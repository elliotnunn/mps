#ifndef __CLPROCS__
#define __CLPROCS__

#ifndef __LISTCONTROL__
#include "ListControl.h"
#endif

extern CLActivateProcPtr		gclActivate;
extern CLClickProcPtr			gclClick;
extern CLCtlHitProcPtr			gclCtlHit;
extern CLFindActiveProcPtr		gclFindActive;
extern CLKeyProcPtr				gclKey;
extern CLNextProcPtr			gclNext;
extern CLViewFromListProcPtr	gclViewFromList;
extern CLWindActivateProcPtr	gclWindActivate;

extern CLVVariableSizeCellsProcPtr	gclvVariableSizeCells;
extern CLVGetCellRectProcPtr		gclvGetCellRect;
extern CLVUpdateProcPtr				gclvUpdate;
extern CLVAutoScrollProcPtr			gclvAutoScroll;
extern CLVSetSelectProcPtr			gclvSetSelect;
extern CLVClickProcPtr				gclvClick;
extern CLVAdjustScrollBarsProcPtr	gclvAdjustScrollBars;

#endif

