/*
	Menus.h -- Menu Manager interface 

	version	2.0a3
	
	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985-1987
	All rights reserved.
*/


#ifndef __MENUS__
#define __MENUS__
#ifndef __TYPES__
#include <Types.h>
#endif
#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif


#define noMark '\0'
#define mDrawMsg 0
#define mChooseMsg 1
#define mSizeMsg 2
#define textMenuProc 0
typedef struct MenuInfo {
	short menuID;
	short menuWidth;
	short menuHeight;
	Handle menuProc;
	long enableFlags;
	Str255 menuData;
} MenuInfo,*MenuPtr,**MenuHandle;
pascal void InitMenus()
	extern 0xA930;
MenuHandle NewMenu();
pascal MenuHandle GetMenu(resourceID)
	short resourceID;
	extern 0xA9BF;
pascal void DisposeMenu(theMenu)
	MenuHandle theMenu;
	extern 0xA932;
pascal void AddResMenu(theMenu,theType)
	MenuHandle theMenu;
	ResType theType;
	extern 0xA94D;
pascal void InsertResMenu(theMenu,theType,afterItem)
	MenuHandle theMenu;
	ResType theType;
	short afterItem;
	extern 0xA951;
pascal void InsertMenu(theMenu,beforeID)
	MenuHandle theMenu;
	short beforeID;
	extern 0xA935;
pascal void DrawMenuBar()
	extern 0xA937;
pascal void DeleteMenu(menuID)
	short menuID;
	extern 0xA936;
pascal void ClearMenuBar()
	extern 0xA934;
pascal Handle GetNewMBar(menuBarID)
	short menuBarID;
	extern 0xA9C0;
pascal Handle GetMenuBar()
	extern 0xA93B;
pascal void SetMenuBar(menuList)
	Handle menuList;
	extern 0xA93C;
pascal void DelMenuItem(theMenu,item)
	MenuHandle theMenu;
	short item;
	extern 0xA952;
pascal long MenuKey(ch)
	short ch;
	extern 0xA93E;
pascal void HiliteMenu(menuID)
	short menuID;
	extern 0xA938;
pascal void DisableItem(theMenu,item)
	MenuHandle theMenu;
	short item;
	extern 0xA93A;
pascal void EnableItem(theMenu,item)
	MenuHandle theMenu;
	short item;
	extern 0xA939;
pascal void CheckItem(theMenu,item,checked)
	MenuHandle theMenu;
	short item;
	Boolean checked;
	extern 0xA945;
pascal void SetItemMark(theMenu,item,markChar)
	MenuHandle theMenu;
	short item;
	short markChar;
	extern 0xA944;
pascal void GetItemMark(theMenu,item,markChar)
	MenuHandle theMenu;
	short item;
	short *markChar;
	extern 0xA943;
pascal void SetItemIcon(theMenu,item,icon)
	MenuHandle theMenu;
	short item;
	short icon;
	extern 0xA940;
pascal void GetItemIcon(theMenu,item,icon)
	MenuHandle theMenu;
	short item;
	short *icon;
	extern 0xA93F;
pascal void SetItemStyle(theMenu,item,chStyle)
	MenuHandle theMenu;
	short item;
	short chStyle;			/* face = Style (char); on stack as short */
	extern 0xA942;
pascal void GetItemStyle(menu,item,chStyle)
	MenuHandle menu;
	short item;
	Style *chStyle;
	extern 0xA941;
pascal void CalcMenuSize(theMenu)
	MenuHandle theMenu;
	extern 0xA948;
pascal short CountMItems(theMenu)
	MenuHandle theMenu;
	extern 0xA950;
pascal MenuHandle GetMHandle(menuID)
	short menuID;
	extern 0xA949;
pascal void FlashMenuBar(menuID)
	short menuID;
	extern 0xA94C;
pascal void SetMenuFlash(count)
	short count;
	extern 0xA94A;



/* Define __ALLNU__ to include routines for Macintosh SE or II. */
#ifdef __ALLNU__		


#define hMenuMark		0xC8 	/* '»' character indicates a hierarchical menu */

#define hMenuCmd		0x1B 	/* itemCmd == 0x1B ==> hierarchical menu */
#define scriptMenuCmd	0x1C 	/* itemCmd == 0x1C ==> item displayed in script font */
#define altMenuCmd1		0x1D 	/* itemCmd == 0x1D ==> unused indicator, reserved */
#define altMenuCmd2		0x1E 	/* itemCmd == 0x1E ==> unused indicator, reserved */
#define altMenuCmd3		0x1F 	/* itemCmd == 0x1F ==> unused indicator, reserved */

#define hierMenu		-1		/* a hierarchical menu - for InsertMenu call */
#define mbRightDir		0		/* menu went to the right (direction) */
#define mbLeftDir		1		/* menu went to the left (direction) */


typedef struct MenuList{
	short			lastMenu;		/* offset */
	short			lastRight;		/* pixels */
	char	   		mbVariant;		/* mbarproc variant */
	char	    	mbResID;		/* mbarproc rsrc ID */
	short	    	lastHMenu;		/* offset */
	short	    	menuTitleSave;	/* handle to bits behind
					 					inverted menu title */
} MenuList;

typedef struct MBarDataRec{
	Rect	    	mbRectSave;		/* menu's rectangle on screen */
	PixMapHandle	mbBitsSave;		/* handle to bits behind menu */
	short	   		mbMenuDir;		/* did menu go left or right? */
	short	    	mbMLOffset;		/* menu's MenuList offset */
	short	    	mbTopScroll;	/* save global TopMenuItem */
	short	    	mbBotScroll;	/* save global AtMenuBottom */
	long			mbReserved;		/* reserved by Apple */
} MBarDataRec;

typedef struct MBarProcRec{
	short	    	lastMBSave;		/* offset to last menu saved in structrue */
	Rect	    	mbItemRect;		/* rect of currently chosen menu item */
	Handle	   		mbCustomStorage; /* private storage for custom mbarprocs */
} MBarProcRec;

typedef struct MCInfoRec{
	short	   		mctID;			/* menu ID.  ID = 0 is the menu bar */
	short	   		mctItem;		/* menu Item. Item = 0 is a title */
	RGBColor	   	mctRGB1;   		/* usage depends on ID and Item */
	RGBColor	    mctRGB2;   		/* usage depends on ID and Item */
	RGBColor	    mctRGB3;   		/* usage depends on ID and Item */
	RGBColor		mctRGB4;   		/* usage depends on ID and Item */
	short	    	mctSanityChk;   /* reserved for internal use */
} MCInfoRec, *MCInfoPtr, **MCInfoHandle;


/* Menu Manager */

pascal void InitProcMenu(resID, aVariant)
	short resID;
	short aVariant;
	extern 0xA808;

/* Color Menu Manager */

pascal void DelMCEntries(menuID, menuItem)
	short menuID;
	short menuItem;
	extern 0xAA60;
pascal MCInfoHandle GetMCInfo()
	extern 0xAA61;
pascal void SetMCInfo(menuCTbl)
	MCInfoHandle menuCTbl;
	extern 0xAA62;
pascal void DispMCInfo(menuCTbl)
	MCInfoHandle menuCTbl;
	extern 0xAA63;
pascal MCInfoPtr GetMCEntry(menuID, menuItem)
	short menuID;
	short menuItem;
	extern 0xAA64;
pascal void SetMCEntries(numEntries, menuCEntries)
	short numEntries;
	MCInfoPtr menuCEntries;
	extern 0xAA65;
pascal long MenuChoice()
	extern 0xAA66;


#endif
#endif
