/*
	SysTypes.r -- Type Declarations for Rez and DeRez
	
	Copyright Apple Computer, Inc. 1986
	All rights reserved.

	August 22, 1986
*/



/*-------------------------------------Equates------------------------------------------*/
/*	The following are used to set characters used in INTL resources.
*/
#define periodSymbol		"."
#define	commaSymbol		","
#define	semicolonSymbol		";"
#define	dollarsignSymbol	"$"
#define	slashSymbol		"/"
#define	colonSymbol		":"

/*-------------------------------------DRVR---------------------------------------------*/
type 'DRVR' {
	boolean = 0;
	boolean			dontNeedLock, needLock;		/* lock drvr in memory	*/
	boolean			dontNeedTime, needTime;		/* for periodic	action	*/
	boolean			dontNeedGoodbye, needGoodbye;	/* call before heap reinit*/
	boolean			noStatusEnable, statusEnable;	/* responds to status	*/
	boolean			noCtlEnable, ctlEnable;		/* responds to control	*/
	boolean			noWriteEnable, writeEnable;	/* responds to write	*/
	boolean			noReadEnable, readEnable;	/* responds to read	*/
	byte = 0;
	integer;						/* driver delay		*/
	unsigned hex integer;					/* desk acc event mask	*/
	integer;						/* driver menu		*/
	unsigned hex integer;					/* offset to open	*/
	unsigned hex integer;					/* offset to prime	*/
	unsigned hex integer;					/* offset to control	*/
	unsigned hex integer;					/* offset to status	*/
	unsigned hex integer;					/* offset to close	*/
	pstring;						/* driver name		*/
	hex string;						/* driver code		*/
};
/*-------------------------------------FOND---------------------------------------------*/
type 'FOND' {
	unsigned hex integer;					/* flags word		*/
	integer;						/* Family ID number	*/
	integer;						/* first char		*/
	integer;						/* last char		*/
	integer;						/* Ascent		*/
	integer;						/* Descent		*/
	integer;						/* Leading		*/
	integer;						/* Width Max		*/
	unsigned hex longint;					/* Wid tab offset	*/
	unsigned hex longint;					/* Kern tab offset	*/
	unsigned hex longint;					/* Style map offset	*/
	integer;						/* reserved		*/
	integer;						/* ex wid bold		*/
	integer;						/* ex wid italic	*/
	integer;						/* ex wid underline	*/
	integer;						/* ex wid outline	*/
	integer;						/* ex wid shadow	*/
	integer;						/* ex wid condensed	*/
	integer;						/* ex wid extended	*/
	integer;						/* reserved		*/
	longint;						/* reserved for intl	*/
	integer;						/* reserved		*/

	integer = $$CountOf(FontEntries)-1; 			/* # of font entries	*/
	wide array FontEntries {
		integer;					/* Font size		*/
		integer;					/* Font style		*/
		integer;					/* Resource ID		*/
	};
	hex string;						/* tables (variable)	*/
};
/*-------------------------------------FONT---------------------------------------------*/
type 'FONT' {
	unsigned hex integer;					/* Font type		*/
	integer;						/* first char		*/
	integer;						/* last char		*/
	integer;						/* width max		*/
	integer;						/* kern max		*/
	integer;						/* neg descent		*/
	integer;						/* font rect width	*/
	integer;						/* font rect height	*/
	unsigned hex integer;					/* offset to off/wid tab*/
	integer;						/* ascent		*/
	integer;						/* descent		*/
	integer;						/* leading		*/
	integer;						/* row width (in words)	*/
	hex string;						/* tables (variable)	*/
};
/*-------------------------------------FWID---------------------------------------------*/
type 'FWID' {
	unsigned hex integer;					/* Font type		*/
	integer;						/* first char		*/
	integer;						/* last char		*/
	integer;						/* width max		*/
	integer;						/* kern max		*/
	integer;						/* neg descent		*/
	integer;						/* font rect width	*/
	integer;						/* font rect height	*/
	unsigned hex integer;					/* offset to off/wid tab*/
	integer;						/* ascent		*/
	integer;						/* descent		*/
	integer;						/* leading		*/
	integer;						/* row width (in words)	*/
	wide array {						/* offset/width table	*/
		byte;						/* char offset		*/
		byte;						/* char width		*/
	};
};
/*-------------------------------------INTL-Resource ID = 0-----------------------------*/
type 'INTL' (0) {
	char		period = periodSymbol;			/* decimal pt sep	*/
	char		comma = commaSymbol;			/* thousands sep	*/
	char		semicolon = semicolonSymbol;		/* list sep		*/
	char		dollarsign = dollarsignSymbol;		/* currSym1		*/
	char;							/* currSym2		*/
	char;							/* currSym3		*/

	/* currFmt */
	boolean		noLeadZero, leadingZero;		/* leading unit zero	*/
	boolean		noTrailingZero, trailingZero;		/* trailing dec zero	*/
	boolean		paren, minusSign;			/* negative rep		*/
	boolean		trails, leads;				/* curr sym position	*/
	fill bit[4];						/* not used		*/
	byte		monDayYear, dayMonYear, yearMonDay;	/* dateOrder		*/

	/* shrtDateFmt */
	boolean		noCentury, century;			/* century incl		*/
	boolean		noMonthLeadZero, monthLeadZero;		/* mon lead zero	*/
	boolean		noDayLeadZero, dayLeadZero;		/* day lead zero	*/
	fill bit[5];						/* filler		*/
	char		slash = slashSymbol;			/* date sep		*/
	byte		twentyFourHour, twelveHour = 255;	/* timeCycle		*/

	/* timeFmt */
	boolean		noHoursLeadZero, hoursLeadZero;		/* hours lead zero	*/
	boolean		noMinutesLeadZero, minutesLeadZero;	/* min lead zero	*/
	boolean		noSecondsLeadZero, secondsLeadZero;	/* sec lead zero	*/
	fill bit[5];						/* filler		*/
	string[4];						/* mornStr		*/
	string[4];						/* eveStr		*/
	char;							/* timeSep		*/
	char;							/* time1Stuff		*/
	char;							/* time2Stuff		*/
	char;							/* time3Stuff		*/
	char;							/* time4Stuff		*/
	char;							/* time5Stuff		*/
	char;							/* time6Stuff		*/
	char;							/* time7Stuff		*/
	char;							/* time8Stuff		*/
	byte		standard, metric = 255;			/* metricSys		*/
	byte		verUs, verFrance, verBritain, verGemany,/* INTL0 country	*/
			verItaly, verNetherlands, verBelgiumLux,
			verSweden, verSpain, verDenmark, verPortugal,
			verFrCanada, verNorway, verIsrael, verJapan,
			verAustrailia, verArabia, verFinland, verFrSwiss,
			verGrSwiss, verGreece, verIceland, verMalta,
			verCyprus, verTurkey, verYugoslavia;
	byte;							/* version		*/
};
/*-------------------------------------INTL-Resource ID = 1-----------------------------*/
type 'INTL' (1) {			
	/* Day names */
	array [7] {
		pstring[15];					/* Sunday, Monday...	*/					
	};
	
	/* Month names */
	array [12] {
		pstring[15];					/* January, February...	*/						
	};

	byte		dayName, none=255;			/* suppressDay		*/
	byte		dayMonYear, monDayYear = 255;		/* longDate format	*/
	byte		noDayLeadZero, dayLeadZero = 255;	/* dayLeading0		*/
	byte;							/* abbrLen		*/
	string[4];						/* st0			*/
	string[4];						/* st1			*/
	string[4];						/* st2			*/
	string[4];						/* st3			*/
	string[4];						/* st4			*/
	byte		verUs, verFrance, verBritain, verGemany,/* INTL1 country 	*/
			verItaly, verNetherlands, verBelgiumLux,
			verSweden, verSpain, verDenmark, verPortugal,
			verFrCanada, verNorway, verIsrael, verJapan,
			verAustrailia, verArabia, verFinland, verFrSwiss,
			verGrSwiss, verGreece, verIceland, verMalta,
			verCyprus, verTurkey, verYugoslavia;
	byte;							/* version		*/
	hex string	DefaultReturn = "\$4E\$75";		/* local routine - If
								   you have one, use 
								   $$Resource to insert
								   code here.  Otherwise,
								   you must have a 68000
								   return instruction.
								   Use DefaultReturn.	*/
};
/*-------------------------------------NFNT---------------------------------------------*/
type 'NFNT' as 'FONT';
/*-------------------------------------nrct---------------------------------------------*/
type 'nrct' {
	integer = $$CountOf(RectArray);				/* Number of rectangles	*/
	array RectArray {
		rect;
	};
};

/*-------------------------------------ROv#---------------------------------------------*/
type 'ROv#' {
	unsigned hex integer;					/* Version # of ROM	*/
	integer = $$CountOf(typeList) - 1;			/* Number of resources	*/
	wide array typeList {
		literal longint;				/* Resource type	*/
		integer;					/* Resource id		*/
	};
};
/*--------------------------------------------------------------------------------------*/
