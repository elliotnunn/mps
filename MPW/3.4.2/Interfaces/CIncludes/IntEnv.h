/********************************************************************

	IntEnv.h
	C Interface to the Macintosh Programmer's Workshop Libraries


	Copyright Apple Computer, Inc. 1995
	All rights reserved
	
 	 Warning:  This interface is NOT a part of the ANSI C standard.
	 		   We do NOT claim to be POSIX compliant.  If you want
			   your code to be portable, don't use this interface.

********************************************************************/


#ifndef __INTENV__
#define __INTENV__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif

#ifndef __ALIASES__
#include <Aliases.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
	#pragma import on
#endif

/* Global Variables */

extern	int	StandAlone;

/* Utility Routines */

OSErr ResolveFolderAliases (
	/* Info in  */	short volume, long directory, StringPtr path, Boolean resolveLeafAlias,
	/* Info out */	FSSpec *theSpec, Boolean *isFolder, Boolean *hadAlias, Boolean *leafIsAlias);
OSErr MakeResolvedFSSpec (short volume, long directory, StringPtr path,
						  FSSpec *theSpec, Boolean *isFolder, Boolean *hadAlias,
						  Boolean *leafIsAlias);
OSErr ResolvePath (char *rawPath, char *resolvedPath, Boolean *isFolder, Boolean *hadAlias);
OSErr MakeResolvedPath (short volume, long directory, StringPtr path, Boolean resolveLeafAlias,
						char *buffer, Boolean *isFolder, Boolean *hadAlias, Boolean *leafIsAlias);

#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
	#pragma import off
#endif

#ifdef __cplusplus
}
#endif

#endif	/* __INTENV__ */
