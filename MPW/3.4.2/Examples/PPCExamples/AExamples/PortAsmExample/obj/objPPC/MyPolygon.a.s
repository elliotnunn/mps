	file	'MyPolygon.a'

#########################################################################
#                                                                       #
#       "MyPolygon.a.s" - Translated from file "MyPolygon.a"            #
#                                                                       #
#-----------------------------------------------------------------------#
#                                                                       #
#       PortAsm Code Translator Copyright (c) MicroAPL 1990-1994        #
#                   All Rights Reserved Worldwide                       #
#                                                                       #
#########################################################################
# Translated on Thu Jun 30 16:44:30 1994 by version 1.2.2 of PortAsm translator
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
#          -o ::obj:objPPC:MyPolygon.a.s
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


ModA5	equ	BaseOf_MyPolygon_a

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
	dc.w 	2


###################################################
# Module Initialisation Routine                   #
###################################################
	csect 	PCcsect[pr]
	export	_PAInit_MyPolygon_a
_PAInit_MyPolygon_a:
# Save application's A5 into TOC for callbacks:
	stw     a5,T_A5Value(RTOC)

# Dummy data load instruction prevents linker from removing unreferenced data
# csect during garbage collection
	lwz 	RS,T_PANoGC(RTOC)

# Check Data Offsets integrity
	lil	R3,-1
	lwz	R4,_PAMagic(a5)
	liu	R5,0x5041
	ori	R5,R5,(2)&0xffff
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
_68_blackColor:       equ   33
_68_whiteColor:       equ   30
_68_redColor:         equ   205
_68_greenColor:       equ   341
_68_blueColor:        equ   409
_68_cyanColor:        equ   273
_68_magentaColor:     equ   137
_68_yellowColor:      equ   69
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
_68_VIRWIDTH:         equ   1280
_68_VIRHEIGHT:        equ   1024
_68_BlackItem:        equ   7


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
# MyPoly                      #
###############################
;#MyPoly          record  0                            [File "PAExample.inc"; Line 121] 
_68_MyPoly:          equ 0
_68_MyPoly_PolyStart:  equ   0
_68_MyPoly_randColors: equ 0
_68_MyPoly_randPoly: equ 1
_68_MyPoly_randDirection: equ 2
_68_MyPoly_phase:    equ 4
_68_MyPoly_Xpos:     equ 6
_68_MyPoly_Ypos:     equ 10
_68_MyPoly_velX:     equ 14
_68_MyPoly_velY:     equ 18
_68_MyPoly_polysize: equ 22
_68_MyPoly_polyOmega: equ 24
_68_MyPoly_spokeLength: equ 26
_68_MyPoly_spokeOmega: equ 28
_68_MyPoly_color:    equ 30
_68_MyPoly_numPoints: equ 32
_68_MyPoly_pt:       equ 34
;#                endr                                 [File "PAExample.inc"; Line 139] 




###############################
# ColorMap                    #
###############################
;#ColorMap:       record                               [Line 19]   
	csect	A5World[rw]
_68_ColorMap:	equ	* + ModA5
	dc.l	_68_whiteColor
	dc.l	_68_redColor
	dc.l	_68_yellowColor
	dc.l	_68_magentaColor
	dc.l	_68_greenColor
	dc.l	_68_cyanColor
	dc.l	_68_blueColor
	dc.l	_68_blackColor
;#                endr                                 [Line 28]   




###############################
# draw_poly                   #
###############################
;#draw_poly:      proc                                 [Line 39]   
	csect	PCcsect[pr]
	align	2
	export	draw_poly__
draw_poly__:
	function	draw_poly__,draw_poly__,16,044
	beginf	39
	nop
	dc.l	0
	dc.l	0
_68_draw_poly:
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
	line	4
;#  move.w      (A4)+,D0                               [Line 42]  
	lha     d0,0(a4)
	addi    a4,a4,2
	line	5
;#  move.w      (A4)+,D1                               [Line 43]  
	lha     d1,0(a4)
	addi    a4,a4,2
	line	6
;#  muls        G.Width,D0                             [Line 44]  
	extsh   RT,d0               # (S)
	lha     RV,_68_G_Width(a5)
	mull    d0,RT,RV
	line	7
;#  divs        #VIRWIDTH,D0                           [Line 45]  
	lil     RX,_68_VIRWIDTH
	mr      RY,d0
	divw    d0,d0,RX
	mull    RX,d0,RX
	subfc   RX,RX,RY
	rlwimi  d0,RX,16,0xffff0000
	line	8
;#  muls        G.Height,D1                            [Line 46]  
	extsh   RT,d1               # (S)
	lha     RV,_68_G_Height(a5)
	mull    d1,RT,RV
	line	9
;#  divs        #VIRHEIGHT,D1                          [Line 47]  
	lil     RX,_68_VIRHEIGHT
	mr      RY,d1
	divw    d1,d1,RX
	mull    RX,d1,RX
	subfc   RX,RX,RY
	rlwimi  d1,RX,16,0xffff0000
	line	10
;#  move.w      D0,-(SP)                               [Line 48]  
	sthu    d0,-2(a7)
	line	11
;#  move.w      D1,-(SP)                               [Line 49]  
	sthu    d1,-2(a7)
	line	12
;#  move.l      (SP),-(SP)                             [Line 50]  
	lwz     RV,0(a7)
	stwu    RV,-4(a7)
	line	13
;#  _moveto                                            [Line 51]  
	lha	R4,0(a7)
	lha	R3,2(a7)
	import	.MoveTo[PR]
	bl	.MoveTo[PR]
	nop
	addi	a7,a7,4
_68_draw_poly_draw_loop:
	line	17
;#  subq.w      #1,D4                       LE         [Line 55]   Preserve d4.l
	extsh   RT,d4               # (S)
	cmpi    0,RT,1
	subic   RT,RT,1
	rlwimi  d4,RT,0,0x0000ffff  # (H)
	line	18
;#  ble         draw_end                               [Line 56]  
	ble     _68_draw_poly_draw_end
	line	19
;#  move.w      (A4)+,D0                               [Line 57]   Preserve d0.l
	lha     RT,0(a4)
	addi    a4,a4,2
	rlwimi  d0,RT,0,0x0000ffff  # (H)
	line	20
;#  move.w      (A4)+,D1                               [Line 58]   Preserve d1.l
	lha     RT,0(a4)
	addi    a4,a4,2
	rlwimi  d1,RT,0,0x0000ffff  # (H)
	line	21
;#  muls        G.Width,D0                             [Line 59]  
	extsh   RT,d0               # (S)
	lha     RV,_68_G_Width(a5)
	mull    d0,RT,RV
	line	22
;#  divs        #VIRWIDTH,D0                           [Line 60]  
	lil     RX,_68_VIRWIDTH
	mr      RY,d0
	divw    d0,d0,RX
	mull    RX,d0,RX
	subfc   RX,RX,RY
	rlwimi  d0,RX,16,0xffff0000
	line	23
;#  muls        G.Height,D1                            [Line 61]  
	extsh   RT,d1               # (S)
	lha     RV,_68_G_Height(a5)
	mull    d1,RT,RV
	line	24
;#  divs        #VIRHEIGHT,D1                          [Line 62]  
	lil     RX,_68_VIRHEIGHT
	mr      RY,d1
	divw    d1,d1,RX
	mull    RX,d1,RX
	subfc   RX,RX,RY
	rlwimi  d1,RX,16,0xffff0000
	line	25
;#  move.w      D0,-(SP)                               [** Line 63]
	extsh   R3,d0
	line	26
;#  move.w      D1,-(SP)                               [** Line 64]
	and     RS,d1,RWord            # (Z)
	extsh   R4,RS
	line	27
;#  _lineto                                            [** Line 65]
	import	.LineTo[PR]
	bl	.LineTo[PR]
	nop
	line	28
;#  bra.s       draw_loop                              [Line 66]  
	b       _68_draw_poly_draw_loop
_68_draw_poly_draw_end:
	line	31
;#  _lineto                                            [Line 69]  
	lha	R4,0(a7)
	lha	R3,2(a7)
	import	.LineTo[PR]
	bl	.LineTo[PR]
	nop
	addi	a7,a7,4
	line	33
;#  rts                                                [Line 71]  
	lwz     RX,0(a7)
	mtlr    RX
	addic   a7,a7,4
	blr     
;#                endp                                 [Line 73]   

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_draw_poly_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_draw_poly_PAEND - _68_draw_poly
	dc.w	9
	dc.b	'draw_poly'
	align	2
	align	2
	endf	73


###############################
# fill_polygon                #
###############################
;#fill_polygon:   proc                                 [Line 88]   
	csect	PCcsect[pr]
	align	2
	export	fill_polygon__
fill_polygon__:
	function	fill_polygon__,fill_polygon__,16,044
	beginf	88
	nop
	dc.l	0
	dc.l	0
_68_fill_polygon:
# Value of _68_PolyWindow set from include file
# Value of _68_RealWindow set from include file
	line	6
;#  move.l      PolyWindow,-(SP)                       [** Line 93]
	lwz     R3,_68_PolyWindow(a5)
	line	7
;#  clr.l       -(SP)                                  [** Line 94]
	lil     R4,0
	line	8
;#                _setgworld                           [Line 95]     (Macro)
;#  move.l      #$00080006,D0                          [** Line 95]
	# Glue optimisation - selector not required
;#  _qdextensions                                      [** Line 95]
	import	.SetGWorld[PR]
	bl	.SetGWorld[PR]
	nop
	line	11
;#  move.l      10(SP),D0                              [Line 98]  
	lwz     d0,10(a7)
	line	12
;#  lsl.l       #2,D0                                  [Line 99]  
	rlwinm  d0,d0,2,0,(31-2)
	line	13
;#  lea         ColorMap,A0                            [Line 100] 
	addi    a0,a5,_68_ColorMap
	line	14
;#  move.l      0(A0,D0.W),-(SP)                       [** Line 101]
	extsh   RZ,d0
	lwzx    R3,a0,RZ
	line	15
;#  _forecolor                                         [** Line 102]
	import	.ForeColor[PR]
	bl	.ForeColor[PR]
	nop
	line	18
;#  move.l      4(SP),A4                               [Line 105] 
	lwz     a4,4(a7)
	line	19
;#  move.w      8(SP),D4                               [Line 106] 
	lha     d4,8(a7)
	line	21
;#  clr.l       -(SP)                                  [** Line 108]
	# Glue Optimisation - Don't need result space
	line	22
;#  _openpoly                                          [** Line 109]
	import	.OpenPoly[PR]
	bl	.OpenPoly[PR]
	nop
	line	23
;#  move.l      (SP)+,D5                               [** Line 110]
	mr      d5,R3
	line	25
;#  bsr         draw_poly                              [Line 112] 
	bl      _PACallGlue
	bl      _68_draw_poly
	line	27
;#  _closepoly                                         [Line 114] 
	import	.ClosePoly[PR]
	bl	.ClosePoly[PR]
	nop
	line	29
;#  move.l      D5,-(SP)                               [** Line 116]
	mr      R3,d5
	line	30
;#  _paintpoly                                         [** Line 117]
	import	.PaintPoly[PR]
	bl	.PaintPoly[PR]
	nop
	line	31
;#  move.l      D5,-(SP)                               [** Line 118]
	mr      R3,d5
	line	32
;#  _killpoly                                          [** Line 119]
	import	.KillPoly[PR]
	bl	.KillPoly[PR]
	nop
	line	34
;#  move.l      RealWindow,-(SP)                       [** Line 121]
	lwz     R3,_68_RealWindow(a5)
	line	35
;#  clr.l       -(SP)                                  [** Line 122]
	lil     R4,0
	line	36
;#                _setgworld                           [Line 123]    (Macro)
;#  move.l      #$00080006,D0                          [** Line 123]
	# Glue optimisation - selector not required
;#  _qdextensions                                      [** Line 123]
	import	.SetGWorld[PR]
	bl	.SetGWorld[PR]
	nop
	line	37
;#  rts                                                [Line 124] 
	lwz     RX,0(a7)
	mtlr    RX
	addic   a7,a7,4
	blr     
;#                endp                                 [Line 126]  

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_fill_polygon_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_fill_polygon_PAEND - _68_fill_polygon
	dc.w	12
	dc.b	'fill_polygon'
	align	2
	align	2
	endf	126


###############################
# outline_polygon             #
###############################
;#outline_polygon: proc                                [Line 141]  
	csect	PCcsect[pr]
	align	2
	export	outline_polygon__
outline_polygon__:
	function	outline_polygon__,outline_polygon__,16,044
	beginf	141
	nop
	dc.l	0
	dc.l	0
_68_outline_polygon:
	line	6
;#  move.l      PolyWindow,-(SP)                       [** Line 146]
	lwz     R3,_68_PolyWindow(a5)
	line	7
;#  clr.l       -(SP)                                  [** Line 147]
	lil     R4,0
	line	8
;#                _setgworld                           [Line 148]    (Macro)
;#  move.l      #$00080006,D0                          [** Line 148]
	# Glue optimisation - selector not required
;#  _qdextensions                                      [** Line 148]
	import	.SetGWorld[PR]
	bl	.SetGWorld[PR]
	nop
	line	11
;#  move.l      10(SP),D0                              [Line 151] 
	lwz     d0,10(a7)
	line	12
;#  lsl.l       #2,D0                                  [Line 152] 
	rlwinm  d0,d0,2,0,(31-2)
	line	13
;#  lea         ColorMap,A0                            [Line 153] 
	addi    a0,a5,_68_ColorMap
	line	14
;#  move.l      0(A0,D0.W),-(SP)                       [** Line 154]
	extsh   RZ,d0
	lwzx    R3,a0,RZ
	line	15
;#  _forecolor                                         [** Line 155]
	import	.ForeColor[PR]
	bl	.ForeColor[PR]
	nop
	line	18
;#  move.l      4(SP),A4                               [Line 158] 
	lwz     a4,4(a7)
	line	19
;#  move.w      8(SP),D4                               [Line 159]  Preserve d4.l
	lha     RT,8(a7)
	rlwimi  d4,RT,0,0x0000ffff  # (H)
	line	20
;#  bsr         draw_poly                              [Line 160]  Preserve d4.l
	bl      _PACallGlue
	bl      _68_draw_poly
	line	22
;#  move.l      RealWindow,-(SP)                       [** Line 162]
	lwz     R3,_68_RealWindow(a5)
	line	23
;#  clr.l       -(SP)                                  [** Line 163]
	lil     R4,0
	line	24
;#                _setgworld                           [Line 164]    (Macro)
;#  move.l      #$00080006,D0                          [** Line 164]
	# Glue optimisation - selector not required
;#  _qdextensions                                      [** Line 164]
	import	.SetGWorld[PR]
	bl	.SetGWorld[PR]
	nop
	line	25
;#  rts                                                [Line 165] 
	lwz     RX,0(a7)
	mtlr    RX
	addic   a7,a7,4
	blr     
;#                endp                                 [Line 167]  

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_outline_polygon_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_outline_polygon_PAEND - _68_outline_polygon
	dc.w	15
	dc.b	'outline_polygon'
	align	2
	align	2
	endf	167


###############################
# DrawOnePolygon              #
###############################
;#DrawOnePolygon  proc    EXPORT                       [Line 186]  
	csect	PCcsect[pr]
	align	2
	export	_68_DrawOnePolygon
	export	DrawOnePolygon__
DrawOnePolygon__:
	function	DrawOnePolygon__,DrawOnePolygon__,16,044
	beginf	186
	nop
	dc.l	0
	dc.l	0
_68_DrawOnePolygon:

;#StackFrame      record  {A6Link},DECR                [Line 188]  
_68_DrawOnePolygon_StackFrame: equ 28
_68_DrawOnePolygon_StackFrame_ParamBegin:  equ   28
_68_DrawOnePolygon_StackFrame_PolyColor: equ 24
_68_DrawOnePolygon_StackFrame_PolyPtr: equ 20
_68_DrawOnePolygon_StackFrame_ParamSize:  equ   _68_DrawOnePolygon_StackFrame_ParamBegin-20
_68_DrawOnePolygon_StackFrame_RetAddr: equ 16
_68_DrawOnePolygon_StackFrame_SaveRegisters: equ 4
_68_DrawOnePolygon_StackFrame_A6Link: equ 0
_68_DrawOnePolygon_StackFrame_ColorNo: equ -4
_68_DrawOnePolygon_StackFrame_NoPoints: equ -6
_68_DrawOnePolygon_StackFrame_PtArray: equ -10
_68_DrawOnePolygon_StackFrame_LocalSize:  equ   -10
;#                endr                                 [Line 200]  


;#                data                                 [Line 202]  
	csect	A5World[rw]
;#                export  ThePolygon:DATA              [Line 203]  
;# Equate to Label "ThePolygon" is defined in data offsets file
;# Burn a real label here for C and Pascal to use
	export	ThePolygon
ThePolygon:
	ds.l	1
;#                code                                 [Line 206]  
	csect	PCcsect[pr]
	import	_68_UpdateRealWin
;#                with    MyPoly                       [Line 210]  
;#                with    StackFrame                   [Line 211]  
	line	28
;#  movem.l     D4/D5/A4,-(SP)                         [Line 213] 
	stw     a4,(-(4))(a7)
	stw     d5,(-(8))(a7)
	stwu    d4,(-(12))(a7)
	line	30
;#  link        A6,#LocalSize                          [Line 215] 
	stwu    a6,-4(a7)
	mr      a6,a7
	addic   a7,a7,_68_DrawOnePolygon_StackFrame_LocalSize
	line	31
;#  move.l      PolyPtr(A6),A4                         [Line 216] 
	lwz     a4,_68_DrawOnePolygon_StackFrame_PolyPtr(a6)
	line	33
;#  move.l      PolyColor(A6),ColorNo(A6)              [Line 218] 
	lwz     RV,_68_DrawOnePolygon_StackFrame_PolyColor(a6)
	stw     RV,_68_DrawOnePolygon_StackFrame_ColorNo(a6)
	line	34
;#  move.w      numPoints(A4),NoPoints(A6)             [Line 219] 
	lha     RV,_68_MyPoly_numPoints(a4)
	sth     RV,_68_DrawOnePolygon_StackFrame_NoPoints(a6)
	line	35
;#  lea         pt(A4),A4                              [Line 220] 
	addi    a4,a4,_68_MyPoly_pt
	line	36
;#  move.l      A4,PtArray(A6)                         [Line 221] 
	stw     a4,_68_DrawOnePolygon_StackFrame_PtArray(a6)
	line	37
;#  bsr         fill_polygon                           [Line 222] 
	bl      _PACallGlue
	bl      _68_fill_polygon
	line	39
;#  move.l      #BlackItem,ColorNo(A6)                 [Line 224] 
	lil     RV,_68_BlackItem
	stw     RV,_68_DrawOnePolygon_StackFrame_ColorNo(a6)
	line	40
;#  bsr         outline_polygon                        [Line 225] 
	bl      _PACallGlue
	bl      _68_outline_polygon
	line	42
;#  tst.b       InAbout                     NE         [Line 227] 
	lbz     RV,_68_InAbout(a5)
	extsb.  RX,RV
	line	43
;#  bne         NoUpdate                               [Line 228] 
	bne     _68_DrawOnePolygon_NoUpdate
	line	44
;#  move.l      PolyPtr(A6),D0                         [Line 229] 
	lwz     d0,_68_DrawOnePolygon_StackFrame_PolyPtr(a6)
	line	45
;#  bsr         UpdateRealWin                          [Line 230] 
	bl      _PACallGlue
	bl      _68_UpdateRealWin
_68_DrawOnePolygon_NoUpdate:
	line	48
;#  unlk        A6                                     [Line 233] 
	addic   a7,a6,4
	lwz     a6,0(a6)
	line	49
;#  movem.l     (SP)+,D4/D5/A4                         [Line 234] 
	lwz     d4,0(a7)
	lwz     d5,4(a7)
	lwz     a4,8(a7)
	addic   a7,a7,12
	line	50
;#  rts                                                [Line 235] 
	lwz     RX,0(a7)
	mtlr    RX
	addic   a7,a7,4
	blr     
;#                endp                                 [Line 237]  

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_DrawOnePolygon_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_DrawOnePolygon_PAEND - _68_DrawOnePolygon
	dc.w	14
	dc.b	'DrawOnePolygon'
	align	2
	align	2
	endf	237


###############################
# DoAboutPolygons             #
###############################
;#DoAboutPolygons proc    EXPORT                       [Line 248]  
	csect	PCcsect[pr]
	align	2
	export	_68_DoAboutPolygons
	export	DoAboutPolygons__
DoAboutPolygons__:
	function	DoAboutPolygons__,DoAboutPolygons__,16,044
	beginf	248
	nop
	dc.l	0
	dc.l	0
_68_DoAboutPolygons:
;#                data                                 [Line 249]  
	csect	A5World[rw]
_68_InAbout:	equ	* + ModA5
	dc.b	0
	align	1
_68_DoAboutPolygons_LocalPoly:	equ	* + ModA5
	ds.l	1
;#                code                                 [Line 254]  
	csect	PCcsect[pr]
	import	.AnimateOnePolygon[PR]
	import	.CreateOnePolygon[PR]
;#                with    MyPoly                       [Line 257]  
	line	12
;#  move.b      #1,InAbout                             [Line 259] 
	lil     RV,(1)&0x00ff
	stb     RV,_68_InAbout(a5)
	line	13
;#  move.l      LocalPoly,D0                NE         [Line 260] 
	lwz     d0,_68_DoAboutPolygons_LocalPoly(a5)
	cmpi    0,d0,0
	line	14
;#  bne         GotPoly                                [Line 261] 
	bne     _68_DoAboutPolygons_GotPoly
	line	15
;#  move.l      #5,-(SP)                               [** Line 262]
	lil     R4,5
	line	16
;#  clr.l       -(SP)                                  [** Line 263]
	lil     R3,0
	line	17
;#  bsr         CreateOnePolygon                       [** Line 264]
	import	.CreateOnePolygon[PR]
	bl	.CreateOnePolygon[PR]
	nop
	mr	d0,R3
	line	18
;#  move.l      D0,A0                                  [Line 265] 
	mr      a0,d0
	line	19
;#  move.b      #1,RandColors(A0)                      [Line 266] 
	lil     RV,(1)&0x00ff
	stb     RV,_68_MyPoly_randColors(a0)
	line	20
;#  move.l      A0,LocalPoly                           [Line 267] 
	stw     a0,_68_DoAboutPolygons_LocalPoly(a5)
	line	21
;#  lea         8(SP),SP                               [** Line 268]
	;# Glue optimisation - instruction not required
_68_DoAboutPolygons_GotPoly:
	line	23
;#  move.l      #180,D3                                [Line 270] 
	lil     d3,180
	line	24
_at_1_8254:
;#  move.l      LocalPoly,-(SP)                        [** Line 271]
	lwz     R3,_68_DoAboutPolygons_LocalPoly(a5)
	line	25
;#  jsr         AnimateOnePolygon                      [** Line 272]
	import	.AnimateOnePolygon[PR]
	bl	.AnimateOnePolygon[PR]
	nop
	mr	d0,R3
	line	26
;#  clr.b       InAbout                                [Line 273] 
	stb     RZero,_68_InAbout(a5)
	line	27
;#  lea         4(SP),SP                               [** Line 274]
	;# Glue optimisation - instruction not required
	line	28
;#  dbra        D3,@1                                  [Line 275]  Preserve d3.l
	extsh   RX,d3
	subic   RX,RX,1
	cmpi    7,RX,-1
	rlwimi  d3,RX,0,0x0000ffff
	bne     7,_at_1_8254
	line	30
;#  rts                                                [Line 277] 
	lwz     RX,0(a7)
	mtlr    RX
	addic   a7,a7,4
	blr     
;#                endp                                 [Line 278]  

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_DoAboutPolygons_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_DoAboutPolygons_PAEND - _68_DoAboutPolygons
	dc.w	15
	dc.b	'DoAboutPolygons'
	align	2
	align	2
	endf	278

#########################################################################
# General Glue for calls from C                                         #
#########################################################################

###############################
# Glue for DrawOnePolygon     #
###############################
	csect	PCcsect[pr]
	export	.DrawOnePolygon
	export	DrawOnePolygon[ds]
	csect	DrawOnePolygon[ds]
	dc.l	.DrawOnePolygon,TOC[tc0]
	csect	PCcsect[pr]
	align	2
.DrawOnePolygon:
	mflr	R0
	bl	_PASetupWorld
	stw	R4,-4(a7)
	stw	R3,-8(a7)
	lwz	R0,T_PAReturnResult0(RTOC)
	stwu	R0,-12(a7)
	b	_68_DrawOnePolygon


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

