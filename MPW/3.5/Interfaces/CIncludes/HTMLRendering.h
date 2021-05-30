/*
     File:       HTMLRendering.h
 
     Contains:   HTML Rendering Library Interfaces.
 
     Version:    Technology: 1.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __HTMLRENDERING__
#define __HTMLRENDERING__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif

#ifndef __CODEFRAGMENTS__
#include <CodeFragments.h>
#endif

#ifndef __CONTROLS__
#include <Controls.h>
#endif

#ifndef __CFDATA__
#include <CFData.h>
#endif

#ifndef __CFSTRING__
#include <CFString.h>
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

typedef struct OpaqueHRReference*       HRReference;
/*
 *  HRGetHTMLRenderingLibVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRGetHTMLRenderingLibVersion(NumVersion * returnVers);


#if TARGET_RT_MAC_CFM
#ifdef __cplusplus
    inline pascal Boolean HRHTMLRenderingLibAvailable() { return ((HRGetHTMLRenderingLibVersion != (void*)kUnresolvedCFragSymbolAddress) ); }
#else
    #define HRHTMLRenderingLibAvailable()   ((HRGetHTMLRenderingLibVersion != (void*)kUnresolvedCFragSymbolAddress) )
#endif
#elif TARGET_RT_MAC_MACHO
#ifdef __cplusplus
    inline pascal Boolean HRHTMLRenderingLibAvailable() { return true; }
#else
    #define HRHTMLRenderingLibAvailable()   (true)
#endif
#endif  /*  */

enum {
  kHRRendererHTML32Type         = FOUR_CHAR_CODE('ht32') /* HTML 3.2 */
};


/*
 *  HRNewReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRNewReference(
  HRReference *  hrRef,
  OSType         rendererType,
  GrafPtr        grafPtr);


/*
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
 */
EXTERN_API( OSStatus )
HRNewReferenceInWindow(
  HRReference *  hrRef,
  OSType         rendererType,
  WindowRef      inWindowRef);


/*
 *  HRDisposeReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRDisposeReference(HRReference hrRef);



/*
 *  HRFreeMemory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( SInt32 )
HRFreeMemory(Size inBytesNeeded);



/* System level notifications */
/*
 *  HRScreenConfigurationChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
HRScreenConfigurationChanged(void);


/*
 *  HRIsHREvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
HRIsHREvent(const EventRecord * eventRecord);



/* Drawing */
/*
 *  HRSetGrafPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRSetGrafPtr(
  HRReference   hrRef,
  GrafPtr       grafPtr);


/*
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
 */
EXTERN_API( OSStatus )
HRSetWindowRef(
  HRReference   hrRef,
  WindowRef     windowRef);


/*
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
 */
EXTERN_API( OSStatus )
HRSetEmbeddingControl(
  HRReference   hrRef,
  ControlRef    controlRef);


/*
 *  HRActivate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRActivate(HRReference hrRef);


/*
 *  HRDeactivate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRDeactivate(HRReference hrRef);


/*
 *  HRDraw()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRDraw(
  HRReference   hrRef,
  RgnHandle     updateRgnH);


/*
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
 */
EXTERN_API( OSStatus )
HRDrawInPort(
  HRReference   hrRef,
  RgnHandle     updateRgnH,
  CGrafPtr      grafPtr);


/*
 *  HRSetRenderingRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRSetRenderingRect(
  HRReference   hrRef,
  const Rect *  renderingRect);


/*
 *  HRGetRenderedImageSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRGetRenderedImageSize(
  HRReference   hrRef,
  Point *       renderingSize);


/*
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
 */
EXTERN_API( OSStatus )
HRGetRenderedImageSize32(
  HRReference   hrRef,
  UInt32 *      height,
  UInt32 *      width);


/*
 *  HRScrollToLocation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRScrollToLocation(
  HRReference   hrRef,
  Point *       location);


/*
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
 */
EXTERN_API( OSStatus )
HRScrollToImageLocation32(
  HRReference   hrRef,
  SInt32        h,
  SInt32        v);


/*
 *  HRForceQuickdraw()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRForceQuickdraw(
  HRReference   hrRef,
  Boolean       forceQuickdraw);


typedef SInt16 HRScrollbarState;
enum {
  eHRScrollbarOn                = 0,
  eHRScrollbarOff               = 1,
  eHRScrollbarAuto              = 2
};

/*
 *  HRSetScrollbarState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRSetScrollbarState(
  HRReference        hrRef,
  HRScrollbarState   hScrollbarState,
  HRScrollbarState   vScrollbarState);


/*
 *  HRSetDrawBorder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRSetDrawBorder(
  HRReference   hrRef,
  Boolean       drawBorder);


/*
 *  HRSetGrowboxCutout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRSetGrowboxCutout(
  HRReference   hrRef,
  Boolean       allowCutout);


/* Navigation */
/*
 *  HRGoToFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRGoToFile(
  HRReference     hrRef,
  const FSSpec *  fsspec,
  Boolean         addToHistory,
  Boolean         forceRefresh);


/*
 *  HRGoToURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRGoToURL(
  HRReference   hrRef,
  const char *  url,
  Boolean       addToHistory,
  Boolean       forceRefresh);


/*
 *  HRGoToAnchor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRGoToAnchor(
  HRReference   hrRef,
  const char *  anchorName);


/*
 *  HRGoToPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRGoToPtr(
  HRReference   hrRef,
  char *        buffer,
  UInt32        bufferSize,
  Boolean       addToHistory,
  Boolean       forceRefresh);


/*
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
 */
EXTERN_API( OSStatus )
HRGoToFSRef(
  HRReference    hrRef,
  const FSRef *  fref,
  Boolean        addToHistory,
  Boolean        forceRefresh);


/*
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
 */
EXTERN_API( OSStatus )
HRGoToCFURL(
  HRReference   hrRef,
  CFURLRef      url,
  Boolean       addToHistory,
  Boolean       forceRefresh);


/*
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
 */
EXTERN_API( OSStatus )
HRGoToAnchorCFString(
  HRReference   hrRef,
  CFStringRef   anchorName);


/*
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
 */
EXTERN_API( OSStatus )
HRGoToData(
  HRReference   hrRef,
  CFDataRef     data,
  Boolean       addToHistory,
  Boolean       forceRefresh);


/* Accessors */
/* either file url or url of <base> tag */
/*
 *  HRGetRootURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRGetRootURL(
  HRReference   hrRef,
  Handle        rootURLH);


/* url of <base> tag */
/*
 *  HRGetBaseURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRGetBaseURL(
  HRReference   hrRef,
  Handle        baseURLH);


/* file url */
/*
 *  HRGetHTMLURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRGetHTMLURL(
  HRReference   hrRef,
  Handle        HTMLURLH);


/*
 *  HRGetTitle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRGetTitle(
  HRReference   hrRef,
  StringPtr     title);


/*
 *  HRGetHTMLFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRGetHTMLFile(
  HRReference   hrRef,
  FSSpec *      fsspec);



/*
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
 */
EXTERN_API( OSStatus )
HRGetRootURLAsCFString(
  HRReference    hrRef,
  CFStringRef *  rootString);


/*
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
 */
EXTERN_API( OSStatus )
HRGetBaseURLAsCFString(
  HRReference    hrRef,
  CFStringRef *  baseString);


/*
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
 */
EXTERN_API( OSStatus )
HRGetHTMLURLAsCFURL(
  HRReference   hrRef,
  CFURLRef *    theURL);


/*
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
 */
EXTERN_API( OSStatus )
HRGetTitleAsCFString(
  HRReference    hrRef,
  CFStringRef *  title);


/*
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
 */
EXTERN_API( OSStatus )
HRGetHTMLFileAsFSRef(
  HRReference   hrRef,
  FSRef *       fref);


/* Utilities */
/*
 *  HRUtilCreateFullURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRUtilCreateFullURL(
  const char *  rootURL,
  const char *  linkURL,
  Handle        fullURLH);


/*
 *  HRUtilGetFSSpecFromURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRUtilGetFSSpecFromURL(
  const char *  rootURL,
  const char *  linkURL,
  FSSpec *      destSpec);


/* urlHandle should be valid on input */
/*
 *  HRUtilGetURLFromFSSpec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HRUtilGetURLFromFSSpec(
  const FSSpec *  fsspec,
  Handle          urlHandle);



/*
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
 */
EXTERN_API( OSStatus )
HRUtilCreateFullCFURL(
  CFStringRef   rootString,
  CFStringRef   linkString,
  CFURLRef *    url);


/*
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
 */
EXTERN_API( OSStatus )
HRUtilGetFSRefFromURL(
  CFStringRef   rootString,
  CFStringRef   linkString,
  FSRef *       destRef);


/*
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
 */
EXTERN_API( OSStatus )
HRUtilGetURLFromFSRef(
  const FSRef *  fileRef,
  CFURLRef *     url);


/*
    Visited links

    If you register a function here, it will be called to determine
    whether or not the given URL has been visited. It should return
    true if the URL has been visited.
    
    In addition to the URLs that the application may add to the list
    of visited links, it should also add URLs that the user clicks
    on. These URLs can be caught by the "add URL to history" callback
    below.
 */
typedef CALLBACK_API( Boolean , HRWasURLVisitedProcPtr )(const char *url, void *refCon);
typedef STACK_UPP_TYPE(HRWasURLVisitedProcPtr)                  HRWasURLVisitedUPP;
/*
 *  HRRegisterWasURLVisitedUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
HRRegisterWasURLVisitedUPP(
  HRWasURLVisitedUPP   inWasURLVisitedUPP,
  HRReference          hrRef,
  void *               inRefCon);


/*
 *  HRUnregisterWasURLVisitedUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
HRUnregisterWasURLVisitedUPP(HRReference hrRef);


/*
    Use these API from  a Carbon App instead of using HRRegisterWasURLVisitedUPP, HRUnregisterWasURLVisitedUPP. 
    These APIs are same in behavior with their old counter parts. The only difference is that they take 
    CFURLRef as parameters.
        
*/
typedef CALLBACK_API( Boolean , HRWasCFURLVisitedProcPtr )(CFURLRef url, void *refCon);
typedef TVECTOR_UPP_TYPE(HRWasCFURLVisitedProcPtr)              HRWasCFURLVisitedUPP;
/*
 *  HRRegisterWasCFURLVisitedUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
HRRegisterWasCFURLVisitedUPP(
  HRWasCFURLVisitedUPP   inWasCFURLVisitedUPP,
  HRReference            hrRef,
  void *                 inRefCon);


/*
 *  HRUnregisterWasCFURLVisitedUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
HRUnregisterWasCFURLVisitedUPP(HRReference hrRef);



/*
    New URL

    If you register a function here, it will be called every time
    the renderer is going to display a new URL. A few examples of how
    you might use this include...
    
        (a) maintaining a history of URLs
        (b) maintainging a list of visited links
        (c) setting a window title based on the new URL
*/
typedef CALLBACK_API( OSStatus , HRNewURLProcPtr )(const char *url, const char *targetFrame, Boolean addToHistory, void *refCon);
typedef STACK_UPP_TYPE(HRNewURLProcPtr)                         HRNewURLUPP;
/*
 *  HRRegisterNewURLUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
HRRegisterNewURLUPP(
  HRNewURLUPP   inNewURLUPP,
  HRReference   hrRef,
  void *        inRefCon);


/*
 *  HRUnregisterNewURLUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
HRUnregisterNewURLUPP(HRReference hrRef);



/* 
    Use these API from  a Carbon App instead of using HRRegisterNewURLUPP, HRUnregisterNewURLUPP. 
    These APIs are same in behavior with their old counter parts. The only difference is that they take 
    CFURLRef as parameters.
*/
typedef CALLBACK_API( OSStatus , HRNewCFURLProcPtr )(CFURLRef url, CFStringRef targetString, Boolean addToHistory, void *refCon);
typedef TVECTOR_UPP_TYPE(HRNewCFURLProcPtr)                     HRNewCFURLUPP;
/*
 *  HRRegisterNewCFURLUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
HRRegisterNewCFURLUPP(
  HRNewCFURLUPP   inURLUPP,
  HRReference     hrRef,
  void *          inRefCon);


/*
 *  HRUnregisterNewCFURLUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
HRUnregisterNewCFURLUPP(HRReference hrRef);





/*
    URL to FSSpec function

    If you register a function here, it will be called every time
    the renderer is going to locate a file. The function will be
    passed an enum indicating the type of file being asked for.
 */
typedef UInt16 URLSourceType;
enum {
  kHRLookingForHTMLSource       = 1,
  kHRLookingForImage            = 2,
  kHRLookingForEmbedded         = 3,
  kHRLookingForImageMap         = 4,
  kHRLookingForFrame            = 5
};

typedef CALLBACK_API( OSStatus , HRURLToFSSpecProcPtr )(const char *rootURL, const char *linkURL, FSSpec *fsspec, URLSourceType urlSourceType, void *refCon);
typedef STACK_UPP_TYPE(HRURLToFSSpecProcPtr)                    HRURLToFSSpecUPP;
/*
 *  HRRegisterURLToFSSpecUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
HRRegisterURLToFSSpecUPP(
  HRURLToFSSpecUPP   inURLToFSSpecUPP,
  HRReference        hrRef,
  void *             inRefCon);


/*
 *  HRUnregisterURLToFSSpecUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HTMLRenderingLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
HRUnregisterURLToFSSpecUPP(HRReference hrRef);



/* 
    Use these API from  a Carbon App instead of using HRRegisterURLToFSSpecUPP, HRUnregisterURLToFSSpecUPP. 
    These APIs are same in behavior with their old counter parts. The only difference is that they take 
    FSRef as parameters.
*/
typedef CALLBACK_API( OSStatus , HRURLToFSRefProcPtr )(CFStringRef rootString, CFStringRef linkString, FSRef *fref, URLSourceType urlSourceType, void *refCon);
typedef TVECTOR_UPP_TYPE(HRURLToFSRefProcPtr)                   HRURLToFSRefUPP;
/*
 *  HRRegisterURLToFSRefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
HRRegisterURLToFSRefUPP(
  HRURLToFSRefUPP   inURLToFSRefUPP,
  HRReference       hrRef,
  void *            inRefCon);


/*
 *  HRUnregisterURLToFSRefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
HRUnregisterURLToFSRefUPP(HRReference hrRef);


/*
 *  NewHRWasURLVisitedUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( HRWasURLVisitedUPP )
NewHRWasURLVisitedUPP(HRWasURLVisitedProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppHRWasURLVisitedProcInfo = 0x000003D0 };  /* pascal 1_byte Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline HRWasURLVisitedUPP NewHRWasURLVisitedUPP(HRWasURLVisitedProcPtr userRoutine) { return (HRWasURLVisitedUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppHRWasURLVisitedProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewHRWasURLVisitedUPP(userRoutine) (HRWasURLVisitedUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppHRWasURLVisitedProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewHRWasCFURLVisitedUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( HRWasCFURLVisitedUPP )
NewHRWasCFURLVisitedUPP(HRWasCFURLVisitedProcPtr userRoutine);

/*
 *  NewHRNewURLUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( HRNewURLUPP )
NewHRNewURLUPP(HRNewURLProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppHRNewURLProcInfo = 0x000037F0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes, 1_byte, 4_bytes) */
  #ifdef __cplusplus
    inline HRNewURLUPP NewHRNewURLUPP(HRNewURLProcPtr userRoutine) { return (HRNewURLUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppHRNewURLProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewHRNewURLUPP(userRoutine) (HRNewURLUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppHRNewURLProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewHRNewCFURLUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( HRNewCFURLUPP )
NewHRNewCFURLUPP(HRNewCFURLProcPtr userRoutine);

/*
 *  NewHRURLToFSSpecUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( HRURLToFSSpecUPP )
NewHRURLToFSSpecUPP(HRURLToFSSpecProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppHRURLToFSSpecProcInfo = 0x0000EFF0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes, 4_bytes, 2_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline HRURLToFSSpecUPP NewHRURLToFSSpecUPP(HRURLToFSSpecProcPtr userRoutine) { return (HRURLToFSSpecUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppHRURLToFSSpecProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewHRURLToFSSpecUPP(userRoutine) (HRURLToFSSpecUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppHRURLToFSSpecProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewHRURLToFSRefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( HRURLToFSRefUPP )
NewHRURLToFSRefUPP(HRURLToFSRefProcPtr userRoutine);

/*
 *  DisposeHRWasURLVisitedUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposeHRWasURLVisitedUPP(HRWasURLVisitedUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeHRWasURLVisitedUPP(HRWasURLVisitedUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeHRWasURLVisitedUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeHRWasCFURLVisitedUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposeHRWasCFURLVisitedUPP(HRWasCFURLVisitedUPP userUPP);

/*
 *  DisposeHRNewURLUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposeHRNewURLUPP(HRNewURLUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeHRNewURLUPP(HRNewURLUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeHRNewURLUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeHRNewCFURLUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposeHRNewCFURLUPP(HRNewCFURLUPP userUPP);

/*
 *  DisposeHRURLToFSSpecUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposeHRURLToFSSpecUPP(HRURLToFSSpecUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeHRURLToFSSpecUPP(HRURLToFSSpecUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeHRURLToFSSpecUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeHRURLToFSRefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposeHRURLToFSRefUPP(HRURLToFSRefUPP userUPP);

/*
 *  InvokeHRWasURLVisitedUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
InvokeHRWasURLVisitedUPP(
  const char *        url,
  void *              refCon,
  HRWasURLVisitedUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline Boolean InvokeHRWasURLVisitedUPP(const char * url, void * refCon, HRWasURLVisitedUPP userUPP) { return (Boolean)CALL_TWO_PARAMETER_UPP(userUPP, uppHRWasURLVisitedProcInfo, url, refCon); }
  #else
    #define InvokeHRWasURLVisitedUPP(url, refCon, userUPP) (Boolean)CALL_TWO_PARAMETER_UPP((userUPP), uppHRWasURLVisitedProcInfo, (url), (refCon))
  #endif
#endif

/*
 *  InvokeHRWasCFURLVisitedUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
InvokeHRWasCFURLVisitedUPP(
  CFURLRef              url,
  void *                refCon,
  HRWasCFURLVisitedUPP  userUPP);

/*
 *  InvokeHRNewURLUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
InvokeHRNewURLUPP(
  const char *  url,
  const char *  targetFrame,
  Boolean       addToHistory,
  void *        refCon,
  HRNewURLUPP   userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline OSStatus InvokeHRNewURLUPP(const char * url, const char * targetFrame, Boolean addToHistory, void * refCon, HRNewURLUPP userUPP) { return (OSStatus)CALL_FOUR_PARAMETER_UPP(userUPP, uppHRNewURLProcInfo, url, targetFrame, addToHistory, refCon); }
  #else
    #define InvokeHRNewURLUPP(url, targetFrame, addToHistory, refCon, userUPP) (OSStatus)CALL_FOUR_PARAMETER_UPP((userUPP), uppHRNewURLProcInfo, (url), (targetFrame), (addToHistory), (refCon))
  #endif
#endif

/*
 *  InvokeHRNewCFURLUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
InvokeHRNewCFURLUPP(
  CFURLRef       url,
  CFStringRef    targetString,
  Boolean        addToHistory,
  void *         refCon,
  HRNewCFURLUPP  userUPP);

/*
 *  InvokeHRURLToFSSpecUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
InvokeHRURLToFSSpecUPP(
  const char *      rootURL,
  const char *      linkURL,
  FSSpec *          fsspec,
  URLSourceType     urlSourceType,
  void *            refCon,
  HRURLToFSSpecUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline OSStatus InvokeHRURLToFSSpecUPP(const char * rootURL, const char * linkURL, FSSpec * fsspec, URLSourceType urlSourceType, void * refCon, HRURLToFSSpecUPP userUPP) { return (OSStatus)CALL_FIVE_PARAMETER_UPP(userUPP, uppHRURLToFSSpecProcInfo, rootURL, linkURL, fsspec, urlSourceType, refCon); }
  #else
    #define InvokeHRURLToFSSpecUPP(rootURL, linkURL, fsspec, urlSourceType, refCon, userUPP) (OSStatus)CALL_FIVE_PARAMETER_UPP((userUPP), uppHRURLToFSSpecProcInfo, (rootURL), (linkURL), (fsspec), (urlSourceType), (refCon))
  #endif
#endif

/*
 *  InvokeHRURLToFSRefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
InvokeHRURLToFSRefUPP(
  CFStringRef      rootString,
  CFStringRef      linkString,
  FSRef *          fref,
  URLSourceType    urlSourceType,
  void *           refCon,
  HRURLToFSRefUPP  userUPP);

#if CALL_NOT_IN_CARBON || OLDROUTINENAMES
    /* support for pre-Carbon UPP routines: New...Proc and Call...Proc */
    #define NewHRWasURLVisitedProc(userRoutine)                 NewHRWasURLVisitedUPP(userRoutine)
    #define NewHRNewURLProc(userRoutine)                        NewHRNewURLUPP(userRoutine)
    #define NewHRURLToFSSpecProc(userRoutine)                   NewHRURLToFSSpecUPP(userRoutine)
    #define CallHRWasURLVisitedProc(userRoutine, url, refCon)   InvokeHRWasURLVisitedUPP(url, refCon, userRoutine)
    #define CallHRNewURLProc(userRoutine, url, targetFrame, addToHistory, refCon) InvokeHRNewURLUPP(url, targetFrame, addToHistory, refCon, userRoutine)
    #define CallHRURLToFSSpecProc(userRoutine, rootURL, linkURL, fsspec, urlSourceType, refCon) InvokeHRURLToFSSpecUPP(rootURL, linkURL, fsspec, urlSourceType, refCon, userRoutine)
#endif /* CALL_NOT_IN_CARBON */


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

#endif /* __HTMLRENDERING__ */

