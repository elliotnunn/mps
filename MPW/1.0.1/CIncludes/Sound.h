/*
	Sound.h -- Sound Driver

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __SOUND__
#define __SOUND__
#ifndef __TYPES__
#include <Types.h>
#endif

#define swMode (-1)
#define ftMode 1
#define ffMode 0
typedef unsigned char FreeWave[30001];
typedef struct FFSynthRec {
	short mode;
	Fixed count;
	FreeWave waveBytes;
} FFSynthRec,*FFSynthPtr;
typedef struct Tone {
	short count;
	short amplitude;
	short duration;
} Tone;
typedef Tone Tones[5001];
typedef struct SWSynthRec {
	short mode;
	Tones triplets;
} SWSynthRec,*SWSynthPtr;
typedef unsigned char Wave[256];
typedef Wave *WavePtr;
typedef struct FTSoundRec {
	short duration;
	Fixed sound1Rate;
	long sound1Phase;
	Fixed sound2Rate;
	long sound2Phase;
	Fixed sound3Rate;
	long sound3Phase;
	Fixed sound4Rate;
	long sound4Phase;
	WavePtr sound1Wave;
	WavePtr sound2Wave;
	WavePtr sound3Wave;
	WavePtr sound4Wave;
} FTSoundRec,*FTSndRecPtr;
typedef struct FTSynthRec {
	short mode;
	FTSndRecPtr sndRec;
} FTSynthRec,*FTSynthPtr;
#endif
