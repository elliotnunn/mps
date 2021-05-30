/*
** Apple Macintosh Developer Technical Support
**
** Program:	     DTS.Lib
** File:	     AppleTalk.c
** Written by:   Pete Helme and Jim Luther
** Modified by:  Eric Soldan
**
** Copyright © 1989-1991 Apple Computer, Inc.
** All rights reserved.
*/

/* You may incorporate this sample code into your applications without
** restriction, though the sample code has been provided "AS IS" and the
** responsibility for its operation is 100% yours.  However, what you are
** not permitted to do is to redistribute the source as "DSC Sample Code"
** after having made changes. If you're going to re-distribute the source,
** we require that you make it clear in the source that the code was
** descended from Apple Sample Code, but that you've made changes. */



/*****************************************************************************/



#include "DTS.Lib2.h"
#include "DTS.Lib.protos.h"

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __LISTCONTROL__
#include "ListControl.h"
#endif

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif



#define		kATPTimeOutVal			3			/* re-try ATP SendRequest every 3 seconds */
#define		kATPRetryCount			5			/* for five times */
#define		kZonesSize				578			/* size of buffer for zone names */
#define		kGetMyZoneCall			0x07000000	/* GetMyZone indicator */
#define		kGetZoneListCall		0x08000000	/* GetZoneList indicator */
#define		kZIPSocket				6			/* the Zone Information Protocol socket */
#define		kMoreZones				0xFF000000 	/* mask to see if more zones to come */
#define		kZoneCount				0x0000FFFF 	/* mask to count zones in buffer */

#define		kTupleSize	104
#define		kMaxTuples	1



/*****************************************************************************/



#pragma segment myPPC
OSErr	ATInit(void)
{
	return(noErr);
}



/*****************************************************************************/



/* Create the list of zones on the network.  Find a bridge to talk to, if one is
** present, then ask it for zone names.  Add the names to the passed-in list. */

#pragma segment myPPC
OSErr	DoBuildZoneList(ListHandle listHndl)
{
	ATPParamBlock	atppb;
	char			zones[kZonesSize], *zptr, data[255];
	OSErr			err;

	BDSElement	dBDS;				/* the BDS for GetZoneList call */
	short		index, count, i;
	short		ignore;
	short		nodeNetAddress, bridgeNode;

	dBDS.buffSize = kZonesSize;									/* set up BDS */
	dBDS.buffPtr = zones;

	atppb.ATPatpFlags = 0;

	/* Get network address of node & node ID of bridge (if any). */

	err = GetNodeAddress(&ignore, &nodeNetAddress);
	if (err) return(err);

	if (!(bridgeNode = GetBridgeAddress())) return(noErr);
		/* We have added all zero zones to the ist, so we are done. */

	atppb.ATPaddrBlock.aNet = nodeNetAddress;
	atppb.ATPaddrBlock.aNode = bridgeNode;			/* Get node of bridge. */
	atppb.ATPaddrBlock.aSocket = kZIPSocket;		/* The socket we want. */
	atppb.ATPreqLength = 0;
	atppb.ATPreqPointer = nil;
	atppb.ATPbdsPointer = (Ptr) &dBDS;
	atppb.ATPnumOfBuffs = 1;
	atppb.ATPtimeOutVal = kATPTimeOutVal;
	atppb.ATPretryCount = kATPRetryCount;

	index = 1;
	count = 0;

	do {
		atppb.ATPuserData = kGetZoneListCall + index;	/* Indicate GetZoneList request. */
		err = PSendRequest(&atppb, false);				/* Send sync request. */
		if (err) return(err);

		count += dBDS.userBytes & kZoneCount;			/* find out how many returned */
		zptr = zones;									/* put current pointer at start */
		do {											/* get each zone */
			for (i = zptr[0]; i; --i)
				data[i - 1] = zptr[i];
			CLInsert(listHndl, data, zptr[0], -1, 0);
			zptr += (*zptr + 1 );						/* bump up current pointer*/
			++index;									/* increment which zone */
		} while(index <= count);

	} while ((dBDS.userBytes & kMoreZones) == 0);		/*	 keep going until none left */

	return(noErr);
}



/*****************************************************************************/



/* Select our zone in the zone list. */

#pragma segment myPPC
OSErr	OldStyleGetMyZone(StringPtr str);
OSErr	HiliteUserZone(ListHandle listHndl)
{
	Str32			zone;
	short			zoneLen, i;
	Point			cell;
	OSErr			err;

	if (!(err = OldStyleGetMyZone(zone))) {
		for (zoneLen = zone[i = 0]; i < zoneLen; ++i) zone[i] = zone[i + 1];
		cell.h = cell.v = 0;
		if (LSearch(zone, zoneLen, nil, &cell, listHndl)) {
			LSetSelect(true, cell, listHndl);
			LAutoScroll(listHndl);
		}
	}
	return(err);
}



/*****************************************************************************/



#pragma segment myPPC
OSErr	OldStyleGetMyZone(StringPtr str)
{
	ATPParamBlock	atppb;
	OSErr			err;

	BDSElement	dBDS;				/* the BDS for GetZoneList call */
	short		ignore;
	short		nodeNetAddress, bridgeNode;

	dBDS.buffSize = sizeof(Str32);
	dBDS.buffPtr  = (Ptr)str;

	atppb.ATPatpFlags = 0;

	/* Get network address of node & node ID of bridge (if any). */

	err = GetNodeAddress(&ignore, &nodeNetAddress);
	if (err) return(err);

	if (!(bridgeNode = GetBridgeAddress())) return(noErr);
		/* We have added all zero zones to the ist, so we are done. */

	atppb.ATPaddrBlock.aNet    = nodeNetAddress;
	atppb.ATPaddrBlock.aNode   = bridgeNode;			/* Get node of bridge. */
	atppb.ATPaddrBlock.aSocket = kZIPSocket;			/* The socket we want. */
	atppb.ATPreqLength  = 0;
	atppb.ATPreqPointer = nil;
	atppb.ATPbdsPointer = (Ptr) &dBDS;
	atppb.ATPnumOfBuffs = 1;
	atppb.ATPtimeOutVal = kATPTimeOutVal;
	atppb.ATPretryCount = kATPRetryCount;

	atppb.ATPuserData = kGetMyZoneCall;				/* Indicate GetMyZone request. */
	return(PSendRequest(&atppb, false));			/* Send sync request. */
}




/*****************************************************************************/



/* This routine finds the socket used by the PPC Toolbox (it's the one with
** type 'PPCToolBox') and gives it a NBP alias (it registers a new NBP name
** on that socket) with the type passed in newNBPType.  The NameTableEntry
** record passed to this routine must be allocated globally (or must be a
** locked block on the heap until RemoveNBPAlias is called).  The variable
** newEntity is filled in with the new entity name and is returned to the
** function's caller so it can be passed to the RemoveNBPAlias function
** (below).  You'll get an error if any call fails, if an entity of type
** 'PPCToolBox' is not found (usually because either Program Linking isn't
** enabled or AppleTalk is disabled), or if RegisterName fails because >100
** copies of your application are running on the one machine. */

#pragma segment myPPC
OSErr	AddPPCNBPAlias(NamesTableEntry *theNTE, Str32 newNBPType, EntityName *newEntity)
{
	OSErr			err;
	MPPParamBlock	pb;
	char			keepSelfFlag;
	short			keepResFile, origLen, num, len;

	EntityName		myEntityName;

	AddrBlock		myAddrBlock;
	char			myRetBuff[kTupleSize];
	Handle			machineNameHndl;
	Str32			machineName;

	pb.SETSELF.newSelfFlag = 1;
	err = PSetSelfSend(&pb, false);						/* Turn on self-send. */
	if (err) return(err);

	keepSelfFlag = pb.SETSELF.oldSelfFlag;				/* Keep old self-send flag. */

	keepResFile = CurResFile();
	UseResFile(0);
	machineNameHndl = GetResource('STR ', -16413);		/* Get machine name. */
	UseResFile(keepResFile);

	if (!machineNameHndl) {
		pb.SETSELF.newSelfFlag = keepSelfFlag;
		PSetSelfSend(&pb, false);
		return(ResError());
	}

	pcpy(machineName, (StringPtr)*machineNameHndl);		/* Keep a copy of the machine name.   */
	ReleaseResource(machineNameHndl);					/* Release the machine name resource. */

	NBPSetEntity((Ptr)&myEntityName, (Ptr)machineName, (Ptr)"\pPPCToolBox", (Ptr)"\p*");

	pb.NBPinterval    = 1;					/* We want to build the entity name using */
	pb.NBPcount       = 1;					/* the machine name and 'PPCToolBox'.     */
	pb.NBPentityPtr   = (Ptr)&myEntityName;
	pb.NBPretBuffPtr  = myRetBuff;
	pb.NBPretBuffSize = (kTupleSize * kMaxTuples);
	pb.NBPmaxToGet    = kMaxTuples;

	if (!(err = PLookupName(&pb, false))) {		/* If lookup was okay... */
		if (pb.NBPnumGotten) {					/* If entity was found... */
									/* ...we found the socket used by the PPC Toolbox. */
									/* This means that there is a socket, due to program */
									/* linking being turned on. */

			NBPExtract(myRetBuff, pb.NBPnumGotten, 1, &myEntityName, &myAddrBlock);
				/* Break the tuple into component parts. */

			for (origLen = machineName[num = 0]; num < 100;) {

				pb.NBPinterval   = 7;
				pb.NBPcount      = 5;
				pb.NBPentityPtr  = (Ptr)theNTE;
				pb.NBPverifyFlag = 1;

				NBPSetNTE((Ptr)theNTE, (Ptr)machineName, (Ptr)newNBPType, (Ptr)"\p*", myAddrBlock.aSocket);
				NBPSetEntity((Ptr)newEntity, (Ptr)machineName,(Ptr) newNBPType, (Ptr)"\p*");
				err = PRegisterName(&pb, false);

				if (err != nbpDuplicate) break;
					/* We registered the name, (or badness happened), so we are done. */

				len = 31;		/* The name we tried already exists, so make up an alternate. */
				if (++num > 9)
					--len;
				if (origLen > len)
					origLen = len;
				machineName[0] = origLen;
				pcatdec(machineName, num);
			}
		}
	}

	pb.SETSELF.newSelfFlag = keepSelfFlag;
	PSetSelfSend(&pb, false);

	return(err);
}




/*****************************************************************************/



/* This function removes the entity specified by theEntity from the registered
** names queue.  You'll get an error if theEntity hasn't been registered on
** this Macintosh with RegisterName. */

#pragma segment myPPC
OSErr	RemoveNBPAlias(EntityPtr theEntity)
{
	MPPParamBlock	pb;

	pb.MPPioCompletion = nil;
	pb.NBPentityPtr    = (Ptr)theEntity;
	return(PRemoveName(&pb, false));
}



