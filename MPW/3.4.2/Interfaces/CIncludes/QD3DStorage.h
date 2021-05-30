/******************************************************************************
 **																			 **
 ** 	Module:		QD3DStorage.h											 **
 ** 																		 **
 ** 																		 **
 ** 	Purpose: 	Abstraction to deal with various types of stream-based	 **
 **					storage devices.										 **
 ** 																		 **
 ** 																		 **
 ** 	Copyright (C) 1992-1995 Apple Computer, Inc.  All rights reserved.	 **
 ** 																		 **
 *****************************************************************************/
#ifndef QD3DStorage_h
#define QD3DStorage_h

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
#include <Files.h>
#endif  /*  OS_MACINTOSH  */

#ifdef __cplusplus
extern "C" {
#endif	/* __cplusplus */

/******************************************************************************
 **																			 **
 **								Storage Routines							 **
 **																			 **
 *****************************************************************************/

TQ3ObjectType Q3Storage_GetType(
	TQ3StorageObject	storage);

TQ3Status Q3Storage_GetSize(
	TQ3StorageObject	storage,
	unsigned long		*size);

/* 
 *	Reads "dataSize" bytes starting at offset in storage, copying into data. 
 *	sizeRead returns the number of bytes filled in. 
 *	
 *	You may assume if *sizeRead < dataSize, then EOF is at offset + *sizeRead
 */

TQ3Status Q3Storage_GetData(
	TQ3StorageObject	storage,
	unsigned long		offset,
	unsigned long		dataSize,
	unsigned char		*data,
	unsigned long		*sizeRead);

/* 
 *	Write "dataSize" bytes starting at offset in storage, copying from data. 
 *	sizeWritten returns the number of bytes filled in. 
 *	
 *	You may assume if *sizeRead < dataSize, then EOF is at offset + *sizeWritten
 */

TQ3Status Q3Storage_SetData(
	TQ3StorageObject	storage,
	unsigned long		offset,
	unsigned long		dataSize,
	const unsigned char	*data,
	unsigned long		*sizeWritten);

/******************************************************************************
 **																			 **
 **							 Memory Storage Prototypes						 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ObjectType Q3MemoryStorage_GetType(
	TQ3StorageObject		storage);

/*
 * These calls COPY the buffer into QD3D space
 */
QD3D_EXPORT TQ3StorageObject Q3MemoryStorage_New(
	const unsigned char		*buffer,
	unsigned long			validSize);

QD3D_EXPORT TQ3Status Q3MemoryStorage_Set(
 	TQ3StorageObject		storage,
	const unsigned char		*buffer,
	unsigned long			validSize);

/*
 * These calls use the pointer given - you must dispose it when you're through
 */
QD3D_EXPORT TQ3StorageObject Q3MemoryStorage_NewBuffer(
	unsigned char			*buffer,
	unsigned long			validSize,
	unsigned long			bufferSize);

QD3D_EXPORT TQ3Status Q3MemoryStorage_SetBuffer(
 	TQ3StorageObject		storage,
	unsigned char			*buffer,
	unsigned long			validSize,
	unsigned long			bufferSize);

QD3D_EXPORT TQ3Status Q3MemoryStorage_GetBuffer(
 	TQ3StorageObject		storage,
	unsigned char			**buffer,
	unsigned long			*validSize,
	unsigned long			*bufferSize);

#if defined(OS_MACINTOSH) && OS_MACINTOSH

/******************************************************************************
 **																			 **
 **								Macintosh Handles Prototypes				 **
 **																			 **
 *****************************************************************************/

/* Handle Storage is a subclass of Memory Storage */

QD3D_EXPORT TQ3StorageObject Q3HandleStorage_New(
	Handle					handle,
	unsigned long			validSize);

QD3D_EXPORT TQ3Status Q3HandleStorage_Set(
 	TQ3StorageObject		storage,
	Handle					handle,
	unsigned long			validSize);

QD3D_EXPORT TQ3Status Q3HandleStorage_Get(
 	TQ3StorageObject		storage,
 	Handle					*handle,
	unsigned long			*validSize);

/******************************************************************************
 **																			 **
 **								Macintosh Storage Prototypes				 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3StorageObject Q3MacintoshStorage_New(					
	short					fsRefNum);	/* Note: This storage is assumed open */

QD3D_EXPORT TQ3Status Q3MacintoshStorage_Set(
 	TQ3StorageObject		storage,
	short					fsRefNum);

QD3D_EXPORT TQ3Status Q3MacintoshStorage_Get(
 	TQ3StorageObject		storage,
	short					*fsRefNum);
	
QD3D_EXPORT TQ3ObjectType Q3MacintoshStorage_GetType(
	TQ3StorageObject		storage);


/******************************************************************************
 **																			 **
 **							Macintosh FSSpec Storage Prototypes				 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3StorageObject Q3FSSpecStorage_New(
	const FSSpec			*fs);

QD3D_EXPORT TQ3Status Q3FSSpecStorage_Set(
 	TQ3StorageObject		storage,
	const FSSpec			*fs);

QD3D_EXPORT TQ3Status Q3FSSpecStorage_Get(
 	TQ3StorageObject		storage,
	FSSpec					*fs);

#endif  /*  OS_MACINTOSH  */


/******************************************************************************
 **																			 **
 **									Unix Prototypes							 **
 **																			 **
 *****************************************************************************/

TQ3StorageObject Q3UnixStorage_New(
	FILE					*storage);

TQ3Status Q3UnixStorage_Set(
 	TQ3StorageObject		storage,
	FILE					*stdFile);

TQ3Status Q3UnixStorage_Get(
 	TQ3StorageObject		storage,
	FILE					**stdFile);
	
TQ3ObjectType Q3UnixStorage_GetType(
	TQ3StorageObject		storage);


/******************************************************************************
 **																			 **
 **								Unix Path Prototypes						 **
 **																			 **
 *****************************************************************************/

TQ3StorageObject Q3UnixPathStorage_New(					
	const char				*pathName);				/* C string */

TQ3Status Q3UnixPathStorage_Set(			
 	TQ3StorageObject		storage,
	const char				*pathName);				/* C string */

TQ3Status Q3UnixPathStorage_Get(			
 	TQ3StorageObject		storage,
	char					*pathName);				/* pathName is a buffer */

#ifdef __cplusplus
}
#endif	/* __cplusplus */

#if defined(__MWERKS__)
#pragma options align=reset
#pragma enumsalwaysint reset
#endif

#endif /* QD3DStorage_h */
