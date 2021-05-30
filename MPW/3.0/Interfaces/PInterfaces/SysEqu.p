{
Created: Tuesday, October 25, 1988 at 12:14 PM
    SysEqu.p
    Pascal Interface to the Macintosh Libraries

    Copyright Apple Computer, Inc.  1988 
    All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
    UNIT SysEqu;
    INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingSysEqu}
{$SETC UsingSysEqu := 1}


CONST
PCDeskPat = $20B;       { desktop pat, top bit only! others are in use}
HiKeyLast = $216;       { Same as KbdVars}
KbdLast = $218;         { Same as KbdVars+2}
ExpandMem = $2B6;       { pointer to expanded memory block}
SCSIBase = $0C00;       { (long) base address for SCSI chip read}
SCSIDMA = $0C04;        { (long) base address for SCSI DMA}
SCSIHsk = $0C08;        { (long) base address for SCSI handshake}
SCSIGlobals = $0C0C;    { (long) ptr for SCSI mgr locals}
RGBBlack = $0C10;       { (6 bytes) the black field for color}
RGBWhite = $0C16;       { (6 bytes) the white field for color}
RowBits = $0C20;        { (word) screen horizontal pixels}
ColLines = $0C22;       { (word) screen vertical pixels}
ScreenBytes = $0C24;    { (long) total screen bytes}
NMIFlag = $0C2C;        { (byte) flag for NMI debounce}
VidType = $0C2D;        { (byte) video board type ID}
VidMode = $0C2E;        { (byte) video mode (4=4bit color)}
SCSIPoll = $0C2F;       { (byte) poll for device zero only once.}
SEVarBase = $0C30;
MMUFlags = $0CB0;       { (byte) cleared to zero (reserved for future use)}
MMUType = $0CB1;        { (byte) kind of MMU present}
MMU32bit = $0CB2;       { (byte) boolean reflecting current machine MMU mode}
MMUFluff = $0CB3;       { (byte) fluff byte forced by reducing MMUMode to MMU32bit.}
MMUTbl = $0CB4;         { (long) pointer to MMU Mapping table}
MMUTblSize = $0CB8;     { (long) size of the MMU mapping table}
SInfoPtr = $0CBC;       { (long) pointer to Slot manager information}
ASCBase = $0CC0;        { (long) pointer to Sound Chip}
SMGlobals = $0CC4;      { (long) pointer to Sound Manager Globals}
TheGDevice = $0CC8;     { (long) the current graphics device}
CQDGlobals = $0CCC;     { (long) quickDraw global extensions}
ADBBase = $0CF8;        { (long) pointer to Front Desk Buss Variables}
WarmStart = $0CFC;      { (long) flag to indicate it is a warm start}
TimeDBRA = $0D00;       { (word) number of iterations of DBRA per millisecond}
TimeSCCDB = $0D02;      { (word) number of iter's of SCC access & DBRA.}
SlotQDT = $0D04;        { ptr to slot queue table}
SlotPrTbl = $0D08;      { ptr to slot priority table}
SlotVBLQ = $0D0C;       { ptr to slot VBL queue table}
ScrnVBLPtr = $0D10;     { save for ptr to main screen VBL queue}
SlotTICKS = $0D14;      { ptr to slot tickcount table}
TableSeed = $0D20;      { (long) seed value for color table ID's}
SRsrcTblPtr = $0D24;    { (long) pointer to slot resource table.}
JVBLTask = $0D28;       { vector to slot VBL task interrupt handler}
WMgrCPort = $0D2C;      { window manager color port }
VertRRate = $0D30;      { (word) Vertical refresh rate for start manager. }
ChunkyDepth = $0D60;    { depth of the pixels}
CrsrPtr = $0D62;        { pointer to cursor save area}
PortList = $0D66;       { list of grafports}
MickeyBytes = $0D6A;    { long pointer to cursor stuff}
QDErrLM = $0D6E;        {QDErr has name conflict w/ type. QuickDraw error code [word]}
VIA2DT = $0D70;         { 32 bytes for VIA2 dispatch table for NuMac}
SInitFlags = $0D90;     { StartInit.a flags [word]}
DTQueue = $0D92;        { (10 bytes) deferred task queue header}
DTQFlags = $0D92;       { flag word for DTQueue}
DTskQHdr = $0D94;       { ptr to head of queue}
DTskQTail = $0D98;      { ptr to tail of queue}
JDTInstall = $0D9C;     { (long) ptr to deferred task install routine}
HiliteRGB = $0DA0;      { 6 bytes: rgb of hilite color}
TimeSCSIDB = $0DA6;     { (word) number of iter's of SCSI access & DBRA}
DSCtrAdj = $0DA8;       { (long) Center adjust for DS rect.}
IconTLAddr = $0DAC;     { (long) pointer to where start icons are to be put.}
VideoInfoOK = $0DB0;    { (long) Signals to CritErr that the Video card is ok}
EndSRTPtr = $0DB4;      { (long) Pointer to the end of the Slot Resource Table (Not the SRT buffer).}
SDMJmpTblPtr = $0DB8;   { (long) Pointer to the SDM jump table}
JSwapMMU = $0DBC;       { (long) jump vector to SwapMMU routine}
SdmBusErr = $0DC0;      { (long) Pointer to the SDM busErr handler}
LastTxGDevice = $0DC4;  { (long) copy of TheGDevice set up for fast text measure}
NewCrsrJTbl = $88C;     { location of new crsr jump vectors}
JAllocCrsr = $88C;      { (long) vector to routine that allocates cursor}
JSetCCrsr = $890;       { (long) vector to routine that sets color cursor}
JOpcodeProc = $894;     { (long) vector to process new picture opcodes}
CrsrBase = $898;        { (long) scrnBase for cursor}
CrsrDevice = $89C;      { (long) current cursor device}
SrcDevice = $8A0;       { (LONG) Src device for Stretchbits}
MainDevice = $8A4;      { (long) the main screen device}
DeviceList = $8A8;      { (long) list of display devices}
CrsrRow = $8AC;         { (word) rowbytes for current cursor screen}
QDColors = $8B0;        { (long) handle to default colors}
HiliteMode = $938;      { used for color highlighting}
BusErrVct = $08;        { bus error vector}
RestProc = $A8C;        { Resume procedure f InitDialogs [pointer]}
ROM85 = $28E;           { (word) actually high bit - 0 for ROM vers $75 (sic) and later}
ROMMapHndl = $B06;      { (long) handle of ROM resource map}
ScrVRes = $102;         { screen vertical dots/inch [word]}
ScrHRes = $104;         { screen horizontal dots/inch [word]}
ScrnBase = $824;        { Screen Base [pointer]}
ScreenRow = $106;       { rowBytes of screen [word]}
MBTicks = $16E;         { tick count @ last mouse button [long]}
JKybdTask = $21A;       { keyboard VBL task hook [pointer]}
KeyLast = $184;         { ASCII for last valid keycode [word]}
KeyTime = $186;         { tickcount when KEYLAST was rec'd [long]}
KeyRepTime = $18A;      { tickcount when key was last repeated [long]}
SPConfig = $1FB;        { config bits: 4-7 A, 0-3 B (see use type below)}
SPPortA = $1FC;         { SCC port A configuration [word]}
SPPortB = $1FE;         { SCC port B configuration [word]}
SCCRd = $1D8;           { SCC base read address [pointer]}
SCCWr = $1DC;           { SCC base write address [pointer]}
DoubleTime = $2F0;      { double click ticks [long]}
CaretTime = $2F4;       { caret blink ticks [long]}
KeyThresh = $18E;       { threshold for key repeat [word]}
KeyRepThresh = $190;    { key repeat speed [word]}
SdVolume = $260;        { Global volume(sound) control [byte]}
Ticks = $16A;           { Tick count, time since boot [unsigned long]}
TimeLM = $20C;          {Time has name conflict w/ type. Clock time (extrapolated) [long]}
MonkeyLives = $100;     { monkey lives if >= 0 [word]}
SEvtEnb = $15C;         { enable SysEvent calls from GNE [byte]}
JournalFlag = $8DE;     { journaling state [word]}
JournalRef = $8E8;      { Journalling driver's refnum [word]}
BufPtr = $10C;          { top of application memory [pointer]}
StkLowPt = $110;        { Lowest stack as measured in VBL task [pointer]}
TheZone = $118;         { current heap zone [pointer]}
ApplLimit = $130;       { application limit [pointer]}
SysZone = $2A6;         { system heap zone [pointer]}
ApplZone = $2AA;        { application heap zone [pointer]}
HeapEnd = $114;         { end of heap [pointer]}
HiHeapMark = $BAE;      { (long) highest address used by a zone below sp<01Nov85 JTC>}
MemErr = $220;          { last memory manager error [word]}
UTableBase = $11C;      { unit I/O table [pointer]}
UnitNtryCnt = $1D2;     { count of entries in unit table [word]}
JFetch = $8F4;          { fetch a byte routine for drivers [pointer]}
JStash = $8F8;          { stash a byte routine for drivers [pointer]}
JIODone = $8FC;         { IODone entry location [pointer]}
DrvQHdr = $308;         { queue header of drives in system [10 bytes]}
BootDrive = $210;       { drive number of boot drive [word]}
EjectNotify = $338;     { eject notify procedure [pointer]}
IAZNotify = $33C;       { world swaps notify procedure [pointer]}
SFSaveDisk = $214;      { last vRefNum seen by standard file [word]}
CurDirStore = $398;     { save dir across calls to Standard File [long]}
OneOne = $A02;          { constant $00010001 [long]}
MinusOne = $A06;        { constant $FFFFFFFF [long]}
Lo3Bytes = $31A;        { constant $00FFFFFF [long]}
ROMBase = $2AE;         { ROM base address [pointer]}
RAMBase = $2B2;         { RAM base address [pointer]}
SysVersion = $15A;      { version # of RAM-based system [word]}
RndSeed = $156;         { random seed/number [long]}
Scratch20 = $1E4;       { scratch [20 bytes]}
Scratch8 = $9FA;        { scratch [8 bytes]}
ScrapSize = $960;       { scrap length [long]}
ScrapHandle = $964;     { memory scrap [handle]}
ScrapCount = $968;      { validation byte [word]}
ScrapState = $96A;      { scrap state [word]}
ScrapName = $96C;       { pointer to scrap name [pointer]}
IntlSpec = $BA0;        { (long) - ptr to extra Intl data }
SwitcherTPtr = $286;    { Switcher's switch table }
CPUFlag = $12F;         { $00=68000, $01=68010, $02=68020 (old ROM inits to $00)}
VIA = $1D4;             { VIA base address [pointer]}
IWM = $1E0;             { IWM base address [pointer]}
Lvl1DT = $192;          { Interrupt level 1 dispatch table [32 bytes]}
Lvl2DT = $1B2;          { Interrupt level 2 dispatch table [32 bytes]}
ExtStsDT = $2BE;        { SCC ext/sts secondary dispatch table [16 bytes]}
SPValid = $1F8;         { validation field ($A7) [byte]}
SPATalkA = $1F9;        { AppleTalk node number hint for port A}
SPATalkB = $1FA;        { AppleTalk node number hint for port B}
SPAlarm = $200;         { alarm time [long]}
SPFont = $204;          { default application font number minus 1 [word]}
SPKbd = $206;           { kbd repeat thresh in 4/60ths [2 4-bit]}
SPPrint = $207;         { print stuff [byte]}
SPVolCtl = $208;        { volume control [byte]}
SPClikCaret = $209;     { double click/caret time in 4/60ths[2 4-bit]}
SPMisc1 = $20A;         { miscellaneous [1 byte]}
SPMisc2 = $20B;         { miscellaneous [1 byte]}
GetParam = $1E4;        { system parameter scratch [20 bytes]}
SysParam = $1F8;        { system parameter memory [20 bytes]}
CrsrThresh = $8EC;      { delta threshold for mouse scaling [word]}
JCrsrTask = $8EE;       { address of CrsrVBLTask [long]}
MTemp = $828;           { Low-level interrupt mouse location [long]}
RawMouse = $82C;        { un-jerked mouse coordinates [long]}
CrsrRect = $83C;        { Cursor hit rectangle [8 bytes]}
TheCrsr = $844;         { Cursor data, mask & hotspot [68 bytes]}
CrsrAddr = $888;        { Address of data under cursor [long]}
CrsrSave = $88C;        { data under the cursor [64 bytes]}
CrsrVis = $8CC;         { Cursor visible? [byte]}
CrsrBusy = $8CD;        { Cursor locked out? [byte]}
CrsrNew = $8CE;         { Cursor changed? [byte]}
CrsrState = $8D0;       { Cursor nesting level [word]}
CrsrObscure = $8D2;     { Cursor obscure semaphore [byte]}
KbdVars = $216;         { Keyboard manager variables [4 bytes]}
KbdType = $21E;         { keyboard model number [byte]}
MBState = $172;         { current mouse button state [byte]}
KeyMapLM = $174;        {KeyMap has name conflict w/ type. Bitmap of the keyboard [2 longs]}
KeypadMap = $17C;       { bitmap for numeric pad-18bits [long]}
Key1Trans = $29E;       { keyboard translator procedure [pointer]}
Key2Trans = $2A2;       { numeric keypad translator procedure [pointer]}
JGNEFilter = $29A;      { GetNextEvent filter proc [pointer]}
KeyMVars = $B04;        { (word) for ROM KEYM proc state}
Mouse = $830;           { processed mouse coordinate [long]}
CrsrPin = $834;         { cursor pinning rectangle [8 bytes]}
CrsrCouple = $8CF;      { cursor coupled to mouse? [byte]}
CrsrScale = $8D3;       { cursor scaled? [byte]}
MouseMask = $8D6;       { V-H mask for ANDing with mouse [long]}
MouseOffset = $8DA;     { V-H offset for adding after ANDing [long]}
AlarmState = $21F;      { Bit7=parity, Bit6=beeped, Bit0=enable [byte]}
VBLQueue = $160;        { VBL queue header [10 bytes]}
SysEvtMask = $144;      { system event mask [word]}
SysEvtBuf = $146;       { system event queue element buffer [pointer]}
EventQueue = $14A;      { event queue header [10 bytes]}
EvtBufCnt = $154;       { max number of events in SysEvtBuf - 1 [word]}
GZRootHnd = $328;       { root handle for GrowZone [handle]}
GZRootPtr = $32C;       { root pointer for GrowZone [pointer]}
GZMoveHnd = $330;       { moving handle for GrowZone [handle]}
MemTop = $108;          { top of memory [pointer]}
MmInOK = $12E;          { initial memory mgr checks ok? [byte]}
HpChk = $316;           { heap check RAM code [pointer]}
MaskBC = $31A;          { Memory Manager Byte Count Mask [long]}
MaskHandle = $31A;      { Memory Manager Handle Mask [long]}
MaskPtr = $31A;         { Memory Manager Pointer Mask [long]}
MinStack = $31E;        { min stack size used in InitApplZone [long]}
DefltStack = $322;      { default size of stack [long]}
MMDefFlags = $326;      { default zone flags [word]}
DSAlertTab = $2BA;      { system error alerts [pointer]}
DSAlertRect = $3F8;     { rectangle for disk-switch alert [8 bytes]}
DSDrawProc = $334;      { alternate syserror draw procedure [pointer]}
DSWndUpdate = $15D;     { GNE not to paintBehind DS AlertRect? [byte]}
WWExist = $8F2;         { window manager initialized? [byte]}
QDExist = $8F3;         { quickdraw is initialized [byte]}
ResumeProc = $A8C;      { Resume procedure from InitDialogs [pointer]}
DSErrCode = $AF0;       { last system error alert ID}
IntFlag = $15F;         { reduce interrupt disable time when bit 7 = 0}
SerialVars = $2D0;      { async driver variables [16 bytes]}
ABusVars = $2D8;        {;Pointer to AppleTalk local variables}
ABusDCE = $2DC;         {;Pointer to AppleTalk DCE}
PortAUse = $290;        { bit 7: 1 = not in use, 0 = in use}
PortBUse = $291;        { port B use, same format as PortAUse}
SCCASts = $2CE;         { SCC read reg 0 last ext/sts rupt - A [byte]}
SCCBSts = $2CF;         { SCC read reg 0 last ext/sts rupt - B [byte]}
DskErr = $142;          { disk routine result code [word]}
PWMBuf2 = $312;         { PWM buffer 1 (or 2 if sound) [pointer]}
SoundPtr = $262;        { 4VE sound definition table [pointer]}
SoundBase = $266;       { sound bitMap [pointer]}
SoundVBL = $26A;        { vertical retrace control element [16 bytes]}
SoundDCE = $27A;        { sound driver DCE [pointer]}
SoundActive = $27E;     { sound is active? [byte]}
SoundLevel = $27F;      { current level in buffer [byte]}
CurPitch = $280;        { current pitch value [word]}
DskVerify = $12C;       { used by 3.5 disk driver for read/verify [byte]}
TagData = $2FA;         { sector tag info for disk drivers [14 bytes]}
BufTgFNum = $2FC;       { file number [long]}
BufTgFFlg = $300;       { flags [word]}
BufTgFBkNum = $302;     { logical block number [word]}
BufTgDate = $304;       { time stamp [word]}
ScrDmpEnb = $2F8;       { screen dump enabled? [byte]}
ScrDmpType = $2F9;      { FF dumps screen, FE dumps front window [byte]}
ScrapVars = $960;       { scrap manager variables [32 bytes]}
ScrapInfo = $960;       { scrap length [long]}
ScrapEnd = $980;        { end of scrap vars}
ScrapTag = $970;        { scrap file name [STRING[15]]}
LaunchFlag = $902;      { from launch or chain [byte]}
SaveSegHandle = $930;   { seg 0 handle [handle]}
CurJTOffset = $934;     { current jump table offset [word]}
CurPageOption = $936;   { current page 2 configuration [word]}
LoaderPBlock = $93A;    { param block for ExitToShell [10 bytes]}
CurApRefNum = $900;     { refNum of application's resFile [word]}
CurrentA5 = $904;       { current value of A5 [pointer]}
CurStackBase = $908;    { current stack base [pointer]}
CurApName = $910;       { name of application [STRING[31]]}
LoadTrap = $12D;        { trap before launch? [byte]}
SegHiEnable = $BB2;     { (byte) 0 to disable MoveHHi in LoadSeg}

{ Window Manager Globals }

WindowList = $9D6;      {Z-ordered linked list of windows [pointer]}
PaintWhite = $9DC;      {erase newly drawn windows? [word]}
WMgrPort = $9DE;        {window manager's grafport [pointer]}
GrayRgn = $9EE;         {rounded gray desk region [handle]}
CurActivate = $A64;     {window slated for activate event [pointer]}
CurDeactive = $A68;     {window slated for deactivate event [pointer]}
DragHook = $9F6;        {user hook during dragging [pointer]}
DeskPattern = $A3C;     {desk pattern [8 bytes]}
DeskHook = $A6C;        {hook for painting the desk [pointer]}
GhostWindow = $A84;     {window hidden from FrontWindow [pointer]}

{ Text Edit Globals }

TEDoText = $A70;        {textEdit doText proc hook [pointer]}
TERecal = $A74;         {textEdit recalText proc hook [pointer]}
TEScrpLength = $AB0;    {textEdit Scrap Length [word]}
TEScrpHandle = $AB4;    {textEdit Scrap [handle]}
TEWdBreak = $AF6;       {default word break routine [pointer]}
WordRedraw = $BA5;      {(byte) - used by TextEdit RecalDraw}
TESysJust = $BAC;       {(word) system justification (intl. textEdit)}

{ Resource Manager Globals }

TopMapHndl = $A50;      {topmost map in list [handle]}
SysMapHndl = $A54;      {system map [handle]}
SysMap = $A58;          {reference number of system map [word]}
CurMap = $A5A;          {reference number of current map [word]}
ResReadOnly = $A5C;     {Read only flag [word]}
ResLoad = $A5E;         {Auto-load feature [word]}
ResErr = $A60;          {Resource error code [word]}
ResErrProc = $AF2;      {Resource error procedure [pointer]}
SysResName = $AD8;      {Name of system resource file [STRING[19]]}
RomMapInsert = $B9E;    {(byte) determines if we should link in map}
TmpResLoad = $B9F;      {second byte is temporary ResLoad value.}


{$ENDC}    { UsingSysEqu }

{$IFC NOT UsingIncludes}
    END.
{$ENDC}

