/************************************************************

Created: Tuesday, October 4, 1988 at 10:47 PM
    SANE.h
    C Interface to the Macintosh Libraries



    Copyright Apple Computer, Inc.  1985-1988
    All rights reserved

************************************************************/


#ifndef __SANE__
#define __SANE__


#ifdef mc68881

/* specific to the MC68881 SANE library */

#define INEXACT 8
#define DIVBYZERO 16
#define UNDERFLOW 32
#define OVERFLOW 64
#define INVALID 128
#define CURINEX1 256
#define CURINEX2 512
#define CURDIVBYZERO 1024
#define CURUNDERFLOW 2048
#define CUROVERFLOW 4096
#define CUROPERROR 8192
#define CURSIGNAN 16384
#define CURBSONUNOR 32768

#else

/* specific to the software SANE library */

#define INVALID 1
#define UNDERFLOW 2
#define OVERFLOW 4
#define DIVBYZERO 8
#define INEXACT 16
#define IEEEDEFAULTENV 0                        /*IEEE-default floating-point environment*/

#endif                                          /* mc68881 */

/* The common interface to the SANE library */

/* Decimal Representation Constants */

#define SIGDIGLEN 20                            /* significant decimal digits */
#define DECSTROUTLEN 80                         /* max length for dec2str output */

/* Decimal Formatting Styles */

#define FLOATDECIMAL 0
#define FIXEDDECIMAL 1

/* Ordering Relations */

#define GREATERTHAN 0
#define LESSTHAN 1
#define EQUALTO 2
#define UNORDERED 3

/* Inquiry Classes */

#define SNAN 0
#define QNAN 1
#define INFINITE 2
#define ZERONUM 3
#define NORMALNUM 4
#define DENORMALNUM 5

/* Rounding Directions */

#define TONEAREST 0
#define UPWARD 1
#define DOWNWARD 2
#define TOWARDZERO 3

/* Rounding Precisions */

#define EXTPRECISION 0
#define DBLPRECISION 1
#define FLOATPRECISION 2

#ifdef mc68881

typedef long exception;


struct extended80 {
    short w[5];
};

#ifndef __cplusplus
typedef struct extended80 extended80;
#endif

struct environment {
    long FPCR;
    long FPSR;
};

#ifndef __cplusplus
typedef struct environment environment;
#endif

environment IEEEDEFAULTENV = {0L,0L};           /* IEEE-default floating-point environment */

struct trapvector {
    void (*unordered)();
    void (*inexact)();
    void (*divbyzero)();
    void (*underflow)();
    void (*operror)();
    void (*overflow)();
    void (*signan)();
};

#ifndef __cplusplus
typedef struct trapvector trapvector;
#endif

#else

typedef short exception;
typedef short environment;
typedef struct {short w[6];} extended96;
typedef pascal void (*haltvector)();
  
#endif

typedef short relop;                            /* relational operator */
typedef short numclass;                         /* inquiry class */
typedef short rounddir;                         /* rounding direction */
typedef short roundpre;                         /* rounding precision */

struct decimal {
    char sgn;                                   /*sign 0 for +, 1 for -*/
    char unused;
    short exp;                                  /*decimal exponent*/
    struct{
        unsigned char length;
        unsigned char text[SIGDIGLEN];          /*significant digits */
        unsigned char unused;
        }sig;
};

#ifndef __cplusplus
typedef struct decimal decimal;
#endif

struct decform {
    char style;                                 /*FLOATDECIMAL or FIXEDDECIMAL*/
    char unused;
    short digits;
};

#ifndef __cplusplus
typedef struct decform decform;
#endif

#ifdef __safe_link
extern "C" {
#endif

#ifdef mc68881

struct trapvector gettrapvector(void); 
void settrapvector(const trapvector *v); 
extended X80toX96(const extended80 *x);         /* X80toX96 <-- 80 bit x in 96 bit extended format */
void x96tox80(extended *x,extended80 *x80); 
void x80tox96(extended80 *x80,extended *x); 

#else

haltvector gethaltvector(void); 
void sethaltvector(haltvector v); 
void x96tox80(extended96 *x96,extended *x); 
void x80tox96(extended *x,extended96 *x96); 

#endif

void num2dec(decform *f,extended x,decimal *d); 
extended dec2num(decimal *d); 
void dec2str(decform *f,decimal *d,char *s);    /* s <-- d, according to format f */
void str2dec(char *s,short *ix,decimal *d,short *vp); 
/* 
    on input ix is starting index into s, on
    output ix is one greater than index of last 
    character of longest numeric substring; 
    boolean vp = ”s begining at given ix is a 
    valid numeric string or a valid prefix of  
    some numeric string”
*/

extended remainder(extended x,extended y,short *quo); 
/* 
    IEEE remainder; quo <-- 7 loworder bits of integer quotient x/y, 
    -127 <= quo <= 127
*/

extended sqrt(extended x);                      /* square root */
extended rint(extended x);                      /* round to integral value */
extended scalb(short n,extended x); 
/* 
    binary scale: x * 2^n; 
    first coerces n to short
*/

extended logb(extended x); 
/* 
    binary log: binary exponent of 
    normalized x
*/

extended copysign(extended x,extended y);       /* returns y with sign of x */
extended nextfloat(extended x,extended y); 
/* 
    next float representation after 
    (float) x in direction of (float) y
*/

extended nextdouble(extended x,extended y); 
/* 
    next double representation after 
    (double) x in direction of (double) y
*/

extended nextextended(extended x,extended y); 
/* 
    next extended representation after 
     x in direction of y
*/

extended log2(extended x);                      /* base-2 logarithm */
extended log(extended x);                       /* base-e logarithm */
extended log1(extended x);                      /* log(1 + x) */
extended exp2(extended x);                      /* base-2 exponential */
extended exp(extended x);                       /* base-e exponential */
extended exp1(extended x);                      /* exp(x) - 1 */
extended power(extended x,extended y);          /* general exponential: x ^ y */
extended ipower(extended x,short i);            /* integer exponential: x ^ i */
extended compound(extended r,extended n);       /* compound: (1 + r) ^ n */
extended annuity(extended r,extended n);        /* annuity: (1 - (1 + r) ^ (-n)) / r */
extended tan(extended x);                       /* tangent */
extended sin(extended x);                       /* sine */
extended cos(extended x);                       /* cosine */
extended atan(extended x);                      /* arctangent */
extended randomx(extended *x); 
/* 
    returns next random number; updates x 
    x must be integral, 1 <= x <= 2^31 - 2
*/

numclass classfloat(extended x);                /* class of (float) x */
numclass classdouble(extended x);               /* class of (double) x */
numclass classcomp(extended x);                 /* class of (comp) x */
numclass classextended(extended x);             /* class of x */
long signnum(extended x);                       /* returns 0 for +, 1 for -class of x */
void setexception(exception e,long s); 
/* 
    clears e flags if s is 0, sets 
    e flags otherwise; may cause halt
*/

long testexception(exception e); 
/* 
    returns 1 if any e flag is set, 
    returns 0 otherwise
*/

void sethalt(exception e,long s); 
/* 
    disables e halts if s is 0, enables e 
    halts otherwise
*/

long testhalt(exception e); 
/* 
    returns 1 if any e halt is enabled, 
    returns 0 otherwise
*/

void setround(rounddir r);                      /* sets rounding direction to r */
rounddir getround(void);                        /* returns current rounding direction */
void setprecision(roundpre p);                  /* sets rounding precision to p */
roundpre getprecision(void);                    /* returns current rounding precision */
void setenvironment(environment e);             /* sets SANE environment to e */
void getenvironment(environment *e);            /* e <-- SANE environment */
void procentry(environment *e); 
/* 
    e <-- SANE environment;
    SANE environment <-- IEEEdefaultenv
*/

void procexit(environment e); 
/* 
    temp <-- current exceptions; 
    SANE environment <-- e;
    signals exceptions in temp
*/

relop relation(extended x,extended y); 
/* 
    returns relation such that 
    ”x relation y” is true
*/

extended nan(unsigned char c);                  /* returns NaN with code c */
extended inf(void);                             /* infinity */
extended pi(void);                              /* pi */
#ifdef __safe_link
}
#endif

#endif
