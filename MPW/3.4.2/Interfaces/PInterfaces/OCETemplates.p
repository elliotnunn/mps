{
 	File:		OCETemplates.p
 
 	Contains:	Apple Open Collaboration Environment Templates Interfaces.
 
 	Version:	Technology:	AOCE Toolbox 1.02
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OCETemplates;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OCETEMPLATES__}
{$SETC __OCETEMPLATES__ := 1}

{$I+}
{$SETC OCETemplatesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{	Quickdraw.p													}
{		MixedMode.p												}
{		QuickdrawText.p											}
{	OSUtils.p													}
{		Memory.p												}

{$IFC UNDEFINED __CONTROLS__}
{$I Controls.p}
{$ENDC}
{	Menus.p														}

{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{	Errors.p													}
{	EPPC.p														}
{		AppleTalk.p												}
{		Files.p													}
{			Finder.p											}
{		PPCToolbox.p											}
{		Processes.p												}
{	Notification.p												}

{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{	Windows.p													}
{	TextEdit.p													}

{$IFC UNDEFINED __OCE__}
{$I OCE.p}
{$ENDC}
{	Aliases.p													}
{	Script.p													}
{		IntlResources.p											}

{$IFC UNDEFINED __OCESTANDARDMAIL__}
{$I OCEStandardMail.p}
{$ENDC}
{	OCEAuthDir.p												}
{	OCEMail.p													}
{		DigitalSignature.p										}
{		OCEMessaging.p											}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	kDETAspectVersion			= -976;
	kDETInfoPageVersion			= -976;
	kDETKillerVersion			= -976;
	kDETForwarderVersion		= -976;
	kDETFileTypeVersion			= -976;

{	"Normal" separation for template IDs within the file (this is just a suggestion; you can use whatever
	separation you like, so long as two separate templates don't have overlapping resources): }
	kDETIDSep					= 250;

{ A few predefined base IDs (again, just suggestions): }
	kDETFirstID					= 1000;
	kDETSecondID				= 1000 + kDETIDSep;
	kDETThirdID					= 1000 + 2 * kDETIDSep;
	kDETFourthID				= 1000 + 3 * kDETIDSep;
	kDETFifthID					= 1000 + 4 * kDETIDSep;

{	Templates consist of a set of associated resources, at constant offsets from a "base ID" set by the
	signature resource of the template. In the case of aspect templates, most of the resources in the
	template are accessible from the template as property default values. The property number is the same
	as the offset from the base ID of the resource. In describing the resources which make up templates,
	we give the type, the offset, and a description. For aspect templates, the offset is also the property #. 
	
	All templates include the following resource fork resources:

	 Type	Offset						Description
	 ----	------						-----------
	'rstr'	kDETTemplateName			Contains the name of the template

}
	kDETTemplateName			= 0;

{	Aspects, info-pages, and forwarders include the following as well:

	 Type	Offset						Description
	 ----	------						-----------
	'rstr'	kDETRecordType				Contains the type of record this applies to
	'rstr'	kDETAttributeType			Contains the type of attribute this applies to
	'detn'	kDETAttributeValueTag		Contains the tag of the attribute values this applies to

}
	kDETRecordType				= 1;
	kDETAttributeType			= 2;
	kDETAttributeValueTag		= 3;

{ ************************************ Aspects }
{	In the case of aspects, property numbers and resource id offsets are the same. Therefore, some of the following
	defines are used for resource offsets, some are used for dynamically generated properties, and some are used for
	both (i.e., properties which may be dynamically generated, but if they aren't, then they're taken from the
	resource). Resource types are given in all cases below; even if there is no actual resource (for example in
	the case of kDETAspectName), it indicates the type for the dynamically generated property. A resource type of
	'rstr' corresponds to a property type of kDETPrTypeString; type 'detn' corresponds to kDETPrTypeNumber; and
	'detb' corresponds to kDETPrTypeBinary.

	 Type	Offset						Description
	 ----	------						-----------
	'deta'	0							Identifies the type of resource
	'detc'	kDETCode					Is the code resource, if any is used
	'ICN#'	kDETAspectMainBitmap
	'icl8'	kDETAspectMainBitmap
	'icl4'	kDETAspectMainBitmap
	'ics#'	kDETAspectMainBitmap
	'ics8'	kDETAspectMainBitmap
	'ics4'	kDETAspectMainBitmap
	'sicn'	kDETAspectMainBitmap		Is the icon suite to display for this item type (main aspect only)
	'rstr'	kDETAspectName				Contains the name of the item (attribute main aspect only)
	'rst#'	kDETAspectCategory			Contains the internal categories for the record type (main aspect only)
	'rst#'	kDETAspectExternalCategory	Contains the external (user-visible) names which correspond to the categories in
										kDETAspectCategory; if this resource is not present, external names are taken from
										another template; if no other template provides an external name for a given internal
										category, the internal name is used as the external name (main aspect only)
	'rstr'	kDETAspectKind				Is the item kind to display (main aspect only)
	'detn'	kDETAspectGender			Is the gender of this kind of object for internationalization (main aspect only)
	'rstr'	kDETAspectWhatIs			Is the string for balloon help when item is in sublist (main aspect only)
	'rstr'	kDETAspectAliasKind			Is the item kind to display for aliases to this type of item (main aspect only)
	'detn'	kDETAspectAliasGender		Is the gender of an alias to this kind of object for internationalization (main aspect only)
	'rstr'	kDETAspectAliasWhatIs		Is the string for balloon help when an alias to the item is in sublist (main aspect only)
	'rst#'	kDETAspectBalloons			Is a list of strings for balloon help; for each item in an info-page, it's
										property # times 2 is used as an index into this array; if the item is not editable,
										then the property # times 2 plus 1 is used
	'rstr'	kDETAspectNewMenuName		Is the string to be used for the user to select new item creation; for records, the
										string is used as a menu entry in the Catalogs menu; for attributes, the string
										is used in a selection dialog invoked by an "Add..." button
	'rstr'	kDETAspectNewEntryName		Is the name to be used for new records (with a digit appended if not unique)
	'detb'	kDETAspectNewValue			Is the value to use when creating a new attribute value; the first four bytes
										is the tag; the rest is the attribute value contents
	'detn'	kDETAspectSublistOpenOnNew	If true (non-zero), automatically open newly created entries (property can be set
										from a code resource, or via a default value in a resource)
	'dett'	kDETAspectLookup			Is the attribute-to-property translation table
	'rstr'	kDETAspectDragInString		Is a string describing the action of dragging into this aspect (if any)
	'rstr'	kDETAspectDragInVerb		Is a single, short word that's the verb of the action (like "add" or "drop"; if
										there's any doubt, use "OK")
	'rstr'	kDETAspectDragInSummary		Is a short phrase that describes the action, suitable to be included in a selection list
	'rst#'	kDETAspectRecordDragIn		Is a list of type pairs; in each pair, the first is the type of a record which
										can be dragged into this aspect, and the second is the attribute type to store
										the reference in
	'rst#'	kDETAspectRecordCatDragIn	Is a list of category/attribute type pairs; in each pair, the first is the
										category of records which can be dragged in, and the second is the type of
										attribute to place the alias in
	'rst#'	kDETAspectAttrDragIn		Is a list of type triples; in each triple, the first is the record type which can be
										dragged from (or "" for any), the second is the attribute type which can be dragged
										in, and the third is the attribute type to store the new attribute in
	'rst#'	kDETAspectDragOut			Is a list of attribute types which can be dragged out of this aspect (an 'rst#'
										resource with no entries means nothing can be dragged out; no 'rst#' resource means
										everything can be dragged out)
	'detm'	kDETAspectViewMenu			Is a table to fill in the view menu from
	'detp'	kDETAspectReverseSort		Is a table listing which properties to sort in reverse order
	'detw'	kDETAspectInfoPageCustomWindow	Is a specification of a custom window size/placement & whether to use the
											page-selector (main aspect only)
	'detv'	kDETAspectInfoPageCustomWindow	Is a view list which is common to all info-pages (main aspect only)
}
	kDETAspectCode				= 4;
	kDETAspectMainBitmap		= 5;
	kDETAspectName				= 6;
	kDETAspectCategory			= 7;
	kDETAspectExternalCategory	= 8;
	kDETAspectKind				= 9;
	kDETAspectGender			= 10;
	kDETAspectWhatIs			= 11;
	kDETAspectAliasKind			= 12;
	kDETAspectAliasGender		= 13;
	kDETAspectAliasWhatIs		= 14;
	kDETAspectBalloons			= 15;
	kDETAspectNewMenuName		= 16;
	kDETAspectNewEntryName		= 17;
	kDETAspectNewValue			= 18;
	kDETAspectSublistOpenOnNew	= 19;
	kDETAspectLookup			= 20;
	kDETAspectDragInString		= 21;
	kDETAspectDragInVerb		= 22;
	kDETAspectDragInSummary		= 23;
	kDETAspectRecordDragIn		= 24;
	kDETAspectRecordCatDragIn	= 25;
	kDETAspectAttrDragIn		= 26;
	kDETAspectAttrDragOut		= 27;
	kDETAspectViewMenu			= 28;
	kDETAspectReverseSort		= 29;
	kDETAspectInfoPageCustomWindow = 30;

{ Properties: }
	kDETNoProperty				= -1;

{ Each aspect has 250 attribute properties in this range: }
	kDETFirstLocalProperty		= 0;
	kDETLastLocalProperty		= 0+(kDETFirstLocalProperty + 249);

{ Developers should use property numbers starting at this point: }
	kDETFirstDevProperty		= 40;

{ The following range provides constant numeric properties for use in patterns and comparisons (constant n is
  
   given by kDETFirstConstantProperty+n): }
	kDETFirstConstantProperty	= 250;
	kDETLastConstantProperty	= 0+(kDETFirstConstantProperty + 249);

{ To convert a number into a constant property, add this: }
	kDETConstantProperty		= kDETFirstConstantProperty;
	kDETZeroProperty			= 0+(kDETConstantProperty + 0);
	kDETOneProperty				= 0+(kDETConstantProperty + 1);
	kDETFalseProperty			= 0+(kDETConstantProperty + 0);
	kDETTrueProperty			= 0+(kDETConstantProperty + 1);

{ The following apply to records, attributes, or aliases; they are the name and kind, as they appear in icon lists: }
	kDETPrName					= 3050;
	kDETPrKind					= 3051;

{ Access mask properties: }
	kDETDNodeAccessMask			= 25825;						{ The DNode access mask }
	kDETRecordAccessMask		= 25826;						{ The record access mask }
	kDETAttributeAccessMask		= 25827;						{ The attribute access mask }
	kDETPrimaryMaskByBit		= 25828;						{ A set of sixteen properties to access all bits of the primary mask }

{ See AOCE documentation for details definitions of each of these bits: }
	kDETPrimarySeeMask			= kDETPrimaryMaskByBit;
	kDETPrimaryAddMask			= 0+(kDETPrimaryMaskByBit + 1);
	kDETPrimaryDeleteMask		= 0+(kDETPrimaryMaskByBit + 2);
	kDETPrimaryChangeMask		= 0+(kDETPrimaryMaskByBit + 3);
	kDETPrimaryRenameMask		= 0+(kDETPrimaryMaskByBit + 4);
	kDETPrimaryChangePrivsMask	= 0+(kDETPrimaryMaskByBit + 5);
	kDETPrimaryTopMaskBit		= 0+(kDETPrimaryMaskByBit + 15);

{ The following property is zero until we've completed the first catalog lookup; from then on it's 1 }
	kDETPastFirstLookup			= 26550;

{ The following property is the page number; issuing a property command with this property will flip info-pages }
	kDETInfoPageNumber			= 27050;

{ The value of the following properties contains the template number of the targeted aspect's template, and the
   currently open info-page (if any). These values can be used with kDETAspectTemplate and kDETInfoPageTemplate
   target selectors. }
	kDETAspectTemplateNumber	= 26551;
	kDETInfoPageTemplateNumber	= 26552;

{ Properties for property commands to deal with sublist items: }
	kDETOpenSelectedItems		= 26553;						{ Open selected sublist items }
	kDETAddNewItem				= 26554;						{ Add new sublist item }
	kDETRemoveSelectedItems		= 26555;						{ Remove selected sublist items }

{ Property types are used to specify types of properties and conversions between types (zero and negative numbers
   are reserved for Apple; developer code resources can use positive numbers): }
	kDETPrTypeNumber			= -1;							{ A number }
	kDETPrTypeString			= -2;							{ A string }
	kDETPrTypeBinary			= -3;							{ A binary block }

{ ************************************ Info-pages }
{ Info-pages include the following as well:

	 Type	Offset						Description
	 ----	------						-----------
	'deti'	0							Identifies the type of resource; see below for details on the contents
	'rstr'	kDETInfoPageName			Is the name of the view to use in the page selection pop-up
	'rstr'	kDETInfoPageMainViewAspect	Is the name of the aspect to use with the main page view
	'rstr'	kDETInfoPageMenuName		Is the name of the catalogs menu ("Catalogs" if not present)
	'detm'	kDETInfoPageMenuEntries		Are menu entries to go in the Catalogs menu

}
	kDETInfoPageName			= 4;
	kDETInfoPageMainViewAspect	= 5;
	kDETInfoPageMenuName		= 6;
	kDETInfoPageMenuEntries		= 7;

{ ************************************ Views 

   Flags: }
	kDETNoFlags					= 0;
{ Main view (non-sublist) field enabled }
	kDETEnabled					= 0+(1 * (2**(0)));

{ The following flags make sense for items in a sublist only }
{ Hilight view when entry is selected }
	kDETHilightIfSelected		= 0+(1 * (2**(0)));

{ The following flags make sense for text views only }
	kDETNumericOnly				= 0+(1 * (2**(3)));				{ Only allow the user to enter digits }
	kDETMultiLine				= 0+(1 * (2**(4)));				{ Allow multiple lines in view }
	kDETDynamicSize				= 0+(1 * (2**(9)));				{ Don't draw box around text until user clicks in it, then auto-size it
	 * Don't allow the user to enter colons (convert ":"s to "-"s) }
	kDETAllowNoColons			= 0+(1 * (2**(10)));

{ The following flags are used for pop-up menus only }
{ Automatically resize pop-up based on contents }
	kDETPopupDynamicSize		= 0+(1 * (2**(8)));

{ The following flags are used for EditPicture views only }
{ Scale picture to view bounds rather than cropping }
	kDETScaleToView				= 0+(1 * (2**(8)));

{	Sizes for icons }
	kDETLargeIcon				= 0;
	kDETSmallIcon				= 1;
	kDETMiniIcon				= 2;

{ Stolen from TextEdit.h }
	kDETLeft					= 0;
	kDETCenter					= 1;
	kDETRight					= -1;
	kDETForceLeft				= -2;

{ Flags for use within Box view type attributes - these are distinct from the flags above }
	kDETUnused					= 0;
	kDETBoxTakesContentClicks	= 0+(1 * (2**(0)));
	kDETBoxIsRounded			= 0+(1 * (2**(1)));
	kDETBoxIsGrayed				= 0+(1 * (2**(2)));
	kDETBoxIsInvisible			= 0+(1 * (2**(3)));

{ The common font info }
	kDETApplicationFont			= 1;
	kDETApplicationFontSize		= 9;
	kDETAppFontLineHeight		= 12;
	kDETSystemFont				= 0;
	kDETSystemFontSize			= 12;
	kDETSystemFontLineHeight	= 16;
	kDETDefaultFont				= 1;
	kDETDefaultFontSize			= 9;
	kDETDefaultFontLineHeight	= 12;

{	These were taken from QuickDraw.h (where they're enums and therefore unusable in resource definitions): }
	kDETNormal					= 0;
	kDETBold					= 1;
	kDETItalic					= 2;
	kDETUnderline				= 4;
	kDETOutline					= 8;
	kDETShadow					= $10;
	kDETCondense				= $20;
	kDETExtend					= $40;

	kDETIconStyle				= -3;							{ Normal text style for regular sublist entries, italic text style for aliases }

{ View menu: }
	kDETChangeViewCommand		= 'view';

{ Info-page window sizes: }
{ Default record info-pages: }
	kDETRecordInfoWindHeight	= 228;
	kDETRecordInfoWindWidth		= 400;

{ Default attribute info-pages: }
	kDETAttributeInfoWindHeight	= 250;
	kDETAttributeInfoWindWidth	= 230;

{ Page identifying icon (for default info-page layout): }
	kDETSubpageIconTop			= 8;
	kDETSubpageIconLeft			= 8;
	kDETSubpageIconBottom		= 0+(kDETSubpageIconTop + 32);
	kDETSubpageIconRight		= 0+(kDETSubpageIconLeft + 32);

{ ************************************ Killers 

   Killers include the following as well:

	 Type	Offset						Description
	 ----	------						-----------
	'detk'	0							Identifies the type of resource; see below for details on the contents
	'rst#'	kDETKillerName				Contains a list of template names to be killed

}
	kDETKillerName				= 1;

{ ************************************ Forwarders 

   Forwarders include the following as well:

	 Type	Offset						Description
	 ----	------						-----------
	'detf'	0							Identifies the type of resource; see below for details on the contents
	'rst#'	kDETForwarderTemplateNames	Contains a list of names of templates to forward to

}
	kDETForwarderTemplateNames	= 4;

{ Target specification: }
	kDETSelf					= 0;							{ The "current" item }
	kDETSelfOtherAspect			= 1;							{ Another aspect of the current item }
	kDETParent					= 2;							{ The parent (i.e., the aspect we're in the sublist of, if any) of the current item }
	kDETSublistItem				= 3;							{ The itemNumberth item in the sublist }
	kDETSelectedSublistItem		= 4;							{ The itemNumberth selected item in the sublist }
	kDETDSSpec					= 5;							{ The item specified by the packed DSSpec }
	kDETAspectTemplate			= 6;							{ A specific aspect template (number itemNumber) }
	kDETInfoPageTemplate		= 7;							{ A specific info-page template (number itemNumber)
	*  Force type to be short }
	kDETHighSelector			= $F000;

	
TYPE
	DETTargetSelector = LONGINT;

	DETTargetSpecification = RECORD
		selector:				DETTargetSelector;						{ Target selection method (see above) }
		aspectName:				RStringPtr;								{ The name of the aspect (kDETSelfOtherAspect, kDETSublistItem,
										   kDETSelectedSublistItem, kDETDSSpec); nil for main aspect or none;
										   always filled in for calls if there is an aspect, even if it's the main aspect }
		itemNumber:				LONGINT;								{ Sublist index (kDETSublistItem & kDETSelectedSublistItem & kDETAspectTemplate);
										   1-based indexing }
		dsSpec:					PackedDSSpecPtr;						{ DSSpec (kDETDSSpec only) }
	END;

{ Code resource calls and call-backs both return an OSType:
		kDETDidNotHandle (1)	= used by template to say "I didn't handle it" (for calls only)
		noErr					= function completed successfully
		any error				= function failed, and here's why
}
{$SETC kDETDidNotHandle := 1}

CONST
	kDETcmdSimpleCallback		= 0;
	kDETcmdBeep					= 1;
	kDETcmdBusy					= 2;
	kDETcmdChangeCallFors		= 3;
	kDETcmdGetCommandSelectionCount = 4;
	kDETcmdGetCommandItemN		= 5;
	kDETcmdOpenDSSpec			= 6;
	kDETcmdAboutToTalk			= 7;
	kDETcmdUnloadTemplates		= 8;
	kDETcmdTemplateCounts		= 9;
	kDETcmdTargetedCallback		= 1000;
	kDETcmdGetDSSpec			= 1001;
	kDETcmdSublistCount			= 1002;
	kDETcmdSelectedSublistCount	= 1003;
	kDETcmdRequestSync			= 1004;
	kDETcmdBreakAttribute		= 1005;
	kDETcmdGetTemplateFSSpec	= 1006;
	kDETcmdGetOpenEdit			= 1007;
	kDETcmdCloseEdit			= 1008;
	kDETcmdPropertyCallback		= 2000;
	kDETcmdGetPropertyType		= 2001;
	kDETcmdGetPropertyNumber	= 2002;
	kDETcmdGetPropertyRString	= 2003;
	kDETcmdGetPropertyBinarySize = 2004;
	kDETcmdGetPropertyBinary	= 2005;
	kDETcmdGetPropertyChanged	= 2006;
	kDETcmdGetPropertyEditable	= 2007;
	kDETcmdSetPropertyType		= 2008;
	kDETcmdSetPropertyNumber	= 2009;
	kDETcmdSetPropertyRString	= 2010;
	kDETcmdSetPropertyBinary	= 2011;
	kDETcmdSetPropertyChanged	= 2012;
	kDETcmdSetPropertyEditable	= 2013;
	kDETcmdDirtyProperty		= 2014;
	kDETcmdDoPropertyCommand	= 2015;
	kDETcmdAddMenu				= 2016;
	kDETcmdRemoveMenu			= 2017;
	kDETcmdMenuItemRString		= 2018;
	kDETcmdSaveProperty			= 2019;
	kDETcmdGetCustomViewUserReference = 2020;
	kDETcmdGetCustomViewBounds	= 2021;
	kDETcmdGetResource			= 2022;
{ Force type to be long }
	kDETcmdHighCallback			= $F0000000;

	
TYPE
	DETCallBackFunctions = LONGINT;

	DETProtoCallBackBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
	END;

	DETBeepBlock = RECORD
		reqFunction:			DETCallBackFunctions;
	END;

	DETBusyBlock = RECORD
		reqFunction:			DETCallBackFunctions;
	END;

	DETChangeCallForsBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		newCallFors:			LONGINT;								{  -> New call-for mask }
	END;

	DETGetCommandSelectionCountBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		count:					LONGINT;								{ <-  The number of items in the command selection list }
	END;


CONST
	kDETHFSType					= 0;							{ HFS item type }
	kDETDSType					= 1;							{ Catalog Service item type }
	kDETMailType				= 2;							{ Mail (letter) item type }
	kDETMoverType				= 3;							{ Sounds, fonts, etc., from inside a suitcase or system file }
	kDETLastItemType			= $F0000000;					{ Force it to be a long (C & C++ seem to disagree about the definition of 0xF000) }

	
TYPE
	DETItemType = LONGINT;

{ FSSpec plus possibly interesting additional info }
	DETFSInfo = RECORD
		fileType:				OSType;									{ File type }
		fileCreator:			OSType;									{ File creator }
		fdFlags:				INTEGER;								{ Finder flags }
		fsSpec:					FSSpec;									{ FSSpec }
	END;

	DSRec = RECORD
		dsSpec:					^PackedDSSpecPtr;						{ <-  DSSpec for item (caller must DisposHandle() when done) }
		refNum:					INTEGER;								{ <-  Refnum for returned address }
		identity:				AuthIdentity;							{ <-  Identity for returned address }
	END;

	DETFSInfoPtr = ^DETFSInfo;

	LetterSpecPtr = ^LetterSpec;

	ItemRec = RECORD
		CASE INTEGER OF
		0: (
			fsInfo:						^DETFSInfoPtr;						{ <-  FSSpec & info for item (caller must DisposHandle() when done) }
		   );
		1: (
			ds:							DSRec;
		   );
		2: (
			dsSpec:						^PackedDSSpecPtr;					{ <-  DSSpec for item (caller must DisposHandle() when done) }
		   );
		3: (
			ltrSpec:					^LetterSpecPtr;						{ <-  Letter spec for item (caller must DisposHandle() when done) }
		   );
	END;

	DETGetCommandItemNBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		itemNumber:				LONGINT;								{  -> Item number to retrieve (1-based) }
		itemType:				DETItemType;							{  -> Type of item to be returned (if we can interpret it as such) }
		item:					ItemRec;
	END;

	DETGetDSSpecBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		dsSpec:					^PackedDSSpecPtr;						{ <-  Handle with result (caller must DisposHandle() when done) }
		refNum:					INTEGER;								{ <-  Refnum for address if PD }
		identity:				AuthIdentity;							{ <-  Identity for address }
		isAlias:				BOOLEAN;								{ <-  True if this entry is an alias }
		isRecordRef:			BOOLEAN;								{ <-  True if this entry is a record reference (reserved) }
	END;

	DETGetTemplateFSSpecBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		fsSpec:					FSSpec;									{ <-  FSSpec of template file }
		baseID:					INTEGER;								{ <-  Base ID of this template }
		aspectTemplateNumber:	LONGINT;								{ <-  The template number for this aspect template }
	END;

	DETGetOpenEditBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		viewProperty:			INTEGER;								{ <-  The property of the view being edited (or kNoProperty if none) }
	END;

	DETCloseEditBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
	END;

	DETGetPropertyTypeBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
		propertyType:			INTEGER;								{ <-  The type of the property }
	END;

	DETGetPropertyNumberBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
		propertyValue:			LONGINT;								{ <-  The value of the property }
	END;

	DETGetPropertyRStringBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
		propertyValue:			RStringHandle;							{ <-  A handle containing the property (as an RString) (caller must DisposHandle() when done) }
	END;

	DETGetPropertyBinarySizeBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
		propertyBinarySize:		LONGINT;								{ <-  The size of the property as a binary block }
	END;

	DETGetPropertyBinaryBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
		propertyValue:			Handle;									{ <-  Handle with the value of the property (caller must DisposHandle() when done) }
	END;

	DETGetPropertyChangedBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
		propertyChanged:		BOOLEAN;								{ <-  True if the property is marked as changed }
		filler1:				BOOLEAN;
	END;

	DETGetPropertyEditableBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
		propertyEditable:		BOOLEAN;								{ <-  True if the property can be edited by the user (if false, view will appear disabled) }
		filler1:				BOOLEAN;
	END;

	DETSetPropertyTypeBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
		newType:				INTEGER;								{  -> New type for property (just sets type, does not convert contents) }
	END;

	DETSetPropertyNumberBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
		newValue:				LONGINT;								{  -> New value to set property to (and set type to number) }
	END;

	DETSetPropertyRStringBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
		newValue:				RStringPtr;								{  -> New value to set property to (and set type to RString) }
	END;

	DETSetPropertyBinaryBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
		newValue:				Ptr;									{  -> New value to set property to (and set type to binary) }
		newValueSize:			LONGINT;								{  -> Size of new value }
	END;

	DETSetPropertyChangedBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
		propertyChanged:		BOOLEAN;								{  -> Value to set changed flag on property to }
		filler1:				BOOLEAN;
	END;

	DETSetPropertyEditableBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
		propertyEditable:		BOOLEAN;								{  -> Value to set editable flag on property to }
		filler1:				BOOLEAN;
	END;

	DETDirtyPropertyBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
	END;

	DETDoPropertyCommandBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
		parameter:				LONGINT;								{ ->  Parameter of command }
	END;

	DETSublistCountBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		count:					LONGINT;								{ <-  The number of items in the current item's sublist }
	END;

	DETSelectedSublistCountBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		count:					LONGINT;								{ <-  The number of selected items in the current item's sublist }
	END;

	DETRequestSyncBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
	END;

	DETAddMenuBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
		name:					^RString;								{  -> Name of new menu item }
		parameter:				LONGINT;								{  -> Parameter to return when this item is selected }
		addAfter:				LONGINT;								{  -> Parameter of entry to add after, or -1 for add at end }
	END;

	DETRemoveMenuBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
		itemToRemove:			LONGINT;								{  -> Parameter of menu item to remove }
	END;

	DETMenuItemRStringBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
		itemParameter:			LONGINT;								{  -> Parameter of menu item to return string for }
		rString:				RStringHandle;							{ <-  Handle with the RString (caller must DisposHandle() when done) }
	END;

	DETOpenDSSpecBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		dsSpec:					PackedDSSpecPtr;						{  -> DSSpec of object to be opened }
	END;

	DETAboutToTalkBlock = RECORD
		reqFunction:			DETCallBackFunctions;
	END;

	DETBreakAttributeBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		breakAttribute:			AttributePtr;							{  -> Attribute to parse }
		isChangeable:			BOOLEAN;								{  -> True if the value can be changed by the user }
		filler1:				BOOLEAN;
	END;

	DETSavePropertyBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
	END;

	DETGetCustomViewUserReferenceBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
		userReference:			INTEGER;								{ <-  User reference value, as specified in the .r file }
	END;

	DETGetCustomViewBoundsBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
		bounds:					Rect;									{ <-  Bounds of the view }
	END;

	DETGetResourceBlock = RECORD
		reqFunction:			DETCallBackFunctions;
		target:					DETTargetSpecification;
		property:				INTEGER;
		resourceType:			ResType;								{  -> Resource type }
		theResource:			Handle;									{ <-  The resource handle (caller must dispose when done) }
	END;

	DETTemplateCounts = RECORD
		reqFunction:			DETCallBackFunctions;
		aspectTemplateCount:	LONGINT;								{ <-  Number of aspect templates in the system }
		infoPageTemplateCount:	LONGINT;								{ <-  Number of info-page templates in the system }
	END;

	DETUnloadTemplatesBlock = RECORD
		reqFunction:			DETCallBackFunctions;
	END;

	DETCallBackBlock = RECORD
		CASE INTEGER OF
		0: (
			protoCallBack:				DETProtoCallBackBlock;
		   );
		1: (
			beep:						DETBeepBlock;
		   );
		2: (
			busy:						DETBusyBlock;
		   );
		3: (
			changeCallFors:				DETChangeCallForsBlock;
		   );
		4: (
			getCommandSelectionCount:	DETGetCommandSelectionCountBlock;
		   );
		5: (
			getCommandItemN:			DETGetCommandItemNBlock;
		   );
		6: (
			getDSSpec:					DETGetDSSpecBlock;
		   );
		7: (
			getTemplateFSSpec:			DETGetTemplateFSSpecBlock;
		   );
		8: (
			getOpenEdit:				DETGetOpenEditBlock;
		   );
		9: (
			closeEdit:					DETCloseEditBlock;
		   );
		10: (
			getPropertyType:			DETGetPropertyTypeBlock;
		   );
		11: (
			getPropertyNumber:			DETGetPropertyNumberBlock;
		   );
		12: (
			getPropertyRString:			DETGetPropertyRStringBlock;
		   );
		13: (
			getPropertyBinarySize:		DETGetPropertyBinarySizeBlock;
		   );
		14: (
			getPropertyBinary:			DETGetPropertyBinaryBlock;
		   );
		15: (
			getPropertyChanged:			DETGetPropertyChangedBlock;
		   );
		16: (
			getPropertyEditable:		DETGetPropertyEditableBlock;
		   );
		17: (
			setPropertyType:			DETSetPropertyTypeBlock;
		   );
		18: (
			setPropertyNumber:			DETSetPropertyNumberBlock;
		   );
		19: (
			setPropertyRString:			DETSetPropertyRStringBlock;
		   );
		20: (
			setPropertyBinary:			DETSetPropertyBinaryBlock;
		   );
		21: (
			setPropertyChanged:			DETSetPropertyChangedBlock;
		   );
		22: (
			setPropertyEditable:		DETSetPropertyEditableBlock;
		   );
		23: (
			dirtyProperty:				DETDirtyPropertyBlock;
		   );
		24: (
			doPropertyCommand:			DETDoPropertyCommandBlock;
		   );
		25: (
			sublistCount:				DETSublistCountBlock;
		   );
		26: (
			selectedSublistCount:		DETSelectedSublistCountBlock;
		   );
		27: (
			requestSync:				DETRequestSyncBlock;
		   );
		28: (
			addMenu:					DETAddMenuBlock;
		   );
		29: (
			removeMenu:					DETRemoveMenuBlock;
		   );
		30: (
			menuItemRString:			DETMenuItemRStringBlock;
		   );
		31: (
			openDSSpec:					DETOpenDSSpecBlock;
		   );
		32: (
			aboutToTalk:				DETAboutToTalkBlock;
		   );
		33: (
			breakAttribute:				DETBreakAttributeBlock;
		   );
		34: (
			saveProperty:				DETSavePropertyBlock;
		   );
		35: (
			getCustomViewUserReference:	DETGetCustomViewUserReferenceBlock;
		   );
		36: (
			getCustomViewBounds:		DETGetCustomViewBoundsBlock;
		   );
		37: (
			getResource:				DETGetResourceBlock;
		   );
		38: (
			templateCounts:				DETTemplateCounts;
		   );
		39: (
			unloadTemplates:			DETUnloadTemplatesBlock;
		   );
	END;

	DETCallBackBlockPtr = ^DETCallBackBlock;

	DETCallBackProcPtr = ProcPtr;  { FUNCTION DETCallBack(VAR callBlockPtr: DETCallBlock; callBackBlockPtr: DETCallBackBlockPtr): OSErr; }
	DETCallBackUPP = UniversalProcPtr;

	DETCallBack = DETCallBackUPP;

{ Call functions:

		reqFunction						Action
		-----------						------
		kDETcmdInit						Called once when template is first loaded (good time to allocate private data); returns call-for list
		kDETcmdExit						Called once when template is freed (good time to free private data)

		kDETcmdAttributeCreation		New sublist attribute creation about to occur; this gives the template a chance to modify
										the value that's about to be created; sent to the template that will be used for
										the main aspect of the new entry

		kDETcmdDynamicForwarders		Return a list of dynamically created forwarders

		kDETcmdInstanceInit				Called once when instance of template is started (good time to allocate private instance data)
		kDETcmdInstanceExit				Called once when instance is ended (good time to free private instance data)

		kDETcmdIdle						Called periodically during idle times

		kDETcmdViewListChanged			Called when the info-page view-list (list of enabled views) has changed

		kDETcmdValidateSave				Validate save: about to save info-page, return noErr (or kDETDidNotHandle) if it's OK to do so

		kDETcmdDropQuery				Drop query: return the appropriate operation for this drag; ask destination
		kDETcmdDropMeQuery				Drop query: return the appropriate operation for this drag; ask dropee

		kDETcmdAttributeNew				Attribute value new (return kDETDidNotHandle to let normal new processing occur)
		kDETcmdAttributeChange			Attribute value change (return kDETDidNotHandle to let normal change processing occur)
		kDETcmdAttributeDelete			Attribute value delete (return kDETDidNotHandle to let normal deletion occur); sent to the
										main aspect of the attribute that's about to be deleted
		kDETcmdItemNew					Target item (record or attribute) has just been created

		kDETcmdOpenSelf					Self open (return noErr to prevent opening; return kDETDidNotHandle to allow it)

		kDETcmdDynamicResource			Return a dynamically created resource

		kDETcmdShouldSync				Check if the code resource wants to force a sync (update data from catalog)
		kDETcmdDoSync					Give code resource a chance to sync (read in and break all attributes)

		kDETcmdPropertyCommand			Command received in the property number range (usually means a button's been pushed)

		kDETcmdMaximumTextLength		Return maximum size for text form of property

		kDETcmdPropertyDirtied			Property dirtied, need to redraw

		kDETcmdPatternIn				Custom pattern element encountered on reading in an attribute
		kDETcmdPatternOut				Custom pattern element encountered on writing out an attribute

		kDETcmdConvertToNumber			Convert from template-defined property type to number
		kDETcmdConvertToRString			Convert from template-defined property type to RString
		kDETcmdConvertFromNumber		Convert from number to template-defined property type
		kDETcmdConvertFromRString		Convert from RString to template-defined property type

		kDETcmdCustomViewDraw			Custom view draw
		kDETcmdCustomViewMouseDown		Custom view mouse down

		kDETcmdKeyPress					Key press (used primarily to filter entry into EditText views)
		kDETcmdPaste					Paste (used primarily to filter entry into EditText views)

		kDETcmdCustomMenuSelected		Custom Catalogs menu selected
		kDETcmdCustomMenuEnabled		Return whether custom Catalogs menu entry should be enabled
}

CONST
	kDETcmdSimpleCall			= 0;
	kDETcmdInit					= 1;
	kDETcmdExit					= 2;
	kDETcmdAttributeCreation	= 3;
	kDETcmdDynamicForwarders	= 4;
	kDETcmdTargetedCall			= 1000;
	kDETcmdInstanceInit			= 1001;
	kDETcmdInstanceExit			= 1002;
	kDETcmdIdle					= 1003;
	kDETcmdViewListChanged		= 1004;
	kDETcmdValidateSave			= 1005;
	kDETcmdDropQuery			= 1006;
	kDETcmdDropMeQuery			= 1007;
	kDETcmdAttributeNew			= 1008;
	kDETcmdAttributeChange		= 1009;
	kDETcmdAttributeDelete		= 1010;
	kDETcmdItemNew				= 1011;
	kDETcmdOpenSelf				= 1012;
	kDETcmdDynamicResource		= 1013;
	kDETcmdShouldSync			= 1014;
	kDETcmdDoSync				= 1015;
	kDETcmdPropertyCall			= 2000;
	kDETcmdPropertyCommand		= 2001;
	kDETcmdMaximumTextLength	= 2002;
	kDETcmdPropertyDirtied		= 2003;
	kDETcmdPatternIn			= 2004;
	kDETcmdPatternOut			= 2005;
	kDETcmdConvertToNumber		= 2006;
	kDETcmdConvertToRString		= 2007;
	kDETcmdConvertFromNumber	= 2008;
	kDETcmdConvertFromRString	= 2009;
	kDETcmdCustomViewDraw		= 2010;
	kDETcmdCustomViewMouseDown	= 2011;
	kDETcmdKeyPress				= 2012;
	kDETcmdPaste				= 2013;
	kDETcmdCustomMenuSelected	= 2014;
	kDETcmdCustomMenuEnabled	= 2015;
	kDETcmdHighCall				= $F0000000;					{ Force the type to be long }

	
TYPE
	DETCallFunctions = LONGINT;

	DETProtoCallBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		property:				INTEGER;
	END;

	DETInitBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		newCallFors:			LONGINT;								{ <-  New call-for mask }
	END;

	DETExitBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
	END;

	DETInstanceInitBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
	END;

	DETInstanceExitBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
	END;

	DETInstanceIdleBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
	END;

	DETPropertyCommandBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		property:				INTEGER;
		parameter:				LONGINT;								{  -> Parameter of command }
	END;

	DETMaximumTextLengthBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		property:				INTEGER;
		maxSize:				LONGINT;								{ <-  Return the maximum number of characters the user can entry when property is edited in an EditText }
	END;

	DETViewListChangedBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
	END;

	DETPropertyDirtiedBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		property:				INTEGER;
	END;

	DETValidateSaveBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		errorString:			RStringHandle;							{ <-  Handle with error string if validation fails (callee must allocate handle, DE will DisposHandle() it) }
	END;

{ Valid commandIDs for DETDropQueryBlock and DETDropMeQueryBlock (in addition to property numbers): }

CONST
	kDETDoNothing				= 'xxx0';
	kDETMove					= 'move';
	kDETDrag					= 'drag';
	kDETAlias					= 'alis';


TYPE
	DETDropQueryBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		modifiers:				INTEGER;								{  -> Modifiers at drop time (option/control/command/shift keys) }
		commandID:				LONGINT;								{ <-> Command ID (kDETDoNothing, kDETMove, kDETDrag (copy), kDETAlias, or a property number) }
		destinationType:		AttributeType;							{ <-> Type to convert attribute to }
		copyToHFS:				BOOLEAN;								{ <-  If true, object should be copied to HFS before being operated on, and deleted after }
		filler2:				BOOLEAN;
	END;

	DETDropMeQueryBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		modifiers:				INTEGER;								{  -> Modifiers at drop time (option/control/command/shift keys) }
		commandID:				LONGINT;								{ <-> Command ID (kDETDoNothing, kDETMove, kDETDrag (copy), kDETAlias, or a property number) }
		destinationType:		AttributeType;							{ <-> Type to convert attribute to }
		copyToHFS:				BOOLEAN;								{ <-  If true, object should be copied to HFS before being operated on, and deleted after }
		filler2:				BOOLEAN;
	END;

	DETAttributeCreationBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		parent:					PackedDSSpecPtr;						{  -> The object within which the creation will occur }
		refNum:					INTEGER;								{  -> Refnum for returned address (DSSpecs in PDs only) }
		identity:				AuthIdentity;							{  -> The identity we're browsing as in the parent object }
		attrType:				AttributeType;							{ <-> The type of the attribute being created }
		attrTag:				AttributeTag;							{ <-> The tag of the attribute being created }
		value:					Handle;									{ <-> The value to write (pre-allocated, resize as needed) }
	END;

	DETAttributeNewBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		parent:					PackedDSSpecPtr;						{  -> The object within which the creation will occur }
		refNum:					INTEGER;								{  -> Refnum for returned address (DSSpecs in PDs only) }
		identity:				AuthIdentity;							{  -> The identity we're browsing as in the parent object }
		attrType:				AttributeType;							{ <-> The type of the attribute being created }
		attrTag:				AttributeTag;							{ <-> The tag of the attribute being created }
		value:					Handle;									{ <-> The value to write (pre-allocated, resize as needed) }
	END;

	DETAttributeChangeBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		parent:					PackedDSSpecPtr;						{  -> The object within which the creation will occur }
		refNum:					INTEGER;								{  -> Refnum for returned address (DSSpecs in PDs only) }
		identity:				AuthIdentity;							{  -> The identity we're browsing as in the parent object }
		attrType:				AttributeType;							{ <-> The type of the attribute being changed }
		attrTag:				AttributeTag;							{ <-> The tag of the attribute being changed }
		attrCID:				AttributeCreationID;					{ <-> The CID of the attribute being changed }
		value:					Handle;									{ <-> The value to write (pre-allocated, resize as needed) }
	END;

	DETAttributeDeleteBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		dsSpec:					PackedDSSpecPtr;						{  -> The object which will be deleted }
		refNum:					INTEGER;								{  -> Refnum for returned address (DSSpecs in PDs only) }
		identity:				AuthIdentity;							{  -> The identity we're browsing as }
	END;

	DETItemNewBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
	END;

	DETShouldSyncBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		shouldSync:				BOOLEAN;								{ <-  True if we should now sync with catalog }
		filler2:				BOOLEAN;
	END;

	DETDoSyncBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
	END;

	DETPatternInBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		property:				INTEGER;
		elementType:			LONGINT;								{  -> Element type from pattern }
		extra:					LONGINT;								{  -> Extra field from pattern }
		attribute:				AttributePtr;							{  -> The complete attribute }
		dataOffset:				LONGINT;								{ <-> Offset to current (next) byte }
		bitOffset:				INTEGER;								{ <-> Bit offset (next bit is *fData >> fBitOffset++) }
	END;

	DETPatternOutBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		property:				INTEGER;
		elementType:			LONGINT;								{  -> Element type from pattern }
		extra:					LONGINT;								{  -> Extra field from pattern }
		attribute:				AttributePtr;							{  -> The attribute (minus the data portion) }
		data:					Handle;									{  -> Data to be written (pre-allocated, resize and add at end) }
		dataOffset:				LONGINT;								{ <-> Offset to next byte to write }
		bitOffset:				INTEGER;								{ <-> Bit offset (if zero, handle will need to be resized to one more byte before write) }
	END;

	DETOpenSelfBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		modifiers:				INTEGER;								{  -> Modifiers at open time (option/control/command/shift keys) }
	END;

	DETConvertToNumberBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		property:				INTEGER;
		theValue:				LONGINT;								{ <-  The converted value to return }
	END;

	DETConvertToRStringBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		property:				INTEGER;
		theValue:				RStringHandle;							{ <-  A handle with the converted value (callee must allocate handle, DE will DisposHandle() it) }
	END;

	DETConvertFromNumberBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		property:				INTEGER;
		theValue:				LONGINT;								{  -> The value to convert (result should be written direct to the property) }
	END;

	DETConvertFromRStringBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		property:				INTEGER;
		theValue:				RStringPtr;								{  -> The value to convert (result should be written direct to the property) }
	END;

	DETCustomViewDrawBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		property:				INTEGER;
	END;

	DETCustomViewMouseDownBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		property:				INTEGER;
		theEvent:				^EventRecord;							{  -> The original event record of the mouse-down }
	END;

	DETKeyPressBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		property:				INTEGER;
		theEvent:				^EventRecord;							{  -> The original event record of the key-press }
	END;

	DETPasteBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		property:				INTEGER;
		modifiers:				INTEGER;								{  -> Modifiers at paste time (option/control/command/shift keys) }
	END;

	DETCustomMenuSelectedBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		menuTableParameter:		INTEGER;								{  -> The "property" field from the custom menu table }
	END;

	DETCustomMenuEnabledBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		menuTableParameter:		INTEGER;								{  -> The "property" field from the custom menu table }
		enable:					BOOLEAN;								{ <-  Whether to enable the menu item }
		filler2:				BOOLEAN;
	END;

	DETForwarderListItemPtr = ^DETForwarderListItem;

	DETForwarderListItem = RECORD
		next:					^DETForwarderListItemPtr;				{ Pointer to next item, or nil }
		attributeValueTag:		AttributeTag;							{ Tag of new templates (0 for none) }
		rstrs:					PackedPathName;							{ Record type (empty if none), attrbute type (empty if none),
												list of template names to forward to }
	END;

	DETForwarderListHandle = ^DETForwarderListItemPtr;

	DETDynamicForwardersBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		forwarders:				DETForwarderListHandle;					{ <-  List of forwaders }
	END;

	DETDynamicResourceBlock = RECORD
		reqFunction:			DETCallFunctions;
		callBack:				DETCallBack;
		callBackPrivate:		LONGINT;
		templatePrivate:		LONGINT;
		instancePrivate:		LONGINT;
		target:					DETTargetSpecification;
		targetIsMainAspect:		BOOLEAN;
		filler1:				BOOLEAN;
		resourceType:			ResType;								{  -> The resource type being requested }
		propertyNumber:			INTEGER;								{  -> The property number of the resource being requested }
		resourceID:				INTEGER;								{  -> The resource ID (base ID + property number) of the resource }
		theResource:			Handle;									{ <-  The requested resource }
	END;

	DETCallBlock = RECORD
		CASE INTEGER OF
		0: (
			protoCall:					DETProtoCallBlock;
		   );
		1: (
			init:						DETInitBlock;
		   );
		2: (
			exit:						DETExitBlock;
		   );
		3: (
			instanceInit:				DETInstanceInitBlock;
		   );
		4: (
			instanceExit:				DETInstanceExitBlock;
		   );
		5: (
			instanceIdle:				DETInstanceIdleBlock;
		   );
		6: (
			propertyCommand:			DETPropertyCommandBlock;
		   );
		7: (
			maximumTextLength:			DETMaximumTextLengthBlock;
		   );
		8: (
			viewListChanged:			DETViewListChangedBlock;
		   );
		9: (
			propertyDirtied:			DETPropertyDirtiedBlock;
		   );
		10: (
			validateSave:				DETValidateSaveBlock;
		   );
		11: (
			dropQuery:					DETDropQueryBlock;
		   );
		12: (
			dropMeQuery:				DETDropMeQueryBlock;
		   );
		13: (
			attributeCreationBlock:		DETAttributeCreationBlock;
		   );
		14: (
			attributeNew:				DETAttributeNewBlock;
		   );
		15: (
			attributeChange:			DETAttributeChangeBlock;
		   );
		16: (
			attributeDelete:			DETAttributeDeleteBlock;
		   );
		17: (
			itemNew:					DETItemNewBlock;
		   );
		18: (
			patternIn:					DETPatternInBlock;
		   );
		19: (
			patternOut:					DETPatternOutBlock;
		   );
		20: (
			shouldSync:					DETShouldSyncBlock;
		   );
		21: (
			doSync:						DETDoSyncBlock;
		   );
		22: (
			openSelf:					DETOpenSelfBlock;
		   );
		23: (
			convertToNumber:			DETConvertToNumberBlock;
		   );
		24: (
			convertToRString:			DETConvertToRStringBlock;
		   );
		25: (
			convertFromNumber:			DETConvertFromNumberBlock;
		   );
		26: (
			convertFromRString:			DETConvertFromRStringBlock;
		   );
		27: (
			customViewDraw:				DETCustomViewDrawBlock;
		   );
		28: (
			customViewMouseDown:		DETCustomViewMouseDownBlock;
		   );
		29: (
			keyPress:					DETKeyPressBlock;
		   );
		30: (
			paste:						DETPasteBlock;
		   );
		31: (
			customMenuSelected:			DETCustomMenuSelectedBlock;
		   );
		32: (
			customMenuEnabled:			DETCustomMenuEnabledBlock;
		   );
		33: (
			dynamicForwarders:			DETDynamicForwardersBlock;
		   );
		34: (
			dynamicResource:			DETDynamicResourceBlock;
		   );
	END;

	DETCallBlockPtr = ^DETCallBlock;

CONST
	uppDETCallBackProcInfo = $000003E0; { FUNCTION (4 byte param, 4 byte param): 2 byte result; }

FUNCTION CallDETCallBackProc(VAR callBlockPtr: DETCallBlock; callBackBlockPtr: DETCallBackBlockPtr; userRoutine: DETCallBackUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION NewDETCallBackProc(userRoutine: DETCallBackProcPtr): DETCallBackUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

CONST
	kDETCallForOther			= 1;							{ Call for things not listed below (also auto-enabled by DE if any of the below are enabled) }
	kDETCallForIdle				= 2;							{ kDETcmdIdle }
	kDETCallForCommands			= 4;							{ kDETcmdPropertyCommand, kDETcmdSelfOpen }
	kDETCallForViewChanges		= 8;							{ kDETcmdViewListChanged, kDETcmdPropertyDirtied, kDETcmdMaximumTextLength }
	kDETCallForDrops			= $10;							{ kDETcmdDropQuery, kDETcmdDropMeQuery }
	kDETCallForAttributes		= $20;							{ kDETcmdAttributeCreation, kDETcmdAttributeNew, kDETcmdAttributeChange, kDETcmdAttributeDelete }
	kDETCallForValidation		= $40;							{ kDETcmdValidateSave }
	kDETCallForKeyPresses		= $80;							{ kDETcmdKeyPress and kDETcmdPaste }
	kDETCallForResources		= $100;							{ kDETcmdDynamicResource }
	kDETCallForSyncing			= $200;							{ kDETcmdShouldSync, kDETcmdDoSync }
	kDETCallForEscalation		= $8000;						{ All calls escalated from the next lower level }
	kDETCallForNothing			= 0;							{ None of the above
	* All of the above }
	kDETCallForEverything		= $FFFFFFFF;

TYPE
	DETCallProcPtr = ProcPtr;  { FUNCTION DETCall(callBlockPtr: DETCallBlockPtr): OSErr; }
	DETCallUPP = UniversalProcPtr;

CONST
	uppDETCallProcInfo = $000000E0; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewDETCallProc(userRoutine: DETCallProcPtr): DETCallUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallDETCallProc(callBlockPtr: DETCallBlockPtr; userRoutine: DETCallUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	DETCall = DETCallUPP;

{ This following macro saves you from having to dig out the call-back pointer from the call block: }

CONST
	kSAMFirstDevProperty		= 40 + 10;

{
	SAM templates have additional resources/properties that are required
	for interaction with the AOCE Key Chain.
	
	 Type	Offset						Description
	 ----	------						-----------
	'rstr'	kSAMAspectUserName			The user name
	'rstr'	kSAMAspectKind				The kind of SAM
	'detn'	kSAMAspectCannotDelete		If 0, then the slot cannot be deleted
	'sami'	kSAMAspectSlotCreationInfo	The info required to create a slot record
}
	kSAMAspectUserName			= 40 + 1;
	kSAMAspectKind				= 40 + 2;
	kSAMAspectCannotDelete		= 40 + 3;
	kSAMAspectSlotCreationInfo	= 40 + 4;

{*************************************************************************************
 ********************************* Admin Definitions: *********************************
 *************************************************************************************}
	kDETAdminVersion			= -978;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OCETemplatesIncludes}

{$ENDC} {__OCETEMPLATES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
