/*------------------------------------------------------------------------------

FILE
	 Stubs.c - Stubs for runtime library routines not used by MPW tools


DESCRIPTION
	 This file provides stubs for several routines defined in the runtine
	 library that aren't necessary in MPW tools.  These routines are 
	 referenced by the Standard C Library I/O functions, but are never called.
	 Because they are referenced, the linker can't remove them.  The stubs in
	 this file provide dummy routines which are never called, but reduce the
	 size of the tool.

COPYRIGHT
	 Copyright Apple Computer, Inc. 1986
	 All rights reserved.


------------------------------------------------------------------------------*/



/* Console Driver

   These drivers provide I/O to the screen (or a specified port) in
   applications.  They aren't necessary in tools.  
*/

_coFAccess() {}
_coClose() {}
_coRead() {}
_coWrite() {}
_coIoctl() {}
_coExit() {}


/* File System Driver

   Tools use the file system drivers linked with the MPW Shell.
*/

_fsFAccess() {}
_fsClose() {}
_fsRead() {}
_fsWrite() {}
_fsIoctl() {}
_fsExit() {}


/* System Driver

   Tools use the system drivers linked with the MPW Shell.
*/

_syFAccess() {}
_syClose() {}
_syRead() {}
_syWrite() {}
_syIoctl() {}
_syExit() {}


/* Floating Point Conversion Routines

   These routines, called by printf, are only necessary if floating point
   formatting is used.
*/

ecvt() {}
fcvt() {}
