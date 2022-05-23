//go:build !windows

// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

/*
Present the host filesystem to the platform-independent File Manager, as
a hierarchy with a single root (natural on Unix).

Paths produced by these functions can be passed to the underlying OS.
Unlike Windows, there are no exceptions.

platPathDir and platPathBase behave the same as their counterparts in
the "path/filepath" package, but with extra checks that can pick up
bugs. Don't use filepath.
*/

package main

import (
	"strings"
)

const (
	platRoot    = "/"
	platPathSep = '/'
)

func platPathDir(p string) string {
	if !strings.HasPrefix(p, "/") {
		panic("Non-absolute-path: " + p)
	}

	if p == "/" {
		panic("Root given to platPathDir")
	}

	p = p[:strings.LastIndex(p, "/")]

	// A notorious exception: the Unix root is not represented by ""
	if p == "" {
		p = "/"
	}

	return p
}

func platPathBase(p string) string {
	if !strings.HasPrefix(p, "/") {
		panic("Non-absolute-path: " + p)
	}

	if p == "/" {
		panic("Root given to platPathBase")
	}

	return p[strings.LastIndex(p, "/")+1:]
}

func platPathJoin(p string, comps ...string) string {
	if !strings.HasPrefix(p, "/") {
		panic("Non-absolute-path: " + p)
	}

	for _, comp := range comps {
		if strings.Contains(comp, "/") {
			panic("platPathJoin with a slash")
		}

		if p == "/" {
			p = ""
		}
		p += "/" + comp
	}

	return p
}

// Applies to the dir that on Windows, contains the drive letters and UNC mounts
func platPathImaginary(p string) bool {
	return false
}

func platNameForbid(n string) bool {
	for _, c := range []byte(n) {
		if c < 0x20 || c == 0x7f || c == '/' {
			return true
		}
	}

	return false
}

// Try to match the semantics of the input path:
// relative paths, ".." components, trailing path separator
func platPathToMac(path string) string {
	if !strings.Contains(path, "/") || strings.Contains(path, "//") {
		return path
	}

	absolute := strings.HasPrefix(path, "/")
	if absolute {
		path = path[1:]
	}

	trailingSep := strings.HasSuffix(path, "/")
	if trailingSep {
		path = path[:len(path)-1]
	}

	var bild strings.Builder
	bild.Grow(len(path) + 4) // safe margin

	if absolute {
		bild.WriteString(string(onlyVolName) + ":")
	} else {
		bild.WriteByte(':')
	}

	comps := strings.Split(path, "/")
	for i, comp := range comps {
		if comp == "." {
			continue
		}

		if comp != ".." {
			bild.WriteString(strings.ReplaceAll(comp, ":", "/"))
		}

		isLast := i == len(comps)-1
		if !isLast || comp == ".." || trailingSep {
			bild.WriteByte(':')
		}
	}

	return bild.String()
}

func fix83Names(p string) string {
	return p
}
