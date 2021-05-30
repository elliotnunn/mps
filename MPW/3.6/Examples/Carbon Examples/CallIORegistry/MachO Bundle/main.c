/*
	File:		main.c
	
	Disclaimer:	IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc.
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

	Copyright © 1999-2001 Apple Computer, Inc., All Rights Reserved
*/


#include <ctype.h>
#include <stdlib.h>
#include <assert.h>
#include <limits.h>
#include <stdio.h>

#include <IOKit/IOKitLib.h>

short	GetClockFrequency( CFDictionaryRef *rootProperties, CFDictionaryRef *deviceTypeProperties )
{
	mach_port_t		masterPort;
	kern_return_t		kr;
	io_registry_entry_t	root;
	io_registry_entry_t	cpus;
	io_registry_entry_t	cpu;
	io_iterator_t		iter;
	io_name_t		name;
	CFDataRef		data;
	short			err		= -1;		//	Default to return error

	kr = IOMasterPort( bootstrap_port, &masterPort );
//	fprintf( stderr, "IOMasterPort returned kr=%d, masterPort=%d\n", kr, masterPort );
	if ( kr != nil ) return( -1 );

	root	= IORegistryEntryFromPath( masterPort, kIODeviceTreePlane ":/" );
	if ( root == nil ) return( -1 );

	kr	= IORegistryEntryCreateCFProperties( root, rootProperties, kCFAllocatorDefault, kNilOptions );
	if ( kr != nil ) goto Bail;
    
	data	= CFDictionaryGetValue( *rootProperties, CFSTR("compatible") );
	if ( data == nil ) goto Bail;

	//	Go looking for a cpu
	if( ( cpus = IORegistryEntryFromPath( masterPort, kIODeviceTreePlane ":/cpus" )) )
	{
		kr	= IORegistryEntryGetChildIterator( cpus, kIODeviceTreePlane, &iter );
		IOObjectRelease( cpus );
	}
	else
	{
		kr = IORegistryEntryGetChildIterator( root, kIODeviceTreePlane, &iter );
	}

	while( cpu = IOIteratorNext( iter ) )
	{
		if( (data = IORegistryEntryCreateCFProperty( cpu, CFSTR("device_type"), kCFAllocatorDefault, kNilOptions ))
		 && (0 == strcmp("cpu", CFDataGetBytePtr(data)) ) )
		{
			(void) IORegistryEntryGetName( cpu, name );
			err = IORegistryEntryCreateCFProperties( cpu, deviceTypeProperties, kCFAllocatorDefault, kNilOptions );
		}
		IOObjectRelease( cpu );
	}
	IOObjectRelease( iter );
Bail:
	IOObjectRelease( root );
	return( err );
}




