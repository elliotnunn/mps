
/*
 *  Mac #includes.c - source to MacHeaders
 *
 *  To add a header, change its "#if 0" to "#if 1".
 *
 *  To remove a header, change its "#if 1" to "#if 0".
 *
 *  There are some conflicts and order dependencies among the various
 *  headers:
 *
 *	•	<Printing.h> and <PrintTraps.h> cannot both be included.
 *
 *	•	<LoMem.h> and <SysEqu.h> cannot both be included.
 *
 *	•	<asm.h> and <Traps.h>, if both are included, must appear
 *		in that order.  If <Traps.h> is included, traps used in
 *		inline assembly must appear without leading underscores.
 *
 *  If the "Check Pointer Types" option is disabled during the
 *  precompilation process, trap definitions will be stored in
 *  such a way that when a trap is called (in a source file that
 *  #includes the precompiled header), pointer arguments to the
 *  trap will not be matched against the types of corresponding
 *  formal parameters.
 *
 *  This is accomplished by storing "simplified" prototypes for
 *  traps, in which any argument of pointer type is stored as
 *  "void *".  The result closely resembles the treatment of traps
 *  in pre-5.0 versions of THINK C.
 *
 *  (Note that this file is written in such a way that it is immune
 *  to the actual compiler setting of "Check Pointer Types".  Use
 *  the "SIMPLIFY_PROTOTYPES" macro, below, to control whether full
 *  prototypes are retained.)
 *
 */

#define OBSOLETE
#define applec
#define _H_MacHeaders


// set this to 0 (zero) to retain full prototypes
// set this to 1 (one) for "simplified" prototypes
#define SIMPLIFY_PROTOTYPES		0


// prototype checking level
#if SIMPLIFY_PROTOTYPES
	#if !__option(check_ptrs)
		#undef SIMPLIFY_PROTOTYPES
	#endif
	#pragma options(!check_ptrs)
#else
	#if __option(check_ptrs)
		#undef SIMPLIFY_PROTOTYPES
	#endif
	#pragma options(check_ptrs)
#endif


// ADSP
	#if 0
		#include <ADSP.h>
	#endif

// AIFF
	#if 0
		#include <AIFF.h>
	#endif

// Aliases
	#if 1
		#include <Aliases.h>
	#endif

// AppleEvents
	#if 1
		#include <AppleEvents.h>
	#endif

// AppleTalk
	#if 0
		#include <AppleTalk.h>
	#endif

// Balloons
	#if 1
		#include <Balloons.h>
	#endif

// CommResources
	#if 0
		#include <CommResources.h>
	#endif

// Components
	#if 1
		#include <Components.h>
	#endif

// Connections
	#if 0
		#include <Connections.h>
	#endif

// ConnectionTools
	#if 0
		#include <ConnectionTools.h>
	#endif

// Controls
	#if 1
		#include <Controls.h>
	#endif

// CRMSerialDevices
	#if 0
		#include <CRMSerialDevices.h>
	#endif

// CTBUtilities
	#if 0
		#include <CTBUtilities.h>
	#endif

// DatabaseAccess
	#if 0
		#include <DatabaseAccess.h>
	#endif

// Desk
	#if 1
		#include <Desk.h>
	#endif

// DeskBus
	#if 0
		#include <DeskBus.h>
	#endif

// Devices
	#if 1
		#include <Devices.h>
	#endif

// Dialogs
	#if 1
		#include <Dialogs.h>
	#endif

// DiskInit
	#if 1
		#include <DiskInit.h>
	#endif

// Disks
	#if 0
		#include <Disks.h>
	#endif

// Editions
	#if 0
		#include <Editions.h>
	#endif

// ENET
	#if 0
		#include <ENET.h>
	#endif

// EPPC
	#if 1
		#include <EPPC.h>
	#endif

// Errors
	#if 1
		#include <Errors.h>
	#endif

// Events
	#if 1
		#include <Events.h>
	#endif

// Files
	#if 1
		#include <Files.h>
	#endif

// FileTransfers
	#if 0
		#include <FileTransfers.h>
	#endif

// FileTransferTools
	#if 0
		#include <FileTransferTools.h>
	#endif

// Finder
	#if 0
		#include <Finder.h>
	#endif

// FixMath
	#if 0
		#include <FixMath.h>
	#endif

// Folders
	#if 1
		#include <Folders.h>
	#endif

// Fonts
	#if 1
		#include <Fonts.h>
	#endif

// GestaltEqu
	#if 1
		#include <GestaltEqu.h>
	#endif

// Graf3D
	#if 0
		#include <Graf3D.h>
	#endif

// HyperXCmd
	#if 0
		#include <HyperXCmd.h>
	#endif

// Icons
	#if 0
		#include <Icons.h>
	#endif

// ImageCompression
	#if 1
		#include <ImageCompression.h>
	#endif

// Language
	#if 0
		#include <Language.h>
	#endif

// Lists
	#if 1
		#include <Lists.h>
	#endif

// Memory
	#if 1
		#include <Memory.h>
	#endif

// Menus
	#if 1
		#include <Menus.h>
	#endif

// MIDI
	#if 0
		#include <MIDI.h>
	#endif

// Movies
	#if 1
		#include <Movies.h>
	#endif

// Notification
	#if 1
		#include <Notification.h>
	#endif

// OSEvents
	#if 1
		#include <OSEvents.h>
	#endif

// OSUtils
	#if 1
		#include <OSUtils.h>
	#endif

// Packages
	#if 1
		#include <Packages.h>
	#endif

// Palette
//	#if 1
//		#include <Palette.h>
//	#endif

// Palettes
	#if 0
		#include <Palettes.h>
	#endif

// Picker
	#if 0
		#include <Picker.h>
	#endif

// PictUtil
	#if 0
		#include <PictUtil.h>
	#endif

// Power
	#if 0
		#include <Power.h>
	#endif

// PPCToolBox
	#if 1
		#include <PPCToolBox.h>
	#endif

// Printing
	#if 1
		#include <Printing.h>
	#endif

// PrintTraps
	#if 0
		#include <PrintTraps.h>
	#endif

// Processes
	#if 1
		#include <Processes.h>
	#endif

// QDOffscreen
	#if 1
		#include <QDOffscreen.h>
	#endif

// Quickdraw
	#if 1
		#include <Quickdraw.h>
	#endif

// Resources
	#if 1
		#include <Resources.h>
	#endif

// Retrace
	#if 0
		#include <Retrace.h>
	#endif

// ROMDefs
	#if 0
		#include <ROMDefs.h>
	#endif

// Scrap
	#if 1
		#include <Scrap.h>
	#endif

// Script
	#if 1
		#include <Script.h>
	#endif

// SCSI
	#if 0
		#include <SCSI.h>
	#endif

// SegLoad
	#if 1
		#include <SegLoad.h>
	#endif

// Serial
	#if 0
		#include <Serial.h>
	#endif

// ShutDown
	#if 0
		#include <ShutDown.h>
	#endif

// Slots
	#if 0
		#include <Slots.h>
	#endif

// Sound
	#if 0
		#include <Sound.h>
	#endif

// SoundInput
	#if 0
		#include <SoundInput.h>
	#endif

// StandardFile
	#if 1
		#include <StandardFile.h>
	#endif

// Start
	#if 0
		#include <Start.h>
	#endif

// SysEqu
	#if 0
		#include <SysEqu.h>
	#endif

// Terminals
	#if 0
		#include <Terminals.h>
	#endif

// TerminalTools
	#if 0
		#include <TerminalTools.h>
	#endif

// TextEdit
	#if 1
		#include <TextEdit.h>
	#endif

// TextServices
	#if 1
		#include <TextServices.h>
	#endif

// Timer
	#if 1
		#include <Timer.h>
	#endif

// ToolUtils
	#if 1
		#include <ToolUtils.h>
	#endif

// Types
	#if 1
		#include <Types.h>
	#endif

// Values
	#if 0
		#include <Values.h>
	#endif

// Video
	#if 0
		#include <Video.h>
	#endif

// Windows
	#if 1
		#include <Windows.h>
	#endif

// pascal.h
	#if 1
		#include <pascal.h>
	#endif

// asm.h
	#if 0
		#include <asm.h>
	#endif

// LoMem
	#if 1
		#include <LoMem.h>
	#endif

// THINK
	#if 1
		#include <THINK.h>
	#endif

// Traps
	#if 1
		#include <Traps.h>
	#endif


// *********************************************
// *********************************************
// *********************************************


// DTS.framework specific includes
	#if 1
		#include <AEUtils.h>
	#endif

	#if 1
		#include <ATUtils.h>
	#endif

	#if 1
		#include <CtlHandler.h>
	#endif

	#if 1
		#include <DTS.Lib.h>
	#endif

	#if 1
		#include <DTS.Lib.protos.h>
	#endif

	#if 1
		#include <GWLayers.h>
	#endif

	#if 1
		#include <ListControl.h>
	#endif

	#if 1
		#include <ListControlProcs.h>
	#endif

	#if 1
		#include <PPC.h>
	#endif

	#if 1
		#include <StringUtils.h>
	#endif

	#if 1
		#include <TextEditControl.h>
	#endif

	#if 1
		#include <TextEditControlProcs.h>
	#endif

	#if 1
		#include <TreeObj.h>
	#endif

	#if 1
		#include <Utilities.h>
	#endif


// *********************************************
// *********************************************
// *********************************************


// restore "Check Pointer Types" to previous setting
#if SIMPLIFY_PROTOTYPES
	#pragma options(check_ptrs)
#elif defined(SIMPLIFY_PROTOTYPES)
	#pragma options(!check_ptrs)
#endif
#undef SIMPLIFY_PROTOTYPES
