/*
	File:		ASRegistry.h

	Copyright:	© 1984-1993 by Apple Computer, Inc., all rights reserved.

	WARNING
	This file was auto generated by the interfacer tool. Modifications
	must be made to the master file.

*/

#ifndef __ASREGISTRY__
#define __ASREGISTRY__

#ifndef __AEREGISTRY__
#include <AERegistry.h>
/*	#include <Types.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*		#include <MixedMode.h>									*/
/*			#include <Traps.h>									*/
/*	#include <AppleEvents.h>									*/
/*		#include <Memory.h>										*/
/*		#include <OSUtils.h>									*/
/*		#include <Events.h>										*/
/*			#include <Quickdraw.h>								*/
/*				#include <QuickdrawText.h>						*/
/*					#include <IntlResources.h>					*/
/*		#include <EPPC.h>										*/
/*			#include <PPCToolBox.h>								*/
/*				#include <AppleTalk.h>							*/
/*			#include <Processes.h>								*/
/*				#include <Files.h>								*/
/*					#include <SegLoad.h>						*/
/*		#include <Notification.h>								*/
#endif

#ifndef __AEOBJECTS__
#include <AEObjects.h>
#endif

enum  {
	keyAETarget					= 0x74617267,					//  'targ'  //
	keySubjectAttr				= 0x7375626a,					//  'subj'  //
// Magic 'returning' parameter:
	keyASReturning				= 0x4b72746e,					//  'Krtn'  //
// AppleScript Specific Codes:
	kASAppleScriptSuite			= 0x61736372,					//  'ascr'  //
	kASTypeNamesSuite			= 0x74706e6d,					//  'tpnm'  //
// dynamic terminologies
	typeAETE					= 0x61657465,					//  'aete'  //
	typeAEUT					= 0x61657574,					//  'aeut'  //
	kGetAETE					= 0x67647465,					//  'gdte'  //
	kGetAEUT					= 0x67647574,					//  'gdut'  //
	kUpdateAEUT					= 0x75647574,					//  'udut'  //
	kUpdateAETE					= 0x75647465,					//  'udte'  //
	kCleanUpAEUT				= 0x63647574,					//  'cdut'  //
	kASComment					= 0x636d6e74,					//  'cmnt'  //
	kASLaunchEvent				= 0x6e6f6f70,					//  'noop'  //
	keyScszResource				= 0x7363737A,					//  'scsz'  //
	typeScszResource			= 0x7363737A,					//  'scsz'  //
// subroutine calls
	kASSubroutineEvent			= 0x70736272,					//  'psbr'  //
	keyASSubroutineName			= 0x736e616d					//  'snam'  //
};


// Operator Events:

enum  {
//		Binary:
	kASAdd						= 0x2b202020,					//  '+   '  //
	kASSubtract					= 0x2d202020,					//  '-   '  //
	kASMultiply					= 0x2a202020,					//  '*   '  //
	kASDivide					= 0x2f202020,					//  '/   '  //
	kASQuotient					= 0x64697620,					//  'div '  //
	kASRemainder				= 0x6d6f6420,					//  'mod '  //
	kASPower					= 0x5e202020,					//  '^   '  //
	kASEqual					= kAEEquals,
	kASNotEqual					= 0xad202020,					//  '≠   '  //
	kASGreaterThan				= kAEGreaterThan,
	kASGreaterThanOrEqual		= kAEGreaterThanEquals,
	kASLessThan					= kAELessThan,
	kASLessThanOrEqual			= kAELessThanEquals,
	kASComesBefore				= 0x63626672,					//  'cbfr'  //
	kASComesAfter				= 0x63616672,					//  'cafr'  //
	kASConcatenate				= 0x63636174,					//  'ccat'  //
	kASStartsWith				= kAEBeginsWith,
	kASEndsWith					= kAEEndsWith,
	kASContains					= kAEContains
};

enum  {
	kASAnd						= kAEAND,
	kASOr						= kAEOR,
//	Unary:
	kASNot						= kAENOT,
	kASNegate					= 0x6e656720,					//  'neg '  //
	keyASArg					= 0x61726720					//  'arg '  //
};

enum  {
// event code for the 'error' statement
	kASErrorEventCode			= 0x65727220,					//  'err '  //
	kOSAErrorArgs				= 0x65727261,					//  'erra'  //
// Properties:
	pLength						= 0x6c656e67,					//  'leng'  //
	pReverse					= 0x72767365,					//  'rvse'  //
	pRest						= 0x72657374,					//  'rest'  //
	pInherits					= 0x6340235e,					//  'c@#^'  //
// User-Defined Record Fields:
	keyASUserRecordFields		= 0x75737266,					//  'usrf'  //
	typeUserRecordFields		= 'list'
};


// Prepositions:

enum  {
	keyASPrepositionAt			= 0x61742020,					//  'at  '  //
	keyASPrepositionIn			= 0x696e2020,					//  'in  '  //
	keyASPrepositionFrom		= 0x66726f6d,					//  'from'  //
	keyASPrepositionFor			= 0x666f7220,					//  'for '  //
	keyASPrepositionTo			= 0x746f2020,					//  'to  '  //
	keyASPrepositionThru		= 0x74687275,					//  'thru'  //
	keyASPrepositionThrough		= 0x74686768,					//  'thgh'  //
	keyASPrepositionBy			= 0x62792020,					//  'by  '  //
	keyASPrepositionOn			= 0x6f6e2020,					//  'on  '  //
	keyASPrepositionInto		= 0x696e746f,					//  'into'  //
	keyASPrepositionOnto		= 0x6f6e746f,					//  'onto'  //
	keyASPrepositionBetween		= 0x6274776e,					//  'btwn'  //
	keyASPrepositionAgainst		= 0x61677374,					//  'agst'  //
	keyASPrepositionOutOf		= 0x6f75746f,					//  'outo'  //
	keyASPrepositionInsteadOf	= 0x6973746f,					//  'isto'  //
	keyASPrepositionAsideFrom	= 0x61736466,					//  'asdf'  //
	keyASPrepositionAround		= 0x61726e64,					//  'arnd'  //
	keyASPrepositionBeside		= 0x62736964,					//  'bsid'  //
	keyASPrepositionBeneath		= 0x626e7468,					//  'bnth'  //
	keyASPrepositionUnder		= 0x756e6472					//  'undr'  //
};

enum  {
	keyASPrepositionOver		= 0x6f766572,					//  'over'  //
	keyASPrepositionAbove		= 0x61627665,					//  'abve'  //
	keyASPrepositionBelow		= 0x62656c77,					//  'belw'  //
	keyASPrepositionApartFrom	= 0x61707274,					//  'aprt'  //
	keyASPrepositionGiven		= 0x6769766e,					//  'givn'  //
	keyASPrepositionWith		= 0x77697468,					//  'with'  //
	keyASPrepositionWithout		= 0x776f7574,					//  'wout'  //
	keyASPrepositionAbout		= 0x61626f75,					//  'abou'  //
	keyASPrepositionSince		= 0x736e6365,					//  'snce'  //
	keyASPrepositionUntil		= 0x74696c6c					//  'till'  //
};

enum  {
// Terminology & Dialect things:
	kDialectBundleResType		= 0x4462646c,					//  'Dbdl'  //
// AppleScript Classes and Enums:
	cConstant					= 'enum',
	cClassIdentifier			= pClass,
	cObjectBeingExamined		= typeObjectBeingExamined,
	cList						= 'list',
	cSmallReal					= 'sing',
	cReal						= 'doub',
	cRecord						= 'reco',
	cReference					= cObjectSpecifier,
	cUndefined					= 0x756e6466,					//  'undf'  //
	cSymbol						= 0x73796d62,					//  'symb'  //
	cLinkedList					= 0x6c6c7374,					//  'llst'  //
	cVector						= 0x76656374,					//  'vect'  //
	cEventIdentifier			= 0x65766e74,					//  'evnt'  //
	cKeyIdentifier				= 0x6b796964,					//  'kyid'  //
	cUserIdentifier				= 0x75696420,					//  'uid '  //
	cPreposition				= 0x70726570,					//  'prep'  //
	cKeyForm					= enumKeyForm,
	cScript						= 0x73637074,					//  'scpt'  //
	cHandler					= 0x68616e64,					//  'hand'  //
	cProcedure					= 0x70726f63					//  'proc'  //
};

enum  {
	cClosure					= 0x636c7372,					//  'clsr'  //
	cRawData					= 0x72646174,					//  'rdat'  //
	cString						= 'TEXT',
	cNumber						= 0x6e6d6272,					//  'nmbr'  //
	cListOrRecord				= 0x6c722020,					//  'lr  '  //
	cListOrString				= 0x6c732020,					//  'ls  '  //
	cListRecordOrString			= 0x6c727320,					//  'lrs '  //
	cNumberOrDateTime			= 0x6e642020,					//  'nd  '  //
	cNumberDateTimeOrString		= 0x6e647320,					//  'nds '  //
	cSeconds					= 0x73636e64,					//  'scnd'  //
	enumBooleanValues			= 0x626f6f76,					//  'boov'  //
	kAETrue						= 'true',
	kAEFalse					= 'fals',
	enumMiscValues				= 0x6d697363,					//  'misc'  //
	kASCurrentApplication		= 0x63757261,					//  'cura'  //
// User-defined property ospecs:
	formUserPropertyID			= 0x75737270					//  'usrp'  //
};

enum  {
// Global properties:
	pASIt						= 0x69742020,					//  'it  '  //
	pASMe						= 0x6d652020,					//  'me  '  //
	pASResult					= 0x72736c74,					//  'rslt'  //
	pASSpace					= 0x73706163,					//  'spac'  //
	pASReturn					= 0x72657420,					//  'ret '  //
	pASTab						= 0x74616220,					//  'tab '  //
	pASPi						= 0x70692020,					//  'pi  '  //
	pASParent					= 0x70617265,					//  'pare'  //
	kASInitializeEventCode		= 0x696e6974,					//  'init'  //
	pASPrintLength				= 0x70726c6e,					//  'prln'  //
	pASPrintDepth				= 0x70726470,					//  'prdp'  //
	pASTopLevelScript			= 0x61736372					//  'ascr'  //
};

enum  {
// Considerations
	kAECase						= 0x63617365,					//  'case'  //
	kAEDiacritic				= 0x64696163,					//  'diac'  //
	kAEWhiteSpace				= 0x77686974,					//  'whit'  //
	kAEHyphens					= 0x68797068,					//  'hyph'  //
	kAEExpansion				= 0x65787061,					//  'expa'  //
	kAEPunctuation				= 0x70756e63,					//  'punc'  //
	kAEZenkakuHankaku			= 0x7a6b686b,					//  'zkhk'  //
	kAESmallKana				= 0x736b6e61,					//  'skna'  //
	kAEKataHiragana				= 0x68696b61,					//  'hika'  //
// AppleScript considerations:
	kASConsiderReplies			= 0x726d7465,					//  'rmte'  //
	enumConsiderations			= 0x636f6e73					//  'cons'  //
};

enum  {
	cCoercion					= 0x636f6563,					//  'coec'  //
	cCoerceUpperCase			= 0x74787570,					//  'txup'  //
	cCoerceLowerCase			= 0x74786c6f,					//  'txlo'  //
	cCoerceRemoveDiacriticals	= 0x74786463,					//  'txdc'  //
	cCoerceRemovePunctuation	= 0x74787063,					//  'txpc'  //
	cCoerceRemoveHyphens		= 0x74786879,					//  'txhy'  //
	cCoerceOneByteToTwoByte		= 0x74786578,					//  'txex'  //
	cCoerceRemoveWhiteSpace		= 0x74787773,					//  'txws'  //
	cCoerceSmallKana			= 0x7478736b,					//  'txsk'  //
	cCoerceZenkakuhankaku		= 0x74787a65,					//  'txze'  //
	cCoerceKataHiragana			= 0x74786b68,					//  'txkh'  //
// Lorax things:
	cZone						= 0x7a6f6e65,					//  'zone'  //
	cMachine					= 0x6d616368,					//  'mach'  //
	cAddress					= 0x61646472,					//  'addr'  //
	cRunningAddress				= 0x72616464,					//  'radd'  //
	cStorage					= 0x73746f72					//  'stor'  //
};

enum  {
// DateTime things:
	pASWeekday					= 0x776b6479,					//  'wkdy'  //
	pASMonth					= 0x6d6e7468,					//  'mnth'  //
	pASDay						= 0x64617920,					//  'day '  //
	pASYear						= 0x79656172,					//  'year'  //
	pASTime						= 0x74696d65,					//  'time'  //
	pASDateString				= 0x64737472,					//  'dstr'  //
	pASTimeString				= 0x74737472,					//  'tstr'  //
// Months
	cMonth						= pASMonth,
	cJanuary					= 0x6a616e20,					//  'jan '  //
	cFebruary					= 0x66656220,					//  'feb '  //
	cMarch						= 0x6d617220,					//  'mar '  //
	cApril						= 0x61707220,					//  'apr '  //
	cMay						= 0x6d617920,					//  'may '  //
	cJune						= 0x6a756e20,					//  'jun '  //
	cJuly						= 0x6a756c20,					//  'jul '  //
	cAugust						= 0x61756720,					//  'aug '  //
	cSeptember					= 0x73657020,					//  'sep '  //
	cOctober					= 0x6f637420,					//  'oct '  //
	cNovember					= 0x6e6f7620,					//  'nov '  //
	cDecember					= 0x64656320					//  'dec '  //
};

enum  {
// Weekdays
	cWeekday					= pASWeekday,
	cSunday						= 0x73756e20,					//  'sun '  //
	cMonday						= 0x6d6f6e20,					//  'mon '  //
	cTuesday					= 0x74756520,					//  'tue '  //
	cWednesday					= 0x77656420,					//  'wed '  //
	cThursday					= 0x74687520,					//  'thu '  //
	cFriday						= 0x66726920,					//  'fri '  //
	cSaturday					= 0x73617420,					//  'sat '  //
// AS 1.1 Globals:
	pASQuote					= 0x71756f74,					//  'quot'  //
	pASSeconds					= 0x73656373,					//  'secs'  //
	pASMinutes					= 0x6d696e20,					//  'min '  //
	pASHours					= 0x686f7572,					//  'hour'  //
	pASDays						= 0x64617973,					//  'days'  //
	pASWeeks					= 0x7765656b,					//  'week'  //
// Writing Code things:
	cWritingCodeInfo			= 0x6369746c,					//  'citl'  //
	pScriptCode					= 0x70736364,					//  'pscd'  //
	pLangCode					= 0x706c6364,					//  'plcd'  //
// Magic Tell and End Tell events for logging:
	kASMagicTellEvent			= 0x74656c6c,					//  'tell'  //
	kASMagicEndTellEvent		= 0x74656e64					//  'tend'  //
};

#endif

