/*
    File:	 PlugInt.c
	
    Description: Basic CFPlugIn sample code shell, Carbon API

    Copyright: 	 © Copyright 2001 Apple Computer, Inc. All rights reserved.

    Disclaimer:	 IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc.
                 ("Apple") in consideration of your agreement to the following terms, and your
                 use, installation, modification or redistribution of this Apple software
                 constitutes acceptance of these terms.  If you do not agree with these terms,
                 please do not use, install, modify or redistribute this Apple software.

                 In consideration of your agreement to abide by the following terms, and subject
                 to these terms, Apple grants you a personal, non-exclusive license, under Apple’s
                 copyrights in this original Apple software (the "Apple Software"), to use,
                 reproduce, modify and redistribute the Apple Software, with or without
                 modifications, in source and/or binary forms; provided that if you redistribute
                 the Apple Software in its entirety and without modifications, you must retain
                 this notice and the following text and disclaimers in all such redistributions of
                 the Apple Software.  Neither the name, trademarks, service marks or logos of
                 Apple Computer, Inc. may be used to endorse or promote products derived from the
                 Apple Software without specific prior written permission from Apple.  Except as
                 expressly stated in this notice, no other rights or licenses, express or implied,
                 are granted by Apple herein, including but not limited to any patent rights that
                 may be infringed by your derivative works or by other works in which the Apple
                 Software may be incorporated.

                 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO
                 WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED
                 WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
                 PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
                 COMBINATION WITH YOUR PRODUCTS.

                 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR
                 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
                 GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
                 ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION
                 OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT
                 (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN
                 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/

#if __APPLE_CC__
#include <Carbon/Carbon.h>
#else
#include <Carbon.h>
#endif

#include "PlugInInterface.h"
#include <stdio.h>
#include <stdlib.h>

// Constants
enum {
    kBallWidth			= 20,
    kBallHeight			= 20,
    kBobSize			= 11	// Width of text in each ball
};

//  The UUID for the factory function.

#define kTestFactoryID (CFUUIDGetConstantUUIDWithBytes(NULL, 0x68, 0x75, 0x3A, 0x44, 0x4D, 0x6F, 0x12, 0x26, 0x9C, 0x60, 0x00, 0x50, 0xE4, 0xC0, 0x00, 0x67))

// The layout for an instance of MyType.

typedef struct _MyType {
    DrawBallInterfaceStruct *_drawBallInterface;
    CFUUIDRef _factoryID;
    UInt32 _refCount;
} MyType;

// Forward declaration for the IUnknown implementation.

void *MyFactory( CFAllocatorRef allocator, CFUUIDRef typeID );
static void _deallocMyType( MyType *myInstance );

// -------------------------------------------------------------------------------------------
//
//  Implementation of the IUnknown QueryInterface function.
//

static HRESULT myQueryInterface( void *myInstance, REFIID iid, LPVOID *ppv )
{
    //  Create a CoreFoundation UUIDRef for the requested interface.

    CFUUIDRef interfaceID = CFUUIDCreateFromUUIDBytes( NULL, iid );

    // Test the requested ID against the valid interfaces.

    if( CFEqual( interfaceID, kTestInterfaceID ) ) {

        //  If the TestInterface was requested, bump the ref count, set the ppv parameter
        //  equal to the instance, and return good status.

        ( (MyType *) myInstance )->_drawBallInterface->AddRef( myInstance );
        *ppv = myInstance;
        CFRelease( interfaceID );
        return S_OK;
    }
    else if( CFEqual( interfaceID, IUnknownUUID ) ) {

        //  If the IUnknown interface was requested, same as above.

        ( (MyType *) myInstance )->_drawBallInterface->AddRef( myInstance );
        *ppv = myInstance;
        CFRelease( interfaceID );
        return S_OK;
    }
    else {

        //  Requested interface unknown, bail with error.

        *ppv = NULL;
        CFRelease( interfaceID );
        return E_NOINTERFACE;
    }
}

// -------------------------------------------------------------------------------------------
//
//  Implementation of reference counting for this type.
//  Whenever an interface is requested, bump the refCount for the instance.
//  NOTE: returning the refcount is a convention but is not required so don't rely on it.
//

static ULONG myAddRef( void *myInstance )
{
    ( (MyType *) myInstance )->_refCount += 1;
    return ( (MyType *) myInstance )->_refCount;
}

// -------------------------------------------------------------------------------------------
//
//  When an interface is released, decrement the refCount.
//  If the refCount goes to zero, deallocate the instance.
//

static ULONG myRelease( void *myInstance )
{
    ( (MyType *) myInstance )->_refCount -= 1;
    if ( ( (MyType *) myInstance )->_refCount == 0 ) {
        _deallocMyType( (MyType *) myInstance );
        return 0;
    }
    else
        return ( (MyType *) myInstance )->_refCount;
}

// -------------------------------------------------------------------------------------------
//
//  The implementation of the drawBall function.
//

static void drawBall( void *myInstance )
{
#pragma unused (myInstance)

    RGBColor            ballColor;
    GrafPtr             currentPort;
    Rect                ballRect;
    Rect                portRect;
    long                newLeft;
    long                newTop;

    // Make a random new color for the ball.

    ballColor.red   = Random();
    ballColor.green = Random();
    ballColor.blue  = Random();

    // Set that color as the new color to use in drawing.

    RGBForeColor( &ballColor );

    // Make a random new location for the ball that is normalized to the grafPort size.  
    // This makes the integer from Random into a number that is portRect.top..portRect.bottom
    // and portRect.left..portRect.right. They are normalized so that we don't spend most of our
    // time drawing in places outside of the grafPort.

    GetPort( &currentPort );
    GetPortBounds( currentPort, &portRect );

    newTop = Random();	
    newTop = (( newTop + 32768 ) % portRect.bottom ) + portRect.top;

    newLeft = Random();
    newLeft = (( newLeft + 32768 ) % portRect.right ) + portRect.left;

    SetRect( &ballRect, newLeft, newTop, newLeft + kBallWidth, newTop + kBallHeight );

    // Move pen to the new location, and paint the colored ball.

    MoveTo( newLeft, newTop );
    PaintOval( &ballRect );

    // Move the pen to the middle of the new ball position, for the text

    MoveTo( ballRect.left + kBallWidth / 2 - kBobSize, 
            ballRect.top + kBallHeight / 2 + kBobSize / 2 - 1 );

    // Invert the color and draw the text there.

    InvertColor( &ballColor ); 
    RGBForeColor( &ballColor );
    DrawString( "\pBob" );
}

// -------------------------------------------------------------------------------------------
//
//  The TestInterface function table.
//

static DrawBallInterfaceStruct drawBallInterfaceFtbl = {
		NULL,                    // Required padding for COM
		myQueryInterface,        // These three are the required COM functions
		myAddRef,
		myRelease,
		drawBall };              // Interface implementation

// -------------------------------------------------------------------------------------------
//
//  Utility function that allocates a new instance.
//

static MyType *_allocMyType( CFUUIDRef factoryID )
{
    //  Allocate memory for the new instance.

    MyType *newOne = (MyType *)malloc( sizeof(MyType) );

    //  Point to the function table

    newOne->_drawBallInterface = &drawBallInterfaceFtbl;

    //  Retain and keep an open instance refcount for each factory.

    if (factoryID) {
        newOne->_factoryID = (CFUUIDRef)CFRetain( factoryID );
        CFPlugInAddInstanceForFactory( factoryID );
    }

    //  This function returns the IUnknown interface so set the refCount to one.

    newOne->_refCount = 1;
    return newOne;
}

// -------------------------------------------------------------------------------------------
//
//  Utility function that deallocates the instance when the refCount goes to zero.
//

static void _deallocMyType( MyType *myInstance )
{
    CFUUIDRef factoryID = myInstance->_factoryID;
    free( myInstance );
    if ( factoryID ) {
        CFPlugInRemoveInstanceForFactory( factoryID );
        CFRelease( factoryID );
    }
}

// -------------------------------------------------------------------------------------------
//
//  Implementation of the factory function for this type.
//

#pragma export MyFactory
void *MyFactory( CFAllocatorRef allocator, CFUUIDRef typeID )
{
#pragma unused (allocator)

    //  If correct type is being requested, allocate an instance of TestType and return
    //  the IUnknown interface.

    if ( CFEqual( typeID, kTestTypeID ) ) {
        MyType *result = _allocMyType( kTestFactoryID );
        return result;
    }
    else {
    
        // If the requested type is incorrect, return NULL.

        return NULL;
    }
}