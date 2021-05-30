/*
 	File:		QuickTimeMusic.h
 
 	Contains:	QuickTime interfaces
 
 	Version:	Technology:	Technology:	QuickTime 2.5
 				Package:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/
#ifndef __QUICKTIMEMUSIC__
#define __QUICKTIMEMUSIC__

#ifndef __COMPONENTS__
#include <Components.h>
#endif
#ifndef __IMAGECOMPRESSION__
#include <ImageCompression.h>
#endif
#ifndef __MOVIES__
#include <Movies.h>
#endif
#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
#ifndef __VIDEO__
#include <Video.h>
#endif
#ifndef __MEMORY__
#include <Memory.h>
#endif
#ifndef __SOUND__
#include <Sound.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif


enum {
	kaiToneDescType				= 'tone',
	kaiNoteRequestInfoType		= 'ntrq',
	kaiKnobListType				= 'knbl',
	kaiKeyRangeInfoType			= 'sinf',
	kaiSampleDescType			= 'sdsc',
	kaiSampleInfoType			= 'smin',
	kaiSampleDataType			= 'sdat',
	kaiInstInfoType				= 'iinf',
	kaiPictType					= 'pict',
	kaiWriterType				= '©wrt',
	kaiCopyrightType			= '©cpy',
	kaiOtherStrType				= 'str ',
	kaiInstrumentRefType		= 'iref',
	kaiLibraryInfoType			= 'linf',
	kaiLibraryDescType			= 'ldsc'
};

struct InstLibDescRec {
	Str31 							libIDName;
};
typedef struct InstLibDescRec InstLibDescRec;

struct InstKnobRec {
	long 							number;
	long 							value;
};
typedef struct InstKnobRec InstKnobRec;


enum {
	kInstKnobMissingUnknown		= 0,
	kInstKnobMissingDefault		= 1 << 0
};

struct InstKnobList {
	long 							knobCount;
	long 							knobFlags;
	InstKnobRec 					knob[1];
};
typedef struct InstKnobList InstKnobList;


enum {
	kMusicLoopTypeNormal		= 0,
	kMusicLoopTypePalindrome	= 1								/* back & forth*/
};


enum {
	instSamplePreProcessFlag	= 1 << 0
};

struct InstSampleDescRec {
	OSType 							dataFormat;
	short 							numChannels;
	short 							sampleSize;
	UnsignedFixed 					sampleRate;
	short 							sampleDataID;
	long 							offset;						/* offset within SampleData - this could be just for internal use*/
	long 							numSamples;					/* this could also just be for internal use, we'll see*/

	long 							loopType;
	long 							loopStart;
	long 							loopEnd;

	long 							pitchNormal;
	long 							pitchLow;
	long 							pitchHigh;
};
typedef struct InstSampleDescRec InstSampleDescRec;

typedef Handle AtomicInstrument;
typedef Ptr AtomicInstrumentPtr;

enum {
	kMusicComponentType			= 'musi'
};


enum {
	kSoftSynthComponentSubType	= 'ss  ',
	kGMSynthComponentSubType	= 'gm  '
};

typedef ComponentInstance MusicComponent;
/* MusicSynthesizerFlags*/

enum {
	kSynthesizerDynamicVoice	= 1 << 0,						/* can assign voices on the fly (else, polyphony is very important */
	kSynthesizerUsesMIDIPort	= 1 << 1,						/* must be patched through MIDI Manager */
	kSynthesizerMicrotone		= 1 << 2,						/* can play microtonal scales */
	kSynthesizerHasSamples		= 1 << 3,						/* synthesizer has some use for sampled data */
	kSynthesizerMixedDrums		= 1 << 4,						/* any part can play drum parts, total = instrument parts */
	kSynthesizerSoftware		= 1 << 5,						/* implemented in main CPU software == uses cpu cycles */
	kSynthesizerHardware		= 1 << 6,						/* is a hardware device (such as nubus, or maybe DSP?) */
	kSynthesizerDynamicChannel	= 1 << 7,						/* can move any part to any channel or disable each part. (else we assume it lives on all channels in masks) */
	kSynthesizerHogsSystemChannel = 1 << 8,						/* can be channelwise dynamic, but always responds on its system channel */
	kSynthesizerSlowSetPart		= 1 << 10,						/* SetPart() and SetPartInstrumentNumber() calls do not have rapid response, may glitch notes */
	kSynthesizerOffline			= 1 << 12,						/* can enter an offline synthesis mode */
	kSynthesizerGM				= 1 << 14,						/* synth is a GM device */
	kSynthesizerSoundLocalization = 1 << 16						/* synth is a GM device */
};

/*
 * Note that these controller numbers
 * are _not_ identical to the MIDI controller numbers.
 * These are _signed_ 8.8 values, and the LSB's are
 * always sent to a MIDI device. Controllers 32-63 are
 * reserved (for MIDI, they are LSB's for 0-31, but we
 * always send both).
 *
 * The full range, therefore, is -128.00 to 127.7f.
 *
 * _Excepting_ _volume_, all controls default to zero.
 *
 * Pitch bend is specified in fractional semitones! No
 * more "pitch bend range" nonsense. You can bend as far
 * as you want, any time you want.
*/
typedef SInt32 MusicController;

enum {
	kControllerModulationWheel	= 1,
	kControllerBreath			= 2,
	kControllerFoot				= 4,
	kControllerPortamentoTime	= 5,							/* portamento on/off is omitted, 0 time = 'off' */
	kControllerVolume			= 7,
	kControllerBalance			= 8,
	kControllerPan				= 10,							/* 0 - "default", 1 - n: positioned in output 1-n (incl fractions) */
	kControllerExpression		= 11,
	kControllerLever1			= 16,							/* general purpose controllers */
	kControllerLever2			= 17,							/* general purpose controllers */
	kControllerLever3			= 18,							/* general purpose controllers */
	kControllerLever4			= 19,							/* general purpose controllers */
	kControllerLever5			= 80,							/* general purpose controllers */
	kControllerLever6			= 81,							/* general purpose controllers */
	kControllerLever7			= 82,							/* general purpose controllers */
	kControllerLever8			= 83,							/* general purpose controllers */
	kControllerPitchBend		= 32,							/* positive & negative semitones, with 7 bits fraction */
	kControllerAfterTouch		= 33,							/* aka channel pressure */
	kControllerSustain			= 64,							/* boolean - positive for on, 0 or negative off */
	kControllerSostenuto		= 66,							/* boolean */
	kControllerSoftPedal		= 67,							/* boolean */
	kControllerReverb			= 91,
	kControllerTremolo			= 92,
	kControllerChorus			= 93,
	kControllerCeleste			= 94,
	kControllerPhaser			= 95,
	kControllerEditPart			= 113,							/* last 16 controllers 113-128 and above are global controllers which respond on part zero */
	kControllerMasterTune		= 114
};


enum {
	kControllerMaximum			= 0x7FFF,						/* +01111111.11111111 */
	kControllerMinimum			= 0x8000						/* -10000000.00000000 */
};

struct SynthesizerDescription {
	OSType 							synthesizerType;			/* synthesizer type (must be same as component subtype) */
	Str31 							name;						/* text name of synthesizer type */
	unsigned long 					flags;						/* from the above enum */
	unsigned long 					voiceCount;					/* maximum polyphony */

	unsigned long 					partCount;					/* maximum multi-timbrality (and midi channels) */
	unsigned long 					instrumentCount;			/* non gm, built in (rom) instruments only */
	unsigned long 					modifiableInstrumentCount;	/* plus n-more are user modifiable */
	unsigned long 					channelMask;				/* (midi device only) which channels device always uses */

	unsigned long 					drumPartCount;				/* maximum multi-timbrality of drum parts */
	unsigned long 					drumCount;					/* non gm, built in (rom) drumkits only */
	unsigned long 					modifiableDrumCount;		/* plus n-more are user modifiable */
	unsigned long 					drumChannelMask;			/* (midi device only) which channels device always uses */

	unsigned long 					outputCount;				/* number of audio outputs (usually two) */
	unsigned long 					latency;					/* response time in µSec */

	unsigned long 					controllers[4];				/* array of 128 bits */
	unsigned long 					gmInstruments[4];			/* array of 128 bits */
	unsigned long 					gmDrums[4];					/* array of 128 bits */
};
typedef struct SynthesizerDescription SynthesizerDescription;


enum {
	kVoiceCountDynamic			= -1							/* constant to use to specify dynamic voicing */
};

struct ToneDescription {
	OSType 							synthesizerType;			/* synthesizer type */
	Str31 							synthesizerName;			/* name of instantiation of synth */
	Str31 							instrumentName;				/* preferred name for human use */
	long 							instrumentNumber;			/* inst-number used if synth-name matches */
	long 							gmNumber;					/* Best matching general MIDI number */
};
typedef struct ToneDescription ToneDescription;


enum {
	kFirstDrumkit				= 16384,						/* (first value is "no drum". instrument numbers from 16384->16384+128 are drumkits, and for GM they are _defined_ drumkits! */
	kLastDrumkit				= (kFirstDrumkit + 128)
};

/* InstrumentMatch*/

enum {
	kInstrumentMatchSynthesizerType = 1,
	kInstrumentMatchSynthesizerName = 2,
	kInstrumentMatchName		= 4,
	kInstrumentMatchNumber		= 8,
	kInstrumentMatchGMNumber	= 16
};

/* KnobFlags*/

enum {
	kKnobReadOnly				= 16,							/* knob value cannot be changed by user or with a SetKnob call */
	kKnobInterruptUnsafe		= 32,							/* only alter this knob from foreground task time (may access toolbox) */
	kKnobKeyrangeOverride		= 64,							/* knob can be overridden within a single keyrange (software synth only) */
	kKnobGroupStart				= 128,							/* knob is first in some logical group of knobs */
	kKnobFixedPoint8			= 1024,
	kKnobFixedPoint16			= 2048,							/* One of these may be used at a time. */
	kKnobTypeNumber				= 0 << 12,
	kKnobTypeGroupName			= 1 << 12,						/* "knob" is really a group name for display purposes */
	kKnobTypeBoolean			= 2 << 12,						/* if range is greater than 1, its a multi-checkbox field */
	kKnobTypeNote				= 3 << 12,						/* knob range is equivalent to MIDI keys */
	kKnobTypePan				= 4 << 12,						/* range goes left/right (lose this? ) */
	kKnobTypeInstrument			= 5 << 12,						/* knob value = reference to another instrument number */
	kKnobTypeSetting			= 6 << 12,						/* knob value is 1 of n different things (eg, fm algorithms) popup menu */
	kKnobTypeMilliseconds		= 7 << 12,						/* knob is a millisecond time range */
	kKnobTypePercentage			= 8 << 12,						/* knob range is displayed as a Percentage */
	kKnobTypeHertz				= 9 << 12,						/* knob represents frequency */
	kKnobTypeButton				= 10 << 12						/* momentary trigger push button */
};


enum {
	kUnknownKnobValue			= 0x7FFFFFFF,					/* a knob with this value means, we don't know it. */
	kDefaultKnobValue			= 0x7FFFFFFE					/* used to SET a knob to its default value. */
};

struct KnobDescription {
	Str63 							name;
	long 							lowValue;
	long 							highValue;
	long 							defaultValue;				/* a default instrument is made of all default values */
	long 							flags;
	long 							knobID;
};
typedef struct KnobDescription KnobDescription;

struct GCInstrumentData {
	ToneDescription 				tone;
	long 							knobCount;
	long 							knob[1];
};
typedef struct GCInstrumentData GCInstrumentData;

typedef GCInstrumentData *GCInstrumentDataPtr;
typedef GCInstrumentDataPtr *GCInstrumentDataHandle;
struct InstrumentAboutInfo {
	PicHandle 						p;
	Str255 							author;
	Str255 							copyright;
	Str255 							other;
};
typedef struct InstrumentAboutInfo InstrumentAboutInfo;


enum {
	kMusicPacketPortLost		= 1,							/* received when application loses the default input port */
	kMusicPacketPortFound		= 2,							/* received when application gets it back out from under someone else's claim */
	kMusicPacketTimeGap			= 3								/* data[0] = number of milliseconds to keep the MIDI line silent */
};

struct MusicMIDIPacket {
	unsigned short 					length;
	unsigned long 					reserved;					/* if length zero, then reserved = above enum */
	UInt8 							data[249];
};
typedef struct MusicMIDIPacket MusicMIDIPacket;

typedef pascal ComponentResult (*MusicMIDISendProcPtr)(MusicComponent self, long refCon, MusicMIDIPacket *mmp);

#if GENERATINGCFM
typedef UniversalProcPtr MusicMIDISendUPP;
#else
typedef MusicMIDISendProcPtr MusicMIDISendUPP;
#endif
typedef pascal ComponentResult (*MusicMIDIReadHookProcPtr)(MusicMIDIPacket *mp, long myRefCon);

#if GENERATINGCFM
typedef UniversalProcPtr MusicMIDIReadHookUPP;
#else
typedef MusicMIDIReadHookProcPtr MusicMIDIReadHookUPP;
#endif

enum {
	notImplementedMusicErr		= (0x80000000 | (0xFFFF & (notImplementedMusicOSErr))),
	cantSendToSynthesizerErr	= (0x80000000 | (0xFFFF & (cantSendToSynthesizerOSErr))),
	cantReceiveFromSynthesizerErr = (0x80000000 | (0xFFFF & (cantReceiveFromSynthesizerOSErr))),
	illegalVoiceAllocationErr	= (0x80000000 | (0xFFFF & (illegalVoiceAllocationOSErr))),
	illegalPartErr				= (0x80000000 | (0xFFFF & (illegalPartOSErr))),
	illegalChannelErr			= (0x80000000 | (0xFFFF & (illegalChannelOSErr))),
	illegalKnobErr				= (0x80000000 | (0xFFFF & (illegalKnobOSErr))),
	illegalKnobValueErr			= (0x80000000 | (0xFFFF & (illegalKnobValueOSErr))),
	illegalInstrumentErr		= (0x80000000 | (0xFFFF & (illegalInstrumentOSErr))),
	illegalControllerErr		= (0x80000000 | (0xFFFF & (illegalControllerOSErr))),
	midiManagerAbsentErr		= (0x80000000 | (0xFFFF & (midiManagerAbsentOSErr))),
	synthesizerNotRespondingErr	= (0x80000000 | (0xFFFF & (synthesizerNotRespondingOSErr))),
	synthesizerErr				= (0x80000000 | (0xFFFF & (synthesizerOSErr))),
	illegalNoteChannelErr		= (0x80000000 | (0xFFFF & (illegalNoteChannelOSErr))),
	noteChannelNotAllocatedErr	= (0x80000000 | (0xFFFF & (noteChannelNotAllocatedOSErr))),
	tunePlayerFullErr			= (0x80000000 | (0xFFFF & (tunePlayerFullOSErr))),
	tuneParseErr				= (0x80000000 | (0xFFFF & (tuneParseOSErr)))
};


enum {
	kGetAtomicInstNoExpandedSamples = 1 << 0,
	kGetAtomicInstNoOriginalSamples = 1 << 1,
	kGetAtomicInstNoSamples		= kGetAtomicInstNoExpandedSamples | kGetAtomicInstNoOriginalSamples,
	kGetAtomicInstNoKnobList	= 1 << 2,
	kGetAtomicInstNoInstrumentInfo = 1 << 3,
	kGetAtomicInstOriginalKnobList = 1 << 4,
	kGetAtomicInstAllKnobs		= 1 << 5						/* return even those that are set to default*/
};

/*
 For non-gm instruments, instrument number of tone description == 0
 If you want to speed up while running, slam the inst num with what Get instrument number returns
 All missing knobs are slammed to the default value
*/

enum {
	kSetAtomicInstKeepOriginalInstrument = 1 << 0,
	kSetAtomicInstShareAcrossParts = 1 << 1,					/* inst disappears when app goes away*/
	kSetAtomicInstCallerTosses	= 1 << 2,						/* the caller isn't keeping a copy around (for NASetAtomicInstrument)*/
	kSetAtomicInstCallerGuarantees = 1 << 3,					/* the caller guarantees a copy is around*/
	kSetAtomicInstInterruptSafe	= 1 << 4,						/* dont move memory at this time (but process at next task time)*/
	kSetAtomicInstDontPreprocess = 1 << 7						/* perform no further preprocessing because either 1)you know the instrument is digitally clean, or 2) you got it from a GetPartAtomic*/
};


enum {
	kInstrumentNamesModifiable	= 1,
	kInstrumentNamesBoth		= 2
};

/*
 * Structures specific to the GenericMusicComponent
*/

enum {
	kGenericMusicComponentSubtype = 'gene'
};

struct GenericKnobDescription {
	KnobDescription 				kd;
	long 							hw1;						/* driver defined */
	long 							hw2;						/* driver defined */
	long 							hw3;						/* driver defined */
	long 							settingsID;					/* resource ID list for boolean and popup names */
};
typedef struct GenericKnobDescription GenericKnobDescription;

struct GenericKnobDescriptionList {
	long 							knobCount;
	GenericKnobDescription 			knob[1];
};
typedef struct GenericKnobDescriptionList GenericKnobDescriptionList;

typedef GenericKnobDescriptionList *GenericKnobDescriptionListPtr;
typedef GenericKnobDescriptionListPtr *GenericKnobDescriptionListHandle;
/* knobTypes for MusicDerivedSetKnob */

enum {
	kGenericMusicKnob			= 1,
	kGenericMusicInstrumentKnob	= 2,
	kGenericMusicDrumKnob		= 3,
	kGenericMusicGlobalController = 4
};


enum {
	kGenericMusicResFirst		= 0,
	kGenericMusicResMiscStringList = 1,							/* STR# 1: synth name, 2:about author,3:aboutcopyright,4:aboutother */
	kGenericMusicResMiscLongList = 2,							/* Long various params, see list below */
	kGenericMusicResInstrumentList = 3,							/* NmLs of names and shorts, categories prefixed by '••' */
	kGenericMusicResDrumList	= 4,							/* NmLs of names and shorts */
	kGenericMusicResInstrumentKnobDescriptionList = 5,			/* Knob */
	kGenericMusicResDrumKnobDescriptionList = 6,				/* Knob */
	kGenericMusicResKnobDescriptionList = 7,					/* Knob */
	kGenericMusicResBitsLongList = 8,							/* Long back to back bitmaps of controllers, gminstruments, and drums */
	kGenericMusicResModifiableInstrumentHW = 9,					/* Shrt same as the hw shorts trailing the instrument names, a shortlist */
	kGenericMusicResGMTranslation = 10,							/* Long 128 long entries, 1 for each gm inst, of local instrument numbers 1-n (not hw numbers) */
	kGenericMusicResROMInstrumentData = 11,						/* knob lists for ROM instruments, so the knob values may be known */
	kGenericMusicResAboutPICT	= 12,							/* picture for aboutlist. must be present for GetAbout call to work */
	kGenericMusicResLast		= 13
};

/* elements of the misc long list */

enum {
	kGenericMusicMiscLongFirst	= 0,
	kGenericMusicMiscLongVoiceCount = 1,
	kGenericMusicMiscLongPartCount = 2,
	kGenericMusicMiscLongModifiableInstrumentCount = 3,
	kGenericMusicMiscLongChannelMask = 4,
	kGenericMusicMiscLongDrumPartCount = 5,
	kGenericMusicMiscLongModifiableDrumCount = 6,
	kGenericMusicMiscLongDrumChannelMask = 7,
	kGenericMusicMiscLongOutputCount = 8,
	kGenericMusicMiscLongLatency = 9,
	kGenericMusicMiscLongFlags	= 10,
	kGenericMusicMiscLongFirstGMHW = 11,						/* number to add to locate GM main instruments */
	kGenericMusicMiscLongFirstGMDrumHW = 12,					/* number to add to locate GM drumkits */
	kGenericMusicMiscLongFirstUserHW = 13,						/* First hw number of user instruments (presumed sequential) */
	kGenericMusicMiscLongLast	= 14
};

struct GCPart {
	long 							hwInstrumentNumber;			/* internal number of recalled instrument */
	short 							controller[128];			/* current values for all controllers */
	long 							volume;						/* ctrl 7 is special case */
	long 							polyphony;
	long 							midiChannel;				/* 1-16 if in use */
	GCInstrumentData 				id;							/* ToneDescription & knoblist, uncertain length */
};
typedef struct GCPart GCPart;

/*
 * Calls specific to the GenericMusicComponent
*/

enum {
	kMusicGenericRange			= 0x0100,
	kMusicDerivedRange			= 0x0200
};

/*
 * Flags in GenericMusicConfigure call
*/

enum {
	kGenericMusicDoMIDI			= 1 << 0,						/* implement normal MIDI messages for note, controllers, and program changes 0-127 */
	kGenericMusicBank0			= 1 << 1,						/* implement instrument bank changes on controller 0 */
	kGenericMusicBank32			= 1 << 2,						/* implement instrument bank changes on controller 32 */
	kGenericMusicErsatzMIDI		= 1 << 3,						/* construct MIDI packets, but send them to the derived component */
	kGenericMusicCallKnobs		= 1 << 4,						/* call the derived component with special knob format call */
	kGenericMusicCallParts		= 1 << 5,						/* call the derived component with special part format call */
	kGenericMusicCallInstrument	= 1 << 6,						/* call MusicDerivedSetInstrument for MusicSetInstrument calls */
	kGenericMusicCallNumber		= 1 << 7,						/* call MusicDerivedSetPartInstrumentNumber for MusicSetPartInstrumentNumber calls, & don't send any C0 or bank stuff */
	kGenericMusicCallROMInstrument = 1 << 8,					/* call MusicSetInstrument for MusicSetPartInstrumentNumber for "ROM" instruments, passing params from the ROMi resource */
	kGenericMusicAllDefaults	= 1 << 9						/* indicates that when a new instrument is recalled, all knobs are reset to DEFAULT settings. True for GS modules */
};

typedef pascal ComponentResult (*MusicOfflineDataProcPtr)(Ptr SoundData, long numBytes, long myRefCon);

#if GENERATINGCFM
typedef UniversalProcPtr MusicOfflineDataUPP;
#else
typedef MusicOfflineDataProcPtr MusicOfflineDataUPP;
#endif
struct OfflineSampleType {
	unsigned long 					numChannels;				/*number of channels,  ie mono = 1*/
	UnsignedFixed 					sampleRate;					/*sample rate in Apples Fixed point representation*/
	unsigned short 					sampleSize;					/*number of bits in sample*/
};
typedef struct OfflineSampleType OfflineSampleType;

struct InstrumentInfoRecord {
	long 							instrumentNumber;			/* instrument number (if 0, name is a catagory)*/
	long 							flags;						/* show in picker, etc.*/
	long 							toneNameIndex;				/* index in toneNames (1 based)*/
	long 							itxtNameAtomID;				/* index in itxtNames (itxt/name by index)*/
};
typedef struct InstrumentInfoRecord InstrumentInfoRecord;

struct InstrumentInfoList {
	long 							recordCount;
	Handle 							toneNames;					/* name from tone description*/
	QTAtomContainer 				itxtNames;					/* itxt/name atoms for instruments*/
	InstrumentInfoRecord 			info[1];
};
typedef struct InstrumentInfoList InstrumentInfoList;

typedef InstrumentInfoList *InstrumentInfoListPtr;
typedef InstrumentInfoListPtr *InstrumentInfoListHandle;
extern pascal ComponentResult MusicGetDescription(MusicComponent mc, SynthesizerDescription *sd)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0001, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGetPart(MusicComponent mc, long part, long *midiChannel, long *polyphony)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0002, 0x7000, 0xA82A);

extern pascal ComponentResult MusicSetPart(MusicComponent mc, long part, long midiChannel, long polyphony)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0003, 0x7000, 0xA82A);

extern pascal ComponentResult MusicSetPartInstrumentNumber(MusicComponent mc, long part, long instrumentNumber)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0004, 0x7000, 0xA82A);

#if OLDROUTINENAMES
#define MusicSetInstrumentNumber(ci,part,instrumentNumber) MusicSetPartInstrumentNumber(ci, part,instrumentNumber)
#endif
extern pascal ComponentResult MusicGetPartInstrumentNumber(MusicComponent mc, long part)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0005, 0x7000, 0xA82A);

extern pascal ComponentResult MusicStorePartInstrument(MusicComponent mc, long part, long instrumentNumber)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0006, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGetPartAtomicInstrument(MusicComponent mc, long part, AtomicInstrument *ai, long flags)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0009, 0x7000, 0xA82A);

extern pascal ComponentResult MusicSetPartAtomicInstrument(MusicComponent mc, long part, AtomicInstrumentPtr aiP, long flags)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x000A, 0x7000, 0xA82A);

/* Obsolete calls*/
extern pascal ComponentResult MusicGetInstrumentKnobDescriptionObsolete(MusicComponent mc, long knobIndex, void *mkd)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x000D, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGetDrumKnobDescriptionObsolete(MusicComponent mc, long knobIndex, void *mkd)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x000E, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGetKnobDescriptionObsolete(MusicComponent mc, long knobIndex, void *mkd)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x000F, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGetPartKnob(MusicComponent mc, long part, long knobID)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0010, 0x7000, 0xA82A);

extern pascal ComponentResult MusicSetPartKnob(MusicComponent mc, long part, long knobID, long knobValue)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0011, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGetKnob(MusicComponent mc, long knobID)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0012, 0x7000, 0xA82A);

extern pascal ComponentResult MusicSetKnob(MusicComponent mc, long knobID, long knobValue)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0013, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGetPartName(MusicComponent mc, long part, StringPtr name)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0014, 0x7000, 0xA82A);

extern pascal ComponentResult MusicSetPartName(MusicComponent mc, long part, StringPtr name)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0015, 0x7000, 0xA82A);

extern pascal ComponentResult MusicFindTone(MusicComponent mc, ToneDescription *td, long *instrumentNumber, unsigned long *fit)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0016, 0x7000, 0xA82A);

extern pascal ComponentResult MusicPlayNote(MusicComponent mc, long part, long pitch, long velocity)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0017, 0x7000, 0xA82A);

extern pascal ComponentResult MusicResetPart(MusicComponent mc, long part)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0018, 0x7000, 0xA82A);

extern pascal ComponentResult MusicSetPartController(MusicComponent mc, long part, MusicController controllerNumber, long controllerValue)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0019, 0x7000, 0xA82A);

#if OLDROUTINENAMES
#define MusicSetController(ci,part,controllerNumber,controllerValue) MusicSetPartController(ci, part,controllerNumber,controllerValue)
#endif
extern pascal ComponentResult MusicGetPartController(MusicComponent mc, long part, MusicController controllerNumber)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x001A, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGetMIDIProc(MusicComponent mc, MusicMIDISendUPP *midiSendProc, long *refCon)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x001B, 0x7000, 0xA82A);

extern pascal ComponentResult MusicSetMIDIProc(MusicComponent mc, MusicMIDISendUPP midiSendProc, long refCon)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x001C, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGetInstrumentNames(MusicComponent mc, long modifiableInstruments, Handle *instrumentNames, Handle *instrumentCategoryLasts, Handle *instrumentCategoryNames)
 FIVEWORDINLINE(0x2F3C, 0x0010, 0x001D, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGetDrumNames(MusicComponent mc, long modifiableInstruments, Handle *instrumentNumbers, Handle *instrumentNames)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x001E, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGetMasterTune(MusicComponent mc)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x001F, 0x7000, 0xA82A);

extern pascal ComponentResult MusicSetMasterTune(MusicComponent mc, long masterTune)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0020, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGetInstrumentAboutInfo(MusicComponent mc, long part, InstrumentAboutInfo *iai)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0022, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGetDeviceConnection(MusicComponent mc, long index, long *id1, long *id2)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0023, 0x7000, 0xA82A);

extern pascal ComponentResult MusicUseDeviceConnection(MusicComponent mc, long id1, long id2)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0024, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGetKnobSettingStrings(MusicComponent mc, long knobIndex, long isGlobal, Handle *settingsNames, Handle *settingsCategoryLasts, Handle *settingsCategoryNames)
 FIVEWORDINLINE(0x2F3C, 0x0014, 0x0025, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGetMIDIPorts(MusicComponent mc, long *inputPortCount, long *outputPortCount)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0026, 0x7000, 0xA82A);

extern pascal ComponentResult MusicSendMIDI(MusicComponent mc, long portIndex, MusicMIDIPacket *mp)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0027, 0x7000, 0xA82A);

extern pascal ComponentResult MusicReceiveMIDI(MusicComponent mc, MusicMIDIReadHookUPP readHook, long refCon)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0028, 0x7000, 0xA82A);

extern pascal ComponentResult MusicStartOffline(MusicComponent mc, unsigned long *numChannels, UnsignedFixed *sampleRate, unsigned short *sampleSize, MusicOfflineDataUPP dataProc, long dataProcRefCon)
 FIVEWORDINLINE(0x2F3C, 0x0014, 0x0029, 0x7000, 0xA82A);

extern pascal ComponentResult MusicSetOfflineTimeTo(MusicComponent mc, long newTimeStamp)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x002A, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGetInstrumentKnobDescription(MusicComponent mc, long knobIndex, KnobDescription *mkd)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x002B, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGetDrumKnobDescription(MusicComponent mc, long knobIndex, KnobDescription *mkd)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x002C, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGetKnobDescription(MusicComponent mc, long knobIndex, KnobDescription *mkd)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x002D, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGetInfoText(MusicComponent mc, long selector, Handle *textH, Handle *styleH)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x002E, 0x7000, 0xA82A);


enum {
	kGetInstrumentInfoNoBuiltIn	= 1 << 0,
	kGetInstrumentInfoMidiUserInst = 1 << 1,
	kGetInstrumentInfoNoIText	= 1 << 2
};

extern pascal ComponentResult MusicGetInstrumentInfo(MusicComponent mc, long getInstrumentInfoFlags, InstrumentInfoListHandle *infoListH)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x002F, 0x7000, 0xA82A);

extern pascal ComponentResult MusicTask(MusicComponent mc)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0031, 0x7000, 0xA82A);

extern pascal ComponentResult MusicSetPartInstrumentNumberInterruptSafe(MusicComponent mc, long part, long instrumentNumber)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0032, 0x7000, 0xA82A);

extern pascal ComponentResult MusicSetPartSoundLocalization(MusicComponent mc, long part, Handle data)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0033, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGenericConfigure(MusicComponent mc, long mode, long flags, long baseResID)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0100, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGenericGetPart(MusicComponent mc, long partNumber, GCPart **part)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0101, 0x7000, 0xA82A);

extern pascal ComponentResult MusicGenericGetKnobList(MusicComponent mc, long knobType, GenericKnobDescriptionListHandle *gkdlH)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0102, 0x7000, 0xA82A);

extern pascal ComponentResult MusicDerivedMIDISend(MusicComponent mc, MusicMIDIPacket *packet)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0200, 0x7000, 0xA82A);

extern pascal ComponentResult MusicDerivedSetKnob(MusicComponent mc, long knobType, long knobNumber, long knobValue, long partNumber, GCPart *p, GenericKnobDescription *gkd)
 FIVEWORDINLINE(0x2F3C, 0x0018, 0x0201, 0x7000, 0xA82A);

extern pascal ComponentResult MusicDerivedSetPart(MusicComponent mc, long partNumber, GCPart *p)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0202, 0x7000, 0xA82A);

extern pascal ComponentResult MusicDerivedSetInstrument(MusicComponent mc, long partNumber, GCPart *p)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0203, 0x7000, 0xA82A);

extern pascal ComponentResult MusicDerivedSetPartInstrumentNumber(MusicComponent mc, long partNumber, GCPart *p)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0204, 0x7000, 0xA82A);

extern pascal ComponentResult MusicDerivedSetMIDI(MusicComponent mc, MusicMIDISendProcPtr midiProc, long refcon, long midiChannel)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0205, 0x7000, 0xA82A);

extern pascal ComponentResult MusicDerivedStorePartInstrument(MusicComponent mc, long partNumber, GCPart *p, long instrumentNumber)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0206, 0x7000, 0xA82A);

/* Mask bit for returned value by InstrumentFind.*/

enum {
	kInstrumentExactMatch		= 0x00020000,
	kInstrumentRecommendedSubstitute = 0x00010000,
	kInstrumentQualityField		= 0xFF000000,
	kInstrumentRoland8BitQuality = 0x05000000
};

typedef InstrumentAboutInfo *InstrumentAboutInfoPtr;
typedef InstrumentAboutInfoPtr *InstrumentAboutInfoHandle;
struct GMInstrumentInfo {
	long 							cmpInstID;
	long 							gmInstNum;
	long 							instMatch;
};
typedef struct GMInstrumentInfo GMInstrumentInfo;

typedef GMInstrumentInfo *GMInstrumentInfoPtr;
typedef GMInstrumentInfoPtr *GMInstrumentInfoHandle;
struct nonGMInstrumentInfoRecord {
	long 							cmpInstID;					/* if 0, category name*/
	long 							flags;						/* match, show in picker*/
	long 							toneNameIndex;				/* index in toneNames (1 based)*/
	long 							itxtNameAtomID;				/* index in itxtNames (itxt/name by index)*/
};
typedef struct nonGMInstrumentInfoRecord nonGMInstrumentInfoRecord;

struct nonGMInstrumentInfo {
	long 							recordCount;
	Handle 							toneNames;					/* name from tone description*/
	QTAtomContainer 				itxtNames;					/* itext/name atoms for instruments*/
	nonGMInstrumentInfoRecord 		instInfo[1];
};
typedef struct nonGMInstrumentInfo nonGMInstrumentInfo;

typedef nonGMInstrumentInfo *nonGMInstrumentInfoPtr;
typedef nonGMInstrumentInfoPtr *nonGMInstrumentInfoHandle;
struct InstCompInfo {
	long 							infoSize;					/* size of this record*/
	Str31 							InstrumentLibraryName;
	QTAtomContainer 				InstrumentLibraryITxt;		/* itext/name atoms for instruments*/
	long 							GMinstrumentCount;
	GMInstrumentInfoHandle 			GMinstrumentInfo;
	long 							GMdrumCount;
	GMInstrumentInfoHandle 			GMdrumInfo;
	long 							nonGMinstrumentCount;
	nonGMInstrumentInfoHandle 		nonGMinstrumentInfo;
};
typedef struct InstCompInfo InstCompInfo;

typedef InstCompInfo *InstCompInfoPtr;
typedef InstCompInfoPtr *InstCompInfoHandle;
extern pascal ComponentResult InstrumentGetInst(ComponentInstance ci, long instID, AtomicInstrument *atomicInst, long flags)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0001, 0x7000, 0xA82A);

extern pascal ComponentResult InstrumentGetInfo(ComponentInstance ci, long getInstrumentInfoFlags, InstCompInfoHandle *instInfo)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0002, 0x7000, 0xA82A);

extern pascal ComponentResult InstrumentInitialize(ComponentInstance ci, long initFormat, void *initParams)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0003, 0x7000, 0xA82A);

extern pascal ComponentResult InstrumentOpenComponentResFile(ComponentInstance ci, short *resFile)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0004, 0x7000, 0xA82A);

extern pascal ComponentResult InstrumentCloseComponentResFile(ComponentInstance ci, short resFile)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x0005, 0x7000, 0xA82A);

extern pascal ComponentResult InstrumentGetComponentRefCon(ComponentInstance ci, void **refCon)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0006, 0x7000, 0xA82A);

extern pascal ComponentResult InstrumentSetComponentRefCon(ComponentInstance ci, void *refCon)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0007, 0x7000, 0xA82A);

/*
--------------------------
	Types
--------------------------
*/

enum {
	kSynthesizerConnectionMono	= 1,							/* if set, and synth can be mono/poly, then the partCount channels from the system channel are hogged */
	kSynthesizerConnectionMMgr	= 2,							/* this connection imported from the MIDI Mgr */
	kSynthesizerConnectionOMS	= 4,							/* this connection imported from OMS */
	kSynthesizerConnectionQT	= 8,							/* this connection is a QuickTime-only port */
	kSynthesizerConnectionFMS	= 16							/* this connection imported from FMS */
};

/* used for MIDI device only */
struct SynthesizerConnections {
	OSType 							clientID;
	OSType 							inputPortID;				/* terminology death: this port is used to SEND to the midi synth */
	OSType 							outputPortID;				/* terminology death: this port receives from a keyboard or other control device */
	long 							midiChannel;				/* The system channel; others are configurable (or the nubus slot number) */
	long 							flags;
	long 							unique;						/* unique id may be used instead of index, to getinfo and unregister calls */
	long 							reserved1;					/* should be zero */
	long 							reserved2;					/* should be zero */
};
typedef struct SynthesizerConnections SynthesizerConnections;

struct QTMIDIPort {
	SynthesizerConnections 			portConnections;
	Str63 							portName;
};
typedef struct QTMIDIPort QTMIDIPort;


enum {
	kNoteRequestNoGM			= 1,							/* dont degrade to a GM synth */
	kNoteRequestNoSynthType		= 2,							/* dont degrade to another synth of same type but different name */
	kNoteRequestSynthMustMatch	= 4								/* synthType must be a match, including kGMSynthComponentSubType */
};

typedef ComponentInstance NoteAllocator;
struct NoteRequestInfo {
	UInt8 							flags;						/* 1: dont accept GM match, 2: dont accept same-synth-type match */
	UInt8 							reserved;					/* must be zero */
	short 							polyphony;					/* Maximum number of voices */
	Fixed 							typicalPolyphony;			/* Hint for level mixing */
};
typedef struct NoteRequestInfo NoteRequestInfo;

struct NoteRequest {
	NoteRequestInfo 				info;
	ToneDescription 				tone;
};
typedef struct NoteRequest NoteRequest;

typedef struct OpaqueNoteChannel* NoteChannel;

enum {
	kPickDontMix				= 1,							/* dont mix instruments with drum sounds */
	kPickSameSynth				= 2,							/* only allow the same device that went in, to come out */
	kPickUserInsts				= 4,							/* show user insts in addition to ROM voices */
	kPickEditAllowEdit			= 8,							/* lets user switch over to edit mode */
	kPickEditAllowPick			= 16,							/* lets the user switch over to pick mode */
	kPickEditSynthGlobal		= 32,							/* edit the global knobs of the synth */
	kPickEditControllers		= 64							/* edit the controllers of the notechannel */
};


enum {
	kNoteAllocatorComponentType	= 'nota'
};

/*
--------------------------------
	Note Allocator Prototypes
--------------------------------
*/
extern pascal ComponentResult NARegisterMusicDevice(NoteAllocator ci, OSType synthType, Str31 name, SynthesizerConnections *connections)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0000, 0x7000, 0xA82A);

extern pascal ComponentResult NAUnregisterMusicDevice(NoteAllocator ci, long index)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0001, 0x7000, 0xA82A);

extern pascal ComponentResult NAGetRegisteredMusicDevice(NoteAllocator ci, long index, OSType *synthType, Str31 name, SynthesizerConnections *connections, MusicComponent *mc)
 FIVEWORDINLINE(0x2F3C, 0x0014, 0x0002, 0x7000, 0xA82A);

extern pascal ComponentResult NASaveMusicConfiguration(NoteAllocator ci)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0003, 0x7000, 0xA82A);

extern pascal ComponentResult NANewNoteChannel(NoteAllocator ci, NoteRequest *noteRequest, NoteChannel *outChannel)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0004, 0x7000, 0xA82A);

extern pascal ComponentResult NADisposeNoteChannel(NoteAllocator ci, NoteChannel noteChannel)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0005, 0x7000, 0xA82A);

extern pascal ComponentResult NAGetNoteChannelInfo(NoteAllocator ci, NoteChannel noteChannel, long *index, long *part)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0006, 0x7000, 0xA82A);

extern pascal ComponentResult NAPrerollNoteChannel(NoteAllocator ci, NoteChannel noteChannel)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0007, 0x7000, 0xA82A);

extern pascal ComponentResult NAUnrollNoteChannel(NoteAllocator ci, NoteChannel noteChannel)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0008, 0x7000, 0xA82A);

extern pascal ComponentResult NASetNoteChannelVolume(NoteAllocator ci, NoteChannel noteChannel, Fixed volume)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x000B, 0x7000, 0xA82A);

extern pascal ComponentResult NAResetNoteChannel(NoteAllocator ci, NoteChannel noteChannel)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x000C, 0x7000, 0xA82A);

extern pascal ComponentResult NAPlayNote(NoteAllocator ci, NoteChannel noteChannel, long pitch, long velocity)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x000D, 0x7000, 0xA82A);

extern pascal ComponentResult NASetController(NoteAllocator ci, NoteChannel noteChannel, long controllerNumber, long controllerValue)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x000E, 0x7000, 0xA82A);

extern pascal ComponentResult NASetKnob(NoteAllocator ci, NoteChannel noteChannel, long knobNumber, long knobValue)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x000F, 0x7000, 0xA82A);

extern pascal ComponentResult NAFindNoteChannelTone(NoteAllocator ci, NoteChannel noteChannel, ToneDescription *td, long *instrumentNumber)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0010, 0x7000, 0xA82A);

extern pascal ComponentResult NASetInstrumentNumber(NoteAllocator ci, NoteChannel noteChannel, long instrumentNumber)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0011, 0x7000, 0xA82A);

#if OLDROUTINENAMES
#define NASetNoteChannelInstrument(ci, noteChannel,instrumentNumber ) NASetInstrumentNumber(ci, noteChannel,instrumentNumber)
#define NASetInstrument(ci, noteChannel,instrumentNumber ) NASetInstrumentNumber(ci, noteChannel,instrumentNumber)
#endif
extern pascal ComponentResult NAPickInstrument(NoteAllocator ci, ModalFilterUPP filterProc, StringPtr prompt, ToneDescription *sd, unsigned long flags, long refCon, long reserved1, long reserved2)
 FIVEWORDINLINE(0x2F3C, 0x001C, 0x0012, 0x7000, 0xA82A);

extern pascal ComponentResult NAPickArrangement(NoteAllocator ci, ModalFilterUPP filterProc, StringPtr prompt, long zero1, long zero2, Track t, StringPtr songName)
 FIVEWORDINLINE(0x2F3C, 0x0018, 0x0013, 0x7000, 0xA82A);

extern pascal ComponentResult NASetDefaultMIDIInput(NoteAllocator ci, SynthesizerConnections *sc)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0015, 0x7000, 0xA82A);

extern pascal ComponentResult NAGetDefaultMIDIInput(NoteAllocator ci, SynthesizerConnections *sc)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0016, 0x7000, 0xA82A);

extern pascal ComponentResult NAUseDefaultMIDIInput(NoteAllocator ci, MusicMIDIReadHookUPP readHook, long refCon, unsigned long flags)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0019, 0x7000, 0xA82A);

extern pascal ComponentResult NALoseDefaultMIDIInput(NoteAllocator ci)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x001A, 0x7000, 0xA82A);

extern pascal ComponentResult NAStuffToneDescription(NoteAllocator ci, long gmNumber, ToneDescription *td)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x001B, 0x7000, 0xA82A);

extern pascal ComponentResult NACopyrightDialog(NoteAllocator ci, PicHandle p, StringPtr author, StringPtr copyright, StringPtr other, StringPtr title, ModalFilterUPP filterProc, long refCon)
 FIVEWORDINLINE(0x2F3C, 0x001C, 0x001C, 0x7000, 0xA82A);

/*
	kNADummyOneSelect = 29
	kNADummyTwoSelect = 30
*/
extern pascal ComponentResult NAGetIndNoteChannel(NoteAllocator ci, long index, NoteChannel *nc, long *seed)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x001F, 0x7000, 0xA82A);

extern pascal ComponentResult NAGetMIDIPorts(NoteAllocator ci, Handle *inputPorts, Handle *outputPorts)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0021, 0x7000, 0xA82A);

extern pascal ComponentResult NAGetNoteRequest(NoteAllocator ci, NoteChannel noteChannel, NoteRequest *nrOut)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0022, 0x7000, 0xA82A);

extern pascal ComponentResult NASendMIDI(NoteAllocator ci, NoteChannel noteChannel, MusicMIDIPacket *mp)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0023, 0x7000, 0xA82A);

extern pascal ComponentResult NAPickEditInstrument(NoteAllocator ci, ModalFilterUPP filterProc, StringPtr prompt, long refCon, NoteChannel nc, AtomicInstrument ai, long flags)
 FIVEWORDINLINE(0x2F3C, 0x0018, 0x0024, 0x7000, 0xA82A);

extern pascal ComponentResult NANewNoteChannelFromAtomicInstrument(NoteAllocator ci, AtomicInstrumentPtr instrument, long flags, NoteChannel *outChannel)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0025, 0x7000, 0xA82A);

extern pascal ComponentResult NASetAtomicInstrument(NoteAllocator ci, NoteChannel noteChannel, AtomicInstrumentPtr instrument, long flags)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0026, 0x7000, 0xA82A);

extern pascal ComponentResult NAGetKnob(NoteAllocator ci, NoteChannel noteChannel, long knobNumber, long *knobValue)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0028, 0x7000, 0xA82A);

extern pascal ComponentResult NATask(NoteAllocator ci)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0029, 0x7000, 0xA82A);

extern pascal ComponentResult NASetNoteChannelBalance(NoteAllocator ci, NoteChannel noteChannel, long balance)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x002A, 0x7000, 0xA82A);

extern pascal ComponentResult NASetInstrumentNumberInterruptSafe(NoteAllocator ci, NoteChannel noteChannel, long instrumentNumber)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x002B, 0x7000, 0xA82A);

extern pascal ComponentResult NASetNoteChannelSoundLocalization(NoteAllocator ci, NoteChannel noteChannel, Handle data)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x002C, 0x7000, 0xA82A);


enum {
	kTuneQueueDepth				= 8								/* Deepest you can queue tune segments */
};

struct TuneStatus {
	unsigned long *					tune;						/* currently playing tune */
	unsigned long *					tunePtr;					/* position within currently playing piece */
	TimeValue 						time;						/* current tune time */
	short 							queueCount;					/* how many pieces queued up? */
	short 							queueSpots;					/* How many more tunepieces can be queued */
	TimeValue 						queueTime;					/* How much time is queued up? (can be very inaccurate) */
	long 							reserved[3];
};
typedef struct TuneStatus TuneStatus;

typedef pascal void (*TuneCallBackProcPtr)(const TuneStatus *status, long refCon);
typedef pascal void (*TunePlayCallBackProcPtr)(unsigned long *event, long seed, long refCon);

#if GENERATINGCFM
typedef UniversalProcPtr TuneCallBackUPP;
typedef UniversalProcPtr TunePlayCallBackUPP;
#else
typedef TuneCallBackProcPtr TuneCallBackUPP;
typedef TunePlayCallBackProcPtr TunePlayCallBackUPP;
#endif
typedef ComponentInstance TunePlayer;

enum {
	kTunePlayerType				= 'tune'
};

extern pascal ComponentResult TuneSetHeader(TunePlayer tp, unsigned long *header)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0004, 0x7000, 0xA82A);

extern pascal ComponentResult TuneGetTimeBase(TunePlayer tp, TimeBase *tb)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0005, 0x7000, 0xA82A);

extern pascal ComponentResult TuneSetTimeScale(TunePlayer tp, TimeScale scale)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0006, 0x7000, 0xA82A);

extern pascal ComponentResult TuneGetTimeScale(TunePlayer tp, TimeScale *scale)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0007, 0x7000, 0xA82A);

extern pascal ComponentResult TuneGetIndexedNoteChannel(TunePlayer tp, long i, NoteChannel *nc)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0008, 0x7000, 0xA82A);

/* Values for when to start. */

enum {
	kTuneStartNow				= 1,							/* start after buffer is implied */
	kTuneDontClipNotes			= 2,							/* allow notes to finish their durations outside sample */
	kTuneExcludeEdgeNotes		= 4,							/* dont play notes that start at end of tune */
	kTuneQuickStart				= 8,							/* Leave all the controllers where they are, ignore start time */
	kTuneLoopUntil				= 16,							/* loop a queued tune if there's nothing else in the queue */
	kTuneStartNewMaster			= 16384
};

extern pascal ComponentResult TuneQueue(TunePlayer tp, unsigned long *tune, Fixed tuneRate, unsigned long tuneStartPosition, unsigned long tuneStopPosition, unsigned long queueFlags, TuneCallBackUPP callBackProc, long refCon)
 FIVEWORDINLINE(0x2F3C, 0x001C, 0x000A, 0x7000, 0xA82A);

extern pascal ComponentResult TuneInstant(TunePlayer tp, void *tune, long tunePosition)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x000B, 0x7000, 0xA82A);

extern pascal ComponentResult TuneGetStatus(TunePlayer tp, TuneStatus *status)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x000C, 0x7000, 0xA82A);

/* Values for stopping. */

enum {
	kTuneStopFade				= 1,							/* do a quick, synchronous fadeout */
	kTuneStopSustain			= 2,							/* don't silece notes */
	kTuneStopInstant			= 4,							/* silence notes fast (else, decay them) */
	kTuneStopReleaseChannels	= 8								/* afterwards, let the channels go */
};

extern pascal ComponentResult TuneStop(TunePlayer tp, long stopFlags)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x000D, 0x7000, 0xA82A);

extern pascal ComponentResult TuneSetVolume(TunePlayer tp, Fixed volume)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0010, 0x7000, 0xA82A);

extern pascal ComponentResult TuneGetVolume(TunePlayer tp)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0011, 0x7000, 0xA82A);

extern pascal ComponentResult TunePreroll(TunePlayer tp)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0012, 0x7000, 0xA82A);

extern pascal ComponentResult TuneUnroll(TunePlayer tp)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0013, 0x7000, 0xA82A);

extern pascal ComponentResult TuneSetNoteChannels(TunePlayer tp, unsigned long count, NoteChannel *noteChannelList, TunePlayCallBackUPP playCallBackProc, long refCon)
 FIVEWORDINLINE(0x2F3C, 0x0010, 0x0014, 0x7000, 0xA82A);

extern pascal ComponentResult TuneSetPartTranspose(TunePlayer tp, unsigned long part, long transpose, long velocityShift)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0015, 0x7000, 0xA82A);

extern pascal NoteAllocator TuneGetNoteAllocator(TunePlayer tp)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0017, 0x7000, 0xA82A);

extern pascal ComponentResult TuneSetSofter(TunePlayer tp, long softer)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0018, 0x7000, 0xA82A);

extern pascal ComponentResult TuneTask(TunePlayer tp)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0019, 0x7000, 0xA82A);

extern pascal ComponentResult TuneSetBalance(TunePlayer tp, long balance)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x001A, 0x7000, 0xA82A);

extern pascal ComponentResult TuneSetSoundLocalization(TunePlayer tp, Handle data)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x001B, 0x7000, 0xA82A);

extern pascal ComponentResult TuneSetHeaderWithSize(TunePlayer tp, unsigned long *header, unsigned long size)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x001C, 0x7000, 0xA82A);

typedef unsigned long MusicOpWord;
typedef unsigned long *MusicOpWordPtr;
/*
 	QuickTime Music Track Event Formats:

	At this time, QuickTime music tracks support 5 different event types -- REST events,
	short NOTE events, short CONTROL events, short GENERAL events, Long NOTE events, 
	long CONTROL events, and variable GENERAL events.
 
		• REST Event (4 bytes/event):
	
			(0 0 0) (5-bit UNUSED) (24-bit Rest Duration)
		
		• Short NOTE Events (4 bytes/event):
	
			(0 0 1) (5-bit Part) (6-bit Pitch) (7-bit Volume) (11-bit Duration)
		
			where:	Pitch is offset by 32 (Actual pitch = pitch field + 32)

		• Short CONTROL Events (4 bytes/event):
	
			(0 1 0) (5-bit Part) (8-bit Controller) (1-bit UNUSED) (1-bit Sign) (7-bit MSB) (7-bit LSB)
																		 ( or 15-bit Signed Value)
		• Short GENERAL Event (4 bytes/event):
	
			(0 1 1) (1-bit UNUSED) (12-bit Sub-Type) (16-bit Value)
	
		• Long NOTE Events (8 bytes/event):
	
			(1 0 0 1) (12-bit Part) (1-bit UNUSED) (7-bit Pitch) (1-bit UNUSED) (7-bit Volume)
			(1 0) (8-bit UNUSED) (22-bit Duration)
		
		• Long CONTROL Event (8 bytes/event):
		
			(1 0 1 0) (12-bit Part) (16-bit Value MSB) 
			(1 0) (14-bit Controller) (16-bit Value LSB)
	
		• Long KNOB Event (8 bytes/event):
	
			(1 0 1 1) (12-bit Sub-Type) (16-bit Value MSB)
			(1 0) (14-bit KNOB) (16-bit Value LSB)
	
		• Variable GENERAL Length Events (N bytes/event):
	
			(1 1 1 1) (12-bit Sub-Type) (16-bit Length)
				:
			(32-bit Data values)
				:
			(1 1) (14-bit UNUSED) (16-bit Length)
	
			where:	Length field is the number of LONG words in the record.
					Lengths include the first and last long words (Minimum length = 2)
				
	The following event type values have not been used yet and are reserved for 
	future expansion:
		
		• (1 0 0 0)		(8 bytes/event)
		• (1 1 0 0)		(N bytes/event)
		• (1 1 0 1)		(N bytes/event)
		• (1 1 1 0)		(N bytes/event)
		
	For all events, the following generalizations apply:
	
		-	All duration values are specified in Millisecond units.
		- 	Pitch values are intended to map directly to the MIDI key numbers.
		-	Controllers from 0 to 127 correspond to the standard MIDI controllers.
			Controllers greater than 127 correspond to other controls (i.e., Pitch Bend, 
			Key Pressure, and Channel Pressure).	
*/
/* Defines for the implemented music event data fields*/

enum {
	kRestEventType				= 0x00000000,					/* lower 3-bits */
	kNoteEventType				= 0x00000001,					/* lower 3-bits */
	kControlEventType			= 0x00000002,					/* lower 3-bits */
	kMarkerEventType			= 0x00000003,					/* lower 3-bits */
	kUndefined1EventType		= 0x00000008,					/* 4-bits */
	kXNoteEventType				= 0x00000009,					/* 4-bits */
	kXControlEventType			= 0x0000000A,					/* 4-bits */
	kKnobEventType				= 0x0000000B,					/* 4-bits */
	kUndefined2EventType		= 0x0000000C,					/* 4-bits */
	kUndefined3EventType		= 0x0000000D,					/* 4-bits */
	kUndefined4EventType		= 0x0000000E,					/* 4-bits */
	kGeneralEventType			= 0x0000000F,					/* 4-bits */
	kXEventLengthBits			= 0x00000002,					/* 2 bits: indicates 8-byte event record */
	kGeneralEventLengthBits		= 0x00000003,					/* 2 bits: indicates variable length event record */
	kEventLen					= 1L,							/* length of events in long words */
	kXEventLen					= 2L,
	kRestEventLen				= kEventLen,					/* length of events in long words */
	kNoteEventLen				= kEventLen,
	kControlEventLen			= kEventLen,
	kMarkerEventLen				= kEventLen,
	kXNoteEventLen				= kXEventLen,
	kXControlEventLen			= kXEventLen,
	kGeneralEventLen			= kXEventLen,					/* 2 or more, however */
																/* Universal Event Defines*/
	kEventLengthFieldPos		= 30,							/* by looking at these two bits of the 1st or last word 			 */
	kEventLengthFieldWidth		= 2,							/* of an event you can determine the event length 					 */
																/* length field: 0 & 1 => 1 long; 2 => 2 longs; 3 => variable length */
	kEventTypeFieldPos			= 29,							/* event type field for short events */
	kEventTypeFieldWidth		= 3,							/* short type is 3 bits */
	kXEventTypeFieldPos			= 28,							/* event type field for extended events */
	kXEventTypeFieldWidth		= 4,							/* extended type is 4 bits */
	kEventPartFieldPos			= 24,
	kEventPartFieldWidth		= 5,
	kXEventPartFieldPos			= 16,							/* in the 1st long word */
	kXEventPartFieldWidth		= 12,							/* Rest Events*/
	kRestEventDurationFieldPos	= 0,
	kRestEventDurationFieldWidth = 24,
	kRestEventDurationMax		= ((1L << kRestEventDurationFieldWidth) - 1), /* Note Events*/
	kNoteEventPitchFieldPos		= 18,
	kNoteEventPitchFieldWidth	= 6,
	kNoteEventPitchOffset		= 32,							/* add to value in pitch field to get actual pitch */
	kNoteEventVolumeFieldPos	= 11,
	kNoteEventVolumeFieldWidth	= 7,
	kNoteEventVolumeOffset		= 0,							/* add to value in volume field to get actual volume */
	kNoteEventDurationFieldPos	= 0,
	kNoteEventDurationFieldWidth = 11,
	kNoteEventDurationMax		= ((1L << kNoteEventDurationFieldWidth) - 1),
	kXNoteEventPitchFieldPos	= 0,							/* in the 1st long word */
	kXNoteEventPitchFieldWidth	= 16,
	kXNoteEventDurationFieldPos	= 0,							/* in the 2nd long word */
	kXNoteEventDurationFieldWidth = 22,
	kXNoteEventDurationMax		= ((1L << kXNoteEventDurationFieldWidth) - 1),
	kXNoteEventVolumeFieldPos	= 22,							/* in the 2nd long word */
	kXNoteEventVolumeFieldWidth	= 7,							/* Control Events*/
	kControlEventControllerFieldPos = 16,
	kControlEventControllerFieldWidth = 8,
	kControlEventValueFieldPos	= 0,
	kControlEventValueFieldWidth = 16,
	kXControlEventControllerFieldPos = 0,						/* in the 2nd long word */
	kXControlEventControllerFieldWidth = 16,
	kXControlEventValueFieldPos	= 0,							/* in the 1st long word */
	kXControlEventValueFieldWidth = 16,							/* Knob Events*/
	kKnobEventValueHighFieldPos	= 0,							/* 1st long word */
	kKnobEventValueHighFieldWidth = 16,
	kKnobEventKnobFieldPos		= 16,							/* 2nd long word */
	kKnobEventKnobFieldWidth	= 14,
	kKnobEventValueLowFieldPos	= 0,							/* 2nd long word */
	kKnobEventValueLowFieldWidth = 16,							/* Marker Events*/
	kMarkerEventSubtypeFieldPos	= 16,
	kMarkerEventSubtypeFieldWidth = 8,
	kMarkerEventValueFieldPos	= 0,
	kMarkerEventValueFieldWidth	= 16,							/* General Events*/
	kGeneralEventSubtypeFieldPos = 16,							/* in the last long word */
	kGeneralEventSubtypeFieldWidth = 14,
	kGeneralEventLengthFieldPos	= 0,							/* in the 1st & last long words */
	kGeneralEventLengthFieldWidth = 16
};

/* macros for extracting various fields from the QuickTime event records*/
#define qtma_MASK(bitWidth) 			((1L << (bitWidth)) - 1)
#define qtma_EXT(val, pos, width) 		(((val) >> (pos)) & qtma_MASK(width))
#define qtma_EventLengthForward(xP,ulen)		{		unsigned long _ext;		unsigned long *lP = (unsigned long *)(xP);		_ext = qtma_EXT(*lP, kEventLengthFieldPos, kEventLengthFieldWidth);		if (_ext != 3) {			ulen = (_ext < 2) ? 1 : 2;			} else {			ulen = (unsigned short)qtma_EXT(*lP, kGeneralEventLengthFieldPos, kGeneralEventLengthFieldWidth);		\
			if (ulen < 2) {			ulen = lP[1];			}			}			}
#define qtma_EventLengthBackward(xP,ulen)		{		unsigned long _ext;		unsigned long *lP = (unsigned long *)(xP);		_ext = qtma_EXT(*lP, kEventLengthFieldPos, kEventLengthFieldWidth);		if (_ext != 3) {			ulen = (_ext < 2) ? 1 : 2;			} else {			ulen = (unsigned short)qtma_EXT(*lP, kGeneralEventLengthFieldPos, kGeneralEventLengthFieldWidth);		\
			if (ulen < 2) {			ulen = lP[-1];			}			}			}
#define qtma_EventType(x) 				((qtma_EXT(x, kEventTypeFieldPos, kEventTypeFieldWidth) > 3) ? qtma_EXT(x, kXEventTypeFieldPos, kXEventTypeFieldWidth) : qtma_EXT(x, kEventTypeFieldPos, kEventTypeFieldWidth))
#define qtma_RestDuration(x)  			(qtma_EXT(x, kRestEventDurationFieldPos, kRestEventDurationFieldWidth))
#define qtma_Part(x) 					(qtma_EXT(x, kEventPartFieldPos, kEventPartFieldWidth))
#define qtma_XPart(m, l) 				(qtma_EXT(m, kXEventPartFieldPos, kXEventPartFieldWidth))
#define qtma_NotePitch(x) 				(qtma_EXT(x, kNoteEventPitchFieldPos, kNoteEventPitchFieldWidth) + kNoteEventPitchOffset)
#define qtma_NoteVolume(x) 				(qtma_EXT(x, kNoteEventVolumeFieldPos, kNoteEventVolumeFieldWidth) + kNoteEventVolumeOffset)
#define qtma_NoteDuration(x) 			(qtma_EXT(x, kNoteEventDurationFieldPos, kNoteEventDurationFieldWidth))
#define qtma_NoteVelocity qtma_NoteVolume
#define qtma_XNotePitch(m, l) 			(qtma_EXT(m, kXNoteEventPitchFieldPos, kXNoteEventPitchFieldWidth))
#define qtma_XNoteVolume(m, l) 			(qtma_EXT(l, kXNoteEventVolumeFieldPos, kXNoteEventVolumeFieldWidth))
#define qtma_XNoteDuration(m, l) 		(qtma_EXT(l, kXNoteEventDurationFieldPos, kXNoteEventDurationFieldWidth))
#define qtma_XNoteVelocity qtma_XNoteVolume
#define qtma_ControlController(x) 		(qtma_EXT(x, kControlEventControllerFieldPos, kControlEventControllerFieldWidth))
#define qtma_ControlValue(x) 			(qtma_EXT(x, kControlEventValueFieldPos, kControlEventValueFieldWidth))
#define qtma_XControlController(m, l) 	(qtma_EXT(l, kXControlEventControllerFieldPos, kXControlEventControllerFieldWidth))
#define qtma_XControlValue(m, l) 		(qtma_EXT(m, kXControlEventValueFieldPos, kXControlEventValueFieldWidth))
#define qtma_MarkerSubtype(x)        	(qtma_EXT(x,kMarkerEventSubtypeFieldPos,kMarkerEventSubtypeFieldWidth))
#define qtma_MarkerValue(x) 			(qtma_EXT(x, kMarkerEventValueFieldPos, kMarkerEventValueFieldWidth))
#define qtma_KnobValue(m,l)				((qtma_EXT(m,kKnobEventValueHighFieldPos,kKnobEventValueHighFieldWidth) << 16)	| (qtma_EXT(l,kKnobEventValueLowFieldPos,kKnobEventValueLowFieldWidth)))
#define qtma_KnobKnob(m,l)				(qtma_EXT(l,kKnobEventKnobFieldPos,kKnobEventKnobFieldWidth))
#define qtma_GeneralSubtype(m,l)        (qtma_EXT(l,kGeneralEventSubtypeFieldPos,kGeneralEventSubtypeFieldWidth))
#define qtma_GeneralLength(m,l)           (qtma_EXT(m,kGeneralEventLengthFieldPos,kGeneralEventLengthFieldWidth))
#define qtma_StuffRestEvent(x, duration)																x = 	(kRestEventType << kEventTypeFieldPos)								|	((long)(duration) << kRestEventDurationFieldPos)
#define qtma_StuffNoteEvent(x, part, pitch, volume, duration)												x = 	(kNoteEventType << kEventTypeFieldPos)									| 	((long)(part) << kEventPartFieldPos)									|	(((long)(pitch) - kNoteEventPitchOffset) << kNoteEventPitchFieldPos)	|	(((long)(volume) - kNoteEventVolumeOffset) << kNoteEventVolumeFieldPos)	|	((long)(duration) << kNoteEventDurationFieldPos)
#define qtma_StuffControlEvent(x, part, control, value)													x = 	(kControlEventType << kEventTypeFieldPos)							| 	((long)(part) << kEventPartFieldPos)								|	((long)(control) << kControlEventControllerFieldPos)				|	((long)((value) & qtma_MASK(kControlEventValueFieldWidth)) << kControlEventValueFieldPos)
#define qtma_StuffMarkerEvent(x, markerType, markerValue)												x = 	(kMarkerEventType << kEventTypeFieldPos)							| 	((long)(markerType) << kMarkerEventSubtypeFieldPos)					|	((long)(markerValue) << kMarkerEventValueFieldPos)					w1 = 	(kXNoteEventType << kXEventTypeFieldPos)							|	((long)(part) << kXEventPartFieldPos)								|	((long)(pitch) << kXNoteEventPitchFieldPos),						w2 =	(kXEventLengthBits << kEventLengthFieldPos)							|	((long)(duration) << kXNoteEventDurationFieldPos)					|	((long)(volume) << kXNoteEventVolumeFieldPos)
#define qtma_StuffXControlEvent(w1, w2, part, control, value)											w1 = 	(kXControlEventType << kXEventTypeFieldPos)							|	((long)(part) << kXEventPartFieldPos)								|	((long)((value) & qtma_MASK(kXControlEventValueFieldWidth)) << kXControlEventValueFieldPos), w2 =	(kXEventLengthBits << kEventLengthFieldPos)							|	((long)(control) << kXControlEventControllerFieldPos)
#define qtma_StuffKnobEvent(w1, w2, part, knob, value)												w1 =	(kKnobEventType << kXEventTypeFieldPos)							|	((long)(part) << kXEventPartFieldPos)							|	((long)(value >> 16) << kKnobEventValueLowFieldPos),			w2 =	(kXEventLengthBits << kEventLengthFieldPos)						|	((long)(knob) << kKnobEventKnobFieldPos)						|	((long)(value & 0xFFFF) << kKnobEventValueLowFieldPos)
#define qtma_StuffGeneralEvent(w1,w2,part,subType,length)											w1 =	(kGeneralEventType << kXEventTypeFieldPos)						|	((long)(pa	(kGeneralEventLengthBits << kEventLengthFieldPos)				|	((long)(subType) << kGeneralEventSubtypeFieldPos)				|	((long)(length) << kGeneralEventLengthFieldPos)
#define qtma_NeedXGeneralEvent(length)	 (((unsigned long)(length)) > (unsigned long)0xffff)
/* General Event Defined Types*/

enum {
	kGeneralEventNoteRequest	= 1,							/* Encapsulates NoteRequest data structure */
	kGeneralEventPartKey		= 4,
	kGeneralEventTuneDifference	= 5,							/* Contains a standard sequence, with end marker, for the tune difference of a sequence piece (halts QuickTime 2.0 Music) */
	kGeneralEventAtomicInstrument = 6,							/* Encapsulates AtomicInstrument record */
	kGeneralEventKnob			= 7,							/* knobID/knobValue pairs; smallest event is 4 longs */
	kGeneralEventMIDIChannel	= 8,							/* used in tune header, one longword identifies the midi channel it originally came from */
	kGeneralEventPartChange		= 9,							/* used in tune sequence, one longword identifies the tune part which can now take over this part's note channel (similar to program change) (halts QuickTime 2.0 Music)*/
	kGeneralEventNoOp			= 10,							/* guaranteed to do nothing and be ignored. (halts QuickTime 2.0 Music) */
	kGeneralEventUsedNotes		= 11							/* four longwords specifying which midi notes are actually used, 0..127 msb to lsb */
};

/* Marker Event Defined Types		// marker is 60 ee vv vv in hex, where e = event type, and v = value*/

enum {
	kMarkerEventEnd				= 0,							/* marker type 0 means: value 0 - stop, value != 0 - ignore*/
	kMarkerEventBeat			= 1,							/* value 0 = single beat; anything else is 65536ths-of-a-beat (quarter note)*/
	kMarkerEventTempo			= 2								/* value same as beat marker, but indicates that a tempo event should be computed (based on where the next beat or tempo marker is) and emitted upon export*/
};

/* UPP call backs */

#if GENERATINGCFM
#else
#endif

enum {
	uppMusicMIDISendProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(ComponentResult)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(MusicComponent)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(MusicMIDIPacket *))),
	uppMusicMIDIReadHookProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(ComponentResult)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(MusicMIDIPacket *)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long))),
	uppMusicOfflineDataProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(ComponentResult)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Ptr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long))),
	uppTuneCallBackProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(const TuneStatus *)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long))),
	uppTunePlayCallBackProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(unsigned long *)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewMusicMIDISendProc(userRoutine)		\
		(MusicMIDISendUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppMusicMIDISendProcInfo, GetCurrentArchitecture())
#define NewMusicMIDIReadHookProc(userRoutine)		\
		(MusicMIDIReadHookUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppMusicMIDIReadHookProcInfo, GetCurrentArchitecture())
#define NewMusicOfflineDataProc(userRoutine)		\
		(MusicOfflineDataUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppMusicOfflineDataProcInfo, GetCurrentArchitecture())
#define NewTuneCallBackProc(userRoutine)		\
		(TuneCallBackUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTuneCallBackProcInfo, GetCurrentArchitecture())
#define NewTunePlayCallBackProc(userRoutine)		\
		(TunePlayCallBackUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTunePlayCallBackProcInfo, GetCurrentArchitecture())
#else
#define NewMusicMIDISendProc(userRoutine)		\
		((MusicMIDISendUPP) (userRoutine))
#define NewMusicMIDIReadHookProc(userRoutine)		\
		((MusicMIDIReadHookUPP) (userRoutine))
#define NewMusicOfflineDataProc(userRoutine)		\
		((MusicOfflineDataUPP) (userRoutine))
#define NewTuneCallBackProc(userRoutine)		\
		((TuneCallBackUPP) (userRoutine))
#define NewTunePlayCallBackProc(userRoutine)		\
		((TunePlayCallBackUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallMusicMIDISendProc(userRoutine, self, refCon, mmp)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppMusicMIDISendProcInfo, (self), (refCon), (mmp))
#define CallMusicMIDIReadHookProc(userRoutine, mp, myRefCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppMusicMIDIReadHookProcInfo, (mp), (myRefCon))
#define CallMusicOfflineDataProc(userRoutine, SoundData, numBytes, myRefCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppMusicOfflineDataProcInfo, (SoundData), (numBytes), (myRefCon))
#define CallTuneCallBackProc(userRoutine, status, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTuneCallBackProcInfo, (status), (refCon))
#define CallTunePlayCallBackProc(userRoutine, event, seed, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTunePlayCallBackProcInfo, (event), (seed), (refCon))
#else
#define CallMusicMIDISendProc(userRoutine, self, refCon, mmp)		\
		(*(userRoutine))((self), (refCon), (mmp))
#define CallMusicMIDIReadHookProc(userRoutine, mp, myRefCon)		\
		(*(userRoutine))((mp), (myRefCon))
#define CallMusicOfflineDataProc(userRoutine, SoundData, numBytes, myRefCon)		\
		(*(userRoutine))((SoundData), (numBytes), (myRefCon))
#define CallTuneCallBackProc(userRoutine, status, refCon)		\
		(*(userRoutine))((status), (refCon))
#define CallTunePlayCallBackProc(userRoutine, event, seed, refCon)		\
		(*(userRoutine))((event), (seed), (refCon))
#endif

/* selectors for component calls */
enum {
	kMusicGetDescriptionSelect						= 0x0001,
	kMusicGetPartSelect								= 0x0002,
	kMusicSetPartSelect								= 0x0003,
	kMusicSetPartInstrumentNumberSelect				= 0x0004,
	kMusicGetPartInstrumentNumberSelect				= 0x0005,
	kMusicStorePartInstrumentSelect					= 0x0006,
	kMusicGetPartAtomicInstrumentSelect				= 0x0009,
	kMusicSetPartAtomicInstrumentSelect				= 0x000A,
	kMusicGetInstrumentKnobDescriptionObsoleteSelect = 0x000D,
	kMusicGetDrumKnobDescriptionObsoleteSelect		= 0x000E,
	kMusicGetKnobDescriptionObsoleteSelect			= 0x000F,
	kMusicGetPartKnobSelect							= 0x0010,
	kMusicSetPartKnobSelect							= 0x0011,
	kMusicGetKnobSelect								= 0x0012,
	kMusicSetKnobSelect								= 0x0013,
	kMusicGetPartNameSelect							= 0x0014,
	kMusicSetPartNameSelect							= 0x0015,
	kMusicFindToneSelect							= 0x0016,
	kMusicPlayNoteSelect							= 0x0017,
	kMusicResetPartSelect							= 0x0018,
	kMusicSetPartControllerSelect					= 0x0019,
	kMusicGetPartControllerSelect					= 0x001A,
	kMusicGetMIDIProcSelect							= 0x001B,
	kMusicSetMIDIProcSelect							= 0x001C,
	kMusicGetInstrumentNamesSelect					= 0x001D,
	kMusicGetDrumNamesSelect						= 0x001E,
	kMusicGetMasterTuneSelect						= 0x001F,
	kMusicSetMasterTuneSelect						= 0x0020,
	kMusicGetInstrumentAboutInfoSelect				= 0x0022,
	kMusicGetDeviceConnectionSelect					= 0x0023,
	kMusicUseDeviceConnectionSelect					= 0x0024,
	kMusicGetKnobSettingStringsSelect				= 0x0025,
	kMusicGetMIDIPortsSelect						= 0x0026,
	kMusicSendMIDISelect							= 0x0027,
	kMusicReceiveMIDISelect							= 0x0028,
	kMusicStartOfflineSelect						= 0x0029,
	kMusicSetOfflineTimeToSelect					= 0x002A,
	kMusicGetInstrumentKnobDescriptionSelect		= 0x002B,
	kMusicGetDrumKnobDescriptionSelect				= 0x002C,
	kMusicGetKnobDescriptionSelect					= 0x002D,
	kMusicGetInfoTextSelect							= 0x002E,
	kMusicGetInstrumentInfoSelect					= 0x002F,
	kMusicTaskSelect								= 0x0031,
	kMusicSetPartInstrumentNumberInterruptSafeSelect = 0x0032,
	kMusicSetPartSoundLocalizationSelect			= 0x0033,
	kMusicGenericConfigureSelect					= 0x0100,
	kMusicGenericGetPartSelect						= 0x0101,
	kMusicGenericGetKnobListSelect					= 0x0102,
	kMusicDerivedMIDISendSelect						= 0x0200,
	kMusicDerivedSetKnobSelect						= 0x0201,
	kMusicDerivedSetPartSelect						= 0x0202,
	kMusicDerivedSetInstrumentSelect				= 0x0203,
	kMusicDerivedSetPartInstrumentNumberSelect		= 0x0204,
	kMusicDerivedSetMIDISelect						= 0x0205,
	kMusicDerivedStorePartInstrumentSelect			= 0x0206,
	kInstrumentGetInstSelect						= 0x0001,
	kInstrumentGetInfoSelect						= 0x0002,
	kInstrumentInitializeSelect						= 0x0003,
	kInstrumentOpenComponentResFileSelect			= 0x0004,
	kInstrumentCloseComponentResFileSelect			= 0x0005,
	kInstrumentGetComponentRefConSelect				= 0x0006,
	kInstrumentSetComponentRefConSelect				= 0x0007,
	kNARegisterMusicDeviceSelect					= 0x0000,
	kNAUnregisterMusicDeviceSelect					= 0x0001,
	kNAGetRegisteredMusicDeviceSelect				= 0x0002,
	kNASaveMusicConfigurationSelect					= 0x0003,
	kNANewNoteChannelSelect							= 0x0004,
	kNADisposeNoteChannelSelect						= 0x0005,
	kNAGetNoteChannelInfoSelect						= 0x0006,
	kNAPrerollNoteChannelSelect						= 0x0007,
	kNAUnrollNoteChannelSelect						= 0x0008,
	kNASetNoteChannelVolumeSelect					= 0x000B,
	kNAResetNoteChannelSelect						= 0x000C,
	kNAPlayNoteSelect								= 0x000D,
	kNASetControllerSelect							= 0x000E,
	kNASetKnobSelect								= 0x000F,
	kNAFindNoteChannelToneSelect					= 0x0010,
	kNASetInstrumentNumberSelect					= 0x0011,
	kNAPickInstrumentSelect							= 0x0012,
	kNAPickArrangementSelect						= 0x0013,
	kNASetDefaultMIDIInputSelect					= 0x0015,
	kNAGetDefaultMIDIInputSelect					= 0x0016,
	kNAUseDefaultMIDIInputSelect					= 0x0019,
	kNALoseDefaultMIDIInputSelect					= 0x001A,
	kNAStuffToneDescriptionSelect					= 0x001B,
	kNACopyrightDialogSelect						= 0x001C,
	kNAGetIndNoteChannelSelect						= 0x001F,
	kNAGetMIDIPortsSelect							= 0x0021,
	kNAGetNoteRequestSelect							= 0x0022,
	kNASendMIDISelect								= 0x0023,
	kNAPickEditInstrumentSelect						= 0x0024,
	kNANewNoteChannelFromAtomicInstrumentSelect		= 0x0025,
	kNASetAtomicInstrumentSelect					= 0x0026,
	kNAGetKnobSelect								= 0x0028,
	kNATaskSelect									= 0x0029,
	kNASetNoteChannelBalanceSelect					= 0x002A,
	kNASetInstrumentNumberInterruptSafeSelect		= 0x002B,
	kNASetNoteChannelSoundLocalizationSelect		= 0x002C,
	kTuneSetHeaderSelect							= 0x0004,
	kTuneGetTimeBaseSelect							= 0x0005,
	kTuneSetTimeScaleSelect							= 0x0006,
	kTuneGetTimeScaleSelect							= 0x0007,
	kTuneGetIndexedNoteChannelSelect				= 0x0008,
	kTuneQueueSelect								= 0x000A,
	kTuneInstantSelect								= 0x000B,
	kTuneGetStatusSelect							= 0x000C,
	kTuneStopSelect									= 0x000D,
	kTuneSetVolumeSelect							= 0x0010,
	kTuneGetVolumeSelect							= 0x0011,
	kTunePrerollSelect								= 0x0012,
	kTuneUnrollSelect								= 0x0013,
	kTuneSetNoteChannelsSelect						= 0x0014,
	kTuneSetPartTransposeSelect						= 0x0015,
	kTuneGetNoteAllocatorSelect						= 0x0017,
	kTuneSetSofterSelect							= 0x0018,
	kTuneTaskSelect									= 0x0019,
	kTuneSetBalanceSelect							= 0x001A,
	kTuneSetSoundLocalizationSelect					= 0x001B,
	kTuneSetHeaderWithSizeSelect					= 0x001C
};

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#ifdef __cplusplus
}
#endif

#endif /* __QUICKTIMEMUSIC__ */

