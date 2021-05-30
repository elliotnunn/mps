/*
     File:       CFXMLParser.h
 
     Contains:   CoreFoundation XML parser
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __CFXMLPARSER__
#define __CFXMLPARSER__

#ifndef __CFBASE__
#include <CFBase.h>
#endif

#ifndef __CFARRAY__
#include <CFArray.h>
#endif

#ifndef __CFDATA__
#include <CFData.h>
#endif

#ifndef __CFDICTIONARY__
#include <CFDictionary.h>
#endif

#ifndef __CFTREE__
#include <CFTree.h>
#endif

#ifndef __CFURL__
#include <CFURL.h>
#endif

#ifndef __CFXMLNODE__
#include <CFXMLNode.h>
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
        #define __CFXMLPARSER__RESTORE_TWOBYTEINTS
        #pragma fourbyteints on
    #endif
    #pragma enumsalwaysint on
#elif PRAGMA_ENUM_OPTIONS
    #pragma option enum=int
#elif PRAGMA_ENUM_PACK
    #if __option(pack_enums)
        #define __CFXMLPARSER__RESTORE_PACKED_ENUMS
        #pragma options(!pack_enums)
    #endif
#endif

typedef struct __CFXMLParser*           CFXMLParserRef;
/* These are the various options you can configure the parser with.  These are
   chosen such that an option flag of 0 (kCFXMLParserNoOptions) leaves the XML
   as "intact" as possible (reports all structures; performs no replacements).
   Hence, to make the parser do the most work, returning only the pure element
   tree, set the option flag to kCFXMLParserAllOptions.

kCFXMLParserValidateDocument -
   validate the document against its grammar from the DTD, reporting any errors.
   Currently not supported.

kCFXMLParserSkipMetaData -
   silently skip over metadata constructs (the DTD and comments)

kCFXMLParserReplacePhysicalEntities -
   replace declared entities like &lt;.  Note that other than the 5 predefined
   entities (lt, gt, quot, amp, apos), these must be defined in the DTD.
   Currently not supported.

kCFXMLParserSkipWhitespace -
   skip over all whitespace that does not abut non-whitespace character data.
   In other words, given <foo>  <bar> blah </bar></foo>, the whitespace between
   foo's open tag and bar's open tag would be suppressed, but the whitespace
   around blah would be preserved.

kCFXMLParserAddImpliedAttributes -
   where the DTD specifies implied attribute-value pairs for a particular element,
   add those pairs to any occurances of the element in the element tree.
   Currently not supported.
*/

enum CFXMLParserOptions {
  kCFXMLParserValidateDocument  = (1 << 0),
  kCFXMLParserSkipMetaData      = (1 << 1),
  kCFXMLParserReplacePhysicalEntities = (1 << 2),
  kCFXMLParserSkipWhitespace    = (1 << 3),
  kCFXMLParserResolveExternalEntities = (1 << 4),
  kCFXMLParserAddImpliedAttributes = (1 << 5),
  kCFXMLParserAllOptions        = 0x00FFFFFF,
  kCFXMLParserNoOptions         = 0
};
typedef enum CFXMLParserOptions CFXMLParserOptions;

/* This list is expected to grow */

enum CFXMLParserStatusCode {
  kCFXMLStatusParseNotBegun     = -2,
  kCFXMLStatusParseInProgress   = -1,
  kCFXMLStatusParseSuccessful   = 0,
  kCFXMLErrorUnexpectedEOF      = 1,
  kCFXMLErrorUnknownEncoding    = 2,
  kCFXMLErrorEncodingConversionFailure = 3,
  kCFXMLErrorMalformedProcessingInstruction = 4,
  kCFXMLErrorMalformedDTD       = 5,
  kCFXMLErrorMalformedName      = 6,
  kCFXMLErrorMalformedCDSect    = 7,
  kCFXMLErrorMalformedCloseTag  = 8,
  kCFXMLErrorMalformedStartTag  = 9,
  kCFXMLErrorMalformedDocument  = 10,
  kCFXMLErrorElementlessDocument = 11,
  kCFXMLErrorMalformedComment   = 12,
  kCFXMLErrorMalformedCharacterReference = 13,
  kCFXMLErrorMalformedParsedCharacterData = 14,
  kCFXMLErrorNoData             = 15
};
typedef enum CFXMLParserStatusCode CFXMLParserStatusCode;

/*  These functions are called as a parse progresses.

createXMLStructure -
  called as new XML structures are encountered by the parser.  May return NULL to indicate
  that the given structure should be skipped; if NULL is returned for a given structure,
  only minimal parsing is done for that structure (enough to correctly determine its end,
  and to extract any data necessary for the remainder of the parse, such as Entity definitions).
  createXMLStructure (or indeed, any of the tree-creation callbacks) will not be called for any
  children of the skipped structure.  The only exception is that the top-most element will always
  be reported even if NULL was returned for the document as a whole.  NOTE: for performance reasons,
  the node passed to createXMLStructure cannot be safely retained by the client; the node as
  a whole must be copied (via CFXMLNodeCreateCopy), or its contents must be extracted and copied.

addChild -
  called as children are parsed and are ready to be added to the tree.  If createXMLStructure
  returns NULL for a given structure, that structure is omitted entirely, and addChild will
  NOT be called for either a NULL child or parent.

endXMLStructure -
  called once a structure (and all its children) are completely parsed.  As elements are encountered,
  createXMLStructure is called for them first, then addChild to add the new structure to its parent,
  then addChild (potentially several times) to add the new structure's children to it, then finally
  endXMLStructure to show that the structure has been fully parsed.

createXMLStructure, addChild, and endXMLStructure are all REQUIRED TO BE NON-NULL.

resolveExternalEntity -
  called when external entities are referenced (NOT when they are simply defined).  If the function
  pointer is NULL, the parser uses its internal routines to try and resolve the entity.  If the
  function pointer is set, and the function returns NULL, a place holder for the external entity
  is inserted into the tree.  In this manner, the parser's client can prevent any external network
  or file accesses.

handleError - called as errors/warnings are encountered in the data stream.  At some point, we will
  have an enum of the expected errors, some of which will be fatal, others of which will not.  If
  the function pointer is NULL, the parser will silently attempt to recover.  The
  handleError function may always return FALSE to force the parser to stop; if handleError returns
  TRUE, the parser will attempt to recover (fatal errors will still cause the parse to abort
  immediately).
*/
typedef CALLBACK_API_C( void *, CFXMLParserCreateXMLStructureCallBack )(CFXMLParserRef parser, CFXMLNodeRef nodeDesc, void *info);
typedef CALLBACK_API_C( void , CFXMLParserAddChildCallBack )(CFXMLParserRef parser, void *parent, void *child, void *info);
typedef CALLBACK_API_C( void , CFXMLParserEndXMLStructureCallBack )(CFXMLParserRef parser, void *xmlType, void *info);
typedef CALLBACK_API_C( CFDataRef , CFXMLParserResolveExternalEntityCallBack )(CFXMLParserRef parser, CFXMLExternalID *extID, void *info);
typedef CALLBACK_API_C( Boolean , CFXMLParserHandleErrorCallBack )(CFXMLParserRef parser, CFXMLParserStatusCode error, void *info);
struct CFXMLParserCallBacks {
  CFIndex             version;
  CFXMLParserCreateXMLStructureCallBack  createXMLStructure;
  CFXMLParserAddChildCallBack  addChild;
  CFXMLParserEndXMLStructureCallBack  endXMLStructure;
  CFXMLParserResolveExternalEntityCallBack  resolveExternalEntity;
  CFXMLParserHandleErrorCallBack  handleError;
};
typedef struct CFXMLParserCallBacks     CFXMLParserCallBacks;
typedef CALLBACK_API_C( const void *, CFXMLParserRetainCallBack )(const void * info);
typedef CALLBACK_API_C( void , CFXMLParserReleaseCallBack )(const void * info);
typedef CALLBACK_API_C( CFStringRef , CFXMLParserCopyDescriptionCallBack )(const void * info);
struct CFXMLParserContext {
  CFIndex             version;
  void *              info;
  CFXMLParserRetainCallBack  retain;
  CFXMLParserReleaseCallBack  release;
  CFXMLParserCopyDescriptionCallBack  copyDescription;
};
typedef struct CFXMLParserContext       CFXMLParserContext;
/*
 *  CFXMLParserGetTypeID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTypeID )
CFXMLParserGetTypeID(void);


/* Creates a parser which will parse the given data with the given options.  xmlData may not be NULL.
   dataSource should be the URL from which the data came, and may be NULL; it is used to resolve any
   relative references found in xmlData. versionOfNodes determines which version CFXMLNodes are produced
   by the parser; see CFXMLNode.h for more details.  callBacks are the callbacks called by the parser as
   the parse progresses; callBacks, callBacks->createXMLStructure, callBacks->addChild, and
   callBacks->endXMLStructure must all be non-NULL.  context determines what if any info pointer is
   passed to the callbacks as the parse progresses; context may be NULL.  */
/*
 *  CFXMLParserCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFXMLParserRef )
CFXMLParserCreate(
  CFAllocatorRef          allocator,
  CFDataRef               xmlData,
  CFURLRef                dataSource,
  CFOptionFlags           parseOptions,
  CFIndex                 versionOfNodes,
  CFXMLParserCallBacks *  callBacks,
  CFXMLParserContext *    context);


/* Arguments as above, except that the data to be parsed is loaded directly
   from dataSource.  dataSource may not be NULL.  */
/*
 *  CFXMLParserCreateWithDataFromURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFXMLParserRef )
CFXMLParserCreateWithDataFromURL(
  CFAllocatorRef          allocator,
  CFURLRef                dataSource,
  CFOptionFlags           parseOptions,
  CFIndex                 versionOfNodes,
  CFXMLParserCallBacks *  callBacks,
  CFXMLParserContext *    context);


/*
 *  CFXMLParserGetContext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFXMLParserGetContext(
  CFXMLParserRef        parser,
  CFXMLParserContext *  context);


/*
 *  CFXMLParserGetCallBacks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFXMLParserGetCallBacks(
  CFXMLParserRef          parser,
  CFXMLParserCallBacks *  callBacks);


/*
 *  CFXMLParserGetSourceURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFXMLParserGetSourceURL(CFXMLParserRef parser);


/* Returns the character index of the current parse location */
/*
 *  CFXMLParserGetLocation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFIndex )
CFXMLParserGetLocation(CFXMLParserRef parser);


/* Returns the line number of the current parse location */
/*
 *  CFXMLParserGetLineNumber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFIndex )
CFXMLParserGetLineNumber(CFXMLParserRef parser);


/* Returns the top-most object returned by the createXMLStructure callback */
/*
 *  CFXMLParserGetDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void * )
CFXMLParserGetDocument(CFXMLParserRef parser);


/* Get the status code or a user-readable description of the last error that occurred in a parse.
   If no error has occurred, a null description string is returned.  See the enum above for
   possible status returns */
/*
 *  CFXMLParserGetStatusCode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFXMLParserStatusCode )
CFXMLParserGetStatusCode(CFXMLParserRef parser);


/*
 *  CFXMLParserCopyErrorDescription()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFXMLParserCopyErrorDescription(CFXMLParserRef parser);


/* Cause any in-progress parse to abort with the given error code and description.  errorCode
   must be positive, and errorDescription may not be NULL.  Cannot be called asynchronously
   (i.e. must be called from within a parser callback) */
/*
 *  CFXMLParserAbort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFXMLParserAbort(
  CFXMLParserRef          parser,
  CFXMLParserStatusCode   errorCode,
  CFStringRef             errorDescription);


/* Starts a parse of the data the parser was created with; returns success or failure.
   Upon success, use CFXMLParserGetDocument() to get the product of the parse.  Upon
   failure, use CFXMLParserGetErrorCode() or CFXMLParserCopyErrorDescription() to get
   information about the error.  It is an error to call CFXMLParserParse() while a
   parse is already underway. */
/*
 *  CFXMLParserParse()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFXMLParserParse(CFXMLParserRef parser);


/* These functions provide a higher-level interface.  The XML data is parsed to a
   special CFTree (an CFXMLTree) with known contexts and callbacks.  See CFXMLNode.h
   for full details on using an CFXMLTree and the CFXMLNodes contained therein.
*/
/* Parse to an CFXMLTreeRef.  parseOptions are as above. versionOfNodes determines
   what version CFXMLNodes are used to populate the tree.  */
/*
 *  CFXMLTreeCreateFromData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFXMLTreeRef )
CFXMLTreeCreateFromData(
  CFAllocatorRef   allocator,
  CFDataRef        xmlData,
  CFURLRef         dataSource,
  CFOptionFlags    parseOptions,
  CFIndex          versionOfNodes);


/* Loads the data to be parsed directly from dataSource.  Arguments as above. */
/*
 *  CFXMLTreeCreateWithDataFromURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFXMLTreeRef )
CFXMLTreeCreateWithDataFromURL(
  CFAllocatorRef   allocator,
  CFURLRef         dataSource,
  CFOptionFlags    parseOptions,
  CFIndex          versionOfNodes);


/* Generate the XMLData (ready to be written to whatever permanent storage is to be
   used) from an CFXMLTree.  Will NOT regenerate entity references (except those
   required for syntactic correctness) if they were replaced at the parse time;
   clients that wish this should walk the tree and re-insert any entity references
   that should appear in the final output file. */
/*
 *  CFXMLTreeCreateXMLData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFDataRef )
CFXMLTreeCreateXMLData(
  CFAllocatorRef   allocator,
  CFXMLTreeRef     xmlTree);



#if PRAGMA_ENUM_ALWAYSINT
    #pragma enumsalwaysint reset
    #ifdef __CFXMLPARSER__RESTORE_TWOBYTEINTS
        #pragma fourbyteints off
    #endif
#elif PRAGMA_ENUM_OPTIONS
    #pragma option enum=reset
#elif defined(__CFXMLPARSER__RESTORE_PACKED_ENUMS)
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

#endif /* __CFXMLPARSER__ */

