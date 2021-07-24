#!/usr/bin/env python3

# grimly domain-specific piece of code

import machfs
from sys import argv

def longhex(data):
    accum = ''
    for i, byte in enumerate(data):
        accum += '0x%02x,' % byte
        accum += '' if (i+1) % 16 else '\n'
    return accum.strip()

def prind(n, ss):
    for s in ss.split('\n'):
        if s:
            print(n * '\t' + s)

vol = machfs.Volume()
vol.read(open(argv[1], 'rb').read())
if len(argv) > 2:
    vol = vol[tuple(argv[2].split(':'))]

print('package main')
print()

print('func secretFolder(path string) (isFolder bool, contents []string) {')
prind(1, 'switch path {')
for path, obj in vol.iter_paths():
    if isinstance(obj, machfs.Folder):
        prind(1, f'case "{":".join(path)}":')
        prind(3, 'return true, []string{')
        for name in obj:
            prind(4, f'"{name}",')
        prind(3, '}')
prind(1, '}')
prind(1, 'return false, nil')
print('}')

print()

print('func secretFile(path string, fork int) (isFile bool, contents []byte) {')
prind(1, 'switch path {')
for path, obj in vol.iter_paths():
    if isinstance(obj, machfs.File):
        obj.data = obj.data.partition(b'Joy!peff')[0] # snip off PPC code

        prind(1, f'case "{":".join(path)}":')
        prind(2, 'switch fork {')

        prind(2, "case 'i':")
        prind(3, f'return true, []byte("{(obj.type + obj.creator).decode("ascii")}")')

        prind(2, "case 'r':")
        if obj.rsrc:
            prind(3, 'return true, []byte{')
            prind(4, longhex(obj.rsrc).rstrip(',') + '}')
        else:
            prind(3, 'return true, nil')

        prind(2, "case 'd':")
        if obj.data:
            prind(3, 'return true, []byte{')
            prind(4, longhex(obj.data).rstrip(',') + '}')
        else:
            prind(3, 'return true, nil')

        prind(2, '}')

prind(1, '}')
prind(1, 'return false, nil')
print('}')
