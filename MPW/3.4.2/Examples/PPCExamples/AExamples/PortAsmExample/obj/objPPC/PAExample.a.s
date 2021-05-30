	file	'PAExample.a'

#########################################################################
#                                                                       #
#       "PAExample.a.s" - Translated from file "PAExample.a"            #
#                                                                       #
#-----------------------------------------------------------------------#
#                                                                       #
#       PortAsm Code Translator Copyright (c) MicroAPL 1990-1994        #
#                   All Rights Reserved Worldwide                       #
#                                                                       #
#########################################################################
# Translated on Thu Jun 30 16:42:14 1994 by version 1.2.2 of PortAsm translator
# PortAsm Licence Number #1250
#
# Non-default Options specified :
#          -dcheck          - Generate runtime integrity checking code
#          -define PowerPC_version=1
#                           - Define symbol or macro symbol
#          -glue TestHD_0:MPW:PortAsm:PortAsm.GlueInfo,:PPC_only:PAExample.glue
#                           - Filename for glue
#          -infopath ::obj:info:
#                           - Path for .INFO files
#          -MacsBug         - Generate MacsBug-style debugging information
#          -nop nop         - Specify instruction to use for 'nop'
#          -o ::obj:objPPC:PAExample.a.s
#                           - Filename for output file
#          -opt glue,cbstack
#                           - Specify list of optimizations to perform
#          -prepend _68_    - Name to prepend to global symbols in output
#          -project :PPC_only:PAExample.proj
#                           - Filename for .PROJ file
#          -sym68k          - Generate info for debugger (680x0 source)
#
#
	dialect   PowerPC
	aligning  off		# We'll do our own alignment
	string    asis


###################################################
# Declare module/imported data offsets            #
###################################################

#########################################################################
# PortAsm Data Offsets file for "PAExamplePPC"                          #
#########################################################################


;# Data offsets for PAExample.a
BaseOf_PAExample_a:        equ 0
_68_QD:                    equ BaseOf_PAExample_a + 8
_68_G:                     equ BaseOf_PAExample_a + 214
SizeOf_PAExample_a:        equ 244

;# Data offsets for DoEvents.a
BaseOf_DoEvents_a:         equ BaseOf_PAExample_a + SizeOf_PAExample_a
SizeOf_DoEvents_a:         equ 4

;# Data offsets for MyPolygon.a
BaseOf_MyPolygon_a:        equ BaseOf_DoEvents_a + SizeOf_DoEvents_a
_68_ThePolygon:            equ BaseOf_MyPolygon_a + 36
SizeOf_MyPolygon_a:        equ 48

;# Data offsets for AboutDlg.a
BaseOf_AboutDlg_a:         equ BaseOf_MyPolygon_a + SizeOf_MyPolygon_a
_68_DialogPtr:             equ BaseOf_AboutDlg_a + 4
_68_DialogPtr2:            equ BaseOf_AboutDlg_a + 8
SizeOf_AboutDlg_a:         equ 28

;# Data offsets for MySound.a
BaseOf_MySound_a:          equ BaseOf_AboutDlg_a + SizeOf_AboutDlg_a
SizeOf_MySound_a:          equ 24

;# Data offsets for VirtualWin.a
BaseOf_VirtualWin_a:       equ BaseOf_MySound_a + SizeOf_MySound_a
_68_PolyWindow:            equ BaseOf_VirtualWin_a + 4
_68_RealWindow:            equ BaseOf_VirtualWin_a + 8
_68_VirtualWindow:         equ BaseOf_VirtualWin_a + 12
SizeOf_VirtualWin_a:       equ 40


ModA5	equ	BaseOf_PAExample_a

###################################################
# Additional equates for translation              #
###################################################
RS       equ   9
RT       equ   10
RXFlag   equ   6
RV       equ   11
RU       equ   5
RX       equ   12
RY       equ   8
RZ       equ   7
RByte    equ   13
RWord    equ   14
RZero    equ   15

# Shadow register assignments:
d0       equ   16
d1       equ   17
d2       equ   18
d3       equ   19
d4       equ   20
d5       equ   21
d6       equ   22
d7       equ   23
a0       equ   24
a1       equ   25
a2       equ   26
a3       equ   27
a4       equ   28
a5       equ   29
a6       equ   30
a7       equ   31
CR1_LS:	 equ   4
CR1_V: 	 equ   5
CR1_C: 	 equ   6

###################################################
# Table of Contents                               #
###################################################
	toc
T_PAStack:	tc _PAStack,_PAStack[rw]
T_PAStart:	tc _PAStart,_PAStart[ds]
T_PAQuit:	tc _PAQuit,_PAQuit
T_A5World:	tc  A5World,A5World[rw]
T_PADebug:	tc _PADebug,_PADebug[rw]

# Descriptor for _PAStart:
	export _PAStart[ds]
	csect  _PAStart[ds]
	dc.l   ._PAStart, TOC[tc0]

###################################################
# Memory for A7 stack                             #
###################################################
_PAStackSize:	equ	30000
	csect  _PAStack[rw]
	ds.b   _PAStackSize
_PAStackTop:
	# Leave some spill after the stack
	ds.b   100


###################################################
# Debugging information                           #
###################################################
	csect	_PADebug[rw]

# The following debugging table was added by the -macsbug option
# It is used by debugger extensions like CallHistory and WhereIs
	import	_PAEndProgram
_PADebugTable:
	dcb.l	8,0x18273645			# Magic search fingerprint
	dc.l	0x54637281,0
	dc.l	._PAStart			# Start of code
	dc.l	_PAEndProgram			# End of code
	dc.l	0,0,0,0,0			# Reserved - 5 longs

# Small poke area for debugging...
_PAPokeArea:
_PAPokeLast:  	dc.l	0,0	# Last caller/callee
_PAPokeIdx:  	dc.l	0	# Buffer index
_PAPokeSize:	dc.l	64	# Number of entries
		dc.l	0	# Reserved
_PAPokeBuf:	ds.l	64*2

###################################################
# Declare A5 data CSECT                           #
###################################################
	csect   A5World[rw]
_PANoGC:
# 0(A5) is pointer to QuickDraw globals:
	dc.l   0

# Magic value for data offsets integrity check
_PAMagic:	equ	* + ModA5
	dc.b   'PA'
	dc.w  	0

###################################################
#  _PAStart: Setup Code                           #
###################################################
# This is the entry point for the translated program

	csect   PCcsect[pr]
._PAStart:
	mflr	R0
	mfcr	R12
	stw	R0,8(R1)
	stw  	R12,4(R1)
	stmw	R13,-4*(32-13)(R1)
	stwu	R1,-512(R1)
	lil     RByte,0x00ff
	ori     RWord,RByte,0xffff
	lil     RZero,0
	lwz     a7,T_PAStack(RTOC)
	addi    a7,a7,_PAStackSize
	lwz     R0,T_PAQuit(RTOC)
	stwu    R0,-4(a7)
	lwz     a5,T_A5World(RTOC)

# Initialise the modules:
	bl	_PAInit_PAExample_a
	cmpi	0,R3,0
	bnel	_PADCheckFail
	import 	_PAInit_DoEvents_a
	bl	_PAInit_DoEvents_a
	cmpi	0,R3,0
	bnel	_PADCheckFail
	import 	_PAInit_MyPolygon_a
	bl	_PAInit_MyPolygon_a
	cmpi	0,R3,0
	bnel	_PADCheckFail
	import 	_PAInit_AboutDlg_a
	bl	_PAInit_AboutDlg_a
	cmpi	0,R3,0
	bnel	_PADCheckFail
	import 	_PAInit_MySound_a
	bl	_PAInit_MySound_a
	cmpi	0,R3,0
	bnel	_PADCheckFail
	import 	_PAInit_VirtualWin_a
	bl	_PAInit_VirtualWin_a
	cmpi	0,R3,0
	bnel	_PADCheckFail

# Branch to translated program's MAIN entry point:
	bl       _68_StartUp

# Return to Operating System if we get here:
_PAQuit:
	lwz 	R1,0(R1)
	lmw	13,-4*(32-13)(R1)
	lwz 	R0,8(R1)
	lwz 	R12,4(R1)
	mtlr	R0
	mtcr 	R12
	blr

# Execute _DebugStr in the event of a -dcheck failure
_PADCheckFail:
	lwz	R3,T_PALiterals(RTOC)
	addi	R3,R3,_PAFailString-_PALiterals
	import	.DebugStr[PR]
	bl	.DebugStr[PR]
	nop
	b	_PAQuit

# Debugging information for -macsbug option
	align	2
	string  ASIS
._PAStart_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	._PAStart_PAEND - ._PAStart
	dc.w	8
	dc.b	'_PAStart'
	align	2

###################################################
# Glue for calling subroutines                    #
###################################################
	csect  	PCcsect[pr]
	export	_PACallGlue
_PACallGlue:
	mflr	RS
	addi	RS,RS,4
	stwu	RS,-4(a7)
# Save caller/callee addresses as debugging aid
	mfcr	RZ			# Save CR
	lwz	RY,-4(RS)		# Get call instruction opcode
	liu	RX,0x4e80
	ori	RX,RX,0x0421
	mfctr	RT			# Get CTR contents
	cmp	0,RY,RX			# Is call "bctlr" (0x4e800421)?
	beq	_PASaveValues
	rlwinm	RY,RY,6,0xffffff00  	# Must be "bl". Unpick opcode
	srawi	RY,RY,6			# to compute call target
	add	RT,RS,RY
	addi	RT,RT,-4
_PASaveValues:
	lwz     RX,T_PADebug(RTOC)
	stw     RS,_PAPokeLast(RX)	# Save last return address
	stw     RT,_PAPokeLast+4(RX)	# Save last call address
	lwz	RY,_PAPokeIdx(RX)	# Bump/wrap buffer index
	lwz	RV,_PAPokeSize(RX)
	addi    RY,RY,1
	cmp	0,RV,RY
	bne	_PANoWrap
	lil	RY,0
_PANoWrap:
	stw     RY,_PAPokeIdx(RX)
	rlwinm  RY,RY,3,0xfffffff8	# x 8 for offset
	add	RY,RY,RX
	stw     RS,_PAPokeBuf(RY)	# Save caller/callee in buffer
	stw     RT,_PAPokeBuf+4(RY)
	mtcr	RZ			# Restore CR
	blr

# Debugging information for -macsbug option
	align	2
	string  ASIS
_PACallGlue_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_PACallGlue_PAEND - _PACallGlue
	dc.w	11
	dc.b	'_PACallGlue'
	align	2

###################################################
# Module Initialisation Routine                   #
###################################################
	csect 	PCcsect[pr]
	export	_PAInit_PAExample_a
_PAInit_PAExample_a:
# Save application's A5 into TOC for callbacks:
	stw     a5,T_A5Value(RTOC)

# Dummy data load instruction prevents linker from removing unreferenced data
# csect during garbage collection
	lwz 	RS,T_PANoGC(RTOC)

# Check Data Offsets integrity
	lil	R3,-1
	lwz	R4,_PAMagic(a5)
	liu	R5,0x5041
	ori	R5,R5,(0)&0xffff
	cmp	0,R4,R5
	bne	_PABadMagic
	lil	R3,0
_PABadMagic:

	blr

########################################
# Shared glue wrappers coming from C   #
########################################
# Glue routine for normal callbacks
# (same as glue for asynchronous callbacks because "-opt cbstack" specified)
	csect	PCcsect[PR]
	export	_PASetupWorld

# Glue routine for asynchronous callbacks
	export	_PASetupWorldAsync
_PASetupWorldAsync:
_PASetupWorld:
	stw	R0,8(R1)
	mfcr	R12
	stw	R12,4(R1)
	stmw	R13,-4*(32-13)(R1)
# Get a 4K callback stack from the R1 stack frame
	addi	a7,R1,-(4*(32-12)+20)
	stwu	R1,-4096(R1)
# Set up registers used in translation
	lil	RZero,0
	lil	RByte,0x000000ff
	ori	RWord,RZero,0x0000ffff
	lwz	a5,T_A5Value(RTOC)
	blr

# Debugging information for -macsbug option
	align	2
	string  ASIS
_PASetupWorld_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_PASetupWorld_PAEND - _PASetupWorld
	dc.w	13
	dc.b	'_PASetupWorld'
	align	2

###############################
# Glue returning to C         #
###############################
	export	_PAReturnResultd0
_PAReturnResultd0:
	mr	R3,d0
	b	_PAReturnResult0
	export	_PAReturnResultd1
_PAReturnResultd1:
	mr	R3,d1
	b	_PAReturnResult0
	export	_PAReturnResultd2
_PAReturnResultd2:
	mr	R3,d2
	b	_PAReturnResult0
	export	_PAReturnResultd3
_PAReturnResultd3:
	mr	R3,d3
	b	_PAReturnResult0
	export	_PAReturnResultd4
_PAReturnResultd4:
	mr	R3,d4
	b	_PAReturnResult0
	export	_PAReturnResultd5
_PAReturnResultd5:
	mr	R3,d5
	b	_PAReturnResult0
	export	_PAReturnResultd6
_PAReturnResultd6:
	mr	R3,d6
	b	_PAReturnResult0
	export	_PAReturnResultd7
_PAReturnResultd7:
	mr	R3,d7
	b	_PAReturnResult0
	export	_PAReturnResulta0
_PAReturnResulta0:
	mr	R3,a0
	b	_PAReturnResult0
	export	_PAReturnResulta1
_PAReturnResulta1:
	mr	R3,a1
	b	_PAReturnResult0
	export	_PAReturnResulta2
_PAReturnResulta2:
	mr	R3,a2
	b	_PAReturnResult0
	export	_PAReturnResulta3
_PAReturnResulta3:
	mr	R3,a3
	b	_PAReturnResult0
	export	_PAReturnResulta4
_PAReturnResulta4:
	mr	R3,a4
	b	_PAReturnResult0
	export	_PAReturnResulta5
_PAReturnResulta5:
	mr	R3,a5
	b	_PAReturnResult0
	export	_PAReturnResulta6
_PAReturnResulta6:
	mr	R3,a6
	b	_PAReturnResult0
	export	_PAReturnResult1
_PAReturnResult1:
	lbz	R3,0(a7)
	b	_PAReturnResult0
	export	_PAReturnResult2
_PAReturnResult2:
	lhz	R3,0(a7)
	b	_PAReturnResult0
	export	_PAReturnResult4
_PAReturnResult4:
	lwz	R3,0(a7)
	export	_PAReturnResult0
_PAReturnResult0:
	lwz	R1,0(R1)
# Restore GPRs, etc
	lmw	R13,-4*(32-13)(R1)
	lwz	R0,8(R1)
	mtlr	R0
	lwz	R12,4(R1)
	mtcr	R12
	blr

# Debugging information for -macsbug option
	align	2
	string  ASIS
_PAReturnResult0_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_PAReturnResult0_PAEND - _PAReturnResult0
	dc.w	16
	dc.b	'_PAReturnResult0'
	align	2

#########################################################################
# Symbols from "-define" option                                         #
#########################################################################
_68_powerpc_version:     equ 1

#########################################################################
# Start of translated code                                              #
#########################################################################
_68___Resources__:    set   1
_68___MinimumTraps__:  set   1
_68___Traps__:        set   1
_68___MinimumTraps__:  set   0
_68_ApplLimit:        equ   0x130
_68_ApplZone:         equ   0x2AA
_68___MinimumSysEqu__:  set   0
_68___MinimumSysEqu__:  set   1
_68___OSUtils__:      set   1
_68___Types__:        set   1
_68___Errors__:       set   1
_68_paramErr:         equ   -(50)
_68_noHardwareErr:    equ   -(200)
_68_notEnoughHardwareErr:  equ   -(201)
_68_dsWDEFNotFound:   equ   87
_68_dsCDEFNotFound:   equ   88
_68_nil:              equ   0


###############################
# SysEnvRec                   #
###############################
;#SysEnvRec              record       0                [File "TestHD_0:MPW:Interfaces:AIncludes:OSUtils.a"; Line 135] 
_68_SysEnvRec:       equ 0
_68_SysEnvRec_environsVersion: equ 0
_68_SysEnvRec_machineType: equ 2
_68_SysEnvRec_systemVersion: equ 4
_68_SysEnvRec_processor: equ 6
_68_SysEnvRec_hasFPU: equ 8
_68_SysEnvRec_hasColorQD: equ 9
_68_SysEnvRec_keyBoardType: equ 10
_68_SysEnvRec_atDrvrVersNum: equ 12
_68_SysEnvRec_sysVRefNum: equ 14
_68_SysEnvRec_size:   equ   16
_68_SysEnvRec_sysEnv1Size:  equ   16-_68_SysEnvRec
;#                       endr                          [File "TestHD_0:MPW:Interfaces:AIncludes:OSUtils.a"; Line 147] 


_68___ToolUtils__:    set   1
_68___Events__:       set   1
_68_everyEvent:       equ   -(1)
_68___MinimumPPCToolBox__:  set   1
_68___PPCToolBox__:   set   1
;#                     xpppbheader                     [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 327]   (Macro)
;#                     xpppbheader                     [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 343]   (Macro)
;#                     xpppbheader                     [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 360]   (Macro)
;#                     xpppbheader                     [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 372]   (Macro)
;#                     xpppbheader                     [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 379]   (Macro)
;#                     xpppbheader                     [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 388]   (Macro)
;#                     mppatpheader                    [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 441]   (Macro)
;#                     mppatpheader                    [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 447]   (Macro)
;#                     mppatpheader                    [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 461]   (Macro)
;#                     mppatpheader                    [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 475]   (Macro)
;#                     mppatpheader                    [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 503]   (Macro)
;#                     mppatpheader                    [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 511]   (Macro)
;#                     mppatpheader                    [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 518]   (Macro)
;#                     mppatpheader                    [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 541]   (Macro)
;#                     mppatpheader                    [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 581]   (Macro)
;#                     moreatpheader                   [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 582]   (Macro)
;#                     mppatpheader                    [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 588]   (Macro)
;#                     moreatpheader                   [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 589]   (Macro)
;#                     mppatpheader                    [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 601]   (Macro)
;#                     moreatpheader                   [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 602]   (Macro)
;#                     mppatpheader                    [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 616]   (Macro)
;#                     moreatpheader                   [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 617]   (Macro)
;#                     mppatpheader                    [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 626]   (Macro)
;#                     moreatpheader                   [File "TestHD_0:MPW:Interfaces:AIncludes:AppleTalk.a"; Line 627]   (Macro)
;#                                  ppcheader          [File "TestHD_0:MPW:Interfaces:AIncludes:PPCToolBox.a"; Line 97]   (Macro)
_68___MinimumPPCToolBox__:  set   0
_68___Memory__:       set   1
_68_defaultPhysicalEntryCount:  equ   8
_68___Power__:        set   1
_68___Devices__:      set   1
_68___Desk__:         set   1
_68_wholeSystem:      equ   1
_68_unitEntries:      equ   64
_68_bgnSlotUnit:      equ   48
_68_VIA2:             equ   0x0CEC
_68_Line1111:         equ   0x2C
_68___Fonts__:        set   1
_68___Windows__:      set   1
_68___Quickdraw__:    set   1
_68_singleDevicesBit:  equ   0
_68_dontMatchSeedsBit:  equ   1
_68_allDevicesBit:    equ   2


###############################
# RGBColor                    #
###############################
;#RGBColor             record  6,DECREMENT             [File "TestHD_0:MPW:Interfaces:AIncludes:Quickdraw.a"; Line 245] 
_68_RGBColor:        equ 6
_68_RGBColor_size:    equ   6
_68_RGBColor_blue:   equ 4
_68_RGBColor_green:  equ 2
_68_RGBColor_red:    equ 0
;#                     endr                            [File "TestHD_0:MPW:Interfaces:AIncludes:Quickdraw.a"; Line 250] 


_68___Menus__:        set   1
_68___Controls__:     set   1
_68_popupMenuProc:    equ   1008
_68___TextEdit__:     set   1
_68___Dialogs__:      set   1
_68_wholeTools:       equ   1
_68_windowSize:       equ   0x9C
_68_teRecBack:        equ   0x42
_68___MinimumTraps__:  set   1
_68_verUS:            equ   0
_68_verThailand:      equ   54
;#                 align         2                     [File "TestHD_0:MPW:Interfaces:AIncludes:Slots.a"; Line 141] 
_68___MinimumGestaltEqu__:  set   0
_68___MinimumGestaltEqu__:  set   1
_68_stdQLength:       equ   128
_68_stateBlockSize:   equ   64
_68_leftOverBlockSize:  equ   32
_68___MinimumSound__:  set   0
_68___MinimumSound__:  set   1
_68___SoundInput__:   set   1
_68___MinimumNotification__:  set   0
_68___MinimumNotification__:  set   1
_68_pixPurgeBit:      equ   0
_68_noNewDeviceBit:   equ   1
_68_useTempMemBit:    equ   2
_68_keepLocalBit:     equ   3
_68_pixelsPurgeableBit:  equ   6
_68_pixelsLockedBit:  equ   7
_68_mapPixBit:        equ   16
_68_newDepthBit:      equ   17
_68_alignPixBit:      equ   18
_68_newRowBytesBit:   equ   19
_68_reallocPixBit:    equ   20
_68_clipPixBit:       equ   28
_68_stretchPixBit:    equ   29
_68_ditherPixBit:     equ   30
_68_gwFlagErrBit:     equ   31
_68___MinimumPictUtil__:  set   0
_68___MinimumPictUtil__:  set   1
_68_topLeft:          equ   0
_68_botRight:         equ   4
_68_bitmapRec:        equ   14
_68_cursRec:          equ   68
_68_portBits:         equ   0x2
_68_bkPat:            equ   0x20
_68_pnPat:            equ   0x3A
_68_thePort:          equ   0
_68_white:            equ   _68_thePort-8
_68_black:            equ   _68_white-8
_68_gray:             equ   _68_black-8
_68_ltGray:           equ   _68_gray-8
_68_dkGray:           equ   _68_ltGray-8
_68_arrow:            equ   _68_dkGray-68
_68_screenBits:       equ   _68_arrow-14
_68_randSeed:         equ   _68_screenBits-4
_68_wideOpen:         equ   _68_randSeed-4
_68_wideMaster:       equ   _68_wideOpen-4
_68_wideData:         equ   _68_wideMaster-10
_68_rgnBuf:           equ   _68_wideData-4
_68_rgnIndex:         equ   _68_rgnBuf-2
_68_rgnMax:           equ   _68_rgnIndex-2
_68_playPic:          equ   _68_rgnMax-4
_68_qdSpare0:         equ   _68_playPic-2
_68_thePoly:          equ   _68_qdSpare0-4
_68_polyMax:          equ   _68_thePoly-2
_68_patAlign:         equ   _68_polyMax-4
_68_fontAdj:          equ   _68_patAlign-4
_68_fontPtr:          equ   _68_fontAdj-4
_68_playIndex:        equ   _68_fontPtr-4
_68_pnLocFixed:       equ   _68_playIndex-2
_68_qdRunSlop:        equ   _68_pnLocFixed-4
_68_qdChExtra:        equ   _68_qdRunSlop-4
_68_fontData:         equ   _68_qdChExtra-12
_68_lastGrafGlob:     equ   _68_fontData
_68_grafSize:         equ   4-_68_lastGrafGlob
_68_pmRec:            equ   0x32
_68_portPixMap:       equ   _68_portBits
_68_portVersion:      equ   _68_portPixMap+4
_68_grafVars:         equ   _68_portVersion+2
_68_chExtra:          equ   _68_grafVars+4
_68_bkPixPat:         equ   _68_bkPat
_68_rgbFgColor:       equ   _68_bkPixPat+4
_68_pnPixPat:         equ   _68_pnPat
_68_crsrType:         equ   0
_68_crsrMap:          equ   _68_crsrType+2
_68_crsrData:         equ   _68_crsrMap+4
_68_crsrXData:        equ   _68_crsrData+4
_68_crsrXValid:       equ   _68_crsrXData+4
_68_crsrXHandle:      equ   _68_crsrXValid+2
_68_crsr1Data:        equ   _68_crsrXHandle+4
_68_crsrMask:         equ   _68_crsr1Data+32
_68_crsrHotSpot:      equ   _68_crsrMask+32
_68_crsrXTable:       equ   _68_crsrHotSpot+4
_68_crsrID:           equ   _68_crsrXTable+4
_68_iconPMap:         equ   0
_68_iconMask:         equ   _68_iconPMap+_68_pmRec
_68_iconBMap:         equ   _68_iconMask+_68_bitmapRec
_68_iconData:         equ   _68_iconBMap+_68_bitmapRec
_68_gVersion:         equ   0
_68_gType:            equ   _68_gVersion+2
_68_gFormulaSize:     equ   _68_gType+2
_68_gChanCnt:         equ   _68_gFormulaSize+2
_68_gDataCnt:         equ   _68_gChanCnt+2
_68_gDataWidth:       equ   _68_gDataCnt+2
_68_rgbOpColor:       equ   0
_68_rgbHiliteColor:   equ   _68_rgbOpColor+6
_68_pmFgColor:        equ   _68_rgbHiliteColor+6
_68_pmFgIndex:        equ   _68_pmFgColor+4
_68_pmBkColor:        equ   _68_pmFgIndex+2
_68_pmBkIndex:        equ   _68_pmBkColor+4
_68_pmFlags:          equ   _68_pmBkIndex+2
_68_ctSeed:           equ   0
_68_ctFlags:          equ   _68_ctSeed+4
_68_ctSize:           equ   _68_ctFlags+2
_68_ctTable:          equ   _68_ctSize+2
_68_EnvironsVersion:  equ   1
_68_MinHeap:          equ   21*1024
_68_MinSpace:         equ   8*1024
_68_rMenuBar:         equ   128
_68_rUserAlert:       equ   129
_68_rWindow:          equ   128
_68_AppleMenu:        equ   128
_68_YellowItem:       equ   2


###############################
# MyQDGlobals                 #
###############################
;#MyQDGlobals     record  0,DECREMENT                  [File "PAExample.inc"; Line 86] 
_68_MyQDGlobals:     equ 0
_68_MyQDGlobals_GrafPort: equ -4
_68_MyQDGlobals_White: equ -12
_68_MyQDGlobals_Black: equ -20
_68_MyQDGlobals_Gray: equ -28
_68_MyQDGlobals_LtGray: equ -36
_68_MyQDGlobals_DkGray: equ -44
_68_MyQDGlobals_Arrow: equ -112
_68_MyQDGlobals_ScreenBits: equ -126
_68_MyQDGlobals_ScreenBits_baseAddr: equ _68_MyQDGlobals_ScreenBits + 0
_68_MyQDGlobals_ScreenBits_rowBytes: equ _68_MyQDGlobals_ScreenBits + 4
_68_MyQDGlobals_ScreenBits_bounds: equ _68_MyQDGlobals_ScreenBits + 6
_68_MyQDGlobals_ScreenBits_bounds_top: equ _68_MyQDGlobals_ScreenBits_bounds + 0
_68_MyQDGlobals_ScreenBits_bounds_left: equ _68_MyQDGlobals_ScreenBits_bounds + 2
_68_MyQDGlobals_ScreenBits_bounds_bottom: equ _68_MyQDGlobals_ScreenBits_bounds + 4
_68_MyQDGlobals_ScreenBits_bounds_right: equ _68_MyQDGlobals_ScreenBits_bounds + 6
_68_MyQDGlobals_ScreenBits_bounds_topLeft: equ _68_MyQDGlobals_ScreenBits_bounds + 0
_68_MyQDGlobals_ScreenBits_bounds_topLeft_v: equ _68_MyQDGlobals_ScreenBits_bounds_topLeft + 0
_68_MyQDGlobals_ScreenBits_bounds_topLeft_h: equ _68_MyQDGlobals_ScreenBits_bounds_topLeft + 2
_68_MyQDGlobals_ScreenBits_bounds_topLeft_size: equ _68_MyQDGlobals_ScreenBits_bounds_topLeft + 4
_68_MyQDGlobals_ScreenBits_bounds_botRight: equ _68_MyQDGlobals_ScreenBits_bounds + 4
_68_MyQDGlobals_ScreenBits_bounds_botRight_v: equ _68_MyQDGlobals_ScreenBits_bounds_botRight + 0
_68_MyQDGlobals_ScreenBits_bounds_botRight_h: equ _68_MyQDGlobals_ScreenBits_bounds_botRight + 2
_68_MyQDGlobals_ScreenBits_bounds_botRight_size: equ _68_MyQDGlobals_ScreenBits_bounds_botRight + 4
_68_MyQDGlobals_ScreenBits_bounds_size: equ _68_MyQDGlobals_ScreenBits_bounds + 8
_68_MyQDGlobals_RandSeed: equ -130
;#                org     -GrafSize                    [File "PAExample.inc"; Line 96] 
;#                endr                                 [File "PAExample.inc"; Line 97] 




###############################
# AppGlobals                  #
###############################
;#AppGlobals      record  0                            [File "PAExample.inc"; Line 101] 
_68_AppGlobals:      equ 0
_68_AppGlobals_Color: equ 0
_68_AppGlobals_OldColor: equ 2
_68_AppGlobals_HasWNEvent: equ 4
_68_AppGlobals_InBackground: equ 6
_68_AppGlobals_WindowSize: equ 8
;#                org     WindowSize                   [File "PAExample.inc"; Line 107] 
_68_AppGlobals_Height: equ 8
_68_AppGlobals_Width: equ 10
_68_AppGlobals_Mac:  equ 12
_68_AppGlobals_Mac_environsVersion: equ _68_AppGlobals_Mac + 0
_68_AppGlobals_Mac_machineType: equ _68_AppGlobals_Mac + 2
_68_AppGlobals_Mac_systemVersion: equ _68_AppGlobals_Mac + 4
_68_AppGlobals_Mac_processor: equ _68_AppGlobals_Mac + 6
_68_AppGlobals_Mac_hasFPU: equ _68_AppGlobals_Mac + 8
_68_AppGlobals_Mac_hasColorQD: equ _68_AppGlobals_Mac + 9
_68_AppGlobals_Mac_keyBoardType: equ _68_AppGlobals_Mac + 10
_68_AppGlobals_Mac_atDrvrVersNum: equ _68_AppGlobals_Mac + 12
_68_AppGlobals_Mac_sysVRefNum: equ _68_AppGlobals_Mac + 14
_68_AppGlobals_Mac_size: equ _68_AppGlobals_Mac + 16
_68_AppGlobals_Mac_sysEnv1Size: equ _68_AppGlobals_Mac + 16
_68_AppGlobals_SoundMode: equ 28
;#                endr                                 [File "PAExample.inc"; Line 112] 


_68_MAX_POINTS:       equ   40
;#                export  (QD,G):DATA                  [Line 23]   
	csect	A5World[rw]
;# Equate to Label "QD" is defined in data offsets file
;# Burn a real label here for C and Pascal to use
	export	QD
QD:
	ds.b	206
_68_QD_GrafPort:     equ _68_QD + 206 + -4
_68_QD_White:        equ _68_QD + 206 + -12
_68_QD_Black:        equ _68_QD + 206 + -20
_68_QD_Gray:         equ _68_QD + 206 + -28
_68_QD_LtGray:       equ _68_QD + 206 + -36
_68_QD_DkGray:       equ _68_QD + 206 + -44
_68_QD_Arrow:        equ _68_QD + 206 + -112
_68_QD_ScreenBits:   equ _68_QD + 206 + -126
_68_QD_ScreenBits_baseAddr: equ _68_QD_ScreenBits + 0
_68_QD_ScreenBits_rowBytes: equ _68_QD_ScreenBits + 4
_68_QD_ScreenBits_bounds: equ _68_QD_ScreenBits + 6
_68_QD_ScreenBits_bounds_top: equ _68_QD_ScreenBits_bounds + 0
_68_QD_ScreenBits_bounds_left: equ _68_QD_ScreenBits_bounds + 2
_68_QD_ScreenBits_bounds_bottom: equ _68_QD_ScreenBits_bounds + 4
_68_QD_ScreenBits_bounds_right: equ _68_QD_ScreenBits_bounds + 6
_68_QD_ScreenBits_bounds_topLeft: equ _68_QD_ScreenBits_bounds + 0
_68_QD_ScreenBits_bounds_topLeft_v: equ _68_QD_ScreenBits_bounds_topLeft + 0
_68_QD_ScreenBits_bounds_topLeft_h: equ _68_QD_ScreenBits_bounds_topLeft + 2
_68_QD_ScreenBits_bounds_topLeft_size: equ _68_QD_ScreenBits_bounds_topLeft + 4
_68_QD_ScreenBits_bounds_botRight: equ _68_QD_ScreenBits_bounds + 4
_68_QD_ScreenBits_bounds_botRight_v: equ _68_QD_ScreenBits_bounds_botRight + 0
_68_QD_ScreenBits_bounds_botRight_h: equ _68_QD_ScreenBits_bounds_botRight + 2
_68_QD_ScreenBits_bounds_botRight_size: equ _68_QD_ScreenBits_bounds_botRight + 4
_68_QD_ScreenBits_bounds_size: equ _68_QD_ScreenBits_bounds + 8
_68_QD_RandSeed:     equ _68_QD + 206 + -130
;# Equate to Label "G" is defined in data offsets file
;# Burn a real label here for C and Pascal to use
	export	G
G:
	ds.b	29
_68_G_Color:         equ _68_G + 0
_68_G_OldColor:      equ _68_G + 2
_68_G_HasWNEvent:    equ _68_G + 4
_68_G_InBackground:  equ _68_G + 6
_68_G_WindowSize:    equ _68_G + 8
_68_G_Height:        equ _68_G + 8
_68_G_Width:         equ _68_G + 10
_68_G_Mac:           equ _68_G + 12
_68_G_Mac_environsVersion: equ _68_G_Mac + 0
_68_G_Mac_machineType: equ _68_G_Mac + 2
_68_G_Mac_systemVersion: equ _68_G_Mac + 4
_68_G_Mac_processor: equ _68_G_Mac + 6
_68_G_Mac_hasFPU:    equ _68_G_Mac + 8
_68_G_Mac_hasColorQD: equ _68_G_Mac + 9
_68_G_Mac_keyBoardType: equ _68_G_Mac + 10
_68_G_Mac_atDrvrVersNum: equ _68_G_Mac + 12
_68_G_Mac_sysVRefNum: equ _68_G_Mac + 14
_68_G_Mac_size:      equ _68_G_Mac + 16
_68_G_Mac_sysEnv1Size: equ _68_G_Mac + 16
_68_G_SoundMode:     equ _68_G + 28


###############################
# AlertUser                   #
###############################
;#AlertUser       proc    EXPORT                       [Line 34]   
	csect	PCcsect[pr]
	align	2
	export	_68_AlertUser
	export	AlertUser__
AlertUser__:
	function	AlertUser__,AlertUser__,16,044
	beginf	34
	nop
	dc.l	0
	dc.l	0
_68_AlertUser:
	line	3
;#  clr.w       -(SP)                                  [** Line 36]
	# Glue Optimisation - Don't need result space
	line	4
;#  move.w      #rUserAlert,-(SP)                      [** Line 37]
	lil     R3,_68_rUserAlert
	line	5
;#  clr.l       -(SP)                                  [** Line 38]
	lil     R4,0
	line	6
;#  _alert                                             [** Line 39]
	import	.Alert[PR]
	bl	.Alert[PR]
	nop
	line	7
;#  move.w      (SP)+,D0                               [** Line 40]
	mr      d0,R3
	line	8
;#  _exittoshell                                       [Line 41]  
	import	.ExitToShell[PR]
	bl	.ExitToShell[PR]
	nop
	line	10
_68_AlertUser_Exit:
;#  rts                                                [Line 43]  
	lwz     RX,0(a7)
	mtlr    RX
	addic   a7,a7,4
	blr     
;#                endp                                 [Line 45]   

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_AlertUser_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_AlertUser_PAEND - _68_AlertUser
	dc.w	9
	dc.b	'AlertUser'
	align	2
	align	2
	endf	45


###############################
# Terminate                   #
###############################
;#Terminate       proc    EXPORT                       [Line 54]   
	csect	PCcsect[pr]
	align	2
	export	_68_Terminate
	export	Terminate__
Terminate__:
	function	Terminate__,Terminate__,16,044
	beginf	54
	nop
	dc.l	0
	dc.l	0
_68_Terminate:

;#StackFrame      record  {A6Link},DECR                [Line 56]   
_68_Terminate_StackFrame: equ 8
_68_Terminate_StackFrame_RetAddr: equ 4
_68_Terminate_StackFrame_A6Link: equ 0
_68_Terminate_StackFrame_WindowPtr: equ -4
_68_Terminate_StackFrame_LocalSize:  equ   -4
;#                endr                                 [Line 61]   


;#                with    StackFrame                   [Line 64]   
	line	12
;#  link        A6,#LocalSize                          [Line 65]  
	stwu    a6,-4(a7)
	mr      a6,a7
	addic   a7,a7,_68_Terminate_StackFrame_LocalSize
	line	15
_68_Terminate_Loop:
;#  clr.l       -(SP)                                  [** Line 68]
	# Glue Optimisation - Don't need result space
	line	16
;#  _frontwindow                                       [** Line 69]
	import	.FrontWindow[PR]
	bl	.FrontWindow[PR]
	nop
	line	17
;#  move.l      (SP)+,WindowPtr(A6)                    [** Line 70]
	stw     R3,_68_Terminate_StackFrame_WindowPtr(a6)
	line	18
;#  cmpi.l      #NIL,WindowPtr(A6)          EQ         [Line 71]  
	lwz     RU,_68_Terminate_StackFrame_WindowPtr(a6)
	cmpi    0,RU,_68_nil
	line	19
;#  beq.s       @1                                     [Line 72]  
	beq     _at_1_9266
	line	21
;#  move.l      WindowPtr(A6),-(SP)                    [** Line 74]
	lwz     R3,_68_Terminate_StackFrame_WindowPtr(a6)
	line	22
;#  _closewindow                                       [** Line 75]
	import	.CloseWindow[PR]
	bl	.CloseWindow[PR]
	nop
	line	23
;#  bra         Loop                                   [Line 76]  
	b       _68_Terminate_Loop
	line	25
_at_1_9266:
;#  _exittoshell                                       [Line 78]  
	import	.ExitToShell[PR]
	bl	.ExitToShell[PR]
	nop
	line	27
_68_Terminate_Exit:
;#  unlk        A6                                     [Line 80]  
	addic   a7,a6,4
	lwz     a6,0(a6)
	line	28
;#  rts                                                [Line 81]  
	lwz     RX,0(a7)
	mtlr    RX
	addic   a7,a7,4
	blr     
;#                endp                                 [Line 83]   

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_Terminate_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_Terminate_PAEND - _68_Terminate
	dc.w	9
	dc.b	'Terminate'
	align	2
	align	2
	endf	83


###############################
# Initialize                  #
###############################
;#Initialize      proc                                 [Line 91]   
	csect	PCcsect[pr]
	align	2
	export	Initialize__
Initialize__:
	function	Initialize__,Initialize__,16,044
	beginf	91
	nop
	dc.l	0
	dc.l	0
_68_Initialize:

;#StackFrame      record  {A6Link},DECR                [Line 95]   
_68_Initialize_StackFrame: equ 8
_68_Initialize_StackFrame_RetAddr: equ 4
_68_Initialize_StackFrame_A6Link: equ 0
_68_Initialize_StackFrame_CurMBar: equ -4
_68_Initialize_StackFrame_TheEvent: equ -20
_68_Initialize_StackFrame_TheEvent_what: equ _68_Initialize_StackFrame_TheEvent + 0
_68_Initialize_StackFrame_TheEvent_message: equ _68_Initialize_StackFrame_TheEvent + 2
_68_Initialize_StackFrame_TheEvent_when: equ _68_Initialize_StackFrame_TheEvent + 6
_68_Initialize_StackFrame_TheEvent_where: equ _68_Initialize_StackFrame_TheEvent + 10
_68_Initialize_StackFrame_TheEvent_where_v: equ _68_Initialize_StackFrame_TheEvent_where + 0
_68_Initialize_StackFrame_TheEvent_where_h: equ _68_Initialize_StackFrame_TheEvent_where + 2
_68_Initialize_StackFrame_TheEvent_where_size: equ _68_Initialize_StackFrame_TheEvent_where + 4
_68_Initialize_StackFrame_TheEvent_modifiers: equ _68_Initialize_StackFrame_TheEvent + 14
_68_Initialize_StackFrame_TheEvent_size: equ _68_Initialize_StackFrame_TheEvent + 16
_68_Initialize_StackFrame_LocalSize:  equ   -20
;#                endr                                 [Line 101]  


	import	.SysEnvirons[PR]
	import	_68_SoundInit
;#                with    StackFrame                   [Line 106]  
	line	17
;#  link        A6,#LocalSize                          [Line 107] 
	stwu    a6,-4(a7)
	mr      a6,a7
	addic   a7,a7,_68_Initialize_StackFrame_LocalSize
	line	19
;#  move.l      D4,-(SP)                               [Line 109] 
	stwu    d4,-4(a7)
	line	21
;#  move.l      #YellowItem,G.OldColor                 [Line 111] 
	lil     RV,_68_YellowItem
	stw     RV,_68_G_OldColor(a5)
	line	25
_at_1_9286:
;#  pea         QD.GrafPort                            [Line 115] 
	addi    RV,a5,_68_QD_GrafPort
	stwu    RV,-4(a7)
	line	26
;#  _initgraf                                          [Line 116] 
	lwz	R3,0(a7)
	stw	R3,0(a5)
	import	.InitGraf[PR]
	bl	.InitGraf[PR]
	cror	15,15,15
	addi	a7,a7,4
	line	27
;#  _initfonts                                         [Line 117] 
	import	.InitFonts[PR]
	bl	.InitFonts[PR]
	nop
	line	28
;#  _initwindows                                       [Line 118] 
	import	.InitWindows[PR]
	bl	.InitWindows[PR]
	nop
	line	29
;#  _initmenus                                         [Line 119] 
	import	.InitMenus[PR]
	bl	.InitMenus[PR]
	nop
	line	30
;#  _teinit                                            [Line 120] 
	import	.TEInit[PR]
	bl	.TEInit[PR]
	nop
	line	31
;#  clr.l       -(SP)                                  [** Line 121]
	lil     R3,0
	line	32
;#  _initdialogs                                       [** Line 122]
	import	.InitDialogs[PR]
	bl	.InitDialogs[PR]
	nop
	line	33
;#  _initcursor                                        [Line 123] 
	import	.InitCursor[PR]
	bl	.InitCursor[PR]
	nop
	line	37
;#  move.w      #2,D4                                  [Line 127] 
	lil     d4,2
	line	38
_68_Initialize_Loop:
;#  clr.w       -(SP)                                  [** Line 128]
	# Glue Optimisation - Don't need result space
	line	39
;#  move.w      #EveryEvent,-(SP)                      [** Line 129]
	lil     R3,_68_everyEvent
	line	40
;#  pea         TheEvent(A6)                           [** Line 130]
	addi    R4,a6,_68_Initialize_StackFrame_TheEvent
	line	41
;#  _eventavail                                        [** Line 131]
	import	.EventAvail[PR]
	bl	.EventAvail[PR]
	nop
	line	42
;#  move.w      (SP)+,D0                               [** Line 132]
	mr      d0,R3
	line	43
;#  dbf         D4,Loop                                [Line 133] 
	extsh   RX,d4
	subic   RX,RX,1
	cmpi    7,RX,-1
	rlwimi  d4,RX,0,0x0000ffff
	bne     7,_68_Initialize_Loop
	line	47
;#  move.w      #EnvironsVersion,D0                    [** Line 137]
	lil     R3,_68_EnvironsVersion
	line	48
;#  lea         G.Mac,A0                               [Line 138] 
	addi    a0,a5,_68_G_Mac
	line	49
;#  jsr         SYSENVIRONS                            [** Line 139]
	mr	R4,a0
	import	.SysEnvirons[PR]
	bl	.SysEnvirons[PR]
	nop
	mr	d0,R3
	line	51
;#  move.w      G.Mac.MachineType,D0        PL         [Line 141] 
	lha     d0,_68_G_Mac_machineType(a5)
	extsh.  RX,d0
	line	52
;#  bpl.s       @2                                     [Line 142] 
	bge     _at_2_9308
	line	53
;#  jmp         AlertUser                              [Line 143] 
	b       _68_AlertUser
	line	57
_at_2_9308:
;#  move.l      applLimit,D1                           [Line 147] 
	lwz     d1,_68_ApplLimit(0)
	line	58
;#  move.l      applZone,D0                            [Line 148] 
	lwz     d0,_68_ApplZone(0)
	line	59
;#  sub.l       D0,D1                                  [Line 149] 
	subfc   d1,d0,d1
	line	60
;#  cmpi.l      #MinHeap,D1                 PL         [Line 150] 
	subic.  RX,d1,_68_MinHeap
	line	61
;#  bpl.s       @3                                     [Line 151] 
	bge     _at_3_9314
	line	62
;#  jmp         AlertUser                              [Line 152] 
	b       _68_AlertUser
	line	64
_at_3_9314:
;#  _purgespace                                        [Line 154] 
	addi	a7,a7,-8
	addi	R3,a7,0
	addi	R4,a7,4
	import	.PurgeSpace[PR]
	bl	.PurgeSpace[PR]
	cror	15,15,15
	lwz	a0,0(a7)
	lwz	d0,4(a7)
	addi	a7,a7,8
	line	65
;#  cmpi.l      #MinSpace,D0                PL         [Line 155] 
	subic.  RX,d0,_68_MinSpace
	line	66
;#  bpl.s       @4                                     [Line 156] 
	bge     _at_4_9318
	line	67
;#  jmp         AlertUser                              [Line 157] 
	b       _68_AlertUser
	line	71
_at_4_9318:
;#  move.l      #windowSize,D0                         [** Line 161]
	lil     R3,_68_windowSize
	line	72
;#  _newptr     ,Clear                                 [** Line 162]
	import	.NewPtrClear[PR]
	bl	.NewPtrClear[PR]
	nop
	mr	a0,R3
	lhz	d0,0x0220(R0)
	line	73
;#  cmpa.l      #NIL,A0                     NE         [Line 163] 
	cmpi    0,a0,_68_nil
	line	74
;#  bne.s       @5                                     [Line 164] 
	bne     _at_5_9324
	line	75
;#  jmp         AlertUser                              [Line 165] 
	b       _68_AlertUser
# Value of _68_RealWindow set from include file
	line	79
_at_5_9324:
;#  clr.l       -(SP)                                  [** Line 169]
	# Glue Optimisation - Don't need result space
	line	80
;#  move.w      #rWindow,-(SP)                         [** Line 170]
	lil     R3,_68_rWindow
	line	81
;#  move.l      A0,-(SP)                               [** Line 171]
	mr      R4,a0
	line	82
;#  move.l      #-1,-(SP)                              [** Line 172]
	lil     R5,(-(1))
	line	83
;#  _getnewwindow                                      [** Line 173]
	import	.GetNewWindow[PR]
	bl	.GetNewWindow[PR]
	nop
	line	84
;#  move.l      (SP)+,RealWindow                       [** Line 174]
	stw     R3,_68_RealWindow(a5)
	line	88
;#  clr.l       -(SP)                                  [** Line 178]
	# Glue Optimisation - Don't need result space
	line	89
;#  move.l      #'WIND',-(SP)                          [** Line 179]
	liu     R3,(0x57494e44>>16)&0xffff
	ori     R3,R3,(0x57494e44)&0xffff
	line	90
;#  move.w      #rWindow,-(SP)                         [** Line 180]
	lil     R4,_68_rWindow
	line	91
;#  _getresource                                       [** Line 181]
	import	.GetResource[PR]
	bl	.GetResource[PR]
	nop
	line	92
;#  movea.l     (SP)+,A0                               [** Line 182]
	mr      a0,R3
	line	93
;#  cmpa.l      #NIL,A0                     NE         [Line 183] 
	cmpi    0,a0,_68_nil
	line	94
;#  bne.s       @6                                     [Line 184] 
	bne     _at_6_9338
	line	95
;#  jmp         AlertUser                              [Line 185] 
	b       _68_AlertUser
	line	97
_at_6_9338:
;#  movea.l     (A0),A0                                [Line 187] 
	lwz     a0,0(a0)
	line	98
;#  move.l      botRight(A0),D0                        [Line 188] 
	lwz     d0,_68_botRight(a0)
	line	99
;#  sub.l       topLeft(A0),D0                         [Line 189] 
	lwz     RV,_68_topLeft(a0)
	subfc   d0,RV,d0
	line	100
;#  move.l      D0,G.WindowSize                        [Line 190] 
	stw     d0,_68_G_WindowSize(a5)
	line	104
;#  clr.l       -(SP)                                  [Line 194] 
	stwu    RZero,-4(a7)
	line	105
;#  move.w      #rMenuBar,-(SP)                        [** Line 195]
	lil     R3,_68_rMenuBar
	line	106
;#  _getnewmbar                                        [** Line 196]
	import	.GetNewMBar[PR]
	bl	.GetNewMBar[PR]
	nop
	stwu	R3,0(a7)
	line	107
;#  move.l      (SP),CurMBar(A6)                       [Line 197] 
	lwz     RV,0(a7)
	stw     RV,_68_Initialize_StackFrame_CurMBar(a6)
	line	108
;#  _setmenubar                                        [Line 198] 
	lwz	R3,0(a7)
	import	.SetMenuBar[PR]
	bl	.SetMenuBar[PR]
	nop
	addi	a7,a7,4
	line	109
;#  movea.l     CurMBar(A6),A0                         [** Line 199]
	lwz     R3,_68_Initialize_StackFrame_CurMBar(a6)
	line	110
;#  _disposhandle                                      [** Line 200]
	import	.DisposeHandle[PR]
	bl	.DisposeHandle[PR]
	nop
	line	111
;#  clr.l       -(SP)                                  [Line 201] 
	stwu    RZero,-4(a7)
	line	112
;#  move.w      #AppleMenu,-(SP)                       [** Line 202]
	lil     R3,_68_AppleMenu
	line	113
;#  _getmhandle                                        [** Line 203]
	import	.GetMenuHandle[PR]
	bl	.GetMenuHandle[PR]
	nop
	stwu	R3,0(a7)
	line	114
;#  move.l      #'DRVR',-(SP)                          [Line 204] 
	liu     RV,(0x44525652>>16)&0xffff
	ori     RV,RV,(0x44525652)&0xffff
	stwu    RV,-4(a7)
	line	115
;#  _addresmenu                                        [Line 205] 
	lwz	R4,0(a7)
	lwz	R3,4(a7)
	import	.AppendResMenu[PR]
	bl	.AppendResMenu[PR]
	nop
	addi	a7,a7,8
	line	116
;#  _drawmenubar                                       [Line 206] 
	import	.DrawMenuBar[PR]
	bl	.DrawMenuBar[PR]
	nop
	import	_68_AboutInit
	line	120
;#  bsr         AboutInit                              [Line 210] 
	bl      _PACallGlue
	bl      _68_AboutInit
	line	124
;#  bsr         SoundInit                              [Line 214] 
	bl      _PACallGlue
	bl      _68_SoundInit
	line	126
_68_Initialize_Exit:
;#  move.l      (SP)+,D4                               [Line 216] 
	lwz     d4,0(a7)
	addi    a7,a7,4
	line	127
;#  unlk        A6                                     [Line 217] 
	addic   a7,a6,4
	lwz     a6,0(a6)
	line	128
;#  rts                                                [Line 218] 
	lwz     RX,0(a7)
	mtlr    RX
	addic   a7,a7,4
	blr     
;#                endp                                 [Line 220]  

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_Initialize_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_Initialize_PAEND - _68_Initialize
	dc.w	10
	dc.b	'Initialize'
	align	2
	align	2
	endf	220


###############################
# StartUp                     #
###############################
;#StartUp         main                                 [Line 232]  
	csect	PCcsect[pr]
	align	2
	export	_68_StartUp
	export	StartUp__
StartUp__:
	function	StartUp__,StartUp__,16,044
	beginf	232
	nop
	dc.l	0
	dc.l	0
_68_StartUp:
	import	_68_EventLoop
	import	_68_InitVirtualWin
# Value of _68_ThePolygon set from include file
	import	.CreateOnePolygon[PR]
	line	15
;#  _maxapplzone                                       [Line 246] 
	import	.MaxApplZone[PR]
	bl	.MaxApplZone[PR]
	nop
	lhz	d0,0x0220(R0)
	line	16
;#  jsr         Initialize                             [Line 247] 
	bl      _PACallGlue
	bl      _68_Initialize
	line	17
;#  pea         Initialize                             [Line 248] 
	lwz     RV,T__68_Initialize(RTOC)
	stwu    RV,-4(a7)
	line	18
;#  _unloadseg                                         [Line 249] 
	;# _UnloadSeg not required - deallocate stack
	addi	a7,a7,4
	line	23
;#  move.l      #5,-(SP)                               [** Line 254]
	lil     R4,5
	line	24
;#  move.l      #0,-(SP)                               [** Line 255]
	lil     R3,0
	line	25
;#  jsr         CreateOnePolygon                       [** Line 256]
	import	.CreateOnePolygon[PR]
	bl	.CreateOnePolygon[PR]
	nop
	mr	d0,R3
	line	26
;#  move.l      D0,ThePolygon                          [Line 257] 
	stw     d0,_68_ThePolygon(a5)
	line	27
;#  lea         8(SP),SP                               [** Line 258]
	;# Glue optimisation - instruction not required
	line	30
;#  bsr         InitVirtualWin                         [Line 261] 
	bl      _PACallGlue
	bl      _68_InitVirtualWin
	line	33
;#  jmp         EventLoop                              [Line 264] 
	b       _68_EventLoop
;#                endp                                 [Line 265]  

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_StartUp_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_StartUp_PAEND - _68_StartUp
	dc.w	7
	dc.b	'StartUp'
	align	2
	align	2
	endf	265


###################################################
# String literals for pea/lea                     #
###################################################
	toc
T_PALiterals: tc _PALiterals,_PALiterals
	csect	PCcsect[pr]
_PALiterals:
_PAFailString:
	string	PString
	dc.b	'PortAsm -dcheck option detects data offsets problem'
	string	ASIS


###################################################
# TOC Entries for Translated Code                 #
###################################################
	toc
T_A5Value:	tc	A5Value,0
T_PANoGC:	tc	_PANoGC,_PANoGC
T__68_Initialize:	tc	_68_Initialize,_68_Initialize

