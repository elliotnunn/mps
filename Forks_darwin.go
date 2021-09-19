// +build darwin

package main

import (
	"os"
	"syscall"
	"unsafe"
)

type attrList struct {
	bitmapcount uint16
	_           uint16
	commonattr  uint32
	volattr     uint32
	dirattr     uint32
	fileattr    uint32
	forkattr    uint32
}

type attrBuf struct {
	size  uint32
	finfo [32]byte
}

func cstring(s string) *byte {
	c := make([]byte, len(s)+1)
	copy(c, s)
	return &c[0]
}

func darwinFInfo(path string) ([32]byte, error) {
	attrList := attrList{bitmapcount: 5, commonattr: 0x00004000} // ATTR_CMN_FNDRINFO
	attrBuf := attrBuf{size: 36}

	_, _, e1 := syscall.Syscall6(
		220,                                    // getattrlist
		uintptr(unsafe.Pointer(cstring(path))), // path
		uintptr(unsafe.Pointer(&attrList)),     // attrList
		uintptr(unsafe.Pointer(&attrBuf)),      // attrBuf
		uintptr(attrBuf.size),                  // attrBufSize
		0,                                      // options
		0,
	)
	if e1 != 0 {
		return [32]byte{}, e1
	}

	return attrBuf.finfo, nil
}

func setDarwinFInfo(path string, finfo [32]byte) error {
	attrList := attrList{bitmapcount: 5, commonattr: 0x00004000} // ATTR_CMN_FNDRINFO

	_, _, e1 := syscall.Syscall6(
		221,                                    // setattrlist
		uintptr(unsafe.Pointer(cstring(path))), // path
		uintptr(unsafe.Pointer(&attrList)),     // attrList
		uintptr(unsafe.Pointer(&finfo)),        // attrBuf
		uintptr(len(finfo)),                    // attrBufSize
		0,                                      // options
		0,
	)
	if e1 != 0 {
		return e1
	}

	return nil
}

func darwinForksExist(path string) bool {
	stat, err := os.Stat(path + "/..namedfork/rsrc")
	if err == nil && stat.Size() > 0 {
		return true
	}

	finfo, err := darwinFInfo(path)
	if err == nil {
		for _, n := range finfo[:8] {
			if n != 0 && n != '?' {
				return true
			}
		}
	}

	return false
}
