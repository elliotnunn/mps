/*
     File:       CGBase.h
 
     Contains:   xxx put contents here xxx
 
     Version:    Technology: from CoreGraphics-70.root
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __CGBASE__
#define __CGBASE__

#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif

#include <stddef.h>
#if __MWERKS__ > 0x2300 
#include <stdint.h>
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

/* if stdint.h has been include, don't define same types */
#if __MWERKS__ <= 0x2300
typedef signed long                     int32_t;
#endif
/* define some unix types used by CoreGraphics */
typedef int                             boolean_t;
typedef unsigned char                   u_int8_t;
typedef unsigned short                  u_int16_t;
typedef unsigned long                   u_int32_t;

#if !defined(CG_INLINE)
#  if defined(__GNUC__)
#    define CG_INLINE static __inline__
#  elif defined(__MWERKS__)
#    define CG_INLINE static inline
#  else
#    define CG_INLINE static    
#  endif
#endif


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

#endif /* __CGBASE__ */

