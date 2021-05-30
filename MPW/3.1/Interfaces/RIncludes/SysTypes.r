/*
	SysTypes.r -- Type Declarations for Rez and DeRez
	
	Copyright Apple Computer, Inc. 1986-1989
	All rights reserved.

	- Change history -
	10/08/87	- THT: fixed scrn, flags were in wrong order.
	10/08/87	- THT: changed FONT & FOND definitions to use labels.
	10/08/87	- THT: added 'snd ' resource.
	12/09/87	- THT: added verIreland through verThailand to Country.
	02/29/88	- THT: added more specific bit information to KSWP and
					   changed the array size definition so that it
					   would derez properly.
	04/18/88	- THT: added 'vers' resource definition.
	06/30/88	- THT: added synth values to 'snd '.
	09/20/88	- THT: added verIndia & verPakistan country codes.
	09/20/88	- THT: added 'itl2' & 'itl4' resource definitions.
	09/28/88	- THT: added 'mcky' and 'finf' resource definitions.
	11/09/88	- THT: updated 'snd ' according to new documentation.
	11/29/88	- THT: added replace bit to CommFlags of 'insc'.
	12/06/88	- THT: changed definition of 'itlb' and 'itlc'.
	02/03/89	- THT: changed 'FONT' to support pixel depths > 1 for NFNT
	02/08/89	- THT: change verGemany to verGermany
	03/20/89	- THT: added #ifndef __SYSTYPES.R__
	04/12/89	- THT: added fields to itlc for script icon
	04/12/89	- THT: added 'itlk' resource definition
	04/12/89	- THT: added new 'itl2' resource definition
	05/08/89	- THT: doctored up 'INTL' (0) with new constants: monYearDay,
					   dayYearMon, yearDayMon, and twelveHourZeroCycle.
	09/06/89	- THT: added Faroese, Farsi, and Cyrillic to Country list.
*/

#ifndef __SYSTYPES.R__
#define __SYSTYPES.R__


/*-------------------------------------Equates------------------------------------------*/
/*	The following are used to set characters used in INTL resources.
*/
#define	periodSymbol		"."
#define	commaSymbol			","
#define	semicolonSymbol		";"
#define	dollarsignSymbol	"$"
#define	slashSymbol			"/"
#define	colonSymbol			":"

#define	Country		verUs, verFrance, verBritain, verGermany,			\
					verItaly, verNetherlands, verBelgiumLux,			\
					verSweden, verSpain, verDenmark, verPortugal,		\
					verFrCanada, verNorway, verIsrael, verJapan,		\
					verAustralia, verArabia, verFinland, verFrSwiss,	\
					verGrSwiss, verGreece, verIceland, verMalta,		\
					verCyprus, verTurkey, verYugoslavia, verIndia = 33,	\
					verPakistan, verFaroese = 47, verFarsi, verCyrillic,\
					verIreland = 50, verKorea, verChina, verTaiwan, 	\
					verThailand

/*		The following are used to set styles, simply add for desired style.
*/
#define	bold			1
#define italic			2
#define underline		4
#define outline 		8
#define shadow			16
#define condense		32
#define extend			64

/*----------------------------DRVR • Driver---------------------------------------------*/
type 'DRVR' {
		boolean = 0;
		boolean			dontNeedLock, needLock;					/* lock drvr in memory	*/
		boolean			dontNeedTime, needTime;					/* for periodic	action	*/
		boolean			dontNeedGoodbye, needGoodbye;			/* call before heap reinit*/
		boolean			noStatusEnable, statusEnable;			/* responds to status	*/
		boolean			noCtlEnable, ctlEnable;					/* responds to control	*/
		boolean			noWriteEnable, writeEnable;				/* responds to write	*/
		boolean			noReadEnable, readEnable;				/* responds to read		*/
		byte = 0;
		integer;												/* driver delay			*/
		unsigned hex integer;									/* desk acc event mask	*/
		integer;												/* driver menu			*/
		unsigned hex integer;									/* offset to open		*/
		unsigned hex integer;									/* offset to prime		*/
		unsigned hex integer;									/* offset to control	*/
		unsigned hex integer;									/* offset to status		*/
		unsigned hex integer;									/* offset to close		*/
		pstring;												/* driver name			*/
		hex string;												/* driver code			*/
};
/*----------------------------finf • Font Family Description----------------------------*/
type 'finf' {
		integer = $$CountOf(Fonts);								/* # of fonts			*/
		array Fonts {
			integer;											/* Font Number			*/
			unsigned hex integer	plain;						/* 		Font Style		*/
			integer;											/* 		Font Size		*/
		};
};
/*----------------------------FOND • Font Family Description----------------------------*/
/* Note: this FOND resource definition only works when the tables at the end of the
		 resource are in this order:	1 - Family Character-Width Table
		 								2 - Style Mapping Table
										3 - Kerning Tables
*/
type 'FOND' {
		/* Flags Word */
		boolean		proportionalFont, fixedWidthFont;
		boolean		useFractWidthTable, dontUseFractWidthTable;
		boolean		computeFixedPointExtra, useIntegerExtra;
		boolean		useFractEnable, ignoreFractEnable;
		boolean		canAdjustCharSpacing, dontAdjustCharSpacing;
		unsigned hex bitstring[9] = 0;							/* Reserved				*/
		boolean		noCharWidthTable, hasCharWidthTable;
		boolean		noImageHeightTable, hasImageHeightTable;

		integer;												/* Family ID number		*/
	First:
		integer;												/* first char			*/
	Last:
		integer;												/* last char			*/
		integer;												/* Ascent				*/
		integer;												/* Descent				*/
		integer;												/* Leading				*/
		integer;												/* Width Max			*/
	WidthOffset:
		unsigned hex longint = WidthTable[1] >> 3;				/* Width table offset	*/
	KerningOffset:
		unsigned hex longint = KerningTable[1] >> 3;			/* Kerning table offset	*/
	StyleMapOffset:
		unsigned hex longint = StyleTable[1] >> 3;				/* Style map offset		*/
		integer;												/* reserved				*/
		integer;												/* ex wid bold			*/
		integer;												/* ex wid italic		*/
		integer;												/* ex wid underline		*/
		integer;												/* ex wid outline		*/
		integer;												/* ex wid shadow		*/
		integer;												/* ex wid condensed		*/
		integer;												/* ex wid extended		*/
		integer;												/* reserved				*/
		longint;												/* reserved for intl	*/
	Version:
		integer;												/* version				*/
	
		/* Font Association Table */
		integer = $$CountOf(FontEntries)-1; 					/* # of font entries	*/
		wide array FontEntries {
			integer;											/* Font size			*/
			integer;											/* Font style			*/
			integer;											/* Resource ID of FONT	*/
		};
		/*  */
		array [$$Word(Version) == 2] {
	OffsetTableStart:
			integer = $$CountOf(OffsetTable) - 1;
			array OffsetTable {
				longint = (BBoxStart[1] - OffsetTableStart[1]) >> 3;				
			};
			/* Font Bounding Box Table */
	BBoxStart:
			integer = $$CountOf(BBoxTable) - 1;
			wide array BBoxTable {
				fill bit[9];									/* Reserved				*/
				Boolean		noExtendedStyle, EXTENDEDstyle;		/* Extended style		*/
				Boolean		noCondensedStyle, CONDENSEDstyle;	/* Condensed style		*/
				Boolean		noShadowStyle, SHADOWstyle;			/* Shadow style			*/
				Boolean		noOutlineStyle, OUTLINEstyle;		/* Outline style		*/
				Boolean		noUnderline, UNDERLINEstyle;		/* Underline style		*/
				Boolean		noItalicStyle, ITALICstyle;			/* Italic style			*/
				Boolean		noBoldStyle, BOLDstyle;				/* Bold style			*/
				Rect;
			};
		};

		/* Family Character-Width Table */
		/* This outer array below handles the case when the width table offset (WidthOffset:)
		   is zero. */
		array [$$Long(WidthOffset) != 0] {
	WidthTable:
			integer = $$CountOf(WidthTable) - 1;				/* # of width tables	*/
			wide array WidthTable {
				fill bit[9];									/* Reserved				*/
				Boolean		noExtendedStyle, EXTENDEDstyle;		/* Extended style		*/
				Boolean		noCondensedStyle, CONDENSEDstyle;	/* Condensed style		*/
				Boolean		noShadowStyle, SHADOWstyle;			/* Shadow style			*/
				Boolean		noOutlineStyle, OUTLINEstyle;		/* Outline style		*/
				Boolean		noUnderline, UNDERLINEstyle;		/* Underline style		*/
				Boolean		noItalicStyle, ITALICstyle;			/* Italic style			*/
				Boolean		noBoldStyle, BOLDstyle;				/* Bold style			*/
				
				wide array [$$Word(Last) - $$Word(First) + 3] {
					unsigned hex integer;						/* Width of character	*/
				};
			};
		};
	
		/* Style Mapping Table */
		/* This outer array below handles the case when the width table offset (WidthOffset:)
		   is zero. */
		array [$$Long(StyleMapOffset) != 0] {
	StyleTable:
			unsigned hex integer;								/* Font class			*/
	CharCodeOffset:
			unsigned hex longint =								/* Encoding table offset*/
				(CharCodeTable[1,1] - StyleTable[1]) / 8 * (CharCodeTable[1,1] != 0);
			fill long;											/* Reserved				*/
			array [48] {
				byte;
			};
			/* Style Name Table */
			integer = $$CountOf(StyleNames);					/* Number of strings	*/
			pstring;											/* Full base font name	*/
			array StyleNames {
				pstring;										/* Style suffix names	*/
			};
			
			/* Character Set Encoding Table */
			/* This outer array below handles the case when the character set encoding
			   offset is zero (CharCodeOffset:) */
			array [$$Long(CharCodeOffset[1]) != 0] {
	CharCodeTable:
				integer = $$CountOf(CharacterCodes);			/* Number of entries	*/
				wide array CharacterCodes {
					char;										/* Character code		*/
					pstring;									/* Char name string		*/
				};
			};
		};

		/* Kerning Tables */
		/* This outer array below handles the case when the kerning table offset
		   (KerningOffset:) is zero. */
		array [$$Long(KerningOffset) != 0] {
			/* Kerning Tables */
	KerningTable:
			integer = $$CountOf(KerningTables) - 1;				/* Number of tables		*/
			wide array KerningTables {
				fill bit[9];									/* Reserved				*/
				Boolean		noExtendedStyle, EXTENDEDstyle;		/* Extended style		*/
				Boolean		noCondensedStyle, CONDENSEDstyle;	/* Condensed style		*/
				Boolean		noShadowStyle, SHADOWstyle;			/* Shadow style			*/
				Boolean		noOutlineStyle, OUTLINEstyle;		/* Outline style		*/
				Boolean		noUnderline, UNDERLINEstyle;		/* Underline style		*/
				Boolean		noItalicStyle, ITALICstyle;			/* Italic style			*/
				Boolean		noBoldStyle, BOLDstyle;				/* Bold style			*/
				integer = $$CountOf(KerningTableEntry);			/* # of entries			*/
				wide array KerningTableEntry {
					char;										/* first char of pair	*/
					char;										/* second char of pair	*/
					unsigned hex integer;						/* kerning offset		*/
				};
			};
		};
};
/*----------------------------FONT • Font Description-----------------------------------*/
/* PROBLEMS: the offset to the offset/width table has been changed to a longint, with the
			 high word stored in the neg descent field (if its not -1).  Rez can't handle
			 this. */
type 'FONT' {	
		/* Font Type Flags */
FontType:
		boolean = 1;											/* Reserved				*/
		boolean		doExpandFont, dontExpandFont;
		boolean		proportionalFont, fixedWidthFont;
		boolean = 1;											/* Reserved				*/
		unsigned bitstring[2] = 0;								/* Reserved				*/
		boolean		blackFont, colorFont;
		boolean		notSynthetic, isSynthetic;
		boolean		nofctbRsrc, hasfctbRsrc;
		unsigned bitstring[3] = 0;								/* Reserved				*/
		unsigned bitstring[2]	oneBit, twoBit,					/* Font depth			*/
								fourBit, eightBit;
		boolean		noCharWidthTable, hasCharWidthTable;
		boolean		noImageHeightTable, hasImageHeightTable;

	FirstChar:
		integer;												/* first char			*/
	LastChar:
		integer;												/* last char			*/
		integer;												/* width max			*/
		integer;												/* kern max				*/
		integer;												/* neg descent			*/
		integer;												/* font rect width		*/
	Height:
		integer;												/* font rect height		*/
	Offset:
		unsigned integer = ((WidthTable-Offset)/16);			/* offset to off/wid tab*/		
		integer;												/* ascent				*/
		integer;												/* descent				*/
		integer;												/* leading				*/
	RowWords:
		integer;												/* row width (in words)	*/
		
		/* Tables */
		/* Bit image */
		hex string [($$Word(RowWords) <<($$BitField(FontType, 12, 2)
			& 3) + 1) * $$Word(Height)];

		/* Location Table */
		array [$$Word(LastChar) - $$Word(FirstChar) + 3] {
			integer;
		};
		
		/* Offset/Width Table */
	WidthTable:
		array [$$Word(LastChar) - $$Word(FirstChar) + 3] {
			integer;
		};
};
/*----------------------------FWID • Font Width Table-----------------------------------*/
type 'FWID' {
		unsigned hex integer;									/* Font type			*/
		integer;												/* first char			*/
		integer;												/* last char			*/
		integer;												/* width max			*/
		integer;												/* kern max				*/
		integer;												/* neg descent			*/
		integer;												/* font rect width		*/
		integer;												/* font rect height		*/
		unsigned hex integer;									/* offset to off/wid tab*/
		integer;												/* ascent				*/
		integer;												/* descent				*/
		integer;												/* leading				*/
		integer;												/* row width (in words)	*/
		wide array {											/* offset/width table	*/
			byte;												/* char offset			*/
			byte;												/* char width			*/
		};
};
/*----------------------------insc • Installer Script-----------------------------------*/
#define	CommFlags 																		   \
		boolean		noDelRemove, delRemove;				/* Remove file if remove clicked*/ \
		boolean		noDelInstall, delInstall;			/* Delete target before copy	*/ \
		boolean		noCopy, copy;						/* Copy file to destination		*/ \
		fill bit[3];									/* Reserved						*/ \
		boolean		doReplace, dontReplace;				/* Replace						*/ \
		fill bit[1];									/* Reserved						*/ \
		boolean		old, noOld;							/* Type & creator need not match*/ \
		boolean		noUpdateOnly, updateOnly			/* Only update if target exists	*/

#define	FileSpecFlags																	   \
		CommFlags;																		   \
		boolean		noRsrcFork, rsrcFork;				/* Apply operation to rsrc fork */ \
		boolean		noDataFork, dataFork;				/* Apply operation to data fork	*/ \
		boolean		needExist, needNotExist;			/* File need not exist			*/ \
		boolean		noCrDate, crDate;					/* Creation date must match		*/ \
		boolean		noTypeCr, typeCr;					/* Type and creator must match	*/ \
		bitstring[1] = 1								/* Indicates file specification	*/

#define	RsrcSpecFlags																	   \
		CommFlags;																		   \
		fill bit;										/* Reserved						*/ \
		boolean		noEvenIf, evenIf;					/* Do it even if rsrc protected */ \
		boolean		needExist, needNotExist;			/* Rsrc need not exist			*/ \
		fill bit;										/* Reserved						*/ \
		boolean noByID, byID;							/* Use name or id to find rsrc	*/ \
		bitstring[1] = 0								/* Indicates rsrc specification	*/

#define	FileSpec																		   \
		FileSpecFlags;									/* FileSpec Flags				*/ \
		literal longint;								/* File Type					*/ \
		literal longint;								/* File Creator					*/ \
		unsigned hex longint;							/* Creation Date, use			   \
														   $$DateToLongInt() to read in	   \
														   the date.					*/ \
		fill long[3];									/* Handle, FDelSize, FAddSize	*/ \
		pstring;										/* File Name					*/ \
		align word

type 'insc' {
		switch {
			case format0:
				key integer = 0;								/* Script Format		*/
				hex integer = 0;								/* Script Flags			*/
				pstring;										/* Script Name			*/
				align word;
				wstring;										/* Script Help			*/
				align word;
				unsigned integer = $$CountOf(FileList);			/* File List			*/
				wide array FileList {
					FileSpec;									/* File Spec			*/
				};
				unsigned integer = $$CountOf(ResFileList);		/* Resource File List	*/
				wide array ResFileList {
					FileSpec;									/* Target File Spec		*/
					integer = $$CountOf(SrcFileList);			/* Source File List		*/
					wide array SrcFileList {
						FileSpec;								/* Source File Spec		*/
						unsigned integer = $$CountOf(ResList);	/* Resource List		*/
						wide array ResList {
							RsrcSpecFlags;						/* Resource Spec Flags	*/
							literal longint;					/* Resource Type		*/
							integer;							/* Source ID			*/
							integer;							/* Target ID			*/
							fill word[2];						/* CRC/Version, Filler1	*/
							fill long[3];						/* Filler2, RDelSize,
																	RAddSize			*/
							pstring;							/* Resource Name		*/
							align word;
							integer = 0;						/* Previous CRC List	*/
						};
					};
				};
				integer = 0;									/* Disk Blocks			*/
	
			case format1:
				key integer = 1;								/* Script Format		*/
				hex integer = 0;								/* Script Flags			*/
				pstring;										/* Script Name			*/
				align word;
				wstring;										/* Script Help			*/
				align word;
				unsigned integer = $$CountOf(FileList);			/* File List			*/
				wide array FileList {
					FileSpec;									/* File Spec			*/
				};
				unsigned integer = $$CountOf(ResFileList);		/* Resource File List	*/
				wide array ResFileList {
					FileSpec;									/* Target File Spec		*/
					integer = $$CountOf(SrcFileList);			/* Source File List		*/
					wide array SrcFileList {
						FileSpec;								/* Source File Spec		*/
						unsigned integer = $$CountOf(ResList);	/* Resource List		*/
						wide array ResList {
							RsrcSpecFlags;						/* Resource Spec Flags	*/
							literal longint;					/* Resource Type		*/
							integer;							/* Source ID			*/
							integer;							/* Target ID			*/
							fill word[2];						/* CRC/Version, Filler1	*/
							fill long[3];						/* Filler2, RDelSize,
																   RAddSize				*/
							pstring;							/* Resource Name		*/
							align word;
							integer = 0;						/* Previous CRC List	*/
						};
					};
				};
				unsigned integer;								/* Boot Block Version	*/
				unsigned integer;								/* Number of Open Files	*/
				unsigned integer;								/* Number of Events		*/
				unsigned hex longint;							/* Sys Heap Size 128K	*/
				unsigned hex longint;							/* Sys Heap Size 256K	*/
				unsigned hex longint;							/* Sys Heap Size 512K	*/
		  };
};
/*----------------------------INTL (0) • International Formatting Information-----------*/
type 'INTL' (0) {
		char		period = periodSymbol;						/* decimal pt sep		*/
		char		comma = commaSymbol;						/* thousands sep		*/
		char		semicolon = semicolonSymbol;				/* list sep				*/
		char		dollarsign = dollarsignSymbol;				/* currSym1				*/
		char;													/* currSym2				*/
		char;													/* currSym3				*/
	
		/* currFmt */
		boolean		noLeadZero, leadingZero;					/* leading unit zero	*/
		boolean		noTrailingZero, trailingZero;				/* trailing dec zero	*/
		boolean		paren, minusSign;							/* negative rep			*/
		boolean		trails, leads;								/* curr sym position	*/
		fill bit[4];											/* not used				*/
		byte		monDayYear, dayMonYear, yearMonDay,			/* dateOrder			*/
					monYearDay, dayYearMon, yearDayMon;
	
		/* shrtDateFmt */
		boolean		noCentury, century;							/* century incl			*/
		boolean		noMonthLeadZero, monthLeadZero;				/* mon lead zero		*/
		boolean		noDayLeadZero, dayLeadZero;					/* day lead zero		*/
		fill bit[5];											/* filler				*/
		char		slash = slashSymbol;						/* date sep				*/
		byte		twentyFourHour, twelveHourZeroCycle,		/* timeCycle			*/
					twelveHour = 255;
			
		/* timeFmt */
		boolean		noHoursLeadZero, hoursLeadZero;				/* hours lead zero		*/
		boolean		noMinutesLeadZero, minutesLeadZero;			/* min lead zero		*/
		boolean		noSecondsLeadZero, secondsLeadZero;			/* sec lead zero		*/
		fill bit[5];											/* filler				*/
		string[4];												/* mornStr				*/
		string[4];												/* eveStr				*/
		char;													/* timeSep				*/
		char;													/* time1Stuff			*/
		char;													/* time2Stuff			*/
		char;													/* time3Stuff			*/
		char;													/* time4Stuff			*/
		char;													/* time5Stuff			*/
		char;													/* time6Stuff			*/
		char;													/* time7Stuff			*/
		char;													/* time8Stuff			*/
		byte		standard, metric = 255;						/* metricSys			*/
		byte		Country;									/* INTL0 country		*/
		byte;													/* version				*/
};
/*----------------------------itl0 • International Formatting Information---------------*/
type 'itl0' as 'INTL' (0);
/*----------------------------INTL (1) • International Date/Time Information------------*/
type 'INTL' (1) {			
		/* Day names */
		array [7] {
			pstring[15];										/* Sunday, Monday...	*/					
		};
		
		/* Month names */
		array [12] {
			pstring[15];										/* January, February...	*/						
		};
	
		byte		dayName, none=255;							/* suppressDay			*/
		byte		dayMonYear, monDayYear = 255;				/* longDate format		*/
		byte		noDayLeadZero, dayLeadZero = 255;			/* dayLeading0			*/
		byte;													/* abbrLen				*/
		string[4];												/* st0					*/
		string[4];												/* st1					*/
		string[4];												/* st2					*/
		string[4];												/* st3					*/
		string[4];												/* st4					*/
		byte		Country;									/* INTL1 country 		*/
		byte;													/* version				*/
		hex string	DefaultReturn = "\$4E\$75";					/* local routine - If
									  							   you have one, use 
																   $$Resource to insert
																   code here.  Otherwise,
																   you must have a 68000
																   return instruction.
																   Use DefaultReturn.	*/
};
/*----------------------------itl1 • International Date/Time Information----------------*/
type 'itl1' as 'INTL' (1);
/*----------------------------itl2 • International String Comparision Package Hooks-----*/
type 'itl2' {
/*
 * The type definition for 'itl2' changed between systems 6.0.3 and 6.0.4.
 * If the fourth integer of this type is -1, the resource is of the new type.
 * There's no clean way to merge both definitions into one type that Rez and
 * DeRez could handle.  If you're trying to create or decompile a pre-6.0.4
 * 'itl2' resource, add -d SYSTEMVERSION=0x060003 to your Rez or DeRez command.
 */
#ifndef SYSTEMVERSION
	#define SYSTEMVERSION 0x060004	// version 6.0.4
#endif
#if SYSTEMVERSION >= 0x060004
		unsigned integer = initHookOffset >> 3;				/* init hook offset			*/
		unsigned integer = fetchHookOffset >> 3;			/* fetch hook offset		*/
		unsigned integer = vernierHookOffset >> 3;			/* vernier hook offset		*/
		unsigned integer = projectHookOffset >> 3;			/* project hook offset		*/
		integer = -1;										/* MODIFIED format flag		*/
		unsigned integer = rsvd2HookOffset >> 3;			/* rsvd2 hook offset		*/

		/* new offsets, for new tables */
		unsigned integer = typeListOffset >> 3;				/* TypeList offset			*/
		unsigned integer = classArrayOffset >> 3;			/* ClassArray offset		*/
		unsigned integer = upperListOffset >> 3;			/* UpperList offset			*/
		unsigned integer = lowerListOffset >> 3;			/* LowerList offset			*/
		unsigned integer = upperNoMarkListOffset >> 3;		/* UpperNoMarkList offset	*/
		unsigned integer = wordTableOffset >> 3;			/* WordTable offset			*/
		unsigned integer = wrapTableOffset >> 3;			/* WrapTable offset			*/
		unsigned integer = noMarkListOffset >> 3;			/* NoMarkList offset		*/
		unsigned hex integer;								/* version number			*/
		unsigned integer;									/* reserved					*/

		/* the current routines */
initHookOffset:
		hex string [(fetchHookOffset - initHookOffset) >> 3];			/* code */
fetchHookOffset:
		hex string [(vernierHookOffset - fetchHookOffset) >> 3];		/* code */
vernierHookOffset:
		hex string [(projectHookOffset - vernierHookOffset) >> 3];		/* code */
projectHookOffset:
		hex string [(rsvd2HookOffset - projectHookOffset) >> 3];		/* code */
/* no rsvd1Hook label in new format */
		/* no rsvd1Hook code in new format */
rsvd2HookOffset:
		hex string [(classArrayOffset - rsvd2HookOffset) >> 3];			/* code */

		/* the new tables; note that order is different than the offset order above */
classArrayOffset:
		hex string [(typeListOffset - classArrayOffset) >> 3];			/* table */
typeListOffset:
		hex string [(upperListOffset - typeListOffset) >> 3];			/* table */
upperListOffset:
		hex string [(lowerListOffset - upperListOffset) >> 3];			/* table */
lowerListOffset:
		hex string [(upperNoMarkListOffset - lowerListOffset) >> 3];	/* table */
upperNoMarkListOffset:
		hex string [(noMarkListOffset - upperNoMarkListOffset) >> 3];	/* table */
noMarkListOffset:
		hex string [(wordTableOffset - noMarkListOffset) >> 3];			/* table */
wordTableOffset:
		hex string [(wrapTableOffset - wordTableOffset) >> 3];			/* table */
wrapTableOffset:
		hex string;
#else
		unsigned integer = initHookOffset >> 3;					/* init hook offset		*/
		unsigned integer = fetchHookOffset >> 3;				/* fetch hook offset	*/
		unsigned integer = vernierHookOffset >> 3;				/* vernier hook offset	*/
		unsigned integer = projectHookOffset >> 3;				/* project hook offset	*/
		unsigned integer = rsvd1HookOffset >> 3;				/* Rsvd1 hook offset	*/
		unsigned integer = rsvd2HookOffset >> 3;				/* Rsvd2 hook offset	*/
initHookOffset:
		hex string [(fetchHookOffset - initHookOffset) >> 3];	/* init hook code		*/
fetchHookOffset:
		hex string [(vernierHookOffset - fetchHookOffset) >> 3];/* fetch hook code		*/
vernierHookOffset:
		hex string [(projectHookOffset - vernierHookOffset) >> 3];/* vernier hook code	*/
projectHookOffset:
		hex string [(rsvd1HookOffset - projectHookOffset) >> 3];/* project hook code	*/
rsvd1HookOffset:
		hex string [(rsvd2HookOffset - rsvd1HookOffset) >> 3];	/* rsvd1 hook code		*/
rsvd2HookOffset:
		hex string;												/* rsvd2 hook code		*/
#endif
};
/*----------------------------itl4 • International Tokenizer----------------------------*/
type 'itl4' {
		unsigned hex integer;									/* flags				*/
		literal longint = 'itl4';								/* resource type		*/
		integer;												/* resource ID			*/
		integer = $0100;										/* version number		*/
		longint = 0;											/* reserved				*/
		longint = 0;											/* reserved				*/

		integer = 8;											/* # of table entries	*/

		unsigned longint = mapCharOffset >> 3;					/* MapChar offset		*/
		unsigned longint = stringCopyOffset >> 3;				/* stringCopy offset	*/
		unsigned longint = extendFetchOffset >> 3;				/* extendFetch offset	*/
		unsigned longint = unTokenOffset >> 3;					/* unToken offset		*/
		unsigned longint = defaultPartsTableOffset >> 3;		/* defaultParts offset	*/
		unsigned longint = 0;									/* reserved offset		*/
		unsigned longint = 0;									/* reserved offset		*/
		unsigned longint = 0;									/* reserved offset		*/
		unsigned longint = 0;									/* reserved offset		*/

		longint = $$CountOf(MapChar);
mapCharOffset:
		array MapChar {
			byte;
		};

extendFetchOffset:
		hex string [(stringCopyOffset - extendFetchOffset) >> 3];/* extendFetch code	*/
stringCopyOffset:
		hex string [(unTokenOffset - stringCopyOffset) >> 3];	/* stringCopy code		*/
unTokenOffset:
		integer = (defaultPartsTableOffset - unTokenOffset) >> 3;/* unToken table size	*/
unTokenSize:
		integer = $$CountOf(unToken) - 1;
		array unToken {
			integer;											/* offset to token strings*/
		};
		array [$$Word(unTokenSize) + 1] {
	unTokenItemOffset:
			pstring;											/* token strings		*/
			align word;
		};
		
defaultPartsTableOffset:
		integer = 1;											/* version number		*/
		wide array [31] {
			unsigned byte;
			char;
		};
		integer;												/* size					*/
		wide array [10] {
			unsigned byte;
			char;
		};
		integer;												/* size					*/
		wide array [10] {
			unsigned byte;
			char;
		};
		integer;												/* size					*/
		wide array [10] {
			unsigned byte;
			char;
		};
		integer;												/* size					*/
		wide array [10] {
			unsigned byte;
			char;
		};
		hex string [20] = "";
};
/*----------------------------itlb • International Script Bundle------------------------*/
type 'itlb' {
		unsigned integer;										/* itl0 id number		*/
		unsigned integer;										/* itl1 id number		*/
		unsigned integer;										/* itl2 id number		*/
		unsigned hex integer;									/* script flags - see
																   smScriptFlags info
																   in ScriptEqu.a		*/
		unsigned integer;										/* itl4 id number		*/
		unsigned integer;										/* reserved				*/
		unsigned integer;										/* Script language		*/
		unsigned integer;										/* high byte - number
																   representation code,
																   low byte - date
																   representation code	*/
		unsigned integer;										/* KCHR id number		*/
		unsigned integer;										/* SICN id number		*/
};
/*----------------------------itlc • International Configuration------------------------*/
type 'itlc' {
		unsigned integer;										/* system script code	*/
		unsigned integer;										/* keyboard cache size	*/
		byte			noFontForce, fontForce = 255;			/* font force flag		*/
		byte			noIntlForce, intlForce = 255;			/* intl force flag		*/
		byte			noOldKeyboard;							/* old keyboard			*/
		unsigned hex byte;										/* general flags - see
																   smGenFlags info in
																   ScriptEqu.a			*/
		integer;												/* script icon offset	*/
		byte			rightOffset, leftOffset = 255;			/* menu side for offset	*/
		byte;													/* icon data (rsvd)		*/
		hex string [36];										/* reserved				*/
};
/*----------------------------itlk • Keyboard-dependent Remapping-----------------------*/
type 'itlk' {
		integer = $$CountOf(RemapItemArray);
		wide array RemapItemArray {
			integer;											/* keyboard type		*/
			hex byte;											/* old modifier bits	*/
			byte;												/* old key code			*/
			hex byte;											/* modifier bits mask	*/
			byte;												/* key code mask		*/
			hex byte;											/* new modifier bits	*/
			byte;												/* new key code			*/
		};
};
/*----------------------------KCAP • Physical Layout of Keyboard------------------------*/
type 'KCAP' {
		rect;													/* boundsRect			*/
		rect;													/* textRect				*/
		integer = $$CountOf(MainArray);
		array MainArray {
			integer = $$CountOf(ShapeArray) - 1;
			wide array ShapeArray {
				point;											/* shapePoint			*/
			};
			integer = $$CountOf(KeyArray) - 1;
			wide array KeyArray {
				byte;											/* mask					*/
				boolean				or, and;
				bitstring[7];									/* keyCode				*/
				integer;										/* dv					*/
				integer;										/* dh					*/
			};
		};
};
/*----------------------------KCHR • ASCII Mapping (software)---------------------------*/
type 'KCHR' {
		integer;												/* Version				*/
		wide array [$100] {										/* Indexes				*/
			byte;
		};
		integer = $$CountOf(TableArray);
		array TableArray {
			wide array [$80] {									/* ASCII characters		*/
				char;
			};
		};
		integer = $$CountOf(DeadArray);
		array DeadArray {
			byte;												/* Table number			*/
			byte;												/* Virtual keycode		*/
			integer = $$CountOf(CompletorArray);
			wide array CompletorArray {
				char;											/* Completor char		*/
				char;											/* Substituting char	*/
			};
			char;												/* No match char		*/
			char;												/* 16-bits for the times
																   when 8 isn't enough	*/
		};
};
/*----------------------------KMAP • Keyboard Mapping (hardware)------------------------*/
type 'KMAP' {
		integer;												/* ID					*/
		integer;												/* Version				*/
		wide array [$80] {										/* Raw to virtual		*/
			byte;												/*  keycode map			*/
		};
		integer = $$CountOf(ExceptionArray);
		wide array ExceptionArray {
			byte;												/* Raw keycode			*/
			boolean			noXor, Xor;
			fill bit[3];
			bitstring[4];										/* ADB op				*/
			pstring;
		};
};
/*----------------------------KSWP • Keyboard Swapping----------------------------------*/
type 'KSWP' {
		/* The expression below that calculates the number of elements in the
		   array is complicated because of the way that $$ResourceSize works.
		   $$ResourceSize returns the size of the resource.  When derez'ing a
		   resource, the size of the resource is known from the start.  When
		   rez'ing a resource, however, the size starts out at zero and is 
		   incremented each time a field is appended to the resource data.  In
		   other words, while rez'ing, $$ResourceSize rarely returns the final
		   size of the resource.  When rez'ing a KSWP, the array size expression
		   is not evaluated until all of the array elements have been parsed.
		   Since each array element is 4 bytes long (if you add up all the fields),
		   the number of array elements is the size of the resource at that point
		   divided by four.  Since the preprocessor value of "DeRez" is zero when
		   Rez'ing, the expression is equivalent to $$ResourceSize / 4.  When
		   derez'ing a KSWP, the value of $$ResourceSize is constant: always the
		   total size of the resource, in bytes.  Since the resource contains 4
		   bytes of fill at the end (which happens to be the size of an array
		   element), we have to take that in consideration when calculating the
		   size of the array.  Note that the preprocessor value of "DeRez" is one,
		   when derez'ing.
		*/
		wide array [$$ResourceSize / 4 - DeRez]{
			hex integer		Roman, Japanese, Chinese, Korean,	/* script code or verb	*/
							Arabic, Hebrew, Greek,
							Rotate = -1, System = -2,
							Alternate = -3;
			unsigned byte;										/* virtual key code		*/
			/* Modifiers */
			fill bit;											/* rControlOn,rControlOff*/
			fill bit;											/* rOptionOn,rOptionOff	*/
			fill bit;											/* rShiftOn,rShiftOff	*/
			boolean		controlOff, controlOn;
			boolean		optionOff, optionOn;
			fill bit;											/* capsLockOn,capsLockOff*/
			boolean		shiftOff, shiftOn;
			boolean		commandOff, commandOn;
		};
		fill long;
};
/*----------------------------mcky • Mouse Tracking-------------------------------------*/
type 'mcky' {
		array [8] {
			unsigned byte;
		};
};
/*----------------------------mppc • MPP Configuration Resource-------------------------*/
type 'mppc' {
		unsigned hex longint;									/* Info passed to drvr	*/
		byte;													/* Override version #	*/
		fill byte;												/* Reserved				*/
};
/*----------------------------NFNT • Font Description-----------------------------------*/
type 'NFNT' as 'FONT';
/*----------------------------nrct • Rectangle List-------------------------------------*/
type 'nrct' {
		integer = $$CountOf(RectArray);							/* Number of rectangles	*/
		array RectArray {
			rect;
		};
};

/*----------------------------ROv# • ROM Resource Override------------------------------*/
type 'ROv#' {
		unsigned hex integer;									/* Version # of ROM		*/
		integer = $$CountOf(typeList) - 1;						/* Number of resources	*/
		wide array typeList {
			literal longint;									/* Resource type		*/
			integer;											/* Resource id			*/
		};
};
/*----------------------------scrn • Screen Configuration-------------------------------*/
type 'scrn' {
		integer = $$CountOf(Device);							/* Number of displays	*/
		wide array Device {
			unsigned hex integer;								/* sRsrc Type			*/
			integer;											/* Slot number			*/
			unsigned hex longint;								/* dCtlDevBase			*/
			integer;											/* sRsrcID for mode		*/
			integer = $77FE;									/* Flag mask			*/
			Boolean			inactive, active;					/* Device active flag	*/
			fill bit[3]; 										/* reserved 			*/
			Boolean			auxillaryScreen, mainScreen;		/* Main screen flag		*/
			unsigned bitstring[10] = 0;							/* reserved				*/
			Boolean			monochrome, color;					/* Device type			*/
			integer;											/* Rsrc ID of 'clut'	*/
			integer;											/* Rsrc ID of 'gama'	*/
			Rect;												/* Device's global rect	*/
			integer = $$CountOf(ControlCalls);					/* # of control calls	*/
			wide array ControlCalls {
				integer;										/* csCode for this call	*/
				wstring;										/* param block data		*/
				align word;
				
			};
		};
};
/*----------------------------snd  • Sound----------------------------------------------*/
type 'snd ' {
		switch {
			case FormatOne:
				key unsigned integer = $0001;
				unsigned integer = $$CountOf(Synthesizers);
				wide array Synthesizers {
					/* Resource ID of synthesizer/modifer */
					integer		generalNoteSynth		= $0001,	// For any Macintosh
								generalWaveTableSynth	= $0003,
								generalSampledSynth		= $0005,
								
								sndChipNoteSynth		= $0801,	// For Macintosh with
								sndChipWaveTableSynth	= $0803,	// Apple sound chip
								sndChipSampledSynth		= $0805,
								
								plusAndSEnoteSynth		= $1001,	// For Macintosh Plus
								plusAndSEwaveTableSynth	= $1003,	// and SE
								plusAndSEsampledSynth	= $1005;
					longint;									/* init parameter		*/
				};
	
			case FormatTwo:
				key unsigned integer = $0002;
				integer		free = 0, keepInMemory = 256+1;		/* Space for refe count	*/
		};
		unsigned integer = $$CountOf(SoundCmnds);
		wide array SoundCmnds {
			boolean		noData, hasData;
			switch {
				case nullCmd:
					key bitstring[15] = 0;
					fill word;									/* Param 1 = nil		*/
					fill long;									/* Param 2 = nil		*/
				case initCmd:
					key bitstring[15] = 1;
					fill word;									/* Param 1 = nil		*/
					longint 	initChanLeft = $02,				/* Init					*/
								initChanRight = $03,
								initChan0 = $04, initChan1 = $05,
								initChan2 = $06, initChan3 = $07,
								initSRate22k = $20, initSRate44k = $30,
								initMono = $80, initStereo = $C0;
				case freeCmd:
					key bitstring[15] = 2;
					fill word;									/* Param 1 = nil		*/
					fill long;									/* Param 2 = nil		*/
				case quietCmd:
					key bitstring[15] = 3;
					fill word;									/* Param 1 = nil		*/
					fill long;									/* Param 2 = nil		*/
				case flushCmd:
					key bitstring[15] = 4;
					fill word;									/* Param 1 = nil		*/
					fill long;									/* Param 2 = nil		*/
				case waitCmd:
					key bitstring[15] = 10;
					integer		oneSecond = 2000;				/* Duration				*/
					fill long;									/* Param 2 = nil		*/
				case pauseCmd:
					key bitstring[15] = 11;
					fill word;									/* Param 1 = nil		*/
					fill long;									/* Param 2 = nil		*/
				case resumeCmd:
					key bitstring[15] = 12;
					fill word;									/* Param 1 = nil		*/
					fill long;									/* Param 2 = nil		*/
				case callBackCmd:
					key bitstring[15] = 13;
					integer;									/* User-defined			*/
					longint;									/* User-defined			*/
				case syncCmd:
					key bitstring[15] = 14;
					integer;									/* Count				*/
					longint;									/* Identifier			*/
				case emptyCmd:
					key bitstring[15] = 15;
					fill word;									/* Param 1 = nil		*/
					fill long;									/* Param 2 = nil		*/
				case tickleCmd:
					key bitstring[15] = 20;
					fill word;									/* Param 1 = nil		*/
					fill long;									/* Param 2 = nil		*/
				case requestNextCmd:
					key bitstring[15] = 21;
					integer;									/* Count				*/
					fill long;									/* Param 2 = nil		*/
				case howOftenCmd:
					key bitstring[15] = 22;
					integer;									/* Period				*/
					longint;									/* Ptr to modifier stub	*/
				case wakeUpCmd:
					key bitstring[15] = 23;
					integer;									/* Period */
					longint;									/* Ptr to modifier stub	*/
				case availableCmd:
					key bitstring[15] = 24;
					integer;									/* Status				*/
					longint 	initChanLeft = $02,				/* Init					*/
								initChanRight = $03,
								initChan0 = $04, initChan1 = $05,
								initChan2 = $06, initChan3 = $07,
								initSRate22k = $20, initSRate44k = $30,
								initMono = $80, initStereo = $C0;
				case versionCmd:
					key bitstring[15] = 25;
					fill word;									/* Param 1 = nil		*/
					longint;									/* Version returned		*/
				case noteCmd:
					key bitstring[15] = 40;
					integer		oneSecond = 2000;				/* Duration				*/
					longint;									/* Amplitude + frequency*/
				case restCmd:
					key bitstring[15] = 41;
					integer		oneSecond = 2000;				/* Duration				*/
					fill long;									/* Param 2 = nil		*/
				case freqCmd:
					key bitstring[15] = 42;
					fill word;									/* Param 1 = nil		*/
					longint;									/* Frequency			*/
				case ampCmd:
					key bitstring[15] = 43;
					integer;									/* Amplitude			*/
					fill long;									/* Param 2				*/
				case timbreCmd:
					key bitstring[15] = 44;
					integer		sineWave, squareWave = 255;		/* Timbre				*/
					fill long;									/* Param 2				*/
				case waveTableCmd:
					key bitstring[15] = 60;
					unsigned integer;							/* Length				*/
					longint;									/* Pointer to table		*/
				case phaseCmd:
					key bitstring[15] = 61;
					integer;									/* Shift				*/
					longint;									/* chanPtr				*/
				case soundCmd:
					key bitstring[15] = 80;
					fill word;									/* Param 1 = nil		*/
					longint;									/* Pointer to sound		*/
				case bufferCmd:
					key bitstring[15] = 81;
					fill word;									/* Param 1 = nil		*/
					longint;									/* Pointer to buffer	*/
				case rateCmd:
					key bitstring[15] = 82;
					fill word;									/* Param 1 = nil		*/
					longint;									/* Rate					*/
				case contBufferCmd:
					key bitstring[15] = 83;
					fill word;									/* Param 1 = nil		*/
					longint;									/* Pointer				*/
			};
		};
		array DataTables {
	DataTable:
			fill long;											/* Pointer to data		*/
	SampleCnt:
			unsigned longint;									/* # of sound samples	*/
			unsigned hex longint
					Rate22K = $56ee8ba4;						/* Sampling rate		*/
			unsigned longint;									/* Start of loop		*/
			unsigned longint;									/* End of loop			*/
			integer;											/* baseNote				*/
			hex string [$$Long(SampleCnt[$$ArrayIndex(DataTables)])];
		};
};
/*----------------------------vers • Version--------------------------------------------*/
type 'vers' {
		hex byte;												/* Major revision in BCD*/
		hex byte;												/* Minor vevision in BCD*/
		hex byte	development = 0x20,							/* Release stage		*/
					alpha = 0x40,
					beta = 0x60,
					final = 0x80, /* or */ release = 0x80;
		hex byte;												/* Non-final release #	*/
		integer		Country;									/* Country code			*/
		pstring;												/* Short version number	*/
		pstring;												/* Long version number	*/
};
/*--------------------------------------------------------------------------------------*/

#endif __SYSTYPES.R__