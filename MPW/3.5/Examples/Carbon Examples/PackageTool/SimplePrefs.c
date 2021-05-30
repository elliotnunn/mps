/*
	file SimplePrefs.c
	
	Description:
	This file contains routines for managing simple preferences files.
	Here, a preference file contains a flattened collection.
	
	PackageTool is an application illustrating how to create application
	packages in Mac OS 9.  It provides a simple interface for converting
	correctly formatted folders into packages and vice versa.

	Copyright: © 1999 by Apple Computer, Inc.
	all rights reserved.
	
	Disclaimer:
	You may incorporate this sample code into your applications without
	restriction, though the sample code has been provided "AS IS" and the
	responsibility for its operation is 100% yours.  However, what you are
	not permitted to do is to redistribute the source as "DSC Sample Code"
	after having made changes. If you're going to re-distribute the source,
	we require that you make it clear in the source that the code was
	descended from Apple Sample Code, but that you've made changes.
	
	Change History (most recent first):
	10/19/99 created
	12/2/99 replaced memset with BlockZero
*/


#include "SimplePrefs.h"
//#include <Folders.h>
//#include <Memory.h>
//#include <Errors.h>
//#include <TextUtils.h>
//#include <PLStringFuncs.h>



typedef struct {
	OSType creator;
	long databytes;
} PrefFileHeader;

enum {
	kMaxNameAttempts = 20
};

OSStatus FindThePreferencesFile(OSType fType, OSType fCreator, FSSpec *prefsSpec) {
	short pvol;
	long pdir;
	Str255 name;
	CInfoPBRec cat;
	OSStatus err;
		/* find the preferences folder */
	err = FindFolder( kOnSystemDisk, kPreferencesFolderType, true, &pvol, &pdir);
	if (err != noErr) return err;
		/* search the folder for the file */
	BlockZero(&cat, sizeof(cat));
	cat.hFileInfo.ioNamePtr = name;
	cat.hFileInfo.ioVRefNum = pvol;
	cat.hFileInfo.ioFDirIndex = 1;
	cat.hFileInfo.ioDirID = pdir;
	while (PBGetCatInfoSync(&cat) == noErr) {
		if (((cat.hFileInfo.ioFlAttrib & 16) == 0)
		&& (cat.hFileInfo.ioFlFndrInfo.fdType == fType)
		&& (cat.hFileInfo.ioFlFndrInfo.fdCreator == fCreator)) {
				/* make a fsspec referring to the file */
			return FSMakeFSSpec(pvol, pdir, name, prefsSpec);
		}
		cat.hFileInfo.ioFDirIndex++;
		cat.hFileInfo.ioDirID = pdir;
	}
	return fnfErr;
}


OSStatus GetPreferences(OSType fType, OSType fCreator, Collection preferences) {
	Handle data;
	FSSpec spec;
	short refnum;
	long prefssize, count;
	OSStatus err;
	PrefFileHeader header;
		/* initial state */
	data = NULL;
	refnum = 0;
		/* find the file */
	err = FindThePreferencesFile(fType, fCreator, &spec);
	if (err != noErr) goto bail;
		/* open the file */
	err = FSpOpenDF(&spec, fsRdPerm, &refnum);
	if (err != noErr) goto bail;
		/* measure it's size */
	err = GetEOF(refnum, &prefssize);
	if (err != noErr) goto bail;
		/* read the read the header */
	err = FSRead(refnum, (count = sizeof(header), &count),  &header);
	if (err != noErr) goto bail;
	if (header.creator != fCreator) { err = fnfErr; goto bail; }
		/* create a new handle */
	data = NewHandle(header.databytes);
	if (data == NULL) { err = memFullErr; goto bail; }
		/* read the data fork into the handle */
	HLock(data);
	err = FSRead(refnum, &header.databytes, *data);
	HUnlock(data);
	if (err != noErr) goto bail;
		/* close the file */
	FSClose(refnum);
	refnum = 0;
		/* convert the data to a collection */
	err = UnflattenCollectionFromHdl(preferences, data);
	if (err != noErr) goto bail;
		/* deallocate the handle */
	DisposeHandle(data);
		/* done */
	return noErr;
bail:
	EmptyCollection(preferences);
	if (data != NULL) DisposeHandle(data);
	if (refnum != 0) FSClose(refnum);
	return err;
}


OSStatus SavePreferences(OSType fType, OSType fCreator, StringPtr suggestedName, Collection preferences) {
	Handle data;
	Str255 name, namenum;
	FSSpec spec;
	short refnum;
	long count, namecounter;
	OSStatus err;
	Boolean createdFile;
	PrefFileHeader header;
		/* initial state */
	data = NULL;
	refnum = 0;
	namecounter = 1;
	createdFile = false;
		/* check parameters */
	if (CountCollectionItems(preferences) == 0)
		return noErr;
		/* find the file */
	err = FindThePreferencesFile(fType, fCreator, &spec);
	if (err == fnfErr) {
		short pvol;
		long pdir;
			/* find the preferences folder */
		err = FindFolder( kOnSystemDisk, kPreferencesFolderType, true, &pvol, &pdir);
		if (err != noErr) goto bail;
			/* find a free name */
		PLstrcpy(name, suggestedName);
		while (namecounter < kMaxNameAttempts) {
			err = FSMakeFSSpec(pvol, pdir, name, &spec);
			if (err == fnfErr) break;
			if (err != noErr) goto bail;
			NumToString(namecounter++, namenum);
			PLstrcpy(name, suggestedName);
			PLstrcat(name, namenum);
			name[0] += namenum[0];
		}
		if (namecounter == kMaxNameAttempts) { err = fnfErr; goto bail; }
		err = FSpCreate(&spec, fCreator, fType, smSystemScript);
		if (err != noErr) goto bail;
		createdFile = true;
	} else if (err != noErr)
		goto bail;
		/* create a new handle */
	data = NewHandle(0);
	if (data == NULL) { err = memFullErr; goto bail; }
		/* flatten the collection to the handle */
	err = FlattenCollectionToHdl(preferences, data);
	if (err != noErr) goto bail;
		/* open the file */
	err = FSpOpenDF(&spec, fsRdWrPerm, &refnum);
	if (err != noErr) goto bail;
		/* write out the header */
	header.creator = fCreator;
	header.databytes = GetHandleSize(data);
	err = FSWrite(refnum, (count = sizeof(header), &count), &header);
	if (err != noErr) goto bail;
		/* write out the data */
	HLock(data);
	err = FSWrite(refnum, &header.databytes, *data);
	HUnlock(data);
	if (err != noErr) goto bail;
		/* crunch!! */
	err = SetEOF(refnum, header.databytes + sizeof(header));
	if (err != noErr) goto bail;
	FSClose(refnum);
	DisposeHandle(data);
		/* done */
	return noErr;
bail:
	if (data != NULL) DisposeHandle(data);
	if (refnum != 0) FSClose(refnum);
	if (createdFile) FSpDelete(&spec);
	return err;
}

