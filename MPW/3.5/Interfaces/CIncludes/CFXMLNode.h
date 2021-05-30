/*
     File:       CFXMLNode.h
 
     Contains:   CoreFoundation XML Node and XML Tree
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __CFXMLNODE__
#define __CFXMLNODE__

#ifndef __CFARRAY__
#include <CFArray.h>
#endif

#ifndef __CFDICTIONARY__
#include <CFDictionary.h>
#endif

#ifndef __CFSTRING__
#include <CFString.h>
#endif

#ifndef __CFTREE__
#include <CFTree.h>
#endif

#ifndef __CFURL__
#include <CFURL.h>
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
        #define __CFXMLNODE__RESTORE_TWOBYTEINTS
        #pragma fourbyteints on
    #endif
    #pragma enumsalwaysint on
#elif PRAGMA_ENUM_OPTIONS
    #pragma option enum=int
#elif PRAGMA_ENUM_PACK
    #if __option(pack_enums)
        #define __CFXMLNODE__RESTORE_PACKED_ENUMS
        #pragma options(!pack_enums)
    #endif
#endif

typedef const struct __CFXMLNode*       CFXMLNodeRef;
typedef CFTreeRef                       CFXMLTreeRef;
/*  An CFXMLNode describes an individual XML construct - like a tag, or a comment, or a string
    of character data.  Each CFXMLNode contains 3 main pieces of information - the node's type,
    the data string, and a pointer to an additional data structure.  The node's type ID is an enum
    value of type CFXMLNodeTypeID.  The data string is always a CFStringRef; the meaning of the
    string is dependent on the node's type ID. The format of the additional data is also dependent
    on the node's type; in general, there is a custom structure for each type that requires
    additional data.  See below for the mapping from type ID to meaning of the data string and
    structure of the additional data.  Note that these structures are versioned, and may change
    as the parser changes.  The current version can always be identified by kCFXMLNodeCurrentVersion;
    earlier versions can be identified and used by passing earlier values for the version number
    (although the older structures would have been removed from the header).

    An CFXMLTree is simply a CFTree whose context data is known to be an CFXMLNodeRef.  As
    such, an CFXMLTree can be used to represent an entire XML document; the CFTree
    provides the tree structure of the document, while the CFXMLNodes identify and describe
    the nodes of the tree.  An XML document can be parsed to a CFXMLTree, and a CFXMLTree
    can generate the data for the equivalent XML document - see CFXMLParser.h for more
    information on parsing XML.
    */
enum {
  kCFXMLNodeCurrentVersion      = 1
};

/* Type codes for the different possible XML nodes; this list may grow.*/

enum CFXMLNodeTypeCode {
  kCFXMLNodeTypeDocument        = 1,
  kCFXMLNodeTypeElement         = 2,
  kCFXMLNodeTypeAttribute       = 3,
  kCFXMLNodeTypeProcessingInstruction = 4,
  kCFXMLNodeTypeComment         = 5,
  kCFXMLNodeTypeText            = 6,
  kCFXMLNodeTypeCDATASection    = 7,
  kCFXMLNodeTypeDocumentFragment = 8,
  kCFXMLNodeTypeEntity          = 9,
  kCFXMLNodeTypeEntityReference = 10,
  kCFXMLNodeTypeDocumentType    = 11,
  kCFXMLNodeTypeWhitespace      = 12,
  kCFXMLNodeTypeNotation        = 13,
  kCFXMLNodeTypeElementTypeDeclaration = 14,
  kCFXMLNodeTypeAttributeListDeclaration = 15
};
typedef enum CFXMLNodeTypeCode CFXMLNodeTypeCode;

struct CFXMLElementInfo {
  CFDictionaryRef     attributes;
  CFArrayRef          attributeOrder;
  Boolean             isEmpty;
};
typedef struct CFXMLElementInfo         CFXMLElementInfo;
struct CFXMLProcessingInstructionInfo {
  CFStringRef         dataString;
};
typedef struct CFXMLProcessingInstructionInfo CFXMLProcessingInstructionInfo;
struct CFXMLDocumentInfo {
  CFURLRef            sourceURL;
  CFStringEncoding    encoding;
};
typedef struct CFXMLDocumentInfo        CFXMLDocumentInfo;
struct CFXMLExternalID {
  CFURLRef            systemID;
  CFStringRef         publicID;
};
typedef struct CFXMLExternalID          CFXMLExternalID;
struct CFXMLDocumentTypeInfo {
  CFXMLExternalID     externalID;
};
typedef struct CFXMLDocumentTypeInfo    CFXMLDocumentTypeInfo;
struct CFXMLNotationInfo {
  CFXMLExternalID     externalID;
};
typedef struct CFXMLNotationInfo        CFXMLNotationInfo;
struct CFXMLElementTypeDeclarationInfo {
                                              /* This is expected to change in future versions */
  CFStringRef         contentDescription;
};
typedef struct CFXMLElementTypeDeclarationInfo CFXMLElementTypeDeclarationInfo;
struct CFXMLAttributeDeclarationInfo {
                                              /* This is expected to change in future versions */
  CFStringRef         attributeName;
  CFStringRef         typeString;
  CFStringRef         defaultString;
};
typedef struct CFXMLAttributeDeclarationInfo CFXMLAttributeDeclarationInfo;
struct CFXMLAttributeListDeclarationInfo {
  CFIndex             numberOfAttributes;
  CFXMLAttributeDeclarationInfo * attributes;
};
typedef struct CFXMLAttributeListDeclarationInfo CFXMLAttributeListDeclarationInfo;

enum CFXMLEntityTypeCode {
  kCFXMLEntityTypeParameter     = 0,    /* Implies parsed, internal */
  kCFXMLEntityTypeParsedInternal = 1,
  kCFXMLEntityTypeParsedExternal = 2,
  kCFXMLEntityTypeUnparsed      = 3,
  kCFXMLEntityTypeCharacter     = 4
};
typedef enum CFXMLEntityTypeCode CFXMLEntityTypeCode;

struct CFXMLEntityInfo {
  CFXMLEntityTypeCode  entityType;
  CFStringRef         replacementText;        /* NULL if entityType is external or unparsed */
  CFXMLExternalID     entityID;               /* entityID.systemID will be NULL if entityType is internal */
  CFStringRef         notationName;           /* NULL if entityType is parsed */
};
typedef struct CFXMLEntityInfo          CFXMLEntityInfo;
struct CFXMLEntityReferenceInfo {
  CFXMLEntityTypeCode  entityType;
};
typedef struct CFXMLEntityReferenceInfo CFXMLEntityReferenceInfo;
/*
 dataTypeCode                       meaning of dataString                format of infoPtr
 ===========                        =====================                =================
 kCFXMLNodeTypeDocument             <currently unused>                   CFXMLDocumentInfo *
 kCFXMLNodeTypeElement              tag name                             CFXMLElementInfo *
 kCFXMLNodeTypeAttribute            <currently unused>                   <currently unused>
 kCFXMLNodeTypeProcessInstruction   name of the target                   CFXMLProcessingInstructionInfo *
 kCFXMLNodeTypeComment              text of the comment                  NULL
 kCFXMLNodeTypeText                 the text's contents                  NULL
 kCFXMLNodeTypeCDATASection         text of the CDATA                    NULL
 kCFXMLNodeTypeDocumentFragment     <currently unused>                   <currently unused>
 kCFXMLNodeTypeEntity               name of the entity                   CFXMLEntityInfo *
 kCFXMLNodeTypeEntityReference      name of the referenced entity        CFXMLEntityReferenceInfo *
 kCFXMLNodeTypeDocumentType         name given as top-level element      CFXMLDocumentTypeInfo *
 kCFXMLNodeTypeWhitespace           text of the whitespace               NULL
 kCFXMLNodeTypeNotation             notation name                        CFXMLNotationInfo *
 kCFXMLNodeTypeElementTypeDeclaration     tag name                       CFXMLElementTypeDeclarationInfo *
 kCFXMLNodeTypeAttributeListDeclaration   tag name                       CFXMLAttributeListDeclarationInfo *
*/
/*
 *  CFXMLNodeGetTypeID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTypeID )
CFXMLNodeGetTypeID(void);


/* Creates a new node based on xmlType, dataString, and additionalInfoPtr.  version (together with xmlType) determines the expected structure of additionalInfoPtr */
/*
 *  CFXMLNodeCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFXMLNodeRef )
CFXMLNodeCreate(
  CFAllocatorRef      alloc,
  CFXMLNodeTypeCode   xmlType,
  CFStringRef         dataString,
  const void *        additionalInfoPtr,
  CFIndex             version);


/* Creates a copy of origNode (which may not be NULL). */
/*
 *  CFXMLNodeCreateCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFXMLNodeRef )
CFXMLNodeCreateCopy(
  CFAllocatorRef   alloc,
  CFXMLNodeRef     origNode);


/*
 *  CFXMLNodeGetTypeCode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFXMLNodeTypeCode )
CFXMLNodeGetTypeCode(CFXMLNodeRef node);


/*
 *  CFXMLNodeGetString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFXMLNodeGetString(CFXMLNodeRef node);


/*
 *  CFXMLNodeGetInfoPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( const void * )
CFXMLNodeGetInfoPtr(CFXMLNodeRef node);


/*
 *  CFXMLNodeGetVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFIndex )
CFXMLNodeGetVersion(CFXMLNodeRef node);


/* CFXMLTreeRef */
/* Creates a childless, parentless tree from node */
/*
 *  CFXMLTreeCreateWithNode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFXMLTreeRef )
CFXMLTreeCreateWithNode(
  CFAllocatorRef   allocator,
  CFXMLNodeRef     node);


/* Extracts and returns the node stored in xmlTree */
/*
 *  CFXMLTreeGetNode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFXMLNodeRef )
CFXMLTreeGetNode(CFXMLTreeRef xmlTree);



#if PRAGMA_ENUM_ALWAYSINT
    #pragma enumsalwaysint reset
    #ifdef __CFXMLNODE__RESTORE_TWOBYTEINTS
        #pragma fourbyteints off
    #endif
#elif PRAGMA_ENUM_OPTIONS
    #pragma option enum=reset
#elif defined(__CFXMLNODE__RESTORE_PACKED_ENUMS)
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

#endif /* __CFXMLNODE__ */

