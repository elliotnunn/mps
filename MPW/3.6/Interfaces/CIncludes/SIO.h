/*------------------------------------------------------------------------------
#	SIO.h
#	Simple Input/Output 
#	Apple Copyright 1996, 1999
#
#	This library permits users to write SIOW-like applications. Supply your
#	own functions to handle standard input and ouput from C or C++.
#
#-----------------------------------------------------------------------------*/

#ifndef __SIO__
#define __SIO__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

enum
{
	kSIOStdOutNum = 1,
	kSIOStdErrNum = 2
};

/* If your code has static c++ objects whose constructors invoke i/o, then 			*/
/* these functions may be invoked before main() is entered. 						*/

extern pascal void (*__sioInit)( int * mainArgc, char *** mainArgv );
	/* Assign a pointer to your function to the variable __sioInit in order 		*/
	/* to be able to program initialization before main() begins. This permits 		*/
	/* calling MacOS initialization functions and setting up windows, arguments 	*/
	/* to main(), etc. 																*/
	/* mainArgc is a pointer to the int argc value passed into main(). You may		*/
	/* assign to int values to *mainArgc.											*/
	/* mainArgv is a pointer to a pointer to an array of char-pointers. You may 	*/
	/* allocate an array of char-pointers using NewPtr() and assign that to 		*/
	/* *mainArgv.																	*/

extern pascal void (*__sioRead)(	char 	* buffer, 
									SInt32 	nCharsDesired, 
									SInt32 	* nCharsUsed, 
									SInt16 	* eofFlag );
	/* Assign a pointer to your function to the variable __sioRead in order 		*/
	/* handle read-requests for stdin. 												*/
	/* buffer is a character array of size nChars. Your should fill it with 		*/
	/* characters until the user hit carriage return or enter, or nChars have 		*/
	/* been gotten.  Carriage return or enter should be represented as the '\n'		*/
	/* character (character code == 13 == 0x0d). 									*/
	/* To indicate end of file, you have two options: set *nCharsUsed to zero and 	*/
	/* *eofFlag to non-zero to immediately signal end of file, OR fill the buffer 	*/
	/* some number of characters, set *nCharsUsed to that number, set *eofFlag to 	*/
	/* non-zero: now the next time read() would be invoked, end of file will be 	*/
	/* indicated and your function will not be called. Once *eofFlag has been 		*/
	/* set, your function will never be called again. 								*/
	/* You may want to implement an event loop here to catch key-strokes for user-	*/
	/* input. Note if your user chooses Quit from the File menu, for example, you	*/
	/* should either return end-of-file or call abort() or exit() to properly shut 	*/
	/* down the application. Calling ExitToShell() will skip calling __sioExit().	*/

extern pascal void (*__sioWrite)( SInt16 filenum, char * buffer, SInt32 nChars );
	/* Assign a pointer to your function to the variable __sioWrite in order 		*/
	/* handle write-requests for stdout (filenum == 1) and stderr (filenum == 2). 	*/

extern pascal void (*__sioExit)( void );
	/* This function is called after main() returns, or if exit() is called, or 	*/
	/* if abort() is called. Note: It is not called if ExitToShell() was called! 	*/
	/* You may want to implement an event loop here to allow the user to save 		*/
	/* output. 																		*/

#ifdef __cplusplus
}
#endif

#endif	// __SIO__
