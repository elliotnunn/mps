/*
    File:	 PlugInHost.h
	
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

#ifdef __APPLE_CC__
#include <CoreFoundation/CoreFoundation.h>
#include <CoreFoundation/CFPlugInCOM.h>
#else
#include <CFPlugIn.h>
#include <CFPlugInCOM.h>
#endif

//  Define the UUID for the type.

#define kTestTypeID (CFUUIDGetConstantUUIDWithBytes(NULL, 0xD7, 0x36, 0x95, 0x0A, 0x4D, 0x6E, 0x12, 0x26, 0x80, 0x3A, 0x00, 0x50, 0xE4, 0xC0, 0x00, 0x67))

//  Define the UUID for the interface.
//  TestType objects must implement TestInterface.

#define kTestInterfaceID (CFUUIDGetConstantUUIDWithBytes(NULL, 0x67, 0x66, 0xE9, 0x4A, 0x4D, 0x6F, 0x12, 0x26, 0x9E, 0x9D, 0x00, 0x50, 0xE4, 0xC0, 0x00, 0x67))

typedef struct PlugInInterfaceStruct {
    IUNKNOWN_C_GUTS;
    void (*drawBall)( void *myInstance );
 } DrawBallInterfaceStruct;

