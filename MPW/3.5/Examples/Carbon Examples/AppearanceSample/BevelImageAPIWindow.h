/*
	File:		BevelImageAPIWindow.h

	Contains:	Bevel Button fun!
			
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

#ifndef _BEVELIMAGE_H
#define _BEVELIMAGE_H

#ifdef __MRC__
#include <Icons.h>
#endif	// __MRC__
#include "BaseDialog.h"

class BevelImageAPIWindow : public BaseDialog
{
	public:
			BevelImageAPIWindow();
		virtual ~BevelImageAPIWindow();
		
	protected:	
		void		HandleItemHit( SInt16 itemHit );
	
	private:
		Handle		fIconSuite;
		CIconHandle	fColorIcon;
		IconRef		fIconRef;
};

#endif // _BEVELIMAGE_H
