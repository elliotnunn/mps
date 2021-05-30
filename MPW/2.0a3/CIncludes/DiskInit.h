/*
	DiskInit.h -- Disk Initialization Package

	version	2.0a3

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __DSKINIT__
#define __DSKINIT__

typedef struct HFSDefaults {
	char sigWord[2];
	long abSize;
	long clpSize;
	long nxFreeFN;
	long btClpSize;
	short rsrv1;
	short rsrv2;
	short rsrv3;
} HFSDefaults;
#endif
