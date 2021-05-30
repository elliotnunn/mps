#
#	Macintosh Developer Technical Support
#
#	EditText Sample Control Panel Device
#
#	EditCdev
#
#	PEditCdev.make	-	Make Source
#
#	Copyright © 1988 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	1.0					8/88
#
#	Components:	EditCdev.p			August 1, 1988
#				EditCdev.r			August 1, 1988
#				EditCdev.make		August 1, 1988
#
#
#	EditCdev demonstrates how to implement an editText item
#	in a Control Panel Device.  It utilizes the new undo, cut, copy,
#	paste, and delete messages that are sent to cdevs in
#	response to user menu selections.
#
#	It is comprised of two editText items that can be edited 
#	and moved between via the mouse or tab key.
#

SrcName			=	EditCdev
Lang			=	P
CdevName		=	{SrcName}

Objs			=	{SrcName}.{Lang}.o ∂
					"{Libraries}"Interface.o

{CdevName}		ƒƒ	{Objs} {CdevName}.make
		Link -o {Targ} -rt cdev=-4064 -m TEXTCDEV {Objs} && ∂
			Setfile {CdevName} -a B && ∂
				Duplicate -y {CdevName} "{SystemFolder}"

{CdevName}		ƒƒ	{SrcName}.r {CdevName}.make
		Rez -o {Targ} {SrcName}.r -t cdev -c hack -rd -append && ∂
			Setfile {CdevName} -a B && ∂
				Duplicate -y {CdevName} "{SystemFolder}"
