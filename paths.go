//go:build !windows

// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

// Unix-specific logic to view the host filesystem
// Incomplete... more work is needed before Windows can be supported.

package main

// Convert the OS's working directory path to Mac format
// and trust it to be a real, absolute path
func convertCWD(path string) string {
	bytes := []byte(string(onlyVolName) + path)
	for i := range bytes {
		switch bytes[i] {
		case ':':
			bytes[i] = '/'
		case '/':
			bytes[i] = ':'
		}
	}

	return string(bytes)
}
