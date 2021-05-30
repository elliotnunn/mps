/*
 *	File: Float.h
 *	ANSI C version
 *	Copyright Apple Computer, Inc. 1987, 1988
 *	All Rights Reserved
 *	Confidential and Proprietary to Apple Computer,Inc.
 *
 */

#ifndef __MATH__
#include <Math.h>
#endif __MATH__

#ifndef __FLOAT__
#define __FLOAT__


#define	DBL_DIG				15
#define	DBL_EPSILON			scalb(-52,1.0)
#define	DBL_MANT_DIG		53
#define	DBL_MAX				nextdouble(inf(),0.0)
#define	DBL_MAX_10_EXP		308
#define	DBL_MAX_EXP			1024
#define	DBL_MIN				scalb(DBL_MIN_EXP-1,1.0)
#define	DBL_MIN_10_EXP		(-307)
#define	DBL_MIN_EXP			(-1021)

#define	FLT_DIG				7
#define	FLT_EPSILON			scalb(-23,1.0)
#define	FLT_MANT_DIG		24
#define	FLT_MAX				nextfloat(inf(),0.0)
#define	FLT_MAX_10_EXP		38
#define	FLT_MAX_EXP			128
#define	FLT_MIN				scalb(FLT_MIN_EXP-1,1.0)
#define	FLT_MIN_10_EXP		(-37)
#define	FLT_MIN_EXP			(-125)

#define	FLT_RADIX			2
#define	FLT_ROUNDS			((getround()+1) % 4)

#define	LDBL_DIG			19
#define	LDBL_EPSILON		scalb(-63,1.0)
#define	LDBL_MANT_DIG		64
#define	LDBL_MAX			nextextended(inf(),0.0)
#define	LDBL_MAX_10_EXP		4932
#define	LDBL_MAX_EXP		16384
#define	LDBL_MIN			scalb(LDBL_MIN_EXP-1,1.0)
#define	LDBL_MIN_10_EXP		(-4931)
#define	LDBL_MIN_EXP		(-16382)


#endif __FLOAT__
