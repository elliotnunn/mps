/************************************************************

Created: Wednesday, October 26, 1988 at 11:49 PM
    Sound.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1986-1988
    All rights reserved

************************************************************/


#ifndef __SOUND__
#define __SOUND__

#ifndef __TYPES__
#include <Types.h>
#endif

#define swMode -1
#define ftMode 1
#define ffMode 0
#define synthCodeRsrc 'snth'
#define soundListRsrc 'snd '

/* synthesizer numbers for SndNewChannel */

#define noteSynth 1                 /*note synthesizer*/
#define waveTableSynth 3            /*wave table synthesizer*/
#define sampledSynth 5              /*sampled sound synthesizer*/
#define midiSynthIn 7               /*MIDI synthesizer in*/
#define midiSynthOut 9              /*MIDI synthesizer out*/

/* Param2 values */

#define midiInitChanFilter 0x10     /*set to initialize a MIDI channel*/
#define midiInitRawMode 0x100       /*set to send raw MIDI data*/
#define twelthRootTwo 1.05946309434
#define infiniteTime 0x7FFFFFFF

/* command numbers for SndDoCommand */

#define nullCmd 0
#define initCmd 1
#define freeCmd 2
#define quietCmd 3
#define flushCmd 4
#define waitCmd 10
#define pauseCmd 11
#define resumeCmd 12
#define callBackCmd 13
#define syncCmd 14
#define emptyCmd 15
#define tickleCmd 20
#define requestNextCmd 21
#define howOftenCmd 22
#define wakeUpCmd 23
#define availableCmd 24
#define versionCmd 25
#define scaleCmd 30
#define tempoCmd 31
#define noteCmd 40
#define restCmd 41
#define freqCmd 42
#define ampCmd 43
#define timbreCmd 44
#define waveTableCmd 60
#define phaseCmd 61
#define soundCmd 80
#define bufferCmd 81
#define rateCmd 82
#define midiDataCmd 100
#define setPtrBit 0x8000
#define stdQLength 128
#define dataPointerFlag 0x8000
#define initChanLeft 2              /*left stereo channel */
#define initChanRight 3             /*right stereo channel*/
#define initChan0 4                 /*channel 0 - wave table only*/
#define initChan1 5                 /*channel 1 - wave table only*/
#define initChan2 6                 /*channel 2 - wave table only*/
#define initChan3 7                 /*channel 3 - wave table only*/
#define initSRate22k 0x20           /*22k sampling rate*/
#define initSRate44k 0x30           /*44k sampling rate*/
#define initMono 0x80               /*monophonic channel*/
#define initStereo 0xC0             /*stereo channel*/
#define firstSoundFormat 1          /*first and only version we can deal with*/

typedef unsigned char FreeWave[30001];

typedef long Time;                  /* in half milliseconds */

typedef unsigned char Wave[256];
typedef Wave *WavePtr;



struct FFSynthRec {
    short mode;
    Fixed count;
    FreeWave waveBytes;
};

#ifndef __cplusplus
typedef struct FFSynthRec FFSynthRec;
#endif

typedef FFSynthRec *FFSynthPtr;

struct Tone {
    short count;
    short amplitude;
    short duration;
};

#ifndef __cplusplus
typedef struct Tone Tone;
#endif

typedef Tone Tones[5001];

struct SWSynthRec {
    short mode;
    Tones triplets;
};

#ifndef __cplusplus
typedef struct SWSynthRec SWSynthRec;
#endif

typedef SWSynthRec *SWSynthPtr;

struct FTSoundRec {
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
};

#ifndef __cplusplus
typedef struct FTSoundRec FTSoundRec;
#endif

typedef FTSoundRec *FTSndRecPtr;

struct FTSynthRec {
    short mode;
    FTSndRecPtr sndRec;
};

#ifndef __cplusplus
typedef struct FTSynthRec FTSynthRec;
#endif

typedef FTSynthRec *FTSynthPtr;

struct SndCommand {
    unsigned short cmd;
    short param1;
    long param2;
};

#ifndef __cplusplus
typedef struct SndCommand SndCommand;
#endif

typedef struct ModifierStub *ModifierStubPtr;
typedef struct SndChannel *SndChannelPtr;

typedef pascal void (*SndCompletionProcPtr)(void);
typedef pascal Boolean (*SndModifierProcPtr)(SndChannelPtr chan, SndCommand *cmd, ModifierStubPtr mod);
typedef pascal Boolean (*SndCallBackProcPtr)(SndChannelPtr chan, SndCommand cmd);



struct SndChannel {
    struct SndChannel *nextChan;
    ModifierStubPtr firstMod;
    SndCallBackProcPtr callBack;
    long userInfo;
    Time wait;                      /*The following is for internal Sound Manager use only.*/
    SndCommand cmdInProgress;
    short flags;
    short qLength;
    short qHead;                    /*next spot to read or -1 if empty*/
    short qTail;                    /*next spot to write = qHead if full*/
    SndCommand queue[128];
};

#ifndef __cplusplus
typedef struct SndChannel SndChannel;
#endif

struct ModifierStub {
    struct ModifierStub *nextStub;
    SndModifierProcPtr code;
    long userInfo;
    Time count;
    Time every;
    char flags;
    char hState;
};

#ifndef __cplusplus
typedef struct ModifierStub ModifierStub;
#endif

struct SoundHeader {
    Ptr samplePtr;                  /*if NIL then samples are in sampleArea*/
    unsigned long length;
    Fixed sampleRate;
    unsigned long loopStart;
    unsigned long loopEnd;
    short baseNote;
    char sampleArea[1];
};

#ifndef __cplusplus
typedef struct SoundHeader SoundHeader;
#endif

typedef SoundHeader *SoundHeaderPtr;

struct ModRef {
    unsigned short modNumber;
    long modInit;
};

#ifndef __cplusplus
typedef struct ModRef ModRef;
#endif

struct SndListResource {
    short format;
    short numModifiers;
    ModRef modifierPart[1];         /*This is a variable length array*/
    short numCommands;
    SndCommand commandPart[1];      /*This is a variable length array*/
    char dataPart[1];               /*This is a variable length array*/
};

#ifndef __cplusplus
typedef struct SndListResource SndListResource;
#endif

typedef SndListResource *SndListPtr;

#ifdef __safe_link
extern "C" {
#endif
pascal OSErr SndDoCommand(SndChannelPtr chan,const SndCommand *cmd,Boolean noWait)
    = 0xA803; 
pascal OSErr SndDoImmediate(SndChannelPtr chan,const SndCommand *cmd)
    = 0xA804; 
pascal OSErr SndNewChannel(SndChannelPtr *chan,short synth,long init,SndCallBackProcPtr userRoutine)
    = 0xA807; 
pascal OSErr SndDisposeChannel(SndChannelPtr chan,Boolean quietNow)
    = 0xA801; 
pascal OSErr SndPlay(SndChannelPtr chan,Handle sndHdl,Boolean async)
    = 0xA805; 
pascal OSErr SndControl(short id,SndCommand *cmd)
    = 0xA806; 
pascal void SetSoundVol(short level); 
pascal void GetSoundVol(short *level); 
pascal void StartSound(Ptr synthRec,long numBytes,SndCompletionProcPtr completionRtn); 
pascal void StopSound(void); 
pascal Boolean SoundDone(void); 
pascal OSErr SndAddModifier(SndChannelPtr chan,SndModifierProcPtr modifier,
    short id,long init)
    = 0xA802; 
#ifdef __safe_link
}
#endif

#endif
