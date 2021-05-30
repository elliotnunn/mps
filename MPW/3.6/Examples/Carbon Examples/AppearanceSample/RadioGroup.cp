/*
	File:		RadioGroup.cp

	Contains:	Class to implement a radio group.

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

#ifdef __MRC__
#include <ControlDefinitions.h>
#endif	// __MRC__

#include "RadioGroup.h"

typedef struct
{
	ControlRef		control;
	SInt16			value;
} RadioEntry;

RadioGroup::RadioGroup()
{
	fInfo = NewHandle( 0 );
	fValue = 0;
	fMixed = false;
}

RadioGroup::~RadioGroup()
{
	DisposeHandle( fInfo );
}
		
void
RadioGroup::AddControl( ControlRef control, SInt16 value )
{
	Size		size;
	SInt16		numItems;
	
	size = GetHandleSize( fInfo );
	numItems = size / sizeof( RadioEntry );
	
	SetHandleSize( fInfo, size + sizeof( RadioEntry ) );
	
	((RadioEntry*)*fInfo)[ numItems ].value = value;
	((RadioEntry*)*fInfo)[ numItems ].control = control;
	
	SetValue( value ); 
}

SInt16
RadioGroup::GetValue()
{
	return fValue;
}

void
RadioGroup::SetValue( SInt16 value )
{
	SInt16		numItems;
	SInt16		i;
	ControlRef	oldControl = nil, newControl = nil;
	
	if ( fMixed )
	{
		numItems = GetHandleSize( fInfo ) / sizeof( RadioEntry );
		
		for ( i = 0; i < numItems; i++ )
		{
			if ( GetControlValue( ((RadioEntry*)*fInfo)[ i ].control ) )
			{
				SetControlValue( ((RadioEntry*)*fInfo)[ i ].control, 0 );
			}
		}
	}
	
	if ( (value != fValue) || fMixed )
	{
		numItems = GetHandleSize( fInfo ) / sizeof( RadioEntry );
		
		for ( i = 0; i < numItems; i++ )
		{
			if ( ((RadioEntry*)*fInfo)[ i ].value == value )
				newControl = ((RadioEntry*)*fInfo)[ i ].control;
			
			if ( ((RadioEntry*)*fInfo)[ i ].value == fValue )
				oldControl = ((RadioEntry*)*fInfo)[ i ].control;
		}
		if ( newControl )
		{
			if ( oldControl )
				SetControlValue( oldControl, 0 );
		
			SetControlValue( newControl, 1 );
		}
		fValue = value;
	}
	fMixed = false;
}

void
RadioGroup::SetMixed( SInt16 value )
{
	SInt16		numItems;
	SInt16		i;
	ControlRef	newControl = nil;
	
	numItems = GetHandleSize( fInfo ) / sizeof( RadioEntry );
	
	for ( i = 0; i < numItems; i++ )
	{
		if ( ((RadioEntry*)*fInfo)[ i ].value == value )
		{
			newControl = ((RadioEntry*)*fInfo)[ i ].control;
			break;
		}
	}
	if ( newControl )
	{
		SetControlValue( newControl, kControlCheckBoxMixedValue );
	}
	fValue = value;

	fMixed = true;
}

void
RadioGroup::SetValueByControl( ControlRef control )
{
	SInt16		numItems;
	SInt16		i;
	ControlRef	oldControl = nil;
	SInt16		value = 0;
	Boolean		valueFound = false;
		
	if ( fMixed )
	{
		numItems = GetHandleSize( fInfo ) / sizeof( RadioEntry );
		
		for ( i = 0; i < numItems; i++ )
		{
			if ( GetControlValue( ((RadioEntry*)*fInfo)[ i ].control ) )
			{
				SetControlValue( ((RadioEntry*)*fInfo)[ i ].control, 0 );
			}
		}
	}
	
	numItems = GetHandleSize( fInfo ) / sizeof( RadioEntry );
	
	for ( i = 0; i < numItems; i++ )
	{
		if ( ((RadioEntry*)*fInfo)[ i ].control == control )
		{
			value = ((RadioEntry*)*fInfo)[ i ].value;
			valueFound = true;
		}
		
		if ( ((RadioEntry*)*fInfo)[ i ].value == fValue )
			oldControl = ((RadioEntry*)*fInfo)[ i ].control;
	}
	if ( valueFound )
	{
		if ( oldControl )
			SetControlValue( oldControl, 0 );
	
		SetControlValue( control, 1 );
	
		fValue = value;
	}
	fMixed = false;
}