/******************************************************************************
 **																			 **
 ** 	Module:		QD3DErrors.h											 **
 **																			 **
 **																			 **
 ** 	Purpose:	Error API and error codes								 **
 **																			 **
 **																			 **
 ** 	Copyright (C) 1992-1995 Apple Computer, Inc.  All rights reserved.	 **
 **																			 **
 *****************************************************************************/
#ifndef QD3DError_h
#define QD3DError_h

#ifndef QD3D_h
#include <QD3D.h>
#endif  /*  QD3D_h  */

#if PRAGMA_ONCE
	#pragma once
#endif

#if defined(__MWERKS__)
	#pragma enumsalwaysint on
	#pragma align_array_members off
	#pragma options align=native
#endif

#if defined(OS_MACINTOSH) && OS_MACINTOSH
#include <Types.h>
#endif  /*  OS_MACINTOSH  */

#ifdef __cplusplus
extern "C" {
#endif  /*  __cplusplus  */


/******************************************************************************
 **																			 **
 **							Error Types and Codes							 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3Error {
	kQ3ErrorNone = 0,		
	/* Fatal Errors */
	kQ3ErrorInternalError	= -28500,
	kQ3ErrorNoRecovery,
	kQ3ErrorLastFatalError,
	/* System Errors */
	kQ3ErrorNotInitialized	= -28490,
	kQ3ErrorAlreadyInitialized,
	kQ3ErrorUnimplemented,
	kQ3ErrorRegistrationFailed,
	/* OS Errors */
	kQ3ErrorUnixError,
	kQ3ErrorMacintoshError,
	kQ3ErrorX11Error,
	/* Memory Errors */
	kQ3ErrorMemoryLeak,
	kQ3ErrorOutOfMemory,
	/* Parameter errors */
	kQ3ErrorNULLParameter,
	kQ3ErrorParameterOutOfRange,
	kQ3ErrorInvalidParameter,			
	kQ3ErrorInvalidData,				
	kQ3ErrorAcceleratorAlreadySet,		
	kQ3ErrorVector3DNotUnitLength,
	kQ3ErrorVector3DZeroLength,
	/* Object Errors */
	kQ3ErrorInvalidObject,
	kQ3ErrorInvalidObjectClass,
	kQ3ErrorInvalidObjectType,
	kQ3ErrorInvalidObjectName,
	kQ3ErrorObjectClassInUse,			
	kQ3ErrorAccessRestricted,
	kQ3ErrorMetaHandlerRequired,
	kQ3ErrorNeedRequiredMethods,
	kQ3ErrorNoSubClassType,
	kQ3ErrorUnknownElementType,
	kQ3ErrorNotSupported,
	/* Extension Errors */
	kQ3ErrorNoExtensionsFolder,
	kQ3ErrorExtensionError,
	kQ3ErrorPrivateExtensionError,
	/* Geometry Errors */
	kQ3ErrorDegenerateGeometry,
	kQ3ErrorGeometryInsufficientNumberOfPoints,
	/* IO Errors */
	kQ3ErrorNoStorageSetForFile,
	kQ3ErrorEndOfFile,
	kQ3ErrorFileCancelled,
	kQ3ErrorInvalidMetafile,
 	kQ3ErrorInvalidMetafilePrimitive,
 	kQ3ErrorInvalidMetafileLabel,
 	kQ3ErrorInvalidMetafileObject,
 	kQ3ErrorInvalidMetafileSubObject,
	kQ3ErrorInvalidSubObjectForObject,
	kQ3ErrorUnresolvableReference,
	kQ3ErrorUnknownObject,
	kQ3ErrorStorageInUse,
	kQ3ErrorStorageAlreadyOpen,
	kQ3ErrorStorageNotOpen,
	kQ3ErrorStorageIsOpen,
	kQ3ErrorFileAlreadyOpen,
	kQ3ErrorFileNotOpen,
	kQ3ErrorFileIsOpen,
	kQ3ErrorBeginWriteAlreadyCalled,
	kQ3ErrorBeginWriteNotCalled,
	kQ3ErrorEndWriteNotCalled,
	kQ3ErrorReadStateInactive,
	kQ3ErrorStateUnavailable,
	kQ3ErrorWriteStateInactive,
	kQ3ErrorSizeNotLongAligned,
	kQ3ErrorFileModeRestriction,
	kQ3ErrorInvalidHexString,
	kQ3ErrorWroteMoreThanSize,
	kQ3ErrorWroteLessThanSize,
	kQ3ErrorReadLessThanSize,
	kQ3ErrorReadMoreThanSize,
	kQ3ErrorNoBeginGroup,
	kQ3ErrorSizeMismatch,
	kQ3ErrorStringExceedsMaximumLength,
	kQ3ErrorValueExceedsMaximumSize,
	kQ3ErrorNonUniqueLabel,
	kQ3ErrorEndOfContainer,
	kQ3ErrorUnmatchedEndGroup,
	kQ3ErrorFileVersionExists,
	/* View errors */
	kQ3ErrorViewNotStarted,
	kQ3ErrorViewIsStarted,
	kQ3ErrorRendererNotSet,
	kQ3ErrorRenderingIsActive,
	kQ3ErrorImmediateModeUnderflow,
	kQ3ErrorDisplayNotSet,
	kQ3ErrorCameraNotSet,
	kQ3ErrorDrawContextNotSet,
	kQ3ErrorNonInvertibleMatrix,
	kQ3ErrorRenderingNotStarted,
	kQ3ErrorPickingNotStarted,
	kQ3ErrorBoundsNotStarted,
	kQ3ErrorDataNotAvailable,
	kQ3ErrorNothingToPop,
	/* Renderer Errors */
	kQ3ErrorUnknownStudioType,			
	kQ3ErrorAlreadyRendering,
	kQ3ErrorStartGroupRange,
	kQ3ErrorUnsupportedGeometryType,
	kQ3ErrorInvalidGeometryType,
	kQ3ErrorUnsupportedFunctionality,
	/* Group Errors */
	kQ3ErrorInvalidPositionForGroup,
	kQ3ErrorInvalidObjectForGroup,
	kQ3ErrorInvalidObjectForPosition,
	/* Transform Errors */
	kQ3ErrorScaleOfZero,				
	/* String Errors */
	kQ3ErrorBadStringType,				
	/* Attribute Errors */
	kQ3ErrorAttributeNotContained,		
	kQ3ErrorAttributeInvalidType,		
	/* Camera Errors */
	kQ3ErrorInvalidCameraValues,		
	/* DrawContext Errors */
	kQ3ErrorBadDrawContextType,
	kQ3ErrorBadDrawContextFlag,
	kQ3ErrorBadDrawContext,
	kQ3ErrorUnsupportedPixelDepth
} TQ3Error;

typedef enum TQ3Warning {
	kQ3WarningNone = 0,
	/* General System */
	kQ3WarningInternalException = -28300,	
	/* Object Warnings */
	kQ3WarningNoObjectSupportForDuplicateMethod,
	kQ3WarningNoObjectSupportForDrawMethod,
	kQ3WarningNoObjectSupportForWriteMethod,
	kQ3WarningNoObjectSupportForReadMethod,
	kQ3WarningUnknownElementType,
	kQ3WarningTypeAndMethodAlreadyDefined,
	kQ3WarningTypeIsOutOfRange,
	kQ3WarningTypeHasNotBeenRegistered,
	/* Parameter Warnings */
	kQ3WarningVector3DNotUnitLength,
	/* IO Warnings */
	kQ3WarningInvalidSubObjectForObject,
	kQ3WarningInvalidHexString,
	kQ3WarningUnknownObject,
	kQ3WarningInvalidMetafileObject,
	kQ3WarningUnmatchedBeginGroup,
	kQ3WarningUnmatchedEndGroup,
	kQ3WarningInvalidTableOfContents,
	kQ3WarningUnresolvableReference,
	kQ3WarningNoAttachMethod,
	kQ3WarningInconsistentData,
	kQ3WarningReadLessThanSize,
	kQ3WarningFilePointerResolutionFailed,
	kQ3WarningFilePointerRedefined,
	kQ3WarningStringExceedsMaximumLength,
	/* Memory Warnings */
	kQ3WarningLowMemory,
	kQ3WarningPossibleMemoryLeak,
	/* View Warnings */
	kQ3WarningViewTraversalInProgress,
	kQ3WarningNonInvertibleMatrix,
	/* Quaternion Warning */
	kQ3WarningQuaternionEntriesAreZero,
	/* Renderer Warning */
	kQ3WarningFunctionalityNotSupported,
	/* DrawContext Warning */
	kQ3WarningInvalidPaneDimensions,
	/* Pick Warning */
	kQ3WarningPickParamOutside,
	/* Scale Warnings */
	kQ3WarningScaleEntriesAllZero,
	kQ3WarningScaleContainsNegativeEntries,
	/* Generic Warnings */
	kQ3WarningParameterOutOfRange
} TQ3Warning;


typedef enum TQ3Notice {
	kQ3NoticeNone = 0,
	kQ3NoticeDataAlreadyEmpty = -28100,
	/* General */
	kQ3NoticeMethodNotSupported,
	kQ3NoticeObjectAlreadySet,
	kQ3NoticeParameterOutOfRange,
	/* IO Notices */
	kQ3NoticeFileAliasWasChanged,
	/* Geometry */
	kQ3NoticeMeshVertexHasNoComponent,
	kQ3NoticeMeshInvalidVertexFacePair,
	kQ3NoticeMeshEdgeVertexDoNotCorrespond,
	kQ3NoticeMeshEdgeIsNotBoundary,
	/* Draw Context */
	kQ3NoticeDrawContextNotSetUsingInternalDefaults,
	/* Lights */
	kQ3NoticeInvalidAttenuationTypeUsingInternalDefaults,
	kQ3NoticeBrightnessGreaterThanOne,
	/*  Scale  */
	kQ3NoticeScaleContainsZeroEntries	
} TQ3Notice;

typedef void (*TQ3ErrorMethod)(
	TQ3Error	firstError,
	TQ3Error	lastError,
	long		reference);
	
typedef void (*TQ3WarningMethod)(
	TQ3Warning	firstWarning,
	TQ3Warning	lastWarning,
	long		reference);

typedef void (*TQ3NoticeMethod)(
	TQ3Notice	firstNotice,
	TQ3Notice	lastNotice,
	long		reference);


/******************************************************************************
 **																			 **
 **								Error Routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Status Q3Error_Register(
	TQ3ErrorMethod		errorPost,
	long				reference);

QD3D_EXPORT TQ3Status Q3Warning_Register(
	TQ3WarningMethod	warningPost,
	long				reference);

QD3D_EXPORT TQ3Status Q3Notice_Register(
	TQ3NoticeMethod		noticePost,
	long				reference);

/*
 *  Getting error codes -
 *	Clears error type on next entry into system (except all of these 
 *  error calls), and returns the last error, and optionally the 
 *	first error. The parameter to these "_Get" calls may be NULL.
 */
QD3D_EXPORT TQ3Error Q3Error_Get(
	TQ3Error			*firstError);

QD3D_EXPORT TQ3Boolean Q3Error_IsFatalError(
	TQ3Error			error);

QD3D_EXPORT TQ3Warning Q3Warning_Get(
	TQ3Warning			*firstWarning);

QD3D_EXPORT TQ3Notice Q3Notice_Get(
	TQ3Notice			*firstNotice);

#if defined(OS_MACINTOSH) && OS_MACINTOSH

QD3D_EXPORT OSErr Q3MacintoshError_Get(
	OSErr				*firstMacErr);

#endif  /*  OS_MACINTOSH  */
#ifdef __cplusplus
}
#endif  /*  __cplusplus  */

#if defined(__MWERKS__)
#pragma options align=reset
#pragma enumsalwaysint reset
#endif

#endif	/*  QD3DError_h  */
