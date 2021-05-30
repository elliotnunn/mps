{———————————————————————————————————————————————————————————————————————————————————}
{											
	©Apple Computer, Inc.  1990, 1991 			
	      All Rights Reserved.				

{[r+,l+,k+,v+,t=4,0=150] Pasmat options}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT AEObjects;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingAEObjects}
{$SETC UsingAEObjects := 1}

{$I+}
{$SETC AEObjectIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$IFC UNDEFINED UsingMemory}
{$I $$Shell(PInterfaces)Memory.p}
{$ENDC}
{$IFC UNDEFINED UsingOSUtils}
{$I $$Shell(PInterfaces)OSUtils.p}
{$ENDC}
{$IFC UNDEFINED UsingEvents}
{$I $$Shell(PInterfaces)Events.p}
{$ENDC}
{$IFC UNDEFINED UsingEPPC}
{$I $$Shell(PInterfaces)EPPC.p}
{$ENDC}
{$IFC UNDEFINED UsingAppleEvents}
{$I $$Shell(PInterfaces)AppleEvents.p}
{$ENDC}

{$SETC UsingIncludes := AEObjectIncludes}

CONST

{ Logical operators: look for them in descriptors of type typeLogicalDescriptor
  with keyword keyAELogicalOperator }
	kAEAND					=	'AND ';
	kAEOR					=	'OR  ';
	kAENOT					=	'NOT ';

{ Absolute ordinals: look for them in descriptors of type typeAbsoluteOrdinal.
  Possible use is as keyAEKeyData in an object specifier whose keyAEKeyForm
  field is formAbsolutePosition. }
	kAEFirst				=	'firs';
	kAELast					=	'last';
	kAEMiddle				=	'midd';
	kAEAny					=	'any ';
	kAEAll					=	'all ';

{  Relative ordinals: look for them in descriptors of type formRelativePosition. }
	kAENext					=	'next';
	kAEPrevious				=	'prev';

{********* Keywords for getting fields out of Object specifier records *********}
	keyAEDesiredClass		=	'want';
	keyAEContainer			=	'from';
	keyAEKeyForm			=	'form';
	keyAEKeyData	 		= 	'seld';


{********* Keywords for getting fields out of Range specifier records *********}
	keyAERangeStart			=	'star';		{ These are the only two fields in the range desc }
	keyAERangeStop			=	'stop';
	
{********* Possible values for the keyAEKeyForm field of an object specifier *********}
{ Remember that this set is an open-ended one.  The OSL makes assumptions about some of them,
  but nothing in the grammar says you can't define your own }
	formAbsolutePosition 	=	'indx' ;	{ e.g., 1st, -2nd (= 2nd from end) }
	formRelativePosition	=	'rele' ;	{ next, previous }
	formTest				=	'test' ;	{ A logical or a comparison }
	formRange				=	'rang' ;	{ Two arbitrary objects and everything in between }
	formPropertyID			=	'prop' ;	{ Key data is a 4-char property name }
	formName				=	'name' ;	{ Key data may be of type 'TEXT' }

{************* Various relevant types ***************}
{ Some of these tend to be paired with certain of the forms above.  Where this
  is the case comments indicating the form(s) follow. }
	typeObjectSpecifier 	= 	'obj ';		{ keyAEContainer will often be one of these }
	typeObjectBeingExamined =	'exmn';		{ Another possible value for keyAEContainer }
	typeCurrentContainer	=	'ccnt';		{ Another possible value for keyAEContainer }
	typeToken				=	'toke';		{ Substituted for 'ccnt' before accessor called }

	typeRelativeDescriptor 	=	'rel ';		{ formRelativePosition }
	typeAbsoluteOrdinal 	=	'abso';		{ formAbsolutePosition }
	typeIndexDescriptor		=	'inde';		{ formAbsolutePosition }
	typeRangeDescriptor 	= 	'rang';		{ formRange }
	typeLogicalDescriptor	= 	'logi';		{ formTest is this or typeCompDescriptor }
	typeCompDescriptor		=	'cmpd';		{ formTest is this or typeLogicalDescriptor }
	
{************* various relevant keywords ***************}
	keyAECompOperator		=	'relo';		{ Relates two terms: '=', '<=', etc. }
	keyAELogicalTerms		=	'term';		{ An AEList of terms to be related by 'logc' below }
	keyAELogicalOperator	=	'logc';		{ kAEAND,  kAEOR or kAENOT }
	keyAEObject1			=	'obj1';		{ One of two objects in a term; must be object specifier }
	keyAEObject2			=	'obj2';		{ The other object; may be a simple descriptor or obj. spec. }


{*********** Special Handler selectors for OSL Callbacks **************}
{ You don't need to use these unless you are not using AESetObjectCallbacks. }
	keyDisposeTokenProc		=	'xtok';
	keyAECompareProc 		= 	'cmpr';
	keyAECountProc 			= 	'cont';
	keyAEMarkTokenProc 		= 	'mkid';
	keyAEMarkProc 			= 	'mark';
	keyAEAdjustMarksProc 	= 	'adjm';
	keyAEGetErrDescProc 	= 	'indc';

{*********** Error codes **************}
{ OSL error codes: AEM proper uses up to -1719}
	errAEImpossibleRange	=	-1720 ;		{ A range like 3rd to 2nd, or 1st to all. }
	errAEWrongNumberArgs	=	-1721 ;		{ Logical op kAENOT used with other than 1 term }

	errAEAccessorNotFound 	=	-1723 ;		{ Accessor proc matching wantClass and containerType
											...or wildcards not found }
	errAENoSuchLogical		=	-1725 ; 	{ Something other than AND, OR, or NOT }
	errAEBadTestKey			=	-1726 ;		{ Test is neither typeLogicalDescriptor
											...nor typeCompDescriptor }
	errAENotAnObjSpec		=	-1727 ; 	{ Param to AEResolve not of type 'obj ' }
	errAENoSuchObject		=	-1728 ; 	{ e.g.,: specifier asked for the 3rd, but there are only 2.
											...Basically, this indicates a run-time resolution error. }
	errAENegativeCount		=	-1729 ;		{ CountProc returned negative value }
	errAEEmptyListContainer	=	-1730 ;		{ Attempt to pass empty list as container to accessor }
	
{ Possible values for flags parameter to AEResolve.  They're additive }
	kAEIDoMinimum			=	$0000 ;
	kAEIDoWhose				=	$0001 ;
	kAEIDoMarking			=	$0004 ;


{ You only care about the constants that follow if you're doing your own whose
  clause resolution }
	typeWhoseDescriptor		=	'whos';
	formWhose				=	'whos';
	typeWhoseRange			=	'wrng';
	keyAEWhoseRangeStart	=	'wstr';
	keyAEWhoseRangeStop		=	'wstp';
	keyAEIndex				=	'kidx';
	keyAETest				=	'ktst';


TYPE
	ccntTokenRecord = RECORD		{ Used for rewriting tokens in place of 'ccnt' descriptors.		}
		tokenClass: DescType ;		{ This record is only of interest to those who, when they...	}
		token:		AEDesc ;		{ ...get ranges as key data in their accessor procs, choose...	}
		END ;						{ ...resolve them manually rather than call AEResolve again.	}
	ccntTokenRecPtr = ^ccntTokenRecord ;
	ccntTokenRecHandle = ^ccntTokenRecPtr ;

	DescPtr = ^AEDesc ;
	DescHandle = ^DescPtr ;

	AccessorProcPtr= ProcPtr;

{——————————————————————————————— PUBLIC PROCEDURES —————————————————————————————————}

{ Not done by inline, but by direct linking into code.  It sets up the pack
  such that further calls can be via inline }
FUNCTION  AEObjectInit									: OSErr ;


FUNCTION AESetObjectCallbacks(myCompareProc,
							myCountProc,
							myDisposeTokenProc,
							myGetMarkTokenProc,					{ called when mark (below) is true }
							myMarkProc,							{ called when mark (below) is true }
							myAdjustMarksProc,					{ called when mark (below) is true }
							myGetErrDescProc: ProcPtr)	: OSErr;{ called to report an error descriptor }
INLINE $303C, $0E35, $A816;		{ = move.w	#$E35,d0 \n _Pack8 }




FUNCTION  AEResolve			(	objectSpecifier:	AEDesc;
								callbackFlags:		INTEGER ;		{ see above for possible values }
					  			VAR theToken:		AEDesc)	: OSErr;
INLINE $303C, $0536, $A816;		{ = move.w	#$E35,d0 \n _Pack8 }


FUNCTION AEInstallObjectAccessor(desiredClass: 		DescType;
							   	containerType: 		DescType;
							   	theAccessor: 		AccessorProcPtr;
							   	accessorRefcon: 	LONGINT;
							   	isSysHandler: 		BOOLEAN): OSErr;
INLINE $303C, $0937, $A816;		{ = move.w	#$E35,d0 \n _Pack8 }

FUNCTION AERemoveObjectAccessor(	desiredClass: 		DescType ;
									containerType: 		DescType ;
									theAccessor: 		AccessorProcPtr ;
									isSysHandler: 		BOOLEAN ) : OSErr ;
INLINE $303C, $0738, $A816;		{ = move.w	#$E35,d0 \n _Pack8 }

FUNCTION AEGetObjectAccessor(	desiredClass: 		DescType;
								containerType: 		DescType;
								VAR theAccessor: 	AccessorProcPtr;
								VAR accessorRefcon: LONGINT;
								isSysHandler: 		BOOLEAN): OSErr;
INLINE $303C, $0939, $A816;		{ = move.w	#$E35,d0 \n _Pack8 }

FUNCTION AEDisposeToken( VAR theToken: AEDesc ): OSErr ;
INLINE $303C, $023A, $A816;		{ = move.w	#$E35,d0 \n _Pack8 }

FUNCTION AECallObjectAccessor(	desiredClass:		DescType ;
								containerToken:		AEDesc ;
								containerClass:		DescType ;
								keyForm:			DescType ;
								keyData:			AEDesc ;
								VAR theToken:		AEDesc): OSErr ;
INLINE $303C, $0C3B, $A816;		{ = move.w	#$E35,d0 \n _Pack8 }

{
Here are the interfaces your callback procs must be written to:

FUNCTION MyCompareProc( comparisonOperator: DescType; theObject: AEDesc; descOrObj:AEDesc;
		VAR result: BOOLEAN ): OSErr;
FUNCTION MyCountProc( desiredType: DescType; containerClass: DescType; theContainer: AEDesc;
		VAR result: LongInt ): OSErr;
FUNCTION MyGetMarkToken( containerToken: AEDesc; containerClass: DescType; VAR result: AEDesc ): OSErr;
FUNCTION MyMark( theToken: AEDesc; markToken: AEDesc; markCount: LONGINT ): OSErr;
FUNCTION MyAdjustMarks( newStart,newStop: LongInt; markToken: AEDesc ): OSErr;
FUNCTION MyDisposeToken( VAR unneededToken: AEDesc ) : OSErr ;
FUNCTION MyGetErrDescProc( VAR errDescPtr: DescPtr ) : OSErr ;

FUNCTION MyObjectAccessor( desiredClass: DescType; containerToken: AEDesc;
		containerClass: DescType; keyForm: DescType;
		keyData: AEDesc; VAR theToken: AEDesc; theRefcon: LongInt; ): OSErr;

You'll probably want to have a number of these last ones.
A proc that finds a line within a document should be installed with 'line' and 'docu'
as the desiredClass and containerClass fields in the call to AEInstallObjectHandler().
}

{$ENDC}    { UsingAEObjects }

{$IFC NOT UsingIncludes}
END.
{$ENDC}
