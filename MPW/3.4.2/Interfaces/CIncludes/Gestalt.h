/*
 	File:		Gestalt.h
 
 	Contains:	Gestalt Interfaces.
 
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

#ifndef __GESTALT__
#define __GESTALT__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __MIXEDMODE__
#include <MixedMode.h>
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


enum {
	gestaltAddressingModeAttr	= 'addr',						/* addressing mode attributes */
	gestalt32BitAddressing		= 0,							/* using 32-bit addressing mode */
	gestalt32BitSysZone			= 1,							/* 32-bit compatible system zone */
	gestalt32BitCapable			= 2								/* Machine is 32-bit capable */
};

enum {
	gestaltAliasMgrAttr			= 'alis',						/* Alias Mgr Attributes */
	gestaltAliasMgrPresent		= 0,							/* True if the Alias Mgr is present */
	gestaltAliasMgrSupportsRemoteAppletalk = 1					/* True if the Alias Mgr knows about Remote Appletalk */
};

enum {
	gestaltAppleTalkVersion		= 'atlk'
};

enum {
	gestaltAUXVersion			= 'a/ux'
};

enum {
	gestaltCloseViewAttr		= 'BSDa',						/* CloseView attributes */
	gestaltCloseViewEnabled		= 0,							/* Closeview enabled (dynamic bit - returns current state) */
	gestaltCloseViewDisplayMgrFriendly = 1						/* Closeview compatible with Display Manager (FUTURE) */
};

enum {
	gestaltCFMAttr				= 'cfrg',						/* returns information about the Code Fragment Manager */
	gestaltCFMPresent			= 0								/* true if the Code Fragment Manager is present */
};

enum {
	gestaltColorMatchingAttr	= 'cmta',						/* ColorSync attributes */
	gestaltHighLevelMatching	= 0,
	gestaltColorMatchingLibLoaded = 1
};

enum {
	gestaltColorMatchingVersion	= 'cmtc',
	gestaltColorSync10			= 0x0100,						/* 0x0100 & 0x0110 _Gestalt versions for 1.0-1.0.3 product */
	gestaltColorSync11			= 0x0110,						/*   0x0100 == low-level matching only */
	gestaltColorSync104			= 0x0104,						/* Real version, by popular demand */
	gestaltColorSync105			= 0x0105
};

enum {
	gestaltConnMgrAttr			= 'conn',						/* connection mgr attributes    */
	gestaltConnMgrPresent		= 0,
	gestaltConnMgrCMSearchFix	= 1,							/* Fix to CMAddSearch?     */
	gestaltConnMgrErrorString	= 2,							/* has CMGetErrorString() */
	gestaltConnMgrMultiAsyncIO	= 3								/* CMNewIOPB, CMDisposeIOPB, CMPBRead, CMPBWrite, CMPBIOKill */
};

enum {
	gestaltComponentMgr			= 'cpnt'
};

enum {
	gestaltColorPickerVersion	= 'cpkr',						/* returns version of ColorPicker */
	gestaltColorPicker			= 'cpkr'
};

/*
	The gestaltNativeCPUtype ('cput') selector can be used to determine the
	native CPU type for all Macs running System 7.5 or later.
	
	The 'cput' selector is not available when running System 7.0 (or earlier)
	on most 68K machines.  If 'cput' is not available, then the 'proc' selector
	should be used to determine the processor type.
	
	An application should always try the 'cput' selector first.  This is because,
	on PowerPC machines, the 'proc' selector will reflect the CPU type of the
	emulator's "virtual processor" rather than the native CPU type.
	
	The values specified below are accurate.  Prior versions of the Gestalt
	interface file contained values that were off by one.
	
	The Quadra 840AV and the Quadra 660AV contain a bug in the ROM code that
	causes the 'cput' selector to respond with the value 5.  This behavior
	occurs only when running System 7.1.  System 7.5 fixes the bug by replacing
	the faulty 'cput' selector function with the correct one.
*/

enum {
	gestaltNativeCPUtype		= 'cput',						/* Native CPU type 									  */
	gestaltCPU68000				= 0,							/* Various 68k CPUs... 	*/
	gestaltCPU68010				= 1,
	gestaltCPU68020				= 2,
	gestaltCPU68030				= 3,
	gestaltCPU68040				= 4,
	gestaltCPU601				= 0x0101,						/* IBM 601 												*/
	gestaltCPU603				= 0x0103,
	gestaltCPU604				= 0x0104,
	gestaltCPU603e				= 0x0106
};

enum {
	gestaltCRMAttr				= 'crm ',						/* comm resource mgr attributes */
	gestaltCRMPresent			= 0,
	gestaltCRMPersistentFix		= 1,							/* fix for persistent tools */
	gestaltCRMToolRsrcCalls		= 2								/* has CRMGetToolResource/ReleaseToolResource */
};

enum {
	gestaltControlStripVersion	= 'csvr'
};

enum {
	gestaltCTBVersion			= 'ctbv'
};

enum {
	gestaltDBAccessMgrAttr		= 'dbac',						/* Database Access Mgr attributes */
	gestaltDBAccessMgrPresent	= 0								/* True if Database Access Mgr present */
};

enum {
	gestaltDictionaryMgrAttr	= 'dict',						/* Dictionary Manager attributes */
	gestaltDictionaryMgrPresent	= 0								/* Dictionary Manager attributes */
};

enum {
	gestaltDITLExtAttr			= 'ditl',						/* AppenDITL, etc. calls from CTB */
	gestaltDITLExtPresent		= 0								/* True if calls are present */
};

enum {
	gestaltDisplayMgrAttr		= 'dply',						/* Display Manager attributes */
	gestaltDisplayMgrPresent	= 0,							/* True if Display Mgr is present */
	gestaltDisplayMgrCanSwitchMirrored = 2,						/* True if Display Mgr can switch modes on mirrored displays */
	gestaltDisplayMgrSetDepthNotifies = 3						/* True SetDepth generates displays mgr notification */
};

enum {
	gestaltDisplayMgrVers		= 'dplv'
};

enum {
	gestaltDragMgrAttr			= 'drag',						/* Drag Manager attributes */
	gestaltDragMgrPresent		= 0,							/* Drag Manager is present */
	gestaltDragMgrFloatingWind	= 1,							/* Drag Manager supports floating windows */
	gestaltPPCDragLibPresent	= 2								/* Drag Manager PPC DragLib is present */
};

enum {
	gestaltEasyAccessAttr		= 'easy',						/* Easy Access attributes */
	gestaltEasyAccessOff		= 0,							/* if Easy Access present, but off (no icon) */
	gestaltEasyAccessOn			= 1,							/* if Easy Access "On" */
	gestaltEasyAccessSticky		= 2,							/* if Easy Access "Sticky" */
	gestaltEasyAccessLocked		= 3								/* if Easy Access "Locked" */
};

enum {
	gestaltEditionMgrAttr		= 'edtn',						/* Edition Mgr attributes */
	gestaltEditionMgrPresent	= 0,							/* True if Edition Mgr present */
	gestaltEditionMgrTranslationAware = 1						/* True if edition manager is translation manager aware */
};

enum {
	gestaltAppleEventsAttr		= 'evnt',						/* Apple Events attributes */
	gestaltAppleEventsPresent	= 0,							/* True if Apple Events present */
	gestaltScriptingSupport		= 1,
	gestaltOSLInSystem			= 2								/* OSL is in system so don’t use the one linked in to app */
};

enum {
	gestaltFinderAttr			= 'fndr',						/* Finder attributes */
	gestaltFinderDropEvent		= 0,							/* Finder recognizes drop event */
	gestaltFinderMagicPlacement	= 1,							/* Finder supports magic icon placement */
	gestaltFinderCallsAEProcess	= 2,							/* Finder calls AEProcessAppleEvent */
	gestaltOSLCompliantFinder	= 3,							/* Finder is scriptable and recordable */
	gestaltFinderSupports4GBVolumes = 4,						/* Finder correctly handles 4GB volumes */
	gestaltFinderHasClippings	= 6								/* Finder supports Drag Manager clipping files */
};

enum {
	gestaltFindFolderAttr		= 'fold',						/* Folder Mgr attributes */
	gestaltFindFolderPresent	= 0								/* True if Folder Mgr present */
};

enum {
	gestaltFontMgrAttr			= 'font',						/* Font Mgr attributes */
	gestaltOutlineFonts			= 0								/* True if Outline Fonts supported */
};

enum {
	gestaltFPUType				= 'fpu ',						/* fpu type */
	gestaltNoFPU				= 0,							/* no FPU */
	gestalt68881				= 1,							/* 68881 FPU */
	gestalt68882				= 2,							/* 68882 FPU */
	gestalt68040FPU				= 3								/* 68040 built-in FPU */
};

enum {
	gestaltFSAttr				= 'fs  ',						/* file system attributes */
	gestaltFullExtFSDispatching	= 0,							/* has really cool new HFSDispatch dispatcher */
	gestaltHasFSSpecCalls		= 1,							/* has FSSpec calls */
	gestaltHasFileSystemManager	= 2,							/* has a file system manager */
	gestaltFSMDoesDynamicLoad	= 3,							/* file system manager supports dynamic loading */
	gestaltFSSupports4GBVols	= 4,							/* file system supports 4 gigabyte volumes */
	gestaltFSSupports2TBVols	= 5,							/* file system supports 2 terabyte volumes */
	gestaltHasExtendedDiskInit	= 6								/* has extended Disk Initialization calls */
};

#if !OLDROUTINELOCATIONS
enum {
	gestaltFSMVersion			= 'fsm '
};

#endif
enum {
	gestaltFXfrMgrAttr			= 'fxfr',						/* file transfer manager attributes */
	gestaltFXfrMgrPresent		= 0,
	gestaltFXfrMgrMultiFile		= 1,							/* supports FTSend and FTReceive */
	gestaltFXfrMgrErrorString	= 2								/* supports FTGetErrorString */
};

enum {
	gestaltGraphicsAttr			= 'gfxa',						/* Quickdraw GX attributes selector */
	gestaltGraphicsIsDebugging	= 0x00000001,
	gestaltGraphicsIsLoaded		= 0x00000002,
	gestaltGraphicsIsPowerPC	= 0x00000004
};

enum {
	gestaltGraphicsVersion		= 'grfx',						/* Quickdraw GX version selector */
	gestaltCurrentGraphicsVersion = 0x00010000					/* the version described in this set of headers */
};

enum {
	gestaltHardwareAttr			= 'hdwr',						/* hardware attributes */
	gestaltHasVIA1				= 0,							/* VIA1 exists */
	gestaltHasVIA2				= 1,							/* VIA2 exists */
	gestaltHasASC				= 3,							/* Apple Sound Chip exists */
	gestaltHasSCC				= 4,							/* SCC exists */
	gestaltHasSCSI				= 7,							/* SCSI exists */
	gestaltHasSoftPowerOff		= 19,							/* Capable of software power off */
	gestaltHasSCSI961			= 21,							/* 53C96 SCSI controller on internal bus */
	gestaltHasSCSI962			= 22,							/* 53C96 SCSI controller on external bus */
	gestaltHasUniversalROM		= 24,							/* Do we have a Universal ROM? */
	gestaltHasEnhancedLtalk		= 30							/* Do we have Enhanced LocalTalk? */
};

enum {
	gestaltHelpMgrAttr			= 'help',						/* Help Mgr Attributes */
	gestaltHelpMgrPresent		= 0,							/* true if help mgr is present */
	gestaltHelpMgrExtensions	= 1								/* true if help mgr extensions are installed */
};

enum {
	gestaltCompressionMgr		= 'icmp'
};

enum {
	gestaltIconUtilitiesAttr	= 'icon',						/* Icon Utilities attributes  (Note: available in System 7.0, despite gestalt) */
	gestaltIconUtilitiesPresent	= 0								/* true if icon utilities are present */
};

enum {
	gestaltKeyboardType			= 'kbd ',						/* keyboard type */
	gestaltMacKbd				= 1,
	gestaltMacAndPad			= 2,
	gestaltMacPlusKbd			= 3,
	gestaltExtADBKbd			= 4,
	gestaltStdADBKbd			= 5,
	gestaltPrtblADBKbd			= 6,
	gestaltPrtblISOKbd			= 7,
	gestaltStdISOADBKbd			= 8,
	gestaltExtISOADBKbd			= 9,
	gestaltADBKbdII				= 10,
	gestaltADBISOKbdII			= 11,
	gestaltPwrBookADBKbd		= 12,
	gestaltPwrBookISOADBKbd		= 13,
	gestaltAppleAdjustKeypad	= 14,
	gestaltAppleAdjustADBKbd	= 15,
	gestaltAppleAdjustISOKbd	= 16,
	gestaltJapanAdjustADBKbd	= 17,							/* Japan Adjustable Keyboard */
	gestaltPwrBkExtISOKbd		= 20,							/* PowerBook Extended International Keyboard with function keys */
	gestaltPwrBkExtJISKbd		= 21,							/* PowerBook Extended Japanese Keyboard with function keys 		*/
	gestaltPwrBkExtADBKbd		= 24							/* PowerBook Extended Domestic Keyboard with function keys 		*/
};

enum {
	gestaltLowMemorySize		= 'lmem'
};

enum {
	gestaltLogicalRAMSize		= 'lram'
};

/*
	MACHINE TYPE CONSTANTS NAMING CONVENTION
	
		All future machine type constant names take the following form:
	
			gestalt<lineName><modelNumber>
			
	Line Names
	
		The following table contains the lines currently produced by Apple and the 
		lineName substrings associated with them:
	
			Line						lineName
			-------------------------	------------
			Macintosh LC				"MacLC"
			Macintosh Performa			"Performa"
			Macintosh PowerBook			"PowerBook"
			Macintosh PowerBook Duo		"PowerBookDuo"
			Power Macintosh				"PowerMac"
			Apple Workgroup Server		"AWS"
		
		The following table contains lineNames for some discontinued lines:
	
			Line						lineName
			-------------------------	------------
			Macintosh Quadra			"MacQuadra" (preferred)
										"Quadra" (also used, but not preferred)
			Macintosh Centris			"MacCentris"
	
	Model Numbers
	
		The modelNumber is a string representing the specific model of the machine
		within its particular line.  For example, for the Power Macintosh 8100/80,
		the modelNumber is "8100".
		
		Some Performa & LC model numbers contain variations in the rightmost 1 or 2
		digits to indicate different RAM and Hard Disk configurations.  A single
		machine type is assigned for all variations of a specific model number.  In
		this case, the modelNumber string consists of the constant leftmost part
		of the model number with 0s for the variant digits.  For example, the
		Performa 6115 and Performa 6116 are both return the same machine type
		constant:  gestaltPerforma6100.	
		
		
	OLD NAMING CONVENTIONS
		
	The "Underscore Speed" suffix
		
		In the past, Apple differentiated between machines that had the same model
		number but different speeds.  For example, the Power Macintosh 8100/80 and
		Power Macintosh 8100/100 return different machine type constants.  This is
		why some existing machine type constant names take the form:
	
			gestalt<lineName><modelNumber>_<speed>
	
		e.g.
	
			gestaltPowerMac8100_110
			gestaltPowerMac7100_80
			gestaltPowerMac7100_66
	
		It is no longer necessary to use the "underscore speed" suffix.  Starting with
		the Power Surge machines (Power Macintosh 7200, 7500, 8500 and 9500), speed is
		no longer used to differentiate between machine types.  This is why a Power
		Macintosh 7200/75 and a Power Macintosh 7200/90 return the same machine type
		constant:  gestaltPowerMac7200.
		
	The "Screen Type" suffix
		
		All PowerBook models prior to the PowerBook 190, and all PowerBook Duo models
		before the PowerBook Duo 2300 take the form:
		
			gestalt<lineName><modelNumber><screenType>
		
		Where <screenType> is "c" or the empty string.
		
		e.g.
		
			gestaltPowerBook100
			gestaltPowerBookDuo280
			gestaltPowerBookDuo280c
			gestaltPowerBook180
			gestaltPowerBook180c
		
		Starting with the PowerBook 190 series and the PowerBook Duo 2300 series, machine
		types are no longer differentiated based on screen type.  This is why a PowerBook
		5300cs/100 and a PowerBook 5300c/100 both return the same machine type constant:
		gestaltPowerBook5300.
	
		Macintosh LC 630				gestaltMacLC630
		Macintosh Performa 6200			gestaltPerforma6200
		Macintosh Quadra 700			gestaltQuadra700
		Macintosh PowerBook 5300		gestaltPowerBook5300
		Macintosh PowerBook Duo 2300	gestaltPowerBookDuo2300
		Power Macintosh 8500			gestaltPowerMac8500
*/

enum {
	gestaltMachineType			= 'mach',						/* machine type */
	gestaltClassic				= 1,
	gestaltMacXL				= 2,
	gestaltMac512KE				= 3,
	gestaltMacPlus				= 4,
	gestaltMacSE				= 5,
	gestaltMacII				= 6,
	gestaltMacIIx				= 7,
	gestaltMacIIcx				= 8,
	gestaltMacSE030				= 9,
	gestaltPortable				= 10,
	gestaltMacIIci				= 11,
	gestaltMacIIfx				= 13,
	gestaltMacClassic			= 17,
	gestaltMacIIsi				= 18,
	gestaltMacLC				= 19,
	gestaltQuadra900			= 20,
	gestaltPowerBook170			= 21,
	gestaltQuadra700			= 22,
	gestaltClassicII			= 23,
	gestaltPowerBook100			= 24,
	gestaltPowerBook140			= 25,
	gestaltQuadra950			= 26,
	gestaltMacLCIII				= 27,
	gestaltPerforma450			= gestaltMacLCIII,
	gestaltPowerBookDuo210		= 29,
	gestaltMacCentris650		= 30,
	gestaltPowerBookDuo230		= 32,
	gestaltPowerBook180			= 33,
	gestaltPowerBook160			= 34,
	gestaltMacQuadra800			= 35,
	gestaltMacQuadra650			= 36,
	gestaltMacLCII				= 37,
	gestaltPowerBookDuo250		= 38,
	gestaltAWS9150_80			= 39,
	gestaltPowerMac8100_110		= 40,
	gestaltAWS8150_110			= gestaltPowerMac8100_110,
	gestaltPowerMac5200			= 41,
	gestaltPowerMac6200			= 42,
	gestaltMacIIvi				= 44,
	gestaltMacIIvm				= 45,
	gestaltPerforma600			= gestaltMacIIvm,
	gestaltPowerMac7100_80		= 47,
	gestaltMacIIvx				= 48,
	gestaltMacColorClassic		= 49,
	gestaltPerforma250			= gestaltMacColorClassic,
	gestaltPowerBook165c		= 50,
	gestaltMacCentris610		= 52,
	gestaltMacQuadra610			= 53,
	gestaltPowerBook145			= 54,
	gestaltPowerMac8100_100		= 55,
	gestaltMacLC520				= 56,
	gestaltAWS9150_120			= 57,
	gestaltMacCentris660AV		= 60,
	gestaltPerforma46x			= 62,
	gestaltPowerMac8100_80		= 65,
	gestaltAWS8150_80			= gestaltPowerMac8100_80,
	gestaltPowerMac9500			= 67,
	gestaltPowerMac7500			= 68,
	gestaltPowerMac8500			= 69,
	gestaltPowerBook180c		= 71,
	gestaltPowerBook520			= 72,
	gestaltPowerBook520c		= gestaltPowerBook520,
	gestaltPowerBook540			= gestaltPowerBook520,
	gestaltPowerBook540c		= gestaltPowerBook520,
	gestaltPowerMac6100_60		= 75,
	gestaltAWS6150_60			= gestaltPowerMac6100_60,
	gestaltPowerBookDuo270c		= 77,
	gestaltMacQuadra840AV		= 78,
	gestaltPerforma550			= 80,
	gestaltPowerBook165			= 84,
	gestaltPowerBook190			= 85,
	gestaltMacTV				= 88,
	gestaltMacLC475				= 89,
	gestaltPerforma47x			= gestaltMacLC475,
	gestaltMacLC575				= 92,
	gestaltMacQuadra605			= 94,
	gestaltQuadra630			= 98,
	gestaltPowerMac6100_66		= 100,
	gestaltAWS6150_66			= gestaltPowerMac6100_66,
	gestaltPowerBookDuo280		= 102,
	gestaltPowerBookDuo280c		= 103,
	gestaltPowerMac7200			= 108,
	gestaltPowerMac7100_66		= 112,							/* Power Macintosh 7100/66 */
	gestaltPowerBook150			= 115,
	gestaltPowerBookDuo2300		= 124,
	gestaltPowerBook500PPCUpgrade = 126,
	gestaltPowerBook5300		= 128
};


enum {
	kMachineNameStrID			= -16395
};

enum {
	gestaltMachineIcon			= 'micn'
};

enum {
	gestaltMiscAttr				= 'misc',						/* miscellaneous attributes */
	gestaltScrollingThrottle	= 0,							/* true if scrolling throttle on */
	gestaltSquareMenuBar		= 2								/* true if menu bar is square */
};

/*
	The name gestaltMixedModeVersion for the 'mixd' selector is semantically incorrect.
	The same selector has been renamed gestaltMixedModeAttr to properly reflect the
	Inside Mac: PowerPC System Software documentation.  The gestaltMixedModeVersion
	symbol has been preserved only for backwards compatibility.

	Developers are forewarned that gestaltMixedModeVersion has a limited lifespan and
	will be removed in a future release of the Interfaces.

	For the first version of Mixed Mode, both meanings of the 'mixd' selector are
	functionally identical.  They both return 0x00000001.  In subsequent versions
	of Mixed Mode, however, the 'mixd' selector will not respond with an increasing
	version number, but rather, with 32 attribute bits with various meanings.
*/
enum {
	gestaltMixedModeVersion		= 'mixd'
};

enum {
	gestaltMixedModeAttr		= 'mixd',						/* returns Mixed Mode attributes */
	gestaltMixedModePowerPC		= 0,							/* true if Mixed Mode supports PowerPC ABI calling conventions */
	gestaltPowerPCAware			= 0,							/* old name for gestaltMixedModePowerPC */
	gestaltMixedModeCFM68K		= 1,							/* true if Mixed Mode supports CFM-68K calling conventions */
	gestaltMixedModeCFM68KHasTrap = 2,							/* true if CFM-68K Mixed Mode implements _MixedModeDispatch (versions 1.0.1 and prior did not) */
	gestaltMixedModeCFM68KHasState = 3							/* true if CFM-68K Mixed Mode exports Save/RestoreMixedModeState */
};


enum {
	gestaltMMUType				= 'mmu ',						/* mmu type */
	gestaltNoMMU				= 0,							/* no MMU */
	gestaltAMU					= 1,							/* address management unit */
	gestalt68851				= 2,							/* 68851 PMMU */
	gestalt68030MMU				= 3,							/* 68030 built-in MMU */
	gestalt68040MMU				= 4,							/* 68040 built-in MMU */
	gestaltEMMU1				= 5								/* Emulated MMU type 1  */
};

enum {
	gestaltStdNBPAttr			= 'nlup',						/* standard nbp attributes */
	gestaltStdNBPPresent		= 0
};

enum {
	gestaltNotificationMgrAttr	= 'nmgr',						/* notification manager attributes */
	gestaltNotificationPresent	= 0								/* notification manager exists */
};

enum {
	gestaltNameRegistryVersion	= 'nreg'
};

enum {
	gestaltNuBusSlotCount		= 'nubs'
};

enum {
	gestaltOpenFirmwareInfo		= 'opfw'
};

enum {
	gestaltOSAttr				= 'os  ',						/* o/s attributes */
	gestaltSysZoneGrowable		= 0,							/* system heap is growable */
	gestaltLaunchCanReturn		= 1,							/* can return from launch */
	gestaltLaunchFullFileSpec	= 2,							/* can launch from full file spec */
	gestaltLaunchControl		= 3,							/* launch control support available */
	gestaltTempMemSupport		= 4,							/* temp memory support */
	gestaltRealTempMemory		= 5,							/* temp memory handles are real */
	gestaltTempMemTracked		= 6,							/* temporary memory handles are tracked */
	gestaltIPCSupport			= 7,							/* IPC support is present */
	gestaltSysDebuggerSupport	= 8								/* system debugger support is present */
};

enum {
	gestaltOSTable				= 'ostt'
};

enum {
	gestaltPCXAttr				= 'pcxg',						/* PC Exchange attributes */
	gestaltPCXHas8and16BitFAT	= 0,							/* PC Exchange supports both 8 and 16 bit FATs */
	gestaltPCXHasProDOS			= 1								/* PC Exchange supports ProDOS */
};

enum {
	gestaltLogicalPageSize		= 'pgsz'
};

enum {
	gestaltPopupAttr			= 'pop!',						/* popup cdef attributes */
	gestaltPopupPresent			= 0
};

enum {
	gestaltPowerMgrAttr			= 'powr',						/* power manager attributes */
	gestaltPMgrExists			= 0,
	gestaltPMgrCPUIdle			= 1,
	gestaltPMgrSCC				= 2,
	gestaltPMgrSound			= 3,
	gestaltPMgrDispatchExists	= 4
};

/*
 * PPC will return the combination of following bit fields.
 * e.g. gestaltPPCSupportsRealTime +gestaltPPCSupportsIncoming + gestaltPPCSupportsOutGoing
 * indicates PPC is cuurently is only supports real time delivery
 * and both incoming and outgoing network sessions are allowed.
 * By default local real time delivery is supported as long as PPCInit has been called.*/
enum {
	gestaltPPCToolboxAttr		= 'ppc ',						/* PPC toolbox attributes */
	gestaltPPCToolboxPresent	= 0x0000,						/* PPC Toolbox is present  Requires PPCInit to be called */
	gestaltPPCSupportsRealTime	= 0x1000,						/* PPC Supports real-time delivery */
	gestaltPPCSupportsIncoming	= 0x0001,						/* PPC will deny incoming network requests */
	gestaltPPCSupportsOutGoing	= 0x0002						/* PPC will deny outgoing network requests */
};

enum {
	gestaltProcessorType		= 'proc',						/* processor type */
	gestalt68000				= 1,
	gestalt68010				= 2,
	gestalt68020				= 3,
	gestalt68030				= 4,
	gestalt68040				= 5
};

enum {
	gestaltParityAttr			= 'prty',						/* parity attributes */
	gestaltHasParityCapability	= 0,							/* has ability to check parity */
	gestaltParityEnabled		= 1								/* parity checking enabled */
};

enum {
	gestaltQuickdrawVersion		= 'qd  ',						/* quickdraw version */
	gestaltOriginalQD			= 0x000,						/* original 1-bit QD */
	gestalt8BitQD				= 0x100,						/* 8-bit color QD */
	gestalt32BitQD				= 0x200,						/* 32-bit color QD */
	gestalt32BitQD11			= 0x201,						/* 32-bit color QDv1.1 */
	gestalt32BitQD12			= 0x220,						/* 32-bit color QDv1.2 */
	gestalt32BitQD13			= 0x230							/* 32-bit color QDv1.3 */
};

enum {
	gestaltQuickdrawFeatures	= 'qdrw',						/* quickdraw features */
	gestaltHasColor				= 0,							/* color quickdraw present */
	gestaltHasDeepGWorlds		= 1,							/* GWorlds can be deeper than 1-bit */
	gestaltHasDirectPixMaps		= 2,							/* PixMaps can be direct (16 or 32 bit) */
	gestaltHasGrayishTextOr		= 3,							/* supports text mode grayishTextOr */
	gestaltSupportsMirroring	= 4								/* Supports video mirroring via the Display Manager. */
};

enum {
	gestaltQuickTimeVersion		= 'qtim',						/* returns version of QuickTime */
	gestaltQuickTime			= 'qtim'
};

enum {
	gestaltQuickTimeFeatures	= 'qtrs',
	gestaltPPCQuickTimeLibPresent = 0							/* PowerPC QuickTime glue library is present */
};

enum {
	gestaltPhysicalRAMSize		= 'ram '
};

enum {
	gestaltRBVAddr				= 'rbv '
};

enum {
	gestaltROMSize				= 'rom '
};

enum {
	gestaltROMVersion			= 'romv'
};

enum {
	gestaltResourceMgrAttr		= 'rsrc',						/* Resource Mgr attributes */
	gestaltPartialRsrcs			= 0								/* True if partial resources exist */
};

enum {
	gestaltRealtimeMgrAttr		= 'rtmr',						/* Realtime manager attributes			*/
	gestaltRealtimeMgrPresent	= 0								/* true if the Realtime manager is present 	*/
};

enum {
	gestaltSCCReadAddr			= 'sccr'
};

enum {
	gestaltSCCWriteAddr			= 'sccw'
};

enum {
	gestaltScrapMgrAttr			= 'scra',						/* Scrap Manager attributes */
	gestaltScrapMgrTranslationAware = 0							/* True if scrap manager is translation aware */
};

enum {
	gestaltScriptMgrVersion		= 'scri'
};

enum {
	gestaltScriptCount			= 'scr#'
};

enum {
	gestaltSCSI					= 'scsi',						/* SCSI Manager attributes */
	gestaltAsyncSCSI			= 0,							/* Supports Asynchronous SCSI */
	gestaltAsyncSCSIINROM		= 1,							/* Async scsi is in ROM (available for booting) */
	gestaltSCSISlotBoot			= 2								/* ROM supports Slot-style PRAM for SCSI boots (PDM and later) */
};

enum {
	gestaltControlStripAttr		= 'sdev',						/* Control Strip attributes */
	gestaltControlStripExists	= 0,							/* Control Strip is installed */
	gestaltControlStripVersionFixed = 1,						/* Control Strip version Gestalt selector was fixed */
	gestaltControlStripUserFont	= 2,							/* supports user-selectable font/size */
	gestaltControlStripUserHotKey = 3							/* support user-selectable hot key to show/hide the window */
};

enum {
	gestaltSerialAttr			= 'ser ',						/* Serial attributes */
	gestaltHasGPIaToDCDa		= 0,							/* GPIa connected to DCDa*/
	gestaltHasGPIaToRTxCa		= 1,							/* GPIa connected to RTxCa clock input*/
	gestaltHasGPIbToDCDb		= 2								/* GPIb connected to DCDb */
};

enum {
	gestaltNuBusConnectors		= 'sltc'
};

enum {
	gestaltSlotAttr				= 'slot',						/* slot attributes  */
	gestaltSlotMgrExists		= 0,							/* true is slot mgr exists  */
	gestaltNuBusPresent			= 1,							/* NuBus slots are present  */
	gestaltSESlotPresent		= 2,							/* SE PDS slot present  */
	gestaltSE30SlotPresent		= 3,							/* SE/30 slot present  */
	gestaltPortableSlotPresent	= 4								/* Portable’s slot present  */
};

enum {
	gestaltFirstSlotNumber		= 'slt1'
};

enum {
	gestaltSoundAttr			= 'snd ',						/* sound attributes */
	gestaltStereoCapability		= 0,							/* sound hardware has stereo capability */
	gestaltStereoMixing			= 1,							/* stereo mixing on external speaker */
	gestaltSoundIOMgrPresent	= 3,							/* The Sound I/O Manager is present */
	gestaltBuiltInSoundInput	= 4,							/* built-in Sound Input hardware is present */
	gestaltHasSoundInputDevice	= 5,							/* Sound Input device available */
	gestaltPlayAndRecord		= 6,							/* built-in hardware can play and record simultaneously */
	gestalt16BitSoundIO			= 7,							/* sound hardware can play and record 16-bit samples */
	gestaltStereoInput			= 8,							/* sound hardware can record stereo */
	gestaltLineLevelInput		= 9,							/* sound input port requires line level */
/* the following bits are not defined prior to Sound Mgr 3.0 */
	gestaltSndPlayDoubleBuffer	= 10,							/* SndPlayDoubleBuffer available, set by Sound Mgr 3.0 and later */
	gestaltMultiChannels		= 11,							/* multiple channel support, set by Sound Mgr 3.0 and later */
	gestalt16BitAudioSupport	= 12							/* 16 bit audio data supported, set by Sound Mgr 3.0 and later */
};

enum {
	gestaltStandardFileAttr		= 'stdf',						/* Standard File attributes */
	gestaltStandardFile58		= 0,							/* True if selectors 5-8 (StandardPutFile-CustomGetFile) are supported */
	gestaltStandardFileTranslationAware = 1,					/* True if standard file is translation manager aware */
	gestaltStandardFileHasColorIcons = 2,						/* True if standard file has 16x16 color icons */
	gestaltStandardFileUseGenericIcons = 3,						/* Standard file LDEF to use only the system generic icons if true */
	gestaltStandardFileHasDynamicVolumeAllocation = 4			/* True if standard file supports more than 20 volumes */
};

enum {
	gestaltSysArchitecture		= 'sysa',						/* Native System Architecture */
	gestalt68k					= 1,							/* Motorola MC68k architecture */
	gestaltPowerPC				= 2								/* IBM PowerPC architecture */
};

enum {
	gestaltSystemVersion		= 'sysv'
};

enum {
	gestaltTSMgrVersion			= 'tsmv',						/* Text Services Mgr version, if present */
	gestaltTSMgr2				= 0x200
};

enum {
	gestaltTSMgrAttr			= 'tsma',						/* Text Services Mgr attributes, if present */
	gestaltTSMDisplayMgrAwareBit = 0,							/* TSM knows about display manager */
	gestaltTSMdoesTSMTEBit		= 1								/* TSM has integrated TSMTE */
};

enum {
	gestaltTSMTEVersion			= 'tmTV',
	gestaltTSMTE1				= 0x100,
	gestaltTSMTE2				= 0x200
};

enum {
	gestaltTSMTEAttr			= 'tmTE',
	gestaltTSMTEPresent			= 0,
	gestaltTSMTE				= 0								/* gestaltTSMTE is old name for gestaltTSMTEPresent */
};

enum {
	gestaltTextEditVersion		= 'te  ',						/* TextEdit version number */
	gestaltTE1					= 1,							/* TextEdit in MacIIci ROM */
	gestaltTE2					= 2,							/* TextEdit with 6.0.4 Script Systems on MacIIci (Script bug fixes for MacIIci) */
	gestaltTE3					= 3,							/* TextEdit with 6.0.4 Script Systems all but MacIIci */
	gestaltTE4					= 4,							/* TextEdit in System 7.0 */
	gestaltTE5					= 5,							/* TextWidthHook available in TextEdit */
	gestaltTE6					= 6								/* TextEdit in System 8.0 */
};

enum {
	gestaltTEAttr				= 'teat',						/* TextEdit attributes */
	gestaltTEHasGetHiliteRgn	= 0,							/* TextEdit has TEGetHiliteRgn */
	gestaltTESupportsInlineInput = 1,							/* TextEdit does Inline Input */
	gestaltTESupportsTextObjects = 2							/* TextEdit does Text Objects */
};

enum {
	gestaltTeleMgrAttr			= 'tele',						/* Telephone manager attributes */
	gestaltTeleMgrPresent		= 0,
	gestaltTeleMgrPowerPCSupport = 1,
	gestaltTeleMgrSoundStreams	= 2,
	gestaltTeleMgrAutoAnswer	= 3,
	gestaltTeleMgrIndHandset	= 4,
	gestaltTeleMgrSilenceDetect	= 5,
	gestaltTeleMgrNewTELNewSupport = 6
};

enum {
	gestaltTermMgrAttr			= 'term',						/* terminal mgr attributes */
	gestaltTermMgrPresent		= 0,
	gestaltTermMgrErrorString	= 2
};

enum {
	gestaltTimeMgrVersion		= 'tmgr',						/* time mgr version */
	gestaltStandardTimeMgr		= 1,							/* standard time mgr is present */
	gestaltRevisedTimeMgr		= 2,							/* revised time mgr is present */
	gestaltExtendedTimeMgr		= 3								/* extended time mgr is present */
};

enum {
	gestaltSpeechAttr			= 'ttsc',						/* Speech Manager attributes */
	gestaltSpeechMgrPresent		= 0,							/* bit set indicates that Speech Manager exists */
	gestaltSpeechHasPPCGlue		= 1								/* bit set indicates that native PPC glue for Speech Manager API exists */
};

enum {
	gestaltToolboxTable			= 'tbtt'
};

enum {
	gestaltThreadMgrAttr		= 'thds',						/* Thread Manager attributes */
	gestaltThreadMgrPresent		= 0,							/* bit true if Thread Mgr is present */
	gestaltSpecificMatchSupport	= 1,							/* bit true if Thread Mgr supports exact match creation option */
	gestaltThreadsLibraryPresent = 2							/* bit true if Thread Mgr shared library is present */
};

enum {
	gestaltTVAttr				= 'tv  ',						/* TV version										<EX16>	 */
	gestaltHasTVTuner			= 0,							/* supports Philips FL1236F video tuner				<EX16>	 */
	gestaltHasSoundFader		= 1,							/* supports Philips TEA6330 Sound Fader chip		<EX16>	 */
	gestaltHasHWClosedCaptioning = 2,							/* supports Philips SAA5252 Closed Captioning		<EX16>	 */
	gestaltHasIRRemote			= 3,							/* supports CyclopsII Infra Red Remote control		<EX16>	 */
	gestaltHasVidDecoderScaler	= 4,							/* supports Philips SAA7194 Video Decoder/Scaler	<EX16>	 */
	gestaltHasStereoDecoder		= 5								/* supports Sony SBX1637A-01 stereo decoder			<EX16>	 */
};

enum {
	gestaltVersion				= 'vers',						/* gestalt version */
	gestaltValueImplementedVers	= 5								/* version of gestalt where gestaltValue is implemented. */
};

enum {
	gestaltVIA1Addr				= 'via1'
};

enum {
	gestaltVIA2Addr				= 'via2'
};

enum {
	gestaltVMAttr				= 'vm  ',						/* virtual memory attributes */
	gestaltVMPresent			= 0,							/* true if virtual memory is present */
	gestaltVMHasLockMemoryForOutput = 1,						/* true if LockMemoryForOutput is available */
	gestaltVMFilemappingOn 		= 3								/* true if filemapping is available */
};

enum {
	gestaltTranslationAttr		= 'xlat',						/* Translation Manager attributes */
	gestaltTranslationMgrExists	= 0,							/* True if translation manager exists */
	gestaltTranslationMgrHintOrder = 1,							/* True if hint order reversal in effect */
	gestaltTranslationPPCAvail	= 2,
	gestaltTranslationGetPathAPIAvail = 3
};

enum {
	gestaltExtToolboxTable		= 'xttt'
};

typedef pascal OSErr (*SelectorFunctionProcPtr)(OSType selector, long *response);

#if GENERATINGCFM
typedef UniversalProcPtr SelectorFunctionUPP;
#else
typedef SelectorFunctionProcPtr SelectorFunctionUPP;
#endif

enum {
	uppSelectorFunctionProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(OSType)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long*)))
};

#if GENERATINGCFM
#define NewSelectorFunctionProc(userRoutine)		\
		(SelectorFunctionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSelectorFunctionProcInfo, GetCurrentArchitecture())
#else
#define NewSelectorFunctionProc(userRoutine)		\
		((SelectorFunctionUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallSelectorFunctionProc(userRoutine, selector, response)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSelectorFunctionProcInfo, (selector), (response))
#else
#define CallSelectorFunctionProc(userRoutine, selector, response)		\
		(*(userRoutine))((selector), (response))
#endif

#if SystemSevenOrLater

#if !GENERATINGCFM
#pragma parameter __D0 Gestalt(__D0, __A1)
#endif
extern pascal OSErr Gestalt(OSType selector, long *response)
 TWOWORDINLINE(0xA1AD, 0x2288);

#if !GENERATINGCFM
#pragma parameter __D0 ReplaceGestalt(__D0, __A0, __A1)
#endif
extern pascal OSErr ReplaceGestalt(OSType selector, SelectorFunctionUPP gestaltFunction, SelectorFunctionUPP *oldGestaltFunction)
 FOURWORDINLINE(0x2F09, 0xA5AD, 0x225F, 0x2288);

#if !GENERATINGCFM
#pragma parameter __D0 NewGestalt(__D0, __A0)
#endif
extern pascal OSErr NewGestalt(OSType selector, SelectorFunctionUPP gestaltFunction)
 ONEWORDINLINE(0xA3AD);
#else
extern pascal OSErr Gestalt(OSType selector, long *response);
extern pascal OSErr NewGestalt(OSType selector, SelectorFunctionUPP gestaltFunction);
extern pascal OSErr ReplaceGestalt(OSType selector, SelectorFunctionUPP gestaltFunction, SelectorFunctionUPP *oldGestaltFunction);
#endif
#if SystemSevenFiveOrLater
/* These functions are built into System 7.5, but not on earlier systems */
extern pascal OSErr NewGestaltValue(OSType selector, long newValue)
 THREEWORDINLINE(0x303C, 0x0401, 0xABF1);
extern pascal OSErr ReplaceGestaltValue(OSType selector, long replacementValue)
 THREEWORDINLINE(0x303C, 0x0402, 0xABF1);
extern pascal OSErr SetGestaltValue(OSType selector, long newValue)
 THREEWORDINLINE(0x303C, 0x0404, 0xABF1);
extern pascal OSErr DeleteGestaltValue(OSType selector)
 THREEWORDINLINE(0x303C, 0x0203, 0xABF1);
#else
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

#endif /* __GESTALT__ */
