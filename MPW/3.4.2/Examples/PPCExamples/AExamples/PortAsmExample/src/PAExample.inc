;------------------------------------------------------------------------------
;
;	PortAsm Simple Example	By Steven Ellis
;
;	Copyright MicroAPL Ltd 1993/4
;
;	Include file for most of our standard equates
;
;------------------------------------------------------------------------------

VIRWIDTH  EQU	1280			; Virtual window dimensions used by 
VIRHEIGHT EQU	1024			; C portion of demo program

EnvironsVersion	EQU	1		; this is the version of the SysEnvirons we want

MinHeap		EQU	21*1024		; minimum heap size in bytes

MinSpace	EQU	8*1024		; minimum stack space in bytes

DITopLeft	EQU	$00500070	; position of Disk Init dialogs

;*************************************************
; The following equates are for resources.
;*************************************************
rMenuBar	EQU	128		; application's menu bar
rUserAlert	EQU	129		; error alert for user
rWindow		EQU	128		; application's window

;*************************************************
; The following equates are for menu definitions
;*************************************************
AppleMenu	EQU	128		;  Apple menu
AboutItem	EQU	1

FileMenu	EQU	129		;  File menu
NewItem		EQU	1
OpenItem	EQU	2
CloseItem	EQU	4
SaveItem	EQU	5
SaveAsItem	EQU	6
RevertItem	EQU	7
PageSetupItem	EQU	9
PrintItem	EQU	10
QuitItem	EQU	12

EditMenu	EQU	130		;  Edit menu
UndoItem	EQU	1
CutItem		EQU	3
CopyItem	EQU	4
PasteItem	EQU	5
ClearItem	EQU	6

ColorMenu	EQU	131		;  Color menu
RedItem		EQU	1
YellowItem	EQU	2
MagentaItem	EQU	3
GreenItem	EQU	4
CyanItem	EQU	5
BlueItem	EQU	6
BlackItem	EQU	7

RandomMenu	EQU	132		; Randomness selection menu
ColorItem	EQU	1
PolyItem	EQU	2
DirectionItem	EQU	3

SoundMenu	EQU	133		; Sound mode selection
SoundOffItem	EQU	1
SoundOnItem	EQU	2


;*************************************************
; ----------------  RECORD TYPES  ----------------
;*************************************************

; ------------- BITMAP TYPE -------------

BitMap		RECORD	0
baseAddr	DS.L	1
rowBytes	DS.W	1
bounds		DS.L	Rect
		ENDR

; ------------- THE QUICKDRAW WORLD -------------

MyQDGlobals	RECORD	0,DECREMENT
GrafPort 	DS.L	1
White		DS.B	8
Black		DS.B	8
Gray		DS.B	8
LtGray		DS.B	8
DkGray		DS.B	8
Arrow		DS.B	cursRec
ScreenBits	DS.B	BitMap
RandSeed	DS.L	1
 		ORG 	-GrafSize
 		ENDR

; -------------  GLOBAL DATA -------------

AppGlobals	RECORD	0		; this is our global data storage
Color		DS.W	1		; color value of the ball
OldColor	DS.W	1		; previous color
HasWNEvent	DS.W	1		; boolean for WaitNextEvent trap, see ForceEnvirons
InBackground	DS.W	1		; boolean for if in background, see OSEvent
WindowSize	DS.L	1		; store size of Window from resource
		ORG	WindowSize
Height		DS.W	1
Width		DS.W	1
Mac		DS	SysEnvRec	; the system environment record, see ForceEnvirons
SoundMode	DS.B	1		; flag for the sound mode
		ENDR


; ------------- DEFINITION OF OUR POLYGON -------------
;
; This must be equivalent to the Polygon definition in MyPolygon.c
;
MAX_POINTS EQU	40			; /* Max number of points in polygon */

MyPoly		RECORD	0
PolyStart	EQU *
randColors	ds.b 1			; /* Boolean for random Colors */
randPoly	ds.b 1			; /* Boolean for random polygons */
randDirection	ds.b 1			; /* Boolean for random direction */
		ds.b 1			; /* unused, to align on long */
phase		ds.w 1			; /* Polygon phase */
Xpos		ds.l 1			; /* X coordinate */
Ypos		ds.l 1			; /* Y coordinate */
velX		ds.l 1			; /* X velocity */
velY		ds.l 1			; /* Y velocity */
polysize	ds.w 1			;
polyOmega	ds.w 1			; /* Rotation speed */
spokeLength	ds.w 1			; /* Spoke length */
spokeOmega	ds.w 1			; /* Spoke rotation speed */
color		ds.w 1			;
numPoints	ds.w 1			; /* Number of points in poly */
pt		ds.l MAX_POINTS		; /* List of points */
		ENDR

