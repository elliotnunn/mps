{
     File:       GXGraphics.p
 
     Contains:   QuickDraw GX graphic routine interfaces.
 
     Version:    Technology: Quickdraw GX 1.1
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT GXGraphics;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __GXGRAPHICS__}
{$SETC __GXGRAPHICS__ := 1}

{$I+}
{$SETC GXGraphicsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FONTS__}
{$I Fonts.p}
{$ENDC}
{$IFC UNDEFINED __GXERRORS__}
{$I GXErrors.p}
{$ENDC}
{$IFC UNDEFINED __GXTYPES__}
{$I GXTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC CALL_NOT_IN_CARBON }
{
 *  GXNewGraphicsClient()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewGraphicsClient(memoryStart: UNIV Ptr; memoryLength: LONGINT; attributes: gxClientAttribute): gxGraphicsClient; C;
{
 *  GXGetGraphicsClient()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetGraphicsClient: gxGraphicsClient; C;
{
 *  GXSetGraphicsClient()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetGraphicsClient(client: gxGraphicsClient); C;
{
 *  GXDisposeGraphicsClient()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDisposeGraphicsClient(client: gxGraphicsClient); C;
{$ENDC}  {CALL_NOT_IN_CARBON}

{returns the count }
{$IFC CALL_NOT_IN_CARBON }
{
 *  GXGetGraphicsClients()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetGraphicsClients(index: LONGINT; count: LONGINT; VAR clients: gxGraphicsClient): LONGINT; C;
{
 *  GXEnterGraphics()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXEnterGraphics; C;
{
 *  GXExitGraphics()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXExitGraphics; C;
{
 *  GXGetGraphicsError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetGraphicsError(VAR stickyError: gxGraphicsError): gxGraphicsError; C;
{
 *  GXGetGraphicsNotice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetGraphicsNotice(VAR stickyNotice: gxGraphicsNotice): gxGraphicsNotice; C;
{
 *  GXGetGraphicsWarning()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetGraphicsWarning(VAR stickyWarning: gxGraphicsWarning): gxGraphicsWarning; C;
{
 *  GXPostGraphicsError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXPostGraphicsError(error: gxGraphicsError); C;
{
 *  GXPostGraphicsWarning()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXPostGraphicsWarning(warning: gxGraphicsWarning); C;
{
 *  GXGetUserGraphicsError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetUserGraphicsError(VAR reference: LONGINT): gxUserErrorUPP; C;
{
 *  GXGetUserGraphicsNotice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetUserGraphicsNotice(VAR reference: LONGINT): gxUserNoticeUPP; C;
{
 *  GXGetUserGraphicsWarning()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetUserGraphicsWarning(VAR reference: LONGINT): gxUserWarningUPP; C;
{
 *  GXSetUserGraphicsError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetUserGraphicsError(userFunction: gxUserErrorUPP; reference: LONGINT); C;
{
 *  GXSetUserGraphicsNotice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetUserGraphicsNotice(userFunction: gxUserNoticeUPP; reference: LONGINT); C;
{
 *  GXSetUserGraphicsWarning()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetUserGraphicsWarning(userFunction: gxUserWarningUPP; reference: LONGINT); C;
{
 *  GXIgnoreGraphicsWarning()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXIgnoreGraphicsWarning(warning: gxGraphicsWarning); C;
{
 *  GXPopGraphicsWarning()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXPopGraphicsWarning; C;
{
 *  GXNewShapeVector()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewShapeVector(aType: gxShapeType; {CONST}VAR vector: Fixed): gxShape; C;
{
 *  GXSetShapeVector()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeVector(target: gxShape; {CONST}VAR vector: Fixed); C;
{
 *  GXNewBitmap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewBitmap({CONST}VAR data: gxBitmap; {CONST}VAR position: gxPoint): gxShape; C;
{
 *  GXNewCurve()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewCurve({CONST}VAR data: gxCurve): gxShape; C;
{
 *  GXNewGlyphs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewGlyphs(charCount: LONGINT; {CONST}VAR text: UInt8; {CONST}VAR positions: gxPoint; {CONST}VAR advance: LONGINT; {CONST}VAR tangents: gxPoint; {CONST}VAR styleRuns: INTEGER; {CONST}VAR glyphStyles: gxStyle): gxShape; C;
{
 *  GXNewLine()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewLine({CONST}VAR data: gxLine): gxShape; C;
{
 *  GXNewPaths()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewPaths({CONST}VAR data: gxPaths): gxShape; C;
{
 *  GXNewPicture()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewPicture(count: LONGINT; {CONST}VAR shapes: gxShape; {CONST}VAR styles: gxStyle; {CONST}VAR inks: gxInk; {CONST}VAR transforms: gxTransform): gxShape; C;
{
 *  GXNewPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewPoint({CONST}VAR data: gxPoint): gxShape; C;
{
 *  GXNewPolygons()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewPolygons({CONST}VAR data: gxPolygons): gxShape; C;
{
 *  GXNewRectangle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewRectangle({CONST}VAR data: gxRectangle): gxShape; C;
{
 *  GXNewText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewText(charCount: LONGINT; {CONST}VAR text: UInt8; {CONST}VAR position: gxPoint): gxShape; C;
{
 *  GXGetBitmap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetBitmap(source: gxShape; VAR data: gxBitmap; VAR position: gxPoint): gxBitmapPtr; C;
{
 *  GXGetCurve()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetCurve(source: gxShape; VAR data: gxCurve): gxCurvePtr; C;
{ returns byte length of glyphs }
{
 *  GXGetGlyphs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetGlyphs(source: gxShape; VAR charCount: LONGINT; VAR text: UInt8; VAR positions: gxPoint; VAR advance: LONGINT; VAR tangents: gxPoint; VAR runCount: LONGINT; VAR styleRuns: INTEGER; VAR glyphStyles: gxStyle): LONGINT; C;
{
 *  GXGetLine()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetLine(source: gxShape; VAR data: gxLine): gxLinePtr; C;
{ returns byte length }
{
 *  GXGetPaths()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetPaths(source: gxShape; VAR data: gxPaths): LONGINT; C;
{ returns count }
{
 *  GXGetPicture()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetPicture(source: gxShape; VAR shapes: gxShape; VAR styles: gxStyle; VAR inks: gxInk; VAR transforms: gxTransform): LONGINT; C;
{
 *  GXGetPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetPoint(source: gxShape; VAR data: gxPoint): gxPointPtr; C;
{ returns byte length }
{
 *  GXGetPolygons()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetPolygons(source: gxShape; VAR data: gxPolygons): LONGINT; C;
{
 *  GXGetRectangle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetRectangle(source: gxShape; VAR data: gxRectangle): gxRectanglePtr; C;
{ returns byte length }
{
 *  GXGetText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetText(source: gxShape; VAR charCount: LONGINT; VAR text: UInt8; VAR position: gxPoint): LONGINT; C;
{
 *  GXSetBitmap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetBitmap(target: gxShape; {CONST}VAR data: gxBitmap; {CONST}VAR position: gxPoint); C;
{
 *  GXSetCurve()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetCurve(target: gxShape; {CONST}VAR data: gxCurve); C;
{
 *  GXSetGlyphs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetGlyphs(target: gxShape; charCount: LONGINT; {CONST}VAR text: UInt8; {CONST}VAR positions: gxPoint; {CONST}VAR advance: LONGINT; {CONST}VAR tangents: gxPoint; {CONST}VAR styleRuns: INTEGER; {CONST}VAR glyphStyles: gxStyle); C;
{
 *  GXSetLine()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetLine(target: gxShape; {CONST}VAR data: gxLine); C;
{
 *  GXSetPaths()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetPaths(target: gxShape; {CONST}VAR data: gxPaths); C;
{
 *  GXSetPicture()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetPicture(target: gxShape; count: LONGINT; {CONST}VAR shapes: gxShape; {CONST}VAR styles: gxStyle; {CONST}VAR inks: gxInk; {CONST}VAR transforms: gxTransform); C;
{
 *  GXSetPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetPoint(target: gxShape; {CONST}VAR data: gxPoint); C;
{
 *  GXSetPolygons()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetPolygons(target: gxShape; {CONST}VAR data: gxPolygons); C;
{
 *  GXSetRectangle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetRectangle(target: gxShape; {CONST}VAR data: gxRectangle); C;
{
 *  GXSetText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetText(target: gxShape; charCount: LONGINT; {CONST}VAR text: UInt8; {CONST}VAR position: gxPoint); C;
{
 *  GXDrawBitmap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDrawBitmap({CONST}VAR data: gxBitmap; {CONST}VAR position: gxPoint); C;
{
 *  GXDrawCurve()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDrawCurve({CONST}VAR data: gxCurve); C;
{
 *  GXDrawGlyphs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDrawGlyphs(charCount: LONGINT; {CONST}VAR text: UInt8; {CONST}VAR positions: gxPoint; {CONST}VAR advance: LONGINT; {CONST}VAR tangents: gxPoint; {CONST}VAR styleRuns: INTEGER; {CONST}VAR glyphStyles: gxStyle); C;
{
 *  GXDrawLine()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDrawLine({CONST}VAR data: gxLine); C;
{
 *  GXDrawPaths()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDrawPaths({CONST}VAR data: gxPaths; fill: gxShapeFill); C;
{
 *  GXDrawPicture()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDrawPicture(count: LONGINT; {CONST}VAR shapes: gxShape; {CONST}VAR styles: gxStyle; {CONST}VAR inks: gxInk; {CONST}VAR transforms: gxTransform); C;
{
 *  GXDrawPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDrawPoint({CONST}VAR data: gxPoint); C;
{
 *  GXDrawPolygons()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDrawPolygons({CONST}VAR data: gxPolygons; fill: gxShapeFill); C;
{
 *  GXDrawRectangle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDrawRectangle({CONST}VAR data: gxRectangle; fill: gxShapeFill); C;
{
 *  GXDrawText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDrawText(charCount: LONGINT; {CONST}VAR text: UInt8; {CONST}VAR position: gxPoint); C;
{
 *  GXNewColorProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewColorProfile(size: LONGINT; colorProfileData: UNIV Ptr): gxColorProfile; C;
{
 *  GXNewColorSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewColorSet(space: gxColorSpace; count: LONGINT; {CONST}VAR colors: gxSetColor): gxColorSet; C;
{
 *  GXNewInk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewInk: gxInk; C;
{
 *  GXNewShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewShape(aType: gxShapeType): gxShape; C;
{
 *  GXNewStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewStyle: gxStyle; C;
{
 *  GXNewTag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewTag(tagType: LONGINT; length: LONGINT; data: UNIV Ptr): gxTag; C;
{
 *  GXNewTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewTransform: gxTransform; C;
{
 *  GXNewViewDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewViewDevice(group: gxViewGroup; bitmapShape: gxShape): gxViewDevice; C;
{
 *  GXNewViewGroup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewViewGroup: gxViewGroup; C;
{
 *  GXNewViewPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewViewPort(group: gxViewGroup): gxViewPort; C;
{
 *  GXDisposeColorProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDisposeColorProfile(target: gxColorProfile); C;
{
 *  GXDisposeColorSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDisposeColorSet(target: gxColorSet); C;
{
 *  GXDisposeInk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDisposeInk(target: gxInk); C;
{
 *  GXDisposeShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDisposeShape(target: gxShape); C;
{
 *  GXDisposeStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDisposeStyle(target: gxStyle); C;
{
 *  GXDisposeTag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDisposeTag(target: gxTag); C;
{
 *  GXDisposeTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDisposeTransform(target: gxTransform); C;
{
 *  GXDisposeViewDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDisposeViewDevice(target: gxViewDevice); C;
{
 *  GXDisposeViewGroup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDisposeViewGroup(target: gxViewGroup); C;
{
 *  GXDisposeViewPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDisposeViewPort(target: gxViewPort); C;
{
 *  GXCloneColorProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCloneColorProfile(source: gxColorProfile): gxColorProfile; C;
{
 *  GXCloneColorSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCloneColorSet(source: gxColorSet): gxColorSet; C;
{
 *  GXCloneInk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCloneInk(source: gxInk): gxInk; C;
{
 *  GXCloneShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCloneShape(source: gxShape): gxShape; C;
{
 *  GXCloneStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCloneStyle(source: gxStyle): gxStyle; C;
{
 *  GXCloneTag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCloneTag(source: gxTag): gxTag; C;
{
 *  GXCloneTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCloneTransform(source: gxTransform): gxTransform; C;
{
 *  GXCopyToColorProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCopyToColorProfile(target: gxColorProfile; source: gxColorProfile): gxColorProfile; C;
{
 *  GXCopyToColorSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCopyToColorSet(target: gxColorSet; source: gxColorSet): gxColorSet; C;
{
 *  GXCopyToInk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCopyToInk(target: gxInk; source: gxInk): gxInk; C;
{
 *  GXCopyToShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCopyToShape(target: gxShape; source: gxShape): gxShape; C;
{
 *  GXCopyToStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCopyToStyle(target: gxStyle; source: gxStyle): gxStyle; C;
{
 *  GXCopyToTag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCopyToTag(target: gxTag; source: gxTag): gxTag; C;
{
 *  GXCopyToTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCopyToTransform(target: gxTransform; source: gxTransform): gxTransform; C;
{
 *  GXCopyToViewDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCopyToViewDevice(target: gxViewDevice; source: gxViewDevice): gxViewDevice; C;
{
 *  GXCopyToViewPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCopyToViewPort(target: gxViewPort; source: gxViewPort): gxViewPort; C;
{
 *  GXEqualColorProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXEqualColorProfile(one: gxColorProfile; two: gxColorProfile): BOOLEAN; C;
{
 *  GXEqualColorSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXEqualColorSet(one: gxColorSet; two: gxColorSet): BOOLEAN; C;
{
 *  GXEqualInk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXEqualInk(one: gxInk; two: gxInk): BOOLEAN; C;
{
 *  GXEqualShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXEqualShape(one: gxShape; two: gxShape): BOOLEAN; C;
{
 *  GXEqualStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXEqualStyle(one: gxStyle; two: gxStyle): BOOLEAN; C;
{
 *  GXEqualTag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXEqualTag(one: gxTag; two: gxTag): BOOLEAN; C;
{
 *  GXEqualTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXEqualTransform(one: gxTransform; two: gxTransform): BOOLEAN; C;
{
 *  GXEqualViewDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXEqualViewDevice(one: gxViewDevice; two: gxViewDevice): BOOLEAN; C;
{
 *  GXEqualViewPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXEqualViewPort(one: gxViewPort; two: gxViewPort): BOOLEAN; C;
{
 *  GXResetInk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXResetInk(target: gxInk); C;
{
 *  GXResetShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXResetShape(target: gxShape); C;
{
 *  GXResetStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXResetStyle(target: gxStyle); C;
{
 *  GXResetTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXResetTransform(target: gxTransform); C;
{
 *  GXLoadColorProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXLoadColorProfile(target: gxColorProfile); C;
{
 *  GXLoadColorSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXLoadColorSet(target: gxColorSet); C;
{
 *  GXLoadInk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXLoadInk(target: gxInk); C;
{
 *  GXLoadShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXLoadShape(target: gxShape); C;
{
 *  GXLoadStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXLoadStyle(target: gxStyle); C;
{
 *  GXLoadTag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXLoadTag(target: gxTag); C;
{
 *  GXLoadTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXLoadTransform(target: gxTransform); C;
{
 *  GXUnloadColorProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXUnloadColorProfile(target: gxColorProfile); C;
{
 *  GXUnloadColorSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXUnloadColorSet(target: gxColorSet); C;
{
 *  GXUnloadInk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXUnloadInk(target: gxInk); C;
{
 *  GXUnloadShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXUnloadShape(target: gxShape); C;
{
 *  GXUnloadStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXUnloadStyle(target: gxStyle); C;
{
 *  GXUnloadTag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXUnloadTag(target: gxTag); C;
{
 *  GXUnloadTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXUnloadTransform(target: gxTransform); C;
{
 *  GXCacheShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXCacheShape(source: gxShape); C;
{
 *  GXCopyDeepToShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCopyDeepToShape(target: gxShape; source: gxShape): gxShape; C;
{
 *  GXDrawShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDrawShape(source: gxShape); C;
{
 *  GXDisposeShapeCache()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDisposeShapeCache(target: gxShape); C;
{
 *  GXGetDefaultColorProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetDefaultColorProfile: gxColorProfile; C;
{
 *  GXGetDefaultShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetDefaultShape(aType: gxShapeType): gxShape; C;
{
 *  GXGetDefaultColorSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetDefaultColorSet(pixelDepth: LONGINT): gxColorSet; C;

{
 *  GXSetDefaultShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetDefaultShape(target: gxShape); C;
{
 *  GXSetDefaultColorSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetDefaultColorSet(target: gxColorSet; pixelDepth: LONGINT); C;
{
 *  GXGetTag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetTag(source: gxTag; VAR tagType: LONGINT; data: UNIV Ptr): LONGINT; C;
{
 *  GXSetTag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetTag(target: gxTag; tagType: LONGINT; length: LONGINT; data: UNIV Ptr); C;
{
 *  GXGetShapeBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeBounds(source: gxShape; index: LONGINT; VAR bounds: gxRectangle): gxRectanglePtr; C;
{
 *  GXGetShapeFill()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeFill(source: gxShape): gxShapeFill; C;
{
 *  GXGetShapeInk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeInk(source: gxShape): gxInk; C;
{
 *  GXGetShapePixel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapePixel(source: gxShape; x: LONGINT; y: LONGINT; VAR data: gxColor; VAR index: LONGINT): LONGINT; C;
{
 *  GXGetShapeStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeStyle(source: gxShape): gxStyle; C;
{
 *  GXGetShapeTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeTransform(source: gxShape): gxTransform; C;
{
 *  GXGetShapeType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeType(source: gxShape): gxShapeType; C;
{
 *  GXGetShapeTypographicBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeTypographicBounds(source: gxShape; VAR bounds: gxRectangle): gxRectanglePtr; C;
{
 *  GXGetBitmapParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetBitmapParts(source: gxShape; {CONST}VAR bounds: gxLongRectangle): gxShape; C;
{
 *  GXGetStyleFontMetrics()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXGetStyleFontMetrics(sourceStyle: gxStyle; VAR before: gxPoint; VAR after: gxPoint; VAR caretAngle: gxPoint; VAR caretOffset: gxPoint); C;
{
 *  GXGetShapeFontMetrics()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXGetShapeFontMetrics(source: gxShape; VAR before: gxPoint; VAR after: gxPoint; VAR caretAngle: gxPoint; VAR caretOffset: gxPoint); C;
{
 *  GXSetShapeBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeBounds(target: gxShape; {CONST}VAR newBounds: gxRectangle); C;
{
 *  GXSetShapeFill()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeFill(target: gxShape; newFill: gxShapeFill); C;
{
 *  GXSetShapeInk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeInk(target: gxShape; newInk: gxInk); C;
{
 *  GXSetShapePixel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapePixel(target: gxShape; x: LONGINT; y: LONGINT; {CONST}VAR newColor: gxColor; newIndex: LONGINT); C;
{
 *  GXSetShapeStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeStyle(target: gxShape; newStyle: gxStyle); C;
{
 *  GXSetShapeTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeTransform(target: gxShape; newTransform: gxTransform); C;
{
 *  GXSetShapeType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeType(target: gxShape; newType: gxShapeType); C;
{
 *  GXSetBitmapParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetBitmapParts(target: gxShape; {CONST}VAR bounds: gxLongRectangle; bitmapShape: gxShape); C;
{
 *  GXSetShapeGeometry()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeGeometry(target: gxShape; geometry: gxShape); C;
{
 *  GXGetShapeCurveError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeCurveError(source: gxShape): Fixed; C;
{
 *  GXGetShapeDash()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeDash(source: gxShape; VAR dash: gxDashRecord): gxDashRecordPtr; C;
{
 *  GXGetShapeCap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeCap(source: gxShape; VAR cap: gxCapRecord): gxCapRecordPtr; C;
{ returns the number of layers }
{
 *  GXGetShapeFace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeFace(source: gxShape; VAR face: gxTextFace): LONGINT; C;
{
 *  GXGetShapeFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeFont(source: gxShape): gxFont; C;
{
 *  GXGetShapeJoin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeJoin(source: gxShape; VAR join: gxJoinRecord): gxJoinRecordPtr; C;
{
 *  GXGetShapeJustification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeJustification(source: gxShape): Fract; C;
{
 *  GXGetShapePattern()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapePattern(source: gxShape; VAR pattern: gxPatternRecord): gxPatternRecordPtr; C;
{
 *  GXGetShapePen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapePen(source: gxShape): Fixed; C;
{
 *  GXGetShapeEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeEncoding(source: gxShape; VAR script: gxFontScript; VAR language: gxFontLanguage): gxFontPlatform; C;
{
 *  GXGetShapeTextSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeTextSize(source: gxShape): Fixed; C;
{
 *  GXGetShapeFontVariations()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeFontVariations(source: gxShape; VAR variations: gxFontVariation): LONGINT; C;
{
 *  GXGetShapeFontVariationSuite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeFontVariationSuite(source: gxShape; VAR variations: gxFontVariation): LONGINT; C;
{
 *  GXGetStyleCurveError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleCurveError(source: gxStyle): Fixed; C;
{
 *  GXGetStyleDash()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleDash(source: gxStyle; VAR dash: gxDashRecord): gxDashRecordPtr; C;
{
 *  GXGetStyleCap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleCap(source: gxStyle; VAR cap: gxCapRecord): gxCapRecordPtr; C;
{ returns the number of layers }
{
 *  GXGetStyleFace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleFace(source: gxStyle; VAR face: gxTextFace): LONGINT; C;
{
 *  GXGetStyleFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleFont(source: gxStyle): gxFont; C;
{
 *  GXGetStyleJoin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleJoin(source: gxStyle; VAR join: gxJoinRecord): gxJoinRecordPtr; C;
{
 *  GXGetStyleJustification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleJustification(source: gxStyle): Fract; C;
{
 *  GXGetStylePattern()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStylePattern(source: gxStyle; VAR pattern: gxPatternRecord): gxPatternRecordPtr; C;
{
 *  GXGetStylePen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStylePen(source: gxStyle): Fixed; C;
{
 *  GXGetStyleEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleEncoding(source: gxStyle; VAR script: gxFontScript; VAR language: gxFontLanguage): gxFontPlatform; C;
{
 *  GXGetStyleTextSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleTextSize(source: gxStyle): Fixed; C;
{
 *  GXGetStyleFontVariations()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleFontVariations(source: gxStyle; VAR variations: gxFontVariation): LONGINT; C;
{
 *  GXGetStyleFontVariationSuite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleFontVariationSuite(source: gxStyle; VAR variations: gxFontVariation): LONGINT; C;
{
 *  GXSetShapeCurveError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeCurveError(target: gxShape; error: Fixed); C;
{
 *  GXSetShapeDash()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeDash(target: gxShape; {CONST}VAR dash: gxDashRecord); C;
{
 *  GXSetShapeCap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeCap(target: gxShape; {CONST}VAR cap: gxCapRecord); C;
{
 *  GXSetShapeFace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeFace(target: gxShape; {CONST}VAR face: gxTextFace); C;
{
 *  GXSetShapeFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeFont(target: gxShape; aFont: gxFont); C;
{
 *  GXSetShapeJoin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeJoin(target: gxShape; {CONST}VAR join: gxJoinRecord); C;
{
 *  GXSetShapeJustification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeJustification(target: gxShape; justify: Fract); C;
{
 *  GXSetShapePattern()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapePattern(target: gxShape; {CONST}VAR pattern: gxPatternRecord); C;
{
 *  GXSetShapePen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapePen(target: gxShape; pen: Fixed); C;
{
 *  GXSetShapeEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeEncoding(target: gxShape; platform: gxFontPlatform; script: gxFontScript; language: gxFontLanguage); C;
{
 *  GXSetShapeTextSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeTextSize(target: gxShape; size: Fixed); C;
{
 *  GXSetShapeFontVariations()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeFontVariations(target: gxShape; count: LONGINT; {CONST}VAR variations: gxFontVariation); C;
{
 *  GXSetStyleCurveError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStyleCurveError(target: gxStyle; error: Fixed); C;
{
 *  GXSetStyleDash()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStyleDash(target: gxStyle; {CONST}VAR dash: gxDashRecord); C;
{
 *  GXSetStyleCap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStyleCap(target: gxStyle; {CONST}VAR cap: gxCapRecord); C;
{
 *  GXSetStyleFace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStyleFace(target: gxStyle; {CONST}VAR face: gxTextFace); C;
{
 *  GXSetStyleFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStyleFont(target: gxStyle; aFont: gxFont); C;
{
 *  GXSetStyleJoin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStyleJoin(target: gxStyle; {CONST}VAR join: gxJoinRecord); C;
{
 *  GXSetStyleJustification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStyleJustification(target: gxStyle; justify: Fract); C;
{
 *  GXSetStylePattern()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStylePattern(target: gxStyle; {CONST}VAR pattern: gxPatternRecord); C;
{
 *  GXSetStylePen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStylePen(target: gxStyle; pen: Fixed); C;
{
 *  GXSetStyleEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStyleEncoding(target: gxStyle; platform: gxFontPlatform; script: gxFontScript; language: gxFontLanguage); C;
{
 *  GXSetStyleTextSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStyleTextSize(target: gxStyle; size: Fixed); C;
{
 *  GXSetStyleFontVariations()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStyleFontVariations(target: gxStyle; count: LONGINT; {CONST}VAR variations: gxFontVariation); C;
{
 *  GXGetShapeColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeColor(source: gxShape; VAR data: gxColor): gxColorPtr; C;
{
 *  GXGetShapeTransfer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeTransfer(source: gxShape; VAR data: gxTransferMode): gxTransferModePtr; C;
{
 *  GXGetInkColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetInkColor(source: gxInk; VAR data: gxColor): gxColorPtr; C;
{
 *  GXGetInkTransfer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetInkTransfer(source: gxInk; VAR data: gxTransferMode): gxTransferModePtr; C;
{
 *  GXSetShapeColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeColor(target: gxShape; {CONST}VAR data: gxColor); C;
{
 *  GXSetShapeTransfer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeTransfer(target: gxShape; {CONST}VAR data: gxTransferMode); C;
{
 *  GXSetInkColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetInkColor(target: gxInk; {CONST}VAR data: gxColor); C;
{
 *  GXSetInkTransfer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetInkTransfer(target: gxInk; {CONST}VAR data: gxTransferMode); C;
{
 *  GXGetShapeClip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeClip(source: gxShape): gxShape; C;
{
 *  GXGetShapeClipType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeClipType(source: gxShape): gxShapeType; C;
{
 *  GXGetShapeMapping()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeMapping(source: gxShape; VAR map: gxMapping): gxMappingPtr; C;
{
 *  GXGetShapeHitTest()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeHitTest(source: gxShape; VAR tolerance: Fixed): gxShapePart; C;
{
 *  GXGetShapeViewPorts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeViewPorts(source: gxShape; VAR list: gxViewPort): LONGINT; C;
{
 *  GXGetTransformClip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetTransformClip(source: gxTransform): gxShape; C;
{
 *  GXGetTransformClipType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetTransformClipType(source: gxTransform): gxShapeType; C;
{
 *  GXGetTransformMapping()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetTransformMapping(source: gxTransform; VAR map: gxMapping): gxMappingPtr; C;
{
 *  GXGetTransformHitTest()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetTransformHitTest(source: gxTransform; VAR tolerance: Fixed): gxShapePart; C;
{
 *  GXGetTransformViewPorts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetTransformViewPorts(source: gxTransform; VAR list: gxViewPort): LONGINT; C;
{
 *  GXSetShapeClip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeClip(target: gxShape; clip: gxShape); C;
{
 *  GXSetShapeMapping()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeMapping(target: gxShape; {CONST}VAR map: gxMapping); C;
{
 *  GXSetShapeHitTest()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeHitTest(target: gxShape; mask: gxShapePart; tolerance: Fixed); C;
{
 *  GXSetShapeViewPorts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeViewPorts(target: gxShape; count: LONGINT; {CONST}VAR list: gxViewPort); C;
{
 *  GXSetTransformClip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetTransformClip(target: gxTransform; clip: gxShape); C;
{
 *  GXSetTransformMapping()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetTransformMapping(target: gxTransform; {CONST}VAR map: gxMapping); C;
{
 *  GXSetTransformHitTest()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetTransformHitTest(target: gxTransform; mask: gxShapePart; tolerance: Fixed); C;
{
 *  GXSetTransformViewPorts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetTransformViewPorts(target: gxTransform; count: LONGINT; {CONST}VAR list: gxViewPort); C;
{
 *  GXGetColorSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetColorSet(source: gxColorSet; VAR space: gxColorSpace; VAR colors: gxSetColor): LONGINT; C;
{
 *  GXGetColorProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetColorProfile(source: gxColorProfile; colorProfileData: UNIV Ptr): LONGINT; C;
{
 *  GXSetColorSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetColorSet(target: gxColorSet; space: gxColorSpace; count: LONGINT; {CONST}VAR colors: gxSetColor); C;
{
 *  GXSetColorProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetColorProfile(target: gxColorProfile; size: LONGINT; colorProfileData: UNIV Ptr); C;
{
 *  GXGetViewDeviceBitmap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewDeviceBitmap(source: gxViewDevice): gxShape; C;
{
 *  GXGetViewDeviceClip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewDeviceClip(source: gxViewDevice): gxShape; C;
{
 *  GXGetViewDeviceMapping()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewDeviceMapping(source: gxViewDevice; VAR map: gxMapping): gxMappingPtr; C;
{
 *  GXGetViewDeviceViewGroup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewDeviceViewGroup(source: gxViewDevice): gxViewGroup; C;
{
 *  GXSetViewDeviceBitmap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetViewDeviceBitmap(target: gxViewDevice; bitmapShape: gxShape); C;
{
 *  GXSetViewDeviceClip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetViewDeviceClip(target: gxViewDevice; clip: gxShape); C;
{
 *  GXSetViewDeviceMapping()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetViewDeviceMapping(target: gxViewDevice; {CONST}VAR map: gxMapping); C;
{
 *  GXSetViewDeviceViewGroup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetViewDeviceViewGroup(target: gxViewDevice; group: gxViewGroup); C;
{
 *  GXGetViewPortChildren()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewPortChildren(source: gxViewPort; VAR list: gxViewPort): LONGINT; C;
{
 *  GXGetViewPortClip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewPortClip(source: gxViewPort): gxShape; C;
{
 *  GXGetViewPortDither()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewPortDither(source: gxViewPort): LONGINT; C;
{
 *  GXGetViewPortHalftone()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewPortHalftone(source: gxViewPort; VAR data: gxHalftone): BOOLEAN; C;
{
 *  GXGetViewPortMapping()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewPortMapping(source: gxViewPort; VAR map: gxMapping): gxMappingPtr; C;
{
 *  GXGetViewPortParent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewPortParent(source: gxViewPort): gxViewPort; C;
{
 *  GXGetViewPortViewGroup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewPortViewGroup(source: gxViewPort): gxViewGroup; C;
{
 *  GXGetViewPortHalftoneMatrix()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewPortHalftoneMatrix(source: gxViewPort; sourceDevice: gxViewDevice; VAR theMatrix: gxHalftoneMatrix): LONGINT; C;
{
 *  GXSetViewPortChildren()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetViewPortChildren(target: gxViewPort; count: LONGINT; {CONST}VAR list: gxViewPort); C;
{
 *  GXSetViewPortClip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetViewPortClip(target: gxViewPort; clip: gxShape); C;
{
 *  GXSetViewPortDither()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetViewPortDither(target: gxViewPort; level: LONGINT); C;
{
 *  GXSetViewPortHalftone()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetViewPortHalftone(target: gxViewPort; {CONST}VAR data: gxHalftone); C;
{
 *  GXSetViewPortMapping()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetViewPortMapping(target: gxViewPort; {CONST}VAR map: gxMapping); C;
{
 *  GXSetViewPortParent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetViewPortParent(target: gxViewPort; parent: gxViewPort); C;
{
 *  GXSetViewPortViewGroup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetViewPortViewGroup(target: gxViewPort; group: gxViewGroup); C;
{
 *  GXGetColorProfileTags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetColorProfileTags(source: gxColorProfile; tagType: LONGINT; index: LONGINT; count: LONGINT; VAR items: gxTag): LONGINT; C;
{
 *  GXGetColorSetTags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetColorSetTags(source: gxColorSet; tagType: LONGINT; index: LONGINT; count: LONGINT; VAR items: gxTag): LONGINT; C;
{
 *  GXGetInkTags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetInkTags(source: gxInk; tagType: LONGINT; index: LONGINT; count: LONGINT; VAR items: gxTag): LONGINT; C;
{
 *  GXGetShapeTags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeTags(source: gxShape; tagType: LONGINT; index: LONGINT; count: LONGINT; VAR items: gxTag): LONGINT; C;
{
 *  GXGetStyleTags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleTags(source: gxStyle; tagType: LONGINT; index: LONGINT; count: LONGINT; VAR items: gxTag): LONGINT; C;
{
 *  GXGetTransformTags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetTransformTags(source: gxTransform; tagType: LONGINT; index: LONGINT; count: LONGINT; VAR items: gxTag): LONGINT; C;
{
 *  GXGetViewDeviceTags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewDeviceTags(source: gxViewDevice; tagType: LONGINT; index: LONGINT; count: LONGINT; VAR items: gxTag): LONGINT; C;
{
 *  GXGetViewPortTags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewPortTags(source: gxViewPort; tagType: LONGINT; index: LONGINT; count: LONGINT; VAR items: gxTag): LONGINT; C;
{
 *  GXSetColorProfileTags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetColorProfileTags(target: gxColorProfile; tagType: LONGINT; index: LONGINT; oldCount: LONGINT; newCount: LONGINT; {CONST}VAR items: gxTag); C;
{
 *  GXSetColorSetTags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetColorSetTags(target: gxColorSet; tagType: LONGINT; index: LONGINT; oldCount: LONGINT; newCount: LONGINT; {CONST}VAR items: gxTag); C;
{
 *  GXSetInkTags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetInkTags(target: gxInk; tagType: LONGINT; index: LONGINT; oldCount: LONGINT; newCount: LONGINT; {CONST}VAR items: gxTag); C;
{
 *  GXSetShapeTags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeTags(target: gxShape; tagType: LONGINT; index: LONGINT; oldCount: LONGINT; newCount: LONGINT; {CONST}VAR items: gxTag); C;
{
 *  GXSetStyleTags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStyleTags(target: gxStyle; tagType: LONGINT; index: LONGINT; oldCount: LONGINT; newCount: LONGINT; {CONST}VAR items: gxTag); C;
{
 *  GXSetTransformTags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetTransformTags(target: gxTransform; tagType: LONGINT; index: LONGINT; oldCount: LONGINT; newCount: LONGINT; {CONST}VAR items: gxTag); C;
{
 *  GXSetViewDeviceTags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetViewDeviceTags(target: gxViewDevice; tagType: LONGINT; index: LONGINT; oldCount: LONGINT; newCount: LONGINT; {CONST}VAR items: gxTag); C;
{
 *  GXSetViewPortTags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetViewPortTags(target: gxViewPort; tagType: LONGINT; index: LONGINT; oldCount: LONGINT; newCount: LONGINT; {CONST}VAR items: gxTag); C;
{
 *  GXGetInkAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetInkAttributes(source: gxInk): gxInkAttribute; C;
{
 *  GXGetShapeAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeAttributes(source: gxShape): gxShapeAttribute; C;
{
 *  GXGetShapeInkAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeInkAttributes(source: gxShape): gxInkAttribute; C;
{
 *  GXGetShapeStyleAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeStyleAttributes(source: gxShape): gxStyleAttribute; C;
{
 *  GXGetStyleAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleAttributes(source: gxStyle): gxStyleAttribute; C;
{
 *  GXGetShapeTextAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeTextAttributes(source: gxShape): gxTextAttribute; C;
{
 *  GXGetStyleTextAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleTextAttributes(source: gxStyle): gxTextAttribute; C;
{
 *  GXGetViewDeviceAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewDeviceAttributes(source: gxViewDevice): gxDeviceAttribute; C;
{
 *  GXGetViewPortAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewPortAttributes(source: gxViewPort): gxPortAttribute; C;
{
 *  GXSetInkAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetInkAttributes(target: gxInk; attributes: gxInkAttribute); C;
{
 *  GXSetShapeAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeAttributes(target: gxShape; attributes: gxShapeAttribute); C;
{
 *  GXSetShapeInkAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeInkAttributes(target: gxShape; attributes: gxInkAttribute); C;
{
 *  GXSetShapeStyleAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeStyleAttributes(target: gxShape; attributes: gxStyleAttribute); C;
{
 *  GXSetStyleAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStyleAttributes(target: gxStyle; attributes: gxStyleAttribute); C;
{
 *  GXSetShapeTextAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeTextAttributes(target: gxShape; attributes: gxTextAttribute); C;
{
 *  GXSetStyleTextAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetStyleTextAttributes(target: gxStyle; attributes: gxTextAttribute); C;
{
 *  GXSetViewDeviceAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetViewDeviceAttributes(target: gxViewDevice; attributes: gxDeviceAttribute); C;
{
 *  GXSetViewPortAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetViewPortAttributes(target: gxViewPort; attributes: gxPortAttribute); C;
{
 *  GXGetColorProfileOwners()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetColorProfileOwners(source: gxColorProfile): LONGINT; C;
{
 *  GXGetColorSetOwners()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetColorSetOwners(source: gxColorSet): LONGINT; C;
{
 *  GXGetInkOwners()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetInkOwners(source: gxInk): LONGINT; C;
{
 *  GXGetShapeOwners()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeOwners(source: gxShape): LONGINT; C;
{
 *  GXGetStyleOwners()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetStyleOwners(source: gxStyle): LONGINT; C;
{
 *  GXGetTagOwners()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetTagOwners(source: gxTag): LONGINT; C;
{
 *  GXGetTransformOwners()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetTransformOwners(source: gxTransform): LONGINT; C;
{
 *  GXLockShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXLockShape(target: gxShape); C;
{
 *  GXLockTag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXLockTag(target: gxTag); C;
{
 *  GXUnlockShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXUnlockShape(target: gxShape); C;
{
 *  GXUnlockTag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXUnlockTag(target: gxTag); C;
{
 *  GXGetShapeStructure()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeStructure(source: gxShape; VAR length: LONGINT): Ptr; C;
{
 *  GXGetTagStructure()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetTagStructure(source: gxTag; VAR length: LONGINT): Ptr; C;
{
 *  GXGetColorDistance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetColorDistance({CONST}VAR target: gxColor; {CONST}VAR source: gxColor): Fixed; C;
{
 *  GXShapeLengthToPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXShapeLengthToPoint(target: gxShape; index: LONGINT; length: Fixed; VAR location: gxPoint; VAR tangent: gxPoint): gxPointPtr; C;
{
 *  GXGetShapeArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeArea(source: gxShape; index: LONGINT; VAR area: wide): widePtr; C;
{
 *  GXGetShapeCacheSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeCacheSize(source: gxShape): LONGINT; C;
{
 *  GXGetShapeCenter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeCenter(source: gxShape; index: LONGINT; VAR center: gxPoint): gxPointPtr; C;
{
 *  GXGetShapeDirection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeDirection(source: gxShape; contour: LONGINT): gxContourDirection; C;
{
 *  GXGetShapeIndex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeIndex(source: gxShape; contour: LONGINT; vector: LONGINT): LONGINT; C;
{
 *  GXGetShapeLength()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeLength(source: gxShape; index: LONGINT; VAR length: wide): widePtr; C;
{
 *  GXGetShapeSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeSize(source: gxShape): LONGINT; C;
{
 *  GXCountShapeContours()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCountShapeContours(source: gxShape): LONGINT; C;
{
 *  GXCountShapePoints()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCountShapePoints(source: gxShape; contour: LONGINT): LONGINT; C;
{ returns the number of positions }
{
 *  GXGetShapeDashPositions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeDashPositions(source: gxShape; VAR dashMappings: gxMapping): LONGINT; C;
{
 *  GXGetShapeDeviceArea()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeDeviceArea(source: gxShape; port: gxViewPort; device: gxViewDevice): LONGINT; C;
{
 *  GXGetShapeDeviceBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeDeviceBounds(source: gxShape; port: gxViewPort; device: gxViewDevice; VAR bounds: gxRectangle): BOOLEAN; C;
{
 *  GXGetShapeDeviceColors()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeDeviceColors(source: gxShape; port: gxViewPort; device: gxViewDevice; VAR width: LONGINT): gxColorSet; C;
{
 *  GXGetShapeGlobalBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeGlobalBounds(source: gxShape; port: gxViewPort; group: gxViewGroup; VAR bounds: gxRectangle): BOOLEAN; C;
{
 *  GXGetShapeGlobalViewDevices()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeGlobalViewDevices(source: gxShape; port: gxViewPort; VAR list: gxViewDevice): LONGINT; C;
{
 *  GXGetShapeGlobalViewPorts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeGlobalViewPorts(source: gxShape; VAR list: gxViewPort): LONGINT; C;
{
 *  GXGetShapeLocalBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeLocalBounds(source: gxShape; VAR bounds: gxRectangle): gxRectanglePtr; C;
{ returns the number of positions }
{
 *  GXGetShapePatternPositions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapePatternPositions(source: gxShape; VAR positions: gxPoint): LONGINT; C;
{
 *  GXGetShapeLocalFontMetrics()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXGetShapeLocalFontMetrics(sourceShape: gxShape; VAR before: gxPoint; VAR after: gxPoint; VAR caretAngle: gxPoint; VAR caretOffset: gxPoint); C;
{
 *  GXGetShapeDeviceFontMetrics()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXGetShapeDeviceFontMetrics(sourceShape: gxShape; port: gxViewPort; device: gxViewDevice; VAR before: gxPoint; VAR after: gxPoint; VAR caretAngle: gxPoint; VAR caretOffset: gxPoint); C;
{
 *  GXGetViewGroupViewDevices()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewGroupViewDevices(source: gxViewGroup; VAR list: gxViewDevice): LONGINT; C;
{
 *  GXGetViewGroupViewPorts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewGroupViewPorts(source: gxViewGroup; VAR list: gxViewPort): LONGINT; C;
{
 *  GXGetViewPortGlobalMapping()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewPortGlobalMapping(source: gxViewPort; VAR map: gxMapping): gxMappingPtr; C;
{
 *  GXGetViewPortViewDevices()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetViewPortViewDevices(source: gxViewPort; VAR list: gxViewDevice): LONGINT; C;
{
 *  GXHitTestPicture()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXHitTestPicture(target: gxShape; {CONST}VAR test: gxPoint; VAR result: gxHitTestInfo; level: LONGINT; depth: LONGINT): gxShape; C;
{
 *  GXIntersectRectangle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXIntersectRectangle(VAR target: gxRectangle; {CONST}VAR source: gxRectangle; {CONST}VAR operand: gxRectangle): BOOLEAN; C;
{
 *  GXUnionRectangle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXUnionRectangle(VAR target: gxRectangle; {CONST}VAR source: gxRectangle; {CONST}VAR operand: gxRectangle): gxRectanglePtr; C;
{
 *  GXTouchesRectanglePoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXTouchesRectanglePoint({CONST}VAR target: gxRectangle; {CONST}VAR test: gxPoint): BOOLEAN; C;
{
 *  GXTouchesShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXTouchesShape(target: gxShape; test: gxShape): BOOLEAN; C;
{
 *  GXTouchesBoundsShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXTouchesBoundsShape({CONST}VAR target: gxRectangle; test: gxShape): BOOLEAN; C;
{
 *  GXContainsRectangle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXContainsRectangle({CONST}VAR container: gxRectangle; {CONST}VAR test: gxRectangle): BOOLEAN; C;
{
 *  GXContainsShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXContainsShape(container: gxShape; test: gxShape): BOOLEAN; C;
{
 *  GXContainsBoundsShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXContainsBoundsShape({CONST}VAR container: gxRectangle; test: gxShape; index: LONGINT): BOOLEAN; C;
{
 *  GXConvertColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXConvertColor(VAR target: gxColor; space: gxColorSpace; aSet: gxColorSet; profile: gxColorProfile): gxColorPtr; C;
{
 *  GXCombineColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCombineColor(VAR target: gxColor; operand: gxInk): gxColorPtr; C;
{
 *  GXCheckColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCheckColor({CONST}VAR source: gxColor; space: gxColorSpace; aSet: gxColorSet; profile: gxColorProfile): BOOLEAN; C;
{
 *  GXCheckBitmapColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCheckBitmapColor(source: gxShape; {CONST}VAR area: gxLongRectangle; space: gxColorSpace; aSet: gxColorSet; profile: gxColorProfile): gxShape; C;
{
 *  GXGetHalftoneDeviceAngle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetHalftoneDeviceAngle(source: gxViewDevice; {CONST}VAR data: gxHalftone): Fixed; C;
{
 *  GXGetColorSetParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetColorSetParts(source: gxColorSet; index: LONGINT; count: LONGINT; VAR space: gxColorSpace; VAR data: gxSetColor): LONGINT; C;
{ returns the glyph count }
{
 *  GXGetGlyphParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetGlyphParts(source: gxShape; index: LONGINT; charCount: LONGINT; VAR byteLength: LONGINT; VAR text: UInt8; VAR positions: gxPoint; VAR advanceBits: LONGINT; VAR tangents: gxPoint; VAR runCount: LONGINT; VAR styleRuns: INTEGER; VAR styles: gxStyle): LONGINT; C;
{
 *  GXGetPathParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetPathParts(source: gxShape; index: LONGINT; count: LONGINT; VAR data: gxPaths): LONGINT; C;
{
 *  GXGetPictureParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetPictureParts(source: gxShape; index: LONGINT; count: LONGINT; VAR shapes: gxShape; VAR styles: gxStyle; VAR inks: gxInk; VAR transforms: gxTransform): LONGINT; C;
{
 *  GXGetPolygonParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetPolygonParts(source: gxShape; index: LONGINT; count: LONGINT; VAR data: gxPolygons): LONGINT; C;
{
 *  GXGetShapeParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapeParts(source: gxShape; index: LONGINT; count: LONGINT; destination: gxShape): gxShape; C;
{
 *  GXGetTextParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetTextParts(source: gxShape; index: LONGINT; charCount: LONGINT; VAR text: UInt8): LONGINT; C;
{
 *  GXSetColorSetParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetColorSetParts(target: gxColorSet; index: LONGINT; oldCount: LONGINT; newCount: LONGINT; {CONST}VAR data: gxSetColor); C;
{
 *  GXSetGlyphParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetGlyphParts(source: gxShape; index: LONGINT; oldCharCount: LONGINT; newCharCount: LONGINT; {CONST}VAR text: UInt8; {CONST}VAR positions: gxPoint; {CONST}VAR advanceBits: LONGINT; {CONST}VAR tangents: gxPoint; {CONST}VAR styleRuns: INTEGER; {CONST}VAR styles: gxStyle); C;
{
 *  GXSetPathParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetPathParts(target: gxShape; index: LONGINT; count: LONGINT; {CONST}VAR data: gxPaths; flags: gxEditShapeFlag); C;
{
 *  GXSetPictureParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetPictureParts(target: gxShape; index: LONGINT; oldCount: LONGINT; newCount: LONGINT; {CONST}VAR shapes: gxShape; {CONST}VAR styles: gxStyle; {CONST}VAR inks: gxInk; {CONST}VAR transforms: gxTransform); C;
{
 *  GXSetPolygonParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetPolygonParts(target: gxShape; index: LONGINT; count: LONGINT; {CONST}VAR data: gxPolygons; flags: gxEditShapeFlag); C;
{
 *  GXSetShapeParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapeParts(target: gxShape; index: LONGINT; count: LONGINT; insert: gxShape; flags: gxEditShapeFlag); C;
{
 *  GXSetTextParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetTextParts(target: gxShape; index: LONGINT; oldCharCount: LONGINT; newCharCount: LONGINT; {CONST}VAR text: UInt8); C;
{
 *  GXGetShapePoints()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetShapePoints(source: gxShape; index: LONGINT; count: LONGINT; VAR data: gxPoint): LONGINT; C;
{
 *  GXSetShapePoints()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetShapePoints(target: gxShape; index: LONGINT; count: LONGINT; {CONST}VAR data: gxPoint); C;
{
 *  GXGetGlyphPositions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetGlyphPositions(source: gxShape; index: LONGINT; charCount: LONGINT; VAR advance: LONGINT; VAR positions: gxPoint): LONGINT; C;
{
 *  GXGetGlyphTangents()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetGlyphTangents(source: gxShape; index: LONGINT; charCount: LONGINT; VAR tangents: gxPoint): LONGINT; C;
{
 *  GXSetGlyphPositions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetGlyphPositions(target: gxShape; index: LONGINT; charCount: LONGINT; {CONST}VAR advance: LONGINT; {CONST}VAR positions: gxPoint); C;
{
 *  GXSetGlyphTangents()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetGlyphTangents(target: gxShape; index: LONGINT; charCount: LONGINT; {CONST}VAR tangents: gxPoint); C;
{
 *  GXGetGlyphMetrics()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetGlyphMetrics(source: gxShape; VAR glyphOrigins: gxPoint; VAR boundingBoxes: gxRectangle; VAR sideBearings: gxPoint): LONGINT; C;
{
 *  GXDifferenceShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDifferenceShape(target: gxShape; operand: gxShape); C;
{
 *  GXExcludeShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXExcludeShape(target: gxShape; operand: gxShape); C;
{
 *  GXIntersectShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXIntersectShape(target: gxShape; operand: gxShape); C;
{
 *  GXMapShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXMapShape(target: gxShape; {CONST}VAR map: gxMapping); C;
{
 *  GXMoveShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXMoveShape(target: gxShape; deltaX: Fixed; deltaY: Fixed); C;
{
 *  GXMoveShapeTo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXMoveShapeTo(target: gxShape; x: Fixed; y: Fixed); C;
{
 *  GXReverseDifferenceShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXReverseDifferenceShape(target: gxShape; operand: gxShape); C;
{
 *  GXRotateShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXRotateShape(target: gxShape; degrees: Fixed; xOffset: Fixed; yOffset: Fixed); C;
{
 *  GXScaleShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXScaleShape(target: gxShape; hScale: Fixed; vScale: Fixed; xOffset: Fixed; yOffset: Fixed); C;
{
 *  GXSkewShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSkewShape(target: gxShape; xSkew: Fixed; ySkew: Fixed; xOffset: Fixed; yOffset: Fixed); C;
{
 *  GXUnionShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXUnionShape(target: gxShape; operand: gxShape); C;
{
 *  GXDifferenceTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDifferenceTransform(target: gxTransform; operand: gxShape); C;
{
 *  GXExcludeTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXExcludeTransform(target: gxTransform; operand: gxShape); C;
{
 *  GXIntersectTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXIntersectTransform(target: gxTransform; operand: gxShape); C;
{
 *  GXMapTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXMapTransform(target: gxTransform; {CONST}VAR map: gxMapping); C;
{
 *  GXMoveTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXMoveTransform(target: gxTransform; deltaX: Fixed; deltaY: Fixed); C;
{
 *  GXMoveTransformTo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXMoveTransformTo(target: gxTransform; x: Fixed; y: Fixed); C;
{
 *  GXReverseDifferenceTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXReverseDifferenceTransform(target: gxTransform; operand: gxShape); C;
{
 *  GXRotateTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXRotateTransform(target: gxTransform; degrees: Fixed; xOffset: Fixed; yOffset: Fixed); C;
{
 *  GXScaleTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXScaleTransform(target: gxTransform; hScale: Fixed; vScale: Fixed; xOffset: Fixed; yOffset: Fixed); C;
{
 *  GXSkewTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSkewTransform(target: gxTransform; xSkew: Fixed; ySkew: Fixed; xOffset: Fixed; yOffset: Fixed); C;
{
 *  GXUnionTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXUnionTransform(target: gxTransform; operand: gxShape); C;
{
 *  GXBreakShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXBreakShape(target: gxShape; index: LONGINT); C;
{
 *  GXChangedShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXChangedShape(target: gxShape); C;
{
 *  GXHitTestShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXHitTestShape(target: gxShape; {CONST}VAR test: gxPoint; VAR result: gxHitTestInfo): gxShapePart; C;
{
 *  GXHitTestDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXHitTestDevice(target: gxShape; port: gxViewPort; device: gxViewDevice; {CONST}VAR test: gxPoint; {CONST}VAR tolerance: gxPoint): gxShape; C;
{
 *  GXInsetShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXInsetShape(target: gxShape; inset: Fixed); C;
{
 *  GXInvertShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXInvertShape(target: gxShape); C;
{
 *  GXPrimitiveShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXPrimitiveShape(target: gxShape); C;
{
 *  GXReduceShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXReduceShape(target: gxShape; contour: LONGINT); C;
{
 *  GXReverseShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXReverseShape(target: gxShape; contour: LONGINT); C;
{
 *  GXSimplifyShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSimplifyShape(target: gxShape); C;
{
 *  GXLockColorProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXLockColorProfile(source: gxColorProfile); C;
{
 *  GXUnlockColorProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXUnlockColorProfile(source: gxColorProfile); C;
{
 *  GXGetColorProfileStructure()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetColorProfileStructure(source: gxColorProfile; VAR length: LONGINT): Ptr; C;
{
 *  GXFlattenShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXFlattenShape(source: gxShape; flags: gxFlattenFlag; VAR block: gxSpoolBlock); C;
{
 *  GXUnflattenShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXUnflattenShape(VAR block: gxSpoolBlock; count: LONGINT; {CONST}VAR portList: gxViewPort): gxShape; C;
{
 *  GXPostGraphicsNotice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXPostGraphicsNotice(notice: gxGraphicsNotice); C;
{
 *  GXIgnoreGraphicsNotice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXIgnoreGraphicsNotice(notice: gxGraphicsNotice); C;
{
 *  GXPopGraphicsNotice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXPopGraphicsNotice; C;


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GXGraphicsIncludes}

{$ENDC} {__GXGRAPHICS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
