/*
 *------------------------------------------------------------------------
 * Copyright:
 *      © 1993 by Apple Computer Inc.  all rights reserved.
 *
 * Project:
 *      PowerPC C++ Streams Library
 *
 * Filename:
 *      stream.h
 *
 * Created:
 *      1993
 *
 * Modified:
 *      Date     Engineer       Comment
 *      -------- -------------- ------------------------------------------
 *      12/17/93 Rudy Wang      Made this file universal.
 *------------------------------------------------------------------------
 */
#ifndef __STREAMH__
#define __STREAMH__         1

#include <iostream.h>
#include <iomanip.h>
#include <stdiostream.h>
#include <fstream.h>

#ifndef NULL
#define NULL    0
#endif

extern char* oct(long, int = 0);
extern char* dec(long, int = 0);
extern char* hex(long, int = 0);

extern char* chr(int, int = 0);         // chr(0) is an empty string ""
extern char* str(const char*, int = 0);
extern char* form(const char* ...);

extern istream& WS(istream&);
extern void eatwhite(istream&);

static const int input  = (ios::in);
static const int output = (ios::out);
static const int append = (ios::app);
static const int atend  = (ios::ate);
static const int _good  = (ios::goodbit);
static const int _bad   = (ios::badbit);
static const int _fail  = (ios::failbit);
static const int _eof   = (ios::eofbit);

typedef ios::io_state state_value;

#endif
