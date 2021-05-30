/*
     File:       CGBitmapContext.h
 
     Contains:   xxx put contents here xxx
 
     Version:    Technology: from CoreGraphics-70.root
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __CGBITMAPCONTEXT__
#define __CGBITMAPCONTEXT__

#ifndef __CGBASE__
#include <CGBase.h>
#endif

#ifndef __CGCONTEXT__
#include <CGContext.h>
#endif




/* Create a bitmap context.  The context draws into a bitmap which is
 * `width' pixels wide and `height' pixels high.  The number of components
 * for each pixel is specified by `colorspace', which also may specify a
 * destination color profile. The number of bits for each component of a
 * pixel is specified by `bitsPerComponent', which must be 1, 2, 4, or 8.
 * Each row of the bitmap consists of `bytesPerRow' bytes, which must be at
 * least `(width * bitsPerComponent * number of components + 7)/8' bytes.
 * `data' points a block of memory at least `bytesPerRow * height' bytes.
 * `alphaInfo' specifies whether the bitmap should contain an alpha
 * channel, and how it's to be generated. */


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

/*
 *  CGBitmapContextCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CGContextRef )
CGBitmapContextCreate(
  void *             data,
  size_t             width,
  size_t             height,
  size_t             bitsPerComponent,
  size_t             bytesPerRow,
  CGColorSpaceRef    colorspace,
  CGImageAlphaInfo   alphaInfo);



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

#endif /* __CGBITMAPCONTEXT__ */

