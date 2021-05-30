{
     File:       MacApplication.p
 
     Contains:   Application-level APIs
 
     Version:    Technology: Mac OS X
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
 UNIT MacApplication;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MACAPPLICATION__}
{$SETC __MACAPPLICATION__ := 1}

{$I+}
{$SETC MacApplicationIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CGCONTEXT__}
{$I CGContext.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
 *  SetApplicationDockTileImage()
 *  
 *  Discussion:
 *    Sets the image for the tile in the dock that represents your
 *    application while it is running. If you set the image, it will
 *    revert back to its original image when your application
 *    terminates automatically. You do not need to manually restore it.
 *  
 *  Parameters:
 *    
 *    inImage:
 *      The image you wish to have as your tile image.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetApplicationDockTileImage(inImage: CGImageRef): OSStatus; C;

{
 *  OverlayApplicationDockTileImage()
 *  
 *  Discussion:
 *    Takes the image passed in and composites it on top of the current
 *    image of your application's dock tile. You might do this to put a
 *    standard badge over your application's icon to indicate something
 *    to the user.
 *  
 *  Parameters:
 *    
 *    inImage:
 *      The image you wish to overlay onto your tile image.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OverlayApplicationDockTileImage(inImage: CGImageRef): OSStatus; C;

{
 *  RestoreApplicationDockTileImage()
 *  
 *  Discussion:
 *    Restores the tile for your appliation in the dock to its normal
 *    image (your application icon). You would use this if some overlay
 *    or change of the application icon needed to be removed.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RestoreApplicationDockTileImage: OSStatus; C;

{
 *  BeginCGContextForApplicationDockTile()
 *  
 *  Discussion:
 *    Creates and returns a CGContextRef. You can use this context to
 *    draw into your application's dock tile with Quartz. You **MUST**
 *    call EndCGContextForApplicationDockTile and NOT CGEndContext when
 *    using this API, as it locks your application's tile in the dock.
 *    If you call CGEndContext, the dock will never know you are done
 *    with the tile.
 *  
 *  Result:
 *    An Quartz (Core Graphics) context reference.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BeginCGContextForApplicationDockTile: CGContextRef; C;

{
 *  EndCGContextForApplicationDockTile()
 *  
 *  Discussion:
 *    Ends the CG context for your application tile and frees the lock
 *    on the application dock tile. You **MUST** call this routine and
 *    NOT CGEndContext when using BeginCGContextForApplicationDockTile,
 *    as it locks your application's tile in the dock. If you call
 *    CGEndContext, the dock will never know you are done with the tile.
 *  
 *  Parameters:
 *    
 *    inContext:
 *      The context to end. The context is invalid after this call and
 *      should no longer be used.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE EndCGContextForApplicationDockTile(inContext: CGContextRef); C;



{
 *  BeginQDContextForApplicationDockTile()
 *  
 *  Discussion:
 *    Creates and returns a CGrafPtr for your application's tile in the
 *    dock. You can use this port to draw into your application's dock
 *    tile with Quickdraw. You **MUST** call
 *    EndQDContextForApplicationDockTile and NOT DisposePort when using
 *    this API, as it locks your application's tile in the dock. If you
 *    call DisposePort, the dock will never know you are done with the
 *    tile.
 *  
 *  Result:
 *    A Quickdraw port reference.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BeginQDContextForApplicationDockTile: CGrafPtr; C;

{
 *  EndQDContextForApplicationDockTile()
 *  
 *  Discussion:
 *    Disposes the Quickdraw port for your application tile and frees
 *    the lock on the application dock tile. You **MUST** call this
 *    routine and NOT DisposePort when using
 *    BeginQDContextForApplicationDockTile, else the dock will never
 *    know you are done with the tile.
 *  
 *  Parameters:
 *    
 *    inContext:
 *      The context to end. The context is invalid after this call and
 *      should no longer be used.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE EndQDContextForApplicationDockTile(inContext: CGrafPtr); C;



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MacApplicationIncludes}

{$ENDC} {__MACAPPLICATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
