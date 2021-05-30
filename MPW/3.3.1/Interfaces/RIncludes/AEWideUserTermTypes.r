////////////////////////////////////////////////////////////////////////////////
// Copyright © 1993 Apple Computer, Inc. All rights reserved.
////////////////////////////////////////////////////////////////////////////////

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
						boolean	reserved;						/* these 13 bits are 		*/
						boolean	reserved;						/*   reserved; set them		*/
						boolean	reserved;						/*   to "reserved" 			*/
						boolean	reserved;
						boolean	reserved;
					/* the following bits are reserved for localization, can we? */
						boolean	reserved;
						boolean	reserved;
						boolean	reserved;
						boolean	reserved;
						boolean	verbEvent,						/* for Japanese; nonVerb is */
								nonVerbEvent;					/*  is used as an expr v.s. */
																/*  v.s. verb is a command  */
							/* the following 3 bits are considered as a part of look up key */
						boolean	reserved;
						boolean	reserved;
						boolean	reserved;
						};
					literal longint		noParams = 'null';	/* direct param type		*/
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
							boolean	reserved;
							boolean	prepositionParam,			/* for Japanese; labeld 	*/
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
							boolean	reserved;
								/* the following 3 bits are considered as a part of look up key */
											/* what if both feminine and masculine? */
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
		
/* AEUT and AETE have the same format						*/

type kAETerminologyExtension as kAEUserTerminology;

type kAEScriptingSizeResource {
	boolean				dontReadExtensionTerms, readExtensionTerms;
	boolean				findAppBySignature,		dontFindAppBySignature;
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