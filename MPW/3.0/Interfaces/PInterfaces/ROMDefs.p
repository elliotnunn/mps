{
Created: Tuesday, August 2, 1988 at 10:09 AM
    ROMDefs.p
    Pascal Interface to the Macintosh Libraries

    Copyright Apple Computer, Inc.  1986-1988
    All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
    UNIT ROMDefs;
    INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingROMDefs}
{$SETC UsingROMDefs := 1}


CONST
appleFormat = 1;                        {Format of Declaration Data (IEEE will assign real value)}
romRevision = 1;                        {Revision of Declaration Data Format}
testPattern = 1519594439;               {FHeader long word test pattern}
sCodeRev = 2;                           {Revision of code (For sExec)}
sCPU68000 = 1;                          {CPU type = 68000}
sCPU68020 = 2;                          {CPU type = 68020}
sMacOS68000 = 1;                        {Mac OS, CPU type = 68000}
board = 0;                              {Board sResource - Required on all boards}
displayVideoAppleTFB = 16843009;        {Video with Apple parameters for TFB card.}
displayVideoAppleGM = 16843010;         {Video with Apple parameters for GM card.}
networkEtherNetApple3Com = 33620225;    {Ethernet with apple parameters for 3-Comm card.}
testSimpleAppleAny = -2147417856;       {A simple test sResource.}
endOfList = 255;                        {End of list}
defaultTO = 100;                        {100 retries.}
sRsrcType = 1;                          {Type of sResource}
sRsrcName = 2;                          {Name of sResource}
sRsrcIcon = 3;                          {Icon}
sRsrcDrvrDir = 4;                       {Driver directory}
sRsrcLoadDir = 5;                       {Load directory}
sRsrcBootRec = 6;                       {sBoot record}
sRsrcFlags = 7;                         {sResource Flags}
sMacOS68020 = 2;                        {Mac OS, CPU type = 68020}
sRsrcHWDevId = 8;                       {Hardware Device Id}
minorBaseOS = 10;                       {Offset to base of sResource in minor space.}
minorLength = 11;
majorBaseOS = 12;                       {Offset to base of sResource in Major space.}
majorLength = 13;
sDRVRDir = 16;                          {sDriver directory}
drSwApple = 1;
drHwTFB = 1;
drHw3Com = 1;
drHwBSC = 3;
catBoard = 1;
catTest = 2;
catDisplay = 3;
catNetwork = 4;
boardId = 32;                           {Board Id}
pRAMInitData = 33;                      {sPRAM init data}
primaryInit = 34;                       {Primary init record}
timeOutConst = 35;                      {Time out constant}
vendorInfo = 36;                        {Vendor information List. See Vendor List, below}
boardFlags = 37;                        {Board Flags}
vendorId = 1;                           {Vendor Id}
serialNum = 2;                          {Serial number}
revLevel = 3;                           {Revision level}
partNum = 4;                            {Part number}
date = 5;                               {Last revision date of the card}
typeBoard = 0;
typeApple = 1;
typeVideo = 1;
typeEtherNet = 1;
testByte = 32;                          {Test byte.}
testWord = 33;                          {0021}
testLong = 34;                          {Test Long.}
testString = 35;                        {Test String.}


{$ENDC}    { UsingROMDefs }

{$IFC NOT UsingIncludes}
    END.
{$ENDC}

