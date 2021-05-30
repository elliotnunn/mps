{
     File:       FinderRegistry.p
 
     Contains:   Data types for Finder AppleEvents
 
     Version:    Technology: Mac OS 8
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT FinderRegistry;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FINDERREGISTRY__}
{$SETC __FINDERREGISTRY__ := 1}

{$I+}
{$SETC FinderRegistryIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __AEREGISTRY__}
{$I AERegistry.p}
{$ENDC}
{$IFC UNDEFINED __OSA__}
{$I OSA.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


{
  //////////////////////////////////////
   Finder Suite
  //////////////////////////////////////
}

{
   The old Finder Event suite was 'FNDR'
   The new suite is 'fndr'
}

CONST
	kAEFinderSuite				= 'fndr';

	{
	  //////////////////////////////////////
	   Finder Events
	  //////////////////////////////////////
	}
	kAECleanUp					= 'fclu';
	kAEEject					= 'ejct';
	kAEEmpty					= 'empt';
	kAEErase					= 'fera';
	kAEGestalt					= 'gstl';
	kAEPutAway					= 'ptwy';
	kAERebuildDesktopDB			= 'rddb';
	kAESync						= 'fupd';
	kAEInterceptOpen			= 'fopn';

	{  "Sort" from the database suite: }
	kAEDatabaseSuite			= 'DATA';
	kAESort						= 'SORT';

	{
	  ////////////////////////////////////////////////////////////////////////
	   Classes
	   Note: all classes are defined up front so that the property definitions
	   can reference classes.
	  ////////////////////////////////////////////////////////////////////////
	}

	cInternalFinderObject		= 'obj ';						{  cReference - used to distinguish objects used inside the Finder only }

	{
	   Main Finder class definitions
	   Indentation implies object model hierarchy
	}
																{  We do not use class cItem from AERegistry.r. Instead our class Item is a cObject }
																{          cItem                        = 'citm',   // defined in AERegistry.r }
																{           cFile                    = 'file',  // defined in AERegistry.r }
	cAliasFile					= 'alia';
	cApplicationFile			= 'appf';
	cControlPanelFile			= 'ccdv';
	cDeskAccessoryFile			= 'dafi';
	cDocumentFile				= 'docf';
	cFontFile					= 'fntf';
	cSoundFile					= 'sndf';
	cClippingFile				= 'clpf';
	cContainer					= 'ctnr';
	cDesktop					= 'cdsk';
	cSharableContainer			= 'sctr';
	cDisk						= 'cdis';
	cFolder						= 'cfol';
	cSuitcase					= 'stcs';
	cAccessorySuitcase			= 'dsut';
	cFontSuitcase				= 'fsut';
	cTrash						= 'ctrs';
	cDesktopPrinter				= 'dskp';
	cPackage					= 'pack';
	cContentSpace				= 'dwnd';						{           cWindow                    = 'cwin',       // defined in AERegistry.r }
	cContainerWindow			= 'cwnd';
	cInfoWindow					= 'iwnd';
	cSharingWindow				= 'swnd';
	cStatusWindow				= 'qwnd';
	cClippingWindow				= 'lwnd';
	cPreferencesWindow			= 'pwnd';
	cDTPWindow					= 'dtpw';
	cProcess					= 'prcs';
	cAccessoryProcess			= 'pcda';
	cApplicationProcess			= 'pcap';
	cGroup						= 'sgrp';
	cUser						= 'cuse';						{          cApplication                  = 'capp',     // defined in AERegistry.r }
	cSharingPrivileges			= 'priv';
	cPreferences				= 'cprf';
	cLabel						= 'clbl';
	cSound						= 'snd ';
	cAliasList					= 'alst';
	cSpecialFolders				= 'spfl';						{  For use by viewer search engines: }
	cOnlineDisk					= 'cods';
	cOnlineLocalDisk			= 'clds';
	cOnlineRemoteDisk			= 'crds';						{  Miscellaneous class definitions }
	cEntireContents				= 'ects';
	cIconFamily					= 'ifam';


	{
	  //////////////////////////////////////
	   Properties
	  //////////////////////////////////////
	}

	{  Properties of class cItem (really cObject) }
																{     pBounds                        = 'pbnd',       // defined in AERegistry.r }
	pComment					= 'comt';
	pContainer					= 'ctnr';
	pContentSpace				= 'dwnd';
	pCreationDateOld			= 'crtd';						{  to support pre-Finder 8 scripts }
	pCreationDate				= 'ascd';						{  from File Commands OSAX }
	pDescription				= 'dscr';
	pDisk						= 'cdis';
	pFolderOld					= 'cfol';						{  to support pre-Finder 8 scripts }
	pFolder						= 'asdr';						{  from File Commands OSAX }
	pIconBitmap					= 'iimg';						{     pID                           = 'ID  ',        // defined in AERegistry.r }
	pInfoWindow					= 'iwnd';
	pKind						= 'kind';
	pLabelIndex					= 'labi';
	pModificationDateOld		= 'modd';						{  to support pre-Finder 8 scripts }
	pModificationDate			= 'asmo';						{  from File Commands OSAX }
																{     pName                      = 'pnam',         // defined in AERegistry.r }
	pPhysicalSize				= 'phys';
	pPosition					= 'posn';
	pIsSelected					= 'issl';
	pSize						= 'ptsz';						{  pPointSize defined in AERegistry.r }
	pWindow						= 'cwin';
	pPreferencesWindow			= 'pwnd';


	{  Properties of class cFile (subclass of cItem) }
	pFileCreator				= 'fcrt';
	pFileType					= 'asty';						{  from File Commands OSAX }
	pFileTypeOld				= 'fitp';						{  to support pre-Finder 8 scripts }
	pIsLocked					= 'aslk';						{  from File Commands OSAX }
	pIsLockedOld				= 'islk';						{  to support pre-Finder 8 scripts }
																{     pIsStationeryPad               = 'pspd',         // defined in AERegistry.r                 }
																{     pVersion                    = 'vers',       // defined in AERegistry.r }
	pProductVersion				= 'ver2';


	{  Properties of class cAliasFile (subclass of cFile) }
	pOriginalItem				= 'orig';

	{  Properties of class cApplicationFile (subclass of cFile) }
	pMinAppPartition			= 'mprt';
	pAppPartition				= 'appt';
	pSuggestedAppPartition		= 'sprt';
	pIsScriptable				= 'isab';

	{  Properties of class cURLFile (subclass of cFile) }
	pInternetLocation			= 'iloc';

	{  Properties of class cSoundFile (subclass of cFile) }
	pSound						= 'snd ';


	{
	   Properties of class cControlPanel (Views CP only) (subclass of cFile)
	   Note: the other view-like preference settings are not available in the Views
	   control panel. These properties are only offered here for backward compatability.
	   To set the full range of Finder Preferences, use the Preferences object.
	}
	pShowFolderSize				= 'sfsz';						{  Moved to a per-folder basis in Finder 8.0 HIS }
	pShowComment				= 'scom';						{  Moved to a per-folder basis in Finder 8.0 HIS }
	pShowDate					= 'sdat';						{  Moved to a per-folder basis in Finder 8.0 HIS }
	pShowCreationDate			= 'scda';						{  Moved to a per-folder basis in Finder 8.0 HIS }
	pShowKind					= 'sknd';						{  Moved to a per-folder basis in Finder 8.0 HIS }
	pShowLabel					= 'slbl';						{  Moved to a per-folder basis in Finder 8.0 HIS }
	pShowSize					= 'ssiz';						{  Moved to a per-folder basis in Finder 8.0 HIS }
	pShowVersion				= 'svrs';						{  Moved to a per-folder basis in Finder 8.0 HIS }
	pSortDirection				= 'sord';
	pShowDiskInfo				= 'sdin';						{  Always on in Finder 8.0 HIS }
	pListViewIconSize			= 'lvis';						{  Moved to a per-folder basis in Finder 8.0 HIS }
	pGridIcons					= 'fgrd';						{  Moved to a per-folder basis in Finder 8.0 HIS }
	pStaggerIcons				= 'fstg';						{  No longer part of the Finder 8.0 HIS }
	pViewFont					= 'vfnt';
	pViewFontSize				= 'vfsz';

	{  Properties of class cContainer (subclass of cItem) }
	pCompletelyExpanded			= 'pexc';
	pContainerWindow			= 'cwnd';
	pEntireContents				= 'ects';
	pExpandable					= 'pexa';
	pExpanded					= 'pexp';
	pPreviousView				= 'svew';						{     pSelection                    = 'sele',       // defined in AERegistry.r }
	pView						= 'pvew';
	pIconSize					= 'lvis';						{  defined above }
	pKeepArranged				= 'arrg';						{  OBSOLETE in Finder 9 or later }
	pKeepArrangedBy				= 'arby';						{  OBSOLETE in Finder 9 or later }

	{  Properties of class cDesktop (subclass of cContainer) }
	pStartupDisk				= 'sdsk';
	pTrash						= 'trsh';

	{  Properties of class cSharableContainer (subclass of cContainer) }
	pOwner						= 'sown';
	pOwnerPrivileges			= 'ownr';
	pGroup						= 'sgrp';
	pGroupPrivileges			= 'gppr';
	pGuestPrivileges			= 'gstp';
	pArePrivilegesInherited		= 'iprv';
	pExported					= 'sexp';
	pMounted					= 'smou';
	pSharingProtection			= 'spro';
	pSharing					= 'shar';
	pSharingWindow				= 'swnd';

	{  Properties of class cDisk (subclass of cSharableContainer) }
	pCapacity					= 'capa';
	pEjectable					= 'isej';
	pFreeSpace					= 'frsp';
	pLocal						= 'isrv';
	pIsStartup					= 'istd';

	{  Properties of class cTrash (subclass of cSharableContainer) }
	pWarnOnEmpty				= 'warn';

	{  Properties of class cWindow (subclass of cContentSpace) }
																{     pBounds                        = 'pbnd',   // defined in AERegistry.r }
																{     pHasCloseBox                = 'hclb',     // defined in AERegistry.r }
																{     pIsFloating                    = 'isfl',     // defined in AERegistry.r }
																{     pIndex                     = 'pidx',     // defined in AERegistry.r }
																{     pIsModal                    = 'pmod',   // defined in AERegistry.r }
																{     pPosition                    = 'posn',     // defined above }
																{     pIsResizable                = 'prsz',     // defined in AERegistry.r }
																{     pHasTitleBar                = 'ptit',     // defined in AERegistry.r }
																{     pVisible                    = 'pvis',   // defined in AERegistry.r }
																{     pIsZoomable                    = 'iszm',     // defined in AERegistry.r }
																{     pIsZoomed                    = 'pzum',     // defined in AERegistry.r }
	pIsZoomedFull				= 'zumf';
	pIsPopup					= 'drwr';
	pIsPulledOpen				= 'pull';						{  only applies to popup windows }
	pIsCollapsed				= 'wshd';						{  only applies to normal windows }

	{  Properties of class cContainerWindow (subclass of cWindow) }
	pObject						= 'cobj';

	{  Properties of class cSharingWindow (subclass of cWindow) }
	pSharableContainer			= 'sctr';

	{  Properties of class cInfoWindow (subclass of cWindow) }
	pInfoPanel					= 'panl';


	{  Properties of networking support }
	pFileShareOn				= 'fshr';
	pFileShareStartingUp		= 'fsup';
	pProgramLinkingOn			= 'iac ';

	{  Properties of class cPreferencesWindow (subclass of cWindow) }
																{     pShowFolderSize                   = 'sfsz',         // defined above for Views CP }
																{     pShowComment                = 'scom',      // defined above for Views CP }
	pShowModificationDate		= 'sdat';						{  pShowDate defined above for Views CP }
																{     pShowKind                    = 'sknd',        // defined above for Views CP }
																{     pShowLabel                    = 'slbl',         // defined above for Views CP }
																{     pShowSize                    = 'ssiz',        // defined above for Views CP }
																{     pShowVersion                = 'svrs',      // defined above for Views CP }
																{     pShowCreationDate             = 'scda',      // Removed from Finder 8.0 HIS }
																{     pShowFileType                 = 'sfty',       // Removed from Finder 8.0 HIS }
																{     pShowFileCreator               = 'sfcr',         // Removed from Finder 8.0 HIS }
																{     pListViewIconSize             = 'lvis',      // defined above for Views CP }
																{     pGridIcons                    = 'fgrd',         // defined above for Views CP }
																{     pStaggerIcons                 = 'fstg',       // defined above for Views CP }
																{     pViewFont                    = 'vfnt',        // defined above for Views CP }
																{     pViewFontSize                 = 'vfsz',       // defined above for Views CP }
	pUseRelativeDate			= 'urdt';						{  Moved to a per-folder basis in Finder 8.0 HIS }
	pDelayBeforeSpringing		= 'dela';
	pSpringOpenFolders			= 'sprg';
	pUseShortMenus				= 'usme';
	pUseWideGrid				= 'uswg';
	pLabel1						= 'lbl1';
	pLabel2						= 'lbl2';
	pLabel3						= 'lbl3';
	pLabel4						= 'lbl4';
	pLabel5						= 'lbl5';
	pLabel6						= 'lbl6';
	pLabel7						= 'lbl7';
	pDefaultIconViewIconSize	= 'iisz';
	pDefaultButtonViewIconSize	= 'bisz';
	pDefaultListViewIconSize	= 'lisz';						{  old use of this name is now pIconSize }
	pIconViewArrangement		= 'iarr';
	pButtonViewArrangement		= 'barr';

	{
	   The next bunch are the various arrangements that make up
	   enumArrangement
	}
	pNoArrangement				= 'narr';
	pSnapToGridArrangement		= 'grda';
	pByNameArrangement			= 'nama';
	pByModificationDateArrangement = 'mdta';
	pByCreationDateArrangement	= 'cdta';
	pBySizeArrangement			= 'siza';
	pByKindArrangement			= 'kina';
	pByLabelArrangement			= 'laba';

	{   #define pObject                                 cObject         // defined above }

	{  Properties of class cProcess (subclass of cObject) }
																{     pName                      = 'pnam',         // defined in AERegistry.r }
	pFile						= 'file';						{     pCreatorType                = 'fcrt',      // defined above }
																{     pFileType                    = 'asty',        // defined above }
																{     pIsFrontProcess                   = 'pisf',         // defined in AERegistry.r }
																{     pAppPartition                 = 'appt',       // defined above }
	pPartitionSpaceUsed			= 'pusd';						{     pIsScriptable                 = 'isab',       // defined in AERegistry.r }
																{     pVisible                    = 'pvis'      // defined in AERegistry.r }
	pLocalAndRemoteEvents		= 'revt';
	pHasScriptingTerminology	= 'hscr';

	{  Properties of class cAccessoryProcess (subclass of cProcess) }
	pDeskAccessoryFile			= 'dafi';

	{  Properties of class cApplicationProcess (subclass of cProcess) }
	pApplicationFile			= 'appf';

	{
	   Properties of class cGroup (subclass of cObject)
	  enum (
	    pBounds
	    pIconBitmap
	    pLabelIndex
	    pName
	    pPosition
	    pWindow                                 = cWindow           // defined above
	  );
	}

	{  Properties of class cUser (subclass of cObject) }
																{     pBounds }
																{     pIconBitmap }
																{     pLabelIndex }
																{     pName }
																{     pPosition }
																{     pWindow                        = cWindow,        // defined above }
	pCanConnect					= 'ccon';
	pCanChangePassword			= 'ccpw';
	pCanDoProgramLinking		= 'ciac';
	pIsOwner					= 'isow';
	pARADialIn					= 'arad';
	pShouldCallBack				= 'calb';
	pCallBackNumber				= 'cbnm';

	{
	   Properties of class cApplication (subclass of cObject)
	   NOTE: properties for the special folders must match their respective kXXXFolderType constants
	}
	pAboutMacintosh				= 'abbx';
	pAppleMenuItemsFolder		= 'amnu';						{  kAppleMenuFolderType }
																{     pClipboard                    = 'pcli',         // defined in AERegistry.r }
	pControlPanelsFolder		= 'ctrl';						{  kControlPanelFolderType }
	pDesktop					= 'desk';						{  kDesktopFolderType }
	pExtensionsFolder			= 'extn';						{  kExtensionFolderType }
																{     pFileShareOn                = 'fshr',      // defined above }
	pFinderPreferences			= 'pfrp';
	pFontsFolder				= 'font';
	pFontsFolderPreAllegro		= 'ffnt';						{  DO NOT USE THIS - FOR BACKWARDS COMPAT ONLY }
																{     pIsFrontProcess                   = 'pisf',         // defined in AERegistry.r }
																{     pInsertionLoc                 = 'pins',       // defined in AERegistry.r }
	pLargestFreeBlock			= 'mfre';
	pPreferencesFolder			= 'pref';						{  kPreferencesFolderType }
																{     pProductVersion                   = 'ver2',         // defined above }
																{     pUserSelection                  = 'pusl',        // defined in AERegistry.r }
																{     pFileShareStartingUp             = 'fsup',        // defined above }
	pShortCuts					= 'scut';
	pShutdownFolder				= 'shdf';
	pStartupItemsFolder			= 'strt';						{  kStartupFolderType }
	pSystemFolder				= 'macs';						{  kSystemFolderType }
	pTemporaryFolder			= 'temp';						{  kTemporaryFolderType }
																{     pVersion                    = 'vers',       // defined in AERegistry.r }
	pViewPreferences			= 'pvwp';						{     pVisible                    = 'pvis',       // defined in AERegistry.r }
	pStartingUp					= 'awak';						{  private property to tell whether the Finder is fully up and running }

	{  Properties of class cSharingPrivileges (subclass of cObject) }
	pSeeFiles					= 'prvr';
	pSeeFolders					= 'prvs';
	pMakeChanges				= 'prvw';

	{
	   Properties of class cPreferences (subclass of cObject)
	  enum (
	    pShowFolderSize                         = 'sfsz',           // defined above for Views CP
	    pShowComment                            = 'scom',           // defined above for Views CP
	    pShowModificationDate                   = pShowDate,            // pShowDate defined above for Views CP
	    pShowKind                               = 'sknd',           // defined above for Views CP
	    pShowLabel                              = 'slbl',           // defined above for Views CP
	    pShowSize                               = 'ssiz',           // defined above for Views CP
	    pShowVersion                            = 'svrs',           // defined above for Views CP
	    pShowCreationDate                       = 'scda',           // defined in cPreferencesWindow
	    pShowFileType                           = 'sfty',           // defined in cPreferencesWindow
	    pShowFileCreator                        = 'sfcr',           // defined in cPreferencesWindow
	    pListViewIconSize                       = 'lvis',           // defined above for Views CP
	    pGridIcons                              = 'fgrd',           // defined above for Views CP
	    pStaggerIcons                           = 'fstg',           // defined above for Views CP
	    pViewFont                               = 'vfnt',           // defined above for Views CP
	    pViewFontSize                           = 'vfsz',           // defined above for Views CP
	    pUseRelativeDate                        = 'urdt',           // defined in cPreferencesWindow
	    pDelayBeforeSpringing                   = 'dela',           // defined in cPreferencesWindow
	    pShowMacOSFolder                        = 'sosf',           // defined in cPreferencesWindow
	    pUseShortMenus                          = 'usme',           // defined in cPreferencesWindow
	    pUseCustomNewMenu                       = 'ucnm',           // defined in cPreferencesWindow
	    pShowDesktopInBackground                = 'sdtb',           // defined in cPreferencesWindow
	    pActivateDesktopOnClick                 = 'adtc',           // defined in cPreferencesWindow
	    pLabel1                                 = 'lbl1',           // defined in cPreferencesWindow
	    pLabel2                                 = 'lbl2',           // defined in cPreferencesWindow
	    pLabel3                                 = 'lbl3',           // defined in cPreferencesWindow
	    pLabel4                                 = 'lbl4',           // defined in cPreferencesWindow
	    pLabel5                                 = 'lbl5',           // defined in cPreferencesWindow
	    pLabel6                                 = 'lbl6',           // defined in cPreferencesWindow
	    pLabel7                                 = 'lbl7',           // defined in cPreferencesWindow
	    pWindow                                 = cWindow           // defined above
	  );
	}

	{
	   Properties of class cLabel (subclass of cObject)
	  enum (
	    pName                                   = 'pnam',           // defined in AERegistry.r
	    pColor                                  = 'colr',           // defined in AERegistry.r
	  );
	}

	{  Misc Properties }
	pSmallIcon					= 'smic';
	pSmallButton				= 'smbu';
	pLargeButton				= 'lgbu';
	pGrid						= 'grid';

	{
	  //////////////////////////////////////
	   Enumerations defined by the Finder
	  //////////////////////////////////////
	}

	enumViewBy					= 'vwby';
	enumGestalt					= 'gsen';
	enumConflicts				= 'cflc';
	enumExistingItems			= 'exsi';
	enumOlderItems				= 'oldr';

	enumDate					= 'enda';
	enumAnyDate					= 'anyd';
	enumToday					= 'tday';
	enumYesterday				= 'yday';
	enumThisWeek				= 'twek';
	enumLastWeek				= 'lwek';
	enumThisMonth				= 'tmon';
	enumLastMonth				= 'lmon';
	enumThisYear				= 'tyer';
	enumLastYear				= 'lyer';
	enumBeforeDate				= 'bfdt';
	enumAfterDate				= 'afdt';
	enumBetweenDate				= 'btdt';
	enumOnDate					= 'ondt';

	enumAllDocuments			= 'alld';
	enumFolders					= 'fold';
	enumAliases					= 'alia';
	enumStationery				= 'stat';

	enumWhere					= 'wher';
	enumAllLocalDisks			= 'aldk';
	enumAllRemoteDisks			= 'ardk';
	enumAllDisks				= 'alld';
	enumAllOpenFolders			= 'aofo';


	enumIconSize				= 'isiz';
	enumSmallIconSize			= 'smic';
	enumMiniIconSize			= 'miic';
	enumLargeIconSize			= 'lgic';

	enumSortDirection			= 'sodr';
	enumSortDirectionNormal		= 'snrm';
	enumSortDirectionReverse	= 'srvs';

	enumArrangement				= 'earr';

	{  Get Info Window panel enumeration }
	enumInfoWindowPanel			= 'ipnl';
	enumGeneralPanel			= 'gpnl';
	enumSharingPanel			= 'spnl';
	enumStatusNConfigPanel		= 'scnl';
	enumFontsPanel				= 'fpnl';
	enumMemoryPanel				= 'mpnl';


	{  Preferences panel enumeration }
	enumPrefsWindowPanel		= 'pple';
	enumPrefsGeneralPanel		= 'pgnp';
	enumPrefsLabelPanel			= 'plbp';
	enumPrefsIconViewPanel		= 'pivp';
	enumPrefsButtonViewPanel	= 'pbvp';
	enumPrefsListViewPanel		= 'plvp';

	{
	  //////////////////////////////////////
	   Types defined by the Finder
	  //////////////////////////////////////
	}

	typeIconFamily				= 'ifam';						{  An AEList of typeIconAndMask, type8BitIcon, & c. }
	typeIconAndMask				= 'ICN#';
	type8BitMask				= 'l8mk';
	type32BitIcon				= 'il32';
	type8BitIcon				= 'icl8';
	type4BitIcon				= 'icl4';
	typeSmallIconAndMask		= 'ics#';
	typeSmall8BitMask			= 's8mk';
	typeSmall32BitIcon			= 'is32';
	typeSmall8BitIcon			= 'ics8';
	typeSmall4BitIcon			= 'ics4';
	typeRelativeTime			= 'rtim';
	typeConceptualTime			= 'timc';

	{
	  //////////////////////////////////////
	   Keywords defined by the Finder
	  //////////////////////////////////////
	}

	keyIconAndMask				= 'ICN#';
	key32BitIcon				= 'il32';
	key8BitIcon					= 'icl8';
	key4BitIcon					= 'icl4';
	key8BitMask					= 'l8mk';
	keySmallIconAndMask			= 'ics#';
	keySmall8BitIcon			= 'ics8';
	keySmall4BitIcon			= 'ics4';
	keySmall32BitIcon			= 'is32';
	keySmall8BitMask			= 's8mk';
	keyMini1BitMask				= 'icm#';
	keyMini4BitIcon				= 'icm4';
	keyMini8BitIcon				= 'icm8';
	keyAEUsing					= 'usin';
	keyAEReplacing				= 'alrp';
	keyAENoAutoRouting			= 'rout';
	keyLocalPositionList		= 'mvpl';
	keyGlobalPositionList		= 'mvpg';
	keyRedirectedDocumentList	= 'fpdl';

	{
	  //////////////////////////////////////
	   New prepositions used by the Finder
	  //////////////////////////////////////
	}

	keyASPrepositionHas			= 'has ';
	keyAll						= 'kyal';
	keyOldFinderItems			= 'fsel';

	{
	  //////////////////////////////////////
	   New key forms used by the Finder
	  //////////////////////////////////////
	}

	formAlias					= 'alis';
	formCreator					= 'fcrt';


	{
	  //////////////////////////////////////
	   Finder error codes
	  //////////////////////////////////////
	}

	errFinderIsBusy				= -15260;
	errFinderWindowNotOpen		= -15261;
	errFinderCannotPutAway		= -15262;
	errFinderWindowMustBeIconView = -15263;						{  RequireWindowInIconView }
	errFinderWindowMustBeListView = -15264;						{  RequireWindowInListView }
	errFinderCantMoveToDestination = -15265;
	errFinderCantMoveSource		= -15266;
	errFinderCantOverwrite		= -15267;
	errFinderIncestuousMove		= -15268;						{  Could just use errFinderCantMoveSource }
	errFinderCantMoveToAncestor	= -15269;						{  Could also use errFinderCantMoveSource }
	errFinderCantUseTrashedItems = -15270;
	errFinderItemAlreadyInDest	= -15271;						{  Move from folder A to folder A }
	errFinderUnknownUser		= -15272;						{  Includes unknown group }
	errFinderSharePointsCantInherit = -15273;
	errFinderWindowWrongType	= -15274;
	errFinderPropertyNowWindowBased = -15275;
	errFinderAppFolderProtected	= -15276;						{  used by General controls when folder protection is on }
	errFinderSysFolderProtected	= -15277;						{  used by General controls when folder protection is on }
	errFinderBoundsWrong		= -15278;
	errAEValueOutOfRange		= -15279;
	errFinderPropertyDoesNotApply = -15280;
	errFinderFileSharingMustBeOn = -15281;
	errFinderMustBeActive		= -15282;
	errFinderVolumeNotFound		= -15283;						{  more descriptive than what we get with nsvErr }
	errFinderLockedItemsInTrash	= -15284;						{  there are some locked items in the trash }
	errFinderOnlyLockedItemsInTrash = -15285;					{  all the items (except folders) in the trash are locked }
	errFinderProgramLinkingMustBeOn = -15286;
	errFinderWindowMustBeButtonView = -15287;
	errFinderBadPackageContents	= -15288;						{  something is wrong within the package    }
	errFinderUnsupportedInsidePackages = -15289;				{  operation cannot be used on items within a package      }
	errFinderCorruptOpenFolderList = -15290;					{  was -15276 in Finder 8.6 and earlier, but that conflicted with General Controls }
	errFinderNoInvisibleFiles	= -15291;						{  was -15277 in Finder 8.6 and earlier, but that conflicted with General Controls }
	errFinderCantDeleteImmediately = -15292;					{  cannot delete immediately via scripting }
	errFinderLastReserved		= -15379;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FinderRegistryIncludes}

{$ENDC} {__FINDERREGISTRY__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
