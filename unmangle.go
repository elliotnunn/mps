// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

/*
C++ name mangling grammer
Macintosh C/C++ ABI Standard Specification v1.3 1996-12-05
Probably inaccurate... and incompletely implemented here

<mangled_name> ::= <entity_name> "__" [<class_name>] <type>
<entity_name> ::= <id> | <special_name>
<special_name> ::= "__ct" | "__dt" | "_vtbl" | "_rttivtbl" | "_vbtbl" | "__rtti" | "__ti" | "___ti" | "__op" <type> | "__" <op>
<op> :: see table

<class_name> ::= <qualified_name>
<qualified_name> ::= 'Q' <count> <qual_name_list>
<count> ::= <terminated_int>
<int> ::= <digit> | <int> <digit>
<digit> ::= 0|1|2|3|4|5|6|7|8|9

<terminated_int> ::= <int> '_'
<qual_name_list> ::= <qual_name> | <qual_name_list> <qual_name>
<qual_name> ::= <l_name> | <parameterized_type>
<l_name> ::= <int> <id>
<parameterized_type> ::= <int> <pt>

<type> ::= <basic_type> | <qualified_type> | <class_name> | <array_type> | <function_type>

<basic_type> ::= <int_type> | <other_base_type>
<int_type> ::= [<sign_mod>] <int_base_type>
<sign_mod> ::= 'S'|'U'
<int_base_type> ::= 'b'|'c'|'s'|'i'|'l'|'x'|'w'
<other_base_type> ::= 'f'|'d'|'r'|'v'|'e'

<qualified_type> ::= [<cv>] [<type_qualifier_list>] <type>
<type_qualifier_list> ::= <type_qualifier> | <type_qualifier_list> <type_qualifier>
<type_qualifier> ::= 'R' | 'P' | 'M' <type>
<cv> ::= 'C'|'V'|'CV'

<array_type> ::= <dimension_list> <type>
<dimension_list> ::= <dimension> | <dimension_list> <dimension>
<dimension> ::= 'A' <terminated_int>

<function_type> ::= 'F' <param_list> ['_' <return_type>]
<param_list> ::= <param> | <param_list> <param>
<param> ::= <type>
<return_type> ::= <type>

<pt> ::= "__PT" <template_name> <pt_param_list>
<template_name> ::= <l_name>
<pt_param_list> ::= <pt_param> | <pt_param_list> <pt_param>
<pt_param> ::= <type> | <expr>
<expr> ::= 'V' <value>
<value> ::= <reference> | <num_value>
<reference> ::= 'R' <count> <characters>
<num_value> ::= 'N' <count> <characters>
<characters> ::= <any_char> | <characters> <any_char>
<any_char> ::= any ASCII char
*/
package main

import (
	"bytes"
	"strings"
)

func unmangle(m string) (u string, ok bool) {
	defer func() {
		recover() // ok=false on failure
	}()

	dunder := strings.Index(m[1:], "__")
	if dunder == -1 {
		return m, false
	}
	dunder += 1

	funcName := m[:dunder] // function name

	r := strings.NewReader(m[dunder+2:])

	namespace := ""
	if isDigit(peekByte(r)) {
		for isDigit(peekByte(r)) {
			namespace = namespace + prefixedStr(r) + "::"
		}
	} else if peekByte(r) == 'Q' {
		for _, ns := range qStr(r) {
			namespace = ns + "::" + namespace
		}
	}

	return unmangleType(r, namespace+funcName), true
}

func unmangleType(r *strings.Reader, name string) string {
	var modifiers []byte
	for bytes.Contains([]byte("SUPRCV"), []byte{peekByte(r)}) {
		modifiers = append(modifiers, readByte(r))
	}

	// Reverse modifiers to "nearest first"
	for i := 0; i < len(modifiers)/2; i++ {
		j := len(modifiers) - i - 1
		modifiers[i], modifiers[j] = modifiers[j], modifiers[i]
	}

	switch peekByte(r) {
	case 'F', 'D':
		readByte(r) // waste 'F'

		var bild strings.Builder

		if bytes.Contains(modifiers, []byte("S")) {
			bild.WriteString("static ")
		}

		// Need to read arg list, but don't use it yet
		var args []string
		for r.Len() != 0 && peekByte(r) != '_' {
			type_ := unmangleType(r, "")

			// Recall type
			if len(type_) == 1 && '1' <= type_[0] && type_[0] <= '9' {
				type_ = args[type_[0]-'1']
			}

			args = append(args, type_)
		}

		// Return type
		if r.Len() != 0 && peekByte(r) == '_' {
			readByte(r)
			bild.WriteString(unmangleType(r, ""))
			bild.WriteByte(' ')
		}

		// Function pointers (don't usually have a name!)
		var stars []byte
		for _, mod := range modifiers {
			switch mod {
			case 'P':
				stars = append(stars, '*')
			case 'R':
				stars = append(stars, '&')
			}
		}

		// Func name and stars, with brackets around if necessary
		if len(stars) != 0 {
			bild.WriteByte('(')
		}
		if name != "" {
			bild.WriteString(name)
		}
		if len(stars) != 0 {
			bild.Write(stars)
			bild.WriteByte(')')
		}

		bild.WriteByte('(')
		comma := ""
		for _, arg := range args {
			bild.WriteString(comma)
			bild.WriteString(arg)
			comma = ", "
		}
		bild.WriteByte(')')

		if bytes.Contains(modifiers, []byte("V")) {
			bild.WriteString(" volatile")
		}

		if bytes.Contains(modifiers, []byte("C")) {
			bild.WriteString(" const")
		}

		return bild.String()

	case 'b', 'c', 'd', 'e', 'f', 'i', 'l', 'r', 's', 'v', 'w', 'x', 'Q',
		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9':

		str := ""
		switch peekByte(r) {
		case 'Q':
			str = strings.Join(qStr(r), "::")
		case '0', '1', '2', '3', '4', '5', '6', '7', '8', '9':
			str = prefixedStr(r)
		default:
			str = map[byte]string{
				'b': "bool",
				'c': "char",
				'd': "double",
				'e': "...",
				'f': "float",
				'i': "int",
				'l': "long",
				'r': "long double",
				's': "short",
				'v': "void",
				'w': "wchar_t",
				'x': "long long",
			}[readByte(r)]
		}

		if bytes.Contains(modifiers, []byte("S")) {
			str = "signed " + str
		} else if bytes.Contains(modifiers, []byte("U")) {
			str = "unsigned " + str
		}

		for _, mod := range modifiers {
			switch mod {
			case 'P':
				str += "*"
			case 'R':
				str += "&"
			case 'C', 'V':
				thing := "const"
				if mod == 'V' {
					thing = "volatile"
				}

				if strings.HasSuffix(str, "*") || strings.HasSuffix(str, "&") {
					str = str + " " + thing
				} else {
					str = thing + " " + str
				}
			}
		}

		return str

	case 'T':
		readByte(r) // waste 'F'
		num := readByte(r)
		if !('1' <= num && num <= '9') {
			panic("expected 1-9")
		}
		return string(num)

	default:
		panic("unknown char " + string(peekByte(r)))
	}
}

func readByte(r *strings.Reader) byte {
	byt, err := r.ReadByte()
	if err != nil {
		panic("unexpectedly ended")
	}
	return byt
}

func peekByte(r *strings.Reader) byte {
	byt := readByte(r)
	r.UnreadByte()
	return byt
}

// String prefixed by decimal number
func prefixedStr(r *strings.Reader) string {
	len := 0
	for isDigit(peekByte(r)) {
		len = 10*len + int(readByte(r)-'0')
	}
	var str []byte
	for i := 0; i < len; i++ {
		str = append(str, readByte(r))
	}
	return string(str)
}

// "Qnn_mmXX_mmXX" where n=count, m=lengths
func qStr(r *strings.Reader) []string {
	if readByte(r) != 'Q' {
		panic("expected Q")
	}

	cnt := 0
	for isDigit(peekByte(r)) {
		cnt = 10*cnt + int(readByte(r)-'0')
	}

	if readByte(r) != '_' {
		panic("expected _")
	}

	slice := make([]string, 0, cnt)
	for i := 0; i < cnt; i++ {
		slice = append(slice, prefixedStr(r))
	}
	return slice
}

func isDigit(c byte) bool {
	return '0' <= c && c <= '9'
}
