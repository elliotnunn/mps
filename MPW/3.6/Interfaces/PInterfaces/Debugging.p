{
     File:       Debugging.p
 
     Contains:   Macros to handle exceptions and assertions.
 
     Version:    Technology: Carbon
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1989-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Debugging;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DEBUGGING__}
{$SETC __DEBUGGING__ := 1}

{$I+}
{$SETC DebuggingIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}

{
  ______________________________________________________________________________________
                                                                                        
    This file defines standard exception handling and assertion macros for              
    system-level programming in C.  Originally used in QuickDraw GX, and heavily        
    modified since, these macros are used extensively throughout Mac OS system          
    software.  Now *you* can look and feel like a system software engineer.             
                                                                                        
    To activate debugger breaks, #define DEBUG to 1 (one) before including this file.   
    Five further levels of debugging are available, selected by #defining one           
    of the following conditionals to 1 after DEBUG is defined to 1.                     
                                                                                        
        DEBUG_INTERNAL      the default; includes file and line number information      
                                                                                        
        DEBUG_EXTERNAL      used for code which must ship to developers outside         
                            your organization; no file or line number information is    
                            included in asserts                                         
                                                                                        
        DEBUG_BREAK_ONLY    where an assertion would normally be sent to the debugger,      
                            send an empty string instead.                               
                                                                                        
        PRODUCTION          used for shipping code; no debugger breaks are emitted      
                                                                                        
        PERFORMANCE         same as PRODUCTION                                          
                                                                                        
    #defining DEBUG to 0 is equivalent to #defining PRODUCTION 1 when DEBUG is 1.       
    (No code for debugger breaks is emitted in either case.)                            
                                                                                        
    Of the multitude of macros, the preferred ones are:                                 
                                                                                        
    debug_string(c-string)                                                              
        If debugging is on, c-string is printed in the debugger.                        
        In production builds, debug_string() does nothing.                              
                                                                                        
    check(expression)                                                                   
    check_noerr(error)                                                                  
        If (expression) evaluates to false, break into the debugger.                    
        In production builds, check() does nothing.                                     
        Code inside check() statements is not compiled into production builds.          
                                                                                        
    require(expression, label)                                                          
    require_noerr(expression, label)                                                    
        If (expression) evaluates to false, announce this fact via the                  
        debugger and then goto label.  In production builds, does not call              
        the debugger but still goes to label if expression is false.                    
                                                                                        
    require_action(expression, label, action)                                           
    require_noerr_action(expression, label, action)                                     
        Same as require, but executes (action) before jumping to label.                 
                                                                                        
    check_string(expression, c-string)                                                  
    require_string(expression, label, c-string)                                         
    require_noerr_string(expression, label, c-string)                                   
        If expression evaluates to false, print string and then proceed as in           
        a normal check/require statement                                                
                                                                                        
    verify(expression)                                                                  
    verify_noerr(error)                                                                 
        If debugging is on, verify is the same as check(expression).                    
        If debugging is off, verify still evaluates (expression)                        
        but ignores the result.  Code inside verify() statements                        
        is executed in both production and debug builds.                                
                                                                                        
    Common usage:                                                                       
                                                                                        
        // my pixmap is not purgeable, so locking it should never fail                  
        verify( LockPixels(myPixMap) );                                                 
        verify_noerr( DisposeThread(myThread, &threadResult, true) );                   
  ______________________________________________________________________________________
}


{
  ______________________________________________________________________________________
                                                                                        
   Before including this file, #define kComponentSignatureString to a C-string          
   containing the name of your client.                                                  
                                                                                        
   example: #define kComponentSignatureString "SurfWriter"                              
  ______________________________________________________________________________________
}





{
  ______________________________________________________________________________________
                                                                                        
    DEBUGASSERTMSG - all error reporting is routed through this macro, which calls the  
    system routine DebugAssert().  If you wish to use your own assertion/debugger break 
    routine, you can override DEBUGASSERTMSG by defining it before including this file. 
  ______________________________________________________________________________________
}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
 *  DebugAssert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DebugLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DebugAssert(componentSignature: OSType; options: UInt32; assertionString: ConstCStringPtr; exceptionString: ConstCStringPtr; errorString: ConstCStringPtr; fileName: ConstCStringPtr; lineNumber: LONGINT; value: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $AA7E;
	{$ENDC}

{
    kBlessedBusErrorBait is an address that will never be mapped
    by Mac OS 8 or 9. It is close to the middle of the 64K range from
    0x68F10000 to 0x68F1FFFF that is unmapped and cannot be accessed 
    without causing an exception. Thus, it's a good value to use for
    filling uninitialized pointers, etc.
}

CONST
	kBlessedBusErrorBait		= $68F168F1;


	{   TaskLevel masks }
	k68kInterruptLevelMask		= $00000007;
	kInVBLTaskMask				= $00000010;
	kInDeferredTaskMask			= $00000020;
	kInSecondaryIntHandlerMask	= $00000040;
	kInNestedInterruptMask		= $00000080;

	kComponentDebugOption		= 0;							{  optionSelectorNum to turn breaks for component on/off }

	kGetDebugOption				= 1;							{  get current debug option setting }
	kSetDebugOption				= 2;							{  set debug option }

	{
	    DebugComponentCallback
	    DebugComponentCallback is the callback into a component that registers with DebugLib.
	    It is called to get the debug option setting, or to turn a debug option on or off.
	        Inputs:
	            optionSelectorNum   The component debug option to set
	            command             The command:
	                                    kGetDebugOption     - get current debug option setting
	                                    kSetDebugOption     - set debug option
	        Outputs:
	            optionSetting       The current setting if kGetDebugOption;
	                                the new debug option if kSetDebugOption
	}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	DebugComponentCallbackProcPtr = PROCEDURE(optionSelectorNum: SInt32; command: UInt32; VAR optionSetting: BOOLEAN);
{$ELSEC}
	DebugComponentCallbackProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DebugComponentCallbackUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DebugComponentCallbackUPP = UniversalProcPtr;
{$ENDC}	
	{
	    TaskLevel
	    TaskLevel returns 0 if we're (probably) running at non-interrupt time.
	    There's no way to make this perfect, but this is as close as we can get.
	    If TaskLevel doesn't return 0, then the following masks can be used to learn more:
	        k68kInterruptLevelMask      = 0x00000007
	        kInVBLTaskMask              = 0x00000010
	        kInDeferredTaskMask         = 0x00000020
	        kInSecondaryIntHandlerMask  = 0x00000040
	        kInNestedInterruptMask      = 0x00000080
	}
	{
	 *  TaskLevel()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in DebugLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION TaskLevel: UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $AA7E;
	{$ENDC}

{
    NewDebugComponent
    NewDebugComponent registers a component with DebugLib.
        Inputs:
            componentSignature  The unique signature of component
            componentName       The displayable string naming the component
            componentCallback   The callback into component for working with options
        Result:
            noErr                           no error
            memFullErr                      could not allocate memory
            debuggingExecutionContextErr    routine cannot be called at this time
            debuggingDuplicateSignatureErr  componentSignature already registered
            debuggingInvalidNameErr         componentName is invalid (NULL)
}
{
 *  NewDebugComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DebugLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDebugComponent(componentSignature: OSType; componentName: Str255; componentCallback: DebugComponentCallbackUPP): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $AA7E;
	{$ENDC}


{
    NewDebugOption
    NewDebugOption registers a debug option with DebugLib.
        Inputs:
            componentSignature  The signature of component to register a debug option for
            optionSelectorNum   The selector number of this debug option
            optionName          The displayable string naming this debug option
        Result:
            noErr                           no error
            memFullErr                      could not allocate memory
            debuggingExecutionContextErr    called at interrupt time
            debuggingDuplicateOptionErr     optionSelectorNum already registered
            debuggingInvalidSignatureErr    componentSignature not registered
            debuggingInvalidNameErr         optionName is invalid (NULL)
            debuggingNoCallbackErr          debugging component has no callback
}
{
 *  NewDebugOption()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DebugLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDebugOption(componentSignature: OSType; optionSelectorNum: SInt32; optionName: Str255): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $AA7E;
	{$ENDC}


{
    DisposeDebugComponent
    DisposeDebugComponent removes a component registration and all related debug options from DebugLib.
        Input:
            componentSignature  The unique signature of a component
        Result:
            noErr                           no error
            debuggingExecutionContextErr    called at interrupt time
            debuggingInvalidSignatureErr    componentSignature not registered
}
{
 *  DisposeDebugComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DebugLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DisposeDebugComponent(componentSignature: OSType): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $AA7E;
	{$ENDC}


{
    GetDebugComponentInfo
    GetDebugComponentInfo returns a component registered with DebugLib.
        Inputs:
            index               The index into the list of registered components (1-based)
        Outputs:
            componentSignature  The unique signature of a component
            componentName       The displayable string naming a component
        Result:
            noErr                           no error
            debuggingNoMatchErr             debugging component not found at this index
}
{
 *  GetDebugComponentInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DebugLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDebugComponentInfo(index: UInt32; VAR componentSignature: OSType; VAR componentName: Str255): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $AA7E;
	{$ENDC}


{
    GetDebugOptionInfo
    GetDebugOptionInfo returns a debug option registered with DebugLib.
        Inputs:
            index               The index into the list of registered debug options (0-based);
                                    0 = kComponentDebugOption 
            componentSignature  The unique signature of a component
        Outputs:
            optionSelectorNum   The selector number of this debug option
            optionName          The displayable string naming this debug option
            optionSetting       The current debug option setting
        Result:
            noErr                           no error
            debuggingInvalidSignatureErr    componentSignature not registered
            debuggingNoMatchErr             option not found at this index
}
{
 *  GetDebugOptionInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DebugLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDebugOptionInfo(index: UInt32; componentSignature: OSType; VAR optionSelectorNum: SInt32; VAR optionName: Str255; VAR optionSetting: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $AA7E;
	{$ENDC}


{
    SetDebugOptionValue
    SetDebugOptionValue sets a debug option registered with DebugLib.
        Inputs:
            componentSignature  The unique signature of a component
            optionSelectorNum   The selector number of this debug option
            newOptionSetting    The new debug option setting
        Result:
            noErr                           no error
            debuggingInvalidSignatureErr    componentSignature not registered
            debuggingInvalidOptionErr       optionSelectorNum is not registered
}
{
 *  SetDebugOptionValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DebugLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDebugOptionValue(componentSignature: OSType; optionSelectorNum: SInt32; newOptionSetting: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $AA7E;
	{$ENDC}

{
    DebugAssertOutputHandler
    DebugAssertOutputHandler is the callback that registers with DebugLib to handle the
    output from DebugAssert.
        Inputs:
            "componentSignature" through "value" are the raw values passed to DebugAssert
                when an exception occurs.
            outputMsg is the string DebugAssert build which would normally be passed to
                DebugStr if a DebugAssertOutputHandler isn't installed.
}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	DebugAssertOutputHandlerProcPtr = PROCEDURE(componentSignature: OSType; options: UInt32; assertionString: ConstCStringPtr; exceptionString: ConstCStringPtr; errorString: ConstCStringPtr; fileName: ConstCStringPtr; lineNumber: LONGINT; value: UNIV Ptr; outputMsg: Str255);
{$ELSEC}
	DebugAssertOutputHandlerProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DebugAssertOutputHandlerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DebugAssertOutputHandlerUPP = UniversalProcPtr;
{$ENDC}	
	{
	    InstallDebugAssertOutputHandler
	    InstallDebugAssertOutputHandler installs a DebugAssertOutputHandler which DebugAssert calls
	    instead of DebugStr.
	        Inputs:
	            handler     the DebugAssertOutputHandler to install or NULL to switch back to
	                        the default handler (DebugStr).
	}
	{
	 *  InstallDebugAssertOutputHandler()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in DebugLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
PROCEDURE InstallDebugAssertOutputHandler(handler: DebugAssertOutputHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $AA7E;
	{$ENDC}

{
    dprintf() takes a variable argument list and 'prints' that to the debugging output
    handler.  Calling dprintf() from anything but C or C++ is tricky.
}
{$IFC CALL_NOT_IN_CARBON }
{
 *  dprintf()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DebugLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE dprintf(format: ConstCStringPtr; ...); C;


{   vdprintf() takes a va_args list and 'prints' that to the debugging output handler. }
{
 *  vdprintf()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DebugLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE vdprintf(format: ConstCStringPtr; va_args_list: CStringPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $AA7E;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	uppDebugComponentCallbackProcInfo = $00000FC0;
	uppDebugAssertOutputHandlerProcInfo = $00FFFFC0;
	{
	 *  NewDebugComponentCallbackUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewDebugComponentCallbackUPP(userRoutine: DebugComponentCallbackProcPtr): DebugComponentCallbackUPP; { old name was NewDebugComponentCallbackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDebugAssertOutputHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDebugAssertOutputHandlerUPP(userRoutine: DebugAssertOutputHandlerProcPtr): DebugAssertOutputHandlerUPP; { old name was NewDebugAssertOutputHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeDebugComponentCallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDebugComponentCallbackUPP(userUPP: DebugComponentCallbackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDebugAssertOutputHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDebugAssertOutputHandlerUPP(userUPP: DebugAssertOutputHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeDebugComponentCallbackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDebugComponentCallbackUPP(optionSelectorNum: SInt32; command: UInt32; VAR optionSetting: BOOLEAN; userRoutine: DebugComponentCallbackUPP); { old name was CallDebugComponentCallbackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeDebugAssertOutputHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDebugAssertOutputHandlerUPP(componentSignature: OSType; options: UInt32; assertionString: ConstCStringPtr; exceptionString: ConstCStringPtr; errorString: ConstCStringPtr; fileName: ConstCStringPtr; lineNumber: LONGINT; value: UNIV Ptr; outputMsg: Str255; userRoutine: DebugAssertOutputHandlerUPP); { old name was CallDebugAssertOutputHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
  ______________________________________________________________________________________
                                                                                        
    Tech Q&A PLAT-30 says to check bit 5 of the byte at 0xbff to                        
    determine whether MacsBug ( or any other low level debugger )                       
    is installed; I also check that MacJmp ( which points to the                        
    entry point for the debugger ) is not nil and not -1.                               
                                                                                        
    MacJmpFlag:                                                                         
        Bit 5 should be set to indicate the debugger is installed.                      
        Bit 6 should be set to indicate the debugger is initialized.                    
        Bit 7 should be clear to indicate that the debugger is NOT busy                 
                                                                                        
    Dr. MacsBug says to also check that the byte at 0xBFF isn't 0xFF.                   
  ______________________________________________________________________________________
}
{$IFC CALL_NOT_IN_CARBON }
{$ENDC}  {CALL_NOT_IN_CARBON}

{  no-op asserts for production code }

{______________________________________________________________________________________}
{______________________________________________________________________________________}
{______________________________________________________________________________________}




{______________________________________________________________________________________}
{______________________________________________________________________________________}
{______________________________________________________________________________________}
{______________________________________________________________________________________}
{______________________________________________________________________________________}

{______________________________________________________________________________________}
{______________________________________________________________________________________}

{______________________________________________________________________________________}

{______________________________________________________________________________________}
{______________________________________________________________________________________}
{______________________________________________________________________________________}

{______________________________________________________________________________________}

{______________________________________________________________________________________}


{______________________________________________________________________________________}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DebuggingIncludes}

{$ENDC} {__DEBUGGING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
