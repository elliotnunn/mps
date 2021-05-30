{
	OPEN SCRIPTING ARCHITECTURE: Generic Component Interface
	OSAGeneric.p

	Copyright Apple Computer, Inc. 1992-1993
	Authors: Jens Alfke, William Cook, Donn Denman, and Warren Harris

	This interface defines a "generic scripting component."
	The Generic Scripting Component allows automatic dispatch to a
	specific scripting component that conforms to the OSA interface.
	This component supports OSA, by calling AppleScript or some other 
	scripting component.  Additionally it provides access to the default
	and the user-prefered scripting component.
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
    UNIT OSAGeneric;
    INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingOSAGeneric}
{$SETC UsingOSAGeneric := 1}

{$I+}
{$SETC OSAGenericIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingOSA}
{$I $$Shell(PInterfaces)OSA.p}
{$ENDC}
{$SETC UsingIncludes := OSAGenericIncludes}


{ Types and Constants }
CONST
	errOSAComponentMismatch			= -1761;	{Parameters are from 2 different components}
	errOSACantOpenComponent			= -1762;	{Can't connect to scripting system with that ID}

	kGenericComponentVersion		= $0100;	{Component version this header file describes}

	{Selector values for special Generic Component routines:}
	kGSSSelectGetDefaultScriptingComponent	= $1001;	{ = kOSASelectComponentSpecificStart}
	kGSSSelectSetDefaultScriptingComponent	= $1002;
	kGSSSelectGetScriptingComponent			= $1003;
	kGSSSelectGetScriptingComponentFromStored=$1004;
	kGSSSelectGenericToRealID				= $1005;
	kGSSSelectRealToGenericID				= $1006;
	kGSSSelectOutOfRange					= $1007;

TYPE
	ScriptingComponentSelector	= OSType;
	GenericID					= OSAID;

{ get and set the default scripting component }
FUNCTION
OSAGetDefaultScriptingComponent( genericScriptingComponent	: ComponentInstance;
								 VAR scriptingSubType		: ScriptingComponentSelector){ out }
	: OSAError;
    INLINE $2F3C, $0004, $1001, $7000, $A82A;
	
FUNCTION 
OSASetDefaultScriptingComponent( genericScriptingComponent	: ComponentInstance;
						 		 scriptingSubType			: ScriptingComponentSelector)
	: OSAError;
    INLINE $2F3C, $0004, $1002, $7000, $A82A;

{ get a scripting component instance from its subtype code }
FUNCTION 
OSAGetScriptingComponent( genericScriptingComponent	: ComponentInstance;
						  scriptingSubType			: ScriptingComponentSelector;
					 	  VAR scriptingInstance		: ComponentInstance)				{ out }
	: OSAError;
    INLINE $2F3C, $0008, $1003, $7000, $A82A;

{ get a scripting component selector (subtype) from a stored script }
FUNCTION 
OSAGetScriptingComponentFromStored( genericScriptingComponent	: ComponentInstance;
									scriptData					: AEDesc;
									VAR scriptingSubType		: ScriptingComponentSelector){ out }
	: OSAError;
    INLINE $2F3C, $0008, $1004, $7000, $A82A;

{ get a real component instance and script id from a generic id }
FUNCTION 
OSAGenericToRealID( genericScriptingComponent	: ComponentInstance;
					VAR theScriptID				: OSAID;								{ in/out }
					VAR theExactComponent		: ComponentInstance )					{ out }
	: OSAError;
    INLINE $2F3C, $0008, $1005, $7000, $A82A;

{ get a generic id from a real component instance and script id }
FUNCTION 
OSARealToGenericID( genericScriptingComponent	: ComponentInstance;
					VAR theScriptID				: OSAID;								{ in/out }
					theExactComponent			: ComponentInstance )
	: OSAError;
    INLINE $2F3C, $0008, $1006, $7000, $A82A;


{$ENDC}    { UsingOSAGeneric }

{$IFC NOT UsingIncludes}
    END.
{$ENDC}
