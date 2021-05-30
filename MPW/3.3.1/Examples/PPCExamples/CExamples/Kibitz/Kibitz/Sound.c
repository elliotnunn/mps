/*
** Apple Macintosh Developer Technical Support
**
** File:             sound.c
** Originally from:  SoundCdev by Jeremy Bornstein
** Modified by:      Eric Soldan
**
** Copyright © 1990-1992 Apple Computer, Inc.
** All rights reserved. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif

#ifndef __SOUND__
#include <Sound.h>
#endif

#ifndef __SOUNDINPUT__
#include <SoundInput.h>
#endif

#ifndef __UTILITIES__
#include <Utilities.h>
#endif



/*****************************************************************************/
/*****************************************************************************/



#pragma segment Main
OSErr	RecordSound(FileRecHndl frHndl)
{
	Handle	newSnd, oldSnd;
	OSErr	err;
	Point	corner = {50, 50};

	if (!(newSnd = NewHandle(31 * 1024))) return(memFullErr);

	err = SndRecord(nil, corner, siBetterQuality, &newSnd);

	if (!err) {
		if (oldSnd = (*frHndl)->doc.sound) DisposHandle(oldSnd);
		(*frHndl)->doc.sound = newSnd;
	}
	else DisposHandle(newSnd);

	return(err);
}



/*****************************************************************************/



/* SoundInputAvaliable
**
** Sound input is avaliable if there's a device registered… */

#pragma segment Main
Boolean SoundInputAvaliable(void)
{
	Boolean		siPresent;
	Handle		devIconHandle;
	Str255		devName;
	NumVersion	vers;
	
	siPresent = false;
	
	if (gSystemVersion >= 0x0700) {
		vers = SndSoundManagerVersion();
		if (vers.majorRev > 0) {
			if (SPBGetIndexedDevice(1, devName, &devIconHandle) == noErr) {
				DisposHandle(devIconHandle);
				siPresent = true;
			}
		}
	}

	return(siPresent);
}



