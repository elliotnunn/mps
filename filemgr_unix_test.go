//go:build !windows

// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

package main

import (
	"testing"
)

var pathTestPairs = []struct {
	in  string
	out string
}{
	{"", ""},
	{"//", "//"},
	{"/", "FS:"},
	{"/subdir", "FS:subdir"},
	{"/sub:dir", "FS:sub/dir"},
	{"/subdir/", "FS:subdir:"},
	{"dir", "dir"},
	{"dir/", ":dir:"},
	{"dir/.", ":dir:"},
	{"dir/..", ":dir::"},
	{"./", ":"},
	{"./..", "::"},
	{"../", "::"},
	{"../dir", "::dir"},
	{"../.", "::"},
	{".././dir", "::dir"},
	{".././dir/", "::dir:"},
}

func TestplatPathToMac(t *testing.T) {
	for _, testCase := range pathTestPairs {
		got := platPathToMac(testCase.in)

		if testCase.out != got {
			t.Errorf("expected platPathToMac(%q) == %q, got %q", testCase.in, testCase.out, got)
		}
	}
}
