package main

import (
	"encoding/binary"
)

// Resource Manager Toolbox traps

// A note: all routines accept and return resource map pointers, not handles

// All map POINTERS from TopMapHndl
func allResMaps() (list []uint32) {
	handle := readl(0xa50)
	for handle != 0 {
		ptr := readl(handle)
		list = append(list, ptr)
		handle = readl(ptr + 16)
	}
	return
}

// All map POINTERS from CurMap
func currentResMaps(stopAt1 bool) (list []uint32) {
	allMaps := allResMaps()
	CurMap := readw(0xa5a)
	for i, resMap := range allMaps {
		if readw(resMap+20) == CurMap {
			return allMaps[i:]
		}
	}
	return
}

// {{type_entry_1, id_entry_1, id_entry_2, ...}, {type_entry_2, ...}, ...}
// note that they are all absolute pointers being returned
func resMapEntries(resMap uint32) (retval [][]uint32) {
	refbase := resMap + uint32(readw(resMap+24))
	num_types := uint32(readw(refbase) + 1)

	for t := uint32(0); t < num_types; t++ {
		this_type_entry := refbase + 2 + 8*t
		num_ids := uint32(readw(this_type_entry+4) + 1)
		retval = append(retval, []uint32{this_type_entry})
		first_of_this_type := uint32(readw(this_type_entry + 6))

		for i := uint32(0); i < num_ids; i++ {
			this_id_entry := refbase + first_of_this_type + 12*i
			retval[len(retval)-1] = append(retval[len(retval)-1], this_id_entry)
		}
	}
	return
}

func uniqueTypesInMaps(maps []uint32) (types []uint32) {
	var already map[uint32]bool

	for _, resMap := range maps {
		for _, entries := range resMapEntries(resMap) {
			type_entry := entries[0] // ignore the type entries
			the_type := readl(type_entry)
			if !already[the_type] {
				already[the_type] = true
				types = append(types, the_type)
			}
		}
	}
	return
}

func uniqueIdsInMaps(the_type uint32, maps []uint32) (ids []uint16) {
	var already map[uint16]bool

	for _, resMap := range maps {
		for _, entries := range resMapEntries(resMap) {
			type_entry := entries[0] // ignore the type entries
			if the_type == readl(type_entry) {
				for _, id_entry := range entries[1:] {
					the_id := readw(id_entry)
					if !already[the_id] {
						already[the_id] = true
						ids = append(ids, the_id)
					}
				}
			}
		}
	}
	return
}

// Use the resource map to find the data
func resData(resMap, id_entry uint32) []byte {
	refnum := readw(resMap + 20)
	filedata := filebuffers[refnum]

	data_ofs := binary.BigEndian.Uint32(filedata) + (readl(id_entry+4) & 0xffffff) + 4
	data_len := binary.BigEndian.Uint32(filedata[data_ofs-4:])
	return filedata[data_ofs:][:data_len]
}

func resToHand(resMap, typeEntry, idEntry uint32, loadPlease bool) uint32 {
	// Is a memory block already recorded?
	handle := readl(idEntry + 8)

	if loadPlease == false && handle == 0 {
		// Create empty handle
		call_m68k(executable_atrap(0xa166)) // _NewEmptyHandle
		handle = readl(a0ptr)
	} else if loadPlease == true && handle == 0 {
		// Create full handle
		data := resData(resMap, idEntry)

		writel(d0ptr, uint32(len(data)))
		call_m68k(executable_atrap(0xa122)) // _NewHandle
		handle = readl(a0ptr)

		copy(mem[readl(handle):], data)
	} else if loadPlease == true && handle != 0 && readl(handle) == 0 {
		// Fill empty handle
		data := resData(resMap, idEntry)

		writel(d0ptr, uint32(len(data)))
		writel(a0ptr, handle)
		call_m68k(executable_atrap(0xa027)) // _ReallocHandle

		copy(mem[readl(handle):], data)
	}

	// Record memory block in map
	writel(idEntry+8, handle)
	return handle
}

func getResName(resMap, idEntry uint32) (hasName bool, theName macstring) {
	nameList := uint32(readw(resMap + 26))
	nameOffset := uint32(readw(idEntry + 2))

	if nameOffset == 0xffff {
		return false, ""
	} else {
		return true, readPstring(resMap + nameList + nameOffset)
	}
}

// func set_resource_name(map_handle, res_entry_ptr, name) {
//     if name == nil {
//         writew(res_entry_ptr + 2, 0xffff)
//
//     } else {
//         name_list_offset := readw(readl(map_handle) + 26) // from start of map
//         name_offset = gethandlesize(map_handle) // from start of map
//         writew(res_entry_ptr + 2, name_offset - name_list_offset)
//
//         // after set_handle_size, all pointers into the map are invalid
//         set_handle_size(map_handle, gethandlesize(map_handle) + 1 + len(name))
//         write_pstring(readl(map_handle) + name_offset, name)
//
//     }
// }

func setResError(err int16) {
	writew(0xa60, uint16(err))
}

func tResError() {
	ResError := readw(0xa60)
	writew(readl(spptr), ResError)
}

func tCurResFile() {
	CurMap := readw(0xa5a)
	writew(readl(spptr), CurMap)
}

func tUseResFile() {
	writew(0xa5a, popw()) // CurMap
	setResError(0)
}

func tOpenResFile() {
	strarg := popl()
	pushw(0) // zero vRefNum
	pushl(0) // zero dirID
	pushl(strarg)
	pushw(0) // zero permission
	tHOpenResFile()
}

func tOpenRFPerm() {
	permission := popw()
	vRefNum := popw()
	fileName := popl()
	pushw(vRefNum)
	pushl(0) // dirID
	pushl(fileName)
	pushw(permission)
	tHOpenResFile()
}

func tHOpenResFile() {
	popw() // permission
	ioNamePtr := popl()
	ioDirID := popl()
	ioVRefNum := popw()
	writew(readl(spptr), 0xffff) // return "failed" refnum

	// Call _HOpenRF with a parameter block
	push(128, 0)
	pb := readl(spptr)
	writel(a0ptr, pb) // a0 = pb
	writew(pb+22, ioVRefNum)
	writel(pb+48, ioDirID)
	writel(pb+18, ioNamePtr)
	call_m68k(executable_atrap(0xa20a)) // _HOpenRF
	pop(128)

	ioResult := readw(pb + 16)
	if ioResult != 0 {
		setResError(int16(ioResult))
		return
	}

	ioRefNum := readw(pb + 24)
	forkdata := filebuffers[ioRefNum] // access buffer directly, not _Read trap
	if len(forkdata) < 256 {
		setResError(-39) // eofErr
		return
	}

	// The "resource map" sits at the end of the fork
	mapstart := binary.BigEndian.Uint32(forkdata[4:])
	maplen := binary.BigEndian.Uint32(forkdata[12:])

	// Create a handle to hold it
	writel(d0ptr, maplen)
	call_m68k(executable_atrap(0xa122)) // _NewHandle for map
	maphdl := readl(a0ptr)
	mapptr := readl(maphdl)

	// The in-memory map's first 16b mirror the on-disk fork's first 16b
	copy(mem[mapptr:], forkdata[mapstart:][:maplen])
	copy(mem[mapptr:], forkdata[:16])
	writew(mapptr+20, ioRefNum) // and there is a spot for the filenum too

	// Point TopMapHndl to us (start of the linked list)
	writel(mapptr+16, readl(0xa50))
	writel(0xa50, maphdl)
	writew(0xa5a, ioRefNum) // CurMap = filenum so we are the first searched

	writew(readl(spptr), ioRefNum) // return refnum
	setResError(0)
}

func tCountTypes() {
	only1Please := gCurToolTrapNum&0x3ff == 0x1c
	answer := len(uniqueTypesInMaps(currentResMaps(only1Please)))
	writew(readl(spptr), uint16(answer))
}

func tCountResources() {
	only1Please := gCurToolTrapNum&0x3ff == 0xd
	the_type := popl()
	answer := len(uniqueIdsInMaps(the_type, currentResMaps(only1Please)))
	writew(readl(spptr), uint16(answer))
}

func tGetIndType() {
	only1Please := gCurToolTrapNum&0x3ff == 0xf
	index := int(popw() - 1)
	theTypePtr := popl()

	var theType uint32
	typeList := uniqueTypesInMaps(currentResMaps(only1Please))
	if index < len(typeList) {
		theType = typeList[index]
	}

	writel(theTypePtr, theType)
}

func tGetResource() {
	only1Please := gCurToolTrapNum&0x3ff == 0x1f
	loadPlease := readb(0xa5e) != 0
	rid := popw()
	rtype := popl()

	var handle uint32
	for _, resMap := range currentResMaps(only1Please) {
		for _, entriesOfType := range resMapEntries(resMap) {
			typeEntry := entriesOfType[0]
			for _, idEntry := range entriesOfType[1:] {
				if rtype == readl(typeEntry) && rid == readw(idEntry) {
					handle = resToHand(resMap, typeEntry, idEntry, loadPlease)
					goto found
				}
			}
		}
	}
found:

	writel(readl(spptr), handle)
	if handle == 0 {
		setResError(-192) // resNotFound
	} else {
		setResError(0)
	}
}

func tGetNamedResource() {
	only1Please := gCurToolTrapNum&0x3ff == 0x20
	loadPlease := readb(0xa5e) != 0
	rname := readPstring(popl())
	rtype := popl()

	var handle uint32
	for _, resMap := range currentResMaps(only1Please) {
		for _, entriesOfType := range resMapEntries(resMap) {
			typeEntry := entriesOfType[0]
			for _, idEntry := range entriesOfType[1:] {
				hasName, theName := getResName(resMap, idEntry)
				if rtype == readl(typeEntry) && hasName && rname == theName {
					handle = resToHand(resMap, typeEntry, idEntry, loadPlease)
					goto found
				}
			}
		}
	}
found:

	writel(readl(spptr), handle)
	if handle == 0 {
		setResError(-192) // resNotFound
	} else {
		setResError(0)
	}
}

func tGetIndResource() {
	only1Please := gCurToolTrapNum&0x3ff == 0xe
	loadPlease := readb(0xa5e) != 0
	rindex := popw()
	rtype := popl()

	var handle uint32
	for _, resMap := range currentResMaps(only1Please) {
		for _, entriesOfType := range resMapEntries(resMap) {
			typeEntry := entriesOfType[0]
			for _, idEntry := range entriesOfType[1:] {
				if rtype == readl(typeEntry) {
					rindex--
					if rindex == 0 {
						handle = resToHand(resMap, typeEntry, idEntry, loadPlease)
						goto found
					}
				}
			}
		}
	}
found:

	writel(readl(spptr), handle)
	if handle == 0 {
		setResError(-192) // resNotFound
	} else {
		setResError(0)
	}
}

func tGetPattern() {
	id := popw()
	pushl(0x50415420) // PAT
	pushw(id)
	tGetResource()
}

func tGetCursor() {
	id := popw()
	pushl(0x43555253) // CURS
	pushw(id)
	tGetResource()
}

func tGetString() {
	id := popw()
	pushl(0x53545220) // STR
	pushw(id)
	tGetResource()
}

func tGetIcon() {
	id := popw()
	pushl(0x49434f4e) // ICON
	pushw(id)
	tGetResource()
}

func tGetPicture() {
	id := popw()
	pushl(0x50494354) // PICT
	pushw(id)
	tGetResource()
}

func tHomeResFile() {
	handle := popl()

	setResError(-192)            // resNotFound
	writew(readl(spptr), 0xffff) // return this meaning "bad"

	for _, resMap := range allResMaps() {
		for _, entriesOfType := range resMapEntries(resMap) {
			for _, idEntry := range entriesOfType[1:] {
				if handle == readl(idEntry+4) {
					setResError(0)
					writew(readl(spptr), readw(resMap+20))
					return
				}
			}
		}
	}
}

func tSizeRsrc() {
	handle := popl()

	setResError(-192)       // resNotFound
	writel(readl(spptr), 0) // return this meaning "bad"

	for _, resMap := range allResMaps() {
		for _, entriesOfType := range resMapEntries(resMap) {
			for _, idEntry := range entriesOfType[1:] {
				if handle == readl(idEntry+4) {
					setResError(0)
					writel(readl(spptr), uint32(len(resData(resMap, idEntry))))
					return
				}
			}
		}
	}
}
