{
  File: Sound.p

 Version: 1.0a1

 Copyright Apple Computer, Inc. 1986
 All Rights Reserved

}



UNIT Sound;

INTERFACE

	USES {$U MemTypes.p } MemTypes,
	  {$U QuickDraw.p } QuickDraw,
	  {$U npQuickDraw.p } npQuickDraw,
	  {$U OsIntf.p	  } OsIntf;


	CONST
		stdQLength		= 128;
		
		{Command Numbers}

		nullCmd			= 0;
		initCmd			= 1;
		quitCmd			= 2;
		killCmd			= 3;

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

		scaleCmd		= 30;
		tempoCmd		= 31;

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

		{Error Returns}
		noHardware			= -200;
		notEnoughHardware	= -201;
		queueFull			= -203;
		resProblem			= -204;
		badChannel			= -205;
		badFormat			= -206;

	TYPE
		Time			= LONGINT;
		
		SndCommand		= PACKED RECORD
							commandNum		: INTEGER;
							wordArg			: INTEGER;
							longArg			: LONGINT;
						  END;

		ModifierStub	= PACKED RECORD
							next			: ^ModifierStub;
							modifierCode	: ProcPtr;
							userInfo		: LONGINT;
							count,
							every			: Time;
						  END;
		ModifierStubPtr	= ^ ModifierStub;
		
		SndChannel		= PACKED RECORD
							next			: ^SndChannel;
							modifierChain	: ^ModifierStub;
							callBack		: ProcPtr;
							userInfo		: Ptr;
							
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
							samplePtr		: Ptr;	{if NIL then samples are in sampleArea}
							length			: LONGINT;
							sampleRate		: Fixed;
							loopStart,
							loopEnd			: LONGINT;
							baseNote		: INTEGER;
							{sampleArea		: PACKED ARRAY [0..0] OF Byte; -- not included, but logically here}
						  END;
		SoundHeaderPtr	= ^ SoundHeader;



	{Manager Routines}
	
	FUNCTION SndDoCommand(chan: SndChannelPtr; cmd: SndCommand; noWait: BOOLEAN): OSErr;
		INLINE $A803;
		
	FUNCTION SndDoImmediate(chan: SndChannelPtr; cmd: SndCommand): OSErr;
		INLINE $A804;
		
	FUNCTION SndAddModifier(chan: SndChannelPtr; modifierCode: ProcPtr; id: INTEGER; init: LONGINT): OSErr;
		INLINE $A802;
		
	FUNCTION SndNewChannel(VAR chan: SndChannelPtr; synth: INTEGER; init: LONGINT; userRoutine: ProcPtr): OSErr;
		INLINE $A807;
		
	FUNCTION SndDisposeChannel(chan: SndChannelPtr; killNow: BOOLEAN): OSErr;
		INLINE $A801;
		
	FUNCTION SndPlay(chan: SndChannelPtr; sList: Handle; async: BOOLEAN): OSErr;
		INLINE $A805;
		
	FUNCTION SndControl(id: INTEGER; VAR cmd: SndCommand): OSErr;
		INLINE $A806;



END.



