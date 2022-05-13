// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

package main

import (
	"testing"
)

var quoteTestPairs = []struct {
	in  string
	out string
}{
	{"", "''"},
	{" ", "' '"},
	{"x∂", "'x'∂∂''"},
	{"x\n", "'x'∂n''"},
	{"abc", "abc"},
	{"abc def", "'abc def'"},
}

func TestQuote(t *testing.T) {
	for _, testCase := range quoteTestPairs {
		got := macToUnicode(quote(unicodeToMacOrPanic(testCase.in)))

		if testCase.out != got {
			t.Errorf("expected quote(%q) == %q, got %q", testCase.in, testCase.out, got)
		}
	}
}
