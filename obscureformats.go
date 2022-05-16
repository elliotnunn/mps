// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

package main

import (
	"encoding/binary"
)

/*
ROCo-type Disk Copy 6 images

Resource 'bcem' lists chunks... would love to do reconstruct without it!

"Apple Data Compression" reversed by Pierre Duhem with thanks
<https://www.macdisk.com/dmgen.php>

Read a byte. If bit 7 is set, this is a data run, whose length is the
rest of the bits, plus one.

	Copy to the target buffer.

If bit 6 is set, this is a three-byte code.

	Strip the bit 6 and add 4 to get the length. The following two bytes
	code the offset of the data to be used. This offset is computed
	backwards from the target pointer. Put a offset pointer to this
	address. If the difference between the offset pointer and the target
	pointer is large enough to hold the data length, just do a plain
	copy from the offset pointer to the target pointer. If not, use
	memset or the like to copy n times a single byte at the target
	pointer.

	CORRECTION BY ELLIOT: Copy n bytes from the offset, always. The
	resulting "eating own tail" behaviour is correct.

If none is set, this is a two-byte code.

	The length is coded in bits 2345 and the offset is coded in bits 01
	of the first byte and in the other byte. Add 3 to the length (that
	is, 0000 codes 3, 0001 4, and so on). Like in the three-byte codes,
	depending on the difference between the offset pointer and the
	target pointer, use memcpy or memset.

As long as there is still data to decode.
*/
func extractROCo(data []byte, bcem []byte) []byte {
	if bcem[0] != 0 || bcem[1] != 0x0b {
		panic("Bad bcem")
	}

	var accum []byte

	bcemCount := int(binary.BigEndian.Uint32(bcem[0x7c:]))
	for i := 0; i < bcemCount; i++ {
		entry := bcem[0x80+12*i:][:12]

		kind := entry[3]
		base := int(binary.BigEndian.Uint32(entry[4:]))
		size := int(binary.BigEndian.Uint32(entry[8:]))

		if size == 0 {
			continue
		}

		switch kind {
		case 2: // direct
			accum = append(accum, data[base:][:size]...)

		case 0x83:
			i := base
			for i < base+size {
				opcode := data[i]
				i++
				if opcode&0x80 != 0 { // 1-byte code
					runlength := int(opcode&^0x80 + 1)
					accum = append(accum, data[i:][:runlength]...)
					i += runlength
					continue
				}

				var runlength, offset int
				if opcode&0x40 != 0 { // 3-byte code
					runlength = int(opcode&^0xc0) + 4
					offset = int(binary.BigEndian.Uint16(data[i:]))
					i += 2
				} else { // 2-byte code
					runlength = int(opcode>>2&0xf) + 3
					offset = int(opcode) << 8 & 0x300
					offset += int(data[i])
					i++
				}

				copybase := len(accum) - offset - 1

				for j := 0; j < runlength; j++ {
					accum = append(accum, accum[copybase+j])
				}
			}

		default:
			panic("unimp")
		}
	}

	return accum
}

// Nearly trivial
func macbinary(blob []byte) (data []byte, resource []byte, ftype, creator string) {
	ftype = string(blob[65:69])
	creator = string(blob[69:73])

	datalen := binary.BigEndian.Uint32(blob[83:])
	data = blob[128:][:datalen]

	reslen := binary.BigEndian.Uint32(blob[87:])
	resbase := 128 + datalen
	resbase += 127
	resbase -= resbase % 128
	resource = blob[resbase:][:reslen]

	return
}
