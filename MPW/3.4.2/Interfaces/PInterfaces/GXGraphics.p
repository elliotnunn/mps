{
 	File:		GXGraphics.p
 
 	Contains:	QuickDraw GX graphic routine interfaces.
 
 	Version:	Technology:	Quickdraw GX 1.1
 				Release:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
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
{$IFC UNDEFINED __TYPES__}
{$I Types.p}
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


FUNCTION GXNewGraphicsClient(memoryStart: UNIV Ptr; memoryLength: LONGINT; attributes: gxClientAttribute): gxGraphicsClient; C;
FUNCTION GXGetGraphicsClient: gxGraphicsClient; C;
PROCEDURE GXSetGraphicsClient(client: gxGraphicsClient); C;
PROCEDURE GXDisposeGraphicsClient(client: gxGraphicsClient); C;
{ returns the count  }
FUNCTION GXGetGraphicsClients(index: LONGINT; count: LONGINT; VAR clients: gxGraphicsClient): LONGINT; C;
PROCEDURE GXEnterGraphics; C;
PROCEDURE GXExitGraphics; C;
FUNCTION GXGetGraphicsError(VAR stickyError: gxGraphicsError): gxGraphicsError; C;
FUNCTION GXGetGraphicsNotice(VAR stickyNotice: gxGraphicsNotice): gxGraphicsNotice; C;
FUNCTION GXGetGraphicsWarning(VAR stickyWarning: gxGraphicsWarning): gxGraphicsWarning; C;
PROCEDURE GXPostGraphicsError(error: gxGraphicsError); C;
PROCEDURE GXPostGraphicsWarning(warning: gxGraphicsWarning); C;
FUNCTION GXGetUserGraphicsError(VAR reference: LONGINT): gxUserErrorFunction; C;
FUNCTION GXGetUserGraphicsNotice(VAR reference: LONGINT): gxUserNoticeFunction; C;
FUNCTION GXGetUserGraphicsWarning(VAR reference: LONGINT): gxUserWarningFunction; C;
PROCEDURE GXSetUserGraphicsError(userFunction: gxUserErrorFunction; reference: LONGINT); C;
PROCEDURE GXSetUserGraphicsNotice(userFunction: gxUserNoticeFunction; reference: LONGINT); C;
PROCEDURE GXSetUserGraphicsWarning(userFunction: gxUserWarningFunction; reference: LONGINT); C;
PROCEDURE GXIgnoreGraphicsWarning(warning: gxGraphicsWarning); C;
PROCEDURE GXPopGraphicsWarning; C;
FUNCTION GXNewShapeVector(aType: gxShapeType; {CONST}VAR vector: Fixed): gxShape; C;
PROCEDURE GXSetShapeVector(target: gxShape; {CONST}VAR vector: Fixed); C;
FUNCTION GXNewBitmap({CONST}VAR data: gxBitmap; {CONST}VAR position: gxPoint): gxShape; C;
FUNCTION GXNewCurve({CONST}VAR data: gxCurve): gxShape; C;
FUNCTION GXNewGlyphs(charCount: LONGINT; {CONST}VAR text: UInt8; {CONST}VAR positions: gxPoint; {CONST}VAR advance: LONGINT; {CONST}VAR tangents: gxPoint; {CONST}VAR styleRuns: INTEGER; {CONST}VAR glyphStyles: gxStyle): gxShape; C;
FUNCTION GXNewLine({CONST}VAR data: gxLine): gxShape; C;
FUNCTION GXNewPaths({CONST}VAR data: gxPaths): gxShape; C;
FUNCTION GXNewPicture(count: LONGINT; {CONST}VAR shapes: gxShape; {CONST}VAR styles: gxStyle; {CONST}VAR inks: gxInk; {CONST}VAR transforms: gxTransform): gxShape; C;
FUNCTION GXNewPoint({CONST}VAR data: gxPoint): gxShape; C;
FUNCTION GXNewPolygons({CONST}VAR data: gxPolygons): gxShape; C;
FUNCTION GXNewRectangle({CONST}VAR data: gxRectangle): gxShape; C;
FUNCTION GXNewText(charCount: LONGINT; {CONST}VAR text: UInt8; {CONST}VAR position: gxPoint): gxShape; C;
FUNCTION GXGetBitmap(source: gxShape; VAR data: gxBitmap; VAR position: gxPoint): gxBitmapPtr; C;
FUNCTION GXGetCurve(source: gxShape; VAR data: gxCurve): gxCurvePtr; C;
{  returns byte length of glyphs  }
FUNCTION GXGetGlyphs(source: gxShape; VAR charCount: LONGINT; VAR text: UInt8; VAR positions: gxPoint; VAR advance: LONGINT; VAR tangents: gxPoint; VAR runCount: LONGINT; VAR styleRuns: INTEGER; VAR glyphStyles: gxStyle): LONGINT; C;
FUNCTION GXGetLine(source: gxShape; VAR data: gxLine): gxLinePtr; C;
{  returns byte length  }
FUNCTION GXGetPaths(source: gxShape; VAR data: gxPaths): LONGINT; C;
{  returns count  }
FUNCTION GXGetPicture(source: gxShape; VAR shapes: gxShape; VAR styles: gxStyle; VAR inks: gxInk; VAR transforms: gxTransform): LONGINT; C;
FUNCTION GXGetPoint(source: gxShape; VAR data: gxPoint): gxPointPtr; C;
{  returns byte length  }
FUNCTION GXGetPolygons(source: gxShape; VAR data: gxPolygons): LONGINT; C;
FUNCTION GXGetRectangle(source: gxShape; VAR data: gxRectangle): gxRectanglePtr; C;
{  returns byte length  }
FUNCTION GXGetText(source: gxShape; VAR charCount: LONGINT; VAR text: UInt8; VAR position: gxPoint): LONGINT; C;
PROCEDURE GXSetBitmap(target: gxShape; {CONST}VAR data: gxBitmap; {CONST}VAR position: gxPoint); C;
PROCEDURE GXSetCurve(target: gxShape; {CONST}VAR data: gxCurve); C;
PROCEDURE GXSetGlyphs(target: gxShape; charCount: LONGINT; {CONST}VAR text: UInt8; {CONST}VAR positions: gxPoint; {CONST}VAR advance: LONGINT; {CONST}VAR tangents: gxPoint; {CONST}VAR styleRuns: INTEGER; {CONST}VAR glyphStyles: gxStyle); C;
PROCEDURE GXSetLine(target: gxShape; {CONST}VAR data: gxLine); C;
PROCEDURE GXSetPaths(target: gxShape; {CONST}VAR data: gxPaths); C;
PROCEDURE GXSetPicture(target: gxShape; count: LONGINT; {CONST}VAR shapes: gxShape; {CONST}VAR styles: gxStyle; {CONST}VAR inks: gxInk; {CONST}VAR transforms: gxTransform); C;
PROCEDURE GXSetPoint(target: gxShape; {CONST}VAR data: gxPoint); C;
PROCEDURE GXSetPolygons(target: gxShape; {CONST}VAR data: gxPolygons); C;
PROCEDURE GXSetRectangle(target: gxShape; {CONST}VAR data: gxRectangle); C;
PROCEDURE GXSetText(target: gxShape; charCount: LONGINT; {CONST}VAR text: UInt8; {CONST}VAR position: gxPoint); C;
PROCEDURE GXDrawBitmap({CONST}VAR data: gxBitmap; {CONST}VAR position: gxPoint); C;
PROCEDURE GXDrawCurve({CONST}VAR data: gxCurve); C;
PROCEDURE GXDrawGlyphs(charCount: LONGINT; {CONST}VAR text: UInt8; {CONST}VAR positions: gxPoint; {CONST}VAR advance: LONGINT; {CONST}VAR tangents: gxPoint; {CONST}VAR styleRuns: INTEGER; {CONST}VAR glyphStyles: gxStyle); C;
PROCEDURE GXDrawLine({CONST}VAR data: gxLine); C;
PROCEDURE GXDrawPaths({CONST}VAR data: gxPaths; fill: gxShapeFill); C;
PROCEDURE GXDrawPicture(count: LONGINT; {CONST}VAR shapes: gxShape; {CONST}VAR styles: gxStyle; {CONST}VAR inks: gxInk; {CONST}VAR transforms: gxTransform); C;
PROCEDURE GXDrawPoint({CONST}VAR data: gxPoint); C;
PROCEDURE GXDrawPolygons({CONST}VAR data: gxPolygons; fill: gxShapeFill); C;
PROCEDURE GXDrawRectangle({CONST}VAR data: gxRectangle; fill: gxShapeFill); C;
PROCEDURE GXDrawText(charCount: LONGINT; {CONST}VAR text: UInt8; {CONST}VAR position: gxPoint); C;
FUNCTION GXNewColorProfile(size: LONGINT; colorProfileData: UNIV Ptr): gxColorProfile; C;
FUNCTION GXNewColorSet(space: gxColorSpace; count: LONGINT; {CONST}VAR colors: gxSetColor): gxColorSet; C;
FUNCTION GXNewInk: gxInk; C;
FUNCTION GXNewShape(aType: gxShapeType): gxShape; C;
FUNCTION GXNewStyle: gxStyle; C;
FUNCTION GXNewTag(tagType: LONGINT; length: LONGINT; data: UNIV Ptr): gxTag; C;
FUNCTION GXNewTransform: gxTransform; C;
FUNCTION GXNewViewDevice(group: gxViewGroup; bitmapShape: gxShape): gxViewDevice; C;
FUNCTION GXNewViewGroup: gxViewGroup; C;
FUNCTION GXNewViewPort(group: gxViewGroup): gxViewPort; C;
PROCEDURE GXDisposeColorProfile(target: gxColorProfile); C;
PROCEDURE GXDisposeColorSet(target: gxColorSet); C;
PROCEDURE GXDisposeInk(target: gxInk); C;
PROCEDURE GXDisposeShape(target: gxShape); C;
PROCEDURE GXDisposeStyle(target: gxStyle); C;
PROCEDURE GXDisposeTag(target: gxTag); C;
PROCEDURE GXDisposeTransform(target: gxTransform); C;
PROCEDURE GXDisposeViewDevice(target: gxViewDevice); C;
PROCEDURE GXDisposeViewGroup(target: gxViewGroup); C;
PROCEDURE GXDisposeViewPort(target: gxViewPort); C;
FUNCTION GXCloneColorProfile(source: gxColorProfile): gxColorProfile; C;
FUNCTION GXCloneColorSet(source: gxColorSet): gxColorSet; C;
FUNCTION GXCloneInk(source: gxInk): gxInk; C;
FUNCTION GXCloneShape(source: gxShape): gxShape; C;
FUNCTION GXCloneStyle(source: gxStyle): gxStyle; C;
FUNCTION GXCloneTag(source: gxTag): gxTag; C;
FUNCTION GXCloneTransform(source: gxTransform): gxTransform; C;
FUNCTION GXCopyToColorProfile(target: gxColorProfile; source: gxColorProfile): gxColorProfile; C;
FUNCTION GXCopyToColorSet(target: gxColorSet; source: gxColorSet): gxColorSet; C;
FUNCTION GXCopyToInk(target: gxInk; source: gxInk): gxInk; C;
FUNCTION GXCopyToShape(target: gxShape; source: gxShape): gxShape; C;
FUNCTION GXCopyToStyle(target: gxStyle; source: gxStyle): gxStyle; C;
FUNCTION GXCopyToTag(target: gxTag; source: gxTag): gxTag; C;
FUNCTION GXCopyToTransform(target: gxTransform; source: gxTransform): gxTransform; C;
FUNCTION GXCopyToViewDevice(target: gxViewDevice; source: gxViewDevice): gxViewDevice; C;
FUNCTION GXCopyToViewPort(target: gxViewPort; source: gxViewPort): gxViewPort; C;
FUNCTION GXEqualColorProfile(one: gxColorProfile; two: gxColorProfile): BOOLEAN; C;
FUNCTION GXEqualColorSet(one: gxColorSet; two: gxColorSet): BOOLEAN; C;
FUNCTION GXEqualInk(one: gxInk; two: gxInk): BOOLEAN; C;
FUNCTION GXEqualShape(one: gxShape; two: gxShape): BOOLEAN; C;
FUNCTION GXEqualStyle(one: gxStyle; two: gxStyle): BOOLEAN; C;
FUNCTION GXEqualTag(one: gxTag; two: gxTag): BOOLEAN; C;
FUNCTION GXEqualTransform(one: gxTransform; two: gxTransform): BOOLEAN; C;
FUNCTION GXEqualViewDevice(one: gxViewDevice; two: gxViewDevice): BOOLEAN; C;
FUNCTION GXEqualViewPort(one: gxViewPort; two: gxViewPort): BOOLEAN; C;
PROCEDURE GXResetInk(target: gxInk); C;
PROCEDURE GXResetShape(target: gxShape); C;
PROCEDURE GXResetStyle(target: gxStyle); C;
PROCEDURE GXResetTransform(target: gxTransform); C;
PROCEDURE GXLoadColorProfile(target: gxColorProfile); C;
PROCEDURE GXLoadColorSet(target: gxColorSet); C;
PROCEDURE GXLoadInk(target: gxInk); C;
PROCEDURE GXLoadShape(target: gxShape); C;
PROCEDURE GXLoadStyle(target: gxStyle); C;
PROCEDURE GXLoadTag(target: gxTag); C;
PROCEDURE GXLoadTransform(target: gxTransform); C;
PROCEDURE GXUnloadColorProfile(target: gxColorProfile); C;
PROCEDURE GXUnloadColorSet(target: gxColorSet); C;
PROCEDURE GXUnloadInk(target: gxInk); C;
PROCEDURE GXUnloadShape(target: gxShape); C;
PROCEDURE GXUnloadStyle(target: gxStyle); C;
PROCEDURE GXUnloadTag(target: gxTag); C;
PROCEDURE GXUnloadTransform(target: gxTransform); C;
PROCEDURE GXCacheShape(source: gxShape); C;
FUNCTION GXCopyDeepToShape(target: gxShape; source: gxShape): gxShape; C;
PROCEDURE GXDrawShape(source: gxShape); C;
PROCEDURE GXDisposeShapeCache(target: gxShape); C;
FUNCTION GXGetDefaultColorProfile: gxColorProfile; C;
FUNCTION GXGetDefaultShape(aType: gxShapeType): gxShape; C;
FUNCTION GXGetDefaultColorSet(pixelDepth: LONGINT): gxColorSet; C;
PROCEDURE GXSetDefaultShape(target: gxShape); C;
PROCEDURE GXSetDefaultColorSet(target: gxColorSet; pixelDepth: LONGINT); C;
FUNCTION GXGetTag(source: gxTag; VAR tagType: LONGINT; data: UNIV Ptr): LONGINT; C;
PROCEDURE GXSetTag(target: gxTag; tagType: LONGINT; length: LONGINT; data: UNIV Ptr); C;
FUNCTION GXGetShapeBounds(source: gxShape; index: LONGINT; VAR bounds: gxRectangle): gxRectanglePtr; C;
FUNCTION GXGetShapeFill(source: gxShape): gxShapeFill; C;
FUNCTION GXGetShapeInk(source: gxShape): gxInk; C;
FUNCTION GXGetShapePixel(source: gxShape; x: LONGINT; y: LONGINT; VAR data: gxColor; VAR index: LONGINT): LONGINT; C;
FUNCTION GXGetShapeStyle(source: gxShape): gxStyle; C;
FUNCTION GXGetShapeTransform(source: gxShape): gxTransform; C;
FUNCTION GXGetShapeType(source: gxShape): gxShapeType; C;
FUNCTION GXGetShapeTypographicBounds(source: gxShape; VAR bounds: gxRectangle): gxRectanglePtr; C;
FUNCTION GXGetBitmapParts(source: gxShape; {CONST}VAR bounds: gxLongRectangle): gxShape; C;
PROCEDURE GXGetStyleFontMetrics(sourceStyle: gxStyle; VAR before: gxPoint; VAR after: gxPoint; VAR caretAngle: gxPoint; VAR caretOffset: gxPoint); C;
PROCEDURE GXGetShapeFontMetrics(source: gxShape; VAR before: gxPoint; VAR after: gxPoint; VAR caretAngle: gxPoint; VAR caretOffset: gxPoint); C;
PROCEDURE GXSetShapeBounds(target: gxShape; {CONST}VAR newBounds: gxRectangle); C;
PROCEDURE GXSetShapeFill(target: gxShape; newFill: gxShapeFill); C;
PROCEDURE GXSetShapeInk(target: gxShape; newInk: gxInk); C;
PROCEDURE GXSetShapePixel(target: gxShape; x: LONGINT; y: LONGINT; {CONST}VAR newColor: gxColor; newIndex: LONGINT); C;
PROCEDURE GXSetShapeStyle(target: gxShape; newStyle: gxStyle); C;
PROCEDURE GXSetShapeTransform(target: gxShape; newTransform: gxTransform); C;
PROCEDURE GXSetShapeType(target: gxShape; newType: gxShapeType); C;
PROCEDURE GXSetBitmapParts(target: gxShape; {CONST}VAR bounds: gxLongRectangle; bitmapShape: gxShape); C;
PROCEDURE GXSetShapeGeometry(target: gxShape; geometry: gxShape); C;
FUNCTION GXGetShapeCurveError(source: gxShape): Fixed; C;
FUNCTION GXGetShapeDash(source: gxShape; VAR dash: gxDashRecord): gxDashRecordPtr; C;
FUNCTION GXGetShapeCap(source: gxShape; VAR cap: gxCapRecord): gxCapRecordPtr; C;
{  returns the number of layers  }
FUNCTION GXGetShapeFace(source: gxShape; VAR face: gxTextFace): LONGINT; C;
FUNCTION GXGetShapeFont(source: gxShape): gxFont; C;
FUNCTION GXGetShapeJoin(source: gxShape; VAR join: gxJoinRecord): gxJoinRecordPtr; C;
FUNCTION GXGetShapeJustification(source: gxShape): Fract; C;
FUNCTION GXGetShapePattern(source: gxShape; VAR pattern: gxPatternRecord): gxPatternRecordPtr; C;
FUNCTION GXGetShapePen(source: gxShape): Fixed; C;
FUNCTION GXGetShapeEncoding(source: gxShape; VAR script: gxFontScript; VAR language: gxFontLanguage): gxFontPlatform; C;
FUNCTION GXGetShapeTextSize(source: gxShape): Fixed; C;
FUNCTION GXGetShapeFontVariations(source: gxShape; VAR variations: gxFontVariation): LONGINT; C;
FUNCTION GXGetShapeFontVariationSuite(source: gxShape; VAR variations: gxFontVariation): LONGINT; C;
FUNCTION GXGetStyleCurveError(source: gxStyle): Fixed; C;
FUNCTION GXGetStyleDash(source: gxStyle; VAR dash: gxDashRecord): gxDashRecordPtr; C;
FUNCTION GXGetStyleCap(source: gxStyle; VAR cap: gxCapRecord): gxCapRecordPtr; C;
{  returns the number of layers  }
FUNCTION GXGetStyleFace(source: gxStyle; VAR face: gxTextFace): LONGINT; C;
FUNCTION GXGetStyleFont(source: gxStyle): gxFont; C;
FUNCTION GXGetStyleJoin(source: gxStyle; VAR join: gxJoinRecord): gxJoinRecordPtr; C;
FUNCTION GXGetStyleJustification(source: gxStyle): Fract; C;
FUNCTION GXGetStylePattern(source: gxStyle; VAR pattern: gxPatternRecord): gxPatternRecordPtr; C;
FUNCTION GXGetStylePen(source: gxStyle): Fixed; C;
FUNCTION GXGetStyleEncoding(source: gxStyle; VAR script: gxFontScript; VAR language: gxFontLanguage): gxFontPlatform; C;
FUNCTION GXGetStyleTextSize(source: gxStyle): Fixed; C;
FUNCTION GXGetStyleFontVariations(source: gxStyle; VAR variations: gxFontVariation): LONGINT; C;
FUNCTION GXGetStyleFontVariationSuite(source: gxStyle; VAR variations: gxFontVariation): LONGINT; C;
PROCEDURE GXSetShapeCurveError(target: gxShape; error: Fixed); C;
PROCEDURE GXSetShapeDash(target: gxShape; {CONST}VAR dash: gxDashRecord); C;
PROCEDURE GXSetShapeCap(target: gxShape; {CONST}VAR cap: gxCapRecord); C;
PROCEDURE GXSetShapeFace(target: gxShape; {CONST}VAR face: gxTextFace); C;
PROCEDURE GXSetShapeFont(target: gxShape; aFont: gxFont); C;
PROCEDURE GXSetShapeJoin(target: gxShape; {CONST}VAR join: gxJoinRecord); C;
PROCEDURE GXSetShapeJustification(target: gxShape; justify: Fract); C;
PROCEDURE GXSetShapePattern(target: gxShape; {CONST}VAR pattern: gxPatternRecord); C;
PROCEDURE GXSetShapePen(target: gxShape; pen: Fixed); C;
PROCEDURE GXSetShapeEncoding(target: gxShape; platform: gxFontPlatform; script: gxFontScript; language: gxFontLanguage); C;
PROCEDURE GXSetShapeTextSize(target: gxShape; size: Fixed); C;
PROCEDURE GXSetShapeFontVariations(target: gxShape; count: LONGINT; {CONST}VAR variations: gxFontVariation); C;
PROCEDURE GXSetStyleCurveError(target: gxStyle; error: Fixed); C;
PROCEDURE GXSetStyleDash(target: gxStyle; {CONST}VAR dash: gxDashRecord); C;
PROCEDURE GXSetStyleCap(target: gxStyle; {CONST}VAR cap: gxCapRecord); C;
PROCEDURE GXSetStyleFace(target: gxStyle; {CONST}VAR face: gxTextFace); C;
PROCEDURE GXSetStyleFont(target: gxStyle; aFont: gxFont); C;
PROCEDURE GXSetStyleJoin(target: gxStyle; {CONST}VAR join: gxJoinRecord); C;
PROCEDURE GXSetStyleJustification(target: gxStyle; justify: Fract); C;
PROCEDURE GXSetStylePattern(target: gxStyle; {CONST}VAR pattern: gxPatternRecord); C;
PROCEDURE GXSetStylePen(target: gxStyle; pen: Fixed); C;
PROCEDURE GXSetStyleEncoding(target: gxStyle; platform: gxFontPlatform; script: gxFontScript; language: gxFontLanguage); C;
PROCEDURE GXSetStyleTextSize(target: gxStyle; size: Fixed); C;
PROCEDURE GXSetStyleFontVariations(target: gxStyle; count: LONGINT; {CONST}VAR variations: gxFontVariation); C;
FUNCTION GXGetShapeColor(source: gxShape; VAR data: gxColor): gxColorPtr; C;
FUNCTION GXGetShapeTransfer(source: gxShape; VAR data: gxTransferMode): gxTransferModePtr; C;
FUNCTION GXGetInkColor(source: gxInk; VAR data: gxColor): gxColorPtr; C;
FUNCTION GXGetInkTransfer(source: gxInk; VAR data: gxTransferMode): gxTransferModePtr; C;
PROCEDURE GXSetShapeColor(target: gxShape; {CONST}VAR data: gxColor); C;
PROCEDURE GXSetShapeTransfer(target: gxShape; {CONST}VAR data: gxTransferMode); C;
PROCEDURE GXSetInkColor(target: gxInk; {CONST}VAR data: gxColor); C;
PROCEDURE GXSetInkTransfer(target: gxInk; {CONST}VAR data: gxTransferMode); C;
FUNCTION GXGetShapeClip(source: gxShape): gxShape; C;
FUNCTION GXGetShapeClipType(source: gxShape): gxShapeType; C;
FUNCTION GXGetShapeMapping(source: gxShape; VAR map: gxMapping): gxMappingPtr; C;
FUNCTION GXGetShapeHitTest(source: gxShape; VAR tolerance: Fixed): gxShapePart; C;
FUNCTION GXGetShapeViewPorts(source: gxShape; VAR list: gxViewPort): LONGINT; C;
FUNCTION GXGetTransformClip(source: gxTransform): gxShape; C;
FUNCTION GXGetTransformClipType(source: gxTransform): gxShapeType; C;
FUNCTION GXGetTransformMapping(source: gxTransform; VAR map: gxMapping): gxMappingPtr; C;
FUNCTION GXGetTransformHitTest(source: gxTransform; VAR tolerance: Fixed): gxShapePart; C;
FUNCTION GXGetTransformViewPorts(source: gxTransform; VAR list: gxViewPort): LONGINT; C;
PROCEDURE GXSetShapeClip(target: gxShape; clip: gxShape); C;
PROCEDURE GXSetShapeMapping(target: gxShape; {CONST}VAR map: gxMapping); C;
PROCEDURE GXSetShapeHitTest(target: gxShape; mask: gxShapePart; tolerance: Fixed); C;
PROCEDURE GXSetShapeViewPorts(target: gxShape; count: LONGINT; {CONST}VAR list: gxViewPort); C;
PROCEDURE GXSetTransformClip(target: gxTransform; clip: gxShape); C;
PROCEDURE GXSetTransformMapping(target: gxTransform; {CONST}VAR map: gxMapping); C;
PROCEDURE GXSetTransformHitTest(target: gxTransform; mask: gxShapePart; tolerance: Fixed); C;
PROCEDURE GXSetTransformViewPorts(target: gxTransform; count: LONGINT; {CONST}VAR list: gxViewPort); C;
FUNCTION GXGetColorSet(source: gxColorSet; VAR space: gxColorSpace; VAR colors: gxSetColor): LONGINT; C;
FUNCTION GXGetColorProfile(source: gxColorProfile; colorProfileData: UNIV Ptr): LONGINT; C;
PROCEDURE GXSetColorSet(target: gxColorSet; space: gxColorSpace; count: LONGINT; {CONST}VAR colors: gxSetColor); C;
PROCEDURE GXSetColorProfile(target: gxColorProfile; size: LONGINT; colorProfileData: UNIV Ptr); C;
FUNCTION GXGetViewDeviceBitmap(source: gxViewDevice): gxShape; C;
FUNCTION GXGetViewDeviceClip(source: gxViewDevice): gxShape; C;
FUNCTION GXGetViewDeviceMapping(source: gxViewDevice; VAR map: gxMapping): gxMappingPtr; C;
FUNCTION GXGetViewDeviceViewGroup(source: gxViewDevice): gxViewGroup; C;
PROCEDURE GXSetViewDeviceBitmap(target: gxViewDevice; bitmapShape: gxShape); C;
PROCEDURE GXSetViewDeviceClip(target: gxViewDevice; clip: gxShape); C;
PROCEDURE GXSetViewDeviceMapping(target: gxViewDevice; {CONST}VAR map: gxMapping); C;
PROCEDURE GXSetViewDeviceViewGroup(target: gxViewDevice; group: gxViewGroup); C;
FUNCTION GXGetViewPortChildren(source: gxViewPort; VAR list: gxViewPort): LONGINT; C;
FUNCTION GXGetViewPortClip(source: gxViewPort): gxShape; C;
FUNCTION GXGetViewPortDither(source: gxViewPort): LONGINT; C;
FUNCTION GXGetViewPortHalftone(source: gxViewPort; VAR data: gxHalftone): BOOLEAN; C;
FUNCTION GXGetViewPortMapping(source: gxViewPort; VAR map: gxMapping): gxMappingPtr; C;
FUNCTION GXGetViewPortParent(source: gxViewPort): gxViewPort; C;
FUNCTION GXGetViewPortViewGroup(source: gxViewPort): gxViewGroup; C;
FUNCTION GXGetViewPortHalftoneMatrix(source: gxViewPort; sourceDevice: gxViewDevice; VAR theMatrix: gxHalftoneMatrix): LONGINT; C;
PROCEDURE GXSetViewPortChildren(target: gxViewPort; count: LONGINT; {CONST}VAR list: gxViewPort); C;
PROCEDURE GXSetViewPortClip(target: gxViewPort; clip: gxShape); C;
PROCEDURE GXSetViewPortDither(target: gxViewPort; level: LONGINT); C;
PROCEDURE GXSetViewPortHalftone(target: gxViewPort; {CONST}VAR data: gxHalftone); C;
PROCEDURE GXSetViewPortMapping(target: gxViewPort; {CONST}VAR map: gxMapping); C;
PROCEDURE GXSetViewPortParent(target: gxViewPort; parent: gxViewPort); C;
PROCEDURE GXSetViewPortViewGroup(target: gxViewPort; group: gxViewGroup); C;
FUNCTION GXGetColorProfileTags(source: gxColorProfile; tagType: LONGINT; index: LONGINT; count: LONGINT; VAR items: gxTag): LONGINT; C;
FUNCTION GXGetColorSetTags(source: gxColorSet; tagType: LONGINT; index: LONGINT; count: LONGINT; VAR items: gxTag): LONGINT; C;
FUNCTION GXGetInkTags(source: gxInk; tagType: LONGINT; index: LONGINT; count: LONGINT; VAR items: gxTag): LONGINT; C;
FUNCTION GXGetShapeTags(source: gxShape; tagType: LONGINT; index: LONGINT; count: LONGINT; VAR items: gxTag): LONGINT; C;
FUNCTION GXGetStyleTags(source: gxStyle; tagType: LONGINT; index: LONGINT; count: LONGINT; VAR items: gxTag): LONGINT; C;
FUNCTION GXGetTransformTags(source: gxTransform; tagType: LONGINT; index: LONGINT; count: LONGINT; VAR items: gxTag): LONGINT; C;
FUNCTION GXGetViewDeviceTags(source: gxViewDevice; tagType: LONGINT; index: LONGINT; count: LONGINT; VAR items: gxTag): LONGINT; C;
FUNCTION GXGetViewPortTags(source: gxViewPort; tagType: LONGINT; index: LONGINT; count: LONGINT; VAR items: gxTag): LONGINT; C;
PROCEDURE GXSetColorProfileTags(target: gxColorProfile; tagType: LONGINT; index: LONGINT; oldCount: LONGINT; newCount: LONGINT; {CONST}VAR items: gxTag); C;
PROCEDURE GXSetColorSetTags(target: gxColorSet; tagType: LONGINT; index: LONGINT; oldCount: LONGINT; newCount: LONGINT; {CONST}VAR items: gxTag); C;
PROCEDURE GXSetInkTags(target: gxInk; tagType: LONGINT; index: LONGINT; oldCount: LONGINT; newCount: LONGINT; {CONST}VAR items: gxTag); C;
PROCEDURE GXSetShapeTags(target: gxShape; tagType: LONGINT; index: LONGINT; oldCount: LONGINT; newCount: LONGINT; {CONST}VAR items: gxTag); C;
PROCEDURE GXSetStyleTags(target: gxStyle; tagType: LONGINT; index: LONGINT; oldCount: LONGINT; newCount: LONGINT; {CONST}VAR items: gxTag); C;
PROCEDURE GXSetTransformTags(target: gxTransform; tagType: LONGINT; index: LONGINT; oldCount: LONGINT; newCount: LONGINT; {CONST}VAR items: gxTag); C;
PROCEDURE GXSetViewDeviceTags(target: gxViewDevice; tagType: LONGINT; index: LONGINT; oldCount: LONGINT; newCount: LONGINT; {CONST}VAR items: gxTag); C;
PROCEDURE GXSetViewPortTags(target: gxViewPort; tagType: LONGINT; index: LONGINT; oldCount: LONGINT; newCount: LONGINT; {CONST}VAR items: gxTag); C;
FUNCTION GXGetInkAttributes(source: gxInk): gxInkAttribute; C;
FUNCTION GXGetShapeAttributes(source: gxShape): gxShapeAttribute; C;
FUNCTION GXGetShapeInkAttributes(source: gxShape): gxInkAttribute; C;
FUNCTION GXGetShapeStyleAttributes(source: gxShape): gxStyleAttribute; C;
FUNCTION GXGetStyleAttributes(source: gxStyle): gxStyleAttribute; C;
FUNCTION GXGetShapeTextAttributes(source: gxShape): gxTextAttribute; C;
FUNCTION GXGetStyleTextAttributes(source: gxStyle): gxTextAttribute; C;
FUNCTION GXGetViewDeviceAttributes(source: gxViewDevice): gxDeviceAttribute; C;
FUNCTION GXGetViewPortAttributes(source: gxViewPort): gxPortAttribute; C;
PROCEDURE GXSetInkAttributes(target: gxInk; attributes: gxInkAttribute); C;
PROCEDURE GXSetShapeAttributes(target: gxShape; attributes: gxShapeAttribute); C;
PROCEDURE GXSetShapeInkAttributes(target: gxShape; attributes: gxInkAttribute); C;
PROCEDURE GXSetShapeStyleAttributes(target: gxShape; attributes: gxStyleAttribute); C;
PROCEDURE GXSetStyleAttributes(target: gxStyle; attributes: gxStyleAttribute); C;
PROCEDURE GXSetShapeTextAttributes(target: gxShape; attributes: gxTextAttribute); C;
PROCEDURE GXSetStyleTextAttributes(target: gxStyle; attributes: gxTextAttribute); C;
PROCEDURE GXSetViewDeviceAttributes(target: gxViewDevice; attributes: gxDeviceAttribute); C;
PROCEDURE GXSetViewPortAttributes(target: gxViewPort; attributes: gxPortAttribute); C;
FUNCTION GXGetColorProfileOwners(source: gxColorProfile): LONGINT; C;
FUNCTION GXGetColorSetOwners(source: gxColorSet): LONGINT; C;
FUNCTION GXGetInkOwners(source: gxInk): LONGINT; C;
FUNCTION GXGetShapeOwners(source: gxShape): LONGINT; C;
FUNCTION GXGetStyleOwners(source: gxStyle): LONGINT; C;
FUNCTION GXGetTagOwners(source: gxTag): LONGINT; C;
FUNCTION GXGetTransformOwners(source: gxTransform): LONGINT; C;
PROCEDURE GXLockShape(target: gxShape); C;
PROCEDURE GXLockTag(target: gxTag); C;
PROCEDURE GXUnlockShape(target: gxShape); C;
PROCEDURE GXUnlockTag(target: gxTag); C;
FUNCTION GXGetShapeStructure(source: gxShape; VAR length: LONGINT): Ptr; C;
FUNCTION GXGetTagStructure(source: gxTag; VAR length: LONGINT): Ptr; C;
FUNCTION GXGetColorDistance({CONST}VAR target: gxColor; {CONST}VAR source: gxColor): Fixed; C;
FUNCTION GXShapeLengthToPoint(target: gxShape; index: LONGINT; length: Fixed; VAR location: gxPoint; VAR tangent: gxPoint): gxPointPtr; C;
FUNCTION GXGetShapeArea(source: gxShape; index: LONGINT; VAR area: wide): widePtr; C;
FUNCTION GXGetShapeCacheSize(source: gxShape): LONGINT; C;
FUNCTION GXGetShapeCenter(source: gxShape; index: LONGINT; VAR center: gxPoint): gxPointPtr; C;
FUNCTION GXGetShapeDirection(source: gxShape; contour: LONGINT): gxContourDirection; C;
FUNCTION GXGetShapeIndex(source: gxShape; contour: LONGINT; vector: LONGINT): LONGINT; C;
FUNCTION GXGetShapeLength(source: gxShape; index: LONGINT; VAR length: wide): widePtr; C;
FUNCTION GXGetShapeSize(source: gxShape): LONGINT; C;
FUNCTION GXCountShapeContours(source: gxShape): LONGINT; C;
FUNCTION GXCountShapePoints(source: gxShape; contour: LONGINT): LONGINT; C;
{  returns the number of positions  }
FUNCTION GXGetShapeDashPositions(source: gxShape; VAR dashMappings: gxMapping): LONGINT; C;
FUNCTION GXGetShapeDeviceArea(source: gxShape; port: gxViewPort; device: gxViewDevice): LONGINT; C;
FUNCTION GXGetShapeDeviceBounds(source: gxShape; port: gxViewPort; device: gxViewDevice; VAR bounds: gxRectangle): BOOLEAN; C;
FUNCTION GXGetShapeDeviceColors(source: gxShape; port: gxViewPort; device: gxViewDevice; VAR width: LONGINT): gxColorSet; C;
FUNCTION GXGetShapeGlobalBounds(source: gxShape; port: gxViewPort; group: gxViewGroup; VAR bounds: gxRectangle): BOOLEAN; C;
FUNCTION GXGetShapeGlobalViewDevices(source: gxShape; port: gxViewPort; VAR list: gxViewDevice): LONGINT; C;
FUNCTION GXGetShapeGlobalViewPorts(source: gxShape; VAR list: gxViewPort): LONGINT; C;
FUNCTION GXGetShapeLocalBounds(source: gxShape; VAR bounds: gxRectangle): gxRectanglePtr; C;
{  returns the number of positions  }
FUNCTION GXGetShapePatternPositions(source: gxShape; VAR positions: gxPoint): LONGINT; C;
PROCEDURE GXGetShapeLocalFontMetrics(sourceShape: gxShape; VAR before: gxPoint; VAR after: gxPoint; VAR caretAngle: gxPoint; VAR caretOffset: gxPoint); C;
PROCEDURE GXGetShapeDeviceFontMetrics(sourceShape: gxShape; port: gxViewPort; device: gxViewDevice; VAR before: gxPoint; VAR after: gxPoint; VAR caretAngle: gxPoint; VAR caretOffset: gxPoint); C;
FUNCTION GXGetViewGroupViewDevices(source: gxViewGroup; VAR list: gxViewDevice): LONGINT; C;
FUNCTION GXGetViewGroupViewPorts(source: gxViewGroup; VAR list: gxViewPort): LONGINT; C;
FUNCTION GXGetViewPortGlobalMapping(source: gxViewPort; VAR map: gxMapping): gxMappingPtr; C;
FUNCTION GXGetViewPortViewDevices(source: gxViewPort; VAR list: gxViewDevice): LONGINT; C;
FUNCTION GXHitTestPicture(target: gxShape; {CONST}VAR test: gxPoint; VAR result: gxHitTestInfo; level: LONGINT; depth: LONGINT): gxShape; C;
FUNCTION GXIntersectRectangle(VAR target: gxRectangle; {CONST}VAR source: gxRectangle; {CONST}VAR operand: gxRectangle): BOOLEAN; C;
FUNCTION GXUnionRectangle(VAR target: gxRectangle; {CONST}VAR source: gxRectangle; {CONST}VAR operand: gxRectangle): gxRectanglePtr; C;
FUNCTION GXTouchesRectanglePoint({CONST}VAR target: gxRectangle; {CONST}VAR test: gxPoint): BOOLEAN; C;
FUNCTION GXTouchesShape(target: gxShape; test: gxShape): BOOLEAN; C;
FUNCTION GXTouchesBoundsShape({CONST}VAR target: gxRectangle; test: gxShape): BOOLEAN; C;
FUNCTION GXContainsRectangle({CONST}VAR container: gxRectangle; {CONST}VAR test: gxRectangle): BOOLEAN; C;
FUNCTION GXContainsShape(container: gxShape; test: gxShape): BOOLEAN; C;
FUNCTION GXContainsBoundsShape({CONST}VAR container: gxRectangle; test: gxShape; index: LONGINT): BOOLEAN; C;
FUNCTION GXConvertColor(VAR target: gxColor; space: gxColorSpace; aSet: gxColorSet; profile: gxColorProfile): gxColorPtr; C;
FUNCTION GXCombineColor(VAR target: gxColor; operand: gxInk): gxColorPtr; C;
FUNCTION GXCheckColor({CONST}VAR source: gxColor; space: gxColorSpace; aSet: gxColorSet; profile: gxColorProfile): BOOLEAN; C;
FUNCTION GXCheckBitmapColor(source: gxShape; {CONST}VAR area: gxLongRectangle; space: gxColorSpace; aSet: gxColorSet; profile: gxColorProfile): gxShape; C;
FUNCTION GXGetHalftoneDeviceAngle(source: gxViewDevice; {CONST}VAR data: gxHalftone): Fixed; C;
FUNCTION GXGetColorSetParts(source: gxColorSet; index: LONGINT; count: LONGINT; VAR space: gxColorSpace; VAR data: gxSetColor): LONGINT; C;
{  returns the glyph count  }
FUNCTION GXGetGlyphParts(source: gxShape; index: LONGINT; charCount: LONGINT; VAR byteLength: LONGINT; VAR text: UInt8; VAR positions: gxPoint; VAR advanceBits: LONGINT; VAR tangents: gxPoint; VAR runCount: LONGINT; VAR styleRuns: INTEGER; VAR styles: gxStyle): LONGINT; C;
FUNCTION GXGetPathParts(source: gxShape; index: LONGINT; count: LONGINT; VAR data: gxPaths): LONGINT; C;
FUNCTION GXGetPictureParts(source: gxShape; index: LONGINT; count: LONGINT; VAR shapes: gxShape; VAR styles: gxStyle; VAR inks: gxInk; VAR transforms: gxTransform): LONGINT; C;
FUNCTION GXGetPolygonParts(source: gxShape; index: LONGINT; count: LONGINT; VAR data: gxPolygons): LONGINT; C;
FUNCTION GXGetShapeParts(source: gxShape; index: LONGINT; count: LONGINT; destination: gxShape): gxShape; C;
FUNCTION GXGetTextParts(source: gxShape; index: LONGINT; charCount: LONGINT; VAR text: UInt8): LONGINT; C;
PROCEDURE GXSetColorSetParts(target: gxColorSet; index: LONGINT; oldCount: LONGINT; newCount: LONGINT; {CONST}VAR data: gxSetColor); C;
PROCEDURE GXSetGlyphParts(source: gxShape; index: LONGINT; oldCharCount: LONGINT; newCharCount: LONGINT; {CONST}VAR text: UInt8; {CONST}VAR positions: gxPoint; {CONST}VAR advanceBits: LONGINT; {CONST}VAR tangents: gxPoint; {CONST}VAR styleRuns: INTEGER; {CONST}VAR styles: gxStyle); C;
PROCEDURE GXSetPathParts(target: gxShape; index: LONGINT; count: LONGINT; {CONST}VAR data: gxPaths; flags: gxEditShapeFlag); C;
PROCEDURE GXSetPictureParts(target: gxShape; index: LONGINT; oldCount: LONGINT; newCount: LONGINT; {CONST}VAR shapes: gxShape; {CONST}VAR styles: gxStyle; {CONST}VAR inks: gxInk; {CONST}VAR transforms: gxTransform); C;
PROCEDURE GXSetPolygonParts(target: gxShape; index: LONGINT; count: LONGINT; {CONST}VAR data: gxPolygons; flags: gxEditShapeFlag); C;
PROCEDURE GXSetShapeParts(target: gxShape; index: LONGINT; count: LONGINT; insert: gxShape; flags: gxEditShapeFlag); C;
PROCEDURE GXSetTextParts(target: gxShape; index: LONGINT; oldCharCount: LONGINT; newCharCount: LONGINT; {CONST}VAR text: UInt8); C;
FUNCTION GXGetShapePoints(source: gxShape; index: LONGINT; count: LONGINT; VAR data: gxPoint): LONGINT; C;
PROCEDURE GXSetShapePoints(target: gxShape; index: LONGINT; count: LONGINT; {CONST}VAR data: gxPoint); C;
FUNCTION GXGetGlyphPositions(source: gxShape; index: LONGINT; charCount: LONGINT; VAR advance: LONGINT; VAR positions: gxPoint): LONGINT; C;
FUNCTION GXGetGlyphTangents(source: gxShape; index: LONGINT; charCount: LONGINT; VAR tangents: gxPoint): LONGINT; C;
PROCEDURE GXSetGlyphPositions(target: gxShape; index: LONGINT; charCount: LONGINT; {CONST}VAR advance: LONGINT; {CONST}VAR positions: gxPoint); C;
PROCEDURE GXSetGlyphTangents(target: gxShape; index: LONGINT; charCount: LONGINT; {CONST}VAR tangents: gxPoint); C;
FUNCTION GXGetGlyphMetrics(source: gxShape; VAR glyphOrigins: gxPoint; VAR boundingBoxes: gxRectangle; VAR sideBearings: gxPoint): LONGINT; C;
PROCEDURE GXDifferenceShape(target: gxShape; operand: gxShape); C;
PROCEDURE GXExcludeShape(target: gxShape; operand: gxShape); C;
PROCEDURE GXIntersectShape(target: gxShape; operand: gxShape); C;
PROCEDURE GXMapShape(target: gxShape; {CONST}VAR map: gxMapping); C;
PROCEDURE GXMoveShape(target: gxShape; deltaX: Fixed; deltaY: Fixed); C;
PROCEDURE GXMoveShapeTo(target: gxShape; x: Fixed; y: Fixed); C;
PROCEDURE GXReverseDifferenceShape(target: gxShape; operand: gxShape); C;
PROCEDURE GXRotateShape(target: gxShape; degrees: Fixed; xOffset: Fixed; yOffset: Fixed); C;
PROCEDURE GXScaleShape(target: gxShape; hScale: Fixed; vScale: Fixed; xOffset: Fixed; yOffset: Fixed); C;
PROCEDURE GXSkewShape(target: gxShape; xSkew: Fixed; ySkew: Fixed; xOffset: Fixed; yOffset: Fixed); C;
PROCEDURE GXUnionShape(target: gxShape; operand: gxShape); C;
PROCEDURE GXDifferenceTransform(target: gxTransform; operand: gxShape); C;
PROCEDURE GXExcludeTransform(target: gxTransform; operand: gxShape); C;
PROCEDURE GXIntersectTransform(target: gxTransform; operand: gxShape); C;
PROCEDURE GXMapTransform(target: gxTransform; {CONST}VAR map: gxMapping); C;
PROCEDURE GXMoveTransform(target: gxTransform; deltaX: Fixed; deltaY: Fixed); C;
PROCEDURE GXMoveTransformTo(target: gxTransform; x: Fixed; y: Fixed); C;
PROCEDURE GXReverseDifferenceTransform(target: gxTransform; operand: gxShape); C;
PROCEDURE GXRotateTransform(target: gxTransform; degrees: Fixed; xOffset: Fixed; yOffset: Fixed); C;
PROCEDURE GXScaleTransform(target: gxTransform; hScale: Fixed; vScale: Fixed; xOffset: Fixed; yOffset: Fixed); C;
PROCEDURE GXSkewTransform(target: gxTransform; xSkew: Fixed; ySkew: Fixed; xOffset: Fixed; yOffset: Fixed); C;
PROCEDURE GXUnionTransform(target: gxTransform; operand: gxShape); C;
PROCEDURE GXBreakShape(target: gxShape; index: LONGINT); C;
PROCEDURE GXChangedShape(target: gxShape); C;
FUNCTION GXHitTestShape(target: gxShape; {CONST}VAR test: gxPoint; VAR result: gxHitTestInfo): gxShapePart; C;
FUNCTION GXHitTestDevice(target: gxShape; port: gxViewPort; device: gxViewDevice; {CONST}VAR test: gxPoint; {CONST}VAR tolerance: gxPoint): gxShape; C;
PROCEDURE GXInsetShape(target: gxShape; inset: Fixed); C;
PROCEDURE GXInvertShape(target: gxShape); C;
PROCEDURE GXPrimitiveShape(target: gxShape); C;
PROCEDURE GXReduceShape(target: gxShape; contour: LONGINT); C;
PROCEDURE GXReverseShape(target: gxShape; contour: LONGINT); C;
PROCEDURE GXSimplifyShape(target: gxShape); C;
PROCEDURE GXLockColorProfile(source: gxColorProfile); C;
PROCEDURE GXUnlockColorProfile(source: gxColorProfile); C;
FUNCTION GXGetColorProfileStructure(source: gxColorProfile; VAR length: LONGINT): Ptr; C;
PROCEDURE GXFlattenShape(source: gxShape; flags: gxFlattenFlag; VAR block: gxSpoolBlock); C;
FUNCTION GXUnflattenShape(VAR block: gxSpoolBlock; count: LONGINT; {CONST}VAR portList: gxViewPort): gxShape; C;
PROCEDURE GXPostGraphicsNotice(notice: gxGraphicsNotice); C;
PROCEDURE GXIgnoreGraphicsNotice(notice: gxGraphicsNotice); C;
PROCEDURE GXPopGraphicsNotice; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GXGraphicsIncludes}

{$ENDC} {__GXGRAPHICS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
