{*-------------------------------------------------------------------------------*
 |																				 |
 |							<<< Cursor Control Unit >>> 						 |
 |																				 |
 |									 09/04/85									 |
 |																				 |
 |					  Copyright Apple Computer, Inc 1985, 1986					 |
 |								All rights reserved.							 |
 |																				 |
 *-------------------------------------------------------------------------------*}

UNIT CursorCtl;

  INTERFACE

	USES {$u MemTypes.p} MemTypes,
	  {$u QuickDraw.p} QuickDraw,
	  {$u OSIntf.p} OSIntf,
	  {$u ToolIntf.p} ToolIntf;

	TYPE
	  Cursors = (HIDDEN_CURSOR, I_BEAM_CURSOR, CROSS_CURSOR, PLUS_CURSOR,
				 WATCH_CURSOR, ARROW_CURSOR); {keep order}

	PROCEDURE RotateCursor(Counter: Integer);
   {Rotate the special "I am active" "beach ball" cursor one quarter
	revolution when the Counter MOD 32 is 0.  It is up to the caller to
	maintain an incementing counter as a function of the executing program
	in whatever way suitable.  If the counter is positive, the rotation is
	clockwise.	If negative, the rotation is counterclockwise. Note,
	RotateCursor just does a Mac SetCursor call for the proper cursor picture.
	It is assumed the cursor  is visible from a prior Show_Cursor call.}

	PROCEDURE SpinCursor(Increment: Integer);
   {SpinCursor is similar in function to RotateCursor, except that instead
	of passing a counter, an Increment is passed an added to a counter
	maintained here.  SpinCursor is provided for those users who do not
	happen to have a convenient counter handy but still want to use the
	spinning cursor.  A positive increment rotates the cursor clockwise, and
	a negative increment rotates the cursor counterclockwise.  A zero value
	for the increment resets the counter to zero.  Note, it is the increment,
	and not the value of the counter that determines the spin direction of
	the cursor.}

	PROCEDURE Hide_Cursor;
   {Hide the cursor if it is showing.  This is this unit's call to the Mac
	HideCursor routine. Thus the Mac cursor level is decremented by one when
	this routine is called.}

	PROCEDURE Show_Cursor(CursorKind: Cursors);
  {Increment the cursor level, which may have been decremented by Hide_Cursor,
   and display the specified cursor if the level becomes 0 (it is never
   incremented beyond 0).  The CursorKind is the kind of cursor to show.  It
   is one of the values HIDDEN_CURSOR, I_BEAM_CURSOR, CROSS_CURSOR,
   PLUS_CURSOR, WATCH_CURSOR, and ARROW_CURSOR. Except for HIDDEN_CURSOR, a
   Mac SetCursor is done for the specified cursor prior to doing a ShowCursor.
   HIDDEN_CURSOR just causes a ShowCursor call.}

END.
