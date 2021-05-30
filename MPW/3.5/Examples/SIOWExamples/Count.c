/*------------------------------------------------------------------------------

NAME
      Count -- count lines and characters


DESCRIPTION
      "Count" counts the lines and characters in its input, and writes the
		counts to standard output.  If more than one file is specified, separate
		counts are written for each file, one per line, followed by the file name. 
		A total is also written following the list of files.
		
COPYRIGHT
      Copyright Apple Computer, Inc. 1985-1994
		All rights reserved.

------------------------------------------------------------------------------*/

#include <Types.h>
#include <ctype.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

enum
{
	kInputSize =	(1024*8),
	kLimitFileNames = 1000
};

/* Variables local to this file */

static	Boolean	optionsSpecified = false;
static	Boolean	lineOption = false;
static	Boolean	charOption = false;

struct counts 
{
	long	lines;
	long	characters;
};
	
static void count( int input, struct counts* cnts )
{
	char					c;
	char					*ptr;
	long					lines = 0;
	long					characters = 0;
	long					charsRead;
	char					inputBuffer[kInputSize + 1];

	while ( ( charsRead = read( input, inputBuffer, kInputSize )) > 0 )
	{
		ptr = inputBuffer;
		inputBuffer[charsRead] = 0;
		characters += charsRead;
		while ( (c = *ptr++) != 0 || ptr <= &inputBuffer[charsRead] )
		{
			if ( c == '\n' ) 
			{
				lines++;
			}
		}
	}	
	if ( characters > 0 && *(ptr-2) != '\n' )
	{
		lines++;
	}
   cnts->lines = lines;
	cnts->characters = characters;
}

static void printTitles( void )
{
	if ( optionsSpecified == false || lineOption == true ) 
	{
		printf( "%7s ", "lines" );
	}
	if (optionsSpecified == false || charOption == true) 
	{
		printf( "%9s ", "chars" );
	}
	printf("filename\n");
}

static void printCnt( char *name, struct counts cnts )
{
	if (optionsSpecified == false || lineOption == true) 
	{
		printf( "%7ld ", cnts.lines );
	}
	if (optionsSpecified == false || charOption == true) 
	{
		printf( "%9ld ", cnts.characters );
	}
	if ( name != NULL )
	{
		printf("%s", name );
	}
	printf( "\n" );
}

int main ( int argc, char* argv[] )
{
	int					input;
	char					request[2048]; /* maximum line length that could be expected from gets() */
	long					lcount = 0;
	long					files = argc - 1;
	char*					fileNames[kLimitFileNames];
	long					done;
	struct	counts	cnts;
	struct	counts	total;
	Boolean				validRequest = false;
	char*					getsval;

	if ( argc <= 1 )
	{
		printf("Note: You can drag text files onto this application's icon in the Finder\n");
		printf("in order to count the lines or characters in those files.\n");
		printf("Make sure Count is not already running when you drag those icons!\n\n");

		printf("Enter filenames, one per line, end with a blank line\n");	

		files = 0;
		do	{
			getsval = gets( request );
			if ( request[0] == '\0' || getsval == NULL ) /* empty string or EOF */
			{
				break;
			}
			else
			{
				fileNames[files] = malloc( strlen(request) + 1 );
				if ( fileNames[files] == NULL )
				{
					break;
				}
				else
				{
					strcpy( fileNames[files], request );
					files++;
				}
			}
		} while ( files < kLimitFileNames );

		if ( files == 0 )
		{
			printf("\ndone\n");
			return -1;
		}
	}
	else
	{
		int i;
		printf("%s\n", argv[0] );
		for ( i = 1; i < argc; i++ )
		{
			fileNames[i-1] = argv[i];
			printf( "    '%s'\n", argv[i] );
		}
	}
	printf("\n");

	printf("Report desired (C[haracters], L[ines], B[oth]:");

	do {
		getsval = gets( request );
		if ( getsval == NULL ) /* EOF */
		{
			validRequest = true;
		}
		else if ( *request == 'c' || *request == 'C' ) 
		{
			optionsSpecified = charOption = true;
			validRequest = true;
		} 
		else if ( *request == 'l' || *request == 'L' ) 
		{
			optionsSpecified = lineOption = true;
			validRequest = true;
		} 
		else if ( *request == 'b' || *request == 'B' ) 
		{
			validRequest = true;
		}
		else 
		{
			printf("expecting C, L, or B, please try again: ");
		}
	} while ( validRequest == false );
	
	printf("\n");
	
	total.lines = total.characters = done = 0;
	
	if ( files >= 1 )
	{
		printTitles();
	}
	for ( lcount = 0; lcount < files; lcount++ )
	{
		input = open( fileNames[lcount], O_RDONLY );

		if ( input >= 0 ) 
		{
			count( input, &cnts );
			close( input );
			total.lines += cnts.lines;
			total.characters += cnts.characters;
			printCnt( fileNames[lcount], cnts );
			done++;
		} 
		else 
		{
			fprintf( stderr, "### - Unable to open file %s.\n", fileNames[lcount] );
		}
	}

	if ( done > 1 ) 
	{
		printCnt( "Total", total );
		printf("%ld files\n", done );
	}

	if ( argc <= 1 ) /* we used malloc in this case */
	{
		int 	i;
		for ( i = 0; i < files; i++ )
		{
			free( fileNames[i] ); /* be nice, clean up heap */
		}
	}

	printf( "\ndone\n" );
	return 0;
}
