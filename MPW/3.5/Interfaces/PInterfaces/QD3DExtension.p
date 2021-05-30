{
     File:       QD3DExtension.p
 
     Contains:   QuickDraw 3D Plug-in Architecture	 Interface File.
 
     Version:    Technology: Quickdraw 3D 1.6
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1995-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QD3DExtension;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DEXTENSION__}
{$SETC __QD3DEXTENSION__ := 1}

{$I+}
{$SETC QD3DExtensionIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}
{$IFC UNDEFINED __QD3DERRORS__}
{$I QD3DErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{*****************************************************************************
 **                                                                          **
 **                             Constants                                    **
 **                                                                          **
 ****************************************************************************}
{$IFC TARGET_OS_MAC }

CONST
	kQ3XExtensionMacCreatorType	= 'Q3XT';
	kQ3XExtensionMacFileType	= 'shlb';

{$ENDC}  {TARGET_OS_MAC}


{*****************************************************************************
 **                                                                          **
 **                             Object Method types                          **
 **                                                                          **
 ****************************************************************************}

CONST
	kQ3XMethodTypeObjectClassVersion = 'vrsn';


TYPE
	TQ3XObjectClassVersion				= UInt32;

CONST
	kQ3XMethodTypeObjectClassRegister = 'rgst';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XObjectClassRegisterMethod = FUNCTION(objectClass: TQ3XObjectClass; classPrivate: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3XObjectClassRegisterMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodTypeObjectClassReplace = 'rgrp';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XObjectClassReplaceMethod = PROCEDURE(oldObjectClass: TQ3XObjectClass; oldClassPrivate: UNIV Ptr; newObjectClass: TQ3XObjectClass; newClassPrivate: UNIV Ptr); C;
{$ELSEC}
	TQ3XObjectClassReplaceMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodTypeObjectClassUnregister = 'unrg';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XObjectClassUnregisterMethod = PROCEDURE(objectClass: TQ3XObjectClass; classPrivate: UNIV Ptr); C;
{$ELSEC}
	TQ3XObjectClassUnregisterMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodTypeObjectNew		= 'newo';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XObjectNewMethod = FUNCTION(object: TQ3Object; privateData: UNIV Ptr; parameters: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3XObjectNewMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodTypeObjectDelete	= 'dlte';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XObjectDeleteMethod = PROCEDURE(object: TQ3Object; privateData: UNIV Ptr); C;
{$ELSEC}
	TQ3XObjectDeleteMethod = ProcPtr;
{$ENDC}


CONST
	kQ3XMethodTypeObjectDuplicate = 'dupl';


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XObjectDuplicateMethod = FUNCTION(fromObject: TQ3Object; fromPrivateData: UNIV Ptr; toObject: TQ3Object; toPrivateData: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3XObjectDuplicateMethod = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQ3XSharedLibraryRegister = FUNCTION: TQ3Status; C;
{$ELSEC}
	TQ3XSharedLibraryRegister = ProcPtr;
{$ENDC}

	{	*****************************************************************************
	 **                                                                          **
	 **                         Object Hierarchy Registration                    **
	 **                                                                          **
	 ****************************************************************************	}
	{	
	 *  Q3XObjectHierarchy_RegisterClass
	 *  
	 *  Register an object class in the QuickDraw 3D hierarchy.
	 *  
	 *  parentType          - an existing type in the hierarchy, or 0 to subclass
	 *                          TQ3Object
	 *  objectType          - the new object class type, used in the binary 
	 *                        metafile.  This is assigned at run time and returned
	 *                        to you.
	 *  objectName          - the new object name, used in the text metafile
	 *  metaHandler         - a TQ3XMetaHandler (may be NULL for some classes) 
	 *                        which returns non-virtual methods
	 *  virtualMetaHandler  - a TQ3XMetaHandler (may be NULL as well) which returns
	 *                          virtual methods a child would inherit
	 *  methodsSize         - the size of the class data needed (see 
	 *                          GetClassPrivate calls below)
	 *  instanceSize        - the size of the object instance data needed (see 
	 *                          GetPrivate calls below)
	 	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3XObjectHierarchy_RegisterClass()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3XObjectHierarchy_RegisterClass(parentType: TQ3ObjectType; VAR objectType: TQ3ObjectType; objectName: CStringPtr; metaHandler: TQ3XMetaHandler; virtualMetaHandler: TQ3XMetaHandler; methodsSize: UInt32; instanceSize: UInt32): TQ3XObjectClass; C;

{
 *  Q3XObjectHierarchy_UnregisterClass
 *  
 *  Returns kQ3Failure if the objectClass still has objects 
 * around; the class remains registered.
 }
{
 *  Q3XObjectHierarchy_UnregisterClass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XObjectHierarchy_UnregisterClass(objectClass: TQ3XObjectClass): TQ3Status; C;

{
 *  Q3XObjectHierarchy_GetMethod
 *  
 *  For use in TQ3XObjectClassRegisterMethod call
 }
{
 *  Q3XObjectClass_GetMethod()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XObjectClass_GetMethod(objectClass: TQ3XObjectClass; methodType: TQ3XMethodType): TQ3XFunctionPointer; C;

{
 *  Q3XObjectHierarchy_NewObject
 *  
 *  To create a new object. Parameters is passed into the 
 *  TQ3XObjectNewMethod as the "parameters" parameter.
 }
{
 *  Q3XObjectHierarchy_NewObject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XObjectHierarchy_NewObject(objectClass: TQ3XObjectClass; parameters: UNIV Ptr): TQ3Object; C;

{
 *  Q3XObjectClass_GetLeafType
 *  
 *  Return the leaf type of a class.
 }
{
 *  Q3XObjectClass_GetLeafType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XObjectClass_GetLeafType(objectClass: TQ3XObjectClass): TQ3ObjectType; C;

{
 *  Q3XObjectClass_GetVersion
 *  This routine obtains the the version of a class, referenced by an
 *  object class type.  Functions for getting the type are in QD3D.h,
 *  if you have the class name.
 }
{
 *  Q3XObjectHierarchy_GetClassVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XObjectHierarchy_GetClassVersion(objectClassType: TQ3ObjectType; VAR version: TQ3XObjectClassVersion): TQ3Status; C;

{
 *  Q3XObjectClass_GetType 
 *
 *  This can be used to get the type, given a reference 
 *  to a class.  This is most useful in the instance where you register a 
 *  an element/attribute and need to get the type.  When you register an
 *  element, QD3D will take the type you pass in and modify it (to avoid
 *  namespace clashes).  Many object system calls require an object type
 *  so this API call allows you to get the type from the class referernce
 *  that you will ordinarily store when you register the class.
 }
{
 *  Q3XObjectClass_GetType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XObjectClass_GetType(objectClass: TQ3XObjectClass; VAR theType: TQ3ObjectType): TQ3Status; C;


{
 *  Q3XObjectHierarchy_FindClassByType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XObjectHierarchy_FindClassByType(theType: TQ3ObjectType): TQ3XObjectClass; C;



{
 *  Q3XObjectClass_GetPrivate
 *  
 *  Return a pointer to private instance data, a block of instanceSize bytes, 
 *  from the Q3XObjectHierarchy_RegisterClass call.
 *  
 *  If instanceSize was zero, NULL is always returned.
 }
{
 *  Q3XObjectClass_GetPrivate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XObjectClass_GetPrivate(objectClass: TQ3XObjectClass; targetObject: TQ3Object): Ptr; C;

{
 * Return the "TQ3XObjectClass" of an object
 }
{
 *  Q3XObject_GetClass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XObject_GetClass(object: TQ3Object): TQ3XObjectClass; C;



{*****************************************************************************
 **                                                                          **
 **                 Shared Library Registration Entry Point                  **
 **                                                                          **
 ****************************************************************************}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	TQ3XSharedLibraryInfoPtr = ^TQ3XSharedLibraryInfo;
	TQ3XSharedLibraryInfo = RECORD
		registerFunction:		TQ3XSharedLibraryRegister;
		sharedLibrary:			UInt32;
	END;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3XSharedLibrary_Register()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3XSharedLibrary_Register(VAR sharedLibraryInfo: TQ3XSharedLibraryInfo): TQ3Status; C;

{
 *  Q3XSharedLibrary_Unregister()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3XSharedLibrary_Unregister(sharedLibrary: UInt32): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                             Posting Errors                               **
 **                                                                          **
 **         You may only call these functions from within an extension       **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3XError_Post
 *  
 *  Post a QuickDraw 3D Error from an extension.
 }
{
 *  Q3XError_Post()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE Q3XError_Post(error: TQ3Error); C;

{
 *  Q3XWarning_Post
 *  
 *  Post a QuickDraw 3D Warning, from an extension.  Note the warning code you
 *  pass into this routine must already be defined in the table above.
 }
{
 *  Q3XWarning_Post()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE Q3XWarning_Post(warning: TQ3Warning); C;

{
 *  Q3XNotice_Post
 *  
 *  Post a QuickDraw 3D Notice, from an extension.  Note the notice code you
 *  pass into this routine must already be defined in the table above.
 }
{
 *  Q3XNotice_Post()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE Q3XNotice_Post(notice: TQ3Notice); C;


{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC TARGET_OS_MAC }
{
 *  Q3XMacintoshError_Post
 *  
 *  Post the QuickDraw 3D Error, kQ3ErrorMacintoshError, and the Macintosh
 *  OSErr macOSErr. (Retrieved with Q3MacintoshError_Get)
 }
{$IFC CALL_NOT_IN_CARBON }
{
 *  Q3XMacintoshError_Post()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE Q3XMacintoshError_Post(macOSErr: OSErr); C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_MAC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DExtensionIncludes}

{$ENDC} {__QD3DEXTENSION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
