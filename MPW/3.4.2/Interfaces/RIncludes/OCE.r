/************************************************************

Created: Tuesday, August 17, 1993 4:37:24 PM
 OCE.r
 Types definitions for Rez and DeRez.

  Copyright Apple Computer, Inc. 1990-1993
  All rights reserved

************************************************************/


#ifndef __OCE_R__
#define __OCE_R__

#ifndef __OCE__
#include "OCE.h"
#endif
#ifndef __OCETEMPLATES__
#include "OCETemplates.h"
#endif


/**********************************************************************************************/
/********************************* Template Resource Formats: *********************************/
/**********************************************************************************************/

/* OCE template file type: 'detf' */


/* ************************************ RString */

#define rstring integer = 0; wstring

type 'rstr' {
	rstring;	/* an RString */
};


/* ************************************ RString List */

type 'rst#' {
	integer = (endOfData - startOfData) / 8;
startOfData:
	integer = $$CountOf(RStrArray); 	/* Array size */
	array RStrArray {
		rstring;
		align word;
	};
endOfData:
};


/* ************************************ Number */

type 'detn' {
	longInt;
};


/* ************************************ Aspect Template */

type 'deta' {
	longInt = kDETInfoPageVersion;					/* Template format version */
	longInt;										/* Drop operation priority (ordering for drop operation with multiple possible) */
	boolean dropCheckConflicts, dropCheckAlways;	/* Whether to check with the user if we're the only valid drop destination */
	boolean notMainAspect, isMainAspect;			/* Whether this is a main aspect for this type */
	align word;										/* Future expansion */
};


/* ************************************ Custom Window Definition (should not be used for normal info-pages) */
type 'detw' {
	rect;									/* Info-page window;
												top == 0 for standard placement;
												top == -1 for center on screen;
												otherwise absolute position */
	boolean discludePopup, includePopup;	/* Whether to include a page-selection pop-up */
	align word;								/* Future expansion */
};


/* ************************************ Attribute Pattern Table */

type 'dett' {
	integer = $$CountOf(AttributeArray);		/* Attribute array size */
	array AttributeArray {
		integer = $$CountOf(TypeArray);			/* Attribute type array size */
		array TypeArray {
			rstring[32];						/* Attribute type */
		};
		longInt;								/* Attribute tag */
		boolean notForInput, useForInput;		/* Whether to use this pattern for input processing */
		boolean notForOutput, useForOutput;		/* Whether to use this pattern for output processing */
		boolean notInSublist, useInSublist;		/* Whether to include this attribute type in the sublist */
		boolean isNotAlias, isAlias;			/* Whether to mark this attribute value as an alias */
		boolean isNotRecordRef, isRecordRef;	/* Whether to mark this attribute value as a record reference */
		align word;								/* Future expansion */
		integer = $$CountOf(PatternArray);		/* Pattern array size */
		array PatternArray {
			longint;							/* Pattern element type */
			integer;							/* Property number */
			integer;							/* Extra (sometimes property #, sometimes resource ID, sometimes...) */
		};
	};
};

/* Pattern element types (pattern elements consist of a <type>, a <property>, and an <extra>):

		Element Type	Property Type	Format
		------------	-------------	------
		   '(((('		   Binary		Everything specified by the elements up to a '))))'
		   '))))'		   None			Ends a '((((' block

		   'byte'		   Number		One byte
		   'word'		   Number		Two bytes
		   'long'		   Number		Four bytes
		   'bbit'		   Number		One bit
		   'blok'		   Binary		<Extra> field is a size; a block <extra> bytes in size
		   'rest'		   Binary		The rest of the attribute

		   'bsiz'		   Binary		Binary field starting with byte-size length (property doesn't include length)
		   'wsiz'		   Binary		Binary field starting with word-size length (property doesn't include length)
		   'lsiz'		   Binary		Binary field starting with long-size length (property doesn't include length)

		   'rstr'		   RString		An RString (two byte script, two byte length, data)
		   'pstr'		   RString		A Pascal string (length byte, data)
		   'wstr'		   RString		A word length followed by the string data bytes
		   'cstr'		   RString		A C string (null byte terminated)

		   'type'		   RString		A four-character type (long can also be used if you want it as a number)

		   'abyt'		   None			Align to next even byte in attribute
		   'awrd'		   None			Align to next even word in attribute
		   'alng'		   None			Align to next even long in attribute

		   'padz'		   None			<Extra> field is a size; process the next pattern element; then zero-fill so
										that the total length is the size specified by <extra>

		   'p:=p'		   None			Set one property from another (extra field is the source property)

		   'equa'		   None			If property <property> == property <extra> process next element; otherwise skip it
		   'nteq'		   None			If property <property> != property <extra> process next element; otherwise skip it
		   'less'		   None			If property <property> <  property <extra> process next element; otherwise skip it
		   'grea'		   None			If property <property> >  property <extra> process next element; otherwise skip it
		   'leeq'		   None			If property <property> <= property <extra> process next element; otherwise skip it
		   'greq'		   None			If property <property> >= property <extra> process next element; otherwise skip it

		   'abrt'		   None			Abort pattern processing

		   'prop'		   Any			Declare a property number that this pattern works with; this allows template-specified
										pattern elements which reference property numbers other than those in the property field

		   'btyp'		   None			<Extra> contains a property type, which is used on all subsequent block elements
										('((((', 'blok', 'rest', 'bsiz', 'wsiz', 'lsiz')
		   'styp'		   Any			Set the type of the specified <property> to type <extra>

	Any pattern element types starting with upper-case letters are passed on to the template code resource. */


/* ************************************ Info-page Template */

type 'deti' {
	longInt = kDETInfoPageVersion;				/* Template format version */
	longInt;									/* Sort order */
	rect;										/* Rectangle to put sublist in */
	boolean selectFirstText, noSelectFirstText;	/* Whether to select the first text field when info-page opens */
	align word;									/* Future expansion */
	integer = $$CountOf(HeaderViewArray);
	array HeaderViewArray {						/* The header view lists */
		integer;									/* Property 1 */
		integer;									/* Property 2 */
		integer;									/* 'detv' ID */
	};
	integer = $$CountOf(SubviewViewArray);
	array SubviewViewArray {					/* The subview view lists */
		integer;									/* Property 1 */
		integer;									/* Property 2 */
		integer;									/* 'detv' ID */
	};
};


/* ************************************ View */

type 'detv' {
	/* this will all be taken out in a later revision (probably): */
	longint = 0;
	longint = 0;
	longint = 0;
	integer = 0;
	longint = 0;
	longint = 0;
	longint = 0;
	longint = 0;
	integer = 0;
	longint = 0;
	longint = 0;

	integer = $$CountOf(ItemArray);				/* count */
	array ItemArray {
		rect;									/* bounds */
		longint = 0;							/* position	flags (autoset by DE) */
		longint;								/* flags */
		integer;								/* property (prName, prKind, etc…) */
		switch {								/* class */
			case StaticTextFromView:
				key longint = 7750;
				integer;						/* font */
				integer;						/* fontSize */
				integer;						/* justification */
				integer;						/* style */
				pstring;						/* title */

			case StaticCommandTextFromView:
				key longint = 22250;
				integer;						/* font */
				integer;						/* fontSize */
				integer;						/* justification */
				integer;						/* style */
				pstring;						/* title */
				align word;						/* align it */
				longint;						/* command */
				integer;						/* value */

			case StaticText:
				key longint = 3250;				/* class id */
				integer;						/* font */
				integer;						/* fontSize */
				integer;						/* justification */
				integer;						/* style */

			case EditText:
				key longint = 8250;				/* class id */
				integer;						/* font */
				integer;						/* fontSize */
				integer;						/* justification */
				integer;						/* style */

			case Bitmap:
				key longint = 6250;
				integer;						/* size */

			case Box:
				key longint = 4750;
				integer;						/* box attributes */

			case DefaultButton:
				key longint = 7250;
				integer;						/* font */
				integer;						/* fontSize */
				integer;						/* justification */
				integer;						/* style */
				pstring;						/* title */
				align word;						/* align it */
				longint;						/* command */

			case Button:
				key longint = 21000;
				integer;						/* font */
				integer;						/* fontSize */
				integer;						/* justification */
				integer;						/* style */
				pstring;						/* title */
				align word;						/* align it */
				longint;						/* command */

			case CheckBox:
				key longint = 21250;
				integer;						/* font */
				integer;						/* fontSize */
				integer;						/* justification */
				integer;						/* style */
				pstring;						/* title */
				align word;						/* align it */
				longint;						/* command */

			case RadioButton:
				key longint = 21500;
				integer;						/* font */
				integer;						/* fontSize */
				integer;						/* justification */
				integer;						/* style */
				pstring;						/* title */
				align word;						/* align it */
				longint;						/* command */
				integer;						/* value */

			case Menu:
				key longint = 5750;
				integer;						/* font */
				integer;						/* fontSize */
				integer;						/* justification */
				integer;						/* style */
				pstring;						/* title */
				align word;						/* align it */
				longint;						/* command */
				integer;						/* menu ResID */

			case EditPicture:
				key longint = 0x00010000+24250;
				integer;						// maximum pixel depth

			case Custom:
				key longint = 6750;
				integer;						/* user reference */
		};
		align word;
	};
};


/* ************************************ Menu */

type 'fmnu' {
	integer = false;					/* Auto-initialize flag */
	integer = $$CountOf(ItemArray)+1;	/* Number of items */

	/* The following is the first item in the array, which is preset. */
	longint;							/* Resource id of this resource */
	integer = (1 << 0)+(1 << 7);		/* Item flags */
	string[1] = "";						/* Key equivalent */
	align word;
	pstring = "";						/* Menu title */
	align word;

	/* The menu item array: */
	array ItemArray {
		longint;						/* Command ID */
		integer = (1 << 0)+(1 << 13)+(1 << 15); /* Item flags */
		string[1] = "";					/* Key equivalent (not allowed for templates) */
		align word;
		pstring;						/* Menu title */
		align word;
	};
};

/* ************************************ Custom Menu */

type 'detm' as 'fmnu';


/* ************************************ Property Table */

type 'detp' {
	integer = $$CountOf(SortArray);		/* Number of items */
	array SortArray {
		integer;						/* Property number */
	};
};


/* ************************************ Killer Template */

type 'detk' {
	longInt = kDETKillerVersion;		/* Template format version */
};


/* ************************************ Forwarder Template */

type 'detf' {
	longInt = kDETForwarderVersion;		/* Template format version */
};


/* ************************************ File Type Template */

type 'detx' {
	longInt = kDETFileTypeVersion;		/* Template format version */
	integer = $$CountOf(ItemArray);		/* Count */
	array ItemArray {
		longInt;						/* Type of additional file */
	};
};


/*************************************************************************************************/
/********************************* Collab Pack Resource Formats: *********************************/
/*************************************************************************************************/

/* ************************************ Panel */

type 'panl' {
	rect;													/* Bounds				*/
	byte			invisible, visible; 					/* visible				*/
	byte			disabled, enabled;						/* enabled				*/
	longint;												/* Enum Flags			*/
	integer;												/* MatchTypeHow			*/
	longint;												/* RefCon				*/
	integer = $$CountOf(TypeIdArray);						/* Nbr of types			*/
	array TypeIdArray {
	   integer;                      						/* 'rtyp' resource id for a type */
	};
};

/* Values for MatchTypeHow: */
#define kMatchAll	0
#define kExactMatch	1
#define kBeginsWith	2
#define kEndsWith	3
#define kContains	4


/* ************************************ Find */

type 'find' {
	pstring;				/* "Find" text */
	align word;
	pstring;				/* "Search" text */
	align word;

	array [5] {
		integer		sysFont, appFont, portFont;
		integer;				/* face */
		integer;				/* size */
		rect;					/* bounds */
	};

};


/* ************************************ SAM */

type 'sami' {
	integer;								/* Max number of catalogs/slots */
	longint;								/* catalog signature, MSAM type */
	byte notMSAM, servesMSAM;				/* An MSAM template? */
	byte notDSAM, servesDSAM;				/* A CSAM template? */
	rstring;								/* Displayed to user when user clicks the Add… button */
	align word;
	rstring;								/* New Record Name */
	align word;
};


/* ************************************ Admin */

/* Goes in 'deta' and 'deti' templates, at base ID */

type 'admn' {
	integer = kDETAdminVersion;				/* version */
	longint = 0;							/* reserved */
	longint = 0;							/* reserved */
};


#endif
