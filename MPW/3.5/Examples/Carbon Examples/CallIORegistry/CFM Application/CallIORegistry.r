/*
	File:		CallIORegistry.r
	
	Disclaimer:	IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc.
				("Apple") in consideration of your agreement to the following terms, and your
				use, installation, modification or redistribution of this Apple software
				constitutes acceptance of these terms.  If you do not agree with these terms,
				please do not use, install, modify or redistribute this Apple software.

				In consideration of your agreement to abide by the following terms, and subject
				to these terms, Apple grants you a personal, non-exclusive license, under Apple’s
				copyrights in this original Apple software (the "Apple Software"), to use,
				reproduce, modify and redistribute the Apple Software, with or without
				modifications, in source and/or binary forms; provided that if you redistribute
				the Apple Software in its entirety and without modifications, you must retain
				this notice and the following text and disclaimers in all such redistributions of
				the Apple Software.  Neither the name, trademarks, service marks or logos of
				Apple Computer, Inc. may be used to endorse or promote products derived from the
				Apple Software without specific prior written permission from Apple.  Except as
				expressly stated in this notice, no other rights or licenses, express or implied,
				are granted by Apple herein, including but not limited to any patent rights that
				may be infringed by your derivative works or by other works in which the Apple
				Software may be incorporated.

				The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO
				WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED
				WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
				PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
				COMBINATION WITH YOUR PRODUCTS.

				IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR
				CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
				GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
				ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION
				OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT
				(INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN
				ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

	Copyright © 1999-2001 Apple Computer, Inc., All Rights Reserved
*/

#include "Types.r"

data 'carb' (0) {
	$"00"
};

resource 'MENU' (128, "About") 
{
	128,
	textMenuProc,
	0x7FFFFFFD,
	enabled,
	apple,
	{
		"About BasicCarbEvents…", noIcon, noKey, noMark, plain,
		"-", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (129, "Standard File Menu")
{
	129,
	textMenuProc,
	0x7FFFFFFF,
	enabled,
	"File",
	{
		"Quit", noIcon, "Q", noMark, plain,
	}
};

resource 'xmnu' (129, "Standard File Menu")
{
	versionZero
	{
		{
			dataItem { 'quit', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph }
		}
	};
};


resource 'MENU' (130, "Standard Edit Menu")
{
	130,
	textMenuProc,
	0x00000000,
	enabled,
	"Edit",
	{
		"Undo", noIcon, "Z", noMark, plain,
		"-", noIcon, noKey, noMark, plain,
		"Cut", noIcon, "X", noMark, plain,
		"Copy", noIcon, "C", noMark, plain,
		"Paste", noIcon, "V", noMark, plain,
		"Clear", noIcon, noKey, noMark, plain,
	}
};

resource 'xmnu' (130, "Standard Edit Menu")
{
	versionZero
	{
		{
			dataItem { 'undo', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			skipItem {},
			dataItem { 'cut ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'copy', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'past', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'clea', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph }
		}
	};
};

resource 'MBAR' (128, "Standard Menu Bar")
{
	{
		128,
		129,
		130
	}
};

resource 'ALRT' (128) {
	{40, 40, 164, 398},
	128,
	{	/* array: 4 elements */
		/* [1] */
		OK, visible, sound1,
		/* [2] */
		OK, visible, sound1,
		/* [3] */
		OK, visible, sound1,
		/* [4] */
		OK, visible, sound1
	},
	alertPositionMainScreen
};

resource 'DITL' (128) {
	{	/* array DITLarray: 2 elements */
		/* [1] */
		{95, 158, 115, 216},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{11, 44, 80, 334},
		StaticText {
			disabled,
			"There was a problem loading the bundle. "
			" Please verify you are running on Mac OS"
			" X and the path to the Mach-O bundle is "
			"correct."
		}
	}
};