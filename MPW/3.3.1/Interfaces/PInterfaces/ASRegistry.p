{
////////////////////////////////////////////////////////////////////////////////
// Copyright © 1991 Apple Computer, Inc. All rights reserved.
// Author: Warren Harris
////////////////////////////////////////////////////////////////////////////////
// Registry constants
////////////////////////////////////////////////////////////////////////////////
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT ASRegistry;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingASRegistry}
{$SETC UsingASRegistry := 1}

{$I+}
{$SETC ASRegistryIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED UsingAERegistry}
{$I $$Shell(PInterfaces)AERegistry.p}
{$ENDC}
{$IFC UNDEFINED UsingAEObjects}
{$I $$Shell(PInterfaces)AEObjects.p}
{$ENDC}

{$SETC UsingIncludes := ASRegistryIncludes}

CONST
	keyAETarget					= 'targ';
	keySubjectAttr				= 'subj';
	
	{ Magic 'returning' parameter: }
	keyASReturning				= 'Krtn';

	{ AppleScript Specific Codes: }
	kASAppleScriptSuite			= 'ascr';
	kASTypeNamesSuite			= 'tpnm';

	{ Dynamic Terminologies }
	typeAETE					= 'aete';
	typeAEUT					= 'aeut';
	kGetAETE					= 'gdte';
	kGetAEUT					= 'gdut';
	kUpdateAEUT					= 'udut';
	kUpdateAETE					= 'udte';
	kCleanUpAEUT				= 'cdut';
	kASComment					= 'cmnt';	{ comment events }
	kASLaunchEvent				= 'noop';

	{ subroutine calls }
	kASSubroutineEvent			= 'psbr';
	keyASSubroutineName			= 'snam';

	{ Operator Events: }
	{		Binary: }
	kASAdd						= '+   ';
	kASSubtract					= '-   ';
	kASMultiply					= '*   ';
	kASDivide					= '/   ';
	kASQuotient					= 'div ';
	kASRemainder				= 'mod ';
	kASPower					= '^   ';
	kASEqual					= kAEEquals;
	kASNotEqual					= '≠   ';
	kASGreaterThan				= kAEGreaterThan;
	kASGreaterThanOrEqual		= kAEGreaterThanEquals;
	kASLessThan					= kAELessThan;
	kASLessThanOrEqual			= kAELessThanEquals;
	kASComesBefore				= 'cbfr';
	kASComesAfter				= 'cafr';
	kASConcatenate				= 'ccat';
	kASStartsWith				= kAEBeginsWith;
	kASEndsWith					= kAEEndsWith;
	kASContains					= kAEContains;
	kASAnd						= kAEAND;
	kASOr						= kAEOR;
	{		Unary: }
	kASNot						= kAENOT;
	kASNegate					= 'neg ';
	keyASArg					= 'arg ';

	kASErrorEventCode			= 'err ';	{ event code for the 'error' statement }
	kOSAErrorArgs				= 'erra';	{ not used }

	{ Properties: }
	pLength						= 'leng';
	pReverse					= 'rvse';
	pRest						= 'rest';
	pInherits					= 'c@#^';

	{ User-Defined Record Fields: }
	keyASUserRecordFields		= 'usrf';
	typeUserRecordFields		= typeAEList;

	{ Prepositions: }
	keyASPrepositionAt			= 'at  ';
	keyASPrepositionIn			= 'in  ';
	keyASPrepositionFrom		= 'from';
	keyASPrepositionFor			= 'for ';
	keyASPrepositionTo			= 'to  ';
	keyASPrepositionThru		= 'thru';
	keyASPrepositionThrough		= 'thgh';	{ this should be = 'thru';!!! }
	keyASPrepositionBy			= 'by  ';
	keyASPrepositionOn			= 'on  ';
	keyASPrepositionInto		= 'into';
	keyASPrepositionOnto		= 'onto';
	keyASPrepositionBetween		= 'btwn';
	keyASPrepositionAgainst		= 'agst';
	keyASPrepositionOutOf		= 'outo';
	keyASPrepositionInsteadOf	= 'isto';
	keyASPrepositionAsideFrom	= 'asdf';
	keyASPrepositionAround		= 'arnd';
	keyASPrepositionBeside		= 'bsid';
	keyASPrepositionBeneath		= 'bnth';
	keyASPrepositionUnder		= 'undr';
	keyASPrepositionOver		= 'over';
	keyASPrepositionAbove		= 'abve';
	keyASPrepositionBelow		= 'belw';
	keyASPrepositionApartFrom	= 'aprt';
	keyASPrepositionGiven		= 'givn';
	keyASPrepositionWith		= 'with';
	keyASPrepositionWithout		= 'wout';
	{ not in ERS: }
	keyASPrepositionAbout		= 'abou';
	keyASPrepositionSince		= 'snce';
	keyASPrepositionUntil		= 'till';

	{ Terminology & Dialect things: }
	kDialectBundleResType		= 'Dbdl';

	{ AppleScript Classes and Enums: }
	cConstant					= typeEnumerated;
	cClassIdentifier			= pClass;
	cObjectBeingExamined		= typeObjectBeingExamined;
	cList						= typeAEList;
	cSmallReal					= typeSMFloat;
	cReal						= typeFloat;
	cRecord						= typeAERecord;
	cReference					= cObjectSpecifier;
	cUndefined					= 'undf';
	cSymbol						= 'symb';
	cLinkedList					= 'llst';
	cVector						= 'vect';
	cEventIdentifier			= 'evnt';
	cKeyIdentifier				= 'kyid';
	cUserIdentifier				= 'uid ';
	cPreposition				= 'prep';
	cKeyForm					= enumKeyForm;
	cScript						= 'scpt';
	cHandler					= 'hand';
	cProcedure					= 'proc';
	cClosure					= 'clsr';
	cRawData					= 'rdat';
	cString						= typeChar;
	cNumber						= 'nmbr';
	cListOrRecord				= 'lr  ';
	cListOrString				= 'ls  ';
	cListRecordOrString			= 'lrs ';
	cNumberOrDateTime			= 'nd  ';
	cNumberDateTimeOrString		= 'nds ';
	cSeconds					= 'scnd';

	enumBooleanValues			= 'boov';
	kAETrue						= typeTrue;
	kAEFalse					= typeFalse;

	enumMiscValues				= 'misc';
	kASCurrentApplication		= 'cura';

	{ User-defined property ospecs: }
	formUserPropertyID			= 'usrp';

	{ Global properties: }
	pASIt						= 'it  ';
	pASMe						= 'me  ';
	pASResult					= 'rslt';
	pASSpace					= 'spac';
	pASReturn					= 'ret ';
	pASTab						= 'tab ';
	pASPi						= 'pi  ';
	pASParent					= 'pare';
	kASInitializeEventCode		= 'init';
	pASPrintLength				= 'prln';
	pASPrintDepth				= 'prdp';
	pASTopLevelScript			= 'ascr';

	{ Considerations }
	kAECase						= 'case';
	kAEDiacritic				= 'diac';
	kAEWhiteSpace				= 'whit';
	kAEHyphens					= 'hyph';
	kAEExpansion				= 'expa';
	kAEPunctuation				= 'punc';
	kAEZenkakuHankaku			= 'zkhk';
	kAESmallKana				= 'skna';
	kAEKataHiragana				= 'hika';
	enumConsiderations			= 'cons';

	{ AppleScript considerations: }
	kASConsiderReplies			= 'rmte';

	cCoercion					= 'coec';
	cCoerceUpperCase			= 'txup';
	cCoerceLowerCase			= 'txlo';
	cCoerceRemoveDiacriticals	= 'txdc';
	cCoerceRemovePunctuation	= 'txpc';
	cCoerceRemoveHyphens		= 'txhy';
	cCoerceOneByteToTwoByte		= 'txex';
	cCoerceRemoveWhiteSpace		= 'txws';
	cCoerceSmallKana			= 'txsk';
	cCoerceZenkakuhankaku		= 'txze';
	cCoerceKataHiragana			= 'txkh';

	{ Lorax things: }
	cZone						= 'zone';
	cMachine					= 'mach';
	cAddress		 			= 'addr';
	cRunningAddress				= 'radd';
	cStorage					= 'stor';

	{ DateTime things: }
	pASWeekday					= 'wkdy';
	pASMonth					= 'mnth';
	pASDay						= 'day ';
	pASYear						= 'year';
	pASTime						= 'time';
	pASDateString				= 'dstr';
	pASTimeString				= 'tstr';

	{ Months }
	cMonth						= pASMonth;
	cJanuary					= 'jan ';
	cFebruary					= 'feb ';
	cMarch						= 'mar ';
	cApril						= 'apr ';
	cMay						= 'may ';
	cJune						= 'jun ';
	cJuly						= 'jul ';
	cAugust						= 'aug ';
	cSeptember					= 'sep ';
	cOctober					= 'oct ';
	cNovember					= 'nov ';
	cDecember					= 'dec ';

	{ Weekdays }
	cWeekday					= pASWeekday;
	cSunday						= 'sun ';
	cMonday						= 'mon ';
	cTuesday					= 'tue ';
	cWednesday					= 'wed ';
	cThursday					= 'thu ';
	cFriday						= 'fri ';
	cSaturday					= 'sat ';

	{ AS 1.1 Globals: }
	pASQuote					= 'quot';
	pASSeconds					= 'secs';
	pASMinutes					= 'min ';
	pASHours					= 'hour';
	pASDays						= 'days';
	pASWeeks					= 'week';

	{ Writing Code things: }
	cWritingCodeInfo			= 'citl';
	pScriptCode					= 'pscd';
	pLangCode					= 'plcd';

	{ Magic Tell and End Tell events for logging: }
	kASMagicTellEvent			= 'tell';
	kASMagicEndTellEvent		= 'tend';

{$ENDC}    { UsingASRegistry }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}
