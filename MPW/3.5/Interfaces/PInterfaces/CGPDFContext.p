{
     File:       CGPDFContext.p
 
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
 UNIT CGPDFContext;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CGPDFCONTEXT__}
{$SETC __CGPDFCONTEXT__ := 1}

{$I+}
{$SETC CGPDFContextIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CGBASE__}
{$I CGBase.p}
{$ENDC}
{$IFC UNDEFINED __CGCONTEXT__}
{$I CGContext.p}
{$ENDC}
{$IFC UNDEFINED __CGDATACONSUMER__}
{$I CGDataConsumer.p}
{$ENDC}
{$IFC UNDEFINED __CFDICTIONARY__}
{$I CFDictionary.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Create a PDF context, using `consumer' for output. `mediaBox' is the
 * default page media bounding box; if NULL, then a default page size is
 * used.  `auxiliaryInfo' specifies additional information used by the PDF
 * context when generating PDF.  The keys and values in `auxiliaryInfo'
 * must be CFStrings.  The following keys are recognized:
 *    Key      Value
 *    Title    The document's title.
 *    Author   The name of the person who created the document.
 *    Creator  If the document was converted to PDF from another format,
 *             the name of the application that created the original
 *             document from which it was converted.
 *    Producer If the document was converted to PDF from another format,
 *             the name of the application that converted it to PDF. }
{
 *  CGPDFContextCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPDFContextCreate(consumer: CGDataConsumerRef; {CONST}VAR mediaBox: CGRect; auxiliaryInfo: CFDictionaryRef): CGContextRef; C;

{ Convenience function: create a PDF context, writing to `url'. }
{
 *  CGPDFContextCreateWithURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPDFContextCreateWithURL(url: CFURLRef; {CONST}VAR mediaBox: CGRect; auxiliaryInfo: CFDictionaryRef): CGContextRef; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CGPDFContextIncludes}

{$ENDC} {__CGPDFCONTEXT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
