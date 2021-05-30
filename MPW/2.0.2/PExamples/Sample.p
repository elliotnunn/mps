{[n+,u+,r+,d+,#+,j=13-/40/1o,t=2,o=95] PasMat formatting options}
{------------------------------------------------------------------------------

FILE Sample.p
 Copyright Apple Computer, Inc. 1985-1987
 All rights reserved.

NAME
  Sample

DESCRIPTION
  A small sample application written by Macintosh User Education.
  It displays a single, fixed-size window in which the user can enter and edit
  text.

------------------------------------------------------------------------------}
{$R-} { Turn off range checking}
PROGRAM Sample;
 {
  The USES clause brings in the units containing the Pascal interfaces.
 }

  USES Memtypes, Quickdraw, OSIntf, ToolIntf;

  PROCEDURE _DataInit;
	EXTERNAL;

  CONST
	appleID 	 = 128; 			   {resource IDs/menu IDs for Apple, File and Edit menus}
	fileID		 = 129;
	editID		 = 130;

	appleM		 = 1;				   {index for each menu in myMenus (array of menu handles)}
	fileM		 = 2;
	editM		 = 3;

	menuCount	 = 3;				   {total number of menus}

	windowID	 = 128; 			   {resource ID for application's window}

	undoCommand  = 1;				   {menu item numbers identifying commands in Edit menu}
	cutCommand	 = 3;
	copyCommand  = 4;
	pasteCommand = 5;
	clearCommand = 6;

	aboutMeCommand = 1; 			   {menu item in apple menu for About sample item}

  VAR
	myMenus:	 ARRAY [1..menuCount] OF MenuHandle; {array of handles to the menus}
	dragRect:	 Rect;				   {rectangle used to mark bounds for dragging window}
	txRect: 	 Rect;				   {rectangle for text in application window}
	textH:		 TEHandle;			   {handle to information about the text}
	theChar:	 CHAR;				   {character typed on the keyboard or keypad}
	extended:	 BOOLEAN;			   {TRUE if user is Shift-clicking}
	doneFlag:	 BOOLEAN;			   {TRUE if user has chosen Quit command}
	myEvent:	 EventRecord;		   {information about an event}
	wRecord:	 WindowRecord;		   {information about the application window}
	myWindow:	 WindowPtr; 		   {pointer to wRecord}
	whichWindow: WindowPtr; 		   {ptr to window in which mouse button was pressed}
	mousePt:	 Point; 			   {point where cursor is located}
	iBeamHdl:	 CursHandle;		   {Handle to the I-beam cursor image}

	{[j=0] PasMat formatting option}

	{$S Initialize} 				   {The menu initialization code lives in its own code
										segment which can be unloaded once it's done with}

  PROCEDURE SetUpMenus;
  { set up menus and menu bar }

	VAR
	  i: INTEGER;

	BEGIN
  {Read menu descriptions from resource file into memory and store handles
  in myMenus array}
	  myMenus[appleM] := GetMenu(appleID); {read Apple menu from resource file}
	  AddResMenu(myMenus[appleM], 'DRVR'); {add desk accessory names to Apple menu}
	  myMenus[fileM] := GetMenu(fileID); {read file menu from resource file}
	  myMenus[editM] := GetMenu(editID); {read Edit menu from resource file}

	  FOR i := 1 TO menuCount DO InsertMenu(myMenus[i], 0); {install menus in menu bar}
	  DrawMenuBar;					   {and draw menu bar}
	END; {of SetUpMenus}

  {$S Main} 						   {the rest of the code belongs in the main segment}

  PROCEDURE ShowAboutMeDialog;
  { Display a dialog box in response to the 'About Sample' menu item}

	CONST
	  aboutMeDLOG = 128;
	  okButton = 1;
	  authorItem = 2;
	  languageItem = 3;

	VAR
	  itemHit, itemType: INTEGER;
	  itemHdl: Handle;
	  itemRect: Rect;
	  theDialog: DialogPtr;

	BEGIN
	  theDialog := GetNewDialog(aboutMeDLOG, NIL, WindowPtr( - 1));
	  GetDitem(theDialog, authorItem, itemType, itemHdl, itemRect);
	  SetIText(itemHdl, 'Ming The Merciless');
	  GetDitem(theDialog, languageItem, itemType, itemHdl, itemRect);
	  SetIText(itemHdl, 'Pascal');

	  REPEAT
		ModalDialog(NIL, itemHit)
	  UNTIL (itemHit = okButton);

	  CloseDialog(theDialog);
	END; {of ShowAboutMeDialog}

  PROCEDURE DoCommand(mResult: LONGINT);
  { Execute command specified by mResult, the result of MenuSelect }

	VAR
	  theItem: INTEGER; 			   {menu item number from mResult low-order word}
	  theMenu: INTEGER; 			   {menu number from mResult high-order word}
	  name: Str255; 				   {desk accessory name}
	  temp: INTEGER;
	  templ: LONGINT;

	BEGIN
	  theItem := LoWord(mResult);	   {call Toolbox Utility routines to}
	  theMenu := HiWord(mResult);	   {set menu item number and menu}
	  {number}

	  CASE theMenu OF				   {case on menu ID}

		appleID:
		  IF (theItem = aboutMeCommand) THEN
			ShowAboutMeDialog
		  ELSE
			BEGIN					   {call Menu Manager to get desk acc.}
			GetItem(myMenus[appleM], theItem, name); {name, and call Desk Mgr. to open}
			temp := OpenDeskAcc(name); {accessory (OpenDeskAcc result not used)}
			SetPort(myWindow);		   {call QuickDraw to restore applic.}
			END; {of appleID}		   {window as grafPort to draw in (may have been changed
										during OpenDeskAcc)}
		fileID: doneFlag := TRUE;	   {quit (main loop repeats until doneFlag is true)}

		editID:
		  BEGIN 					   {call Desk Manager to handle editing}
		  IF NOT SystemEdit(theItem - 1) {command if desk accessory window is the active
										  window}
			 THEN					   {applic. window is the active window}
			CASE theItem OF 		   {case on menu item (command) number call TextEdit to
										handle command}
			  cutCommand:
				BEGIN
				TECut(textH);
				templ := ZeroScrap;
				temp := TEtoScrap;
				END;
			  copyCommand:
				BEGIN
				TECopy(textH);
				templ := ZeroScrap;
				temp := TEtoScrap;
				END;
			  pasteCommand:
				BEGIN
				temp := TEfromScrap;
				TEPaste(textH);
				END;
			  clearCommand: TEDelete(textH);
			END; {of item CASE}
		  END; {of editID}

	  END; {of menu CASE}			   {to indicate completion of command,}
	  HiliteMenu(0);				   {call Menu Manager to unhighlight menu title
										(highlighted by MenuSelect)}
	END; {of DoCommand}

  BEGIN 							   {main program}
	{ Initialization }
	UnLoadSeg(@_DataInit);			   {remove data initialization code before any allocations}
	InitGraf(@thePort); 			   {initialize QuickDraw}
	InitFonts;						   {initialize Font Manager}
	FlushEvents(everyEvent, 0); 	   {call OS Event Mgr to discard any previous events}
	InitWindows;					   {initialize Window Manager}
	InitMenus;						   {initialize Menu Manager}
	TEInit; 						   {initialize TextEdit}
	InitDialogs(NIL);				   {initialize Dialog Manager}
	InitCursor; 					   {call QuickDraw to make cursor (pointer) an arrow}

	SetUpMenus; 					   {set up menus and menu bar}
	UnLoadSeg(@SetUpMenus); 		   {remove the once-only code}
	WITH screenBits.bounds DO		   {call QuickDraw to set dragging boundaries;}
	  SetRect(dragRect, 4, 24, right - 4, bottom - 4); {ensure at least 4 by 4 pixels will
														remain visible}
	doneFlag := FALSE;				   {flag to detect when Quit command is chosen}

	myWindow := GetNewWindow(windowID, @wRecord, POINTER( - 1)); {put up applic. window}
	SetPort(myWindow);				   {set current grafPort to this window}
	txRect := thePort^.portRect;	   {rectangle for text in window; InsetRect brings it}
	InsetRect(txRect, 4, 0);		   {in 4 pixels from left and right edges of window}
	textH := TENew(txRect, txRect);    {call TextEdit to prepare for receiving text}

	iBeamHdl := GetCursor(iBeamCursor);

	{ Main event loop }
	REPEAT							   {call Desk Manager to perform any periodic}
	  SystemTask;					   {actions defined for desk accessories}

	  IF (myWindow = frontWindow) THEN
		BEGIN
		GetMouse(mousePt);
		IF PtInRect(mousePt, myWindow^.portRect) THEN
		  SetCursor(iBeamHdl^^)
		ELSE
		  SetCursor(arrow);
		TEIdle(textH);				   {call TextEdit to make vertical bar blink}
		END;

	  IF GetNextEvent(everyEvent, myEvent) THEN {call Toolbox Event Manager to get the next
												 event that the application should handle}
		CASE myEvent.what OF		   {case on event type}

		  mouseDown:				   {mouse button down: call Window Mgr to find out where}
			CASE FindWindow(myEvent.where, whichWindow) OF

			  inSysWindow:			   {desk accessory window: call Desk Manager to handle it}
				SystemClick(myEvent, whichWindow);

			  inMenuBar:			   {menu bar: call Menu Manager to learn which command,
										then execute it}
				DoCommand(MenuSelect(myEvent.where));

			  inDrag:				   {title bar: call Window Manager to drag}
				DragWindow(whichWindow, myEvent.where, dragRect);

			  inContent:			   {body of application window: }
				BEGIN				   {call Window Manager to check whether it's the active
										window}
				IF whichWindow <> frontWindow THEN
				  SelectWindow(whichWindow) {and make it active if not}
				ELSE IF whichWindow = myWindow THEN
				  BEGIN 			   {already active}
				  GlobalToLocal(myEvent.where); {convert to window coordinates for TEClick}
				  extended := BAnd(myEvent.modifiers, shiftKey) <> 0;
				  TEClick(myEvent.where, extended, textH); {call TextEdit to process the event}
				  END;
				END; {of inContent}
			END; {of mouseDown}

		  keyDown, autoKey: 		   {key pressed once or held down to repeat}
			IF myWindow = frontWindow THEN
			  BEGIN
			  theChar := CHR(BAnd(myEvent.message, charCodeMask)); {get the char}
			  IF BAnd(myEvent.modifiers, cmdKey) <> 0 THEN {if Command key down, call Menu
															Manager to learn which}
				DoCommand(MenuKey(theChar))
			  ELSE
				TEKey(theChar, textH); {command, then execute it and pass char to TextEdit}
			  END; {of keyDown and autoKey}

		  activateEvt:
			IF WindowPtr(myEvent.message) = myWindow THEN
			  BEGIN
			  IF BAnd(myEvent.modifiers, activeFlag) <> 0 THEN {application window is becoming
																active: call}
				BEGIN				   {TextEdit to highlight selection or display }
				TEActivate(textH);	   {blinking vertical bar, and call Menu Mgr to}
				DisableItem(myMenus[editM], undoCommand); {disable Undo (since }
				END 				   {application doesn't support Undo)}
			  ELSE
				BEGIN				   {application window is becoming inactive: }
				TEDeactivate(textH);   {unhighlight selection or remove blinking }
				EnableItem(myMenus[editM], undoCommand); {vertical bar, and enable Undo (since
														  desk accessory may support it)}
				END;
			  END; {of activateEvt}

		  updateEvt:				   {window appearance needs updating}
			IF WindowPtr(myEvent.message) = myWindow THEN
			  BEGIN
			  BeginUpdate(WindowPtr(myEvent.message)); {call Window Mgr to begin update}
			  EraseRect(thePort^.portRect); {call QuickDraw to erase text area}
			  TEUpdate(thePort^.portRect, textH); {call TextEdit to update the text}
			  EndUpdate(WindowPtr(myEvent.message)); {call Window Mgr to end update}
			  END; {of updateEvt}

		END; {of event CASE}

	UNTIL doneFlag;
  END.
