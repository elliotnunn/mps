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
	 Copyright Apple Computer, Inc. 1985, 1986
	 All rights reserved.


------------------------------------------------------------------------------*/


#include <stdio.h>

extern char *GetSysErrText(errNbr,errMsg);
pascal void RotateCursor(tick)
   short tick;
   extern;

extern short MacOSErr;
static char errorBuffer[256];

#define False 0
#define True  1


static char *Usage = "# Usage - %s [-l] [-c] [files…].\n";
static long options, lineOption, charOption;

struct counts {
   long lines;
   long characters;
   };

struct counts count(input)
   FILE *input;

   {
   long c,c1;
   struct counts cnts;
   short lines;

   cnts.lines = cnts.characters = 0;
   while ((c = getc(input)) != EOF) {
	 c1 = c;
	 cnts.characters++;
	 if (c == '\n') {
	   lines = cnts.lines++;
	   RotateCursor(lines);
	   }
	 }
   if (cnts.characters > 0 && c1 != '\n') cnts.lines++;
   return(cnts);
   }


print(files,max,name,cnts)
   long files;
   long max;
   char *name;
   struct counts cnts;

   {
   long space;

   space = 0;
   if (files > 1) {
	 fprintf(stdout,"%s ",name);
	 space = max - strlen(name);
	 }
   if (options == False || lineOption == True) {
	 fprintf(stdout,"%*d ",space+5,cnts.lines);
	 space = 0;
	 }
   if (options == False || charOption == True) {
	 fprintf(stdout,"%*d ",space+7,cnts.characters);
	 }
   fprintf(stdout,"\n");
   fflush(stdout);
   }



main(argc,argv)
   int argc;
   char *argv[];

   {
   long status;
   long parms, files, done;
   long length, max;
   struct counts cnts, total;
   FILE *input;

   status = 0;
   files = 0;
   max = strlen("Total");
   options = lineOption = charOption = False;
   for (parms = 1; parms < argc; parms++) {
	  length = strlen(argv[parms]);
	  if (*argv[parms] != '-') {
		 argv[++files] = argv[parms];
		 if (max < length) max = length;
		 }
	  else if (tolower(*(argv[parms]+1)) == 'c' && length == 2) {
		 options = charOption = True;
		 }
	  else if (tolower(*(argv[parms]+1)) == 'l' && length == 2) {
		 options = lineOption = True;
		 }
	  else {
		 fprintf(stderr,"### %s - \"%s\" is not an option.\n",argv[0],argv[parms]);
		 fprintf(stderr,Usage,argv[0]);
		 return(1);
		 }
	  }
   if (files == 0) {
	  cnts = count(stdin);
	  print(files,max,NULL,cnts);
	  }
   else {
	  total.lines = total.characters = done = 0;
	  for (parms = 1; parms <= files; parms++) {
		 if ((input = fopen(argv[parms],"r")) != NULL) {
			cnts = count(input);
			fclose(input);
			total.lines += cnts.lines;
			total.characters += cnts.characters;
			print(files,max,argv[parms],cnts);
			done++;
			}
		 else {
			fprintf(stderr,"### %s - Unable to open file %s.\n",argv[0],argv[parms]);
			fprintf(stderr,"# %s\n",GetSysErrText(MacOSErr,errorBuffer));
			status = 2;
			}
		 }
	  if (done > 1) {
		 print(files,max,"Total",total);
		 }
	  }
   return(status);
   }
