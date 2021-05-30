#ifndef __PPCTOOLBOX__
#include <PPCToolbox.h>
#endif


OSErr	DoIPCListPorts(short *sindx, short *reqCount, short *actCount,
					   LocationNamePtr  loc,
					   PortInfoArrayPtr retInfo,
					   PPCFilterProcPtr filter);

/* Used to generate a list of IPC ports, given a target.  For an example usage,
** see the file AEChess.c in the sample application Kibitz. 
** Note - The filter proc is never passed to the toolbox, it is called
** directly, so we can get away without using a UniversalProcPtr.  */

