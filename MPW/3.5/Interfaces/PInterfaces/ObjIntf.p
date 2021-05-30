{
	File:		ObjIntf.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ObjIntf;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingObjIntf}
{$SETC UsingObjIntf := 1}


TYPE
	TObject = OBJECT
		FUNCTION  ShallowClone: TObject;
			{Lowest level method for copying an object; should not be overridden
				except in very unusual cases.  Simply calls HandToHand to copy
				the object data.}
		FUNCTION  Clone: TObject;
			{Defaults to calling ShallowClone; can be overridden to copy objects
				refered to by fields.}
		PROCEDURE ShallowFree;
			{Lowest level method for freeing an object; should not be overridden
				except in very unusual cases.  Simply calls DisposHandle to
				free the object data.}
		PROCEDURE Free;
			{Defaults to calling ShallowFree; can be overridden to free objects 
				refered to by fields.}
		END;


{$ENDC} { UsingObjIntf }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

