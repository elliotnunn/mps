// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

/*
Test Standard Apple Numeric Environment

- Compares the system SANE with a Mac Plus ROM named "sane"
- Prints TAP (Test Anything Protocol)
- Builds under MPW 3.5
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <Memory.h>
#include <Patches.h>

const char argsPerOpcode[] = {2,1,2,1,2,1,2,1,2,2,2,3,2,1,2,1,2,2,1,2,1,1,1,1,2,1,1,1,2};

struct regs {
	long d[8];
	long a[8];
	short ccr;
};

struct haltRec {
	short didHalt;
	long dst, src, src2;
	short exceptions;
	short ccr;
	long d0;
	short otherOpcodeHalts;
	short otherOpcodeHaltOp;
	short otherOpcodeHaltState;
};

long opcodeSignature(short opcode);
void *saneFromFile(char *path);
void *slurp(char *path, long *returnSize);
void test(char *baseName, int opcode, ...);
void testFOD2B(char *baseName, int sign, int exponent, char *string);
void printCompare(const char *name, int width, void *field, int delta);
pascal void halt(char *miscrec, long src2, long src, long dst, short opcode);
void thunk(void *sanePtr, struct regs *statePtr);

#pragma parameter __D0 getA5()
long getA5(void) = {0x200d}; // move.l a5,d0

short *const FPState = (void *)0xa4a;
long *const HaltVector = (void *)0xa4c;
void *sanes[2];
struct haltRec *curHaltRec;
short curHaltOpcode;
int forcePrint;
int tempNoMode;

void tapOpen(char *name);
void tapFail(void);
void tapClose(void);
void tapPlan(void);
long tapCount;
char *tapName;
int tapOK;

const unsigned char *junkData = "\p\xba\xad\xc0\xde\xba\xad\xc0\xde\xba\xad\xc0\xde";

const unsigned char *pos0 = "\p\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00";
const unsigned char *neg0 = "\p\x80\x00\x00\x00\x00\x00\x00\x00\x00\x00";
const unsigned char *pos1 = "\p\x3f\xff\x80\x00\x00\x00\x00\x00\x00\x00";
const unsigned char *neg1 = "\p\xbf\xff\x80\x00\x00\x00\x00\x00\x00\x00";
const unsigned char *posInf = "\p\x7f\xff\x00\x00\x00\x00\x00\x00\x00\x00";
const unsigned char *negInf = "\p\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00";

const unsigned char *xSample[] = {
	"\p\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00", // +0.0
	"\p\x80\x00\x00\x00\x00\x00\x00\x00\x00\x00", // -0.0
	"\p\x7f\xff\x00\x00\x00\x00\x00\x00\x00\x00", // +inf
	"\p\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00", // -inf
	"\p\x7f\xff\x00\x01\x00\x00\x00\x00\x00\x00", // +NaN
	"\p\xff\xff\x00\x01\x00\x00\x00\x00\x00\x00", // -NaN, same
	"\p\x7f\xff\x00\x02\x00\x00\x00\x00\x00\x00", // +NaN, different
	"\p\x3f\xff\x80\x00\x00\x00\x00\x00\x00\x00", // +1.0
	"\p\x3f\xff\x80\x00\x00\x00\x00\x00\x00\x01", // +1+eps
	"\p\x00\x00\x80\x00\x00\x00\x00\x00\x00\x01", // +eps
	"\p\x40\x00\x40\x00\x00\x00\x00\x00\x00\x00", // +1.0 denormed
	"\p\xbf\xff\x80\x00\x00\x00\x00\x00\x00\x00", // -1.0
	"\p\x3f\xfe\x80\x00\x00\x00\x00\x00\x00\x00", // +0.5
	NULL
};

const unsigned char *dSample[] = {
	"\p\x00\x00\x00\x00\x00\x00\x00\x00", // +0.0
	"\p\x80\x00\x00\x00\x00\x00\x00\x00", // -0.0
	"\p\x7f\xf0\x00\x00\x00\x00\x00\x00", // +inf
	"\p\xff\xf0\x00\x00\x00\x00\x00\x00", // -inf
	"\p\x3f\xf0\x00\x00\x00\x00\x00\x00", // +1.0
	"\p\xbf\xf0\x00\x00\x00\x00\x00\x00", // -1.0
};

const unsigned char *sSample[] = {
	"\p\x00\x00\x00\x00", // +0.0
	"\p\x80\x00\x00\x00", // -0.0
	"\p\x7f\x80\x00\x00", // +inf
	"\p\xff\x80\x00\x00", // -inf
	"\p\x7f\xf0\x00\x00", // NaN
	"\p\x3f\x80\x00\x00", // +1.0
	"\p\xbf\x80\x00\x00", // -1.0
	NULL
};

const unsigned char *fnextxSample[] = { // remember, all will be tried with both signs
	"\p\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00", // zero
	"\p\x3f\xff\x80\x00\x00\x00\x00\x00\x00\x00", // one
	"\p\x7f\xfe\xff\xff\xff\xff\xff\xff\xff\xff", // largest finite

	"\p\x3f\xff\x00\x00\x00\x01\x00\x00\x00\x00", // buggy case
	"\p\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00", // buggy case
	"\p\x3f\xff\x80\x00\x00\x01\x00\x00\x00\x00", // buggy case
	"\p\x00\x00\x80\x00\x00\x01\x00\x00\x00\x00", // buggy case
	"\p\x3f\xff\x01\x00\x00\x01\x00\x00\x00\x00", // buggy case
	"\p\x00\x00\x01\x00\x00\x01\x00\x00\x00\x00", // buggy case
	"\p\x3f\xff\x81\x00\x00\x01\x00\x00\x00\x00", // buggy case
	"\p\x00\x00\x81\x00\x00\x01\x00\x00\x00\x00", // buggy case
	NULL
};

const unsigned char *fnextdSample[] = {
	"\p\x00\x00\x00\x00\x00\x00\x00\x00", // zero
	"\p\x7f\xf0\x00\x00\x00\x00\x00\x00", // inf
	"\p\x7f\xf8\x00\x00\x00\x00\x00\x00", // NaN
	"\p\x3f\xf0\x00\x00\x00\x00\x00\x00", // one
	"\p\x7f\xef\xff\xff\xff\xff\xff\xff", // large
	NULL
};

const unsigned char *fnextsSample[] = {
	"\p\x00\x00\x00\x00", // zero
	"\p\x7f\x80\x00\x00", // inf
	"\p\x7f\xf0\x00\x00", // NaN
	"\p\x3f\x80\x00\x00", // one
	"\p\x7f\x7f\xff\xff", // large
	NULL
};

int main(int argc, char* argv[]) {
	int i, j, k;

	(void)argc;
	sanes[0] = saneFromFile(argv[0]);
	sanes[1] = (void *)GetToolTrapAddress(0xa9eb);

	// ApplScratch = SANE base address (makes debugging easier)
	*(long *)0xa78 = (long)(sanes[0]);

	test("Replicate buggy coerce-to-single", 0x0000, "\p\x3f\x74\x80\x00\x00\x00\x00\x00\x00\x00", "\p\x3f\x32\x80\x00\x00\x00\x00\x00\x00\x00");

	test("FOSUB", 0x0002, pos1, neg1);

	for (i = 0; xSample[i] != NULL; i++) {
		for (j = 0; xSample[j] != NULL; j++) {
			test("FOADD", 0x0000, xSample[i], xSample[j]);
		}
	}

	for (i = 0; xSample[i] != NULL; i++) {
		for (j = 0; xSample[j] != NULL; j++) {
			test("FOMUL", 0x0004, xSample[i], xSample[j]);
		}
	}

	for (i = 0; xSample[i] != NULL; i++) {
		for (j = 0; xSample[j] != NULL; j++) {
			test("FODIV", 0x0006, xSample[i], xSample[j]);
		}
	}

	for (i = 0; xSample[i] != NULL; i++) {
		for (j = 0; xSample[j] != NULL; j++) {
			test("FOCMP", 0x0008, xSample[i], xSample[j]);
		}
	}

	for (i = 0; xSample[i] != NULL; i++) {
		for (j = 0; xSample[j] != NULL; j++) {
			test("FOCPX", 0x000a, xSample[i], xSample[j]);
		}
	}

	for (i = 0; xSample[i] != NULL; i++) {
		for (j = 0; xSample[j] != NULL; j++) {
			test("FOREM", 0x000c, xSample[i], xSample[j]);
		}
	}

	for (i = 0; dSample[i] != NULL; i++) {
		test("FOZ2X.FD2X", 0x080e, junkData, dSample[i]);
	}

	for (i = 0; sSample[i] != NULL; i++) {
		test("FOZ2X.FS2X", 0x100e, junkData, sSample[i]);
	}

	test("FOZ2X.FI2X", 0x200e, junkData, "\p\x80\x00");
	test("FOZ2X.FI2X", 0x200e, junkData, "\p\xff\xfe");
	test("FOZ2X.FI2X", 0x200e, junkData, "\p\xff\xff");
	test("FOZ2X.FI2X", 0x200e, junkData, "\p\x00\x00");
	test("FOZ2X.FI2X", 0x200e, junkData, "\p\x00\x01");

	test("FOZ2X.FL2X", 0x280e, junkData, "\p\x80\x00\x00\x00");
	test("FOZ2X.FL2X", 0x280e, junkData, "\p\xff\xff\xff\xfe");
	test("FOZ2X.FL2X", 0x280e, junkData, "\p\xff\xff\xff\xff");
	test("FOZ2X.FL2X", 0x280e, junkData, "\p\x00\x00\x00\x00");
	test("FOZ2X.FL2X", 0x280e, junkData, "\p\x00\x00\x00\x01");

	test("FOZ2X.FC2X", 0x300e, junkData, "\p\x00\x00\x00\x00\x00\x00\x00\x01");
	test("FOZ2X.FC2X", 0x300e, junkData, "\p\x80\x00\x00\x00\x00\x00\x00\x00");
	test("FOZ2X.FC2X", 0x300e, junkData, "\p\x80\x00\x00\x00\x00\x00\x00\x01");

	for (i = 0; xSample[i] != NULL; i++) {
		test("FOX2Z.FX2D", 0x0810, junkData, xSample[i]);
	}

	for (i = 0; xSample[i] != NULL; i++) {
		test("FOX2Z.FX2S", 0x1010, junkData, xSample[i]);
	}

	for (i = 0; xSample[i] != NULL; i++) {
		test("FOX2Z.FX2I", 0x2010, junkData, xSample[i]);
	}

	for (i = 0; xSample[i] != NULL; i++) {
		test("FOX2Z.FX2L", 0x2810, junkData, xSample[i]);
	}

	for (i = 0; xSample[i] != NULL; i++) {
		test("FOX2Z.FX2C", 0x3010, junkData, xSample[i]);
	}

	for (i = 0; i < 2; i++) {
		char name[] = "FORTI.FRINTX";
		short opcode;
		name[2] = name[7] = i ? 'R' : 'T';
		opcode = i ? 0x0014 : 0x0016;
		test(name, opcode, "\p\x7f\xff\x00\x00\x00\x00\x00\x00\x00\x00"); // +inf
		test(name, opcode, "\p\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00"); // -inf
		test(name, opcode, "\p\x7f\xfe\xff\xff\xff\xff\xff\xff\xff\xff"); // +huge
		test(name, opcode, "\p\xff\xfe\xff\xff\xff\xff\xff\xff\xff\xff"); // -huge
		test(name, opcode, "\p\x3f\xff\xc0\x00\x00\x00\x00\x00\x00\x00"); // +1.5
		test(name, opcode, "\p\xbf\xff\xc0\x00\x00\x00\x00\x00\x00\x00"); // -1.5
		test(name, opcode, "\p\x3f\xff\xa0\x00\x00\x00\x00\x00\x00\x00"); // +1.25
		test(name, opcode, "\p\xbf\xff\xa0\x00\x00\x00\x00\x00\x00\x00"); // -1.25
		test(name, opcode, "\p\x3f\xff\x80\x00\x00\x00\x00\x00\x00\x00"); // +1.0
		test(name, opcode, "\p\xbf\xff\x80\x00\x00\x00\x00\x00\x00\x00"); // -1.0
		test(name, opcode, "\p\x3f\xff\x60\x00\x00\x00\x00\x00\x00\x00"); // +0.75 denorm
		test(name, opcode, "\p\xbf\xff\x60\x00\x00\x00\x00\x00\x00\x00"); // -0.75 denorm
	}

	// The headers incorrectly use FSCALBX=FFINT+FOSCALB=0x2018,
	// despite the float argument being an extended.
	for (i = 0; i < 2; i++) {
		short opcode = i ? 0x0018 : 0x2018;
		test("FOSCALB", opcode, posInf, "\p\x7f\xff");
		test("FOSCALB", opcode, pos1, "\p\x7f\xff");
		test("FOSCALB", opcode, pos1, "\p\x7f\xff");
		test("FOSCALB", opcode, pos1, "\p\xff\xc0");
		test("FOSCALB", opcode, neg1, "\p\x80\x00");
	}

	test("FOLOGB.FLOGBX", 0x001a, pos0);
	test("FOLOGB.FLOGBX", 0x001a, neg0);
	test("FOLOGB.FLOGBX", 0x001a, posInf);
	test("FOLOGB.FLOGBX", 0x001a, negInf);
	test("FOLOGB.FLOGBX", 0x001a, neg1);
	test("FOLOGB.FLOGBX", 0x001a, pos1);
	test("FOLOGB.FLOGBX", 0x001a, "\p\x3f\xff\x40\x00\x00\x00\x00\x00\x00\x00"); // +0.5
	test("FOLOGB.FLOGBX", 0x001a, "\p\x3f\xff\x20\x00\x00\x00\x00\x00\x00\x00"); // +0.25

	test("FOCLASS misinterpret as inf", 0x001c, "\p\x00\x00", "\p\x7f\xff\x80\x00\x00\x00\x00\x00\x00\x00");
	test("FOCLASS correctly interpret as NaN", 0x001c, "\p\x00\x00", "\p\x7f\xff\xc0\x00\x00\x00\x00\x00\x00\x00");
	test("FOCLASS +zero", 0x001c, "\p\x00\x00", "\p\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00");
	test("FOCLASS -zero", 0x001c, "\p\x00\x00", "\p\x80\x00\x00\x00\x00\x00\x00\x00\x00\x00");
	test("FOCLASS +inf", 0x001c, "\p\x00\x00", "\p\x7f\xff\x00\x00\x00\x00\x00\x00\x00\x00");
	test("FOCLASS -inf", 0x001c, "\p\x00\x00", "\p\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00");
	test("FOCLASS +norm", 0x001c, "\p\x00\x00", "\p\x3f\xff\x80\x00\x00\x00\x00\x00\x00\x00");
	test("FOCLASS -norm", 0x001c, "\p\x00\x00", "\p\xbf\xff\x80\x00\x00\x00\x00\x00\x00\x00");
	test("FOCLASS +denorm", 0x001c, "\p\x00\x00", "\p\x3f\xff\x40\x00\x00\x00\x00\x00\x00\x00");
	test("FOCLASS -denorm", 0x001c, "\p\x00\x00", "\p\xbf\xff\x40\x00\x00\x00\x00\x00\x00\x00");
	test("FOCLASS +sNaN", 0x001c, "\p\x00\x00", "\p\x7f\xff\x00\x01\x00\x00\x00\x00\x00\x00");
	test("FOCLASS -sNaN", 0x001c, "\p\x00\x00", "\p\xff\xff\x00\x01\x00\x00\x00\x00\x00\x00");
	test("FOCLASS +qNaN", 0x001c, "\p\x00\x00", "\p\x7f\xff\x40\x01\x00\x00\x00\x00\x00\x00");
	test("FOCLASS -qNaN", 0x001c, "\p\x00\x00", "\p\xff\xff\x40\x01\x00\x00\x00\x00\x00\x00");

	test("FOSETENV", 0x0001, "\p\x12\x34");
	test("FOGETENV", 0x0003, junkData);
	test("FOSETHV", 0x0005, "\p\x9a\xbc\xde\xf0");
	test("FOGETHV", 0x0007, junkData);
	test("FOPROCENTRY", 0x0017, junkData);
	test("FOPROCEXIT", 0x0019, "\p\xff\xff");

	test("FOSETXCP", 0x0015, "\p\x00\x00");
	test("FOSETXCP", 0x0015, "\p\x00\x01");
	test("FOSETXCP", 0x0015, "\p\x00\x02");
	test("FOSETXCP", 0x0015, "\p\x00\x03");
	test("FOSETXCP", 0x0015, "\p\x00\x04");

	// These test the upper word of FPState, which we stuff precision bits into
	test("FOTESTXCP", 0x001b, "\p\x00\x00");
	test("FOTESTXCP", 0x001b, "\p\x00\x01");
	test("FOTESTXCP", 0x001b, "\p\x00\x02");
	test("FOTESTXCP", 0x001b, "\p\x00\x03");
	test("FOTESTXCP", 0x001b, "\p\x00\x04");
	test("FOTESTXCP", 0x001b, "\p\x00\x05");
	test("FOTESTXCP", 0x001b, "\p\x00\x06");
	test("FOTESTXCP", 0x001b, "\p\x00\x07");

	// Only touching the initial bit
	test("FONEG", 0x000d, "\p\x00");
	test("FONEG", 0x000d, "\p\x01");
	test("FONEG", 0x000d, "\p\x80");
	test("FONEG", 0x000d, "\p\x81");
	test("FOABS", 0x000f, "\p\x00");
	test("FOABS", 0x000f, "\p\x01");
	test("FOABS", 0x000f, "\p\x80");
	test("FOABS", 0x000f, "\p\x81");
	test("FOCPYSGN", 0x000f, "\p\x00", "\p\x00");
	test("FOCPYSGN", 0x000f, "\p\x00", "\p\xff");
	test("FOCPYSGN", 0x000f, "\p\xff", "\p\x00");
	test("FOCPYSGN", 0x000f, "\p\xff", "\p\xff");

	for (i = 0; xSample[i] != NULL; i++) {
		for (j = 0; xSample[j] != NULL; j++) {
			test("FONEXT", 0x0013, xSample[i], xSample[j]);
		}
	}

	for (j = 0; fnextxSample[j] != NULL; j++) { // thing being aimed
		for (k = 0; k < 2; k++) { // sign of thing being aimed
			for (i = 0; i < 2; i++) { // sign of infinite target
				char name[] = "FONEXT.FNEXTX +ve step";
				unsigned char target[] = "\p\x7f\xff\x00\x00\x00\x00\x00\x00\x00\x00"; // inf
				unsigned char sampleBuf[11];

				if (i) {
					name[14] = '-';
					target[1] |= 0x80; // make it negative inf
				}

				memcpy(sampleBuf, fnextxSample[j], sizeof(sampleBuf));
				if (k) {
					sampleBuf[1] |= 0x80;
				}

				tempNoMode = 1;
				test(name, 0x0013, target, sampleBuf);
			}
		}
	}

	for (j = 0; fnextdSample[j] != NULL; j++) { // thing being aimed
		for (k = 0; k < 2; k++) { // sign of thing being aimed
			for (i = 0; i < 2; i++) { // sign of infinite target
				char name[] = "FONEXT.FNEXTD +ve step";
				unsigned char target[] = "\p\x7f\xf0\x00\x00\x00\x00\x00\x00"; // inf
				unsigned char sampleBuf[9];

				if (i) {
					name[14] = '-';
					target[1] |= 0x80; // make it negative inf
				}

				memcpy(sampleBuf, fnextdSample[j], sizeof(sampleBuf));
				if (k) {
					sampleBuf[1] |= 0x80;
				}

				tempNoMode = 1;
				test(name, 0x0813, target, sampleBuf);
			}
		}
	}

	for (j = 0; fnextsSample[j] != NULL; j++) { // thing being aimed
		for (k = 0; k < 2; k++) { // sign of thing being aimed
			for (i = 0; i < 2; i++) { // sign of infinite target
				char name[] = "FONEXT.FNEXTS +ve step";
				unsigned char target[] = "\p\x7f\x80\x00\x00"; // inf
				unsigned char sampleBuf[5];

				if (i) {
					name[14] = '-';
					target[1] |= 0x80; // make it negative inf
				}

				memcpy(sampleBuf, fnextsSample[j], sizeof(sampleBuf));
				if (k) {
					sampleBuf[1] |= 0x80;
				}

				tempNoMode = 1;
				test(name, 0x1013, target, sampleBuf);
			}
		}
	}

	// Test the interpretation of the sign bool           Sgn.Pad.Exp.....Digits
	tempNoMode = 1; test("FOD2B sign", 0x0009, negInf, "\p\x80\x00\x01\x01\x0223"); // -1 (all of first byte counted)
	tempNoMode = 1; test("FOD2B sign", 0x0009, negInf, "\p\x40\x00\x01\x01\x0223"); // -1 (all of first byte counted)
	tempNoMode = 1; test("FOD2B sign", 0x0009, negInf, "\p\x00\x01\x01\x01\x0223"); // +1 (pad byte ignored)

	/*
	FOD2B and FOB2D share a routine for calculating 10^n, which re-enters SANE
	to call FMULX. The rounding mode for this reentrant call is based on the
	sign field, the sign of the exponent field, and the original rounding mode.
	We want to test this behaviour.

	To expose the reentrant rounding mode, we call FOD2B with parameters that
	ensure FMULX is called and that it traps: large exponent, inexact halt
	enabled. Then we record its FPState in our halt() routine. FMULX, if called,
	is always the first reentrant call from FOD2B, so halt() records FPState the
	first time only.
	*/
	testFOD2B("reentrant FMULX rndMode", 0, -5000, "9999999999999999999");
	testFOD2B("reentrant FMULX rndMode", 0, +5000, "9999999999999999999");
	testFOD2B("reentrant FMULX rndMode", 1, -5000, "9999999999999999999");
	testFOD2B("reentrant FMULX rndMode", 1, +5000, "9999999999999999999");

	testFOD2B("positive zero", 0, 0, "0");
	testFOD2B("negative zero", 1, 0, "0");

	// The 20th digit being nonzero may result in this being rounded to highest or 2nd highest finite
	testFOD2B("largest positive", 0, 4914, "11897314953572317655");
	testFOD2B("largest negative", 1, 4914, "11897314953572317655");

	testFOD2B("random", 1, -340, "7314953572098129803");

	testFOD2B("zero NaN", 0, 99, "N");
	testFOD2B("lil NaN", 0, 99, "N64");
	testFOD2B("big NaN", 1, 99, "N765432");

	tempNoMode = 1; test("FOB2D +0 -> float", 0x000b, "", pos0, "\p\x00\x00");
	tempNoMode = 1; test("FOB2D +0 -> fixed", 0x000b, "", pos0, "\p\x01\x00");
	tempNoMode = 1; test("FOB2D -0 -> float", 0x000b, "", neg0, "\p\x00\x00");
	tempNoMode = 1; test("FOB2D -0 -> fixed16", 0x000b, "", neg0, "\p\x01\x10");

	tempNoMode = 1; test("FOB2D +inf -> float", 0x000b, "", posInf, "\p\x00\x00");
	tempNoMode = 1; test("FOB2D -inf -> fixed", 0x000b, "", negInf, "\p\x01\x00");

	tempNoMode = 1; test("FOB2D NaN", 0x000b, "", "\p\xff\xff\x00\x12\x23\x34\x45\x56\x67\x00", "\p\x00\x00");

	// Floats close to 10^19                       dst src                                  decform -> [fix]   [digits ]
 	tempNoMode = 1; test("FOB2D 10^19-1",  0x000b, "", "\p\x40\x3e\x8a\xc7\x23\x04\x89\xe7\xff\xff", "\p\x00\x00\x00\x20");
 	tempNoMode = 1; test("FOB2D 10^19",    0x000b, "", "\p\x40\x3e\x8a\xc7\x23\x04\x89\xe8\x00\x00", "\p\x00\x00\x00\x20");
 	tempNoMode = 1; test("FOB2D 10^19+10", 0x000b, "", "\p\x40\x3e\x8a\xc7\x23\x04\x89\xe8\x00\x0a", "\p\x00\x00\x00\x20");

	// Smallest float
 	tempNoMode = 1; test("FOB2D tiny", 0x000b, "", "\p\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01", "\p\x00\x00\x00\x13");

	// Fixed-point... make it fail
	tempNoMode = 1; test("FOB2D fixed", 0x000b, "", "\p\xbf\xff\x80\x00\x00\x03\x00\x00\x00\x00", "\p\x01\x00\x00\x04");
	tempNoMode = 1; test("FOB2D fixed", 0x000b, "", "\p\xbf\xff\x80\x00\x00\x03\x00\x00\x00\x00", "\p\x02\x00\x00\x12");
	tempNoMode = 1; test("FOB2D fixed", 0x000b, "", "\p\xbf\xff\x80\x00\x00\x03\x00\x00\x00\x00", "\p\x80\x00\x00\x12"); // "?"

	tapPlan();
	return 0;
}

void test(char *baseName, int opcode, ...) {
	int nargs = argsPerOpcode[opcode & 0xff];
	int mode, i, j, impl;
	int fail = 0;

	for (mode = 0; mode < 12; mode++) {
		char name[666] = "";
		char *nameEnd = name;
		char args0[32*3], args1[32*3];
		char *args[2];
		struct regs regs[2];
		struct haltRec haltRecs[2];
		short fpStates[2];
		long haltVectors[2];
		va_list vargs;

		args[0] = args0; args[1] = args1;

		// Design a name
		va_start(vargs, opcode);
		nameEnd += sprintf(nameEnd, "%s - %04x(", baseName, opcode);
		for (i = 0; i < nargs; i++) {
			char *pstring = va_arg(vargs, char *);
			for (j = 0; j < *pstring; j++) {
				if (j%2==0 && j!=0) *nameEnd++ = '_';
				nameEnd += sprintf(nameEnd, "%02x", pstring[j+1] & 0xff);
			}
			*nameEnd++ = ',';
		}
		va_end(vargs);
		*nameEnd++ = "~^v0"[mode & 3]; // nearest, up, down, zero
		*nameEnd++ = "XDS"[(mode >> 2) & 3]; // ext, double, single
		*nameEnd++ = ')';
		*nameEnd++ = 0;

		tapOpen(name);

		// For each implementation, create machine state and run.
		for (impl = 0; impl < 2; impl++) {
			char tmpArgs[3*32] = {0}; // needed to keep arg addresses consistent
			char stack[500] = {0};
			char *sp = stack + 480;

			// Design a buffer with 1-3 arguments
			va_start(vargs, opcode);
			for (i = 0; i < nargs; i++) {
				char *pstring = va_arg(vargs, char *);
				memcpy(tmpArgs + 32*i, pstring+1, pstring[0]);
			}
			va_end(vargs);

			// Design registers: only stack and global ptr are significant
			memset(&regs[impl], 0xdc, sizeof(regs[impl]));
			regs[impl].a[7] = (long)sp;
			regs[impl].a[5] = getA5();

			// Design stack frame
			*(short *)sp = opcode;
			for (i = 0; i < nargs; i++) {
				*(long *)(sp + 2 + 4*i) = (long)(tmpArgs) + 32*i;
			}

			// Zero halt record, and make it known via a global
			memset(&haltRecs[impl], 0, sizeof(haltRecs[impl]));
			curHaltRec = &haltRecs[impl];
			curHaltOpcode = opcode;

			*FPState = ((mode << 3) & 0x60) | ((mode << 13) & 0x6000) | 0x1f;
			*HaltVector = (long)&halt;

			// Run it
			thunk(sanes[impl], &regs[impl]);
			fpStates[impl] = *FPState;
			haltVectors[impl] = *HaltVector;

			if ((opcode & 0xff) == 0x08 || (opcode & 0xff) == 0x0a) { // CMP,CPX
				regs[impl].ccr &= 0x1f;
			} else {
				regs[impl].ccr = 0xff00;
			}

			memcpy(args[impl], tmpArgs, 3*32);
		}

		fail = memcmp(&regs[0], &regs[1], sizeof(regs[0])) ||
			memcmp(args[0], args[1], 32*3) ||
			memcmp(&haltRecs[0], &haltRecs[1], sizeof(haltRecs[0])) ||
			fpStates[0] != fpStates[1] || haltVectors[0] != haltVectors[1];

		if (fail) tapFail();
		tapClose();

		if (fail || forcePrint) {
			va_start(vargs, opcode);
			for (i = 0; i < nargs; i++) {
				unsigned char *pstring = va_arg(vargs, unsigned char *);
				char *name = "Dst";
				if (i == 1) name = "Src";
				else if (i == 2) name = "Src2";

				// Special case: for the Dst of FOB2D, dump the actual string
				if (i == 0 && (opcode & 0x00ff) == 0x000b) {
					char *err = "  ok  ";
					if (memcmp(args[0], args[1], 32)) {
						err = "NOT OK";
					}

					printf("#  Dst (dec-rec)  %s  %08x \"%.*s\" %08x \"%.*s\"\n",
						err,
						*(unsigned long *)(args[0]), args[0][4], args[0]+5,
						*(unsigned long *)(args[1]), args[1][4], args[1]+5);
					continue;
				}

				printCompare(name, pstring[0], args[0] + 32*i, (long)(args[1]) - (long)(args[0]));
			}
			va_end(vargs);

			printCompare("FPState", 2, fpStates, sizeof(*fpStates));
			printCompare("HaltVector", 4, haltVectors, sizeof(*haltVectors));

			printCompare("Halted", 2, &haltRecs[0].didHalt, sizeof(*haltRecs));
			printCompare("HaltDstArg", 4, &haltRecs[0].dst, sizeof(*haltRecs));
			printCompare("HaltSrcArg", 4, &haltRecs[0].src, sizeof(*haltRecs));
			printCompare("HaltSrc2Arg", 4, &haltRecs[0].src2, sizeof(*haltRecs));
			printCompare("HaltExceptions", 2, &haltRecs[0].exceptions, sizeof(*haltRecs));
			printCompare("HaltCCR", 2, &haltRecs[0].ccr, sizeof(*haltRecs));
			printCompare("HaltD0", 4, &haltRecs[0].d0, sizeof(*haltRecs));
			printCompare("ReentrantHalts", 2, &haltRecs[0].otherOpcodeHalts, sizeof(*haltRecs));
			printCompare("ReentHaltOp", 2, &haltRecs[0].otherOpcodeHaltOp, sizeof(*haltRecs));
			printCompare("ReentHaltState", 2, &haltRecs[0].otherOpcodeHaltState, sizeof(*haltRecs));

			printCompare("D0", 4, &regs[0].d[0], sizeof(*regs));
			printCompare("D1", 4, &regs[0].d[1], sizeof(*regs));
			printCompare("D2", 4, &regs[0].d[2], sizeof(*regs));
			printCompare("D3", 4, &regs[0].d[3], sizeof(*regs));
			printCompare("D4", 4, &regs[0].d[4], sizeof(*regs));
			printCompare("D5", 4, &regs[0].d[5], sizeof(*regs));
			printCompare("D6", 4, &regs[0].d[6], sizeof(*regs));
			printCompare("D7", 4, &regs[0].d[7], sizeof(*regs));
			printCompare("A0", 4, &regs[0].a[0], sizeof(*regs));
			printCompare("A1", 4, &regs[0].a[1], sizeof(*regs));
			printCompare("A2", 4, &regs[0].a[2], sizeof(*regs));
			printCompare("A3", 4, &regs[0].a[3], sizeof(*regs));
			printCompare("A4", 4, &regs[0].a[4], sizeof(*regs));
			printCompare("A5", 4, &regs[0].a[5], sizeof(*regs));
			printCompare("A6", 4, &regs[0].a[6], sizeof(*regs));
			printCompare("SP", 4, &regs[0].a[7], sizeof(*regs));

			printCompare("CCR (CMP/CPX)", 2, &regs[0].ccr, sizeof(*regs));
		}

		if (tempNoMode) {
			tempNoMode = 0;
			break;
		}
	}
}

void testFOD2B(char *baseName, int sign, int exponent, char *string) {
	const int resultLens[] = {10, 8, 4, 99, 2, 4, 8};

	int fmt;
	for (fmt = 0x0000; fmt <= 0x3000; fmt += 0x0800) {
		char name[666];
		char fmtName = "XDS ILC"[fmt >> 11];
		char dstBuffer[11] = {0x99};
		char buffer[32];
		int len = strlen(string);

		if (fmt == 0x1800) continue; // No such format

		// Discard the first byte of buffer to keep fields aligned
		buffer[1] = len + 5;
		*(short *)(buffer + 2) = sign ? 0xff00 : 0x0000;
		*(short *)(buffer + 4) = exponent;
		buffer[6] = len;
		memcpy(buffer + 7, string, len);

		// dstBuffer is just a pascal string with the length of the result
		dstBuffer[0] = resultLens[fmt >> 11];

		sprintf(name, "FOD2B.FDEC2%c(%c%s*10^%d) - %s", fmtName, sign ? '-' : '+', string, exponent, baseName);

		test(name, fmt | 0x0009, dstBuffer, buffer + 1);
	}

}

void printCompare(const char *name, int width, void *field, int delta) {
	char *err = "  ok  ";
	if (memcmp(field, (char *)field + delta, width)) {
		err = "NOT OK";
	}

	printf("# %14s  %s ", name, err);

	if (1 || memcmp(field, (char *)field + delta, width)) {
		int i, j;
		for (i = 0; i < 2; i++) {
			printf(" ");

			for (j = 0; j < width; j++) {
				printf("%02x", ((unsigned char *)field)[i*delta + j]);
			}
		}
	}

	printf("\n");
}

pascal void halt(char *miscrec, long src2, long src, long dst, short opcode) {
	if (opcode == curHaltOpcode) {
		curHaltRec->didHalt = 1;
		curHaltRec->dst = dst;
		curHaltRec->src = src;
		curHaltRec->src2 = src2;
		curHaltRec->exceptions = *(short *)(miscrec);
		curHaltRec->ccr = *(short *)(miscrec + 2);
		curHaltRec->d0 = *(long *)(miscrec + 4);
	} else {
		// Reentrant SANE calls can also halt
		// Record the FPState of the first such halt, for bin<->dec converters
		if (curHaltRec->otherOpcodeHalts == 0) {
			curHaltRec->otherOpcodeHaltOp = opcode;
			curHaltRec->otherOpcodeHaltState = *FPState;
		}
		curHaltRec->otherOpcodeHalts += 1;
	}
}

void thunk(void *funcPtr, struct regs *statePtr) {
	char generatedFunc[200];
	void (*callableFunc)(void);
	short *ptr = (short *)generatedFunc;
	struct regs save;

	// movem.l d0-d7/a0-a7,save
	*ptr++ = 0x48f9;
	*ptr++ = 0xffff;
	*ptr++ = (long)&save >> 16;
	*ptr++ = (long)&save;

	// movem.l state,d0-d7/a0-a7
	*ptr++ = 0x4cf9;
	*ptr++ = 0xffff;
	*ptr++ = (long)statePtr >> 16;
	*ptr++ = (long)statePtr;

	// move regs.ccr,ccr
	*ptr++ = 0x44f9;
	*ptr++ = (long)&statePtr->ccr >> 16;
	*ptr++ = (long)&statePtr->ccr;

	// jsr sane
	*ptr++ = 0x4eb9;
	*ptr++ = (long)funcPtr >> 16;
	*ptr++ = (long)funcPtr;

	// move sr,regs.ccr
	*ptr++ = 0x40f9;
	*ptr++ = (long)&statePtr->ccr >> 16;
	*ptr++ = (long)&statePtr->ccr;

	// movem.l d0-d7/a0-a7,state
	*ptr++ = 0x48f9;
	*ptr++ = 0xffff;
	*ptr++ = (long)statePtr >> 16;
	*ptr++ = (long)statePtr;

	// movem.l save,d0-d7/a0-a7
	*ptr++ = 0x4cf9;
	*ptr++ = 0xffff;
	*ptr++ = (long)&save >> 16;
	*ptr++ = (long)&save;

	// rts
	*ptr++ = 0x4e75;

	// Clear the instruction cache
	BlockMove(generatedFunc, generatedFunc, sizeof(generatedFunc));

	callableFunc = (void *)generatedFunc;
	callableFunc();
}

void *saneFromFile(char *path) {
	int cut = 0;
	long i;
	long size;
	char *file;

	for (i = 0; path[i] != 0; i++) {
		if (path[i] == ':') {
			cut = i;
		}
	}
	strcpy(path + cut, "::sane");

	file = (char *)slurp(path, &size);
	for (i = 0; i + 10 < size; i += 2) {
		if (file[i] == 0x60 &&
			file[i+1] == 0x0a &&
			file[i+4] == 'P' &&
			file[i+5] == 'A' &&
			file[i+6] == 'C' &&
			file[i+7] == 'K' &&
			file[i+8] == 0x00 &&
			file[i+9] == 0x04) {
			break;
		}
	}

	if (i + 10 >= size) {
		fprintf(stderr, "PACK 4 not found in file\n");
		exit(1);
	}

	return (void *)(file + i);
}

void *slurp(char *path, long *returnSize) {
	FILE *f;
	long pos, readsuccess;
	void *bytes;

	f = fopen(path, "rb");
	if (!f) goto fail;

	fseek(f, 0, SEEK_END);
	pos = ftell(f);
	fseek(f, 0, SEEK_SET);

	bytes = malloc(pos);
	if (!bytes) goto fail;

	readsuccess = fread(bytes, 1, pos, f);
	if (readsuccess != pos) goto fail;

	if (fclose(f)) goto fail;

	*returnSize = pos;
	return bytes;

fail:
	fprintf(stderr, "\"sane\" not found TestTools\n");
	exit(1);
	return 0; // silence the warning
}

void tapOpen(char *name) {
	tapCount++;
	tapName = name;
	tapOK = 1;
}

void tapFail() {
	if (tapOK) {
		printf("not ok %ld - %s\n", tapCount, tapName);
		tapOK = 0;
	}
}

void tapClose() {
	if (tapOK) {
		printf("ok %ld - %s\n", tapCount, tapName);
	}
}

void tapPlan() {
	printf("1..%ld\n", tapCount);
}
