	file	'AboutDlg.a'

#########################################################################
#                                                                       #
#       "AboutDlg.a.s" - Translated from file "AboutDlg.a"              #
#                                                                       #
#-----------------------------------------------------------------------#
#                                                                       #
#       PortAsm Code Translator Copyright (c) MicroAPL 1990-1994        #
#                   All Rights Reserved Worldwide                       #
#                                                                       #
#########################################################################
# Translated on Thu Jun 30 16:49:23 1994 by version 1.2.2 of PortAsm translator
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
#          -o ::obj:objPPC:AboutDlg.a.s
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


ModA5	equ	BaseOf_AboutDlg_a

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
	dc.w 	3


###################################################
# Module Initialisation Routine                   #
###################################################
	csect 	PCcsect[pr]
	export	_PAInit_AboutDlg_a
_PAInit_AboutDlg_a:
# Save application's A5 into TOC for callbacks:
	stw     a5,T_A5Value(RTOC)

# Dummy data load instruction prevents linker from removing unreferenced data
# csect during garbage collection
	lwz 	RS,T_PANoGC(RTOC)

# Save return address:
	mflr	RX
	stwu	RX,-4(a7)

###################################################
# Code to create Universal Proc Pointers          #
###################################################
kPowerPCISA:	equ	0x00000001
kPascalStackBased:	equ	0x00000000
kCStackBased:	equ	0x00000001
kRegisterBased:	equ	0x00000002
kOneByteCode:	equ	1
kTwoByteCode:	equ	2
kFourByteCode:	equ	3
kD0:	equ	0
kD1:	equ	1
kD2:	equ	2
kD3:	equ	3
kA0:	equ	4
kA1:	equ	5
kA2:	equ	6
kA3:	equ	7

	import	.NewRoutineDescriptor[PR]

uppAboutWindow_wrapper2_ProcInfo	equ    kPascalStackBased|(kFourByteCode<<6)|(kTwoByteCode<<8)
	lil	R5,kPowerPCISA
	liu	R4,((uppAboutWindow_wrapper2_ProcInfo)>>16)&0xffff
	ori	R4,R4,(uppAboutWindow_wrapper2_ProcInfo)&0xffff
	lwz	R3,T_AboutWindow_wrapper2_DS(RTOC)
	bl	.NewRoutineDescriptor[PR]
	nop
	stw	R3,T_AboutWindow_wrapper2_UPP(RTOC)


# Check Data Offsets integrity
	lil	R3,-1
	lwz	R4,_PAMagic(a5)
	liu	R5,0x5041
	ori	R5,R5,(3)&0xffff
	cmp	0,R4,R5
	bne	_PABadMagic
	lil	R3,0
_PABadMagic:

# Return to caller:
	lwz	RX,0(a7)
	mtlr	RX
	addi	a7,a7,4
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


###############################
# AboutInit                   #
###############################
;#AboutInit:      proc    EXPORT                       [Line 29]   
	csect	PCcsect[pr]
	align	2
	export	_68_AboutInit
	export	AboutInit__
AboutInit__:
	function	AboutInit__,AboutInit__,16,044
	beginf	29
	nop
	dc.l	0
	dc.l	0
_68_AboutInit:
;#                data                                 [Line 31]   
	csect	A5World[rw]
;#                export  DialogPtr:DATA               [Line 32]   
;#                export  DialogPtr2:DATA              [Line 33]   
;# Equate to Label "DialogPtr" is defined in data offsets file
;# Burn a real label here for C and Pascal to use
	export	DialogPtr
DialogPtr:
	ds.l	1
;# Equate to Label "DialogPtr2" is defined in data offsets file
;# Burn a real label here for C and Pascal to use
	export	DialogPtr2
DialogPtr2:
	ds.l	1
_68_ItemType:	equ	* + ModA5
	ds.l	1
_68_ItemHandle:	equ	* + ModA5
	ds.l	1
_68_ItemBox:	equ	* + ModA5
	ds.l	2
;#                code                                 [Line 41]   
	csect	PCcsect[pr]
	line	17
;#  move.l      D0,-(SP)                               [Line 45]  
	stwu    d0,-4(a7)
	line	19
;#  clr.l       -(SP)                                  [** Line 47]
	# Glue Optimisation - Don't need result space
	line	20
;#  move.w      #130,-(SP)                             [** Line 48]
	lil     R3,130
	line	21
;#  clr.l       -(SP)                                  [** Line 49]
	lil     R4,0
	line	22
;#  move.l      #-1,-(SP)                              [** Line 50]
	lil     R5,(-(1))
	line	23
;#  _getnewdialog                                      [** Line 51]
	import	.GetNewDialog[PR]
	bl	.GetNewDialog[PR]
	nop
	line	24
;#  move.l      (SP)+,DialogPtr                        [** Line 52]
	stw     R3,_68_DialogPtr(a5)
	line	26
;#  lea         AboutWindow,A0                         [Line 54]  
	lwz     a0,T_AboutWindow_wrapper2_UPP(RTOC)
;#                hint    UPP "AboutWindow" is "UserItemUPP"
	line	29
;#  moveq.l     #4,D0                                  [Line 57]  
	lil     d0,4
	line	30
;#  jsr         SetItem                                [Line 58]  
	bl      _PACallGlue
	bl      _68_SetItem
	line	32
;#  move.l      (SP)+,D0                               [Line 60]  
	lwz     d0,0(a7)
	addi    a7,a7,4
	line	33
;#  rts                                                [Line 61]  
	lwz     RX,0(a7)
	mtlr    RX
	addic   a7,a7,4
	blr     
;#                endp                                 [Line 62]   

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_AboutInit_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_AboutInit_PAEND - _68_AboutInit
	dc.w	9
	dc.b	'AboutInit'
	align	2
	align	2
	endf	62


###############################
# GetItem                     #
###############################
;#GetItem:        proc    Entry                        [Line 75]   
	csect	PCcsect[pr]
	align	2
	export	GetItem__
GetItem__:
	function	GetItem__,GetItem__,16,044
	beginf	75
	nop
	dc.l	0
	dc.l	0
_68_GetItem:
	line	3
;#  movem.l     D0-D2/A0-A1,-(SP)                      [Line 77]  
	stw     a1,(-(4))(a7)
	stw     a0,(-(8))(a7)
	addi    a7,a7,(-(20))
	stswi   d0,a7,12
	line	4
;#  move.l      DialogPtr,-(SP)                        [** Line 78]
	lwz     R3,_68_DialogPtr(a5)
	line	5
;#  move.w      D0,-(SP)                               [** Line 79]
	extsh   R4,d0
	line	6
;#  pea         ItemType                               [** Line 80]
	addi    R5,a5,_68_ItemType
	line	7
;#  pea         ItemHandle                             [** Line 81]
	addi    R6,a5,_68_ItemHandle
	line	8
;#  pea         ItemBox                                [** Line 82]
	addi    R7,a5,_68_ItemBox
	line	9
;#  _getditem                                          [** Line 83]
	import	.GetDialogItem[PR]
	bl	.GetDialogItem[PR]
	nop
	line	10
;#  movem.l     (SP)+,D0-D2/A0-A1                      [Line 84]  
	lswi    d0,a7,12
	lwz     a0,12(a7)
	lwz     a1,16(a7)
	addic   a7,a7,20
	line	12
;#  rts                                                [Line 86]  
	lwz     RX,0(a7)
	mtlr    RX
	addic   a7,a7,4
	blr     
;#                endp                                 [Line 87]   

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_GetItem_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_GetItem_PAEND - _68_GetItem
	dc.w	7
	dc.b	'GetItem'
	align	2
	align	2
	endf	87


###############################
# SetItem                     #
###############################
;#SetItem:        proc    Entry                        [Line 100]  
	csect	PCcsect[pr]
	align	2
	export	SetItem__
SetItem__:
	function	SetItem__,SetItem__,16,044
	beginf	100
	nop
	dc.l	0
	dc.l	0
_68_SetItem:
	line	3
;#  movem.l     D0-D2/A0-A1,-(SP)                      [Line 102] 
	stw     a1,(-(4))(a7)
	stw     a0,(-(8))(a7)
	addi    a7,a7,(-(20))
	stswi   d0,a7,12
	line	5
;#  jsr         GetItem                                [Line 104] 
	bl      _PACallGlue
	bl      _68_GetItem
	line	6
;#  move.l      DialogPtr,-(SP)                        [** Line 105]
	lwz     R3,_68_DialogPtr(a5)
	line	7
;#  move.w      D0,-(SP)                               [** Line 106]
	extsh   R4,d0
	line	8
;#  move.w      ItemType,-(SP)                         [** Line 107]
	lha     R5,_68_ItemType(a5)
	line	9
;#  move.l      A0,-(SP)                               [** Line 108]
	mr      R6,a0
	line	10
;#  pea         ItemBox                                [** Line 109]
	addi    R7,a5,_68_ItemBox
	line	11
;#  _setditem                                          [** Line 110]
	import	.SetDialogItem[PR]
	bl	.SetDialogItem[PR]
	nop
	line	13
;#  movem.l     (SP)+,D0-D2/A0-A1                      [Line 112] 
	lswi    d0,a7,12
	lwz     a0,12(a7)
	lwz     a1,16(a7)
	addic   a7,a7,20
	line	14
;#  rts                                                [Line 113] 
	lwz     RX,0(a7)
	mtlr    RX
	addic   a7,a7,4
	blr     
;#                endp                                 [Line 115]  

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_SetItem_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_SetItem_PAEND - _68_SetItem
	dc.w	7
	dc.b	'SetItem'
	align	2
	align	2
	endf	115


###############################
# AboutWindow                 #
###############################
;#AboutWindow:    proc    EXPORT                       [Line 126]  
	csect	PCcsect[pr]
	align	2
	export	_68_AboutWindow
	export	AboutWindow__
AboutWindow__:
	function	AboutWindow__,AboutWindow__,16,044
	beginf	126
	nop
	dc.l	0
	dc.l	0
_68_AboutWindow:

;#StackFrame      record  {A6Link},DECR                [Line 128]  
_68_AboutWindow_StackFrame: equ 14
_68_AboutWindow_StackFrame_SplashWindow: equ 10
_68_AboutWindow_StackFrame_SplashItem: equ 8
_68_AboutWindow_StackFrame_RetAddr: equ 4
_68_AboutWindow_StackFrame_A6Link: equ 0
_68_AboutWindow_StackFrame_OldWindowSize: equ -4
_68_AboutWindow_StackFrame_OldClipRect: equ -8
_68_AboutWindow_StackFrame_LocalSize:  equ   -8
;#                endr                                 [Line 136]  


# Value of _68_G set from include file
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
	import	_68_DoAboutPolygons
;#                with    StackFrame                   [Line 141]  
	line	17
;#  link        A6,#LocalSize                          [Line 142] 
	stwu    a6,-4(a7)
	mr      a6,a7
	addic   a7,a7,_68_AboutWindow_StackFrame_LocalSize
	line	18
;#  movem.l     D0-D5/A1,-(SP)                         [Line 143] 
	stw     a1,(-(4))(a7)
	addi    a7,a7,(-(28))
	stswi   d0,a7,24
	line	20
;#  move.w      SplashItem(A6),D0                      [Line 145] 
	lha     d0,_68_AboutWindow_StackFrame_SplashItem(a6)
	line	21
;#  move.l      SplashWindow(A6),A0                    [Line 146] 
	lwz     a0,_68_AboutWindow_StackFrame_SplashWindow(a6)
	line	22
;#  bsr         GetItem                                [Line 147] 
	bl      _PACallGlue
	bl      _68_GetItem
	line	24
;#  pea         ItemBox                                [** Line 149]
	addi    R3,a5,_68_ItemBox
	line	25
;#  _framerect                                         [** Line 150]
	import	.FrameRect[PR]
	bl	.FrameRect[PR]
	nop
	line	26
;#  pea         ItemBox                                [** Line 151]
	addi    R3,a5,_68_ItemBox
	line	27
;#  _cliprect                                          [** Line 152]
	import	.ClipRect[PR]
	bl	.ClipRect[PR]
	nop
	line	29
;#  move.l      ItemBox+4,D0                           [Line 154] 
	lwz     d0,(_68_ItemBox+4)(a5)
	line	30
;#  move.l      ItemBox,D1                             [Line 155] 
	lwz     d1,_68_ItemBox(a5)
	line	31
;#  sub         D0,D1                                  [Line 156]  Preserve d1.l
	subfc   RT,d0,d1
	rlwimi  d1,RT,0,0x0000ffff  # (H)
	line	32
;#  move.l      G.WindowSize,OldWindowSize(A6)           [Line 157] 
	lwz     RV,_68_G_WindowSize(a5)
	stw     RV,_68_AboutWindow_StackFrame_OldWindowSize(a6)
	line	33
;#  move.l      D0,G.WindowSize                        [Line 158] 
	stw     d0,_68_G_WindowSize(a5)
	line	34
;#  bsr         DoAboutPolygons                        [Line 159] 
	bl      _PACallGlue
	bl      _68_DoAboutPolygons
	line	36
;#  move.l      DialogPtr,-(SP)                        [** Line 161]
	lwz     R3,_68_DialogPtr(a5)
	line	37
;#  clr.l       -(SP)                                  [** Line 162]
	lil     R4,0
	line	38
;#                _setgworld                           [Line 163]    (Macro)
;#  move.l      #$00080006,D0                          [** Line 163]
	# Glue optimisation - selector not required
;#  _qdextensions                                      [** Line 163]
	import	.SetGWorld[PR]
	bl	.SetGWorld[PR]
	nop
	line	39
;#  move.l      OldWindowSize(A6),G.WindowSize           [Line 164] 
	lwz     RV,_68_AboutWindow_StackFrame_OldWindowSize(a6)
	stw     RV,_68_G_WindowSize(a5)
	line	40
;#  clr.l       OldClipRect(A6)                        [Line 165] 
	stw     RZero,_68_AboutWindow_StackFrame_OldClipRect(a6)
	line	41
;#  pea         OldClipRect(a6)                        [** Line 166]
	addi    R3,a6,_68_AboutWindow_StackFrame_OldClipRect
	line	42
;#  _cliprect                                          [** Line 167]
	import	.ClipRect[PR]
	bl	.ClipRect[PR]
	nop
	line	44
;#  movem.l     (SP)+,D0-D5/A1                         [Line 169] 
	lswi    d0,a7,24
	lwz     a1,24(a7)
	addic   a7,a7,28
	line	45
;#  unlk        A6                                     [Line 170] 
	addic   a7,a6,4
	lwz     a6,0(a6)
	line	46
;#  move.l      (SP),A0                                [Line 171] 
	lwz     a0,0(a7)
	line	47
;#  lea         10(SP),SP                              [Line 172] 
	addi    a7,a7,10
	line	48
;#  jmp         (A0)                                   [Line 173] 
	mtctr   a0
	bctr    
;#                endwith                              [Line 175]  
;#                endp                                 [Line 177]  

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_AboutWindow_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_AboutWindow_PAEND - _68_AboutWindow
	dc.w	11
	dc.b	'AboutWindow'
	align	2
	align	2
	endf	177

#########################################################################
# General Glue for calls from C                                         #
#########################################################################

####################################
# Glue for AboutWindow_wrapper2_   #
####################################
	csect	PCcsect[pr]
	export	.AboutWindow_wrapper2_
	export	AboutWindow_wrapper2_[ds]
	csect	AboutWindow_wrapper2_[ds]
	dc.l	.AboutWindow_wrapper2_,TOC[tc0]
	csect	PCcsect[pr]
	align	2
.AboutWindow_wrapper2_:
	mflr	R0
	bl	_PASetupWorld
	stw	R3,-4(a7)
	sth	R4,-6(a7)
	lwz	R0,T_PAReturnResult0(RTOC)
	stwu	R0,-10(a7)
	b	_68_AboutWindow


###################################################
# TOC Entries for C wrappers                      #
###################################################
	import	_PASetupWorld
	import	_PASetupWorldAsync
	import	_PAReturnResult0
	toc
T_PAReturnResult0:	tc	_PAReturnResult0,_PAReturnResult0



###################################################
# TOC Entries for Translated Code                 #
###################################################
	toc
T_A5Value:	tc	A5Value,0
T_PANoGC:	tc	_PANoGC,_PANoGC
T_AboutWindow_wrapper2_DS:	tc AboutWindow_wrapper2_DS, AboutWindow_wrapper2_[ds]
T_AboutWindow_wrapper2_UPP:	tc AboutWindow_wrapper2_UPP, 0

