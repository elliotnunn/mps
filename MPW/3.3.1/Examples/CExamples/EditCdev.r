/*------------------------------------------------------------------------------
#
#	Macintosh Developer Technical Support
#
#	EditText Sample Control Panel Device
#
#	EditCdev
#
#	EditCdev.make	-	Make Source
#
#	Copyright © 1988 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	1.0					8/88
#
#	Components:	EditCdev.c			August 1, 1988
#				EditCdev.r			August 1, 1988
#				EditCdev.make		August 1, 1988
#
#	EditCdev is a sample Control Panel device (cdev) that 
#	demonstrates the usage of the edit-related messages.  
#	EditCdev demonstrates how to implement an editText item
#	in a Control Panel Device.  It utilizes the new undo, cut, copy,
#	paste, and delete messages that are sent to cdevs in
#	response to user menu selections.
#
#	It is comprised of two editText items that can be edited 
#	and moved between via the mouse or tab key.
#
------------------------------------------------------------------------------*/


#include "Types.r"
#include "SysTypes.r"

type 'hack' as 'STR ';

resource 'vers' (1) {
	0x01, 0x00, release, 0x00,
	verUS,
	"1.00",
	"1.00, Copyright © 1988 Apple Computer, Inc."
};

type 'nrct' {
	integer = $$CountOf(RectArray);
	array RectArray { rect; };
};

type 'mach' {
	unsigned hex integer;	/* Softmask */
	unsigned hex integer;	/* Hardmask */
};

resource 'hack' (0, purgeable) {
	"Control Panel Device, INIT and CODE by Macintosh Developer Technical Support"
};

resource 'BNDL' (-4064, purgeable) {
	'hack', 0,
	{	'ICN#', {0, -4064},
		'FREF', {0, -4064}
	}
};

resource 'ICN#' (-4064, purgeable) {
	{ /* array: 2 elements */
		/* [1] */
		$"00 00 00 00 00 00 3F E0 00 00 48 10 00 00 44 10"
		$"00 01 83 10 00 02 01 90 00 04 01 90 00 04 01 90"
		$"00 04 01 90 00 04 03 90 00 04 02 90 00 04 02 90"
		$"00 08 02 90 00 08 02 90 00 10 06 90 00 20 0C 90"
		$"03 C0 18 90 04 00 3F 10 0F FF C0 10 08 00 00 10"
		$"08 00 00 10 08 00 00 10 08 00 FF 10 08 00 00 10"
		$"08 00 00 10 08 00 00 10 08 00 00 10 07 FF FF E0"
		$"04 00 00 20 04 00 00 20 04 00 00 20 07 FF FF E0",
		/* [2] */
		$"00 00 00 00 00 00 3F E0 00 00 7F F0 00 00 7F F0"
		$"00 01 FF F0 00 03 FF F0 00 07 FF F0 00 07 FF F0"
		$"00 07 FF F0 00 07 FF F0 00 07 FF F0 00 07 FF F0"
		$"00 0F FF F0 00 0F FF F0 00 1F FF F0 00 3F FF F0"
		$"03 FF FF F0 07 FF FF F0 0F FF FF F0 0F FF FF F0"
		$"0F FF FF F0 0F FF FF F0 0F FF FF F0 0F FF FF F0"
		$"0F FF FF F0 0F FF FF F0 0F FF FF F0 07 FF FF E0"
		$"07 FF FF E0 07 FF FF E0 07 FF FF E0 07 FF FF E0"
	}
};

resource 'DITL' (-4064) {
	{ /* array DITLarray: 1 elements */
		/* [1] */
		{60, 110, 76, 280},
		EditText {
			enabled, ""
		};
		/* [2] */
		{85, 110, 101, 280},
		EditText {
			enabled, ""
		};
		/* [3] */
		{15, 110, 50, 280},
		StaticText {
			disabled, "Apple Macintosh Developer Technical Support TextEdit Control Panel Device Example © 1988"
		}
	}
};

resource 'FREF' (-4064, purgeable) {
	'cdev', 0, ""
};

resource 'nrct' (-4064, purgeable) {
	{	/* array RectArray: 1 elements */
		/* [1] */
		{-1, 87, 130, 322}
	}
};

resource 'mach' (-4064, purgeable) {
	0xFFFF,
	0
};
