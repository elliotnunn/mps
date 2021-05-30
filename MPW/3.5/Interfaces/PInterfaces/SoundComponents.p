{
     File:       SoundComponents.p
 
     Contains:   Sound Components Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1991-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT SoundComponents;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SOUNDCOMPONENTS__}
{$SETC __SOUNDCOMPONENTS__ := 1}

{$I+}
{$SETC SoundComponentsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{  obsolete file, all sound interfaces have been moved to Sound.[hpar] }
{$IFC UNDEFINED __SOUND__}
{$I Sound.p}
{$ENDC}

{$SETC UsingIncludes := SoundComponentsIncludes}

{$ENDC} {__SOUNDCOMPONENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
