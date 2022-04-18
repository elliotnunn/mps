// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

// C interface to the routines in TAP.a

pascal void LineAppend(unsigned char *);
pascal void LineAppendX(short);
pascal void LineFlush(void);
pascal void TestOpen(unsigned char *);
pascal void TestClose(void);
pascal void TestFail(void);
pascal void TestFailMsg(unsigned char *);
pascal void TestPlan(void);
pascal void TestStrCmp(unsigned char *, unsigned char *);
