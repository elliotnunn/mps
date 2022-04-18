// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

package main

import (
	"testing"
)

var quoteTestPairs = []string{
	"", "''",
	" ", "' '",
	"x∂", "'x'∂∂''",
	"x\n", "'x'∂n''",
	"abc", "abc",
	"abc def", "'abc def'",
}

func TestQuote(t *testing.T) {
	for i := 0; i*2 < len(quoteTestPairs); i += 2 {
		in := unicodeToMacOrPanic(quoteTestPairs[i])
		out := unicodeToMacOrPanic(quoteTestPairs[i+1])

		if quote(in) != out {
			t.Fatalf("expected %q, got %q", out, quote(in))
		}
	}
}
