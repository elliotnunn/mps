/*
** Apple Macintosh Developer Technical Support
**
** Program:     DTS.Lib
** File:        TreeObj.c
** Written by:  Eric Soldan
**
** Copyright © 1992-1993 Apple Computer, Inc.
** All rights reserved.
*/

/* You may incorporate this sample code into your applications without
** restriction, though the sample code has been provided "AS IS" and the
** responsibility for its operation is 100% yours.  However, what you are
** not permitted to do is to redistribute the source as "DSC Sample Code"
** after having made changes. If you're going to re-distribute the source,
** we require that you make it clear in the source that the code was
** descended from Apple Sample Code, but that you've made changes. */

#include "DTS.Lib2.h"
#include "DTS.Lib.protos.h"

#ifndef __FILES__
#include <Files.h>
#endif

//#ifndef __STDIO__
//#include <StdIO.h>
//#endif

//#ifndef __STRING__
//#include <String.h>
//#endif

#ifndef __TREEOBJ__
#include "TreeObj.h"
#endif



#define NEW_CHILD     1
#define DISPOSE_CHILD 2
#define MOVE_CHILD    3
#define SWAP_CHILDREN 4
#define CHANGE_CHILD  5



extern TreeObjProcPtr	gTreeObjMethods[];
extern long				gMinTreeObjSize[];

static TreeObjHndl	CopyOneChild(TreeObjHndl chndl, TreeObjHndl copyToHndl, short copyCNum);
static OSErr		ReadBranch(TreeObjHndl hndl, short fileRefNum);
static OSErr		ReadTreeObjHeader(TreeObjHndl hndl, short fileRefNum);
static OSErr		WriteTreeObjHeader(TreeObjHndl hndl, short fileRefNum);

static void			DoNumberTree0(TreeObjHndl hndl);
static TreeObjHndl	GetUndoTaskHndl(TreeObjHndl undo, short editType);
static TreeObjHndl	NewUndoPart(TreeObjHndl taskHndl, short action, TreeObjHndl shndl, short cnum, TreeObjHndl dhndl, short dcnum, Boolean deepCopy);

static OSErr		PostNewChild(short editType, TreeObjHndl phndl, short cnum);
static OSErr		PostDisposeChild(short editType, TreeObjHndl phndl, short cnum);
static void			PostMoveChild(short editType, TreeObjHndl shndl, short scnum, TreeObjHndl dhndl, short dcnum);
static void			PostSwapChildren(short editType, TreeObjHndl hndla, short cnuma, TreeObjHndl hndlb, short cnumb);

static void			UndoNewChild(TreeObjHndl undoPart);
static void			UndoDisposeChild(TreeObjHndl undoPart);
static void			UndoMoveChild(TreeObjHndl undoPart);
static void			UndoModifyChild(TreeObjHndl undoPart);
static void			UndoModifyChildren(TreeObjHndl dhndl, TreeObjHndl uhndl, Boolean deepCopy);
static void			UndoSwapChildren(TreeObjHndl undoPart);



/**********************************************************************/



/* Creates an object with no parent.  This object will be the root object
** for a tree.  Returns nil upon failure. */

#pragma segment TreeObj
TreeObjHndl	NewRootObj(short ctype, long size)
{
	TreeObjHndl		root;
	TreeObjPtr		ptr;
	char			*cptr;
	short			i;
	TreeObjProcPtr	proc;

	if (size < gMinTreeObjSize[ctype])
		size = gMinTreeObjSize[ctype];
			/* Ensure a minimally-sized object. */

	root = (TreeObjHndl)NewHandle(sizeof(TreeObj) + size);
	if (!root) return(nil);
		/* Oh well...
		** Note that since we are creating an orphan, it isn't possible to purge
		** old undos to possibly make space.  This means that for anyone calling
		** NewRootObj to get a handlewho considers it okay to purge old undos to
		** get the memory if necessary, has to do the following:
		** 1)  Call NewRootObj
		** 2)  If failure, call PurgeUndo for a particular document to purge the
		**     oldest undo for that document to free up ram.
		** 3)  If PurgeUndo returns true, then something was purged and there is more
		**     ram available.  Loop back to step 1 and try to create the object again.
		** 4)  If PurgeUndo returns false, then there really isn't any more ram.  One
		**     possibility is to try purging undos from other documents, but this is
		**     probably rude. */

	cptr = GetDataPtr(root);
	for (i = 0; i < size; ++i) cptr[i] = 0;
		/* Initialize data area to 0's.  This is very nice of us. */

	ptr = *root;	 				/* Deref root object once.      */
	ptr->type        = ctype;	 	/* Flag what object type it is. */
	ptr->numChildren = 0;			/* Give root 0 children.        */
	ptr->dataSize    = size;		/* Remember the data area size. */
	ptr->treeID      = 0;			/* Requisite do-nothing field.  */
	ptr->parent      = nil;			/* We aren't owned yet.         */

	if (proc = gTreeObjMethods[ctype]) {				/* If this object type has a proc...   */
		if ((*proc)(root, INITMESSAGE, CREATEINIT)) {	/* Call the proc with an init message. */
			DisposeHandle((Handle)root);				/* If the init complains, it's no go.  */
			return(nil);
		}
	}

	return(root);	/* Success.  Return the handle. */
}



/**********************************************************************/



/* Creates a child of the specified type and adds it to the parent at the
** specified location.  Returns nil upon failure. */

#pragma segment TreeObj
TreeObjHndl	NewChild(short editType, TreeObjHndl phndl, short cnum, short ctype, long size)
{
	TreeObjHndl		chndl;
	TreeObjProcPtr	proc;

	for (;;) {
		chndl = NewRootObj(ctype, size);	/* Let somebody else do the creative work. */
		if (chndl) break;					/* We succeeded at creating an orphan. */
		if (!PurgeUndo(phndl)) return(nil);
			/* Oh well...
			** There is really no memory.  We even purged the undos to try to make
			** room, but we still didn't have enough ram to create the orphan object. */
	};

	/* Now that we have successfully created an orphan object, make it someone's child. */

	GetChildHndlPtr(phndl, &cnum, 1);
		/* Adjust cnum to within bounds.  See GetChildHndlPtr() for more info. */

	if (InsertChildHndl(phndl, chndl, cnum)) {
			/* Couldn't insert the child into the parent handle table. */
		if (proc = gTreeObjMethods[ctype])
			(*proc)(chndl, FREEMESSAGE, 0);
				/* Since we couldn't attatch, call the object with a free message so that
				** it can get rid of any additional memory that was allocated when an
				** init message was sent to it. */
		DisposeHandle((Handle)chndl);
			/* After the free message, the object now consists of a single handle.
			** Dispose this handle and it is history completely. */
		return(nil);
	}

	if (PostNewChild(editType, phndl, cnum)) {
		DisposeChild(NO_EDIT, phndl, cnum);
		chndl = nil;
	}

	DoTreeObjMethod(chndl, UNDOMESSAGE, UNDOTODOC);
	return(chndl);
}



/**********************************************************************/



/* Disposes of the specified child and all offspring of that child. */

#pragma segment TreeObj
void	DisposeChild(short editType, TreeObjHndl phndl, short cnum)
{
	TreeObjHndl	chndl;

	if (GetChildHndlPtr(phndl, &cnum, 0)) {
		/* This test checks that there are children in the table, plus it
		** also adjusts cnum to legit values, if possible. */

		chndl = GetChildHndl(phndl, cnum);

		if (editType) {
			if (PostDisposeChild(editType, phndl, cnum)) {
					/* Posting a DisposeChild can actually take more ram.
					** The reason for this is that the object isn't disposed of.
					** It is moved into the undo, plus information as to where to
					** put it back is kept.  If PostDisposeChild fails, then we
					** are in a bad way memory-wise, so we really need to let the
					** dispose occur.  To accomplish this, we disable undos for
					** this document, and then we go ahead and allow a straight
					** dispose of the child.  This will get the job done, plus it
					** will free up some ram.
					** The reason that undos are disabled is that the edit that
					** is occuring may have multiple operations.  We want to stop
					** collection of the remaining operations for this edit, as
					** it wouldn't be a complete undo anyway.  The undos will
					** be enabled again when NewUndo is called to start a new edit. */
				DisableUndo(phndl);
					/* Undo collection off temporarily, plus all undos are purged,
					** thus freeing up ram. */
				editType = 0;
			}
		}

		if (!editType) {
			DoTreeObjMethod(chndl, UNDOMESSAGE, UNDOFROMDOC);
				/* If the dispose was successfully posted, then the object got a message that
				** it was leaving the document via PostDisposeChild calling MoveChild.  The
				** only way that PostDisposeChild can fail (and therefore not call MoveChild)
				** is if an undoTask couldn't be created, and this is prior to MoveChild being
				** called.  What all this means is that if we are here, the object hadn't yet
				** received a message about leaving the document. */
			DisposeObjAndOffspring(GetChildHndl(phndl, cnum));
			*GetChildHndlPtr(phndl, &cnum, 0) = nil;
				/* Since the child no longer exists, DeleteChildHndl can't set
				** the parent reference for the child to nil.  Setting the reference
				** to the child prevents DeleteChildHndl from doing this. */
			DeleteChildHndl(phndl, cnum);
		}
	}
}



/**********************************************************************/



/* Copies the specified child (and all offspring of that child if deepCopy is true). */

#pragma segment TreeObj
TreeObjHndl	CopyChild(short editType, TreeObjHndl shndl, short scnum,
					  TreeObjHndl dhndl, short dcnum, Boolean deepCopy)
{
	TreeObjHndl	chndl, copyHndl;

	if (!GetChildHndlPtr(shndl, &scnum, 0)) return(nil);
		/* Adjust scnum to within bounds, if possible. */

	GetChildHndlPtr(dhndl, &dcnum, 1);
		/* Adjust dcnum to within bounds. */

	copyHndl = CopyOneChild(chndl = GetChildHndl(shndl, scnum), dhndl, dcnum);
	if (!copyHndl) return(nil);

	if (deepCopy) {
		if (CopyChildren(chndl, copyHndl)) {		/* Copy child's children. */
			DisposeChild(NO_EDIT, dhndl, dcnum);
			return(nil);
		}
	}

	if (PostNewChild(editType, dhndl, dcnum)) {
		DisposeChild(NO_EDIT, dhndl, dcnum);
		return(nil);
	}

	DoTreeObjMethod(copyHndl, UNDOMESSAGE, UNDOTODOC);
	return(copyHndl);
}



/**********************************************************************/



/* Moves a child from one location on the tree to another. */

#pragma segment TreeObj
OSErr	MoveChild(short editType, TreeObjHndl shndl, short scnum, TreeObjHndl dhndl, short dcnum)
{
	TreeObjHndl	chndl;

	if (!GetChildHndlPtr(shndl, &scnum, 0)) return(paramErr);
		/* Adjust scnum to within bounds.  Adjustment not possible if no children. */

	GetChildHndlPtr(dhndl, &dcnum, 1);		/* Adjust dcnum to within bounds. */

	chndl = GetChildHndl(shndl, scnum);
	DoTreeObjMethod(chndl, UNDOMESSAGE, UNDOFROMDOC);
	DeleteChildHndl(shndl, scnum);

	GetChildHndlPtr(dhndl, &dcnum, 1);
		/* Adjust dcnum to within bounds.  It may be just out of bounds if shndl
		** and dhndl are the same.  After the DeleteChildHndl, dcnum may be 2 past
		** the end, instead of the allowable 1 for a target. */

	InsertChildHndl(dhndl, chndl, dcnum);
	DoTreeObjMethod(chndl, UNDOMESSAGE, UNDOTODOC);

	PostMoveChild(editType, shndl, scnum, dhndl, dcnum);
	return(noErr);
}



/**********************************************************************/



/* Saves a copy of the child in the undo hierarchy for undo/redo purposes. */

#pragma segment TreeObj
OSErr	ModifyChild(short editType, TreeObjHndl phndl, short cnum, Boolean deepCopy)
{
	TreeObjHndl	undo, task, part, copy;
	short		i;
	OSErr		err;

	if (!editType) return(noErr);

	err  = noErr;
	copy = nil;
	undo = GetUndoHndl(phndl);

	if (mDerefUndo(undo)->disabled)
		copy = phndl;		/* Used for flag purposes. */

	else {
		if (task = GetUndoTaskHndl(undo, editType)) {
			for (i = (*task)->numChildren; i;) {
				part = GetChildHndl(task, --i);
				if (mDerefUndoPart(part)->actionType == CHANGE_CHILD)
					if ((mDerefUndoPart(part)->shndl ==phndl) && (mDerefUndoPart(part)->scnum ==cnum))
						return(noErr);
							/* Child is already posted as changed for this undo editType. */
			}

			part = NewUndoPart(task, CHANGE_CHILD, phndl, cnum, nil, 0, deepCopy);
			if (part)
				copy = CopyChild(NO_EDIT, phndl, cnum, part, -1, deepCopy);
		}
	}

	if (!copy) {
		DisableUndo(phndl);
		err = memFullErr;
	}

	return(err);
}



/**********************************************************************/



/* Swaps the child handles. */

#pragma segment TreeObj
OSErr	SwapChildren(short editType, TreeObjHndl hndla, short cnuma, TreeObjHndl hndlb, short cnumb)
{
	TreeObjHndl	*tptra, *tptrb, hndl;

	if (!(tptra = GetChildHndlPtr(hndla, &cnuma, 0))) return(paramErr);
	if (!(tptrb = GetChildHndlPtr(hndlb, &cnumb, 0))) return(paramErr);

	BlockMove(tptra, &hndl, sizeof(TreeObjHndl));
	BlockMove(tptrb, tptra, sizeof(TreeObjHndl));
	BlockMove(&hndl, tptra, sizeof(TreeObjHndl));

	(*GetChildHndl(hndla, cnuma))->parent = hndla;
	(*GetChildHndl(hndlb, cnumb))->parent = hndlb;

	PostSwapChildren(editType, hndla, cnuma, hndlb, cnumb);
	return(noErr);
}



/**********************************************************************/



/* Swaps the child data without swapping the handles. */

#pragma segment TreeObj
OSErr	SwapTreeObjData(TreeObjHndl hndla, TreeObjHndl hndlb)
{
	TreeObjHndl	hndl;
	long		size, sizea, sizeb, i;
	char		*ptra, *ptrb, c;
	OSErr		err;

	sizea = (*hndla)->dataSize;
	sizeb = (*hndlb)->dataSize;
	if (sizea > sizeb) {		/* Make hndla the small one and hndlb the big one. */
		size  = sizea;
		sizea = sizeb;
		sizeb = size;
		hndl  = hndla;
		hndla = hndlb;
		hndlb = hndl;
	}

	err = SetDataSize(hndla, sizeb);		/* Make the small one big. */
	if (!err) {
		ptra = GetDataPtr(hndla);
		ptrb = GetDataPtr(hndlb);
		for (i = 0; i < sizeb; ++i) {
			c = ptra[i];
			ptra[i] = ptrb[i];
			ptrb[i] = c;
		}
		SetDataSize(hndlb, sizea);			/* Make the big one small. */
	}

	return(err);
}



/**********************************************************************/
/**********************************************************************/



/* This disposes of the child and any offspring of that child.  It does not remove
** the child from the parent's child handle table. */

#pragma segment TreeObj
void	DisposeObjAndOffspring(TreeObjHndl chndl)
{
	short			nc;
	TreeObjProcPtr	proc;

	if (!chndl) return;

	if (proc = gTreeObjMethods[(*chndl)->type])
		(*proc)(chndl, FREEMESSAGE, 0);
			/* If the object has any additional deallocation to do, let it do it. */

	while (nc = (*chndl)->numChildren) {
		DisposeObjAndOffspring(GetChildHndl(chndl, nc - 1));
		(*chndl)->numChildren--;
	}
	DisposeHandle((Handle)chndl);
}



/**********************************************************************/



/* Copies the children (and children below that and so on) of one object to
** another object.  Used internally by CopyChild for deep copies. */

#pragma segment TreeObj
OSErr	CopyChildren(TreeObjHndl shndl, TreeObjHndl dhndl)
{
	TreeObjHndl	chndl, copyHndl;
	short	i;
	OSErr	err;

	for (i = (*shndl)->numChildren; i;) {
		chndl    = GetChildHndl(shndl, --i);
		copyHndl = CopyOneChild(chndl, dhndl, 0);
		if (!copyHndl) return(memFullErr);
		if (err = CopyChildren(chndl, copyHndl)) return(err);
	}
	return(noErr);
}



/**********************************************************************/



/* Used internally by CopyChild for shallow copies. */

#pragma segment TreeObj
static TreeObjHndl	CopyOneChild(TreeObjHndl chndl, TreeObjHndl copyToHndl, short copycnum)
{
	TreeObjHndl		copyHndl;
	short			type;
	long			size;
	TreeObjProcPtr	proc;

	type = (*chndl)->type;
	size = (*chndl)->dataSize;


	proc = gTreeObjMethods[type];	/* Prevent NewChild() from calling the */
	gTreeObjMethods[type] = nil;	/* object for INITMESSAGE. */

	copyHndl = NewChild(NO_EDIT, copyToHndl, copycnum, type, size);
		/* NewChild takes care of bounds-checking for copycnum.  The child data has
		** not been fully initialized, as we prevented the INITMESSAGE. */

	gTreeObjMethods[type] = proc;	/* Re-enable messaging the object. */

	if (!copyHndl) return(nil);

	BlockMove(GetDataPtr(chndl), GetDataPtr(copyHndl), size);
	if (proc) {
		if ((*proc)(copyHndl, COPYMESSAGE, (long)chndl)) {
			DisposeChild(NO_EDIT, copyHndl, copycnum);
			return(nil);
		}
	}

	return(copyHndl);
}



/**********************************************************************/
/**********************************************************************/



/* Adds an existing child to a parent's child handle table. */

#pragma segment TreeObj
OSErr	InsertChildHndl(TreeObjHndl phndl, TreeObjHndl chndl, short cnum)
{
	TreeObjHndl	*tptr;
	TreeObjPtr	ptr;
	long		oldSize, newSize, dhSize;
	long		oldTblSize, tblOffset;
	OSErr		err;

	oldSize = GetHandleSize((Handle)phndl);
	dhSize  = sizeof(TreeObj) + (ptr = *phndl)->dataSize;		/* Data + header size. */

	oldTblSize = ptr->numChildren * sizeof(TreeObjHndl);

	newSize = dhSize + oldTblSize + sizeof(TreeObjHndl);
	newSize |= 0x1F;
	++newSize;

	if (newSize > oldSize) {
		SetHandleSize((Handle)phndl, newSize);
		if (err = MemError()) return(err);
		ptr = *phndl;
	}

	tptr      = GetChildHndlPtr(phndl, &cnum, 1);
	tblOffset = cnum * sizeof(TreeObjHndl);
	BlockMove((char *)tptr, (char *)(tptr + 1), oldTblSize - tblOffset);

	ptr->numChildren++;
	BlockMove(&chndl, tptr, sizeof(TreeObjHndl));
	(*chndl)->parent = phndl;
	return(noErr);
}



/**********************************************************************/



/* Removes a child from the parent's child handle table. */

#pragma segment TreeObj
void	DeleteChildHndl(TreeObjHndl phndl, short cnum)
{
	TreeObjHndl	*tptr;
	TreeObjHndl	chndl;
	TreeObjPtr	ptr;
	long		dhSize, tblSize, tblOffset;

	if (!(tptr = GetChildHndlPtr(phndl, &cnum, 0))) return;
	BlockMove(tptr, &chndl, sizeof(TreeObjHndl));

	dhSize    = sizeof(TreeObj) + (ptr = *phndl)->dataSize;
	tblSize   = ptr->numChildren * sizeof(TreeObjHndl);
	tblOffset = cnum * sizeof(TreeObjHndl);

	BlockMove((char *)(tptr + 1), (char *)tptr, tblSize - tblOffset - sizeof(TreeObjHndl));
	SetHandleSize((Handle)phndl, ((dhSize + tblSize - sizeof(TreeObjHndl)) | 0x1F) + 1);
	(*phndl)->numChildren--;

	if (chndl)
		(*chndl)->parent = nil;
}



/**********************************************************************/



/* Given an object handle, return the root handle. */

#pragma segment TreeObj
TreeObjHndl	GetRootHndl(TreeObjHndl hndl)
{
	for (; (*hndl)->parent; hndl = (*hndl)->parent);
	return(hndl);
}



/**********************************************************************/



/* Given a parent handle and a child number, this returns the child handle. */

#pragma segment TreeObj
TreeObjHndl	GetChildHndl(TreeObjHndl phndl, short cnum)
{
	TreeObjHndl	*tptr, th;

	if (!(tptr = GetChildHndlPtr(phndl, &cnum, 0))) return(nil);
	BlockMove(tptr, &th, sizeof(TreeObjHndl));
	return(th);
}



/**********************************************************************/



/* Return a pointer into the child handle table.  This also validates (and corrects)
** cnum so that it is in range, if possible.  Depending on the usage, pointing to
** just after the child handle table is either valid or invalid.  If a handle is
** being added to the table, then pointing just after the table is valid.  If a
** handle is being removed or referenced, then pointing just after the table is
** invalid.  the parameter endCase determines which case we are dealing with.  If
** endCase is 0, then pointing just after the child handle table is invalid, and
** if the cnum value passed in causes this, then nil is returned for the pointer.
** if endCase is 1, then pointing just after the child handle table is okay, and
** therefore nil will never be returned as the pointer.  Any cnum value out of
** range will be corrected (if possible) to be within range. */

#pragma segment TreeObj
TreeObjHndl	*GetChildHndlPtr(TreeObjHndl phndl, short *cnum, short endCase)
{
	TreeObjPtr	ptr;
	short		nc;
	long		dhSize, tblOffset;

	ptr = *phndl;
	if (!((nc = ptr->numChildren) + endCase)) return(nil);

	if ((*cnum < 0) || (*cnum >= nc + endCase))
		*cnum = nc - 1 + endCase;

	dhSize    = sizeof(TreeObj) + ptr->dataSize;
	tblOffset = *cnum * sizeof(TreeObjHndl);
	return((TreeObjHndl *)((char *)ptr + dhSize + tblOffset));
}



/**********************************************************************/



/* Given a child handle, this returns the child number of that
** handle in the parent's child handle table. */

#pragma segment TreeObj
short	GetChildNum(TreeObjHndl hndl)
{
	TreeObjHndl	phndl, *tptr, th;
	short		nc, j;

	if (!(phndl = (*hndl)->parent)) return(-1);
		/* Child doesn't have a parent, and therefore it is a root. */

	j = 0;
	if (tptr = GetChildHndlPtr(phndl, &j, 0)) {
		nc  = (*phndl)->numChildren;
		for (; j < nc; ++j) {
			BlockMove(tptr++, &th, sizeof(TreeObjHndl));
			if (th == hndl) return(j);
		}
	}

	return(-1);
}



/**********************************************************************/
/**********************************************************************/



/* Adjusts the data size, either greater or smaller, depending on the sign of 'delta'. */

#pragma segment TreeObj
OSErr	AdjustDataSize(TreeObjHndl hndl, long delta)
{
	TreeObjPtr	ptr;
	long		dhSize, tblSize;
	char		*cptr;
	OSErr		err;

	ptr = *hndl;
	tblSize = ptr->numChildren * sizeof (TreeObjHndl);
	dhSize  = sizeof(TreeObj) + ptr->dataSize;

	if (!(delta & 0x80000000L)) {
		SetHandleSize((Handle)hndl, ((dhSize + tblSize + delta) | 0x1F) + 1);
		if (err = MemError()) return(err);
		ptr = *hndl;
	}

	cptr = (char *)ptr + dhSize;
	BlockMove(cptr, cptr + delta, tblSize);
	ptr->dataSize += delta;

	if (delta & 0x80000000L)
		SetHandleSize((Handle)hndl, ((dhSize + tblSize + delta) | 0x1F) + 1);

	return(noErr);
}



/**********************************************************************/



/* Sets the data size to newSize. */

#pragma segment TreeObj
OSErr	SetDataSize(TreeObjHndl hndl, long newSize)
{
	return(AdjustDataSize(hndl, newSize - (*hndl)->dataSize));
}



/**********************************************************************/



/* Slides some of the data in the data portion of the object starting at
** 'offset' by a 'delta' amount, either forward or backward, depending
** on the sign of 'delta'. */

#pragma segment TreeObj
OSErr	SlideData(TreeObjHndl hndl, long offset, long delta)
{
	long	dataSize;
	char	*cptr;
	OSErr	err;

	dataSize = (*hndl)->dataSize;

	if (!(delta & 0x80000000L))
		if (err = AdjustDataSize(hndl, delta)) return(err);

	cptr = (char *)GetDataPtr(hndl) + offset;
	BlockMove(cptr, cptr + delta, dataSize - offset);

	if (delta & 0x80000000L)
		AdjustDataSize(hndl, delta);

	return(noErr);
}



/**********************************************************************/



/* Returns a pointer to the beginning of the object's data area.
** THIS DOES NOT LOCK THE HANDLE!!  The pointer may become invalid
** if memory moves. */

#pragma segment TreeObj
void	*GetDataPtr(TreeObjHndl hndl)
{
	return(*hndl + 1);
}



/**********************************************************************/
/**********************************************************************/



/* Given an open file that has been previously written via WriteTree, this function
** is called to read the file data into ram.  The root object for the file is already
** created by InitDocument.  The file must be open, and the file position must be
** set to the byte location where the root object of the file starts.  Once this is
** so, just call this function with a reference to the root object and the open file
** refrence number. */

#pragma segment TreeObj
OSErr	ReadTree(TreeObjHndl hndl, short fileRefNum)
{
	OSErr	err;

	if (err = ReadBranch(hndl, fileRefNum)) {
		while ((*hndl)->numChildren)
			DisposeChild(NO_EDIT, hndl, 0);
	}
	else {
		DoNumberTree(hndl);
		DoFTreeMethod(hndl, CONVERTMESSAGE, CONVERTTOHNDL);
	}

	return(err);
}



/**********************************************************************/



/* This is an internal function for recursively reading the data from the
** open file. */

#pragma segment TreeObj
static OSErr	ReadBranch(TreeObjHndl hndl, short fileRefNum)
{
	TreeObjHndl		chndl;
	TreeObjProcPtr	proc;
	short			numChildren, cnum;
	OSErr			err;

	if (err = ReadTreeObjHeader(hndl, fileRefNum)) {
		(*hndl)->numChildren = 0;	/* So we can dispose the portion that was read. */
		return(err);
	}

	numChildren = (*hndl)->numChildren;	/* So we can dispose of a partial read if */
	(*hndl)->numChildren = 0;			/* we have a failure after this point.    */

	if (proc = gTreeObjMethods[(*hndl)->type])
		err = (*proc)(hndl, FREADMESSAGE, fileRefNum);
	else
		err = ReadTreeObjData(hndl, fileRefNum);

	if (err) return(err);

	for (cnum = 0; cnum < numChildren; ++cnum) {
		if (!(chndl = NewRootObj(EMPTYOBJ, 0))) return(memFullErr);
		if (InsertChildHndl(hndl, chndl, cnum)) {
			DisposeObjAndOffspring(chndl);
			return(memFullErr);
		}
		if (err = ReadBranch(chndl, fileRefNum)) return(err);
	}

	return(noErr);
}



/**********************************************************************/



#pragma segment TreeObj
static OSErr	ReadTreeObjHeader(TreeObjHndl hndl, short fileRefNum)
{
	TreeObj		header;
	TreeObjHndl	parent;
	OSErr		err;
	long		count;

	count = sizeof(TreeObj) - sizeof(TreeObjHndl);
	if (!(err = FSRead(fileRefNum, &count, &header))) {
		parent = (*hndl)->parent;
		**hndl = header;
		(*hndl)->parent = parent;
	}

	return(err);
}



/**********************************************************************/



/* Read in dataSize number of bytes into the object. */

#pragma segment TreeObj
OSErr	ReadTreeObjData(TreeObjHndl hndl, short fileRefNum)
{
	long	dataSize;
	OSErr	err;
	char	hstate;
	Ptr		dataPtr;

	if (!(err = SetDataSize(hndl, dataSize = (*hndl)->dataSize))) {
		hstate = HGetState((Handle)hndl);
		HLock((Handle)hndl);
		dataPtr = GetDataPtr(hndl);
		err     = FSRead(fileRefNum, &dataSize, dataPtr);
		HSetState((Handle)hndl, hstate);
	}

	return(err);
}



/**********************************************************************/



/* Given an open file that is ready to be written to, this function is called to
** write the file tree to the designated file. */

#pragma segment TreeObj
OSErr	WriteTree(TreeObjHndl hndl, short fileRefNum)
{
	TreeObjProcPtr	proc;
	short			cnum;
	OSErr			err;

	err = WriteTreeObjHeader(hndl, fileRefNum);
	if (!err) {

		DoTreeObjMethod(hndl, CONVERTMESSAGE, CONVERTTOID);
			/* Ready data to be written to file.  Any references to handles are invalid
			** when written to disk.  These need to be converted to a reference that
			** makes sense when read in from disk when a file is opened.  The standard
			** way to do this is to convert the handle reference to a tree-obj-number
			** reference.  Prior to WriteTree() being called, DoNumberTree() is called.
			** DoNumberTree() walks the tree and numbers each handle sequentially, thus
			** giving each handle a unique id number. */

		if (proc = gTreeObjMethods[(*hndl)->type])
			err = (*proc)(hndl, FWRITEMESSAGE, fileRefNum);
		else
			err = WriteTreeObjData(hndl, fileRefNum);

		DoTreeObjMethod(hndl, CONVERTMESSAGE, CONVERTTOHNDL);
			/* Undo any id references back to handle references. */
	}


	if (!err) {
		for (cnum = 0; cnum < (*hndl)->numChildren; ++cnum)
			if (err = WriteTree(GetChildHndl(hndl, cnum), fileRefNum)) break;
	}

	return(err);
}



/**********************************************************************/



#pragma segment TreeObj
static OSErr	WriteTreeObjHeader(TreeObjHndl hndl, short fileRefNum)
{
	TreeObj	header;
	OSErr	err;
	long	count;

	header = **hndl;
	count = sizeof(TreeObj) - sizeof(TreeObjHndl);
	err = FSWrite(fileRefNum, &count, &header);

	return(err);
}



/**********************************************************************/



/* Write out dataSize number of bytes from the object. */

#pragma segment TreeObj
OSErr	WriteTreeObjData(TreeObjHndl hndl, short fileRefNum)
{
	long	dataSize;
	OSErr	err;
	char	hstate;
	Ptr		dataPtr;

	dataSize = (*hndl)->dataSize;

	hstate  = HGetState((Handle)hndl);
	HLock((Handle)hndl);
	dataPtr = GetDataPtr(hndl);
	err     = FSWrite(fileRefNum, &dataSize, dataPtr);
	HSetState((Handle)hndl, hstate);

	return(err);
}



/**********************************************************************/



/* Call the object for each member of the tree (or branch) starting
** from the back of the tree working forward. */

#pragma segment TreeObj
void	DoBTreeMethod(TreeObjHndl hndl, short message, long data)
{
	short	cnum;

	DoTreeObjMethod(hndl, message, data);

	for (cnum = (*hndl)->numChildren; cnum;)
		DoBTreeMethod(GetChildHndl(hndl, --cnum), message, data);
}



/**********************************************************************/



/* Same as DoBTreeMethod, except that an error aborts tree walk and returns error. */

#pragma segment TreeObj
OSErr	DoErrBTreeMethod(TreeObjHndl hndl, short message, long data)
{
	short	cnum;
	OSErr	err;

	if (err = DoTreeObjMethod(hndl, message, data))
		return(err);

	for (cnum = (*hndl)->numChildren; cnum;)
		if (err = DoErrBTreeMethod(GetChildHndl(hndl, --cnum), message, data))
			return(err);

	return(noErr);
}



/**********************************************************************/



/* Call the object for each member of the tree (or branch) starting
** from the front of the tree working backward. */

#pragma segment TreeObj
void	DoFTreeMethod(TreeObjHndl hndl, short message, long data)
{
	short	cnum;

	DoTreeObjMethod(hndl, message, data);

	for (cnum = 0; cnum < (*hndl)->numChildren; ++cnum) 
		DoFTreeMethod(GetChildHndl(hndl, cnum), message, data);
}



/**********************************************************************/



/* Same as DoFTreeMethod, except that an error aborts tree walk and returns error. */

#pragma segment TreeObj
OSErr	DoErrFTreeMethod(TreeObjHndl hndl, short message, long data)
{
	short	cnum;
	OSErr	err;

	if (err = DoTreeObjMethod(hndl, message, data))
		return(err);

	for (cnum = 0; cnum < (*hndl)->numChildren; ++cnum) 
		if (err = DoErrFTreeMethod(GetChildHndl(hndl, cnum), message, data))
			return(err);

	return(noErr);
}



/**********************************************************************/



/* If the object has a method procedure, call it.  If no method procedure,
** then do nothing. */

#pragma segment TreeObj
long	DoTreeObjMethod(TreeObjHndl hndl, short message, long data)
{
	TreeObjProcPtr	proc;

	if (proc = gTreeObjMethods[(*hndl)->type]) return((*proc)(hndl, message, data));
	return(0);
}



/**********************************************************************/



/* Number each member in the tree with a unique treeID.  The tree is number
** sequentially from front to back.  The first treeID number is 1.  0 is
** reserved for Hndl2ID/ID2Hndl conversions where it is possible that the
** handle value is nil.  The nil handle will convert to 0, and convert back
** to nil. */

#pragma segment TreeObj
void		DoNumberTree(TreeObjHndl hndl)
{
	DoNumberTree0(GetRootHndl(hndl));
}



/**********************************************************************/



#pragma segment TreeObj
static void	DoNumberTree0(TreeObjHndl hndl)
{
	short			cnum;
	static short	nodeNum;

	if (!(*hndl)->parent)
		nodeNum = 0;
	(*hndl)->treeID = ++nodeNum;

	for (cnum = 0; cnum < (*hndl)->numChildren; ++cnum)
		DoNumberTree0(GetChildHndl(hndl, cnum));
}



/**********************************************************************/



/* This function is used to convert a handle reference into a treeID reference.
** A pointer to the handle reference is passed in.  Typical usage will be where
** a handle object has a reference to another handle object.  Handle object
** references aren't meaningful when saved to disk, and therefore don't persist
** in their native form.  These handle references need to be converted into
** a treeID reference so that they can be saved.
** The tree first needs to be numbered so that the treeID references are unique
** and meaningful.  The tree is numbered by first calling DoNumberTree().  It
** numbers all the members of the tree hierarchy uniquely and sequentially. */

#pragma segment TreeObj
void	Hndl2ID(TreeObjHndl *hndl)
{
	if (*hndl)
		*hndl = (TreeObjHndl)(**hndl)->treeID;
}



/**********************************************************************/



/* Given a tree object ID and a reference object (any member of the tree),
** return the cooresponding object handle.  DoNumberTree() must be called
** prior to using this function, and after the last change to the tree, as
** it generates the object treeID numbers for the entire tree. */

#pragma segment TreeObj
void	ID2Hndl(TreeObjHndl refHndl, TreeObjHndl *hndl)
{
	short		cnum;
	TreeObjHndl	chndl;

	if ((!refHndl) || (!*hndl)) return;

	refHndl = GetRootHndl(refHndl);
	for (;;) {
		if ((*refHndl)->treeID == (long)*hndl) {
			*hndl = refHndl;
			return;
		}
		if (!(cnum = (*refHndl)->numChildren)) return;
		for (; cnum;) {
			chndl = GetChildHndl(refHndl, --cnum);
			if ((*chndl)->treeID <= (long)*hndl) {
				refHndl = chndl;
				break;
			}
		}
	}
}



/**********************************************************************/



/* Given an object handle, return the undo handle. */

#pragma segment TreeObj
TreeObjHndl	GetUndoHndl(TreeObjHndl undo)
{
	for (; (*undo)->parent; undo = (*undo)->parent);
	if ((*undo)->type == ROOTOBJ)
		undo = mDerefRoot(undo)->undo;
	return(undo);
}



/**********************************************************************/



/* Used to close out an old undo task.  Closing out the old task means that
** any editing to the document will be recorded into a new undo task.  Use
** this to separate two edits of the same edit type that would otherwise
** get recorded into the same undo task. */

#pragma segment TreeObj
void	NewUndo(TreeObjHndl hndl)
{
	TreeObjHndl	undo;

	undo = GetUndoHndl(hndl);
	mDerefUndo(undo)->lastEditType = NO_EDIT;
	mDerefUndo(undo)->disabled     = false;
}



/**********************************************************************/



/* If an edit fails, it can be backed out of by calling this.  All edits
** that were done will be undone, thus recovering the state of the
** document prior to the edit. */

#pragma segment TreeObj
void	RevertEdit(TreeObjHndl hndl)
{
	TreeObjHndl	root;
	FileRecHndl	frHndl;
	Boolean		docDirty;

	root     = GetRootHndl(hndl);
	frHndl   = mDerefRoot(root)->frHndl;
	docDirty = (*frHndl)->fileState.docDirty;

	DoUndoTask(hndl, DOUNDO, false);
		/* Use the undo mechanism to back out of the edit task. */

	DisposeChild(NO_EDIT, GetUndoHndl(hndl), -1);
		/* Get rid of the undo that was just used to revert.
		** Leave the rest of the undos. */

	(*frHndl)->fileState.docDirty = docDirty;
}



/**********************************************************************/



/* Call this to undo or redo editing to the document.  If redo is false,
** the it is an undo task. */

#pragma segment TreeObj
void	DoUndoTask(TreeObjHndl hndl, Boolean redo, Boolean fixup)
{
	FileRecHndl	frHndl;
	TreeObjHndl	undo, undoTask, undoPart;
	short		numUndos, undoDepth, undoPartNum;
	short		beg, end, inc;
	Point		contOrg;

	NewUndo(undo = GetUndoHndl(hndl));

	numUndos  = (*undo)->numChildren;
	undoDepth = mDerefUndo(undo)->undoDepth;

	if ((redo) && (numUndos == undoDepth)) return;
	if (!(numUndos | undoDepth)) return;

	frHndl = mDerefUndo(undo)->frHndl;

	if (redo) undoDepth++;
	undoTask = GetChildHndl(undo, --undoDepth);

	if (!redo) {
		GetContentOrigin((*frHndl)->fileState.window, &contOrg);
		mDerefUndoTask(undoTask)->redoOrigin = contOrg;
		contOrg = mDerefUndoTask(undoTask)->undoOrigin;
	}
	else contOrg = mDerefUndoTask(undoTask)->redoOrigin;

	if (fixup)
		DoUndoFixup(frHndl, contOrg, 0);
			/* Prepare for undo task, such as deselecting the current selection so
			** that the undone stuff can be displayed as the only selected stuff. */

	beg = (*undoTask)->numChildren - 1;
	end = -1;
	inc = -1;
	if (redo) {
		end = ++beg;
		beg = 0;
		inc = 1;
	}

	for (undoPartNum = beg; undoPartNum != end; undoPartNum += inc) {
		undoPart = GetChildHndl(undoTask, undoPartNum);
		switch(mDerefUndoPart(undoPart)->actionType) {
			case NEW_CHILD:
				UndoNewChild(undoPart);
				break;
			case DISPOSE_CHILD:
				UndoDisposeChild(undoPart);
				break;
			case MOVE_CHILD:
				UndoMoveChild(undoPart);
				break;
			case CHANGE_CHILD:
				UndoModifyChild(undoPart);
				break;
			case SWAP_CHILDREN:
				UndoSwapChildren(undoPart);
				break;
		}
	}

	inc = -1;
	if (redo)
		inc = 1;

	mDerefUndo(undo)->undoDepth += inc;

	if (fixup)
		DoUndoFixup(frHndl, contOrg, 1);
			/* Clean up and redisplay after undo task. */

	SetDocDirty(frHndl);
}



/**********************************************************************/



#pragma segment TreeObj
static TreeObjHndl	GetUndoTaskHndl(TreeObjHndl undo, short editType)
{
	TreeObjHndl		lastTaskHndl;
	short			lastEditType, undoDepth, addNewUndo, numUndoLevels, maxNumUndos;
	Point			contOrg;
	FileRecHndl		frHndl;
	WindowPtr		window;

	if (!(maxNumUndos = mDerefUndo(undo)->maxNumUndos)) return(nil);

	lastEditType = mDerefUndo(undo)->lastEditType;
	undoDepth    = mDerefUndo(undo)->undoDepth;

	addNewUndo = false;
	if (editType != lastEditType)
		addNewUndo = true;
	if (!(numUndoLevels = (*undo)->numChildren))
		addNewUndo = true;

	while (undoDepth < numUndoLevels) {
		DisposeChild(NO_EDIT, undo, --numUndoLevels);
		addNewUndo = true;		/* Flushing old also indicates a new undo. */
	}							/* undoDepth now is the same as numUndoLevels. */

	lastTaskHndl = nil;
	if (!addNewUndo) {
		lastTaskHndl = GetChildHndl(undo, -1);		/* Get last child handle. */
		if ((editType) && (editType != mDerefUndoTask(lastTaskHndl)->editType))
			lastTaskHndl = nil;
	}

	if (!lastTaskHndl) {
		while (numUndoLevels >= maxNumUndos) {
			DisposeChild(NO_EDIT, undo, 0);
			mDerefUndo(undo)->undoDepth--;
			numUndoLevels--;
		}	/* Restrict number of undos to designated level. */

		if (lastTaskHndl = NewChild(NO_EDIT, undo, numUndoLevels, UNDOTASKOBJ, 0)) {
			mDerefUndo(undo)->lastEditType = editType;
			mDerefUndo(undo)->undoDepth++;
			frHndl = mDerefUndo(undo)->frHndl;
			window = (*frHndl)->fileState.window;
			GetContentOrigin(window, &contOrg);
			mDerefUndoTask(lastTaskHndl)->editType   = editType;
			mDerefUndoTask(lastTaskHndl)->undoOrigin = contOrg;
			mDerefUndoTask(lastTaskHndl)->redoOrigin = contOrg;
		}
	}

	return(lastTaskHndl);
}



/**********************************************************************/



#pragma segment TreeObj
static TreeObjHndl	NewUndoPart(TreeObjHndl taskHndl, short action, TreeObjHndl shndl, short scnum,
								TreeObjHndl dhndl, short dcnum, Boolean deepCopy)
{
	TreeObjHndl	partHndl;
	UndoPartObj	*partPtr;

	partHndl = NewChild(NO_EDIT, taskHndl, -1, UNDOPARTOBJ, 0);	/* Add new child to end. */
	if (partHndl) {
		partPtr = GetDataPtr(partHndl);
		partPtr->actionType = action;
		partPtr->shndl      = shndl;
		partPtr->scnum      = scnum;
		partPtr->dhndl      = dhndl;
		partPtr->dcnum      = dcnum;
		partPtr->deepCopy   = deepCopy;
	}

	return(partHndl);
}



/**********************************************************************/



#pragma segment TreeObj
static OSErr	PostNewChild(short editType, TreeObjHndl phndl, short cnum)
{
	TreeObjHndl	undo, task;

	if (!editType) return(noErr);

	undo = GetUndoHndl(phndl);
	if (mDerefUndo(undo)->disabled) return(noErr);

	if (task = GetUndoTaskHndl(undo, editType))
		if (NewUndoPart(task, NEW_CHILD, phndl, cnum, nil, 0, false)) return(noErr);

	return(memFullErr);
}



/**********************************************************************/



#pragma segment TreeObj
static OSErr	PostDisposeChild(short editType, TreeObjHndl phndl, short cnum)
{
	TreeObjHndl	undo, task, part;

	if (!editType) return(noErr);

	undo = GetUndoHndl(phndl);
	if (mDerefUndo(undo)->disabled) return(noErr);

	if (task = GetUndoTaskHndl(undo, editType)) {
		part = NewUndoPart(task, DISPOSE_CHILD, phndl, cnum, nil, 0, false);
		if (part) {
			MoveChild(NO_EDIT, phndl, cnum, part, -1);
			return(noErr);
		}
	}

	return(memFullErr);
}



/**********************************************************************/



#pragma segment TreeObj
static void	PostMoveChild(short editType, TreeObjHndl shndl, short scnum, TreeObjHndl dhndl, short dcnum)
{
	TreeObjHndl	undo, task;

	if (editType) {
		undo = GetUndoHndl(shndl);
		if (!mDerefUndo(undo)->disabled)
			if (task = GetUndoTaskHndl(undo, editType))
				NewUndoPart(task, MOVE_CHILD, shndl, scnum, dhndl, dcnum, false);
	}
}



/**********************************************************************/



#pragma segment TreeObj
static void	PostSwapChildren(short editType, TreeObjHndl hndla, short cnuma, TreeObjHndl hndlb, short cnumb)
{
	TreeObjHndl	undo, task;

	if (editType) {
		undo = GetUndoHndl(hndla);
		if (!mDerefUndo(undo)->disabled)
			if (task = GetUndoTaskHndl(undo, editType))
				NewUndoPart(task, SWAP_CHILDREN, hndla, cnuma, hndlb, cnumb, false);

	}
}



/**********************************************************************/



#pragma segment TreeObj
static void	UndoNewChild(TreeObjHndl undoPart)
{
	TreeObjHndl	shndl, chndl;
	short		scnum;

	shndl = mDerefUndoPart(undoPart)->shndl;
	scnum = mDerefUndoPart(undoPart)->scnum;
	mDerefUndoPart(undoPart)->actionType = DISPOSE_CHILD;

	chndl = GetChildHndl(shndl, scnum);
	MoveChild(NO_EDIT, shndl, scnum, undoPart, 0);
}



/**********************************************************************/



#pragma segment TreeObj
static void	UndoDisposeChild(TreeObjHndl undoPart)
{
	TreeObjHndl	shndl, chndl;
	short		scnum;

	shndl = mDerefUndoPart(undoPart)->shndl;
	scnum = mDerefUndoPart(undoPart)->scnum;
	mDerefUndoPart(undoPart)->actionType = NEW_CHILD;

	chndl = GetChildHndl(undoPart, 0);
	MoveChild(NO_EDIT, undoPart, 0, shndl, scnum);
}



/**********************************************************************/



#pragma segment TreeObj
static void	UndoMoveChild(TreeObjHndl undoPart)
{
	TreeObjHndl	shndl, dhndl;
	short		scnum, dcnum;

	shndl = mDerefUndoPart(undoPart)->shndl;
	scnum = mDerefUndoPart(undoPart)->scnum;
	dhndl = mDerefUndoPart(undoPart)->dhndl;
	dcnum = mDerefUndoPart(undoPart)->dcnum;

	MoveChild(NO_EDIT, dhndl, dcnum, shndl, scnum);

	mDerefUndoPart(undoPart)->shndl = dhndl;
	mDerefUndoPart(undoPart)->scnum = dcnum;
	mDerefUndoPart(undoPart)->dhndl = shndl;
	mDerefUndoPart(undoPart)->dcnum = scnum;
}



/**********************************************************************/



#pragma segment TreeObj
static void	UndoModifyChild(TreeObjHndl undoPart)
{
	TreeObjHndl	shndl, dchndl, uchndl;
	short		scnum;

	shndl = mDerefUndoPart(undoPart)->shndl;
	scnum = mDerefUndoPart(undoPart)->scnum;

	dchndl = GetChildHndl(shndl, scnum);	/* Document child handle. */
	uchndl = GetChildHndl(undoPart, 0);		/* Undo child handle. */

	UndoModifyChildren(dchndl, uchndl, mDerefUndoPart(undoPart)->deepCopy);
}



/**********************************************************************/



#pragma segment TreeObj
static void	UndoModifyChildren(TreeObjHndl dhndl, TreeObjHndl uhndl, Boolean deepCopy)
{
	TreeObjHndl	dchndl, uchndl;
	short		i;

	DoTreeObjMethod(dhndl, UNDOMESSAGE, UNDOFROMDOC);	/* Old data leaving document. */
	SwapTreeObjData(dhndl, uhndl);
	DoTreeObjMethod(dhndl, UNDOMESSAGE, UNDOTODOC);		/* New data entering document. */

	if (deepCopy) {
		for (i = (*dhndl)->numChildren; i;) {
			dchndl = GetChildHndl(dhndl, --i);
			uchndl = GetChildHndl(uhndl, i);
			UndoModifyChildren(dchndl, uchndl, deepCopy);
		}
	}
}



/**********************************************************************/



#pragma segment TreeObj
static void	UndoSwapChildren(TreeObjHndl undoPart)
{
	TreeObjHndl	shndl, dhndl, schndl, dchndl;
	short		scnum, dcnum;

	shndl = mDerefUndoPart(undoPart)->shndl;
	scnum = mDerefUndoPart(undoPart)->scnum;
	dhndl = mDerefUndoPart(undoPart)->dhndl;
	dcnum = mDerefUndoPart(undoPart)->dcnum;

	schndl = GetChildHndl(shndl, scnum);
	dchndl = GetChildHndl(dhndl, dcnum);

	DoTreeObjMethod(schndl, UNDOMESSAGE, UNDOFROMDOC);
	DoTreeObjMethod(dchndl, UNDOMESSAGE, UNDOFROMDOC);

	SwapChildren(NO_EDIT, shndl, scnum, dhndl, dcnum);

	DoTreeObjMethod(schndl, UNDOMESSAGE, UNDOTODOC);
	DoTreeObjMethod(dchndl, UNDOMESSAGE, UNDOTODOC);
}



/**********************************************************************/



/* Dispose of all undo information and prevent further undo collection.
** Calling NewUndo() will re-enable undo collection. */

#pragma segment TreeObj
void	DisableUndo(TreeObjHndl hndl)
{
	TreeObjHndl	undo;

	undo = GetUndoHndl(hndl);
	while ((*undo)->numChildren) DisposeChild(NO_EDIT, undo, 0);

	mDerefUndo(undo)->undoDepth = 0;
	mDerefUndo(undo)->disabled  = true;
}



/**********************************************************************/



/* Dispose of all undo information and prevent further undo collection.
** Calling NewUndo() will re-enable undo collection. */

#pragma segment TreeObj
void	DisposeUndos(TreeObjHndl hndl)
{
	DisableUndo(hndl);
	NewUndo(hndl);
}



/**********************************************************************/



/* Dispose of all undo information except the current undo.  The current undo
** may still be active, and it may be needed to back out of an edit operation. */

#pragma segment TreeObj
Boolean	PurgeUndo(TreeObjHndl hndl)
{
	TreeObjHndl	undo;
	Boolean		didPurge;

	undo = GetUndoHndl(hndl);
	didPurge = false;
	while ((*undo)->numChildren > 1) {
		DisposeChild(NO_EDIT, undo, 0);
		didPurge = true;
	}

	return(didPurge);
}



/**********************************************************************/



#pragma segment TreeObj
void	GetUndoInfo(FileRecHndl frHndl, short *undoDepth, short *numUndos)
{
	TreeObjHndl	undo;

	*undoDepth = *numUndos = 0;
	if ((*frHndl)->fileState.readOnly) return;

	undo = GetUndoHndl((*frHndl)->d.doc.root);
	if (!mDerefUndo(undo)->disabled) {
		*undoDepth = mDerefUndo(undo)->undoDepth;
		*numUndos  = (*undo)->numChildren;
	}
}



/*****************************************************************************/
/*****************************************************************************/



/* This function does the standard document initialization. */

#pragma segment TreeObj
OSErr	DefaultInitDocument(FileRecHndl frHndl, short version, short numUndos, short numSaveUndos)
{
	TreeObjHndl	root, undo;
	OSErr		err;

	err = noErr;

	(*frHndl)->d.doc.fhInfo.version = version;

	(*frHndl)->fileState.readDocumentHeaderProc  = DefaultReadDocumentHeader;
	(*frHndl)->fileState.writeDocumentHeaderProc = DefaultWriteDocumentHeader;

	if (root = NewRootObj(ROOTOBJ, 0)) {		/* Create hierarchical data root. */
		(*frHndl)->d.doc.root = root;			/* Link file to hierarchical data. */
		undo = NewRootObj(UNDOOBJ, 0);			/* Create hierarchical undo root. */
		mDerefRoot(root)->undo    = undo;		/* Save hierarchical undo root. */
		mDerefRoot(root)->frHndl  = frHndl;
		if (undo) {
			(*frHndl)->fileState.defaultDoc = true;
			mDerefUndo(undo)->root   = root;	/* Point undo back at file root. */
			mDerefUndo(undo)->frHndl = frHndl;
			mDerefUndo(undo)->maxNumUndos  = numUndos;
			mDerefUndo(undo)->numSaveUndos = numSaveUndos;
		}
		else {
			DefaultFreeDocument(frHndl);
			err = memFullErr;
		}
	}
	else err = memFullErr;

	return(err);
}



/*****************************************************************************/



/* Frees up the hierarchical document and undo portions of a default document. */

#pragma segment TreeObj
OSErr	DefaultFreeDocument(FileRecHndl frHndl)
{
	TreeObjHndl	root, undo;

	if (root = (*frHndl)->d.doc.root) {			/* If we have a valid root object... */
		if (undo = mDerefRoot(root)->undo)		/* If we have a valid undo object... */
			DisposeObjAndOffspring(undo);		/* Dispose of undo info. */
		DisposeObjAndOffspring(root);			/* Dispose of hierarchical file data. */
		(*frHndl)->d.doc.root = nil;
	}
	return(noErr);
}



/*****************************************************************************/



#pragma segment TreeObj
OSErr	DefaultReadDocument(FileRecHndl frHndl)
{
	OSErr		err;
	TreeObjHndl	root, undo;
	short		resID, refNum, flags;
	Movie		movie;
	Boolean		wasChanged;

	refNum = (*frHndl)->fileState.refNum;
	err    = SetFPos(refNum, fsFromStart, 0);
		/* Set the file position to the beginning of the file. */

	err = DoReadDocumentHeader(frHndl);

	if (!err) {
		if ((*frHndl)->fileState.sfType == MovieFileType) {
			resID  = 0;
			flags  = (*frHndl)->fileState.movieFlags;
			err = NewMovieFromFile(&movie, refNum, &resID, nil, flags, &wasChanged);
			if (err) return(err);
			(*frHndl)->fileState.movie                  = movie;
			(*frHndl)->fileState.movieResID             = resID;
			(*frHndl)->fileState.movieDataRefWasChanged = wasChanged;
		}
		else {
			root = (*frHndl)->d.doc.root;		/* Preserve the undo field.  Preserving  */
			undo = mDerefRoot(root)->undo;		/* any application-sepcific fields is up */
												/* to the application.					 */
			err = ReadTree(root, refNum);
				/* Read in the hierarchical file data portion. */

			mDerefRoot(root)->undo   = undo;	/* Restore the 2 over-written fields. */
			mDerefRoot(root)->frHndl = frHndl;
		}
	}

	return(err);
}



/*****************************************************************************/



#pragma segment TreeObj
OSErr	DefaultReadDocumentFixup(FileRecHndl frHndl)
{
	TreeObjHndl	root, undo, chndl;

	root = (*frHndl)->d.doc.root;
	undo = mDerefRoot(root)->undo;
	for (;;) {
		if (!(chndl = GetChildHndl(root, -1))) break;
		if ((*chndl)->type != UNDOTASKOBJ)     break;
		MoveChild(NO_EDIT, root, -1, undo, -1);
		mDerefUndo(undo)->undoDepth++;
			/* Move any undo tasks that were saved with the document
			** out of the document and into the undo hierarchy. */
	}

	return(noErr);
}



/*****************************************************************************/



#pragma segment TreeObj
OSErr	DefaultWriteDocument(FileRecHndl frHndl)
{
	short		refNum, cnum, numSaveUndos;
	OSErr		err;
	long		fpos;
	TreeObjHndl	root, undo, chndl;

	refNum = (*frHndl)->fileState.refNum;
	err    = DoWriteDocumentHeader(frHndl);

	if (!err) {
		if ((*frHndl)->fileState.sfType != MovieFileType) {
			undo         = GetUndoHndl(root = (*frHndl)->d.doc.root);
			numSaveUndos = mDerefUndo(undo)->numSaveUndos;
			for (cnum = mDerefUndo(undo)->undoDepth; ((cnum) && (numSaveUndos)); --numSaveUndos)
				MoveChild(NO_EDIT, undo, --cnum, root, -1);
					/* Move the designated number of undo tasks into the document side.
					** They will be saved to disk this way.  The designated number may be
					** zero, which means that undos aren't saved to disk. */

			DoNumberTree(root);
				/* Assign each object in the tree a unique treeID.  This will allow
				** the objects to convert handle references into ID references so that
				** the data can be saved to disk. */

			err = WriteTree(root, refNum);
				/* Write out the hierarchical data.  This includes the data in the root object.
				** When reading a data file, the root object data has already been initialized,
				** and therefore reading in the old root data from disk is a bad thing.  This is
				** handled by caching the root data prior to reading in a file, and then
				** restoring the data after the ReadTree() call has been made. */

			for (;;) {
				if (!(chndl = GetChildHndl(root, -1))) break;
				if ((*chndl)->type != UNDOTASKOBJ)     break;
				MoveChild(NO_EDIT, root, -1, undo, cnum++);
					/* Move any undo tasks that we previously moved into the document
					** out of the document and back into the undo hierarchy. */
			}

			if (!err) {
				err = GetFPos(refNum, &fpos);
				if (!err)
					err = SetEOF(refNum, fpos);
			}			/* The document may be shorter than last time it was written to disk.
						** Handle this case by ending the file based on the new length. */
		}
		else {
		}
	}

	return(err);
}



/**********************************************************************/
/**********************************************************************/
/**********************************************************************/



#pragma segment TreeObj
OSErr	HReadTree(TreeObjHndl hndl, Handle tree)
{
	OSErr	err;

	if (!GetHandleSize(tree)) return(noErr);

	if (err = HReadBranch(hndl, tree)) {
		while ((*hndl)->numChildren)
			DisposeChild(NO_EDIT, hndl, 0);
	}
	else {
		DoNumberTree(hndl);
		DoFTreeMethod(hndl, CONVERTMESSAGE, CONVERTTOHNDL);
	}

	return(err);
}



/**********************************************************************/



/* This function recursively dissects the handle into separate tree objects.  The handle
** has previously had tree objects streamed into it.  The public format is as follows:
** 1) object header
** 2) data length (4 bytes)
** 3) data
**
** After the object is created, the header is moved into it.  Then the data length is
** fetched and a data handle is created to hold the data portion of the streamed data
** for this object.  Once the data handle holds the object data, the tree handle has
** the information for this object removed from it.
** After this data separation, we call the object and pass it the data handle.
** The object is responsible for interpreting the handle and initializing the data
** portion of the object with it. */

#pragma segment TreeObj
OSErr	HReadBranch(TreeObjHndl hndl, Handle tree)
{
	TreeObjHndl		chndl;
	Handle			treeObjData;
	TreeObjProcPtr	proc;
	short			numChildren, cnum;
	long			size, diff;
	OSErr			err;

	if (GetHandleSize(tree) < sizeof(TreeObj)) return(paramErr);

	BlockMove(*tree, *hndl, sizeof(TreeObj) - sizeof(TreeObjHndl));

	numChildren = (*hndl)->numChildren;	/* So we can dispose of a partial read if */
	(*hndl)->numChildren = 0;			/* we have a failure after this point.    */

	BlockMove((long *)(*tree + sizeof(TreeObj) - sizeof(TreeObjHndl)), (Ptr)&size, sizeof(size));
		/* Get the size of the data following the header data. */

	if (!(treeObjData = NewHandle(size)))
		return(memFullErr);
			/* Create a handle the size of the data. */

	BlockMove(*tree + sizeof(TreeObj), *treeObjData, size);
		/* Copy the data into the handle. */

	diff = sizeof(TreeObj) + size;
	size = GetHandleSize(tree) - diff;
		/* Calculate how much we are going to shrink the tree handle. */

	BlockMove(*tree + diff, *tree, size);
	SetHandleSize(tree, size);

	if (proc = gTreeObjMethods[(*hndl)->type])
		err = (*proc)(hndl, HREADMESSAGE, (long)treeObjData);
	else
		err = HReadTreeObjData(hndl, treeObjData);

	DisposeHandle(treeObjData);

	if (err)
		return(err);

	for (cnum = 0; cnum < numChildren; ++cnum) {
		if (!(chndl = NewRootObj(EMPTYOBJ, 0))) return(memFullErr);
		if (InsertChildHndl(hndl, chndl, cnum)) {
			DisposeObjAndOffspring(chndl);
			return(memFullErr);
		}
		if (err = HReadBranch(chndl, tree))
			return(err);
	}

	return(noErr);
}



/**********************************************************************/



/* The simple handle read can assume that there will be no expansion or interpretation
** of the data.  This means that the dataSize field represents the correct data size. */

#pragma segment TreeObj
OSErr	HReadTreeObjData(TreeObjHndl hndl, Handle treeObjData)
{
	long	dataSize;
	OSErr	err;

	if (!(err = SetDataSize(hndl, dataSize = (*hndl)->dataSize)))
		BlockMove(*treeObjData, (Ptr)(*hndl + 1), dataSize);

	return(err);
}



/**********************************************************************/



/* Given an open file that is ready to be written to, this function is called to
** write the file tree to the designated file. */

#pragma segment TreeObj
OSErr	HWriteTree(TreeObjHndl hndl, Handle tree)
{
	TreeObjProcPtr	proc;
	Handle			data;
	short			cnum;
	OSErr			err;
	long			tsize, dsize;

	DoTreeObjMethod(hndl, CONVERTMESSAGE, CONVERTTOID);
		/* Ready data to be written to file.  Any references to handles are invalid
		** when written to disk.  These need to be converted to a reference that
		** makes sense when read in from disk when a file is opened.  The standard
		** way to do this is to convert the handle reference to a tree-obj-number
		** reference.  Prior to WriteTree() being called, DoNumberTree() is called.
		** DoNumberTree() walks the tree and numbers each handle sequentially, thus
		** giving each handle a unique id number. */

	if (!(data = NewHandle((*hndl)->dataSize)))
		return(memFullErr);

	if (proc = gTreeObjMethods[(*hndl)->type])
		err = (*proc)(hndl, HWRITEMESSAGE, (long)data);
	else
		err = HWriteTreeObjData(hndl, data);

	if (err) {
		DisposeHandle(data);
		return(err);
	}

	tsize = GetHandleSize(tree);
	dsize = GetHandleSize(data);
	SetHandleSize(tree, tsize + sizeof(TreeObj) + dsize);
	BlockMove((Ptr)*hndl,  (*tree + tsize), sizeof(TreeObj) - sizeof(TreeObjHndl));
	BlockMove((Ptr)&dsize, (*tree + tsize + sizeof(TreeObj) - sizeof(TreeObjHndl)), sizeof(long));
	BlockMove(*data,       (*tree + tsize + sizeof(TreeObj)), dsize);

	DisposeHandle(data);
	DoTreeObjMethod(hndl, CONVERTMESSAGE, CONVERTTOHNDL);
		/* Undo any id references back to handle references. */

	for (cnum = 0; cnum < (*hndl)->numChildren; ++cnum)
		if (err = HWriteTree(GetChildHndl(hndl, cnum), tree)) break;

	return(err);
}



/**********************************************************************/



/* Write out dataSize number of bytes from the object. */

#pragma segment TreeObj
OSErr	HWriteTreeObjData(TreeObjHndl hndl, Handle data)
{
	long	dataSize;
	OSErr	err;

	SetHandleSize(data, dataSize = (*hndl)->dataSize);
	if (err = MemError())
		return(err);

	BlockMove((Ptr)(*hndl + 1), *data, dataSize);
	return(noErr);
}



/**********************************************************************/
/**********************************************************************/



#pragma segment TreeObj
long	GetCData(TreeObjHndl hndl, long offset, char *data)
{
	Ptr		dptr;
	long	len;

	dptr = (Ptr)GetDataPtr(hndl) + offset;
	len  = clen(dptr);

	if (data)
		ccpy(data, dptr);

	return(len);
}



/**********************************************************************/



#pragma segment TreeObj
OSErr	PutCData(TreeObjHndl hndl, long offset, char *data)
{
	unsigned char	*dptr;
	long			oldl, newl;
	OSErr			err;

	dptr = (unsigned char *)GetDataPtr(hndl) + offset;

	oldl = clen((Ptr)dptr) + 1;
	newl = clen(data) + 1;

	if (err = SlideData(hndl, offset + oldl, newl - oldl)) return(err);

	dptr = (unsigned char *)GetDataPtr(hndl) + offset;
	ccpy((Ptr)dptr, data);

	return(noErr);
}



/**********************************************************************/



#pragma segment TreeObj
void	GetPData(TreeObjHndl hndl, long offset, StringPtr data)
{
	StringPtr	dptr;

	dptr = (StringPtr)GetDataPtr(hndl) + offset;
	pcpy(data, dptr);
}



/**********************************************************************/



#pragma segment TreeObj
OSErr	PutPData(TreeObjHndl hndl, long offset, StringPtr data)
{
	unsigned char	*dptr;
	long			oldl, newl;
	OSErr			err;

	dptr = (unsigned char *)GetDataPtr(hndl) + offset;

	oldl = *dptr + 1;
	newl = (*(unsigned char *)data) + 1;

	if (err = SlideData(hndl, offset + oldl, newl - oldl)) return(err);

	dptr = (unsigned char *)GetDataPtr(hndl) + offset;
	pcpy(dptr, data);

	return(noErr);
}



/**********************************************************************/



#pragma segment TreeObj
OSErr	PutShortData(TreeObjHndl hndl, long offset, void *data, unsigned short size)
{
	unsigned short	*dptr;
	long			oldl, newl;
	short			ss;
	OSErr			err;

	dptr = (unsigned short *)((unsigned char *)GetDataPtr(hndl) + offset);

	BlockMove(dptr, &ss, sizeof(short));
	oldl = ss    + sizeof(short);
	newl = size  + sizeof(short);

	if (err = SlideData(hndl, offset + oldl, newl - oldl)) return(err);

	dptr = (unsigned short *)((unsigned char *)GetDataPtr(hndl) + offset);
	BlockMove(&size, dptr, sizeof(short));
	BlockMove(data, dptr + 1, size);

	return(noErr);
}



/**********************************************************************/



#pragma segment TreeObj
OSErr	PutLongData(TreeObjHndl hndl, long offset, void *data, long size)
{
	unsigned long	*dptr, ll;
	long			oldl, newl;
	OSErr			err;

	dptr = (unsigned long *)((unsigned char *)GetDataPtr(hndl) + offset);

	BlockMove(dptr, &ll, sizeof(long));
	oldl = ll    + sizeof(long);
	newl = size  + sizeof(long);

	if (err = SlideData(hndl, offset + oldl, newl - oldl)) return(err);

	dptr = (unsigned long *)((unsigned char *)GetDataPtr(hndl) + offset);
	BlockMove(&size, dptr, sizeof(long));
	BlockMove(data, dptr + 1, size);

	return(noErr);
}



/**********************************************************************/



#pragma segment TreeObj
unsigned long	GetDataOffset(TreeObjHndl hndl, unsigned long offset, short dtype, short dnum)
{
	unsigned char	*dptr;
	short			ss;
	long			ll;

	while (dnum--) {
	dptr = (unsigned char *)GetDataPtr(hndl) + offset;
		switch (dtype) {
			case kCStr:
				offset += clen((Ptr)dptr) + 1;
				break;
			case kPStr:
				offset += *dptr + 1;
				break;
			case kSDataBlock:
				BlockMove(dptr, &ss, sizeof(short));
				offset += ss + sizeof(short);
				break;
			case kLDataBlock:
				BlockMove(dptr, &ll, sizeof(long));
				offset += ll + sizeof(long);
				break;
		}
	}

	return(offset);
}



/**********************************************************************/
/**********************************************************************/



#pragma segment TreeObj
Boolean	EqualTreeObjData(TreeObjHndl h1, TreeObjHndl h2)
{
	TreeObjProcPtr	proc;

	if ((h1) && (!h2)) return(false);
	if ((h2) && (!h1)) return(false);

	if ((*h1)->type != (*h2)->type) return(false);

	if (proc = gTreeObjMethods[(*h1)->type])
		return((*proc)(h1, COMPAREMESSAGE, (long)h2));
	else
		return(DefaultEqualTreeObjData(h1, h2));
}



/**********************************************************************/



#pragma segment TreeObj
Boolean	DefaultEqualTreeObjData(TreeObjHndl h1, TreeObjHndl h2)
{
	Ptr		p1, p2;
	long	ii, jj;

	if ((jj = (*h1)->dataSize) != (*h2)->dataSize) return(false);

	p1 = GetDataPtr(h1);
	p2 = GetDataPtr(h2);

	for (ii = 0; ii < jj; ++ii) {
		if (p1[ii] != p2[ii]) return(false);
	}

	return(true);
}



