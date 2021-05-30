#
#	Macintosh Developer Technical Support
#
#	EditText Sample Control Panel Device
#
#	EditCdev
#
#	EditCdev.make	-	Make Source
#
#	Copyright © 1988, 1995 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	1.0					8/88
#
#	Components:	EditCdev.c			August 1, 1988
#				EditCdev.r			August 1, 1988
#				EditCdev.make		August 1, 1988
#
#	EditCdev is a sample Control Panel device (cdev) that 
#	demonstrates the usage of the edit-related messages.  
#	EditCdev demonstrates how to implement an editText item
#	in a Control Panel Device.  It utilizes the new undo, cut, copy,
#	paste, and delete messages that are sent to cdevs in
#	response to user menu selections.
#
#	It is comprised of two editText items that can be edited 
#	and moved between via the mouse or tab key.
#

SrcName			=	EditCdev
Lang			=	C
CdevName		=	{SrcName}
Destination		=	{SystemFolder}Control Panels:
COptions		=	-proto strict -w 17

Objs			=	{SrcName}.{Lang}.o ∂
					"{Libraries}"Interface.o

{CdevName}		ƒƒ	{Objs} {CdevName}.make
	Link -o {Targ} -rt cdev=-4064 -m TEXTCDEV {Objs} && ∂
		Setfile {CdevName} -a B && ∂
			Duplicate -y {CdevName} "{Destination}"

{CdevName}		ƒƒ	{SrcName}.r {CdevName}.make
	Rez -o {Targ} {SrcName}.r -t cdev -c hack -rd -append && ∂
		Setfile {CdevName} -a B && ∂
			Duplicate -y {CdevName} "{Destination}"
