/*ident	"@(#)ctrans:incl/pipestream.h	1.1.1.1" */
/**************************************************************************
                        Copyright (c) 1984 AT&T
                          All Rights Reserved   

        THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF AT&T
      
        The copyright notice above does not evidence any        
        actual or intended publication of such source code.

*****************************************************************************/
#ifndef __PIPESTREAM__
#define __PIPESTREAM__

#ifndef __IOSTREAM__
#include <iostream.h>
#endif

class pipebuf : public streambuf {
	virtual int	overflow(int);	
	virtual int	underflow();
	virtual int	pbackfail(int);
	void 		normalize() ;
public:
			pipebuf() ;
			pipebuf(char*  p, int l) ;
	int		full() ;
	int		empty() ;
	virtual streambuf*
			setbuf(char*  p, int l, int c) ;
	
};

class pipestream : public iostream {
	pipebuf		buf ;
public:
			pipestream();
			pipestream(char*  p, int l) ;
	pipebuf*	rdbuf() ;
	} ;

#endif
