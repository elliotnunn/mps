{
Created: Wednesday, October 26, 1988 at 11:39 PM
    Sound.p
    Pascal Interface to the Macintosh Libraries

    Copyright Apple Computer, Inc.  1986-1988
    All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
    UNIT Sound;
    INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingSound}
{$SETC UsingSound := 1}

{$I+}
{$SETC SoundIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$SETC UsingIncludes := SoundIncludes}

CONST
swMode = -1;
ftMode = 1;
ffMode = 0;
synthCodeRsrc = 'snth';
soundListRsrc = 'snd ';

{ synthesizer numbers for SndNewChannel }

noteSynth = 1;              {note synthesizer}
waveTableSynth = 3;         {wave table synthesizer}
sampledSynth = 5;           {sampled sound synthesizer}
midiSynthIn = 7;            {MIDI synthesizer in}
midiSynthOut = 9;           {MIDI synthesizer out}

{ Param2 values }

midiInitChanFilter = $10;   {set to initialize a MIDI channel}
midiInitRawMode = $100;     {set to send raw MIDI data}
twelthRootTwo = 1.05946309434;
infiniteTime = $7FFFFFFF;

{ command numbers for SndDoCommand }

nullCmd = 0;
initCmd = 1;
freeCmd = 2;
quietCmd = 3;
flushCmd = 4;
waitCmd = 10;
pauseCmd = 11;
resumeCmd = 12;
callBackCmd = 13;
syncCmd = 14;
emptyCmd = 15;
tickleCmd = 20;
requestNextCmd = 21;
howOftenCmd = 22;
wakeUpCmd = 23;
availableCmd = 24;
versionCmd = 25;
scaleCmd = 30;
tempoCmd = 31;
noteCmd = 40;
restCmd = 41;
freqCmd = 42;
ampCmd = 43;
timbreCmd = 44;
waveTableCmd = 60;
phaseCmd = 61;
soundCmd = 80;
bufferCmd = 81;
rateCmd = 82;
midiDataCmd = 100;
setPtrBit = $8000;
stdQLength = 128;
dataPointerFlag = $8000;
initChanLeft = 2;           {left stereo channel }
initChanRight = 3;          {right stereo channel}
initChan0 = 4;              {channel 0 - wave table only}
initChan1 = 5;              {channel 1 - wave table only}
initChan2 = 6;              {channel 2 - wave table only}
initChan3 = 7;              {channel 3 - wave table only}
initSRate22k = $20;         {22k sampling rate}
initSRate44k = $30;         {44k sampling rate}
initMono = $80;             {monophonic channel}
initStereo = $C0;           {stereo channel}
firstSoundFormat = 1;       {first and only version we can deal with}


TYPE


FreeWave = PACKED ARRAY [0..30000] OF Byte;

FFSynthPtr = ^FFSynthRec;
FFSynthRec = RECORD
    mode: INTEGER;
    count: Fixed;
    waveBytes: FreeWave;
    END;

Tone = RECORD
    count: INTEGER;
    amplitude: INTEGER;
    duration: INTEGER;
    END;

Tones = ARRAY [0..5000] OF Tone;

SWSynthPtr = ^SWSynthRec;
SWSynthRec = RECORD
    mode: INTEGER;
    triplets: Tones;
    END;

Wave = PACKED ARRAY [0..255] OF Byte;

WavePtr = ^Wave;

FTSndRecPtr = ^FTSoundRec;
FTSoundRec = RECORD
    duration: INTEGER;
    sound1Rate: Fixed;
    sound1Phase: LONGINT;
    sound2Rate: Fixed;
    sound2Phase: LONGINT;
    sound3Rate: Fixed;
    sound3Phase: LONGINT;
    sound4Rate: Fixed;
    sound4Phase: LONGINT;
    sound1Wave: WavePtr;
    sound2Wave: WavePtr;
    sound3Wave: WavePtr;
    sound4Wave: WavePtr;
    END;

FTSynthPtr = ^FTSynthRec;
FTSynthRec = RECORD
    mode: INTEGER;
    sndRec: FTSndRecPtr;
    END;

SndCommand = PACKED RECORD
    cmd: INTEGER;
    param1: INTEGER;
    param2: LONGINT;
    END;

Time = LONGINT;

ModifierStubPtr = ^ModifierStub;
ModifierStub = PACKED RECORD
    nextStub: ModifierStubPtr;
    code: ProcPtr;
    userInfo: LONGINT;
    count: Time;
    every: Time;
    flags: SignedByte;
    hState: SignedByte;
    END;

SndChannelPtr = ^SndChannel;
SndChannel = PACKED RECORD
    nextChan: SndChannelPtr;
    firstMod: ModifierStubPtr;
    callBack: ProcPtr;
    userInfo: LONGINT;
    wait: Time;             {The following is for internal Sound Manager use only.}
    cmdInProgress: SndCommand;
    flags: INTEGER;
    qLength: INTEGER;
    qHead: INTEGER;         {next spot to read or -1 if empty}
    qTail: INTEGER;         {next spot to write = qHead if full}
    queue: ARRAY [0..127] OF SndCommand;
    END;

SoundHeaderPtr = ^SoundHeader;
SoundHeader = RECORD
    samplePtr: Ptr;         {if NIL then samples are in sampleArea}
    length: LONGINT;
    sampleRate: Fixed;
    loopStart: LONGINT;
    loopEnd: LONGINT;
    baseNote: INTEGER;
    sampleArea: PACKED ARRAY [0..0] OF Byte;
    END;

ModRef = RECORD
    modNumber: INTEGER;
    modInit: LONGINT;
    END;



FUNCTION SndDoCommand(chan: SndChannelPtr;cmd: SndCommand;noWait: BOOLEAN): OSErr;
    INLINE $A803;
FUNCTION SndDoImmediate(chan: SndChannelPtr;cmd: SndCommand): OSErr;
    INLINE $A804;
FUNCTION SndNewChannel(VAR chan: SndChannelPtr;synth: INTEGER;init: LONGINT;
    userRoutine: ProcPtr): OSErr;
    INLINE $A807;
FUNCTION SndDisposeChannel(chan: SndChannelPtr;quietNow: BOOLEAN): OSErr;
    INLINE $A801;
FUNCTION SndPlay(chan: SndChannelPtr;sndHdl: Handle;async: BOOLEAN): OSErr;
    INLINE $A805;
FUNCTION SndControl(id: INTEGER;VAR cmd: SndCommand): OSErr;
    INLINE $A806;
PROCEDURE SetSoundVol(level: INTEGER);
PROCEDURE GetSoundVol(VAR level: INTEGER);
PROCEDURE StartSound(synthRec: Ptr;numBytes: LONGINT;completionRtn: ProcPtr);
PROCEDURE StopSound;
FUNCTION SoundDone: BOOLEAN;
FUNCTION SndAddModifier(chan: SndChannelPtr;modifier: ProcPtr;id: INTEGER;
    init: LONGINT): OSErr;
    INLINE $A802;

{$ENDC}    { UsingSound }

{$IFC NOT UsingIncludes}
    END.
{$ENDC}

