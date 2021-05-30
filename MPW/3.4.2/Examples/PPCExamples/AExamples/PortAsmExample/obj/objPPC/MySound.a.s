	file	'MySound.a'

#########################################################################
#                                                                       #
#       "MySound.a.s" - Translated from file "MySound.a"                #
#                                                                       #
#-----------------------------------------------------------------------#
#                                                                       #
#       PortAsm Code Translator Copyright (c) MicroAPL 1990-1994        #
#                   All Rights Reserved Worldwide                       #
#                                                                       #
#########################################################################
# Translated on Thu Jun 30 16:50:01 1994 by version 1.2.2 of PortAsm translator
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
#          -o ::obj:objPPC:MySound.a.s
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


ModA5	equ	BaseOf_MySound_a

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
# Code required by glue                           #
###################################################
# Linkage to call glue :
	import	_PACallGlue
	csect	A5World[RW]
_PANoGC:
# Magic value for data offsets integrity check
_PAMagic:	equ	* + ModA5
	dc.b	'PA'
	dc.w 	4


###################################################
# Module Initialisation Routine                   #
###################################################
	csect 	PCcsect[pr]
	export	_PAInit_MySound_a
_PAInit_MySound_a:
# Save application's A5 into TOC for callbacks:
	stw     a5,T_A5Value(RTOC)

# Dummy data load instruction prevents linker from removing unreferenced data
# csect during garbage collection
	lwz 	RS,T_PANoGC(RTOC)

# Check Data Offsets integrity
	lil	R3,-1
	lwz	R4,_PAMagic(a5)
	liu	R5,0x5041
	ori	R5,R5,(4)&0xffff
	cmp	0,R4,R5
	bne	_PABadMagic
	lil	R3,0
_PABadMagic:

	blr

#########################################################################
# Symbols from "-define" option                                         #
#########################################################################
_68_powerpc_version:     equ 1

#########################################################################
# Start of translated code                                              #
#########################################################################
_68___Traps__:        set   1
_68___MinimumTraps__:  set   0
_68___MinimumTraps__:  set   1
_68___Quickdraw__:    set   1
_68___Types__:        set   1
_68___Errors__:       set   1
_68_paramErr:         equ   -(50)
_68_noHardwareErr:    equ   -(200)
_68_notEnoughHardwareErr:  equ   -(201)
_68_dsWDEFNotFound:   equ   87
_68_dsCDEFNotFound:   equ   88
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


_68___Windows__:      set   1
_68_popupMenuProc:    equ   1008
_68___OSUtils__:      set   1
_68_verUS:            equ   0
_68_verThailand:      equ   54
_68_defaultPhysicalEntryCount:  equ   8
;#                 align         2                     [File "TestHD_0:MPW:Interfaces:AIncludes:Slots.a"; Line 141] 
_68___MinimumGestaltEqu__:  set   0
_68___MinimumGestaltEqu__:  set   1
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
_68___MinimumPPCToolbox__:  set   0
_68___MinimumPPCToolbox__:  set   1
_68___Sound__:        set   1
_68_sampledSynth:     equ   5
_68_freqDurationCmd:  equ   40
_68_soundCmd:         equ   80
_68_stdQLength:       equ   128
_68_initMono:         equ   0x0080
_68_stateBlockSize:   equ   64
_68_leftOverBlockSize:  equ   32


###############################
# SndCommand                  #
###############################
;#SndCommand              record         0             [File "TestHD_0:MPW:Interfaces:AIncludes:Sound.a"; Line 207] 
_68_SndCommand:      equ 0
_68_SndCommand_cmd:  equ 0
_68_SndCommand_param1: equ 2
_68_SndCommand_param2: equ 4
_68_SndCommand_size:  equ   8
_68_SndCommand_sndCSize:  equ   _68_SndCommand_size
;#                        endr                         [File "TestHD_0:MPW:Interfaces:AIncludes:Sound.a"; Line 213] 




###############################
# SndChannel                  #
###############################
;#SndChannel              record         0             [File "TestHD_0:MPW:Interfaces:AIncludes:Sound.a"; Line 218] 
_68_SndChannel:      equ 0
_68_SndChannel_nextChan: equ 0
_68_SndChannel_firstMod: equ 4
_68_SndChannel_callBack: equ 8
_68_SndChannel_userInfo: equ 12
_68_SndChannel_wait: equ 16
_68_SndChannel_cmdInProgress: equ 20
_68_SndChannel_cmdInProgress_cmd: equ _68_SndChannel_cmdInProgress + 0
_68_SndChannel_cmdInProgress_param1: equ _68_SndChannel_cmdInProgress + 2
_68_SndChannel_cmdInProgress_param2: equ _68_SndChannel_cmdInProgress + 4
_68_SndChannel_cmdInProgress_size: equ _68_SndChannel_cmdInProgress + 8
_68_SndChannel_cmdInProgress_sndCSize: equ _68_SndChannel_cmdInProgress + 8
_68_SndChannel_flags: equ 28
_68_SndChannel_qLength: equ 30
_68_SndChannel_qHead: equ 32
_68_SndChannel_qTail: equ 34
_68_SndChannel_queue: equ 36
_68_SndChannel_size:  equ   1060
_68_SndChannel_sndChSize:  equ   _68_SndChannel_size
;#                        endr                         [File "TestHD_0:MPW:Interfaces:AIncludes:Sound.a"; Line 232] 


_68___MinimumSound__:  set   0
_68___MinimumSound__:  set   1
_68___IncludingSound__:  set   1
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
_68_SoundRez:         equ   -(1)


###############################
# SoundInit                   #
###############################
;#SoundInit       proc    Export                       [Line 27]   
	csect	PCcsect[pr]
	align	2
	export	_68_SoundInit
	export	SoundInit__
SoundInit__:
	function	SoundInit__,SoundInit__,16,044
	beginf	27
	nop
	dc.l	0
	dc.l	0
_68_SoundInit:
;#                data                                 [Line 29]   
	csect	A5World[rw]
_68_SoundInit_SoundHandle:	equ	* + ModA5
	ds.l	2
_68_SoundChannel:	equ	* + ModA5
	ds.l	1
;#                code                                 [Line 34]   
	csect	PCcsect[pr]
;#                with    SndChannel                   [Line 35]   
	line	13
;#  clr.l       -(SP)                                  [Line 39]  
	stwu    RZero,-4(a7)
	line	14
;#  move.l      #'snd ',-(SP)                          [** Line 40]
	liu     R3,(0x736e6420>>16)&0xffff
	ori     R3,R3,(0x736e6420)&0xffff
	line	15
;#  move.w      #SoundRez,-(SP)                        [** Line 41]
	lil     R4,_68_SoundRez
	line	16
;#  _getresource                                       [** Line 42]
	import	.GetResource[PR]
	bl	.GetResource[PR]
	nop
	stwu	R3,0(a7)
	line	17
;#  move.l      (SP),SoundHandle                       [Line 43]  
	lwz     RV,0(a7)
	stw     RV,_68_SoundInit_SoundHandle(a5)
	line	18
;#  _loadresource                                      [Line 44]  
	lwz	R3,0(a7)
	import	.LoadResource[PR]
	bl	.LoadResource[PR]
	nop
	addi	a7,a7,4
	line	25
;#  clr.l       -(SP)                                  [Line 51]  
	stwu    RZero,-4(a7)
	line	26
;#  pea         SoundChannel                           [** Line 52]
	addi    R3,a5,_68_SoundChannel
	line	27
;#  move.w      #sampledSynth,-(SP)                    [** Line 53]
	lil     R4,_68_sampledSynth
	line	28
;#  move.l      #initMono,-(SP)                        [** Line 54]
	lil     R5,_68_initMono
	line	29
;#  clr.l       -(SP)                                  [** Line 55]
	lil     R6,0
	line	30
;#  _sndnewchannel                                     [** Line 56]
	import	.SndNewChannel[PR]
	bl	.SndNewChannel[PR]
	nop
	sthu	R3,0(a7)
	line	31
;#  lea         4(SP),SP                               [Line 57]  
	addi    a7,a7,4
	line	35
;#  move.l      SoundHandle,A0                         [Line 61]  
	lwz     a0,_68_SoundInit_SoundHandle(a5)
	line	36
;#  move.l      (A0),A1                                [Line 62]  
	lwz     a1,0(a0)
	line	37
;#  lea         $0C(A1),A0                             [Line 63]  
	addi    a0,a1,0x0C
	line	38
;#  move.w      #soundCmd,SndCommand.cmd(A0)           [Line 64]  
	lil     RV,_68_soundCmd
	sth     RV,_68_SndCommand_cmd(a0)
	line	39
;#  move.w      #0,SndCommand.param1(A0)               [Line 65]  
	sth     RZero,_68_SndCommand_param1(a0)
	line	40
;#  lea         $14(A1),A1                             [Line 66]  
	addi    a1,a1,0x14
	line	41
;#  move.l      A1,SndCommand.param2(A0)               [Line 67]  
	stw     a1,_68_SndCommand_param2(a0)
	line	42
;#  clr.l       -(SP)                                  [Line 68]  
	stwu    RZero,-4(a7)
	line	43
;#  move.l      SoundChannel,-(SP)                     [** Line 69]
	lwz     R3,_68_SoundChannel(a5)
	line	44
;#  move.l      A0,-(SP)                               [** Line 70]
	mr      R4,a0
	line	45
;#  _snddoimmediate                                    [** Line 71]
	import	.SndDoImmediate[PR]
	bl	.SndDoImmediate[PR]
	nop
	sthu	R3,0(a7)
	line	46
;#  lea         4(SP),SP                               [Line 72]  
	addi    a7,a7,4
	line	48
;#  rts                                                [Line 74]  
	lwz     RX,0(a7)
	mtlr    RX
	addic   a7,a7,4
	blr     
;#                endp                                 [Line 76]   

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_SoundInit_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_SoundInit_PAEND - _68_SoundInit
	dc.w	9
	dc.b	'SoundInit'
	align	2
	align	2
	endf	76


###############################
# SoundPlay                   #
###############################
;#SoundPlay       proc    Export                       [Line 87]   
	csect	PCcsect[pr]
	align	2
	export	_68_SoundPlay
	export	SoundPlay__
SoundPlay__:
	function	SoundPlay__,SoundPlay__,16,044
	beginf	87
	nop
	dc.l	0
	dc.l	0
_68_SoundPlay:
;#                data                                 [Line 88]   
	csect	A5World[rw]
_68_SoundPlay_mycommand:	equ	* + ModA5
	ds.b	8
_68_SoundPlay_mycommand_cmd: equ _68_SoundPlay_mycommand + 0
_68_SoundPlay_mycommand_param1: equ _68_SoundPlay_mycommand + 2
_68_SoundPlay_mycommand_param2: equ _68_SoundPlay_mycommand + 4
_68_SoundPlay_mycommand_size: equ _68_SoundPlay_mycommand + 8
_68_SoundPlay_mycommand_sndCSize: equ _68_SoundPlay_mycommand + 8
;#                code                                 [Line 91]   
	csect	PCcsect[pr]
;#                with    SndCommand                   [Line 92]   
	line	7
;#  move.l      SoundChannel,A0                        [Line 93]  
	lwz     a0,_68_SoundChannel(a5)
	line	9
;#  lea         mycommand,A1                           [Line 95]  
	addi    a1,a5,_68_SoundPlay_mycommand
	line	10
;#  move.w      #freqDurationCmd,cmd(A1)               [Line 96]  
	lil     RV,_68_freqDurationCmd
	sth     RV,_68_SndCommand_cmd(a1)
	line	11
;#  move.w      #100,param1(A1)                        [Line 97]  
	lil     RV,100
	sth     RV,_68_SndCommand_param1(a1)
	line	12
;#  move.l      D0,param2(A1)                          [Line 98]  
	stw     d0,_68_SndCommand_param2(a1)
	line	14
;#  clr.l       -(SP)                                  [Line 100] 
	stwu    RZero,-4(a7)
	line	15
;#  move.l      A0,-(SP)                               [** Line 101]
	mr      R3,a0
	line	16
;#  move.l      A1,-(SP)                               [** Line 102]
	mr      R4,a1
	line	17
;#  _snddoimmediate                                    [** Line 103]
	import	.SndDoImmediate[PR]
	bl	.SndDoImmediate[PR]
	nop
	sthu	R3,0(a7)
	line	18
;#  lea         4(SP),SP                               [Line 104] 
	addi    a7,a7,4
	line	20
;#  rts                                                [Line 106] 
	lwz     RX,0(a7)
	mtlr    RX
	addic   a7,a7,4
	blr     
;#                endp                                 [Line 108]  

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_SoundPlay_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_SoundPlay_PAEND - _68_SoundPlay
	dc.w	9
	dc.b	'SoundPlay'
	align	2
	align	2
	endf	108


###################################################
# TOC Entries for Translated Code                 #
###################################################
	toc
T_A5Value:	tc	A5Value,0
T_PANoGC:	tc	_PANoGC,_PANoGC

