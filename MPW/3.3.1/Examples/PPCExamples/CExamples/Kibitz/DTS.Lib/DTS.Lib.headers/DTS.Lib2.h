#ifndef __L2DTS__
#define __L2DTS__

#include "DTS.Lib.h"

#ifndef __LISTCONTROL__
#include "ListControl.h"
#endif

#ifndef __TEXTEDITCONTROL__
#include "TextEditControl.h"
#endif

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __TREEOBJ__
#include "TreeObj.h"
#endif

typedef struct {
	DocHeaderInfo	fhInfo;
	TreeObjHndl		root;			/***** End of application framework file info. *****/
} TheDoc;

typedef struct {
	DocHeaderInfo	fhInfo;
	TreeObjHndl		root;			/***** Start of custom file info. *****/
	TEHandle		dump;
	TEHandle		display;
	ListHandle		plist;
	ListHandle		clist;
	ControlHandle	newView;
} ViewDoc;

typedef struct FileRec {
	FileStateRec	fileState;
	ConnectRec		connect;
	union {
		TheDoc	doc;
		ViewDoc	vh;
	} d;
} FileRec;

typedef struct {
	TreeObjHndl	undo;
	FileRecHndl	frHndl;
} RootObj;

#define mDerefRoot(hndl)     ((RootObj*)((*hndl) + 1))

#endif
