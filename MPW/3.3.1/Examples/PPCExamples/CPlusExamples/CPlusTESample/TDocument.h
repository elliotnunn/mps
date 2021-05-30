/*------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Simple Application Framework
#
#	TDocument
#
#	TDocument.h		-	C++ source
#
#	Copyright © 1989 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	
#			1.20					10/91
#			1.10 					07/89
#			1.00 					04/89
#
#	Components:
#			TDocument.h				July 9, 1989
#			TDocument.cp			July 9, 1989
#
------------------------------------------------------------------------------*/

#ifndef TDocument_Defs
#define TDocument_Defs

// Include necessary interface files
#include <Types.h>
#include <Quickdraw.h>


// Define HiWrd and LoWrd macros for efficiency
#define HiWrd(aLong)	((short) (((aLong) >> 16) & 0xFFFF))
#define LoWrd(aLong)	((short) ((aLong) & 0xFFFF))

// Define TopLeft and BotRight macros for convenience. Notice the implicit
// dependency on the ordering of fields within a Rect
#define TopLeft(aRect)	(* (Point *) &(aRect).top)
#define BotRight(aRect)	(* (Point *) &(aRect).bottom)

const long kMaxSleepTime = 60;	// 1 second worth of ticks

/***********************************************************************/
//
//	Class definitions
//
/***********************************************************************/


//-----------------------------------------------------------------------
// TDocument -	some basic member functions are included. Although it is 
//				not a complete set, it does provide enough functionality
//				to develop subclasses. As you develop subclasses, you may
//				choose to incorporate common functionality of those
//				subclasses into the base class to reduce the complexity
//				of creating others.
//
	class TDocument 
#ifdef applec
	: public HandleObject	// we derive from handle object to prevent fragmentation
#endif
	{
		protected:
			WindowPtr fDocWindow;
		
		public:
			TDocument( short resID );		// our constructor - creates window using resID as template
			virtual ~TDocument();			// our destructor - disposes of window
		
			// you will need to override these in your subclasses,
			// since they are do-nothing routines by default...
				virtual void DoZoom		( short			/*partCode*/ )			{}
				virtual void DoGrow		( EventRecord*	/*theEvent*/ )			{}
				virtual void DoContent	( EventRecord*	/*theEvent*/ )			{}
				virtual void DoKeyDown	( EventRecord*	/*theEvent*/ )			{}
				virtual void DoActivate	( Boolean		/*becomingActive*/ )	{}
				virtual void DoUpdate	( void )								{}
		
			// file handling routines
				virtual void DoOpen		( void )	{};
				virtual void DoClose	( void )	{ delete this; };	// by default, we just delete ourself & let destructor do cleanup
				virtual void DoSave		( void )	{};
				virtual void DoSaveAs	( void )	{};
				virtual void DoRevert	( void )	{};
				virtual void DoPrint	( void )	{};
		
			// do standard edit menu actions
				virtual void DoUndo		( void )	{};
				virtual void DoCut		( void )	{};
				virtual void DoCopy		( void )	{};
				virtual void DoPaste	( void )	{};
				virtual void DoClear	( void )	{};
				virtual void DoSelectAll( void )	{};
		
			// idle time routines: you can use these to do cursor handling,
			// TE caret blinking, marquee effects, etc...
				virtual void DoIdle				( void ) 				{};
				virtual unsigned long CalcIdle	( void ) 				{ return kMaxSleepTime; };	// by default, we don't need idle
				virtual void AdjustCursor		( Point /*where*/ ) 	{};							// where is in local coords
			
			// query state of document - useful for adjusting menu state
				virtual Boolean HaveUndo		( void )	{ return false; };
				virtual Boolean HaveSelection	( void )	{ return false; };
				virtual Boolean HavePaste		( void )	{ return false; };
				virtual Boolean CanClose		( void )	{ return true;  };
				virtual Boolean CanSave			( void )	{ return false; };
				virtual Boolean CanSaveAs		( void )	{ return true;  };
				virtual Boolean CanRevert		( void )	{ return false; };
				virtual Boolean CanPrint		( void ) 	{ return false; };
		
			// utility routine to get window pointer for document
				inline WindowPtr GetDocWindow	( void ) 	{ return fDocWindow; }
				
	}; /* class TDocument */


//-----------------------------------------------------------------------
// TDocumentLink -	is a simple utility class which is used by the TDocumentList
// 					class below. You cannot allocate objects of this type yourself,
//					since its constructor is private. We get around this for
//					TDocumentList by making it a "friend" of this class. This is
//					a handy trick.
//
	class TDocumentLink
	{
		friend class TDocumentList;
	
		// class variables
			TDocumentLink*			fNext;			// the link to the next document
			TDocument*				fDoc;			// the document this link refers to
	
		// our constructor. Note that it can take args for convenience,
		// but that they default to nil.
			TDocumentLink( TDocumentLink *n = nil, TDocument *v = nil );
	
		// implementation of our TDocumentLink routines is done inline, for speed
			inline TDocumentLink*	GetNext	() 							{ return fNext;  };
			inline TDocument* 		GetDoc	() 							{ return fDoc;   };
			inline void				SetNext	( TDocumentLink* aLink ) 	{ fNext = aLink; };
			inline void 			SetDoc	( TDocument* aDoc ) 		{ fDoc = aDoc;   };
		
	}; /* class TDocumentLink */


//-----------------------------------------------------------------------
// TDocumentList -	is a simple linked list of documents, implemented C++ style. I
//					could have made a general linked list class & just made this a
//					subclass. This would have been a more general (and more
//					object-oriented) solution, but I did it from scratch in a
//					futile attempt at keeping the size of this program at a
//					reasonable level.
//
	class TDocumentList
	{
		// class variables
			TDocumentLink*	fDocList;	// the first link in our list
			int				fNumDocs;	// the number of elements in the list
		
		public:
			TDocumentList( void );		// our constructor
		
			virtual void		AddDoc		( TDocument* doc );
			virtual void		RemoveDoc	( TDocument* doc );
			virtual TDocument*	FindDoc		( WindowPtr window );		// find the TDocument associated with the window
		
			inline int			NumDocs() { return fNumDocs; }			// return number of active documents
		
	}; /* class TDocumentList */


#endif // TDocument_Defs
