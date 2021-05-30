{
     File:       CFPlugIn.p
 
     Contains:   CoreFoundation plugins
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CFPlugIn;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFPLUGIN__}
{$SETC __CFPLUGIN__ := 1}

{$I+}
{$SETC CFPlugInIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}
{$IFC UNDEFINED __CFARRAY__}
{$I CFArray.p}
{$ENDC}
{$IFC UNDEFINED __CFBUNDLE__}
{$I CFBundle.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{$IFC UNDEFINED __CFURL__}
{$I CFURL.p}
{$ENDC}
{$IFC UNDEFINED __CFUUID__}
{$I CFUUID.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ ================ Standard Info.plist keys for plugIns ================ }
{
 *  kCFPlugInDynamicRegistrationKey
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
{
 *  kCFPlugInDynamicRegisterFunctionKey
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
{
 *  kCFPlugInUnloadFunctionKey
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
{
 *  kCFPlugInFactoriesKey
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
{
 *  kCFPlugInTypesKey
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
{ ================= Function prototypes for various callbacks ================= }
{ Function types that plugIn authors can implement for various purposes. }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	CFPlugInDynamicRegisterFunction = PROCEDURE(plugIn: CFPlugInRef); C;
{$ELSEC}
	CFPlugInDynamicRegisterFunction = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFPlugInUnloadFunction = PROCEDURE(plugIn: CFPlugInRef); C;
{$ELSEC}
	CFPlugInUnloadFunction = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFPlugInFactoryFunction = FUNCTION(allocator: CFAllocatorRef; typeUUID: CFUUIDRef): Ptr; C;
{$ELSEC}
	CFPlugInFactoryFunction = ProcPtr;
{$ENDC}

	{	 ================= Creating PlugIns ================= 	}
	{
	 *  CFPlugInGetTypeID()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFPlugInGetTypeID: UInt32; C;

{
 *  CFPlugInCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPlugInCreate(allocator: CFAllocatorRef; plugInURL: CFURLRef): CFPlugInRef; C;

{ Might return an existing instance with the ref-count bumped. }
{
 *  CFPlugInGetBundle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPlugInGetBundle(plugIn: CFPlugInRef): CFBundleRef; C;

{ ================= Controlling load on demand ================= }
{ For plugIns. }
{ PlugIns that do static registration are load on demand by default. }
{ PlugIns that do dynamic registration are not load on demand by default. }
{ A dynamic registration function can call CFPlugInSetLoadOnDemand(). }
{
 *  CFPlugInSetLoadOnDemand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFPlugInSetLoadOnDemand(plugIn: CFPlugInRef; flag: BOOLEAN); C;

{
 *  CFPlugInIsLoadOnDemand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPlugInIsLoadOnDemand(plugIn: CFPlugInRef): BOOLEAN; C;

{ ================= Finding factories and creating instances ================= }
{ For plugIn hosts. }
{ Functions for finding factories to create specific types and actually creating instances of a type. }
{
 *  CFPlugInFindFactoriesForPlugInType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPlugInFindFactoriesForPlugInType(typeUUID: CFUUIDRef): CFArrayRef; C;

{ This function finds all the factories from any plugin for the given type.  }
{
 *  CFPlugInFindFactoriesForPlugInTypeInPlugIn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPlugInFindFactoriesForPlugInTypeInPlugIn(typeUUID: CFUUIDRef; plugIn: CFPlugInRef): CFArrayRef; C;

{ This function restricts the result to factories from the given plug-in that can create the given type }
{
 *  CFPlugInInstanceCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPlugInInstanceCreate(allocator: CFAllocatorRef; factoryUUID: CFUUIDRef; typeUUID: CFUUIDRef): Ptr; C;

{ This function returns the IUnknown interface for the new instance. }
{ ================= Registering factories and types ================= }
{ For plugIn writers who must dynamically register things. }
{ Functions to register factory functions and to associate factories with types. }
{
 *  CFPlugInRegisterFactoryFunction()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPlugInRegisterFactoryFunction(factoryUUID: CFUUIDRef; func: CFPlugInFactoryFunction): BOOLEAN; C;

{
 *  CFPlugInRegisterFactoryFunctionByName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPlugInRegisterFactoryFunctionByName(factoryUUID: CFUUIDRef; plugIn: CFPlugInRef; functionName: CFStringRef): BOOLEAN; C;

{
 *  CFPlugInUnregisterFactory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPlugInUnregisterFactory(factoryUUID: CFUUIDRef): BOOLEAN; C;

{
 *  CFPlugInRegisterPlugInType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPlugInRegisterPlugInType(factoryUUID: CFUUIDRef; typeUUID: CFUUIDRef): BOOLEAN; C;

{
 *  CFPlugInUnregisterPlugInType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPlugInUnregisterPlugInType(factoryUUID: CFUUIDRef; typeUUID: CFUUIDRef): BOOLEAN; C;

{ ================= Registering instances ================= }
{ When a new instance of a type is created, the instance is responsible for registering itself with the factory that created it and unregistering when it deallocates. }
{ This means that an instance must keep track of the CFUUIDRef of the factory that created it so it can unregister when it goes away. }
{
 *  CFPlugInAddInstanceForFactory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFPlugInAddInstanceForFactory(factoryID: CFUUIDRef); C;

{
 *  CFPlugInRemoveInstanceForFactory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFPlugInRemoveInstanceForFactory(factoryID: CFUUIDRef); C;


{ Obsolete API }

TYPE
	CFPlugInInstanceRef    = ^LONGINT; { an opaque 32-bit type }
	CFPlugInInstanceRefPtr = ^CFPlugInInstanceRef;  { when a VAR xx:CFPlugInInstanceRef parameter can be nil, it is changed to xx: CFPlugInInstanceRefPtr }
{$IFC TYPED_FUNCTION_POINTERS}
	CFPlugInInstanceGetInterfaceFunction = FUNCTION(instance: CFPlugInInstanceRef; interfaceName: CFStringRef; VAR ftbl: UNIV Ptr): BOOLEAN; C;
{$ELSEC}
	CFPlugInInstanceGetInterfaceFunction = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFPlugInInstanceDeallocateInstanceDataFunction = PROCEDURE(instanceData: UNIV Ptr); C;
{$ELSEC}
	CFPlugInInstanceDeallocateInstanceDataFunction = ProcPtr;
{$ENDC}

	{
	 *  CFPlugInInstanceGetInterfaceFunctionTable()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFPlugInInstanceGetInterfaceFunctionTable(instance: CFPlugInInstanceRef; interfaceName: CFStringRef; VAR ftbl: UNIV Ptr): BOOLEAN; C;

{
 *  CFPlugInInstanceGetFactoryName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPlugInInstanceGetFactoryName(instance: CFPlugInInstanceRef): CFStringRef; C;

{
 *  CFPlugInInstanceGetInstanceData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPlugInInstanceGetInstanceData(instance: CFPlugInInstanceRef): Ptr; C;

{
 *  CFPlugInInstanceGetTypeID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPlugInInstanceGetTypeID: UInt32; C;

{
 *  CFPlugInInstanceCreateWithInstanceDataSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPlugInInstanceCreateWithInstanceDataSize(allocator: CFAllocatorRef; instanceDataSize: CFIndex; deallocateInstanceFunction: CFPlugInInstanceDeallocateInstanceDataFunction; factoryName: CFStringRef; getInterfaceFunction: CFPlugInInstanceGetInterfaceFunction): CFPlugInInstanceRef; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFPlugInIncludes}

{$ENDC} {__CFPLUGIN__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
