//go:build windows

// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

/*
Drive letters to appear in caps like FS:C:
UNC paths to appear in caps like FS:SERVER:SHARE
*/

package main

import (
	"strings"
	"syscall"
)

const (
	platRoot    = "\x00imagiroot"
	platPathSep = '\\'
)

func winSplit(path string) (comps []string) {
	if path == platRoot {
		return nil
	}

	path = strings.ReplaceAll(path, "/", "\\")
	path = strings.TrimRight(path, "\\")

	var capitalCount int

	if len(path) >= 2 && isLetter(path[0]) && path[1] == ':' && (len(path) == 2 || path[2] == '\\') {
		// Drive letter
		comps = strings.Split(path, "\\")
		comps[0] = comps[0][:1] // trim C: to C
		capitalCount = 1
	} else if len(path) >= 3 && strings.HasPrefix(path, "\\\\") {
		// UNC
		comps = strings.Split(path[2:], "\\")
		capitalCount = 2
	} else {
		panic("Bad Windows path: " + path)
	}

	for i := 0; i < capitalCount && i < len(comps); i++ {
		comps[i] = strings.ToUpper(comps[i])
	}

	return comps
}

func winJoin(comps []string) (path string) {
	if len(comps) == 0 {
		return platRoot
	}

	var capitalCount int

	comps = append(make([]string, 0, len(comps)), comps...)
	if len(comps[0]) == 1 && isLetter(comps[0][0]) {
		// Drive letter
		comps[0] += ":"
		if len(comps) == 1 { // backslash mandatory after C:
			comps = append(comps, "")
		}
		capitalCount = 1
	} else {
		// UNC
		comps[0] = "\\\\" + comps[0]
		capitalCount = 2
	}

	for i := 0; i < capitalCount && i < len(comps); i++ {
		comps[i] = strings.ToUpper(comps[i])
	}

	return strings.Join(comps, "\\")
}

func isLetter(let byte) bool {
	return (let >= 'a' && let <= 'z') || (let >= 'A' && let <= 'Z')
}

func platPathDir(p string) string {
	comps := winSplit(p)
	if len(comps) == 0 {
		panic("Root given to platPathDir")
	}

	return winJoin(comps[:len(comps)-1])
}

func platPathBase(p string) string {
	comps := winSplit(p)
	if len(comps) == 0 {
		panic("Root given to platPathBase")
	}

	return comps[len(comps)-1]
}

func platPathJoin(p string, comps ...string) string {
	comps = append(winSplit(p), comps...)
	return winJoin(comps)
}

func platPathImaginary(p string) bool {
	comps := winSplit(p)

	// the root contains \\SERVER and C:\
	if len(comps) == 0 {
		return true
	}

	// \\SERVER is an imaginary folder but \\C is C:\
	if len(comps) == 1 && !(len(comps[0]) == 1 && isLetter(comps[0][0])) {
		return true
	}

	return false
}

func platNameForbid(n string) bool {
	for _, c := range []byte(n) {
		if c < 0x20 || c == 0x7f || c == '/' || c == '\\' {
			return true
		}
	}

	// And NUL, COM and the like

	return false
}

// Try to match the semantics of the input path:
// relative paths, ".." components, trailing path separator
func platPathToMac(path string) string {
	var bild strings.Builder

	if !strings.Contains(path, "\\") {
		return path
	}

	trailingSep := false
	if strings.HasSuffix(path, "\\") {
		trailingSep = true
		path = path[:len(path)-1]
	}

	absolute := strings.HasPrefix(path, "\\\\") || (len(path) >= 2 && path[1] == ':')
	var comps []string
	if absolute {
		comps = winSplit(path)
		bild.WriteString(string(onlyVolName))
	} else {
		comps = strings.Split(path, "\\")
	}

	trailingDoubleDot := false
	for _, comp := range comps {
		if comp == "." || comp == "" {
			continue
		}

		bild.WriteByte(':')

		if comp == ".." {
			trailingDoubleDot = true
			continue
		}

		trailingDoubleDot = false
		bild.WriteString(strings.ReplaceAll(comp, ":", "/"))
	}

	if trailingSep || trailingDoubleDot || (absolute && bild.Len() == len(onlyVolName)) {
		bild.WriteByte(':')
	}

	return bild.String()
}

// Environment variables can contain e.g. TEMP~1.UCC
// These will not make sense when converted to HFS paths, so fix them here
// Takes absolute paths and changes them fairly minimally
func fix83Names(p string) string {
	comps := winSplit(p)

	if len(comps) == 0 {
		return p
	}

	// Index of first actual file component of driveletter or UNC path
	fromComp := 1
	if len(comps) == 1 && !(len(comps[0]) == 1 && isLetter(comps[0][0])) {
		fromComp = 2
	}

	for i := fromComp; i < len(comps); i++ {
		better, err := winNormBase(winJoin(comps[:i+1]))
		if err == nil {
			comps[i] = better
		}
	}

	return winJoin(comps)
}

// Borrowed from standard library normBase()
// normBase returns the last element of path with correct case.
func winNormBase(path string) (string, error) {
	p, err := syscall.UTF16PtrFromString(path)
	if err != nil {
		return "", err
	}

	var data syscall.Win32finddata

	h, err := syscall.FindFirstFile(p, &data)
	if err != nil {
		return "", err
	}
	syscall.FindClose(h)

	return syscall.UTF16ToString(data.FileName[:]), nil
}
