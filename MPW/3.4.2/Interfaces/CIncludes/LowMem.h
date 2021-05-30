/*
 	File:		LowMem.h
 
 	Contains:	Low Memory Accessor Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.5
 
 	Copyright:	© 1984-1997 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __LOWMEM__
#define __LOWMEM__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __CONTROLS__
#include <Controls.h>
#endif
/*	#include <Quickdraw.h>										*/
/*		#include <MixedMode.h>									*/
/*		#include <QuickdrawText.h>								*/
/*	#include <Menus.h>											*/
/*		#include <Memory.h>										*/

#ifndef __EVENTS__
#include <Events.h>
#endif
/*	#include <OSUtils.h>										*/

#ifndef __FILES__
#include <Files.h>
#endif
/*	#include <Finder.h>											*/

#ifndef __FONTS__
#include <Fonts.h>
#endif

#ifndef __MEMORY__
#include <Memory.h>
#endif

#ifndef __MENUS__
#include <Menus.h>
#endif

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef __WINDOWS__
#include <Windows.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

extern pascal SInt16 LMGetScrVRes( void )
	TWOWORDINLINE( 0x3EB8, 0x0102 ); /* MOVE.w $0102,(SP) */
extern pascal void LMSetScrVRes( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0102 ); /* MOVE.w (SP)+,$0102 */
extern pascal SInt16 LMGetScrHRes( void )
	TWOWORDINLINE( 0x3EB8, 0x0104 ); /* MOVE.w $0104,(SP) */
extern pascal void LMSetScrHRes( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0104 ); /* MOVE.w (SP)+,$0104 */
extern pascal Ptr LMGetMemTop( void )
	TWOWORDINLINE( 0x2EB8, 0x0108 ); /* MOVE.l $0108,(SP) */
extern pascal void LMSetMemTop( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x0108 ); /* MOVE.l (SP)+,$0108 */
extern pascal Ptr LMGetBufPtr( void )
	TWOWORDINLINE( 0x2EB8, 0x010C ); /* MOVE.l $010C,(SP) */
extern pascal void LMSetBufPtr( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x010C ); /* MOVE.l (SP)+,$010C */
extern pascal Ptr LMGetHeapEnd( void )
	TWOWORDINLINE( 0x2EB8, 0x0114 ); /* MOVE.l $0114,(SP) */
extern pascal void LMSetHeapEnd( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x0114 ); /* MOVE.l (SP)+,$0114 */
extern pascal THz LMGetTheZone( void )
	TWOWORDINLINE( 0x2EB8, 0x0118 ); /* MOVE.l $0118,(SP) */
extern pascal void LMSetTheZone( THz value )
	TWOWORDINLINE( 0x21DF, 0x0118 ); /* MOVE.l (SP)+,$0118 */
extern pascal Ptr LMGetUTableBase( void )
	TWOWORDINLINE( 0x2EB8, 0x011C ); /* MOVE.l $011C,(SP) */
extern pascal void LMSetUTableBase( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x011C ); /* MOVE.l (SP)+,$011C */
extern pascal UInt8 LMGetCPUFlag( void )
	TWOWORDINLINE( 0x1EB8, 0x012F ); /* MOVE.b $012F,(SP) */
extern pascal void LMSetCPUFlag( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x012F ); /* MOVE.b (SP)+,$012F */
extern pascal Ptr LMGetApplLimit( void )
	TWOWORDINLINE( 0x2EB8, 0x0130 ); /* MOVE.l $0130,(SP) */
extern pascal void LMSetApplLimit( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x0130 ); /* MOVE.l (SP)+,$0130 */
extern pascal SInt16 LMGetSysEvtMask( void )
	TWOWORDINLINE( 0x3EB8, 0x0144 ); /* MOVE.w $0144,(SP) */
extern pascal void LMSetSysEvtMask( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0144 ); /* MOVE.w (SP)+,$0144 */
extern pascal SInt32 LMGetRndSeed( void )
	TWOWORDINLINE( 0x2EB8, 0x0156 ); /* MOVE.l $0156,(SP) */
extern pascal void LMSetRndSeed( SInt32 value )
	TWOWORDINLINE( 0x21DF, 0x0156 ); /* MOVE.l (SP)+,$0156 */
extern pascal UInt8 LMGetSEvtEnb( void )
	TWOWORDINLINE( 0x1EB8, 0x015C ); /* MOVE.b $015C,(SP) */
extern pascal void LMSetSEvtEnb( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x015C ); /* MOVE.b (SP)+,$015C */
extern pascal SInt32 LMGetTicks( void )
	TWOWORDINLINE( 0x2EB8, 0x016A ); /* MOVE.l $016A,(SP) */
extern pascal void LMSetTicks( SInt32 value )
	TWOWORDINLINE( 0x21DF, 0x016A ); /* MOVE.l (SP)+,$016A */
extern pascal SInt16 LMGetKeyThresh( void )
	TWOWORDINLINE( 0x3EB8, 0x018E ); /* MOVE.w $018E,(SP) */
extern pascal void LMSetKeyThresh( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x018E ); /* MOVE.w (SP)+,$018E */
extern pascal SInt16 LMGetKeyRepThresh( void )
	TWOWORDINLINE( 0x3EB8, 0x0190 ); /* MOVE.w $0190,(SP) */
extern pascal void LMSetKeyRepThresh( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0190 ); /* MOVE.w (SP)+,$0190 */
extern pascal SInt16 LMGetUnitTableEntryCount( void )
	TWOWORDINLINE( 0x3EB8, 0x01D2 ); /* MOVE.w $01D2,(SP) */
extern pascal void LMSetUnitTableEntryCount( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x01D2 ); /* MOVE.w (SP)+,$01D2 */
extern pascal Ptr LMGetVIA( void )
	TWOWORDINLINE( 0x2EB8, 0x01D4 ); /* MOVE.l $01D4,(SP) */
extern pascal void LMSetVIA( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x01D4 ); /* MOVE.l (SP)+,$01D4 */
extern pascal Ptr LMGetSCCRd( void )
	TWOWORDINLINE( 0x2EB8, 0x01D8 ); /* MOVE.l $01D8,(SP) */
extern pascal void LMSetSCCRd( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x01D8 ); /* MOVE.l (SP)+,$01D8 */
extern pascal Ptr LMGetSCCWr( void )
	TWOWORDINLINE( 0x2EB8, 0x01DC ); /* MOVE.l $01DC,(SP) */
extern pascal void LMSetSCCWr( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x01DC ); /* MOVE.l (SP)+,$01DC */
extern pascal UInt8 LMGetSPValid( void )
	TWOWORDINLINE( 0x1EB8, 0x01F8 ); /* MOVE.b $01F8,(SP) */
extern pascal void LMSetSPValid( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x01F8 ); /* MOVE.b (SP)+,$01F8 */
extern pascal UInt8 LMGetSPATalkA( void )
	TWOWORDINLINE( 0x1EB8, 0x01F9 ); /* MOVE.b $01F9,(SP) */
extern pascal void LMSetSPATalkA( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x01F9 ); /* MOVE.b (SP)+,$01F9 */
extern pascal UInt8 LMGetSPATalkB( void )
	TWOWORDINLINE( 0x1EB8, 0x01FA ); /* MOVE.b $01FA,(SP) */
extern pascal void LMSetSPATalkB( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x01FA ); /* MOVE.b (SP)+,$01FA */
extern pascal UInt8 LMGetSPConfig( void )
	TWOWORDINLINE( 0x1EB8, 0x01FB ); /* MOVE.b $01FB,(SP) */
extern pascal void LMSetSPConfig( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x01FB ); /* MOVE.b (SP)+,$01FB */
extern pascal SInt16 LMGetSPPortA( void )
	TWOWORDINLINE( 0x3EB8, 0x01FC ); /* MOVE.w $01FC,(SP) */
extern pascal void LMSetSPPortA( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x01FC ); /* MOVE.w (SP)+,$01FC */
extern pascal SInt16 LMGetSPPortB( void )
	TWOWORDINLINE( 0x3EB8, 0x01FE ); /* MOVE.w $01FE,(SP) */
extern pascal void LMSetSPPortB( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x01FE ); /* MOVE.w (SP)+,$01FE */
extern pascal SInt32 LMGetSPAlarm( void )
	TWOWORDINLINE( 0x2EB8, 0x0200 ); /* MOVE.l $0200,(SP) */
extern pascal void LMSetSPAlarm( SInt32 value )
	TWOWORDINLINE( 0x21DF, 0x0200 ); /* MOVE.l (SP)+,$0200 */
extern pascal SInt16 LMGetSPFont( void )
	TWOWORDINLINE( 0x3EB8, 0x0204 ); /* MOVE.w $0204,(SP) */
extern pascal void LMSetSPFont( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0204 ); /* MOVE.w (SP)+,$0204 */
extern pascal UInt8 LMGetSPKbd( void )
	TWOWORDINLINE( 0x1EB8, 0x0206 ); /* MOVE.b $0206,(SP) */
extern pascal void LMSetSPKbd( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x0206 ); /* MOVE.b (SP)+,$0206 */
extern pascal UInt8 LMGetSPPrint( void )
	TWOWORDINLINE( 0x1EB8, 0x0207 ); /* MOVE.b $0207,(SP) */
extern pascal void LMSetSPPrint( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x0207 ); /* MOVE.b (SP)+,$0207 */
extern pascal UInt8 LMGetSPVolCtl( void )
	TWOWORDINLINE( 0x1EB8, 0x0208 ); /* MOVE.b $0208,(SP) */
extern pascal void LMSetSPVolCtl( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x0208 ); /* MOVE.b (SP)+,$0208 */
extern pascal UInt8 LMGetSPClikCaret( void )
	TWOWORDINLINE( 0x1EB8, 0x0209 ); /* MOVE.b $0209,(SP) */
extern pascal void LMSetSPClikCaret( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x0209 ); /* MOVE.b (SP)+,$0209 */
extern pascal UInt8 LMGetSPMisc2( void )
	TWOWORDINLINE( 0x1EB8, 0x020B ); /* MOVE.b $020B,(SP) */
extern pascal void LMSetSPMisc2( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x020B ); /* MOVE.b (SP)+,$020B */
extern pascal SInt32 LMGetTime( void )
	TWOWORDINLINE( 0x2EB8, 0x020C ); /* MOVE.l $020C,(SP) */
extern pascal void LMSetTime( SInt32 value )
	TWOWORDINLINE( 0x21DF, 0x020C ); /* MOVE.l (SP)+,$020C */
extern pascal SInt16 LMGetBootDrive( void )
	TWOWORDINLINE( 0x3EB8, 0x0210 ); /* MOVE.w $0210,(SP) */
extern pascal void LMSetBootDrive( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0210 ); /* MOVE.w (SP)+,$0210 */
extern pascal SInt16 LMGetSFSaveDisk( void )
	TWOWORDINLINE( 0x3EB8, 0x0214 ); /* MOVE.w $0214,(SP) */
extern pascal void LMSetSFSaveDisk( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0214 ); /* MOVE.w (SP)+,$0214 */
extern pascal UInt8 LMGetKbdLast( void )
	TWOWORDINLINE( 0x1EB8, 0x0218 ); /* MOVE.b $0218,(SP) */
extern pascal void LMSetKbdLast( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x0218 ); /* MOVE.b (SP)+,$0218 */
extern pascal UInt8 LMGetKbdType( void )
	TWOWORDINLINE( 0x1EB8, 0x021E ); /* MOVE.b $021E,(SP) */
extern pascal void LMSetKbdType( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x021E ); /* MOVE.b (SP)+,$021E */
extern pascal SInt16 LMGetMemErr( void )
	TWOWORDINLINE( 0x3EB8, 0x0220 ); /* MOVE.w $0220,(SP) */
extern pascal void LMSetMemErr( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0220 ); /* MOVE.w (SP)+,$0220 */
extern pascal UInt8 LMGetSdVolume( void )
	TWOWORDINLINE( 0x1EB8, 0x0260 ); /* MOVE.b $0260,(SP) */
extern pascal void LMSetSdVolume( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x0260 ); /* MOVE.b (SP)+,$0260 */
extern pascal Ptr LMGetSoundPtr( void )
	TWOWORDINLINE( 0x2EB8, 0x0262 ); /* MOVE.l $0262,(SP) */
extern pascal void LMSetSoundPtr( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x0262 ); /* MOVE.l (SP)+,$0262 */
extern pascal Ptr LMGetSoundBase( void )
	TWOWORDINLINE( 0x2EB8, 0x0266 ); /* MOVE.l $0266,(SP) */
extern pascal void LMSetSoundBase( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x0266 ); /* MOVE.l (SP)+,$0266 */
extern pascal UInt8 LMGetSoundLevel( void )
	TWOWORDINLINE( 0x1EB8, 0x027F ); /* MOVE.b $027F,(SP) */
extern pascal void LMSetSoundLevel( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x027F ); /* MOVE.b (SP)+,$027F */
extern pascal SInt16 LMGetCurPitch( void )
	TWOWORDINLINE( 0x3EB8, 0x0280 ); /* MOVE.w $0280,(SP) */
extern pascal void LMSetCurPitch( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0280 ); /* MOVE.w (SP)+,$0280 */
extern pascal SInt16 LMGetROM85( void )
	TWOWORDINLINE( 0x3EB8, 0x028E ); /* MOVE.w $028E,(SP) */
extern pascal void LMSetROM85( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x028E ); /* MOVE.w (SP)+,$028E */
extern pascal UInt8 LMGetPortBUse( void )
	TWOWORDINLINE( 0x1EB8, 0x0291 ); /* MOVE.b $0291,(SP) */
extern pascal void LMSetPortBUse( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x0291 ); /* MOVE.b (SP)+,$0291 */
extern pascal GNEFilterUPP LMGetGNEFilter( void )
	TWOWORDINLINE( 0x2EB8, 0x029A ); /* MOVE.l $029A,(SP) */
extern pascal void LMSetGNEFilter( GNEFilterUPP value )
	TWOWORDINLINE( 0x21DF, 0x029A ); /* MOVE.l (SP)+,$029A */
extern pascal THz LMGetSysZone( void )
	TWOWORDINLINE( 0x2EB8, 0x02A6 ); /* MOVE.l $02A6,(SP) */
extern pascal void LMSetSysZone( THz value )
	TWOWORDINLINE( 0x21DF, 0x02A6 ); /* MOVE.l (SP)+,$02A6 */
extern pascal THz LMGetApplZone( void )
	TWOWORDINLINE( 0x2EB8, 0x02AA ); /* MOVE.l $02AA,(SP) */
extern pascal void LMSetApplZone( THz value )
	TWOWORDINLINE( 0x21DF, 0x02AA ); /* MOVE.l (SP)+,$02AA */
extern pascal Ptr LMGetROMBase( void )
	TWOWORDINLINE( 0x2EB8, 0x02AE ); /* MOVE.l $02AE,(SP) */
extern pascal void LMSetROMBase( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x02AE ); /* MOVE.l (SP)+,$02AE */
extern pascal Ptr LMGetRAMBase( void )
	TWOWORDINLINE( 0x2EB8, 0x02B2 ); /* MOVE.l $02B2,(SP) */
extern pascal void LMSetRAMBase( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x02B2 ); /* MOVE.l (SP)+,$02B2 */
extern pascal Ptr LMGetDSAlertTab( void )
	TWOWORDINLINE( 0x2EB8, 0x02BA ); /* MOVE.l $02BA,(SP) */
extern pascal void LMSetDSAlertTab( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x02BA ); /* MOVE.l (SP)+,$02BA */
extern pascal Ptr LMGetABusVars( void )
	TWOWORDINLINE( 0x2EB8, 0x02D8 ); /* MOVE.l $02D8,(SP) */
extern pascal void LMSetABusVars( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x02D8 ); /* MOVE.l (SP)+,$02D8 */
extern pascal Ptr LMGetABusDCE( void )
	TWOWORDINLINE( 0x2EB8, 0x02DC ); /* MOVE.l $02DC,(SP) */
extern pascal void LMSetABusDCE( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x02DC ); /* MOVE.l (SP)+,$02DC */
extern pascal UInt32 LMGetDoubleTime( void )
	TWOWORDINLINE( 0x2EB8, 0x02F0 ); /* MOVE.l $02F0,(SP) */
extern pascal void LMSetDoubleTime( UInt32 value )
	TWOWORDINLINE( 0x21DF, 0x02F0 ); /* MOVE.l (SP)+,$02F0 */
extern pascal UInt32 LMGetCaretTime( void )
	TWOWORDINLINE( 0x2EB8, 0x02F4 ); /* MOVE.l $02F4,(SP) */
extern pascal void LMSetCaretTime( UInt32 value )
	TWOWORDINLINE( 0x21DF, 0x02F4 ); /* MOVE.l (SP)+,$02F4 */
extern pascal UInt8 LMGetScrDmpEnb( void )
	TWOWORDINLINE( 0x1EB8, 0x02F8 ); /* MOVE.b $02F8,(SP) */
extern pascal void LMSetScrDmpEnb( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x02F8 ); /* MOVE.b (SP)+,$02F8 */
extern pascal SInt32 LMGetBufTgFNum( void )
	TWOWORDINLINE( 0x2EB8, 0x02FC ); /* MOVE.l $02FC,(SP) */
extern pascal void LMSetBufTgFNum( SInt32 value )
	TWOWORDINLINE( 0x21DF, 0x02FC ); /* MOVE.l (SP)+,$02FC */
extern pascal SInt16 LMGetBufTgFFlg( void )
	TWOWORDINLINE( 0x3EB8, 0x0300 ); /* MOVE.w $0300,(SP) */
extern pascal void LMSetBufTgFFlg( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0300 ); /* MOVE.w (SP)+,$0300 */
extern pascal SInt16 LMGetBufTgFBkNum( void )
	TWOWORDINLINE( 0x3EB8, 0x0302 ); /* MOVE.w $0302,(SP) */
extern pascal void LMSetBufTgFBkNum( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0302 ); /* MOVE.w (SP)+,$0302 */
extern pascal SInt32 LMGetBufTgDate( void )
	TWOWORDINLINE( 0x2EB8, 0x0304 ); /* MOVE.l $0304,(SP) */
extern pascal void LMSetBufTgDate( SInt32 value )
	TWOWORDINLINE( 0x21DF, 0x0304 ); /* MOVE.l (SP)+,$0304 */
extern pascal SInt32 LMGetLo3Bytes( void )
	TWOWORDINLINE( 0x2EB8, 0x031A ); /* MOVE.l $031A,(SP) */
extern pascal void LMSetLo3Bytes( SInt32 value )
	TWOWORDINLINE( 0x21DF, 0x031A ); /* MOVE.l (SP)+,$031A */
extern pascal SInt32 LMGetMinStack( void )
	TWOWORDINLINE( 0x2EB8, 0x031E ); /* MOVE.l $031E,(SP) */
extern pascal void LMSetMinStack( SInt32 value )
	TWOWORDINLINE( 0x21DF, 0x031E ); /* MOVE.l (SP)+,$031E */
extern pascal SInt32 LMGetDefltStack( void )
	TWOWORDINLINE( 0x2EB8, 0x0322 ); /* MOVE.l $0322,(SP) */
extern pascal void LMSetDefltStack( SInt32 value )
	TWOWORDINLINE( 0x21DF, 0x0322 ); /* MOVE.l (SP)+,$0322 */
extern pascal Handle LMGetGZRootHnd( void )
	TWOWORDINLINE( 0x2EB8, 0x0328 ); /* MOVE.l $0328,(SP) */
extern pascal void LMSetGZRootHnd( Handle value )
	TWOWORDINLINE( 0x21DF, 0x0328 ); /* MOVE.l (SP)+,$0328 */
extern pascal Handle LMGetGZMoveHnd( void )
	TWOWORDINLINE( 0x2EB8, 0x0330 ); /* MOVE.l $0330,(SP) */
extern pascal void LMSetGZMoveHnd( Handle value )
	TWOWORDINLINE( 0x21DF, 0x0330 ); /* MOVE.l (SP)+,$0330 */
extern pascal Ptr LMGetFCBSPtr( void )
	TWOWORDINLINE( 0x2EB8, 0x034E ); /* MOVE.l $034E,(SP) */
extern pascal void LMSetFCBSPtr( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x034E ); /* MOVE.l (SP)+,$034E */
extern pascal Ptr LMGetDefVCBPtr( void )
	TWOWORDINLINE( 0x2EB8, 0x0352 ); /* MOVE.l $0352,(SP) */
extern pascal void LMSetDefVCBPtr( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x0352 ); /* MOVE.l (SP)+,$0352 */
extern pascal SInt32 LMGetCurDirStore( void )
	TWOWORDINLINE( 0x2EB8, 0x0398 ); /* MOVE.l $0398,(SP) */
extern pascal void LMSetCurDirStore( SInt32 value )
	TWOWORDINLINE( 0x21DF, 0x0398 ); /* MOVE.l (SP)+,$0398 */
extern pascal UniversalProcPtr LMGetToExtFS( void )
	TWOWORDINLINE( 0x2EB8, 0x03F2 ); /* MOVE.l $03F2,(SP) */
extern pascal void LMSetToExtFS( UniversalProcPtr value )
	TWOWORDINLINE( 0x21DF, 0x03F2 ); /* MOVE.l (SP)+,$03F2 */
extern pascal SInt16 LMGetFSFCBLen( void )
	TWOWORDINLINE( 0x3EB8, 0x03F6 ); /* MOVE.w $03F6,(SP) */
extern pascal void LMSetFSFCBLen( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x03F6 ); /* MOVE.w (SP)+,$03F6 */
extern pascal Ptr LMGetScrnBase( void )
	TWOWORDINLINE( 0x2EB8, 0x0824 ); /* MOVE.l $0824,(SP) */
extern pascal void LMSetScrnBase( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x0824 ); /* MOVE.l (SP)+,$0824 */
extern pascal GDHandle LMGetMainDevice( void )
	TWOWORDINLINE( 0x2EB8, 0x08A4 ); /* MOVE.l $08A4,(SP) */
extern pascal void LMSetMainDevice( GDHandle value )
	TWOWORDINLINE( 0x21DF, 0x08A4 ); /* MOVE.l (SP)+,$08A4 */
extern pascal GDHandle LMGetDeviceList( void )
	TWOWORDINLINE( 0x2EB8, 0x08A8 ); /* MOVE.l $08A8,(SP) */
extern pascal void LMSetDeviceList( GDHandle value )
	TWOWORDINLINE( 0x21DF, 0x08A8 ); /* MOVE.l (SP)+,$08A8 */
extern pascal Handle LMGetQDColors( void )
	TWOWORDINLINE( 0x2EB8, 0x08B0 ); /* MOVE.l $08B0,(SP) */
extern pascal void LMSetQDColors( Handle value )
	TWOWORDINLINE( 0x21DF, 0x08B0 ); /* MOVE.l (SP)+,$08B0 */
extern pascal UInt8 LMGetCrsrBusy( void )
	TWOWORDINLINE( 0x1EB8, 0x08CD ); /* MOVE.b $08CD,(SP) */
extern pascal void LMSetCrsrBusy( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x08CD ); /* MOVE.b (SP)+,$08CD */
extern pascal Handle LMGetWidthListHand( void )
	TWOWORDINLINE( 0x2EB8, 0x08E4 ); /* MOVE.l $08E4,(SP) */
extern pascal void LMSetWidthListHand( Handle value )
	TWOWORDINLINE( 0x21DF, 0x08E4 ); /* MOVE.l (SP)+,$08E4 */
extern pascal SInt16 LMGetJournalRef( void )
	TWOWORDINLINE( 0x3EB8, 0x08E8 ); /* MOVE.w $08E8,(SP) */
extern pascal void LMSetJournalRef( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x08E8 ); /* MOVE.w (SP)+,$08E8 */
extern pascal SInt16 LMGetCrsrThresh( void )
	TWOWORDINLINE( 0x3EB8, 0x08EC ); /* MOVE.w $08EC,(SP) */
extern pascal void LMSetCrsrThresh( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x08EC ); /* MOVE.w (SP)+,$08EC */
extern pascal UniversalProcPtr LMGetJFetch( void )
	TWOWORDINLINE( 0x2EB8, 0x08F4 ); /* MOVE.l $08F4,(SP) */
extern pascal void LMSetJFetch( UniversalProcPtr value )
	TWOWORDINLINE( 0x21DF, 0x08F4 ); /* MOVE.l (SP)+,$08F4 */
extern pascal UniversalProcPtr LMGetJStash( void )
	TWOWORDINLINE( 0x2EB8, 0x08F8 ); /* MOVE.l $08F8,(SP) */
extern pascal void LMSetJStash( UniversalProcPtr value )
	TWOWORDINLINE( 0x21DF, 0x08F8 ); /* MOVE.l (SP)+,$08F8 */
extern pascal UniversalProcPtr LMGetJIODone( void )
	TWOWORDINLINE( 0x2EB8, 0x08FC ); /* MOVE.l $08FC,(SP) */
extern pascal void LMSetJIODone( UniversalProcPtr value )
	TWOWORDINLINE( 0x21DF, 0x08FC ); /* MOVE.l (SP)+,$08FC */
extern pascal SInt16 LMGetCurApRefNum( void )
	TWOWORDINLINE( 0x3EB8, 0x0900 ); /* MOVE.w $0900,(SP) */
extern pascal void LMSetCurApRefNum( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0900 ); /* MOVE.w (SP)+,$0900 */
extern pascal Ptr LMGetCurrentA5( void )
	TWOWORDINLINE( 0x2EB8, 0x0904 ); /* MOVE.l $0904,(SP) */
extern pascal void LMSetCurrentA5( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x0904 ); /* MOVE.l (SP)+,$0904 */
extern pascal Ptr LMGetCurStackBase( void )
	TWOWORDINLINE( 0x2EB8, 0x0908 ); /* MOVE.l $0908,(SP) */
extern pascal void LMSetCurStackBase( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x0908 ); /* MOVE.l (SP)+,$0908 */
extern pascal SInt16 LMGetCurJTOffset( void )
	TWOWORDINLINE( 0x3EB8, 0x0934 ); /* MOVE.w $0934,(SP) */
extern pascal void LMSetCurJTOffset( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0934 ); /* MOVE.w (SP)+,$0934 */
extern pascal SInt16 LMGetCurPageOption( void )
	TWOWORDINLINE( 0x3EB8, 0x0936 ); /* MOVE.w $0936,(SP) */
extern pascal void LMSetCurPageOption( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0936 ); /* MOVE.w (SP)+,$0936 */
extern pascal UInt8 LMGetHiliteMode( void )
	TWOWORDINLINE( 0x1EB8, 0x0938 ); /* MOVE.b $0938,(SP) */
extern pascal void LMSetHiliteMode( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x0938 ); /* MOVE.b (SP)+,$0938 */
extern pascal SInt16 LMGetPrintErr( void )
	TWOWORDINLINE( 0x3EB8, 0x0944 ); /* MOVE.w $0944,(SP) */
extern pascal void LMSetPrintErr( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0944 ); /* MOVE.w (SP)+,$0944 */
extern pascal SInt32 LMGetScrapSize( void )
	TWOWORDINLINE( 0x2EB8, 0x0960 ); /* MOVE.l $0960,(SP) */
extern pascal void LMSetScrapSize( SInt32 value )
	TWOWORDINLINE( 0x21DF, 0x0960 ); /* MOVE.l (SP)+,$0960 */
extern pascal Handle LMGetScrapHandle( void )
	TWOWORDINLINE( 0x2EB8, 0x0964 ); /* MOVE.l $0964,(SP) */
extern pascal void LMSetScrapHandle( Handle value )
	TWOWORDINLINE( 0x21DF, 0x0964 ); /* MOVE.l (SP)+,$0964 */
extern pascal SInt16 LMGetScrapCount( void )
	TWOWORDINLINE( 0x3EB8, 0x0968 ); /* MOVE.w $0968,(SP) */
extern pascal void LMSetScrapCount( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0968 ); /* MOVE.w (SP)+,$0968 */
extern pascal SInt16 LMGetScrapState( void )
	TWOWORDINLINE( 0x3EB8, 0x096A ); /* MOVE.w $096A,(SP) */
extern pascal void LMSetScrapState( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x096A ); /* MOVE.w (SP)+,$096A */
extern pascal StringPtr LMGetScrapName( void )
	TWOWORDINLINE( 0x2EB8, 0x096C ); /* MOVE.l $096C,(SP) */
extern pascal void LMSetScrapName( StringPtr value )
	TWOWORDINLINE( 0x21DF, 0x096C ); /* MOVE.l (SP)+,$096C */
extern pascal Handle LMGetROMFont0( void )
	TWOWORDINLINE( 0x2EB8, 0x0980 ); /* MOVE.l $0980,(SP) */
extern pascal void LMSetROMFont0( Handle value )
	TWOWORDINLINE( 0x21DF, 0x0980 ); /* MOVE.l (SP)+,$0980 */
extern pascal SInt16 LMGetApFontID( void )
	TWOWORDINLINE( 0x3EB8, 0x0984 ); /* MOVE.w $0984,(SP) */
extern pascal void LMSetApFontID( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0984 ); /* MOVE.w (SP)+,$0984 */
extern pascal WindowRef LMGetWindowList( void )
	TWOWORDINLINE( 0x2EB8, 0x09D6 ); /* MOVE.l $09D6,(SP) */
extern pascal SInt16 LMGetSaveUpdate( void )
	TWOWORDINLINE( 0x3EB8, 0x09DA ); /* MOVE.w $09DA,(SP) */
extern pascal void LMSetSaveUpdate( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x09DA ); /* MOVE.w (SP)+,$09DA */
extern pascal SInt16 LMGetPaintWhite( void )
	TWOWORDINLINE( 0x3EB8, 0x09DC ); /* MOVE.w $09DC,(SP) */
extern pascal void LMSetPaintWhite( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x09DC ); /* MOVE.w (SP)+,$09DC */
extern pascal GrafPtr LMGetWMgrPort( void )
	TWOWORDINLINE( 0x2EB8, 0x09DE ); /* MOVE.l $09DE,(SP) */
extern pascal void LMSetWMgrPort( GrafPtr value )
	TWOWORDINLINE( 0x21DF, 0x09DE ); /* MOVE.l (SP)+,$09DE */
extern pascal RgnHandle LMGetGrayRgn( void )
	TWOWORDINLINE( 0x2EB8, 0x09EE ); /* MOVE.l $09EE,(SP) */
extern pascal DragGrayRgnUPP LMGetDragHook( void )
	TWOWORDINLINE( 0x2EB8, 0x09F6 ); /* MOVE.l $09F6,(SP) */
extern pascal void LMSetDragHook( DragGrayRgnUPP value )
	TWOWORDINLINE( 0x21DF, 0x09F6 ); /* MOVE.l (SP)+,$09F6 */
/*
 There is no reason to set the window list directly.
 Use BringToFront and SendBehind.

 If you need to do floating windows, avoid using GhostWindow 
 and especially avoid patching the window manager.

 See Dean Yu's article in Develop 15 about how to implement floating
 windows using low-level window manager calls.  The next generation
 Macintosh Window Manager will have built-in support for floating
 and modal windows.
*/
extern pascal void LMSetWindowList( WindowRef value )
	TWOWORDINLINE( 0x21DF, 0x09D6 ); /* MOVE.l (SP)+,$09D6 */
extern pascal WindowRef LMGetGhostWindow( void )
	TWOWORDINLINE( 0x2EB8, 0x0A84 ); /* MOVE.l $0A84,(SP) */
extern pascal void LMSetGhostWindow( WindowRef value )
	TWOWORDINLINE( 0x21DF, 0x0A84 ); /* MOVE.l (SP)+,$0A84 */
/*
 The auxiliary window record list will be empty in future
 versions of the window manager.  There is no reason to 
 walk it or change it. 
*/
extern pascal AuxWinHandle LMGetAuxWinHead( void )
	TWOWORDINLINE( 0x2EB8, 0x0CD0 ); /* MOVE.l $0CD0,(SP) */
extern pascal void LMSetAuxWinHead( AuxWinHandle value )
	TWOWORDINLINE( 0x21DF, 0x0CD0 ); /* MOVE.l (SP)+,$0CD0 */
/*
 Please rely on the event manager to deliver activate and 
 deactivate events and on the window manager to generate them.

 The next generation window manager will queue these events
 rather than just slamming these lowmems with the latest
 generated event, so it pays to rely on the event manager.
*/
extern pascal WindowRef LMGetCurActivate( void )
	TWOWORDINLINE( 0x2EB8, 0x0A64 ); /* MOVE.l $0A64,(SP) */
extern pascal void LMSetCurActivate( WindowRef value )
	TWOWORDINLINE( 0x21DF, 0x0A64 ); /* MOVE.l (SP)+,$0A64 */
extern pascal WindowRef LMGetCurDeactive( void )
	TWOWORDINLINE( 0x2EB8, 0x0A68 ); /* MOVE.l $0A68,(SP) */
extern pascal void LMSetCurDeactive( WindowRef value )
	TWOWORDINLINE( 0x21DF, 0x0A68 ); /* MOVE.l (SP)+,$0A68 */
extern pascal RgnHandle LMGetOldStructure( void )
	TWOWORDINLINE( 0x2EB8, 0x09E6 ); /* MOVE.l $09E6,(SP) */
extern pascal void LMSetOldStructure( RgnHandle value )
	TWOWORDINLINE( 0x21DF, 0x09E6 ); /* MOVE.l (SP)+,$09E6 */
extern pascal RgnHandle LMGetOldContent( void )
	TWOWORDINLINE( 0x2EB8, 0x09EA ); /* MOVE.l $09EA,(SP) */
extern pascal void LMSetOldContent( RgnHandle value )
	TWOWORDINLINE( 0x21DF, 0x09EA ); /* MOVE.l (SP)+,$09EA */
/*
 Please don't mess with the gray region.  There has
 to be a better way.  If not, please manipulate the
 existing region, don't change the value of the lowmem.
*/
extern pascal void LMSetGrayRgn( RgnHandle value )
	TWOWORDINLINE( 0x21DF, 0x09EE ); /* MOVE.l (SP)+,$09EE */
extern pascal RgnHandle LMGetSaveVisRgn( void )
	TWOWORDINLINE( 0x2EB8, 0x09F2 ); /* MOVE.l $09F2,(SP) */
extern pascal void LMSetSaveVisRgn( RgnHandle value )
	TWOWORDINLINE( 0x21DF, 0x09F2 ); /* MOVE.l (SP)+,$09F2 */

extern pascal SInt32 LMGetOneOne( void )
	TWOWORDINLINE( 0x2EB8, 0x0A02 ); /* MOVE.l $0A02,(SP) */
extern pascal void LMSetOneOne( SInt32 value )
	TWOWORDINLINE( 0x21DF, 0x0A02 ); /* MOVE.l (SP)+,$0A02 */
extern pascal SInt32 LMGetMinusOne( void )
	TWOWORDINLINE( 0x2EB8, 0x0A06 ); /* MOVE.l $0A06,(SP) */
extern pascal void LMSetMinusOne( SInt32 value )
	TWOWORDINLINE( 0x21DF, 0x0A06 ); /* MOVE.l (SP)+,$0A06 */
extern pascal SInt16 LMGetTopMenuItem( void )
	TWOWORDINLINE( 0x3EB8, 0x0A0A ); /* MOVE.w $0A0A,(SP) */
extern pascal void LMSetTopMenuItem( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0A0A ); /* MOVE.w (SP)+,$0A0A */
extern pascal SInt16 LMGetAtMenuBottom( void )
	TWOWORDINLINE( 0x3EB8, 0x0A0C ); /* MOVE.w $0A0C,(SP) */
extern pascal void LMSetAtMenuBottom( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0A0C ); /* MOVE.w (SP)+,$0A0C */
extern pascal Handle LMGetMenuList( void )
	TWOWORDINLINE( 0x2EB8, 0x0A1C ); /* MOVE.l $0A1C,(SP) */
extern pascal void LMSetMenuList( Handle value )
	TWOWORDINLINE( 0x21DF, 0x0A1C ); /* MOVE.l (SP)+,$0A1C */
extern pascal SInt16 LMGetMBarEnable( void )
	TWOWORDINLINE( 0x3EB8, 0x0A20 ); /* MOVE.w $0A20,(SP) */
extern pascal void LMSetMBarEnable( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0A20 ); /* MOVE.w (SP)+,$0A20 */
extern pascal SInt16 LMGetMenuFlash( void )
	TWOWORDINLINE( 0x3EB8, 0x0A24 ); /* MOVE.w $0A24,(SP) */
extern pascal void LMSetMenuFlash( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0A24 ); /* MOVE.w (SP)+,$0A24 */
extern pascal SInt16 LMGetTheMenu( void )
	TWOWORDINLINE( 0x3EB8, 0x0A26 ); /* MOVE.w $0A26,(SP) */
extern pascal void LMSetTheMenu( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0A26 ); /* MOVE.w (SP)+,$0A26 */
extern pascal MBarHookUPP LMGetMBarHook( void )
	TWOWORDINLINE( 0x2EB8, 0x0A2C ); /* MOVE.l $0A2C,(SP) */
extern pascal void LMSetMBarHook( MBarHookUPP value )
	TWOWORDINLINE( 0x21DF, 0x0A2C ); /* MOVE.l (SP)+,$0A2C */
extern pascal MenuHookUPP LMGetMenuHook( void )
	TWOWORDINLINE( 0x2EB8, 0x0A30 ); /* MOVE.l $0A30,(SP) */
extern pascal void LMSetMenuHook( MenuHookUPP value )
	TWOWORDINLINE( 0x21DF, 0x0A30 ); /* MOVE.l (SP)+,$0A30 */
extern pascal Handle LMGetTopMapHndl( void )
	TWOWORDINLINE( 0x2EB8, 0x0A50 ); /* MOVE.l $0A50,(SP) */
extern pascal void LMSetTopMapHndl( Handle value )
	TWOWORDINLINE( 0x21DF, 0x0A50 ); /* MOVE.l (SP)+,$0A50 */
extern pascal Handle LMGetSysMapHndl( void )
	TWOWORDINLINE( 0x2EB8, 0x0A54 ); /* MOVE.l $0A54,(SP) */
extern pascal void LMSetSysMapHndl( Handle value )
	TWOWORDINLINE( 0x21DF, 0x0A54 ); /* MOVE.l (SP)+,$0A54 */
extern pascal SInt16 LMGetSysMap( void )
	TWOWORDINLINE( 0x3EB8, 0x0A58 ); /* MOVE.w $0A58,(SP) */
extern pascal void LMSetSysMap( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0A58 ); /* MOVE.w (SP)+,$0A58 */
extern pascal SInt16 LMGetCurMap( void )
	TWOWORDINLINE( 0x3EB8, 0x0A5A ); /* MOVE.w $0A5A,(SP) */
extern pascal void LMSetCurMap( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0A5A ); /* MOVE.w (SP)+,$0A5A */
extern pascal UInt8 LMGetResLoad( void )
	TWOWORDINLINE( 0x1EB8, 0x0A5E ); /* MOVE.b $0A5E,(SP) */
extern pascal void LMSetResLoad( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x0A5E ); /* MOVE.b (SP)+,$0A5E */
extern pascal SInt16 LMGetResErr( void )
	TWOWORDINLINE( 0x3EB8, 0x0A60 ); /* MOVE.w $0A60,(SP) */
extern pascal void LMSetResErr( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0A60 ); /* MOVE.w (SP)+,$0A60 */
extern pascal UInt8 LMGetFScaleDisable( void )
	TWOWORDINLINE( 0x1EB8, 0x0A63 ); /* MOVE.b $0A63,(SP) */
extern pascal void LMSetFScaleDisable( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x0A63 ); /* MOVE.b (SP)+,$0A63 */
extern pascal UniversalProcPtr LMGetDeskHook( void )
	TWOWORDINLINE( 0x2EB8, 0x0A6C ); /* MOVE.l $0A6C,(SP) */
extern pascal void LMSetDeskHook( UniversalProcPtr value )
	TWOWORDINLINE( 0x21DF, 0x0A6C ); /* MOVE.l (SP)+,$0A6C */
extern pascal UniversalProcPtr LMGetTEDoText( void )
	TWOWORDINLINE( 0x2EB8, 0x0A70 ); /* MOVE.l $0A70,(SP) */
extern pascal void LMSetTEDoText( UniversalProcPtr value )
	TWOWORDINLINE( 0x21DF, 0x0A70 ); /* MOVE.l (SP)+,$0A70 */
extern pascal UniversalProcPtr LMGetTERecal( void )
	TWOWORDINLINE( 0x2EB8, 0x0A74 ); /* MOVE.l $0A74,(SP) */
extern pascal void LMSetTERecal( UniversalProcPtr value )
	TWOWORDINLINE( 0x21DF, 0x0A74 ); /* MOVE.l (SP)+,$0A74 */
extern pascal UniversalProcPtr LMGetResumeProc( void )
	TWOWORDINLINE( 0x2EB8, 0x0A8C ); /* MOVE.l $0A8C,(SP) */
extern pascal void LMSetResumeProc( UniversalProcPtr value )
	TWOWORDINLINE( 0x21DF, 0x0A8C ); /* MOVE.l (SP)+,$0A8C */
extern pascal SInt16 LMGetANumber( void )
	TWOWORDINLINE( 0x3EB8, 0x0A98 ); /* MOVE.w $0A98,(SP) */
extern pascal void LMSetANumber( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0A98 ); /* MOVE.w (SP)+,$0A98 */
extern pascal SInt16 LMGetACount( void )
	TWOWORDINLINE( 0x3EB8, 0x0A9A ); /* MOVE.w $0A9A,(SP) */
extern pascal void LMSetACount( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0A9A ); /* MOVE.w (SP)+,$0A9A */
extern pascal UniversalProcPtr LMGetDABeeper( void )
	TWOWORDINLINE( 0x2EB8, 0x0A9C ); /* MOVE.l $0A9C,(SP) */
extern pascal void LMSetDABeeper( UniversalProcPtr value )
	TWOWORDINLINE( 0x21DF, 0x0A9C ); /* MOVE.l (SP)+,$0A9C */
extern pascal UInt16 LMGetTEScrpLength( void )
	TWOWORDINLINE( 0x3EB8, 0x0AB0 ); /* MOVE.w $0AB0,(SP) */
extern pascal void LMSetTEScrpLength( UInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0AB0 ); /* MOVE.w (SP)+,$0AB0 */
extern pascal Handle LMGetTEScrpHandle( void )
	TWOWORDINLINE( 0x2EB8, 0x0AB4 ); /* MOVE.l $0AB4,(SP) */
extern pascal void LMSetTEScrpHandle( Handle value )
	TWOWORDINLINE( 0x21DF, 0x0AB4 ); /* MOVE.l (SP)+,$0AB4 */
extern pascal Handle LMGetAppParmHandle( void )
	TWOWORDINLINE( 0x2EB8, 0x0AEC ); /* MOVE.l $0AEC,(SP) */
extern pascal void LMSetAppParmHandle( Handle value )
	TWOWORDINLINE( 0x21DF, 0x0AEC ); /* MOVE.l (SP)+,$0AEC */
extern pascal SInt16 LMGetDSErrCode( void )
	TWOWORDINLINE( 0x3EB8, 0x0AF0 ); /* MOVE.w $0AF0,(SP) */
extern pascal void LMSetDSErrCode( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0AF0 ); /* MOVE.w (SP)+,$0AF0 */
extern pascal ResErrUPP LMGetResErrProc( void )
	TWOWORDINLINE( 0x2EB8, 0x0AF2 ); /* MOVE.l $0AF2,(SP) */
extern pascal void LMSetResErrProc( ResErrUPP value )
	TWOWORDINLINE( 0x21DF, 0x0AF2 ); /* MOVE.l (SP)+,$0AF2 */
extern pascal SInt16 LMGetDlgFont( void )
	TWOWORDINLINE( 0x3EB8, 0x0AFA ); /* MOVE.w $0AFA,(SP) */
extern pascal void LMSetDlgFont( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0AFA ); /* MOVE.w (SP)+,$0AFA */
extern pascal Ptr LMGetWidthPtr( void )
	TWOWORDINLINE( 0x2EB8, 0x0B10 ); /* MOVE.l $0B10,(SP) */
extern pascal void LMSetWidthPtr( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x0B10 ); /* MOVE.l (SP)+,$0B10 */
extern pascal Ptr LMGetATalkHk2( void )
	TWOWORDINLINE( 0x2EB8, 0x0B18 ); /* MOVE.l $0B18,(SP) */
extern pascal void LMSetATalkHk2( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x0B18 ); /* MOVE.l (SP)+,$0B18 */
extern pascal SInt16 LMGetHWCfgFlags( void )
	TWOWORDINLINE( 0x3EB8, 0x0B22 ); /* MOVE.w $0B22,(SP) */
extern pascal void LMSetHWCfgFlags( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0B22 ); /* MOVE.w (SP)+,$0B22 */
extern pascal Handle LMGetWidthTabHandle( void )
	TWOWORDINLINE( 0x2EB8, 0x0B2A ); /* MOVE.l $0B2A,(SP) */
extern pascal void LMSetWidthTabHandle( Handle value )
	TWOWORDINLINE( 0x21DF, 0x0B2A ); /* MOVE.l (SP)+,$0B2A */
extern pascal SInt32 LMGetLastSPExtra( void )
	TWOWORDINLINE( 0x2EB8, 0x0B4C ); /* MOVE.l $0B4C,(SP) */
extern pascal void LMSetLastSPExtra( SInt32 value )
	TWOWORDINLINE( 0x21DF, 0x0B4C ); /* MOVE.l (SP)+,$0B4C */
extern pascal SInt32 LMGetMenuDisable( void )
	TWOWORDINLINE( 0x2EB8, 0x0B54 ); /* MOVE.l $0B54,(SP) */
extern pascal void LMSetMenuDisable( SInt32 value )
	TWOWORDINLINE( 0x21DF, 0x0B54 ); /* MOVE.l (SP)+,$0B54 */
extern pascal UInt8 LMGetROMMapInsert( void )
	TWOWORDINLINE( 0x1EB8, 0x0B9E ); /* MOVE.b $0B9E,(SP) */
extern pascal void LMSetROMMapInsert( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x0B9E ); /* MOVE.b (SP)+,$0B9E */
extern pascal UInt8 LMGetTmpResLoad( void )
	TWOWORDINLINE( 0x1EB8, 0x0B9F ); /* MOVE.b $0B9F,(SP) */
extern pascal void LMSetTmpResLoad( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x0B9F ); /* MOVE.b (SP)+,$0B9F */
extern pascal Ptr LMGetIntlSpec( void )
	TWOWORDINLINE( 0x2EB8, 0x0BA0 ); /* MOVE.l $0BA0,(SP) */
extern pascal void LMSetIntlSpec( Ptr value )
	TWOWORDINLINE( 0x21DF, 0x0BA0 ); /* MOVE.l (SP)+,$0BA0 */
extern pascal UInt8 LMGetWordRedraw( void )
	TWOWORDINLINE( 0x1EB8, 0x0BA5 ); /* MOVE.b $0BA5,(SP) */
extern pascal void LMSetWordRedraw( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x0BA5 ); /* MOVE.b (SP)+,$0BA5 */
extern pascal SInt16 LMGetSysFontFam( void )
	TWOWORDINLINE( 0x3EB8, 0x0BA6 ); /* MOVE.w $0BA6,(SP) */
extern pascal void LMSetSysFontFam( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0BA6 ); /* MOVE.w (SP)+,$0BA6 */
extern pascal SInt16 LMGetSysFontSize( void )
	TWOWORDINLINE( 0x3EB8, 0x0BA8 ); /* MOVE.w $0BA8,(SP) */
extern pascal void LMSetSysFontSize( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0BA8 ); /* MOVE.w (SP)+,$0BA8 */
extern pascal SInt16 LMGetMBarHeight( void )
	TWOWORDINLINE( 0x3EB8, 0x0BAA ); /* MOVE.w $0BAA,(SP) */
extern pascal void LMSetMBarHeight( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0BAA ); /* MOVE.w (SP)+,$0BAA */
extern pascal SInt16 LMGetTESysJust( void )
	TWOWORDINLINE( 0x3EB8, 0x0BAC ); /* MOVE.w $0BAC,(SP) */
extern pascal void LMSetTESysJust( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0BAC ); /* MOVE.w (SP)+,$0BAC */
extern pascal Handle LMGetLastFOND( void )
	TWOWORDINLINE( 0x2EB8, 0x0BC2 ); /* MOVE.l $0BC2,(SP) */
extern pascal void LMSetLastFOND( Handle value )
	TWOWORDINLINE( 0x21DF, 0x0BC2 ); /* MOVE.l (SP)+,$0BC2 */
extern pascal UInt8 LMGetFractEnable( void )
	TWOWORDINLINE( 0x1EB8, 0x0BF4 ); /* MOVE.b $0BF4,(SP) */
extern pascal void LMSetFractEnable( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x0BF4 ); /* MOVE.b (SP)+,$0BF4 */
extern pascal UInt8 LMGetMMU32Bit( void )
	TWOWORDINLINE( 0x1EB8, 0x0CB2 ); /* MOVE.b $0CB2,(SP) */
extern pascal void LMSetMMU32Bit( UInt8 value )
	TWOWORDINLINE( 0x11DF, 0x0CB2 ); /* MOVE.b (SP)+,$0CB2 */
extern pascal GDHandle LMGetTheGDevice( void )
	TWOWORDINLINE( 0x2EB8, 0x0CC8 ); /* MOVE.l $0CC8,(SP) */
extern pascal void LMSetTheGDevice( GDHandle value )
	TWOWORDINLINE( 0x21DF, 0x0CC8 ); /* MOVE.l (SP)+,$0CC8 */
extern pascal PixPatHandle LMGetDeskCPat( void )
	TWOWORDINLINE( 0x2EB8, 0x0CD8 ); /* MOVE.l $0CD8,(SP) */
extern pascal void LMSetDeskCPat( PixPatHandle value )
	TWOWORDINLINE( 0x21DF, 0x0CD8 ); /* MOVE.l (SP)+,$0CD8 */
extern pascal SInt16 LMGetTimeDBRA( void )
	TWOWORDINLINE( 0x3EB8, 0x0D00 ); /* MOVE.w $0D00,(SP) */
extern pascal void LMSetTimeDBRA( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0D00 ); /* MOVE.w (SP)+,$0D00 */
extern pascal SInt16 LMGetTimeSCCDB( void )
	TWOWORDINLINE( 0x3EB8, 0x0D02 ); /* MOVE.w $0D02,(SP) */
extern pascal void LMSetTimeSCCDB( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0D02 ); /* MOVE.w (SP)+,$0D02 */
extern pascal UniversalProcPtr LMGetJVBLTask( void )
	TWOWORDINLINE( 0x2EB8, 0x0D28 ); /* MOVE.l $0D28,(SP) */
extern pascal void LMSetJVBLTask( UniversalProcPtr value )
	TWOWORDINLINE( 0x21DF, 0x0D28 ); /* MOVE.l (SP)+,$0D28 */
extern pascal Handle LMGetSynListHandle( void )
	TWOWORDINLINE( 0x2EB8, 0x0D32 ); /* MOVE.l $0D32,(SP) */
extern pascal void LMSetSynListHandle( Handle value )
	TWOWORDINLINE( 0x21DF, 0x0D32 ); /* MOVE.l (SP)+,$0D32 */
extern pascal MCTableHandle LMGetMenuCInfo( void )
	TWOWORDINLINE( 0x2EB8, 0x0D50 ); /* MOVE.l $0D50,(SP) */
extern pascal void LMSetMenuCInfo( MCTableHandle value )
	TWOWORDINLINE( 0x21DF, 0x0D50 ); /* MOVE.l (SP)+,$0D50 */
extern pascal UniversalProcPtr LMGetJDTInstall( void )
	TWOWORDINLINE( 0x2EB8, 0x0D9C ); /* MOVE.l $0D9C,(SP) */
extern pascal void LMSetJDTInstall( UniversalProcPtr value )
	TWOWORDINLINE( 0x21DF, 0x0D9C ); /* MOVE.l (SP)+,$0D9C */
extern pascal SInt16 LMGetTimeSCSIDB( void )
	TWOWORDINLINE( 0x3EB8, 0x0B24 ); /* MOVE.w $0B24,(SP) */
extern pascal void LMSetTimeSCSIDB( SInt16 value )
	TWOWORDINLINE( 0x31DF, 0x0B24 ); /* MOVE.w (SP)+,$0B24 */
/**************************************************************************************

	MORE COMPLEX LOWMEM ACCESSORS

**************************************************************************************/
#if CFMSYSTEMCALLS
extern pascal void LMGetDSAlertRect(Rect *dsAlertRectValue);
extern pascal void LMSetDSAlertRect(const Rect *dsAlertRectValue);
extern pascal void LMGetDragPattern(Pattern *dragPatternValue);
extern pascal void LMSetDragPattern(const Pattern *dragPatternValue);
extern pascal void LMGetDeskPattern(Pattern *deskPatternValue);
extern pascal void LMSetDeskPattern(const Pattern *deskPatternValue);
extern pascal void LMGetHiliteRGB(RGBColor *hiliteRGBValue);
extern pascal void LMSetHiliteRGB(const RGBColor *hiliteRGBValue);
extern pascal QHdrPtr LMGetEventQueue(void);
extern pascal void LMSetEventQueue(QHdrPtr eventQueueValue);
extern pascal QHdrPtr LMGetVBLQueue(void);
extern pascal void LMSetVBLQueue(QHdrPtr vblQueueValue);
extern pascal QHdrPtr LMGetDrvQHdr(void);
extern pascal void LMSetDrvQHdr(QHdrPtr drvQHdrValue);
extern pascal QHdrPtr LMGetVCBQHdr(void);
extern pascal void LMSetVCBQHdr(QHdrPtr vcbQHdrValue);
extern pascal QHdrPtr LMGetDTQueue(void);
extern pascal void LMSetDTQueue(QHdrPtr dtQueueValue);
extern pascal QHdrPtr LMGetFSQHdr(void);
/**************************************************************************************
	"BLOCKMOVE ACCESSORS"
	
		These lowmem accessors use the BlockMove trap
**************************************************************************************/
extern pascal StringPtr LMGetCurApName(void);
extern pascal void LMSetCurApName(ConstStr31Param curApNameValue);
extern pascal StringPtr LMGetSysResName(void);
extern pascal void LMSetSysResName(ConstStr15Param sysResNameValue);
extern pascal StringPtr LMGetFinderName(void);
extern pascal void LMSetFinderName(ConstStr15Param finderNameValue);
extern pascal Ptr LMGetScratch20(void);
extern pascal void LMSetScratch20(const void *scratch20Value);
extern pascal Ptr LMGetToolScratch(void);
extern pascal void LMSetToolScratch(const void *toolScratchValue);
extern pascal Ptr LMGetApplScratch(void);
extern pascal void LMSetApplScratch(const void *applScratchValue);
/**************************************************************************************
	"INDEXED ACCESSORS"
	
		These lowmem accessors take an index parameter to get/set an indexed
		lowmem global.
**************************************************************************************/
extern pascal StringHandle LMGetDAStrings(short whichString);
extern pascal void LMSetDAStrings(StringHandle stringsValue, short whichString);
extern pascal UniversalProcPtr LMGetLvl2DT(short vectorNumber);
extern pascal void LMSetLvl2DT(UniversalProcPtr Lvl2DTValue, short vectorNumber);
extern pascal UniversalProcPtr LMGetExtStsDT(short vectorNumber);
extern pascal void LMSetExtStsDT(UniversalProcPtr ExtStsDTValue, short vectorNumber);
#else
/**************************************************************************************
	"BIG DATA"
	
		These lowmem accessors access big (> 4 bytes) values.
**************************************************************************************/
#define LMGetDSAlertRect(dsAlertRectValue) (*(dsAlertRectValue) = * (Rect*) 0x03F8)
#define LMSetDSAlertRect(dsAlertRectValue) ((* (Rect *) 0x03F8) = *(dsAlertRectValue))
#define LMGetDragPattern(dragPatternValue) (*(dragPatternValue) = * (Pattern *) 0x0A34)
#define LMSetDragPattern(dragPatternValue) ((* (Pattern *) 0x0A34) = *(dragPatternValue))
#define LMGetDeskPattern(deskPatternValue) (*(deskPatternValue) = * (Pattern *) 0x0A3C)
#define LMSetDeskPattern(deskPatternValue) ((* (Pattern *) 0x0A3C) = *(deskPatternValue))
#define LMGetHiliteRGB(hiliteRGBValue) (*(hiliteRGBValue) = *(RGBColor*)0x0DA0)
#define LMSetHiliteRGB(hiliteRGBValue) ((* (RGBColor *) 0x0DA0) = *(hiliteRGBValue))
#define LMGetEventQueue() ( (QHdrPtr) 0x014A)
#define LMSetEventQueue(eventQueueValue) ((* (QHdrPtr) 0x014A) = *(QHdrPtr)(eventQueueValue))
#define LMGetVBLQueue() ( (QHdrPtr) 0x0160)
#define LMSetVBLQueue(vblQueueValue) ((* (QHdrPtr) 0x0160) = *(QHdrPtr)(vblQueueValue))
#define LMGetDrvQHdr() ( (QHdrPtr) 0x0308)
#define LMSetDrvQHdr(drvQHdrValue) ((* (QHdrPtr) 0x0308) = *(QHdrPtr)(drvQHdrValue))
#define LMGetVCBQHdr() ( (QHdrPtr) 0x0356)
#define LMSetVCBQHdr(vcbQHdrValue) ((* (QHdrPtr) 0x0356) = *(QHdrPtr)(vcbQHdrValue))
#define LMGetDTQueue() ( (QHdrPtr) 0x0D92)
#define LMSetDTQueue(dtQueueValue) ((* (QHdrPtr) 0x0D92) = *(QHdrPtr)(dtQueueValue))
#define LMGetFSQHdr() ( (QHdrPtr) 0x0360)
/**************************************************************************************
	"BLOCKMOVE ACCESSORS"
	
		These lowmem accessors use the BlockMove trap
**************************************************************************************/
#define LMGetCurApName() ((StringPtr) 0x0910)
#define LMSetCurApName(curApNameValue) (BlockMoveData((Ptr)(curApNameValue), (Ptr)0x0910, sizeof(Str31)))
#define LMGetSysResName() ( (StringPtr) 0x0AD8)
#define LMSetSysResName(sysResNameValue) (BlockMoveData((Ptr)(sysResNameValue), (Ptr)0x0AD8, sizeof(Str15)))
#define LMGetFinderName() ((StringPtr)0x02E0)
#define LMSetFinderName(finderName) (BlockMoveData((Ptr)(finderName), (Ptr)0x02E0, sizeof(Str15)))
#define LMGetScratch20() ((Ptr) 0x01E4)
#define LMSetScratch20(scratch20Value) (BlockMoveData((Ptr) (scratch20Value), (Ptr) 0x01E4, 20))
#define LMGetToolScratch() ((Ptr) 0x09CE)
#define LMSetToolScratch(toolScratchValue) (BlockMoveData((Ptr)(toolScratchValue), (Ptr) 0x09CE, 8))
#define LMGetApplScratch() ((Ptr) 0x0A78)
#define LMSetApplScratch(applScratchValue) (BlockMoveData((Ptr) (applScratchValue), (Ptr) 0x0A78, 12))
/**************************************************************************************
	"INDEXED ACCESSORS"
	
		These lowmem accessors take an index parameter to get/set an indexed
		lowmem global.
**************************************************************************************/
#define LMGetDAStrings(whichString) ( ((StringHandle*)0x0AA0)[whichString] )
#define LMSetDAStrings(stringsValue, whichString) ( ((StringHandle*)0x0AA0)[whichString] = (stringsValue) )
#define LMGetLvl2DT(vectorNumber) ( ((UniversalProcPtr*)0x01B2)[vectorNumber] )
#define LMSetLvl2DT(lvl2DTValue, vectorNumber) ( ((UniversalProcPtr*)0x01B2)[vectorNumber] = (lvl2DTValue) )
#define LMGetExtStsDT(vectorNumber) ( ((UniversalProcPtr*)0x02BE)[vectorNumber] )
#define LMSetExtStsDT(extStsDTValue, vectorNumber) ( ((UniversalProcPtr*)0x02BE)[vectorNumber] = (extStsDTValue) )
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __LOWMEM__ */
