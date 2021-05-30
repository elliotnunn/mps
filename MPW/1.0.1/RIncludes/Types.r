/*
		Types.r -- Type Declarations for Rez and DeRez
		
		Copyright Apple Computer, Inc. 1986
		All rights reserved.

		September 7, 1986
*/



/*-------------------------------------Equates------------------------------------------*/
/*		The following are used to set styles, simply add for desired style.
*/
#define bold			1
#define italic			2
#define underline		4
#define outline 		8
#define shadow			16
#define condense		32
#define extend			64

/*-------------------------------------ALRT---------------------------------------------*/
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
/*-------------------------------------BNDL---------------------------------------------*/
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
/*-------------------------------------CNTL---------------------------------------------*/
type 'CNTL' {
		rect;													/* Bounds				*/
		integer;												/* Value				*/
		byte			invisible, visible; 					/* visible				*/
		fill byte;
		integer;												/* Max					*/
		integer;												/* Min					*/
		integer 		pushButProc, checkBoxProc, radioButProc,/* ProcID				*/
						pushButProcUseWFont=8, checkBoxProcUseWFont,
						radioButProcUseWFont, scrollBarProc=16;
		longint;												/* RefCon				*/
		pstring;												/* Title				*/
};
/*-------------------------------------CURS---------------------------------------------*/
type 'CURS' {
		hex string [32];										/* Data 				*/
		hex string [32];										/* Mask 				*/
		point;													/* Hot spot 			*/
};
/*-------------------------------------DITL---------------------------------------------*/
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
/*-------------------------------------DLOG---------------------------------------------*/
type 'DLOG' {
		rect;													/* boundsRect			*/
		integer 		documentProc, dBoxProc, plainDBox,		/* procID				*/
						altDBoxProc, noGrowDocProc, zoomDocProc=8,
						zoomNoGrow=12, rDocProc=16;
		byte			invisible, visible; 					/* visible				*/
		fill byte;
		byte			noGoAway, goAway;						/* goAway				*/
		fill byte;
		unsigned hex longint;									/* refCon				*/
		integer;												/* 'DITL' ID			*/
		pstring;												/* title				*/
};
/*-------------------------------------FREF---------------------------------------------*/
type 'FREF' {
		literal longint;										/* File Type			*/
		integer;												/* Icon ID				*/
		pstring;												/* Filename 			*/
};
/*-------------------------------------ICON---------------------------------------------*/
type 'ICON' {
		hex string[128];										/* Icon data			*/
};
/*-------------------------------------ICN#---------------------------------------------*/
type 'ICN#' {
		array {
				hex string[128];								/* Icon data			*/
		};
};
/*-------------------------------------MENU---------------------------------------------*/
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
				char			noKey = "\0x00";				/* Key equivalent		*/
				char			noMark = "\0x00",				/* Marking char 		*/
								check = "\0x12";
				fill bit;
				unsigned bitstring[7]
								plain;							/* Style				*/
		};
		byte = 0;
};
/*-------------------------------------MBAR---------------------------------------------*/
type 'MBAR' {
		integer = $$CountOf(MenuArray); 						/* Number of menus		*/
		wide array MenuArray{
				integer;										/* Menu resource ID 	*/
		};
};
/*-------------------------------------PAT ---------------------------------------------*/
type 'PAT ' {
		hex string[8];											/* Pattern				*/
};
/*-------------------------------------PAT#---------------------------------------------*/
type 'PAT#' {
		integer = $$Countof(PatArray);
		array PatArray {
				hex string[8];									/* Pattern				*/
		};
};
/*-------------------------------------PICT---------------------------------------------*/
type 'PICT' {
		integer;												/* Length				*/
		rect;													/* Frame				*/
		hex string; 											/* Data 				*/
};
/*-------------------------------------SICN---------------------------------------------*/
type 'SICN' {
		array {
				hex string[32]; 								/* SICN data			*/
		};
};
/*-------------------------------------SIZE---------------------------------------------*/
type 'SIZE' {
		boolean 				dontSaveScreen, 				/* Save screen			*/
								saveScreen;
		boolean 				ignoreSuspendResumeEvents,		/* suspend-resume		*/
								acceptSuspendResumeEvents;
		unsigned bitstring[14] = 0; 							/* reserved 			*/
		unsigned longint;										/* size - 32k			*/
		unsigned longint;										/* min size - 32k		*/
};
/*-------------------------------------STR ---------------------------------------------*/
type 'STR ' {
		pstring;												/* String				*/
};
/*-------------------------------------STR#---------------------------------------------*/
type 'STR#' {
		integer = $$Countof(StringArray);
		array StringArray {
				pstring;										/* String				*/
		};
};
/*-------------------------------------WIND---------------------------------------------*/
type 'WIND' {
		rect;													/* boundsRect			*/
		integer 		documentProc, dBoxProc, plainDBox,		/* procID				*/
						altDBoxProc, noGrowDocProc, zoomDocProc=8,
						zoomNoGrow=12, rDocProc=16;
		byte			invisible, visible; 					/* visible				*/
		fill byte;
		byte			noGoAway, goAway;						/* goAway				*/
		fill byte;
		unsigned hex longint;									/* refCon				*/
		pstring 		Untitled = "Untitled";					/* title				*/
};
/*--------------------------------------------------------------------------------------*/
