//go:build windows

// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

package main

import (
	"strings"
	"testing"
)

func TestPlatPathDir(t *testing.T) {
	var pairs = []struct {
		in  string
		out string
	}{
		{`C:`, platRoot},
		{`C:\`, platRoot},
		{`C:\this`, `C:\`},
		{`C:\this\other\`, `C:\this`},
		{`\\unc`, platRoot},
		{`\\unc\`, platRoot},
		{`\\unc\share\`, `\\UNC`},
		{`\\unc\share\this`, `\\UNC\SHARE`},
	}

	for _, testCase := range pairs {
		got := platPathDir(testCase.in)

		if testCase.out != got {
			t.Errorf("expected platPathDir(%q) == %q, got %q", testCase.in, testCase.out, got)
		}
	}
}

func TestPlatPathBase(t *testing.T) {
	var pairs = []struct {
		in  string
		out string
	}{
		{`C:\`, `C`},
		{`c:\`, `C`},
		{`C:\this`, `this`},
		{`C:\this\other`, `other`},
		{`\\unc`, `UNC`},
		{`\\unc\share\`, `SHARE`},
		{`\\unc\share\this`, `this`},
		{`\\unc\share\this\other`, `other`},
	}

	for _, testCase := range pairs {
		got := platPathBase(testCase.in)

		if testCase.out != got {
			t.Errorf("expected platPathBase(%q) == %q, got %q", testCase.in, testCase.out, got)
		}
	}
}

func TestPlatPathJoin(t *testing.T) {
	var pairs = []struct {
		in  []string
		out string
	}{
		{[]string{`C:\`, `windows`}, `C:\windows`},
		{[]string{platRoot, "c"}, `C:\`},
		{[]string{platRoot, "unc", "path", "mixedCase"}, `\\UNC\PATH\mixedCase`},
	}

	for _, testCase := range pairs {
		got := platPathJoin(testCase.in[0], testCase.in[1:]...)

		if testCase.out != got {
			t.Errorf("expected platPathJoin(%s) == %q, got %q", strings.Join(testCase.in, ", "), testCase.out, got)
		}
	}
}

func TestPlatPathToMac(t *testing.T) {
	var pairs = []struct {
		in  string
		out string
	}{
		{`c:\`, `FS:C:`},
		{`c:\nonExist`, `FS:C:nonExist`},
		{`c:\nonExist\..`, `FS:C:nonExist::`},
		{`c:\nonExist\`, `FS:C:nonExist:`},
		{`c:\nonExist\`, `FS:C:nonExist:`},
		{`c:\nonExist\`, `FS:C:nonExist:`},
		{`\\unc\share\`, `FS:UNC:SHARE:`},
		{`\\unc\share\nonExist`, `FS:UNC:SHARE:nonExist`},
		{`\\unc\share\nonExist\`, `FS:UNC:SHARE:nonExist:`},
		{`.\`, `:`},
		{`..\.`, `::`},
		{`..\.\`, `::`},
		{`..\.\\`, `::`},
	}

	for _, testCase := range pairs {
		got := platPathToMac(testCase.in)

		if testCase.out != got {
			t.Errorf("expected platPathToMac(%q) == %q, got %q", testCase.in, testCase.out, got)
		}
	}
}
