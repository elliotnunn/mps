{
     File:       JManager.p
 
     Contains:   Routines that can be used to invoke the Java Virtual Machine in MRJ
 
     Version:    Technology: MRJ 2.1
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1996-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT JManager;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __JMANAGER__}
{$SETC __JMANAGER__ := 1}

{$I+}
{$SETC JManagerIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __DRAG__}
{$I Drag.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}
{$IFC UNDEFINED __CODEFRAGMENTS__}
{$I CodeFragments.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kJMVersion					= $11800007;					{  using Sun's 1.1.8 APIs, our rev 7 APIs.  }
	kDefaultJMTime				= $00000400;					{  how much time to give the JM library on "empty" events, in milliseconds.  }

	kJMVersionError				= -60000;
	kJMExceptionOccurred		= -60001;
	kJMBadClassPathError		= -60002;

	{	
	 * Special codes for JMFrameKey, JMFrameKeyRelease:
	 *
	 * When your app notices that a modifiers is pressed (must be done by polling,
	 * unless Mac OS changes to support sending modifiers as events)
	 * you should notify the runtime using JMFrameKey, JMFrameKeyRelease, using
	 * these constants for asciiChar and keyCode.  This will allow the AWT to
	 * synthesize the appropriate events
	 	}
	kModifierAsciiChar			= 0;
	kModifierKeyCode			= 0;

	{	
	 *  Private data structures
	 *
	 *  JMClientData        - enough bits to reliably store a pointer to arbitrary, client-specific data. 
	 *  JMSessionRef        - references the entire java runtime 
	 *  JMTextRef           - a Text string, length, and encoding 
	 *  JMTextEncoding      - which encoding to use when converting in and out of Java strings.
	 *  JMFrameRef          - a java frame 
	 *  JMAWTContextRef     - a context for the AWT to request frames, process events 
	 *  JMAppletLocatorRef  - a device for locating, fetching, and parsing URLs that may contain applets 
	 *  JMAppletViewerRef   - an object that displays applets in a Frame 
	 *  JMAppletPageRef     - a way to group JMAWTContextRef's so they share the same class loader
	 	}

TYPE
	JMClientData						= Ptr;
	JMSessionRef    = ^LONGINT; { an opaque 32-bit type }
	JMSessionRefPtr = ^JMSessionRef;  { when a VAR xx:JMSessionRef parameter can be nil, it is changed to xx: JMSessionRefPtr }
	JMFrameRef    = ^LONGINT; { an opaque 32-bit type }
	JMFrameRefPtr = ^JMFrameRef;  { when a VAR xx:JMFrameRef parameter can be nil, it is changed to xx: JMFrameRefPtr }
	JMTextRef    = ^LONGINT; { an opaque 32-bit type }
	JMTextRefPtr = ^JMTextRef;  { when a VAR xx:JMTextRef parameter can be nil, it is changed to xx: JMTextRefPtr }
	JMAWTContextRef    = ^LONGINT; { an opaque 32-bit type }
	JMAWTContextRefPtr = ^JMAWTContextRef;  { when a VAR xx:JMAWTContextRef parameter can be nil, it is changed to xx: JMAWTContextRefPtr }
	JMAppletLocatorRef    = ^LONGINT; { an opaque 32-bit type }
	JMAppletLocatorRefPtr = ^JMAppletLocatorRef;  { when a VAR xx:JMAppletLocatorRef parameter can be nil, it is changed to xx: JMAppletLocatorRefPtr }
	JMAppletViewerRef    = ^LONGINT; { an opaque 32-bit type }
	JMAppletViewerRefPtr = ^JMAppletViewerRef;  { when a VAR xx:JMAppletViewerRef parameter can be nil, it is changed to xx: JMAppletViewerRefPtr }
	JMAppletPageRef    = ^LONGINT; { an opaque 32-bit type }
	JMAppletPageRefPtr = ^JMAppletPageRef;  { when a VAR xx:JMAppletPageRef parameter can be nil, it is changed to xx: JMAppletPageRefPtr }
	JMTextEncoding						= TextEncoding;

	{	
	 * The runtime requires certain callbacks be used to communicate between
	 * session events and the embedding application.
	 *
	 * In general, you can pass nil as a callback and a "good" default will be used.
	 *
	 *  JMConsoleProcPtr        - redirect stderr or stdout - the message is delivered in the encoding specified when
	 *                              you created the session, or possibly binary data.
	 *  JMConsoleReadProcPtr    - take input from the user from a console or file.  The input is expected to 
	 *                              be in the encoding specified when you opened the session.
	 *  JMExitProcPtr           - called via System.exit(int), return "true" to kill the current thread,
	 *                              false, to cause a 'QUIT' AppleEvent to be sent to the current process,
	 *                              or just tear down the runtime and exit to shell immediately
	 * JMLowMemoryProcPtr       - This callback is available to notify the embedding application that
	 *                              a low memory situation has occurred so it can attempt to recover appropriately.
	 * JMAuthenicateURLProcPtr  - prompt the user for autentication based on the URL.  If you pass
	 *                              nil, JManager will prompt the user.  Return false if the user pressed cancel.
	 	}
{$IFC TYPED_FUNCTION_POINTERS}
	JMConsoleProcPtr = PROCEDURE(session: JMSessionRef; message: UNIV Ptr; messageLengthInBytes: SInt32); C;
{$ELSEC}
	JMConsoleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMConsoleReadProcPtr = FUNCTION(session: JMSessionRef; buffer: UNIV Ptr; maxBufferLength: SInt32): SInt32; C;
{$ELSEC}
	JMConsoleReadProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMExitProcPtr = FUNCTION(session: JMSessionRef; status: SInt32): BOOLEAN; C;
{$ELSEC}
	JMExitProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMAuthenticateURLProcPtr = FUNCTION(session: JMSessionRef; url: ConstCStringPtr; realm: ConstCStringPtr; VAR userName: CHAR; VAR password: CHAR): BOOLEAN; C;
{$ELSEC}
	JMAuthenticateURLProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMLowMemoryProcPtr = PROCEDURE(session: JMSessionRef); C;
{$ELSEC}
	JMLowMemoryProcPtr = ProcPtr;
{$ENDC}

	JMSessionCallbacksPtr = ^JMSessionCallbacks;
	JMSessionCallbacks = RECORD
		fVersion:				UInt32;									{  should be set to kJMVersion  }
		fStandardOutput:		JMConsoleProcPtr;						{  JM will route "stdout" to this function.  }
		fStandardError:			JMConsoleProcPtr;						{  JM will route "stderr" to this function.  }
		fStandardIn:			JMConsoleReadProcPtr;					{  read from console - can be nil for default behavior (no console IO)  }
		fExitProc:				JMExitProcPtr;							{  handle System.exit(int) requests  }
		fAuthenticateProc:		JMAuthenticateURLProcPtr;				{  present basic authentication dialog  }
		fLowMemProc:			JMLowMemoryProcPtr;						{  Low Memory notification Proc  }
	END;

	JMVerifierOptions 			= SInt32;
CONST
	eDontCheckCode				= 0;
	eCheckRemoteCode			= 1;
	eCheckAllCode				= 2;


	{	
	 * JMRuntimeOptions is a mask that allows you to specify certain attributes
	 * for the runtime. Bitwise or the fields together, or use one of the "premade" entries.
	 * eJManager2Defaults is the factory default, and best bet to use.
	 	}

TYPE
	JMRuntimeOptions 			= SInt32;
CONST
	eJManager2Defaults			= 0;
	eUseAppHeapOnly				= $01;
	eDisableJITC				= $02;
	eEnableDebugger				= $04;
	eDisableInternetConfig		= $08;
	eInhibitClassUnloading		= $10;
	eEnableProfiling			= $20;
	eJManager1Compatible		= $18;




	{	
	 * Returns the version of the currently installed JManager library.
	 * Compare to kJMVersion.  This is the only call that doesn't
	 * require a session, or a reference to something that references
	 * a session.
	 	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  JMGetVersion()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in JManager 2.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION JMGetVersion: UInt32; C;

{
 * Returns the version number of the MRJ installation.  This is an
 * official version number that will change for each official release
 * of MRJ, whereas for an incremental MRJ release, the version number
 * returned by JMGetVersion may not change.
 }
{
 *  JMGetMRJRuntimeVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMGetMRJRuntimeVersion: UInt32; C;

{
 * JMOpenSession creates a new Java Runtime.  Note that JManger 2.0 doesn't set 
 * security options at the time of runtime instantiation.  AppletViewer Objecs have
 * seperate security attributes bound to them, and the verifier is availiable elsewhere
 * as well.  The client data parameter lets a client associate an arbitgrary tagged pointer
 * with the seession.
 * When you create the session, you must specify the desired Text Encoding to use for
 * console IO.  Usually, its OK to use "kTextEncodingMacRoman".  See TextCommon.h for the list.
 }
{
 *  JMOpenSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMOpenSession(VAR session: JMSessionRef; runtimeOptions: JMRuntimeOptions; verifyMode: JMVerifierOptions; {CONST}VAR callbacks: JMSessionCallbacks; desiredEncoding: JMTextEncoding; data: JMClientData): OSStatus; C;

{
 *  JMCloseSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMCloseSession(session: JMSessionRef): OSStatus; C;


{
 * Client data getter/setter functions.
 }
{
 *  JMGetSessionData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMGetSessionData(session: JMSessionRef; VAR data: JMClientData): OSStatus; C;

{
 *  JMSetSessionData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMSetSessionData(session: JMSessionRef; data: JMClientData): OSStatus; C;


{
 * Prepend the target of the FSSpec to the class path.
 * If a file, .zip or other known archive file - not a .class file
 }
{
 *  JMAddToClassPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMAddToClassPath(session: JMSessionRef; {CONST}VAR spec: FSSpec): OSStatus; C;


{
 * Utility returns (client owned) null terminated handle containing "file://xxxx", or nil if fnfErr
 }
{
 *  JMFSSToURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMFSSToURL(session: JMSessionRef; {CONST}VAR spec: FSSpec): Handle; C;


{
 * Turns "file:///disk/file" into an FSSpec.  other handlers return paramErr
 }
{
 *  JMURLToFSS()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMURLToFSS(session: JMSessionRef; urlString: JMTextRef; VAR spec: FSSpec): OSStatus; C;


{
 * JMIdle gives time to all Java threads. Giving more time makes Java programs run faster,
 * but can reduce overall system responsiveness. JMIdle will return sooner if low-level (user)
 * events appear in the event queue.
 }
{
 *  JMIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMIdle(session: JMSessionRef; jmTimeMillis: UInt32): OSStatus; C;


{$ENDC}  {CALL_NOT_IN_CARBON}

{
 * Java defines system-wide properties that applets can use to make queries about the
 * host system. Many of these properties correspond to defaults provided by "Internet Config."
 * JMPutSessionProperty can be used by a client program to modify various system-wide properties.
 }
{$IFC CALL_NOT_IN_CARBON }
{
 *  JMGetSessionProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMGetSessionProperty(session: JMSessionRef; propertyName: JMTextRef; VAR propertyValue: JMTextRef): OSStatus; C;

{
 *  JMPutSessionProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMPutSessionProperty(session: JMSessionRef; propertyName: JMTextRef; propertyValue: JMTextRef): OSStatus; C;


{$ENDC}  {CALL_NOT_IN_CARBON}

{
 * JMText: opaque object that encapsulates a string, length, and
 * character encoding.  Strings passed between JManager and the
 * embedding application goes through this interface.  Only the most
 * rudimentary conversion routines are supplied - it is expected that
 * the embedding application will most of its work in the System Script.
 *
 * These APIs present some questions about who actually owns the 
 * JMText.  The rule is, if you created a JMTextRef, you are responsible
 * for deleting it after passing it into the runtime.  If the runtime passes
 * one to you, it will be deleted after the callback.
 *
 * If a pointer to an uninitialised JMTextRef is passed in to a routine (eg JMGetSessionProperty),
 * it is assumed to have been created for the caller, and it is the callers responsibility to
 * dispose of it.
 *
 * The encoding types are taken verbatim from the Text Encoding Converter,
 * which handles the ugly backside of script conversion.
 }
{
 * JMNewTextRef can create from a buffer of data in the specified encoding
 }
{$IFC CALL_NOT_IN_CARBON }
{
 *  JMNewTextRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMNewTextRef(session: JMSessionRef; VAR textRef: JMTextRef; encoding: JMTextEncoding; charBuffer: UNIV Ptr; bufferLengthInBytes: UInt32): OSStatus; C;


{
 * JMCopyTextRef clones a text ref.
 }
{
 *  JMCopyTextRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMCopyTextRef(textRefSrc: JMTextRef; VAR textRefDst: JMTextRef): OSStatus; C;


{
 * Disposes of a text ref passed back from the runtime, or created explicitly through JMNewTextRef
 }
{
 *  JMDisposeTextRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMDisposeTextRef(textRef: JMTextRef): OSStatus; C;


{
 * Returns the text length, in characters
 }
{
 *  JMGetTextLength()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMGetTextLength(textRef: JMTextRef; VAR textLengthInCharacters: UInt32): OSStatus; C;


{
 * Returns the text length, in number of bytes taken in the destination encoding
 }
{
 *  JMGetTextLengthInBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMGetTextLengthInBytes(textRef: JMTextRef; dstEncoding: JMTextEncoding; VAR textLengthInBytes: UInt32): OSStatus; C;


{
 * Copies the specified number of characters to the destination buffer with the appropriate
 * destination encoding.
 }
{
 *  JMGetTextBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMGetTextBytes(textRef: JMTextRef; dstEncoding: JMTextEncoding; textBuffer: UNIV Ptr; textBufferLength: UInt32; VAR numCharsCopied: UInt32): OSStatus; C;


{$ENDC}  {CALL_NOT_IN_CARBON}

{
 * Returns a Handle to a null terminated, "C" string in the System Script.
 * Note that using this routine could result in data loss, if the characters
 * are not availiable in the System Script.
 }
{$IFC CALL_NOT_IN_CARBON }
{
 *  JMTextToMacOSCStringHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMTextToMacOSCStringHandle(textRef: JMTextRef): Handle; C;




{
 * Proxy properties in the runtime.
 *
 * These will only be checked if InternetConfig isn't used to specify properties,
 * or if it doesn't have the data for these.
 }
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	JMProxyInfoPtr = ^JMProxyInfo;
	JMProxyInfo = RECORD
		useProxy:				BOOLEAN;
		proxyHost:				PACKED ARRAY [0..254] OF CHAR;
		proxyPort:				UInt16;
	END;

	JMProxyType 				= SInt32;
CONST
	eHTTPProxy					= 0;
	eFirewallProxy				= 1;
	eFTPProxy					= 2;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  JMGetProxyInfo()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in JManager 2.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION JMGetProxyInfo(session: JMSessionRef; proxyType: JMProxyType; VAR proxyInfo: JMProxyInfo): OSStatus; C;

{
 *  JMSetProxyInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMSetProxyInfo(session: JMSessionRef; proxyType: JMProxyType; {CONST}VAR proxyInfo: JMProxyInfo): OSStatus; C;


{
 * Security - JManager 2.0 security is handled on a per-applet basis.
 * There are some security settings that are inherited from InternetConfig
 * (Proxy Servers) but the verifier can now be enabled and disabled.
 }
{
 *  JMGetVerifyMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMGetVerifyMode(session: JMSessionRef; VAR verifierOptions: JMVerifierOptions): OSStatus; C;

{
 *  JMSetVerifyMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMSetVerifyMode(session: JMSessionRef; verifierOptions: JMVerifierOptions): OSStatus; C;




{
 * The basic unit of AWT interaction is the JMFrame.  A JMFrame is bound to top level
 * awt Frame, Window, or Dialog.  When a user event occurs for a MacOS window, the event is passed
 * to the corrosponding frame object.  Similarly, when an AWT event occurs that requires the
 * Mac OS Window to change, a callback is made.  JManager 1.x bound the frame to the window through
 * a callback to set and restore the windows GrafPort.  In JManager 2.0, a GrafPort, Offset, and 
 * ClipRgn are specified up front - changes in visibility and structure require that these be re-set.
 * This enables support for the JavaSoft DrawingSurface API - and also improves graphics performance.
 * You should reset the graphics attributes anytime the visiblity changes, like when scrolling.
 * You should also set it initially when the AWTContext requests the frame.
 * At various times, JM will call back to the client to register a new JMFrame, 
 * indicating the frame type.  The client should take the following steps:
 *
 *  o   Create a new invisible window of the specified type
 *  o   Fill in the callbacks parameter with function pointers
 *  o   Do something to bind the frame to the window (like stuff the WindowPtr in the JMClientData of the frame)
 *  o   Register the visiblity parameters (GrafPtr, etc) with the frame
 }
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	ReorderRequest 				= SInt32;
CONST
	eBringToFront				= 0;							{  bring the window to front  }
	eSendToBack					= 1;							{  send the window to back  }
	eSendBehindFront			= 2;							{  send the window behind the front window  }


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	JMSetFrameSizeProcPtr = PROCEDURE(frame: JMFrameRef; {CONST}VAR newBounds: Rect); C;
{$ELSEC}
	JMSetFrameSizeProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMFrameInvalRectProcPtr = PROCEDURE(frame: JMFrameRef; {CONST}VAR r: Rect); C;
{$ELSEC}
	JMFrameInvalRectProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMFrameShowHideProcPtr = PROCEDURE(frame: JMFrameRef; showFrameRequested: BOOLEAN); C;
{$ELSEC}
	JMFrameShowHideProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMSetTitleProcPtr = PROCEDURE(frame: JMFrameRef; title: JMTextRef); C;
{$ELSEC}
	JMSetTitleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMCheckUpdateProcPtr = PROCEDURE(frame: JMFrameRef); C;
{$ELSEC}
	JMCheckUpdateProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMReorderFrame = PROCEDURE(frame: JMFrameRef; theRequest: ReorderRequest); C;
{$ELSEC}
	JMReorderFrame = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMSetResizeable = PROCEDURE(frame: JMFrameRef; resizeable: BOOLEAN); C;
{$ELSEC}
	JMSetResizeable = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMGetFrameInsets = PROCEDURE(frame: JMFrameRef; VAR insets: Rect); C;
{$ELSEC}
	JMGetFrameInsets = ProcPtr;
{$ENDC}

	{	
	 * New in JManager 2.1:
	 *  If the AWT needs to set focus to a frame (in the case of multiple JMFrames within
	 *  a single Mac OS Frame) it will call back to the embedding application using
	 *  JMRRequestFocus.  The application should then defocus what it thought did have the
	 *  focus, and set the focus to the new frame.
	 *  If the user is tabbing within a JMFrame, and the focus reaches the last focusable
	 *  component (or the first, if focus is traversing backwards) JMNexetFocus will be called.
	 *  The application should defocus the component that requests this, and focus the next application
	 *  visible focusable element.  (If none, send focus back to the frame.)
	 	}
{$IFC TYPED_FUNCTION_POINTERS}
	JMNextFocus = PROCEDURE(frame: JMFrameRef; forward: BOOLEAN); C;
{$ELSEC}
	JMNextFocus = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMRequestFocus = PROCEDURE(frame: JMFrameRef); C;
{$ELSEC}
	JMRequestFocus = ProcPtr;
{$ENDC}

	JMFrameCallbacksPtr = ^JMFrameCallbacks;
	JMFrameCallbacks = RECORD
		fVersion:				UInt32;									{  should be set to kJMVersion  }
		fSetFrameSize:			JMSetFrameSizeProcPtr;
		fInvalRect:				JMFrameInvalRectProcPtr;
		fShowHide:				JMFrameShowHideProcPtr;
		fSetTitle:				JMSetTitleProcPtr;
		fCheckUpdate:			JMCheckUpdateProcPtr;
		fReorderFrame:			JMReorderFrame;
		fSetResizeable:			JMSetResizeable;
		fGetInsets:				JMGetFrameInsets;
		fNextFocus:				JMNextFocus;
		fRequestFocus:			JMRequestFocus;
	END;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  JMSetFrameVisibility()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in JManager 2.1 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION JMSetFrameVisibility(frame: JMFrameRef; famePort: GrafPtr; frameOrigin: Point; frameClip: RgnHandle): OSStatus; C;

{
 *  JMGetFrameData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMGetFrameData(frame: JMFrameRef; VAR data: JMClientData): OSStatus; C;

{
 *  JMSetFrameData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMSetFrameData(frame: JMFrameRef; data: JMClientData): OSStatus; C;

{
 *  JMGetFrameSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMGetFrameSize(frame: JMFrameRef; VAR result: Rect): OSStatus; C;

{ note that the top left indicates the "global" position of this frame }
{ use this to update the frame position when it gets moved }
{
 *  JMSetFrameSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMSetFrameSize(frame: JMFrameRef; {CONST}VAR newSize: Rect): OSStatus; C;

{
 * Dispatch a particular event to an embedded frame
 }
{
 *  JMFrameClickWithEventRecord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMFrameClickWithEventRecord(frame: JMFrameRef; localPos: Point; {CONST}VAR event: EventRecord): OSStatus; C;

{
 *  JMFrameKey()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMFrameKey(frame: JMFrameRef; asciiChar: ByteParameter; keyCode: ByteParameter; modifiers: INTEGER): OSStatus; C;

{
 *  JMFrameKeyRelease()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMFrameKeyRelease(frame: JMFrameRef; asciiChar: ByteParameter; keyCode: ByteParameter; modifiers: INTEGER): OSStatus; C;

{
 *  JMFrameUpdate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMFrameUpdate(frame: JMFrameRef; updateRgn: RgnHandle): OSStatus; C;

{
 *  JMFrameActivate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMFrameActivate(frame: JMFrameRef; activate: BOOLEAN): OSStatus; C;

{
 *  JMFrameResume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMFrameResume(frame: JMFrameRef; resume: BOOLEAN): OSStatus; C;

{
 *  JMFrameMouseOver()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMFrameMouseOver(frame: JMFrameRef; localPos: Point; modifiers: INTEGER): OSStatus; C;

{
 *  JMFrameShowHide()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMFrameShowHide(frame: JMFrameRef; showFrame: BOOLEAN): OSStatus; C;

{
 *  JMFrameGoAway()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMFrameGoAway(frame: JMFrameRef): OSStatus; C;

{
 *  JMGetFrameContext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMGetFrameContext(frame: JMFrameRef): JMAWTContextRef; C;

{
 *  JMFrameDragTracking()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMFrameDragTracking(frame: JMFrameRef; message: DragTrackingMessage; theDragRef: DragReference): OSStatus; C;

{
 *  JMFrameDragReceive()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMFrameDragReceive(frame: JMFrameRef; theDragRef: DragReference): OSStatus; C;

{
 * JMFrameClick is deprecated - please use JMFrameClickWithEventRecord instead.
 }
{
 *  JMFrameClick()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMFrameClick(frame: JMFrameRef; localPos: Point; modifiers: INTEGER): OSStatus; C;

{
 * If you may have multiple JMFrames in a single Mac OS Window (for example,
 * in a browser) then use JMFrameFocus to control when you believe the
 * frame should logically contain the focus.  This will allow for the correct
 * appearance of Controls and Text Fields.  If you will only have one
 * JMFrame per Mac OS Window, use JMFrameFocus as well as JMFrameActivate to
 * control hiliting.
 }
{
 *  JMFrameFocus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMFrameFocus(frame: JMFrameRef; gotFocus: BOOLEAN): OSStatus; C;

{
 * Cause a Frame and its contents to be rendered in a GrafPort.
 * This is typically going to be used to cause an applet to print itself
 * into a PrGrafPort.
 * If you pass 'true' as the last parameter, the paint(Graphics) method of the
 * frame is called, rather than print(Graphics).
 }
{
 *  JMDrawFrameInPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMDrawFrameInPort(frame: JMFrameRef; framePort: GrafPtr; frameOrigin: Point; clipRgn: RgnHandle; callPaintAsOpposedToPrint: BOOLEAN): OSStatus; C;

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 * Window types
 }

TYPE
	JMFrameKind 				= SInt32;
CONST
	eBorderlessModelessWindowFrame = 0;
	eModelessWindowFrame		= 1;
	eModalWindowFrame			= 2;
	eModelessDialogFrame		= 3;


	{	 JMAppletPageRef -
	 * Creating a "page" is optional. 
	 * Applets will share the same class loader (and thus static variables) iff
	 * they are share the same JMAppletPageRef and have the same codebase.
	 	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  JMNewAppletPage()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in JManager 2.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION JMNewAppletPage(VAR page: JMAppletPageRef; session: JMSessionRef): OSStatus; C;

{
 *  JMDisposeAppletPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMDisposeAppletPage(page: JMAppletPageRef): OSStatus; C;



{ JMAWTContext -
 * To create a top level frame, you must use a JMAWTContext object.
 * The JMAWTContext provides a context for the AWT to request frames.
 * A AWTContext has a threadgroup associated with it - all events and processing occurs
 * there.  When you create one, it is quiescent, you must call resume before it begins executing.
 }
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	JMRequestFrameProcPtr = FUNCTION(context: JMAWTContextRef; newFrame: JMFrameRef; kind: JMFrameKind; {CONST}VAR initialBounds: Rect; resizeable: BOOLEAN; VAR callbacks: JMFrameCallbacks): OSStatus; C;
{$ELSEC}
	JMRequestFrameProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMReleaseFrameProcPtr = FUNCTION(context: JMAWTContextRef; oldFrame: JMFrameRef): OSStatus; C;
{$ELSEC}
	JMReleaseFrameProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMUniqueMenuIDProcPtr = FUNCTION(context: JMAWTContextRef; isSubmenu: BOOLEAN): SInt16; C;
{$ELSEC}
	JMUniqueMenuIDProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMExceptionOccurredProcPtr = PROCEDURE(context: JMAWTContextRef; exceptionName: JMTextRef; exceptionMsg: JMTextRef; stackTrace: JMTextRef); C;
{$ELSEC}
	JMExceptionOccurredProcPtr = ProcPtr;
{$ENDC}

	JMAWTContextCallbacksPtr = ^JMAWTContextCallbacks;
	JMAWTContextCallbacks = RECORD
		fVersion:				UInt32;									{  should be set to kJMVersion  }
		fRequestFrame:			JMRequestFrameProcPtr;					{  a new frame is being created.  }
		fReleaseFrame:			JMReleaseFrameProcPtr;					{  an existing frame is being destroyed.  }
		fUniqueMenuID:			JMUniqueMenuIDProcPtr;					{  a new menu will be created with this id.  }
		fExceptionOccurred:		JMExceptionOccurredProcPtr;				{  just some notification that some recent operation caused an exception.  You can't do anything really from here.  }
	END;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  JMNewAWTContext()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in JManager 2.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION JMNewAWTContext(VAR context: JMAWTContextRef; session: JMSessionRef; {CONST}VAR callbacks: JMAWTContextCallbacks; data: JMClientData): OSStatus; C;

{
 *  JMNewAWTContextInPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMNewAWTContextInPage(VAR context: JMAWTContextRef; session: JMSessionRef; page: JMAppletPageRef; {CONST}VAR callbacks: JMAWTContextCallbacks; data: JMClientData): OSStatus; C;

{
 *  JMDisposeAWTContext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMDisposeAWTContext(context: JMAWTContextRef): OSStatus; C;

{
 *  JMGetAWTContextData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMGetAWTContextData(context: JMAWTContextRef; VAR data: JMClientData): OSStatus; C;

{
 *  JMSetAWTContextData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMSetAWTContextData(context: JMAWTContextRef; data: JMClientData): OSStatus; C;

{
 *  JMCountAWTContextFrames()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMCountAWTContextFrames(context: JMAWTContextRef; VAR frameCount: UInt32): OSStatus; C;

{
 *  JMGetAWTContextFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMGetAWTContextFrame(context: JMAWTContextRef; frameIndex: UInt32; VAR frame: JMFrameRef): OSStatus; C;

{
 * Starting in MRJ 2.1, JMMenuSelected is deprecated.  Please use JMMenuSelectedWithModifiers instead.
 }
{
 *  JMMenuSelected()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMMenuSelected(context: JMAWTContextRef; hMenu: MenuRef; menuItem: INTEGER): OSStatus; C;

{
 * Starting in MRJ 2.1, this call takes an additional 'modifiers' parameter that you can get
 * from your event record.
 }
{
 *  JMMenuSelectedWithModifiers()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMMenuSelectedWithModifiers(context: JMAWTContextRef; hMenu: MenuRef; menuItem: INTEGER; modifiers: INTEGER): OSStatus; C;

{$ENDC}  {CALL_NOT_IN_CARBON}



{
 * JMAppletLocator - Since Java applets are always referenced by a Uniform Resource Locator
 * (see RFC 1737, http://www.w3.org/pub/WWW/Addressing/rfc1738.txt), we provide an object
 * that encapsulates the information about a set of applets. A JMAppletLocator is built
 * by providing a base URL, which must point at a valid HTML document containing applet
 * tags. To save a network transaction, the contents of the document may be passed optionally. 
 *
 * You can also use a JMLocatorInfoBlock for a synchronous resolution of the applet,
 * assuming that you already have the info for the tag.
 }

TYPE
	JMLocatorErrors 			= SInt32;
CONST
	eLocatorNoErr				= 0;							{  the html was retrieved successfully }
	eHostNotFound				= 1;							{  the host specified by the url could not be found }
	eFileNotFound				= 2;							{  the file could not be found on the host }
	eLocatorTimeout				= 3;							{  a timeout occurred retrieving the html text }
	eLocatorKilled				= 4;							{  in response to a JMDisposeAppletLocator before it has completed }


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	JMFetchCompleted = PROCEDURE(ref: JMAppletLocatorRef; status: JMLocatorErrors); C;
{$ELSEC}
	JMFetchCompleted = ProcPtr;
{$ENDC}

	JMAppletLocatorCallbacksPtr = ^JMAppletLocatorCallbacks;
	JMAppletLocatorCallbacks = RECORD
		fVersion:				UInt32;									{  should be set to kJMVersion  }
		fCompleted:				JMFetchCompleted;						{  called when the html has been completely fetched  }
	END;

	{	
	 * These structures are used to pass pre-parsed parameter
	 * tags to the AppletLocator.  Implies synchronous semantics.
	 	}

	JMLIBOptionalParamsPtr = ^JMLIBOptionalParams;
	JMLIBOptionalParams = RECORD
		fParamName:				JMTextRef;								{  could be from a <parameter name=foo value=bar> or "zipbase", etc  }
		fParamValue:			JMTextRef;								{  the value of this optional tag  }
	END;

	JMLocatorInfoBlockPtr = ^JMLocatorInfoBlock;
	JMLocatorInfoBlock = RECORD
		fVersion:				UInt32;									{  should be set to kJMVersion  }
																		{  These are required to be present and not nil  }
		fBaseURL:				JMTextRef;								{  the URL of this applet's host page  }
		fAppletCode:			JMTextRef;								{  code= parameter  }
		fWidth:					INTEGER;								{  width= parameter  }
		fHeight:				INTEGER;								{  height= parameter  }
																		{  These are optional parameters  }
		fOptionalParameterCount: SInt32;								{  how many in this array  }
		fParams:				JMLIBOptionalParamsPtr;					{  pointer to an array of these (points to first element)  }
	END;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  JMNewAppletLocator()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in JManager 2.1 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION JMNewAppletLocator(VAR locatorRef: JMAppletLocatorRef; session: JMSessionRef; {CONST}VAR callbacks: JMAppletLocatorCallbacks; url: JMTextRef; htmlText: JMTextRef; data: JMClientData): OSStatus; C;

{
 *  JMNewAppletLocatorFromInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMNewAppletLocatorFromInfo(VAR locatorRef: JMAppletLocatorRef; session: JMSessionRef; {CONST}VAR info: JMLocatorInfoBlock; data: JMClientData): OSStatus; C;

{
 *  JMDisposeAppletLocator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMDisposeAppletLocator(locatorRef: JMAppletLocatorRef): OSStatus; C;

{
 *  JMGetAppletLocatorData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMGetAppletLocatorData(locatorRef: JMAppletLocatorRef; VAR data: JMClientData): OSStatus; C;

{
 *  JMSetAppletLocatorData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMSetAppletLocatorData(locatorRef: JMAppletLocatorRef; data: JMClientData): OSStatus; C;

{
 *  JMCountApplets()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMCountApplets(locatorRef: JMAppletLocatorRef; VAR appletCount: UInt32): OSStatus; C;

{
 *  JMGetAppletDimensions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMGetAppletDimensions(locatorRef: JMAppletLocatorRef; appletIndex: UInt32; VAR width: UInt32; VAR height: UInt32): OSStatus; C;

{
 *  JMGetAppletTag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMGetAppletTag(locatorRef: JMAppletLocatorRef; appletIndex: UInt32; VAR tagRef: JMTextRef): OSStatus; C;

{
 *  JMGetAppletName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMGetAppletName(locatorRef: JMAppletLocatorRef; appletIndex: UInt32; VAR nameRef: JMTextRef): OSStatus; C;


{
 * JMAppletViewer - Applets are instantiated, one by one, by specifying a JMAppletLocator and
 * a zero-based index (Macintosh API's usually use one-based indexing, the Java language
 * uses zero, however.). The resulting applet is encapsulated in a JMAppletViewer object. 
 * Since applets can have one or more visible areas to draw in, one or more JMFrame objects
 * may be requested while the viewer is being created, or at a later time, thus the client
 * must provide callbacks to satisfy these requests.
 *
 * The window name for the ShowDocument callback is one of:
 *   _self      show in current frame
 *   _parent    show in parent frame
 *   _top       show in top-most frame
 *   _blank     show in new unnamed top-level window
 *   <other>    show in new top-level window named <other> 
 }
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	JMShowDocumentProcPtr = PROCEDURE(viewer: JMAppletViewerRef; urlString: JMTextRef; windowName: JMTextRef); C;
{$ELSEC}
	JMShowDocumentProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	JMSetStatusMsgProcPtr = PROCEDURE(viewer: JMAppletViewerRef; statusMsg: JMTextRef); C;
{$ELSEC}
	JMSetStatusMsgProcPtr = ProcPtr;
{$ENDC}

	JMAppletViewerCallbacksPtr = ^JMAppletViewerCallbacks;
	JMAppletViewerCallbacks = RECORD
		fVersion:				UInt32;									{  should be set to kJMVersion  }
		fShowDocument:			JMShowDocumentProcPtr;					{  go to a url, optionally in a new window  }
		fSetStatusMsg:			JMSetStatusMsgProcPtr;					{  applet changed status message  }
	END;

	{	
	 * NEW: per-applet security settings
	 * Previously, these settings were attached to the session.
	 * JManager 2.0 allows them to be attached to each viewer.
	 	}
	JMNetworkSecurityOptions 	= SInt32;
CONST
	eNoNetworkAccess			= 0;
	eAppletHostAccess			= 1;
	eUnrestrictedAccess			= 2;


TYPE
	JMFileSystemOptions 		= SInt32;
CONST
	eNoFSAccess					= 0;
	eLocalAppletAccess			= 1;
	eAllFSAccess				= 2;

	{	
	 * Lists of packages are comma separated,
	 * the default for mrj.security.system.access is
	 * "sun,netscape,com.apple".
	 	}


TYPE
	JMAppletSecurityPtr = ^JMAppletSecurity;
	JMAppletSecurity = RECORD
		fVersion:				UInt32;									{  should be set to kJMVersion  }
		fNetworkSecurity:		JMNetworkSecurityOptions;				{  can this applet access network resources  }
		fFileSystemSecurity:	JMFileSystemOptions;					{  can this applet access network resources  }
		fRestrictSystemAccess:	BOOLEAN;								{  restrict access to system packages (com.apple.*, sun.*, netscape.*) also found in the property "mrj.security.system.access"  }
		fRestrictSystemDefine:	BOOLEAN;								{  restrict classes from loading system packages (com.apple.*, sun.*, netscape.*) also found in the property "mrj.security.system.define"  }
		fRestrictApplicationAccess: BOOLEAN;							{  restrict access to application packages found in the property "mrj.security.application.access"  }
		fRestrictApplicationDefine: BOOLEAN;							{  restrict access to application packages found in the property "mrj.security.application.access"  }
	END;

	{	
	 * AppletViewer methods
	 	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  JMNewAppletViewer()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in JManager 2.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION JMNewAppletViewer(VAR viewer: JMAppletViewerRef; context: JMAWTContextRef; locatorRef: JMAppletLocatorRef; appletIndex: UInt32; {CONST}VAR security: JMAppletSecurity; {CONST}VAR callbacks: JMAppletViewerCallbacks; data: JMClientData): OSStatus; C;

{
 *  JMDisposeAppletViewer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMDisposeAppletViewer(viewer: JMAppletViewerRef): OSStatus; C;

{
 *  JMGetAppletViewerData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMGetAppletViewerData(viewer: JMAppletViewerRef; VAR data: JMClientData): OSStatus; C;

{
 *  JMSetAppletViewerData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMSetAppletViewerData(viewer: JMAppletViewerRef; data: JMClientData): OSStatus; C;


{
 * You can change the applet security on the fly
 }
{
 *  JMGetAppletViewerSecurity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMGetAppletViewerSecurity(viewer: JMAppletViewerRef; VAR data: JMAppletSecurity): OSStatus; C;

{
 *  JMSetAppletViewerSecurity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMSetAppletViewerSecurity(viewer: JMAppletViewerRef; {CONST}VAR data: JMAppletSecurity): OSStatus; C;


{
 * JMReloadApplet reloads viewer's applet from the source.
 * JMRestartApplet reinstantiates the applet without reloading.
 }
{
 *  JMReloadApplet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMReloadApplet(viewer: JMAppletViewerRef): OSStatus; C;

{
 *  JMRestartApplet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMRestartApplet(viewer: JMAppletViewerRef): OSStatus; C;


{
 * JMSuspendApplet tells the Java thread scheduler to stop executing the viewer's applet.
 * JMResumeApplet resumes execution of the viewer's applet.
 }
{
 *  JMSuspendApplet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMSuspendApplet(viewer: JMAppletViewerRef): OSStatus; C;

{
 *  JMResumeApplet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMResumeApplet(viewer: JMAppletViewerRef): OSStatus; C;


{ 
 * To get back to the JMAppletViewerRef instance from whence a frame came,
 * as well as the ultimate frame parent (the one created _for_ the applet viewer)
 }
{
 *  JMGetFrameViewer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMGetFrameViewer(frame: JMFrameRef; VAR viewer: JMAppletViewerRef; VAR parentFrame: JMFrameRef): OSStatus; C;

{
 * To get a ref back to the Frame that was created for this JMAppletViewerRef
 }
{
 *  JMGetViewerFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMGetViewerFrame(viewer: JMAppletViewerRef; VAR frame: JMFrameRef): OSStatus; C;

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 * Tell MRJ to add connID to its list of shared libraries used when searching for
 * JNI (and JRI) native methods. This is useful for overriding or redirecting
 * a java call to System.loadLibrary().  In particular System.loadLibrary()
 * does not reuse CFM connections to libraries already open by someone outside
 * of the java session.  It always forces its own private copy of a shared library 
 * to be opened.  This can result in multiple instances of the data/TOC section
 * of a shared library.  
 * Note: This function has no effect on JDirect based native methods.
 * If connID exports a function named "JNI_OnLoad", it is immediately called.
 * If javaShouldClose is true, MRJ will close the connection when the session is closed.
 * Returns false and does nothing if a library with that name is already registered.
 }
{$IFC CALL_NOT_IN_CARBON }
{
 *  JMRegisterLibrary()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in JManager 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION JMRegisterLibrary(session: JMSessionRef; libraryName: Str63; connID: CFragConnectionID; javaShouldClose: BOOLEAN): BOOLEAN; C;



{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := JManagerIncludes}

{$ENDC} {__JMANAGER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
