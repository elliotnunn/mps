/*
     File:       GXEnvironment.h
 
     Contains:   QuickDraw GX environment constants and interfaces
 
     Version:    Technology: Quickdraw GX 1.1
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __GXENVIRONMENT__
#define __GXENVIRONMENT__

#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif

#ifndef __MIXEDMODE__
#include <MixedMode.h>
#endif

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#ifndef __GXTYPES__
#include <GXTypes.h>
#endif

#ifndef __CMAPPLICATION__
#include <CMApplication.h>
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

#if defined(__MWERKS__) && TARGET_CPU_68K
    #pragma push
    #pragma pointers_in_D0
#endif
 
/* old header = graphics macintosh */
 
enum {
  defaultPollingHandlerFlags    = 0x00,
  okToSwitchDuringPollFlag      = 0x00,
  dontSwitchDuringPollFlag      = 0x01
};

typedef long                            gxPollingHandlerFlags;
typedef CALLBACK_API_C( void , gxPollingHandlerProcPtr )(long reference, gxPollingHandlerFlags flags);
typedef STACK_UPP_TYPE(gxPollingHandlerProcPtr)                 gxPollingHandlerUPP;
#if CALL_NOT_IN_CARBON
/*
 *  NewgxPollingHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( gxPollingHandlerUPP )
NewgxPollingHandlerUPP(gxPollingHandlerProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppgxPollingHandlerProcInfo = 0x000003C1 };  /* no_return_value Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline gxPollingHandlerUPP NewgxPollingHandlerUPP(gxPollingHandlerProcPtr userRoutine) { return (gxPollingHandlerUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppgxPollingHandlerProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewgxPollingHandlerUPP(userRoutine) (gxPollingHandlerUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppgxPollingHandlerProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  DisposegxPollingHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposegxPollingHandlerUPP(gxPollingHandlerUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposegxPollingHandlerUPP(gxPollingHandlerUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposegxPollingHandlerUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  InvokegxPollingHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
InvokegxPollingHandlerUPP(
  long                   reference,
  gxPollingHandlerFlags  flags,
  gxPollingHandlerUPP    userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void InvokegxPollingHandlerUPP(long reference, gxPollingHandlerFlags flags, gxPollingHandlerUPP userUPP) { CALL_TWO_PARAMETER_UPP(userUPP, uppgxPollingHandlerProcInfo, reference, flags); }
  #else
    #define InvokegxPollingHandlerUPP(reference, flags, userUPP) CALL_TWO_PARAMETER_UPP((userUPP), uppgxPollingHandlerProcInfo, (reference), (flags))
  #endif
#endif

#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON || OLDROUTINENAMES
    /* support for pre-Carbon UPP routines: New...Proc and Call...Proc */
    #define NewgxPollingHandlerProc(userRoutine)                NewgxPollingHandlerUPP(userRoutine)
    #define CallgxPollingHandlerProc(userRoutine, reference, flags) InvokegxPollingHandlerUPP(reference, flags, userRoutine)
#endif /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
/*
 *  GXGetGraphicsPollingHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( gxPollingHandlerUPP )
GXGetGraphicsPollingHandler(long * reference)                 THREEWORDINLINE(0x303C, 0x0245, 0xA832);


/*
 *  GXSetGraphicsPollingHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
GXSetGraphicsPollingHandler(
  gxPollingHandlerUPP   handler,
  long                  reference)                            THREEWORDINLINE(0x303C, 0x0246, 0xA832);


/* old header = graphics toolbox */
 

/* QD to QD GX Translator typedefs */
#endif  /* CALL_NOT_IN_CARBON */

enum {
  gxDefaultOptionsTranslation   = 0x0000,
  gxOptimizedTranslation        = 0x0001,
  gxReplaceLineWidthTranslation = 0x0002,
  gxSimpleScalingTranslation    = 0x0004,
  gxSimpleGeometryTranslation   = 0x0008, /* implies simple scaling */
  gxSimpleLinesTranslation      = 0x000C, /* implies simple geometry & scaling */
  gxLayoutTextTranslation       = 0x0010, /* turn on gxLine layout (normally off) */
  gxRasterTargetTranslation     = 0x0020,
  gxPostScriptTargetTranslation = 0x0040,
  gxVectorTargetTranslation     = 0x0080,
  gxPDDTargetTranslation        = 0x0100,
  gxDontConvertPatternsTranslation = 0x1000,
  gxDontSplitBitmapsTranslation = 0x2000
};

typedef long                            gxTranslationOption;
enum {
  gxContainsFormsBegin          = 0x0001,
  gxContainsFormsEnd            = 0x0002,
  gxContainsPostScript          = 0x0004,
  gxContainsEmptyPostScript     = 0x0008
};

typedef long                            gxTranslationStatistic;
enum {
  gxQuickDrawPictTag            = FOUR_CHAR_CODE('pict')
};

struct gxQuickDrawPict {
                                              /* translator inputs */
  gxTranslationOption  options;
  Rect                srcRect;
  Point               styleStretch;

                                              /* size of quickdraw picture data */
  unsigned long       dataLength;

                                              /* file alias */
  gxBitmapDataSourceAlias  alias;
};
typedef struct gxQuickDrawPict          gxQuickDrawPict;
/* WindowRecord utilities */
#if CALL_NOT_IN_CARBON
/*
 *  GXNewWindowViewPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( gxViewPort )
GXNewWindowViewPort(WindowRef qdWindow)                       THREEWORDINLINE(0x303C, 0x0236, 0xA832);


/*
 *  GXGetWindowViewPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( gxViewPort )
GXGetWindowViewPort(WindowRef qdWindow)                       THREEWORDINLINE(0x303C, 0x0237, 0xA832);


/*
 *  GXGetViewPortWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( WindowRef )
GXGetViewPortWindow(gxViewPort portOrder)                     THREEWORDINLINE(0x303C, 0x0238, 0xA832);


/* GDevice utilities */
/*
 *  GXGetViewDeviceGDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( GDHandle )
GXGetViewDeviceGDevice(gxViewDevice theDevice)                THREEWORDINLINE(0x303C, 0x0239, 0xA832);


/*
 *  GXGetGDeviceViewDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( gxViewDevice )
GXGetGDeviceViewDevice(GDHandle qdGDevice)                    THREEWORDINLINE(0x303C, 0x023A, 0xA832);


/* gxPoint utilities */
/*
 *  GXConvertQDPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
GXConvertQDPoint(
  const Point *  shortPt,
  gxViewPort     portOrder,
  gxPoint *      fixedPt)                                     THREEWORDINLINE(0x303C, 0x023B, 0xA832);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API_C( OSErr , gxShapeSpoolProcPtr )(gxShape toSpool, long refCon);
/* printing utilities typedef */
typedef CALLBACK_API_C( void , gxUserViewPortFilterProcPtr )(gxShape toFilter, gxViewPort portOrder, long refCon);
typedef CALLBACK_API_C( long , gxConvertQDFontProcPtr )(gxStyle dst, long txFont, long txFace);
typedef STACK_UPP_TYPE(gxShapeSpoolProcPtr)                     gxShapeSpoolUPP;
typedef STACK_UPP_TYPE(gxUserViewPortFilterProcPtr)             gxUserViewPortFilterUPP;
typedef STACK_UPP_TYPE(gxConvertQDFontProcPtr)                  gxConvertQDFontUPP;
#if CALL_NOT_IN_CARBON
/*
 *  NewgxShapeSpoolUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( gxShapeSpoolUPP )
NewgxShapeSpoolUPP(gxShapeSpoolProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppgxShapeSpoolProcInfo = 0x000003E1 };  /* 2_bytes Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline gxShapeSpoolUPP NewgxShapeSpoolUPP(gxShapeSpoolProcPtr userRoutine) { return (gxShapeSpoolUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppgxShapeSpoolProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewgxShapeSpoolUPP(userRoutine) (gxShapeSpoolUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppgxShapeSpoolProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewgxUserViewPortFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( gxUserViewPortFilterUPP )
NewgxUserViewPortFilterUPP(gxUserViewPortFilterProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppgxUserViewPortFilterProcInfo = 0x00000FC1 };  /* no_return_value Func(4_bytes, 4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline gxUserViewPortFilterUPP NewgxUserViewPortFilterUPP(gxUserViewPortFilterProcPtr userRoutine) { return (gxUserViewPortFilterUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppgxUserViewPortFilterProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewgxUserViewPortFilterUPP(userRoutine) (gxUserViewPortFilterUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppgxUserViewPortFilterProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewgxConvertQDFontUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( gxConvertQDFontUPP )
NewgxConvertQDFontUPP(gxConvertQDFontProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppgxConvertQDFontProcInfo = 0x00000FF1 };  /* 4_bytes Func(4_bytes, 4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline gxConvertQDFontUPP NewgxConvertQDFontUPP(gxConvertQDFontProcPtr userRoutine) { return (gxConvertQDFontUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppgxConvertQDFontProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewgxConvertQDFontUPP(userRoutine) (gxConvertQDFontUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppgxConvertQDFontProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  DisposegxShapeSpoolUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposegxShapeSpoolUPP(gxShapeSpoolUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposegxShapeSpoolUPP(gxShapeSpoolUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposegxShapeSpoolUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposegxUserViewPortFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposegxUserViewPortFilterUPP(gxUserViewPortFilterUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposegxUserViewPortFilterUPP(gxUserViewPortFilterUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposegxUserViewPortFilterUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposegxConvertQDFontUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposegxConvertQDFontUPP(gxConvertQDFontUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposegxConvertQDFontUPP(gxConvertQDFontUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposegxConvertQDFontUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  InvokegxShapeSpoolUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSErr )
InvokegxShapeSpoolUPP(
  gxShape          toSpool,
  long             refCon,
  gxShapeSpoolUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline OSErr InvokegxShapeSpoolUPP(gxShape toSpool, long refCon, gxShapeSpoolUPP userUPP) { return (OSErr)CALL_TWO_PARAMETER_UPP(userUPP, uppgxShapeSpoolProcInfo, toSpool, refCon); }
  #else
    #define InvokegxShapeSpoolUPP(toSpool, refCon, userUPP) (OSErr)CALL_TWO_PARAMETER_UPP((userUPP), uppgxShapeSpoolProcInfo, (toSpool), (refCon))
  #endif
#endif

/*
 *  InvokegxUserViewPortFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
InvokegxUserViewPortFilterUPP(
  gxShape                  toFilter,
  gxViewPort               portOrder,
  long                     refCon,
  gxUserViewPortFilterUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void InvokegxUserViewPortFilterUPP(gxShape toFilter, gxViewPort portOrder, long refCon, gxUserViewPortFilterUPP userUPP) { CALL_THREE_PARAMETER_UPP(userUPP, uppgxUserViewPortFilterProcInfo, toFilter, portOrder, refCon); }
  #else
    #define InvokegxUserViewPortFilterUPP(toFilter, portOrder, refCon, userUPP) CALL_THREE_PARAMETER_UPP((userUPP), uppgxUserViewPortFilterProcInfo, (toFilter), (portOrder), (refCon))
  #endif
#endif

/*
 *  InvokegxConvertQDFontUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( long )
InvokegxConvertQDFontUPP(
  gxStyle             dst,
  long                txFont,
  long                txFace,
  gxConvertQDFontUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline long InvokegxConvertQDFontUPP(gxStyle dst, long txFont, long txFace, gxConvertQDFontUPP userUPP) { return (long)CALL_THREE_PARAMETER_UPP(userUPP, uppgxConvertQDFontProcInfo, dst, txFont, txFace); }
  #else
    #define InvokegxConvertQDFontUPP(dst, txFont, txFace, userUPP) (long)CALL_THREE_PARAMETER_UPP((userUPP), uppgxConvertQDFontProcInfo, (dst), (txFont), (txFace))
  #endif
#endif

#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON || OLDROUTINENAMES
    /* support for pre-Carbon UPP routines: New...Proc and Call...Proc */
    #define NewgxShapeSpoolProc(userRoutine)                    NewgxShapeSpoolUPP(userRoutine)
    #define NewgxUserViewPortFilterProc(userRoutine)            NewgxUserViewPortFilterUPP(userRoutine)
    #define NewgxConvertQDFontProc(userRoutine)                 NewgxConvertQDFontUPP(userRoutine)
    #define CallgxShapeSpoolProc(userRoutine, toSpool, refCon)  InvokegxShapeSpoolUPP(toSpool, refCon, userRoutine)
    #define CallgxUserViewPortFilterProc(userRoutine, toFilter, portOrder, refCon) InvokegxUserViewPortFilterUPP(toFilter, portOrder, refCon, userRoutine)
    #define CallgxConvertQDFontProc(userRoutine, dst, txFont, txFace) InvokegxConvertQDFontUPP(dst, txFont, txFace, userRoutine)
#endif /* CALL_NOT_IN_CARBON */


typedef gxShapeSpoolProcPtr             gxShapeSpoolFunction;
typedef gxUserViewPortFilterProcPtr     gxUserViewPortFilter;
typedef gxConvertQDFontProcPtr          gxConvertQDFontFunction;
/* mouse utilities */
/* return mouse location in fixed-gxPoint global space */
#if CALL_NOT_IN_CARBON
/*
 *  GXGetGlobalMouse()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
GXGetGlobalMouse(gxPoint * globalPt)                          THREEWORDINLINE(0x303C, 0x023C, 0xA832);


/* return fixed-gxPoint local mouse (gxViewPort == 0 --> default) */
/*
 *  GXGetViewPortMouse()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
GXGetViewPortMouse(
  gxViewPort   portOrder,
  gxPoint *    localPt)                                       THREEWORDINLINE(0x303C, 0x023D, 0xA832);


/* printing utilities */
/*
 *  GXGetViewPortFilter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( gxUserViewPortFilterUPP )
GXGetViewPortFilter(
  gxViewPort   portOrder,
  long *       refCon)                                        THREEWORDINLINE(0x303C, 0x025E, 0xA832);


/*
 *  GXSetViewPortFilter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
GXSetViewPortFilter(
  gxViewPort                portOrder,
  gxUserViewPortFilterUPP   filter,
  long                      refCon)                           THREEWORDINLINE(0x303C, 0x023E, 0xA832);


/* QD to QD GX Translator functions */
/*
 *  GXInstallQDTranslator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
GXInstallQDTranslator(
  GrafPtr               port,
  gxTranslationOption   options,
  const Rect *          srcRect,
  const Rect *          dstRect,
  Point                 styleStrech,
  gxShapeSpoolUPP       userFunction,
  void *                reference)                            THREEWORDINLINE(0x303C, 0x023F, 0xA832);


/*
 *  GXRemoveQDTranslator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( gxTranslationStatistic )
GXRemoveQDTranslator(
  GrafPtr                   port,
  gxTranslationStatistic *  statistic)                        THREEWORDINLINE(0x303C, 0x0240, 0xA832);


/*
 *  GXConvertPICTToShape()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( gxShape )
GXConvertPICTToShape(
  PicHandle                 pict,
  gxTranslationOption       options,
  const Rect *              srcRect,
  const Rect *              dstRect,
  Point                     styleStretch,
  gxShape                   destination,
  gxTranslationStatistic *  stats)                            THREEWORDINLINE(0x303C, 0x0241, 0xA832);


/* Find the best GX style given a QD font and face. Called by the QD->GX translator */
/*
 *  GXConvertQDFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( long )
GXConvertQDFont(
  gxStyle   theStyle,
  long      txFont,
  long      txFace)                                           THREEWORDINLINE(0x303C, 0x0242, 0xA832);


/*
 *  GXGetConvertQDFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( gxConvertQDFontUPP )
GXGetConvertQDFont(void)                                      THREEWORDINLINE(0x303C, 0x0243, 0xA832);


/*
 *  GXSetConvertQDFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
GXSetConvertQDFont(gxConvertQDFontUPP userFunction)           THREEWORDINLINE(0x303C, 0x0244, 0xA832);


#endif  /* CALL_NOT_IN_CARBON */

typedef unsigned long                   gxProfilePoolAttributes;
struct gxFlatProfileListItem {
  gxProfilePoolAttributes  attributes;        /* information about this particular profile's source*/
  CMProfileRef        profileRef;             /* reference to profile, only valid before shape is disposed*/
  CMProfileIdentifier  identifier;            /* information on how to find the profile upon unflattening*/
};
typedef struct gxFlatProfileListItem    gxFlatProfileListItem;

 
#if defined(__MWERKS__) && TARGET_CPU_68K
    #pragma pop
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

#endif /* __GXENVIRONMENT__ */

