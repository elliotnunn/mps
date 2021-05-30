/*
	fstream.h -- Streams classes: filebuf, fstreambase, ifstream, ofstream, fstream
	
	Copyright Apple Computer,Inc.	1994-1995
	All rights reserved.

*/

#ifndef __FSTREAM__
#define __FSTREAM__        1

#include <iostream.h>

#ifdef powerc
#pragma options align=power
#endif

class filebuf : public streambuf
{

public:
        static const int openprot;      // default protection mode for open

public:
                        filebuf();
                        filebuf(int fd);
                        filebuf(int fd, char* p, int l);
                        ~filebuf();
        int             is_open()       { return opened; }
        int             fd()            { return xfd; }
        filebuf*        open(const char *name, int om, int prot = openprot);
        filebuf*        attach(int fd);
        filebuf*        close();

public:
        virtual int     overflow(int = EOF);
        virtual int     underflow();
        virtual int     sync();
        virtual streampos seekoff(streamoff, ios::seek_dir, int);
        virtual streambuf* setbuf(char* p, int len);
        virtual int     xsputn(const char* s, int n);

protected:
        int             xfd;    
        int             mode;
        char            opened;
        char            i_opened_it;	// If true, the associated file was opened by this object.
        streampos       last_seek;
        char*           in_start;
        int             last_op();
        char            lahead[2];

};  // class filebuf


class fstreambase : virtual public ios
{

public:
                        fstreambase();
                        fstreambase(const char* name, int mode, int prot = filebuf::openprot);
                        fstreambase(int fd);
                        fstreambase(int fd, char* p, int l);
                        ~fstreambase();
        void            open(const char* name, int mode, int prot = filebuf::openprot);
        void            attach(int fd);
        void            close();
        void            setbuf(char* p, int l);
        filebuf*        rdbuf()         { return &buf; }

private:
        filebuf         buf;

protected:
        void            verify(int);

};  // class fstreambase


class ifstream : public fstreambase, public istream
{

public:
                        ifstream();
                        ifstream(const char* name, int mode = ios::in, int prot = filebuf::openprot);
                        ifstream(int fd);
                        ifstream(int fd, char* p, int l);
                        ~ifstream();
        void            open(const char* name, int mode = ios::in, int prot = filebuf::openprot);
        filebuf*        rdbuf()         { return fstreambase::rdbuf(); }

};  // class ifstream


class ofstream : public fstreambase, public ostream
{

public:
                        ofstream();
                        ofstream(const char* name, int mode = ios::out, int prot = filebuf::openprot);
                        ofstream(int fd);
                        ofstream(int fd, char* p, int l);
                        ~ofstream();
        void            open(const char* name, int mode = ios::out, int prot = filebuf::openprot);
        filebuf*        rdbuf()         { return fstreambase::rdbuf(); }

};  // class ofstream


class fstream : public fstreambase, public iostream
{

public:
                        fstream();
                        fstream(const char* name, int mode, int prot = filebuf::openprot);
                        fstream(int fd);
                        fstream(int fd, char* p, int l);
                        ~fstream();
        void            open(const char* name, int mode, int prot = filebuf::openprot);
        filebuf*        rdbuf()         { return fstreambase::rdbuf(); }

};  // class fstream


#ifdef powerc
#pragma options align=reset
#endif

#endif	/* __FSTREAM__ */
