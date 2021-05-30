/* 
    Copyright (c) Apple Computer Inc 1993

    6   09/15/93        AWL     (&ELE) Define application stack & subfolder default values
    5   07/28/93        AWL     Define application stack & subfolder fields
    4   07/12/93        ELE     (&AWL) Deleted 'cfri'; expanded comments as per PM change.
   	2	06/09/93		ELE		(&AWL) broke longint into several smaller fields
   	1	01/28/93 		ELE 	Initial version.

    The 'cfrg' resource now replaces the 'cfri' resource.  It serves as both 
	the Native Application Enabler as well as the Shared Library Enabler.
	
	The 'cfrg' resource must be ID=0, but does not require sysheap or locked 
	(previous versions of the CFM required this, but it is now not recommended).

    Native Application Enabler -
	   The 'cfrg' is required to inform the Process Manager that there is a 
	   native 601 code fragment available for execution.  The location of the 
	   code fragment is described with the 'cfrg' resource.  Typically the native 
	   601 code fragment is located in the data fork starting at offset zero, 
	   and going until EOF (use kZeroOffset and kTheWholeFork, respectively).
	   The usage field is set to kIsApp for applications.
	   
	   The application's "name" is also supplied in the 'cfrg'.  The name is important 
	   only when an application has exports for drop in extensions with call backs,
	   however, it is recommended that the name be that of the application.
	   
	Shared Library Enabler -
	   The 'cfrg' is required to allow the Code Fragment Manager (called by the 
	   Process Manager as part of application launch) to find shared libraries.

	   Shared Libraries are libraries that satisfy link time imports, that are 
	   usually placed in the extensions folder; they are automatically connected to 
	   by the Code Fragment Manager at application launch time.  Shared Libraries
	   must have the file type 'shlb'.  The usage field is set to kIsLib for shared 
	   libraries.

	Plug in extensions (code fragments packaged in various application specific ways)
	are that loaded programaticallly by the application do not require the file type 
	'shlb' and a cfrg resource, but may need some similar mechanism that is 
	application specific.
 *****************************************/

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
      literal longint archType, kPowerPC = 'pwpc';
	  longint         updateLevel, kFullLib = 0, kUpdateLib = 1;
	  longint         currentVersion, kNoVersionNum = 0;
	  longint         oldDefVersion, kNoVersionNum = 0;
	  longint         appStackSize, kDefaultStackSize = 0;
	  integer         appSubFolderID, kNoAppSubFolder = 0;
	  byte            usage, kIsLib = 0, kIsApp = 1, kIsDropIn = 2;
	  byte            where, kInMem = 0, kOnDiskFlat = 1, kOnDiskSegmented = 2;
	  longint         offset, kZeroOffset = 0;
	  longint         length, kWholeFork = 0;
	  longint         = 0;      /* reserved - free   */
	  longint         = 0;      /* reserved - free   */
	  integer         = (memberEnd[$$ArrayIndex(memberArray)] - memberStart[$$ArrayIndex(memberArray)]) / 8;
	  pstring;        /* member name */
	  align long;     /* match size to C structure size */
     memberEnd:
   };
};
