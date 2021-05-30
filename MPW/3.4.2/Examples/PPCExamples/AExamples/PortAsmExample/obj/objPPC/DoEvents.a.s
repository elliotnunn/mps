	file	'DoEvents.a'

#########################################################################
#                                                                       #
#       "DoEvents.a.s" - Translated from file "DoEvents.a"              #
#                                                                       #
#-----------------------------------------------------------------------#
#                                                                       #
#       PortAsm Code Translator Copyright (c) MicroAPL 1990-1994        #
#                   All Rights Reserved Worldwide                       #
#                                                                       #
#########################################################################
# Translated on Thu Jun 30 16:43:42 1994 by version 1.2.2 of PortAsm translator
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
#          -o ::obj:objPPC:DoEvents.a.s
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


ModA5	equ	BaseOf_DoEvents_a

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
	dc.w 	1


###################################################
# Module Initialisation Routine                   #
###################################################
	csect 	PCcsect[pr]
	export	_PAInit_DoEvents_a
_PAInit_DoEvents_a:
# Save application's A5 into TOC for callbacks:
	stw     a5,T_A5Value(RTOC)

# Dummy data load instruction prevents linker from removing unreferenced data
# csect during garbage collection
	lwz 	RS,T_PANoGC(RTOC)

# Check Data Offsets integrity
	lil	R3,-1
	lwz	R4,_PAMagic(a5)
	liu	R5,0x5041
	ori	R5,R5,(1)&0xffff
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
_68___Resources__:    set   1
_68___MinimumTraps__:  set   1
_68___Traps__:        set   1
_68___MinimumTraps__:  set   0
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
_68_false:            equ   0
_68_true:             equ   1
_68___ToolUtils__:    set   1
_68___Events__:       set   1
_68_everyEvent:       equ   -(1)
_68_cmdKey:           equ   0x8


###############################
# EventRecord                 #
###############################
;#EventRecord          record  0                       [File "TestHD_0:MPW:Interfaces:AIncludes:Events.a"; Line 81] 
_68_EventRecord:     equ 0
_68_EventRecord_what: equ 0
_68_EventRecord_message: equ 2
_68_EventRecord_when: equ 6
_68_EventRecord_where: equ 10
_68_EventRecord_where_v: equ _68_EventRecord_where + 0
_68_EventRecord_where_h: equ _68_EventRecord_where + 2
_68_EventRecord_where_size: equ _68_EventRecord_where + 4
_68_EventRecord_modifiers: equ 14
_68_EventRecord_size:  equ   16
;#                     endr                            [File "TestHD_0:MPW:Interfaces:AIncludes:Events.a"; Line 88] 


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
_68_evtMouse:         equ   0xA
_68_evtBlkSize:       equ   0x10
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


_68_inMenuBar:        equ   1
_68_inSysWindow:      equ   2
_68_inContent:        equ   3
_68_inDrag:           equ   4
_68_inGoAway:         equ   6
_68___Menus__:        set   1
_68___Controls__:     set   1
_68_popupMenuProc:    equ   1008
_68___TextEdit__:     set   1
_68___Dialogs__:      set   1
_68_wholeTools:       equ   1
_68_teRecBack:        equ   0x42
_68___MinimumTraps__:  set   1
_68___Packages__:     set   1
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
_68_diBadMount:       equ   0
_68_bitmapRec:        equ   14
_68_cursRec:          equ   68
_68_portBits:         equ   0x2
_68_portRect:         equ   0x10
_68_visRgn:           equ   0x18
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
_68_VIRHEIGHT:        equ   1024
_68_DITopLeft:        equ   0x00500070
_68_AppleMenu:        equ   128
_68_AboutItem:        equ   1
_68_FileMenu:         equ   129
_68_NewItem:          equ   1
_68_CloseItem:        equ   4
_68_QuitItem:         equ   12
_68_EditMenu:         equ   130
_68_ColorMenu:        equ   131
_68_RandomMenu:       equ   132
_68_ColorItem:        equ   1
_68_PolyItem:         equ   2
_68_DirectionItem:    equ   3
_68_SoundMenu:        equ   133
_68_SoundOffItem:     equ   1
_68_SoundOnItem:      equ   2


###############################
# BitMap                      #
###############################
;#BitMap          record  0                            [File "PAExample.inc"; Line 78] 
_68_BitMap:          equ 0
_68_BitMap_baseAddr: equ 0
_68_BitMap_rowBytes: equ 4
_68_BitMap_bounds:   equ 6
_68_BitMap_bounds_top: equ _68_BitMap_bounds + 0
_68_BitMap_bounds_left: equ _68_BitMap_bounds + 2
_68_BitMap_bounds_bottom: equ _68_BitMap_bounds + 4
_68_BitMap_bounds_right: equ _68_BitMap_bounds + 6
_68_BitMap_bounds_topLeft: equ _68_BitMap_bounds + 0
_68_BitMap_bounds_topLeft_v: equ _68_BitMap_bounds_topLeft + 0
_68_BitMap_bounds_topLeft_h: equ _68_BitMap_bounds_topLeft + 2
_68_BitMap_bounds_topLeft_size: equ _68_BitMap_bounds_topLeft + 4
_68_BitMap_bounds_botRight: equ _68_BitMap_bounds + 4
_68_BitMap_bounds_botRight_v: equ _68_BitMap_bounds_botRight + 0
_68_BitMap_bounds_botRight_h: equ _68_BitMap_bounds_botRight + 2
_68_BitMap_bounds_botRight_size: equ _68_BitMap_bounds_botRight + 4
_68_BitMap_bounds_size: equ _68_BitMap_bounds + 8
;#                endr                                 [File "PAExample.inc"; Line 82] 




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
# Value of _68_QD set from include file
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


###############################
# AdjustMenus                 #
###############################
;#AdjustMenus     proc    ENTRY                        [Line 28]   
	csect	PCcsect[pr]
	align	2
	export	AdjustMenus__
AdjustMenus__:
	function	AdjustMenus__,AdjustMenus__,16,044
	beginf	28
	nop
	dc.l	0
	dc.l	0
_68_AdjustMenus:

;#StackFrame      record  {A6Link},DECR                [Line 30]   
_68_AdjustMenus_StackFrame: equ 8
_68_AdjustMenus_StackFrame_RetAddr: equ 4
_68_AdjustMenus_StackFrame_A6Link: equ 0
_68_AdjustMenus_StackFrame_FrontMost: equ -4
_68_AdjustMenus_StackFrame_Menu: equ -8
_68_AdjustMenus_StackFrame_LocalSize:  equ   -8
;#                endr                                 [Line 36]   


# Value of _68_ThePolygon set from include file
;#                with    StackFrame                   [Line 39]   
	line	13
;#  link        A6,#LocalSize                          [Line 40]  
	stwu    a6,-4(a7)
	mr      a6,a7
	addic   a7,a7,_68_AdjustMenus_StackFrame_LocalSize
	line	15
;#  clr.l       -(SP)                                  [** Line 42]
	# Glue Optimisation - Don't need result space
	line	16
;#  _frontwindow                                       [** Line 43]
	import	.FrontWindow[PR]
	bl	.FrontWindow[PR]
	nop
	line	17
;#  move.l      (SP)+,FrontMost(A6)                    [** Line 44]
	stw     R3,_68_AdjustMenus_StackFrame_FrontMost(a6)
_68_AdjustMenus_AdjustFile:
	line	21
;#  clr.l       -(SP)                                  [Line 48]  
	stwu    RZero,-4(a7)
	line	22
;#  move.w      #FileMenu,-(SP)                        [** Line 49]
	lil     R3,_68_FileMenu
	line	23
;#  _getmhandle                                        [** Line 50]
	import	.GetMenuHandle[PR]
	bl	.GetMenuHandle[PR]
	nop
	stwu	R3,0(a7)
	line	24
;#  move.w      #CloseItem,-(SP)                       [Line 51]  
	lil     RV,_68_CloseItem
	sthu    RV,-2(a7)
	line	25
;#  _disableitem                                       [Line 52]  
	lha	R4,0(a7)
	lwz	R3,2(a7)
	import	.DisableItem[PR]
	bl	.DisableItem[PR]
	nop
	addi	a7,a7,6
_68_AdjustMenus_AdjustColor:
	line	29
;#  clr.l       -(SP)                                  [** Line 56]
	# Glue Optimisation - Don't need result space
	line	30
;#  move.w      #ColorMenu,-(SP)                       [** Line 57]
	lil     R3,_68_ColorMenu
	line	31
;#  _getmhandle                                        [** Line 58]
	import	.GetMenuHandle[PR]
	bl	.GetMenuHandle[PR]
	nop
	line	32
;#  move.l      (SP)+,Menu(A6)                         [** Line 59]
	stw     R3,_68_AdjustMenus_StackFrame_Menu(a6)
	line	34
;#  move.l      Menu(A6),-(SP)                         [** Line 61]
	lwz     R3,_68_AdjustMenus_StackFrame_Menu(a6)
	line	35
;#  move.w      G.OldColor,-(SP)                       [** Line 62]
	lha     R4,_68_G_OldColor(a5)
	line	36
;#  move.b      #False,-(SP)                           [** Line 63]
	lil     R5,_68_false
	line	37
;#  _checkitem                                         [** Line 64]
	import	.CheckItem[PR]
	bl	.CheckItem[PR]
	nop
	line	39
;#  move.l      ThePolygon,A0                          [Line 66]  
	lwz     a0,_68_ThePolygon(a5)
	line	40
;#  move.b      MyPoly.randColors(A0),D0    NE         [Line 67]  
	lbz     d0,_68_MyPoly_randColors(a0)
	extsb.  RX,d0
	line	41
;#  bne         AdjustRandom                           [Line 68]  
	bne     _68_AdjustMenus_AdjustRandom
	line	43
;#  move.l      Menu(A6),-(SP)                         [** Line 70]
	lwz     R3,_68_AdjustMenus_StackFrame_Menu(a6)
	line	44
;#  move.l      ThePolygon,A0                          [Line 71]  
	lwz     a0,_68_ThePolygon(a5)
	line	45
;#  move.w      MyPoly.color(A0),D0                    [Line 72]  
	lha     d0,_68_MyPoly_color(a0)
	line	46
;#  move.w      D0,-(SP)                               [** Line 73]
	extsh   R4,d0
	line	47
;#  move.b      #True,-(SP)                            [** Line 74]
	lil     R5,_68_true
	line	48
;#  _checkitem                                         [** Line 75]
	import	.CheckItem[PR]
	bl	.CheckItem[PR]
	nop
_68_AdjustMenus_AdjustRandom:
	line	52
;#  clr.l       -(SP)                                  [** Line 79]
	# Glue Optimisation - Don't need result space
	line	53
;#  move.w      #RandomMenu,-(SP)                      [** Line 80]
	lil     R3,_68_RandomMenu
	line	54
;#  _getmhandle                                        [** Line 81]
	import	.GetMenuHandle[PR]
	bl	.GetMenuHandle[PR]
	nop
	line	55
;#  move.l      (SP)+,Menu(A6)                         [** Line 82]
	stw     R3,_68_AdjustMenus_StackFrame_Menu(a6)
	line	57
;#  move.l      Menu(A6),-(SP)                         [** Line 84]
	lwz     R3,_68_AdjustMenus_StackFrame_Menu(a6)
	line	58
;#  move.w      #ColorItem,-(SP)                       [** Line 85]
	lil     R4,_68_ColorItem
	line	59
;#  move.l      ThePolygon,A0                          [Line 86]  
	lwz     a0,_68_ThePolygon(a5)
	line	60
;#  move.b      MyPoly.randColors(A0),-(SP)            [** Line 87]
	lbz     R5,_68_MyPoly_randColors(a0)
	line	61
;#  _checkitem                                         [** Line 88]
	import	.CheckItem[PR]
	bl	.CheckItem[PR]
	nop
	line	62
;#  move.l      Menu(A6),-(SP)                         [** Line 89]
	lwz     R3,_68_AdjustMenus_StackFrame_Menu(a6)
	line	63
;#  move.w      #PolyItem,-(SP)                        [** Line 90]
	lil     R4,_68_PolyItem
	line	64
;#  move.l      ThePolygon,A0                          [Line 91]  
	lwz     a0,_68_ThePolygon(a5)
	line	65
;#  move.b      MyPoly.randPoly(A0),-(SP)              [** Line 92]
	lbz     R5,_68_MyPoly_randPoly(a0)
	line	66
;#  _checkitem                                         [** Line 93]
	import	.CheckItem[PR]
	bl	.CheckItem[PR]
	nop
	line	67
;#  move.l      Menu(A6),-(SP)                         [** Line 94]
	lwz     R3,_68_AdjustMenus_StackFrame_Menu(a6)
	line	68
;#  move.w      #DirectionItem,-(SP)                   [** Line 95]
	lil     R4,_68_DirectionItem
	line	69
;#  move.l      ThePolygon,A0                          [Line 96]  
	lwz     a0,_68_ThePolygon(a5)
	line	70
;#  move.b      MyPoly.randDirection(A0),-(SP)           [** Line 97]
	lbz     R5,_68_MyPoly_randDirection(a0)
	line	71
;#  _checkitem                                         [** Line 98]
	import	.CheckItem[PR]
	bl	.CheckItem[PR]
	nop
_68_AdjustMenus_AdjustSound:
	line	75
;#  clr.l       -(SP)                                  [** Line 102]
	# Glue Optimisation - Don't need result space
	line	76
;#  move.w      #SoundMenu,-(SP)                       [** Line 103]
	lil     R3,_68_SoundMenu
	line	77
;#  _getmhandle                                        [** Line 104]
	import	.GetMenuHandle[PR]
	bl	.GetMenuHandle[PR]
	nop
	line	78
;#  move.l      (SP)+,Menu(A6)                         [** Line 105]
	stw     R3,_68_AdjustMenus_StackFrame_Menu(a6)
	line	80
;#  move.l      Menu(A6),-(SP)                         [** Line 107]
	lwz     R3,_68_AdjustMenus_StackFrame_Menu(a6)
	line	81
;#  move.w      #SoundOffItem,-(SP)                    [** Line 108]
	lil     R4,_68_SoundOffItem
	line	82
;#  move.b      G.SoundMode,D0                         [Line 109] 
	lbz     d0,_68_G_SoundMode(a5)
	line	83
;#  eori.b      #1,D0                                  [Line 110] 
	xori    d0,d0,(1)&0xffff
	line	84
;#  move.b      D0,-(SP)                               [** Line 111]
	and     R5,d0,RByte
	line	85
;#  _checkitem                                         [** Line 112]
	import	.CheckItem[PR]
	bl	.CheckItem[PR]
	nop
	line	86
;#  move.l      Menu(A6),-(SP)                         [** Line 113]
	lwz     R3,_68_AdjustMenus_StackFrame_Menu(a6)
	line	87
;#  move.w      #SoundOnItem,-(SP)                     [** Line 114]
	lil     R4,_68_SoundOnItem
	line	88
;#  move.b      G.SoundMode,-(SP)                      [** Line 115]
	lbz     R5,_68_G_SoundMode(a5)
	line	89
;#  _checkitem                                         [** Line 116]
	import	.CheckItem[PR]
	bl	.CheckItem[PR]
	nop
	line	92
;#  unlk        A6                                     [Line 119] 
	addic   a7,a6,4
	lwz     a6,0(a6)
	line	93
;#  rts                                                [Line 120] 
	lwz     RX,0(a7)
	mtlr    RX
	addic   a7,a7,4
	blr     
;#                endp                                 [Line 122]  

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_AdjustMenus_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_AdjustMenus_PAEND - _68_AdjustMenus
	dc.w	11
	dc.b	'AdjustMenus'
	align	2
	align	2
	endf	122


###############################
# DoUpdate                    #
###############################
;#DoUpdate        proc    ENTRY                        [Line 133]  
	csect	PCcsect[pr]
	align	2
	export	DoUpdate__
DoUpdate__:
	function	DoUpdate__,DoUpdate__,16,044
	beginf	133
	nop
	dc.l	0
	dc.l	0
_68_DoUpdate:

;#StackFrame      record  {A6Link},DECR                [Line 135]  
_68_DoUpdate_StackFrame: equ 12
_68_DoUpdate_StackFrame_ParamBegin:  equ   12
_68_DoUpdate_StackFrame_WindowPtr: equ 8
_68_DoUpdate_StackFrame_ParamSize:  equ   _68_DoUpdate_StackFrame_ParamBegin-8
_68_DoUpdate_StackFrame_RetAddr: equ 4
_68_DoUpdate_StackFrame_A6Link: equ 0
_68_DoUpdate_StackFrame_LocalSize:  equ   0
;#                endr                                 [Line 142]  


	import	_68_RefreshRealWin
;#                with    StackFrame                   [Line 145]  
	line	14
;#  link        A6,#LocalSize                          [Line 146] 
	stwu    a6,-4(a7)
	mr      a6,a7
	line	16
;#  move.l      WindowPtr(A6),-(SP)                    [** Line 148]
	lwz     R3,_68_DoUpdate_StackFrame_WindowPtr(a6)
	line	17
;#  _beginupdate                                       [** Line 149]
	import	.BeginUpdate[PR]
	bl	.BeginUpdate[PR]
	nop
	line	18
;#  clr.w       -(SP)                                  [** Line 150]
	# Glue Optimisation - Don't need result space
	line	19
;#  movea.l     WindowPtr(A6),A0                       [Line 151] 
	lwz     a0,_68_DoUpdate_StackFrame_WindowPtr(a6)
	line	20
;#  move.l      visRgn(A0),-(SP)                       [** Line 152]
	lwz     R3,_68_visRgn(a0)
	line	21
;#  _emptyrgn                                          [** Line 153]
	import	.EmptyRgn[PR]
	bl	.EmptyRgn[PR]
	nop
	line	22
;#  move.b      (SP)+,D0                               [** Line 154]
	mr      d0,R3
	line	23
;#  cmpi.b      #True,D0                    EQ         [Line 155] 
	subic   RX,d0,_68_true
	extsb.  RX,RX
	line	24
;#  beq.s       @1                                     [Line 156] 
	beq     _at_1_9606
	line	26
;#  bsr         RefreshRealWin                         [Line 158] 
	bl      _PACallGlue
	bl      _68_RefreshRealWin
	line	28
_at_1_9606:
;#  move.l      WindowPtr(A6),-(SP)                    [** Line 160]
	lwz     R3,_68_DoUpdate_StackFrame_WindowPtr(a6)
	line	29
;#  _endupdate                                         [** Line 161]
	import	.EndUpdate[PR]
	bl	.EndUpdate[PR]
	nop
	line	31
_68_DoUpdate_Exit:
;#  unlk        A6                                     [Line 163] 
	addic   a7,a6,4
	lwz     a6,0(a6)
	line	32
;#  movea.l     (SP)+,A0                               [Line 164] 
	lwz     a0,0(a7)
	addi    a7,a7,4
	line	33
;#  adda.l      #ParamSize,SP                          [Line 165] 
	addic   a7,a7,_68_DoUpdate_StackFrame_ParamSize
	line	34
;#  jmp         (A0)                                   [Line 166] 
	mtctr   a0
	bctr    
;#                endp                                 [Line 168]  

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_DoUpdate_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_DoUpdate_PAEND - _68_DoUpdate
	dc.w	8
	dc.b	'DoUpdate'
	align	2
	align	2
	endf	168


###############################
# DoMenuCommand               #
###############################
;#DoMenuCommand   proc                                 [Line 177]  
	csect	PCcsect[pr]
	align	2
	export	DoMenuCommand__
DoMenuCommand__:
	function	DoMenuCommand__,DoMenuCommand__,16,044
	beginf	177
	nop
	dc.l	0
	dc.l	0
_68_DoMenuCommand:

;#StackFrame      record  {A6Link},DECR                [Line 179]  
_68_DoMenuCommand_StackFrame: equ 12
_68_DoMenuCommand_StackFrame_ParamBegin:  equ   12
_68_DoMenuCommand_StackFrame_MenuItem: equ 10
_68_DoMenuCommand_StackFrame_MenuID: equ 8
_68_DoMenuCommand_StackFrame_ParamSize:  equ   _68_DoMenuCommand_StackFrame_ParamBegin-8
_68_DoMenuCommand_StackFrame_RetAddr: equ 4
_68_DoMenuCommand_StackFrame_A6Link: equ 0
_68_DoMenuCommand_StackFrame_Deskname: equ -256
_68_DoMenuCommand_StackFrame_TempPort: equ -260
_68_DoMenuCommand_StackFrame_Item: equ -262
_68_DoMenuCommand_StackFrame_LocalSize:  equ   -262
;#                endr                                 [Line 190]  


	import	_68_Terminate
	import	_68_ClearVirtualWin
# Value of _68_PolyWindow set from include file
# Value of _68_DialogPtr set from include file
# Value of _68_RealWindow set from include file
# Value of _68_VirtualWindow set from include file
;#                with    StackFrame                   [Line 200]  
	line	25
;#  link        A6,#LocalSize                          [Line 201] 
	stwu    a6,-4(a7)
	mr      a6,a7
	addic   a7,a7,_68_DoMenuCommand_StackFrame_LocalSize
	line	27
;#  move.w      MenuID(A6),D0                          [Line 203] 
	lha     d0,_68_DoMenuCommand_StackFrame_MenuID(a6)
	line	28
;#  cmpi        #AppleMenu,D0               EQ         [Line 204] 
	subic   RX,d0,_68_AppleMenu
	extsh.  RX,RX
	line	29
;#  beq.w       DoAppleMenu                            [Line 205] 
	beq     _68_DoMenuCommand_DoAppleMenu
	line	30
;#  cmpi        #FileMenu,D0                EQ         [Line 206] 
	subic   RX,d0,_68_FileMenu
	extsh.  RX,RX
	line	31
;#  beq.w       DoFileMenu                             [Line 207] 
	beq     _68_DoMenuCommand_DoFileMenu
	line	32
;#  cmpi        #EditMenu,D0                EQ         [Line 208] 
	subic   RX,d0,_68_EditMenu
	extsh.  RX,RX
	line	33
;#  beq.w       DoEditMenu                             [Line 209] 
	beq     _68_DoMenuCommand_DoEditMenu
	line	34
;#  cmpi        #ColorMenu,D0               EQ         [Line 210] 
	subic   RX,d0,_68_ColorMenu
	extsh.  RX,RX
	line	35
;#  beq.w       DoColorMenu                            [Line 211] 
	beq     _68_DoMenuCommand_DoColorMenu
	line	36
;#  cmpi        #RandomMenu,D0              EQ         [Line 212] 
	subic   RX,d0,_68_RandomMenu
	extsh.  RX,RX
	line	37
;#  beq.w       DoRandomMenu                           [Line 213] 
	beq     _68_DoMenuCommand_DoRandomMenu
	line	38
;#  cmpi        #SoundMenu,D0               EQ         [Line 214] 
	subic   RX,d0,_68_SoundMenu
	extsh.  RX,RX
	line	39
;#  beq.w       DoSoundMenu                            [Line 215] 
	beq     _68_DoMenuCommand_DoSoundMenu
	line	41
;#  bra.w       Exit                                   [Line 217] 
	b       _68_DoMenuCommand_Exit
_68_DoMenuCommand_DoAppleMenu:
	line	45
;#  cmpi.w      #AboutItem,MenuItem(A6)     NE         [Line 221] 
	lha     RU,_68_DoMenuCommand_StackFrame_MenuItem(a6)
	subic   RX,RU,_68_AboutItem
	extsh.  RX,RX
	line	46
;#  bne.s       @1                                     [Line 222] 
	bne     _at_1_9665
	line	48
;#  move.l      DialogPtr,PolyWindow                   [Line 224] 
	lwz     RV,_68_DialogPtr(a5)
	stw     RV,_68_PolyWindow(a5)
	line	49
;#  move.l      DialogPtr,-(SP)                        [** Line 225]
	lwz     R3,_68_DialogPtr(a5)
	line	50
;#  _showwindow                                        [** Line 226]
	import	.ShowWindow[PR]
	bl	.ShowWindow[PR]
	nop
	line	51
;#  move.l      DialogPtr,-(SP)                        [** Line 227]
	lwz     R3,_68_DialogPtr(a5)
	line	52
;#  _bringtofront                                      [** Line 228]
	import	.BringToFront[PR]
	bl	.BringToFront[PR]
	nop
	line	54
;#  clr.l       -(SP)                                  [** Line 230]
	lil     R3,0
	line	55
;#  pea         Item(A6)                               [** Line 231]
	addi    R4,a6,_68_DoMenuCommand_StackFrame_Item
	line	56
;#  _modaldialog                                       [** Line 232]
	import	.ModalDialog[PR]
	bl	.ModalDialog[PR]
	nop
	line	58
;#  move.l      DialogPtr,-(SP)                        [** Line 234]
	lwz     R3,_68_DialogPtr(a5)
	line	59
;#  _hidewindow                                        [** Line 235]
	import	.HideWindow[PR]
	bl	.HideWindow[PR]
	nop
	line	61
;#  move.l      VirtualWindow,PolyWindow               [Line 237] 
	lwz     RV,_68_VirtualWindow(a5)
	stw     RV,_68_PolyWindow(a5)
	line	63
;#  bra.w       Exit                                   [Line 239] 
	b       _68_DoMenuCommand_Exit
	line	65
_at_1_9665:
;#  clr.l       -(SP)                                  [Line 241] 
	stwu    RZero,-4(a7)
	line	66
;#  move.w      #AppleMenu,-(SP)                       [** Line 242]
	lil     R3,_68_AppleMenu
	line	67
;#  _getmhandle                                        [** Line 243]
	import	.GetMenuHandle[PR]
	bl	.GetMenuHandle[PR]
	nop
	stwu	R3,0(a7)
	line	68
;#  move.w      MenuItem(A6),-(SP)                     [Line 244] 
	lha     RV,_68_DoMenuCommand_StackFrame_MenuItem(a6)
	sthu    RV,-2(a7)
	line	69
;#  pea         DeskName(A6)                           [Line 245] 
	addi    RV,a6,_68_DoMenuCommand_StackFrame_Deskname
	stwu    RV,-4(a7)
	line	70
;#  _getitem                                           [Line 246] 
	lwz	R5,0(a7)
	lha	R4,4(a7)
	lwz	R3,6(a7)
	import	.GetMenuItemText[PR]
	bl	.GetMenuItemText[PR]
	nop
	addi	a7,a7,10
	line	71
;#  clr.w       -(SP)                                  [** Line 247]
	# Glue Optimisation - Don't need result space
	line	72
;#  pea         DeskName(A6)                           [** Line 248]
	addi    R3,a6,_68_DoMenuCommand_StackFrame_Deskname
	line	73
;#  _opendeskacc                                       [** Line 249]
	import	.OpenDeskAcc[PR]
	bl	.OpenDeskAcc[PR]
	nop
	line	74
;#  move.w      (SP)+,D0                               [** Line 250]
	mr      d0,R3
	line	76
;#  bra.w       Exit                                   [Line 252] 
	b       _68_DoMenuCommand_Exit
_68_DoMenuCommand_DoFileMenu:
	line	80
;#  move.w      MenuItem(A6),D0                        [Line 256] 
	lha     d0,_68_DoMenuCommand_StackFrame_MenuItem(a6)
	line	81
;#  cmpi        #NewItem,D0                 EQ         [Line 257] 
	subic   RX,d0,_68_NewItem
	extsh.  RX,RX
	line	82
;#  beq.w       FIleNew                                [Line 258] 
	beq     _68_DoMenuCommand_FileNew
	line	83
;#  cmpi        #QuitItem,D0                EQ         [Line 259] 
	subic   RX,d0,_68_QuitItem
	extsh.  RX,RX
	line	84
;#  beq.w       FIleQuit                               [Line 260] 
	beq     _68_DoMenuCommand_FileQuit
	line	86
;#  bra.w       Exit                                   [Line 262] 
	b       _68_DoMenuCommand_Exit
_68_DoMenuCommand_FileNew:
	line	88
;#  bsr         ClearVirtualWin                        [Line 264] 
	bl      _PACallGlue
	bl      _68_ClearVirtualWin
	line	89
;#  movea.l     PolyWindow,A0                          [Line 265] 
	lwz     a0,_68_PolyWindow(a5)
	line	90
;#  pea         portRect(A0)                           [** Line 266]
	addi    R3,a0,_68_portRect
	line	91
;#  _invalrect                                         [** Line 267]
	import	.InvalRect[PR]
	bl	.InvalRect[PR]
	nop
	line	92
;#  bra.w       Exit                                   [Line 268] 
	b       _68_DoMenuCommand_Exit
_68_DoMenuCommand_FileQuit:
	line	95
;#  bsr         Terminate                              [Line 271] 
	bl      _PACallGlue
	bl      _68_Terminate
	line	96
;#  bra         Exit                                   [Line 272] 
	b       _68_DoMenuCommand_Exit
_68_DoMenuCommand_DoEditMenu:
	line	100
;#  clr.w       -(SP)                                  [Line 276] 
	sthu    RZero,-2(a7)
	line	101
;#  move.w      MenuItem(A6),-(SP)                     [Line 277] 
	lha     RV,_68_DoMenuCommand_StackFrame_MenuItem(a6)
	sthu    RV,-2(a7)
	line	102
;#  subq.w      #1,(SP)                                [Line 278] 
	lha     RU,0(a7)
	subic   RU,RU,1
	sth     RU,0(a7)
	line	103
;#  _sysedit                                           [Line 279] 
	lha	R3,0(a7)
	import	.SystemEdit[PR]
	bl	.SystemEdit[PR]
	nop
	stbu	R3,2(a7)
	line	104
;#  move.b      (SP)+,D0                               [Line 280] 
	lbz     d0,0(a7)
	addi    a7,a7,2
	line	105
;#  bra         Exit                                   [Line 281] 
	b       _68_DoMenuCommand_Exit
_68_DoMenuCommand_DoColorMenu:
	line	109
;#  move.w      MenuItem(A6),D3                        [Line 285]  Preserve d3.l
	lha     RT,_68_DoMenuCommand_StackFrame_MenuItem(a6)
	rlwimi  d3,RT,0,0x0000ffff  # (H)
	line	110
;#  cmp.w       #0,D3                       EQ         [Line 286] 
	subic   RX,d3,0
	extsh.  RX,RX
	line	111
;#  beq         Exit                                   [Line 287] 
	beq     _68_DoMenuCommand_Exit
	line	112
;#  cmp.w       #7,D3                       GT         [Line 288] 
	extsh   RT,d3               # (S)
	cmpi    0,RT,7
	line	113
;#  bgt.w       Exit                                   [Line 289] 
	bgt     _68_DoMenuCommand_Exit
	line	115
;#  move.l      ThePolygon,A0                          [Line 291] 
	lwz     a0,_68_ThePolygon(a5)
	line	116
;#  cmp.w       MyPoly.color(A0),D3         EQ         [Line 292] 
	lha     RV,_68_MyPoly_color(a0)
	subfc   RX,RV,d3
	extsh.  RX,RX
	line	117
;#  beq.w       Exit                                   [Line 293] 
	beq     _68_DoMenuCommand_Exit
	line	119
;#  move.w      MyPoly.color(A0),G.OldColor            [Line 295] 
	lha     RV,_68_MyPoly_color(a0)
	sth     RV,_68_G_OldColor(a5)
	line	120
;#  move.w      D3,MyPoly.color(A0)                    [Line 296] 
	sth     d3,_68_MyPoly_color(a0)
	line	121
;#  bra.w       Exit                                   [Line 297] 
	b       _68_DoMenuCommand_Exit
_68_DoMenuCommand_DoRandomMenu:
	line	125
;#  move.w      MenuItem(A6),D0                        [Line 301] 
	lha     d0,_68_DoMenuCommand_StackFrame_MenuItem(a6)
	line	126
;#  cmpi        #ColorItem,D0               EQ         [Line 302] 
	subic   RX,d0,_68_ColorItem
	extsh.  RX,RX
	line	127
;#  beq.w       RandColor                              [Line 303] 
	beq     _68_DoMenuCommand_RandColor
	line	128
;#  cmpi        #PolyItem,D0                EQ         [Line 304] 
	subic   RX,d0,_68_PolyItem
	extsh.  RX,RX
	line	129
;#  beq.w       RandPoly                               [Line 305] 
	beq     _68_DoMenuCommand_RandPoly
	line	130
;#  cmpi        #DirectionItem,D0           EQ         [Line 306] 
	subic   RX,d0,_68_DirectionItem
	extsh.  RX,RX
	line	131
;#  beq.w       RandDirection                          [Line 307] 
	beq     _68_DoMenuCommand_RandDirection
	line	133
;#  bra.s       Exit                                   [Line 309] 
	b       _68_DoMenuCommand_Exit
	line	135
_68_DoMenuCommand_RandColor:
;#  clr.l       -(SP)                                  [Line 311] 
	stwu    RZero,-4(a7)
	line	136
;#  move.w      #ColorMenu,-(SP)                       [** Line 312]
	lil     R3,_68_ColorMenu
	line	137
;#  _getmhandle                                        [** Line 313]
	import	.GetMenuHandle[PR]
	bl	.GetMenuHandle[PR]
	nop
	stwu	R3,0(a7)
	line	138
;#  move.w      #0,-(SP)                               [Line 314] 
	sthu    RZero,-2(a7)
	line	140
;#  move.l      ThePolygon,A0                          [Line 316] 
	lwz     a0,_68_ThePolygon(a5)
	line	141
;#  eori.b      #1,MyPoly.randColors(A0)               [Line 317] 
	lbz     RU,_68_MyPoly_randColors(a0)
	xori    RU,RU,(1)&0xffff
	stb     RU,_68_MyPoly_randColors(a0)
	line	142
;#  move.w      MyPoly.color(A0),G.OldColor            [Line 318] 
	lha     RV,_68_MyPoly_color(a0)
	sth     RV,_68_G_OldColor(a5)
	line	143
;#  cmpi.b      #1,MyPoly.randColors(A0)    NE         [Line 319] 
	lbz     RU,_68_MyPoly_randColors(a0)
	subic   RX,RU,1
	extsb.  RX,RX
	line	144
;#  bne.s       @1                                     [Line 320] 
	bne     _at_1_9732
	line	145
;#  _disableitem                                       [Line 321] 
	lha	R4,0(a7)
	lwz	R3,2(a7)
	import	.DisableItem[PR]
	bl	.DisableItem[PR]
	nop
	addi	a7,a7,6
	line	146
;#  _drawmenubar                                       [Line 322] 
	import	.DrawMenuBar[PR]
	bl	.DrawMenuBar[PR]
	nop
	line	147
;#  bra.s       Exit                                   [Line 323] 
	b       _68_DoMenuCommand_Exit
	line	149
_at_1_9732:
;#  _enableitem                                        [Line 325] 
	lha	R4,0(a7)
	lwz	R3,2(a7)
	import	.EnableItem[PR]
	bl	.EnableItem[PR]
	nop
	addi	a7,a7,6
	line	150
;#  _drawmenubar                                       [Line 326] 
	import	.DrawMenuBar[PR]
	bl	.DrawMenuBar[PR]
	nop
	line	151
;#  bra.s       Exit                                   [Line 327] 
	b       _68_DoMenuCommand_Exit
	line	153
_68_DoMenuCommand_RandPoly:
;#  move.l      ThePolygon,A0                          [Line 329] 
	lwz     a0,_68_ThePolygon(a5)
	line	154
;#  eori.b      #1,MyPoly.randPoly(A0)                 [Line 330] 
	lbz     RU,_68_MyPoly_randPoly(a0)
	xori    RU,RU,(1)&0xffff
	stb     RU,_68_MyPoly_randPoly(a0)
	line	155
;#  bra.s       Exit                                   [Line 331] 
	b       _68_DoMenuCommand_Exit
	line	157
_68_DoMenuCommand_RandDirection:
;#  move.l      ThePolygon,A0                          [Line 333] 
	lwz     a0,_68_ThePolygon(a5)
	line	158
;#  eori.b      #1,MyPoly.randDirection(A0)            [Line 334] 
	lbz     RU,_68_MyPoly_randDirection(a0)
	xori    RU,RU,(1)&0xffff
	stb     RU,_68_MyPoly_randDirection(a0)
	line	159
;#  bra.s       Exit                                   [Line 335] 
	b       _68_DoMenuCommand_Exit
_68_DoMenuCommand_DoSoundMenu:
	line	163
;#  move.w      MenuItem(A6),D0                        [Line 339] 
	lha     d0,_68_DoMenuCommand_StackFrame_MenuItem(a6)
	line	164
;#  cmpi        #SoundOffItem,D0            EQ         [Line 340] 
	subic   RX,d0,_68_SoundOffItem
	extsh.  RX,RX
	line	165
;#  beq.w       SoundOff                               [Line 341] 
	beq     _68_DoMenuCommand_SoundOff
	line	166
;#  cmpi        #SoundOnItem,D0             EQ         [Line 342] 
	subic   RX,d0,_68_SoundOnItem
	extsh.  RX,RX
	line	167
;#  beq.w       SoundOn                                [Line 343] 
	beq     _68_DoMenuCommand_SoundOn
	line	169
;#  bra.s       Exit                                   [Line 345] 
	b       _68_DoMenuCommand_Exit
	line	171
_68_DoMenuCommand_SoundOff:
;#  move.b      #FALSE,G.SoundMode                     [Line 347] 
	stb     RZero,_68_G_SoundMode(a5)
	line	172
;#  bra.s       Exit                                   [Line 348] 
	b       _68_DoMenuCommand_Exit
	line	174
_68_DoMenuCommand_SoundOn:
;#  move.b      #TRUE,G.SoundMode                      [Line 350] 
	lil     RV,(_68_true)&0x00ff
	stb     RV,_68_G_SoundMode(a5)
	line	176
_68_DoMenuCommand_Exit:
;#  clr.w       -(SP)                                  [** Line 352]
	lil     R3,0
	line	177
;#  _hilitemenu                                        [** Line 353]
	import	.HiliteMenu[PR]
	bl	.HiliteMenu[PR]
	nop
	line	178
;#  unlk        A6                                     [Line 354] 
	addic   a7,a6,4
	lwz     a6,0(a6)
	line	179
;#  movea.l     (SP)+,A0                               [Line 355] 
	lwz     a0,0(a7)
	addi    a7,a7,4
	line	180
;#  adda.l      #ParamSize,SP                          [Line 356] 
	addic   a7,a7,_68_DoMenuCommand_StackFrame_ParamSize
	line	181
;#  jmp         (A0)                                   [Line 357] 
	mtctr   a0
	bctr    
;#                endp                                 [Line 359]  

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_DoMenuCommand_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_DoMenuCommand_PAEND - _68_DoMenuCommand
	dc.w	13
	dc.b	'DoMenuCommand'
	align	2
	align	2
	endf	359


###############################
# DoMouseDown                 #
###############################
;#DoMouseDown     proc    ENTRY                        [Line 371]  
	csect	PCcsect[pr]
	align	2
	export	DoMouseDown__
DoMouseDown__:
	function	DoMouseDown__,DoMouseDown__,16,044
	beginf	371
	nop
	dc.l	0
	dc.l	0
_68_DoMouseDown:

;#StackFrame      record  {A6Link},DECR                [Line 373]  
_68_DoMouseDown_StackFrame: equ 12
_68_DoMouseDown_StackFrame_ParamBegin:  equ   12
_68_DoMouseDown_StackFrame_EventPtr: equ 8
_68_DoMouseDown_StackFrame_ParamSize:  equ   _68_DoMouseDown_StackFrame_ParamBegin-8
_68_DoMouseDown_StackFrame_RetAddr: equ 4
_68_DoMouseDown_StackFrame_A6Link: equ 0
_68_DoMouseDown_StackFrame_WindowPtr: equ -4
_68_DoMouseDown_StackFrame_Where: equ -8
_68_DoMouseDown_StackFrame_NewGrowRect: equ -16
_68_DoMouseDown_StackFrame_NewGrowRect_top: equ _68_DoMouseDown_StackFrame_NewGrowRect + 0
_68_DoMouseDown_StackFrame_NewGrowRect_left: equ _68_DoMouseDown_StackFrame_NewGrowRect + 2
_68_DoMouseDown_StackFrame_NewGrowRect_bottom: equ _68_DoMouseDown_StackFrame_NewGrowRect + 4
_68_DoMouseDown_StackFrame_NewGrowRect_right: equ _68_DoMouseDown_StackFrame_NewGrowRect + 6
_68_DoMouseDown_StackFrame_NewGrowRect_topLeft: equ _68_DoMouseDown_StackFrame_NewGrowRect + 0
_68_DoMouseDown_StackFrame_NewGrowRect_topLeft_v: equ _68_DoMouseDown_StackFrame_NewGrowRect_topLeft + 0
_68_DoMouseDown_StackFrame_NewGrowRect_topLeft_h: equ _68_DoMouseDown_StackFrame_NewGrowRect_topLeft + 2
_68_DoMouseDown_StackFrame_NewGrowRect_topLeft_size: equ _68_DoMouseDown_StackFrame_NewGrowRect_topLeft + 4
_68_DoMouseDown_StackFrame_NewGrowRect_botRight: equ _68_DoMouseDown_StackFrame_NewGrowRect + 4
_68_DoMouseDown_StackFrame_NewGrowRect_botRight_v: equ _68_DoMouseDown_StackFrame_NewGrowRect_botRight + 0
_68_DoMouseDown_StackFrame_NewGrowRect_botRight_h: equ _68_DoMouseDown_StackFrame_NewGrowRect_botRight + 2
_68_DoMouseDown_StackFrame_NewGrowRect_botRight_size: equ _68_DoMouseDown_StackFrame_NewGrowRect_botRight + 4
_68_DoMouseDown_StackFrame_NewGrowRect_size: equ _68_DoMouseDown_StackFrame_NewGrowRect + 8
_68_DoMouseDown_StackFrame_LocalSize:  equ   -16
;#                endr                                 [Line 383]  


;#                with    StackFrame                   [Line 387]  
	line	18
;#  link        A6,#LocalSize                          [Line 388] 
	stwu    a6,-4(a7)
	mr      a6,a7
	addic   a7,a7,_68_DoMouseDown_StackFrame_LocalSize
	line	20
;#  movea.l     EventPtr(A6),A0                        [Line 390] 
	lwz     a0,_68_DoMouseDown_StackFrame_EventPtr(a6)
	line	21
;#  move.l      evtMouse(A0),Where(A6)                 [Line 391] 
	lwz     RV,_68_evtMouse(a0)
	stw     RV,_68_DoMouseDown_StackFrame_Where(a6)
	line	23
;#  clr.w       -(SP)                                  [** Line 393]
	# Glue Optimisation - Don't need result space
	line	24
;#  move.l      Where(A6),-(SP)                        [** Line 394]
	lwz     R3,_68_DoMouseDown_StackFrame_Where(a6)
	line	25
;#  pea         WindowPtr(A6)                          [** Line 395]
	addi    R4,a6,_68_DoMouseDown_StackFrame_WindowPtr
	line	26
;#  _findwindow                                        [** Line 396]
	import	.FindWindow[PR]
	bl	.FindWindow[PR]
	nop
	line	27
;#  move.w      (SP)+,D0                               [** Line 397] Preserve d0.l
	mr      d0,R3
	line	28
;#  cmpi        #InMenuBar,D0               EQ         [Line 398] 
	subic   RX,d0,_68_inMenuBar
	extsh.  RX,RX
	line	29
;#  beq.w       MenuEvent                              [Line 399] 
	beq     _68_DoMouseDown_MenuEvent
	line	30
;#  cmpi        #InSysWindow,D0             EQ         [Line 400] 
	subic   RX,d0,_68_inSysWindow
	extsh.  RX,RX
	line	31
;#  beq.w       SystemEvent                            [Line 401] 
	beq     _68_DoMouseDown_SystemEvent
	line	32
;#  cmpi        #InContent,D0               EQ         [Line 402] 
	subic   RX,d0,_68_inContent
	extsh.  RX,RX
	line	33
;#  beq.w       Content                                [Line 403] 
	beq     _68_DoMouseDown_Content
	line	34
;#  cmpi        #InDrag,D0                  EQ         [Line 404] 
	subic   RX,d0,_68_inDrag
	extsh.  RX,RX
	line	35
;#  beq.w       Drag                                   [Line 405] 
	beq     _68_DoMouseDown_Drag
	line	36
;#  cmpi        #InGoAway,D0                EQ         [Line 406] 
	subic   RX,d0,_68_inGoAway
	extsh.  RX,RX
	line	37
;#  beq.w       GoAway                                 [Line 407] 
	beq     _68_DoMouseDown_GoAway
	line	39
;#  bra.s       Exit                                   [Line 409] 
	b       _68_DoMouseDown_Exit
_68_DoMouseDown_MenuEvent:
	line	42
;#  bsr.w       AdjustMenus                            [Line 412] 
	bl      _PACallGlue
	bl      _68_AdjustMenus
	line	43
;#  clr.l       -(SP)                                  [Line 413] 
	stwu    RZero,-4(a7)
	line	44
;#  move.l      Where(A6),-(SP)                        [** Line 414]
	lwz     R3,_68_DoMouseDown_StackFrame_Where(a6)
	line	45
;#  _menuselect                                        [** Line 415]
	import	.MenuSelect[PR]
	bl	.MenuSelect[PR]
	nop
	stwu	R3,0(a7)
	line	46
;#  bsr         DoMenuCommand                          [Line 416]  Preserve d3.l
	bl      _PACallGlue
	bl      _68_DoMenuCommand
	line	47
;#  bra.s       Exit                                   [Line 417] 
	b       _68_DoMouseDown_Exit
_68_DoMouseDown_SystemEvent:
	line	50
;#  move.l      EventPtr(A6),-(SP)                     [** Line 420]
	lwz     R3,_68_DoMouseDown_StackFrame_EventPtr(a6)
	line	51
;#  move.l      WindowPtr(A6),-(SP)                    [** Line 421]
	lwz     R4,_68_DoMouseDown_StackFrame_WindowPtr(a6)
	line	52
;#  _systemclick                                       [** Line 422]
	import	.SystemClick[PR]
	bl	.SystemClick[PR]
	nop
	line	53
;#  bra.s       Exit                                   [Line 423] 
	b       _68_DoMouseDown_Exit
_68_DoMouseDown_Content:
	line	57
;#  clr.l       -(SP)                                  [** Line 427]
	# Glue Optimisation - Don't need result space
	line	58
;#  _frontwindow                                       [** Line 428]
	import	.FrontWindow[PR]
	bl	.FrontWindow[PR]
	nop
	line	59
;#  move.l      (SP)+,D0                               [** Line 429]
	mr      d0,R3
	line	60
;#  cmp.l       WindowPtr(A6),D0            NE         [Line 430] 
	lwz     RV,_68_DoMouseDown_StackFrame_WindowPtr(a6)
	cmp     0,d0,RV
	line	61
;#  bne.s       @1                                     [Line 431] 
	bne     _at_1_9811
	line	63
;#  bra.s       Exit                                   [Line 433] 
	b       _68_DoMouseDown_Exit
	line	65
_at_1_9811:
;#  move.l      WindowPtr(A6),-(SP)                    [** Line 435]
	lwz     R3,_68_DoMouseDown_StackFrame_WindowPtr(a6)
	line	66
;#  _selectwindow                                      [** Line 436]
	import	.SelectWindow[PR]
	bl	.SelectWindow[PR]
	nop
	line	67
;#  bra.s       Exit                                   [Line 437] 
	b       _68_DoMouseDown_Exit
	line	69
;#  bra.s       Exit                                   [Line 439] 
	b       _68_DoMouseDown_Exit
_68_DoMouseDown_GoAway:
	line	73
;#  bsr         Terminate                              [Line 443] 
	bl      _PACallGlue
	bl      _68_Terminate
	line	74
;#  bra.s       Exit                                   [Line 444] 
	b       _68_DoMouseDown_Exit
_68_DoMouseDown_Drag:
	line	78
;#  move.l      WindowPtr(A6),-(SP)                    [** Line 448]
	lwz     R3,_68_DoMouseDown_StackFrame_WindowPtr(a6)
	line	79
;#  move.l      Where(A6),-(SP)                        [** Line 449]
	lwz     R4,_68_DoMouseDown_StackFrame_Where(a6)
	line	80
;#  pea         QD.Screenbits.bounds                   [** Line 450]
	addi    R5,a5,_68_QD_ScreenBits_bounds
	line	81
;#  _dragwindow                                        [** Line 451]
	import	.DragWindow[PR]
	bl	.DragWindow[PR]
	nop
_68_DoMouseDown_Exit:
	line	84
;#  unlk        A6                                     [Line 454] 
	addic   a7,a6,4
	lwz     a6,0(a6)
	line	85
;#  movea.l     (SP)+,A0                               [Line 455] 
	lwz     a0,0(a7)
	addi    a7,a7,4
	line	86
;#  adda.l      #ParamSize,SP                          [Line 456] 
	addic   a7,a7,_68_DoMouseDown_StackFrame_ParamSize
	line	87
;#  jmp         (A0)                                   [Line 457] 
	mtctr   a0
	bctr    
;#                endp                                 [Line 459]  

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_DoMouseDown_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_DoMouseDown_PAEND - _68_DoMouseDown
	dc.w	11
	dc.b	'DoMouseDown'
	align	2
	align	2
	endf	459


###############################
# DoEvent                     #
###############################
;#DoEvent         proc                                 [Line 471]  
	csect	PCcsect[pr]
	align	2
	export	DoEvent__
DoEvent__:
	function	DoEvent__,DoEvent__,16,044
	beginf	471
	nop
	dc.l	0
	dc.l	0
_68_DoEvent:

;#StackFrame      record  {A6Link},DECR                [Line 473]  
_68_DoEvent_StackFrame: equ 12
_68_DoEvent_StackFrame_ParamBegin:  equ   12
_68_DoEvent_StackFrame_EventPtr: equ 8
_68_DoEvent_StackFrame_ParamSize:  equ   _68_DoEvent_StackFrame_ParamBegin-8
_68_DoEvent_StackFrame_RetAddr: equ 4
_68_DoEvent_StackFrame_A6Link: equ 0
_68_DoEvent_StackFrame_TheEvent: equ -16
_68_DoEvent_StackFrame_TheEvent_what: equ _68_DoEvent_StackFrame_TheEvent + 0
_68_DoEvent_StackFrame_TheEvent_message: equ _68_DoEvent_StackFrame_TheEvent + 2
_68_DoEvent_StackFrame_TheEvent_when: equ _68_DoEvent_StackFrame_TheEvent + 6
_68_DoEvent_StackFrame_TheEvent_where: equ _68_DoEvent_StackFrame_TheEvent + 10
_68_DoEvent_StackFrame_TheEvent_where_v: equ _68_DoEvent_StackFrame_TheEvent_where + 0
_68_DoEvent_StackFrame_TheEvent_where_h: equ _68_DoEvent_StackFrame_TheEvent_where + 2
_68_DoEvent_StackFrame_TheEvent_where_size: equ _68_DoEvent_StackFrame_TheEvent_where + 4
_68_DoEvent_StackFrame_TheEvent_modifiers: equ _68_DoEvent_StackFrame_TheEvent + 14
_68_DoEvent_StackFrame_TheEvent_size: equ _68_DoEvent_StackFrame_TheEvent + 16
_68_DoEvent_StackFrame_LocalSize:  equ   -16
;#                endr                                 [Line 481]  


;#                with    StackFrame,TheEvent          [Line 483]  
	line	14
;#  link        A6,#LocalSize                          [Line 484] 
	stwu    a6,-4(a7)
	mr      a6,a7
	addic   a7,a7,_68_DoEvent_StackFrame_LocalSize
	line	15
;#  move.l      D4,-(SP)                               [Line 485] 
	stwu    d4,-4(a7)
	line	17
;#  movea.l     EventPtr(A6),A0                        [Line 487] 
	lwz     a0,_68_DoEvent_StackFrame_EventPtr(a6)
	line	18
;#  lea         TheEvent(A6),A1                        [Line 488] 
	addi    a1,a6,_68_DoEvent_StackFrame_TheEvent
	line	19
;#  move.l      #evtBlkSize,D0                         [** Line 489]
	lil     R5,_68_evtBlkSize
	line	20
;#  _blockmove                                         [** Line 490]
	mr	R3,a0
	mr	R4,a1
	import	.BlockMove[PR]
	bl	.BlockMove[PR]
	nop
	line	22
;#  move.w      Modifiers(A6),D4                       [Line 492] 
	lha     d4,_68_DoEvent_StackFrame_TheEvent_modifiers(a6)
	line	24
;#  move.w      What(A6),D0                            [Line 494]  Preserve d0.l
	lha     RT,_68_DoEvent_StackFrame_TheEvent_what(a6)
	rlwimi  d0,RT,0,0x0000ffff  # (H)
	line	26
;#  cmpi        #1,D0                       EQ         [Line 496] 
	subic   RX,d0,1
	extsh.  RX,RX
	line	27
;#  beq         MouseDownEvent                         [Line 497] 
	beq     _68_DoEvent_MouseDownEvent
	line	29
;#  cmpi        #3,D0                       EQ         [Line 499] 
	subic   RX,d0,3
	extsh.  RX,RX
	line	30
;#  beq.w       KeyDownEvent                           [Line 500] 
	beq     _68_DoEvent_KeyDownEvent
	line	32
;#  cmpi        #4,D0                       EQ         [Line 502] 
	subic   RX,d0,4
	extsh.  RX,RX
	line	33
;#  beq.w       KeyDownEvent                           [Line 503] 
	beq     _68_DoEvent_KeyDownEvent
	line	34
;#  cmpi        #6,D0                       EQ         [Line 504] 
	subic   RX,d0,6
	extsh.  RX,RX
	line	35
;#  beq.w       UpdateEvent                            [Line 505] 
	beq     _68_DoEvent_UpdateEvent
	line	36
;#  cmpi        #7,D0                       EQ         [Line 506] 
	subic   RX,d0,7
	extsh.  RX,RX
	line	37
;#  beq.w       DiskEvent                              [Line 507] 
	beq     _68_DoEvent_DiskEvent
_68_DoEvent_MouseDownEvent:
	line	49
;#  pea         TheEvent(A6)                           [Line 519] 
	addi    RV,a6,_68_DoEvent_StackFrame_TheEvent
	stwu    RV,-4(a7)
	line	50
;#  bsr         DoMouseDown                            [Line 520]  Preserve d3.l
	bl      _PACallGlue
	bl      _68_DoMouseDown
	line	51
;#  bra         Exit                                   [Line 521] 
	b       _68_DoEvent_Exit
_68_DoEvent_KeyDownEvent:
	line	55
;#  btst        #CmdKey,D4                  EQ         [Line 525] 
	rlwinm  RX,d4,(32-_68_cmdKey)&0x1f,0x00000001
	cmpi    7,RX,0
	cror    CR0_EQ,CR7_EQ,CR7_EQ
	line	56
;#  beq         Exit                                   [Line 526] 
	beq     _68_DoEvent_Exit
	line	57
;#  bsr.w       AdjustMenus                            [Line 527] 
	bl      _PACallGlue
	bl      _68_AdjustMenus
	line	58
;#  clr.l       -(SP)                                  [Line 528] 
	stwu    RZero,-4(a7)
	line	59
;#  move.w      2+Message(A6),-(SP)                    [** Line 529]
	lha     R3,(2+_68_DoEvent_StackFrame_TheEvent_message)(a6)
	line	60
;#  _menukey                                           [** Line 530]
	import	.MenuKey[PR]
	bl	.MenuKey[PR]
	nop
	stwu	R3,0(a7)
	line	61
;#  bsr         DoMenuCommand                          [Line 531]  Preserve d3.l
	bl      _PACallGlue
	bl      _68_DoMenuCommand
	line	62
;#  bra.w       Exit                                   [Line 532] 
	b       _68_DoEvent_Exit
_68_DoEvent_UpdateEvent:
	line	66
;#  move.l      Message(A6),-(SP)                      [Line 536] 
	lwz     RV,_68_DoEvent_StackFrame_TheEvent_message(a6)
	stwu    RV,-4(a7)
	line	67
;#  bsr         DoUpdate                               [Line 537] 
	bl      _PACallGlue
	bl      _68_DoUpdate
	line	68
;#  bra.s       Exit                                   [Line 538] 
	b       _68_DoEvent_Exit
_68_DoEvent_DiskEvent:
	line	73
;#  tst.w       Message(A6)                 EQ         [Line 543] 
	lha     RV,_68_DoEvent_StackFrame_TheEvent_message(a6)
	extsh.  RX,RV
	line	74
;#  beq.s       Exit                                   [Line 544] 
	beq     _68_DoEvent_Exit
	line	75
;#  clr.w       -(SP)                                  [** Line 545]
	# Glue Optimisation - Don't need result space
	line	76
;#  move.l      #DITopLeft,-(SP)                       [** Line 546]
	liu     R3,(_68_DITopLeft>>16)&0xffff
	ori     R3,R3,(_68_DITopLeft)&0xffff
	line	77
;#  move.l      Message(A6),-(SP)                      [** Line 547]
	lwz     R4,_68_DoEvent_StackFrame_TheEvent_message(a6)
	line	78
;#  move.w      #diBadMount,-(SP)                      [** Line 548]
	# Glue optimisation - selector not required
	line	79
;#  _pack2                                             [** Line 549]
	import	.DIBadMount[PR]
	bl	.DIBadMount[PR]
	nop
	line	80
;#  addq        #2,SP                                  [** Line 550]
	;# Glue optimisation - instruction not required
_68_DoEvent_Exit:
	line	83
;#  move.l      (SP)+,D4                               [Line 553] 
	lwz     d4,0(a7)
	addi    a7,a7,4
	line	84
;#  unlk        A6                                     [Line 554] 
	addic   a7,a6,4
	lwz     a6,0(a6)
	line	85
;#  movea.l     (SP)+,A0                               [Line 555] 
	lwz     a0,0(a7)
	addi    a7,a7,4
	line	86
;#  adda.l      #ParamSize,SP                          [Line 556] 
	addic   a7,a7,_68_DoEvent_StackFrame_ParamSize
	line	87
;#  jmp         (A0)                                   [Line 557] 
	mtctr   a0
	bctr    
;#                endp                                 [Line 559]  

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_DoEvent_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_DoEvent_PAEND - _68_DoEvent
	dc.w	7
	dc.b	'DoEvent'
	align	2
	align	2
	endf	559


###############################
# EventLoop                   #
###############################
;#EventLoop       proc    EXPORT                       [Line 571]  
	csect	PCcsect[pr]
	align	2
	export	_68_EventLoop
	export	EventLoop__
EventLoop__:
	function	EventLoop__,EventLoop__,16,044
	beginf	571
	nop
	dc.l	0
	dc.l	0
_68_EventLoop:

;#StackFrame      record  {A6Link},DECR                [Line 573]  
_68_EventLoop_StackFrame: equ 8
_68_EventLoop_StackFrame_RetAddr: equ 4
_68_EventLoop_StackFrame_A6Link: equ 0
_68_EventLoop_StackFrame_TheEvent: equ -16
_68_EventLoop_StackFrame_TheEvent_what: equ _68_EventLoop_StackFrame_TheEvent + 0
_68_EventLoop_StackFrame_TheEvent_message: equ _68_EventLoop_StackFrame_TheEvent + 2
_68_EventLoop_StackFrame_TheEvent_when: equ _68_EventLoop_StackFrame_TheEvent + 6
_68_EventLoop_StackFrame_TheEvent_where: equ _68_EventLoop_StackFrame_TheEvent + 10
_68_EventLoop_StackFrame_TheEvent_where_v: equ _68_EventLoop_StackFrame_TheEvent_where + 0
_68_EventLoop_StackFrame_TheEvent_where_h: equ _68_EventLoop_StackFrame_TheEvent_where + 2
_68_EventLoop_StackFrame_TheEvent_where_size: equ _68_EventLoop_StackFrame_TheEvent_where + 4
_68_EventLoop_StackFrame_TheEvent_modifiers: equ _68_EventLoop_StackFrame_TheEvent + 14
_68_EventLoop_StackFrame_TheEvent_size: equ _68_EventLoop_StackFrame_TheEvent + 16
_68_EventLoop_StackFrame_LocalSize:  equ   -16
;#                endr                                 [Line 578]  


	import	.AnimateOnePolygon[PR]
	import	_68_SoundPlay
	import	_68_UpdateRealWin
;#                with    StackFrame                   [Line 584]  
	line	15
;#  link        A6,#LocalSize                          [Line 585] 
	stwu    a6,-4(a7)
	mr      a6,a7
	addic   a7,a7,_68_EventLoop_StackFrame_LocalSize
_68_EventLoop_NextEvent:
	line	20
;#  move.l      ThePolygon,-(SP)                       [** Line 590]
	lwz     R3,_68_ThePolygon(a5)
	line	21
;#  jsr         AnimateOnePolygon                      [** Line 591]
	import	.AnimateOnePolygon[PR]
	bl	.AnimateOnePolygon[PR]
	nop
	mr	d0,R3
	line	22
;#  lea         4(SP),SP                               [** Line 592]
	;# Glue optimisation - instruction not required
	line	24
;#  cmp.b       #0,D0                       EQ         [Line 594] 
	subic   RX,d0,0
	extsb.  RX,RX
	line	25
;#  beq         NoBounce                               [Line 595] 
	beq     _68_EventLoop_NoBounce
	line	26
;#  move.b      G.SoundMode,D0              EQ         [Line 596]  Preserve d0.w 
	lbz     RT,_68_G_SoundMode(a5)
	extsb.  RX,RT
	rlwimi  d0,RT,0,0x000000ff  # (H)
	line	27
;#  beq         NoBounce                               [Line 597] 
	beq     _68_EventLoop_NoBounce
	line	30
;#  move.l      ThePolygon,A0                          [Line 600] 
	lwz     a0,_68_ThePolygon(a5)
	line	31
;#  move.l      MyPoly.Ypos(A0),D0                     [Line 601] 
	lwz     d0,_68_MyPoly_Ypos(a0)
	line	32
;#  move.w      G.Height,D1                            [Line 602] 
	lha     d1,_68_G_Height(a5)
	line	33
;#  mulu        #$50,D0                                [Line 603] 
	and     RT,d0,RWord            # (Z)
	mulli   d0,RT,0x50
	line	34
;#  divu        #VIRHEIGHT,D0                          [Line 604] 
	ori     RX,RZero,_68_VIRHEIGHT
	mr      RY,d0
	divwu   d0,d0,RX
	mull    RX,d0,RX
	subfc   RX,RX,RY
	rlwimi  d0,RX,16,0xffff0000
	line	35
;#  andi.l      #$ff,D0                                [Line 605] 
	and     d0,d0,RByte
	line	36
;#  addi.l      #$20,D0                                [Line 606] 
	addic   d0,d0,0x20
	line	37
;#  bsr         SoundPlay                              [Line 607] 
	bl      _PACallGlue
	bl      _68_SoundPlay
_68_EventLoop_NoBounce:
	line	39
;#  _systemtask                                        [Line 609] 
	import	.SystemTask[PR]
	bl	.SystemTask[PR]
	nop
	line	40
;#  clr.w       -(SP)                                  [** Line 610]
	# Glue Optimisation - Don't need result space
	line	41
;#  move.w      #EveryEvent,-(SP)                      [** Line 611]
	lil     R3,_68_everyEvent
	line	42
;#  pea         TheEvent(A6)                           [** Line 612]
	addi    R4,a6,_68_EventLoop_StackFrame_TheEvent
	line	43
;#  _getnextevent                                      [** Line 613]
	import	.GetNextEvent[PR]
	bl	.GetNextEvent[PR]
	nop
	line	44
;#  move.w      (SP)+,D0                    EQ         [** Line 614]
	mr      d0,R3
	extsh.  RX,d0
	line	45
;#  beq.s       NextEvent                              [Line 615] 
	beq     _68_EventLoop_NextEvent
	line	47
_68_EventLoop_GotEvent:
;#  pea         TheEvent(A6)                           [Line 617] 
	addi    RV,a6,_68_EventLoop_StackFrame_TheEvent
	stwu    RV,-4(a7)
	line	48
;#  bsr         DoEvent                                [Line 618] 
	bl      _PACallGlue
	bl      _68_DoEvent
	line	50
;#  bra.s       NextEvent                              [Line 620] 
	b       _68_EventLoop_NextEvent
	line	52
_68_EventLoop_Exit:
;#  unlk        A6                                     [Line 622] 
	addic   a7,a6,4
	lwz     a6,0(a6)
	line	53
;#  rts                                                [Line 623] 
	lwz     RX,0(a7)
	mtlr    RX
	addic   a7,a7,4
	blr     
;#                endp                                 [Line 625]  

# Debugging information for -macsbug option
	align	2
	string  ASIS
_68_EventLoop_PAEND:
	dc.l	0,0x2041,0x8000001
	dc.l	_68_EventLoop_PAEND - _68_EventLoop
	dc.w	9
	dc.b	'EventLoop'
	align	2
	align	2
	endf	625


###################################################
# TOC Entries for Translated Code                 #
###################################################
	toc
T_A5Value:	tc	A5Value,0
T_PANoGC:	tc	_PANoGC,_PANoGC

