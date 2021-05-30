{
     File:       CFTree.p
 
     Contains:   CoreFoundation tree collection
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CFTree;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFTREE__}
{$SETC __CFTREE__ := 1}

{$I+}
{$SETC CFTreeIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	CFTreeRetainCallBack = FUNCTION(info: UNIV Ptr): Ptr; C;
{$ELSEC}
	CFTreeRetainCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFTreeReleaseCallBack = PROCEDURE(info: UNIV Ptr); C;
{$ELSEC}
	CFTreeReleaseCallBack = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CFTreeCopyDescriptionCallBack = FUNCTION(info: UNIV Ptr): CFStringRef; C;
{$ELSEC}
	CFTreeCopyDescriptionCallBack = ProcPtr;
{$ENDC}

	CFTreeContextPtr = ^CFTreeContext;
	CFTreeContext = RECORD
		version:				CFIndex;
		info:					Ptr;
		retain:					CFTreeRetainCallBack;
		release:				CFTreeReleaseCallBack;
		copyDescription:		CFTreeCopyDescriptionCallBack;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	CFTreeApplierFunction = PROCEDURE(value: UNIV Ptr; context: UNIV Ptr); C;
{$ELSEC}
	CFTreeApplierFunction = ProcPtr;
{$ENDC}

	CFTreeRef    = ^LONGINT; { an opaque 32-bit type }
	CFTreeRefPtr = ^CFTreeRef;  { when a VAR xx:CFTreeRef parameter can be nil, it is changed to xx: CFTreeRefPtr }
	{
	 *  CFTreeGetTypeID()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFTreeGetTypeID: CFTypeID; C;

{
 *  CFTreeCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFTreeCreate(allocator: CFAllocatorRef; {CONST}VAR context: CFTreeContext): CFTreeRef; C;

{
 *  CFTreeGetParent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFTreeGetParent(tree: CFTreeRef): CFTreeRef; C;

{
 *  CFTreeGetNextSibling()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFTreeGetNextSibling(tree: CFTreeRef): CFTreeRef; C;

{
 *  CFTreeGetFirstChild()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFTreeGetFirstChild(tree: CFTreeRef): CFTreeRef; C;

{
 *  CFTreeGetContext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFTreeGetContext(tree: CFTreeRef; VAR context: CFTreeContext); C;

{
 *  CFTreeGetChildCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFTreeGetChildCount(tree: CFTreeRef): CFIndex; C;

{
 *  CFTreeGetChildAtIndex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFTreeGetChildAtIndex(tree: CFTreeRef; idx: CFIndex): CFTreeRef; C;

{
 *  CFTreeGetChildren()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFTreeGetChildren(tree: CFTreeRef; VAR children: CFTreeRef); C;

{
 *  CFTreeApplyFunctionToChildren()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFTreeApplyFunctionToChildren(tree: CFTreeRef; applier: CFTreeApplierFunction; context: UNIV Ptr); C;

{
 *  CFTreeFindRoot()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFTreeFindRoot(tree: CFTreeRef): CFTreeRef; C;

{
 *  CFTreeSetContext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFTreeSetContext(tree: CFTreeRef; {CONST}VAR context: CFTreeContext); C;

{ adds newChild as tree's first child }
{
 *  CFTreePrependChild()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFTreePrependChild(tree: CFTreeRef; newChild: CFTreeRef); C;

{ adds newChild as tree's last child }
{
 *  CFTreeAppendChild()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFTreeAppendChild(tree: CFTreeRef; newChild: CFTreeRef); C;

{ Inserts newSibling after tree.  tree and newSibling will have the same parent }
{
 *  CFTreeInsertSibling()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFTreeInsertSibling(tree: CFTreeRef; newSibling: CFTreeRef); C;

{ Removes tree from its parent }
{
 *  CFTreeRemove()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFTreeRemove(tree: CFTreeRef); C;

{ Removes all the children of tree }
{
 *  CFTreeRemoveAllChildren()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFTreeRemoveAllChildren(tree: CFTreeRef); C;

{
 *  CFTreeSortChildren()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFTreeSortChildren(tree: CFTreeRef; comparator: CFComparatorFunction; context: UNIV Ptr); C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFTreeIncludes}

{$ENDC} {__CFTREE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
