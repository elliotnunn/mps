{
     File:       AEMach.p
 
     Contains:   AppleEvent over mach_msg interfaces
 
     Version:    Technology: For Mac OS X
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
 UNIT AEMach;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __AEMACH__}
{$SETC __AEMACH__ := 1}

{$I+}
{$SETC AEMachIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __AEDATAMODEL__}
{$I AEDataModel.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{-
 * AE Mach API --
 *
 * AppleEvents on OS X are implemented in terms of mach messages.
 * To facilitate writing server processes that can send and receive
 * AppleEvents, the following APIs are provided.
 *
 * AppleEvents are directed to a well known port uniquely tied to a
 * process.  The AE framework will discover this port based on the
 * keyAddressAttr of the event (as specifed in AECreateAppleEvent by
 * the target parameter.)  If a port cannot be found,
 * procNotFound (-600) will be returned on AESend.
 *
 * Of note is a new attribute for an AppleEvent, typeReplyPortAttr.
 * This specifies the mach_port_t to which an AppleEvent reply
 * should be directed.  By default, replies are sent to the
 * processes registered port where they are culled from the normal  
 * event stream if there is an outstanding AESend + kAEWaitReply.
 * But it may be desirable for a client to specify their own port to
 * receive quued replies.
 * (In the case of AESendMessage with kAEWaitReply specified, an 
 * anonymous port will be used to block until the reply is received.)
 *
 * Not supplied is a convenience routine to block a server and
 * process AppleEvents.  This implementation will be detailed in a
 * tech note.
 *}

CONST
	typeReplyPortAttr			= 'repp';

{$IFC TARGET_RT_MAC_MACHO }
	{	-
	 * Return the mach_port_t that was registered with the bootstrap
	 * server for this process.  This port is considered public, and
	 * will be used by other applications to target your process.  You
	 * are free to use this mach_port_t to add to a port set, if and
	 * only if, you are not also using routines from HIToolbox.  In that
	 * case, HIToolbox retains control of this port and AppleEvents are
	 * dispatched through the main event loop.  
	 *	}
	{
	 *  AEGetRegisteredMachPort()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION AEGetRegisteredMachPort: mach_port_t; C;

{-
 * Decode a mach_msg into an AppleEvent and its related reply.  (The
 * reply is set up from fields of the event.)  You can call this
 * routine if you wish to dispatch or handle the event yourself.  To
 * return a reply to the sender, you should call:
 *
 *  AESendMessage(reply, NULL, kAENoReply, kAENormalPriority, kAEDefaultTimeout);
 *
 * The contents of the header are invalid after this call.  
 *}
{
 *  AEDecodeMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEDecodeMessage(VAR header: mach_msg_header_t; VAR event: AppleEvent; reply: AppleEventPtr): OSStatus; C;

{-
 * Decodes and dispatches an event to an event handler.  Handles
 * packaging and returning the reply to the sender.
 *
 * The contents of the header are invalid after this call.
 *}
{
 *  AEProcessMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEProcessMessage(VAR header: mach_msg_header_t): OSStatus; C;

{-
 * Send an AppleEvent to a target process.  If the target is the
 * current process (as specified by using typeProcessSerialNumber of
 * ( 0, kCurrentProcess ) it is dispatched directly to the
 * appropriate event handler in your process and not serialized.
 *}
{
 *  AESendMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AESendMessage({CONST}VAR event: AppleEvent; reply: AppleEventPtr; sendMode: AESendMode; timeOutInTicks: LONGINT): OSStatus; C;

{$ENDC}  {TARGET_RT_MAC_MACHO}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AEMachIncludes}

{$ENDC} {__AEMACH__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
