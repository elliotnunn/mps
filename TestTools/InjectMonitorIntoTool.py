#!/usr/bin/env python3

bodge_code = r'''

    macro   PushStrAndLength
    bra     .Skip\@
.StrStart\@
    dc.b    \1
.StrEnd\@
    even
.Skip\@
    pea     .StrStart\@
    move.l  #.StrEnd\@-.StrStart\@,-(sp)
    endm


    macro   PushStrNewlineAndLength
    bra     .Skip\@
.StrStart\@
    dc.b    \1
    dc.b    13
.StrEnd\@
    even
.Skip\@
    pea     .StrStart\@
    move.l  #.StrEnd\@-.StrStart\@,-(sp)
    endm


    movem.l d0-d7/a0-a4,-(sp)
    link    a6,#0

; Keep enough information for an un-intercepted write to stderr
    move.l  $316,a0         ; a0 points to MPGM table
    move.l  4(a0),a0        ; a0 points to SH table
    move.l  $1c(a0),a0      ; a0 points to table of file structures
    lea     $28(a0),a0      ; a0 points to stdout file descriptor
    move.l  4(a0),a1        ; a1 points to stdout FSYS table
    move.l  $10(a1),a1      ; a1 points to stdout write routine

    lea     stderrPtr,a2    ; save this info
    move.l  a0,(a2)
    lea     stderrWritePtr,a2
    move.l  a1,(a2)

; Patch MPW's function tables to run our interceptor routine
    move.l  $316,a0         ; a0 points to MPGM table
    move.l  4(a0),a0        ; a0 points to SH table
    move.l  $20(a0),a0      ; a0 points to FSYS/ECON/SYST array, $18b each

    lea     generatedJumpCode,a4
.tableLoop
    move.b  (a0),d0
    cmp.b   #'A',d0
    blt.s   .noMoreTables
    cmp.b   #'Z',d0
    bgt.s   .noMoreTables

    move.l  (a0)+,d7        ; d7 = FSYS or similar
    moveq.l #4,d6           ; d6 = what kind of routine
.entryLoop
    move.l  (a0)+,d5        ; d5 = mpw's routine address

    move.l  a4,-4(a0)       ; set new routine address

                            ; create our fake routine...
    move.w  #$2f3c,(a4)+    ; move.l #imm,-(sp)
    move.l  d5,(a4)+            (#imm = mpw's routine address)
    move.w  #$2f3c,(a4)+    ; move.l #imm,-(sp)
    move.l  d7,(a4)+        ;   (#imm = FSYS or similar)
    move.w  #$2f3c,(a4)+    ; move.l #imm,-(sp)
    move.l  d6,(a4)+        ;   (#imm = what kind of routine)
    move.w  #$4ef9,(a4)+    ; jmp abs.l
    pea     preMpwOperation
    move.l  (sp)+,(a4)+     ;   (abs.l = our routine)

    dbra    d6,.entryLoop
.noMoreTables

    unlk    a6
    movem.l (sp)+,d0-d7/a0-a4
    bra     realRoutine     ; on with the main program


; This is our single interceptor routine

; On entry:
;  0(sp).l  4=access/3=close/2=read/1=write/0=ioctl
;  4(sp).l  FSYS or similar
;  8(sp).l  mpw's real routine address
; 12(sp).l  return address in program, etc

; We can safely trash d0-d2/a0-a1, I think

tableName           dc.l    0
realRoutineAddress  dc.l    0
returnAddress       dc.l    0

preMpwOperation
    movem.l (sp)+,d0 ; operation
    lea     tableName,a0
    move.l  (sp)+,(a0)
    lea     realRoutineAddress,a0
    move.l  (sp)+,(a0)
    lea     returnAddress,a0
    move.l  (sp)+,(a0)


    tst.l   d0
    bne     not_ioctl
; IOCTL

    PushStrAndLength '#### > '
    bsr     safelyWriteToStderr

    move.l  (sp),a1 ; file struct
    pea     tableName
    move.l  #4,-(sp)
    bsr     safelyWriteToStderr

    PushStrAndLength '.ioctl(fd='
    bsr     safelyWriteToStderr

    move.l  (sp),a1 ; file struct
    pea     8(a1) ; push ptr to fd
    move.l  #4,-(sp)
    bsr     tohex
    bsr     safelyWriteToStderr

    PushStrAndLength ', request='
    bsr     safelyWriteToStderr

    pea     4(sp)
    move.l  #4,-(sp)
    bsr     tohex
    bsr     safelyWriteToStderr

    PushStrAndLength ', argp='
    bsr     safelyWriteToStderr

    pea     8(sp)
    move.l  #4,-(sp)
    bsr     tohex
    bsr     safelyWriteToStderr

    tst.l   8(sp)
    beq.s   dontPrintArgp

    PushStrAndLength ' pointing to '
    bsr     safelyWriteToStderr

    move.l  8(sp),-(sp)
    move.l  #10,-(sp)
    bsr     tohex
    bsr     safelyWriteToStderr
dontPrintArgp
    PushStrNewlineAndLength ')'
    bsr     safelyWriteToStderr

;    move.l  returnAddress,-(sp)
    pea     returnToMyIoctlCode
    move.l  realRoutineAddress,-(sp)
    rts
returnToMyIoctlCode

    PushStrAndLength '#### < d0='
    bsr     safelyWriteToStderr

    move.l  d0,-(sp)
    pea     (sp)
    move.l  #4,-(sp)
    bsr     tohex
    bsr     safelyWriteToStderr
    addq    #4,sp ; pop d0 from the stack

    PushStrAndLength ', err='
    bsr     safelyWriteToStderr

    move.l  (sp),a1 ; file struct
    pea     2(a1) ; push ptr to error code
    move.l  #2,-(sp)
    bsr     tohex
    bsr     safelyWriteToStderr

    PushStrAndLength ', argp='
    bsr     safelyWriteToStderr

    pea     8(sp)
    move.l  #4,-(sp)
    bsr     tohex
    bsr     safelyWriteToStderr

    tst.l   8(sp)
    beq.s   dontPrintArgp2

    PushStrAndLength ' pointing to '
    bsr     safelyWriteToStderr

    move.l  8(sp),-(sp)
    move.l  #10,-(sp)
    bsr     tohex
    bsr     safelyWriteToStderr
dontPrintArgp2
    PushStrNewlineAndLength ')'
    bsr     safelyWriteToStderr

    move.l  returnAddress,-(sp)
    tst.l   d0
    rts









not_ioctl
    subq    #1,d0
    bne     not_write
; WRITE

    move.l  returnAddress,-(sp)
    move.l  realRoutineAddress,-(sp)
    rts

not_write
    subq    #1,d0
    bne     not_read
; READ

    move.l  returnAddress,-(sp)
    move.l  realRoutineAddress,-(sp)
    rts

not_read
    subq    #1,d0
    bne     not_close
; CLOSE

    move.l  returnAddress,-(sp)
    move.l  realRoutineAddress,-(sp)
    rts

not_close
; ACCESS

    move.l  returnAddress,-(sp)
    move.l  realRoutineAddress,-(sp)
    rts




; Hopefully safe function to write debug output, while bypassing our capture mechanism
; push buffer.l then count.l before calling please, and I will pop them for you
stderrPtr           dc.l    0   ; populated by the init code above
stderrWritePtr      dc.l    0
safelyWriteToStderr
    link    a6,#-$40
    movem.l d0-d7/a0-a4,-$40(a6)
    move.l  stderrPtr,a4
    move.l  $c(a4),-(sp)    ; keep previous count
    move.l  $10(a4),-(sp)   ; keep previous buffer
    move.l  $8(a6),$c(a4)   ; apply new count
    move.l  $c(a6),$10(a4)  ; apply new buffer
    move.l  a4,-(sp)        ; push the stdout struct as tribute
    move.l  stderrWritePtr,a0
    jsr     (a0)            ; the write stuff...haha!
    addq    #4,sp           ; pop the stdout struct
    move.l  (sp)+,$10(a4)   ; restore previous buffer
    move.l  (sp)+,$c(a0)    ; restore previous count
    movem.l -$40(a6),d0-d7/a0-a4
    unlk    a6
    move.l  (sp),8(sp)
    addq    #8,sp
    rts


; Function to convert n bytes to hex, same input/output convention as safelyWriteToStderr
; But it uses a fixed hex buffer, so is not reentrant, and is limited in size
fixedSizeHexBuffer  dcb.b   256
hexTemplate         dc.b    '0123456789ABCDEF'
tohex
    link    a6,#-$40
    movem.l d0-d7/a0-a4,-$40(a6)

    move.l  8(a6),d0
    move.l  12(a6),a0
    move.l  d0,d1
    asl.l   #1,d1
    move.l  d1,8(a6)        ; double the number of bytes
    lea     fixedSizeHexBuffer,a1
    move.l  a1,12(a6)

.loop
    tst.l   d0
    beq.s   .exitloop

    clr.l   d1
    move.b  (a0),d1
    asr.l   #4,d1
    move.b  hexTemplate(pc,d1.l),(a1)+ ; upper nibble
    move.b  (a0),d1
    and.l   #$0000000f,d1
    move.b  hexTemplate(pc,d1.l),(a1)+ ; lower nibble

    subq.l  #1,d0
    add.l   #1,a0
    bra.s   .loop
.exitloop

    movem.l -$40(a6),d0-d7/a0-a4
    unlk    a6
    rts


generatedJumpCode
    dcb.b   400


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

        sp = subprocess.run(['vasmm68k_mot', '-quiet', '-Fbin', '-o', destfile.name, srcfile.name])

        if sp.returncode: sys.exit(sp.returncode)

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
