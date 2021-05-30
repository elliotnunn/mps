#
#	Macintosh Developer Technical Support
#
#	EditText Sample Control Panel Device
#
#	EditCdev
#
#	EditCdev.make	-	Make Source
#
#	Copyright © 1988 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	1.1					7/88
#				1.0					6/88
#
#	Components:	EditCdev.p			July 20, 1988
#				EditCdev.c			July 20, 1988
#				EditCdev.r			July 20, 1988
#				(P)EditCdev.make	July 20, 1988
#				(C)EditCdev.make	July 20, 1988
#
#	EditCdev demonstrates how to implement an editText item
#	in a Control Panel Device.  It utilizes the new undo, cut, copy,
#	paste, and delete messages that are sent to cdevs in
#	response to user menu selections.  How to handle private
#	storage is also covered.
#

SrcName			=	EditCdev
Lang			=	P
CdevName		=	{SrcName}

Objs			=	{SrcName}.{Lang}.o ∂
					"{Libraries}"Interface.o

{CdevName}			ƒ	{SrcName}.rsrc {Objs} {CdevName}.make
		Duplicate -y {SrcName}.rsrc {Targ}
		Link -o {Targ} -rt cdev=-4064 -m TEXTCDEV {Objs} && ∂
			Setfile {CdevName} -a B && ∂
				Duplicate -y {CdevName} "{SystemFolder}"

{SrcName}.rsrc		ƒ	{SrcName}.r {CdevName}.make
		Rez -o {Targ} {SrcName}.r -t cdev -c hack -rd
