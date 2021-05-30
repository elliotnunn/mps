/*
     File:       CFTree.h
 
     Contains:   CoreFoundation tree collection
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __CFTREE__
#define __CFTREE__

#ifndef __CFBASE__
#include <CFBase.h>
#endif




#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
    #pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
    #pragma pack(2)
#endif

typedef CALLBACK_API_C( const void *, CFTreeRetainCallBack )(const void * info);
typedef CALLBACK_API_C( void , CFTreeReleaseCallBack )(const void * info);
typedef CALLBACK_API_C( CFStringRef , CFTreeCopyDescriptionCallBack )(const void * info);
struct CFTreeContext {
  CFIndex             version;
  void *              info;
  CFTreeRetainCallBack  retain;
  CFTreeReleaseCallBack  release;
  CFTreeCopyDescriptionCallBack  copyDescription;
};
typedef struct CFTreeContext            CFTreeContext;
typedef CALLBACK_API_C( void , CFTreeApplierFunction )(const void *value, void *context);
typedef struct __CFTree*                CFTreeRef;
/*
 *  CFTreeGetTypeID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTypeID )
CFTreeGetTypeID(void);


/*
 *  CFTreeCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTreeRef )
CFTreeCreate(
  CFAllocatorRef         allocator,
  const CFTreeContext *  context);


/*
 *  CFTreeGetParent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTreeRef )
CFTreeGetParent(CFTreeRef tree);


/*
 *  CFTreeGetNextSibling()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTreeRef )
CFTreeGetNextSibling(CFTreeRef tree);


/*
 *  CFTreeGetFirstChild()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTreeRef )
CFTreeGetFirstChild(CFTreeRef tree);


/*
 *  CFTreeGetContext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFTreeGetContext(
  CFTreeRef        tree,
  CFTreeContext *  context);


/*
 *  CFTreeGetChildCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFIndex )
CFTreeGetChildCount(CFTreeRef tree);


/*
 *  CFTreeGetChildAtIndex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTreeRef )
CFTreeGetChildAtIndex(
  CFTreeRef   tree,
  CFIndex     idx);


/*
 *  CFTreeGetChildren()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFTreeGetChildren(
  CFTreeRef    tree,
  CFTreeRef *  children);


/*
 *  CFTreeApplyFunctionToChildren()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFTreeApplyFunctionToChildren(
  CFTreeRef               tree,
  CFTreeApplierFunction   applier,
  void *                  context);


/*
 *  CFTreeFindRoot()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTreeRef )
CFTreeFindRoot(CFTreeRef tree);


/*
 *  CFTreeSetContext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFTreeSetContext(
  CFTreeRef              tree,
  const CFTreeContext *  context);


/* adds newChild as tree's first child */
/*
 *  CFTreePrependChild()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFTreePrependChild(
  CFTreeRef   tree,
  CFTreeRef   newChild);


/* adds newChild as tree's last child */
/*
 *  CFTreeAppendChild()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFTreeAppendChild(
  CFTreeRef   tree,
  CFTreeRef   newChild);


/* Inserts newSibling after tree.  tree and newSibling will have the same parent */
/*
 *  CFTreeInsertSibling()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFTreeInsertSibling(
  CFTreeRef   tree,
  CFTreeRef   newSibling);


/* Removes tree from its parent */
/*
 *  CFTreeRemove()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFTreeRemove(CFTreeRef tree);


/* Removes all the children of tree */
/*
 *  CFTreeRemoveAllChildren()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFTreeRemoveAllChildren(CFTreeRef tree);


/*
 *  CFTreeSortChildren()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFTreeSortChildren(
  CFTreeRef              tree,
  CFComparatorFunction   comparator,
  void *                 context);



#if PRAGMA_STRUCT_ALIGN
    #pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
    #pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __CFTREE__ */

