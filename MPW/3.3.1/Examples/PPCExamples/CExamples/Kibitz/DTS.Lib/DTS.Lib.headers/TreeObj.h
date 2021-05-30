#ifndef __TREEOBJ__
#define __TREEOBJ__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef __MEMORY__
#include <Memory.h>
#endif

#define NO_EDIT 0						/* System edit type. */


/********/


#define EMPTYOBJ    0
#define ROOTOBJ     1
#define UNDOOBJ     2
#define UNDOTASKOBJ 3
#define UNDOPARTOBJ 4
#define WFMTOBJ     5
#define CTLOBJ      6

#define kCStr       0
#define kPStr       1
#define kSDataBlock 2
#define kLDataBlock 3

struct FileRec;
typedef struct FileRec *FileRecPtr, **FileRecHndl;

struct TreeObj;
typedef struct TreeObj *TreeObjPtr, **TreeObjHndl;
typedef long	(*TreeObjProcPtr)(TreeObjHndl hndl, short message, long data);

typedef struct TreeObj {
	short		type;
	short		numChildren;
	long		dataSize;
	long		treeID;
	TreeObjHndl	parent;
} TreeObj;

long	TUndoObj(TreeObjHndl hndl, short message, long data);
typedef struct {
	TreeObjHndl	root;
	FileRecHndl	frHndl;
	Boolean		disabled;
	short		lastEditType;
	short		undoDepth;
	short		maxNumUndos;
	short		numSaveUndos;
} UndoObj;

long	TUndoTaskObj(TreeObjHndl hndl, short message, long data);
typedef struct {
	short	editType;
	Point	undoOrigin;
	Point	redoOrigin;
} UndoTaskObj;

long	TUndoPartObj(TreeObjHndl hndl, short message, long data);
typedef struct {
	short		actionType;
	TreeObjHndl	shndl;
	short		scnum;
	TreeObjHndl	dhndl;
	short		dcnum;
	Boolean		deepCopy;
} UndoPartObj;

struct VHFormatData {
	Handle	text;
	char	*header;
	char	*data;
};
typedef struct VHFormatData VHFormatData;
typedef VHFormatData *VHFormatDataPtr;

#define mDerefUndo(hndl)     ((UndoObj*)((*hndl) + 1))
#define mDerefUndoTask(hndl) ((UndoTaskObj*)((*hndl) + 1))
#define mDerefUndoPart(hndl) ((UndoPartObj*)((*hndl) + 1))


/********/


#define INITMESSAGE        0		/* Additional object initialization. */
#define     CREATEINIT         0	/* Object being initially created. */
#define     WINDOWINIT         1	/* Document/object being assigned to a window. */
#define     NOWINDOWINIT       2	/* Document/object being freed from a window. */

#define FREEMESSAGE        1		/* Additional object disposal. */

#define COPYMESSAGE        2		/* Additional object cloning. */

#define UNDOMESSAGE        3		/* Additional object undo. */
#define     UNDOFROMDOC        0	/* Object leaving document. */
#define     UNDOTODOC          1	/* Object returning to document. */

#define CONVERTMESSAGE     4		/* Hndl2ID or ID2Hndl conversions. */
#define     CONVERTTOID        0	/* Convert handle references to ID references. */
#define     CONVERTTOHNDL    1		/* Convert ID references to handle references. */

#define FREADMESSAGE       5		/* Read object data from file. */
#define FWRITEMESSAGE      6		/* Write object data to file. */

#define HREADMESSAGE       7		/* Read object data from handle. */
#define HWRITEMESSAGE      8		/* Write object data to handle. */

#define HITTESTMESSAGE     9		/* Test if object was hit. */
#define     HITTESTOBJ         0	/* Test body of object for hit. */
#define     HITTESTGRABBER     1	/* Test sizing parts for hit. */
#define     CANBETARGET        2	/* Return true if object can become target. */
#define     CANTAKEKEYS        3	/* Return true if target can take keys. */

#define GETRGNMESSAGE      10		/* Return object defining rect. */
#define GETOBJRECTMESSAGE  11		/* Return object defining rect. */
#define SETOBJRECTMESSAGE  12		/* Set object bounding box. */
#define SECTOBJRECTMESSAGE 13		/* Check if rect intersects object bounding box. */

#define GETBBOXMESSAGE     14		/* Return rect that contains entire graphic image. */

#define DRAWMESSAGE        15		/* Draw some form of the object. */
#define     DRAWOBJ            0	/* Draw the object. */
#define     ERASEOBJ           1	/* Draw the object. */
#define     DRAWSELECT         2	/* Draw the selection portion of the object. */
#define     DRAWGHOST          3	/* Draw an xor-ghost (for dragging) of the image. */
#define     DRAWMASK           4	/* Draw a mask of the image (for offscreen layer masking.) */

#define PRINTMESSAGE       16

#define VHMESSAGE          17		/* Format View Hierarchy information for the object. */

#define COMPAREMESSAGE     18		/* Compare data of two objects of same type. */



#define DOUNDO 0
#define DOREDO 1



TreeObjHndl	NewRootObj(short ctype, long size);
	/* Creates an object with no parent.  This object will be the root object
	** for a tree.  Returns nil upon failure. */



TreeObjHndl	NewChild(short editType, TreeObjHndl parentHndl, short childNum, short ctype, long size);
	/* Creates a child of the specified type and adds it to the parent at the
	** specified location.  Returns nil upon failure. */



void		DisposeChild(short editType, TreeObjHndl parentHndl, short childNum);
	/* Disposes of the specified child and all offspring of that child. */



TreeObjHndl	CopyChild(short editType, TreeObjHndl shndl, short scnum, TreeObjHndl dhndl, short dcnum, Boolean deepCopy);
	/* Copies the specified child (and all offspring of that child if deepCopy is true). */



OSErr		MoveChild(short editType, TreeObjHndl shndl, short scnum, TreeObjHndl dhndl, short dcnum);
	/* Moves a child from one location on the tree to another. */



OSErr		ModifyChild(short editType, TreeObjHndl phndl, short cnum, Boolean deepCopy);
	/* Saves a copy of the child in the undo hierarchy for undo/redo purposes. */



OSErr		SwapChildren(short editType, TreeObjHndl hndla, short cnuma, TreeObjHndl hndlb, short cnumb);
	/* Swaps the child handles. */



OSErr		SwapTreeObjData(TreeObjHndl hndla, TreeObjHndl hndlb);
	/* Swaps the child data without swapping the handles. */



void		DisposeObjAndOffspring(TreeObjHndl childHndl);
	/* This disposes of the child and any offspring of that child.  It does not remove
	** the child from the parent's child handle table. */



OSErr		CopyChildren(TreeObjHndl shndl, TreeObjHndl dhndl);
	/* Copies the children (and children below that and so on) of one object to
	** another object.  Used internally by CopyChild for deep copies. */



OSErr		InsertChildHndl(TreeObjHndl parentHndl, TreeObjHndl childHndl, short childNum);
	/* Adds an existing child to a parent's child handle table. */



void		DeleteChildHndl(TreeObjHndl parentHndl, short childNum);
	/* Removes a child from the parent's child handle table. */



TreeObjHndl	GetRootHndl(TreeObjHndl hndl);
	/* Given an object handle, return the root handle. */



TreeObjHndl	GetChildHndl(TreeObjHndl parentHndl, short cnum);
	/* Given a parent handle and a child number, this returns the child handle. */



TreeObjHndl	*GetChildHndlPtr(TreeObjHndl parentHndl, short *childNum, short endCase);
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



short		GetChildNum(TreeObjHndl hndl);
	/* Given a child handle, this returns the child number of that
	** handle in the parent's child handle table. */



OSErr		AdjustDataSize(TreeObjHndl hndl, long delta);
	/* Adjusts the data size, either greater or smaller, depending on the sign of 'delta'. */



OSErr		SetDataSize(TreeObjHndl hndl, long newSize);
	/* Sets the data size to newSize. */



OSErr		SlideData(TreeObjHndl hndl, long offset, long delta);
	/* Slides some of the data in the data portion of the object starting at
	** 'offset' by a 'delta' amount, either forward or backward, depending
	** on the sign of 'delta'. */



void		*GetDataPtr(TreeObjHndl hndl);
	/* Returns a pointer to the beginning of the object's data area.
	** THIS DOES NOT LOCK THE HANDLE!!  The pointer may become invalid
	** if memory moves. */



OSErr		ReadTree(TreeObjHndl hndl, short fileRefNum);
	/* Given an open file that has been previously written via WriteTree, this function
	** is called to read the file data into ram.  The root object for the file is already
	** created by InitDocument.  The file must be open, and the file position must be
	** set to the byte location where the root object of the file starts.  Once this is
	** so, just call this function with a reference to the root object and the open file
	** refrence number. */



OSErr		ReadTreeObjData(TreeObjHndl hndl, short fileRefNum);
	/* Read in dataSize number of bytes into the object. */



OSErr		WriteTree(TreeObjHndl hndl, short fileRefNum);
	/* Given an open file that is ready to be written to, this function is called to
	** write the file tree to the designated file. */



OSErr		WriteTreeObjData(TreeObjHndl hndl, short fileRefNum);
	/* Write out dataSize number of bytes from the object. */



void		DoBTreeMethod(TreeObjHndl hndl, short message, long data);
	/* Call the object for each member of the tree (or branch) starting
	** from the back of the tree working forward. */



OSErr		DoErrBTreeMethod(TreeObjHndl hndl, short message, long data);
	/* Same as DoBTreeMethod, except that an error aborts tree walk and returns error. */



void		DoFTreeMethod(TreeObjHndl hndl, short message, long data);
	/* Call the object for each member of the tree (or branch) starting
	** from the front of the tree working backward. */



OSErr		DoErrFTreeMethod(TreeObjHndl hndl, short message, long data);
	/* Same as DoFTreeMethod, except that an error aborts tree walk and returns error. */



long		DoTreeObjMethod(TreeObjHndl hndl, short message, long data);
	/* If the object has a method procedure, call it.  If no method procedure,
	** then do nothing. */



void		DoNumberTree(TreeObjHndl hndl);
	/* Number each member in the tree with a unique treeID.  The tree is number
	** sequentially from front to back.  The first treeID number is 1.  0 is
	** reserved for Hndl2ID/ID2Hndl conversions where it is possible that the
	** handle value is nil.  The nil handle will convert to 0, and convert back
	** to nil. */



void		Hndl2ID(TreeObjHndl *hndl);
	/* This function is used to convert a handle reference into a treeID reference.
	** A pointer to the handle reference is passed in.  Typical usage will be where
	** a handle object has a reference to another handle object.  Handle object
	** references aren't meaningful when saved to disk, and therefore don't persist
	** in their native form.  These handle references need to be converted into
	** a treeID reference so that they can be saved.
	** The tree first needs to be numbered so that the treeID references are unique
	** and meaningful.  The tree is numbered by first calling DoNumberTree().  It
	** numbers all the members of the tree hierarchy uniquely and sequentially. */



void		ID2Hndl(TreeObjHndl refHndl, TreeObjHndl *hndl);
	/* Given a tree object ID and a reference object (any member of the tree),
	** return the cooresponding object handle.  DoNumberTree() must be called
	** prior to using this function, and after the last change to the tree, as
	** it generates the object treeID numbers for the entire tree. */



TreeObjHndl	GetUndoHndl(TreeObjHndl hndl);
	/* Given an object handle, return the undo handle. */



void		NewUndo(TreeObjHndl hndl);
	/* Used to close out an old undo task.  Closing out the old task means that
	** any editing to the document will be recorded into a new undo task.  Use
	** this to separate two edits of the same edit type that would otherwise
	** get recorded into the same undo task. */



void		RevertEdit(TreeObjHndl hndl);
	/* If an edit fails, it can be backed out of by calling this.  All edits
	** that were done will be undone, thus recovering the state of the
	** document prior to the edit. */



void		DoUndoTask(TreeObjHndl hndl, Boolean redo, Boolean fixup);
	/* Call this to undo or redo editing to the document.  If redo is false,
	** the it is an undo task.  If fixup is true, then the fixup application's
	** undo fixup procedure is called before and after the undo operation. */



void		DisableUndo(TreeObjHndl hndl);
	/* Dispose of all undo information and prevent further undo collection.
	** Calling NewUndo() will re-enable undo collection. */



void		DisposeUndos(TreeObjHndl hndl);
	/* Dispose of all undo information. */



Boolean		PurgeUndo(TreeObjHndl hndl);
	/* Dispose of all undo information except the current undo.  The current undo
	** may still be active, and it may be needed to back out of an edit operation. */



void		GetUndoInfo(FileRecHndl frHndl, short *undoDepth, short *numUndos);
	/* Return the depth of the undo state, along with the number of undos.  This
	** is useful to determine if undo and redo operations are possible.  If undoDepth
	** is non-zero, then undo is possible.  If numUndos is greater than undoDepth,
	** then redo is possible. */



OSErr	DefaultInitDocument(FileRecHndl frHndl, short version, short numUndos, short numSaveUndos);
OSErr	DefaultFreeDocument(FileRecHndl frHndl);
OSErr	DefaultReadDocument(FileRecHndl frHndl);
OSErr	DefaultReadDocumentFixup(FileRecHndl frHndl);
OSErr	DefaultWriteDocument(FileRecHndl frHndl);
	/* These functions are called when the standard behaviors are what is desired.
	**
	** DefaultInitDocument:
	**		Create a root object and an undo root object.  The undo root has the numUndos
	**		and numSaveUndos values placed in it.
	**
	** DefaultFreeDocument:
	**		Dispose of the document and undo information.  It assumes a normal hierarchical
	**		document architecture and undo root for the document. 
	**
	** DefaultReadDocument:
	**		Read a standard hierarchical document from a file.  It assumes that the document
	**		was written with DefaultWriteDocument.  There may be handle-to-id conversions
	**		still to do.  The entire document must first be read in before this can occur.
	**		A separate pass through the doucment is made, giving each object a chance to
	**		convert id's back into handle references.
	**
	** DefaultReadDocumentFixup:
	**		Fixup the document that was just read in.  When a document is written out using
	**		DefaultWriteDocument, some number of undo tasks may have been moved onto the
	**		end of the document.  This function moves the undo tasks out of the document
	**		and into the undo root.
	**
	** DefaultWriteDocument:
	**		Write a standard hierarchical document to disk.  The number of undos to save
	**		(indicated by the numSaveUndos field in the undo root) are first moved to the
	**		end of the document.  The document is then saved starting with the document
	**		root.
	*/



OSErr	HReadTree(TreeObjHndl hndl, Handle tree);
OSErr	HReadBranch(TreeObjHndl hndl, Handle tree);
OSErr	HReadTreeObjData(TreeObjHndl hndl, Handle treeObjData);
OSErr	HWriteTree(TreeObjHndl hndl, Handle tree);
OSErr	HWriteTreeObjData(TreeObjHndl hndl, Handle data);
	/* These functions work the same as the non-handle based versions.  Instead of
	** reading or writing to a file, these read or write to a handle.  This allows
	** you to stream the hierarchical data into a single handle that can be stored
	** as a resource or sent to another application via AppleEvents. */



long			GetCData(TreeObjHndl hndl, long offset, char *data);
OSErr			PutCData(TreeObjHndl hndl, long offset, char *data);
void			GetPData(TreeObjHndl hndl, long offset, StringPtr data);
OSErr			PutPData(TreeObjHndl hndl, long offset, StringPtr data);
OSErr			PutShortData(TreeObjHndl hndl, long offset, void *data, unsigned short size);
OSErr			PutLongData(TreeObjHndl hndl, long offset, void *data, long size);
unsigned long	GetDataOffset(TreeObjHndl hndl, unsigned long offset, short dtype, short dnum);
	/* Thees functions are use to get and put data of various sized/kinds out of and into
	** TreeObj handles.  These are just for convenience, as any data get/put operations
	** could be done without these functions.  See the document “=Using TreeObj.c” for samples
	** of using these functions. */



Boolean	EqualTreeObjData(TreeObjHndl h1, TreeObjHndl h2);
	/* Call this function to compare two TreeObj objects.  If there is no procPtr defined for
	** the object, then this function calls DefaultEqualTreeObjData to do the conparison.
	** If you have a procPtr defined for the function, then you will probably want to call
	** DefaultEqualTreeObjData from within your object when you get a COMPAREMESSAGE.
	** DefaultEqualTreeObjData simply does a byte-per-byte comparison, and if any difference
	** is found, it returns false.  If all of the bytes are the same, then it returns true.
	** For deep objects, you will have to write your own comparison.  If you have a handle
	** stored in the object, then you will need to compare the contents of the handle, instead
	** of the handle itself.  DefaultEqualTreeObjData doesn't know that the data is actually
	** a handle.  DefaultEqualTreeObjData does a flat compare. */

Boolean	DefaultEqualTreeObjData(TreeObjHndl h1, TreeObjHndl h2);
	/* The default object comparison function.  This simply does a flat-compare of the two
	** objects. */


#endif
