#ifndef __AEUTILS__
#define __AEUTILS__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef __WINDOWS__
#include <Windows.h>
#endif

void			DoHighLevelEvent(EventRecord *event);
	/* Simply calls AEProcessAppleEvent and reports any errors.
	** AEProcessAppleEvent looks in its table of registered events and sees if
	** the current event is registered.  If so, off we go. */

OSErr			GetTargetInfo(AEAddressDesc targetDesc, StringPtr zone, StringPtr machine,
							  StringPtr application);
	/* This function returns the zone, machine, and application name for the
	** indicated target descriptor. */

OSErr			MakeTarget(AEAddressDesc *target, Boolean sendDirect, short replyMode, Str255 prompt,
						   Str255 applListLabel, PPCFilterUPP portFilter, char *theLocNBPType);
	/* Creates a TargetID.
	**
	** If sendDirect is TRUE, the target is specified by setting a
	** ProcessSerialNumber to kCurrentProcess.  This has the advantage of sending
	** the message directly to ourselves, bypassing ePPC and gaining about a 10-15x
	** speed improvement.  If sendDirect is FALSE, we see if we have the
	** PPCToolBox.  If not, then we are forced to do a direct send.  If we do have
	** the PPCToolbox, then we call PPCBrowser.  We then look at the reply, and
	** factor in the mode we are going to use in AESend.  If that mode is
	** kAEWaitReply and the user selected us as the target, we have to turn that
	** into a direct send.  This is because the AppleEvent Manager will otherwise
	** post the event as a high-level event.  However, we are busy waiting for a
	** reply, not looking for events, so we'll hang.  We avoid this by forcing a
	** direct send. */

Boolean			MissedAnyParameters(AppleEvent *message);
	/* Used to check for any unread required parameters. Returns true if we
	** missed at least one. */

void			NotifyCancel(void);

void			NotifyUser(void);


#endif

