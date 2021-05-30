////////////////////////////////////////////////////////////////////////////////
// Copyright © 1992 Apple Computer, Inc. All rights reserved.
// Author: Warren Harris
////////////////////////////////////////////////////////////////////////////////

#ifndef __AEOBJECTS_R__
#define __AEOBJECTS_R__

/* Logical operators: look for them in descriptors of type typeLogicalDescriptor
  with keyword keyAELogicalOperator */
#define kAEAND						'AND '
#define kAEOR						'OR  '
#define kAENOT						'NOT '

/* Absolute ordinals: look for them in descriptors of type typeAbsoluteOrdinal.
  Possible use is as keyAEKeyData in an object specifier whose keyAEKeyForm
  field is formAbsolutePosition. */
#define kAEFirst					'firs'
#define kAELast						'last'
#define kAEMiddle					'midd'
#define kAEAny						'any '
#define kAEAll						'all '

/*  Relative ordinals: look for them in descriptors of type formRelativePosition. */
#define kAENext						'next'
#define kAEPrevious					'prev'

/********** Keywords for getting fields out of object specifier records **********/
#define keyAEDesiredClass			'want'
#define keyAEContainer				'from'
#define keyAEKeyForm				'form'
#define keyAEKeyData	 		 	'seld'


/********** Keywords for getting fields out of Range specifier records **********/
#define keyAERangeStart				'star'		/* These are the only two fields in the range desc */
#define keyAERangeStop				'stop'
	
/********** Possible values for the keyAEKeyForm field of an object specifier **********/
/* Remember that this set is an open-ended one.  The OSL makes assumptions about some of them,
  but nothing in the grammar says you can't define your own */
#define formAbsolutePosition 		'indx'	 	/* e.g., 1st, -2nd ( 2nd from end) */
#define formRelativePosition		'rele' 		/* next, previous */
#define formTest					'test' 		/* A logical or a comparison */
#define formRange					'rang' 		/* Two arbitrary objects and everything in between */
#define formPropertyID				'prop' 		/* Key data is a 4-char property name */
#define formName					'name' 		/* Key data may be of type 'TEXT' */

/************** Various relevant types ****************/
/* Some of these tend to be paired with certain of the forms above.  Where this
  is the case comments indicating the form(s) follow. */
#define typeObjectSpecifier 	 	'obj '		/* keyAEContainer will often be one of these */
#define typeObjectBeingExamined 	'exmn'		/* Another possible value for keyAEContainer */
#define typeCurrentContainer		'ccnt'		/* Another possible value for keyAEContainer */
#define typeToken					'toke'		/* Substituted for 'ccnt' before accessor called */

#define typeRelativeDescriptor 		'rel '		/* formRelativePosition */
#define typeAbsoluteOrdinal 		'abso'		/* formAbsolutePosition */
#define typeIndexDescriptor			'inde'		/* formAbsolutePosition */
#define typeRangeDescriptor 	 	'rang'		/* formRange */
#define typeLogicalDescriptor	 	'logi'		/* formTest is this or typeCompDescriptor */
#define typeCompDescriptor			'cmpd'		/* formTest is this or typeLogicalDescriptor */
	
/************** various relevant keywords ****************/
#define keyAECompOperator			'relo'		/* Relates two terms: '', '<', etc. */
#define keyAELogicalTerms			'term'		/* An AEList of terms to be related by 'logc' below */
#define keyAELogicalOperator		'logc'		/* kAEAND,  kAEOR or kAENOT */
#define keyAEObject1				'obj1'		/* One of two objects in a term must be object specifier */
#define keyAEObject2				'obj2'		/* The other object may be a simple descriptor or obj. spec. */

/************ Internal whose clause format ***************/
/* Only needed if you do whose clauses yourself. */
#define formWhose 'whos'
#define typeWhoseDescriptor 'whos'
#define keyAEIndex 'kidx'
#define keyAETest 'ktst'
#define typeWhoseRange 'wrng'
#define keyAEWhoseRangeStart 'wstr'
#define keyAEWhoseRangeStop 'wstp'

/************ Special Handler selectors for OSL Callbacks ***************/
/* You don't need to use these unless you are not using AESetObjectCallbacks. */
#define keyDisposeTokenProc			'xtok'
#define keyAECompareProc 		 	'cmpr'
#define keyAECountProc 			 	'cont'
#define keyAEMarkTokenProc 		 	'mkid'
#define keyAEMarkProc 			 	'mark'
#define keyAEAdjustMarksProc 	 	'adjm'
#define keyAEGetErrDescProc 	 	'indc'


#endif

////////////////////////////////////////////////////////////////////////////////

