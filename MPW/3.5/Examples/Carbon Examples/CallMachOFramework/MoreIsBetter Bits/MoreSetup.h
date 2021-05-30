/*
	File:		MoreSetup.h

	Contains:	Sets up conditions etc for MoreIsBetter.

	Written by:	Pete Gontier (PCG)

	Copyright:	Copyright © 1998 by Apple Computer, Inc., All Rights Reserved.

				You may incorporate this Apple sample source code into your program(s) without
				restriction. This Apple sample source code has been provided "AS IS" and the
				responsibility for its operation is yours. You are not permitted to redistribute
				this Apple sample source code as "Apple sample source code" after having made
				changes. If you're going to re-distribute the source, we require that you make
				it clear in the source that the code was descended from Apple sample source
				code, but that you've made changes.

	Change History (most recent first):

         <7>     22/4/99    Quinn   Add a check for the Universal Interfaces version.  MoreIsBetter
                                    requires Universal Interfaces 3.2 or higher (because many of its
                                    component parts do).
         <6>     2/11/99    PCG     add comments because Andy rightfully pointed out my original
                                    attempts sucked; also, remove some excessive TARGET_CARBON
                                    gymnastics
         <5>     1/22/99    PCG     TARGET_CARBON
         <4>    11/11/98    PCG     fix header
         <3>    11/10/98    PCG     separate change histories
         <2>    10/11/98    Quinn   Convert "MorePrefix.h" to "MoreSetup.h".
         <1>    10/11/98    Quinn   Changed name from "MorePrefix.h" to "MoreSetup.h".

	Start of "MorePrefix.h" change history (most recent first):

         <3>     5/11/98    Quinn   Use MoreAssertQ instead of MoreAssert.
         <2>     7/24/98    PCG	    rid of triplet #includes
         <2>     6/23/98    PCG     add copyright disclaimer stuff
         <1>     6/23/98    PCG     initial checkin
*/

#pragma once

	//
	//	We never want to use old names or locations.
	//	Since these settings must be consistent all the way through
	//	a compilation unit, and since we don't want to silently
	//	change them out from under a developer who uses a prefix
	//	file (C/C++ panel of Target Settings), we simply complain
	//	if they are already set in a way we don't like.
	//

#ifndef OLDROUTINELOCATIONS
#	define OLDROUTINELOCATIONS 0
#elif OLDROUTINELOCATIONS
#	error OLDROUTINELOCATIONS must be FALSE when compiling MoreIsBetter.
#endif

#ifndef OLDROUTINENAMES
#	define OLDROUTINENAMES 0
#elif OLDROUTINENAMES
#	error OLDROUTINENAMES must be FALSE when compiling MoreIsBetter.
#endif

	//
	//	Almost every non-trivial module needs to detect
	//	or produce errors, so we include it for the
	//	convenience of all modules.
	//

#include <Errors.h>

	//	Now that we've included a Mac OS interface file,
	//	we know that the Universal Interfaces environment
	//	is set up.  MoreIsBetter requires Universal Interfaces
	//	3.2 or higher.  Check for it.

#if !defined(UNIVERSAL_INTERFACES_VERSION) || UNIVERSAL_INTERFACES_VERSION < 0x0320
	#error MoreIsBetter requires Universal Interfaces 3.2 or higher.
#endif

	//
	//	We usually want asserions and other debugging code
	//	turned on, but you can turn it all off if you like
	//	by setting MORE_DEBUG to 0.
	//

#ifndef MORE_DEBUG
#	define MORE_DEBUG 1
#endif

	//
	//	Our assertion macros compile down to nothing if
	//	MORE_DEBUG is not true. MoreAssert produces a
	//	value indicating whether the assertion succeeded
	//	or failed. MoreAssertQ is Quinn's flavor of
	//	MoreAssert which does not produce a value.
	//

#if MORE_DEBUG
#	define MoreAssert(x) \
		((x) ? true : (DebugStr ("\pMoreAssert failure: " #x), false))
#	define MoreAssertQ(x) \
		do { if (!(x)) DebugStr ("\pMoreAssertQ failure: " #x); } while (false)
#else
#	define MoreAssert(x) (true)
#	define MoreAssertQ(x)
#endif
