/*------------------------------------------------------------------------------
#
#	MultiFinder-Aware Simple Shapes Sample Application
#
#	CPlusShapesApp
#
#	This file: ShapesAppCommon.h - Common Header (C++ and Rez) for ShapesApp
#
#	Copyright © 1988 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	1.0 				3/89
#
#	Components:
#			CPlusShapesApp.make		March 1, 1989
#			TApplicationCommon.h	March 1, 1989
#			TApplication.h			March 1, 1989
#			TDocument.h				March 1, 1989
#			ShapesAppCommon.h		March 1, 1989
#			ShapesApp.h				March 1, 1989
#			ShapesDocument.h		March 1, 1989
#			TApplication.cp			March 1, 1989
#			TDocument.cp			March 1, 1989
#			ShapesApp.cp			March 1, 1989
#			ShapesDocument.cp		March 1, 1989
#			TApplication.r			March 1, 1989
#			ShapesApp.r				March 1, 1989
#
#   There are four main classes in this program. Each of
#   these classes has a definition (.h) file and an
#   implementation (.cp) file.  
#   
#   The TApplication class does all of the basic event
#   handling and initialization necessary for Mac Toolbox
#   applications. It maintains a list of TDocument objects,
#   and passes events to the correct TDocument class when
#   apropriate. 
#   
#   The TDocument class does all of the basic document
#   handling work. TDocuments are objects that are
#   associated with a window. Methods are provided to deal
#   with update, activate, mouse-click, key down, and other
#   events. Some additional classes which implement a
#   linked list of TDocument objects are provided. 
#   
#   The TApplication and TDocument classes together define
#   a basic framework for Mac applications, without having
#   any specific knowledge about the type of data being
#   displayed by the application's documents. They are a
#   (very) crude implementation of the MacApp application
#   model, without the sophisticated view heirarchies or
#   any real error handling. 
#   
#   The TShapesApp class is a subclass of TApplication. It
#   overrides several TApplication methods, including those
#   for handling menu commands and cursor adjustment, and
#   it does some necessary initialization.
#   
#   The TShapesDocument class is a subclass of TDocument. This
#   class contains most of the special purpose code for
#   shape drawing. In addition to overriding several of the
#   TDocument methods, it defines a few additional
#   methods which are used by the TShapesApp class to get
#   information on the document state.  
#
#------------------------------------------------------------------------------*/
#ifndef ShapesAppCommon_Defs
#define ShapesAppCommon_Defs

/*
	These definitions are shared by Rez and C++. We use #define statements
	instead of constants in this file because Rez doesn't support constants.
 */

/*	Determining an application's minimum size to request from MultiFinder depends
	on many things, each of which can be unique to an application's function,
	the anticipated environment, the developer's attitude of what constitutes
	reasonable functionality and performance, etc. Here is a list of some things to
	consider when determining the minimum size (and preferred size) for your
	application. The list is pretty much in order of importance, but by no means
	complete.
	
	1.	What is the minimum size needed to give almost 100 percent assurance
		that the application won't crash because it ran out of memory? This
		includes not only things that you do have direct control over such as
		checking for NIL handles and pointers, but also things that some
		feel are not so much under their control such as QuickDraw and the
		Segment Loader.
		
	2.	What kind of performance can a user expect from the application when
		it is running in the minimum memory configuration? Performance includes
		not only speed in handling data, but also things like how many documents
		can be opened, etc.
		
	3.	What are the typical sizes of scraps that a user might wish to work
		with when lauching or switching to your application? If the amount
		of memory is too small, the scrap will be purged from memory. This
		can be quite frustrating to the user.
		
	4.	The previous items have concentrated on topics that tend to cause an
		increase in the minimum size to request from MultiFinder. On the flip
		side, however, should be the consideration of what environments the
		application may be running in. There may be a high probability that
		many users with relatively small memory configurations will want to
		avail themselves of your application. Or, many users might want to use it
		while several other, possibly related/complementary applications are
		running. If that is the case, it would be helpful to have a fairly
		small minimum size.
	
	What we did for CPlusShapesApp:
	
		We determined the smallest heap size that CPlusShapesApp could have and
		still run (48K). For the preferred size we added enough space to permit:
			a. a little performance cushion (see 2, above) (12K)
		Result: 60K for preferred size
		
		Result: 48K for minimum size
*/
 
#define kPrefSize				60
#define kMinSize				48
	
/* kMinHeap - This is the minimum result from the following
	 equation:
			
			ORD(GetApplLimit) - ORD(ApplicZone)
			
	 for the application to run. It will insure that enough memory will
	 be around for reasonable-sized scraps, FKEYs, etc. to exist with the
	 application, and still give the application some 'breathing room'.
	 To derive this number, we ran under a MultiFinder partition that was
	 our requested minimum size, as given in the 'SIZE' resource. */
	 
#define	kMinHeap				 (34 * 1024)
	
/* kMinSpace - This is the minimum result from PurgeSpace, when called
	 at initialization time, for the application to run. This number acts
	 as a double-check to insure that there really is enough memory for the
	 application to run, including what has been taken up already by
	 pre-loaded resources, the scrap, code, and other sundry memory blocks. */
	 
#define	kMinSpace				(20 * 1024)

/* id of our STR# for error strings */
#define kShapesAppErrStrings	 129

/* The following are indicies into STR# resources. */
#define	eNoMemory				1
#define	eNoWindow				2

#define	rMenuBar	128				/* application's menu bar */
#define	rAboutAlert	128				/* about alert */
#define	rDocWindow	128				/* application's window */

/* The following constants are used to identify menus and their items. The menu IDs
   have an "m" prefix and the item numbers within each menu have an "i" prefix. */
#define	mApple					128		/* Apple menu */
#define	iAbout					1

#define	mFile					129		/* File menu */
#define	iNew					1
#define	iClose					4
#define	iQuit					12

#define	mEdit					130		/* Edit menu */
#define	iUndo					1
#define	iCut					3
#define	iCopy					4
#define	iPaste					5
#define	iClear					6

#define	mShapes					131		/* Shapes menu */
#define	iRRect					1
#define	iOval					2
#define	iArc					3
#define	iMove					5

#endif ShapesAppCommon_Defs
