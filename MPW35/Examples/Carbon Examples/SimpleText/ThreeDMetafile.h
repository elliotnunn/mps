/*
	File:		ThreeDMetafile.h

	Contains:	3D viewer support for SimpleText

    Version:	Mac OS X

	Disclaimer:	IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc.
				("Apple") in consideration of your agreement to the following terms, and your
				use, installation, modification or redistribution of this Apple software
				constitutes acceptance of these terms.  If you do not agree with these terms,
				please do not use, install, modify or redistribute this Apple software.

				In consideration of your agreement to abide by the following terms, and subject
				to these terms, Apple grants you a personal, non-exclusive license, under Apple’s
				copyrights in this original Apple software (the "Apple Software"), to use,
				reproduce, modify and redistribute the Apple Software, with or without
				modifications, in source and/or binary forms; provided that if you redistribute
				the Apple Software in its entirety and without modifications, you must retain
				this notice and the following text and disclaimers in all such redistributions of
				the Apple Software.  Neither the name, trademarks, service marks or logos of
				Apple Computer, Inc. may be used to endorse or promote products derived from the
				Apple Software without specific prior written permission from Apple.  Except as
				expressly stated in this notice, no other rights or licenses, express or implied,
				are granted by Apple herein, including but not limited to any patent rights that
				may be infringed by your derivative works or by other works in which the Apple
				Software may be incorporated.

				The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO
				WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED
				WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
				PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
				COMBINATION WITH YOUR PRODUCTS.

				IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR
				CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
				GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
				ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION
				OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT
				(INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN
				ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

	Copyright © 1994-2001 Apple Computer, Inc., All Rights Reserved
*/

#include "SimpleText.h"


#define kThreeDWindowID	kThreeDBaseID


#ifndef REZ
	typedef long ViewerObject;

	struct ThreeDDataRecord
		{
		WindowDataRecord		w;
		
		ViewerObject			viewerObject;
		};
	typedef struct ThreeDDataRecord ThreeDDataRecord, *ThreeDDataPtr;	

	enum {
		kQ3ViewerShowBadge 			= 1<<0,
		kQ3ViewerActive				= 1<<1,
		kQ3ViewerControllerVisible	= 1<<2,
		kQ3ViewerDrawFrame			= 1<<3,
		kQ3ViewerDraggingOff		= 1<<4,
		
		kQ3ViewerButtonCamera		= 1<<5,
		kQ3ViewerButtonTruck		= 1<<6,
		kQ3ViewerButtonOrbit		= 1<<7,
		kQ3ViewerButtonZoom			= 1<<8,
		kQ3ViewerButtonDolly		= 1<<9,
		
	
		kQ3ViewerDefault = (
					kQ3ViewerActive        | kQ3ViewerControllerVisible | 
					kQ3ViewerButtonCamera  | kQ3ViewerButtonTruck       | 
					kQ3ViewerButtonOrbit   | kQ3ViewerButtonDolly )
	};

	enum {
		uppViewerLibNewProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(Ptr)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(CGrafPtr)))
			 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Rect*)))
			 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long))),
		uppViewerLibDisposeProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Ptr))),

		uppViewerLibUseFileProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject)))
			 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long))),
		uppViewerLibUseDataProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject)))
			 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*)))
			 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long))),

		uppViewerLibWriteFileProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject)))
			 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long))),
		uppViewerLibWriteDataProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(unsigned long)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject)))
			 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void**))),

		uppViewerLibDrawProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject))),

		uppViewerLibGetPictProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(PicHandle)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject))),
		uppViewerLibGetButtonRectProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject)))
			 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(unsigned long)))
			 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(Rect*))),

		uppViewerLibGetDimensionProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject)))
			 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long*)))
			 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long*))),

		uppViewerLibSetFlagsProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject)))
			 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(unsigned long))),
		uppViewerLibGetFlagsProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(unsigned long)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject))),

		uppViewerLibSetBoundsProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject)))
			 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Rect*))),
		uppViewerLibGetBoundsProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject)))
			 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Rect*))),

		uppViewerLibSetPortProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject)))
			 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(CGrafPtr))),
		uppViewerLibGetPortProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(CGrafPtr)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject))),

		uppViewerLibEventProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject)))
			 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(EventRecord*))),
		uppViewerLibAdjustCursorProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject)))
			 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Point*))),

		uppViewerLibGetStateProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(unsigned long)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject))),

		uppViewerLibClearProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject))),
		uppViewerLibCutProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject))),
		uppViewerLibCopyProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject))),
		uppViewerLibPasteProcInfo = kCStackBased
			 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ViewerObject)))

		};
		
	// Proc pointer typedefs
	typedef ViewerObject (*ViewerLib_NewType) (CGrafPtr port,  Rect *rect,  unsigned long flags);
	typedef OSErr (*ViewerLib_DisposeType) (ViewerObject theViewer);

	typedef OSErr (*ViewerLib_UseFileType) (ViewerObject theViewer, long refNum);
	typedef OSErr (*ViewerLib_UseDataType)  (ViewerObject theViewer, void *data, long size);

	typedef OSErr (*ViewerLib_WriteFileType) (ViewerObject theViewer, long refNum);
	typedef unsigned long (*ViewerLib_WriteDataType)  (ViewerObject theViewer, void **data);

	typedef OSErr (*ViewerLib_DrawType) (ViewerObject theViewer);

	typedef PicHandle (*ViewerLib_GetPictType) (ViewerObject theViewer);
	typedef OSErr     (*ViewerLib_GetButtonRectType) (ViewerObject theViewer, unsigned long button, Rect *rect);

	typedef OSErr (*ViewerLib_GetDimensionType) (ViewerObject theViewer, long *width, long* height);
	
	typedef OSErr (*ViewerLib_SetFlagsType) (ViewerObject theViewer, unsigned long flags);
	typedef unsigned long (*ViewerLib_GetFlagsType) (ViewerObject theViewer);

	typedef OSErr (*ViewerLib_SetBoundsType) (ViewerObject theViewer, Rect *bounds);
	typedef OSErr (*ViewerLib_GetBoundsType) (ViewerObject theViewer, Rect *bounds);

	typedef OSErr (*ViewerLib_SetPortType) (ViewerObject theViewer, CGrafPtr port);
	typedef CGrafPtr (*ViewerLib_GetPortType) (ViewerObject theViewer);

	typedef Boolean (*ViewerLib_EventType) (ViewerObject theViewer, EventRecord *evt);
	typedef Boolean (*ViewerLib_AdjustCursorType) (ViewerObject theViewer, Point *pt);

	typedef unsigned long (*ViewerLib_GetStateType) (ViewerObject theViewer);

	typedef OSErr (*ViewerLib_ClearType) (ViewerObject theViewer);
	typedef OSErr (*ViewerLib_CutType) (ViewerObject theViewer);
	typedef OSErr (*ViewerLib_CopyType) (ViewerObject theViewer);
	typedef OSErr (*ViewerLib_PasteType) (ViewerObject theViewer);


	typedef struct
		{
		ProcInfoType		info;
		void				*entry;
		} GlobalEntry;
		
	// Macro calls
	#if TARGET_RT_MAC_CFM
		#define ViewerLib_New(A,B,C) CallUniversalProc(gProcPointers[0].entry, uppViewerLibNewProcInfo, A, B, C)
		#define ViewerLib_Dispose(A) CallUniversalProc(gProcPointers[1].entry, uppViewerLibDisposeProcInfo, A)
		
		#define ViewerLib_UseFile(A,B) CallUniversalProc(gProcPointers[2].entry, uppViewerLibUseFileProcInfo, A, B)
		#define ViewerLib_UseData(A,B,C) CallUniversalProc(gProcPointers[3].entry, uppViewerLibUseDataProcInfo, A, B, C)
	
		#define ViewerLib_WriteFile(A,B) CallUniversalProc(gProcPointers[4].entry, uppViewerLibWriteFileProcInfo, A, B)
		#define ViewerLib_WriteData(A,B) CallUniversalProc(gProcPointers[5].entry, uppViewerLibWriteDataProcInfo, A, B)
		
		#define ViewerLib_Draw(A) CallUniversalProc(gProcPointers[6].entry, uppViewerLibDrawProcInfo, A)
	
		#define ViewerLib_GetPict(A) CallUniversalProc(gProcPointers[7].entry, uppViewerLibGetPictProcInfo, A)
		#define ViewerLib_GetButtonRect(A,B,C) CallUniversalProc(gProcPointers[8].entry, uppViewerLibGetButtonRectProcInfo, A,B,C)
	
		#define ViewerLib_GetDimension(A,B,C) CallUniversalProc(gProcPointers[9].entry, uppViewerLibGetDimensionProcInfo, A,B,C)
		
		#define ViewerLib_SetFlags(A,B) CallUniversalProc(gProcPointers[10].entry, uppViewerLibSetFlagsProcInfo, A, B)
		#define ViewerLib_GetFlags(A) CallUniversalProc(gProcPointers[11].entry, uppViewerLibGetFlagsProcInfo, A)
	
		#define ViewerLib_SetBounds(A,B) CallUniversalProc(gProcPointers[12].entry, uppViewerLibSetBoundsProcInfo, A, B)
		#define ViewerLib_GetBounds(A,B) CallUniversalProc(gProcPointers[13].entry, uppViewerLibGetBoundsProcInfo, A, B)
	
		#define ViewerLib_SetPort(A,B) CallUniversalProc(gProcPointers[14].entry, uppViewerLibSetPortProcInfo, A, B)
		#define ViewerLib_GetPort(A) CallUniversalProc(gProcPointers[15].entry, uppViewerLibGetPortProcInfo, A)
	
		#define ViewerLib_Event(A,B) CallUniversalProc(gProcPointers[16].entry, uppViewerLibEventProcInfo, A, B)
		#define ViewerLib_AdjustCursor(A,B) CallUniversalProc(gProcPointers[17].entry, uppViewerLibAdjustCursorProcInfo, A, B)
	
		#define ViewerLib_GetState(A) CallUniversalProc(gProcPointers[18].entry, uppViewerLibGetStateProcInfo, A)
	
		#define ViewerLib_Clear(A) CallUniversalProc(gProcPointers[19].entry, uppViewerLibClearProcInfo, A)
		#define ViewerLib_Cut(A) CallUniversalProc(gProcPointers[20].entry, uppViewerLibCutProcInfo, A)
		#define ViewerLib_Copy(A) CallUniversalProc(gProcPointers[21].entry, uppViewerLibCopyProcInfo, A)
		#define ViewerLib_Paste(A) CallUniversalProc(gProcPointers[22].entry, uppViewerLibPasteProcInfo, A)
	#else
		#define ViewerLib_New(A,B,C) (*(ViewerLib_NewType)(gProcPointers[0].entry)) (A, B, C)
		#define ViewerLib_Dispose(A) (*(ViewerLib_DisposeType)(gProcPointers[1].entry)) (A)
		
		#define ViewerLib_UseFile(A,B) (*(ViewerLib_UseFileType)(gProcPointers[2].entry)) (A, B)
		#define ViewerLib_UseData(A,B,C) (*(ViewerLib_UseDataType)(gProcPointers[3].entry)) (A, B, C)
	
		#define ViewerLib_WriteFile(A,B) (*(ViewerLib_WriteFileType)(gProcPointers[4].entry)) (A, B)
		#define ViewerLib_WriteData(A,B) (*(ViewerLib_WriteDataType)(gProcPointers[5].entry)) (A, B)
		
		#define ViewerLib_Draw(A) (*(ViewerLib_DrawType)(gProcPointers[6].entry)) (A)
	
		#define ViewerLib_GetPict(A) (*(ViewerLib_GetPictType)(gProcPointers[7].entry)) (A)
		#define ViewerLib_GetButtonRect(A,B,C) (*(ViewerLib_GetButtonRectType)(gProcPointers[8].entry)) (A,B,C)
	
		#define ViewerLib_GetDimension(A,B,C) (*(ViewerLib_GetDimensionType)(gProcPointers[9].entry)) (A,B,C)
		
		#define ViewerLib_SetFlags(A,B) (*(ViewerLib_SetFlagsType)(gProcPointers[10].entry)) (A, B)
		#define ViewerLib_GetFlags(A) (*(ViewerLib_GetFlagsType)(gProcPointers[11].entry)) (A)
	
		#define ViewerLib_SetBounds(A,B) (*(ViewerLib_SetBoundsType)(gProcPointers[12].entry)) (A, B)
		#define ViewerLib_GetBounds(A,B) (*(ViewerLib_GetBoundsType)(gProcPointers[13].entry)) (A, B)
	
		#define ViewerLib_SetPort(A,B) (*(ViewerLib_SetPortType)(gProcPointers[14].entry)) (A, B)
		#define ViewerLib_GetPort(A) (*(ViewerLib_GetPortType)(gProcPointers[15].entry)) (A)
	
		#define ViewerLib_Event(A,B) (*(ViewerLib_EventType)(gProcPointers[16].entry)) (A, B)
		#define ViewerLib_AdjustCursor(A,B) (*(ViewerLib_AdjustCursorType)(gProcPointers[17].entry)) (A, B)
	
		#define ViewerLib_GetState(A) (*(ViewerLib_GetStateType)(gProcPointers[18].entry)) (A)
	
		#define ViewerLib_Clear(A) (*(ViewerLib_ClearType)(gProcPointers[19].entry)) (A)
		#define ViewerLib_Cut(A) (*(ViewerLib_CutType)(gProcPointers[20].entry)) (A)
		#define ViewerLib_Copy(A) (*(ViewerLib_CopyType)(gProcPointers[21].entry)) (A)
		#define ViewerLib_Paste(A) (*(ViewerLib_PasteType)(gProcPointers[22].entry)) (A)

	#endif
	

#endif
