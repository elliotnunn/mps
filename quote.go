// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

package main

func quote(in macstring) macstring {
	out := make([]byte, 0, len(in)+2)

	needQuote := false

	// Need to quote empty string
	if len(in) == 0 {
		needQuote = true
	}

	// Need to quote if any of these characters are present
	for _, c := range []byte(in) {
		switch c {
		case '#', ' ', '\t', '\r', ';', '&', '|', '(', ')', '\'', '"',
			'/', '\\', '{', '}', '`', '?', '[', ']', '+', '*', '<', '>',
			0xb6, // ∂
			0xc5, // ≈
			0xc7, // «
			0xc8, // »
			0xa8, // ®
			0xb3, // ≥
			0xb7, // ∑
			0xc9: // …
			needQuote = true
			break
		}
	}

	if needQuote {
		out = append(out, '\'')
	}

	// The escape character is ∂
	for _, c := range []byte(in) {
		switch c {
		case 0xb6:
			out = append(out, '\'', 0xb6, 0xb6, '\'')
		case '\r':
			out = append(out, '\'', 0xb6, 'n', '\'')
		case '\'':
			out = append(out, '\'', 0xb6, '\'', '\'')
		default:
			out = append(out, c)
		}
	}

	if needQuote {
		out = append(out, '\'')
	}

	return macstring(out)
}
