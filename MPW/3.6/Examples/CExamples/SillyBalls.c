/*------------------------------------------------------------------------------
#
#	Macintosh Developer Technical Support
#
#	Simple Color QuickDraw Sample Application
#
#	SillyBalls
#
#	SillyBalls.c	-	C Source
#
#	Copyright © 1988, 1995 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	1.0					8/88
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
------------------------------------------------------------------------------*/

/*	
	Version 1.0:	6/2/88
					7/20/88	 DJB	Converted to C
	
	purpose		To demonstrate a simple color App using Color QuickDraw.
						It draws colored balls in a color window, then uses colored
						text inverted in the ball.  The ball location and color is Random.
						
						This program was written by Bo3b Johnson, 1/88.
						
						The inverted Bob text was a Skippy Blair special concept,
						kept for obvious aesthetic reasons.
						
						You can build the program with this junk:
C -r SillyBalls.c
Link SillyBalls.c.o ∂
	"{Libraries}"Interface.o ∂
	"{Libraries}"Runtime.o ∂
	-o SillyBalls
SillyBalls
*/

/* Where does it fit:
	This is a series of sample programs for those doing development
	using Color QuickDraw.  Since the whole color problem depends
	upon the exact effect desired, there are a number of answers
	to how to use colors, from the simple to the radically complex.
	These programs try to cover the gamut, so you should use 
	which ever seems appropriate.  In most cases, use the simplest
	one that will give the desired results.  The compatibility
	rating is from 0..9 where low is better.  The more known risks 
	there are the higher the rating.
	
	
	The programs (in order of compatibility):
	
		SillyBalls:	(***)
			This is the simplest use of Color QuickDraw, and does
			not use the Palette Manager.  It draws randomly colored
			balls in a color window.  This is intended to give you
			the absolute minimum required to get color on the screen.
			Written in straight Pascal code.
			Compatibility rating = 0, no known risks.
		
		FracAppPalette:
			This is a version of FracApp that uses only the Palette
			Manager.  It does not support color table animation
			since that part of the Palette Manager is not sufficient.
			The program demonstrates a full color palette that is
			used to display the Mandelbrot set.  It uses an offscreen
			gDevice w/ Port to handle the data, using CopyBits to
			draw to the window.  The Palette is automatically 
			associated with each window.  The PICT files are read
			and written using the bottlenecks, to save on memory
			useage.
			Written in MacApp Object Pascal code.
			Compatibility rating = 0, no known risks.
		
		TubeTest:
			This is a small demo program that demonstrates using the
			Palette Manager for color table animation.  It uses a 
			color palette with animating entries, and draws using the
			Palette Manager.  There are two circles of animating colors
			which gives a flowing tube effect.  This is a valid case
			for using the animating colors aspect of the Palette Manager,
			since the image is being drawn directly.
			Written in straight Pascal code.
			Compatibility rating = 0, no known risks.
		
		FracApp:
			This is the ‘commercial quality’ version of FracApp.  This
			version supports color table animation, using an offscreen
			gDevice w/ Port, and handles multiple documents.  The
			CopyBits updates to the screen are as fast as possible.  The
			program does not use the Palette Manager, except to
			provide for the system palette, or color modes with less than
			255 colors.  For color table animation using an offscreen
			gDevice w/ Port, it uses the Color Manager and handles the
			colors itself.  Strict compatibility was relaxed to allow for
			a higher performance program.  This is the most ‘real’ of the
			sample programs.
			Written in MacApp Object Pascal code.
			Compatibility rating = 2.  (nothing will break, but it may not
				always look correct.)
		
		FracApp300:
			This doesn't support colors, but demonstrates how to create and
			use a 300 dpi bitmap w/ Port.  The bitmap is printed at full
			resolution on LaserWriters, and clipped on other printers (but
			they still print).  It demonstrates how to use a high resolution
			image as a PICT file, and how to print them out.
			Written in MacApp Object Pascal code.
			Compatibility rating = 1.  (The use of PrGeneral is slightly 
				out of the ordinary, although supported.)
*/

#include <Types.h>
#include <Memory.h>
#include <Quickdraw.h>
#include <Fonts.h>
#include <Events.h>
#include <Menus.h>
#include <Windows.h>
#include <TextEdit.h>
#include <Dialogs.h>
#include <Sound.h>
#include <ToolUtils.h>
#include <Processes.h>

/* Constants */
#define BallWidth		20
#define BallHeight		20
#define BobSize			8		/* Size of text in each ball */

/* Globals */
Rect		windRect;

/* The qd global has been removed from the libraries */
QDGlobals qd;


/* Prototypes */
void Initialize(void);
void NewBall(void);

/* 
**	Main body of program SillyBalls
*/
void main(void)
{
	Initialize();
	
	do {
		NewBall();
	} while (!Button());
	
}

/* 
**	Initialize everything for the program, make sure we can run
*/
void Initialize(void)
{
	WindowPtr	mainPtr;
	OSErr		error;
	SysEnvRec	theWorld;
	
	/*
	**	Test the computer to be sure we can do color.  
	**	If not we would crash, which would be bad.  
	**	If we can’t run, just beep and exit.
	*/
	error = SysEnvirons(1, &theWorld);
	if (theWorld.hasColorQD == false) {
		SysBeep(50);
		ExitToShell();					/* If no color QD, we must leave. */
	}
	
	/* Initialize all the needed managers. */
	InitGraf(&qd.thePort);
	InitFonts();
	InitWindows();
	InitMenus();
	TEInit();
	InitDialogs(nil);
	InitCursor();

	/*
	**	To make the Random sequences truly random, we need to make the seed start
	**	at a different number.  An easy way to do this is to put the current time
	**	and date into the seed.  Since it is always incrementing the starting seed
	**	will always be different.  Don’t for each call of Random, or the sequence
	**	will no longer be random.  Only needed once, here in the init.
	*/
	GetDateTime((unsigned long*) &qd.randSeed);

	/*
	**	Make a new window for drawing in, and it must be a color window.  
	**	The window is full screen size, made smaller to make it more visible.
	*/
	windRect = qd.screenBits.bounds;
	InsetRect(&windRect, 50, 50);
	mainPtr = NewCWindow(nil, &windRect, "\pBo3b Land", true, documentProc, 
						(WindowPtr) -1, false, 0);
		
	SetPort(mainPtr);						/* set window to current graf port */
	TextSize(BobSize);						/* smaller font for drawing. */
}


/* 
**	NewBall: make another ball in the window at a random location and color.
*/
void NewBall(void)
{
	RGBColor	ballColor;
	Rect		ballRect;
	long int	newLeft,
				newTop;
	
	/* 
	**	Make a random new color for the ball.
	*/
	ballColor.red   = Random();
	ballColor.green = Random();
	ballColor.blue  = Random();
	
	/* 
	**	Set that color as the new color to use in drawing.
	*/
	RGBForeColor (&ballColor);

	/*	
	**	Make a Random new location for the ball, that is normalized to the window size.  
	**	This makes the Integer from Random into a number that is 0..windRect.bottom
	**	and 0..windRect.right.  They are normalized so that we don't spend most of our
	**	time drawing in places outside of the window.
	*/
	newTop = Random();	newLeft = Random();
	newTop = ((newTop+32767) * windRect.bottom)/65536;
	newLeft = ((newLeft+32767) * windRect.right)/65536;
	SetRect(&ballRect, newLeft, newTop, newLeft+BallWidth, newTop+BallHeight);
	
	/*
	**	Move pen to the new location, and paint the colored ball.
	*/
	MoveTo(newLeft, newTop);
	PaintOval (&ballRect);
	
	/*
	**	Move the pen to the middle of the new ball position, for the text
	*/
	MoveTo(ballRect.left + BallWidth/2 - BobSize, 
		ballRect.top + BallHeight/2 + BobSize/2 -1);
	
	/*	
	**	Invert the color and draw the text there.  This won’t look quite right in 1 bit
	**	mode, since the foreground and background colors will be the same.
	**	Color QuickDraw special cases this to not invert the color, to avoid
	**	invisible drawing.
	*/
	InvertColor(&ballColor); 
	RGBForeColor(&ballColor);
	DrawString("\pBob");
}
