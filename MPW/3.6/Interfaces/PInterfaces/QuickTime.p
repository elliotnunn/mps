{
     File:       QuickTime.p
 
     Contains:   Master include for all of QuickTime on OS X
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QuickTime;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QUICKTIME__}
{$SETC __QUICKTIME__ := 1}

{$I+}
{$SETC QuickTimeIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CARBON__}
{$I Carbon.p}
{$ENDC}


{$IFC UNDEFINED __MEDIAHANDLERS__}
{$I MediaHandlers.p}
{$ENDC}
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}
{$IFC UNDEFINED __MOVIESFORMAT__}
{$I MoviesFormat.p}
{$ENDC}
{$IFC UNDEFINED __QUICKTIMEVR__}
{$I QuickTimeVR.p}
{$ENDC}
{$IFC UNDEFINED __QUICKTIMEVRFORMAT__}
{$I QuickTimeVRFormat.p}
{$ENDC}
{$IFC UNDEFINED __IMAGECOMPRESSION__}
{$I ImageCompression.p}
{$ENDC}
{$IFC UNDEFINED __IMAGECODEC__}
{$I ImageCodec.p}
{$ENDC}
{$IFC UNDEFINED __QUICKTIMEMUSIC__}
{$I QuickTimeMusic.p}
{$ENDC}
{$IFC UNDEFINED __QUICKTIMECOMPONENTS__}
{$I QuickTimeComponents.p}
{$ENDC}
{$IFC UNDEFINED __QUICKTIMESTREAMING__}
{$I QuickTimeStreaming.p}
{$ENDC}
{$IFC UNDEFINED __QTSMOVIE__}
{$I QTSMovie.p}
{$ENDC}
{$IFC UNDEFINED __QTSTREAMINGCOMPONENTS__}
{$I QTStreamingComponents.p}
{$ENDC}

{$SETC UsingIncludes := QuickTimeIncludes}

{$ENDC} {__QUICKTIME__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
