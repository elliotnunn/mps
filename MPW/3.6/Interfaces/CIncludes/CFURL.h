/*
     File:       CFURL.h
 
     Contains:   CoreFoundation urls
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __CFURL__
#define __CFURL__

#ifndef __CFBASE__
#include <CFBase.h>
#endif

#ifndef __CFDATA__
#include <CFData.h>
#endif

#ifndef __CFSTRING__
#include <CFString.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif





#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
    #pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
    #pragma pack(2)
#endif

#if PRAGMA_ENUM_ALWAYSINT
    #if defined(__fourbyteints__) && !__fourbyteints__ 
        #define __CFURL__RESTORE_TWOBYTEINTS
        #pragma fourbyteints on
    #endif
    #pragma enumsalwaysint on
#elif PRAGMA_ENUM_OPTIONS
    #pragma option enum=int
#elif PRAGMA_ENUM_PACK
    #if __option(pack_enums)
        #define __CFURL__RESTORE_PACKED_ENUMS
        #pragma options(!pack_enums)
    #endif
#endif


enum CFURLPathStyle {
  kCFURLPOSIXPathStyle          = 0,
  kCFURLHFSPathStyle            = 1,
  kCFURLWindowsPathStyle        = 2
};
typedef enum CFURLPathStyle CFURLPathStyle;

typedef const struct __CFURL*           CFURLRef;
/* CFURLs are composed of two fundamental pieces - their string, and a */
/* (possibly NULL) base URL.  A relative URL is one in which the string */
/* by itself does not fully specify the URL (for instance "myDir/image.tiff"); */
/* an absolute URL is one in which the string does fully specify the URL */
/* ("file://localhost/myDir/image.tiff").  Absolute URLs always have NULL */
/* base URLs; however, it is possible for a URL to have a NULL base, and still */
/* not be absolute.  Such a URL has only a relative string, and cannot be */
/* resolved.  Two CFURLs are considered equal if and only if their strings */
/* are equal and their bases are equal.  In other words, */
/* "file://localhost/myDir/image.tiff" is NOT equal to the URL with relative */
/* string "myDir/image.tiff" and base URL "file://localhost/".  Clients that */
/* need these less strict form of equality should convert all URLs to their */
/* absolute form via CFURLCopyAbsoluteURL(), then compare the absolute forms. */
/*
 *  CFURLGetTypeID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTypeID )
CFURLGetTypeID(void);


/* encoding will be used both to interpret the bytes of URLBytes, and to */
/* interpret any percent-escapes within the bytes. */
/*
 *  CFURLCreateWithBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFURLCreateWithBytes(
  CFAllocatorRef     allocator,
  const UInt8 *      URLBytes,
  CFIndex            length,
  CFStringEncoding   encoding,
  CFURLRef           baseURL);


/* Escapes any character that is not 7-bit ASCII with the byte-code */
/* for the given encoding.  If escapeWhitespace is true, whitespace */
/* characters (' ', '\t', '\r', '\n') will be escaped also (desirable */
/* if embedding the URL into a larger text stream like HTML) */
/*
 *  CFURLCreateData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFDataRef )
CFURLCreateData(
  CFAllocatorRef     allocator,
  CFURLRef           url,
  CFStringEncoding   encoding,
  Boolean            escapeWhitespace);


/* Any escape sequences in URLString will be interpreted via UTF-8. */
/*
 *  CFURLCreateWithString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFURLCreateWithString(
  CFAllocatorRef   allocator,
  CFStringRef      URLString,
  CFURLRef         baseURL);


/* filePath should be the URL's path expressed as a path of the type */
/* fsType.  If filePath is not absolute, the resulting URL will be */
/* considered relative to the current working directory (evaluated */
/* at creation time).  isDirectory determines whether filePath is */
/* treated as a directory path when resolving against relative path */
/* components */
/*
 *  CFURLCreateWithFileSystemPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFURLCreateWithFileSystemPath(
  CFAllocatorRef   allocator,
  CFStringRef      filePath,
  CFURLPathStyle   pathStyle,
  Boolean          isDirectory);


/*
 *  CFURLCreateFromFileSystemRepresentation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFURLCreateFromFileSystemRepresentation(
  CFAllocatorRef   allocator,
  const UInt8 *    buffer,
  CFIndex          bufLen,
  Boolean          isDirectory);


/*
 *  CFURLCreateWithFileSystemPathRelativeToBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFURLCreateWithFileSystemPathRelativeToBase(
  CFAllocatorRef   allocator,
  CFStringRef      filePath,
  CFURLPathStyle   pathStyle,
  Boolean          isDirectory,
  CFURLRef         baseURL);


/*
 *  CFURLCreateFromFileSystemRepresentationRelativeToBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFURLCreateFromFileSystemRepresentationRelativeToBase(
  CFAllocatorRef   allocator,
  const UInt8 *    buffer,
  CFIndex          bufLen,
  Boolean          isDirectory,
  CFURLRef         baseURL);


/* Fills buffer with the file system's native representation of */
/* url's path. No more than maxBufLen bytes are written to buffer. */
/* The buffer should be at least the maximum path length for */
/* the file system in question to avoid failures for insufficiently */
/* large buffers.  If resolveAgainstBase is true, the url's relative */
/* portion is resolved against its base before the path is computed. */
/* Returns success or failure. */
/*
 *  CFURLGetFileSystemRepresentation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFURLGetFileSystemRepresentation(
  CFURLRef   url,
  Boolean    resolveAgainstBase,
  UInt8 *    buffer,
  CFIndex    maxBufLen);


/* Creates a new URL by resolving the relative portion of relativeURL against its base. */
/*
 *  CFURLCopyAbsoluteURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFURLCopyAbsoluteURL(CFURLRef relativeURL);


/* Returns the URL's string. */
/*
 *  CFURLGetString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFURLGetString(CFURLRef anURL);


/* Returns the base URL if it exists */
/*
 *  CFURLGetBaseURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFURLGetBaseURL(CFURLRef anURL);


/*
All URLs can be broken into two pieces - the scheme (preceding the
first colon) and the resource specifier (following the first colon).
Most URLs are also "standard" URLs conforming to RFC 1808 (available
from www.w3c.org).  This category includes URLs of the file, http,
https, and ftp schemes, to name a few.  Standard URLs start the
resource specifier with two slashes ("//"), and can be broken into
four distinct pieces - the scheme, the net location, the path, and
further resource specifiers (typically an optional parameter, query,
and/or fragment).  The net location appears immediately following
the two slashes and goes up to the next slash; it's format is
scheme-specific, but is usually composed of some or all of a username,
password, host name, and port.  The path is a series of path components
separated by slashes; if the net location is present, the path always
begins with a slash.  Standard URLs can be relative to another URL,
in which case at least the scheme and possibly other pieces as well
come from the base URL (see RFC 1808 for precise details when resolving
a relative URL against its base).  The full URL is therefore

<scheme> "://" <net location> <path, always starting with slash> <add'l resource specifiers>

If a given CFURL can be decomposed (that is, conforms to RFC 1808), you
can ask for each of the four basic pieces (scheme, net location, path,
and resource specifer) separately, as well as for its base URL.  The
basic pieces are returned with any percent escape sequences still in
place (although note that the scheme may not legally include any
percent escapes); this is to allow the caller to distinguish between
percent sequences that may have syntactic meaning if replaced by the
character being escaped (for instance, a '/' in a path component).
Since only the individual schemes know which characters are
syntactically significant, CFURL cannot safely replace any percent
escape sequences.  However, you can use
CFURLCreateStringByReplacingPercentEscapes() to create a new string with
the percent escapes removed; see below.

If a given CFURL can not be decomposed, you can ask for its scheme and its
resource specifier; asking it for its net location or path will return NULL.

To get more refined information about the components of a decomposable
CFURL, you may ask for more specific pieces of the URL, expressed with
the percent escapes removed.  The available functions are CFURLCopyHostName(),
CFURLGetPortNumber() (returns an Int32), CFURLCopyUserName(),
CFURLCopyPassword(), CFURLCopyQuery(), CFURLCopyParameters(), and
CFURLCopyFragment().  Because the parameters, query, and fragment of an
URL may contain scheme-specific syntaxes, these methods take a second
argument, giving a list of characters which should NOT be replaced if
percent escaped.  For instance, the ftp parameter syntax gives simple
key-value pairs as "<key>=<value>;"  Clearly if a key or value includes
either '=' or ';', it must be escaped to avoid corrupting the meaning of
the parameters, so the caller may request the parameter string as

CFStringRef myParams = CFURLCopyParameters(ftpURL, CFSTR("=;%"));

requesting that all percent escape sequences be replaced by the represented
characters, except for escaped '=', '%' or ';' characters.  Pass the empty
string (CFSTR("")) to request that all percent escapes be replaced, or NULL
to request that none be.
*/
/* Returns TRUE if anURL conforms to RFC 1808 */
/*
 *  CFURLCanBeDecomposed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFURLCanBeDecomposed(CFURLRef anURL);


/* The next several methods leave any percent escape sequences intact */
/*
 *  CFURLCopyScheme()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFURLCopyScheme(CFURLRef anURL);


/* NULL if CFURLCanBeDecomposed(anURL) is FALSE */
/*
 *  CFURLCopyNetLocation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFURLCopyNetLocation(CFURLRef anURL);


/* NULL if CFURLCanBeDecomposed(anURL) is FALSE; also does not resolve the URL */
/* against its base.  See also CFURLCopyAbsoluteURL().  Note that, strictly */
/* speaking, any leading '/' is not considered part of the URL's path, although */
/* its presence or absence determines whether the path is absolute. */
/* CFURLCopyPath()'s return value includes any leading slash (giving the path */
/* the normal POSIX appearance); CFURLCopyStrictPath()'s return value omits any */
/* leading slash, and uses isAbsolute to report whether the URL's path is absolute. */
/* CFURLCopyFileSystemPath() returns the URL's path as a file system path for the */
/* given path style.  All percent escape sequences are replaced.  The URL is not */
/* resolved against its base before computing the path. */
/*
 *  CFURLCopyPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFURLCopyPath(CFURLRef anURL);


/*
 *  CFURLCopyStrictPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFURLCopyStrictPath(
  CFURLRef   anURL,
  Boolean *  isAbsolute);


/*
 *  CFURLCopyFileSystemPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFURLCopyFileSystemPath(
  CFURLRef         anURL,
  CFURLPathStyle   pathStyle);


/* Returns whether anURL's path represents a directory */
/* (TRUE returned) or a simple file (FALSE returned) */
/*
 *  CFURLHasDirectoryPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFURLHasDirectoryPath(CFURLRef anURL);


/* Any additional resource specifiers after the path.  For URLs */
/* that cannot be decomposed, this is everything except the scheme itself. */
/*
 *  CFURLCopyResourceSpecifier()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFURLCopyResourceSpecifier(CFURLRef anURL);


/*
 *  CFURLCopyHostName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFURLCopyHostName(CFURLRef anURL);


/*
 *  CFURLGetPortNumber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( SInt32 )
CFURLGetPortNumber(CFURLRef anURL);


/* Returns -1 if no port number is specified */
/*
 *  CFURLCopyUserName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFURLCopyUserName(CFURLRef anURL);


/*
 *  CFURLCopyPassword()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFURLCopyPassword(CFURLRef anURL);


/* These remove all percent escape sequences except those for */
/* characters in charactersToLeaveEscaped.  If charactersToLeaveEscaped */
/* is empty (""), all percent escape sequences are replaced by their */
/* corresponding characters.  If charactersToLeaveEscaped is NULL, */
/* then no escape sequences are removed at all */
/*
 *  CFURLCopyParameterString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFURLCopyParameterString(
  CFURLRef      anURL,
  CFStringRef   charactersToLeaveEscaped);


/*
 *  CFURLCopyQueryString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFURLCopyQueryString(
  CFURLRef      anURL,
  CFStringRef   charactersToLeaveEscaped);


/*
 *  CFURLCopyFragment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFURLCopyFragment(
  CFURLRef      anURL,
  CFStringRef   charactersToLeaveEscaped);


/*
 *  CFURLCopyLastPathComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFURLCopyLastPathComponent(CFURLRef url);


/*
 *  CFURLCopyPathExtension()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFURLCopyPathExtension(CFURLRef url);


/* These functions all treat the base URL of the supplied url as */
/* invariant.  In other words, the URL returned will always have */
/* the same base as the URL supplied as an argument. */
/*
 *  CFURLCreateCopyAppendingPathComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFURLCreateCopyAppendingPathComponent(
  CFAllocatorRef   allocator,
  CFURLRef         url,
  CFStringRef      pathComponent,
  Boolean          isDirectory);


/*
 *  CFURLCreateCopyDeletingLastPathComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFURLCreateCopyDeletingLastPathComponent(
  CFAllocatorRef   allocator,
  CFURLRef         url);


/*
 *  CFURLCreateCopyAppendingPathExtension()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFURLCreateCopyAppendingPathExtension(
  CFAllocatorRef   allocator,
  CFURLRef         url,
  CFStringRef      extension);


/*
 *  CFURLCreateCopyDeletingPathExtension()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFURLCreateCopyDeletingPathExtension(
  CFAllocatorRef   allocator,
  CFURLRef         url);


/* Returns a string with any percent escape sequences that do NOT */
/* correspond to characters in charactersToLeaveEscaped with their */
/* equivalent.  Returns NULL on failure (if an invalid percent sequence */
/* is encountered), or the original string (retained) if no characters */
/* need to be replaced. Pass NULL to request that no percent escapes be */
/* replaced, or the empty string (CFSTR("")) to request that all percent */
/* escapes be replaced. Uses UTF8 to interpret percent escapes. */
/*
 *  CFURLCreateStringByReplacingPercentEscapes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFURLCreateStringByReplacingPercentEscapes(
  CFAllocatorRef   allocator,
  CFStringRef      originalString,
  CFStringRef      charactersToLeaveEscaped);


/*
 *  CFURLCreateStringByAddingPercentEscapes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFURLCreateStringByAddingPercentEscapes(
  CFAllocatorRef     allocator,
  CFStringRef        originalString,
  CFStringRef        charactersToLeaveUnescaped,
  CFStringRef        legalURLCharactersToBeEscaped,
  CFStringEncoding   encoding);


/*
 *  CFURLCreateFromFSRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFURLCreateFromFSRef(
  CFAllocatorRef   allocator,
  const FSRef *    fsRef);


/*
 *  CFURLGetFSRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFURLGetFSRef(
  CFURLRef   url,
  FSRef *    fsRef);



#if PRAGMA_ENUM_ALWAYSINT
    #pragma enumsalwaysint reset
    #ifdef __CFURL__RESTORE_TWOBYTEINTS
        #pragma fourbyteints off
    #endif
#elif PRAGMA_ENUM_OPTIONS
    #pragma option enum=reset
#elif defined(__CFURL__RESTORE_PACKED_ENUMS)
    #pragma options(pack_enums)
#endif

#if PRAGMA_STRUCT_ALIGN
    #pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
    #pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __CFURL__ */

