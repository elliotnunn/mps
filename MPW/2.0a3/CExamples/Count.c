/*------------------------------------------------------------------------------

NAME
	 Count -- count lines and characters

SYNOPSIS
	 Count [-l] [-c] [file…]

DESCRIPTION
	 "Count" counts the lines and characters in its input, and writes the
	 counts to standard output.  If no files are specified standard input is
	 read.	If more than one file is specified, separate counts are written
	 for each file, one per line, preceeded by the file name.  A total is also
	 written following the list of files.

COPYRIGHT
	 Copyright Apple Computer, Inc. 1985-1987
	 All rights reserved.


------------------------------------------------------------------------------*/

#include	<types.h>
#include	<stdio.h>


/* External variables/procedures */

extern	char			*GetSysErrText(errNbr, errMsg);
extern	short			MacOSErr;
extern	pascal	void	RotateCursor(tick)
							long tick; extern;
extern	pascal	void	InitCursorCtl(acurHandle)
							Handle acurHandle; extern;

/* Variables local to this file */

static	char	*usage = "# Usage - %s [-l] [-c] [files…].\n";
static	Boolean	optionsSpecified;
static	Boolean	lineOption;
static	Boolean	charOption;
static	char	errorBuffer[256];		/* space to store text from GetSysErrText */


struct counts {
	long	lines;
	long	characters;
};


main(argc,argv)
	int		argc;
	char	*argv[];
{
	long			status;
	long			parms;
	long			files;
	long			done;
	long			length;
	long			max;
	FILE			*input;
	struct	counts	cnts;
	struct	counts	total;
	struct	counts	count();
	void			print();

	status = files = 0;
	max = strlen("Total");
	optionsSpecified = lineOption = charOption = false;
	InitCursorCtl(nil);

	for (parms = 1; parms < argc; parms++) {
		length = strlen(argv[parms]);
		if (*argv[parms] != '-') {
			argv[++files] = argv[parms];
			if (max < length)
				max = length;
		} else if (tolower(*(argv[parms]+1)) == 'c' && length == 2) {
			optionsSpecified = charOption = true;
		} else if (tolower(*(argv[parms]+1)) == 'l' && length == 2) {
			optionsSpecified = lineOption = true;
		} else {
			fprintf(stderr,"### %s - \"%s\" is not an option.\n", argv[0], argv[parms]);
			fprintf(stderr, usage, argv[0]);
			return(1);
		}
	}
	if (files == 0) {
		cnts = count(stdin);
		print(files, max, NULL, cnts);
	} else {
		total.lines = total.characters = done = 0;
		for (parms = 1; parms <= files; parms++) {
			if ((input = fopen(argv[parms],"r")) != NULL) {
				cnts = count(input);
				fclose(input);
				total.lines += cnts.lines;
				total.characters += cnts.characters;
				print(files, max, argv[parms], cnts);
				done++;
			} else {
				fprintf(stderr,"### %s - Unable to open file %s.\n",argv[0],argv[parms]);
				fprintf(stderr,"# %s\n",GetSysErrText(MacOSErr,errorBuffer));
				status = 2;
			}
		}
		if (done > 1)
			print(files,max,"Total",total);
	}
	return status;
}


struct counts count(input)
	FILE *input;
{
	long			c;
	long			c1;
	struct	counts	cnts;
	
	cnts.lines = cnts.characters = 0;
	while ((c = getc(input)) != EOF) {
		c1 = c;
		cnts.characters++;
		if (c == '\n') {
			RotateCursor(cnts.lines++);
		}
	}
	if (cnts.characters > 0 && c1 != '\n')
		cnts.lines++;

	return cnts;
}


void print(files, max, name, cnts)
	long			files;
	long			max;
	char			*name;
	struct	counts	cnts;
{
	long space;
	
	space = 0;
	if (files > 1) {
		fprintf(stdout,"%s ",name);
		space = max - strlen(name);
	}
	if (optionsSpecified == false || lineOption == true) {
		fprintf(stdout,"%*d ", space+5, cnts.lines);
		space = 0;
	}
	if (optionsSpecified == false || charOption == true) {
		fprintf(stdout,"%*d ", space+7, cnts.characters);
	}
	fprintf(stdout, "\n");
	fflush(stdout);
}



