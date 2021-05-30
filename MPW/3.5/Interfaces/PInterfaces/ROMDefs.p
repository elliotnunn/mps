{
     File:       ROMDefs.p
 
     Contains:   NuBus card ROM Definitions.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1986-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ROMDefs;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ROMDEFS__}
{$SETC __ROMDEFS__ := 1}

{$I+}
{$SETC ROMDefsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	appleFormat					= 1;							{ Format of Declaration Data (IEEE will assign real value) }
	romRevision					= 1;							{ Revision of Declaration Data Format }
	romRevRange					= 9;							{ Revision of Declaration Data Format [1..9] }
	testPattern					= 1519594439;					{ FHeader long word test pattern }
	sCodeRev					= 2;							{ Revision of code (For sExec) }
	sExec2						= 2;
	sCPU68000					= 1;							{ CPU type = 68000 }
	sCPU68020					= 2;							{ CPU type = 68020 }
	sCPU68030					= 3;							{ CPU type = 68030 }
	sCPU68040					= 4;							{ CPU type = 68040 }
	sMacOS68000					= 1;							{ Mac OS, CPU type = 68000 }
	sMacOS68020					= 2;							{ Mac OS, CPU type = 68020 }
	sMacOS68030					= 3;							{ Mac OS, CPU type = 68030 }
	sMacOS68040					= 4;							{ Mac OS, CPU type = 68040 }
	board						= 0;							{ Board sResource - Required on all boards }
	displayVideoAppleTFB		= 16843009;						{ Video with Apple parameters for TFB card. }
	displayVideoAppleGM			= 16843010;						{ Video with Apple parameters for GM card. }
	networkEtherNetApple3Com	= 33620225;						{ Ethernet with apple parameters for 3-Comm card. }
	testSimpleAppleAny			= -2147417856;					{ A simple test sResource. }
	endOfList					= 255;							{ End of list }
	defaultTO					= 100;							{ 100 retries. }


																{  sResource flags for sRsrc_Flags  }
	fOpenAtStart				= 1;							{  set => open the driver at start time, else do not  }
	f32BitMode					= 2;							{  set => a 32-bit address will be put into dctlDevBase (IM Devices 2-54)  }

	sRsrcType					= 1;							{ Type of sResource }
	sRsrcName					= 2;							{ Name of sResource }
	sRsrcIcon					= 3;							{ Icon }
	sRsrcDrvrDir				= 4;							{ Driver directory }
	sRsrcLoadDir				= 5;							{ Load directory }
	sRsrcBootRec				= 6;							{ sBoot record }
	sRsrcFlags					= 7;							{ sResource Flags }
	sRsrcHWDevId				= 8;							{ Hardware Device Id }
	minorBaseOS					= 10;							{ Offset to base of sResource in minor space. }
	minorLength					= 11;							{ Length of sResource’s address space in standard slot space. }
	majorBaseOS					= 12;							{ Offset to base of sResource in Major space. }
	majorLength					= 13;							{ Length of sResource in super slot space. }
	sRsrcTest					= 14;							{ sBlock diagnostic code }
	sRsrccicn					= 15;							{ Color icon }
	sRsrcicl8					= 16;							{ 8-bit (indexed) icon }
	sRsrcicl4					= 17;							{ 4-bit (indexed) icon }
	sDRVRDir					= 16;							{ sDriver directory }
	sGammaDir					= 64;							{ sGamma directory }
	sRsrcVidNames				= 65;							{ Video mode name directory }
	sRsrcDock					= 80;							{ spID for Docking Handlers }
	sDiagRec					= 85;							{ spID for board diagnostics }
	sVidAuxParams				= 123;							{ more video info for Display Manager -- timing information }
	sDebugger					= 124;							{ DatLstEntry for debuggers indicating video anamolies }
	sVidAttributes				= 125;							{ video attributes data field (optional,word) }
	fLCDScreen					= 0;							{  bit 0 - when set is LCD, else is CRT }
	fBuiltInDisplay				= 1;							{       1 - when set is built-in (in the box) display, else not }
	fDefaultColor				= 2;							{       2 - when set display prefers multi-bit color, else gray }
	fActiveBlack				= 3;							{       3 - when set black on display must be written, else display is naturally black }
	fDimMinAt1					= 4;							{       4 - when set should dim backlight to level 1 instead of 0 }
	fBuiltInDetach				= 4;							{       4 - when set is built-in (in the box), but detaches }
	sVidParmDir					= 126;
	sBkltParmDir				= 140;							{ directory of backlight tables }
	stdBkltTblSize				= 36;							{ size of “standard” 0..31-entry backlight table }
	sSuperDir					= 254;

	{	 =======================================================================  	}
	{	 sResource types                                                          	}
	{	 =======================================================================  	}
	catBoard					= $0001;						{ Category for board types. }
	catTest						= $0002;						{ Category for test types -- not used much. }
	catDisplay					= $0003;						{ Category for display (video) cards. }
	catNetwork					= $0004;						{ Category for Networking cards. }
	catScanner					= $0008;						{ scanners bring in data somehow }
	catCPU						= $000A;
	catIntBus					= $000C;
	catProto					= $0011;
	catDock						= $0020;						{ <Type> }
	typeBoard					= $0000;
	typeApple					= $0001;
	typeVideo					= $0001;
	typeEtherNet				= $0001;
	typeStation					= $0001;
	typeDesk					= $0002;
	typeTravel					= $0003;
	typeDSP						= $0004;
	typeXPT						= $000B;
	typeSIM						= $000C;
	typeDebugger				= $0100;
	type68000					= $0002;
	type68020					= $0003;
	type68030					= $0004;
	type68040					= $0005;
	type601						= $0025;
	type603						= $002E;
	typeAppleII					= $0015;						{ Driver Interface : <id.SW> }
	drSwMacCPU					= 0;
	drSwAppleIIe				= $0001;
	drSwApple					= 1;							{ To ask for or define an Apple-compatible SW device. }
	drSwMacsBug					= $0104;
	drSwDepewEngineering		= $0101;						{ Driver Interface : <id.SW><id.HW> }
	drHwTFB						= 1;							{ HW ID for the TFB (original Mac II) video card. }
	drHw3Com					= 1;							{ HW ID for the Apple EtherTalk card. }
	drHwBSC						= 3;
	drHwGemini					= 1;
	drHwDeskBar					= 1;
	drHwHooperDock				= 2;							{ Hooper’s CatDock,TypeDesk,DrSwApple ID; registered with DTS. }
	drHwATT3210					= $0001;
	drHwBootBug					= $0100;
	drHwMicroDock				= $0100;						{  video hardware id's  - <catDisplay><typVideo> }
	drHwSTB3					= $0002;						{  Assigned by Kevin Mellander for STB-3 hardware.  }
	drHwSTB						= $0002;						{  (Both STB-3 and STB-4 share the same video hardware.)  }
	drHwRBV						= $0018;						{  IIci Aurora25/16 hw ID  }
	drHwJMFB					= $0019;						{  4•8/8•24 NuBus card  }
	drHwElsie					= $001A;
	drHwTim						= $001B;
	drHwDAFB					= $001C;
	drHwDolphin					= $001D;						{  8•24GC NuBus card  }
	drHwGSC						= $001E;						{  (Renamed from GSC drHWDBLite)  }
	drHwDAFBPDS					= $001F;
	drHWVSC						= $0020;
	drHwApollo					= $0021;
	drHwSonora					= $0022;
	drHwReserved2				= $0023;
	drHwColumbia				= $0024;
	drHwCivic					= $0025;
	drHwBrazil					= $0026;
	drHWPBLCD					= $0027;
	drHWCSC						= $0028;
	drHwJET						= $0029;
	drHWMEMCjr					= $002A;
	drHwBoogie					= $002B;						{  8•24AC nuBus video card (built by Radius)  }
	drHwHPV						= $002C;						{  High performance Video (HPV) PDS card for original PowerMacs  }
	drHwPlanaria				= $002D;						{ PowerMac 6100/7100/8100 PDS AV video }
	drHwValkyrie				= $002E;
	drHwKeystone				= $002F;
	drHWATI						= $0055;
	drHwGammaFormula			= $0056;						{  Use for gType of display mgr gamma tables  }
																{  other drHW id's for built-in functions }
	drHwSonic					= $0110;
	drHwMace					= $0114;
	drHwDblExp					= $0001;						{  CPU board IDs - <catBoard> <typBoard> <0000> <0000> }
	MIIBoardId					= $0010;						{ Mac II Board ID }
	ciVidBoardID				= $001F;						{ Aurora25 board ID }
	CX16VidBoardID				= $0020;						{ Aurora16 board ID }
	MIIxBoardId					= $0021;						{ Mac IIx Board ID }
	SE30BoardID					= $0022;						{ Mac SE/30 Board ID }
	MIIcxBoardId				= $0023;						{ Mac IIcx Board ID }
	MIIfxBoardId				= $0024;						{ F19 board ID }
	EricksonBoardID				= $0028;
	ElsieBoardID				= $0029;
	TIMBoardID					= $002A;
	EclipseBoardID				= $002B;
	SpikeBoardID				= $0033;
	DBLiteBoardID				= $0035;
	ZydecoBrdID					= $0036;
	ApolloBoardID				= $0038;
	PDMBrdID					= $0039;
	VailBoardID					= $003A;
	WombatBrdID					= $003B;
	ColumbiaBrdID				= $003C;
	CycloneBrdID				= $003D;
	CompanionBrdID				= $003E;
	DartanianBoardID			= $0040;
	DartExtVidBoardID			= $0046;
	HookBoardID					= $0047;						{ Hook internal video board ID }
	EscherBoardID				= $004A;						{ Board ID for Escher (CSC) }
	POBoardID					= $004D;						{ Board ID for Primus/Optimus/Aladdin }
	TempestBrdID				= $0050;						{ Non-official Board ID for Tempest }
	BlackBirdBdID				= $0058;						{ Board ID for BlackBird }
	BBExtVidBdID				= $0059;						{ Board ID for BlackBird built-in external video }
	YeagerBoardID				= $005A;						{ Board ID for Yeager }
	BBEtherNetBdID				= $005E;						{ Board ID for BlackBird Ethernet board }
	TELLBoardID					= $0065;						{ Board ID for TELL (Valkyrie) }
	MalcolmBoardID				= $065E;						{ Board ID for Malcolm }
	AJBoardID					= $065F;						{ Board ID for AJ }
	M2BoardID					= $0660;						{ Board ID for M2 }
	OmegaBoardID				= $0661;						{ Board ID for Omega }
	TNTBoardID					= $0670;						{ Board ID for TNT/Alchemy/Hipclipper CPUs (did Nano just make this up?) }
	HooperBoardID				= $06CD;						{ Board ID for Hooper }
																{  other board IDs }
	BoardIDDblExp				= $002F;
	DAFBPDSBoardID				= $0037;
	MonetBoardID				= $0048;
	SacSONIC16BoardID			= $004E;
	SacSONIC32BoardID			= $004F;						{  CPU board types - <CatCPU> <Typ680x0> <DrSwMacCPU> }
	drHWMacII					= $0001;						{ Mac II hw ID }
	drHwMacIIx					= $0002;						{ Mac IIx hw ID }
	drHWSE30					= $0003;						{ Mac SE/30 hw ID }
	drHwMacIIcx					= $0004;						{ Mac IIcx hw ID }
	drHWMacIIfx					= $0005;						{ Mac IIfx hw ID }
	drHWF19						= $0005;						{ F19 hw ID }
	sBlockTransferInfo			= 20;							{ general slot block xfer info }
	sMaxLockedTransferCount		= 21;							{ slot max. locked xfer count }
	boardId						= 32;							{ Board Id }
	pRAMInitData				= 33;							{ sPRAM init data }
	primaryInit					= 34;							{ Primary init record }
	timeOutConst				= 35;							{ Time out constant }
	vendorInfo					= 36;							{ Vendor information List. See Vendor List, below }
	boardFlags					= 37;							{ Board Flags }
	secondaryInit				= 38;							{ Secondary init record/code }
																{  The following Id's are associated with all CPU sResources. }
	MajRAMSp					= 129;							{ ID of Major RAM space. }
	MinROMSp					= 130;							{ ID of Minor ROM space. }
	vendorId					= 1;							{ Vendor Id }
	serialNum					= 2;							{ Serial number }
	revLevel					= 3;							{ Revision level }
	partNum						= 4;							{ Part number }
	date						= 5;							{ Last revision date of the card }

	testByte					= 32;							{ Test byte. }
	testWord					= 33;							{ 0021 }
	testLong					= 34;							{ Test Long. }
	testString					= 35;							{ Test String. }

	{	 sResource List. Category: Display        Type: Video 	}
	{	 The following Id's are common to all Mode sResources in Display_Video 	}
	{	 functional sResources. 	}
	mBlockTransferInfo			= 5;							{  slot block xfer info PER MODE  }
	mMaxLockedTransferCount		= 6;							{  slot max. locked xfer count PER MODE  }




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ROMDefsIncludes}

{$ENDC} {__ROMDEFS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
