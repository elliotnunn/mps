/*
 *	stdio.h -- Standard C I/O Package
 *	Modified for use with Macintosh C
 *	Apple Computer, Inc.  1985
 *
 *	version	2.0a3
 *
 *	Copyright American Telephone & Telegraph
 *	Used with permission, Apple Computer Inc. (1985)
 *	All rights reserved.
 */

#ifndef __STDIO__
#define __STDIO__

#define _NFILE	  20
#define BUFSIZ	1024			/* default file buffer size */
#define _LBFSIZ  100			/* Line buffer size */

typedef struct {
	int 			_cnt;
	unsigned char	*_ptr;
	unsigned char	*_base;
	unsigned char	*_end;
	unsigned short	_size;
	unsigned short	_flag;
	unsigned short	_file;
} FILE;

/*
 * 07-Sep-85, Hartwell:
 *		_IOSYNC will synchronize input and output fp's, such that
 *				a read() for an input fp with this bit set will first
 *				fflush() all output fp's which have the _IOSYNC bit set.
 *		_IOLBF simply declares that a fflush() occurs when a \n is written.
 */
#define _IOFBF		0			/* Pseudo-flag, default buffering style */
#define _IOREAD 	(1<<0)		/* Current mode is for reading */
#define _IOWRT		(1<<1)		/* Current mode is for writing */
#define _IONBF		(1<<2)		/* no buffering */
#define _IOMYBUF	(1<<3)		/* buffer was allocated by stdio */
#define _IOEOF		(1<<4)
#define _IOERR		(1<<5)
#define _IOLBF		(1<<6)		/* fflush(iop) when a \n is written */
#define _IORW		(1<<7)		/* Enable read/write access */
#define _IOSYNC 	(1<<8)		/* Input triggers fflush() to output fp's */

#ifndef NULL
#define NULL		0
#endif
#ifndef EOF
#define EOF 		(-1)
#endif

#define stdin		(&_iob[0])
#define stdout		(&_iob[1])
#define stderr		(&_iob[2])

/*
 * Hartwell: new structure components are
 * backwards-compatible with other stdio modules.
 */
#define _bufend(p)	(p)->_end
#define _bufsiz(p)	(p)->_size

#ifndef lint
#define getc(p) 	(--(p)->_cnt >= 0 ? (int) *(p)->_ptr++ : _filbuf(p))
#define putc(x, p)	(--(p)->_cnt >= 0 ? \
						((int) (*(p)->_ptr++ = (unsigned char) (x))) : \
						_flsbuf((unsigned char) (x), (p)))
#define getchar()	getc(stdin)
#define putchar(x)	putc((x), stdout)
#define clearerr(p) ((void) ((p)->_flag &= ~(_IOERR | _IOEOF)))
#define feof(p) 	((p)->_flag & _IOEOF)
#define ferror(p)	((p)->_flag & _IOERR)
#define fileno(p)	(p)->_file
#endif lint

extern FILE 	_iob[_NFILE];
extern FILE 	*fopen(), *fdopen(), *freopen();
extern long 	ftell();
extern void 	rewind(), setbuf();
extern char 	*fgets(), *gets();

#endif __STDIO__
