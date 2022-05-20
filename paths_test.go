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

func TestConvertPath(t *testing.T) {
	for _, testCase := range pathTestPairs {
		got := convertPath(testCase.in)

		if testCase.out != got {
			t.Errorf("expected convertPath(%q) == %q, got %q", testCase.in, testCase.out, got)
		}
	}
}
