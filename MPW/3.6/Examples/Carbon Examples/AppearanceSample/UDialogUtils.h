/*
	File:		UDialogUtils.h

	Contains:	Dialog item utility routines.

	Version:    CarbonLib 1.0.2 SDK

	You may incorporate this sample code into your applications without
	restriction, though the sample code has been provided "AS IS" and the
	responsibility for its operation is 100% yours.  However, what you are
	not permitted to do is to redistribute the source as "Apple Sample Code"
	after having made changes. If you're going to re-distribute the source,
	we require that you make it clear in the source that the code was
	descended from Apple Sample Code, but that you've made changes.

	© 1997-2000 by Apple Computer, Inc. All rights reserved.
*/

#ifndef _UDIALOGUTILS_
#define _UDIALOGUTILS_

#include <Appearance.h>
#include <Controls.h>
#include <Dialogs.h>

class UDialogUtils
{
	public:
		static	Handle		GetItemHandle( DialogPtr theDialog, short item );
		static	void		SetItemHandle( DialogPtr theDialog, short item, Handle handle );
		static	void		GetItemRect( DialogPtr theDialog, short item, Rect& rect );
		static	void		SetItemRect( DialogPtr theDialog, short item, const Rect& rect );
		static	void		SetItemValue( DialogPtr dialog, short item, short value );
		static	SInt16		GetItemValue( DialogPtr dialog, short item );
		static	void		SetItemText( DialogPtr dialog, short item, StringPtr text );
		static	void		GetItemText( DialogPtr dialog, short item, StringPtr text );
		static	void		FlashItem( DialogPtr theDialog, short item );
		static	void		ToggleCheckBox( DialogPtr theDialog, short item );
		static	void		EnableDialogItem( DialogPtr dialog, short item, Boolean enableIt );
		static	void		SetFontStyle( DialogPtr dialog, short item, ControlFontStyleRec& style );
};

#endif // _UDIALOGUTILS_
