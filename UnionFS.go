// A UnionFS struct is a primitive union filesystem with the real OS's
// filesystem at its root and a number of fs.FS'es in subdirectories.

// It is read-only, so access the OS directly to write files.
// Use the IsHostPath to determine whether a path is real first.

// Paths are given in the OS format, unlike slash-only fs.FS

package main

import (
	"io/fs"
	"os"
	"strings"
)

type UnionFS struct {
	fses        []fs.FS
	fsLocations []string
}

func (fsys *UnionFS) whichFS(path string) (string, fs.FS) {
	for i, loc := range fsys.fsLocations {
		if strings.HasPrefix(path, loc) {
			if len(path) == len(loc) || path[len(loc)] == os.PathSeparator {
				path = path[len(loc):]
				if len(path) > 0 && path[0] == os.PathSeparator {
					path = path[1:]
				}
				path = strings.ReplaceAll(path, string([]byte{os.PathSeparator}), "/")
				if path == "" {
					path = "."
				}
				return path, fsys.fses[i]
			}
		}
	}

	return path, nil
}

func (fsys *UnionFS) Add(what fs.FS, where string) {
	fsys.fses = append(fsys.fses, what)
	fsys.fsLocations = append(fsys.fsLocations, where)
	os.Mkdir(where, 0o777) // so it shows up in listings
}

// Allow to "escape" and write, stat, etc
func (fsys *UnionFS) IsHostPath(path string) bool {
	_, subFS := fsys.whichFS(path)
	return subFS == nil
}

func (fsys *UnionFS) ReadDir(path string) ([]fs.DirEntry, error) {
	subPath, subFS := fsys.whichFS(path)

	if subFS == nil {
		list, err := os.ReadDir(path)
		return list, err
	} else {
		list, err := fs.ReadDir(subFS, subPath)
		return list, err
	}
}

func (fsys *UnionFS) ReadFile(path string) ([]byte, error) {
	subPath, subFS := fsys.whichFS(path)

	if subFS == nil {
		data, err := os.ReadFile(path)
		return data, err
	} else {
		data, err := fs.ReadFile(subFS, subPath)
		return data, err
	}
}

func (fsys *UnionFS) Stat(path string) (fs.FileInfo, error) {
	subPath, subFS := fsys.whichFS(path)

	if subFS == nil {
		stat, err := os.Stat(path)
		return stat, err
	} else {
		stat, err := fs.Stat(subFS, subPath)
		return stat, err
	}
}
