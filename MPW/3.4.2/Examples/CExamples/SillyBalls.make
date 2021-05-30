#
#	Macintosh Developer Technical Support
#
#	Simple Color QuickDraw Sample Application
#
#	SillyBalls
#
#	SillyBalls.make	-	Make Source
#
#	Copyright © 1988, 1995 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	1.0					8/88
#				1.01				4/91	Updated for MPW 3.2
#
#	Components:	SillyBalls.c		August 1, 1988
#				SillyBalls.make		August 1, 1988
#
#	This is a very simple sample program that demonstrates how to use Color 
#	QuickDraw.  It is about two pages of code, and does nothing more than open
#	a color window and draw randomly colored ovals in the window.
#	
#	The purpose is to show how to get some initial results with Color QuickDraw.
#	It is a complete program and is very short to be as clear as possible.
#	
#	It does not have an Event Loop.  It is not fully functional in the sense that
#	it does not do all the things you would expect a well behaved Macintosh 
#	program to do, like size the window naturally, have an event loop, use menus, 
#	etc.
#
#	See Sample and TESample for the general structure and MultiFinder techniques that
#	we recommend that you use when building a new application.
#
# MPW 3.0 and later: We override the default COptions to turn on strict prototyping;
#	add '-proto strict' to your UserStartup when you tire of the warning from Make.

COptions = -proto strict -w 17

Objs		=	SillyBalls.c.o ∂
				"{Libraries}"Interface.o ∂
				"{Libraries}"MacRuntime.o 

SillyBalls	ƒ	{Objs} SillyBalls.make
	Link -o {Targ} {Objs}
	SetFile {Targ} -t APPL -c '????'
