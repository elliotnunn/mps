/*
** Apple Macintosh Developer Technical Support
**
** File:	    speechmessage.c
** Written by:  Eric Soldan
**
** Copyright © 1990-1992 Apple Computer, Inc.
** All rights reserved.
*/



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __GESTALTEQU__
#include <GestaltEqu.h>
#endif

#ifndef __MEMORY__
#include <Memory.h>
#endif

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

#ifndef __TOOLUTILS__
#include <ToolUtils.h>
#endif

#ifndef __TEXTEDITCONTROL__
#include <TextEditControl.h>
#endif

#ifndef __UTILITIES__
#include <Utilities.h>
#endif



/*****************************************************************************/
/*****************************************************************************/

#include <Speech.h>

struct WordLimits {
	Boolean hilite;
	short	wordStart;
	short	wordEnd;
};
typedef struct WordLimits WordLimits;
typedef WordLimits *WordLimitsPtr;

pascal void	MyWordCallback(SpeechChannel sChannel, WordLimitsPtr wLP, long wordPos, short wordLen);



/*****************************************************************************/
/*****************************************************************************/



Boolean	SpeechAvailable(void)
{
	long	result;

	if (Gestalt(gestaltSpeechAttr, &result)) return (false);
	
	if (!(result & (1 << gestaltSpeechMgrPresent))) return(false);

	/*
	 * There isn't an equate to identify the PowerPC Speech Mgr. Lib
	 * When there is then change this conditional to #ifdef powerc
	 */
#if 0
	if (!(result & (1 << gestaltSpeechMgrLibPresent))) return(false);
#endif

	return(true);
}



/*****************************************************************************/



/* We will use the word call back to hilite the next word to be spoken. 
   The problem is that this proc is called at interrupt time and can not
   use something that moves memory, so here we only save the information and
   let the "while speechbusy loop do the actual hiliting.
*/

pascal void MyWordCallback(SpeechChannel sChannel, WordLimitsPtr wLP, long wordPos, short wordLen)
{
#pragma unused (sChannel)

	wLP->hilite = true;		/* flag that word needs hiliting */
	wLP->wordStart = wordPos;
	wLP->wordEnd = wordPos + wordLen;
}



/*****************************************************************************/



/* 	- Calls SpeakText.
	- Opens a speech channel,
	- holds until done
	- hilites the word being spoken
	- checks for command period
	- disposes of the channel.
*/

OSErr SayText(TEHandle teH, Handle txt, VoiceSpec theVoice)
{
	VoiceSpec		*voicePtr;
	WordLimits		wlimits;
	SpeechChannel	sChannel;
	KeyMap			kMap;
	TEHandle		oldActive;
	OSErr			err;
	Ptr				txtPtr;
	short			txtSiz, txtBeg, txtEnd;
	static SpeechWordUPP	myWordCallbackUPP = nil;

	voicePtr = (theVoice.creator) ? &theVoice : nil;

	if (!(err = NewSpeechChannel(voicePtr, &sChannel)) ) {
		SetSpeechInfo(sChannel, soRefCon, &wlimits);
		if (!myWordCallbackUPP)
			myWordCallbackUPP = NewSpeechWordProc(MyWordCallback);
		SetSpeechInfo(sChannel, soWordCallBack, myWordCallbackUPP);

		/* need to activate to let user see the highlited words as they are spoken. */

		if (teH)
			txt = (*teH)->hText;

		HLock(txt);
		txtPtr = *txt;
		txtSiz = GetHandleSize(txt);
		txtBeg = 0;
		if (teH) {
			txtBeg  = (*teH)->selStart;
			txtEnd  = (*teH)->selEnd;
			txtPtr += txtBeg;
			txtSiz -= txtBeg;
			CTESetSelect(0, 0, teH);
			oldActive = CTEFindActive(nil);
			CTEActivate(true, teH);
		}

		if (!(err = SpeakText(sChannel, *txt + txtBeg, txtSiz))) {

			while (SpeechBusy() > 0) { /* Need to wait until all stops */

				if (wlimits.hilite) {			/* first we check if word being spoken needs hiliting */
					if (teH)
						CTESetSelect(wlimits.wordStart + txtBeg, wlimits.wordEnd + txtBeg, teH);
					wlimits.hilite = false;		/* do it only once */
				}
				GetKeys(kMap);
				if ((kMap[1] == 0x808000) ){ /* user is tired of the long message */
					err = StopSpeech(sChannel);
					break;
				}
			}
		}
		HUnlock(txt);

		if (teH) {
			CTEActivate(false, teH); /* no more */
			CTEActivate(true, oldActive);
			CTESetSelect(txtBeg, txtEnd, teH);
		}

		SetSpeechInfo(sChannel, soWordCallBack, nil);
		err = DisposeSpeechChannel(sChannel);
	}

	return err;
}



