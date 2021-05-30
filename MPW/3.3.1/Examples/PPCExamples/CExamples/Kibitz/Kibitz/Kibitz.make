#------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Sample Application
#
#	Program:	Kibitz
#	File:		Kibitz.make	-	Make Source
#
#	Copyright © 1988-1994 Apple Computer, Inc.
#	All rights reserved.
#
#------------------------------------------------------------------------------

#	The are three possible ways of making Kibitz with this makefile
#		1) 68K only
#		2) Power Macintosh only
#		3) "Fat" - both 68K and Power Macintosh
#	You can control which gets build using the dependency line for "AppName"
#	The default is to build the fat version.  See instructions below.
AppName			=	'Kibitz'
Signature		=	'KBTZ'

DTS.Lib.folder	=	"::DTS.Lib:"
DTS.Lib.hdrs	=	"::DTS.Lib:DTS.Lib.headers:"
projsrc			=	:
obj				= 	:OBJECT:
objppc			= 	:OBJECTPPC:

#------------------------------------------------------------------------------
# Options for our compilers:
#	-sym on: tells the compilers and linker to emit symbol information for
#		a source level debugger, such as SADE.
#	-i {DTS.Lib.hdrs}: means to look for any #include files in the specified
#		directory, as well as the normal set.
#	-r: tells the C compiler to require function prototypes.
#	-mbg off: tells the compilers to not emit low-level debugger names. This
#		saves on file space, but you may wish to remove this option if you
#		need to debug with something like Macsbug.
#	-rd: for Rez means to suppress warnings for redeclared types (we redeclare
#		'RECT' because it’s not included in MPW 3.0).
#	-append: means to add the resources to the target file, rather than
#		deleting all the ones that are there first.
#	-d Signature...: is a way of passing our application's signature to Rez.
#		With this mechanism, we can define our signature here, and export
#		it to Rez, so that we don't have to declare it there, too.
#	-sn STDCLIB=Main: puts all the routines that would normally go into the
#		STDCLIB segment into the Main segment. This is done so that when we
#		call upon any low-level utilities, we don't potentially move memory
#		by loading in a segment.
#------------------------------------------------------------------------------

#	SymOptions and OptOptions are mutually exclusive.  Enable as appropriate
SymOptions		=	-sym off				# turn this on to debug.
COptOptions		=	-opt off
PPCCOptOptions	=	-opt off

# CIncludesFolder needs to be set to your Universal Interfaces folder
CIncludesFolder	=	-i "{CIncludes}"
IncludesFolders	=	-i {DTS.Lib.hdrs}
COptions		=	{IncludesFolders} {CIncludesFolder} {SymOptions} {COptOptions} -r -mbg on
PPCCOptions		=	{IncludesFolders} {SymOptions} {PPCCOptOptions} -w conformance -appleext on
RezOptions		=	{IncludesFolders} -rd -append -d Signature="{Signature}" -d AppName='"Kibitz"'
LinkOptions		=	{SymOptions} {SegmentMappings} -msg nodup
LinkOptionsPPC	=	{SymOptions} -main main
MakeSymOptions	=	-i {DTS.Lib.folder} -r
#	The -w options for MakePef makes those libraries "weak" imports, meaning
#		they can be absent at runtime.  The app must check before calling them.
MakePefOptions	=	-l QuickTimeLib.xcoff=QuickTimeLib~ ∂
						-w QuickTimeLib:EnterMovies ∂
						-l SpeechLib.xcoff=SpeechLib~ ∂
						-w SpeechLib:DisposeSpeechChannel ∂
						-w SpeechLib:NewSpeechChannel ∂
						-w SpeechLib:SetSpeechInfo ∂
						-w SpeechLib:SpeakText ∂
						-w SpeechLib:SpeechBusy ∂
						-w SpeechLib:StopSpeech ∂
						-l InterfaceLib.xcoff=InterfaceLib
SegmentMappings	=	-sn INTENV=Main ∂
					-sn PASLIB=Main ∂
					-sn STDCLIB=Main ∂
					-sn SANELIB=Main ∂
					-sn StringUtils=Main ∂
					-sn UtilMain=Main

#------------------------------------------------------------------------------
# These are modified default build rules.  This is necessary to take into
# account differences between MPW 3.1 and 3.2
#------------------------------------------------------------------------------
{obj}			ƒ	{projsrc}

.c.o			ƒ	.c
	{C} {COptions} {CAltOptions} {DepDir}{Default}.c -o {TargDir}{Default}.c.o

{objppc}		ƒ	{projsrc}

.o				ƒ	.c
	PPCC {PPCCOptions} {DepDir}{Default}.c -o {TargDir}{Default}.o

#------------------------------------------------------------------------------
# These are the objects that we want to link with. If any one of these
# changes, then we invoke the Link command.
#------------------------------------------------------------------------------
AppObjects		=	∂
					{obj}AEchess.c.o ∂
					{obj}AppleEvents.c.o ∂
					{obj}BoardSlider.c.o ∂
					{obj}Chess.c.o ∂
					{obj}CMQueenMate.c.o ∂
					{obj}CMRookMate.c.o ∂
					{obj}Config.c.o ∂
					{obj}DoCursor.c.o ∂
					{obj}DoEvent.c.o ∂
					{obj}EventLoop.c.o ∂
					{obj}File.c.o ∂
					{obj}GoToMove.c.o ∂
					{obj}Help.c.o ∂
					{obj}IdleTasks.c.o ∂
					{obj}Init.c.o ∂
					{obj}KibitzWindow.c.o ∂
					{obj}Menu.c.o ∂
					{obj}Notation.c.o ∂
					{obj}Offscreen.c.o ∂
					{obj}PPCBrowserOverride.a.o ∂
					{obj}PPCBrowserOverride.c.o ∂
					{obj}Print.c.o ∂
					{obj}SaveBoardImage.c.o ∂
					{obj}Setup.c.o ∂
					{obj}Sound.c.o ∂
					{obj}SpeechMessage.c.o ∂
					{obj}Start.c.o ∂
					{obj}Window.c.o

AppObjectsPPC	=	∂
					{objppc}AEchess.o ∂
					{objppc}AppleEvents.o ∂
					{objppc}BoardSlider.o ∂
					{objppc}Chess.o ∂
					{objppc}CMQueenMate.o ∂
					{objppc}CMRookMate.o ∂
					{objppc}Config.o ∂
					{objppc}DoCursor.o ∂
					{objppc}DoEvent.o ∂
					{objppc}EventLoop.o ∂
					{objppc}File.o ∂
					{objppc}GoToMove.o ∂
					{objppc}Help.o ∂
					{objppc}IdleTasks.o ∂
					{objppc}Init.o ∂
					{objppc}KibitzWindow.o ∂
					{objppc}Menu.o ∂
					{objppc}Notation.o ∂
					{objppc}Offscreen.o ∂
					#{objppc}PPCBrowserOverride.a.o ∂
					#{objppc}PPCBrowserOverride.o ∂
					{objppc}Print.o ∂
					{objppc}SaveBoardImage.o ∂
					{objppc}Setup.o ∂
					{objppc}Sound.o ∂
					{objppc}SpeechMessage.o ∂
					{objppc}Start.o ∂
					{objppc}Window.o

#------------------------------------------------------------------------------
# These help define the libraries that we want to link with. {AppObjects} holds
# the names of the application units we want to link together. {Libs68K} and
# {LibsPPC} hold the DTS.Lib and System library files we need to link with.
# If any of these change, then we also need to relink.
#------------------------------------------------------------------------------
Libs68K			=	∂
					"{Libraries}Runtime.o" ∂
					"{DTS.Lib.folder}DTS.Lib_controls" ∂
					"{DTS.Lib.folder}DTS.Lib_strings" ∂
					"{DTS.Lib.folder}DTS.Lib_utils" ∂
					"{Libraries}Interface.o"

LibsPPC			=	∂
					"{DTS.Lib.folder}DTS.Lib_controls.PPC" ∂
					"{DTS.Lib.folder}DTS.Lib_strings.PPC" ∂
					"{DTS.Lib.folder}DTS.Lib_utils.PPC" ∂
					"{PPCLibraries}"QuickTimeLib.xcoff ∂
					"{PPCLibraries}"SpeechLib.xcoff ∂
					"{PPCLibraries}"InterfaceLib.xcoff ∂
					"{PPCLibraries}"PPCCRuntime.o

#------------------------------------------------------------------------------
#	This rule controls how the final app is built.
#	By depending on both App68K and AppPPC, the "fat" version
#	gets built.  To build 68K only or Power Macintosh only, remove the other
#	dependency.
#------------------------------------------------------------------------------

{AppName}			ƒƒ AppRez App68K AppPPC
	SetFile {AppName} -t APPL -c {Signature} -a B

#------------------------------------------------------------------------------
# Build rule that links our application together. If any of our objects 
# changes, or this makefile changes, then we relink.  The dummy prerequisite
# ShellForce must come before any other prerequisites for {AppName}
#------------------------------------------------------------------------------

App68K				ƒ {AppObjects} {Libs68K}
	Link {LinkOptions} -o {AppName} {AppObjects} {Libs68K}
	Rez {RezOptions} KibitzCfrg.r -o {AppName}

#------------------------------------------------------------------------------
# Build rule that creates our resources and adds them to the application
#------------------------------------------------------------------------------

AppRez				ƒ	{AppName}.make ∂
						Kibitz.r ∂
						KibitzCfrg.r ∂
						Kibitz.h
	Rez {RezOptions} Kibitz.r KibitzCfrg.r -o {AppName}
	
#------------------------------------------------------------------------------
# Dependencies for the individual components. These will invoke the
# default build rules listed in Chapter 9 of the MPW 3.0 manual.
# You may wish to reduce the number of dependencies.  Two dependencies
# you may wish to remove are this makefile and the Kibitz.protos file.
# For the Kibitz.protos file, if you add a function to the list of
# functions in Kibitz.protos, you will cause all the source files to be
# recompiled.  This may be more than you want to wait for each time you
# add a function to your application.  On the other hand, if you do not
# include this in the dependencies, and you change the parameters for a
# function, and make the respective change to Kibitz.protos, any files
# that reference that function will not be recompiled.  If these files are
# recompiled, the prototype checking will catch any cases where you did
# not change the way the altered function was called.  <<You choose>>
#------------------------------------------------------------------------------
	
#{AppObjects}	ƒ	{AppName}.make ∂
#					Kibitz.h ∂
#					Kibitz.protos

#{AppObjectsPPC}	ƒ	{AppName}.make ∂
#					Kibitz.h ∂
#					Kibitz.protos


#------------------------------------------------------------------------------
# Rules to build the Power Macintosh part
#------------------------------------------------------------------------------
AppPPC				ƒ	{AppName}.pef

{AppName}.xcoff		ƒ	{AppObjectsPPC} {LibsPPC}
	PPCLink {LinkOptionsPPC} {AppObjectsPPC} {LibsPPC} -o {AppName}.xcoff

#	MakeSym is very timeconsuming, so we only do it if we really need it
{AppName}.xSYM		ƒ {AppName}.xcoff
	IF "{SymOptions}" != ""	&& "{SymOptions}" != "-sym off"				
		MakeSym {MakeSymOptions} {AppName}.xcoff -o {AppName}.xSYM
	END

{AppName}.pef		ƒ	{AppName}.xcoff {AppName}.xSYM
	MakePef {MakePefOptions} {AppName}.xcoff -o {AppName}
	Rez {RezOptions} -d powerc KibitzCfrg.r -o {AppName}
	