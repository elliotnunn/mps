#ifndef __KIBITZ__
#define __KIBITZ__

#ifndef __CHESS__
#include "chess.h"
#endif

/********/

typedef struct {
	Boolean		docDirty;
	Boolean		readOnly;
	short		refNum;
	FSSpec		fss;
	WindowPtr	window;
} FileStateRec, *FileStatePtr;

typedef struct {
	FileStateRec	fileState;
	TheDoc			doc;
} FileRec, *FileRecPtr, **FileRecHndl;

/********/

typedef unsigned long uint32;
typedef unsigned short uint16;
typedef	long	int32;
typedef short	int16;

/********/

#define kCustomEventClass  'CUST'
#define kibitzAESendGame   'KGAM'
#define kibitzAESendMssg   'KMSG'

#define keyLongReply       'KLRP'
#define keyShortReply      'KSRP'
#define keyGameID          'GAME'
#define keyTime            'TIME'
#define keyPascalReply     'PSTR'
#define keyPascal2Reply    'PST2'
#define keyPascal3Reply    'PST3'
#define keyTextMessage	   'MSSG'
#define keySoundMessage	   'SNDM'

#define typeTheBoard       'BORD'
#define typeGameMoves      'GAME'
#define typeMssg           'MSSG'
#define typeDoubleLong     'DBLL'
#define typePascal         'PSTR'
#define typePascal2        'PST2'
#define typePascal3        'PST3'

#define keyReplyErr        'errn'

/********/

#define kLeastVersion	104
#define kVersion		105
#define kWrongVersion	105

#define kArrangeBoard	-1
#define kOnePlayer		0
#define kTwoPlayer		1
#define kLimbo			2

#define kIsMove			0
#define kScrolling		1
#define kResync			2
#define kHandResync		3

#define kAmWhiteMssg		0
#define kAmBlackMssg		1
#define kDisconnectMssg		2
#define kTimeMssg			3
#define kTextMssg			4
#define kSoundMssg			5
#define kBeepMssg			6

#define kInvalVRefNum	0

#define kSaveYes		1
#define kSaveNo			3
#define kSaveCanceled	4

#define kOpenYes		1
#define kOpenNo			3

#define kMaxNumWindows	65535

#define kBoardHOffset	-1
#define kBoardVOffset	-1
#define kBoardSqSize	33

#define kBoardHeight		(8 * kBoardSqSize)
#define kBoardHalfHeight	(4 * kBoardSqSize)

#define kBoardWidth			(8 * kBoardSqSize)
#define kBoardHalfWidth		(4 * kBoardSqSize)

#define rJustBoardWindowWidth (kBoardWidth - 1)

#define kMessageIn		0
#define kMessageOut		1

#define kTEScroll		20

#endif
