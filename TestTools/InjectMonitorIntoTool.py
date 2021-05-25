#!/usr/bin/env python3

bodge_code = '''
    bra     realRoutine
'''

import argparse
import struct
import subprocess
import sys
import tempfile

import macresources # https://github.com/elliotnunn/macresources

def vasmm68k_mot(the_code): # http://sun.hasenbraten.de/vasm/
    with tempfile.NamedTemporaryFile('w', delete=False) as srcfile, tempfile.NamedTemporaryFile('wb', delete=False) as destfile:
        srcfile.write(the_code)
        srcfile.close()
        destfile.close()

        subprocess.run(['vasmm68k_mot', '-quiet', '-Fbin', '-o', destfile.name, srcfile.name],
            check=True)

        return open(destfile.name, 'rb').read()


parser = argparse.ArgumentParser(description='Binpatch MPW Tool. Requires vasmm68k_mot and macresources.')

# parser.add_argument('--gather', action='store_true', help='Binary or directory')
parser.add_argument('-r', action='store_true', help='Revert patch')
parser.add_argument('targ', action='store', help='Target')

args = parser.parse_args()


if not args.targ.endswith('.rdump'): args.targ += '.rdump'
rfork = macresources.parse_rez_code(
    open(args.targ, 'rb').read(), original_file=args.targ)

rfork = list(rfork)

for zerosegment in rfork:
    if not (zerosegment.type == b'CODE' and zerosegment.id == 0): continue

    mainproc, mainsegnum = struct.unpack_from('>Hxxh', zerosegment, 16)
    break

for mainsegment in rfork:
    if not (mainsegment.type == b'CODE' and mainsegment.id == mainsegnum): continue
    break

newmainproc = mainproc

if b'patched here' in mainsegment:
    real, _, fake = mainsegment.partition(b'patched here')
    mainsegment[:] = real
    newmainproc, = struct.unpack_from('>H', fake)
    mainproc = newmainproc

    print('unpatched')

if not args.r: # if not undoing the patch
    # To allow reversal of the patch
    mainsegment.extend(b'patched here')
    mainsegment.extend(struct.pack('>H', mainproc))
    while len(mainsegment) % 2: mainsegment.append(0)

    # Append a new "main" procedure
    newmainproc = len(mainsegment) - 4
    bodge_code = ('realRoutine equ *+%d-%d\n' % (mainproc, newmainproc)) + bodge_code
    mainsegment.extend(vasmm68k_mot(bodge_code))

    print('patched')

struct.pack_into('>H', zerosegment, 16, newmainproc) # where to start the program

open(args.targ, 'wb').write(macresources.make_rez_code(rfork, ascii_clean=True))
