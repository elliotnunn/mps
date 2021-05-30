/*
 *------------------------------------------------------------------------
 * Copyright:
 *      © 1993 by Apple Computer Inc.  all rights reserved.
 *
 * Project:
 *      PowerPC C++ Streams Library
 *
 * Filename:
 *      fstream.h
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
#ifndef __FSTREAMH__
#define __FSTREAMH__        1

#include <iostream.h>

#ifdef powerc
#pragma options align=power
#endif

class filebuf : public streambuf
{

#ifdef powerc
public:
        static const int openprot;      // default protection mode for open
#endif

public:
                        filebuf();
                        filebuf(int fd);
                        filebuf(int fd, char* p, int l);
                        ~filebuf();
        int             is_open()       { return opened; }
        int             fd()            { return xfd; }
#ifdef applec
        filebuf*        open(const char *name, int om);
#else
        filebuf*        open(const char *name, int om, int prot = openprot);
#endif
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
        streampos       last_seek;
        char*           in_start;
        int             last_op();
        char            lahead[2];

};  // class filebuf


class fstreambase : virtual public ios
{

public:
                        fstreambase();
#ifdef applec
                        fstreambase(const char* name, int mode);
#else
                        fstreambase(const char* name, int mode, int prot = filebuf::openprot);
#endif
                        fstreambase(int fd);
                        fstreambase(int fd, char* p, int l);
                        ~fstreambase();
#ifdef applec
        void            open(const char* name, int mode);
#else
        void            open(const char* name, int mode, int prot = filebuf::openprot);
#endif
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
#ifdef applec
                        ifstream(const char* name, int mode = ios::in);
#else
                        ifstream(const char* name, int mode = ios::in, int prot = filebuf::openprot);
#endif
                        ifstream(int fd);
                        ifstream(int fd, char* p, int l);
                        ~ifstream();
#ifdef applec
        void            open(const char* name, int mode = ios::in);
#else
        void            open(const char* name, int mode = ios::in, int prot = filebuf::openprot);
#endif
        filebuf*        rdbuf()         { return fstreambase::rdbuf(); }

};  // class ifstream


class ofstream : public fstreambase, public ostream
{

public:
                        ofstream();
#ifdef applec
                        ofstream(const char* name, int mode = ios::out);
#else
                        ofstream(const char* name, int mode = ios::out, int prot = filebuf::openprot);
#endif
                        ofstream(int fd);
                        ofstream(int fd, char* p, int l);
                        ~ofstream();
#ifdef applec
        void            open(const char* name, int mode = ios::out);
#else
        void            open(const char* name, int mode = ios::out, int prot = filebuf::openprot);
#endif
        filebuf*        rdbuf()         { return fstreambase::rdbuf(); }

};  // class ofstream


class fstream : public fstreambase, public iostream
{

public:
                        fstream();
#ifdef applec
                        fstream(const char* name, int mode);
#else
                        fstream(const char* name, int mode, int prot = filebuf::openprot);
#endif
                        fstream(int fd);
                        fstream(int fd, char* p, int l);
                        ~fstream();
#ifdef applec
        void            open(const char* name, int mode);
#else
        void            open(const char* name, int mode, int prot = filebuf::openprot);
#endif
        filebuf*        rdbuf()         { return fstreambase::rdbuf(); }

};  // class fstream


#ifdef powerc
#pragma options align=reset
#endif

#endif
