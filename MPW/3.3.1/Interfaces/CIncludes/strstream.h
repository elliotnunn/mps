/*
 *------------------------------------------------------------------------
 * Copyright:
 *      © 1993 by Apple Computer Inc.  all rights reserved.
 *
 * Project:
 *      PowerPC C++ Streams Library
 *
 * Filename:
 *      strstream.h
 *
 * Created:
 *      (unknown)
 *
 * Modified:
 *      Date     Engineer       Comment
 *      -------- -------------- ------------------------------------------
 *      12/17/93 Rudy Wang      Made this file universal.
 *------------------------------------------------------------------------
 */
#ifndef __STRSTREAMH__
#define __STRSTREAMH__      1

#include <iostream.h>

#ifdef powerc
#pragma options align=power
#endif

class strstreambuf : public streambuf
{

public:
                strstreambuf();
                strstreambuf(int);
                strstreambuf(void* (*a)(long), void (*f)(void*));
                strstreambuf(char* b, int size, char* pstart = 0);
                strstreambuf(unsigned char* b, int size, unsigned char* pstart = 0);
                ~strstreambuf();
    int         pcount();
    void        freeze(int n = 1);
    char*       str();

public:
    virtual int         doallocate();
    virtual int         overflow(int);
    virtual int         underflow();
    virtual streambuf*  setbuf(char* p, int l);
    virtual streampos   seekoff(streamoff, ios::seek_dir, int);

private:
    void        init(char*, int, char*);
    void*       (*afct)(long);
    void        (*ffct)(void*);
    int         ignore_oflow;
    int         froozen;
    int         auto_extend;

#ifdef powerc
public:
    int         isfrozen()              { return froozen; }
#endif

};  // class strstreambuf


class strstreambase : public virtual ios
{

public:
                strstreambuf* rdbuf();

protected:
                strstreambase(char*, int, char*);
                strstreambase();
                ~strstreambase();

private:
    strstreambuf buf;

};  // class strstreambase


class istrstream : public strstreambase, public istream
{

public:
                istrstream(char* str);
                istrstream(char* str, int size);
                ~istrstream();

};  // class istrstream


class ostrstream : public strstreambase, public ostream
{

public:
                ostrstream(char* str, int size, int mode = ios::out);
                ostrstream();
                ~ostrstream();
    char*       str();
    int         pcount();

};  // class ostrstream


class strstream : public strstreambase, public iostream
{

public:
                strstream();
                strstream(char* str, int size, int mode);
                ~strstream();
    char*       str();

};  // class strstream

#ifdef powerc
#pragma options align=reset
#endif

#endif
