//#define TARGET_API_MAC_CARBON 1
#define COMPILING_CARBONLIB 1
#if defined(__APPLE_CC__) && __APPLE_CC__
#include <Carbon/Carbon.h>
#else
//#include <Carbon.h>
#include "CarbonHeadersPCH"
#endif