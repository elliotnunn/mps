/*
	Menus.h -- Menu Manager

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __MENUS__
#define __MENUS__
#ifndef __TYPES__
#include <Types.h>
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
	Style chStyle;
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
#endif
