	file	'VirtualWin.a'

#########################################################################
#                                                                       #
#       "VirtualWin.a.s" - Translated from file "VirtualWin.a"          #
#                                                                       #
#-----------------------------------------------------------------------#
#                                                                       #
#       PortAsm Code Translator Copyright (c) MicroAPL 1990-1994        #
#                   All Rights Reserved Worldwide                       #
#                                                                       #
#########################################################################
# Translated on Thu Jun 30 16:50:40 1994 by version 1.2.2 of PortAsm translator
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
#          -o ::obj:objPPC:VirtualWin.a.s
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


ModA5	equ	BaseOf_VirtualWin_a

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
	dc.w 	5


###################################################
# Module Initialisation Routine                   #
###################################################
	csect 	PCcsect[pr]
	export	_PAInit_VirtualWin_a
_PAInit_VirtualWin_a:
# Save application's A5 into TOC for callbacks:
	stw     a5,T_A5Value(RTOC)

# Dummy data load instruction prevents linker from removing unreferenced data
# csect during garbage collection
	lwz 	RS,T_PANoGC(RTOC)

# Check Data Offsets integrity
	lil	R3,-1
	lwz	R4,_PAMagic(a5)
	liu	R5,0x5041
	ori	R5,R5,(5)&0xffff
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


###############################
# Rect                        #
###############################
;#Rect              record    0                        [File "TestHD_0:MPW:Interfaces:AIncludes:Types.a"; Line 44] 
_68_Rect:            equ 0
_68_Rect_top:        equ 0
_68_Rect_left:       equ 2
_68_Rect_bottom:     equ 4
_68_Rect_right:      equ 6
;#                  org        top                     [File "TestHD_0:MPW:Interfaces:AIncludes:Types.a"; Line 49] 
_68_Rect_topLeft:    equ 0
_68_Rect_topLeft_v:  equ _68_Rect_topLeft + 0
_68_Rect_topLeft_h:  equ _68_Rect_topLeft + 2
_68_Rect_topLeft_size: equ _68_Rect_topLeft + 4
_68_Rect_botRight:   equ 4
_68_Rect_botRight_v: equ _68_Rect_botRight + 0
_68_Rect_botRight_h: equ _68_Rect_botRight + 2
_68_Rect_botRight_size: equ _68_Rect_botRight + 4
;#                  org                                [File "TestHD_0:MPW:Interfaces:AIncludes:Types.a"; Line 52] 
_68_Rect_size:        equ   8
;#                  endr                               [File "TestHD_0:MPW:Interfaces:AIncludes:Types.a"; Line 54] 


_68_srcCopy:          equ   0
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
_68_portRect:         equ   0x10
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
# InitVirtualWin              #
###############################
;#InitVirtualWin: proc    EXPORT                       [Line 31]   
	csect	PCcsect[pr]
	align	2
	export	_68_InitVirtualWin
	export	InitVirtualWin__
InitVirtualWin__:
	function	InitVirtualWin__,InitVirtualWin__,16,044
	beginf	31
	nop
	dc.l	0
	dc.l	0
_68_InitVirtualWin:
;#                data                                 [Line 32]   
	csect	A5World[rw]
;#                export  (PolyWindow,RealWindow,VirtualWindow):DATA [Line 34]   
;# Equate to Label "PolyWindow" is defined in data offsets file
;# Burn a real label here for C and Pascal to use
	export	PolyWindow
PolyWindow:
	ds.l	1
;# Equate to Label "RealWindow" is defined in data offsets file
;# Burn a real label here for C and Pascal to use
	export	RealWindow
RealWindow:
	ds.l	1
;# Equate to Label "VirtualWindow" is defined in data offsets file
;# Burn a real label here for C and Pascal to use
	export	VirtualWindow
VirtualWindow:
	ds.l	1
_68_InitVirtualWin_VirtRect:	equ	* + ModA5
	ds.l	2
;#                code                                 [Line 40]   
	csect	PCcsect[pr]
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
	line	14
;#  clr.l       VirtRect                               [Line 44]  
	stw     RZero,_68_InitVirtualWin_VirtRect(a5)
	line	15
;#  move.l      G.WindowSize,VirtRect+4                [Line 45]  
	lwz     RV,_68_G_WindowSize(a5)
	stw     RV,(_68_InitVirtualWin_VirtRect+4)(a5)
	line	16
;#  clr.l       -(SP)                                  [Line 46]  
	stwu    RZero,-4(a7)
	line	17
;#  pea         VirtualWindow                          [** Line 47]
	addi    R3,a5,_68_VirtualWindow
	line	18
;#  clr.w       -(SP)                                  [** Line 48]
	lil     R4,0
	line	19
;#  pea         VirtRect                               [** Line 49]
	addi    R5,a5,_68_InitVirtualWin_VirtRect
	line	20
;#  clr.l       -(SP)                                  [** Line 50]
	lil     R6,0
	line	21
;#  clr.l       -(SP)                                  [** Line 51]
	lil     R7,0
	line	22
;#  clr.l       -(SP)                                  [** Line 52]
	lil     R8,0
	line	23
;#                _newgworld                           [Line 53]     (Macro)
;#  move.l      #$00160000,D0                          [** Line 53]
	# Glue optimisation - selector not required
;#  _qdextensions                                      [** Line 53]
	import	.NewGWorld[PR]
	bl	.NewGWorld[PR]
	nop
	sthu	R3,0(a7)
	line	24
;#  lea         4(SP),SP                               [Line 54]  
	addi    a7,a7,4
	line	29
;#  move.l      VirtualWindow,-(SP)                    [** Line 59]
	lwz     R3,_68_VirtualWindow(a5)
	line	30
;#  clr.l       -(SP)                                  [** Line 60]
	lil     R4,0
	line	31
;#                _setgworld                           [Line 61]     (Macro)
;#  move.l      #$00080006,D0                          [** Line 61]
	# Glue optimisation - selector not required
;#  _qdextensions                                      [** Line 61]
	import	.SetGWorld[PR]
	bl	.SetGWorld[PR]
	nop
	line	36
;#  clr.b       -(SP)                                  [Line 66]  
	stbu    RZero,-2(a7)
	line	37
;#  clr.l       -(SP)                                  [Line 67]  
	stwu    RZero,-4(a7)
	line	38
;#  move.l      VirtualWindow,-(SP)                    [** Line 68]
	lwz     R3,_68_VirtualWindow(a5)
	line	39
;#                _getgworldpixmap                     [Line 69]     (Macro)
;#  move.l      #$00040017,D0                          [** Line 69]
	# Glue optimisation - selector not required
;#  _qdextensions                                      [** Line 69]
	import	.GetGWorldPixMap[PR]
	bl	.GetGWorldPixMap[PR]
	nop
	stwu	R3,0(a7)
	line	40
;#                _lockpixels                          [Line 70]     (Macro)
;#  move.l      #$00040001,D0                          [** Line 70]
	# Glue optimisation - selector not required
;#  _qdextensions                                      [** Line 70]
	lwz	R3,0(a7)
	import	.LockPixels[PR]
	bl	.LockPixels[PR]
	nop
	stbu	R3,4(a7)
	line	41
;#  move.b      (SP)+,D0                               [Line 71]   Preserve d0.w 
	lbz     RT,0(a7)
	addi    a7,a7,2
	rlwimi  d0,RT,0,0x000000ff  # (H)
	line	43
;#  clr.l       -(SP)                                  [Line 73]  
	stwu    RZero,-4(a7)
	line	44
;#  move.l      VirtualWindow,-(SP)                    [** Line 74]
	lwz     R3,_68_VirtualWindow(a5)
	line	45
;#                _getgworldpixmap                     [Line 75]     (Macro)
;#  move.l      #$00040017,D0                          [** Line 75]
	# Glue optimisation - selector not required
;#  _qdextensions                                      [** Line 75]
	import	.GetGWorldPixMap[PR]
	bl	.GetGWorldPixMap[PR]
	nop
	stwu	R3,0(a7)
	line	46
;#                _nopurgepixels                       [Line 76]     (Macro)
;#  move.l      #$0004000C,D0                          [** Line 76]
	# Glue optimisation - selector not required
;#  _qdextensions                                      [** Line 76]
	lwz	R3,0(a7)
	import	.NoPurgePixels[PR]
	bl	.NoPurgePixels[PR]
	nop
	addi	a7,a7,4
	line	50
;#  move.l      VirtualWindow,A0                       [Line 80]  
	lwz     a0,_68_VirtualWindow(a5)
	line	51
;#  pea         portRect(A0)                           [** Line 81]
	addi    R3,a0,_68_portRect
	line	52
;#  _eraserect                                         [** Line 82]
	import	.EraseRect[PR]
	bl	.EraseRect[PR]
	nop
	line	54
;#  move.l      VirtualWindow,PolyWindow               [Line 84]  
	lwz     RV,_68_VirtualWindow(a5)
	stw     RV,_68_PolyWindow(a5)
	line	56
;#  rts                                                [Line 86]  
	lwz     RX,0(a7)
	mtlr    RX
	addic   a7,a7,4
	blr     
;#                endp                                 [Line 88]   

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_InitVirtualWin_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_InitVirtualWin_PAEND - _68_InitVirtualWin
	dc.w	14
	dc.b	'InitVirtualWin'
	align	2
	align	2
	endf	88


###############################
# ClearVirtualWin             #
###############################
;#ClearVirtualWin: proc   EXPORT                       [Line 97]   
	csect	PCcsect[pr]
	align	2
	export	_68_ClearVirtualWin
	export	ClearVirtualWin__
ClearVirtualWin__:
	function	ClearVirtualWin__,ClearVirtualWin__,16,044
	beginf	97
	nop
	dc.l	0
	dc.l	0
_68_ClearVirtualWin:
	line	3
;#  move.l      VirtualWindow,-(SP)                    [** Line 99]
	lwz     R3,_68_VirtualWindow(a5)
	line	4
;#  clr.l       -(SP)                                  [** Line 100]
	lil     R4,0
	line	5
;#                _setgworld                           [Line 101]    (Macro)
;#  move.l      #$00080006,D0                          [** Line 101]
	# Glue optimisation - selector not required
;#  _qdextensions                                      [** Line 101]
	import	.SetGWorld[PR]
	bl	.SetGWorld[PR]
	nop
	line	7
;#  move.l      VirtualWindow,A0                       [Line 103] 
	lwz     a0,_68_VirtualWindow(a5)
	line	8
;#  pea         portRect(A0)                           [** Line 104]
	addi    R3,a0,_68_portRect
	line	9
;#  _eraserect                                         [** Line 105]
	import	.EraseRect[PR]
	bl	.EraseRect[PR]
	nop
	line	12
;#  move.l      RealWindow,-(SP)                       [** Line 108]
	lwz     R3,_68_RealWindow(a5)
	line	13
;#  clr.l       -(SP)                                  [** Line 109]
	lil     R4,0
	line	14
;#                _setgworld                           [Line 110]    (Macro)
;#  move.l      #$00080006,D0                          [** Line 110]
	# Glue optimisation - selector not required
;#  _qdextensions                                      [** Line 110]
	import	.SetGWorld[PR]
	bl	.SetGWorld[PR]
	nop
	line	16
;#  rts                                                [Line 112] 
	lwz     RX,0(a7)
	mtlr    RX
	addic   a7,a7,4
	blr     
;#                endp                                 [Line 114]  

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_ClearVirtualWin_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_ClearVirtualWin_PAEND - _68_ClearVirtualWin
	dc.w	15
	dc.b	'ClearVirtualWin'
	align	2
	align	2
	endf	114


###############################
# UpdateRealWin               #
###############################
;#UpdateRealWin:  proc    EXPORT                       [Line 128]  
	csect	PCcsect[pr]
	align	2
	export	_68_UpdateRealWin
	export	UpdateRealWin__
UpdateRealWin__:
	function	UpdateRealWin__,UpdateRealWin__,16,044
	beginf	128
	nop
	dc.l	0
	dc.l	0
_68_UpdateRealWin:
;#                data                                 [Line 129]  
	csect	A5World[rw]
_68_UpdateRealWin_polyRect:	equ	* + ModA5
	ds.b	8
_68_UpdateRealWin_polyRect_top: equ _68_UpdateRealWin_polyRect + 0
_68_UpdateRealWin_polyRect_left: equ _68_UpdateRealWin_polyRect + 2
_68_UpdateRealWin_polyRect_bottom: equ _68_UpdateRealWin_polyRect + 4
_68_UpdateRealWin_polyRect_right: equ _68_UpdateRealWin_polyRect + 6
_68_UpdateRealWin_polyRect_topLeft: equ _68_UpdateRealWin_polyRect + 0
_68_UpdateRealWin_polyRect_topLeft_v: equ _68_UpdateRealWin_polyRect_topLeft + 0
_68_UpdateRealWin_polyRect_topLeft_h: equ _68_UpdateRealWin_polyRect_topLeft + 2
_68_UpdateRealWin_polyRect_topLeft_size: equ _68_UpdateRealWin_polyRect_topLeft + 4
_68_UpdateRealWin_polyRect_botRight: equ _68_UpdateRealWin_polyRect + 4
_68_UpdateRealWin_polyRect_botRight_v: equ _68_UpdateRealWin_polyRect_botRight + 0
_68_UpdateRealWin_polyRect_botRight_h: equ _68_UpdateRealWin_polyRect_botRight + 2
_68_UpdateRealWin_polyRect_botRight_size: equ _68_UpdateRealWin_polyRect_botRight + 4
_68_UpdateRealWin_polyRect_size: equ _68_UpdateRealWin_polyRect + 8
;#                code                                 [Line 132]  
	csect	PCcsect[pr]
	import	.GetVirtualPolyRect[PR]
	line	9
;#  move.l      VirtualWindow,A0                       [Line 136] 
	lwz     a0,_68_VirtualWindow(a5)
	line	10
;#  pea         portBits(A0)                           [Line 137] 
	addi    RV,a0,_68_portBits
	stwu    RV,-4(a7)
	line	12
;#  move.l      RealWindow,A0                          [Line 139] 
	lwz     a0,_68_RealWindow(a5)
	line	13
;#  pea         portBits(A0)                           [Line 140] 
	addi    RV,a0,_68_portBits
	stwu    RV,-4(a7)
	line	15
;#  move.l      d0,-(SP)                               [** Line 142]
	mr      R3,d0
	line	16
;#  jsr         GetVirtualPolyRect                     [** Line 143]
	import	.GetVirtualPolyRect[PR]
	bl	.GetVirtualPolyRect[PR]
	nop
	mr	d0,R3
	line	17
;#  lea         4(SP),SP                               [** Line 144]
	;# Glue optimisation - instruction not required
	line	18
;#  move.l      D0,A0                                  [Line 145] 
	mr      a0,d0
	line	20
;#  move.w      Rect.left(A0),D0                       [Line 147] 
	lha     d0,_68_Rect_left(a0)
	line	21
;#  muls        G.Width,D0                             [Line 148] 
	extsh   RT,d0               # (S)
	lha     RV,_68_G_Width(a5)
	mull    d0,RT,RV
	line	22
;#  divs        #VIRWIDTH,D0                           [Line 149] 
	lil     RX,_68_VIRWIDTH
	mr      RY,d0
	divw    d0,d0,RX
	mull    RX,d0,RX
	subfc   RX,RX,RY
	rlwimi  d0,RX,16,0xffff0000
	line	23
;#  move.w      D0,Rect.left(A0)                       [Line 150] 
	sth     d0,_68_Rect_left(a0)
	line	24
;#  move.w      Rect.top(A0),D1                        [Line 151] 
	lha     d1,_68_Rect_top(a0)
	line	25
;#  muls        G.Height,D1                            [Line 152] 
	extsh   RT,d1               # (S)
	lha     RV,_68_G_Height(a5)
	mull    d1,RT,RV
	line	26
;#  divs        #VIRHEIGHT,D1                          [Line 153] 
	lil     RX,_68_VIRHEIGHT
	mr      RY,d1
	divw    d1,d1,RX
	mull    RX,d1,RX
	subfc   RX,RX,RY
	rlwimi  d1,RX,16,0xffff0000
	line	27
;#  move.w      D1,Rect.top(A0)                        [Line 154] 
	sth     d1,_68_Rect_top(a0)
	line	28
;#  move.w      Rect.right(A0),D0                      [Line 155]  Preserve d0.l
	lha     RT,_68_Rect_right(a0)
	rlwimi  d0,RT,0,0x0000ffff  # (H)
	line	29
;#  move.w      Rect.bottom(A0),D1                     [Line 156]  Preserve d1.l
	lha     RT,_68_Rect_bottom(a0)
	rlwimi  d1,RT,0,0x0000ffff  # (H)
	line	30
;#  muls        G.Width,D0                             [Line 157] 
	extsh   RT,d0               # (S)
	lha     RV,_68_G_Width(a5)
	mull    d0,RT,RV
	line	31
;#  divs        #VIRWIDTH,D0                           [Line 158] 
	lil     RX,_68_VIRWIDTH
	mr      RY,d0
	divw    d0,d0,RX
	mull    RX,d0,RX
	subfc   RX,RX,RY
	rlwimi  d0,RX,16,0xffff0000
	line	32
;#  muls        G.Height,D1                            [Line 159] 
	extsh   RT,d1               # (S)
	lha     RV,_68_G_Height(a5)
	mull    d1,RT,RV
	line	33
;#  divs        #VIRHEIGHT,D1                          [Line 160] 
	lil     RX,_68_VIRHEIGHT
	mr      RY,d1
	divw    d1,d1,RX
	mull    RX,d1,RX
	subfc   RX,RX,RY
	rlwimi  d1,RX,16,0xffff0000
	line	34
;#  move.w      D0,Rect.right(A0)                      [Line 161] 
	sth     d0,_68_Rect_right(a0)
	line	35
;#  move.w      D1,Rect.bottom(A0)                     [Line 162] 
	sth     d1,_68_Rect_bottom(a0)
	line	37
;#  move.l      A0,-(SP)                               [Line 164] 
	stwu    a0,-4(a7)
	line	38
;#  move.l      A0,-(SP)                               [Line 165] 
	stwu    a0,-4(a7)
	line	39
;#  move.w      #srcCopy,-(SP)                         [Line 166] 
	sthu    RZero,-2(a7)
	line	40
;#  clr.l       -(SP)                                  [Line 167] 
	stwu    RZero,-4(a7)
	line	41
;#  _copybits                                          [Line 168] 
	lwz	R8,0(a7)
	lha	R7,4(a7)
	lwz	R6,6(a7)
	lwz	R5,10(a7)
	lwz	R4,14(a7)
	lwz	R3,18(a7)
	import	.CopyBits[PR]
	bl	.CopyBits[PR]
	nop
	addi	a7,a7,22
	line	43
;#  rts                                                [Line 170] 
	lwz     RX,0(a7)
	mtlr    RX
	addic   a7,a7,4
	blr     
;#                endp                                 [Line 172]  

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_UpdateRealWin_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_UpdateRealWin_PAEND - _68_UpdateRealWin
	dc.w	13
	dc.b	'UpdateRealWin'
	align	2
	align	2
	endf	172


###############################
# RefreshRealWin              #
###############################
;#RefreshRealWin: proc    EXPORT                       [Line 182]  
	csect	PCcsect[pr]
	align	2
	export	_68_RefreshRealWin
	export	RefreshRealWin__
RefreshRealWin__:
	function	RefreshRealWin__,RefreshRealWin__,16,044
	beginf	182
	nop
	dc.l	0
	dc.l	0
_68_RefreshRealWin:
;#                data                                 [Line 183]  
	csect	A5World[rw]
_68_RefreshRealWin_polyRect:	equ	* + ModA5
	ds.b	8
_68_RefreshRealWin_polyRect_top: equ _68_RefreshRealWin_polyRect + 0
_68_RefreshRealWin_polyRect_left: equ _68_RefreshRealWin_polyRect + 2
_68_RefreshRealWin_polyRect_bottom: equ _68_RefreshRealWin_polyRect + 4
_68_RefreshRealWin_polyRect_right: equ _68_RefreshRealWin_polyRect + 6
_68_RefreshRealWin_polyRect_topLeft: equ _68_RefreshRealWin_polyRect + 0
_68_RefreshRealWin_polyRect_topLeft_v: equ _68_RefreshRealWin_polyRect_topLeft + 0
_68_RefreshRealWin_polyRect_topLeft_h: equ _68_RefreshRealWin_polyRect_topLeft + 2
_68_RefreshRealWin_polyRect_topLeft_size: equ _68_RefreshRealWin_polyRect_topLeft + 4
_68_RefreshRealWin_polyRect_botRight: equ _68_RefreshRealWin_polyRect + 4
_68_RefreshRealWin_polyRect_botRight_v: equ _68_RefreshRealWin_polyRect_botRight + 0
_68_RefreshRealWin_polyRect_botRight_h: equ _68_RefreshRealWin_polyRect_botRight + 2
_68_RefreshRealWin_polyRect_botRight_size: equ _68_RefreshRealWin_polyRect_botRight + 4
_68_RefreshRealWin_polyRect_size: equ _68_RefreshRealWin_polyRect + 8
;#                code                                 [Line 186]  
	csect	PCcsect[pr]
	line	9
;#  move.l      VirtualWindow,A0                       [Line 190] 
	lwz     a0,_68_VirtualWindow(a5)
	line	10
;#  pea         portBits(A0)                           [** Line 191]
	addi    R3,a0,_68_portBits
	line	11
;#  lea         portRect(A0),A1                        [Line 192] 
	addi    a1,a0,_68_portRect
	line	13
;#  move.l      RealWindow,A0                          [Line 194] 
	lwz     a0,_68_RealWindow(a5)
	line	14
;#  pea         portBits(A0)                           [** Line 195]
	addi    R4,a0,_68_portBits
	line	16
;#  move.l      A1,-(SP)                               [** Line 197]
	mr      R5,a1
	line	17
;#  pea         portRect(A0)                           [** Line 198]
	addi    R6,a0,_68_portRect
	line	18
;#  move.w      #srcCopy,-(SP)                         [** Line 199]
	lil     R7,_68_srcCopy
	line	19
;#  clr.l       -(SP)                                  [** Line 200]
	lil     R8,0
	line	20
;#  _copybits                                          [** Line 201]
	import	.CopyBits[PR]
	bl	.CopyBits[PR]
	nop
	line	22
;#  rts                                                [Line 203] 
	lwz     RX,0(a7)
	mtlr    RX
	addic   a7,a7,4
	blr     
;#                endp                                 [Line 205]  

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_RefreshRealWin_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_RefreshRealWin_PAEND - _68_RefreshRealWin
	dc.w	14
	dc.b	'RefreshRealWin'
	align	2
	align	2
	endf	205

###################################################
# Export the very last label...                   #
###################################################
# This is the last label in the application. Used for debugging purposes
	csect   PCcsect[pr]
	export	_PAEndProgram
_PAEndProgram:
	dc.l	0x0000000


###################################################
# TOC Entries for Translated Code                 #
###################################################
	toc
T_A5Value:	tc	A5Value,0
T_PANoGC:	tc	_PANoGC,_PANoGC

