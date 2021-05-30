{
     File:       Speech.p
 
     Contains:   Speech Interfaces.
 
     Version:    Technology: System 7.5
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
 UNIT Speech;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SPEECH__}
{$SETC __SPEECH__ := 1}

{$I+}
{$SETC SpeechIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{

    The interface file Speech.h has been renamed to SpeechSynthesis.h.

}
{$IFC UNDEFINED __SPEECHSYNTHESIS__}
{$I SpeechSynthesis.p}
{$ENDC}
{$SETC UsingIncludes := SpeechIncludes}

{$ENDC} {__SPEECH__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
