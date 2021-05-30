{
     File:       CGError.p
 
     Contains:   xxx put contents here xxx
 
     Version:    Technology: from CoreGraphics-74.1.root
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
 UNIT CGError;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CGERROR__}
{$SETC __CGERROR__ := 1}

{$I+}
{$SETC CGErrorIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CGBASE__}
{$I CGBase.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Types used for error and error handler }

TYPE
	CGError 					= SInt32;
CONST
	kCGErrorSuccess				= 0;
	kCGErrorFirst				= 1000;
	kCGErrorFailure				= 1000;
	kCGErrorIllegalArgument		= 1001;
	kCGErrorInvalidConnection	= 1002;
	kCGErrorInvalidContext		= 1003;
	kCGErrorCannotComplete		= 1004;
	kCGErrorNameTooLong			= 1005;
	kCGErrorNotImplemented		= 1006;
	kCGErrorRangeCheck			= 1007;
	kCGErrorTypeCheck			= 1008;
	kCGErrorNoCurrentPoint		= 1009;
	kCGErrorInvalidOperation	= 1010;
	kCGErrorNoneAvailable		= 1011;
	kCGErrorLast				= 1011;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CGErrorIncludes}

{$ENDC} {__CGERROR__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
