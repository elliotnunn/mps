// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

package main

import (
	"encoding/binary"
	"fmt"
)

const (
	resSysHeap   = 0x40
	resPurgeable = 0x20
	resLocked    = 0x10
	resProtected = 0x08
	resPreload   = 0x04
	resChanged   = 0x02
	resAll       = 0x7f
)

var bigEndian = binary.BigEndian

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
func currentResMaps(stopAt1 bool) (maps []uint32) {
	maps = allResMaps()
	for len(maps) > 0 {
		if readw(maps[0]+20) == readw(0xa5a) {
			break
		}
		maps = maps[1:]
	}

	if len(maps) > 0 && stopAt1 {
		maps = maps[:1]
	}

	return
}

// Given a handle, identify which resource map, and which entry inside the map
func lookupResHandle(handle uint32) (resMap uint32, typeEntry uint32, idEntry uint32, ok bool) {
	for _, resMap = range allResMaps() {
		for _, entriesOfType := range resMapEntries(resMap) {
			typeEntry = entriesOfType[0]
			for _, idEntry = range entriesOfType[1:] {
				if readl(idEntry+8) == handle {
					ok = true
					return
				}
			}
		}
	}
	return 0, 0, 0, false
}

// Given a refnum, get the corresponding map pointer
func lookupMapRefnum(refnum uint16) (resMap uint32, ok bool) {
	if refnum == 0 {
		refnum = readw(0xa58) // 0 means SysMap
	}

	for _, resMap := range allResMaps() {
		if readw(resMap+20) == refnum {
			return resMap, true
		}
	}
	return 0, false
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
	already := make(map[uint32]bool)

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
	already := make(map[uint16]bool)

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
func resData(resMap, type_entry, id_entry uint32) []byte {
	refnum := readw(resMap + 20)
	filedata := *(openBuffers[refnum])

	data_ofs := binary.BigEndian.Uint32(filedata) + (readl(id_entry+4) & 0xffffff) + 4
	data_len := binary.BigEndian.Uint32(filedata[data_ofs-4:])

	data := filedata[data_ofs:][:data_len]

	// Edit ToolServer CODE resources
	if refnum == readw(0x900) { // CurApRefNum
		if readl(type_entry) == 0x434f4445 && readw(id_entry) != 0 {
			ioCodePatch(data)
		}
	}

	return data
}

func resToHand(resMap, typeEntry, idEntry uint32, loadPlease bool) uint32 {
	// Is a memory block already recorded?
	handle := readl(idEntry + 8)

	if loadPlease == false && handle == 0 {
		// Create empty handle
		lineA(0xa166) // _NewEmptyHandle
		handle = readl(a0ptr)
	} else if loadPlease == true && handle == 0 {
		// Create full handle
		data := resData(resMap, typeEntry, idEntry)

		writel(d0ptr, uint32(len(data)))
		lineA(0xa122) // _NewHandle
		handle = readl(a0ptr)

		copy(mem[readl(handle):], data)
	} else if loadPlease == true && handle != 0 && readl(handle) == 0 {
		// Fill empty handle
		data := resData(resMap, typeEntry, idEntry)

		writel(d0ptr, uint32(len(data)))
		writel(a0ptr, handle)
		lineA(0xa027) // _ReallocHandle

		copy(mem[readl(handle):], data)
	}

	// Declare block to be a resource
	writeb(handle+4, readb(handle+4)|0x20)

	// Record memory block in map
	writel(idEntry+8, handle)
	return handle
}

var (
	curSegStart = uint32(1)
	curSegEnd   = uint32(0)
	curRes      = uint64(0)
)

// Returns 0xA000BBBBCCCCCCCC: A=(0=ToolServer/1=other), B=segment, C=offset
// Useful for checking for a specific instruction inside the emulator loop
func codeResource(pc uint32) (ret uint64) {
	if curSegStart <= pc && pc < curSegEnd {
		goto win
	}

	// Search every loaded resource
	for _, resMapAddr := range allResMaps() {
		resMap := dumpMap(mem[resMapAddr:])
		for _, entry := range resMap.list {
			if entry.tType != 0x434f4445 || entry.rHndl == 0 {
				continue
			}

			start := readl(entry.rHndl)
			if start == 0 {
				continue

			}

			end := start + usedBlocks[start].size
			if pc < start || pc >= end {
				continue
			}

			curSegStart = start
			curSegEnd = end
			curRes = uint64(entry.rID) << 32
			if resMap.mRefNum != tsRefNum {
				curRes |= 0x1000000000000000
			}

			goto win
		}
	}

	// lose
	curSegStart = 1
	curSegEnd = 0
	return 0

win:
	return curRes | uint64(pc-curSegStart)
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

func tGetResInfo() {
	namePtr := popl()
	typePtr := popl()
	idPtr := popl()
	handle := popl()

	if resMap, typeEntry, idEntry, ok := lookupResHandle(handle); ok {
		if namePtr != 0 {
			_, name := getResName(resMap, idEntry)
			writePstring(namePtr, name)
		}

		if typePtr != 0 {
			writel(typePtr, readl(typeEntry))
		}

		if idPtr != 0 {
			writew(idPtr, readw(idEntry))
		}

		setResError(0)
	} else {
		setResError(-192) // resNotFound
	}
}

func setResError(err int16) {
	writew(0xa60, uint16(err))
}

func tResError() {
	ResError := readw(0xa60)
	writew(readl(spptr), ResError)
}

func tSetResLoad() {
	writeb(0xa5e, popb())
}

func tCurResFile() {
	CurMap := readw(0xa5a)
	writew(readl(spptr), CurMap)
}

func tUseResFile() {
	refNum := popw()

	for _, resMap := range allResMaps() {
		if readw(resMap+20) == refNum {
			writew(0xa5a, refNum) // CurMap
			setResError(0)
			return
		}
	}

	setResError(-193) // ResFNotFound
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
	pb, oldsp := pushzero(128)
	writel(a0ptr, pb) // a0 = pb
	writew(pb+22, ioVRefNum)
	writel(pb+48, ioDirID)
	writel(pb+18, ioNamePtr)
	lineA(0xa20a) // _HOpenRF
	writel(spptr, oldsp)

	ioResult := readw(pb + 16)
	if ioResult != 0 {
		setResError(int16(ioResult))
		return
	}

	ioRefNum := readw(pb + 24)
	forkdata := *(openBuffers[ioRefNum]) // access buffer directly, not _Read trap
	if len(forkdata) < 256 {
		// Close the truncated fork
		pb, oldsp := pushzero(128)
		writel(a0ptr, pb)
		writew(pb+24, ioRefNum)
		lineA(0xa001) // _Close
		writel(spptr, oldsp)

		setResError(-39) // eofErr
		return
	}

	// The "resource map" sits at the end of the fork
	mapstart := binary.BigEndian.Uint32(forkdata[4:])
	maplen := binary.BigEndian.Uint32(forkdata[12:])

	// Create a handle to hold it
	writel(d0ptr, maplen)
	lineA(0xa122) // _NewHandle for map
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

	// Some on-disk resource maps have junk in the handle field
	for _, entriesOfType := range resMapEntries(readl(maphdl)) {
		for _, idEntry := range entriesOfType[1:] {
			writel(idEntry+8, 0)
		}
	}

	writew(readl(spptr), ioRefNum) // return refnum
	setResError(0)
}

func tCount1Types() {
	tCountTypesCommon(true)
}

func tCountTypes() {
	tCountTypesCommon(false)
}

func tCountTypesCommon(only1Please bool) {
	answer := len(uniqueTypesInMaps(currentResMaps(only1Please)))
	writew(readl(spptr), uint16(answer))
}

func tCount1Resources() {
	tCountResourcesCommon(true)
}

func tCountResources() {
	tCountResourcesCommon(false)
}

func tCountResourcesCommon(only1Please bool) {
	the_type := popl()
	answer := len(uniqueIdsInMaps(the_type, currentResMaps(only1Please)))
	writew(readl(spptr), uint16(answer))
}

func tGet1IndType() {
	tGetIndTypeCommon(true)
}

func tGetIndType() {
	tGetIndTypeCommon(false)
}

func tGetIndTypeCommon(only1Please bool) {
	index := int(popw() - 1)
	theTypePtr := popl()

	var theType uint32
	typeList := uniqueTypesInMaps(currentResMaps(only1Please))
	if index < len(typeList) {
		theType = typeList[index]
	}

	writel(theTypePtr, theType)
}

func tGet1Resource() {
	tGetResourceCommon(true)
}

func tGetResource() {
	tGetResourceCommon(false)
}

func tGetResourceCommon(only1Please bool) {
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

func tReleaseResource() {
	handle := popl()
	if _, _, idEntry, ok := lookupResHandle(handle); ok {
		// If the resChanged bit is set, then fail silently
		if readb(idEntry+4)&resChanged == 0 {
			writel(idEntry+8, 0) // zero the handle record

			writel(a0ptr, handle)
			lineA(0xa023) // _DisposHandle
		}

		setResError(0) // noErr
	} else {
		setResError(-192) // resNotFound
	}
}

func tDetachResource() {
	handle := popl()
	if _, _, idEntry, ok := lookupResHandle(handle); ok {
		// If the resChanged bit is set, then fail silently
		if readb(idEntry+4)&resChanged == 0 {
			writel(idEntry+8, 0)                    // zero the handle record
			writeb(handle+4, readb(handle+4)&^0x20) // orphan the handle
		}

		setResError(0) // noErr
	} else {
		setResError(-192) // resNotFound
	}
}

func tGet1NamedResource() {
	tGetNamedResourceCommon(true)
}

func tGetNamedResource() {
	tGetNamedResourceCommon(false)
}

func tGetNamedResourceCommon(only1Please bool) {
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

func tGet1IndResource() {
	tGetIndResourceCommon(true)
}

func tGetIndResource() {
	tGetIndResourceCommon(false)
}

func tGetIndResourceCommon(only1Please bool) {
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

func tLoadResource() {
	resMap, typeEntry, idEntry, ok := lookupResHandle(popl())
	if !ok {
		setResError(-192) // resNotFound
		return
	}

	resToHand(resMap, typeEntry, idEntry, true)
	setResError(0)
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
	retValPtr := readl(spptr)

	if resMap, _, _, ok := lookupResHandle(handle); ok {
		setResError(0)                      // noErr
		writew(retValPtr, readw(resMap+20)) // map refNum
	} else {
		setResError(-192)         // resNotFound
		writew(retValPtr, 0xffff) // invalid refNum
	}
}

func tSizeRsrc() {
	handle := popl()
	retValPtr := readl(spptr)

	if resMap, typeEntry, idEntry, ok := lookupResHandle(handle); ok {
		setResError(0) // noErr
		writel(retValPtr, uint32(len(resData(resMap, typeEntry, idEntry))))
	} else {
		setResError(-192)    // resNotFound
		writel(retValPtr, 0) // return this meaning "bad"
	}
}

// Functions that CHANGE resource maps and forks

func setMapDirty(resMap uint32, dirty bool) {
	mattr := readb(resMap+22) &^ 0x20
	if dirty {
		mattr |= 0x20
	}
	writeb(resMap+22, mattr)
}

func getMapDirty(resMap uint32) bool {
	return readb(resMap+22)&0x20 != 0
}

func tChangedResource() {
	handle := popl()
	if resMap, _, idEntry, ok := lookupResHandle(handle); ok {
		setMapDirty(resMap, true)
		writeb(idEntry+4, readb(idEntry+4)|resChanged)
		setResError(0) // noErr
	} else {
		setResError(-192) // resNotFound
	}
}

func tWriteResource() {
	handle := popl()
	if resMap, _, idEntry, ok := lookupResHandle(handle); ok {
		attr := readb(idEntry + 4)
		if attr&resChanged != 0 && attr&resProtected == 0 {
			writeb(idEntry+4, attr&^resChanged)

			refnum := readw(resMap + 20)
			buffer := openBuffers[refnum]

			ptr := readl(handle)
			dataSize := usedBlocks[ptr].size
			firstDataInFork := readl(resMap) // usually constant 256
			dataFromFirstData := uint32(len(*buffer)) - firstDataInFork

			// Directly editing a buffer is simpler than using _Write
			*buffer = append(*buffer, 0, 0, 0, 0)
			bigEndian.PutUint32((*buffer)[len(*buffer)-4:], dataSize) // awkward
			*buffer = append(*buffer, mem[ptr:][:dataSize]...)

			// Awkward 3-byte value in the resource map
			if dataFromFirstData > 0xffffff {
				panic("Resource file too big")
			}
			writel(idEntry+4, readl(idEntry+4)&0xff000000|dataFromFirstData)
		}

		setResError(0) // noErr
	} else {
		setResError(-192) // resNotFound
	}
}

// Squishes the existing on-disk resources together and appends the in-memory map
// Does NOT write modified resources to disk
func compactResFile(resMap uint32) {
	rmap := dumpMap(getBlock(resMap))
	refnum := rmap.mRefNum // save this, because we clobber it

	fork := openBuffers[refnum]
	newFork := make([]byte, 256)

	// Copy each resource to the fork
	for i := range rmap.list {
		// get the resource data from fork, including 4b length
		dataOnDisk := (*fork)[rmap.resDataOffset+rmap.list[i].rLocn:]
		dataOnDisk = dataOnDisk[:4+binary.BigEndian.Uint32(dataOnDisk)]

		rmap.list[i].rLocn = uint32(len(newFork) - 256)
		newFork = append(newFork, dataOnDisk...)

		// align to 4
		for len(newFork)%4 != 0 {
			newFork = append(newFork, 0)
		}
	}

	// Update the in-memory resource map
	copy(mem[resMap:], mkMap(rmap))

	// Write out the on-disk resource map
	midpoint := uint32(len(newFork)) // end of data, start of map
	rmap.cleanForDisk()              // zero out many useless fields
	newFork = append(newFork, mkMap(rmap)...)
	endpoint := uint32(len(newFork)) // end of map

	binary.BigEndian.PutUint32(newFork, 256)                    // resDataOffset
	binary.BigEndian.PutUint32(newFork[4:], midpoint)           // resMapOffset
	binary.BigEndian.PutUint32(newFork[8:], midpoint-256)       // dataSize
	binary.BigEndian.PutUint32(newFork[12:], endpoint-midpoint) // mapSize

	*fork = newFork
}

func tUpdateResFile() {
	refnum := popw()
	if resMap, ok := lookupMapRefnum(refnum); ok {
		if getMapDirty(resMap) {
			// First, flush every resource to the file
			for _, entryList := range resMapEntries(resMap) {
				for _, idEntry := range entryList[1:] {
					handle := readl(idEntry + 8)
					pushl(handle)
					tWriteResource()
				}
			}

			// Second, compact the currently messy file and write a new map to it
			// MacOS would write the file to disk, but we don't bother
			compactResFile(resMap)

			setMapDirty(resMap, false)
		}

		setResError(0) // noErr
	} else {
		setResError(-193) // resFNotFound
	}
}

func tCloseResFile() {
	refnum := popw()
	if resMap, ok := lookupMapRefnum(refnum); ok {
		// Update the file on disk
		pushw(refnum)
		tUpdateResFile()

		// Free every resource from memory
		for _, entryList := range resMapEntries(resMap) {
			for _, idEntry := range entryList[1:] {
				resHand := readl(idEntry + 8)
				// zero rHndl because nonexistent handles crash codeResource()
				writel(idEntry+8, 0)
				if resHand != 0 {
					writel(a0ptr, resHand)
					lineA(0xa023) // _DisposHandle
				}
			}
		}

		// Remove the resource map from the chain, starting at TopMapHndl
		for handLoc := uint32(0xa50); readl(handLoc) != 0; handLoc = readl(readl(handLoc)) + 16 {
			if readl(readl(handLoc)) == resMap {
				writel(handLoc, readl(readl(readl(handLoc))+16))
			}
		}

		// If this is CurMap, pick something else
		if refnum == readw(0xa5a) {
			topMap := readl(readl(0xa50))
			writew(0xa5a, readw(topMap+20))
		}

		// Release the resource map
		writel(a0ptr, usedBlocks[resMap].masterPtr)
		lineA(0xa023) // _DisposHandle

		// Close the underlying fork
		paramBlk, oldsp := pushzero(128)
		writew(paramBlk+24, refnum) // ioRefNum
		writel(a0ptr, paramBlk)
		lineA(0xa001) // _Close
		writel(spptr, oldsp)

		setResError(0) // noErr
	} else {
		setResError(-193) // resFNotFound
	}
}

func tAddResource() {
	namePtr := popl()
	id := popw()
	tType := popl()
	handle := popl()

	res := resourceStruct{
		tType: tType,
		rID:   id,
		rAttr: resChanged,
		rHndl: handle,
	}

	if namePtr != 0 {
		res.hasName = true
		res.name = readPstring(namePtr)
	}

	resMap := currentResMaps(true)[0]

	setMapDirty(resMap, true)

	deep := dumpMap(getBlock(resMap))
	deep.list = append(deep.list, res)
	setHandleBlock(usedBlocks[resMap].masterPtr, mkMap(deep))

	setResError(0) // noErr
}

func tRmveResource() {
	handle := popl()
	if resMap, _, _, ok := lookupResHandle(handle); ok {
		setMapDirty(resMap, true)

		deep := dumpMap(getBlock(resMap))
		for i, res := range deep.list {
			if res.rHndl == handle {
				if res.rAttr&resProtected != 0 {
					setResError(-196) // rmvResFailed
					return
				} else {
					writeb(handle+4, readb(handle+4)&^0x20) // orphan the handle
					deep.list = append(deep.list[:i], deep.list[i+1:]...)
					setHandleBlock(usedBlocks[resMap].masterPtr, mkMap(deep))
					setResError(0)
					return
				}
			}
		}
	}

	setResError(-196) // rmvResFailed
}

type mapStruct struct {
	resDataOffset uint32
	resMapOffset  uint32
	dataSize      uint32
	mapSize       uint32
	mNext         uint32
	mRefNum       uint16
	mAttr         uint16
	list          []resourceStruct
}

type resourceStruct struct {
	tType   uint32
	rID     uint16
	hasName bool
	name    macstring
	rAttr   uint8
	rHndl   uint32
	rLocn   uint32
}

func (s *resourceStruct) String() string {
	tstr := macToUnicode(macstring([]byte{byte(s.tType >> 24), byte(s.tType >> 16), byte(s.tType >> 8), byte(s.tType)}))
	if s.hasName {
		return fmt.Sprintf("{'%s' (%d, \"%s\", $%x) handle=%08x locn=%06x}", tstr, s.rID, s.name, s.rAttr, s.rHndl, s.rLocn)
	} else {
		return fmt.Sprintf("{'%s' (%d, $%x) handle=%08x locn=%06x}", tstr, s.rID, s.rAttr, s.rHndl, s.rLocn)
	}
}

// Flatten the map to a list of resources
// Does not depend on anything else
func dumpMap(flat []byte) (deep mapStruct) {
	// only resDataOffset is any use, but might as well preserve them all
	deep.resDataOffset = binary.BigEndian.Uint32(flat)
	deep.resMapOffset = binary.BigEndian.Uint32(flat[4:])
	deep.dataSize = binary.BigEndian.Uint32(flat[8:])
	deep.mapSize = binary.BigEndian.Uint32(flat[12:])

	deep.mNext = binary.BigEndian.Uint32(flat[16:])
	deep.mRefNum = binary.BigEndian.Uint16(flat[20:])
	deep.mAttr = binary.BigEndian.Uint16(flat[22:])

	mTypes := binary.BigEndian.Uint16(flat[24:])
	mNames := binary.BigEndian.Uint16(flat[26:])

	typeCount := binary.BigEndian.Uint16(flat[mTypes:]) + 1 // zero-based

	for i := uint16(0); i < typeCount; i++ {
		tBase := mTypes + 2 + 8*i

		tCount := binary.BigEndian.Uint16(flat[tBase+4:]) + 1 // zero-based
		tOffset := binary.BigEndian.Uint16(flat[tBase+6:])

		for j := uint16(0); j < tCount; j++ {
			rBase := mTypes + tOffset + 12*j

			rNameOff := binary.BigEndian.Uint16(flat[rBase+2:])

			res := resourceStruct{
				tType: binary.BigEndian.Uint32(flat[tBase:]),
				rID:   binary.BigEndian.Uint16(flat[rBase:]),
				rAttr: flat[rBase+4],
				rLocn: binary.BigEndian.Uint32(flat[rBase+4:]) & 0xffffff,
				rHndl: binary.BigEndian.Uint32(flat[rBase+8:]),
			}

			if rNameOff != 0xffff {
				pstring := flat[mNames+rNameOff:]
				pstring = pstring[1 : 1+pstring[0]]
				res.name = macstring(pstring)
				res.hasName = true
			}

			deep.list = append(deep.list, res)
		}
	}
	return
}

func mkMap(deep mapStruct) (flat []byte) {
	flat = make([]byte, 28)

	binary.BigEndian.PutUint32(flat, deep.resDataOffset)
	binary.BigEndian.PutUint32(flat[4:], deep.resMapOffset)
	binary.BigEndian.PutUint32(flat[8:], deep.dataSize)
	binary.BigEndian.PutUint32(flat[12:], deep.mapSize)

	binary.BigEndian.PutUint32(flat[16:], deep.mNext)
	binary.BigEndian.PutUint16(flat[20:], deep.mRefNum)
	binary.BigEndian.PutUint16(flat[22:], deep.mAttr)

	typeOrder := []uint32{}
	resByType := make(map[uint32][]resourceStruct)
	for _, res := range deep.list {
		if _, alreadyExist := resByType[res.tType]; !alreadyExist {
			typeOrder = append(typeOrder, res.tType)
		}
		resByType[res.tType] = append(resByType[res.tType], res)
	}

	flat = append(flat, make([]byte, 2+8*len(typeOrder))...)
	nameList := make([]byte, 0)

	binary.BigEndian.PutUint16(flat[24:], 28)                       // mTypes
	binary.BigEndian.PutUint16(flat[28:], uint16(len(typeOrder))-1) // typeCount

	for i, tType := range typeOrder {
		typeEntry := 28 + 2 + 8*i
		binary.BigEndian.PutUint32(flat[typeEntry:], tType)
		binary.BigEndian.PutUint16(flat[typeEntry+4:], uint16(len(resByType[tType]))-1)
		binary.BigEndian.PutUint16(flat[typeEntry+6:], uint16(len(flat))-28)

		for _, res := range resByType[tType] {
			idEntry := len(flat)
			flat = append(flat, make([]byte, 12)...)
			binary.BigEndian.PutUint16(flat[idEntry:], res.rID)
			binary.BigEndian.PutUint32(flat[idEntry+4:], res.rLocn)
			binary.BigEndian.PutUint32(flat[idEntry+8:], res.rHndl)
			flat[idEntry+4] = res.rAttr

			if res.hasName {
				binary.BigEndian.PutUint16(flat[idEntry+2:], uint16(len(nameList)))
				nameList = append(nameList, byte(len(res.name)))
				nameList = append(nameList, res.name...)
			} else {
				binary.BigEndian.PutUint16(flat[idEntry+2:], 0xffff)
			}
		}
	}

	binary.BigEndian.PutUint16(flat[26:], uint16(len(flat))) // mNames
	flat = append(flat, nameList...)
	return
}

func (deep *mapStruct) cleanForDisk() {
	deep.resDataOffset = 0
	deep.resMapOffset = 0
	deep.dataSize = 0
	deep.mapSize = 0
	deep.mNext = 0
	deep.mRefNum = 0
	deep.mAttr &= 0xff00

	for i, _ := range deep.list {
		deep.list[i].rAttr &= 0x7e
		deep.list[i].rHndl = 0
	}
}

func extractRes(fork []byte, rtype string, rid int16) []byte {
	mapstart := binary.BigEndian.Uint32(fork[4:])
	maplen := binary.BigEndian.Uint32(fork[12:])

	resMap := dumpMap(fork[mapstart:][:maplen])
	for _, res := range resMap.list {
		if rtype != string([]byte{byte(res.tType >> 24), byte(res.tType >> 16), byte(res.tType >> 8), byte(res.tType)}) {
			continue
		}

		if rid != int16(res.rID) {
			continue
		}

		dataStart := binary.BigEndian.Uint32(fork) // base of all data within fork
		dataStart += res.rLocn & 0xffffff          // this res within fork
		dataLen := binary.BigEndian.Uint32(fork[dataStart:])

		return fork[dataStart+4:][:dataLen]
	}

	return nil
}

func tCreateResFile() {
	namePtr := popl()
	pushw(0) // vRefNum
	pushl(0) // dirID
	pushl(namePtr)
	tHCreateResFile()
}

func tHCreateResFile() {
	namePtr := popl()
	dirID := uint16(popl())
	vRefNum := popw()

	if dirID == 0 {
		dirID = vRefNum
	}

	path, errno := hostPath(dirID, readPstring(namePtr), leafMayExist)
	if errno != 0 {
		setResError(int16(errno))
		return
	}

	// Hack, to allow CreateResFile if there is a corrupt or truncated fork
	if len(resourceFork(path)) <= 256 {
		empty := []byte{0x2: 0x01, 0x6: 0x01, 0xf: 0x1e, 0x119: 0x1c, 0x11b: 0x1e, 0x11c: 0xff, 0x11d: 0xff}
		writeResourceFork(path, empty)
		clearDirCache(platPathDir(path))
	}

	setResError(0)
}

func tGetResAttrs() {
	resHandle := popl()
	_, _, idEntry, ok := lookupResHandle(resHandle)
	if ok {
		writew(readl(spptr), uint16(readb(idEntry+4)))
		setResError(0)
	} else {
		setResError(-192) // resNotFound
	}
}

func tSetResAttrs() {
	attrs := popw()
	resHandle := popl()
	_, _, idEntry, ok := lookupResHandle(resHandle)
	if ok {
		writeb(idEntry+4, uint8(attrs))
		setResError(0)
	} else {
		setResError(-192) // resNotFound
	}
}

func tGetResFileAttrs() {
	refNum := popw()
	mapPtr, ok := lookupMapRefnum(refNum)
	if ok {
		writew(readl(spptr), uint16(readb(mapPtr+22))) // return mAttr in low byte
		setResError(0)
	} else {
		writew(readl(spptr), 0)
		setResError(-193) // resFNotFound
	}
}

func tSetResFileAttrs() {
	attrs := popw()
	refNum := popw()
	mapPtr, ok := lookupMapRefnum(refNum)
	if ok {
		writeb(mapPtr+22, uint8(attrs)) // set mAttr
		setResError(0)
	} else {
		setResError(-193) // resFNotFound
	}
}
