/*
	LEGALESE:	© 1988-1993 Apple Computer, Inc.  All Rights Reserved
	
	PROJECT:	Installer 4.0
	
	PROGRAM:	Installer
	
	AUTHORS:	Bruce Jones, Cindy Frost, Bobby Carp, Kevin Aitken, Afshin Jalalian
	
	PURPOSE:	This file contains all the resource templates necessary to
				create installer scripts.

*/


#include "SysTypes.r"									/* For region codes */

/* For those using pre-7.0 "SysTypes.r" we need to define region.  It used */
/* to be country, but became region in 7.0 */

#ifndef region
#define region country
#endif


/*----------------------------Installer 3.0 Scripts-----------------------------------*/

#define evenPaddedString																						\
	pstring;																									\
	align word


#define OSType																									\
	literal longint
	
	
#define rsrcType																								\
	OSType												/* type of a rsrc which must exist in system */			\
		patchrsrcType = 'PTCH',																					\
		userFunctionType = 'infn',																				\
		auditrsrcType = 'audt'


#define rsrcID																									\
	integer												/* ID of a rsrc which must exist in system */			\
		macPlusPatch = 117,																						\
		macSEPatch = 630,																						\
		macIIPatch = 376,																						\
		portablePatch = 890,																					\
		macIIciPatch = 1660,																					\
		oldAuroraPatch = 1657

#define SrcDiskType																									\
	integer												/* Expected type of src source disk */					\
		kExpectFloppyDisk 	= 0,																				\
		kExpectCDVolume 	= 1,																				\
		kExpectFoldersOnVol = 2


#define RsrcName																								\
	evenPaddedString

/*
§ --------------------------------- Packages ---------------------------------*/
#define	packageFlags 																							\
		boolean		doesntShowOnCustom, showsOnCustom;		/* should show up on Custom screen	 */				\
		boolean		notRemovable, removable;				/* this package can be removed	 */					\
		boolean		forceRestart, dontForceRestart;			/* should installing this package for a restart? */	\
		fill bit[13]										/* Reserved */ 

#define	partSpec																								\
		rsrcType;											/* Part Type: inpk, infa, inra… */ 				\
		rsrcID												/* Part ID */


type 'inpk' {
		switch {
			case format0:
				key integer = 0;							/* Package Format version */
				packageFlags;								/* Package Flags */
				rsrcID;										/* icmt ID */
				unsigned longint;							/* Package Size */
				evenPaddedString;							/* Package Name */
				unsigned integer = $$CountOf(partsList);	/* Parts List */
				wide array partsList {
					partSpec;								/* Parts Spec */
				};
	
		};
};


type 'icmt' {												/* Installer comment */
		unsigned hex longint;								/* Creation Date  */
		unsigned hex longint;								/* Version */
		rsrcID;												/* Icon ID */
		evenPaddedString;									/* Comment Text */
};


type 'inpc' {												/* New Custom Item comment */
		switch {
			case format1:
				key integer = 1;							/* Custom Item Format version */
				unsigned hex longint;						/* Custom Item Date  */
				unsigned hex longint;						/* Custom Item Version */
				unsigned longint;							/* Custom Item RAM Requirements */
				rsrcID;										/* Custom Item Icon ID */
				rsrcID;										/* Custom Item Description ('TEXT' resource ID ) */
		};
};


/*
§ --------------------------------- File Specs ---------------------------------*/
#define fileSpecID																								\
		rsrcID


#define	fileSpecFlags																							\
		boolean		noSearchForFile, SearchForFile;			/* Search (tgt only) if not found in given path*/	\
		boolean		TypeCrNeedNotMatch, TypeCrMustMatch;	/* Type and creator must match	*/					\
		fill bit[14]										/* currently unused	*/

type	'infs' {														
		OSType;												/* File Type	*/
		OSType;												/* File Creator	*/
		unsigned hex longint;								/* Creation Date*/ 
		fileSpecFlags;										/* File Spec Flags */
		evenPaddedString;									/* Full Path */
};

/*
§ --------------------------------- Target File Spec ---------------------------------*/
#define	targetFileSpecFlags																							\
		boolean		noSearchForFile, SearchForFile;			/* Search by calling the referenced 'insp' resource */	\
		boolean		TypeCrNeedNotMatch, TypeCrMustMatch;	/* Type and creator must match	*/					\
		fill bit[14]										/* currently unused	*/

type 'intf' {														
	switch {
		case format0:
			key integer = 0;			/* Target File Spec. Format version */
			fileSpecFlags;				/* Target File Spec. Flags */
			OSType;						/* Target File Type */
			OSType;						/* Target File Creator */
			rsrcID;						/* Search Proc. Rsrc ID */ 
			evenPaddedString;			/* Target File Path */
	};
};

/*
§ --------------------------------- File Atoms ---------------------------------*/
#define	opcodeFlags 																							\
		boolean		dontDeleteWhenRemoving, deleteWhenRemoving;			/* Remove file or rsrc if remove clicked */	\
		boolean		dontDeleteWhenInstalling, deleteWhenInstalling;		/* Delete target before copy	*/			\
		boolean		dontCopy, copy;							/* Copy file or rsrc to destination */				\
		fill bit[3]											/* Reserved */


#define	fileAtomFlags																							\
		opcodeFlags;																							\
		fill bit[5]; 																							\
		boolean		updateEvenIfNewer, leaveAloneIfNewer; 	/* OK for a newer version of this file to exist */	\
		boolean		updateExisting, keepExisting;			/* Keep tgt file if it already exists */			\
		boolean		copyIfNewOrUpdate, copyIfUpdate;		/* Only update if target exists	*/					\
		boolean		noRsrcFork, rsrcFork;					/* Apply operation to rsrc fork */					\
		boolean		noDataFork, dataFork					/* Apply operation to data fork	*/

#define	fileAtom1Flags																							\
		opcodeFlags;																							\
		boolean		dontIgnoreLockedFile, ignoreLockedFile;	/* Do it even if file is locked */					\
		boolean		dontSetFileLocked, setFileLocked; 		/* Set the Target file to be locked or not. */		\
		boolean		useSrcCrDateToCompare, useVersProcToCompare; 	/* How we determine if the target is newer. */	\
		boolean		srcNeedExist, srcNeedNotExist; 			/* Ignore atom if file does not exist */			\
		boolean		rsrcForkInRsrcFork, rsrcForkInDataFork; /* Determines where to read the rsrc fork from */	\
		boolean		updateEvenIfNewer, leaveAloneIfNewer; 	/* OK for a newer version of this file to exist */	\
		boolean		updateExisting, keepExisting;			/* Keep tgt file if it already exists */			\
		boolean		copyIfNewOrUpdate, copyIfUpdate;		/* Only update if target exists	*/					\
		boolean		noRsrcFork, rsrcFork;					/* Apply operation to rsrc fork */					\
		boolean		noDataFork, dataFork					/* Apply operation to data fork	*/

type 'infa' {
		switch {
			case format0:
				key integer = 0;							/* File Atom Format version */
				fileAtomFlags;								/* File Atom Flags		  */
				rsrcID;										/* tgt file spec ID */
				rsrcID;										/* src file spec ID */
				unsigned longInt;							/* File Size */
				evenPaddedString;							/* Atom Description     */
				
			case format1:
				key integer = 1;							/* File Atom version */
				fileAtom1Flags;								/* File Atom Flags */
				unsigned longInt;							/* File Size */
				unsigned integer;							/* Finder Attribute Flags */
				fileSpecID;									/* Tgt file spec ID */
				integer = $$CountOf (Pieces);				/* Number of Source Pieces */
				wide array Pieces {
					fileSpecID;								/* Source File Spec*/
					unsigned longInt;						/* Target Data Fork Part Size */
					unsigned longInt;						/* Target Rsrc Fork Part Size */
				};
				unsigned hex longint;						/* Source Version Number in BCD format. */
				rsrcID;										/* Version Compare rsrc ID (zero if none) */
				rsrcID;										/* Atom Extender ID */
				evenPaddedString;							/* Atom Description */
		};
};

/*
§ -------------------------------- Resource Atoms ---------------------------------*/
#define	resourceAtomFlags																						\
		opcodeFlags;																							\
		fill bit[3];										/* Reserved	*/										\
		boolean		noTgtRequired, tgtRequired;				/* target req or can be created by another inra */	\
		boolean		updateExisting, keepExisting;			/* Keep tgt rsrc if it already exists */			\
		boolean		copyIfNewOrUpdate, copyIfUpdate;		/* Only update if target exists	*/					\
		boolean		dontIgnoreProtection, ignoreProtection;	/* Do it even if rsrc protected */					\
		boolean		srcNeedExist, srcNeedNotExist;			/* Rsrc need not exist on source */					\
		boolean		byName, byID;							/* Use name or id to find rsrc	*/					\
		boolean		nameNeedNotMatch, nameMustMatch			/* name must match*/

#define	resourceAtomFlagsFormat1																						\
		opcodeFlags;																							\
		fill bit[2];										/* Reserved	*/										\
		boolean		updateEvenIfNewer, leaveAloneIfNewer; 	/* OK for a newer version of this rsrsc to exist */	\
		boolean		noTgtRequired, tgtRequired;				/* target req or can be created by another inra */	\
		boolean		updateExisting, keepExisting;			/* Keep tgt rsrc if it already exists */			\
		boolean		copyIfNewOrUpdate, copyIfUpdate;		/* Only update if target exists	*/					\
		boolean		dontIgnoreProtection, ignoreProtection;	/* Do it even if rsrc protected */					\
		boolean		srcNeedExist, srcNeedNotExist;			/* Rsrc need not exist on source */					\
		boolean		byName, byID;							/* Use name or id to find rsrc	*/					\
		boolean		nameNeedNotMatch, nameMustMatch			/* name must match*/

type 'inra' {
		switch {
			case format0:
				key integer = 0;							/* Resource Atom Format version */
				resourceAtomFlags;							/* Resource Atom Flags */
				rsrcID;										/* tgt file spec ID */
				rsrcID;										/* src file spec ID */
				rsrcType;									/* Resource Type */
				rsrcID;										/* Source ID */
				rsrcID;										/* Target ID */
				unsigned longInt;							/* Resource Size */
				evenPaddedString;							/* Atom Description */
				evenPaddedString;							/* Resource Name */

			case format1:
				key integer = 1;				/* Resource Atom Format version */
				resourceAtomFlagsFormat1;		/* Resource Atom Flags */
				unsigned longInt;				/* Total Target Size (including owned rsrcs)	*/

				fileSpecID;						/* Target Resource File Spec */
				rsrcType;						/* Target Resource Type */
				rsrcID;							/* Target Resource ID */
				unsigned integer;				/* Target Resource Attributes */
				evenPaddedString;				/* Target Resource Name */

				integer = $$CountOf (Parts);	/* Number of Parts */
				wide array Parts {
					fileSpecID;						/* Source Part File Spec */
					rsrcType;						/* Source Part Type	*/
					rsrcID;							/* Source Part Rsrc ID */
					unsigned longInt;				/* Target Part Size	*/
					evenPaddedString;				/* Source Part Resource Name */				
				};
				unsigned hex longint;			/* Source Version Number in BCD format. */
				rsrcID;							/* Version Compare rsrc ID (zero if none) */
				rsrcID;							/* Atom Extender ID */
				evenPaddedString;				/* Atom Description */
		};
};


type 'inr#' {
		switch {
			case format0:
				key integer = 0;				/* Resource Atom Format version */

				integer = $$CountOf (inraRsrcs);	/* Number of inraRsrcs */
				wide array inraRsrcs {
					integer;						/* resource ID ( type to be decided)	*/
					resourceAtomFlagsFormat1;		/* Resource Atom Flags */
					unsigned longInt;				/* Total Target Size (including owned rsrcs)	*/

					fileSpecID;						/* Target Resource File Spec */
					fileSpecID;						/* Source File Spec */
					rsrcType;						/* Source/Target Resource Type */
					rsrcID;							/* Source/Target Resource ID */
					unsigned integer;				/* Target Resource Attributes */

					unsigned hex longint;			/* Source Version Number in BCD format. */
					rsrcID;							/* Version Compare rsrc ID (zero if none) */
					rsrcID;							/* Atom Extender ID */
					unsigned longInt;				/* Target Size of Rsrc */
				};
		};
};



/*
§ --------------------------------- ResMerge Atoms ---------------------------------*/

#define	resMergeAtomFlags																						\
		fill bit[16];

type 'inrm' {
		switch {
			case format0:
				key integer = 0;							/* ResMerge Atom Format version */
				resMergeAtomFlags;							/* ResMerge Atom Flags		  */
				unsigned longInt;							/* Size of all resources   */
				rsrcID;										/* tgt file spec ID */
				rsrcID;										/* src file spec ID */
				evenPaddedString;							/* Atom Description     */
		};
};

/*
§ --------------------------------- Folder Atoms ---------------------------------*/

#define	folderAtomFlags																						\
		fill bit[16];

type 'infm' {
		switch {
			case format0:
				key integer = 0;							/* Folder Atom Format version */
				folderAtomFlags;							/* Folder Atom Flags		  */
				unsigned longInt;							/* Size of all files in source folder */
				rsrcID;										/* tgt file spec ID */
				rsrcID;										/* src file spec ID */
				evenPaddedString;							/* Atom Description     */
		};
};

/*
§ --------------------------------- Boot Block Atoms ---------------------------------*/
#define	bootBlockAtomFlags																						\
		fill bit[14];																							\
		boolean		dontChangeOnInstall, changeOnInstall;	/* change parameter if we're installing */			\
		boolean		dontChangeOnRemove, changeOnRemove		/* change parameter if we're removing */ 

#define	BootBlockUpdateFlags																					\
		fill bit[7];																							\
		boolean		replaceBBSysName, 																			\
					saveBBSysName; 																				\
		boolean		replaceBBShellName, 																		\
					saveBBShellName;																			\
		boolean		replaceBBDbg1Name, 																			\
					saveBBDbg1Name; 																			\
		boolean		replaceBBDbg2Name, 																			\
					saveBBDbg2Name; 																			\
		boolean		replaceBBScreenName, 																		\
					saveBBScreenName; 																			\
		boolean		replaceBBHelloName, 																		\
					saveBBHelloName; 																			\
		boolean		replaceBBScrapName,																			\
					saveBBScrapName; 																			\
		boolean		replaceBBCntFCBs, 																			\
					maxBBCntFCBs; 																				\
		boolean		replaceBBCntEvts, 																			\
					maxBBCntEvts


type 'inbb' {
		switch {
			case format0:
				key integer = 0;							/* Boot Block Format version */
				bootBlockAtomFlags;							/* Boot Block Atom Flags	  */
						
						/* now case off the type for the boot block value */
				switch {
					case bbUpdate:
						key integer = -1;
						rsrcID;								/* The file spec ID for the source of the 'boot' resource */
						bootBlockUpdateFlags;
						
					case bbID:
						key integer = 1;
						decimal integer;
					
					case bbEntry:
						key integer = 2;
						decimal longint;
						
					case bbVersion:
						key integer = 3;
						decimal integer;
						
					case bbPageFlags:
						key integer = 4;
						decimal integer;
						
					case bbSysName:
						key integer = 5;
						evenPaddedString;
						
					case bbShellName:
						key integer = 6;
						evenPaddedString;
						
					case bbDbg1Name:
						key integer = 7;
						evenPaddedString;
						
					case bbDbg2Name:
						key integer = 8;
						evenPaddedString;
						
					case bbScreenName:
						key integer = 9;
						evenPaddedString;
						
					case bbHelloName:
						key integer = 10;
						evenPaddedString;
						
					case bbScrapName:
						key integer = 11;
						evenPaddedString;
						
					case bbCntFCBs:
						key integer = 12;
						decimal integer;
						
					case bbCntEvts:
						key integer = 13;
						decimal integer;
						
					case bb128KSHeap:
						key integer = 14;
						decimal longint;
						
					case bb256KSHeap:
						key integer = 15;
						decimal longint;
						
					case bb512KSHeap:
						key integer = 16;
						decimal longint;
						
					case bbSysHeapSize:						/* Note - same as 512 */
						key integer = 16;
						decimal longint;
						
					case bbSysHeapExtra:
						key integer = 18;
						decimal longint;
						
					case bbSysHeapFract:
						key integer = 19;
						decimal longint;
				};
				evenPaddedString;								/* Boot Block Atom Description */
		};
};


/*
§ --------------------------------- Action Atoms ---------------------------------*/

#define	whenToActAAFlags																					\
		boolean		actAfter,				/* Call this proc after all installations */					\
					actBefore;				/* Call this proc before all installations */					\
		boolean		dontActOnRemove, 																		\
					actOnRemove;			/* Call this proc when doing a remove */						\
		boolean		dontActOnInstall, 																		\
					actOnInstall			/* Call this proc when doing an Install */


#define	actionAtomFlagsFormat0																				\
		fill bit[13];																						\
		whenToActAAFlags

#define	actionAtomFlagsFormat1																				\
		fill bit[12]; 																						\
		boolean		continueBusyCursors,	/* Allow Installer busy cursor during call (3.3+ Only) */		\
					suspendBusyCursors;		/* Stop Installer busy cursor before call (3.3+ Only) */		\
		whenToActAAFlags
		
#define	actionAtomFlagsFormat2																				\
		fill bit[12]; 																						\
		boolean		continueBusyCursors,	/* Allow Installer busy cursor during call (3.3+ Only) */		\
					suspendBusyCursors;		/* Stop Installer busy cursor before call (3.3+ Only) */		\
		whenToActAAFlags

type 'inaa' {
		switch {
			case format0:
				key integer = 0;			/* Action Atom Format version */
				actionAtomFlagsFormat0;		/* Action Atom Flags for Format 0 */
				partSpec;					/* Resource type & id for executable resource */
				longint;					/* RefCon that's passed to the executable resource */
				evenPaddedString;			/* Atom Description */
				
			case format1:
				key integer = 1;			/* Action Atom Format version.  Use with Installer 3.3 and newer */
				actionAtomFlagsFormat1;		/* Action Atom Flags for Format 1 */
				partSpec;					/* Resource type & id for executable resource */
				longint;					/* RefCon that's passed to the executable resource */
				evenPaddedString;			/* Atom Description */
			
			case format2:
				key integer = 2;			/* Action Atom Format version.  Use with Installer 4.0 and newer.*/
				actionAtomFlagsFormat2;		/* Action Atom Flags for Format 2 */
				partSpec;					/* Resource type & id for executable resource.  NOTE:  code rsrc has C calling interface. */
				longint;					/* RefCon that's passed to the executable resource */
				unsigned longint;			/* Requested Memory in bytes */
				evenPaddedString;			/* Atom Description */
		};
};



/*
§ --------------------------------- Audit Trail Atoms ---------------------------------*/
type 'inat' {
		switch {
			case format0:
				key integer = 0;							/* Version */
				fileSpecID;									/* Target File Spec */
				OSType;										/* Selector */
				literal longint;							/* Value */
			};
};

/*
§ ----------------------------------- Atom Extenders -----------------------------------*/
#define	atomExtenderFlags										\
		boolean		dontSendInitMessage, sendInitMessage;		\
		boolean		dontSendBeforeMessage, sendBeforeMessage;	\
		boolean		dontSendAfterMessage, sendAfterMessage;		\
		boolean		dontSendSuccessMessage, sendSuccessMessage;	\
		boolean		dontSendCancelMessage, sendCancelMessage;	\
		boolean		continueBusyCursors, suspendBusyCursors;	\
		fill bit[10];

type 'inex' {
		switch {
			case format0:
				key integer = 0;		/* Extender Format version */
				atomExtenderFlags;		/* Flags for Format 0 */
				partSpec;				/* Type & id of code resource */
				longint;				/* Refcon for parameter block */
				unsigned longint;		/* Requested Memory in bytes */
				evenPaddedString;		/* Status Description  */	
		};
};


/*
§ --------------------------------- Installer Rules ---------------------------------*/

#define Version																									\
	hex byte;												/* System file Major revision in BCD*/				\
	hex byte;												/* System file Minor revision in BCD*/				\
	hex byte	development = 0x20,							/* System file Release stage		*/				\
				alpha = 0x40, beta = 0x60,																		\
				final = 0x80, release = 0x80;																	\
	hex byte												/* Non Final */
	
	
/* Note that if the minimal & maximal target disk sizes are both 0, any volume will match */
/* If the Minimal is > 0 and the maximal = 0, then only the minimum requirement is used */
#define TargetVolReqs										/* Required Target Volume Description */			\
	decimal longint											/* Minimal Target Disk Size */						\
		floppy = 0,																								\
		hdFloppy = 1400,																						\
		hardDisk = 10000;																						\
	decimal longint											/* Maximal Target Disk Size */						\
		floppy = 900,																							\
		hdFloppy = 1500,																						\
		hardDisk = 0
	
	
#define IntegerList																								\
	unsigned integer = $$CountOf(IntegerArray);																	\
	array IntegerArray {																						\
		integer;																								\
	}


#define LongIntList																								\
	unsigned integer = $$CountOf(LongIntArray);																	\
	array LongIntArray {																						\
		longint;																								\
	}


#define packageList																								\
	IntegerList


#define assertionList																							\
	IntegerList
	
	
#define gestaltList																								\
	LongIntList


#define	alwaysFalseKey							-2
#define	alwaysTrueKey							-1
#define	checkGestaltKey							1
#define checkMinMemoryKey						2
#define	checkFileDataForkExistsKey				3
#define	checkFileRsrcForkExistsKey				4
#define	checkFileContainsRsrcByIDKey			5
#define	checkFileContainsRsrcByNameKey			6
#define	checkFileVersionKey						7
#define	checkFileCountryCodeKey					8
#define	checkTgtVolSizeKey						9
#define	checkUserFunctionKey					10
#define	checkAllAssertionsKey					11
#define	checkAnyAssertionKey					12
#define checkMoreThanOneAssertionKey			13
#define	addUserDescriptionKey					14
#define	addPackagesKey							15
#define	addAssertionKey							16
#define reportVolErrorKey						17
#define reportSysErrorKey						18
#define addAuditRecKey							19
#define checkAuditRecKey						20
#define checkAnyAuditRecKey						21
#define addCustomItemsKey 						22
#define checkAllNonAssertionsKey				23
#define checkAnyNonAssertionKey					24
#define clearAssertionsKey						25
#define checkRuleFunctionKey					26
#define checkGestaltAttributesKey				27



/* The Easy Install Rules */
type 'inrl' {
	switch {
		case format0:
			key integer = 0;
			hex integer = 0;											/* Rule Flags for future use */
			unsigned integer = $$CountOf(Rules);
			wide array Rules {
				switch {
					case alwaysFalse:
						key integer = alwaysFalseKey;
						
					case alwaysTrue:
						key integer = alwaysTrueKey;
						
					case checkGestalt:
						key integer = checkGestaltKey;
						OSType;											/* Gestalt selector */
						gestaltList;									/* Legal results */
					
					case checkMinMemory:
						key integer = checkMinMemoryKey;
						decimal longint;

					case checkFileDataForkExists:
						key integer = checkFileDataForkExistsKey;
						fileSpecID;
						
					case checkFileRsrcForkExists:
						key integer = checkFileRsrcForkExistsKey;
						fileSpecID;
						
					case checkFileContainsRsrcByID:
						key integer = checkFileContainsRsrcByIDKey;
						fileSpecID;
						rsrcType;
						rsrcID;
						
					case checkFileContainsRsrcByName:
						key integer = checkFileContainsRsrcByNameKey;
						fileSpecID;
						rsrcType;
						rsrcName;
						
					case checkFileVersion:
						key integer = checkFileVersionKey;
						fileSpecID;
						version;
						
					case checkFileCountryCode:
						key integer = checkFileCountryCodeKey;
						fileSpecID;
						integer Region;
						
					case checkTgtVolSize:
						key integer = checkTgtVolSizeKey;
						targetVolReqs;
						                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             						
					case checkUserFunction:
						key integer = checkUserFunctionKey;
						rsrcType;
						rsrcID;
						longint;					/* RefCon that's passed to the executable resource */
						
					case checkAllAssertions:
						key integer = checkAllAssertionsKey;
						assertionList;
						
					case checkAnyAssertion:
						key integer = checkAnyAssertionKey;
						assertionList;
						
					case checkMoreThanOneAssertion:
						key integer = checkMoreThanOneAssertionKey;
						assertionList;
						
					case addUserDescription:
						key integer = addUserDescriptionKey;
						evenPaddedString;
						
					case addPackages:
						key integer = addPackagesKey;
						packageList;
						
					case addAssertion:
						key integer = addAssertionKey;
						assertionList;
						
					case reportVolError:
						key integer = reportVolErrorKey;
						evenPaddedString;
						
					case reportSysError:
						key integer = reportSysErrorKey;
						evenPaddedString;
						
					case addAuditRec:
						key integer = addAuditRecKey;
						fileSpecID;
						OSType;
						literal longint;
						
					case checkAuditRec:
						key integer = checkAuditRecKey;
						fileSpecID;
						OSType;
						literal longint;
						
					case checkAnyAuditRec:
						key integer = checkAnyAuditRecKey;
						fileSpecID;
						OSType;
						longIntList;
						
					case addCustomItems:
						key integer = addCustomItemsKey;
						packageList;
						
					case checkAllNonAssertions:
						key integer = checkAllNonAssertionsKey;
						assertionList;
						
					case checkAnyNonAssertion:
						key integer = checkAnyNonAssertionKey;
						assertionList;
						
					case clearAssertions:
						key integer = clearAssertionsKey;
						assertionList;
						
					case checkRuleFunction:
						key integer = checkRuleFunctionKey;
						rsrcID;
					
					case checkGestaltAttributes:
						key integer = checkGestaltAttributesKey;
						OSType;											/* Gestalt selector */
						literal longint;								/* Bit Mask */
						
			};
		};
	};
};


#define RuleList IntegerList
	
#define kEasyInstallFrameworkRsrcID 	764
#define kCustomInstallFrameworkRsrcID 	766
#define kGlobalFrameworkRsrcID 			765
	
/* The rule framework */
type 'infr' {
	switch {
		case format0:
			key integer = 0;								/* Rule framework version */
			unsigned integer = $$CountOf(RuleArray);
			wide array RuleArray {
				boolean pickFirst, pickAll;					/* which packages to select? */						
				fill bit[15];
				ruleList;									/* List of rules */									
			};
	};
};


/* The list of disks we may need, and the order we want them to appear in */
/* This is optional. */
type 'indo' {
	switch {
		case format0:
			key integer = 0;								/* indo version */
			integer = $$Countof(StringArray);
			array StringArray {
					evenPaddedString;
			};
			
		case format1:
			key integer = 1;								/* indo version */
			integer = $$Countof(SrcVolArray);
			array SrcVolArray {
					SrcDiskType;
					evenPaddedString;
			};
	};
};


/* This script resource defines the minimum Installer version that is required */
/* to run the script.  If an Installer app is launched that is older than this */
/* required version, the user receives a dialog telling him/her to run a newer Installer */
/* This is optional. */
type 'invs' {
	switch {
		case format0:
			key integer = 0;
			hex byte;												/* Major revision in BCD*/
			hex byte;												/* Minor vevision in BCD*/
			hex byte	development = 0x20,							/* Release stage		*/
						alpha = 0x40,
						beta = 0x60,
						final = 0x80, /* or */ release = 0x80;
			hex byte;												/* Non-final release #	*/
			pstring;												/* Short version number	*/
	};
};



/*
§ -------------------------------- Font Atom & Split Atom Stuff ---------------------------------*/

#define	Style																					\
	fill bit[9];										/* Reserved */							\
	Boolean		noExtendedStyle, extendedStyle;			/* Exteneded style */					\
	Boolean		noCondensedStyle, condensedStyle;		/* Condensed style */					\
	Boolean		noShadowStyle, 	shadowStyle;			/* Shadow style */						\
	Boolean		noOutlineStyle, outlineStyle;			/* Outline style */						\
	Boolean		noUnderlineStyle, underlineStyle;		/* Underline style */					\
	Boolean		noItalicStyle, italicStyle;				/* Italic style */						\
	Boolean		noBoldStyle, boldStyle;					/* Bold style */

#define	RsrcSpec																				\
		fileSpecID;										/* File spec for this resource */		\
		rsrcType;										/* Type of the resource	*/				\
		rsrcID;											/* ID of the resource */				\
		unsigned longInt;								/* Size in bytes of this resource	*/	\
		evenPaddedString								/* Name of the resource */				

#define	SrcPartsList									/* The list of pieces */				\
		integer = $$CountOf (Parts);					/* How many of them? */					\
		wide array Parts {																		\
			RsrcSpec;									/* Description of this piece */			\
		}

#define resSysHeap		64								/* Defines for resource attributes */
#define resPurgeable	32
#define resLocked		16
#define resProtected	8
#define resPreload		4
#define resChanged		2

#define Strike																					\
	integer;											/* Font size */							\
	Style;												/* Which styles? */						\
	RsrcType;											/* Target Font Resource Type */			\
	integer;											/* Target Attributes */					\
	SrcPartsList;										/* All of the pieces */
	
type 'inff' {
	switch {
		case format0:
			key integer = 0;							/*format version 0 */
			resourceAtomFlags;							/* flags */
			fileSpecID;									/* Target File Spec */
			fileSpecID;									/* Source File Spec of the FOND and all pieces, unless overriden by a split definition */
			unsigned integer;							/* Target FOND Attributes */
			unsigned longInt;							/* size in bytes of the complete family set */
			rsrcID;										/* source FOND's resource ID */
			switch {
			case entireFamily:
			 	key integer = 1;
			case explicitFamilyMembers:
				key integer = 2;
				unsigned integer = $$CountOf(StrikeEntries);
				wide array StrikeEntries {
					Strike;								/* Source for each of the points */
				};
			};
			evenPaddedString;							/* Atom Description */
			evenPaddedString;							/* the exact family name */
			
		case format1:
			key integer = 1;							/*format version 1 */
			resourceAtomFlags;							/* flags */
			fileSpecID;									/* Target File Spec */
			fileSpecID;									/* Source File Spec of the FOND and all pieces, unless overriden by a split definition */
			unsigned integer;							/* Target FOND Attributes */
			unsigned longInt;							/* size in bytes of the complete family set */
			rsrcID;										/* source FOND's resource ID */
			switch {
			case entireFamily:
			 	key integer = 1;
			case explicitFamilyMembers:
				key integer = 2;
				unsigned integer = $$CountOf(StrikeEntries);
				wide array StrikeEntries {
					Strike;								/* Source for each of the points */
				};
			};
			rsrcID;										/* Atom Extender ID */
			evenPaddedString;							/* Atom Description */
			evenPaddedString;							/* the exact family name */
	};
};


/*
§ ----------------------------------- Preference Resource -----------------------------------*/
#define	preferenceFlags														\
		boolean		useDiskTargetMode, useFolderTargetMode;					\
		boolean		dontAllowUserToSetSystemDisk, allowUserToSetSystemDisk;	\
		boolean		dontShowSelectedSizeInCustom, showSelectedSizeInCustom;	\
		boolean		noSetupFunctionSupplied, setupFunctionSupplied;			\
		boolean		dontAllowCleanInstall, allowCleanInstall;				\
		boolean		dontAllowServerAsTarget, allowServerAsTarget;			\
		fill bit[10];

/*  NOTE:  The 'allowServerAsTarget' flag is an unsupported and untested feature.  Only
those scriptwriters that absolutley, positively, must allow their users to
install onto AppleShare server volumes should use the 'allowServerAsTarget' flag!  And if
you install on an AppleShare volume, never, ever install anything into its System Folder!!
*/

type 'inpr' {
		switch {
			case format0:
				key integer = 0;		/* Preference version */
				preferenceFlags;		/* Preference Flags */
				rsrcType;				/* Type of code resource for Setup Function */
				rsrcID;					/* Id of code resource for Setup Function */
				unsigned integer = $$CountOf(helpPagelist);	/* Help page List */
				wide array helpPagelist {
					rsrcID;								/* B&W left edge picture */
					rsrcID;								/* B&W main text */
					rsrcID;								/* 8-Bit left edge picture */
					rsrcID;								/* 8-Bit main text */
				};
				evenPaddedString;		/* Default Folder name, if no Setup Function supplied */	
		};
};




/*
§ ----------------------------------- Search Procedure -----------------------------------*/
#define	searchProcedureFlags		\
		fill bit[16];

type 'insp' {	
	switch {
		case format0:
			key integer = 0;		/* Search Procedure Format version */
			searchProcedureFlags;	/* Search Procedure Flags */
			rsrcType;				/* Search Procedure Code Rsrc Type   NOTE:  code rsrc has C calling interface.*/
			rsrcID;					/* Search Procedure Code Rsrc ID */
			longint;				/* RefCon Value */
			unsigned longint;		/* Requested Memory in bytes */
			evenPaddedString;		/* Optional Summary String, not shown to user */	
	};
};


/*
§ ----------------------------------- Action Handlers -----------------------------------*/
#define	actionHandlerFlags		\
		fill bit[16];

type 'inah' {
		switch {
			case format0:
				key integer = 0;		/* Format version */
				actionHandlerFlags;		/* Action Handler Flags */
				rsrcType;				/* Action Handler Code Rsrc Type   NOTE:  code rsrc has C calling interface.*/
				rsrcID;					/* Action Handler Code Rsrc ID */
				unsigned longint;		/* Requested Memory in bytes */
				evenPaddedString;		/* Optional Summary String, not shown to user */	
		};
};


/*
§ ----------------------------------- Version Compare -----------------------------------*/
#define	versionCompareFlags		\
		fill bit[16];

type 'invc' {
		switch {
			case format0:
				key integer = 0;		/* Format version */
				versionCompareFlags;	/* Flags for Format 0 */
				rsrcType;				/* Version Proc. Code Rsrc Type   NOTE:  code rsrc has C calling interface.*/
				rsrcID;					/* Version Proc. Code Rsrc ID */
				unsigned longint;		/* Requested Memory in bytes */
				evenPaddedString;		/* Optional Summary String, not shown to user */	
		};
};


/*
§ ----------------------------------- Rule Function -----------------------------------*/
#define	ruleFunctionFlags		\
		fill bit[16];

type 'inrf' {
		switch {
			case format0:
				key integer = 0;		/* Format version */
				ruleFunctionFlags;		/* Flags for Format 0 */
				rsrcType;				/* Rule Function Code Rsrc Type   NOTE:  code rsrc has C calling interface.*/
				rsrcID;					/* Rule Function Code Rsrc ID */
				longint;				/* RefCon Value */
				unsigned longint;		/* Requested Memory in bytes */
				evenPaddedString;		/* Optional Summary String, not shown to user */	
		};
};


/*
§ ------------------------------ Script Sub-Heap Size Resource -------------------------------*/
type 'insz' {
		switch {
			case format0:
				key integer = 0;		/* Format version */
				unsigned longint;		/* Script Sub-Heap Size in bytes */
		};
};


