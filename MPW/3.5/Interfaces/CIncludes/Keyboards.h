/*
     File:       Keyboards.h
 
     Contains:   Keyboard API.
 
     Version:    Technology: Keyboard 1.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1997-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __KEYBOARDS__
#define __KEYBOARDS__

#ifndef __MACTYPES__
#include <MacTypes.h>
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

/*——————————————————————————————————————————————————————————————————————————————————*/
/* Keyboard API constants                                                           */
/*——————————————————————————————————————————————————————————————————————————————————*/
/* Keyboard API Trap Number. Should be moved to Traps.i */
enum {
  _KeyboardDispatch             = 0xAA7A
};

/* Gestalt selector and values for the Keyboard API */
enum {
  gestaltKeyboardsAttr          = FOUR_CHAR_CODE('kbds'),
  gestaltKBPS2Keyboards         = 1,
  gestaltKBPS2SetIDToAny        = 2,
  gestaltKBPS2SetTranslationTable = 4
};

/* Keyboard API Error Codes */
/*
   I stole the range blow from the empty space in the Allocation project but should
   be updated to the officially registered range.
*/
enum {
  errKBPS2KeyboardNotAvailable  = -30850,
  errKBIlligalParameters        = -30851,
  errKBFailSettingID            = -30852,
  errKBFailSettingTranslationTable = -30853,
  errKBFailWritePreference      = -30854
};


/* Keyboard HW Layout Types */
enum {
  kKeyboardJIS                  = FOUR_CHAR_CODE('JIS '),
  kKeyboardANSI                 = FOUR_CHAR_CODE('ANSI'),
  kKeyboardISO                  = FOUR_CHAR_CODE('ISO '),
  kKeyboardUnknown              = kUnknownType /* '????'*/
};


/*——————————————————————————————————————————————————————————————————————————————————*/
/* Keyboard API types                                                               */
/*——————————————————————————————————————————————————————————————————————————————————*/



/*——————————————————————————————————————————————————————————————————————————————————*/
/* Keyboard API routines                                                            */
/*——————————————————————————————————————————————————————————————————————————————————*/

#if CALL_NOT_IN_CARBON
/*
 *  KBInitialize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
KBInitialize(void)                                            THREEWORDINLINE(0x303C, 0x0000, 0xAA7A);


/*
 *  KBSetupPS2Keyboard()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
KBSetupPS2Keyboard(
  SInt16   keyboardType,
  SInt8 *  alternativeTable)                                  THREEWORDINLINE(0x303C, 0x0001, 0xAA7A);


/*
 *  KBGetPS2KeyboardID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
KBGetPS2KeyboardID(SInt16 * keyboardType)                     THREEWORDINLINE(0x303C, 0x0002, 0xAA7A);


/*
 *  KBIsPS2KeyboardConnected()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Boolean )
KBIsPS2KeyboardConnected(void)                                THREEWORDINLINE(0x303C, 0x0003, 0xAA7A);


/*
 *  KBIsPS2KeyboardEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Boolean )
KBIsPS2KeyboardEnabled(void)                                  THREEWORDINLINE(0x303C, 0x0004, 0xAA7A);


/*
 *  KBGetPS2KeyboardAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( SInt32 )
KBGetPS2KeyboardAttributes(void)                              THREEWORDINLINE(0x303C, 0x0005, 0xAA7A);


/*
 *  KBSetKCAPForPS2Keyboard()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
KBSetKCAPForPS2Keyboard(Handle kcapHandle)                    THREEWORDINLINE(0x303C, 0x0006, 0xAA7A);


/*
 *  KBSetupPS2KeyboardFromLayoutType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
KBSetupPS2KeyboardFromLayoutType(OSType layoutType)           THREEWORDINLINE(0x303C, 0x0008, 0xAA7A);


/*
 *  KBGetPS2KeyboardLayoutType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
KBGetPS2KeyboardLayoutType(OSType * layoutType)               THREEWORDINLINE(0x303C, 0x0009, 0xAA7A);


#endif  /* CALL_NOT_IN_CARBON */

/*
 *  KBGetLayoutType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSType )
KBGetLayoutType(SInt16 keyboardType)                          THREEWORDINLINE(0x303C, 0x0007, 0xAA7A);




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

#endif /* __KEYBOARDS__ */

