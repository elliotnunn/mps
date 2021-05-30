/*
		Types.r -- Type Declarations for Rez and DeRez
		
		Copyright Apple Computer, Inc. 1986, 1987
		All rights reserved.

		June 8, 1987
*/



/*-------------------------------------Equates------------------------------------------*/
/*		The following are used to set styles, simply add for desired style.
*/
#define	bold			1
#define italic			2
#define underline		4
#define outline 		8
#define shadow			16
#define condense		32
#define extend			64

/*----------------------------actb • Alert Color Lookup Table----------------------------*/
type 'actb' {
		unsigned hex longint;									/* ctSeed				*/
		integer;												/* transIndex			*/
		integer = $$Countof(ColorSpec) - 1;						/* ctSize				*/
		wide array ColorSpec {
				integer		wContentColor,						/* value				*/
							wFrameColor,
							wTextColor,
							wHiliteColor,
							wTitleBarColor;
				unsigned integer;								/* RGB:	red				*/
				unsigned integer;								/*		green			*/
				unsigned integer;								/*		blue			*/
		};
};
/*----------------------------ALRT • Alert Template-------------------------------------*/
type 'ALRT' {
		rect;													/* boundsRect			*/
		integer;												/* 'DITL' ID			*/
	
		/* NOTE: the stages are ordered 4, 3, 2, 1 */
		wide array [4] {
				boolean 				OK, Cancel; 			/* Bold Outline 		*/
				boolean 				invisible, visible; 	/* Draw Alert			*/
				unsigned bitstring[2]	silent = 0
								sound1, sound2, sound3; 		/* Beeps				*/
		};
};
/*----------------------------BNDL • Bundle---------------------------------------------*/
type 'BNDL' {
		literal longint;										/* Signature			*/
		integer;												/* Version ID			*/
		integer = $$CountOf(TypeArray) - 1;
		array TypeArray {
				literal longint;								/* Type 				*/
				integer = $$CountOf(IDArray) - 1;
				wide array IDArray {
						integer;								/* Local ID 			*/
						integer;								/* Actual ID			*/
				};
		};
};
/*----------------------------cctb • Control Color Lookup Table-------------------------*/
type 'cctb' {
		unsigned hex longint;									/* CCSeed				*/
		integer;												/* ccReserved			*/
		integer = $$Countof(ColorSpec) - 1;						/* ctSize				*/
		wide array ColorSpec {
				integer		cFrameColor,						/* partcode				*/
							cBodyColor,
							cTextColor,
							cElevatorColor;
				unsigned integer;								/* RGB:	red				*/
				unsigned integer;								/*		green			*/
				unsigned integer;								/*		blue			*/
		};
};
/*----------------------------cicn • Color Icon-----------------------------------------*/
type 'cicn' {
		/* IconPMap (pixMap) record */
		fill long;												/* Base address			*/
		unsigned bitstring[1] = 1;								/* New pixMap flag		*/
		unsigned bitstring[2] = 0;								/* Must be 0			*/
		unsigned bitstring[13];									/* Offset to next row	*/
		rect;													/* Bitmap bounds		*/
		integer;												/* pixMap vers number	*/
		integer	unpacked;										/* Packing format		*/
		unsigned longint;										/* Size of pixel data	*/
		unsigned hex longint;									/* h. resolution (ppi) (fixed) */
		unsigned hex longint;									/* v. resolution (ppi) (fixed) */
		integer			chunky, chunkyPlanar, planar;			/* Pixel storage format	*/
		integer;												/* # bits in pixel		*/
		integer;												/* # components in pixel*/
		integer;												/* # bits per field		*/
		unsigned longint;										/* Offset to next plane	*/
		unsigned longint;										/* Offset to color table*/
		fill long;												/* Reserved				*/
		
		/* IconMask (bitMap) record */
		fill long;												/* Base address			*/
		integer;												/* Row bytes			*/
		rect;													/* Bitmap bounds		*/
		
		/* IconBMap (bitMap) record */
		fill long;												/* Base address			*/
		integer;												/* Row bytes			*/
		rect;													/* Bitmap bounds		*/
		
		fill long;												/* Handle placeholder	*/
		
		hex string;												/* mask data, BMapData,
																   PMapCTab, PMapData	*/
};
/*----------------------------clut • Generic Color Lookup Table-------------------------*/
type 'clut' {
		unsigned hex longint;									/* ctSeed				*/
		integer;												/* transIndex			*/
		integer = $$Countof(ColorSpec) - 1;						/* ctSize				*/
		wide array ColorSpec {
				integer;										/* value				*/
				unsigned integer;								/* RGB:	red				*/
				unsigned integer;								/*		green			*/
				unsigned integer;								/*		blue			*/
		};
};
/*----------------------------CNTL • Control Template-----------------------------------*/
type 'CNTL' {
		rect;													/* Bounds				*/
		integer;												/* Value				*/
		byte			invisible, visible; 					/* visible				*/
		fill byte;
		integer;												/* Max					*/
		integer;												/* Min					*/
		integer 		pushButProc,							/* ProcID				*/
						checkBoxProc,
						radioButProc,
						pushButProcUseWFont = 8,
						checkBoxProcUseWFont,
						radioButProcUseWFont,
						scrollBarProc = 16;
		longint;												/* RefCon				*/
		pstring;												/* Title				*/
};
/*----------------------------crsr • Color Cursor---------------------------------------*/
type 'crsr' {
		/* CCrsr record */
		hex unsigned integer	oldCursor   = $8000,			/* Type of cursor		*/
								colorCursor = $8001;
		unsigned longint = 96;									/* Offset to pixMap		*/
		unsigned longint = 146;									/* Offset to pixel data	*/
		fill long;												/* Expanded cursor data	*/
		fill word;												/* Expanded data depth	*/
		fill long;												/* Reserved				*/
		hex string [32];										/* One bit cursor data	*/
		hex string [32];										/* One bit cursor mask	*/
		point;													/* Hot spot 			*/
		fill long;												/* Table id				*/
		fill long;												/* id for cursor		*/
	
		/* IconPMap (pixMap) record */
		fill long;												/* Base address			*/
		unsigned bitstring[1] = 1;								/* New pixMap flag		*/
		unsigned bitstring[2] = 0;								/* Must be 0			*/
		unsigned bitstring[13];									/* Offset to next row	*/
		rect;													/* Bitmap bounds		*/
		integer;												/* pixMap version number*/
		integer	unpacked;										/* Packing format		*/
		unsigned longint;										/* Size of pixel data	*/
		unsigned hex longint;									/* h. resolution (ppi) (fixed) */
		unsigned hex longint;									/* v. resolution (ppi) (fixed) */
		integer			chunky, chunkyPlanar, planar;			/* Pixel storage format	*/
		integer;												/* # bits in pixel		*/
		integer;												/* # components in pixel*/
		integer;												/* # bits per field		*/
		unsigned longint;										/* Offset to next plane	*/
		unsigned longint;										/* Offset to color table*/
		fill long;												/* Reserved				*/
	
		hex string;												/* Pixel data, color table */
};
/*----------------------------CURS • Cursor---------------------------------------------*/
type 'CURS' {
		hex string [32];										/* Data 				*/
		hex string [32];										/* Mask 				*/
		point;													/* Hot spot 			*/
};
/*----------------------------dctb • Dialog Color Lookup Table--------------------------*/
type 'dctb' as 'actb';
/*----------------------------DITL • Dialog Item List-----------------------------------*/
type 'DITL' {
		integer = $$CountOf(DITLarray) - 1; 					/* Array size			*/
		wide array DITLarray {
				fill long;
				rect;											/* Item bounds			*/
				switch {
				case Button:
						boolean 		enabled,disabled;		/* Enable flag			*/
						key bitstring[7] = 4;
						pstring;								/* Title				*/

				case CheckBox:
						boolean 		enabled,disabled;		/* Enable flag			*/
						key bitstring[7] = 5;
						pstring;								/* Title				*/

				case RadioButton:
						boolean 		enabled,disabled;		/* Enable flag			*/
						key bitstring[7] = 6;
						pstring;								/* Title				*/

				case Control:
						boolean 		enabled,disabled;		/* Enable flag			*/
						key bitstring[7] = 7;
						byte = 2;
						integer;								/* 'CTRL' ID			*/

				case StaticText:
						boolean 		enabled,disabled;		/* Enable flag			*/
						key bitstring[7] = 8;
						pstring;								/* Text 				*/

				case EditText:
						boolean 		enabled,disabled;		/* Enable flag			*/
						key bitstring[7] = 16;
						pstring;								/* Text 				*/

				case Icon:
						boolean 		enabled,disabled;		/* Enable flag			*/
						key bitstring[7] = 32;
						byte = 2;
						integer;								/* 'ICON' ID			*/

				case Picture:
						boolean 		enabled,disabled;		/* Enable flag			*/
						key bitstring[7] = 64;
						byte = 2;
						integer;								/* 'PICT' ID			*/

				case UserItem:
						boolean 		enabled,disabled;		/* Enable flag			*/
						key bitstring[7] = 0;
						byte = 0;
				};
				align word;
		};
};
/*----------------------------DLOG • Dialog Template------------------------------------*/
type 'DLOG' {
		rect;													/* boundsRect			*/
		integer 		documentProc,							/* procID				*/
						dBoxProc,
						plainDBox,
						altDBoxProc,
						noGrowDocProc,
						zoomDocProc = 8,
						zoomNoGrow = 12,
						rDocProc = 16;
		byte			invisible, visible; 					/* visible				*/
		fill byte;
		byte			noGoAway, goAway;						/* goAway				*/
		fill byte;
		unsigned hex longint;									/* refCon				*/
		integer;												/* 'DITL' ID			*/
		pstring;												/* title				*/
};
/*----------------------------fctb • Font Color Lookup Table----------------------------*/
type 'fctb' as 'clut';
/*----------------------------FREF • File Reference-------------------------------------*/
type 'FREF' {
		literal longint;										/* File Type			*/
		integer;												/* Icon ID				*/
		pstring;												/* Filename 			*/
};
/*----------------------------ICON • Icon-----------------------------------------------*/
type 'ICON' {
		hex string[128];										/* Icon data			*/
};
/*----------------------------ICN# • Icon List------------------------------------------*/
type 'ICN#' {
		array {
				hex string[128];								/* Icon data			*/
		};
};
/*----------------------------MENU • Menu-----------------------------------------------*/
type 'MENU' {
		integer;												/* Menu ID				*/
		fill word[2];
		integer 		textMenuProc = 0;						/* ID of menu def proc	*/
		fill word;
		unsigned hex bitstring[31]
						allEnabled = 0x7FFFFFFF;				/* Enable flags 		*/
		boolean 		disabled, enabled;						/* Menu enable			*/
		pstring 		apple = "\0x14";						/* Menu Title			*/
		wide array {
				pstring;										/* Item title			*/
				byte			noIcon; 						/* Icon number			*/
				char			noKey = "\0x00",				/* Key equivalent or	*/
								hierarchicalMenu = "\0x1B";		/* hierarchical menu	*/
				char			noMark = "\0x00",				/* Marking char or id	*/
								check = "\0x12";				/* of hierarchical menu	*/
				fill bit;
				unsigned bitstring[7]
								plain;							/* Style				*/
		};
		byte = 0;
};
/*----------------------------MBAR • Menu Bar-------------------------------------------*/
type 'MBAR' {
		integer = $$CountOf(MenuArray); 						/* Number of menus		*/
		wide array MenuArray{
				integer;										/* Menu resource ID 	*/
		};
};
/*----------------------------mctb • Menu Color Lookup Table----------------------------*/
type 'mctb' {
		integer = $$CountOf(MCTBArray); 						/* Color table count	*/
		wide array MCTBArray {
			integer				mctbLast = -99;					/* Menu resource ID 	*/
			integer;											/* Menu Item 			*/
			wide array [4] {
					unsigned integer;							/* RGB: red				*/
					unsigned integer;							/*		green			*/
					unsigned integer;							/*		blue			*/
			};
			fill word;											/* Reserved word		*/
		};
};
/*----------------------------PAT  • Quickdraw Pattern----------------------------------*/
type 'PAT ' {
		hex string[8];											/* Pattern				*/
};
/*----------------------------PAT# • Quickdraw Pattern List-----------------------------*/
type 'PAT#' {
		integer = $$Countof(PatArray);
		array PatArray {
				hex string[8];									/* Pattern				*/
		};
};
/*----------------------------PICT • Quickdraw Picture----------------------------------*/
type 'PICT' {
		integer;												/* Length				*/
		rect;													/* Frame				*/
		hex string; 											/* Data 				*/
};
/*----------------------------pltt • Color Palette--------------------------------------*/
type 'pltt' {
		integer = $$CountOf(ColorInfo); 						/* Color table count	*/		
		fill long;												/* Reserved				*/
		fill word;												/* Reserved				*/
		fill long;												/* Reserved				*/
		fill long;												/* Reserved				*/
		wide array ColorInfo {
			unsigned integer;									/* RGB: red				*/
			unsigned integer;									/*		green			*/
			unsigned integer;									/* 		blue			*/
			integer		pmCourteous, pmDithered, pmTolerant,	/* Color usage			*/
						pmAnimated = 4, pmExplicit = 8;
			integer;											/* Tolerance value		*/
			fill word;											/* Private flags		*/
			fill long;											/* Private				*/
		};
};
/*----------------------------ppat • Pixel Pattern--------------------------------------*/
type 'ppat' {
		/* PixPat record */
		integer		oldPattern,									/* Pattern type			*/
					newPattern,
					ditherPattern;
		unsigned longint = 28;									/* Offset to pixmap		*/
		unsigned longint = 78;									/* Offset to data		*/
		fill long;												/* Expanded pixel image	*/
		fill word;												/* Pattern valid flag	*/
		fill long;												/* expanded pattern		*/
		hex string [8];											/* old-style pattern	*/
	
		/* PixMap record */
		fill long;												/* Base address			*/
		unsigned bitstring[1] = 1;								/* New pixMap flag		*/
		unsigned bitstring[2] = 0;								/* Must be 0			*/
		unsigned bitstring[13];									/* Offset to next row	*/
		rect;													/* Bitmap bounds		*/
		integer;												/* pixMap vers number	*/
		integer	unpacked;										/* Packing format		*/
		unsigned longint;										/* size of pixel data	*/
		unsigned hex longint;									/* h. resolution (ppi) (fixed) */
		unsigned hex longint;									/* v. resolution (ppi) (fixed) */
		integer			chunky, chunkyPlanar, planar;			/* Pixel storage format	*/
		integer;												/* # bits in pixel		*/
		integer;												/* # components in pixel*/
		integer;												/* # bits per field		*/
		unsigned longint;										/* Offset to next plane	*/
		unsigned longint;										/* Offset to color table*/
		fill long;												/* Reserved				*/
	
		hex string;												/* Cursor data, color table */
};
/*----------------------------SICN • Small Icon-----------------------------------------*/
type 'SICN' {
		array {
				hex string[32]; 								/* SICN data			*/
		};
};
/*----------------------------SIZE • Switcher Size Information--------------------------*/
type 'SIZE' {
		boolean 				dontSaveScreen, 				/* Save screen			*/
								saveScreen;
		boolean 				ignoreSuspendResumeEvents,		/* suspend-resume		*/
								acceptSuspendResumeEvents;
		unsigned bitstring[2] = 0; 								/* reserved 			*/
		boolean					dontDoOwnActivate,				/* activate/deactivate	*/
								doOwnActivate;					/* on resume/suspend	*/
		unsigned bitstring[11] = 0; 							/* reserved 			*/
		unsigned longint;										/* size - 32k			*/
		unsigned longint;										/* min size - 32k		*/
};
/*----------------------------STR  • Pascal-Style String--------------------------------*/
type 'STR ' {
		pstring;												/* String				*/
};
/*----------------------------STR# • Pascal-Style String List---------------------------*/
type 'STR#' {
		integer = $$Countof(StringArray);
		array StringArray {
				pstring;										/* String				*/
		};
};
/*----------------------------wctb • Window Color Lookup Table--------------------------*/
type 'wctb' as 'actb';
/*----------------------------WIND • Window Template------------------------------------*/
type 'WIND' {
		rect;													/* boundsRect			*/
		integer 		documentProc,							/* procID				*/
						dBoxProc,
						plainDBox,
						altDBoxProc,
						noGrowDocProc,
						zoomDocProc = 8,
						zoomNoGrow = 12,
						rDocProc = 16;
		byte			invisible, visible; 					/* visible				*/
		fill byte;
		byte			noGoAway, goAway;						/* goAway				*/
		fill byte;
		unsigned hex longint;									/* refCon				*/
		pstring 		Untitled = "Untitled";					/* title				*/
};
/*--------------------------------------------------------------------------------------*/
