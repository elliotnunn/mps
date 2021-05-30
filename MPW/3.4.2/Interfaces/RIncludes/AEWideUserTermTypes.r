/*
	File:		AEWideUserTermTypes.r

	Contains:	Type Declarations for Rez and DeRez
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.5
 
 	Copyright:	© 1992-1997 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
*/


/* Resource Descriptions for									*/
/* Apple Event User Terminology Resources						*/
/* This version uses a wide format for groups of booleans		*/

#ifndef __AEWIDEUSERTERMTYPES__
#define __AEWIDEUSERTERMTYPES__ 1

#include "AEObjects.r"

#include "SysTypes.r"
#define kAEUserTerminology			'aeut'
#define kAETerminologyExtension		'aete'
#define kAEScriptingSizeResource	'scsz'


// "reserved" needs to be defined to be false for resources
//   but undef'ed for type definitions.  We preserve its state
//   and undef it here.

#undef reserved

/* Description of the Apple Event User Terminology resource		*/
/* This resource is provided by Apple Computer, Inc.			*/
type kAEUserTerminology {
		hex byte;											/* major version in BCD		*/
		hex byte;											/* minor version in BCD		*/
		integer		Language, english = 0, japanese = 11;	/* language code			*/
		integer		Script, roman = 0;						/* script code				*/
		integer = $$Countof(Suites);
		array Suites {
				pstring;									/* suite name				*/
				pstring;									/* suite description		*/
				align word;									/* alignment				*/
				literal longint;							/* suite ID					*/
				integer;									/* suite level				*/
				integer;									/* suite version			*/
				integer = $$Countof(Events);
				array Events {
					pstring;								/* event name				*/
					pstring;								/* event description		*/
					align word;								/* alignment				*/
					literal longint;						/* event class				*/
					literal longint;						/* event ID					*/
					literal longint		noReply = 'null';	/* reply type				*/
					pstring;								/* reply description		*/
					align word;								/* alignment				*/
					wide array [1] {
						boolean	replyRequired,					/* if the reply is  		*/
								replyOptional;					/*   required   			*/
						boolean singleItem,						/* if the reply must be a   */
								listOfItems;					/*   list					*/										
						boolean notEnumerated,					/* if the type is			*/
								enumerated;						/*	 enumerated				*/
						boolean	notTightBindingFunction,		/* if the message has tight	*/
								tightBindingFunction;			/*   binding precedence		*/
						boolean	reserved;						/* these 13 bits are 		*/
						boolean	reserved;						/*   reserved; set them		*/
						boolean	reserved;						/*   to "reserved" 			*/
						boolean	reserved;
					/* the following bits are reserved for localization */
						boolean	reserved;
						boolean	reserved;
						boolean	reserved;
						boolean	reserved;
						boolean	verbEvent,						/* for Japanese; nonVerb    */
								nonVerbEvent;					/*  is used as an expr v.s. */
																/*  v.s. verb is a command  */
							/* the following 3 bits are considered as a part of look up key */
						boolean	reserved;
						boolean	reserved;
						boolean	reserved;
					};
					literal longint		noDirectParam = 'null',
										noParams ='null';	/* direct param type		*/
					pstring;								/* direct param description	*/
					align word;								/* alignment				*/
					wide array [1] {
						boolean	directParamRequired,			/* if the direct param 		*/
								directParamOptional;			/*   is required      		*/
						boolean singleItem,						/* if the param must be a   */
								listOfItems;					/*   list					*/										
						boolean notEnumerated,					/* if the type is			*/
								enumerated;						/*	 enumerated				*/
						boolean	doesntChangeState,				/* if the event changes     */
								changesState;					/*   server's state			*/
						boolean	reserved;						/* these 12 bits are 		*/
						boolean	reserved;						/*   reserved; set them		*/
						boolean	reserved;						/*   to "reserved" 			*/
						boolean	reserved;
						boolean	reserved;
						boolean	reserved;
						boolean	reserved;
						boolean	reserved;
						boolean	reserved;
						boolean	reserved;
						boolean	reserved;
						boolean	reserved;
					};
					integer = $$Countof(OtherParams);
					array OtherParams {
						pstring;							/* parameter name			*/
						align word;							/* alignment				*/
						literal longint;					/* parameter keyword		*/
						literal longint;					/* parameter type			*/
						pstring;							/* parameter description	*/
						align word;							/* alignment				*/
						wide array [1] {
							boolean	required,
									optional;					/* if param is optional		*/
							boolean singleItem,					/* if the param must be a   */
									listOfItems;				/*   list					*/										
							boolean notEnumerated,				/* if the type is			*/
									enumerated;					/*	 enumerated				*/
							boolean	reserved;
							boolean	reserved;					/* these bits are 			*/
							boolean	reserved;					/*   reserved; set them		*/
							boolean	reserved;					/*   to "reserved" 			*/
							boolean	reserved;
						/* the following bits are reserved for localization */
							boolean	reserved;
							boolean	reserved;
							boolean	reserved;
							boolean	reserved;
							boolean	prepositionParam,			/* for Japanese; labeled 	*/
									labeledParam;				/*  param name comes before */
																/*  the param value		    */
								/* the following 3 bits are considered as a part of look up key */
							boolean	notFeminine,				/* feminine					*/
									feminine;
							boolean	notMasculine,				/* masculine				*/	
									masculine;					
							boolean	singular,
									plural;						/* plural					*/
						};
					};
				};
				integer = $$Countof(Classes);
				array Classes {
					pstring;								/* class name				*/
					align word;								/* alignment				*/
					literal longint;						/* class ID					*/
					pstring;								/* class description		*/
					align word;								/* alignment				*/
					integer = $$Countof(Properties);
					array Properties {
						pstring;							/* property name			*/
						align word;							/* alignment				*/
						literal longint;					/* property ID				*/
						literal longint;					/* property class			*/
						pstring;							/* property description		*/
						align word;							/* alignment				*/
						wide array [1] {
							boolean	reserved;					/* reserved					*/
							boolean singleItem,					/* if the property must be  */
									listOfItems;				/*   a list					*/										
							boolean notEnumerated,				/* if the type is			*/
									enumerated;					/*	 enumerated				*/
							boolean	readOnly,					/* can only read it			*/
									readWrite;					/* can read or write it		*/
							boolean	reserved;					/* these 12 bits are 		*/
							boolean	reserved;					/*   reserved; set them		*/
							boolean	reserved;					/*   to "reserved" 			*/
							boolean	reserved;
					/* the following bits are reserved for localization */
							boolean	reserved;
							boolean	reserved;
							boolean	reserved;
							boolean	reserved;
							boolean	noApostrophe,	/* This bit is special to the French dialect */
									apostrophe;		/* It indicates that the name begins */
													/* with a vowel */
								/* the following 3 bits are considered as a part of look up key */
											/* what if both feminine and masculine? */
								/* the following 3 bits are considered as a part of look up key */
							boolean	notFeminine,				/* feminine					*/
									feminine;
							boolean	notMasculine,				/* masculine				*/	
									masculine;					
							boolean	singular,
									plural;						/* plural					*/
						};
					};
					integer = $$Countof(Elements);
					array Elements {
						literal longint;					/* element class			*/
						integer = $$Countof(KeyForms);
						array KeyForms {					/* list of key forms		*/
							literal longint;				/* key form ID				*/
						};
					};
				};
				integer = $$Countof(ComparisonOps);
				array ComparisonOps {
					pstring;								/* comparison operator name	*/
					align word;								/* alignment				*/
					literal longint;						/* comparison operator ID	*/
					pstring;								/* comparison comment		*/
					align word;								/* alignment				*/
				};
				integer = $$Countof(Enumerations);
				array Enumerations {						/* list of Enumerations		*/
					literal longint;						/* Enumeration ID			*/
					integer = $$Countof(Enumerators);
					array Enumerators {						/* list of Enumerators		*/
						pstring;							/* Enumerator name			*/
						align word;							/* alignment				*/
						literal longint;					/* Enumerator ID			*/
						pstring;							/* Enumerator comment		*/
						align word;							/* alignment				*/
					};
				};
			};
		};
		
/* Description of the Apple Event Terminology Extension resource		*/
/* This resource is provided by your application						*/
/* AEUT and AETE have the same format						*/

type kAETerminologyExtension as kAEUserTerminology;

type kAEScriptingSizeResource {
	boolean				dontReadExtensionTerms,	readExtensionTerms, dontLaunchToGetTerminology = 0, launchToGetTerminology = 1;
	boolean				findAppBySignature,		dontFindAppBySignature;
	boolean				dontAlwaysSendSubject,	alwaysSendSubject;
	boolean				reserved;
	boolean				reserved;
	boolean				reserved;
	boolean				reserved;
	boolean				reserved;
	boolean				reserved;
	boolean				reserved;
	boolean				reserved;
	boolean				reserved;
	boolean				reserved;
	boolean				reserved;
	boolean				reserved;
	boolean				reserved;
	/* Memory sizes are in bytes. Zero means use default. */
	unsigned longint	minStackSize;
	unsigned longint	preferredStackSize;
	unsigned longint	maxStackSize;
	unsigned longint	minHeapSize;
	unsigned longint	preferredHeapSize;
	unsigned longint	maxHeapSize;	
};

#define reserved false
#endif