{
     File:       AVLTree.p
 
     Contains:   Prototypes for routines which create, destroy, allow for
 
     Version:    Technology: 
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT AVLTree;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __AVLTREE__}
{$SETC __AVLTREE__ := 1}

{$I+}
{$SETC AVLTreeIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{ The visit stage for AVLWalk() walkProcs }

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	AVLVisitStage 				= UInt16;
CONST
	kAVLPreOrder				= 0;
	kAVLInOrder					= 1;
	kAVLPostOrder				= 2;

	{	 The order the tree is walked or disposed of. 	}

TYPE
	AVLOrder 					= UInt16;
CONST
	kLeftToRight				= 0;
	kRightToLeft				= 1;

	{	 The type of the node being passed to a callback proc. 	}

TYPE
	AVLNodeType 				= UInt16;
CONST
	kAVLIsTree					= 0;
	kAVLIsLeftBranch			= 1;
	kAVLIsRightBranch			= 2;
	kAVLIsLeaf					= 3;
	kAVLNullNode				= 4;

	errItemAlreadyInTree		= -960;
	errNotValidTree				= -961;
	errItemNotFoundInTree		= -962;
	errCanNotInsertWhileWalkProcInProgress = -963;
	errTreeIsLocked				= -964;

	{   The structure of a tree.  It's opaque; don't assume it's 36 bytes in size. }

TYPE
	AVLTreeStructPtr = ^AVLTreeStruct;
	AVLTreeStruct = RECORD
		signature:				OSType;
		privateStuff:			ARRAY [0..7] OF UInt32;
	END;

	AVLTreePtr							= ^AVLTreeStruct;
	{
	    Every tree must have a function which compares the data for two items and returns < 0, 0, or >0
	    for the items - < 0 if the first item is 'before' the second item according to some criteria,
	    == 0 if the two items are identical according to the criteria, or > 0 if the first item is
	    'after' the second item according to the criteria.  The comparison function is also passed the
	    node type, but most of the time this can be ignored.
	}
{$IFC TYPED_FUNCTION_POINTERS}
	AVLCompareItemsProcPtr = FUNCTION(tree: AVLTreePtr; i1: UNIV Ptr; i2: UNIV Ptr; nd_typ: AVLNodeType): SInt32;
{$ELSEC}
	AVLCompareItemsProcPtr = ProcPtr;
{$ENDC}

	{
	    Every tree must have a itemSizeProc; this routine gets passed a pointer to the item's data and
	    returns the size of the data.  If a tree contains records of a fixed size, this function can
	    just return sizeof( that-struct ); otherwise it should calculate the size of the item based on
	    the data for the item.
	}
{$IFC TYPED_FUNCTION_POINTERS}
	AVLItemSizeProcPtr = FUNCTION(tree: AVLTreePtr; itemPtr: UNIV Ptr): UInt32;
{$ELSEC}
	AVLItemSizeProcPtr = ProcPtr;
{$ENDC}

	{
	    A tree may have an optional disposeItemProc, which gets called whenever an item is removed
	    from the tree ( via AVLRemove() or when AVLDispose() deletes all of the items in the tree ).
	    This might be useful if the nodes in the tree own 'resources'  ( like, open files ) which
	    should be released before the item is removed.
	}
{$IFC TYPED_FUNCTION_POINTERS}
	AVLDisposeItemProcPtr = PROCEDURE(tree: AVLTreePtr; dataP: UNIV Ptr);
{$ELSEC}
	AVLDisposeItemProcPtr = ProcPtr;
{$ENDC}

	{
	    The common way to iterate across all of the items in a tree is via AVLWalk(), which takes
	    a walkProcPtr.  This function will get called for every item in the tree three times, as
	    the tree is being walked across.  First, the walkProc will get called with visitStage ==
	    kAVLPreOrder, at which point internally the node of the tree for the given data has just
	    been reached.  Later, this function will get called with visitStage == kAVLInOrder, and
	    lastly this function will get called with visitStage == kAVLPostOrder.
	    The 'minimum' item in the tree will get called with visitStage == kInOrder first, followed
	    by the 'next' item in the tree, up until the last item in the tree structure is called.
	    In general, you'll only care about calls to this function when visitStage == kAVLInOrder.
	}
{$IFC TYPED_FUNCTION_POINTERS}
	AVLWalkProcPtr = FUNCTION(tree: AVLTreePtr; dataP: UNIV Ptr; visitStage: AVLVisitStage; node: AVLNodeType; level: UInt32; balance: SInt32; refCon: UNIV Ptr): OSErr;
{$ELSEC}
	AVLWalkProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	AVLCompareItemsUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	AVLCompareItemsUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	AVLItemSizeUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	AVLItemSizeUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	AVLDisposeItemUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	AVLDisposeItemUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	AVLWalkUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	AVLWalkUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppAVLCompareItemsProcInfo = $00002FF0;
	uppAVLItemSizeProcInfo = $000003F0;
	uppAVLDisposeItemProcInfo = $000003C0;
	uppAVLWalkProcInfo = $000FEBE0;
	{
	 *  NewAVLCompareItemsUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewAVLCompareItemsUPP(userRoutine: AVLCompareItemsProcPtr): AVLCompareItemsUPP; { old name was NewAVLCompareItemsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewAVLItemSizeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewAVLItemSizeUPP(userRoutine: AVLItemSizeProcPtr): AVLItemSizeUPP; { old name was NewAVLItemSizeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewAVLDisposeItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewAVLDisposeItemUPP(userRoutine: AVLDisposeItemProcPtr): AVLDisposeItemUPP; { old name was NewAVLDisposeItemProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewAVLWalkUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewAVLWalkUPP(userRoutine: AVLWalkProcPtr): AVLWalkUPP; { old name was NewAVLWalkProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeAVLCompareItemsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeAVLCompareItemsUPP(userUPP: AVLCompareItemsUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeAVLItemSizeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeAVLItemSizeUPP(userUPP: AVLItemSizeUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeAVLDisposeItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeAVLDisposeItemUPP(userUPP: AVLDisposeItemUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeAVLWalkUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeAVLWalkUPP(userUPP: AVLWalkUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeAVLCompareItemsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeAVLCompareItemsUPP(tree: AVLTreePtr; i1: UNIV Ptr; i2: UNIV Ptr; nd_typ: AVLNodeType; userRoutine: AVLCompareItemsUPP): SInt32; { old name was CallAVLCompareItemsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeAVLItemSizeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeAVLItemSizeUPP(tree: AVLTreePtr; itemPtr: UNIV Ptr; userRoutine: AVLItemSizeUPP): UInt32; { old name was CallAVLItemSizeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeAVLDisposeItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeAVLDisposeItemUPP(tree: AVLTreePtr; dataP: UNIV Ptr; userRoutine: AVLDisposeItemUPP); { old name was CallAVLDisposeItemProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeAVLWalkUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeAVLWalkUPP(tree: AVLTreePtr; dataP: UNIV Ptr; visitStage: AVLVisitStage; node: AVLNodeType; level: UInt32; balance: SInt32; refCon: UNIV Ptr; userRoutine: AVLWalkUPP): OSErr; { old name was CallAVLWalkProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
    Create an AVL tree.  The compareItemsProc and the sizeItemProc are required; disposeItemProc is
    optional and can be nil.  The refCon is stored with the list, and is passed back to the
    compareItemsProc, sizeItemProc, and disposeItemsProc calls.  The allocation of the tree ( and all
    nodes later added to the list with AVLInsert ) will be created in what is the current zone at the
    time AVLInit() is called.  Always call AVLDispose() to dispose of a list created with AVLInit().
}
{
 *  AVLInit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AVLInit(flags: UInt32; compareItemsProc: AVLCompareItemsUPP; sizeItemProc: AVLItemSizeUPP; disposeItemProc: AVLDisposeItemUPP; refCon: UNIV Ptr; VAR tree: AVLTreePtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0C01, $AA80;
	{$ENDC}

{
    Dispose of an AVL tree.  This will dispose of each item in the tree in the order specified,
    call the tree's disposeProc proc for each item, and then dispose of the space allocated for
    the tree itself.
}
{
 *  AVLDispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AVLDispose(VAR tree: AVLTreePtr; order: AVLOrder): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0302, $AA80;
	{$ENDC}

{
    Iterate across all of the items in the tree, in the order specified.  kLeftToRight is
    basically lowest-to-highest order, kRightToLeft is highest-to-lowest order.  For each
    node in the tree, it will call the walkProc with three messages ( at the appropriate 
    time ).  First, with kAVLPreOrder when the walking gets to this node in the tree,
    before handling either the left or right subtree, secondly, with kAVLInOrder after
    handling one subtree but before handling the other, and lastly with kAVLPostOrder after
    handling both subtrees.  If you want to handle items in order, then only do something
    if the visit stage is kAVLInOrder.  You can only call AVLRemove() from inside a walkProc
    if visit stage is kAVLPostOrder ( because if you remove a node during the pre or in order
    stages you will corrupt the list ) OR if you return a non-zero result from the walkProc
    call which called AVLRemove() to immediately terminate the walkProc.  Do not call AVLInsert()
    to insert a node into the tree from inside a walkProc.
    The walkProc function gets called with the AVLTreePtr, a pointer to the data for the
    current node ( which you can change in place as long as you do not affect the order within
    the tree ), the visit stage, the type of the current node ( leaf node, right or left branch,
    or full tree ), the level within the tree ( the root is level 1 ), the balance for the
    current node, and the refCon passed to AVLWalk().  This refCon is different from the one passed
    into AVLInit(); use AVLGetRefCon() to get that refCon if you want it inside a walkProc.
    ( Most walkProcs will not care about the values for node type, level, or balance. )
}
{
 *  AVLWalk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AVLWalk(tree: AVLTreePtr; walkProc: AVLWalkUPP; order: AVLOrder; walkRefCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0703, $AA80;
	{$ENDC}

{   Return  the number of items in the given tree. }
{
 *  AVLCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AVLCount(tree: AVLTreePtr; VAR count: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0804, $AA80;
	{$ENDC}

{
    Return the one-based index-th item from the tree by putting it's data at dataPtr
    if dataPtr is non-nil, and it's size into *itemSize if itemSize is non-nil.
    If index is out of range, return errItemNotFoundInTree.  ( Internally, this does
    an AVLWalk(), so the tree can not be modified while this call is in progress ).
}
{
 *  AVLGetIndItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AVLGetIndItem(tree: AVLTreePtr; index: UInt32; dataPtr: UNIV Ptr; VAR itemSize: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0805, $AA80;
	{$ENDC}

{
    Insert the given item into the tree.  This will call the tree's sizeItemProc
    to determine how big the item at data is, and then will make a copy of the
    item and insert it into the tree in the appropriate place.  If an item already
    exists in the tree with the same key ( so that the compareItemsUPP returns 0
    when asked to compare this item to an existing one ), then it will return
    errItemNotFoundInTree.
}
{
 *  AVLInsert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AVLInsert(tree: AVLTreePtr; data: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0406, $AA80;
	{$ENDC}

{
    Remove any item from the tree with the given key.  If dataPtr != nil, then
    copy the item's data to dataPtr before removing it from the tree.  Before
    removing the item, call the tree's disposeItemProc to let it release anything
    used by the data in the tree.  It is not necessary to fill in a complete
    record for key, only that the compareItemsProc return 0 when asked to compare
    the data at key with the node in the tree to be deleted.  If the item cannot
    be found in the tree, this will return errItemNotFoundInTree.
}
{
 *  AVLRemove()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AVLRemove(tree: AVLTreePtr; key: UNIV Ptr; dataPtr: UNIV Ptr; VAR itemSize: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0807, $AA80;
	{$ENDC}

{
    Find the item in the tree with the given key, and return it's data in
    dataPtr ( if dataPtr != nil ), and it's size in *itemSize ( if itemSize
    != nil ).  It is not necessary to fill in a complete record for key,
    only that the compareItemsProc return 0 when asked to compare the data
    at key with the node in the tree to be deleted.  If the item cannot
    be found in the tree, this will return errItemNotFoundInTree.
}
{
 *  AVLFind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AVLFind(tree: AVLTreePtr; key: UNIV Ptr; dataPtr: UNIV Ptr; VAR itemSize: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0808, $AA80;
	{$ENDC}

{
    Get the refCon for the given tree ( set in AVLInit ) and return it.
    If the given tree is invalid, then return nil.
}
{
 *  AVLGetRefcon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AVLGetRefcon(tree: AVLTreePtr; VAR refCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0409, $AA80;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AVLTreeIncludes}

{$ENDC} {__AVLTREE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
