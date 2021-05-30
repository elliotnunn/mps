
/************************************************************

    FSpio.h
    FSSpec versions of the standard input and output functions.

    Copyright Apple Computer,Inc.  1997-1999
    All rights reserved

************************************************************/


#ifndef __FSPIO__
#define __FSPIO__

#include <ConditionalMacros.h>
#include <stdio.h>
#include <Files.h>

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT_SUPPORTED
    #pragma import on
#endif

#if !defined(__CFM68K__)
/*
 * Functions similar to those in <stdio.h>
 */
extern int FSp_remove (const FSSpec *spec);

/* For FSp_rename, "newname" must be a leaf name.  The file is renamed "in place". */
extern int   FSp_rename (const FSSpec *spec, const char *newFName);
extern FILE  *FSp_freopen (const FSSpec *spec, const char *mode, FILE *stream);
extern FILE  *FSp_fopen (const FSSpec *spec, const char * open_mode);
extern void  FSp_fsetfileinfo (const FSSpec *spec, unsigned long newcreator, unsigned long newtype);

/*
 * Functions similar to those in <FCntl.h>
 */
extern int FSp_open(const FSSpec *spec, int oflag);
extern int FSp_creat(const FSSpec *spec);
extern int FSp_unlink(const FSSpec *spec);
extern int FSp_faccess(const FSSpec *spec, unsigned int cmd, long *arg);

/*
 * Alias utility functions similar to those in <IntEnv.h>
 */
extern OSErr FSMakeFSSpec_Long(char *source, Str255 nameBuffer, short initvRefNum, int initdirID, FSSpec *result);
extern OSErr FSSpec2Path_Long (FSSpec theSpec, char *path, size_t pathSize);


extern OSErr ResolveFolderAliases_Long (short volume, long directory, char *path, Str255 nameBuffer, Boolean resolveLeafName,
										FSSpec *theSpec, Boolean *isFolder, Boolean *hadAlias, Boolean *leafIsAlias);
extern OSErr MakeResolvedFSSpec_Long (short volume, long directory, char *path, Str255 buffer,
									  FSSpec *theSpec, Boolean *isFolder, Boolean *hadAlias, Boolean *leafIsAlias);
extern OSErr ResolvePath_Long (char *rawPath, char *resolvedPath, Boolean *isFolder, Boolean *hadAlias, size_t resolvedPathSize);
extern OSErr MakeResolvedPath_Long (short volume, long directory, char *path, Boolean resolveLeafAlias, char *buffer,
									Boolean *isFolder, Boolean *hadAlias, Boolean *leafIsAlias,
									size_t bufferSize);
#endif

#if PRAGMA_IMPORT_SUPPORTED
    #pragma import off
#endif

#ifdef __cplusplus
}
#endif



#endif  /* __FSPIO__ */
