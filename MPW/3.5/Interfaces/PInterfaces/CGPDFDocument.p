{
     File:       CGPDFDocument.p
 
     Contains:   xxx put contents here xxx
 
     Version:    Technology: from CoreGraphics-70.root
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CGPDFDocument;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CGPDFDOCUMENT__}
{$SETC __CGPDFDOCUMENT__ := 1}

{$I+}
{$SETC CGPDFDocumentIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CGBASE__}
{$I CGBase.p}
{$ENDC}
{$IFC UNDEFINED __CGDATAPROVIDER__}
{$I CGDataProvider.p}
{$ENDC}
{$IFC UNDEFINED __CGGEOMETRY__}
{$I CGGeometry.p}
{$ENDC}
{$IFC UNDEFINED __CFURL__}
{$I CFURL.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CGPDFDocumentRef    = ^LONGINT; { an opaque 32-bit type }
	CGPDFDocumentRefPtr = ^CGPDFDocumentRef;  { when a VAR xx:CGPDFDocumentRef parameter can be nil, it is changed to xx: CGPDFDocumentRefPtr }
	{	 Create a PDF document, using `provider' to obtain the document's
	 * data. 	}
	{
	 *  CGPDFDocumentCreateWithProvider()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CGPDFDocumentCreateWithProvider(provider: CGDataProviderRef): CGPDFDocumentRef; C;

{ Create a PDF document from `url'. }
{
 *  CGPDFDocumentCreateWithURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPDFDocumentCreateWithURL(url: CFURLRef): CGPDFDocumentRef; C;

{ Increment the retain count of `document' and return it.  All PDF
 * documents are created with an initial retain count of 1. }
{
 *  CGPDFDocumentRetain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPDFDocumentRetain(document: CGPDFDocumentRef): CGPDFDocumentRef; C;

{ Decrement the retain count of `document'.  If the retain count reaches 0,
 * then free it and any associated resources. }
{
 *  CGPDFDocumentRelease()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CGPDFDocumentRelease(document: CGPDFDocumentRef); C;

{ Return the number of pages in `document'. }
{
 *  CGPDFDocumentGetNumberOfPages()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPDFDocumentGetNumberOfPages(document: CGPDFDocumentRef): LONGINT; C;

{ Return the media box of page number `page' in `document'. }
{
 *  CGPDFDocumentGetMediaBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPDFDocumentGetMediaBox(document: CGPDFDocumentRef; page: LONGINT): CGRect; C;

{ Return the crop box of page number `page' in `document'. }
{
 *  CGPDFDocumentGetCropBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPDFDocumentGetCropBox(document: CGPDFDocumentRef; page: LONGINT): CGRect; C;

{ Return the bleed box of page number `page' in `document'. }
{
 *  CGPDFDocumentGetBleedBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPDFDocumentGetBleedBox(document: CGPDFDocumentRef; page: LONGINT): CGRect; C;

{ Return the trim box of page number `page' in `document'. }
{
 *  CGPDFDocumentGetTrimBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPDFDocumentGetTrimBox(document: CGPDFDocumentRef; page: LONGINT): CGRect; C;

{ Return the art box of page number `page' in `document'. }
{
 *  CGPDFDocumentGetArtBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPDFDocumentGetArtBox(document: CGPDFDocumentRef; page: LONGINT): CGRect; C;

{ Return the rotation angle (in degrees) of page number `page' in
 * `document'. }
{
 *  CGPDFDocumentGetRotationAngle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPDFDocumentGetRotationAngle(document: CGPDFDocumentRef; page: LONGINT): LONGINT; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CGPDFDocumentIncludes}

{$ENDC} {__CGPDFDOCUMENT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
