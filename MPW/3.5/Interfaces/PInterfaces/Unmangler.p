(*---------------------------------------------------------------------------*
 |                                                                           |
 |                            <<< Unmangler.p >>>                            |
 |                                                                           |
 |                         C++ Function Name Decoding                        |
 |                                                                           |
 |                 Copyright Apple Computer, Inc. 1988-1995                  |
 |                           All rights reserved.                            |
 |                                                                           |
 *---------------------------------------------------------------------------*)

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
UNIT Unmangler;
 INTERFACE
{$ENDC}
		
{$IFC UNDEFINED UsingUnmangler AND UNDEFINED __UNMANGLER__}
{$SETC UsingUnmangler := 1}
{$SETC __UNMANGLER__ := 1}
{$I+}
{$SETC UnmanglerIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED UsingTypes AND UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}

{$SETC UsingIncludes := UnmanglerIncludes}

		(*
		FUNCTION unmangle(dst: UNIV Ptr; src: UNIV Ptr; limit: LongInt): LongInt; C;
			{This function unmangles C++ mangled symbols (i.e. a symbol with a type signature).
			 The mangled C string is passed in “src” and the unmangled C string is returned in
			 “dst”.  Up to “limit” characters (not including terminating null) may be returned
			 in “dst”.
		 
			 The function returns,
		 
				 -1 ==> error, probably because symbol was not mangled, but looked like it was
					0 ==> symbol wasn't mangled; not copied either
					1 ==> symbol was mangled; unmangled result fit in buffer
					2 ==> symbol was mangled; unmangled result truncated to fit in buffer}
		*)
		
{$IFC UNDEFINED __CFM68K__}
	{$PUSH}
	{$LibExport+}
{$ENDC}
		FUNCTION Unmangle(dst: UNIV StringPtr; src: UNIV StringPtr; limit: LongInt): LongInt;
			{This function unmangles C++ mangled symbols (i.e. a symbol with a type signature).
			 The mangled Pascal string is passed in “src” and the unmangled Pascal string is
			 returned in “dst”.  Up to “limit” characters may be returned in “dst”.
			
			 The function returns,
			 
				 -1 ==> error, probably because symbol was not mangled, but looked like it was
					0 ==> symbol wasn't mangled; not copied either
					1 ==> symbol was mangled; unmangled result fit in buffer
					2 ==> symbol was mangled; unmangled result truncated to fit in buffer
					 
			 This function is identical to unmangle() above except that all the strings are
			 Pascal instead of C strings.
			}

{$IFC UNDEFINED __CFM68K__}
	{$POP}
{$ENDC}

{$ENDC} { UsingUnmangler }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
