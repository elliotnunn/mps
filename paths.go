//go:build !windows

// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

// Unix-specific logic to view the host filesystem
// Incomplete... more work is needed before Windows can be supported.

package main

import (
	"strings"
)

func convertPath(path string) string {
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
	bild.Grow(len(path) + 1)

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
