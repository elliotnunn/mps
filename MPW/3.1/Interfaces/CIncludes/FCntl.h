/*
 * FCntl.h -- faccess(), fcntl(), and open() mode flags
 *
 * Portions copyright American Telephone & Telegraph
 * Used with permission, Apple Computer Inc. (1985, 1988)
 * All rights reserved.
 */

#ifndef __FCNTL__
#define __FCNTL__
/*
 * faccess() commands
 */
# define F_OPEN 		(('d'<<8)|00)		/* 'd' => "directory" ops */
# define F_DELETE		(('d'<<8)|01)
# define F_RENAME		(('d'<<8)|02)

# define F_GTABINFO 	(('e'<<8)|00)		/* 'e' => "editor" ops */	
# define F_STABINFO 	(('e'<<8)|01)
# define F_GFONTINFO	(('e'<<8)|02)
# define F_SFONTINFO	(('e'<<8)|03)
# define F_GPRINTREC	(('e'<<8)|04)
# define F_SPRINTREC	(('e'<<8)|05)
# define F_GSELINFO 	(('e'<<8)|06)
# define F_SSELINFO 	(('e'<<8)|07)
# define F_GWININFO 	(('e'<<8)|08)
# define F_SWININFO 	(('e'<<8)|09)

/*
 * Mode values accessible to open()
 */
# define O_RDONLY	  0 		/* Bits 0 and 1 are used internally */
# define O_WRONLY	  1 		/* Values 0..2 are historical */
# define O_RDWR 	  2
# define O_APPEND	(1<<3)		/* append (writes guaranteed at the end) */
# define O_RSRC 	(1<<4)		/* Open the resource fork */
# define O_CREAT	(1<<8)		/* Open with file create */
# define O_TRUNC	(1<<9)		/* Open with truncation */
# define O_EXCL 	(1<<10) 	/* Exclusive open */
# define O_BINARY	(1<<11) 	/* Open as a binary stream */
# define O_USEP 	(1<<12) 	/* For internal use only */
# define O_TMP 		(1<<13) 	/* For internal use only */

#ifdef __safe_link
extern "C" {
#endif

int faccess(char*, unsigned int, long*);
int fcntl(int, unsigned int, int);
int unlink(char*), open(const char*, int), close(int), creat(const char*);
int read(int, char*, unsigned), write(int, const char*, unsigned);
long lseek(int, long, int); 

#ifdef __safe_link
}
#endif

# define F_DUPFD 0	   /* Duplicate fildes */

#endif __FCNTL__
