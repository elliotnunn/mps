// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

// Just enough HFS to unpack MPW-GM

package main

import (
	"encoding/binary"
	"strings"
)

type hfsContent struct {
	data, rsrc []byte
	finfo      [16]byte
}

func hfs(fs []byte) (paths []string, content map[string]hfsContent) {
	if fs[0x400] != 'B' || fs[0x401] != 'D' {
		panic("not HFS")
	}

	drAlBlkSiz := int(binary.BigEndian.Uint32(fs[0x414:]))
	drAlBlSt := int(binary.BigEndian.Uint16(fs[0x41c:]))

	readExtents := func(extents []extent) (file []byte) {
		for _, extent := range extents {
			offset := 512*drAlBlSt + drAlBlkSiz*extent.start
			size := drAlBlkSiz * extent.count
			file = append(file, fs[offset:][:size]...)
		}
		return
	}

	// Need the extents overflow file, before anything else can be read
	type oflowkey struct {
		cnid  uint32
		n     int
		isres bool
	}
	xoflow := make(map[oflowkey][]extent)

	// Load the extents overflow file from the extent triple in the header
	for _, rec := range btree(readExtents(extentTriple(fs[0x486:]))) {
		if rec[0] != 7 {
			continue
		}

		xoflow[oflowkey{
			cnid:  binary.BigEndian.Uint32(rec[2:]),
			n:     int(binary.BigEndian.Uint16(rec[6:])),
			isres: rec[1] == 0xff,
		}] = extentTriple(rec[8:])
	}

	catalogExtents := extentTriple(fs[0x496:])

	for {
		moreExtents := xoflow[oflowkey{4, len(catalogExtents), false}]
		if len(moreExtents) == 0 {
			break
		}
		catalogExtents = append(catalogExtents, moreExtents...)
	}

	childrenByCNID := make(map[uint32][]uint32)
	nameByCNID := make(map[uint32]string)
	contentByCNID := make(map[uint32]hfsContent)

	for _, rec := range btree(readExtents(catalogExtents)) {
		cut := (int(rec[0]) + 2) &^ 1

		parent := binary.BigEndian.Uint32(rec[2:])
		name := string(rec[7:][:rec[6]])

		if rec[cut] != 1 && rec[cut] != 2 {
			continue
		}

		// Directory is simple
		cnid := binary.BigEndian.Uint32(rec[cut+6:])

		// File has a different, more frustrating structure
		if rec[cut] == 2 {
			cnid = binary.BigEndian.Uint32(rec[cut+22:])

			var cont hfsContent

			copy(cont.finfo[:], rec[cut+4:])

			for _, whichFork := range [...]bool{true, false} {
				extents := extentTriple(rec[cut+74:])
				size := int(binary.BigEndian.Uint32(rec[cut+26:]))
				if whichFork {
					extents = extentTriple(rec[cut+86:])
					size = int(binary.BigEndian.Uint32(rec[cut+36:]))
				}

				// Get more extents from the overflow file
				for {
					moreExtents := xoflow[oflowkey{cnid, len(extents), whichFork}]
					if len(moreExtents) == 0 {
						break
					}
					extents = append(extents, moreExtents...)
				}

				// Copy the fork into a nice structure
				fork := readExtents(extents)[:size]
				if whichFork {
					cont.rsrc = fork
				} else {
					cont.data = fork
				}
			}

			contentByCNID[cnid] = cont
		}

		childrenByCNID[parent] = append(childrenByCNID[parent], cnid)
		nameByCNID[cnid] = name
	}

	content = make(map[string]hfsContent)
	for _, cnidPath := range flattenCNIDs(1, childrenByCNID) {
		// Make:HFS:path
		components := make([]string, 0, len(cnidPath))
		for _, el := range cnidPath {
			components = append(components, nameByCNID[el])
		}
		path := strings.Join(components, ":")
		paths = append(paths, path)

		// Use path as a key for the caller to get file contents
		cnid := cnidPath[len(cnidPath)-1]
		if cont, ok := contentByCNID[cnid]; ok {
			content[path] = cont
		}
	}

	return paths, content
}

// This function frightens me
// Turns {1: {2}, 2: {3, 4}} into {{1}, {1, 2}, {1, 2, 3}, {1, 2, 4}}
func flattenCNIDs(cnid uint32, childrenByCNID map[uint32][]uint32) (numericPaths [][]uint32) {
	for _, child := range childrenByCNID[cnid] {
		numericPaths = append(numericPaths, []uint32{child})
		for _, childPath := range flattenCNIDs(child, childrenByCNID) {
			childPath = append([]uint32{child}, childPath...)
			numericPaths = append(numericPaths, childPath)
		}
	}
	return numericPaths
}

type extent struct {
	start, count int
}

func extentTriple(record []byte) (extents []extent) {
	for i := 0; i < 12; i += 4 {
		block := int(binary.BigEndian.Uint16(record[i:]))
		count := int(binary.BigEndian.Uint16(record[i+2:]))
		if count != 0 {
			extents = append(extents, extent{block, count})
		}
	}
	return
}

func btree(tree []byte) (records [][]byte) {
	// Special first node has special header record
	headerRec := bnode(tree)[0]

	// Ends of a linked list of leaf nodes
	bthFNode := int(binary.BigEndian.Uint32(headerRec[10:]))
	bthLNode := int(binary.BigEndian.Uint32(headerRec[14:]))

	i := bthFNode
	for {
		offset := 512 * i
		i = int(binary.BigEndian.Uint32(tree[offset:]))

		records = append(records, bnode(tree[offset:][:512])...)

		if i == bthLNode {
			break
		}
	}

	return records
}

func bnode(node []byte) [][]byte {
	cnt := int(binary.BigEndian.Uint16(node[10:]))

	boundaries := make([]int, 0, cnt+1)
	for i := 0; i < cnt+1; i++ {
		boundaries = append(boundaries, int(binary.BigEndian.Uint16(node[512-2-2*i:])))
	}

	records := make([][]byte, 0, cnt)
	for i := 0; i < cnt; i++ {
		start := boundaries[i]
		stop := boundaries[i+1]
		records = append(records, node[start:stop])
	}

	return records
}
