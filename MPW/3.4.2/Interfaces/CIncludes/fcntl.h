/************************************************************

    FCntl.h
    faccess(), fcntl(), and open() mode flags.

    Copyright Apple Computer,Inc.  1995
    All rights reserved

 * Warning:  This interface is NOT a part of the ANSI C standard.
 *           This header file is not POSIX compliant.
 *           For portable code, don't use this interface.

************************************************************/


#ifndef __FCNTL__
#define __FCNTL__


/*
 * Get common declarations 
 */

#include <SeekDefs.h>
#include <SizeTDef.h>


/*
 * faccess() commands; for general use
 */
                       /* 'd' => "directory" ops */
#define F_DELETE        (('d'<<8)|0x01)
#define F_RENAME        (('d'<<8)|0x02)

/*
 * more faccess() commands; for use only by MPW tools
 */
 
#define F_OPEN          (('d'<<8)|0x00)     /* reserved for operating system use  */
                       /* 'e' => "editor" ops */
#define F_GTABINFO      (('e'<<8)|0x00)     /* get tab offset for file            */
#define F_STABINFO      (('e'<<8)|0x01)     /* set  "   "      "   "              */
#define F_GFONTINFO     (('e'<<8)|0x02)     /* get font number and size for file  */
#define F_SFONTINFO     (('e'<<8)|0x03)     /* set  "     "     "   "    "   "    */
#define F_GPRINTREC     (('e'<<8)|0x04)     /* get print record for file          */
#define F_SPRINTREC     (('e'<<8)|0x05)     /* set   "     "     "   "            */
#define F_GSELINFO      (('e'<<8)|0x06)     /* get selection information for file */
#define F_SSELINFO      (('e'<<8)|0x07)     /* set     "          "       "   "   */
#define F_GWININFO      (('e'<<8)|0x08)     /* get current window position        */
#define F_SWININFO      (('e'<<8)|0x09)     /* set    "      "       "            */
#define F_GSCROLLINFO   (('e'<<8)|0x0A)     /* get scroll information             */
#define F_SSCROLLINFO   (('e'<<8)|0x0B)     /* set    "        "                  */
#define F_GMARKER       (('e'<<8)|0x0D)     /* Get Marker                         */
#define F_SMARKER       (('e'<<8)|0x0C)     /* Set   "                            */
#define F_GSAVEONCLOSE  (('e'<<8)|0x0F)     /* Get Save on close                  */
#define F_SSAVEONCLOSE  (('e'<<8)|0x0E)     /* Set  "   "    "                    */

/*
 *  argument structure for use with F_SMARKER command
 */
#ifdef powerc
#pragma options align=mac68k
#endif
struct MarkElement {
    int             start;          /* start position of mark */
    int             end;            /* end position */
    unsigned char   charCount;      /* number of chars in mark name */
    char            name[64];       /* marker name */
};                                  /* note: marker may be up to 64 chars long */

#ifdef powerc
#pragma options align=reset
#endif

#ifndef __cplusplus
typedef struct MarkElement MarkElement;
#endif

#ifdef powerc
#pragma options align=mac68k
#endif
struct SelectionRecord {
    long    startingPos;
    long    endingPos;
    long    displayTop;
};
#ifdef powerc
#pragma options align=reset
#endif
#ifndef __cplusplus
typedef struct SelectionRecord SelectionRecord;
#endif


/*
 * Mode values accessible to open()
 */
 
#define O_RDONLY      0x00      /* Open for reading only.            */
#define O_WRONLY      0x01      /* Open for writing only.            */
#define O_RDWR        0x02      /* Open for reading & writing.       */
#define O_APPEND      0x08      /* Write to the end of the file.     */
#define O_RSRC        0x10      /* Open the resource fork.           */
#define O_ALIAS       0x20      /* Open alias file.                  */
#define O_CREAT      0x100      /* Open or create a file.            */
#define O_TRUNC      0x200      /* Open and truncate to zero length. */
#define O_EXCL       0x400      /* Create file only; fail if exists. */
#define O_BINARY     0x800      /* Open as a binary stream.          */
#define O_NRESOLVE  0x4000      /* Don't resolve any aliases.        */

/*
 * fcntl() commands
 */
#define F_DUPFD 0      /* Duplicate files (file descriptor) */


typedef int ssize_t;
typedef long off_t;

#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
    #pragma import on
#endif

#if __cplusplus
extern "C" {
#endif  /* __cplusplus */

/*
 * Input and Output Primitives 
 */

extern int open(const char *path, int oflag);
extern int creat(const char *path);
extern int unlink(const char *path);
extern int faccess(const char *path, unsigned int cmd, long *arg);
extern int dup(int fildes);     /* OBSOLETE: fcntl(filedes, F_DUPFD, 0) is preferred. */
extern int close(int fildes);
extern ssize_t read(int fildes, void *buf, size_t nbyte);
extern ssize_t write(int fildes, const void *buf, size_t nbyte);
extern int fcntl(int fildes, unsigned int cmd, int arg);
extern off_t lseek(int fildes, off_t offset, int whence);


#if __cplusplus
}
#endif  /* __cplusplus */

#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
    #pragma import off
#endif

#endif  /* __FCNTL__ */
