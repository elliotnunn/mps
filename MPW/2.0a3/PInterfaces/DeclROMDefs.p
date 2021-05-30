{
	File: DeclROMDefs.p

 Version: 2.0a2.1


 Copyright Apple Computer, Inc. 1986-1987 
 All Rights Reserved

}

UNIT DeclROMDefs;

INTERFACE

  CONST

{Format-Header}
    appleFormat		= 	$01;		{Format of Declaration Data (IEEE will assign real value)}
    romRevision		= 	$01;		{Revision of Declaration Data Format}
    testPattern		= 	$5A932BC7;	{FHeader long word test pattern}

{sExec constants}
    sCodeRev		=	2;			{Revision of code (For sExec)}
    sCPU68000		=	1;			{CPU type = 68000}
    sCPU68020		=	2;			{CPU type = 68020}

{sDRVR directory constants}
    sMacOS68000		=	1;			{Mac OS, CPU type = 68000}
    sMacOS68020		=	2;			{Mac OS, CPU type = 68020}


{sResource types}	
	board		 				=		$00000000;				{Board sResource - Required on all boards}
	displayVideoAppleTFB		=		$01010101;				{Video with Apple parameters for TFB card.}
	displayVideoAppleGM			=		$01010102;				{Video with Apple parameters for GM card.}
	networkEtherNetApple3Com	=		$02010101;				{Ethernet with apple parameters for 3-Comm card.}
	testSimpleAppleAny			=		$80010100;				{A simple test sResource.}

	
{Declaration ROM Id's}
  
  
{Misc}
	
	endOfList		= 	$FF;		{End of list}
    defaultTO       =   100;		{100 retries.}
 
{sResource List. Category: All}

	{The following Id's are common to all sResources.}
	sRsrcType		=		1;		{Type of sResource}
	sRsrcName		=		2;		{Name of sResource}
	sRsrcIcon		=		3;		{Icon}
	sRsrcDrvrDir	=		4;		{Driver directory}
	sRsrcLoadDir	=		5;		{Load directory}
	sRsrcBootRec	=		6;		{sBoot record}
	sRsrcFlags		=		7;		{sResource Flags}
	sRsrcHWDevId	=		8;		{Hardware Device Id}

	minorBaseOS		=		10;		{Offset to base of sResource in minor space.}
	minorLength		=		11;
	majorBaseOS		=		12;		{Offset to base of sResource in Major space.}
	majorLength		=		13;

	sDRVRDir		=		16;		{sDriver directory}

	drSwApple     	= 	1;
	drHwTFB       	= 	1;
	drHwGM        	= 	2;
	drHw3Com      	= 	1;
 
 {sResource List. Category: Board}

	{The following Id's are common to all Board sResources.}
	catBoard        =     	1;
	catTest         =     	2;
	catDisplay      =     	3;
	catNetwork      =     	4;
	boardId			=		32;		{Board Id}
	pRAMInitData	=		33;		{sPRAM init data}
	primaryInit		=		34;		{Primary init record}
	timeOutConst	=		35;		{Time out constant}
	vendorInfo		=		36;		{Vendor information List. See Vendor List, below}
	boardFlags		=		37;		{Board Flags}


{Vendor List}		
	
	{The following Id's are associated with the VendorInfo id}
	vendorId		= 	1;			{Vendor Id}
	serialNum		=	2;			{Serial number}
	revLevel		= 	3;			{Revision level}
	partNum			= 	4;			{Part numbe}


{sResource List. Category_Type: Test_One}

	{The following Id's are common to all Test_One_x sResources.}
	typeBoard      	=	0;
	typeApple      	=	1;
	typeVideo      	=	1;
 	typeEtherNet   	=	1;
 	testByte		=	32;			{Test byte.}
	testWord		=	33;			{Test Word.}
	testLong		=	34;			{Test Long.}
	testString		=	35;			{Test String.}


  

END.
