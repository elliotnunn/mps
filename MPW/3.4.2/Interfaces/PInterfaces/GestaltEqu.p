{
 	File:		GestaltEqu.p
 
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
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT GestaltEqu;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __GESTALTEQU__}
{$SETC __GESTALTEQU__ := 1}

{$I+}
{$SETC GestaltEquIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	gestaltAddressingModeAttr	= 'addr';						{ addressing mode attributes }
	gestalt32BitAddressing		= 0;							{ using 32-bit addressing mode }
	gestalt32BitSysZone			= 1;							{ 32-bit compatible system zone }
	gestalt32BitCapable			= 2;							{ Machine is 32-bit capable }

	gestaltAliasMgrAttr			= 'alis';						{ Alias Mgr Attributes }
	gestaltAliasMgrPresent		= 0;							{ True if the Alias Mgr is present }
	gestaltAliasMgrSupportsRemoteAppletalk = 1;					{ True if the Alias Mgr knows about Remote Appletalk }

	gestaltAppleTalkVersion		= 'atlk';

	gestaltAUXVersion			= 'a/ux';

	gestaltCloseViewAttr		= 'BSDa';						{ CloseView attributes }
	gestaltCloseViewEnabled		= 0;							{ Closeview enabled (dynamic bit - returns current state) }
	gestaltCloseViewDisplayMgrFriendly = 1;						{ Closeview compatible with Display Manager (FUTURE) }

	gestaltCFMAttr				= 'cfrg';						{ returns information about the Code Fragment Manager }
	gestaltCFMPresent			= 0;							{ true if the Code Fragment Manager is present }

	gestaltColorMatchingAttr	= 'cmta';						{ ColorSync attributes }
	gestaltHighLevelMatching	= 0;
	gestaltColorMatchingLibLoaded = 1;

	gestaltColorMatchingVersion	= 'cmtc';
	gestaltColorSync10			= $0100;						{ 0x0100 & 0x0110 _Gestalt versions for 1.0-1.0.3 product }
	gestaltColorSync11			= $0110;						{   0x0100 == low-level matching only }
	gestaltColorSync104			= $0104;						{ Real version, by popular demand }
	gestaltColorSync105			= $0105;

	gestaltConnMgrAttr			= 'conn';						{ connection mgr attributes    }
	gestaltConnMgrPresent		= 0;
	gestaltConnMgrCMSearchFix	= 1;							{ Fix to CMAddSearch?     }
	gestaltConnMgrErrorString	= 2;							{ has CMGetErrorString() }
	gestaltConnMgrMultiAsyncIO	= 3;							{ CMNewIOPB, CMDisposeIOPB, CMPBRead, CMPBWrite, CMPBIOKill }

	gestaltComponentMgr			= 'cpnt';

	gestaltColorPickerVersion	= 'cpkr';						{ returns version of ColorPicker }
	gestaltColorPicker			= 'cpkr';

{
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
}
	gestaltNativeCPUtype		= 'cput';						{  Native CPU type 									   }
	gestaltCPU68000				= 0;							{  Various 68k CPUs... 	 }
	gestaltCPU68010				= 1;
	gestaltCPU68020				= 2;
	gestaltCPU68030				= 3;
	gestaltCPU68040				= 4;
	gestaltCPU601				= $0101;						{  IBM 601 												 }
	gestaltCPU603				= $0103;
	gestaltCPU604				= $0104;
	gestaltCPU603e				= $0106;

	gestaltCRMAttr				= 'crm ';						{ comm resource mgr attributes }
	gestaltCRMPresent			= 0;
	gestaltCRMPersistentFix		= 1;							{ fix for persistent tools }
	gestaltCRMToolRsrcCalls		= 2;							{ has CRMGetToolResource/ReleaseToolResource }

	gestaltControlStripVersion	= 'csvr';

	gestaltCTBVersion			= 'ctbv';

	gestaltDBAccessMgrAttr		= 'dbac';						{ Database Access Mgr attributes }
	gestaltDBAccessMgrPresent	= 0;							{ True if Database Access Mgr present }

	gestaltDictionaryMgrAttr	= 'dict';						{ Dictionary Manager attributes }
	gestaltDictionaryMgrPresent	= 0;							{ Dictionary Manager attributes }

	gestaltDITLExtAttr			= 'ditl';						{ AppenDITL, etc. calls from CTB }
	gestaltDITLExtPresent		= 0;							{ True if calls are present }

	gestaltDisplayMgrAttr		= 'dply';						{ Display Manager attributes }
	gestaltDisplayMgrPresent	= 0;							{ True if Display Mgr is present }
	gestaltDisplayMgrCanSwitchMirrored = 2;						{ True if Display Mgr can switch modes on mirrored displays }
	gestaltDisplayMgrSetDepthNotifies = 3;						{ True SetDepth generates displays mgr notification }

	gestaltDisplayMgrVers		= 'dplv';

	gestaltDragMgrAttr			= 'drag';						{ Drag Manager attributes }
	gestaltDragMgrPresent		= 0;							{ Drag Manager is present }
	gestaltDragMgrFloatingWind	= 1;							{ Drag Manager supports floating windows }
	gestaltPPCDragLibPresent	= 2;							{ Drag Manager PPC DragLib is present }

	gestaltEasyAccessAttr		= 'easy';						{ Easy Access attributes }
	gestaltEasyAccessOff		= 0;							{ if Easy Access present, but off (no icon) }
	gestaltEasyAccessOn			= 1;							{ if Easy Access "On" }
	gestaltEasyAccessSticky		= 2;							{ if Easy Access "Sticky" }
	gestaltEasyAccessLocked		= 3;							{ if Easy Access "Locked" }

	gestaltEditionMgrAttr		= 'edtn';						{ Edition Mgr attributes }
	gestaltEditionMgrPresent	= 0;							{ True if Edition Mgr present }
	gestaltEditionMgrTranslationAware = 1;						{ True if edition manager is translation manager aware }

	gestaltAppleEventsAttr		= 'evnt';						{ Apple Events attributes }
	gestaltAppleEventsPresent	= 0;							{ True if Apple Events present }
	gestaltScriptingSupport		= 1;
	gestaltOSLInSystem			= 2;							{ OSL is in system so don’t use the one linked in to app }

	gestaltFinderAttr			= 'fndr';						{ Finder attributes }
	gestaltFinderDropEvent		= 0;							{ Finder recognizes drop event }
	gestaltFinderMagicPlacement	= 1;							{ Finder supports magic icon placement }
	gestaltFinderCallsAEProcess	= 2;							{ Finder calls AEProcessAppleEvent }
	gestaltOSLCompliantFinder	= 3;							{ Finder is scriptable and recordable }
	gestaltFinderSupports4GBVolumes = 4;						{ Finder correctly handles 4GB volumes }
	gestaltFinderHasClippings	= 6;							{ Finder supports Drag Manager clipping files }

	gestaltFindFolderAttr		= 'fold';						{ Folder Mgr attributes }
	gestaltFindFolderPresent	= 0;							{ True if Folder Mgr present }

	gestaltFontMgrAttr			= 'font';						{ Font Mgr attributes }
	gestaltOutlineFonts			= 0;							{ True if Outline Fonts supported }

	gestaltFPUType				= 'fpu ';						{ fpu type }
	gestaltNoFPU				= 0;							{ no FPU }
	gestalt68881				= 1;							{ 68881 FPU }
	gestalt68882				= 2;							{ 68882 FPU }
	gestalt68040FPU				= 3;							{ 68040 built-in FPU }

	gestaltFSAttr				= 'fs  ';						{ file system attributes }
	gestaltFullExtFSDispatching	= 0;							{ has really cool new HFSDispatch dispatcher }
	gestaltHasFSSpecCalls		= 1;							{ has FSSpec calls }
	gestaltHasFileSystemManager	= 2;							{ has a file system manager }
	gestaltFSMDoesDynamicLoad	= 3;							{ file system manager supports dynamic loading }
	gestaltFSSupports4GBVols	= 4;							{ file system supports 4 gigabyte volumes }
	gestaltFSSupports2TBVols	= 5;							{ file system supports 2 terabyte volumes }
	gestaltHasExtendedDiskInit	= 6;							{ has extended Disk Initialization calls }

{$IFC NOT OLDROUTINELOCATIONS }
	gestaltFSMVersion			= 'fsm ';

{$ENDC}
	gestaltFXfrMgrAttr			= 'fxfr';						{ file transfer manager attributes }
	gestaltFXfrMgrPresent		= 0;
	gestaltFXfrMgrMultiFile		= 1;							{ supports FTSend and FTReceive }
	gestaltFXfrMgrErrorString	= 2;							{ supports FTGetErrorString }

	gestaltGraphicsAttr			= 'gfxa';						{ Quickdraw GX attributes selector }
	gestaltGraphicsIsDebugging	= $00000001;
	gestaltGraphicsIsLoaded		= $00000002;
	gestaltGraphicsIsPowerPC	= $00000004;

	gestaltGraphicsVersion		= 'grfx';						{ Quickdraw GX version selector }
	gestaltCurrentGraphicsVersion = $00010000;					{ the version described in this set of headers }

	gestaltHardwareAttr			= 'hdwr';						{ hardware attributes }
	gestaltHasVIA1				= 0;							{ VIA1 exists }
	gestaltHasVIA2				= 1;							{ VIA2 exists }
	gestaltHasASC				= 3;							{ Apple Sound Chip exists }
	gestaltHasSCC				= 4;							{ SCC exists }
	gestaltHasSCSI				= 7;							{ SCSI exists }
	gestaltHasSoftPowerOff		= 19;							{ Capable of software power off }
	gestaltHasSCSI961			= 21;							{ 53C96 SCSI controller on internal bus }
	gestaltHasSCSI962			= 22;							{ 53C96 SCSI controller on external bus }
	gestaltHasUniversalROM		= 24;							{ Do we have a Universal ROM? }
	gestaltHasEnhancedLtalk		= 30;							{ Do we have Enhanced LocalTalk? }

	gestaltHelpMgrAttr			= 'help';						{ Help Mgr Attributes }
	gestaltHelpMgrPresent		= 0;							{ true if help mgr is present }
	gestaltHelpMgrExtensions	= 1;							{ true if help mgr extensions are installed }

	gestaltCompressionMgr		= 'icmp';

	gestaltIconUtilitiesAttr	= 'icon';						{ Icon Utilities attributes  (Note: available in System 7.0, despite gestalt) }
	gestaltIconUtilitiesPresent	= 0;							{ true if icon utilities are present }

	gestaltKeyboardType			= 'kbd ';						{ keyboard type }
	gestaltMacKbd				= 1;
	gestaltMacAndPad			= 2;
	gestaltMacPlusKbd			= 3;
	gestaltExtADBKbd			= 4;
	gestaltStdADBKbd			= 5;
	gestaltPrtblADBKbd			= 6;
	gestaltPrtblISOKbd			= 7;
	gestaltStdISOADBKbd			= 8;
	gestaltExtISOADBKbd			= 9;
	gestaltADBKbdII				= 10;
	gestaltADBISOKbdII			= 11;
	gestaltPwrBookADBKbd		= 12;
	gestaltPwrBookISOADBKbd		= 13;
	gestaltAppleAdjustKeypad	= 14;
	gestaltAppleAdjustADBKbd	= 15;
	gestaltAppleAdjustISOKbd	= 16;
	gestaltJapanAdjustADBKbd	= 17;							{ Japan Adjustable Keyboard }
	gestaltPwrBkExtISOKbd		= 20;							{ PowerBook Extended International Keyboard with function keys }
	gestaltPwrBkExtJISKbd		= 21;							{ PowerBook Extended Japanese Keyboard with function keys 		}
	gestaltPwrBkExtADBKbd		= 24;							{ PowerBook Extended Domestic Keyboard with function keys 		}

	gestaltLowMemorySize		= 'lmem';

	gestaltLogicalRAMSize		= 'lram';

{
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
}
	gestaltMachineType			= 'mach';						{ machine type }
	gestaltClassic				= 1;
	gestaltMacXL				= 2;
	gestaltMac512KE				= 3;
	gestaltMacPlus				= 4;
	gestaltMacSE				= 5;
	gestaltMacII				= 6;
	gestaltMacIIx				= 7;
	gestaltMacIIcx				= 8;
	gestaltMacSE030				= 9;
	gestaltPortable				= 10;
	gestaltMacIIci				= 11;
	gestaltMacIIfx				= 13;
	gestaltMacClassic			= 17;
	gestaltMacIIsi				= 18;
	gestaltMacLC				= 19;
	gestaltQuadra900			= 20;
	gestaltPowerBook170			= 21;
	gestaltQuadra700			= 22;
	gestaltClassicII			= 23;
	gestaltPowerBook100			= 24;
	gestaltPowerBook140			= 25;
	gestaltQuadra950			= 26;
	gestaltMacLCIII				= 27;
	gestaltPerforma450			= gestaltMacLCIII;
	gestaltPowerBookDuo210		= 29;
	gestaltMacCentris650		= 30;
	gestaltPowerBookDuo230		= 32;
	gestaltPowerBook180			= 33;
	gestaltPowerBook160			= 34;
	gestaltMacQuadra800			= 35;
	gestaltMacQuadra650			= 36;
	gestaltMacLCII				= 37;
	gestaltPowerBookDuo250		= 38;
	gestaltAWS9150_80			= 39;
	gestaltPowerMac8100_110		= 40;
	gestaltAWS8150_110			= gestaltPowerMac8100_110;
	gestaltPowerMac5200			= 41;
	gestaltPowerMac6200			= 42;
	gestaltMacIIvi				= 44;
	gestaltMacIIvm				= 45;
	gestaltPerforma600			= gestaltMacIIvm;
	gestaltPowerMac7100_80		= 47;
	gestaltMacIIvx				= 48;
	gestaltMacColorClassic		= 49;
	gestaltPerforma250			= gestaltMacColorClassic;
	gestaltPowerBook165c		= 50;
	gestaltMacCentris610		= 52;
	gestaltMacQuadra610			= 53;
	gestaltPowerBook145			= 54;
	gestaltPowerMac8100_100		= 55;
	gestaltMacLC520				= 56;
	gestaltAWS9150_120			= 57;
	gestaltMacCentris660AV		= 60;
	gestaltPerforma46x			= 62;
	gestaltPowerMac8100_80		= 65;
	gestaltAWS8150_80			= gestaltPowerMac8100_80;
	gestaltPowerMac9500			= 67;
	gestaltPowerMac7500			= 68;
	gestaltPowerMac8500			= 69;
	gestaltPowerBook180c		= 71;
	gestaltPowerBook520			= 72;
	gestaltPowerBook520c		= 72;
	gestaltPowerBook540			= 72;
	gestaltPowerBook540c		= 72;
	gestaltPowerMac6100_60		= 75;
	gestaltAWS6150_60			= gestaltPowerMac6100_60;
	gestaltPowerBookDuo270c		= 77;
	gestaltMacQuadra840AV		= 78;
	gestaltPerforma550			= 80;
	gestaltPowerBook165			= 84;
	gestaltPowerBook190			= 85;
	gestaltMacTV				= 88;
	gestaltMacLC475				= 89;
	gestaltPerforma47x			= gestaltMacLC475;
	gestaltMacLC575				= 92;
	gestaltMacQuadra605			= 94;
	gestaltQuadra630			= 98;
	gestaltPowerMac6100_66		= 100;
	gestaltAWS6150_66			= gestaltPowerMac6100_66;
	gestaltPowerBookDuo280		= 102;
	gestaltPowerBookDuo280c		= 103;
	gestaltPowerMac7200			= 108;
	gestaltPowerMac7100_66		= 112;							{  Power Macintosh 7100/66  }
	gestaltPowerBook150			= 115;
	gestaltPowerBookDuo2300		= 124;
	gestaltPowerBook500PPCUpgrade = 126;
	gestaltPowerBook5300		= 128;

	kMachineNameStrID			= -16395;

	gestaltMachineIcon			= 'micn';

	gestaltMiscAttr				= 'misc';						{ miscellaneous attributes }
	gestaltScrollingThrottle	= 0;							{ true if scrolling throttle on }
	gestaltSquareMenuBar		= 2;							{ true if menu bar is square }

{
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
}
	gestaltMixedModeVersion		= 'mixd';

	gestaltMixedModeAttr		= 'mixd';						{ returns Mixed Mode attributes }
	gestaltMixedModePowerPC		= 0;							{  true if Mixed Mode supports PowerPC ABI calling conventions  }
	gestaltPowerPCAware			= 0;							{  old name for gestaltMixedModePowerPC  }
	gestaltMixedModeCFM68K		= 1;							{  true if Mixed Mode supports CFM-68K calling conventions  }
	gestaltMixedModeCFM68KHasTrap = 2;							{  true if CFM-68K Mixed Mode implements _MixedModeDispatch (versions 1.0.1 and prior did not)  }
	gestaltMixedModeCFM68KHasState = 3;							{  true if CFM-68K Mixed Mode exports Save/RestoreMixedModeState  }

	gestaltMMUType				= 'mmu ';						{ mmu type }
	gestaltNoMMU				= 0;							{ no MMU }
	gestaltAMU					= 1;							{ address management unit }
	gestalt68851				= 2;							{ 68851 PMMU }
	gestalt68030MMU				= 3;							{ 68030 built-in MMU }
	gestalt68040MMU				= 4;							{ 68040 built-in MMU }
	gestaltEMMU1				= 5;							{ Emulated MMU type 1  }

	gestaltStdNBPAttr			= 'nlup';						{ standard nbp attributes }
	gestaltStdNBPPresent		= 0;

	gestaltNotificationMgrAttr	= 'nmgr';						{ notification manager attributes }
	gestaltNotificationPresent	= 0;							{ notification manager exists }

	gestaltNameRegistryVersion	= 'nreg';

	gestaltNuBusSlotCount		= 'nubs';

	gestaltOpenFirmwareInfo		= 'opfw';

	gestaltOSAttr				= 'os  ';						{ o/s attributes }
	gestaltSysZoneGrowable		= 0;							{ system heap is growable }
	gestaltLaunchCanReturn		= 1;							{ can return from launch }
	gestaltLaunchFullFileSpec	= 2;							{ can launch from full file spec }
	gestaltLaunchControl		= 3;							{ launch control support available }
	gestaltTempMemSupport		= 4;							{ temp memory support }
	gestaltRealTempMemory		= 5;							{ temp memory handles are real }
	gestaltTempMemTracked		= 6;							{ temporary memory handles are tracked }
	gestaltIPCSupport			= 7;							{ IPC support is present }
	gestaltSysDebuggerSupport	= 8;							{ system debugger support is present }

	gestaltOSTable				= 'ostt';

	gestaltPCXAttr				= 'pcxg';						{ PC Exchange attributes }
	gestaltPCXHas8and16BitFAT	= 0;							{ PC Exchange supports both 8 and 16 bit FATs }
	gestaltPCXHasProDOS			= 1;							{ PC Exchange supports ProDOS }

	gestaltLogicalPageSize		= 'pgsz';

	gestaltPopupAttr			= 'pop!';						{ popup cdef attributes }
	gestaltPopupPresent			= 0;

	gestaltPowerMgrAttr			= 'powr';						{ power manager attributes }
	gestaltPMgrExists			= 0;
	gestaltPMgrCPUIdle			= 1;
	gestaltPMgrSCC				= 2;
	gestaltPMgrSound			= 3;
	gestaltPMgrDispatchExists	= 4;

{
 * PPC will return the combination of following bit fields.
 * e.g. gestaltPPCSupportsRealTime +gestaltPPCSupportsIncoming + gestaltPPCSupportsOutGoing
 * indicates PPC is cuurently is only supports real time delivery
 * and both incoming and outgoing network sessions are allowed.
 * By default local real time delivery is supported as long as PPCInit has been called.}
	gestaltPPCToolboxAttr		= 'ppc ';						{ PPC toolbox attributes }
	gestaltPPCToolboxPresent	= $0000;						{ PPC Toolbox is present  Requires PPCInit to be called }
	gestaltPPCSupportsRealTime	= $1000;						{ PPC Supports real-time delivery }
	gestaltPPCSupportsIncoming	= $0001;						{ PPC will deny incoming network requests }
	gestaltPPCSupportsOutGoing	= $0002;						{ PPC will deny outgoing network requests }

	gestaltProcessorType		= 'proc';						{ processor type }
	gestalt68000				= 1;
	gestalt68010				= 2;
	gestalt68020				= 3;
	gestalt68030				= 4;
	gestalt68040				= 5;

	gestaltParityAttr			= 'prty';						{ parity attributes }
	gestaltHasParityCapability	= 0;							{ has ability to check parity }
	gestaltParityEnabled		= 1;							{ parity checking enabled }

	gestaltQuickdrawVersion		= 'qd  ';						{ quickdraw version }
	gestaltOriginalQD			= $000;							{ original 1-bit QD }
	gestalt8BitQD				= $100;							{ 8-bit color QD }
	gestalt32BitQD				= $200;							{ 32-bit color QD }
	gestalt32BitQD11			= $201;							{ 32-bit color QDv1.1 }
	gestalt32BitQD12			= $220;							{ 32-bit color QDv1.2 }
	gestalt32BitQD13			= $230;							{ 32-bit color QDv1.3 }

	gestaltQuickdrawFeatures	= 'qdrw';						{ quickdraw features }
	gestaltHasColor				= 0;							{ color quickdraw present }
	gestaltHasDeepGWorlds		= 1;							{ GWorlds can be deeper than 1-bit }
	gestaltHasDirectPixMaps		= 2;							{ PixMaps can be direct (16 or 32 bit) }
	gestaltHasGrayishTextOr		= 3;							{ supports text mode grayishTextOr }
	gestaltSupportsMirroring	= 4;							{ Supports video mirroring via the Display Manager. }

	gestaltQuickTimeVersion		= 'qtim';						{ returns version of QuickTime }
	gestaltQuickTime			= 'qtim';

	gestaltQuickTimeFeatures	= 'qtrs';
	gestaltPPCQuickTimeLibPresent = 0;							{ PowerPC QuickTime glue library is present }

	gestaltPhysicalRAMSize		= 'ram ';

	gestaltRBVAddr				= 'rbv ';

	gestaltROMSize				= 'rom ';

	gestaltROMVersion			= 'romv';

	gestaltResourceMgrAttr		= 'rsrc';						{ Resource Mgr attributes }
	gestaltPartialRsrcs			= 0;							{ True if partial resources exist }

	gestaltRealtimeMgrAttr		= 'rtmr';						{ Realtime manager attributes			}
	gestaltRealtimeMgrPresent	= 0;							{ true if the Realtime manager is present 	}

	gestaltSCCReadAddr			= 'sccr';

	gestaltSCCWriteAddr			= 'sccw';

	gestaltScrapMgrAttr			= 'scra';						{ Scrap Manager attributes }
	gestaltScrapMgrTranslationAware = 0;						{ True if scrap manager is translation aware }

	gestaltScriptMgrVersion		= 'scri';

	gestaltScriptCount			= 'scr#';

	gestaltSCSI					= 'scsi';						{ SCSI Manager attributes }
	gestaltAsyncSCSI			= 0;							{ Supports Asynchronous SCSI }
	gestaltAsyncSCSIINROM		= 1;							{ Async scsi is in ROM (available for booting) }
	gestaltSCSISlotBoot			= 2;							{ ROM supports Slot-style PRAM for SCSI boots (PDM and later) }

	gestaltControlStripAttr		= 'sdev';						{ Control Strip attributes }
	gestaltControlStripExists	= 0;							{ Control Strip is installed }
	gestaltControlStripVersionFixed = 1;						{ Control Strip version Gestalt selector was fixed }
	gestaltControlStripUserFont	= 2;							{ supports user-selectable font/size }
	gestaltControlStripUserHotKey = 3;							{ support user-selectable hot key to show/hide the window }

	gestaltSerialAttr			= 'ser ';						{ Serial attributes }
	gestaltHasGPIaToDCDa		= 0;							{ GPIa connected to DCDa}
	gestaltHasGPIaToRTxCa		= 1;							{ GPIa connected to RTxCa clock input}
	gestaltHasGPIbToDCDb		= 2;							{ GPIb connected to DCDb }

	gestaltNuBusConnectors		= 'sltc';

	gestaltSlotAttr				= 'slot';						{ slot attributes  }
	gestaltSlotMgrExists		= 0;							{ true is slot mgr exists  }
	gestaltNuBusPresent			= 1;							{ NuBus slots are present  }
	gestaltSESlotPresent		= 2;							{ SE PDS slot present  }
	gestaltSE30SlotPresent		= 3;							{ SE/30 slot present  }
	gestaltPortableSlotPresent	= 4;							{ Portable’s slot present  }

	gestaltFirstSlotNumber		= 'slt1';

	gestaltSoundAttr			= 'snd ';						{ sound attributes }
	gestaltStereoCapability		= 0;							{ sound hardware has stereo capability }
	gestaltStereoMixing			= 1;							{ stereo mixing on external speaker }
	gestaltSoundIOMgrPresent	= 3;							{ The Sound I/O Manager is present }
	gestaltBuiltInSoundInput	= 4;							{ built-in Sound Input hardware is present }
	gestaltHasSoundInputDevice	= 5;							{ Sound Input device available }
	gestaltPlayAndRecord		= 6;							{ built-in hardware can play and record simultaneously }
	gestalt16BitSoundIO			= 7;							{ sound hardware can play and record 16-bit samples }
	gestaltStereoInput			= 8;							{ sound hardware can record stereo }
	gestaltLineLevelInput		= 9;							{ sound input port requires line level }
{ the following bits are not defined prior to Sound Mgr 3.0 }
	gestaltSndPlayDoubleBuffer	= 10;							{ SndPlayDoubleBuffer available, set by Sound Mgr 3.0 and later }
	gestaltMultiChannels		= 11;							{ multiple channel support, set by Sound Mgr 3.0 and later }
	gestalt16BitAudioSupport	= 12;							{ 16 bit audio data supported, set by Sound Mgr 3.0 and later }

	gestaltStandardFileAttr		= 'stdf';						{ Standard File attributes }
	gestaltStandardFile58		= 0;							{ True if selectors 5-8 (StandardPutFile-CustomGetFile) are supported }
	gestaltStandardFileTranslationAware = 1;					{ True if standard file is translation manager aware }
	gestaltStandardFileHasColorIcons = 2;						{ True if standard file has 16x16 color icons }
	gestaltStandardFileUseGenericIcons = 3;						{ Standard file LDEF to use only the system generic icons if true }
	gestaltStandardFileHasDynamicVolumeAllocation = 4;			{ True if standard file supports more than 20 volumes }

	gestaltSysArchitecture		= 'sysa';						{ Native System Architecture }
	gestalt68k					= 1;							{ Motorola MC68k architecture }
	gestaltPowerPC				= 2;							{ IBM PowerPC architecture }

	gestaltSystemVersion		= 'sysv';

	gestaltTSMgrVersion			= 'tsmv';						{ Text Services Mgr version, if present }
	gestaltTSMgr2				= $200;

	gestaltTSMgrAttr			= 'tsma';						{ Text Services Mgr attributes, if present }
	gestaltTSMDisplayMgrAwareBit = 0;							{ TSM knows about display manager }
	gestaltTSMdoesTSMTEBit		= 1;							{ TSM has integrated TSMTE }

	gestaltTSMTEVersion			= 'tmTV';
	gestaltTSMTE1				= $100;
	gestaltTSMTE2				= $200;

	gestaltTSMTEAttr			= 'tmTE';
	gestaltTSMTEPresent			= 0;
	gestaltTSMTE				= 0;							{ gestaltTSMTE is old name for gestaltTSMTEPresent }

	gestaltTextEditVersion		= 'te  ';						{ TextEdit version number }
	gestaltTE1					= 1;							{ TextEdit in MacIIci ROM }
	gestaltTE2					= 2;							{ TextEdit with 6.0.4 Script Systems on MacIIci (Script bug fixes for MacIIci) }
	gestaltTE3					= 3;							{ TextEdit with 6.0.4 Script Systems all but MacIIci }
	gestaltTE4					= 4;							{ TextEdit in System 7.0 }
	gestaltTE5					= 5;							{ TextWidthHook available in TextEdit }
	gestaltTE6					= 6;							{ TextEdit in System 8.0 }

	gestaltTEAttr				= 'teat';						{ TextEdit attributes }
	gestaltTEHasGetHiliteRgn	= 0;							{ TextEdit has TEGetHiliteRgn }
	gestaltTESupportsInlineInput = 1;							{ TextEdit does Inline Input }
	gestaltTESupportsTextObjects = 2;							{ TextEdit does Text Objects }

	gestaltTeleMgrAttr			= 'tele';						{ Telephone manager attributes }
	gestaltTeleMgrPresent		= 0;
	gestaltTeleMgrPowerPCSupport = 1;
	gestaltTeleMgrSoundStreams	= 2;
	gestaltTeleMgrAutoAnswer	= 3;
	gestaltTeleMgrIndHandset	= 4;
	gestaltTeleMgrSilenceDetect	= 5;
	gestaltTeleMgrNewTELNewSupport = 6;

	gestaltTermMgrAttr			= 'term';						{ terminal mgr attributes }
	gestaltTermMgrPresent		= 0;
	gestaltTermMgrErrorString	= 2;

	gestaltTimeMgrVersion		= 'tmgr';						{ time mgr version }
	gestaltStandardTimeMgr		= 1;							{ standard time mgr is present }
	gestaltRevisedTimeMgr		= 2;							{ revised time mgr is present }
	gestaltExtendedTimeMgr		= 3;							{ extended time mgr is present }

	gestaltSpeechAttr			= 'ttsc';						{ Speech Manager attributes }
	gestaltSpeechMgrPresent		= 0;							{ bit set indicates that Speech Manager exists }
	gestaltSpeechHasPPCGlue		= 1;							{ bit set indicates that native PPC glue for Speech Manager API exists }

	gestaltToolboxTable			= 'tbtt';

	gestaltThreadMgrAttr		= 'thds';						{ Thread Manager attributes }
	gestaltThreadMgrPresent		= 0;							{ bit true if Thread Mgr is present }
	gestaltSpecificMatchSupport	= 1;							{ bit true if Thread Mgr supports exact match creation option }
	gestaltThreadsLibraryPresent = 2;							{ bit true if Thread Mgr shared library is present }

	gestaltTVAttr				= 'tv  ';						{ TV version										<EX16>	 }
	gestaltHasTVTuner			= 0;							{ supports Philips FL1236F video tuner				<EX16>	 }
	gestaltHasSoundFader		= 1;							{ supports Philips TEA6330 Sound Fader chip			<EX16>	 }
	gestaltHasHWClosedCaptioning = 2;							{ supports Philips SAA5252 Closed Captioning		<EX16>	 }
	gestaltHasIRRemote			= 3;							{ supports CyclopsII Infra Red Remote control		<EX16>	 }
	gestaltHasVidDecoderScaler	= 4;							{ supports Philips SAA7194 Video Decoder/Scaler		<EX16>	 }
	gestaltHasStereoDecoder		= 5;							{ supports Sony SBX1637A-01 stereo decoder			<EX16>	 }

	gestaltVersion				= 'vers';						{ gestalt version }
	gestaltValueImplementedVers	= 5;							{ version of gestalt where gestaltValue is implemented. }

	gestaltVIA1Addr				= 'via1';

	gestaltVIA2Addr				= 'via2';

	gestaltVMAttr				= 'vm  ';						{ virtual memory attributes }
	gestaltVMPresent			= 0;							{ true if virtual memory is present }
	gestaltVMHasLockMemoryForOutput = 1;						{ true if LockMemoryForOutput is available }
	gestaltVMFilemappingOn		= 3;							{ true if filemapping is available }

	gestaltTranslationAttr		= 'xlat';						{ Translation Manager attributes }
	gestaltTranslationMgrExists	= 0;							{ True if translation manager exists }
	gestaltTranslationMgrHintOrder = 1;							{ True if hint order reversal in effect }
	gestaltTranslationPPCAvail	= 2;
	gestaltTranslationGetPathAPIAvail = 3;

	gestaltExtToolboxTable		= 'xttt';

TYPE
	SelectorFunctionProcPtr = ProcPtr;  { FUNCTION SelectorFunction(selector: OSType; VAR response: LONGINT): OSErr; }
	SelectorFunctionUPP = UniversalProcPtr;

CONST
	uppSelectorFunctionProcInfo = $000003E0; { FUNCTION (4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewSelectorFunctionProc(userRoutine: SelectorFunctionProcPtr): SelectorFunctionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallSelectorFunctionProc(selector: OSType; VAR response: LONGINT; userRoutine: SelectorFunctionUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
{$IFC SystemSevenOrLater }

FUNCTION Gestalt(selector: OSType; VAR response: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $225F, $201F, $A1AD, $2288, $3E80;
	{$ENDC}
FUNCTION ReplaceGestalt(selector: OSType; gestaltFunction: SelectorFunctionUPP; VAR oldGestaltFunction: SelectorFunctionUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $225F, $205F, $201F, $2F09, $A5AD, $225F, $2288, $3E80;
	{$ENDC}
FUNCTION NewGestalt(selector: OSType; gestaltFunction: SelectorFunctionUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $201F, $A3AD, $3E80;
	{$ENDC}
{$ELSEC}

FUNCTION Gestalt(selector: OSType; VAR response: LONGINT): OSErr;
FUNCTION NewGestalt(selector: OSType; gestaltFunction: SelectorFunctionUPP): OSErr;
FUNCTION ReplaceGestalt(selector: OSType; gestaltFunction: SelectorFunctionUPP; VAR oldGestaltFunction: SelectorFunctionUPP): OSErr;
{$ENDC}
{$IFC SystemSevenFiveOrLater }
{ These functions are built into System 7.5, but not on earlier systems }
FUNCTION NewGestaltValue(selector: OSType; newValue: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0401, $ABF1;
	{$ENDC}
FUNCTION ReplaceGestaltValue(selector: OSType; replacementValue: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0402, $ABF1;
	{$ENDC}
FUNCTION SetGestaltValue(selector: OSType; newValue: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0404, $ABF1;
	{$ENDC}
FUNCTION DeleteGestaltValue(selector: OSType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0203, $ABF1;
	{$ENDC}
{$ELSEC}
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GestaltEquIncludes}

{$ENDC} {__GESTALTEQU__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
