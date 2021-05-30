#ifndef __CTEPROCS__
#define __CTEPROCS__

#ifndef __TEXTEDITCONTROL__
#include "TextEditControl.h"
#endif

extern CTEActivateProcPtr           gcteActivate;
extern CTEClickProcPtr              gcteClick;
extern CTECtlHitProcPtr             gcteCtlHit;
extern CTEFindActiveProcPtr         gcteFindActive;
extern CTEKeyProcPtr                gcteKey;
extern CTENextProcPtr               gcteNext;
extern CTESetSelectProcPtr          gcteSetSelect;
extern CTEViewFromTEProcPtr         gcteViewFromTE;
extern CTEWindActivateProcPtr       gcteWindActivate;

#endif

