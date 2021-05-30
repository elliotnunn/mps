/*
	File:		OTConfig.r

	Contains:	Rez file definitions for 'epcf' resource

	Copyright:	© 1992-1995 by Apple Computer, Inc., all rights reserved.

*/

#ifndef __OTCONFIG_R__
#define __OTCONFIG_R__

#include "Options.h"

type 'otdr'
{
	unsigned integer	/* version		*/	= 0x01;
	wide array DeviceInfo
	{
		unsigned longint;		/* 'Creator' of preference file or....	*/
		pstring;				/* Name of preference file				*/
		align word;
		pstring;				/* Device abbreviation, if appropriate	*/
		align word;
		pstring;				/* Device Name							*/
		align word;
	};
};

type 'epcf'
{
	unsigned integer	/* version		*/	= 0x01;
	unsigned integer;	/* protocolType	*/
	unsigned longint;	/* upperInterface	*/
	unsigned longint;	/* lowerInterface	*/
	unsigned longint;	/* flags			*/
	unsigned longint;	/* myXTILevel		*/
	unsigned integer = $$CountOf(OptionList);	/* Resource List		*/
	wide array OptionList
	{
		unsigned longint;		/* XTI Level of Options	*/
		unsigned longint;		/* XTI Name of Options	*/
		unsigned integer;		/* minOctets			*/
		unsigned integer;		/* maxOctets			*/
		unsigned integer;		/* optionType			*/
		pstring;				/* Option Name			*/
		align word;
	};
};

#define XTI_GENERIC		0xffff

#define XTI_DEBUG		0x0001
#define XTI_LINGER		0x0080
#define XTI_RCVBUF		0x1002
#define XTI_RCVLOWAT	0x1004
#define XTI_SNDBUF		0x1001
#define XTI_SNDLOWAT	0x1003

#define OPT_CHECKSUM	0x0600
#define OPT_RETRYCNT	0x0601
#define OPT_INTERVAL	0x0602
#define OPT_ENABLEEOM	0x0603
#define OPT_SELFSEND	0x0604
#define OPT_SERVERSTATUS 0x0605
#define OPT_KEEPALIVE	0x0008

#endif
