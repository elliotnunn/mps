{
     File:       CFURL.p
 
     Contains:   CoreFoundation urls
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CFURL;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFURL__}
{$SETC __CFURL__ := 1}

{$I+}
{$SETC CFURLIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}
{$IFC UNDEFINED __CFDATA__}
{$I CFData.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CFURLPathStyle 				= SInt32;
CONST
	kCFURLPOSIXPathStyle		= 0;
	kCFURLHFSPathStyle			= 1;
	kCFURLWindowsPathStyle		= 2;


TYPE
	CFURLRef    = ^LONGINT; { an opaque 32-bit type }
	CFURLRefPtr = ^CFURLRef;  { when a VAR xx:CFURLRef parameter can be nil, it is changed to xx: CFURLRefPtr }
	{	 CFURLs are composed of two fundamental pieces - their string, and a 	}
	{	 (possibly NULL) base URL.  A relative URL is one in which the string 	}
	{	 by itself does not fully specify the URL (for instance "myDir/image.tiff"); 	}
	{	 an absolute URL is one in which the string does fully specify the URL 	}
	{	 ("file://localhost/myDir/image.tiff").  Absolute URLs always have NULL 	}
	{	 base URLs; however, it is possible for a URL to have a NULL base, and still 	}
	{	 not be absolute.  Such a URL has only a relative string, and cannot be 	}
	{	 resolved.  Two CFURLs are considered equal if and only if their strings 	}
	{	 are equal and their bases are equal.  In other words, 	}
	{	 "file://localhost/myDir/image.tiff" is NOT equal to the URL with relative 	}
	{	 string "myDir/image.tiff" and base URL "file://localhost/".  Clients that 	}
	{	 need these less strict form of equality should convert all URLs to their 	}
	{	 absolute form via CFURLCopyAbsoluteURL(), then compare the absolute forms. 	}
	{
	 *  CFURLGetTypeID()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFURLGetTypeID: CFTypeID; C;

{ encoding will be used both to interpret the bytes of URLBytes, and to }
{ interpret any percent-escapes within the bytes. }
{
 *  CFURLCreateWithBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCreateWithBytes(allocator: CFAllocatorRef; {CONST}VAR URLBytes: UInt8; length: CFIndex; encoding: CFStringEncoding; baseURL: CFURLRef): CFURLRef; C;

{ Escapes any character that is not 7-bit ASCII with the byte-code }
{ for the given encoding.  If escapeWhitespace is true, whitespace }
{ characters (' ', '\t', '\r', '\n') will be escaped also (desirable }
{ if embedding the URL into a larger text stream like HTML) }
{
 *  CFURLCreateData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCreateData(allocator: CFAllocatorRef; url: CFURLRef; encoding: CFStringEncoding; escapeWhitespace: BOOLEAN): CFDataRef; C;

{ Any escape sequences in URLString will be interpreted via UTF-8. }
{
 *  CFURLCreateWithString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCreateWithString(allocator: CFAllocatorRef; URLString: CFStringRef; baseURL: CFURLRef): CFURLRef; C;

{ filePath should be the URL's path expressed as a path of the type }
{ fsType.  If filePath is not absolute, the resulting URL will be }
{ considered relative to the current working directory (evaluated }
{ at creation time).  isDirectory determines whether filePath is }
{ treated as a directory path when resolving against relative path }
{ components }
{
 *  CFURLCreateWithFileSystemPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCreateWithFileSystemPath(allocator: CFAllocatorRef; filePath: CFStringRef; pathStyle: CFURLPathStyle; isDirectory: BOOLEAN): CFURLRef; C;

{
 *  CFURLCreateFromFileSystemRepresentation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCreateFromFileSystemRepresentation(allocator: CFAllocatorRef; {CONST}VAR buffer: UInt8; bufLen: CFIndex; isDirectory: BOOLEAN): CFURLRef; C;

{
 *  CFURLCreateWithFileSystemPathRelativeToBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCreateWithFileSystemPathRelativeToBase(allocator: CFAllocatorRef; filePath: CFStringRef; pathStyle: CFURLPathStyle; isDirectory: BOOLEAN; baseURL: CFURLRef): CFURLRef; C;

{
 *  CFURLCreateFromFileSystemRepresentationRelativeToBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCreateFromFileSystemRepresentationRelativeToBase(allocator: CFAllocatorRef; {CONST}VAR buffer: UInt8; bufLen: CFIndex; isDirectory: BOOLEAN; baseURL: CFURLRef): CFURLRef; C;

{ Fills buffer with the file system's native representation of }
{ url's path. No more than maxBufLen bytes are written to buffer. }
{ The buffer should be at least the maximum path length for }
{ the file system in question to avoid failures for insufficiently }
{ large buffers.  If resolveAgainstBase is true, the url's relative }
{ portion is resolved against its base before the path is computed. }
{ Returns success or failure. }
{
 *  CFURLGetFileSystemRepresentation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLGetFileSystemRepresentation(url: CFURLRef; resolveAgainstBase: BOOLEAN; VAR buffer: UInt8; maxBufLen: CFIndex): BOOLEAN; C;

{ Creates a new URL by resolving the relative portion of relativeURL against its base. }
{
 *  CFURLCopyAbsoluteURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCopyAbsoluteURL(relativeURL: CFURLRef): CFURLRef; C;

{ Returns the URL's string. }
{
 *  CFURLGetString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLGetString(anURL: CFURLRef): CFStringRef; C;

{ Returns the base URL if it exists }
{
 *  CFURLGetBaseURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLGetBaseURL(anURL: CFURLRef): CFURLRef; C;

{
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
}
{ Returns TRUE if anURL conforms to RFC 1808 }
{
 *  CFURLCanBeDecomposed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCanBeDecomposed(anURL: CFURLRef): BOOLEAN; C;

{ The next several methods leave any percent escape sequences intact }
{
 *  CFURLCopyScheme()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCopyScheme(anURL: CFURLRef): CFStringRef; C;

{ NULL if CFURLCanBeDecomposed(anURL) is FALSE }
{
 *  CFURLCopyNetLocation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCopyNetLocation(anURL: CFURLRef): CFStringRef; C;

{ NULL if CFURLCanBeDecomposed(anURL) is FALSE; also does not resolve the URL }
{ against its base.  See also CFURLCopyAbsoluteURL().  Note that, strictly }
{ speaking, any leading '/' is not considered part of the URL's path, although }
{ its presence or absence determines whether the path is absolute. }
{ CFURLCopyPath()'s return value includes any leading slash (giving the path }
{ the normal POSIX appearance); CFURLCopyStrictPath()'s return value omits any }
{ leading slash, and uses isAbsolute to report whether the URL's path is absolute. }
{ CFURLCopyFileSystemPath() returns the URL's path as a file system path for the }
{ given path style.  All percent escape sequences are replaced.  The URL is not }
{ resolved against its base before computing the path. }
{
 *  CFURLCopyPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCopyPath(anURL: CFURLRef): CFStringRef; C;

{
 *  CFURLCopyStrictPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCopyStrictPath(anURL: CFURLRef; VAR isAbsolute: BOOLEAN): CFStringRef; C;

{
 *  CFURLCopyFileSystemPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCopyFileSystemPath(anURL: CFURLRef; pathStyle: CFURLPathStyle): CFStringRef; C;

{ Returns whether anURL's path represents a directory }
{ (TRUE returned) or a simple file (FALSE returned) }
{
 *  CFURLHasDirectoryPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLHasDirectoryPath(anURL: CFURLRef): BOOLEAN; C;

{ Any additional resource specifiers after the path.  For URLs }
{ that cannot be decomposed, this is everything except the scheme itself. }
{
 *  CFURLCopyResourceSpecifier()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCopyResourceSpecifier(anURL: CFURLRef): CFStringRef; C;

{
 *  CFURLCopyHostName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCopyHostName(anURL: CFURLRef): CFStringRef; C;

{
 *  CFURLGetPortNumber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLGetPortNumber(anURL: CFURLRef): SInt32; C;

{ Returns -1 if no port number is specified }
{
 *  CFURLCopyUserName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCopyUserName(anURL: CFURLRef): CFStringRef; C;

{
 *  CFURLCopyPassword()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCopyPassword(anURL: CFURLRef): CFStringRef; C;

{ These remove all percent escape sequences except those for }
{ characters in charactersToLeaveEscaped.  If charactersToLeaveEscaped }
{ is empty (""), all percent escape sequences are replaced by their }
{ corresponding characters.  If charactersToLeaveEscaped is NULL, }
{ then no escape sequences are removed at all }
{
 *  CFURLCopyParameterString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCopyParameterString(anURL: CFURLRef; charactersToLeaveEscaped: CFStringRef): CFStringRef; C;

{
 *  CFURLCopyQueryString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCopyQueryString(anURL: CFURLRef; charactersToLeaveEscaped: CFStringRef): CFStringRef; C;

{
 *  CFURLCopyFragment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCopyFragment(anURL: CFURLRef; charactersToLeaveEscaped: CFStringRef): CFStringRef; C;

{
 *  CFURLCopyLastPathComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCopyLastPathComponent(url: CFURLRef): CFStringRef; C;

{
 *  CFURLCopyPathExtension()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCopyPathExtension(url: CFURLRef): CFStringRef; C;

{ These functions all treat the base URL of the supplied url as }
{ invariant.  In other words, the URL returned will always have }
{ the same base as the URL supplied as an argument. }
{
 *  CFURLCreateCopyAppendingPathComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCreateCopyAppendingPathComponent(allocator: CFAllocatorRef; url: CFURLRef; pathComponent: CFStringRef; isDirectory: BOOLEAN): CFURLRef; C;

{
 *  CFURLCreateCopyDeletingLastPathComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCreateCopyDeletingLastPathComponent(allocator: CFAllocatorRef; url: CFURLRef): CFURLRef; C;

{
 *  CFURLCreateCopyAppendingPathExtension()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCreateCopyAppendingPathExtension(allocator: CFAllocatorRef; url: CFURLRef; extension: CFStringRef): CFURLRef; C;

{
 *  CFURLCreateCopyDeletingPathExtension()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCreateCopyDeletingPathExtension(allocator: CFAllocatorRef; url: CFURLRef): CFURLRef; C;

{ Returns a string with any percent escape sequences that do NOT }
{ correspond to characters in charactersToLeaveEscaped with their }
{ equivalent.  Returns NULL on failure (if an invalid percent sequence }
{ is encountered), or the original string (retained) if no characters }
{ need to be replaced. Pass NULL to request that no percent escapes be }
{ replaced, or the empty string (CFSTR("")) to request that all percent }
{ escapes be replaced. Uses UTF8 to interpret percent escapes. }
{
 *  CFURLCreateStringByReplacingPercentEscapes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCreateStringByReplacingPercentEscapes(allocator: CFAllocatorRef; originalString: CFStringRef; charactersToLeaveEscaped: CFStringRef): CFStringRef; C;

{
 *  CFURLCreateStringByAddingPercentEscapes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCreateStringByAddingPercentEscapes(allocator: CFAllocatorRef; originalString: CFStringRef; charactersToLeaveUnescaped: CFStringRef; legalURLCharactersToBeEscaped: CFStringRef; encoding: CFStringEncoding): CFStringRef; C;

{
 *  CFURLCreateFromFSRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCreateFromFSRef(allocator: CFAllocatorRef; {CONST}VAR fsRef: FSRef): CFURLRef; C;

{
 *  CFURLGetFSRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLGetFSRef(url: CFURLRef; VAR fsRef: FSRef): BOOLEAN; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFURLIncludes}

{$ENDC} {__CFURL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
