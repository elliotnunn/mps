{
     File:       CFXMLNode.p
 
     Contains:   CoreFoundation XML Node and XML Tree
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CFXMLNode;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFXMLNODE__}
{$SETC __CFXMLNODE__ := 1}

{$I+}
{$SETC CFXMLNodeIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFARRAY__}
{$I CFArray.p}
{$ENDC}
{$IFC UNDEFINED __CFDICTIONARY__}
{$I CFDictionary.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{$IFC UNDEFINED __CFTREE__}
{$I CFTree.p}
{$ENDC}
{$IFC UNDEFINED __CFURL__}
{$I CFURL.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CFXMLNodeRef    = ^LONGINT; { an opaque 32-bit type }
	CFXMLNodeRefPtr = ^CFXMLNodeRef;  { when a VAR xx:CFXMLNodeRef parameter can be nil, it is changed to xx: CFXMLNodeRefPtr }
	CFXMLTreeRef						= CFTreeRef;
	{	  An CFXMLNode describes an individual XML construct - like a tag, or a comment, or a string
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
	    	}

CONST
	kCFXMLNodeCurrentVersion	= 1;

	{	 Type codes for the different possible XML nodes; this list may grow.	}

TYPE
	CFXMLNodeTypeCode 			= SInt32;
CONST
	kCFXMLNodeTypeDocument		= 1;
	kCFXMLNodeTypeElement		= 2;
	kCFXMLNodeTypeAttribute		= 3;
	kCFXMLNodeTypeProcessingInstruction = 4;
	kCFXMLNodeTypeComment		= 5;
	kCFXMLNodeTypeText			= 6;
	kCFXMLNodeTypeCDATASection	= 7;
	kCFXMLNodeTypeDocumentFragment = 8;
	kCFXMLNodeTypeEntity		= 9;
	kCFXMLNodeTypeEntityReference = 10;
	kCFXMLNodeTypeDocumentType	= 11;
	kCFXMLNodeTypeWhitespace	= 12;
	kCFXMLNodeTypeNotation		= 13;
	kCFXMLNodeTypeElementTypeDeclaration = 14;
	kCFXMLNodeTypeAttributeListDeclaration = 15;


TYPE
	CFXMLElementInfoPtr = ^CFXMLElementInfo;
	CFXMLElementInfo = RECORD
		attributes:				CFDictionaryRef;
		attributeOrder:			CFArrayRef;
		isEmpty:				BOOLEAN;
	END;

	CFXMLProcessingInstructionInfoPtr = ^CFXMLProcessingInstructionInfo;
	CFXMLProcessingInstructionInfo = RECORD
		dataString:				CFStringRef;
	END;

	CFXMLDocumentInfoPtr = ^CFXMLDocumentInfo;
	CFXMLDocumentInfo = RECORD
		sourceURL:				CFURLRef;
		encoding:				CFStringEncoding;
	END;

	CFXMLExternalIDPtr = ^CFXMLExternalID;
	CFXMLExternalID = RECORD
		systemID:				CFURLRef;
		publicID:				CFStringRef;
	END;

	CFXMLDocumentTypeInfoPtr = ^CFXMLDocumentTypeInfo;
	CFXMLDocumentTypeInfo = RECORD
		externalID:				CFXMLExternalID;
	END;

	CFXMLNotationInfoPtr = ^CFXMLNotationInfo;
	CFXMLNotationInfo = RECORD
		externalID:				CFXMLExternalID;
	END;

	CFXMLElementTypeDeclarationInfoPtr = ^CFXMLElementTypeDeclarationInfo;
	CFXMLElementTypeDeclarationInfo = RECORD
																		{  This is expected to change in future versions  }
		contentDescription:		CFStringRef;
	END;

	CFXMLAttributeDeclarationInfoPtr = ^CFXMLAttributeDeclarationInfo;
	CFXMLAttributeDeclarationInfo = RECORD
																		{  This is expected to change in future versions  }
		attributeName:			CFStringRef;
		typeString:				CFStringRef;
		defaultString:			CFStringRef;
	END;

	CFXMLAttributeListDeclarationInfoPtr = ^CFXMLAttributeListDeclarationInfo;
	CFXMLAttributeListDeclarationInfo = RECORD
		numberOfAttributes:		CFIndex;
		attributes:				CFXMLAttributeDeclarationInfoPtr;
	END;

	CFXMLEntityTypeCode 		= SInt32;
CONST
	kCFXMLEntityTypeParameter	= 0;							{  Implies parsed, internal  }
	kCFXMLEntityTypeParsedInternal = 1;
	kCFXMLEntityTypeParsedExternal = 2;
	kCFXMLEntityTypeUnparsed	= 3;
	kCFXMLEntityTypeCharacter	= 4;


TYPE
	CFXMLEntityInfoPtr = ^CFXMLEntityInfo;
	CFXMLEntityInfo = RECORD
		entityType:				CFXMLEntityTypeCode;
		replacementText:		CFStringRef;							{  NULL if entityType is external or unparsed  }
		entityID:				CFXMLExternalID;						{  entityID.systemID will be NULL if entityType is internal  }
		notationName:			CFStringRef;							{  NULL if entityType is parsed  }
	END;

	CFXMLEntityReferenceInfoPtr = ^CFXMLEntityReferenceInfo;
	CFXMLEntityReferenceInfo = RECORD
		entityType:				CFXMLEntityTypeCode;
	END;

	{	
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
		}
	{
	 *  CFXMLNodeGetTypeID()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFXMLNodeGetTypeID: CFTypeID; C;

{ Creates a new node based on xmlType, dataString, and additionalInfoPtr.  version (together with xmlType) determines the expected structure of additionalInfoPtr }
{
 *  CFXMLNodeCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFXMLNodeCreate(alloc: CFAllocatorRef; xmlType: CFXMLNodeTypeCode; dataString: CFStringRef; additionalInfoPtr: UNIV Ptr; version: CFIndex): CFXMLNodeRef; C;

{ Creates a copy of origNode (which may not be NULL). }
{
 *  CFXMLNodeCreateCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFXMLNodeCreateCopy(alloc: CFAllocatorRef; origNode: CFXMLNodeRef): CFXMLNodeRef; C;

{
 *  CFXMLNodeGetTypeCode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFXMLNodeGetTypeCode(node: CFXMLNodeRef): CFXMLNodeTypeCode; C;

{
 *  CFXMLNodeGetString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFXMLNodeGetString(node: CFXMLNodeRef): CFStringRef; C;

{
 *  CFXMLNodeGetInfoPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFXMLNodeGetInfoPtr(node: CFXMLNodeRef): Ptr; C;

{
 *  CFXMLNodeGetVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFXMLNodeGetVersion(node: CFXMLNodeRef): CFIndex; C;

{ CFXMLTreeRef }
{ Creates a childless, parentless tree from node }
{
 *  CFXMLTreeCreateWithNode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFXMLTreeCreateWithNode(allocator: CFAllocatorRef; node: CFXMLNodeRef): CFXMLTreeRef; C;

{ Extracts and returns the node stored in xmlTree }
{
 *  CFXMLTreeGetNode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFXMLTreeGetNode(xmlTree: CFXMLTreeRef): CFXMLNodeRef; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFXMLNodeIncludes}

{$ENDC} {__CFXMLNODE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
