***** TreeObj.c usage documentation *****/

Purpose:  To simplify and standardize document manipulation, including undo.

Defining a generic document architecture that is flexible enough to handle the
many and varied document types, yet simple enough to justify using it, can be
difficult.

The document structure type chosen here is a simple hierarchy.  For simple document
types, the hierarchical feature can simply be ignored.  All of the member objects of
the document can simply be children of the root object.  This gives the document a
linear feel, (all objects are at the same level in the hierarchy), which is all that
is needed for a lot of applications.

For more complex document structures that have many data types which inter-relate, the
hierarchical model is quite useful.  The sample given here is a draw program.  The draw
example demonstrates both the linear document type (no grouping used) and the hierarchical 
document type (grouping used).  If no grouping is used, then all of the objects added to
the document are children of the root object.  The objects are arranged linearly off the
root document object.  If some of the objects are grouped, a group object is first added
to the root object, and then the selected objects are moved so that they are children of
the group object.  Now the document is no longer linear.  The root object has children,
some of which may be group objects.  These group objects in turn have children.

This sort of hierarchical support makes grouping of objects in a draw-type program trivial.
It naturally represents the organization of the objects within the document.

An additional benefit of managing the objects in a document in such a standardized way is
that additional application features such as undo/redo can be automatically supported.
Whenever a change is to be made to the document, one of a few document-hierarchy-management
calls is made first.  The different operations that can be done to the hierarchical document
are:

	NewChild();
	DisposeChild();
	CopyChild();
	MoveChild();
	ModifyChild();
	SwapChildren();

These six operations cover the various operations that can be performed to one or more of
the document objects.  Children can be added, removed, copied, moved, modified, or swapped.
If these calls are used to modify objects within the document hierarchy, then the editing
operations done to the document can automatically be recorded for undo/redo purposes.

Let's look at a sample NewChild() call and its prototype:

TreeObjHndl	NewChild(short editType, TreeObjHndl parentHndl, short childNum, short ctype, long size);

NewChild(), if successful, returns a handle for the child object added to the document.
The parameters are:
	editType:	Application edit type for which this document modification is being done.
	parentHndl:	The child created will be added as a child to this object.
	childNum:	The child will be added to the parent as this child number.
	ctype:		The child will be of this type.
	size:		The child will be created this initial size (if size is greater than minimum).

NewChild() must have a parent declared.  This begs the question of where the initial parent
comes from.  At some point, NewRootObj() must be called to create the initial root parent.
As would be expected, the root object has no parent.  Once there is an initial root object,
children can then be added to the document via NewChild().

The editType of the NewChild() call is used for automatically tracking undo/redo.  Many
individual operations may be done to the document that are all for the same editing operation.
Let's say that you have a word-processor application that has paragraph objects.  If your
document has 27 paragraphs, then you have 27 children off the root object.  The order of the
children is the order of the paragraphs in your document.

Let's now say that the user has selected some text.  The text selected starts in the middle of
paragraph 3, goes through paragraphs 4-5, and through half of the text in paragraph 6.
The user then deletes this text.  We may have declared this type of edit to be of type
DELETE_EDIT.  The edits to the document that we will perform are:

1) Modify paragraph 3 by removing the selected text and keeping the unselected text.
2) Delete paragraphs 4-5.
3) Modify paragraph 6 by removing the selected text and keeping the unselected text.

For step 1, we would first use ModifyChild().  The prototype for ModifyChild() is:

	OSErr	ModifyChild(short editType, TreeObjHndl phndl, short childNum, Boolean deepCopy);

ModifyChild() makes a copy of the object and places the copy in the undo hierarchy.  We are
now free to modify the object any way we see fit.  If the user chooses to undo the change,
the undo code simply swaps the data of the modified object with the copy that was saved in
the undo hierarchy.  If the user later chooses to redo the edit, the undo code simply swaps
the data again to perform the redo.

NOTE:  ModifyChild() may fail, since a copy of the object is made.  There may not be enough
memory for this copy to be created.  If this is so, then a memFullErr will be returned.

The parameters are:
	editType:	Application edit type for which this document modification is being done.
	parentHndl:	Parent of the child being modified.
	childNum:	Child number (of the parent) being modified.
	deepCopy:	If true, the children of this child are also copied into the undo hierarchy.

The editType parameter is used to determine if this document modification is of the same
edit type as previous document modifications.  If it is, then the operation is grouped
with the other operations.  This is all done for the purposes of undo/redo.  Multiple objects
may be modified in a single edit, and these modifications all have to be undone/redone with
a single undo/redo.

If the editType is different than the last document modification, then a new undo group is
started, and this operation is recorded in this new group.

For the above example, we would make the following call to ModifyChild() prior to removing
the selected text from paragraph 3:

	err = ModifyChild(DELETE_EDIT, root, 3, false);

Of course, it would be a really odd application in which the '3' was hard-coded as in
the above line.

Now paragraphs 4 and 5 need to be deleted.  This is done by using DisposeChild().
The prototype for DisposeChild() is:
	void	DisposeChild(short editType, TreeObjHndl parentHndl, short childNum);

Note that DisposeChild() will succeed, as it doesn't have to create a new handle for the
copy as ModifyChild() does.  HOWEVER:  DisposeChild doesn't necessarily free up ram, as
you would expect.  All that occurs is that the child is moved into the undo hierarchy so
that undo can move the child back into the document.

To delete children 4 and 5, we would do the following:

	DisposeChild(DELETE_EDIT, root, 4);
	DisposeChild(DELETE_EDIT, root, 4);

Note that for both calls we dispose of child number 4.  This is because once the first child
is disposed of, what used to be child 5 is now child 4.

The last operation we would do is to declare our intent to change to the end child in the
selection range.  This would be done as follows:
	err = ModifyChild(DELETE_EDIT, root, 4, false);

The delete (assuming no errors) has now been completed.  Actually, the delete has occurred
in either case.  If there were errors, all that occurred is that the undo information wasn't
recorded.

Now let's say that the user selects a new range of text and deletes it, as well.  We would
do the same thing as above to delete the text.  Here's the problem:  The editType of this
second text delete is the same as the first.  Both document edits were of type DELETE_EDIT.
This means that both operations were recorded under the same undo task.  When the user
chooses undo, both deletes will be undone.  This isn't what we want.

To fix this problem, we have to make one additional call.  We need to call NewUndo().
NewUndo() closes out the old editing task.  When you then make some document modification,
it will be recorded in a separate undo task.

NewUndo() only takes a single parameter.  Just pass it any handle in the document.  Any
object in the document can serve as a reference to the document.


An object handle has 3 parts:
1) The header information.
2) The application-defined object data.
3) The child handle table.


The object header is of the following form:

typedef struct TreeObj {
	short		type;
	short		numChildren;
	long		dataSize;
	long		treeID;
	TreeObjHndl	parent;
} TreeObj;

These fields are automatically filled out whenever an object is created via NewRootObj()
or NewChild().

The application-defined data area is automatically initialized with 0's.  When NewRootObj()
or NewChild() is called, a size parameter is passed in.  There is also a table of minimum sizes
for each object type that needs to be defined.  If the size passed in is smaller than the
minimum size, then the minimum size is used as the data size instead.

The minimum size table is a global array of longs called gMinTreeObjSize.  Its definition is
found in File.c.  For each type of object defined, there needs to be a minimum size defined.

There are some predefined object types.  These are defined by the following:

#define ROOTOBJ     1
#define UNDOOBJ     2
#define UNDOTASKOBJ 3
#define UNDOPARTOBJ 4
#define WFMTOBJ     5
#define CTLOBJ      6

These are the mandatory object types for supporting this implementation of the document
structure and undo/redo features.

Application-defined object types can start with type number 16.  Type number 0 is reserved
and is currently undefined.  Types 7-15 are reserved for future objects that may be added
to the DTS.Lib application framework.

The numChildren field is initially 0 after calling either NewRootObj() or NewChild().

The dataSize is the effective data size after object creation, which is either the size passed
in, or the minimum object size, whichever is greater.

The treeID field is initially set to 0 by both NewRootObj() and NewChild().  This field is
used to uniquely identify members of the hierarchy by ID.  (More on this later.)

The parent field is a reference to the handle which is the parent.  As you would expect,
objects created by NewRootObj() have no parent, and therefore this field is nil.


The application-defined data area starts immediately after the header information.  As the
structure of this portion is application-defined and variant, there is no structure pre-defined
for it.  Each object type will have a unique structure definition for this portion of the object.


The final part of an object is the child handle table.  The child handle table starts
immediately after the data portion of the object.  The size of the header structure plus
the value in the dataSize field serves as an offset from the beginning of the object to
the child handle table.  Given the relationship between dataSize and the child handle
table, it is important that the object isn't resized directly.  There are calls for managing
the data area and its size that take the child handle table into account.  These are:

	OSErr	AdjustDataSize(TreeObjHndl hndl, long delta);
	OSErr	SetDataSize(TreeObjHndl hndl, long newSize);
	OSErr	SlideData(TreeObjHndl hndl, long offset, long delta);
	void	*GetDataPtr(TreeObjHndl hndl);

AdjustDataSize() alters the size of the data area, based on the delta passed in.  If you wish
to decrease the data area by one byte, for example, pass in a -1.  AdjustDataSize() does not
reposition any of the data within the data area.  It does move the child handle table so that
it continues to be positioned immediately after the data area.

SetDataSize() does as expected.  It specifically sets the data size to the designated
size.  It also does not shift the data, but does do the appropriate child handle table
maintenance, just as AdjustDataSize() does.

SlideData() operates the same as AdjustDataSize(), plus it also slides some or all of the
data in the data area.  Use SlideData() to insert or remove data at some location within
the data area.

GetDataPtr() simply returns a pointer to the beginning of the data area.  IT DOES NOT LOCK
THE HANDLE!!  If the handle needs locking, then you must do this yourself.  Since the object
is simply a handle, this poses no difficulties.  (Unlock when you are done, of course.)


The child handle table is automatically handled.  There shouldn't be a reason that you need
to manage or reference this yourself.  If however you end up needing to do this, there
are calls to manage the child handle table.


Objects referencing other objects:

Let's revisit the word-processor example.  Once again, we have this paragraph-based word
processor.  The user selects some text.  The cursor location (insertion point) must be kept.
A reference to the starting object and an offset into the data of that object would serve as
the cursor location reference.

This reference to the paragraph object containing the insertion point could be kept as either
a handle reference or a child number reference.  Either would serve the purpose.  Both would
uniquely describe an object in the document.  The handle reference would directly reference
the object.  The child number reference would indirectly reference the object.  If we used
child numbers as our reference and we desired to get the handle of the object, we would do
something like the following:

	chndl = GetChildHndl(root, cnum);

In our document example, all of the paragraph objects are children of the root object.
In this case it would be a simple matter of getting the child handle.  The child number
reference would probably be stored in the root object, as it is a global piece of information
for this document.  We would probably want it saved with the document, which would occur
automatically if it were stored in the root object.

So, since they both seem to work, which is better?  Is keeping the handle better, or is keeping
the child number better?  When saving a document, child numbers will be meaningful when the
document is opened at a future date.  References to handles aren't meaningful when saved to disk
and then reloaded.  For this reason it seems that child number should win out.

But what if you wish to keep a reference to some arbitrary point in the document?  What if you
don't know what the parent of that object is?  What if the object is at some arbitrary depth
in the hierarchy?  In this case, it seems pretty clear that we wish to use handle references
instead of child number references, at least when the document is in memory.

So what about handle references when saved to disk?  We need these references to persist.  To
do this, we must convert them to something that saves meaningfully and can be converted back
to handle references when the document is reopened.

This is what the treeID field in the object header is for.  When DoNumberTree() is called,
all of the objects in the hierarchy are uniquely numbered.  DoNumberTree() is automatically
called by the shell just prior to the objects in a hierarchy are written to disk.  In
addition, prior to writing an object out to disk, the object is called with a message
requesting it to convert any handle references it contains to treeID references.  For each
handle reference that needs to be converted, you need to call Hndl2ID() to do the conversion.
Hndl2ID() depends on DoNumberTree() already being called so that all of the treeID fields
for all of the objects in the hierarchy are current.

After calling the object with the handle-to-id conversion message, the object is written
to disk.  Once it is written, a message is sent to the object requesting it to covert the
id back into a handle reference.  For each reference converted, you need to call ID2Hndl()
to deconvert the reference back into a handle.

When a document is opened, all of the objects are first read into memory.  Once the entire
document is in memory, DoNumberTree() is called, and then each object in the document is
sent a message requesting it to convert the converted handle references back into real
handle references.

The reason that the entire document must first be read is that the reference to another object
may be to an object that is later in the document.  Only after the entire document is read in
is it possible to resolve all references to anywhere in the document.

This messaging mechanism allows you to use handle references within your application without
worrying about them persisting through a save/open cycle.  So, given the above messaging
mechanism, using either child number references or handle references is equally valid.
Whatever seems easiest for a particular application is the one to use.


There is a standard set of messages passed to objects.  The above message is just one of these.
The standard list of messages (and possible sub-messages) is defined as below:

#define INITMESSAGE      0		/* Additional object initialization. */
#define     CREATEINIT       0		/* Object being initially created. */
#define     WINDOWINIT       1		/* Document/object being assigned to a window. */
#define     NOWINDOWINIT     2		/* Document/object being freed from a window. */

#define FREEMESSAGE      1		/* Additional object disposal. */

#define COPYMESSAGE      2		/* Additional object cloning. */

#define UNDOMESSAGE      3		/* Additional object undo. */
#define     UNDOFROMDOC      0		/* Object leaving document. */
#define     UNDOTODOC        1		/* Object returning to document. */

#define CONVERTMESSAGE   4		/* Hndl2ID or ID2Hndl conversions. */
#define     CONVERTTOID      0		/* Convert handle references to ID references. */
#define     CONVERTTOHNDL    1		/* Convert ID references to handle references. */

#define FREADMESSAGE     5		/* Read object data from file. */
#define FWRITEMESSAGE    6		/* Write object data to file. */

#define HREADMESSAGE     7		/* Read object data from handle. */
#define HWRITEMESSAGE    8		/* Write object data to handle. */

#define HITTESTMESSAGE   9		/* Test if object was hit. */
#define     HITTESTOBJ       0		/* Test body of object for hit. */
#define     HITTESTGRABBER   1		/* Test sizing parts for hit. */
#define     CANBETARGET      2		/* Return true if object can become target. */
#define     CANTAKEKEYS      3		/* Return true if target can take keys. */

#define GETRGNMESSAGE    10		/* Return object bounding box. */
#define GETBBOXMESSAGE   11		/* Return object bounding box. */
#define SETBBOXMESSAGE   12		/* Set object bounding box. */
#define SECTBBOXMESSAGE  13		/* Check if rect intersects object bounding box. */

#define TARGETMESSAGE    14		/* Set target status for object. */
#define     TARGETOFF        0		/* Make the object no longer the target. */
#define     TARGETON         1		/* Make the object the target. */

#define DRAWMESSAGE      15		/* Draw some form of the object. */
#define     DRAWOBJ          0		/* Draw the object. */
#define     ERASEOBJ         1		/* Draw the object. */
#define     DRAWSELECT       2		/* Draw the selection portion of the object. */
#define     DRAWGHOST        3		/* Draw an xor-ghost (for dragging) of the image. */
#define     DRAWMASK         4		/* Draw a mask of the image (for offscreen layer masking.) */

#define PRINTMESSAGE     16		/* Print the object. */

#define VHMESSAGE        17		/* Format View Hierarchy information for the object. */


INITMESSAGE:  This is called with a sub-message of what kind of init it is.  The CREATEINIT
sub-message  indicates that the object is initially being created.  This sub-message is in
case there is additional data initialization that must occur.  Depending on the object, there
may be handles that need to be created off the object itself.  It may not be a simple linear
block of data.  In these cases, you want to do this additional initialization when the
INITMESSAGE is received.
The WINDOWINIT sub-message is in case certain objects have a different state when the document
has a window than when it doesn't.  For example:  If there were a TextEdit object, then when
the file is initially read in and the CREATEINIT sub-message is passed to the object, there is
no window to pass to TENew() to create a new TextEdit record.  The data has to be read in as
regular text that has no TERecord yet.  Once the document is assigned a window, a TERecord can
be created for the object and the text data can be moved into the TERecord.  This additional
WINDOWINIT sub-message is defined for just such objects that you may create.  Note that
nowhere in the application framework is there a call that passes a WINDOWINIT sub-message.
This would be an application-specific function, and therefore this call would belong in the
application.  The most likely place for this would be in the InitContent() function for the
application.  You would do something like the following:
	DoFTreeMethod(root, INITMESSAGE, WINDOWINIT);
This would pass each object in the document an INITMESSAGE with a sub-message of WINDOWINIT.
The final sub-message is NOWINDOWINIT.  This message occurs when a document is being detached
from a window.  If an object has to change state to accomodate being related to a window, then
it would need to change state back when disassociated with that window.

FREEMESSAGE:  This is called due to DisposeChild() being called.  DisposeChild() will
dispose of simple objects that don't have additional handles of data.  Any handles that were
created at INITMESSAGE time should be disposed of when the FREEMESSAGE is received.

COPYMESSAGE:  When CopyChild() is called, a new child is created via calling NewChild().
Normally when NewChild() is called, the object is called with INITMESSAGE.  However,
when a child is being copied, the data area is copied into the copy child.  This data
copy would clobber any handle references the newly created copy would have, thus orphaning
those handles.  For this reason, no INITMESSAGE was passed to the object by NewChild().
The data was copied into the copy however, so any handle references in the copy aren't unique
references.  The original child has the same references.  This isn't a good situation.
The first thing that the code for the COPYMESSAGE needs to do is to send itself an
INITMESSAGE so that unique handles for the copy are created.  Once this is done, then
the code for COPYMESSAGE can actually copy the data in these handles.  Once this final
copying is done, we have a complete and separate copy of the original child.

UNDOMESSAGE:  When the user performs an undo or redo, involved objects get passed
this message.  When an undo/redo occurs objects are either moving into or out of the
document.  Objects move back and forth between the document and the undo hierarchy.
The sub-messages UNDOFROMDOC and UNDOTODOC determine the direction.  There may be various
tasks that need to be performed to this object and other parts of the document when an
undo/redo occurs.  When an undo of a DELETE_EDIT is performed, it is typical to select
the portion of the document undeleted.  The root object may hold the selection information.
If this is the case, the object should call GetRootHndl() and then adjust the selection
accordingly.  Note that the root object may turn out to be the undo hierarchy root object.
If the object has been moved out of the document and into the undo hierarchy, this will
turn out to be the case.  In this instance nothing would have to be done.  At least one
message will be sent to the object while it is still in the document.  The sub-message
will then state whether the document is about to leave or just was added to the document.
Let's say that the root object contains a count of the number of selected items.  In this
case, if the item is selected, and it is about to leave the document, then the count of
items selected will need to be decremented.  If the item has just moved into the document,
then the item needs to be set as selected, plus the number of selected items count needs
to be increased by 1.
An additional call is made prior to any objects being moved.  This is to globally prepare
the document for an undo/redo operation.  Given that the items involved in the undo/redo
should be selected, this suggests that other selected items should be deselected prior
to the undo/redo.  This global undo/redo setup call is the place to do things like this.
Also, once the undo/redo operation is complete and all objects involved in the operation
are moved and messaged, a final call is made to clean up any unfinished undo/redo business.
To recap the undo/redo procedure:
	1) A global get-ready-to-undo/redo call is made.  This function is called UndoFixup.
	   It is passed a reference to the document, plus a sub-message stating that it is
	   called for pre-undo/redo tasks or post-undo/redo tasks (in this case pre-undo/redo).
	2) Each object involved in the undo/redo task is called with appropriate messages
	   stating whether it is leaving or entering the document.  Appropriate document
	   maintenance tasks should be performed based on these messages/sub-messages.
	1) UndoFixup is called a final time.  Once again, it is passed a reference to the document,
	   plus a sub-message stating that it is called for post-undo/redo tasks.

CONVERTMESSAGE:  This is called to convert handle references within an object to treeID
values and visa versa, depending on the sub-message.
For the sub-message CONVERTTOID:  Prior to the first object being written to disk, DoNumberTree()
is called to assign a unique treeID to each object in the document.  For each handle reference
in an object, call Hndl2ID() to convert it to a treeID value.  Once the object is written to
disk, the object will be called again with the sub-message CONVERTTOHNDL.  This indicates that
the handle references that were converted to treeID values should be converted back.  Call
ID2Hndl() to do the reverse conversion.
For the sub-message CONVERTTOHNDL:  The entire document is in memory prior to ever receiving this
message.  In the case of writing a document to disk, the document is already in memory.  For
the case where a document is being opened, the entire document is first read in, and then
objects are passed this message as an opportunity to convert treeID values into handle references.
In either case, DoNumberTree() will have already been called, so it is okay to call ID2Hndl().

FREADMESSAGE:  This is called to read in the data portion of an object.  The header
information has already been read in.  Since the header information doesn't vary according
to the object type, it can be read in generically.  Also, the header information states what
type the object is, so until it the header is read in, the object type can't be determined.
If the data doesn't have any additional handle references, just call the default function
to read in the data.  The default function is called ReadTreeObjData().  It will read in
the number of bytes designated by the dataSize in the header, which has already been read in.
If there is additional data for the object to be kept in handles, or some such other unique
situation, the code to do this goes here.

FWRITEMESSAGE:  This is called to write out the data portion of an object.  The header
information has already been written.  Since the header information doesn't vary according
to the object type, it can be written generically.  If the data doesn't have any additional
handle references, just call the default function to write out the data.  The default
function is called WriteTreeObjData().  It will write out the number of bytes designated by
the dataSize in the header.  If there is additional data for the object kept in handles, or
some such other unique situation, the code to write this additional data goes here.

HREADMESSAGE:  This message is similar to FREADMESSAGE, except that the data is read from
a handle instead of from disk.  The assumption is that the data is already in a handle.
A handle containing the object's data is passed in.  The handle is the same size as the dataSize
field for the object.  If the object's data is flat, then you can simply do the following:
	case HREADMESSAGE:
		return(HReadTreeObjData(hndl, (Handle)data));
		break;
If the object's data isn't flat, then you will have to move the data from the handle into the
object as is appropriate for this object.  The ability to stream data not only to the file,
but to a handle is really convenient.  By calling the TreeObj.c function HWriteTree(), you can
stream any tree (or branch) into a handle.  You can then save the handle as a resource, or you
can send it to another application via AppleEvents.  Once read, it can be unstreamed by
calling HReadTree().

HWRITEMESSAGE:  This message is similar to FWRITEMESSAGE, except that it is used to write
the data into a handle.  See the HREADMESSAGE for more info.

HITTESTMESSAGE:  This message is used for hit-testing of an object, along with various
targeting and keystroke information for the object.  See the DTS.Draw example for
implementation details.

GETRGNMESSAGE:  This message is requesting that the object return a region that describes
its shape.

GETBBOXMESSAGE:  This message is requesting that the object return a rectangle that encloses
all portions of the object.

SETBBOXMESSAGE:  This message is used to change the size of the bounding rectangle for
an object.

SECTBBOXMESSAGE:  This message is used to determine if the object's bounding rectangle
intersects the given rectangle.

TARGETMESSAGE:  This message is how an object is made the target or not the target of keystrokes.

DRAWMESSAGE:  This message and sub-message is to tell the object to draw itself, and in
what form.

PRINTMESSAGE:  This message is to tell the object to print itself.  Assumably the data
field will vary, according to the object type.  Objects often print themselves differently
than they draw, so specific object information will have to be passed in for these cases.

VHMESSAGE:  This message allows the object to format the data information that is viewed
when using the View Hierarchy object viewing feature.


As is evident from the above descriptions, the behaviors for the different types of objects
is completely dependent on what is done for the various messages.  To define an object type,
you need to make an entry into two tables.  These tables are:
	1) gTreeObjMethods
	2) gMinTreeObjSize
These tables are found in the application file File.c.  As you add objects to your application,
just make entries for these new objects into these tables.
If you want the default behaviors for an object, then use nil for the method procedure.  If
the method procedure is nil, then the object is passed no messages, as it is assumed that it
is simple and generic enough to be handled automatically.  If you need to handle just one
message specifically , you will then need to define a method procedure.  With method procedures,
it is an all-or-nothing situation.  If you set the method procedure to non-nil for an object,
then that object will receive all messages.  For these instances you can just call the default
code directly, such as ReadTreeObjData() and WriteTreeObjData() for handling file I/O for
the object.


Since the object is a handle of three components, referencing the object as if it is unique
can be a bit of a pain.  The unique portion of the object, the data portion, is actually in
the middle of the object.  To syntactically fix this problem, you will want to define some
macros for dereferencing into an object with appropriate object-type typecasting.  In
FileFormat.h you will find some such dereferencing macros.  They are in the form:

#define mDerefRoot(hndl)     ((RootObj*)((*hndl) + 1))

This macro allows you to write code that looks like the following:

	numSelected = mDerefRoot(root)->numSelected;

The only danger with this is that the handle that is dereferenced doesn't have to be of type
RootObj.  It can be of any type.  This is convenient and not.  It allows objects of different
types to be treated similarly or differently, whichever the code demands.


There are two defines in FileFormat.h that I should mention.  These are:
1) MAXNUMUNDOS
2) NUMSAVEUNDOS

These govern the depth of the undo mechanism.

MAXNUMUNDOS is the maximum number of undos that will be recorded before the oldest are
automatically purged.  This can be set up to 65535, if you so wish, although that will
cause a lot of undo hierarchy object to be kept around and is more than any human user
can comprehend.

NUMSAVEUNDOS is the maximum number of undos that are saved along with the document.  If this
number if non-zero, then when the document is opened, the user may already have some undos
that can be performed from the last editing session.  Setting this constant to zero makes
the application save no undos along with the document.


It is generally better if your object's data area is flat.  This is good for a number of reasons:

1)	It allows you to use the default streaming functions for FREADMESSAGE, FWRITEMESSAGE,
	HREADMESSAGE, HWRITEMESSAGE.
2)	Your application uses fewer handles.  The more handles, the slower the memory manager gets.

Of course, for some object, being complete flat is unreasonable.  The framework supports both flat
and non-flat objects, so the choice is yours.


To make keeping the object's data flat easier, I've added the following functions:

long			GetCData(TreeObjHndl hndl, long offset, char *data);
OSErr			PutCData(TreeObjHndl hndl, long offset, char *data);
void			GetPData(TreeObjHndl hndl, long offset, StringPtr data);
OSErr			PutPData(TreeObjHndl hndl, long offset, StringPtr data);
OSErr			PutShortData(TreeObjHndl hndl, long offset, void *data, unsigned short size);
OSErr			PutLongData(TreeObjHndl hndl, long offset, void *data, long size);
unsigned long	GetDataOffset(TreeObjHndl hndl, unsigned long offset, short dtype, short dnum);

GetDataOffset is the key call.  It allows you to calculate an offset into the objects data,
even if the data in front of it is of variable size.  Let's takle a look at an object that is
quite variable.  You will find the following typedef in the file DTS.Lib.h:

typedef struct {
	short	numRows;
	short	numCols;
	short	cellHeight;
	short	cellWidth;
	short	mode;
} CLNewInfo;
typedef struct {
	Rect	destRct;
	Rect	viewRct;
	Rect	brdrRct;
	short	maxTextLen;
	short	mode;
} CTENewInfo;
typedef struct {
	short			selected;
	Rect			rect;
	char			visible;
	char			hilite;
	short			value, min, max;
	short			procID;
	long			refCon;
	short			ctlID;
	short			cctbID;
	short			fontSize;
	Style			fontStyle;
	union {
		CLNewInfo	clnew;
		CTENewInfo	ctenew;
	} extCtl;
	unsigned char	title[4];		/* 4 pascal strings are stored back-to-back starting here. */
									/* title[0] = control title */
									/* title[1] = key equivs    */
									/* title[2] = control font  */
									/* title[3] = balloon help info */
	short			textLen[2];		/* 2 short-prefixed data blocks stored starting here.
									** textLen[0] = textEdit control text block
									** textLen[1] = textEdit control style block */
} CtlObj;
#define mDerefCtl(hndl) ((CtlObj*)((*hndl) + 1))

Everything is reasonable until we get to the textLen field.  If we were to get the offset
of this field using the offsetof macro (found in Utilities.h), we would get a value that is
4 bigger than the offset for the title field.  This is initially true if the struct is filled
with zeros.  (We would then have 4 zero-length pascal strings in front on textLen).  Once we
modify one of these title strings, then the textLen data would slide down.

To get the correct offset for textLen[1], we would do the following:

ofst = GetDataOffset(hndl, offsetof(CtlObj,title), kPStr, 4);
		/* This gets us past the 4 pascal strings. */

ofst = GetDataOffset(hndl, ofst, kSDataBlock, 1);
		/* This gets us past the first short block of data.  A short block of data is a 2-byte
		** data length, followed by the data.  Note that even though textLen is a signed short,
		** GetDataOffset treats it as unsigned.  This allows us to be a bit more descriptive
		** in our typedef.  By stating that it is a short, we are indicating that we don't
		** expect the data to get bigger than 32767. */

Now that we have this offset, we can use the PutShortData() call to replace this data.
Let's assume that we have a handle of text called txtHndl, and the length is txtLen.  To replace
the old block of data with this text, we would make the following call:

	err = PutShortData(hndl, ofst, txtHndl, txtLen);

Any data fields that are after this field are moved to adjust for the size differences between
the data being replaced and the new data.

Long data blocks are also supported, as well as C and pascal string data types.
There are also Get functions for the string types, but there aren't for the block types.
The assumption is that you will need to create a handle to copy the data into.  To get a
data block, first generate the offset, then get the short or long for the data size.  Create
a handle of this size, and then BlockMove the data.

To get the data for this short block, the code would look like this:

	short	ofst;
	Ptr		dptr;

	ofst = GetDataOffset(hndl, offsetof(CtlObj,title), kPStr, 4);
	ofst = GetDataOffset(hndl, ofst, kSDataBlock, 1);
	dptr = GetDataPtr(hndl);
	BlockMove(dptr + ofst, &dsiz, sizeof(short));
	dhndl = NewHandle(dsiz);
	if (dhndl) {
		dptr = GetDataPtr(hndl);
		BlockMove(dptr + ofst, *dhndl, dsiz);
	}

Not too bad for fetching a variable-length field from a variable location.

Of course, for strings, it's a snap.  Here's the code to get title[2]:

	short	ofst;
	Str255	pstr;

	ofst = GetDataOffset(hndl, offsetof(CtlObj,title), kPStr, 2);
	GetPData(hndl, ofst, pstr);



The final thing I will cover here is the 'View Hierarchy' facility in this sample.  As
powerful as a hierarchical document structure can be, it can also be difficult to examine
and debug.  The debugging feature of a 'View Hierarchy' window has been introduced to
address this problem.

Whatever window is the top-most window when 'View Hierarchy' is selected will be referenced
by the 'View Hierarchy' window.  The 'View Hierarchy' window will be given the same window
name as the window being referenced to keep confusion to a minimum if multiple 'View Hierarchy'
windows are opened at once.

The TextEdit control on the left is used to display the data in the object.  The small TextEdit
control near the top-right is used to enter an alternate object handle to display.  The List
control on the left displays the parent hierarchy.  The List control on the right is used
to display the child handle table of the currently displayed object.  By double-clicking on
members of these two lists, you can navigate the document hierarchy.

The data TextEdit control displays the header information of the object, plus the data portion
of the object.

For root objects, the first 4 bytes of the data area hold a reference to the undo hierarchy of
the document.  To view the undo hierarchy, either enter this handle in the small TextEdit
control and press display, or just select the text for the handle in the data display area and
press display.  Either method will make the undo root object the object to display.

The undo root object holds the document root in the first 4 bytes of the data area, so to
go back to displaying the document root, just do the same as you did to display the undo root
object.

If you try to display a handle that doesn't exist, the 'View Hierarchy' code will beep at you
and do nothing.  If you enter a handle that exists, but isn't an object handle, it will try
to display something and probably crash.  (Remember, this is only meant as a debugging aid.)


This is probably enough for an introduction.  Have fun.

