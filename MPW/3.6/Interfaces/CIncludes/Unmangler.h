/*---------------------------------------------------------------------------*
 |                                                                           |
 |                            <<< Unmangler.h >>>                            |
 |                                                                           |
 |                         C++ Function Name Decoding                        |
 |                                                                           |
 |        Copyright Apple Computer, Inc. 1988-1991, 1995, 1999-2000          |
 |                           All rights reserved.                            |
 |                                                                           |
 *---------------------------------------------------------------------------*/

#ifndef __UNMANGLER__
#define __UNMANGLER__

#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

int unmangle(char *dst, char *src, int limit);
	/*
	This function unmangles C++ mangled symbols (i.e. a symbol with a type signature).  The
	mangled C string is passed in src and the unmangled C string is returned in dst.  Up to
	limit characters (not including terminating null) may be returned in dst.
	
	The function returns,
	
		 -1 ==> error, probably because symbol was not mangled, but looked like it was
			0 ==> symbol wasn't mangled; not copied either
			1 ==> symbol was mangled; unmangled result fit in buffer
			2 ==> symbol was mangled; unmangled result truncated to fit in buffer (null written)
 
	Caution: the src and dst string must not overlap!
	*/


#if __MRC__ || __SC__ || __MWERKS__
pascal int Unmangle(char *dst, char *src, int limit);
	/*
	This is identical to unmangle (above) except that this routine is provided for Pascal.
	The src string is assumed to be a Pascal string and the returned string is a Pascal
	string.
	*/
#endif


char *unmangle_ident(char *pchIdent);
	/*
	This routine acts as "glue code" or a cover routine to map Symantec's standard unmangler
	calling conventions into Apple's.  This routine accepts a mangled C++ name as a C string
	and returns a pointer to the malloc'ed unmangled name.  NULL is returned if no unmangling
	was done (due to an error or truncation).
	
  Note, it is assumed the buffer malloc'ed here should be freed by the caller.  Also, the
  maximum unmangled string returned is 1023 characters.
	*/


char *unmangle_pt(char **pt);
	/*
	This routine takes a pointer (*pt) to a mangled parameterized type (template) (i.e., the
	mangled strings starts with "__PT" or "__pt") and returns a pointer to the malloc'ed
	unmangled string.  *pt is updated to point to the first character in the string that
	follows the mangled template string (i.e., the one that stopped the parse).
	 
	Note, it is assumed the buffer malloc'ed here should be freed by the caller.  Also this
	routine is generally only used for special internal purposes like the Symantec and MrC[pp]
	compilers.  The maximum unmangled string returned is 1023 characters.
	*/


int unmangle_pt_length(char **pt);
	/*
	This routine takes a pointer (*pt) to a mangled parameterized type (template) (i.e., the
	mangled strings starts with "__PT" or "__pt") and returns the length of the mangled
	encoding for the template and its arguments.  0 is returned if there are any errors. *pt
	is updated to point to the first character in the string that follows the mangled
	template string (i.e., the one that stopped the parse).
	 
	The maximum unmangled string allowed is 1023 characters.
	
	This routine is used only to scan mangled strings to process the "__pt" mangling for
	possible abbreviated replacement (__ptTi & __ptNi).  We are not interested in the
	unmangled string here.  But we do need to actually do the unmangling since that's the
	way we pick apart the parameters (i.e., there is no separate routine to walk through
	the parameters without doing anything).
	*/


void MWUnmangle(const char *mangled_name, char *unmangled_name, size_t buffersize);
	/*
	This routine acts as "glue code" or a cover routine to map MetroWerks standard unmangler
	calling conventions into Apple's.  This routine accepts a C++ mangled_name as a C string
	and returns the unmangled name in unmangled_name.  If there are any errors, the 
	unmangled_name is simply copied into the mangled_name.  Up to buffersize characters
	(including a delimiting null) are copied to the mangled_name.  Truncation of the mangled
	name is considered an error.
	*/
	

#ifdef __cplusplus
}
#endif
#endif