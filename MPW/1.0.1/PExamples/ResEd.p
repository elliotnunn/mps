{
File ResEd.p

Copyright Apple Computer, Inc. 1984,1985,1986
All rights reserved.
}
{ Prototype Resource Edit Unit for instances of type editors. This should be
  USE'd by any Pascal implementation of a resource editor "driver".  The
  companion file ResEd68k.a.o should be linked with the ResXXXXEd.p.o to build
  the file for inclusion in ResEdit.

  There are two types of drivers: Pickers and Editors.	Pickers are given
  a resource type and should display all of that type in the current resfile
  in a suitable format.  If the Picker is given an open call AND there's an
  compatible Editor, it should give birth to the Editor.  The Editor driver
  is given a handle to the resource object and it should open up an edit
  window(s) for the user.

  Note that anybody can open Pickers and Editors so, for instance, a dialog
  Editor might open an icon Picker for the user to choose an appropriate icon.
  And, the user can, while in the icon Picker, open the icon editor to create
  an new icon if desired }


UNIT ResEd;


INTERFACE

USES Memtypes, Quickdraw, OSIntf, ToolIntf, PackIntf;

CONST

{Standard menus exported by the resource editor shell}

	FileMenu	= 2;

	NewItem 	= 1;
	OpenItem	= 2;
	OpnOther	= 3;
	OpnGnrl 	= 4;
	CloseItem	= 5;
	RevertItem	= 6;
	GetInfoItem = 7;
	QuitItem	= 9;

	EditMenu	= 3;

	UndoItem	= 1;
	CutItem 	= 3;
	CopyItem	= 4;
	PasteItem	= 5;
	ClearItem	= 6;
	DupItem 	= 8;

	fileAll 	 = $FFFFFEFF;	{ All enabled }
	fileNoOpen	 = $FFFFFEE3;	{ open disabled - for when editor on top}
	fileTop 	 = $FFFFFEE1;	{ Close, GetInfo, Revert, Quit enabled }
	fileClose	 = $FFFFFE21;	{ Close, Quit enabled }
	fileNoRevert = $FFFFFEBF;	{ No revert }
	fileNoInfo	 = $FFFFFE7F;	{ No get info }
	fileOpQuOnly = $FFFFFE1D;	{ Open and Quit enable }
	fileQuit	 = $FFFFFE01;	{ Only Quit enabled }
	fileNoAsMask = $FFFFFFF7;	{ Mask off the Open as… selection }

	editAll 	 = $FFFFFF7B;	{ All enabled }
	editNoUndo	 = $FFFFFF79;	{ All enabled except undo }
	editNoDup	 = $FFFFFE79;	{ All enabled except undo and duplicate }
	editNone	 = $FFFFFE01;	{ None enabled }
	editAcc 	 = $0000007B;	{ Common enabled for desk acc. }
	editCopy	 = $FFFFFE11;	{ Only copy enabled }

TYPE
	STR64 = STRING[64];

   {map entry def for new resource manager call}
	ResMapEntry = RECORD
		RID: INTEGER;
		RNameOff: INTEGER;
		RLocn: LongInt;
		RHndl: Handle;
	END;{ResMapEntry}

	{Each driver has its own object handle. This has to start with a handle }
	{to its parent's object followed by the name distinguishing the father  }
	{This name will be part of the son's window title. The next field should}
	{be the window of the obj (may be used by son to get back to the father }
	{(through the refcon in the windowRec). The rest of the handle can be of}
	{any format.}

	ParentPtr	 = ^ParentRec;
	ParentHandle = ^ParentPtr;

	ParentRec	 = RECORD
		father: ParentHandle;
		name:	str64;
		wind:	WindowPeek;
		rebuild:BOOLEAN;			{flag set by son to indicate that world}
									{has changed so father should rebuild list}
	END;

{ Standard picker record }

	PickPtr 	= ^PickRec; 		{Any type is OK here}
	PickHandle	= ^PickPtr;

	PickRec 	= RECORD
		father: ParentHandle;		{Back ptr to dad}
		fName:	STR64;				
		wind:	WindowPtr;			{Directory window}
		rebuild:BOOLEAN;
		pickID: INTEGER;			{ID of this picker}
		rType:	ResType;			{Type for picker}
		rNum:	INTEGER;			{resfile number}
		rSize:	LONGINT;			{size of a null resource}
		nInsts: INTEGER;			{Number of instances}
		instances:ListHandle;		{List of instances}
		drawProc:Ptr;				{List draw proc}
		scroll: ControlHandle;		{Scroll bar}
	END;

{ These routines are used to give birth to type pickers and editors.}

PROCEDURE CallPBirth( t: ResType; parent: ParentHandle; id: INTEGER );
PROCEDURE CallEBirth( thing: Handle; parent: ParentHandle; id: INTEGER );

{These routines are used to feed events and menu calls to the appropriate
code segments}
PROCEDURE CallEvent( VAR evt: EventRecord; object: LONGINT; id: INTEGER );
PROCEDURE CallMenu( menu, item: INTEGER; object: LONGINT; id: INTEGER );
PROCEDURE CallInfoUpdate(oldID,newID: INTEGER; object: LONGINT; id: INTEGER );

PROCEDURE PassMenu( menu, item: INTEGER; father: ParentHandle );

{Common utilities exported by main editor}

FUNCTION  WindAlloc: WindowPtr;
PROCEDURE WindFree( w: WindowPtr );
FUNCTION  WindList( w: WindowPtr; nAcross: INTEGER; pt: Point; drawProc:INTEGER ): ListHandle;
PROCEDURE WindOrigin( w: WindowPtr );
FUNCTION  WindSetup( width, height: INTEGER; t, s: STR255 ): WindowPtr;

{Extended Resource Manager routines which only act on one resource file, etc.}

FUNCTION  CurrentRes: INTEGER;
FUNCTION  Count1Res( t: ResType ): INTEGER;
FUNCTION  Count1Type: INTEGER;
FUNCTION  Get1Index( t: ResType; index: INTEGER ): Handle;
FUNCTION  Get1Res( t: ResType; id: INTEGER ): Handle;
PROCEDURE Get1IdxType( VAR theType:  ResType; i:  INTEGER);
FUNCTION  GetResLoad: BOOLEAN;
PROCEDURE Get1MapEntry(VAR theEntry: ResMapEntry; t: ResType; id: INTEGER);
PROCEDURE Get1IMapEntry(VAR theEntry: ResMapEntry; t: ResType; index: INTEGER);

PROCEDURE GiveEBirth(h: Handle; pick: PickHandle);
FUNCTION  RevertResource( h: Handle ): BOOLEAN;


{Miscellany}

PROCEDURE AbleMenu( menu: INTEGER; enable: LONGINT );
PROCEDURE AppRes;
FUNCTION  AddNewRes(hNew: Handle; t: ResType; idNew: INTEGER;
					 s: str255): BOOLEAN;
PROCEDURE BubbleUp( h: Handle );
FUNCTION  BuildType( t: ResType; l: ListHandle ): INTEGER;
PROCEDURE ClearHand( h: Handle );
FUNCTION  CopyRes( VAR h: Handle; makeID: BOOLEAN; resNew: INTEGER): Handle;
PROCEDURE ConcatStr( VAR str1: STR255; str2: STR255 );
PROCEDURE DoListEvt( e: EventRecord; l: ListHandle );
FUNCTION  DupPick( h: Handle; c: cell; pick: PickHandle ): Handle;
FUNCTION  ErrorCheck( err, msgID: INTEGER ): BOOLEAN;
FUNCTION  FileNewType(types: ListHandle; VAR s: str255): BOOLEAN;
PROCEDURE FixHand( s: LONGINT; h: Handle );
PROCEDURE GetStr( num, list: INTEGER; VAR str: STR255 );
FUNCTION  GetThePort: GrafPtr;
FUNCTION  HandleCheck( h: Handle; msgID: INTEGER ): BOOLEAN;
PROCEDURE MetaKeys( VAR cmd, shift, opt: BOOLEAN );
FUNCTION  NewRes( s: LONGINT; t: ResType; l: ListHandle; VAR n: INTEGER): Handle;
PROCEDURE PickEvent( VAR evt: EventRecord; pick: PickHandle );
PROCEDURE PickInfoUp( oldID,newID: INTEGER; pick: PickHandle );
PROCEDURE PickMenu( menu, item: INTEGER; pick: PickHandle );
FUNCTION  ResEdID: INTEGER;
PROCEDURE ResEverest;
PROCEDURE ScrapCopy( VAR h: Handle );
PROCEDURE ScrapEmpty;
PROCEDURE ScrapPaste( resFile: INTEGER );
PROCEDURE SetResChanged(h: Handle);
PROCEDURE SetETitle( h: Handle; VAR str: STR255 );
FUNCTION  ResEditRes: INTEGER;
PROCEDURE ShowInfo(h: Handle; dad: ParentHandle);

PROCEDURE RSeedFill(srcPtr,dstPtr: Ptr;
				   srcRow,dstRow,height,words: INTEGER;
				   seedH,seedV: INTEGER);
PROCEDURE RCalcMask(srcPtr,dstPtr: Ptr;
				   srcRow,dstRow,height,words: INTEGER);

END.



