/*
	stdiostream.h -- Streams classes: stdiobuf, stdiostream

	Copyright Apple Computer,Inc.	1994-1995
	All rights reserved.

*/

#ifndef __STDIOSTREAM__
#define __STDIOSTREAM__    1

#include <iostream.h>
#include <stdio.h>

/*
 * stdiobuf is obsolete, should be avoided!!!
 */
#ifdef powerc
#pragma options align=power
#endif

class stdiobuf : public streambuf
{

public:
                        stdiobuf(FILE* f);
        FILE*           stdiofile()             { return fp; }
        virtual         ~stdiobuf();

public:
        virtual int     overflow(int = EOF);
        virtual int     underflow();
        virtual int     sync();
        virtual streampos seekoff(streamoff, ios::seek_dir, int);
        virtual int     pbackfail(int c);

private:
        FILE*           fp;                     
        int             last_op;
        char            buf[2];

};  // class stdiobuf


class stdiostream : public ios
{

public:
                        stdiostream(FILE*);
                        ~stdiostream();
        stdiobuf*       rdbuf();

private:
        stdiobuf        buf;

};  // class stdiostream

#ifdef powerc
#pragma options align=reset
#endif

#endif	/* __STDIOSTREAM__ */
