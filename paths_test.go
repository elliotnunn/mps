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
	{"/", "_:"},
	{"/subdir", "_:subdir"},
	{"/sub:dir", "_:sub/dir"},
	{"/subdir/", "_:subdir:"},
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

		if len(testCase.out) > len(testCase.in)+1 {
			t.Errorf("expected len(convertPath(%q)) <= %d, got %d", testCase.in, len(testCase.in)+1, len(testCase.out))
		}
	}
}
