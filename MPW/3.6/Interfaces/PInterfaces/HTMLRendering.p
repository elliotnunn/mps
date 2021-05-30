{
     File:       HTMLRendering.p
 
     Contains:   HTML Rendering Library Interfaces.
 
     Version:    Technology: 1.0
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
 UNIT HTMLRendering;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __HTMLRENDERING__}
{$SETC __HTMLRENDERING__ := 1}

{$I+}
{$SETC HTMLRenderingIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __CODEFRAGMENTS__}
{$I CodeFragments.p}
{$ENDC}
{$IFC UNDEFINED __CONTROLS__}
{$I Controls.p}
{$ENDC}
{$IFC UNDEFINED __CFDATA__}
{$I CFData.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{$IFC UNDEFINED __CFURL__}
{$I CFURL.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	HRReference    = ^LONGINT; { an opaque 32-bit type }
	HRReferencePtr = ^HRReference;  { when a VAR xx:HRReference parameter can be nil, it is changed to xx: HRReferencePtr }
	{
	 *  HRGetHTMLRenderingLibVersion()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION HRGetHTMLRenderingLibVersion(VAR returnVers: NumVersion): OSStatus;

{$IFC TARGET_RT_MAC_CFM }
{$ELSEC}
  {$IFC TARGET_RT_MAC_MACHO }
  {$ENDC}
{$ENDC}


CONST
	kHRRendererHTML32Type		= 'ht32';						{  HTML 3.2  }


	{
	 *  HRNewReference()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION HRNewReference(VAR hrRef: HRReference; rendererType: OSType; grafPtr: GrafPtr): OSStatus;

{
 *  HRNewReferenceInWindow()
 *  
 *  Discussion:
 *    Use this API from  a Carbon App. All the contrrols created by the
 *    HTML renderer will be embedded in the root control of the window
 *    specified by the window ref.
 *  
 *  Parameters:
 *    
 *    hrRef:
 *      Pointer to the new reference created and returned by the
 *      renderer.
 *    
 *    rendererType:
 *      Type of the renderer e.g. kHRRendererHTML32Type. Only this type
 *      is supported for now.
 *    
 *    inWindowRef:
 *      Reference to the window for which rendering area will be
 *      specified.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRNewReferenceInWindow(VAR hrRef: HRReference; rendererType: OSType; inWindowRef: WindowRef): OSStatus;

{
 *  HRDisposeReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRDisposeReference(hrRef: HRReference): OSStatus;


{
 *  HRFreeMemory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRFreeMemory(inBytesNeeded: Size): SInt32;


{ System level notifications }
{
 *  HRScreenConfigurationChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE HRScreenConfigurationChanged;

{
 *  HRIsHREvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRIsHREvent({CONST}VAR eventRecord: EventRecord): BOOLEAN;


{ Drawing }
{
 *  HRSetGrafPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRSetGrafPtr(hrRef: HRReference; grafPtr: GrafPtr): OSStatus;

{
 *  HRSetWindowRef()
 *  
 *  Discussion:
 *    Use this API from  a Carbon App. All the contrrols created by the
 *    HTML renderer will be moved in the root control of the window
 *    specified by the window ref. All the drawing will now happen in
 *    the specified window.
 *  
 *  Parameters:
 *    
 *    hrRef:
 *      Reference to the renderer object.
 *    
 *    windowRef:
 *      new Reference to the window to be attached to the above hrRef.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRSetWindowRef(hrRef: HRReference; windowRef: WindowRef): OSStatus;

{
 *  HRSetEmbeddingControl()
 *  
 *  Discussion:
 *    Use this API to tell the HTML Renderer to embed all the controls
 *    it has created so far and the new controls it creates after this
 *    call to be embedded in the given control. Useful if you wish to
 *    have an HTML displayed with in your dialog. e.g. Software Update
 *    needs this.
 *  
 *  Parameters:
 *    
 *    hrRef:
 *      Reference to the renderer object.
 *    
 *    controlRef:
 *      all the future controls created by renderer are embeded in this
 *      controlRef.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRSetEmbeddingControl(hrRef: HRReference; controlRef: ControlRef): OSStatus;

{
 *  HRActivate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRActivate(hrRef: HRReference): OSStatus;

{
 *  HRDeactivate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRDeactivate(hrRef: HRReference): OSStatus;

{
 *  HRDraw()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRDraw(hrRef: HRReference; updateRgnH: RgnHandle): OSStatus;

{
 *  HRDrawInPort()
 *  
 *  Discussion:
 *    Use this API from  a Carbon App.  All the drawing will now happen
 *    in the specified port. This is the API you want to use to draw in
 *    an offscreen port, for example when printing. You could also use
 *    this API to draw in an on screen port.
 *  
 *  Parameters:
 *    
 *    hrRef:
 *      Reference to the renderer object.
 *    
 *    updateRgnH:
 *      Region to be updated.
 *    
 *    grafPtr:
 *      A graf pointer to render HTML into.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRDrawInPort(hrRef: HRReference; updateRgnH: RgnHandle; grafPtr: CGrafPtr): OSStatus;

{
 *  HRSetRenderingRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRSetRenderingRect(hrRef: HRReference; {CONST}VAR renderingRect: Rect): OSStatus;

{
 *  HRGetRenderedImageSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRGetRenderedImageSize(hrRef: HRReference; VAR renderingSize: Point): OSStatus;

{
 *  HRGetRenderedImageSize32()
 *  
 *  Discussion:
 *    Use this API when the rendered image could have coordinates
 *    larger than what SInt16 can hold.
 *  
 *  Parameters:
 *    
 *    hrRef:
 *      Reference to the renderer object.
 *    
 *    height:
 *      Height of the image is returned in this parameter.
 *    
 *    width:
 *      Width of the image is returned in this parameter.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRGetRenderedImageSize32(hrRef: HRReference; VAR height: UInt32; VAR width: UInt32): OSStatus;

{
 *  HRScrollToLocation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRScrollToLocation(hrRef: HRReference; VAR location: Point): OSStatus;

{
 *  HRScrollToImageLocation32()
 *  
 *  Discussion:
 *    Use this API when specifying location to scroll to. Location is
 *    specified in image space.
 *  
 *  Parameters:
 *    
 *    hrRef:
 *      Reference to the renderer object.
 *    
 *    h:
 *      Horizontal location.
 *    
 *    v:
 *      Vertical location.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRScrollToImageLocation32(hrRef: HRReference; h: SInt32; v: SInt32): OSStatus;

{
 *  HRForceQuickdraw()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRForceQuickdraw(hrRef: HRReference; forceQuickdraw: BOOLEAN): OSStatus;


TYPE
	HRScrollbarState 			= SInt16;
CONST
	eHRScrollbarOn				= 0;
	eHRScrollbarOff				= 1;
	eHRScrollbarAuto			= 2;

	{
	 *  HRSetScrollbarState()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION HRSetScrollbarState(hrRef: HRReference; hScrollbarState: HRScrollbarState; vScrollbarState: HRScrollbarState): OSStatus;

{
 *  HRSetDrawBorder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRSetDrawBorder(hrRef: HRReference; drawBorder: BOOLEAN): OSStatus;

{
 *  HRSetGrowboxCutout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRSetGrowboxCutout(hrRef: HRReference; allowCutout: BOOLEAN): OSStatus;

{ Navigation }
{
 *  HRGoToFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRGoToFile(hrRef: HRReference; {CONST}VAR fsspec: FSSpec; addToHistory: BOOLEAN; forceRefresh: BOOLEAN): OSStatus;

{
 *  HRGoToURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRGoToURL(hrRef: HRReference; url: ConstCStringPtr; addToHistory: BOOLEAN; forceRefresh: BOOLEAN): OSStatus;

{
 *  HRGoToAnchor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRGoToAnchor(hrRef: HRReference; anchorName: ConstCStringPtr): OSStatus;

{
 *  HRGoToPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRGoToPtr(hrRef: HRReference; buffer: CStringPtr; bufferSize: UInt32; addToHistory: BOOLEAN; forceRefresh: BOOLEAN): OSStatus;

{
 *  HRGoToFSRef()
 *  
 *  Discussion:
 *    Use these API from  a Carbon App instead of using HRGoToFile,
 *    HRGoToURL, HRGoToAnchor and HRGoToPtr. These APIs are same in
 *    behavior with their old counter parts. The only difference is
 *    that they take FSRef, CFURLRef, CFString, and CFData as
 *    parameters.
 *  
 *  Parameters:
 *    
 *    hrRef:
 *      Reference to the renderer object.
 *    
 *    fref:
 *      Reference to HTML file that is be opened and rendered.
 *    
 *    addToHistory:
 *      true if this file URL should be added to history.
 *    
 *    forceRefresh:
 *      true if the rendering area should be refreshed.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRGoToFSRef(hrRef: HRReference; {CONST}VAR fref: FSRef; addToHistory: BOOLEAN; forceRefresh: BOOLEAN): OSStatus;

{
 *  HRGoToCFURL()
 *  
 *  Discussion:
 *    Use these API from  a Carbon App instead of using HRGoToFile,
 *    HRGoToURL, HRGoToAnchor and HRGoToPtr. These APIs are same in
 *    behavior with their old counter parts. The only difference is
 *    that they take FSRef, CFURLRef, CFString, and CFData as
 *    parameters.
 *  
 *  Parameters:
 *    
 *    hrRef:
 *      Reference to the renderer object.
 *    
 *    url:
 *      Reference to url that is be rendered.
 *    
 *    addToHistory:
 *      true if this URL should be added to history.
 *    
 *    forceRefresh:
 *      true if the rendering area should be refreshed.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRGoToCFURL(hrRef: HRReference; url: CFURLRef; addToHistory: BOOLEAN; forceRefresh: BOOLEAN): OSStatus;

{
 *  HRGoToAnchorCFString()
 *  
 *  Discussion:
 *    Use these API from  a Carbon App instead of using HRGoToFile,
 *    HRGoToURL, HRGoToAnchor and HRGoToPtr. These APIs are same in
 *    behavior with their old counter parts. The only difference is
 *    that they take FSRef, CFURLRef, CFString, and CFData as
 *    parameters.
 *  
 *  Parameters:
 *    
 *    hrRef:
 *      Reference to the renderer object.
 *    
 *    anchorName:
 *      Name of the anchor to be displayed.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRGoToAnchorCFString(hrRef: HRReference; anchorName: CFStringRef): OSStatus;

{
 *  HRGoToData()
 *  
 *  Discussion:
 *    Use these API from  a Carbon App instead of using HRGoToFile,
 *    HRGoToURL, HRGoToAnchor and HRGoToPtr. These APIs are same in
 *    behavior with their old counter parts. The only difference is
 *    that they take FSRef, CFURLRef, CFString, and CFData as
 *    parameters.
 *  
 *  Parameters:
 *    
 *    hrRef:
 *      Reference to the renderer object.
 *    
 *    data:
 *      Reference to data in the memory that is be rendered.
 *    
 *    addToHistory:
 *      true if this file URL should be added to history.
 *    
 *    forceRefresh:
 *      true if the rendering area should be refreshed.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRGoToData(hrRef: HRReference; data: CFDataRef; addToHistory: BOOLEAN; forceRefresh: BOOLEAN): OSStatus;

{ Accessors }
{ either file url or url of <base> tag }
{
 *  HRGetRootURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRGetRootURL(hrRef: HRReference; rootURLH: Handle): OSStatus;

{ url of <base> tag }
{
 *  HRGetBaseURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRGetBaseURL(hrRef: HRReference; baseURLH: Handle): OSStatus;

{ file url }
{
 *  HRGetHTMLURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRGetHTMLURL(hrRef: HRReference; HTMLURLH: Handle): OSStatus;

{
 *  HRGetTitle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRGetTitle(hrRef: HRReference; title: StringPtr): OSStatus;

{
 *  HRGetHTMLFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRGetHTMLFile(hrRef: HRReference; VAR fsspec: FSSpec): OSStatus;


{
 *  HRGetRootURLAsCFString()
 *  
 *  Discussion:
 *    Use these API from  a Carbon App instead of using HRGetRootURL,
 *    HRGetBaseURL, HRGetHTMLURL, HRGetTitle and HRGetHTMLFile. These
 *    APIs are same in behavior with their old counter parts. The only
 *    difference is that they take CFString, CFURLRef, and FSRef as
 *    parameters.
 *  
 *  Parameters:
 *    
 *    hrRef:
 *      Reference to the renderer object.
 *    
 *    rootString:
 *      Get CFString equivalent for the root url.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRGetRootURLAsCFString(hrRef: HRReference; VAR rootString: CFStringRef): OSStatus;

{
 *  HRGetBaseURLAsCFString()
 *  
 *  Discussion:
 *    Use these API from  a Carbon App instead of using HRGetRootURL,
 *    HRGetBaseURL, HRGetHTMLURL, HRGetTitle and HRGetHTMLFile. These
 *    APIs are same in behavior with their old counter parts. The only
 *    difference is that they take CFString, CFURLRef, and FSRef as
 *    parameters.
 *  
 *  Parameters:
 *    
 *    hrRef:
 *      Reference to the renderer object.
 *    
 *    baseString:
 *      Get CFString equivalent for the base url.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRGetBaseURLAsCFString(hrRef: HRReference; VAR baseString: CFStringRef): OSStatus;

{
 *  HRGetHTMLURLAsCFURL()
 *  
 *  Discussion:
 *    Use these API from  a Carbon App instead of using HRGetRootURL,
 *    HRGetBaseURL, HRGetHTMLURL, HRGetTitle and HRGetHTMLFile. These
 *    APIs are same in behavior with their old counter parts. The only
 *    difference is that they take CFString, CFURLRef, and FSRef as
 *    parameters.
 *  
 *  Parameters:
 *    
 *    hrRef:
 *      Reference to the renderer object.
 *    
 *    theURL:
 *      Get currently displayed HTML as a CFURL.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRGetHTMLURLAsCFURL(hrRef: HRReference; VAR theURL: CFURLRef): OSStatus;

{
 *  HRGetTitleAsCFString()
 *  
 *  Discussion:
 *    Use these API from  a Carbon App instead of using HRGetRootURL,
 *    HRGetBaseURL, HRGetHTMLURL, HRGetTitle and HRGetHTMLFile. These
 *    APIs are same in behavior with their old counter parts. The only
 *    difference is that they take CFString, CFURLRef, and FSRef as
 *    parameters.
 *  
 *  Parameters:
 *    
 *    hrRef:
 *      Reference to the renderer object.
 *    
 *    title:
 *      Get title of the currently displayed HTML as a CFString.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRGetTitleAsCFString(hrRef: HRReference; VAR title: CFStringRef): OSStatus;

{
 *  HRGetHTMLFileAsFSRef()
 *  
 *  Discussion:
 *    Use these API from  a Carbon App instead of using HRGetRootURL,
 *    HRGetBaseURL, HRGetHTMLURL, HRGetTitle and HRGetHTMLFile. These
 *    APIs are same in behavior with their old counter parts. The only
 *    difference is that they take CFString, CFURLRef, and FSRef as
 *    parameters.
 *  
 *  Parameters:
 *    
 *    hrRef:
 *      Reference to the renderer object.
 *    
 *    fref:
 *      Get currently displayed HTML as a FSRef.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRGetHTMLFileAsFSRef(hrRef: HRReference; VAR fref: FSRef): OSStatus;

{ Utilities }
{
 *  HRUtilCreateFullURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRUtilCreateFullURL(rootURL: ConstCStringPtr; linkURL: ConstCStringPtr; fullURLH: Handle): OSStatus;

{
 *  HRUtilGetFSSpecFromURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRUtilGetFSSpecFromURL(rootURL: ConstCStringPtr; linkURL: ConstCStringPtr; VAR destSpec: FSSpec): OSStatus;

{ urlHandle should be valid on input }
{
 *  HRUtilGetURLFromFSSpec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRUtilGetURLFromFSSpec({CONST}VAR fsspec: FSSpec; urlHandle: Handle): OSStatus;


{
 *  HRUtilCreateFullCFURL()
 *  
 *  Discussion:
 *    Use these API from  a Carbon App instead of using
 *    HRUtilCreateFullURL, HRUtilGetFSSpecFromURL,
 *    HRUtilGetURLFromFSSpec. These APIs are same in behavior with
 *    their old counter parts. The only difference is that they take
 *    CFURLRef, and FSRef as parameters.
 *  
 *  Parameters:
 *    
 *    rootString:
 *      a CFString for the root.
 *    
 *    linkString:
 *      a CFString for a partial link.
 *    
 *    url:
 *      Fully qualified URL is returned after attaching a link string
 *      to the root.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRUtilCreateFullCFURL(rootString: CFStringRef; linkString: CFStringRef; VAR url: CFURLRef): OSStatus;

{
 *  HRUtilGetFSRefFromURL()
 *  
 *  Discussion:
 *    Use these API from  a Carbon App instead of using
 *    HRUtilCreateFullURL, HRUtilGetFSSpecFromURL,
 *    HRUtilGetURLFromFSSpec. These APIs are same in behavior with
 *    their old counter parts. The only difference is that they take
 *    CFURLRef, and FSRef as parameters.
 *  
 *  Parameters:
 *    
 *    rootString:
 *      a CFString for the root.
 *    
 *    linkString:
 *      a CFString for a partial link.
 *    
 *    destRef:
 *      File reference is returned for the complete path created after
 *      attaching link string to the root. If File does not exist,
 *      fnfErr is returned as a function result.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRUtilGetFSRefFromURL(rootString: CFStringRef; linkString: CFStringRef; VAR destRef: FSRef): OSStatus;

{
 *  HRUtilGetURLFromFSRef()
 *  
 *  Discussion:
 *    Use these API from  a Carbon App instead of using
 *    HRUtilCreateFullURL, HRUtilGetFSSpecFromURL,
 *    HRUtilGetURLFromFSSpec. These APIs are same in behavior with
 *    their old counter parts. The only difference is that they take
 *    CFURLRef, and FSRef as parameters.
 *  
 *  Parameters:
 *    
 *    fileRef:
 *      Refernce to a file whose URL is desired.
 *    
 *    url:
 *      a fully qualified URL is returned in this parameter. The
 *      returned URL gives the path of the file specified in the above
 *      parameter.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HRUtilGetURLFromFSRef({CONST}VAR fileRef: FSRef; VAR url: CFURLRef): OSStatus;

{
    Visited links

    If you register a function here, it will be called to determine
    whether or not the given URL has been visited. It should return
    true if the URL has been visited.
    
    In addition to the URLs that the application may add to the list
    of visited links, it should also add URLs that the user clicks
    on. These URLs can be caught by the "add URL to history" callback
    below.
 }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	HRWasURLVisitedProcPtr = FUNCTION(url: ConstCStringPtr; refCon: UNIV Ptr): BOOLEAN;
{$ELSEC}
	HRWasURLVisitedProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	HRWasURLVisitedUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	HRWasURLVisitedUPP = UniversalProcPtr;
{$ENDC}	
	{
	 *  HRRegisterWasURLVisitedUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
PROCEDURE HRRegisterWasURLVisitedUPP(inWasURLVisitedUPP: HRWasURLVisitedUPP; hrRef: HRReference; inRefCon: UNIV Ptr);

{
 *  HRUnregisterWasURLVisitedUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE HRUnregisterWasURLVisitedUPP(hrRef: HRReference);

{
    Use these API from  a Carbon App instead of using HRRegisterWasURLVisitedUPP, HRUnregisterWasURLVisitedUPP. 
    These APIs are same in behavior with their old counter parts. The only difference is that they take 
    CFURLRef as parameters.
        
}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	HRWasCFURLVisitedProcPtr = FUNCTION(url: CFURLRef; refCon: UNIV Ptr): BOOLEAN;
{$ELSEC}
	HRWasCFURLVisitedProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	HRWasCFURLVisitedUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	HRWasCFURLVisitedUPP = HRWasCFURLVisitedProcPtr;
{$ENDC}	
	{
	 *  HRRegisterWasCFURLVisitedUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.3 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
PROCEDURE HRRegisterWasCFURLVisitedUPP(inWasCFURLVisitedUPP: HRWasCFURLVisitedUPP; hrRef: HRReference; inRefCon: UNIV Ptr);

{
 *  HRUnregisterWasCFURLVisitedUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE HRUnregisterWasCFURLVisitedUPP(hrRef: HRReference);


{
    New URL

    If you register a function here, it will be called every time
    the renderer is going to display a new URL. A few examples of how
    you might use this include...
    
        (a) maintaining a history of URLs
        (b) maintainging a list of visited links
        (c) setting a window title based on the new URL
}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	HRNewURLProcPtr = FUNCTION(url: ConstCStringPtr; targetFrame: ConstCStringPtr; addToHistory: BOOLEAN; refCon: UNIV Ptr): OSStatus;
{$ELSEC}
	HRNewURLProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	HRNewURLUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	HRNewURLUPP = UniversalProcPtr;
{$ENDC}	
	{
	 *  HRRegisterNewURLUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
PROCEDURE HRRegisterNewURLUPP(inNewURLUPP: HRNewURLUPP; hrRef: HRReference; inRefCon: UNIV Ptr);

{
 *  HRUnregisterNewURLUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE HRUnregisterNewURLUPP(hrRef: HRReference);


{ 
    Use these API from  a Carbon App instead of using HRRegisterNewURLUPP, HRUnregisterNewURLUPP. 
    These APIs are same in behavior with their old counter parts. The only difference is that they take 
    CFURLRef as parameters.
}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	HRNewCFURLProcPtr = FUNCTION(url: CFURLRef; targetString: CFStringRef; addToHistory: BOOLEAN; refCon: UNIV Ptr): OSStatus;
{$ELSEC}
	HRNewCFURLProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	HRNewCFURLUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	HRNewCFURLUPP = HRNewCFURLProcPtr;
{$ENDC}	
	{
	 *  HRRegisterNewCFURLUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.3 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
PROCEDURE HRRegisterNewCFURLUPP(inURLUPP: HRNewCFURLUPP; hrRef: HRReference; inRefCon: UNIV Ptr);

{
 *  HRUnregisterNewCFURLUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE HRUnregisterNewCFURLUPP(hrRef: HRReference);




{
    URL to FSSpec function

    If you register a function here, it will be called every time
    the renderer is going to locate a file. The function will be
    passed an enum indicating the type of file being asked for.
 }

TYPE
	URLSourceType 				= UInt16;
CONST
	kHRLookingForHTMLSource		= 1;
	kHRLookingForImage			= 2;
	kHRLookingForEmbedded		= 3;
	kHRLookingForImageMap		= 4;
	kHRLookingForFrame			= 5;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	HRURLToFSSpecProcPtr = FUNCTION(rootURL: ConstCStringPtr; linkURL: ConstCStringPtr; VAR fsspec: FSSpec; urlSourceType: URLSourceType; refCon: UNIV Ptr): OSStatus;
{$ELSEC}
	HRURLToFSSpecProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	HRURLToFSSpecUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	HRURLToFSSpecUPP = UniversalProcPtr;
{$ENDC}	
	{
	 *  HRRegisterURLToFSSpecUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
PROCEDURE HRRegisterURLToFSSpecUPP(inURLToFSSpecUPP: HRURLToFSSpecUPP; hrRef: HRReference; inRefCon: UNIV Ptr);

{
 *  HRUnregisterURLToFSSpecUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE HRUnregisterURLToFSSpecUPP(hrRef: HRReference);


{ 
    Use these API from  a Carbon App instead of using HRRegisterURLToFSSpecUPP, HRUnregisterURLToFSSpecUPP. 
    These APIs are same in behavior with their old counter parts. The only difference is that they take 
    FSRef as parameters.
}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	HRURLToFSRefProcPtr = FUNCTION(rootString: CFStringRef; linkString: CFStringRef; VAR fref: FSRef; urlSourceType: URLSourceType; refCon: UNIV Ptr): OSStatus;
{$ELSEC}
	HRURLToFSRefProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	HRURLToFSRefUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	HRURLToFSRefUPP = HRURLToFSRefProcPtr;
{$ENDC}	
	{
	 *  HRRegisterURLToFSRefUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.3 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
PROCEDURE HRRegisterURLToFSRefUPP(inURLToFSRefUPP: HRURLToFSRefUPP; hrRef: HRReference; inRefCon: UNIV Ptr);

{
 *  HRUnregisterURLToFSRefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE HRUnregisterURLToFSRefUPP(hrRef: HRReference);


CONST
	uppHRWasURLVisitedProcInfo = $000003D0;
	uppHRWasCFURLVisitedProcInfo = $000003D0;
	uppHRNewURLProcInfo = $000037F0;
	uppHRNewCFURLProcInfo = $000037F0;
	uppHRURLToFSSpecProcInfo = $0000EFF0;
	uppHRURLToFSRefProcInfo = $0000EFF0;
	{
	 *  NewHRWasURLVisitedUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewHRWasURLVisitedUPP(userRoutine: HRWasURLVisitedProcPtr): HRWasURLVisitedUPP; { old name was NewHRWasURLVisitedProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewHRWasCFURLVisitedUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewHRWasCFURLVisitedUPP(userRoutine: HRWasCFURLVisitedProcPtr): HRWasCFURLVisitedUPP;
{
 *  NewHRNewURLUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewHRNewURLUPP(userRoutine: HRNewURLProcPtr): HRNewURLUPP; { old name was NewHRNewURLProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewHRNewCFURLUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewHRNewCFURLUPP(userRoutine: HRNewCFURLProcPtr): HRNewCFURLUPP;
{
 *  NewHRURLToFSSpecUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewHRURLToFSSpecUPP(userRoutine: HRURLToFSSpecProcPtr): HRURLToFSSpecUPP; { old name was NewHRURLToFSSpecProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewHRURLToFSRefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewHRURLToFSRefUPP(userRoutine: HRURLToFSRefProcPtr): HRURLToFSRefUPP;
{
 *  DisposeHRWasURLVisitedUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeHRWasURLVisitedUPP(userUPP: HRWasURLVisitedUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeHRWasCFURLVisitedUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeHRWasCFURLVisitedUPP(userUPP: HRWasCFURLVisitedUPP);
{
 *  DisposeHRNewURLUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeHRNewURLUPP(userUPP: HRNewURLUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeHRNewCFURLUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeHRNewCFURLUPP(userUPP: HRNewCFURLUPP);
{
 *  DisposeHRURLToFSSpecUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeHRURLToFSSpecUPP(userUPP: HRURLToFSSpecUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeHRURLToFSRefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeHRURLToFSRefUPP(userUPP: HRURLToFSRefUPP);
{
 *  InvokeHRWasURLVisitedUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeHRWasURLVisitedUPP(url: ConstCStringPtr; refCon: UNIV Ptr; userRoutine: HRWasURLVisitedUPP): BOOLEAN; { old name was CallHRWasURLVisitedProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeHRWasCFURLVisitedUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeHRWasCFURLVisitedUPP(url: CFURLRef; refCon: UNIV Ptr; userRoutine: HRWasCFURLVisitedUPP): BOOLEAN;
{
 *  InvokeHRNewURLUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeHRNewURLUPP(url: ConstCStringPtr; targetFrame: ConstCStringPtr; addToHistory: BOOLEAN; refCon: UNIV Ptr; userRoutine: HRNewURLUPP): OSStatus; { old name was CallHRNewURLProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeHRNewCFURLUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeHRNewCFURLUPP(url: CFURLRef; targetString: CFStringRef; addToHistory: BOOLEAN; refCon: UNIV Ptr; userRoutine: HRNewCFURLUPP): OSStatus;
{
 *  InvokeHRURLToFSSpecUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeHRURLToFSSpecUPP(rootURL: ConstCStringPtr; linkURL: ConstCStringPtr; VAR fsspec: FSSpec; urlSourceType: URLSourceType; refCon: UNIV Ptr; userRoutine: HRURLToFSSpecUPP): OSStatus; { old name was CallHRURLToFSSpecProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeHRURLToFSRefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeHRURLToFSRefUPP(rootString: CFStringRef; linkString: CFStringRef; VAR fref: FSRef; urlSourceType: URLSourceType; refCon: UNIV Ptr; userRoutine: HRURLToFSRefUPP): OSStatus;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := HTMLRenderingIncludes}

{$ENDC} {__HTMLRENDERING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
