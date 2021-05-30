/*
 File: Sound.h

 version	2.0a3

 Copyright Apple Computer, Inc. 1986
 All Rights Reserved

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



/* Define __ALLNU__ to include routines for Macintosh SE or II. */
#ifdef __ALLNU__		


/* Error codes */
#define noErr				0
#define noHardware			-200
#define notEnoughHardware	-201
#define queueFull			-203
#define resProblem			-204
#define badChannel			-205
#define badFormat			-206

#define synthCodeRsrc		'snth'
#define soundListRsrc		'snd '

#define noteSynth			2
#define waveTableSynth		3
#define midiSynth			4
#define sampledSynth		5


#define twelthRootTwo		1.05946309434
typedef	long				Time;				/* in half milliseconds */
#define infiniteTime		0x7FFFFFFF



typedef struct SndCommand
{
	unsigned short			commandNum;
	short					wordArg;
	long					longArg;
}
	SndCommand;

#define nullCmd				0
#define initCmd				1
#define quitCmd				2
#define killCmd				3

#define waitCmd				10
#define pauseCmd			11
#define resumeCmd			12
#define callBackCmd			13
#define syncCmd				14
#define emptyCmd			15

#define tickleCmd			20
#define requestNextCmd		21
#define howOftenCmd			22
#define wakeUpCmd			23
#define availableCmd		24

#define scaleCmd			30
#define tempoCmd			31

#define noteCmd				40
#define restCmd				41
#define FreqCmd				42
#define ampCmd				43
#define timbreCmd			44

#define waveTableCmd		60
#define phaseCmd			61

#define soundCmd			80
#define bufferCmd			81
#define rateCmd				82

#define dataPointerFlag		0x8000

typedef struct ModifierStub
{
	struct ModifierStub		*next;
	ProcPtr					modifierCode;
	long					userInfo;
	Time					count,
							every;
}
	ModifierStub, *ModifierStubPtr;



#define StdQLength			128

typedef struct SndChannel
{
	struct SndChannel		*next;
	ModifierStubPtr			modifierChain;
	ProcPtr					callBack;
	long					userInfo;
	
	/* The following is for internal Sound Manager use only. */
	Time					wait;
	SndCommand				cmdInProgress;
	short					flags;
	short					qLength,
							qHead,		/* next spot to read or -1 if empty */
							qTail;		/* next spot to write, = qHead if full */
	SndCommand				queue[StdQLength];
}
	SndChannel, *SndChannelPtr;



/* Standard Synthesizer Structures */

/* Sampled Sound Synthesizer */

typedef struct SoundHeader
{
	char				* samplePtr;	/* if NIL then samples are in sampleArea */
	unsigned long		length;
	Fixed				sampleRate;
	unsigned long		loopStart,
						loopEnd;
	short				baseNote;
	char				sampleArea[0];
} SoundHeader, *SoundHeaderPtr;



/* Sound List Resource Format */

/* the zero array sizes are here mearly to get this through the compilier */

typedef struct SndListResource
{
	short				format;
	short				numModifiers;
	struct modRef {
		unsigned short	modNumber;
		long			modInit;
	}					modifierPart[0];
	short				numCommands;
	SndCommand			commandPart[0];
	char				dataPart[0];
} SndListResource, *SndListPtr;

#define FirstSoundFormat	0x0001		/* first and only version we can deal with */

/* User callable routines */
pascal OSErr SndDoCommand(chan, cmd, noWait)
	SndChannelPtr		chan;
	SndCommand			* cmd;
	Boolean				noWait;
extern;

pascal OSErr SndDoImmediate(chan, cmd)
	SndChannelPtr		chan;
	SndCommand			* cmd;
extern;

pascal OSErr SndAddModifier(chan, modifierCode, id, init)
	SndChannelPtr		chan;
	ProcPtr				modifierCode;
	short				id;
	long				init;
extern;

pascal OSErr SndNewChannel(chanVar, synth, init, userRoutine)
	SndChannelPtr		* chanVar;
	short				synth;
	long				init;
	ProcPtr				userRoutine;
extern;

pascal OSErr SndDisposeChannel(chan, killNow)
	SndChannelPtr		chan;
	Boolean				killNow;
extern;

pascal OSErr SndPlay(chan, sList, async)
	SndChannelPtr		chan;
	Handle				sList;
	Boolean				async;
extern;

pascal OSErr SndControl(id, cmdVar)
	short				id;
	SndCommand			* cmdVar;
extern;

#endif
#endif
