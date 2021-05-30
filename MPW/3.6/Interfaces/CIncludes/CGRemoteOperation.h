/*
     File:       CGRemoteOperation.h
 
     Contains:   xxx put contents here xxx
 
     Version:    Technology: from CoreGraphics-93.14
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __CGREMOTEOPERATION__
#define __CGREMOTEOPERATION__

#ifndef __CGBASE__
#include <CGBase.h>
#endif

#ifndef __CGGEOMETRY__
#include <CGGeometry.h>
#endif

#ifndef __CGERROR__
#include <CGError.h>
#endif

#ifndef __CFDATE__
#include <CFDate.h>
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

typedef CGError                         CGEventErr;
enum {
  CGEventNoErr                  = kCGErrorSuccess
};


/* Screen refresh or drawing notification */
/*
 * Callback function pointer;
 * Declare your callback function in this form.  When an area of the display is
 * modified or refreshed, your callback function will be invoked with a count
 * of the number of rectangles in the refreshed areas, and a list of the refreshed
 * rectangles.  The rectangles are in global coordinates.
 *
 * Your function should not modify, deallocate or free memory pointed to by rectArray.
 *
 * The system continues to accumulate refreshed areas constantly.  Whenever new
 * information is available, your callback function is invoked.The list of rects
 * passed to the callback function are cleared from the accumulated refreshed area
 * when the callback is made.
 *
 * This callback may be triggered by drawing operations, window movement, and
 * display reconfiguration.
 *
 * Bear in mind that a single rectangle may occupy multiple displays,
 * either by overlapping the displays, or by residing on coincident displays
 * when mirroring is active.  Use the CGGetDisplaysWithRect() to determine
 * the displays a rectangle occupies.
 */
typedef u_int32_t                       CGRectCount;
typedef CALLBACK_API_C( void , CGScreenRefreshCallback )(CGRectCount count, const CGRect *rectArray, void *userParameter);
/*
 * Register a callback function to be invoked when an area of the display
 * is refreshed, or modified.  The function is invoked on the same thread
 * of execution that is processing events within your application.
 * userParameter is passed back with each invocation of the callback function.
 */
/*
 *  CGRegisterScreenRefreshCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CGRegisterScreenRefreshCallback(
  CGScreenRefreshCallback   callback,
  void *                    userParameter);


/*
 * Remove a previously registered calback function.
 * Both the function and the userParameter must match the registered entry to be removed.
 */
/*
 *  CGUnregisterScreenRefreshCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CGUnregisterScreenRefreshCallback(
  CGScreenRefreshCallback   callback,
  void *                    userParameter);



/*
 * In some applications it may be preferable to have a seperate thread wait for screen refresh data.
 * This function should be called on a thread seperate from the event processing thread.
 * If screen refresh callback functions are registered, this function should not be used.
 * The mechanisms are mutually exclusive.
 *
 * Deallocate screen refresh rects using CGReleaseScreenRefreshRects().
 *
 * Returns an error code if parameters are invalid or an error occurs in retrieving
 * dirty screen rects from the server.
 */
/*
 *  CGWaitForScreenRefreshRects()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CGEventErr )
CGWaitForScreenRefreshRects(
  CGRect **      pRectArray,
  CGRectCount *  pCount);


/*
 * Deallocate the list of rects recieved from CGWaitForScreenRefreshRects()
 */
/*
 *  CGReleaseScreenRefreshRects()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CGReleaseScreenRefreshRects(CGRect * rectArray);


/*
 * Posting events: These functions post events into the system.  Use for remote
 * operation and virtualization.
 *
 * Note that remote operation requires a valid connection to the server, which
 * must be owned by either the root/Administrator user or the logged in console
 * user.  This means that your application must be running as root/Administrator
 * user or the logged in console user.
 */

/*
 * Synthesize mouse events.
 * mouseCursorPosition should be the global coordinates the mouse is at for the event.
 * updateMouseCursor should be TRUE if the on-screen cursor
 * should be moved to mouseCursorPosition.
 *
 * Based on the values entered, the appropriate mouse-down, mouse-up, mouse-move,
 * or mouse-drag events are generated, by comparing the new state with the current state.
 *
 * The current implemementation of the event system supports a maximum of thirty-two buttons.
 * The buttonCount parameter should be followed by 'buttonCount' boolean_t values
 * indicating button state.  The first value should reflect the state of the primary
 * button on the mouse. The second value, if any, should reflect the state of the secondary
 * mouse button (right), if any. A third value woule be the center button, and the remaining
 * buttons would be in USB device order.
 */
typedef u_int32_t                       CGButtonCount;
/*
 *  CGPostMouseEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CGEventErr )
CGPostMouseEvent(
  CGPoint         mouseCursorPosition,
  boolean_t       updateMouseCursorPosition,
  CGButtonCount   buttonCount,
  boolean_t       mouseButtonDown,
  ...);


/*
 * Synthesize scroll wheel events.
 *
 * The current implemementation of the event system supports a maximum of three wheels.
 *
 * The wheelCount parameter should be followed by 'wheelCount' 32 bit integer values
 * indicating wheel movements.  The first value should reflect the state of the primary
 * wheel on the mouse. The second value, if any, should reflect the state of a secondary
 * mouse wheel, if any.
 *
 * Wheel movement is represented by small signed integer values,
 * typically in a range from -10 to +10.  Large values may have unexpected results,
 * depending on the  application that processes the event.
 */
typedef u_int32_t                       CGWheelCount;
/*
 *  CGPostScrollWheelEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CGEventErr )
CGPostScrollWheelEvent(
  CGWheelCount   wheelCount,
  int32_t        wheel1,
  ...);


/*
 * Synthesize keyboard events.  Based on the values entered,
 * the appropriate key down, key up, and flags changed events are generated.
 * If keyChar is NUL (0), an apropriate value will be guessed at, based on the
 * default keymapping.
 *
 * All keystrokes needed to generate a character must be entered, including
 * SHIFT, CONTROL, OPTION, and COMMAND keys.  For example, to produce a 'Z',
 * the SHIFT key must be down, the 'z' key must go down, and then the SHIFT
 * and 'z' key must be released:
 *  CGPostKeyboardEvent( (CGCharCode)0, (CGKeyCode)56, true ); // shift down
 *  CGPostKeyboardEvent( (CGCharCode)'Z', (CGKeyCode)6, true ); // 'z' down
 *  CGPostKeyboardEvent( (CGCharCode)'Z', (CGKeyCode)6, false ); // 'z' up
 *  CGPostKeyboardEvent( (CGCharCode)0, (CGKeyCode)56, false ); // 'shift up
 */
typedef u_int16_t                       CGCharCode;
typedef u_int16_t                       CGKeyCode;
/*
 *  CGPostKeyboardEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CGEventErr )
CGPostKeyboardEvent(
  CGCharCode   keyChar,
  CGKeyCode    virtualKey,
  boolean_t    keyDown);


/*
 * Warp the mouse cursor to the desired position in global
 * coordinates without generating events
 */
/*
 *  CGWarpMouseCursorPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CGEventErr )
CGWarpMouseCursorPosition(CGPoint newCursorPosition);


/*
 * Remote operation may want to inhibit local events (events from
 * the machine's keyboard and mouse).  This may be done either as a
 * explicit request (tracked per app) or as a short term side effect of
 * posting an event.
 *
 * CGInhibitLocalEvents() is typically used for long term remote operation
 * of a system, as in automated system testing or telecommuting applications.
 * Local device state changes are discarded.
 *
 * Local event inhibition is turned off if the app that requested it terminates.
 */
/*
 *  CGInhibitLocalEvents()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CGEventErr )
CGInhibitLocalEvents(boolean_t doInhibit);


/*
 * Set the period of time in seconds that local hardware events (keyboard and mouse)
 * are supressed after posting an event.  Defaults to 0.25 second.
 */
/*
 *  CGSetLocalEventsSuppressionInterval()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CGEventErr )
CGSetLocalEventsSuppressionInterval(CFTimeInterval seconds);


/*
 * Helper function to connect or disconnect the mouse and mouse cursor.
 * CGAssociateMouseAndMouseCursorPosition(false) has the same effect
 * as the following, without actually modifying the supression interval:
 *
 *  CGSetLocalEventsSuppressionInterval(MAX_DOUBLE);
 *  CGWarpMouseCursorPosition(currentPosition);
 *
 * While disconnected, mouse move and drag events will reflect the current position of
 * the mouse cursor position, which will not change with mouse movement. Use the
 * <CoreGraphics/CGDirectDisplay.h> function:
 *
 *  void CGGetLastMouseDelta( CGMouseDelta * deltaX, CGMouseDelta * deltaY );
 *
 * This will report mouse movement associated with the last mouse move or drag event.
 *
 * To update the display cursor position, use the function defined in this module:
 *
 *  CGEventErr CGWarpMouseCursorPosition( CGPoint newCursorPosition );
 */
/*
 *  CGAssociateMouseAndMouseCursorPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CGEventErr )
CGAssociateMouseAndMouseCursorPosition(boolean_t connected);



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

#endif /* __CGREMOTEOPERATION__ */

