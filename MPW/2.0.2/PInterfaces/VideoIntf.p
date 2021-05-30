{
  File: VideoIntf.p

 Copyright Apple Computer, Inc. 1986-1987
 All Rights Reserved
}

UNIT VideoIntf;

INTERFACE

CONST

{Video sResource parameter Id's}

mBaseOffset 		=	1;		{Id of mBaseOffset.}
mRowBytes			=	2;
mBounds 			=	3;
mVersion			=	4;
mHRes				=	5;
mVRes				=	6;
mPixelType			=	7;
mPixelSize			=	8;
mCmpCount			=	9;
mCmpSize			=	10;
mPlaneBytes 		=	11;
{* mTable			=	12; *}
{* mPageCnt 		=	13; *}
mVertRefRate		=	14;

mVidParams		=	1;			{ Video parameter block id. }
mTable			=	2;			{ Offset to the table. }
mPageCnt		=	3;			{ Number of pages }
mDevType		=	4;			{ Device Type }


{Video sResource List Id's}

oneBitMode		=	128;		{ Id of OneBitMode Parameter list. }
twoBitMode		=	129;		{ Id of TwoBitMode Parameter list. }
fourBitMode 	=	130;		{ Id of FourBitMode Parameter list. }	
eightBitMode	=	131;		{ Id of EightBitMode Parameter list. }

{Control Codes}

cscReset		= 0;
cscSetMode		= 2;
cscSetEntries	= 3;
cscGrayPage 	= 5;
cscSetGray		= 6;

{Status Codes}

cscGetMode		= 2;
cscGetEntries	= 3;
cscGetPageCnt	= 4;
cscGetPageBase	= 5;


TYPE

{ mVidParams block }

VPBlockPtr = ^VPBlock;

VPBlock 		= RECORD		{ Video Parameters block. }
vpBaseOffset	: LONGINT;		{ Offset to page zero of video RAM (From minorBaseOS). }
vpRowBytes		: INTEGER;		{ Width of each row of video memory. }
vpBounds		: Rect; 		{ BoundsRect for the video display (gives dimensions). }
vpVersion		: INTEGER;		{ PixelMap version number. }
vpPackType		: INTEGER;					
vpPackSize		: LONGINT;					
vpHRes			: LONGINT;		{ Horizontal resolution of the device (pixels per inch). }
vpVRes			: LONGINT;		{ Vertical resolution of the device (pixels per inch). }
vpPixelType 	: INTEGER;		{ Defines the pixel type. }
vpPixelSize 	: INTEGER;		{ Number of bits in pixel. }
vpCmpCount		: INTEGER;		{ Number of components in pixel. }
vpCmpSize		: INTEGER;		{ Number of bits per component }
vpPlaneBytes	: LONGINT;		{ Offset from one plane to the next. }
			 END;
					
VDEntRecPtr = ^VDEntryRecord;

VDEntryRecord	= RECORD		
					csTable: Ptr;		{ (long) pointer to color table }
										{ entry = value, r, g, b : INTEGER	}
				END;
		
VDGrayPtr = ^VDGrayRecord;

VDGrayRecord	= RECORD				{ Parm block for SetGray control call }
					csMode: BOOLEAN;	{ Same as GDDevType value (0=mono; 1=color) }
	  			  END;

VDSetEntryPtr = ^VDSetEntryRecord;

VDSetEntryRecord = RECORD				{ Parm block for SetEntries control call }
					csTable: ^ColorSpec; { Pointer to an array of color specs }
					csStart: INTEGER;	{ Which spec in array to start with, or -1 }
					csCount: INTEGER;	{ Number of color spec entries to set }
	  			  END;

VDPgInfoPtr = ^VDPageInfo;

VDPageInfo	= RECORD		
				csMode: INTEGER;		{ (word) mode within device 	}
				csData: LONGINT;		{ (long) data supplied by driver	}
				csPage: INTEGER;		{ (word) page to switch in			}
				csBaseAddr: Ptr;		{ (long) base address of page		}
			END;
		
VDSzInfoPtr = ^VDSizeInfo;

VDSizeInfo	= RECORD		
				csHSize: INTEGER;		{ (word) desired/returned h size	}
				csHPos: INTEGER;		{ (word) desired/returned h position		}
				csVSize: INTEGER;		{ (word) desired/returned v size	}
				csVPos: INTEGER;		{ (word) desired/returned v position		}
			END;
		
VDSettingsPtr = ^VDSettings;

VDSettings	= RECORD		
				csParamCnt: 	INTEGER;	{ (word) number of params}
				csBrightMax:	INTEGER;	{ (word) max brightness}
				csBrightDef:	INTEGER;	{ (word) default brightness}
				csBrightVal:	INTEGER;	{ (word) current brightness}
				csCntrstMax:	INTEGER;	{ (word) max contrast}
				csCntrstDef:	INTEGER;	{ (word) default contrast}
				csCntrstVal:	INTEGER;	{ (word) current contrast}
				csTintMax:		INTEGER;	{ (word) max tint}
				csTintDef:		INTEGER;	{ (word) default tint}
				csTintVal:		INTEGER;	{ (word) current tint}
				csHueMax:		INTEGER;	{ (word) max hue}
				csHueDef:		INTEGER;	{ (word) default hue}
				csHueVal:		INTEGER;	{ (word) current hue}
				csHorizDef: 	INTEGER;	{ (word) default horizontal}
				csHorizVal: 	INTEGER;	{ (word) current horizontal}
				csHorizMax: 	INTEGER;	{ (word) max horizontal}
				csVertDef:		INTEGER;	{ (word) default vertical}
				csVertVal:		INTEGER;	{ (word) current vertical}
				csVertMax:		INTEGER;	{ (word) max vertical}
			END;

END.

