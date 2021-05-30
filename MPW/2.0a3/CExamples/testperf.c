/*
 * File TestPerf.c
 *
 * Copyright Apple Computer, Inc. 1985-1987
 * All rights reserved.
 *
 *	This tool demonstrates the use of the performance tools in C.
 */

#include	<Perf.h>
#include	<QuickDraw.h>
#include	<stdio.h>

/* Depending upon which machine this tool will be run on,
   define or undefine the appropriate lines below.
*/
#undef	MacPlus
#define	MacII


void	W5000A();
void	W100();
void	W10000();
void	Waste();
void	W5000B();
void	ROMW5000A();
void	ROMW100();
void	ROMW10000();
void	ROMWaste();
void	ROMW5000B();
	
main ()
{
	short			repeats;				/* a looping variable */
	Boolean			oldState;				/* saved performance state */
	TP2PerfGlobals	ThePGlobals = nil;		/* performance globals */

	/* Initialize the performance globals */
	if (!InitPerf(&ThePGlobals,
			4,			/* ms */
			8,			/* bytes */
			true,		/* measure ROM code */
			true, 		/* measure application code */
			"\004CODE",	/* segments to measure */
#ifdef MacPlus
			255,		/* ROM id */
			"\003ROM",	/* ROM name */
			true,		/* measure RAM */
			0,			/* low RAM address */
			0xFFFFF,	/* high RAM address */
			16			/* RAM bucket size */
#else
#ifdef MacII
			117,		/* ROM id */
			"\004Main",	/* ROM name */
			true,		/* measure RAM */
			0,			/* low RAM address */
			0x1FFFFF,	/* high RAM address (for 2 megabytes) */
			16			/* RAM bucket size */
#endif MacII
#endif MacPlus
		)) {
			fprintf(stderr, "Errors during InitPerf.\n");
				return 1;
	};
	printf("PCOffset = %d  size of globals = %d\n", ThePGlobals->PCOffset, 
						sizeof(TPerfGlobals));
	printf("FirstCode = %d NumMeasure = %d\n", ThePGlobals->firstCode, 
			ThePGlobals->numMeasure);

	oldState = PerfControl(ThePGlobals, true);	/* turn on measurements */

	for (repeats = 5; repeats; repeats--) {
		/* waste some time in user code/MUL4 */
		Waste();
		W100();
		W5000A();
		W5000B();
		W10000();
		/* waste some time in ROM calls: */
		ROMWaste();
		ROMW100();
		ROMW5000A();
		ROMW5000B();
		ROMW10000();
	};
	oldState = PerfControl(ThePGlobals, false);	/* turn off measurements */

	/* Write the performance raw data into a file */
	if (PerfDump (ThePGlobals, "\013Perform.out", true, 80) ) 
		fprintf(stderr, "Errors during dump.\n");

	TermPerf(ThePGlobals);	/* clean up */
}


#define __SEG__ Seg1

void W5000A()
{
	short	i;
	int		junk;
	int		junk1;
	int		junk2;

	for (i = 1; i <= 5000; i++) {
		junk = 1;
		junk1 = junk * 5;
		junk2 = (junk + junk1) * 5;
	};
}; 
		
void W100()
{
	short	i;
	int		junk;
	int		junk1;
	int		junk2;

	for (i = 1; i <= 100; i++) {
		junk = 1;
		junk1 = junk * 5;
		junk2 = (junk + junk1) * 5;
	};
}; 

void W10000()
{
	short	i;
	int		junk;
	int		junk1;
	int		junk2;

	for (i = 1; i <= 10000; i++) {
		junk = 1;
		junk1 = junk * 5;
		junk2 = (junk + junk1) * 5;
	};
}; 

#define __SEG__ SEG2

void Waste()
{
	short	i;
	int		junk;
	int		junk1;
	int		junk2;

	for (i = 1; i <= 1; i++) {
		junk = 1;
		junk1 = junk * 5;
		junk2 = (junk + junk1) * 5;
	};
}; 

void W5000B()
{
	short	i;
	int		junk;
	int		junk1;
	int		junk2;

	for (i = 1; i <= 5000; i++) {
		junk = 1;
		junk1 = junk * 5;
		junk2 = (junk + junk1) * 5;
	};
}; 
		
#define __SEG__ ROMSEG1

void ROMW5000A()
{
	short	i;
	Rect	junk;
	Rect	junk1;
	Rect	junk2;
	Boolean	dontCare;
		
	for (i = 1; i <= 5000; i++) {
		SetRect(&junk, 100, 200, 300, 400);
		SetRect(&junk1, 200, 300, 400, 500);
		dontCare = SectRect(&junk, &junk1, &junk2);
	};
};
		
void ROMW100()
{
	short	i;
	Rect	junk;
	Rect	junk1;
	Rect	junk2;
	Boolean	dontCare;
		
	for (i = 1; i <= 100; i++) {
		SetRect(&junk, 100, 200, 300, 400);
		SetRect(&junk1, 200, 300, 400, 500);
		dontCare = SectRect(&junk, &junk1, &junk2);
	};
};
		
void ROMW10000()
{
	short	i;
	Rect	junk;
	Rect	junk1;
	Rect	junk2;
	Boolean	dontCare;
		
	for (i = 1; i <= 10000; i++) {
		SetRect(&junk, 100, 200, 300, 400);
		SetRect(&junk1, 200, 300, 400, 500);
		dontCare = SectRect(&junk, &junk1, &junk2);
	};
};
		
#define __SEG__ ROMSEG2

void ROMWaste()
{
	short	i;
	Rect	junk;
	Rect	junk1;
	Rect	junk2;
	Boolean	dontCare;
		
	for (i = 1; i <= 1; i++) {
		SetRect(&junk, 100, 200, 300, 400);
		SetRect(&junk1, 200, 300, 400, 500);
		dontCare = SectRect(&junk, &junk1, &junk2);
	};
};
		
void ROMW5000B()
{
	short	i;
	Rect	junk;
	Rect	junk1;
	Rect	junk2;
	Boolean	dontCare;
		
	for (i = 1; i <= 5000; i++) {
		SetRect(&junk, 100, 200, 300, 400);
		SetRect(&junk1, 200, 300, 400, 500);
		dontCare = SectRect(&junk, &junk1, &junk2);
	};
};
