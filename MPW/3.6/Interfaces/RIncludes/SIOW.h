/*------------------------------------------------------------------------------
#	SIOW.h
#	Simple Inpue/Output Window header
#	Apple Copyright 1989-1998
#
#	The names for these constants have been selected to satisfy both the
#	standards set up by Apple for applications, and by ANSI for C programming.
#
#-----------------------------------------------------------------------------*/

#ifndef __SIOW__
#define __SIOW__

#ifndef REZ
#include <Types.h>
#include <Events.h>
#endif

#ifndef __kPrefSize
#define __kPrefSize			350		/* Default max app size */
#endif
#ifndef __kMinSize
#define __kMinSize			250		/* Default min app size */
#endif

/* The following constants are used to identify menus and their items. */
/* NOTE: resources IDs 20000-20010 are reserved fur use by SIOW */

#define	__mApple			20000	/* Apple menu */
#define	__mFile				20001	/* File menu */
#define	__mEdit				20002	/* Edit menu */
#define __mFont				20003	/* Font menu */
#define __mSize				20004	/* Font menu */
#define __mControl			20005	/* Control menu */

#define	__rMenuBar			20000	/* application's menu bar */

#define	__rAboutAlert		20000	/* about alert */
#define	__rUserAlert		20001	/* user error alert */
#define __rSaveAlert		20002	/* save changes alert -- when quitting is final. */
#define __rQuitAlert		20003	/* quit alert -- when user has a choice. */

#define	__rDocWindow		20000	/* application's window */
#define	__rVScroll			20000	/* vertical scrollbar control */
#define	__rHScroll			20001	/* horizontal scrollbar control */
#define	__kErrStrings		20000	/* error string list */
#define __kBalloonStringsResID	20001	/* boolean help string list */

#define __rFontPrefStr		20000	/* "Monaco" text for defaut font name */
#define __rResumeMenuText	20001	/* "Resume" text for "Pause" menu item */
#define __rPauseMenuText	20002	/* "Pause" text for "Pause" menu item */
#define __rFinderHelpString	20003	/* balloon help text for icon in finder */

#define __rOutfilePrefStr	20004	/* resource for DEFAULT_OUTFILE_NAME */
	/* (only used if SavePref == 2 or 3) */

#define __rSavePref			20004
	/* values:  */
	/* 0 = default = DEFAULT_SAVE_PREF, save dialog will remind user to save. 	*/
	/* 1 = save dialog will not happen, no output will be saved unless user 	*/
	/* 		choose Save or Save As. */
	/* 2 = save dialog will not happen, an output file whose name is 			*/
	/*		specified by 'STR ' __rOutfilePrefStr will be created to save the 	*/
	/*		output, replacing any existing file with that name. 				*/
	/* note: for option 2, the window title is NOT set to be the filename 		*/
	/*		specified by 'STR ' __rOutfilePrefStr. If you want it to be the		*/
	/*		same, define DEFAULT_WINDOW_NAME to be same as DEFAULT_OUTFILE_NAME.*/

#define __rStopPref			20005
	/* values: */
	/* 0 = default = DEFAULT_STOP_PREF, stop dialog will remind user that he	*/
	/*		can continue execution. 											*/
	/* 1 = stop dialog will not be shown. If __rSavePref != 0, then the app 	*/
	/*		exits directly to the Finder, otherwise the app will stay alive		*/
	/*		so the user has a chance to save the output.						*/

#define __rWindowWidthPref	20006
	/* resource contains a 16-bit value that is used to set the maximum width	*/
	/* of the SIOW window.														*/


/* The following constants are used to identify menus items. The menu IDs 	*/
/*   have an "m" prefix and are here for continuity							*/
/*   The item numbers within each menu have an "i" prefix. 					*/

/* Apple menu */
#define	__iAbout				1

/* File menu */
#define	__iNew					1
#define	__iOpen					2
#define	__iClose				4
#define __iSave 				5
#define	__iSave_As				6
#define	__iPageSetup			8
#define	__iPrint				9
#define	__iQuit					11

/* Edit menu */
#define	__iUndo					1
#define	__iCut					3
#define	__iCopy					4
#define	__iPaste				5
#define	__iClear				6
#define	__iSelectAll			8

/* control menu */

#define __iInputEOF				1
#define __iPauseOutput			2
#define __iStop					3

/* The following are indicies into STR# __kErrStrings */

#define	__eWrongMachine			1	/* "You must run on 512Ke or later"; */
#define	__eSmallSize			2	/* "Application Memory Size is too small"; */
#define	__eNoMemory				3	/* "Not enough memory to run SIOW"; */
#define	__eNoSpaceCut			4	/* "Not enough memory to do Cut"; */
#define	__eNoCut				5	/* "Cannot do Cut"; */
#define	__eNoCopy				6	/* "Cannot do Copy"; */
#define	__eExceedPaste			7	/* "Cannot exceed 32,000 characters with Paste"; */
#define	__eNoSpacePaste			8	/* "Not enough memory to do Paste"; */
#define	__eNoWindow				9	/* "Cannot create window"; */
#define	__eExceedChar			10	/* "Cannot exceed 32,000 characters"; */
#define	__eNoPaste				11	/* "Cannot do Paste"; */
#define	__eNofont				12	/* "Font not found"; */
#define __eNoInputMoreThanReq	13 	/* "Your input was longer than this program was requesting; it will be truncated." */
#define __eDontNeedToSaveAgain	14

/* the following are buttons used in __rQuitAlert */

#define __kQuitCancelButton		2
#define __kQuitQuitButton		1

/* the following are buttons used in __rSaveAlert */

#define __kSaveSaveButton		1
#define __kSaveQuitButton		2

/* the following are buttons used in __rUserAlert (error) */

#define __kUserOKButton			1
#define __kUserStaticText		2
#define __kUserIcon				3

/* the following are buttons used in __rAboutAlert */

#define __kAboutOKButton		1

/* SIOW prefs */

/* use -d DEFAULT_FONT_NAME=Geneva (for example) in the rez command-line to override. */

#ifndef DEFAULT_FONT_NAME
	#define DEFAULT_FONT_NAME 	"Monaco"
#endif

/* use -d DEFAULT_FONT_SIZE=12 (for example) in the rez command-line to override.  */

#ifndef DEFAULT_FONT_SIZE
	#define DEFAULT_FONT_SIZE 	9
#endif

/* use -d DEFAULT_WINDOW_NAME=name in the rez command-line to override.  */

#ifndef DEFAULT_WINDOW_NAME
	#define DEFAULT_WINDOW_NAME 	"untitled"
#endif

/* use -d DEFAULT_OUTFILE_NAME=name in the rez command-line to override.  */
	
#ifndef DEFAULT_OUTFILE_NAME	/* see __rSavePref above */
	#define DEFAULT_OUTFILE_NAME	"output"
	/* (only used if SavePref == 2) */
#endif

/* use -d DEFAULT_SAVE_PREF=1 (or 2 or 3) in the rez command-line to override.  */

#ifndef DEFAULT_SAVE_PREF		/* see __rSavePref above */
	#define DEFAULT_SAVE_PREF	0
#endif

/* use -d DEFAULT_STOP_PREF=1 in the rez command-line to override.  */

#ifndef DEFAULT_STOP_PREF		/* see __rStopPref above */
	#define DEFAULT_STOP_PREF 	0
#endif

/* use -d DEFAULT_WINDOW_SIZE=2048 (for example) in the rez command-line to override.  */

#ifndef DEFAULT_WINDOW_SIZE
	#define DEFAULT_WINDOW_SIZE	576
#endif

#ifndef STACK_SIZE
#define STACK_SIZE 4096	
#endif

#ifndef REZ

	/* The following are “hooks” apps can use to wrestle control from 			*/
	/* SIOW at critical times. These variabled are defined to NULL in the SIOW 	*/
	/* library; assign your function pointers to these variables in your 		*/
	/* code.																	*/

	extern Boolean (*__siowEventHook)(EventRecord *theEvent);	
		/* User event loop hook -- called when user code is executing 			*/
		/* a read from stdin. Return true if your hook function has handled 	*/
		/* the event and wants the SIOW library to ignore the event. 			*/

	extern void (*__siowWindowHook)(WindowPtr theWindow);		
		/* User window is up hook -- called once when output window is created.	*/

	extern void (*__siowExitHook)(Boolean abort);				
		/* User “exit” hook -- called once when application is quitting.		*/

#endif

#endif

