/*
	File:		CodeFragmentTypes.r

	Contains:	Type Declarations for Rez and DeRez

	Copyright:	© 1986-1996 by Apple Computer, Inc.
				All Rights Reserved.

	Version:	System 7.5
	Created:	Friday, March 10, 1995
*/

#ifndef __CODEFRAGMENTTYPES_R__
#define __CODEFRAGMENTTYPES_R__


#if 0
    Copyright (c) Apple Computer Inc 1993-95
	
    The 'cfrg' resource serves to inform the Process Manager and Code Fragment Manager
	of code fragments present in this file.
	
	The 'cfrg' resource must have an ID of 0.  There can only be one 'cfrg' resource
	per file, however, the trailing part of a 'cfrg' resource is an array of entries.
	Each entry can be used to associate a name and type to a specified code fragment.
	The names are used when the system searches for code fragments as named shared 
	libraries.  There can be more than one cfrg array entry per code fragment, this is
	used to give a single code fragment more than one name.

    The 'cfrg' resource member format has been extended.

	The extended form is needed only when the code fragment will be searched for 
	using the new CFM/SOM search mechanisms.
	
	The shorter original form, called the regular form, is appropriate for 
	applications and most shared libraries.
	
	In order to support the regular form, along with the extended form, 
	a switch statement has been added to the 'cfrg' resource type definition.
	Uses of the old form need to be enclosed in the following switch syntax: 
			regular { <put original member entry here> }

	For example in the old syntax :
				resource 'cfrg' (0) {
					{
						kPowerPC, kFullLib, kNoVersionNum, kNoVersionNum,
						kDefaultStackSize, kNoAppSubFolder,
						kIsApp, kOnDiskFlat, kZeroOffset, kWholeFork,
						"My Application",
					}
				};
	becomes, in the new syntax:
				resource 'cfrg' (0) {
					{
						regularEntry {		/* <--- add this line */	
							kPowerPC, kFullLib, kNoVersionNum, kNoVersionNum,
							kDefaultStackSize, kNoAppSubFolder,
							kIsApp, kOnDiskFlat, kZeroOffset, kWholeFork,
							"My Application",
						}					/* <--- and this line */
					}
				};
	The compiled binary resource is identical.
	
	The extended form allows specification of an OSType and 4 Str255s that are 
	used as criterea in searching for libraries that satisfy some contstraints.
	For example, a SOM class library that is a particular sub-class of the 
	"ClassXYZ" base class, might be represented as :
				resource 'cfrg' (0) {
					{
						extendedEntry {
							kPowerPC, kFullLib, kNoVersionNum, kNoVersionNum,
							kDefaultStackSize, kNoAppSubFolder,
							kIsLib,kOnDiskFlat,kZeroOffset,kWholeFork,
							"MyLibName",	/* standard internal name: used by CFM */
							/* start of extended info */
							kFragSOMClassLibrary,
							"ClassXYZ",
							"",
							"",
							"My Name"		/* external name: may be seen by user */
						}
					}
				};
	Using the new CFM/SOM search functions, one could search for all som
	class libraries that inherit from "ClassXYZ".

	One cfrg resource can contain member entries of both regular and extended format.
		
    For Applications
	   The 'cfrg' is required to inform the Process Manager that there is a 
	   code fragment available.  One of the entries which has the architecture
	   type appropriate for the given machine (ie: pwpc, or m68k) should have the 
	   kIsApp usage designation.  The Process Manager will choose this code fragment 
	   over the traditional CODE 0.  The location of the code fragment (usually in 
	   the data fork) is described within the cfrg array entry.  
	   
	   For applications, the name is important only when an application has by name 
	   call backs, that is, exports for drop in extensions that import from the 
	   application.  Generally speaking, the name of the application is used for 
	   its 'cfrg' array entry.
	   
	For Shared Libraries
	   The 'cfrg' is required to allow the Code Fragment Manager to find shared 
	   libraries. 
	   
	   Shared Libraries are libraries that satisfy link time imports, that are 
	   usually placed in the extensions folder; they are automatically connected to 
	   by the Code Fragment Manager at application launch time.  Shared Libraries
	   must have the file type 'shlb'.  The usage field is set to kIsLib for shared 
	   libraries.

	Plug in extensions (code fragments packaged in various application specific ways)
	are that loaded programaticallly by the application do not require the file type 
	'shlb' and a cfrg resource, but may use some similar mechanism that is application
	specific / developer defined.

#endif


#ifdef UseExtendedCFRGTemplate

type 'cfrg' {
   longint = 0;            /* reserved - in use */
   longint = 0;            /* reserved - in use */
   longint = 1;            /* cfrgVersion       */
   longint = 0;            /* reserved - in use */
   longint = 0;            /* reserved - in use */
   longint = 0;            /* reserved - free   */
   longint = 0;            /* reserved - free   */
   longint = $$CountOf (memberArray);
   Array memberArray {
     memberStart:
      align long;
      switch{
      case regularEntry:
		  literal longint archType, kPowerPC = 'pwpc', kMotorola = 'm68k';
		  longint         updateLevel, kFullLib = 0, kUpdateLib = 1;
		  longint         currentVersion, kNoVersionNum = 0;
		  longint         oldDefVersion, kNoVersionNum = 0;
		  longint         appStackSize, kDefaultStackSize = 0;
		  integer         appSubFolderID, kNoAppSubFolder = 0;
		  byte            usage, kIsLib = 0, kIsApp = 1, kIsDropIn = 2;
		  byte            where, kInMem = 0, kOnDiskFlat = 1, kOnDiskSegmented = 2;
		  longint         offset, kZeroOffset = 0, kRSEG = 'rseg';
		  longint         length, kWholeFork = 0, kSegIDZero = 0;
		  longint         = 0;      /* reserved - free */
		  integer         = 0;      /* reserved - free */
	      key integer     = 0;      /* no cfrg extensions */
		  integer         = (memberEnd[$$ArrayIndex(memberArray)] - memberStart[$$ArrayIndex(memberArray)]) / 8;
		  pstring;        /* member name */
		  align long;     /* match size to C structure size */
      case extendedEntry:
		  literal longint archType, kPowerPC = 'pwpc', kMotorola = 'm68k';
		  longint         updateLevel, kFullLib = 0, kUpdateLib = 1;
		  longint         currentVersion, kNoVersionNum = 0;
		  longint         oldDefVersion, kNoVersionNum = 0;
		  longint         appStackSize, kDefaultStackSize = 0;
		  integer         appSubFolderID, kNoAppSubFolder = 0;
		  byte            usage, kIsLib = 0, kIsApp = 1, kIsDropIn = 2;
		  byte            where, kInMem = 0, kOnDiskFlat = 1, kOnDiskSegmented = 2;
		  longint         offset, kZeroOffset = 0, kRSEG = 'rseg';
		  longint         length, kWholeFork = 0, kSegIDZero = 0;
		  longint         = 0;      /* reserved - free */
		  integer         = 0;      /* reserved - free */
	      key integer     = 1;      /* one extension   */
		  integer         = (memberEnd[$$ArrayIndex(memberArray)] - memberStart[$$ArrayIndex(memberArray)]) / 8;
		  pstring;        /* member name */
		  align long;     /* match size to C structure size */
         extensionStart: 
		  integer	      = 0x30ee;   	/* magic # signifies this extended cfrg entry format */
 		  integer         = (extensionEnd[$$ArrayIndex(memberArray)] - extensionStart[$$ArrayIndex(memberArray)]) / 8;
		  literal longint libKind, 
						kFragDocumentPartHandler = 'part',
						kFragSOMClassLibrary = 'clas',
						kFragInterfaceDefinition = 'libr',
						kFragComponentMgrComponent = 'comp';
						/* others allowed, need to be a DTS registered OSType */
		  pstring;		  /* qualifier 1: 
								'part' : part handler type
								'clas' : base class name
								'libr' : interface definition name
								'comp' : component kind
						  */
		  pstring;	      /* qualifier 2:
								'part' : part handler sub type ?
								'clas' : not used
								'libr' : not used
								'comp' : component sub kind
						  */
		  pstring;		  /* infoStr, optional information depending on libKind */
		  pstring;		  /* intlName, an internationalizable string that can
							 be displayed to the user on the screen */
		  align long;
         extensionEnd:
	  };
     align long;
     memberEnd:
   };
};

#else

type 'cfrg' {
   longint = 0;            /* reserved - in use */
   longint = 0;            /* reserved - in use */
   longint = 1;            /* cfrgVersion       */
   longint = 0;            /* reserved - in use */
   longint = 0;            /* reserved - in use */
   longint = 0;            /* reserved - free   */
   longint = 0;            /* reserved - free   */
   longint = $$CountOf (memberArray);
   Array memberArray {
     memberStart:
      align long;
      literal longint archType, kPowerPC = 'pwpc', kMotorola = 'm68k';
	  longint         updateLevel, kFullLib = 0, kUpdateLib = 1;
	  longint         currentVersion, kNoVersionNum = 0;
	  longint         oldDefVersion, kNoVersionNum = 0;
	  longint         appStackSize, kDefaultStackSize = 0;
	  integer         appSubFolderID, kNoAppSubFolder = 0;
	  byte            usage, kIsLib = 0, kIsApp = 1, kIsDropIn = 2;
	  byte            where, kInMem = 0, kOnDiskFlat = 1, kOnDiskSegmented = 2;
	  longint         offset, kZeroOffset = 0, kRSEG = 'rseg';
	  longint         length, kWholeFork = 0, kSegIDZero = 0;
	  longint         = 0;      /* reserved - free   */
	  longint         = 0;      /* reserved - free   */
	  integer         = (memberEnd[$$ArrayIndex(memberArray)] - memberStart[$$ArrayIndex(memberArray)]) / 8;
	  pstring;        /* member name */
	  align long;     /* match size to C structure size */
     memberEnd:
   };
};

#endif
#endif __CODEFRAGMENTTYPES_R__

