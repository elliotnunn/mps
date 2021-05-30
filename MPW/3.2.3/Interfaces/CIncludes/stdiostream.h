/*ident	"@(#)C++env:incl-master/const-headers/stdiostream.h	1.2" */
/**************************************************************************
                        Copyright (c) 1984 AT&T
                          All Rights Reserved   

        THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF AT&T
      
        The copyright notice above does not evidence any        
        actual or intended publication of such source code.

*****************************************************************************/
#ifndef __STDSTREAM__
#define __STDSTREAM__

#include <iostream.h>
#include <stdio.h>

class stdiobuf : public streambuf {
	/*** stdiobuf is obsolete, should be avoided ***/
public: // Virtuals
	virtual int	overflow(int=EOF);
	virtual int	underflow();
	virtual int	sync() ;
	virtual streampos
#ifdef __ATT2_1
			seekoff(streamoff,ios::seek_dir,int) ;
#else  /*__ATT2_1*/
			seekoff(streamoff,seek_dir,int) ;
#endif /*__ATT2_1*/
	virtual int	pbackfail(int c);
public:
			stdiobuf(FILE* f) ;
	FILE*		stdiofile() { return fp ; }
	virtual		~stdiobuf() ;
private:
	FILE*		fp ;			
	int		last_op ;
	char		buf[2];
};

class stdiostream : public ios {
public:
			stdiostream(FILE*) ;
			~stdiostream() ;
	stdiobuf*	rdbuf() ;
private:
	stdiobuf	buf ;
};

#endif

