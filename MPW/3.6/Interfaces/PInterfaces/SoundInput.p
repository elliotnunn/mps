{
     File:       SoundInput.p
 
     Contains:   Sound Input Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1990-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT SoundInput;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SOUNDINPUT__}
{$SETC __SOUNDINPUT__ := 1}

{$I+}
{$SETC SoundInputIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{  obsolete file, all sound interfaces have been moved to Sound.[hpar] }
{$IFC UNDEFINED __SOUND__}
{$I Sound.p}
{$ENDC}



{$SETC UsingIncludes := SoundInputIncludes}

{$ENDC} {__SOUNDINPUT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
