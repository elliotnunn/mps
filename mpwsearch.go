package main

import (
	"os"
	"path/filepath"
)

func isAccessibleDir(path string) (goodpath string, ok bool) {
	path, _ = filepath.Abs(path) // never fails

	// First, convert to an absolute path
	slice := []byte(path)
	for i := range slice {
		switch slice[i] {
		case ':':
			slice[i] = '/'
		case '/':
			slice[i] = ':'
		}
	}
	macpath := macstring(slice) // relative to root

	path, errno := hostPath(2, macpath, true)
	if errno != 0 {
		return "", false
	}

	stat, err := os.Stat(path)
	if err != nil {
		return "", false
	}

	if !stat.IsDir() {
		return "", false
	}

	return path, true
}

func mpwSearch() string {
	if p, ok := os.LookupEnv("MPW"); ok {
		p, ok = isAccessibleDir(p)
		if ok {
			return p
		}
	}

	if p, ok := os.LookupEnv("HOME"); ok {
		p = filepath.Join(p, "mpw")
		if p, ok = isAccessibleDir(p); ok {
			return p
		}
	}

	if p, ok := isAccessibleDir("/usr/local/share/mpw"); ok {
		return p
	}

	if p, ok := isAccessibleDir("/usr/share/mpw"); ok {
		return p
	}

	panic("Did not find an MPW")
}
