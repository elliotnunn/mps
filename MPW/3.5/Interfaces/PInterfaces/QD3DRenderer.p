{
     File:       QD3DRenderer.p
 
     Contains:   Q3Renderer types and routines
 
     Version:    Technology: Quickdraw 3D 1.6
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1995-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QD3DRenderer;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DRENDERER__}
{$SETC __QD3DRENDERER__ := 1}

{$I+}
{$SETC QD3DRendererIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}
{$IFC UNDEFINED __QD3DSET__}
{$I QD3DSet.p}
{$ENDC}
{$IFC UNDEFINED __QD3DVIEW__}
{$I QD3DView.p}
{$ENDC}
{$IFC UNDEFINED __RAVE__}
{$I RAVE.p}
{$ENDC}

{$IFC TARGET_OS_MAC }
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$ENDC}  {TARGET_OS_MAC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{*****************************************************************************
 **                                                                          **
 **                         User Interface Things                            **
 **                                                                          **
 ****************************************************************************}
{$IFC TARGET_OS_MAC }
{
 *  A callback to an application's event handling code. This is needed to    
 *  support movable modal dialogs. The dialog's event filter calls this      
 *  callback with events it does not handle.                                 
 *  If an application handles the event it should return kQ3True.            
 *  If the application does not handle the event it must return kQ3False and 
 *  the dialog's event filter will pass the event to the system unhandled.   
 }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3MacOSDialogEventHandler = FUNCTION({CONST}VAR event: EventRecord): TQ3Boolean; C;
{$ELSEC}
	TQ3MacOSDialogEventHandler = ProcPtr;
{$ENDC}

	TQ3DialogAnchorPtr = ^TQ3DialogAnchor;
	TQ3DialogAnchor = RECORD
		clientEventHandler:		TQ3MacOSDialogEventHandler;
	END;

{$ENDC}  {TARGET_OS_MAC}

{$IFC TARGET_OS_WIN32 }

TYPE
	TQ3DialogAnchor = RECORD
		ownerWindow:			HWND;
	END;

{$ENDC}  {TARGET_OS_WIN32}

{$IFC TARGET_OS_UNIX }

TYPE
	TQ3DialogAnchorPtr = ^TQ3DialogAnchor;
	TQ3DialogAnchor = RECORD
		notUsed:				Ptr;									{  place holder  }
	END;

{$ENDC}  {TARGET_OS_UNIX}

{*****************************************************************************
 **                                                                          **
 **                         Renderer Functions                               **
 **                                                                          **
 ****************************************************************************}
{$IFC CALL_NOT_IN_CARBON }
{
 *  Q3Renderer_NewFromType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Renderer_NewFromType(rendererObjectType: TQ3ObjectType): TQ3RendererObject; C;

{
 *  Q3Renderer_GetType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Renderer_GetType(renderer: TQ3RendererObject): TQ3ObjectType; C;


{ Q3Renderer_Flush has been replaced by Q3View_Flush }
{ Q3Renderer_Sync has been replaced by Q3View_Sync }
{$ENDC}  {CALL_NOT_IN_CARBON}


{
 *  Q3Renderer_IsInteractive
 *      Determine if this renderer is intended to be used interactively.
 }
{$IFC CALL_NOT_IN_CARBON }
{
 *  Q3Renderer_IsInteractive()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Renderer_IsInteractive(renderer: TQ3RendererObject): TQ3Boolean; C;


{
 *  Q3Renderer_HasModalConfigure
 *      Determine if this renderer has a modal settings dialog.
 *
 *  Q3Renderer_ModalConfigure
 *      Have the renderer pop up a modal dialog box to configure its settings.
 *  dialogAnchor - is platform specific data passed by the client to support
 *      movable modal dialogs. 
 *    MacOS: this is a callback to the calling application's event handler.
 *      The renderer calls this function with events not handled by the 
 *      settings dialog. This is necessary in order to support movable modal 
 *      dialogs. An application's event handler must return kQ3True if it 
 *      handles the event passed to the callback or kQ3False if not. 
 *      An application which doesn't want to support a movable modal configure
 *      dialog should pass NULL for the clientEventHandler of TQ3DialogAnchor.
 *    Win32: this is the HWND of the owning window (typically an application's
 *      main window).
 *  canceled - returns a boolean inditacating that the user canceled the 
 *  dialog.
 *      
 }
{
 *  Q3Renderer_HasModalConfigure()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Renderer_HasModalConfigure(renderer: TQ3RendererObject): TQ3Boolean; C;

{
 *  Q3Renderer_ModalConfigure()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Renderer_ModalConfigure(renderer: TQ3RendererObject; dialogAnchor: TQ3DialogAnchor; VAR canceled: TQ3Boolean): TQ3Status; C;

{
 *  Q3RendererClass_GetNickNameString
 *      Allows an application to get a renderers name string, the 
 *      renderer is responsible for storing this in a localizable format
 *      for example as a resource.  This string can then be used to provide
 *      a selection mechanism for an application (for example in a menu).
 *
 *      If this call returns nil in the supplied string, then the App may 
 *      choose to use the class name for the renderer.  You should always 
 *      try to get the name string before using the class name, since the
 *      class name is not localizable.
 }
{
 *  Q3RendererClass_GetNickNameString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RendererClass_GetNickNameString(rendererClassType: TQ3ObjectType; VAR rendererClassString: TQ3ObjectClassNameString): TQ3Status; C;


{
 *  Q3Renderer_GetConfigurationData
 *      Allows an application to collect private renderer configuration data
 *      which it will then save. For example in a preference file or in a 
 *      style template. An application should tag this data with the 
 *      Renderer's object  name.
 *  
 *      if dataBuffer is NULL actualDataSize returns the required size in 
 *      bytes of a data buffer large enough to store private data. 
 *
 *      bufferSize is the actual size of the memory block pointed to by 
 *      dataBuffer
 *
 *      actualDataSize - on return the actual number of bytes written to the 
 *      buffer or if dataBuffer is NULL the required size of dataBuffer
 * 
 }
{
 *  Q3Renderer_GetConfigurationData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Renderer_GetConfigurationData(renderer: TQ3RendererObject; VAR dataBuffer: UInt8; bufferSize: UInt32; VAR actualDataSize: UInt32): TQ3Status; C;

{
 *  Q3Renderer_SetConfigurationData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Renderer_SetConfigurationData(renderer: TQ3RendererObject; VAR dataBuffer: UInt8; bufferSize: UInt32): TQ3Status; C;



{*****************************************************************************
 **                                                                          **
 **                     Interactive Renderer Specific Functions              **
 **                                                                          **
 ****************************************************************************}
{ CSG IDs attribute }
{ Object IDs, to be applied as attributes on geometries }
{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kQ3AttributeTypeConstructiveSolidGeometryID = 'csgi';

	kQ3SolidGeometryObjNone		= -1;
	kQ3SolidGeometryObjA		= 0;
	kQ3SolidGeometryObjB		= 1;
	kQ3SolidGeometryObjC		= 2;
	kQ3SolidGeometryObjD		= 3;
	kQ3SolidGeometryObjE		= 4;

	{	 Possible CSG equations 	}

TYPE
	TQ3CSGEquation 				= SInt32;
CONST
	kQ3CSGEquationAandB			= $88888888;
	kQ3CSGEquationAandnotB		= $22222222;
	kQ3CSGEquationAanBonCad		= $2F222F22;
	kQ3CSGEquationnotAandB		= $44444444;
	kQ3CSGEquationnAaBorCanB	= $74747474;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3InteractiveRenderer_SetCSGEquation()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3InteractiveRenderer_SetCSGEquation(renderer: TQ3RendererObject; equation: TQ3CSGEquation): TQ3Status; C;

{
 *  Q3InteractiveRenderer_GetCSGEquation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3InteractiveRenderer_GetCSGEquation(renderer: TQ3RendererObject; VAR equation: TQ3CSGEquation): TQ3Status; C;

{
 *  Q3InteractiveRenderer_SetPreferences()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3InteractiveRenderer_SetPreferences(renderer: TQ3RendererObject; vendorID: LONGINT; engineID: LONGINT): TQ3Status; C;

{
 *  Q3InteractiveRenderer_GetPreferences()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3InteractiveRenderer_GetPreferences(renderer: TQ3RendererObject; VAR vendorID: LONGINT; VAR engineID: LONGINT): TQ3Status; C;

{
 *  Q3InteractiveRenderer_SetDoubleBufferBypass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3InteractiveRenderer_SetDoubleBufferBypass(renderer: TQ3RendererObject; bypass: TQ3Boolean): TQ3Status; C;

{
 *  Q3InteractiveRenderer_GetDoubleBufferBypass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3InteractiveRenderer_GetDoubleBufferBypass(renderer: TQ3RendererObject; VAR bypass: TQ3Boolean): TQ3Status; C;

{
 *  Q3InteractiveRenderer_SetRAVEContextHints()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3InteractiveRenderer_SetRAVEContextHints(renderer: TQ3RendererObject; RAVEContextHints: UInt32): TQ3Status; C;

{
 *  Q3InteractiveRenderer_GetRAVEContextHints()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3InteractiveRenderer_GetRAVEContextHints(renderer: TQ3RendererObject; VAR RAVEContextHints: UInt32): TQ3Status; C;

{
 *  Q3InteractiveRenderer_SetRAVETextureFilter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3InteractiveRenderer_SetRAVETextureFilter(renderer: TQ3RendererObject; RAVEtextureFilterValue: UInt32): TQ3Status; C;

{
 *  Q3InteractiveRenderer_GetRAVETextureFilter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3InteractiveRenderer_GetRAVETextureFilter(renderer: TQ3RendererObject; VAR RAVEtextureFilterValue: UInt32): TQ3Status; C;

{
 *  Q3InteractiveRenderer_CountRAVEDrawContexts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3InteractiveRenderer_CountRAVEDrawContexts(renderer: TQ3RendererObject; VAR numRAVEContexts: UInt32): TQ3Status; C;

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3RaveDestroyCallback = PROCEDURE(renderer: TQ3RendererObject); C;
{$ELSEC}
	TQ3RaveDestroyCallback = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3InteractiveRenderer_GetRAVEDrawContexts()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3InteractiveRenderer_GetRAVEDrawContexts(renderer: TQ3RendererObject; VAR raveDrawContextList: UNIV Ptr; VAR raveDrawingEnginesList: UNIV Ptr; VAR numRAVEContexts: UInt32; raveDestroyCallback: TQ3RaveDestroyCallback): TQ3Status; C;




{*****************************************************************************
 **                                                                          **
 **                         Renderer View Tools                              **
 **                                                                          **
 **                 You may only call these methods from a plug-in           **
 **                                                                          **
 ****************************************************************************}
{
 *  Call by a renderer to call the user "idle" method, with progress 
 *  information.
 *  
 *  Pass in (view, 0, n) on first call
 *  Pass in (view, 1..n-1, n) during rendering
 *  Pass in (view, n, n) upon completion
 *  
 *  Note: The user must have supplied an idleProgress method with 
 *  Q3XView_SetIdleProgressMethod. Otherwise, the generic idle method is
 *  called with no progress data. e.g. the Q3View_SetIdleMethod method
 *  is called instead. (current and final are ignored, essentially.)
 *
 *  Returns kQ3Failure if rendering is cancelled.
 }
{
 *  Q3XView_IdleProgress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XView_IdleProgress(view: TQ3ViewObject; current: UInt32; completed: UInt32): TQ3Status; C;

{
 *  Called by an asynchronous renderer when it completes a frame.
 }
{
 *  Q3XView_EndFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XView_EndFrame(view: TQ3ViewObject): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         Renderer AttributeSet Tools                      **
 **                                                                          **
 **                 You may only call these methods from a plug-in           **
 **                                                                          **
 ****************************************************************************}
{
 *  Faster access to geometry attribute sets.
 *  
 *  Returns pointer to INTERNAL data structure for elements and attributes
 *  in an attributeSet, or NULL if no attribute exists.
 *  
 *  For attributes of type kQ3AttributeType..., the internal data structure
 *  is identical to the data structure used in Q3AttributeSet_Add.
 }
{
 *  Q3XAttributeSet_GetPointer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XAttributeSet_GetPointer(attributeSet: TQ3AttributeSet; attributeType: TQ3AttributeType): Ptr; C;


{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kQ3XAttributeMaskNone		= 0;
	kQ3XAttributeMaskSurfaceUV	= $01;
	kQ3XAttributeMaskShadingUV	= $02;
	kQ3XAttributeMaskNormal		= $04;
	kQ3XAttributeMaskAmbientCoefficient = $08;
	kQ3XAttributeMaskDiffuseColor = $10;
	kQ3XAttributeMaskSpecularColor = $20;
	kQ3XAttributeMaskSpecularControl = $40;
	kQ3XAttributeMaskTransparencyColor = $80;
	kQ3XAttributeMaskSurfaceTangent = $0100;
	kQ3XAttributeMaskHighlightState = $0200;
	kQ3XAttributeMaskSurfaceShader = $0400;
	kQ3XAttributeMaskCustomAttribute = $80000000;
	kQ3XAttributeMaskAll		= $800007FF;
	kQ3XAttributeMaskInherited	= $03FF;
	kQ3XAttributeMaskInterpolated = $01FF;


TYPE
	TQ3XAttributeMask					= UInt32;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3XAttributeSet_GetMask()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3XAttributeSet_GetMask(attributeSet: TQ3AttributeSet): TQ3XAttributeMask; C;


{*****************************************************************************
 **                                                                          **
 **                         Renderer Draw Context Tools                      **
 **                                                                          **
 ****************************************************************************}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	TQ3XDrawRegion    = ^LONGINT; { an opaque 32-bit type }
	TQ3XDrawRegionPtr = ^TQ3XDrawRegion;  { when a VAR xx:TQ3XDrawRegion parameter can be nil, it is changed to xx: TQ3XDrawRegionPtr }
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3XDrawContext_GetDrawRegion()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3XDrawContext_GetDrawRegion(drawContext: TQ3DrawContextObject; VAR drawRegion: TQ3XDrawRegion): TQ3Status; C;

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	TQ3XDrawContextValidationMasks  = SInt32;
CONST
	kQ3XDrawContextValidationClearFlags = $00000000;
	kQ3XDrawContextValidationDoubleBuffer = $01;
	kQ3XDrawContextValidationShader = $02;
	kQ3XDrawContextValidationClearFunction = $04;
	kQ3XDrawContextValidationActiveBuffer = $08;
	kQ3XDrawContextValidationInternalOffScreen = $10;
	kQ3XDrawContextValidationPane = $20;
	kQ3XDrawContextValidationMask = $40;
	kQ3XDrawContextValidationDevice = $80;
	kQ3XDrawContextValidationWindow = $0100;
	kQ3XDrawContextValidationWindowSize = $0200;
	kQ3XDrawContextValidationWindowClip = $0400;
	kQ3XDrawContextValidationWindowPosition = $0800;
	kQ3XDrawContextValidationPlatformAttributes = $1000;
	kQ3XDrawContextValidationForegroundShader = $2000;
	kQ3XDrawContextValidationBackgroundShader = $4000;
	kQ3XDrawContextValidationColorPalette = $8000;
	kQ3XDrawContextValidationAll = $FFFFFFFF;


TYPE
	TQ3XDrawContextValidation			= UInt32;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3XDrawContext_ClearValidationFlags()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3XDrawContext_ClearValidationFlags(drawContext: TQ3DrawContextObject): TQ3Status; C;

{
 *  Q3XDrawContext_GetValidationFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawContext_GetValidationFlags(drawContext: TQ3DrawContextObject; VAR validationFlags: TQ3XDrawContextValidation): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         Renderer Draw Region Tools                       **
 **                                                                          **
 ****************************************************************************}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	TQ3XDevicePixelType 		= SInt32;
CONST
																{  These do not indicate byte ordering    }
	kQ3XDevicePixelTypeInvalid	= 0;							{  Unknown, un-initialized type     }
	kQ3XDevicePixelTypeRGB32	= 1;							{  Alpha:8 (ignored), R:8, G:8, B:8  }
	kQ3XDevicePixelTypeARGB32	= 2;							{  Alpha:8, R:8, G:8, B:8            }
	kQ3XDevicePixelTypeRGB24	= 3;							{  24 bits/pixel, R:8, G:8, B:8     }
	kQ3XDevicePixelTypeRGB16	= 4;							{  Alpha:1 (ignored), R:5, G:5, B:5  }
	kQ3XDevicePixelTypeARGB16	= 5;							{  Alpha:1, R:5, G:5, B:5            }
	kQ3XDevicePixelTypeRGB16_565 = 6;							{  16 bits/pixel, R:5, G:6, B:5     }
	kQ3XDevicePixelTypeIndexed8	= 7;							{  8-bit color table index           }
	kQ3XDevicePixelTypeIndexed4	= 8;							{  4-bit color table index           }
	kQ3XDevicePixelTypeIndexed2	= 9;							{  2-bit color table index           }
	kQ3XDevicePixelTypeIndexed1	= 10;							{  1-bit color table index           }


TYPE
	TQ3XClipMaskState 			= SInt32;
CONST
	kQ3XClipMaskFullyExposed	= 0;
	kQ3XClipMaskPartiallyExposed = 1;
	kQ3XClipMaskNotExposed		= 2;


TYPE
	TQ3XColorDescriptorPtr = ^TQ3XColorDescriptor;
	TQ3XColorDescriptor = RECORD
		redShift:				UInt32;
		redMask:				UInt32;
		greenShift:				UInt32;
		greenMask:				UInt32;
		blueShift:				UInt32;
		blueMask:				UInt32;
		alphaShift:				UInt32;
		alphaMask:				UInt32;
	END;

	TQ3XDrawRegionDescriptorPtr = ^TQ3XDrawRegionDescriptor;
	TQ3XDrawRegionDescriptor = RECORD
		width:					UInt32;
		height:					UInt32;
		rowBytes:				UInt32;
		pixelSize:				UInt32;
		pixelType:				TQ3XDevicePixelType;
		colorDescriptor:		TQ3XColorDescriptor;
		bitOrder:				TQ3Endian;
		byteOrder:				TQ3Endian;
		clipMask:				TQ3BitmapPtr;
	END;

	TQ3XDrawRegionServicesMasks  = SInt32;
CONST
	kQ3XDrawRegionServicesNoneFlag = 0;
	kQ3XDrawRegionServicesClearFlag = $01;
	kQ3XDrawRegionServicesDontLockDDSurfaceFlag = $02;


TYPE
	TQ3XDrawRegionServices				= UInt32;
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XDrawRegionRendererPrivateDeleteMethod = PROCEDURE(rendererPrivate: UNIV Ptr); C;
{$ELSEC}
	TQ3XDrawRegionRendererPrivateDeleteMethod = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3XDrawRegion_GetDeviceScaleX()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3XDrawRegion_GetDeviceScaleX(drawRegion: TQ3XDrawRegion; VAR deviceScaleX: Single): TQ3Status; C;

{
 *  Q3XDrawRegion_GetDeviceScaleY()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_GetDeviceScaleY(drawRegion: TQ3XDrawRegion; VAR deviceScaleY: Single): TQ3Status; C;


{
 *  Q3XDrawRegion_GetDeviceOffsetX()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_GetDeviceOffsetX(drawRegion: TQ3XDrawRegion; VAR deviceOffsetX: Single): TQ3Status; C;

{
 *  Q3XDrawRegion_GetDeviceOffsetY()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_GetDeviceOffsetY(drawRegion: TQ3XDrawRegion; VAR deviceOffsetX: Single): TQ3Status; C;


{
 *  Q3XDrawRegion_GetWindowScaleX()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_GetWindowScaleX(drawRegion: TQ3XDrawRegion; VAR windowScaleX: Single): TQ3Status; C;

{
 *  Q3XDrawRegion_GetWindowScaleY()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_GetWindowScaleY(drawRegion: TQ3XDrawRegion; VAR windowScaleY: Single): TQ3Status; C;


{
 *  Q3XDrawRegion_GetWindowOffsetX()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_GetWindowOffsetX(drawRegion: TQ3XDrawRegion; VAR windowOffsetX: Single): TQ3Status; C;

{
 *  Q3XDrawRegion_GetWindowOffsetY()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_GetWindowOffsetY(drawRegion: TQ3XDrawRegion; VAR windowOffsetY: Single): TQ3Status; C;

{
 *  Q3XDrawRegion_IsActive()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_IsActive(drawRegion: TQ3XDrawRegion; VAR isActive: TQ3Boolean): TQ3Status; C;


{
 *  Q3XDrawRegion_GetNextRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_GetNextRegion(drawRegion: TQ3XDrawRegion; VAR nextDrawRegion: TQ3XDrawRegion): TQ3Status; C;

{ 
 *  One of the next two functions must be called before using a draw region 
 }
{
 *  Use this Start function if double buffering/image access services from the
 *  Draw Context are not needed, you may still request clear for example
 }
{
 *  Q3XDrawRegion_Start()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_Start(drawRegion: TQ3XDrawRegion; services: TQ3XDrawRegionServices; VAR descriptor: UNIV Ptr): TQ3Status; C;

{
 *  Use this Start function if double buffering or image access services from 
 *  the Draw Context are needed.
 }
{
 *  Q3XDrawRegion_StartAccessToImageBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_StartAccessToImageBuffer(drawRegion: TQ3XDrawRegion; services: TQ3XDrawRegionServices; VAR descriptor: UNIV Ptr; VAR image: UNIV Ptr): TQ3Status; C;

{
 *  This function is used to indicate that access to a DrawRegion is ended.
 }
{
 *  Q3XDrawRegion_End()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_End(drawRegion: TQ3XDrawRegion): TQ3Status; C;

{
 *  Q3XDrawRegion_GetDeviceTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_GetDeviceTransform(drawRegion: TQ3XDrawRegion; VAR deviceTransform: UNIV Ptr): TQ3Status; C;

{
 *  Q3XDrawRegion_GetClipFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_GetClipFlags(drawRegion: TQ3XDrawRegion; VAR clipMaskState: TQ3XClipMaskState): TQ3Status; C;

{
 *  Q3XDrawRegion_GetClipMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_GetClipMask(drawRegion: TQ3XDrawRegion; VAR clipMask: UNIV Ptr): TQ3Status; C;

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC TARGET_OS_MAC }
{$IFC CALL_NOT_IN_CARBON }
{
 *  Q3XDrawRegion_GetClipRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_GetClipRegion(drawRegion: TQ3XDrawRegion; VAR rgnHandle: RgnHandle): TQ3Status; C;

{
 *  Q3XDrawRegion_GetGDHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_GetGDHandle(drawRegion: TQ3XDrawRegion; VAR gdHandle: GDHandle): TQ3Status; C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_MAC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  Q3XDrawRegion_GetRendererPrivate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_GetRendererPrivate(drawRegion: TQ3XDrawRegion; VAR rendererPrivate: UNIV Ptr): TQ3Status; C;

{
 *  Q3XDrawRegion_SetRendererPrivate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_SetRendererPrivate(drawRegion: TQ3XDrawRegion; rendererPrivate: UNIV Ptr; deleteMethod: TQ3XDrawRegionRendererPrivateDeleteMethod): TQ3Status; C;

{
 *  Q3XDrawRegion_SetUseDefaultRendererFlag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_SetUseDefaultRendererFlag(drawRegion: TQ3XDrawRegion; flag: TQ3Boolean): TQ3Status; C;

{
 *  Q3XDrawRegion_GetUseDefaultRendererFlag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XDrawRegion_GetUseDefaultRendererFlag(drawRegion: TQ3XDrawRegion; VAR useDefaultRenderingFlag: TQ3Boolean): TQ3Status; C;



{*****************************************************************************
 **                                                                          **
 **                         Renderer Class Methods                           **
 **                                                                          **
 ****************************************************************************}
{
 *  Methods from Object
 *      kQ3XMethodTypeObjectClassRegister
 *      kQ3XMethodTypeObjectClassUnregister
 *      kQ3XMethodTypeObjectNew
 *      kQ3XMethodTypeObjectDelete
 *      kQ3XMethodTypeObjectRead
 *      kQ3XMethodTypeObjectTraverse
 *      kQ3XMethodTypeObjectWrite
 *      
 *  Methods from Shared
 *      kQ3MethodTypeSharedEdited
 *
 *  Renderer Methods
 *  
 *  The renderer methods should be implemented according to the type
 *  of renderer being written.
 *
 *  For the purposes of documentation, there are two basic types of
 *  renderers: 
 *
 *      Interactive
 *          Interactive Renderer
 *          WireFrame Renderer
 *      
 *      Deferred
 *          a ray-tracer
 *          painter's algorithm renderer (cached in a BSP triangle tree)
 *          an artistic renderer (simulates a pencil drawing, etc.)
 *
 *  The main difference is how each renderer handles incoming state and 
 *  geometry.
 *
 *  An interactive renderer immediately transforms, culls, and shades
 *  incoming geometry and performs rasterization. For example, in a 
 *  single-buffered WireFrame renderer, you will see a new triangle
 *  immediately after Q3Triangle_Draw (if it's visible, of course).
 *
 *  A deferred renderer caches the view state and each geometry, 
 *  converting into any internal queue of drawing commands. Rasterization
 *  is not actually performed until all data has been submitted.
 *  
 *  For example, a ray-tracer may not rasterize anything until the
 *  end of the rendering loop, or until an EndFrame call is made.
 }

{*****************************************************************************
 **                                                                          **
 **                     Renderer User Interface Methods                      **
 **                                                                          **
 ****************************************************************************}
{
 *  kQ3XMethodTypeRendererIsInteractive
 *  
 *  There is no actual method with this - the metahandler simply returns
 *  "(TQ3XFunctionPointer)kQ3True" for this "method" if the renderer is 
 *  intended to be used in interactive settings, and   
 *  "(TQ3XFunctionPointer)kQ3False" otherwise. 
 *  
 *  If neither value is specified in the metahandler, the renderer 
 *  is *assumed to be non-interactive*!!!
 *  
 *  OPTIONAL
 }
{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kQ3XMethodTypeRendererIsInteractive = 'isin';


	{	
	 *  TQ3XRendererModalConfigureMethod
	 *  
	 *  This method should pop up a modal dialog to edit the renderer settings 
	 *  found in the renderer private. 
	 *  
	 *  dialogAnchor - is platform specific data passed by the client to support
	 *      movable modal dialogs. 
	 *    MacOS: this is a callback to the calling application's event handler.
	 *      The renderer calls this function with events not handled by the 
	 *      settings dialog. This is necessary in order to support movable modal 
	 *      dialogs. An application's event handler must return kQ3True if it 
	 *      handles the event passed to the callback or kQ3False if not. 
	 *      An application which doesn't want to support a movable modal configure
	 *      dialog should pass NULL for the clientEventHandler of TQ3DialogAnchor.
	 *      A renderer should implement a non-movable style dialog in that case.
	 *    Win32: this is the HWND of the owning window (typically an application's
	 *      main window).  (Win32 application modal dialogs are always movable.)
	 *  canceled - returns a boolean inditacating that the user canceled the 
	 *  dialog.
	 *  
	 *  OPTIONAL
	 	}
	kQ3XMethodTypeRendererModalConfigure = 'rdmc';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererModalConfigureMethod = FUNCTION(renderer: TQ3RendererObject; dialogAnchor: TQ3DialogAnchor; VAR canceled: TQ3Boolean; rendererPrivate: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3XRendererModalConfigureMethod = ProcPtr;
{$ENDC}

	{	
	 *  kQ3XMethodTypeRendererGetNickNameString
	 *  
	 *      Allows an application to collect the name of the renderer for
	 *      display in a user interface item such as a menu.
	 *  
	 *      If dataBuffer is NULL actualDataSize returns the required size in 
	 *      bytes of a data buffer large enough to store the renderer name. 
	 *
	 *      bufferSize is the actual size of the memory block pointed to by 
	 *      dataBuffer
	 *
	 *      actualDataSize - on return the actual number of bytes written to the
	 *      buffer or if dataBuffer is NULL the required size of dataBuffer
	 *
	 *  OPTIONAL
	 	}

CONST
	kQ3XMethodTypeRendererGetNickNameString = 'rdns';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererGetNickNameStringMethod = FUNCTION(VAR dataBuffer: UInt8; bufferSize: UInt32; VAR actualDataSize: UInt32): TQ3Status; C;
{$ELSEC}
	TQ3XRendererGetNickNameStringMethod = ProcPtr;
{$ENDC}

	{	
	 *  kQ3XMethodTypeRendererGetConfigurationData
	 *  
	 *      Allows an application to collect private configuration data from the
	 *      renderer which it will then save. For example in a preference file, 
	 *      a registry key (on Windows) or in a style template. An application 
	 *      should tag this data with the renderer's object name.
	 *  
	 *      If dataBuffer is NULL actualDataSize returns the required size in 
	 *      bytes of a data buffer large enough to store private data. 
	 *
	 *      bufferSize is the actual size of the memory block pointed to by 
	 *      dataBuffer
	 *
	 *      actualDataSize - on return the actual number of bytes written to the
	 *      buffer or if dataBuffer is NULL the required size of dataBuffer
	 *
	 *  OPTIONAL
	 	}

CONST
	kQ3XMethodTypeRendererGetConfigurationData = 'rdgp';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererGetConfigurationDataMethod = FUNCTION(renderer: TQ3RendererObject; VAR dataBuffer: UInt8; bufferSize: UInt32; VAR actualDataSize: UInt32; rendererPrivate: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3XRendererGetConfigurationDataMethod = ProcPtr;
{$ENDC}

	{	
	 *  TQ3XRendererSetConfigurationDataMethod
	 *  
	 *      Allows an application to pass private configuration data which has
	 *      previously  been obtained from a renderer via 
	 *      Q3Renderer_GetConfigurationData. For example in a preference file or 
	 *      in a style template. An application should tag this data with the 
	 *      renderer's object name.
	 *  
	 *      bufferSize is the actual size of the memory block pointed to by 
	 *      dataBuffer
	 *
	 *  OPTIONAL
	 	}

CONST
	kQ3XMethodTypeRendererSetConfigurationData = 'rdsp';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererSetConfigurationDataMethod = FUNCTION(renderer: TQ3RendererObject; VAR dataBuffer: UInt8; bufferSize: UInt32; rendererPrivate: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3XRendererSetConfigurationDataMethod = ProcPtr;
{$ENDC}

	{	*****************************************************************************
	 **                                                                          **
	 **                     Renderer Drawing State Methods                       **
	 **                                                                          **
	 ****************************************************************************	}
	{	
	 *  TQ3RendererStartFrame
	 *  
	 *  The StartFrame method is called first at Q3View_StartRendering
	 *  and should:
	 *      - initialize any renderer state to defaults
	 *      - extract any and all useful data from the drawContext
	 *
	 *  If your renderer passed in kQ3RendererFlagClearBuffer at 
	 *  registration, then it should also:
	 *      - clear the drawContext 
	 *  
	 *      When clearing, your renderer may opt to:
	 *      - NOT clear anything (if you touch every pixel, for example)
	 *      - to clear with your own routine, or
	 *      - to use the draw context default clear method by calling 
	 *      Q3DrawContext_Clear. Q3DrawContext_Clear takes advantage of
	 *      any available hardware in the system for clearing.
	 *  
	 *  This call also signals the start of all default submit commands from
	 *  the view. The renderer will receive updates for the default view
	 *  state via its Update methods before StartPass is called.
	 *  
	 *  REQUIRED
	 	}

CONST
	kQ3XMethodTypeRendererStartFrame = 'rdcl';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererStartFrameMethod = FUNCTION(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; drawContext: TQ3DrawContextObject): TQ3Status; C;
{$ELSEC}
	TQ3XRendererStartFrameMethod = ProcPtr;
{$ENDC}

	{	
	 *  kQ3XMethodTypeRendererStartPass
	 *  TQ3XRendererStartPassMethod
	 *  
	 *  The StartPass method is called during Q3View_StartRendering but after
	 *  the StartFrame command. It should:
	 *      - collect camera and light information
	 *  
	 *  If your renderer supports deferred camera transformation, camera is the
	 *  main camera which will be submitted in the hierarchy somewhere. It
	 *  is never NULL.
	 *
	 *  If your renderer does not support deferred camera transformation, camera
	 *  is the transformed camera.
	 *
	 *  If your renderer supports deferred light transformation, lights will be
	 *  NULL, and will be submitted to your light draw methods instead.
	 *
	 *  This call signals the end of the default update state, and the start of 
	 *  submit commands from the user to the view.
	 *
	 *  REQUIRED
	 	}

CONST
	kQ3XMethodTypeRendererStartPass = 'rdst';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererStartPassMethod = FUNCTION(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; camera: TQ3CameraObject; lightGroup: TQ3GroupObject): TQ3Status; C;
{$ELSEC}
	TQ3XRendererStartPassMethod = ProcPtr;
{$ENDC}

	{	
	 *  kQ3XMethodTypeRendererFlushFrame
	 *  TQ3XRendererFlushFrameMethod
	 *  
	 *  This call is only implemented by asynchronous renderers.
	 *  
	 *  The FlushFrame method is called between the StartPass and EndPass
	 *  methods and is called when the user wishes to flush any asynchronous
	 *  drawing tasks (which draw to the drawcontext), but does not want 
	 *  to block.
	 *  
	 *  The result of this call is that an image should "eventually" appear
	 *  asynchronously.
	 *  
	 *  For asynchronous rendering, this call is non-blocking.
	 *  
	 *  An interactive renderer should ensure that all received
	 *  geometries are drawn in the image.
	 *  
	 *  An interactive renderer that talks to hardware should force
	 *  the hardware to generate an image.
	 *  
	 *  A deferred renderer should exhibit a similar behaviour,
	 *  though it is not required.  A deferred renderer should spawn
	 *  a process that generates a partial image from the currently
	 *  accumulated drawing state. 
	 *  
	 *  However, for renderers such as ray-tracers which generally are
	 *  quite compute-intensive, FlushFrame is not required and is a no-op.
	 *
	 *  OPTIONAL
	 	}

CONST
	kQ3XMethodTypeRendererFlushFrame = 'rdfl';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererFlushFrameMethod = FUNCTION(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; drawContext: TQ3DrawContextObject): TQ3Status; C;
{$ELSEC}
	TQ3XRendererFlushFrameMethod = ProcPtr;
{$ENDC}

	{	
	 *  kQ3XMethodTypeRendererEndPass
	 *  TQ3XRendererEndPassMethod
	 *  
	 *  The EndPass method is called at Q3View_EndRendering and signals
	 *  the end of submit commands to the view.
	 *
	 *  If an error occurs, the renderer should call Q3XError_Post and
	 *  return kQ3ViewStatusError.
	 *  
	 *  If a renderer requires another pass on the renderering data,
	 *  it should return kQ3ViewStatusRetraverse.
	 *  
	 *  If rendering was cancelled, this function will not be called
	 *  and the view will handle returning kQ3ViewStatusCancelled;
	 *  
	 *  Otherwise, your renderer should begin completing the process of 
	 *  generating the image in the drawcontext. If you have buffered
	 *  any drawing data, flush it. RendererEnd should have a similar
	 *  effect as RendererFlushFrame.
	 *  
	 *  If the renderer is synchronous:
	 *      - complete rendering of the entire frame
	 *      if the renderer supports kQ3RendererClassSupportDoubleBuffer
	 *          - Update the front buffer
	 *      else
	 *          - DrawContext will update the front buffer after returning
	 *
	 *  If the renderer is asynchronous
	 *      - spawn rendering thread for entire frame
	 *      if the renderer supports kQ3RendererClassSupportDoubleBuffer,
	 *          - you must eventually update the front buffer asynchronously
	 *      else
	 *          - you must eventually update the back buffer asynchronously
	 *          
	 *  REQUIRED
	 	}

CONST
	kQ3XMethodTypeRendererEndPass = 'rded';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererEndPassMethod = FUNCTION(view: TQ3ViewObject; rendererPrivate: UNIV Ptr): TQ3ViewStatus; C;
{$ELSEC}
	TQ3XRendererEndPassMethod = ProcPtr;
{$ENDC}

	{	
	 *  kQ3XMethodTypeRendererEndFrame
	 *  TQ3XRendererEndFrame
	 *  
	 *  This call is only implemented by asynchronous renderers.
	 *
	 *  The EndFrame method is called from Q3View_Sync, which is
	 *  called after Q3View_EndRendering and signals that the user
	 *  wishes to see the completed image and is willing to block.
	 *  
	 *  If your renderer supports kQ3RendererFlagDoubleBuffer
	 *      - update the front buffer completely 
	 *  else
	 *      - update the back buffer completely
	 *
	 *  This call is equivalent in functionality to RendererFlushFrame
	 *  but blocks until the image is completed.
	 *  
	 *  If no method is supplied, the default is a no-op.
	 *  
	 *  NOTE: Registering a method of this type indicates that your renderer will
	 *  be rendering after Q3View_EndRendering has been called.
	 *  
	 *  OPTIONAL
	 	}

CONST
	kQ3XMethodTypeRendererEndFrame = 'rdsy';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererEndFrameMethod = FUNCTION(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; drawContext: TQ3DrawContextObject): TQ3Status; C;
{$ELSEC}
	TQ3XRendererEndFrameMethod = ProcPtr;
{$ENDC}

	{	
	 *  The RendererCancel method is called after Q3View_StartRendering
	 *  and signals the termination of all rendering operations.
	 *
	 *  A renderer should clean up any cached data, and cancel all 
	 *  rendering operations.
	 *  
	 *  If called before Q3View_EndRendering, the RendererEnd method
	 *  is NOT called.
	 *  
	 *  If called after Q3View_EndRendering, the renderer should kill
	 *  any threads and terminate any further rendering.
	 *  
	 *  REQUIRED
	 	}

CONST
	kQ3XMethodTypeRendererCancel = 'rdab';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererCancelMethod = PROCEDURE(view: TQ3ViewObject; rendererPrivate: UNIV Ptr); C;
{$ELSEC}
	TQ3XRendererCancelMethod = ProcPtr;
{$ENDC}

	{	*****************************************************************************
	 **                                                                          **
	 **                     Renderer DrawContext Methods                         **
	 **                                                                          **
	 ****************************************************************************	}
	{	
	 *  kQ3XMethodTypeRendererPush
	 *  TQ3XRendererPushMethod
	 *  
	 *  kQ3XMethodTypeRendererPop
	 *  TQ3XRendererPopMethod
	 *  
	 *  These methods are called whenever the graphics state in the view
	 *  is pushed or popped. The user may isolate state by calling:
	 *  
	 *  Q3Attribute_Submit(kQ3AttributeTypeDiffuseColor, &red, view);
	 *  Q3Attribute_Submit(kQ3AttributeTypeTransparencyColor, &blue, view);
	 *  Q3Attribute_Submit(kQ3AttributeTypeSpecularColor, &white, view);
	 *  Q3Box_Submit(&unitBox, view);
	 *  Q3TranslateTransform_Submit(&unitVector, view);
	 *  Q3Push_Submit(view);
	 *      Q3Attribute_Submit(kQ3AttributeTypeDiffuseColor, &blue, view);
	 *      Q3Attribute_Submit(kQ3AttributeTypeTransparencyColor, &green, view);
	 *      Q3Box_Submit(&unitBox, view);
	 *  Q3Pop_Submit(view); 
	 *  Q3TranslateTransform_Submit(&unitVector, view);
	 *  Q3Box_Submit(&unitBox, view);
	 *  
	 *  or by submitting a display group which pushes and pops.
	 *  
	 *  If you support RendererPush and RendererPop in your renderer:
	 *      - you must maintain your drawing state as a stack, as well.
	 *      - you will not be updated with the popped state after
	 *          RendererPop is called.
	 *
	 *  If you do not support Push and Pop in your renderer:
	 *      - you may maintain a single copy of the drawing state.
	 *      - you will be updated with changed fields after the view stack is
	 *          popped.
	 *
	 *  A renderer that supports Push and Pop gets called in the following
	 *  sequence (from example above):
	 *  
	 *  RendererUpdateAttributeDiffuseColor(&red,...)
	 *  RendererUpdateAttributeTransparencyColor(&blue,...)
	 *  RendererUpdateAttributeSpecularColor(&white,...)
	 *  RendererUpdateMatrixLocalToWorld(...)
	 *  RendererSubmitGeometryBox(...)
	 *  RendererPush(...)
	 *      RendererUpdateAttributeDiffuseColor(&blue,...)
	 *      RendererUpdateAttributeTransparencyColor(&green,...)
	 *      RendererSubmitGeometryBox(...)
	 *  RendererPop(...)
	 *  RendererUpdateMatrixLocalToWorld(...)
	 *  RendererSubmitGeometryBox(...)
	 *
	 *  A renderer that does not supports Push and Pop gets called in the
	 *  following sequence:
	 *  
	 *  RendererUpdateAttributeDiffuseColor(&red,...)
	 *  RendererUpdateAttributeTransparencyColor(&blue,...)
	 *  RendererUpdateAttributeSpecularColor(&white,...)
	 *  RendererUpdateMatrixLocalToWorld(...)
	 *  RendererSubmitGeometryBox(...)
	 *      RendererUpdateAttributeDiffuseColor(&blue,...)
	 *      RendererUpdateAttributeTransparencyColor(&green,...)
	 *      RendererSubmitGeometryBox(...)
	 *  RendererUpdateAttributeDiffuseColor(&red,...)
	 *  RendererUpdateAttributeTransparencyColor(&blue,...)
	 *  RendererUpdateMatrixLocalToWorld(...)
	 *  RendererSubmitGeometryBox(...)
	 *  
	 	}

CONST
	kQ3XMethodTypeRendererPush	= 'rdps';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererPushMethod = FUNCTION(view: TQ3ViewObject; rendererPrivate: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3XRendererPushMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodTypeRendererPop	= 'rdpo';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererPopMethod = FUNCTION(view: TQ3ViewObject; rendererPrivate: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3XRendererPopMethod = ProcPtr;
{$ENDC}

	{	*****************************************************************************
	 **                                                                          **
	 **                         Renderer Cull Methods                            **
	 **                                                                          **
	 ****************************************************************************	}
	{	
	 *  kQ3XMethodTypeRendererIsBoundingBoxVisible
	 *  TQ3XRendererIsBoundingBoxVisibleMethod
	 *  
	 *  This method is called to cull complex groups and geometries 
	 *  given their bounding box in local space.
	 *  
	 *  It should transform the local-space bounding box coordinates to
	 *  frustum space and return a TQ3Boolean return value indicating
	 *  whether the box appears within the viewing frustum.
	 *  
	 *  If no method is supplied, the default behavior is to return
	 *  kQ3True.
	 *  
	 	}

CONST
	kQ3XMethodTypeRendererIsBoundingBoxVisible = 'rdbx';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererIsBoundingBoxVisibleMethod = FUNCTION(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; {CONST}VAR bBox: TQ3BoundingBox): TQ3Boolean; C;
{$ELSEC}
	TQ3XRendererIsBoundingBoxVisibleMethod = ProcPtr;
{$ENDC}


	{	*****************************************************************************
	 **                                                                          **
	 **                     Renderer Object Support Methods                      **
	 **                                                                          **
	 ****************************************************************************	}
	{	
	 *  Drawing methods (Geometry, Camera, Lights)
	 *
	 	}
	{	
	 *  Geometry MetaHandler
	 *  
	 *  This metaHandler is required to support 
	 *  
	 *  kQ3GeometryTypeTriangle
	 *  kQ3GeometryTypeLine
	 *  kQ3GeometryTypePoint
	 *  kQ3GeometryTypeMarker
	 *  kQ3GeometryTypePixmapMarker
	 *  
	 *  REQUIRED
	 	}

CONST
	kQ3XMethodTypeRendererSubmitGeometryMetaHandler = 'rdgm';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererSubmitGeometryMetaHandlerMethod = FUNCTION(geometryType: TQ3ObjectType): TQ3XFunctionPointer; C;
{$ELSEC}
	TQ3XRendererSubmitGeometryMetaHandlerMethod = ProcPtr;
{$ENDC}

	{	
	 *  The TQ3XRendererSubmitGeometryMetaHandlerMethod switches on geometryType
	 *  of kQ3GeometryTypeFoo and returns methods of type:
	 	}
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererSubmitGeometryMethod = FUNCTION(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; geometry: TQ3GeometryObject; publicData: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3XRendererSubmitGeometryMethod = ProcPtr;
{$ENDC}

	{	
	 *  Camera MetaHandler
	 *  
	 *  This metaHandler, if supplied, indicates that your renderer
	 *  handles deferred transformation of the main camera within a scene.
	 *  
	 *  If not supplied, or an unsupported camera is used, the view will do
	 *  the transformation for the renderer and pass in a camera in the 
	 *  StartPass method.
	 *  
	 *  OPTIONAL
	 	}

CONST
	kQ3XMethodTypeRendererSubmitCameraMetaHandler = 'rdcm';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererSubmitCameraMetaHandlerMethod = FUNCTION(cameraType: TQ3ObjectType): TQ3XFunctionPointer; C;
{$ELSEC}
	TQ3XRendererSubmitCameraMetaHandlerMethod = ProcPtr;
{$ENDC}

	{	
	 *  The TQ3XRendererSubmitCameraMetaHandlerMethod switches on cameraType
	 *  of kQ3CameraTypeFoo and returns methods of type:
	 	}
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererSubmitCameraMethod = FUNCTION(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; camera: TQ3CameraObject; publicData: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3XRendererSubmitCameraMethod = ProcPtr;
{$ENDC}

	{	
	 *  Light MetaHandler
	 *  
	 *  This metaHandler, if supplied, indicates that your renderer
	 *  handles deferred transformation of lights within a scene.
	 *  
	 *  If an unsupported light is encountered, it is ignored.
	 *
	 *  OPTIONAL
	 	}

CONST
	kQ3XMethodTypeRendererSubmitLightMetaHandler = 'rdlg';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererSubmitLightMetaHandlerMethod = FUNCTION(lightType: TQ3ObjectType): TQ3XFunctionPointer; C;
{$ELSEC}
	TQ3XRendererSubmitLightMetaHandlerMethod = ProcPtr;
{$ENDC}

	{	
	 *  The TQ3XRendererSubmitLightMetaHandlerMethod switches on lightType
	 *  of kQ3LightTypeFoo and returns methods of type:
	 	}
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererSubmitLightMethod = FUNCTION(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; light: TQ3LightObject; publicData: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3XRendererSubmitLightMethod = ProcPtr;
{$ENDC}

	{	
	 *
	 *  Update methods
	 *
	 *  They are called whenever the state has changed. If the renderer supports
	 *  the RendererPush and RendererPop methods, it must maintain its own state
	 *  stack. Updates are not called for changed data when the view stack is
	 *  popped.
	 *
	 *  See the comments for the RendererPush and RendererPop methods above
	 *  for an example of how data is updated.
	 *
	 	}
	{	
	 *  Style
	 	}

CONST
	kQ3XMethodTypeRendererUpdateStyleMetaHandler = 'rdyu';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererUpdateStyleMetaHandlerMethod = FUNCTION(styleType: TQ3ObjectType): TQ3XFunctionPointer; C;
{$ELSEC}
	TQ3XRendererUpdateStyleMetaHandlerMethod = ProcPtr;
{$ENDC}

	{	
	 *  The TQ3XRendererUpdateStyleMetaHandlerMethod switches on styleType
	 *  of kQ3StyleTypeFoo and returns methods of type:
	 	}
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererUpdateStyleMethod = FUNCTION(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; publicData: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3XRendererUpdateStyleMethod = ProcPtr;
{$ENDC}

	{	
	 *  Attributes
	 	}

CONST
	kQ3XMethodTypeRendererUpdateAttributeMetaHandler = 'rdau';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererUpdateAttributeMetaHandlerMethod = FUNCTION(attributeType: TQ3AttributeType): TQ3XFunctionPointer; C;
{$ELSEC}
	TQ3XRendererUpdateAttributeMetaHandlerMethod = ProcPtr;
{$ENDC}

	{	
	 *  The TQ3XRendererUpdateStyleMetaHandlerMethod switches on attributeType
	 *  of kQ3AttributeTypeFoo and returns methods of type:
	 	}
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererUpdateAttributeMethod = FUNCTION(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; publicData: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3XRendererUpdateAttributeMethod = ProcPtr;
{$ENDC}

	{	
	 *  Shaders
	 	}

CONST
	kQ3XMethodTypeRendererUpdateShaderMetaHandler = 'rdsu';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererUpdateShaderMetaHandlerMethod = FUNCTION(shaderType: TQ3ObjectType): TQ3XFunctionPointer; C;
{$ELSEC}
	TQ3XRendererUpdateShaderMetaHandlerMethod = ProcPtr;
{$ENDC}

	{	
	 *  The TQ3XRendererUpdateShaderMetaHandlerMethod switches on shaderType
	 *  of kQ3ShaderTypeFoo and returns methods of type:
	 	}
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererUpdateShaderMethod = FUNCTION(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; VAR shaderObject: TQ3Object): TQ3Status; C;
{$ELSEC}
	TQ3XRendererUpdateShaderMethod = ProcPtr;
{$ENDC}

	{	
	 *  Matrices
	 	}

CONST
	kQ3XMethodTypeRendererUpdateMatrixMetaHandler = 'rdxu';


TYPE
	TQ3XRendererUpdateMatrixMetaHandlerMethod = TQ3XMetaHandler;
	{	
	 *  The TQ3XRendererUpdateShaderMetaHandlerMethod switches on methods
	 *  of the form kQ3MethodTypeRendererUpdateMatrixFoo:
	 	}

CONST
	kQ3XMethodTypeRendererUpdateMatrixLocalToWorld = 'ulwx';

	kQ3XMethodTypeRendererUpdateMatrixLocalToWorldInverse = 'ulwi';

	kQ3XMethodTypeRendererUpdateMatrixLocalToWorldInverseTranspose = 'ulwt';

	kQ3XMethodTypeRendererUpdateMatrixLocalToCamera = 'ulcx';

	kQ3XMethodTypeRendererUpdateMatrixLocalToFrustum = 'ulfx';

	kQ3XMethodTypeRendererUpdateMatrixWorldToFrustum = 'uwfx';

	{	
	 *  and returns methods of type:
	 	}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XRendererUpdateMatrixMethod = FUNCTION(view: TQ3ViewObject; rendererPrivate: UNIV Ptr; {CONST}VAR matrix: TQ3Matrix4x4): TQ3Status; C;
{$ELSEC}
	TQ3XRendererUpdateMatrixMethod = ProcPtr;
{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DRendererIncludes}

{$ENDC} {__QD3DRENDERER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
