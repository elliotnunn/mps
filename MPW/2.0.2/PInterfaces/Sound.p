{
  File: Sound.p

 Copyright Apple Computer, Inc. 1986
 All Rights Reserved
}



UNIT Sound;

INTERFACE

	USES {$U MemTypes.p } MemTypes,
	  {$U QuickDraw.p } QuickDraw,
	  {$U OsIntf.p	  } OsIntf;

	CONST

		{Command Numbers}
		nullCmd			= 0;
		initCmd			= 1;
		freeCmd			= 2;
		quietCmd		= 3;
		flushCmd		= 4;
		waitCmd			= 10;
		pauseCmd		= 11;
		resumeCmd		= 12;
		callBackCmd		= 13;
		syncCmd			= 14;
		emptyCmd		= 15;
		tickleCmd		= 20;
		requestNextCmd	= 21;
		howOftenCmd		= 22;
		wakeUpCmd		= 23;
		availableCmd	= 24;
		noteCmd			= 40;
		restCmd			= 41;
		freqCmd			= 42;
		ampCmd			= 43;
		timbreCmd		= 44;
		waveTableCmd	= 60;
		phaseCmd		= 61;
		soundCmd		= 80;
		bufferCmd		= 81;
		rateCmd			= 82;
		midiDataCmd		= 100;
		
		{ Constant for setting pointer bit of command number }
		setPtrBit		= $8000;

		stdQLength		= 128;

		{Error Returns}
		noHardware			= -200;
		notEnoughHardware	= -201;
		queueFull			= -203;
		resProblem			= -204;
		badChannel			= -205;
		badFormat			= -206;
		
		{ Wave Table Synthesizer }
		initChanLeft		= $02;	{left stereo channel}
		initChanRight		= $03;	{right stereo channel}
		initChan0			= $04;	{channel 0 - wave table only}
		initChan1			= $05;	{channel 1 - wave table only}
		initChan2			= $06;	{channel 2 - wave table only}
		initChan3			= $07;	{channel 3 - wave table only}
		initSRate22k		= $20;	{22k sampling rate}
		initSRate44k		= $30;	{44k sampling rate}
		initMono			= $80;	{monophonic channel}
		initStereo			= $C0;	{stereo channel}

	TYPE
		Time			= LONGINT;
		
		SndCommand		= PACKED RECORD
							cmd			: INTEGER;
							param1		: INTEGER;
							param2		: LONGINT;
						  END;

		ModifierStub	= PACKED RECORD
							nextStub	: ^ModifierStub;
							code		: ProcPtr;
							userInfo	: LONGINT;
							count		: Time;
							every		: Time;
							flags		: SignedByte;
							hState		: SignedByte;
						  END;
		ModifierStubPtr	= ^ ModifierStub;
		
		SndChannel		= PACKED RECORD
							nextChan	: ^SndChannel;
							firstMod	: ^ModifierStub;
							callBack	: ProcPtr;
							userInfo	: Ptr;
							
							{The following is for internal Sound Manager use only.}
							wait			: Time;
							cmdInProgress	: SndCommand;
							flags			: INTEGER;
							qLength,
							qHead,
							qTail			: INTEGER;
							queue			: ARRAY [0..StdQLength-1] OF SndCommand;
						  END;
		SndChannelPtr	= ^ SndChannel;


		SoundHeader		= RECORD
							samplePtr	: Ptr;	{if NIL then samples are in sampleArea}
							length		: LONGINT;
							sampleRate	: Fixed;
							loopStart,
							loopEnd		: LONGINT;
							baseNote	: INTEGER;
							{sampleArea	: PACKED ARRAY [0..0] OF Byte; -- not included, but logically here}
						  END;
		SoundHeaderPtr	= ^ SoundHeader;



	{Manager Routines}
	
	FUNCTION SndDoCommand(chan: SndChannelPtr; cmd: SndCommand; noWait: BOOLEAN): OSErr;
		INLINE $A803;
		
	FUNCTION SndDoImmediate(chan: SndChannelPtr; cmd: SndCommand): OSErr;
		INLINE $A804;
		
	FUNCTION SndAddModifier(chan: SndChannelPtr; modifier: ProcPtr; id: INTEGER;
		init: LONGINT): OSErr;
		INLINE $A802;
		
	FUNCTION SndNewChannel(VAR chan: SndChannelPtr; synth: INTEGER; init: LONGINT; 
		userRoutine: ProcPtr): OSErr;
		INLINE $A807;
		
	FUNCTION SndDisposeChannel(chan: SndChannelPtr; quietNow: BOOLEAN): OSErr;
		INLINE $A801;
		
	FUNCTION SndPlay(chan: SndChannelPtr; sndHdl: Handle; async: BOOLEAN): OSErr;
		INLINE $A805;
		
	FUNCTION SndControl(id: INTEGER; VAR cmd: SndCommand): OSErr;
		INLINE $A806;

END.



