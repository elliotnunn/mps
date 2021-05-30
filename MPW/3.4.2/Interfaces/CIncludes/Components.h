/*
 	File:		Components.h
 
 	Contains:	QuickTime interfaces
 
 	Version:	Technology:	Technology:	QuickTime 2.5
 				Package:	Universal Interfaces 2.1.3
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/
#ifndef __COMPONENTS__
#define __COMPONENTS__

#ifndef __ERRORS__
#include <Errors.h>
#endif
#ifndef __TYPES__
#include <Types.h>
#endif
#ifndef __MEMORY__
#include <Memory.h>
#endif
#ifndef __MIXEDMODE__
#include <MixedMode.h>
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
	kAppleManufacturer			= 'appl',						/* Apple supplied components */
	kComponentResourceType		= 'thng'						/* a components resource type */
};


enum {
	kAnyComponentType			= 0,
	kAnyComponentSubType		= 0,
	kAnyComponentManufacturer	= 0,
	kAnyComponentFlagsMask		= 0
};


enum {
	cmpWantsRegisterMessage		= 1L << 31
};


enum {
	kComponentOpenSelect		= -1,							/* ComponentInstance for this open */
	kComponentCloseSelect		= -2,							/* ComponentInstance for this close */
	kComponentCanDoSelect		= -3,							/* selector # being queried */
	kComponentVersionSelect		= -4,							/* no params */
	kComponentRegisterSelect	= -5,							/* no params */
	kComponentTargetSelect		= -6,							/* ComponentInstance for top of call chain */
	kComponentUnregisterSelect	= -7,							/* no params */
	kComponentGetMPWorkFunctionSelect = -8						/* some params */
};

/* Component Resource Extension flags */

enum {
	componentDoAutoVersion		= (1 << 0),
	componentWantsUnregister	= (1 << 1),
	componentAutoVersionIncludeFlags = (1 << 2),
	componentHasMultiplePlatforms = (1 << 3)
};

/* Set Default Component flags */

enum {
	defaultComponentIdentical	= 0,
	defaultComponentAnyFlags	= 1,
	defaultComponentAnyManufacturer = 2,
	defaultComponentAnySubType	= 4,
	defaultComponentAnyFlagsAnyManufacturer = (defaultComponentAnyFlags + defaultComponentAnyManufacturer),
	defaultComponentAnyFlagsAnyManufacturerAnySubType = (defaultComponentAnyFlags + defaultComponentAnyManufacturer + defaultComponentAnySubType)
};

/* RegisterComponentResource flags */

enum {
	registerComponentGlobal		= 1,
	registerComponentNoDuplicates = 2,
	registerComponentAfterExisting = 4
};

struct ComponentDescription {
	OSType 							componentType;				/* A unique 4-byte code indentifying the command set */
	OSType 							componentSubType;			/* Particular flavor of this instance */
	OSType 							componentManufacturer;		/* Vendor indentification */
	unsigned long 					componentFlags;				/* 8 each for Component,Type,SubType,Manuf/revision */
	unsigned long 					componentFlagsMask;			/* Mask for specifying which flags to consider in search, zero during registration */
};
typedef struct ComponentDescription ComponentDescription;

struct ResourceSpec {
	OSType 							resType;					/* 4-byte code 	*/
	short 							resID;						/*  			*/
};
typedef struct ResourceSpec ResourceSpec;

struct ComponentResource {
	ComponentDescription 			cd;							/* Registration parameters */
	ResourceSpec 					component;					/* resource where Component code is found */
	ResourceSpec 					componentName;				/* name string resource */
	ResourceSpec 					componentInfo;				/* info string resource */
	ResourceSpec 					componentIcon;				/* icon resource */
};
typedef struct ComponentResource ComponentResource;

typedef ComponentResource *ComponentResourcePtr;
typedef ComponentResourcePtr *ComponentResourceHandle;
struct ComponentPlatformInfo {
	long 							componentFlags;				/* flags of Component */
	ResourceSpec 					component;					/* resource where Component code is found */
	short 							platformType;				/* gestaltSysArchitecture result */
};
typedef struct ComponentPlatformInfo ComponentPlatformInfo;

struct ComponentResourceExtension {
	long 							componentVersion;			/* version of Component */
	long 							componentRegisterFlags;		/* flags for registration */
	short 							componentIconFamily;		/* resource id of Icon Family */
};
typedef struct ComponentResourceExtension ComponentResourceExtension;

struct ComponentPlatformInfoArray {
	long 							count;
	ComponentPlatformInfo 			platformArray[1];
};
typedef struct ComponentPlatformInfoArray ComponentPlatformInfoArray;

struct ExtComponentResource {
	ComponentDescription 			cd;							/* registration parameters */
	ResourceSpec 					component;					/* resource where Component code is found */
	ResourceSpec 					componentName;				/* name string resource */
	ResourceSpec 					componentInfo;				/* info string resource */
	ResourceSpec 					componentIcon;				/* icon resource */
	long 							componentVersion;			/* version of Component */
	long 							componentRegisterFlags;		/* flags for registration */
	short 							componentIconFamily;		/* resource id of Icon Family */
	long 							count;						/* elements in platformArray */
	ComponentPlatformInfo 			platformArray[1];
};
typedef struct ExtComponentResource ExtComponentResource;

/*  Structure received by Component:		*/
struct ComponentParameters {
	UInt8 							flags;						/* call modifiers: sync/async, deferred, immed, etc */
	UInt8 							paramSize;					/* size in bytes of actual parameters passed to this call */
	short 							what;						/* routine selector, negative for Component management calls */
	long 							params[1];					/* actual parameters for the indicated routine */
};
typedef struct ComponentParameters ComponentParameters;

struct ComponentRecord {
	long 							data[1];
};
typedef struct ComponentRecord ComponentRecord;

typedef ComponentRecord *Component;
struct ComponentInstanceRecord {
	long 							data[1];
};
typedef struct ComponentInstanceRecord ComponentInstanceRecord;

typedef ComponentInstanceRecord *ComponentInstance;
struct RegisteredComponentRecord {
	long 							data[1];
};
typedef struct RegisteredComponentRecord RegisteredComponentRecord;

typedef RegisteredComponentRecord *RegisteredComponentPtr;
struct RegisteredComponentInstanceRecord {
	long 							data[1];
};
typedef struct RegisteredComponentInstanceRecord RegisteredComponentInstanceRecord;

typedef RegisteredComponentInstanceRecord *RegisteredComponentInstancePtr;
typedef long ComponentResult;

enum {
	mpWorkFlagDoWork			= (1 << 0),
	mpWorkFlagDoCompletion		= (1 << 1),
	mpWorkFlagCopyWorkBlock		= (1 << 2),
	mpWorkFlagDontBlock			= (1 << 3),
	mpWorkFlagGetProcessorCount	= (1 << 4),
	mpWorkFlagGetIsRunning		= (1 << 6)
};

struct ComponentMPWorkFunctionHeaderRecord {
	UInt32 							headerSize;
	UInt32 							recordSize;
	UInt32 							workFlags;
	UInt16 							processorCount;
	UInt8 							unused;
	UInt8 							isRunning;
};
typedef struct ComponentMPWorkFunctionHeaderRecord ComponentMPWorkFunctionHeaderRecord;

typedef ComponentMPWorkFunctionHeaderRecord *ComponentMPWorkFunctionHeaderRecordPtr;
typedef pascal ComponentResult (*ComponentMPWorkFunctionProcPtr)(void *globalRefCon, ComponentMPWorkFunctionHeaderRecordPtr header);
typedef pascal ComponentResult (*ComponentRoutineProcPtr)(ComponentParameters *cp, Handle componentStorage);

#if GENERATINGCFM
typedef UniversalProcPtr ComponentMPWorkFunctionUPP;
typedef UniversalProcPtr ComponentRoutineUPP;
#else
typedef ComponentMPWorkFunctionProcPtr ComponentMPWorkFunctionUPP;
typedef ComponentRoutineProcPtr ComponentRoutineUPP;
#endif
/*
	The parameter list for each ComponentFunction is unique. It is 
	therefore up to users to create the appropriate procInfo for their 
	own ComponentFunctions where necessary.
*/
typedef UniversalProcPtr ComponentFunctionUPP;
#if GENERATINGCFM
/* 
	CallComponentUPP is a global variable exported from InterfaceLib.
	It is the ProcPtr passed to CallUniversalProc to manually call a component function.
*/
extern UniversalProcPtr CallComponentUPP;
#endif
#define ComponentCallNow( callNumber, paramSize ) \
	FIVEWORDINLINE( 0x2F3C,paramSize,callNumber,0x7000,0xA82A )

/*
*******************************************************
*														*
*  				APPLICATION LEVEL CALLS					*
*														*
*******************************************************
*/
/*
*******************************************************
* Component Database Add, Delete, and Query Routines 
*******************************************************
*/
extern pascal Component RegisterComponent(ComponentDescription *cd, ComponentRoutineUPP componentEntryPoint, short global, Handle componentName, Handle componentInfo, Handle componentIcon)
 TWOWORDINLINE(0x7001, 0xA82A);

extern pascal Component RegisterComponentResource(ComponentResourceHandle cr, short global)
 TWOWORDINLINE(0x7012, 0xA82A);

extern pascal OSErr UnregisterComponent(Component aComponent)
 TWOWORDINLINE(0x7002, 0xA82A);

extern pascal Component FindNextComponent(Component aComponent, ComponentDescription *looking)
 TWOWORDINLINE(0x7004, 0xA82A);

extern pascal long CountComponents(ComponentDescription *looking)
 TWOWORDINLINE(0x7003, 0xA82A);

extern pascal OSErr GetComponentInfo(Component aComponent, ComponentDescription *cd, Handle componentName, Handle componentInfo, Handle componentIcon)
 TWOWORDINLINE(0x7005, 0xA82A);

extern pascal long GetComponentListModSeed(void )
 TWOWORDINLINE(0x7006, 0xA82A);

extern pascal long GetComponentTypeModSeed(OSType componentType)
 TWOWORDINLINE(0x702C, 0xA82A);

/*
*******************************************************
* Component Instance Allocation and dispatch routines 
*******************************************************
*/
extern pascal OSErr OpenAComponent(Component aComponent, ComponentInstance *ci)
 TWOWORDINLINE(0x702D, 0xA82A);

extern pascal ComponentInstance OpenComponent(Component aComponent)
 TWOWORDINLINE(0x7007, 0xA82A);

extern pascal OSErr CloseComponent(ComponentInstance aComponentInstance)
 TWOWORDINLINE(0x7008, 0xA82A);

extern pascal OSErr GetComponentInstanceError(ComponentInstance aComponentInstance)
 TWOWORDINLINE(0x700A, 0xA82A);

/*
*******************************************************
*														*
*  					CALLS MADE BY COMPONENTS	  		*
*														*
*******************************************************
*/
/*
*******************************************************
* Component Management routines
*******************************************************
*/
extern pascal void SetComponentInstanceError(ComponentInstance aComponentInstance, OSErr theError)
 TWOWORDINLINE(0x700B, 0xA82A);

extern pascal long GetComponentRefcon(Component aComponent)
 TWOWORDINLINE(0x7010, 0xA82A);

extern pascal void SetComponentRefcon(Component aComponent, long theRefcon)
 TWOWORDINLINE(0x7011, 0xA82A);

extern pascal short OpenComponentResFile(Component aComponent)
 TWOWORDINLINE(0x7015, 0xA82A);

extern pascal OSErr OpenAComponentResFile(Component aComponent, short *resRef)
 TWOWORDINLINE(0x702F, 0xA82A);

extern pascal OSErr CloseComponentResFile(short refnum)
 TWOWORDINLINE(0x7018, 0xA82A);

/*
*******************************************************
* Component Instance Management routines
*******************************************************
*/
extern pascal Handle GetComponentInstanceStorage(ComponentInstance aComponentInstance)
 TWOWORDINLINE(0x700C, 0xA82A);

extern pascal void SetComponentInstanceStorage(ComponentInstance aComponentInstance, Handle theStorage)
 TWOWORDINLINE(0x700D, 0xA82A);

extern pascal long GetComponentInstanceA5(ComponentInstance aComponentInstance)
 TWOWORDINLINE(0x700E, 0xA82A);

extern pascal void SetComponentInstanceA5(ComponentInstance aComponentInstance, long theA5)
 TWOWORDINLINE(0x700F, 0xA82A);

extern pascal long CountComponentInstances(Component aComponent)
 TWOWORDINLINE(0x7013, 0xA82A);

/* useful helper routines for convenient method dispatching */
extern pascal long CallComponentFunction(ComponentParameters *params, ComponentFunctionUPP func)
 TWOWORDINLINE(0x70FF, 0xA82A);

extern pascal long CallComponentFunctionWithStorage(Handle storage, ComponentParameters *params, ComponentFunctionUPP func)
 TWOWORDINLINE(0x70FF, 0xA82A);

#if GENERATINGPOWERPC
extern pascal long CallComponentFunctionWithStorageProcInfo(Handle storage, ComponentParameters *params, ProcPtr func, long funcProcInfo);

#else
#define CallComponentFunctionWithStorageProcInfo(storage, params, func, funcProcInfo ) CallComponentFunctionWithStorage(storage, params, func)

#endif
extern pascal long DelegateComponentCall(ComponentParameters *originalParams, ComponentInstance ci)
 TWOWORDINLINE(0x7024, 0xA82A);

extern pascal OSErr SetDefaultComponent(Component aComponent, short flags)
 TWOWORDINLINE(0x701E, 0xA82A);

extern pascal ComponentInstance OpenDefaultComponent(OSType componentType, OSType componentSubType)
 TWOWORDINLINE(0x7021, 0xA82A);

extern pascal OSErr OpenADefaultComponent(OSType componentType, OSType componentSubType, ComponentInstance *ci)
 TWOWORDINLINE(0x702E, 0xA82A);

extern pascal Component CaptureComponent(Component capturedComponent, Component capturingComponent)
 TWOWORDINLINE(0x701C, 0xA82A);

extern pascal OSErr UncaptureComponent(Component aComponent)
 TWOWORDINLINE(0x701D, 0xA82A);

extern pascal long RegisterComponentResourceFile(short resRefNum, short global)
 TWOWORDINLINE(0x7014, 0xA82A);

extern pascal OSErr GetComponentIconSuite(Component aComponent, Handle *iconSuite)
 TWOWORDINLINE(0x7029, 0xA82A);

/*
*******************************************************
*														*
*  			Direct calls to the Components				*
*														*
*******************************************************
*/
/* Old style names*/
extern pascal long ComponentFunctionImplemented(ComponentInstance ci, short ftnNumber)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0xFFFD, 0x7000, 0xA82A);

extern pascal long GetComponentVersion(ComponentInstance ci)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0xFFFC, 0x7000, 0xA82A);

extern pascal long ComponentSetTarget(ComponentInstance ci, ComponentInstance target)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0xFFFA, 0x7000, 0xA82A);

/* New style names*/
extern pascal ComponentResult CallComponentOpen(ComponentInstance ci, ComponentInstance self)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0xFFFF, 0x7000, 0xA82A);

extern pascal ComponentResult CallComponentClose(ComponentInstance ci, ComponentInstance self)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0xFFFE, 0x7000, 0xA82A);

extern pascal ComponentResult CallComponentCanDo(ComponentInstance ci, short ftnNumber)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0xFFFD, 0x7000, 0xA82A);

extern pascal ComponentResult CallComponentVersion(ComponentInstance ci)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0xFFFC, 0x7000, 0xA82A);

extern pascal ComponentResult CallComponentRegister(ComponentInstance ci)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0xFFFB, 0x7000, 0xA82A);

extern pascal ComponentResult CallComponentTarget(ComponentInstance ci, ComponentInstance target)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0xFFFA, 0x7000, 0xA82A);

extern pascal ComponentResult CallComponentUnregister(ComponentInstance ci)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0xFFF9, 0x7000, 0xA82A);

extern pascal ComponentResult CallComponentGetMPWorkFunction(ComponentInstance ci, ComponentMPWorkFunctionUPP *workFunction, void **refCon)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0xFFF8, 0x7000, 0xA82A);

/* UPP call backs */

#if GENERATINGCFM
#else
#endif

enum {
	uppComponentMPWorkFunctionProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(ComponentResult)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(void *)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(ComponentMPWorkFunctionHeaderRecordPtr))),
	uppComponentRoutineProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(ComponentResult)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ComponentParameters *)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Handle)))
};

#if GENERATINGCFM
#define NewComponentMPWorkFunctionProc(userRoutine)		\
		(ComponentMPWorkFunctionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppComponentMPWorkFunctionProcInfo, GetCurrentArchitecture())
#define NewComponentRoutineProc(userRoutine)		\
		(ComponentRoutineUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppComponentRoutineProcInfo, GetCurrentArchitecture())
#else
#define NewComponentMPWorkFunctionProc(userRoutine)		\
		((ComponentMPWorkFunctionUPP) (userRoutine))
#define NewComponentRoutineProc(userRoutine)		\
		((ComponentRoutineUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallComponentMPWorkFunctionProc(userRoutine, globalRefCon, header)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppComponentMPWorkFunctionProcInfo, (globalRefCon), (header))
#define CallComponentRoutineProc(userRoutine, cp, componentStorage)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppComponentRoutineProcInfo, (cp), (componentStorage))
#else
#define CallComponentMPWorkFunctionProc(userRoutine, globalRefCon, header)		\
		(*(userRoutine))((globalRefCon), (header))
#define CallComponentRoutineProc(userRoutine, cp, componentStorage)		\
		(*(userRoutine))((cp), (componentStorage))
#endif
/* ProcInfos */

/* MixedMode ProcInfo constants for component calls */
enum {
	uppComponentFunctionImplementedProcInfo			= 0x000002F0,
	uppGetComponentVersionProcInfo					= 0x000000F0,
	uppComponentSetTargetProcInfo					= 0x000003F0,
	uppCallComponentOpenProcInfo					= 0x000003F0,
	uppCallComponentCloseProcInfo					= 0x000003F0,
	uppCallComponentCanDoProcInfo					= 0x000002F0,
	uppCallComponentVersionProcInfo					= 0x000000F0,
	uppCallComponentRegisterProcInfo				= 0x000000F0,
	uppCallComponentTargetProcInfo					= 0x000003F0,
	uppCallComponentUnregisterProcInfo				= 0x000000F0,
	uppCallComponentGetMPWorkFunctionProcInfo		= 0x00000FF0
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

#endif /* __COMPONENTS__ */

