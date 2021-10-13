// #include <stdarg.h>

#include "TAP.h"

#define ioLink			0x00			// queue link in header [pointer]
#define ioType			0x04			// type for safety check [byte]
#define ioTrap			0x06			// the trap [word]
#define ioCmdAddr		0x08			// address to dispatch to [pointer]
#define ioCompletion	0x0c			// completion routine [pointer]
#define ioResult		0x10			// I/O result code [word]
#define ioNamePtr		0x12			// file name pointer [pointer]
#define ioVNPtr			0x12			// name buffer (or zero) [pointer]
#define ioDrvNum		0x16			// drive number [word]
#define ioVRefNum		0x16			// volume refnum [word]
#define ioRefNum		0x18			// file reference number [word]
#define ioVersNum		0x1a			// specified along with FileName [byte]
#define ioPermssn		0x1b			// permissions [byte]
#define ioFDirIndex		0x1c			// directory index of file [word]
#define ioMisc			0x1c			// see trap-specific uses below [pointer]
#define ioVolIndex		0x1c			// volume index number [word]
#define ioVCrDate		0x1e			// creation date & time [long]
#define ioFlAttrib		0x1e			// in-use bit=7, lock bit=0 [byte]
#define ioDrUsrWds		0x20			// Directory's user info bytes
#define ioBuffer		0x20			// data buffer [pointer]
#define ioFlUsrWds		0x20			// finder info [16 bytes]
#define ioVLsMod		0x22			// Last modification date
#define ioVLsBkUp		0x22			// last backup date & time [long]
#define ioReqCount		0x24			// requested new size [long]
#define ioVAtrb			0x26			// Volume attributes [word]
#define ioVNmFls		0x28			// # files in directory [word]
#define ioActCount		0x28			// actual byte count allocated [long]
#define ioVDirSt		0x2a			// start block of file dir [word]
#define ioPosMode		0x2c			// initial file positioning mode/eol char [word]
#define ioVBlLn			0x2c			// length of dir in blocks [word]
#define ioPosOffset		0x2e			// file position offset [long]
#define ioVNmAlBlks		0x2e			// num blks (of alloc size) this dev [word]
#define ioDrDirID		0x30			// Directory ID
#define ioVAlBlkSiz		0x30			// alloc blk byte size [long]
#define ioDirID			0x30			// directory ID
#define ioDrNmFls		0x34			// Number of files in a directory
#define ioVClpSiz		0x34			// bytes to try to allocate at a time [long]
#define ioFlStBlk		0x34			// start file block (0000 if none) [word]
#define ioFlLgLen		0x36			// logical length (EOF) [long]
#define ioAlBlSt		0x38			// starting block in block map [word]
#define ioVNxtFNum		0x3a			// next free file number [long]
#define ioFlPyLen		0x3a			// physical length in bytes [long]
#define ioVFrBlk		0x3e			// # free alloc blks for this vol [word]
#define ioFlRStBlk		0x3e			// resource fork's start file block [word]
#define ioVSigWord		0x40			// Volume signature
#define ioFlRLgLen		0x40			// resource fork's logical length (EOF) [long]
#define ioVDrvInfo		0x42			// Drive number (0 if volume is offline)
#define ioVDRefNum		0x44			// Driver refNum
#define ioFlRPyLen		0x44			// resource fork's physical length [long]
#define ioVFSID			0x46			// ID of file system handling this volume
#define ioDrCrDat		0x48			// Directory creation date
#define ioVBkup			0x48			// Last backup date (0 if never backed up)
#define ioFlCrDat		0x48			// creation date & time [long]
#define ioDrMdDat		0x4c			// Directory modification date
#define ioVSeqNum		0x4c			// Sequence number of this volume in volume set
#define ioFlMdDat		0x4c			// last modification date & time [long]
#define ioVWrCnt		0x4e			// Volume write count
#define ioDrBkDat		0x50			// Directory backup date
#define ioFlBkDat		0x50			// File's last backup date
#define ioVFilCnt		0x52			// Total number of files on volume
#define ioDrFndrInfo	0x54			// Directory finder info bytes
#define ioFlxFndrInfo	0x54			// File's additional finder info bytes
#define ioVDirCnt		0x56			// Total number of directories on the volume
#define ioVFndrInfo		0x5a			// Finder information for volume
#define ioDrParID		0x64			// Directory's parent directory ID
#define ioFlParID		0x64			// File's parent directory ID
#define ioFlClpSiz		0x68			// File's clump size, in bytes

#pragma parameter __D0 Open(__A0)
short Open(char *pb) = {0xa000};
#pragma parameter __D0 HOpen(__A0)
short HOpen(char *pb) = {0xa200};

#pragma parameter __D0 Close(__A0)
short Close(char *pb) = {0xa001};

#pragma parameter __D0 Read(__A0)
short Read(char *pb) = {0xa002};

#pragma parameter __D0 Write(__A0)
short Write(char *pb) = {0xa003};

#pragma parameter __D0 GetVInfo(__A0)
short GetVInfo(char *pb) = {0xa007};
#pragma parameter __D0 HGetVInfo(__A0)
short HGetVInfo(char *pb) = {0xa207};

#pragma parameter __D0 Create(__A0)
short Create(char *pb) = {0xa008};
#pragma parameter __D0 HCreate(__A0)
short HCreate(char *pb) = {0xa208};

#pragma parameter __D0 Delete(__A0)
short Delete(char *pb) = {0xa009};
#pragma parameter __D0 HDelete(__A0)
short HDelete(char *pb) = {0xa209};

#pragma parameter __D0 OpenRF(__A0)
short OpenRF(char *pb) = {0xa00a};
#pragma parameter __D0 HOpenRF(__A0)
short HOpenRF(char *pb) = {0xa20a};

#pragma parameter __D0 GetFInfo(__A0)
short GetFInfo(char *pb) = {0xa00c};
#pragma parameter __D0 HGetFInfo(__A0)
short HGetFInfo(char *pb) = {0xa20c};

#pragma parameter __D0 SetFInfo(__A0)
short SetFInfo(char *pb) = {0xa00d};
#pragma parameter __D0 HSetFInfo(__A0)
short HSetFInfo(char *pb) = {0xa20d};

#pragma parameter __D0 GetEOF(__A0)
short GetEOF(char *pb) = {0xa011};
#pragma parameter __D0 HGetEOF(__A0)
short HGetEOF(char *pb) = {0xa211};

#pragma parameter __D0 SetEOF(__A0)
short SetEOF(char *pb) = {0xa012};
#pragma parameter __D0 HSetEOF(__A0)
short HSetEOF(char *pb) = {0xa212};

#pragma parameter __D0 FlushVol(__A0)
short FlushVol(char *pb) = {0xa013};

#pragma parameter __D0 GetVol(__A0)
short GetVol(char *pb) = {0xa014};
#pragma parameter __D0 HGetVol(__A0)
short HGetVol(char *pb) = {0xa214};

#pragma parameter __D0 SetVol(__A0)
short SetVol(char *pb) = {0xa015};
#pragma parameter __D0 HSetVol(__A0)
short HSetVol(char *pb) = {0xa215};

#pragma parameter __D0 GetFPos(__A0)
short GetFPos(char *pb) = {0xa018};
#pragma parameter __D0 HGetFPos(__A0)
short HGetFPos(char *pb) = {0xa218};

#pragma parameter __D0 SetFPos(__A0)
short SetFPos(char *pb) = {0xa044};
#pragma parameter __D0 HSetFPos(__A0)
short HSetFPos(char *pb) = {0xa244};

#pragma parameter __D0 OpenWD(__A0)
short OpenWD(char *pb) = {0x7001, 0xa260};

#pragma parameter __D0 CloseWD(__A0)
short CloseWD(char *pb) = {0x7002, 0xa260};

#pragma parameter __D0 CatMove(__A0)
short CatMove(char *pb) = {0x7005, 0xa260};

#pragma parameter __D0 DirCreate(__A0)
short DirCreate(char *pb) = {0x7006, 0xa260};

#pragma parameter __D0 GetWDInfo(__A0)
short GetWDInfo(char *pb) = {0x7007, 0xa260};

#pragma parameter __D0 GetFCBInfo(__A0)
short GetFCBInfo(char *pb) = {0x7008, 0xa260};

#pragma parameter __D0 GetCatInfo(__A0)
short GetCatInfo(char *pb) = {0x7009, 0xa260};

#pragma parameter __D0 SetCatInfo(__A0)
short SetCatInfo(char *pb) = {0x700a, 0xa260};

#pragma parameter __D0 SetVolInfo(__A0)
short SetVolInfo(char *pb) = {0x700b, 0xa260};

#pragma parameter __D0 LockRng(__A0)
short LockRng(char *pb) = {0x7010, 0xa260};

#pragma parameter __D0 UnlockRng(__A0)
short UnlockRng(char *pb) = {0x7011, 0xa260};

#pragma parameter __D0 ExchangeFiles(__A0)
short ExchangeFiles(char *pb) = {0x7016, 0xa260};

#pragma parameter __D0 OpenDF(__A0)
short OpenDF(char *pb) = {0x701a, 0xa260};

#pragma parameter __D0 MakeFSSpec(__A0)
short MakeFSSpec(char *pb) = {0x701b, 0xa260};

char pb[128], oldpb[128];

void pbClear() {
	int i;
	for (i = 0; i < sizeof pb; i++) {
		oldpb[i] = pb[i] = 0xff;
	}
}

void pbSetB(int ofs, char val) {
	*(oldpb + ofs) = *(pb + ofs) = val;
}

void pbSetW(int ofs, short val) {
	*(short *)(oldpb + ofs) = *(short *)(pb + ofs) = val;
}

void pbSetL(int ofs, long val) {
	*(long *)(oldpb + ofs) = *(long *)(pb + ofs) = val;
}

void pbSetPtr(int ofs, void *val) {
	*(void **)(oldpb + ofs) = *(void **)(pb + ofs) = val;
}

void pbCanDifferB(int ofs) {
	*(oldpb + ofs) = *(pb + ofs);
}

void pbCanDifferW(int ofs) {
	*(short *)(oldpb + ofs) = *(short *)(pb + ofs);
}

void pbCanDifferL(int ofs) {
	*(long *)(oldpb + ofs) = *(long *)(pb + ofs);
}

void pbMustDifferB(int ofs) {
	if (*(oldpb + ofs) == *(pb + ofs)) {
		LineAppend("\p# bad: PB byte unchanged at $");
		LineAppendX((unsigned char)ofs);
		LineFlush();
		TestFail();
	}

	*(oldpb + ofs) = *(pb + ofs);
}

void pbMustDifferW(int ofs) {
	if (*(short *)(oldpb + ofs) == *(short *)(pb + ofs)) {
		LineAppend("\p# bad: PB word unchanged at $");
		LineAppendX((unsigned char)ofs);
		LineFlush();
		TestFail();
	}

	*(short *)(oldpb + ofs) = *(short *)(pb + ofs);
}

void pbMustDifferL(int ofs) {
	if (*(long *)(oldpb + ofs) == *(long *)(pb + ofs)) {
		LineAppend("\p# bad: PB long unchanged at $");
		LineAppendX((unsigned char)ofs);
		LineFlush();
		TestFail();
	}

	*(long *)(oldpb + ofs) = *(long *)(pb + ofs);
}

void pbCheck() {
	int i;
	for (i = 0x12; i < sizeof pb; i += 2) {
		if (*(short *)(pb + i) != *(short *)(oldpb + i)) {
			LineAppend("\p# bad: PB word changed at $");
			LineAppendX((unsigned char)i);
			LineFlush();
			TestFail();
		}
	}
}

void main(void) {
	short result;

	{
		TestOpen("\pOpen NonExistentFile");
		pbClear();
		pbSetPtr(ioNamePtr, "\pNonExistentFile");
		pbSetW(ioVRefNum, 0);
		pbSetB(ioVersNum, 0);
		pbSetB(ioPermssn, 1); // readonly
		pbSetL(ioMisc, 0);

		if (Open(pb) != -43) {TestFailMsg("\punexpected return value");}

		pbCheck(pb);
		TestClose();
	}

	{
		TestOpen("\pOpenRF NonExistentFile");
		pbClear();
		pbSetPtr(ioNamePtr, "\pNonExistentFile");
		pbSetW(ioVRefNum, 0);
		pbSetB(ioVersNum, 0);
		pbSetB(ioPermssn, 1); // readonly
		pbSetL(ioMisc, 0);

		if (OpenRF(pb) != -43) {TestFailMsg("\punexpected return value");}

		pbCheck(pb);
		TestClose();
	}

	{
		TestOpen("\pHOpen NonExistentFile");
		pbClear();
		pbSetPtr(ioNamePtr, "\pNonExistentFile");
		pbSetW(ioVRefNum, 0);
		pbSetL(ioDirID, 0);
		pbSetB(ioVersNum, 0);
		pbSetB(ioPermssn, 1); // readonly
		pbSetL(ioMisc, 0);

		if (HOpen(pb) != -43) {TestFailMsg("\punexpected return value");}

		pbCheck(pb);
		TestClose();
	}

	{
		TestOpen("\pHOpenRF NonExistentFile");
		pbClear();
		pbSetPtr(ioNamePtr, "\pNonExistentFile");
		pbSetW(ioVRefNum, 0);
		pbSetL(ioDirID, 0);
		pbSetB(ioVersNum, 0);
		pbSetB(ioPermssn, 1); // readonly
		pbSetL(ioMisc, 0);

		if (HOpenRF(pb) != -43) {TestFailMsg("\punexpected return value");}

		pbCheck(pb);
		TestClose();
	}
}
