/* File ScriptTypes.r
 * -----------------------------------------------------------------------------
 *
 * Script Manager and Script System type declarations.
 *
 * Written by Joe Ternasky	July 13, 1986
 *
 * This file contains the resource definitions specific to the 
 * script manager.
 *
 * Copyright Apple Computer, Inc. 1986
 * All Rights Reserved
 *
 * Modification History
 *
 * 13 Jul 86 JDT	First draft.
 * 20 Aug 86 KWK	Modified for trap interface. Fixed ITL1 strings.
 * 21 Aug 86 JDT	Modified for Script Manager.
 * 24 Aug 86 KWK	Added the ITL2 resource id field to rgnb type
 * 28 Aug 86 JDT	Added simple KCHR resource type.
 *  3 Sep 86 JDT	Wet'n'wild reorganization.  Region bundles eliminated.
 *  7 Sep 86 MED	Dropped stuff duplicated in standard types.
 * 11 Sep 86 JDT	Added definition for new keyboard swapping (KSWP) type.
 * 12 Sep 86 JDT	Exchanged key code and modifiers in KSWP type.
 *
 * -----------------------------------------------------------------------------
 */
 
/*------------------------------Equates---------------------------------*/

/* The following are used to set characters in INT0 and ITL1 resources. */

#define periodSymbol		"."
#define	commaSymbol			","
#define	semicolonSymbol		";"
#define	dollarsignSymbol	"$"
#define	slashSymbol			"/"
#define	colonSymbol			":"

/*--------------------------------itlc----------------------------------*/

type 'itlc' {
	unsigned integer;							/* system script code.	*/
	unsigned integer;							/* keyboard cache size.	*/
	byte noFontForce = 0, fontForce = 255;		/* font force flag.		*/
	byte noIntlForce = 0, intlForce = 255;		/* intl force flag.		*/
};

/*--------------------------------itlb----------------------------------*/

type 'itlb' {
	unsigned integer;							/* ITL0 id number.		*/
	unsigned integer;							/* ITL1 id number.		*/
	unsigned integer;							/* INL2 id number.		*/
	unsigned integer;							/* reserved.			*/
	unsigned integer;							/* reserved.			*/
	unsigned integer;							/* reserved.			*/
	unsigned integer;							/* reserved.			*/
	unsigned integer;							/* reserved.			*/
	unsigned integer;							/* KCHR id number.		*/
	unsigned integer;							/* SICN id number.		*/
};

/*--------------------------------itl0----------------------------------*/

type 'itl0' {
	char	period = periodSymbol;				/* decimal pt sep		*/
	char	comma = commaSymbol;				/* thousands sep		*/
	char	semicolon = semicolonSymbol;		/* list sep				*/
	char	dollarsign = dollarsignSymbol;		/* currSym1				*/
	char;										/* currSym2				*/
	char;										/* currSym3				*/

	/* currFmt */
	boolean	noLeadZero, leadingZero;			/* leading unit zero	*/
	boolean	noTrailingZero, trailingZero;		/* trailing dec zero	*/
	boolean	paren, minusSign;					/* negative rep			*/
	boolean	trails, leads;						/* curr sym position	*/
	fill bit[4];								/* not used				*/
	byte monDayYear, dayMonYear, yearMonDay;	/* dateOrder			*/

	/* shrtDateFmt */
	boolean	noCentury, century;					/* century incl			*/
	boolean	noMonthLeadZero, monthLeadZero;		/* mon lead zero		*/
	boolean	noDayLeadZero, dayLeadZero;			/* day lead zero		*/
	fill bit[5];								/* filler				*/
	char	slash = slashSymbol;				/* date sep				*/
	byte	twentyFourHour, twelveHour = 255;	/* timeCycle			*/

	/* timeFmt */
	boolean	noHoursLeadZero, hoursLeadZero;		/* hours lead zero		*/
	boolean	noMinutesLeadZero, minutesLeadZero;	/* min lead zero		*/
	boolean	noSecondsLeadZero, secondsLeadZero;	/* sec lead zero		*/
	fill bit[5];								/* filler				*/
	string[4];									/* mornStr				*/
	string[4];									/* eveStr				*/
	char;										/* timeSep				*/
	char;										/* time1Stuff			*/
	char;										/* time2Stuff			*/
	char;										/* time3Stuff			*/
	char;										/* time4Stuff			*/
	char;										/* time5Stuff			*/
	char;										/* time6Stuff			*/
	char;										/* time7Stuff			*/
	char;										/* time8Stuff			*/
	byte	standard, metric = 255;				/* metricSys			*/
	byte	verUs, verFrance, verBritain,		/* INTL0 country		*/
		verGemany, verItaly, verNetherlands, verBelgiumLux,
		verSweden, verSpain, verDenmark, verPortugal,
		verFrCanada, verNorway, verIsrael, verJapan,
		verAustrailia, verArabia, verFinland, verFrSwiss,
		verGrSwiss, verGreece, verIceland, verMalta,
		verCyprus, verTurkey, verYugoslavia;
	byte;										/* version				*/
};

/*--------------------------------itl1----------------------------------*/

type 'itl1' {						
	/* Day names */
	array [7] {
		pstring[15];							/* Sunday, Monday...	*/					
	};
	
	/* Month names */
	array [12] {
		pstring[15];							/* January, February...	*/						
	};

	byte	dayName, none=255;					/* suppressDay			*/
	byte	dayMonYear, monDayYear = 255;		/* longDate format		*/
	byte	noDayLeadZero,
		dayLeadZero = 255;						/* dayLeading0			*/
	byte;										/* abbrLen				*/
	string[4];									/* st0					*/
	string[4];									/* st1					*/
	string[4];									/* st2					*/
	string[4];									/* st3					*/
	string[4];									/* st4					*/
	byte	verUs, verFrance, verBritain,		/* INTL1 country 		*/
		verGemany, verItaly, verNetherlands, verBelgiumLux,
		verSweden, verSpain, verDenmark, verPortugal,
		verFrCanada, verNorway, verIsrael, verJapan,
		verAustrailia, verArabia, verFinland, verFrSwiss,
		verGrSwiss, verGreece, verIceland, verMalta,
		verCyprus, verTurkey, verYugoslavia;
	byte;										/* version				*/
	hex string;									/* local routine - use	*/
												/* $$Resource to insert	*/
												/* code here.			*/
};

/*--------------------------------KCHR----------------------------------*/

type 'KCHR' {
	unsigned integer;							/* version.				*/
	wide array [128] {
		unsigned hex integer;					/* offset array.		*/
	};
	unsigned integer = $$CountOf(Tables);		/* number of tables.	*/
	array Tables {
		string[128];							/* character table.		*/
	};
	hex string;									/* dead key lists.		*/
};

/*--------------------------------KSWP----------------------------------*/

type 'KSWP' {
	wide array {
		hex integer;							/* script code.			*/
		unsigned binary byte;					/* modifiers.			*/
		unsigned hex byte;						/* virtual key code.	*/
	};
	fill long;
};
