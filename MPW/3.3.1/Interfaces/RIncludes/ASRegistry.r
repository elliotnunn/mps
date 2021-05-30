/*
	ASRegistry.r -- Type Declarations for Rez and DeRez
	
	Copyright Apple Computer, Inc. 1993-1994
	All rights reserved.

	Saturday, March 26, 1994 17:34:25
*/

#ifndef __ASREGISTRY__
#define __ASREGISTRY__

#define kASAppleScriptSuite			'ascr'
#define kASTypeNamesSuite			'tpnm'

// Dynamic Terminologies:
#define typeAETE					'aete'
#define typeAEUT					'aeut'
#define kGetAETE					'gdte'
#define kGetAEUT					'gdut'
#define kASCommentEvent				'cmnt'
#define kASLaunchEvent				'noop'

// User-defined record fields:
#define keyASUserRecordFields		'usrf'
#define typeUserRecordFields		'list'

// Operator Events:
#define keyASArg					'arg '
	// Binary:
#define kASEqual					'=   '
#define kASNotEqual					'≠   '
#define kASGreaterThan				'>   '
#define kASGreaterThanOrEqual		'>=  '
#define kASLessThan					'<   '
#define kASLessThanOrEqual			'<=  '
#define kASStartsWith				'bgwt'
#define kASEndsWith					'ends'
#define kASContains					'cont'
	// not currently sent:
#define kASConcatenate				'ccat'
#define kASAdd						'+   '
#define kASSubtract					'-   '
#define kASMultiply					'*   '
#define kASDivide					'/   '
#define kASQuotient					'div '
#define kASRemainder				'mod '
#define kASPower					'^   '
	// Unary:
#define kASNegate					'neg '

// Subroutine Events:
#define kASSubroutineEvent			'psbr'
#define keyASSubroutineName			'snam'

// Subroutine event parameter prepositions:
#define keyASPrepositionAt			'at  '
#define keyASPrepositionIn			'in  '
#define keyASPrepositionFrom		'from'
#define keyASPrepositionFor			'for '
#define keyASPrepositionTo			'to  '
#define keyASPrepositionThru		'thru'
#define keyASPrepositionThrough		'thgh'
#define keyASPrepositionBy			'by  '
#define keyASPrepositionOn			'on  '
#define keyASPrepositionInto		'into'
#define keyASPrepositionOnto		'onto'
#define keyASPrepositionBetween		'btwn'
#define keyASPrepositionAgainst		'agst'
#define keyASPrepositionOutOf		'outo'
#define keyASPrepositionInsteadOf	'isto'
#define keyASPrepositionAsideFrom	'asdf'
#define keyASPrepositionAround		'arnd'
#define keyASPrepositionBeside		'bsid'
#define keyASPrepositionBeneath		'bnth'
#define keyASPrepositionUnder		'undr'
#define keyASPrepositionOver		'over'
#define keyASPrepositionAbove		'abve'
#define keyASPrepositionBelow		'belw'
#define keyASPrepositionApartFrom	'aprt'
#define keyASPrepositionAbout		'abou'
#define keyASPrepositionSince		'snce'
#define keyASPrepositionUntil		'till'

// AppleScript Classes and Enums:
#define cEventIdentifier			'evnt'
#define cScript						'scpt'
#define cSeconds					'scnd'
#define cList						'list'
#define cRecord						'reco'

// List properties:
#define pLength						'leng'
#define pReverse					'rvse'
#define pRest						'rest'

// Script properties:
#define pASParent					'pare'

// Properties of global environment:
#define pASPrintLength				'prln'
#define pASPrintDepth				'prdp'

// Considerations:
#define enumConsiderations			'cons'
#define kAECase						'case'
#define kAEDiacritic				'diac'
#define kAEWhiteSpace				'whit'
#define kAEHyphens					'hyph'
#define kAEExpansion				'expa'
#define kAEPunctuation				'punc'
#define kAEZenkakuHankaku			'zkhk'
#define kAESmallKana				'skna'
#define kAEKataHiragana				'hika'
	// AppleScript considerations:
#define kASConsiderReplies			'rmte'

// System classes:
#define cZone						'zone'
#define cMachine					'mach'

// New stuff for AppleScript 1.1:
#define cClassIdentifier			'pcls'
#define cClosure					'clsr'
#define cCoerceKataHiragana			'txkh'
#define cCoerceLowerCase			'txlo'
#define cCoerceOneByteToTwoByte		'txex'
#define cCoerceRemoveDiacriticals	'txdc'
#define cCoerceRemoveHyphens		'txhy'
#define cCoerceRemovePunctuation	'txpc'
#define cCoerceRemoveWhiteSpace		'txws'
#define cCoerceSmallKana			'txsk'
#define cCoerceUpperCase			'txup'
#define cCoerceZenkakuhankaku		'txze'
#define cCoercion					'coec'
#define cConstant					'enum'
#define cHandler					'hand'
#define cKeyForm					'keyf'
#define cKeyIdentifier				'kyid'
#define cLinkedList					'llst'
#define cListElement				'celm'
#define cListOrRecord				'lr  '
#define cListOrString				'ls  '
#define cListRecordOrString			'lrs '
#define cNumber						'nmbr'
#define cNumberOrDateTime			'nd  '
#define cNumberDateTimeOrString		'nds '
#define cObjectBeingExamined		'exmn'
#define cPreposition				'prep'
#define cProcedure					'proc'
#define cRawData					'rdat'
#define cReal						'doub'
#define cReference					'obj '
#define cSmallReal					'sing'
// shouldn't #define cString as anything since it's a built-in Rez type.
// Instead, use cStringClass.
//#define cString						'TEXT'
#define cStringClass				'TEXT'
#define cSymbol						'symb'
#define cUndefined					'undf'
#define cUserIdentifier				'uid '
#define cVector						'vect'
#define enumBooleanValues			'boov'
#define enumMiscValues				'misc'
#define kAEFalse					'fals'
#define kAETrue						'true'
#define kASComesAfter				'cafr'
#define kASComesBefore				'cbfr'
#define kASComment					'cmnt'
#define kASCurrentApplication		'cura'
#define kASPrepositionalSubroutine	'psbr'
#define kASSubroutineName			'snam'
#define kCleanUpAEUT				'cdut'
#define kDialectBundleResType		'Dbdl'
#define keyAEErrorObject			'erob'
#define keyAETarget					'targ'
#define keyASPositionalArgs			'parg'
#define keyASPrepositionGiven		'givn'
#define keyASPrepositionWith		'with'
#define keyASPrepositionWithout		'wout'
#define kUpdateAETE					'udte'
#define kUpdateAEUT					'udut'
#define pASIt						'it  '
#define pASMe						'me  '
#define pASPi						'pi  '
#define pASTopLevelScript			'ascr'
#define pASResult					'rslt'
#define pASReturn					'ret '
#define pASSpace					'spac'
#define pASTab						'tab '
#define pInherits					'c@#^'
#define kASErrorEventCode			'err '
#define kASInitializeEventCode		'init'
#define kOSAErrorNumber				'errn'
#define kOSAErrorMessage			'errs'
#define kOSAErrorBriefMessage		'errb'
#define kOSAErrorApp				'erap'
#define kOSAErrorPartialResult		'ptlr'
#define kOSAErrorOffendingObject	'erob'
#define kOSAErrorRange				'erng'
#define kOSAErrorExpectedType		'errt'	// forgotten from OSA.h
#define keyASSubjectAttr			'subj'

// Magic 'returning' parameter:
#define keyASReturning				'Krtn'

// DateTime things:
#define pASWeekday					'wkdy'
#define pASMonth					'mnth'
#define pASDay						'day '
#define pASYear						'year'
#define pASTime						'time'
#define pASDateString				'dstr'
#define pASTimeString				'tstr'

// Months
#define cMonth						pASMonth
#define cJanuary					'jan '
#define cFebruary					'feb '
#define cMarch						'mar '
#define cApril						'apr '
#define cMay						'may '
#define cJune						'jun '
#define cJuly						'jul '
#define cAugust						'aug '
#define cSeptember					'sep '
#define cOctober					'oct '
#define cNovember					'nov '
#define cDecember					'dec '

// Weekdays
#define cWeekday					pASWeekday
#define cSunday						'sun '
#define cMonday						'mon '
#define cTuesday					'tue '
#define cWednesday					'wed '
#define cThursday					'thu '
#define cFriday						'fri '
#define cSaturday					'sat '

// AS 1.1 Globals:
#define pASQuote					'quot'
#define pASSeconds					'secs'
#define pASMinutes					'min '
#define pASHours					'hour'
#define pASDays						'days'
#define pASWeeks					'week'

// Writing Code things:
#define cWritingCodeInfo			'citl'
#define pScriptCode					'pscd'
#define pLangCode					'plcd'

// Magic Tell and End Tell events for logging:
#define kASMagicTellEvent			'tell'
#define kASMagicEndTellEvent		'tend'

#endif __ASREGISTRY__
