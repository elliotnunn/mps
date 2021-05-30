{
	File:		Notification.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Notification;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingNotification}
{$SETC UsingNotification := 1}

{$I+}
{$SETC NotificationIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$IFC UNDEFINED UsingOSUtils}
{$I $$Shell(PInterfaces)OSUtils.p}
{$ENDC}
{$SETC UsingIncludes := NotificationIncludes}

CONST
nmType = 8;

TYPE
NMProcPtr = ProcPtr;

NMRecPtr = ^NMRec;
NMRec = RECORD
 qLink: QElemPtr;		{next queue entry}
 qType: INTEGER;		{queue type -- ORD(nmType) = 8}
 nmFlags: INTEGER;		{reserved}
 nmPrivate: LONGINT;	{reserved}
 nmReserved: INTEGER;	{reserved}
 nmMark: INTEGER;		{item to mark in Apple menu}
 nmIcon: Handle;		{handle to small icon}
 nmSound: Handle;		{handle to sound record}
 nmStr: StringPtr;		{string to appear in alert}
 nmResp: NMProcPtr;		{pointer to response routine}
 nmRefCon: LONGINT;		{for application use}
 END;


FUNCTION NMInstall(nmReqPtr: NMRecPtr): OSErr;
 INLINE $205F,$A05E,$3E80;
FUNCTION NMRemove(nmReqPtr: NMRecPtr): OSErr;
 INLINE $205F,$A05F,$3E80;


{$ENDC} { UsingNotification }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

