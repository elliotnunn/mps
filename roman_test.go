// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

package main

import (
	"bytes"
	"encoding/hex"
	"testing"
)

func Test2CharToMac(t *testing.T) {
	for _, pair1 := range utfMacPairList {
		for _, pair2 := range utfMacPairList {
			mac := pair1.mac + pair2.mac
			utf := pair1.utf + pair2.utf
			name := hex.EncodeToString([]byte(utf)) + "_" + hex.EncodeToString([]byte(mac))
			t.Run(name, func(t *testing.T) {
				got := string(unicodeToMacOrPanic(utf))
				if got != mac {
					t.Fatalf("Got %s", hex.EncodeToString([]byte(got)))
				}
			})
		}
	}
}

func Test2CharToUnicode(t *testing.T) {
	for _, pair1 := range utfMacPairList {
		for _, pair2 := range utfMacPairList {
			mac := pair1.mac + pair2.mac
			utf := pair1.utf + pair2.utf

			// We never output combining characters or the pre-8.5 currency sign
			if bytes.Contains([]byte(utf), []byte{0xcc}) || bytes.Contains([]byte(utf), []byte{0xc2, 0xa4}) {
				continue
			}

			name := hex.EncodeToString([]byte(mac)) + "_" + hex.EncodeToString([]byte(utf))
			t.Run(name, func(t *testing.T) {
				got := macToUnicode(macstring(mac))
				if got != utf {
					t.Fatalf("Got %s", hex.EncodeToString([]byte(got)))
				}
			})
		}
	}
}

type utfMacPair struct {
	mac string
	utf string
}

var utfMacPairList = []utfMacPair{
	{"", ""},
	{"\r", "\n"},
	{"\x00", "\u0000"},
	{"\x01", "\u0001"},
	{"\x02", "\u0002"},
	{"\x03", "\u0003"},
	{"\x04", "\u0004"},
	{"\x05", "\u0005"},
	{"\x06", "\u0006"},
	{"\x07", "\u0007"},
	{"\x08", "\u0008"},
	{"\x09", "\u0009"},
	{"\x0b", "\u000b"},
	{"\x0c", "\u000c"},
	{"\x0e", "\u000e"},
	{"\x0f", "\u000f"},
	{"\x10", "\u0010"},
	{"\x11", "\u0011"},
	{"\x12", "\u0012"},
	{"\x13", "\u0013"},
	{"\x14", "\u0014"},
	{"\x15", "\u0015"},
	{"\x16", "\u0016"},
	{"\x17", "\u0017"},
	{"\x18", "\u0018"},
	{"\x19", "\u0019"},
	{"\x1a", "\u001a"},
	{"\x1b", "\u001b"},
	{"\x1c", "\u001c"},
	{"\x1d", "\u001d"},
	{"\x1e", "\u001e"},
	{"\x1f", "\u001f"},
	{" ", " "},
	{"!", "!"},
	{"\"", "\""},
	{"#", "#"},
	{"$", "$"},
	{"%", "%"},
	{"&", "&"},
	{"'", "'"},
	{"(", "("},
	{")", ")"},
	{"*", "*"},
	{"+", "+"},
	{",", ","},
	{"-", "-"},
	{".", "."},
	{"/", "/"},
	{"0", "0"},
	{"1", "1"},
	{"2", "2"},
	{"3", "3"},
	{"4", "4"},
	{"5", "5"},
	{"6", "6"},
	{"7", "7"},
	{"8", "8"},
	{"9", "9"},
	{":", ":"},
	{";", ";"},
	{"<", "<"},
	{"=", "="},
	{">", ">"},
	{"?", "?"},
	{"@", "@"},
	{"A", "A"},
	{"B", "B"},
	{"C", "C"},
	{"D", "D"},
	{"E", "E"},
	{"F", "F"},
	{"G", "G"},
	{"H", "H"},
	{"I", "I"},
	{"J", "J"},
	{"K", "K"},
	{"L", "L"},
	{"M", "M"},
	{"N", "N"},
	{"O", "O"},
	{"P", "P"},
	{"Q", "Q"},
	{"R", "R"},
	{"S", "S"},
	{"T", "T"},
	{"U", "U"},
	{"V", "V"},
	{"W", "W"},
	{"X", "X"},
	{"Y", "Y"},
	{"Z", "Z"},
	{"[", "["},
	{"\\", "\\"},
	{"]", "]"},
	{"^", "^"},
	{"_", "_"},
	{"`", "`"},
	{"a", "a"},
	{"b", "b"},
	{"c", "c"},
	{"d", "d"},
	{"e", "e"},
	{"f", "f"},
	{"g", "g"},
	{"h", "h"},
	{"i", "i"},
	{"j", "j"},
	{"k", "k"},
	{"l", "l"},
	{"m", "m"},
	{"n", "n"},
	{"o", "o"},
	{"p", "p"},
	{"q", "q"},
	{"r", "r"},
	{"s", "s"},
	{"t", "t"},
	{"u", "u"},
	{"v", "v"},
	{"w", "w"},
	{"x", "x"},
	{"y", "y"},
	{"z", "z"},
	{"{", "{"},
	{"|", "|"},
	{"}", "}"},
	{"~", "~"},
	{"\x7f", "\u007f"},
	{"\x80", "\u00c4"},
	{"\x80", "A\u0308"},
	{"\x81", "\u00c5"},
	{"\x81", "A\u030a"},
	{"\x82", "\u00c7"},
	{"\x82", "C\u0327"},
	{"\x83", "\u00c9"},
	{"\x83", "E\u0301"},
	{"\x84", "\u00d1"},
	{"\x84", "N\u0303"},
	{"\x85", "\u00d6"},
	{"\x85", "O\u0308"},
	{"\x86", "\u00dc"},
	{"\x86", "U\u0308"},
	{"\x87", "\u00e1"},
	{"\x87", "a\u0301"},
	{"\x88", "\u00e0"},
	{"\x88", "a\u0300"},
	{"\x89", "\u00e2"},
	{"\x89", "a\u0302"},
	{"\x8a", "\u00e4"},
	{"\x8a", "a\u0308"},
	{"\x8b", "\u00e3"},
	{"\x8b", "a\u0303"},
	{"\x8c", "\u00e5"},
	{"\x8c", "a\u030a"},
	{"\x8d", "\u00e7"},
	{"\x8d", "c\u0327"},
	{"\x8e", "\u00e9"},
	{"\x8e", "e\u0301"},
	{"\x8f", "\u00e8"},
	{"\x8f", "e\u0300"},
	{"\x90", "\u00ea"},
	{"\x90", "e\u0302"},
	{"\x91", "\u00eb"},
	{"\x91", "e\u0308"},
	{"\x92", "\u00ed"},
	{"\x92", "i\u0301"},
	{"\x93", "\u00ec"},
	{"\x93", "i\u0300"},
	{"\x94", "\u00ee"},
	{"\x94", "i\u0302"},
	{"\x95", "\u00ef"},
	{"\x95", "i\u0308"},
	{"\x96", "\u00f1"},
	{"\x96", "n\u0303"},
	{"\x97", "\u00f3"},
	{"\x97", "o\u0301"},
	{"\x98", "\u00f2"},
	{"\x98", "o\u0300"},
	{"\x99", "\u00f4"},
	{"\x99", "o\u0302"},
	{"\x9a", "\u00f6"},
	{"\x9a", "o\u0308"},
	{"\x9b", "\u00f5"},
	{"\x9b", "o\u0303"},
	{"\x9c", "\u00fa"},
	{"\x9c", "u\u0301"},
	{"\x9d", "\u00f9"},
	{"\x9d", "u\u0300"},
	{"\x9e", "\u00fb"},
	{"\x9e", "u\u0302"},
	{"\x9f", "\u00fc"},
	{"\x9f", "u\u0308"},
	{"\xa0", "\u2020"},
	{"\xa1", "\u00b0"},
	{"\xa2", "\u00a2"},
	{"\xa3", "\u00a3"},
	{"\xa4", "\u00a7"},
	{"\xa5", "\u2022"},
	{"\xa6", "\u00b6"},
	{"\xa7", "\u00df"},
	{"\xa8", "\u00ae"},
	{"\xa9", "\u00a9"},
	{"\xaa", "\u2122"},
	{"\xab", "\u00b4"},
	{"\xac", "\u00a8"},
	{"\xad", "\u2260"},
	{"\xad", "=\u0338"},
	{"\xae", "\u00c6"},
	{"\xaf", "\u00d8"},
	{"\xb0", "\u221e"},
	{"\xb1", "\u00b1"},
	{"\xb2", "\u2264"},
	{"\xb3", "\u2265"},
	{"\xb4", "\u00a5"},
	{"\xb5", "\u00b5"},
	{"\xb6", "\u2202"},
	{"\xb7", "\u2211"},
	{"\xb8", "\u220f"},
	{"\xb9", "\u03c0"},
	{"\xba", "\u222b"},
	{"\xbb", "\u00aa"},
	{"\xbc", "\u00ba"},
	{"\xbd", "\u03a9"},
	{"\xbe", "\u00e6"},
	{"\xbf", "\u00f8"},
	{"\xc0", "\u00bf"},
	{"\xc1", "\u00a1"},
	{"\xc2", "\u00ac"},
	{"\xc3", "\u221a"},
	{"\xc4", "\u0192"},
	{"\xc5", "\u2248"},
	{"\xc6", "\u2206"},
	{"\xc7", "\u00ab"},
	{"\xc8", "\u00bb"},
	{"\xc9", "\u2026"},
	{"\xca", "\u00a0"},
	{"\xcb", "\u00c0"},
	{"\xcb", "A\u0300"},
	{"\xcc", "\u00c3"},
	{"\xcc", "A\u0303"},
	{"\xcd", "\u00d5"},
	{"\xcd", "O\u0303"},
	{"\xce", "\u0152"},
	{"\xcf", "\u0153"},
	{"\xd0", "\u2013"},
	{"\xd1", "\u2014"},
	{"\xd2", "\u201c"},
	{"\xd3", "\u201d"},
	{"\xd4", "\u2018"},
	{"\xd5", "\u2019"},
	{"\xd6", "\u00f7"},
	{"\xd7", "\u25ca"},
	{"\xd8", "\u00ff"},
	{"\xd8", "y\u0308"},
	{"\xd9", "\u0178"},
	{"\xd9", "Y\u0308"},
	{"\xda", "\u2044"},
	{"\xdb", "\u00a4"},
	{"\xdb", "\u20ac"},
	{"\xdc", "\u2039"},
	{"\xdd", "\u203a"},
	{"\xde", "\ufb01"},
	{"\xdf", "\ufb02"},
	{"\xe0", "\u2021"},
	{"\xe1", "\u00b7"},
	{"\xe2", "\u201a"},
	{"\xe3", "\u201e"},
	{"\xe4", "\u2030"},
	{"\xe5", "\u00c2"},
	{"\xe5", "A\u0302"},
	{"\xe6", "\u00ca"},
	{"\xe6", "E\u0302"},
	{"\xe7", "\u00c1"},
	{"\xe7", "A\u0301"},
	{"\xe8", "\u00cb"},
	{"\xe8", "E\u0308"},
	{"\xe9", "\u00c8"},
	{"\xe9", "E\u0300"},
	{"\xea", "\u00cd"},
	{"\xea", "I\u0301"},
	{"\xeb", "\u00ce"},
	{"\xeb", "I\u0302"},
	{"\xec", "\u00cf"},
	{"\xec", "I\u0308"},
	{"\xed", "\u00cc"},
	{"\xed", "I\u0300"},
	{"\xee", "\u00d3"},
	{"\xee", "O\u0301"},
	{"\xef", "\u00d4"},
	{"\xef", "O\u0302"},
	{"\xf0", "\uf8ff"},
	{"\xf1", "\u00d2"},
	{"\xf1", "O\u0300"},
	{"\xf2", "\u00da"},
	{"\xf2", "U\u0301"},
	{"\xf3", "\u00db"},
	{"\xf3", "U\u0302"},
	{"\xf4", "\u00d9"},
	{"\xf4", "U\u0300"},
	{"\xf5", "\u0131"},
	{"\xf6", "\u02c6"},
	{"\xf7", "\u02dc"},
	{"\xf8", "\u00af"},
	{"\xf9", "\u02d8"},
	{"\xfa", "\u02d9"},
	{"\xfb", "\u02da"},
	{"\xfc", "\u00b8"},
	{"\xfd", "\u02dd"},
	{"\xfe", "\u02db"},
	{"\xff", "\u02c7"},
}
