//
//	cplus_sample.h - header for simple C++ program
//
//
//	Copyright © 1993, Apple Computer, Inc.  All rights reserved.
//

#include <Windows.h>
#include <Quickdraw.h>
#include <Fonts.h>
#include <string.h>

class TSampleClass
{
	public:
		TSampleClass ();		// class constructor
		void showMessage (WindowPtr theWindow);
		void myPause ();
		
	private:
		char		theMessage[80];
};



