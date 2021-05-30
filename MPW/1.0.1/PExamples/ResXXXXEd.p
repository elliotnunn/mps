{
File ResXXXXEd.p

Copyright Apple Computer, Inc. 1985,1986
All rights reserved.
}

UNIT ResXXXXed;
  {XXXX Editor for ResEdit}

  INTERFACE

	USES {$U Memtypes.p } Memtypes,
	  {$U QuickDraw.p } QuickDraw,
	  {$U OSIntf.p	} OSIntf,
	  {$U ToolIntf.p } ToolIntf,
	  {$U PackIntf.p } PackIntf,
	  {$U ResEd 	} ResEd;
	  {$R-} {Range checking off }

	TYPE
	  rXXXXPtr	  = ^rXXXXRec;
	  rXXXXHandle = ^rXXXXPtr;
	  rXXXXRec	  = RECORD
					  father: ParentHandle; {Back ptr to dad }
					  name: str64; {the name of this editor }
					  windPtr: WindowPtr; {This view's window}
					  rebuild: BOOLEAN; {Set TRUE if things have changed}
					  hXXXX: Handle; {The resource we are working on}
					  menuXXXX: Menuhandle; {our menu }
					END; {rXXXXRec}

	PROCEDURE EditBirth(Thing: Handle; Dad: ParentHandle);

	PROCEDURE PickBirth(t: ResType; Dad: ParentHandle);

	PROCEDURE DoEvent(VAR Evt: EventRecord; MyXXXX: rXXXXHandle);

	PROCEDURE DoInfoUpdate(oldID, newID: INTEGER; MyXXXX: rXXXXHandle);

	PROCEDURE DoMenu(Menu, Item: INTEGER; MyXXXX: rXXXXHandle);

  IMPLEMENTATION

	CONST
	  forever = FALSE;

	VAR
	  dummy: INTEGER;
	  {- -	-  -  - -  -  -  - -  -  -	- -  -	-  - -	-  -  - -  -  -}
	  {- -	-  -  - -  -  -  - -  -  -	- -  -	-  - -	-  -  - -  -  -}

	PROCEDURE EditBirth{Thing:Handle;Dad:ParentHandle};

	  VAR
		MyXXXX: rXXXXHandle;
		w: WindowPtr;
		s: str255;

	  BEGIN {EditBirth}
		{Prepare window title and request creation of a new window}
		s := 'Window';
		SetETitle(Handle(Thing), s);
		ConcatStr(s, ' from ');
		w := WindSetup(100, 100, s, Dad^^.name);
		{If we got a new window, then start up the editor}
		IF ORD(w) <> 0 THEN
		  BEGIN
		  FixHand(SIZEOF(WindowRecord), Handle(Thing)); {Make sure we have
														 enough room in }
		  {the handle for a complete window }
		  {record. (later this will be		}
		  {assigned to MyXXXX^^.hXXXX		}

		  {Get memory for and handle to our instance record}
		  MyXXXX := rXXXXHandle(NewHandle(SIZEOF(rXXXXRec))); {Need to do size
			check?}
		  HLock(Handle(MyXXXX));
		  WITH MyXXXX^^ DO
			BEGIN
	{Put information about this incarnation of the editor and the window it is }
		 {serving into our record.(always passed around in the handle MyXXXX.  }
			windPtr := w;
			father := Dad;
			hXXXX := Thing;
   {Let the main program know who is to manage this window by giving it both   }
			{our resource ID number and our instance record handle	   }
			WITH WindowPeek(w)^ DO
			  BEGIN
			  windowKind := ResEdID;
			  refCon := ORD(MyXXXX);
			  END; {WITH}
			END; {WITH}
		  {Set up menus,the view, etc. for this window}
		  HUnlock(Handle(MyXXXX));
		  END; {IF ORD(w)<>0}
	  END; {EditBirth}
	{- -  -  -	- -  -	-  - -	-  -  - -  -  -  - -  -  -	- -  -	-}

	PROCEDURE PickBirth{t:ResType;Dad:ParentHandle};

	  BEGIN {PickBirth}
	  END; {PickBirth}
	{- -  -  -	- -  -	-  - -	-  -  - -  -  -  - -  -  -	- -  -	-}

	PROCEDURE DoEvent{VAR Evt:EventRecord;MyXXXX:rXXXXHandle};

	  VAR
		MousePoint: Point;
		act: BOOLEAN;

	  BEGIN {DoEvent}
		BubbleUp(Handle(MyXXXX)); {Move our item up im memory}
		HLock(Handle(MyXXXX)); {Lock it down }
		WITH MyXXXX^^ DO
		  BEGIN {Handle event passed to us by main program}
		  {Just like a 'real' event loop, except…		  }
		  {there is no loop and we don't have to          }
		  {handle as much because the main program		  }
		  {will do all the stuff that doesn't apply       }
		  {to us.										  }
		  MousePoint := Evt.where; {Point at which the event occured }
		  SetPort(windPtr); {Set the port to our window }
		  GlobalToLocal(MousePoint); {Convert event location to local coords}
		  CASE Evt.what OF
			mouseDown:
			  BEGIN
			  END; {mouseDown}
			activateEvt:
			  BEGIN
			  AbleMenu(fileMenu, filetop);
			  act := ODD(Evt.modifiers);
			  IF act THEN
				BEGIN {Activate event}
				END   {Activate event}
			  ELSE
				BEGIN {Deactivate event}
				END;  {Deactivate event}
			  END {activateEvt} ;
			updateEvt:
			  BEGIN
			  END; {updateEvt}
			keyDown:
			  BEGIN
			  END; {keyDown}
		  END; {CASE evt.what}
		  END; {WITH MyXXXX^^}
		HUnlock(Handle(MyXXXX));
	  END; {DoEvent}
	{- -  -  -	- -  -	-  - -	-  -  - -  -  -  - -  -  -	- -  -	-}

	PROCEDURE DoInfoUpdate{oldID,newID:INTEGER;MyXXXX:rXXXXHandle};

	  VAR
		s: str255;

	  BEGIN {DoInfoUpdate}
		WITH MyXXXX^^ DO
		  BEGIN {Since our ID has changed, we need to change our window title}
		  s := 'Window';
		  SetETitle(Handle(hXXXX), s);
		  ConcatStr(s, ' from ');
		  ConcatStr(s, father^^.name);
		  SetWTitle(windPtr, s);
		  {Now, let our father object know that our ID has been changed}
		  CallInfoUpdate(oldID, newID, father^^.wind^.refCon,
						 father^^.wind^.windowKind);
		  END; {WITH MyXXXX^^}
	  END; {DoInfoUpdate}
	{- -  -  -	- -  -	-  - -	-  -  - -  -  -  - -  -  -	- -  -	-}

	PROCEDURE DoMenu{Menu,Item:INTEGER;MyXXXX:rXXXXHandle};

	  VAR
		saveRefNum: INTEGER;

	  PROCEDURE DoClose;

		BEGIN
		  WITH MyXXXX^^ DO
			BEGIN
			CloseWindow(windPtr); {Close the window }
			WindFree(windPtr); {Mark the window record as being available}
			InitCursor; {Make sure the cursor is the arrow cursor }
			{Delete any menus that we added and redraw menu bar   }
			{Be sure to dispose of any handles you are done with  }
			END; {WITH MyXXXX^^}
		  DisposHandle(Handle(MyXXXX));
		END; {DoClose}

	  BEGIN {DoMenu}
		BubbleUp(Handle(MyXXXX));
		HLock(Handle(MyXXXX));
		WITH MyXXXX^^ DO
		  BEGIN
		  SetPort(windPtr); {Set the port to our window}
	  {Again, we handle the menu stuff just as we would in a 'real' application}
	  {except that we only have to handle those items that apply to ourselves. }
		  CASE Menu OF
			fileMenu:
			  CASE Item OF
				CloseItem:
				  BEGIN
				  DoClose; {Close our window }
				  EXIT(DoMenu); {Return to main program}
				  END; {CloseItem}
				RevertItem:
				  BEGIN
				  {The area under window will need to be updated}
				  InvalRect(windPtr^.portrect);
				  {We will need to restore the cur resource file	}
				  {reference number when we are done here.			}
				  saveRefNum := CurrentRes;
				  {We are going to be using the resource file we	}
				  { came from.										}
				  UseResFile(HomeResFile(Handle(hXXXX)));
				  {Read in the old copy from disk (see documentation}
				  {for revertResource).  Clear it out unless this	}
				  { was a newly created resource, in which case 	}
				  {don't.                                           }
				  IF NOT RevertResource(Handle(hXXXX)) THEN
					BEGIN
					RmveResource(Handle(hXXXX));
					MyXXXX^^.father^^.rebuild := TRUE;
					DoClose;
					EXIT(DoMenu);
					END; {IF NOT RevertResource…}
				  {Go back to using old resource file.	   }
				  UseResFile(saveRefNum);
				  END; {RevertItem}
				GetInfoItem:
				  BEGIN
				  ShowInfo(Handle(hXXXX), ParentHandle(MyXXXX));
				  END; {GetInfoItem}
			  END; {FileMenu: CASE Item OF}
			EditMenu:
			  CASE Item OF
				CutItem:   ;
				CopyItem:  ;
				PasteItem: ;
				ClearItem: ;
			  END; {EditMenu: CASE Item OF}
		  END; {CASE Menu OF }
		  END; {WITH MyXXXX^^}
	  END; {DoMenu}
END.
