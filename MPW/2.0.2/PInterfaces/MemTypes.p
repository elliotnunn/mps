{
  File: MemTypes.p

 Copyright Apple Computer, Inc. 1984-1987
 All Rights Reserved
}

UNIT MemTypes;

  INTERFACE

	TYPE

	SignedByte = - 128..127; { any byte in memory }
	Byte = 0..255; { unsigned byte for fontmgr }
	Ptr = ^SignedByte; { blind pointer }
	Handle = ^Ptr; { pointer to a master pointer }
	ProcPtr = Ptr; { pointer to a procedure }
	Fixed = LONGINT; { fixed point arithmetic type }

	Str255 = String[255]; { maximum string size }
	StringPtr = ^Str255; { pointer to maximum string }
	StringHandle = ^StringPtr; { handle to maximum string }

END.
