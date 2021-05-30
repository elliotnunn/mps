{
	Script.p --  Script Manager Interface

	This file contains the interface to the Macintosh Script
	Manager routines.
				
	Copyright Apple Computer, Inc. 1986,1987
	All Rights Reserved.
}

UNIT Script;

INTERFACE

USES
	MemTypes;
	

CONST
	{ Note that the version number is divided into two bytes:  The high byte is
	bumped when the changes make the next version incompatible with previous
	versions.  If compatability is maintained, the low byte is bumped. }

	smgrVers		=	$0155;	{ current version number. }

	{ Script interface identification numbers. }
	
	smRoman 		= 0;		{ Font script is Roman. 	}

	smJapanese		= 1;		{ Font script is Japanese.	}
	smChinese		= 2;		{ Font script is Chinese.	}
	smKorean		= 3;		{ Font script is Korean.	}
	
	smArabic		= 4;		{ Font script is Arabic.	}
	smHebrew		= 5;		{ Font script is Hebrew.	}
	smGreek 		= 6;		{ Font script is Greek. 	}
	smRussian		= 7;		{ Font script is Russian.	}
	
	smRSymbol		= 8;		{ Font script is Right-left symbol. }
	
	smDevanagari	= 9;		{ Font script is Devanagari.}
	smGurmukhi		= 10;		{ Font script is Gurmukhi.	}
	smGujarati		= 11;		{ Font script is Gujarati.	}
	smOriya 		= 12;		{ Font script is Oriya. 	}
	smBengali		= 13;		{ Font script is Bengali.	}
	smTamil 		= 14;		{ Font script is Tamil. 	}
	smTelugu		= 15;		{ Font script is Telugu.	}
	smKannada		= 16;		{ Font script is Kannada.	}
	smMalayalam 	= 17;		{ Font script is Malayalam. }
	smSinhalese 	= 18;		{ Font script is Sinhalese. }
	
	smBurmese		= 19;		{ Font script is Burmese.	}
	smKhmer 		= 20;		{ Font script is Khmer. 	}
	smThai			= 21;		{ Font script is Thai.		}
	smLaotian		= 22;		{ Font script is Laotian.	}
	
	smGeorgian		= 23;		{ Font script is Georgian.	}
	smArmenian		= 24;		{ Font script is Armenian.	}
	
	smMaldivian 	= 25;		{ Font script is Maldivian. }
	smTibetan		= 26;		{ Font script is Tibetan.	}
	smMongolian 	= 27;		{ Font script is Mongolian. }
	smAmharic		= 28;		{ Font script is Amharic.	}
	
	smSlavic		= 29;		{ Font script is Slavic.	}
	smVietnamese	= 30;		{ Font script is Vietnamese. }
	smSindhi		= 31;		{ Font script is Sindhi.	}
	
	smReserved2 	= 32;		{ Font script is Reserved2. }

	{ Language Codes }

	langEnglish 	=	0;
	langFrench		=	1;
	langGerman		=	2;
	langItalian 	=	3;
	langDutch		=	4;
	langSwedish 	=	5;
	langSpanish 	=	6;
	langDanish		=	7;
	langPortugese	=	8;
	langNorwegian	=	9;
	langHebrew		=	10;
	langJapanese	=	11;
	langArabic		=	12;
	langFinish		=	13;
	langGreek		=	14;
	langIcelandic	=	15;
	langMalta		=	16;
	langTurkish 	=	17;
	langYugoslavian =	18;
	langChinese 	=	19;
	langUrdu		=	20;
	langHindi		=	21;
	langThai		=	22;

	{ Calendar Codes }

	calGregorian	=	0;
	calArabicCivil	=	1;
	calArabicLunar	=	2;
	calJapanese 	=	3;
	calJewish		=	4;
	calCoptic		=	5;

	{ Integer Format Codes }

	intWestern		=	0;
	intArabic		=	1;
	intRoman		=	2;
	intJapanese 	=	3;

	{ CharByte byte types. }

	smSingleByte	=	 0;
	smFirstByte 	=	-1;
	smLastByte		=	 1;
	smMiddleByte	=	 2;

	{ CharType field masks }

	smcTypeMask 	=	$000F;
	smcReserved 	=	$00F0;
	smcClassMask	=	$0F00;
	smcReserved12	=	$1000;
	smcRightMask	=	$2000;
	smcUpperMask	=	$4000;
	smcDoubleMask	=	$8000;

	{ CharType character types. }
	
	smCharPunct 	= 0;
	smCharAscii 	= 1;
	smCharEuro		= 7;
	
	{ CharType punctuation types. }
	
	smPunctNormal	= $0000;
	smPunctNumber	= $0100;
	smPunctSymbol	= $0200;
	smPunctBlank	= $0300;

	{ CharType case modifers. }
	
	smCharLower 	= $0000;
	smCharUpper 	= $4000;
	
	{ CharType character size modifiers (1 or multiple bytes). }
	
	smChar1byte 	= $0000;
	smChar2byte 	= $8000;

	{ Char2Pixel directions. }
	
	smLeftCaret 	=  0;		{ Place caret for left block.	}
	smRightCaret	= -1;		{ Place caret for right block.	}
	smHilite		=  1;		{ Direction is TESysJust.	}
	
	{ Transliterate target types. }
	
	smTransAscii	= 0;
	smTransNative	= 1;
	
	{ Transliterate target modifiers. }
	
	smTransLower	= $4000;
	smTransUpper	= $8000;
	
	{ Transliterate tource masks. }
	
	smMaskAscii 	= $0001;	{ 2 ^ IUTransAscii		}
	smMaskNative	= $0002;	{ 2 ^ IUTransNative 	}
	
	{ Result values from GetEnvirons, SetEnvirons, GetScript and SetScript calls. }
	
	smBadVerb		= -1;		{ Unknown verb. 		}
	smBadScript 	= -2;		{ Unknown script number.	}

	smNotInstalled	= 0;		{ routine not available in script }

	{ GetEnvirons/SetEnvirons verbs. }
	
	smVersion		=  0;		{ Script Manager version.	}
	smMunged		=  2;		{ Script globals changed count. }
	smEnabled		=  4;		{ Script Manager enabled flag.	}
	smBidirect		=  6;		{ At least on bidirect script.	}

	smFontForce 	=  8;		{ Force font flag.		}
	smIntlForce 	= 10;		{ Force intl flag.		}
	smForced		= 12;		{ Script forced to sysetem. }
	smDefault		= 14;		{ Script defaulted to Roman.	}
	
	smPrint 		= 16;		{ Printer action routine.	}
	
	smSysScript 	= 18;		{ System script.		}
	smLastScript	= 20;		{ Last keyboard script. 	}
	smKeyScript 	= 22;		{ Keyboard script.		}
	
	smSysRef		= 24;		{ System folder refNum. 	}
	smKeyCache		= 26;		{ Keyboard character cache. }
	smKeySwap		= 28;		{ Swapping table handle.	}
	
	{ GetScript/SetScript verbs. }
	
	smScriptVersion =  0;		{ Script software version.	}
	smScriptMunged	=  2;		{ Script entry changed count.	}
	smScriptEnabled =  4;		{ Script enabled flag.		}
	smScriptRight	=  6;		{ Right to left flag.		}
	smScriptJust	=  8;		{ Justification flag.		}
	smScriptRedraw	= 10;		{ Word redraw flag. 	}
	
	smScriptSysFond = 12;		{ Preferred system font.	}
	smScriptAppFond = 14;		{ Preferred Application font.	}
	
	smScriptBundle	= 16;		{ Beginning of bundle verbs.	}
	smScriptNumber	= 16;		{ Script itl0 id number.	}
	smScriptDate	= 18;		{ Script itl1 id number.	}
	smScriptSort	= 20;		{ Script itl2 id number.	}
	smScriptRsvd1	= 22;		{ Reserved. 		}
	smScriptRsvd2	= 24;		{ Reserved. 		}
	smScriptRsvd3	= 26;		{ Reserved. 		}
	smScriptRsvd4	= 28;		{ Reserved. 		}
	smScriptRsvd5	= 30;		{ Reserved. 		}
	smScriptKeys	= 32;		{ Script KEYC id number.	}
	smScriptIcon	= 34;		{ Script SICN id number.	}
	
	smScriptPrint	= 36;		{ Script printer action.	}
	smScriptTrap	= 38;		{ Trap entry pointer.		}
	
	smScriptCreator = 40;		{ Script file creator.		}
	smScriptFile	= 42;		{ Script file name. 	}
	smScriptName	= 44;		{ Script name.			}

	{ Bits in the smScriptFlags word }

	smsfIntellCP	=	0;		{ script has intellegent cut & paste	}
	smsfSingByte	=	1;		{ script has only single bytes			}
	smsfNatCase 	=	2;		{ native chars have upper & lower case	}
	smsfContext 	=	3;		{ contextual script (e.g. AIS-based)	}

	{ Roman script constants }

	romanVers		=	1;		{ version number. }
	romanSysFond	=	$3FFF;	{ system font id number. }
	romanAppFond	=	3;		{ application font id number. }

	{ Script Manager font equates. }

	smFondStart 	=	$4000;	{ start from 16K. }
	smFondEnd		=	$C000;	{ past end of range at 48K. }


	{Private constants for INLINE statements}
	
	smPushLong		= $2F3C;
	smTrapWord		= $A8B5;
	smApFontId		= $0984;
	smSysFontSize	= $0BA8;
	smSysFontFam	= $0BA6;
	smTESysJust 	= $0BAC;
	smMoveWord2Stack	= $3EB8;
	smMoveIWord2Stack	= $3EBC;
	smPopStack2Word = $31DF;
	smBneS			= $6600;
	smMBarHeight	= $0BAA;

	emCurVersion	=	$0101;	{ version 1.1 for ExpandMemRec }
	

TYPE
	OffsetTable = ARRAY [0..5] of INTEGER;
	BreakTable	= RECORD
				charTypes:		ARRAY [0..255] OF SignedByte;
				tripleLength:	INTEGER;
				triples:		ARRAY [0..0] OF INTEGER;
			end; {BreakTable}
	BreakTablePtr	= ^BreakTable;


{ Bundle declarations }

	ItlcRecord	= RECORD		{ international configuration resource (type itlc)}
				itlcSystem: 	INTEGER;		{ default system script. }
				itlcReserved:	INTEGER;		{ reserved }
				itlcFontForce:	SignedByte; 	{ default font force flag. }
				itlcIntlForce:	SignedByte; 	{ default intl force flag. }
			end;

	ItlbRecord	= RECORD		{ international bundle resource (type itlb)}
				itlbNumber: 	INTEGER;		{ ITL0 id number. }
				itlbDate:		INTEGER;		{ ITL1 id number. }
				itlbSort:		INTEGER;		{ ITL2 id number. }
				itlbReserved1:	INTEGER;		{ reserved. }
				itlbReserved2:	INTEGER;		{ reserved. }
				itlbReserved3:	INTEGER;		{ reserved. }
				itlbLang:		INTEGER;		{ cur language for script }
				itlbNumRep: 	SignedByte; 	{ number representation code }
				itlbDateRep:	SignedByte; 	{ date representation code }
				itlbKeys:		INTEGER;		{ KCHR id number. }
				itlbIcon:		INTEGER;		{ SICN id number. }
			end;


FUNCTION FontScript: INTEGER;
	INLINE smPushLong, $8200, $0000, smTrapWord;

FUNCTION IntlScript: INTEGER;
	INLINE smPushLong, $8200, $0002, smTrapWord;

PROCEDURE KeyScript(code: INTEGER);
	INLINE smPushLong, $8002, $0004, smTrapWord;

FUNCTION Font2Script(fontNumber: INTEGER): INTEGER;
	INLINE smPushLong, $8202, $0006, smTrapWord;
	
FUNCTION GetEnvirons(verb: INTEGER): LONGINT;
	INLINE smPushLong, $8402, $0008, smTrapWord;

FUNCTION SetEnvirons(verb: INTEGER; param: LONGINT): OSErr;
	INLINE smPushLong, $8206, $000A, smTrapWord;

FUNCTION GetScript(script, verb: INTEGER): LONGINT;
	INLINE smPushLong, $8404, $000C, smTrapWord;

FUNCTION SetScript(script,verb: INTEGER; param: LONGINT): OSErr;
	INLINE smPushLong, $8208, $000E, smTrapWord;

FUNCTION CharByte(textBuf: Ptr; textOffset: INTEGER): INTEGER;
	INLINE smPushLong, $8206, $0010, smTrapWord;

FUNCTION CharType(textBuf: Ptr; textOffset: INTEGER): INTEGER;
	INLINE smPushLong, $8206, $0012, smTrapWord;

FUNCTION Pixel2Char(textBuf: Ptr; textLen,slop,pixelWidth: INTEGER;
	Var leftSide: Boolean): INTEGER;
	INLINE smPushLong, $820E, $0014, smTrapWord;

FUNCTION Char2Pixel(textBuf: Ptr; textLen,slop,offset: INTEGER;
	direction: INTEGER): INTEGER;
	INLINE smPushLong, $820C, $0016, smTrapWord;

FUNCTION Transliterate(srcHandle,dstHandle: Handle; target: INTEGER;
	srcMask: LONGINT): OSErr;
	INLINE smPushLong, $820E, $0018, smTrapWord;

PROCEDURE FindWord(textPtr: Ptr; textLength, offset: INTEGER; leftSide: Boolean;
	breaks: BreakTablePtr; Var offsets: OffsetTable);
	INLINE smPushLong, $8012, $001A, smTrapWord;

PROCEDURE HiliteText(textPtr: Ptr; textLength, firstOffset, secondOffset: INTEGER;
	Var offsets: OffsetTable);
	INLINE smPushLong, $800E, $001C, smTrapWord;

PROCEDURE DrawJust(textPtr: Ptr; textLength, slop: INTEGER);
	INLINE smPushLong, $8008, $001E, smTrapWord;

PROCEDURE MeasureJust(textPtr: Ptr; textLength, slop: INTEGER; charLocs: Ptr);
	INLINE smPushLong, $800C, $0020, smTrapWord;

FUNCTION ParseTable(tablePtr: Ptr): Boolean;
	INLINE smPushLong, $8204, $0022, smTrapWord;

FUNCTION GetDefFontSize: INTEGER;
INLINE smMoveWord2Stack, smSysFontSize, smBneS+4, smMoveIWord2Stack, $000C;

FUNCTION GetSysFont: INTEGER;
INLINE smMoveWord2Stack, smSysFontFam;

FUNCTION GetAppFont: INTEGER;
INLINE smMoveWord2Stack, smApFontId;

FUNCTION GetMBarHeight: INTEGER;
INLINE smMoveWord2Stack, smMBarHeight;

FUNCTION GetSysJust: INTEGER;
INLINE smMoveWord2Stack, smTESysJust;

PROCEDURE SetSysJust (newJust: INTEGER);
INLINE smPopStack2Word, smTESysJust;


END {Script}.

