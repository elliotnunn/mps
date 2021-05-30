{
 	File:		Menus.p
 
 	Contains:	Menu Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.5
 
 	Copyright:	© 1984-1997 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Menus;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MENUS__}
{$SETC __MENUS__ := 1}

{$I+}
{$SETC MenusIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __MEMORY__}
{$I Memory.p}
{$ENDC}
{	Types.p														}
{		ConditionalMacros.p										}
{	MixedMode.p													}

{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{	QuickdrawText.p												}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
	*****************************************************************************
	*                                                                           *
	* All ≈Ref Types have reverted to their original Handle and Ptr Types.      *
	*                                                                           *
	*****************************************************************************

	Details:
	The original purpose of the STRICT_ conditionals and accessor macros was to
	help ease the transition to Copland.  Shared data structures are difficult
	to coordinate in a preemptive multitasking OS.  By hiding the fields in a
	WindowRecord and other data structures, we would begin the migration to the
	discipline wherein system data structures are completely hidden from
	applications.
	
	After many design reviews, we finally concluded that with this sort of
	migration, the system could never tell when an application was no longer
	peeking at a WindowRecord, and thus the data structure might never become
	system owned.  Additionally, there were many other limitations in the
	classic toolbox that were begging to be addressed.  The final decision was
	to leave the traditional toolbox as a compatibility mode.
	
	We also decided to use the Handle and Ptr based types in the function
	declarations.  For example, NewWindow now returns a WindowPtr rather than a
	WindowRef.  The Ref types are still defined in the header files, so all
	existing code will still compile exactly as it did before.  There are
	several reasons why we chose to do this:
	
	- The importance of backwards compatibility makes it unfeasible for us to
	enforce real opaque references in the implementation anytime in the
	foreseeable future.  Therefore, any opaque data types (e.g. WindowRef,
	ControlRef, etc.) in the documentation and header files would always be a
	fake veneer of opacity.
	
	- There exists a significant base of books and sample code that neophyte
	Macintosh developers use to learn how to program the Macintosh.  These
	books and sample code all use direct data access.  Introducing opaque data
	types at this point would confuse neophyte programmers more than it would
	help them.
	
	- Direct data structure access is used by nearly all Macintosh developers. 
	Changing the interfaces to reflect a false opacity would not provide any
	benefit to these developers.
	
	- Accessor functions are useful in and of themselves as convenience
	functions, without being tied to opaque data types.  We will complete and
	document the Windows and Dialogs accessor functions in an upcoming release
	of the interfaces.
}

CONST
	noMark						= 0;							{mark symbol for MarkItem}
{ menu defProc messages }
	mDrawMsg					= 0;
	mChooseMsg					= 1;
	mSizeMsg					= 2;
	mDrawItemMsg				= 4;
	mCalcItemMsg				= 5;
	textMenuProc				= 0;
	hMenuCmd					= 27;							{itemCmd == 0x001B ==> hierarchical menu}
	hierMenu					= -1;							{a hierarchical menu - for InsertMenu call}
	mPopUpMsg					= 3;							{menu defProc messages - place yourself}
	mctAllItems					= -98;							{search for all Items for the given ID}
	mctLastIDIndic				= -99;							{last color table entry has this in ID field}

TYPE
	MenuInfo = RECORD
		menuID:					INTEGER;
		menuWidth:				INTEGER;
		menuHeight:				INTEGER;
		menuProc:				Handle;
		enableFlags:			LONGINT;
		menuData:				Str255;
	END;

	MenuPtr = ^MenuInfo;
	MenuHandle = ^MenuPtr;

	MenuRef = MenuHandle;

	MenuDefProcPtr = ProcPtr;  { PROCEDURE MenuDef(message: INTEGER; theMenu: MenuHandle; VAR menuRect: Rect; hitPt: Point; VAR whichItem: INTEGER); }
	MenuBarDefProcPtr = ProcPtr;  { FUNCTION MenuBarDef(selector: INTEGER; message: INTEGER; parameter1: INTEGER; parameter2: LONGINT): LONGINT; }
	MenuHookProcPtr = ProcPtr;  { PROCEDURE MenuHook; }
	MBarHookProcPtr = ProcPtr;  { FUNCTION MBarHook(VAR menuRect: Rect): INTEGER; }
	MenuDefUPP = UniversalProcPtr;
	MenuBarDefUPP = UniversalProcPtr;
	MenuHookUPP = UniversalProcPtr;
	MBarHookUPP = UniversalProcPtr;

CONST
	uppMenuDefProcInfo = $0000FF80; { PROCEDURE (2 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param); }
	uppMenuBarDefProcInfo = $00003AB0; { FUNCTION (2 byte param, 2 byte param, 2 byte param, 4 byte param): 4 byte result; }
	uppMenuHookProcInfo = $00000000; { PROCEDURE ; }
	uppMBarHookProcInfo = $000000CF; { SPECIAL_CASE_PROCINFO( kSpecialCaseMBarHook ) }

FUNCTION NewMenuDefProc(userRoutine: MenuDefProcPtr): MenuDefUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMenuBarDefProc(userRoutine: MenuBarDefProcPtr): MenuBarDefUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMenuHookProc(userRoutine: MenuHookProcPtr): MenuHookUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMBarHookProc(userRoutine: MBarHookProcPtr): MBarHookUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallMenuDefProc(message: INTEGER; theMenu: MenuHandle; VAR menuRect: Rect; hitPt: Point; VAR whichItem: INTEGER; userRoutine: MenuDefUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallMenuBarDefProc(selector: INTEGER; message: INTEGER; parameter1: INTEGER; parameter2: LONGINT; userRoutine: MenuBarDefUPP): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallMenuHookProc(userRoutine: MenuHookUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallMBarHookProc(VAR menuRect: Rect; userRoutine: MBarHookUPP): INTEGER;
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters according to special case conventions.}
	{$ENDC}

TYPE
	MCEntry = RECORD
		mctID:					INTEGER;								{menu ID.  ID = 0 is the menu bar}
		mctItem:				INTEGER;								{menu Item. Item = 0 is a title}
		mctRGB1:				RGBColor;								{usage depends on ID and Item}
		mctRGB2:				RGBColor;								{usage depends on ID and Item}
		mctRGB3:				RGBColor;								{usage depends on ID and Item}
		mctRGB4:				RGBColor;								{usage depends on ID and Item}
		mctReserved:			INTEGER;								{reserved for internal use}
	END;

	MCEntryPtr = ^MCEntry;

	MCTable = ARRAY [0..0] OF MCEntry;

	MCTablePtr = ^MCTable;
	MCTableHandle = ^MCTablePtr;

	MenuCRsrc = RECORD
		numEntries:				INTEGER;								{number of entries}
		mcEntryRecs:			MCTable;								{ARRAY [1..numEntries] of MCEntry}
	END;

	MenuCRsrcPtr = ^MenuCRsrc;
	MenuCRsrcHandle = ^MenuCRsrcPtr;

FUNCTION GetMBarHeight : INTEGER;
	{$IFC NOT CFMSYSTEMCALLS}
	INLINE $3EB8, $0BAA;			{ MOVE.w $0BAA,(SP) }
	{$ENDC}

PROCEDURE InitMenus;
	{$IFC NOT GENERATINGCFM}
	INLINE $A930;
	{$ENDC}
FUNCTION NewMenu(menuID: INTEGER; menuTitle: ConstStr255Param): MenuHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A931;
	{$ENDC}
FUNCTION GetMenu(resourceID: INTEGER): MenuHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9BF;
	{$ENDC}
PROCEDURE DisposeMenu(theMenu: MenuHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A932;
	{$ENDC}
PROCEDURE AppendMenu(menu: MenuHandle; data: ConstStr255Param);
	{$IFC NOT GENERATINGCFM}
	INLINE $A933;
	{$ENDC}
PROCEDURE AppendResMenu(theMenu: MenuHandle; theType: ResType);
	{$IFC NOT GENERATINGCFM}
	INLINE $A94D;
	{$ENDC}
PROCEDURE InsertResMenu(theMenu: MenuHandle; theType: ResType; afterItem: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A951;
	{$ENDC}
PROCEDURE InsertMenu(theMenu: MenuHandle; beforeID: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A935;
	{$ENDC}
PROCEDURE DrawMenuBar;
	{$IFC NOT GENERATINGCFM}
	INLINE $A937;
	{$ENDC}
PROCEDURE InvalMenuBar;
	{$IFC NOT GENERATINGCFM}
	INLINE $A81D;
	{$ENDC}
PROCEDURE DeleteMenu(menuID: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A936;
	{$ENDC}
PROCEDURE ClearMenuBar;
	{$IFC NOT GENERATINGCFM}
	INLINE $A934;
	{$ENDC}
FUNCTION GetNewMBar(menuBarID: INTEGER): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9C0;
	{$ENDC}
FUNCTION GetMenuBar: Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A93B;
	{$ENDC}
PROCEDURE SetMenuBar(menuList: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A93C;
	{$ENDC}
PROCEDURE InsertMenuItem(theMenu: MenuHandle; itemString: ConstStr255Param; afterItem: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A826;
	{$ENDC}
PROCEDURE DeleteMenuItem(theMenu: MenuHandle; item: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A952;
	{$ENDC}
FUNCTION MenuKey(ch: CHAR): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A93E;
	{$ENDC}
PROCEDURE HiliteMenu(menuID: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A938;
	{$ENDC}
PROCEDURE SetMenuItemText(theMenu: MenuHandle; item: INTEGER; itemString: ConstStr255Param);
	{$IFC NOT GENERATINGCFM}
	INLINE $A947;
	{$ENDC}
PROCEDURE GetMenuItemText(theMenu: MenuHandle; item: INTEGER; VAR itemString: Str255);
	{$IFC NOT GENERATINGCFM}
	INLINE $A946;
	{$ENDC}
PROCEDURE DisableItem(theMenu: MenuHandle; item: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A93A;
	{$ENDC}
PROCEDURE EnableItem(theMenu: MenuHandle; item: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A939;
	{$ENDC}
PROCEDURE CheckItem(theMenu: MenuHandle; item: INTEGER; checked: BOOLEAN);
	{$IFC NOT GENERATINGCFM}
	INLINE $A945;
	{$ENDC}
PROCEDURE SetItemMark(theMenu: MenuHandle; item: INTEGER; markChar: CHAR);
	{$IFC NOT GENERATINGCFM}
	INLINE $A944;
	{$ENDC}
PROCEDURE GetItemMark(theMenu: MenuHandle; item: INTEGER; VAR markChar: CHAR);
	{$IFC NOT GENERATINGCFM}
	INLINE $A943;
	{$ENDC}
PROCEDURE SetItemIcon(theMenu: MenuHandle; item: INTEGER; iconIndex: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A940;
	{$ENDC}
PROCEDURE GetItemIcon(theMenu: MenuHandle; item: INTEGER; VAR iconIndex: Byte);
	{$IFC NOT GENERATINGCFM}
	INLINE $A93F;
	{$ENDC}
PROCEDURE SetItemStyle(theMenu: MenuHandle; item: INTEGER; chStyle: Style);
	{$IFC NOT GENERATINGCFM}
	INLINE $A942;
	{$ENDC}
PROCEDURE GetItemStyle(theMenu: MenuHandle; item: INTEGER; VAR chStyle: Style);
PROCEDURE CalcMenuSize(theMenu: MenuHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A948;
	{$ENDC}
FUNCTION CountMItems(theMenu: MenuHandle): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A950;
	{$ENDC}
FUNCTION GetMenuHandle(menuID: INTEGER): MenuHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A949;
	{$ENDC}
PROCEDURE FlashMenuBar(menuID: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A94C;
	{$ENDC}
PROCEDURE SetMenuFlash(count: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A94A;
	{$ENDC}
FUNCTION MenuSelect(startPt: Point): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A93D;
	{$ENDC}
PROCEDURE InitProcMenu(resID: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A808;
	{$ENDC}
PROCEDURE GetItemCmd(theMenu: MenuHandle; item: INTEGER; VAR cmdChar: CHAR);
	{$IFC NOT GENERATINGCFM}
	INLINE $A84E;
	{$ENDC}
PROCEDURE SetItemCmd(theMenu: MenuHandle; item: INTEGER; cmdChar: CHAR);
	{$IFC NOT GENERATINGCFM}
	INLINE $A84F;
	{$ENDC}
FUNCTION PopUpMenuSelect(menu: MenuHandle; top: INTEGER; left: INTEGER; popUpItem: INTEGER): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A80B;
	{$ENDC}
FUNCTION MenuChoice: LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA66;
	{$ENDC}
PROCEDURE DeleteMCEntries(menuID: INTEGER; menuItem: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA60;
	{$ENDC}
FUNCTION GetMCInfo: MCTableHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA61;
	{$ENDC}
PROCEDURE SetMCInfo(menuCTbl: MCTableHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA62;
	{$ENDC}
PROCEDURE DisposeMCInfo(menuCTbl: MCTableHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA63;
	{$ENDC}
FUNCTION GetMCEntry(menuID: INTEGER; menuItem: INTEGER): MCEntryPtr;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA64;
	{$ENDC}
PROCEDURE SetMCEntries(numEntries: INTEGER; menuCEntries: MCTablePtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA65;
	{$ENDC}
PROCEDURE InsertFontResMenu(theMenu: MenuHandle; afterItem: INTEGER; scriptFilter: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0400, $A825;
	{$ENDC}
PROCEDURE InsertIntlResMenu(theMenu: MenuHandle; theType: ResType; afterItem: INTEGER; scriptFilter: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0601, $A825;
	{$ENDC}
FUNCTION SystemEdit(editCmd: INTEGER): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9C2;
	{$ENDC}
PROCEDURE SystemMenu(menuResult: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9B5;
	{$ENDC}
{$IFC OLDROUTINENAMES }
PROCEDURE AddResMenu(theMenu: MenuHandle; theType: ResType);
	{$IFC NOT GENERATINGCFM}
	INLINE $A94D;
	{$ENDC}
PROCEDURE InsMenuItem(theMenu: MenuHandle; itemString: ConstStr255Param; afterItem: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A826;
	{$ENDC}
PROCEDURE DelMenuItem(theMenu: MenuHandle; item: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A952;
	{$ENDC}
PROCEDURE SetItem(theMenu: MenuHandle; item: INTEGER; itemString: ConstStr255Param);
	{$IFC NOT GENERATINGCFM}
	INLINE $A947;
	{$ENDC}
PROCEDURE GetItem(theMenu: MenuHandle; item: INTEGER; VAR itemString: Str255);
	{$IFC NOT GENERATINGCFM}
	INLINE $A946;
	{$ENDC}
FUNCTION GetMHandle(menuID: INTEGER): MenuHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A949;
	{$ENDC}
PROCEDURE DelMCEntries(menuID: INTEGER; menuItem: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA60;
	{$ENDC}
PROCEDURE DispMCInfo(menuCTbl: MCTableHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA63;
	{$ENDC}
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MenusIncludes}

{$ENDC} {__MENUS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
