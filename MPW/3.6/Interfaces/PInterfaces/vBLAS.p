{
     File:       vBLAS.p
 
     Contains:   Header for the Basic Linear Algebra Subprograms, with Apple extensions.
 
     Version:    Technology: All
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{  ========================================================================================================================== }


{
   =================================================================================================
   Definitions of the Basic Linear Algebra Subprograms (BLAS) as provided by Apple Computer.  At
   present this is a subset of the "legacy" FORTRAN and C interfaces.  Only single precision forms
   are provided, and only the most useful routines.  For example only the general matrix forms are
   provided, not the symmetric, Hermitian, or triangular forms.  A few additional functions, unique
   to Mac OS, have also been provided.  These are clearly documented as Apple extensions.
   Documentation on the BLAS standard, including reference implementations, can be found on the web
   starting from the BLAS FAQ page at these URLs (at least as of August 2000):
        http://www.netlib.org/blas/faq.html
        http://www.netlib.org/blas/blast-forum/blast-forum.html
   =================================================================================================
}


{
   =================================================================================================
   Matrix shape and storage
   ========================
   Keeping the various matrix shape and storage parameters straight can be difficult.  The BLAS
   documentation generally makes a distinction between the concpetual "matrix" and the physical
   "array".  However there are a number of places where this becomes fuzzy because of the overall
   bias towards FORTRAN's column major storage.  The confusion is made worse by style differences
   between the level 2 and level 3 functions.  It is amplified further by the explicit choice of row
   or column major storage in the C interface.
   The storage order does not affect the actual computation that is performed.  That is, it does not
   affect the results other than where they appear in memory.  It does affect the values passed
   for so-called "leading dimension" parameters, such as lda in sgemv.  These are always the major
   stride in storage, allowing operations on rectangular subsets of larger matrices.  For row major
   storage this is the number of columns in the parent matrix, and for column major storage this is
   the number of rows in the parent matrix.
   For the level 2 functions, which deal with only a single matrix, the matrix shape parameters are
   always M and N.  These are the logical shape of the matrix, M rows by N columns.  The transpose
   parameter, such as transA in sgemv, defines whether the regular matrix or its transpose is used
   in the operation.  This affects the implicit length of the input and output vectors.  For example,
   if the regular matrix A is used in sgemv, the input vector X has length N, the number of columns
   of A, and the output vector Y has length M, the number of rows of A.  The length of the input and
   output vectors is not affected by the storage order of the matrix.
   The level 3 functions deal with 2 input matrices and one output matrix, the matrix shape parameters
   are M, N, and K.  The logical shape of the output matrix is always M by N, while K is the common
   dimension of the input matrices.  Like level 2, the transpose parameters, such as transA and transB
   in sgemm, define whether the regular input or its transpose is used in the operation.  However
   unlike level 2, in level 3 the transpose parameters affect the implicit shape of the input matrix.
   Consider sgemm, which computes "C = (alpha * A * B) + (beta * C)", where A and B might be regular
   or transposed.  The logical shape of C is always M rows by N columns.  The physical shape depends
   on the storage order parameter.  Using column major storage the declaration of C (the array) in C
   (the language) would be something like "float C[N][M]".  The logical shape of A without transposition
   is M by K, and B is K by N.  The one storage order parameter affects all three matrices.
   For those readers still wondering about the style differences between level 2 and level 3, they
   involve whether the input or output shapes are explicit.  For level 2, the input matrix shape is
   always M by N.  The input and output vector lengths are implicit and vary according to the
   transpose parameter.  For level 3, the output matrix shape is always M by N.  The input matrix
   shapes are implicit and vary according to the transpose parameters.
   =================================================================================================
}


{  ========================================================================================================================== }


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT vBLAS;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __VBLAS__}
{$SETC __VBLAS__ := 1}

{$I+}
{$SETC vBLASIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}

{$PUSH}
{$ALIGN POWER}
{$LibExport+}


{
   ==========================================================================================================================
   Types and constants
   ===================
}



TYPE
	CBLAS_ORDER 				= SInt32;
CONST
	CblasRowMajor				= 101;
	CblasColMajor				= 102;


TYPE
	CBLAS_TRANSPOSE 			= SInt32;
CONST
	CblasNoTrans				= 111;
	CblasTrans					= 112;
	CblasConjTrans				= 113;


TYPE
	CBLAS_UPLO 					= SInt32;
CONST
	CblasUpper					= 121;
	CblasLower					= 122;


TYPE
	CBLAS_DIAG 					= SInt32;
CONST
	CblasNonUnit				= 131;
	CblasUnit					= 132;


TYPE
	CBLAS_SIDE 					= SInt32;
CONST
	CblasLeft					= 141;
	CblasRight					= 142;


	{
	   ------------------------------------------------------------------------------------------------------------------
	   IsAlignedCount   - True if an integer is positive and a multiple of 4.  Negative strides are considered unaligned.
	   IsAlignedAddr    - True if an address is a multiple of 16.
	}


	{
	   ==========================================================================================================================
	   ==========================================================================================================================
	   Legacy BLAS Functions
	   ==========================================================================================================================
	   ==========================================================================================================================
	}


	{
	   ==========================================================================================================================
	   Level 1 Single Precision Functions
	   ==================================
	}


	{
	 *  cblas_sdot()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in vecLib 1.0.2 and later
	 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION cblas_sdot(N: LONGINT; {CONST}VAR X: Single; incX: LONGINT; {CONST}VAR Y: Single; incY: LONGINT): Single; C;

{
 *  cblas_snrm2()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0.2 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION cblas_snrm2(N: LONGINT; {CONST}VAR X: Single; incX: LONGINT): Single; C;

{
 *  cblas_sasum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0.2 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION cblas_sasum(N: LONGINT; {CONST}VAR X: Single; incX: LONGINT): Single; C;

{
 *  cblas_isamax()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0.2 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION cblas_isamax(N: LONGINT; {CONST}VAR X: Single; incX: LONGINT): LONGINT; C;

{
 *  cblas_sswap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0.2 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE cblas_sswap(N: LONGINT; VAR X: Single; incX: LONGINT; VAR Y: Single; incY: LONGINT); C;

{
 *  cblas_scopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0.2 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE cblas_scopy(N: LONGINT; {CONST}VAR X: Single; incX: LONGINT; VAR Y: Single; incY: LONGINT); C;

{
 *  cblas_saxpy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0.2 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE cblas_saxpy(N: LONGINT; alpha: Single; {CONST}VAR X: Single; incX: LONGINT; VAR Y: Single; incY: LONGINT); C;

{
 *  cblas_srot()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0.2 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE cblas_srot(N: LONGINT; VAR X: Single; incX: LONGINT; VAR Y: Single; incY: LONGINT; c: Single; s: Single); C;

{
 *  cblas_sscal()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0.2 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE cblas_sscal(N: LONGINT; alpha: Single; VAR X: Single; incX: LONGINT); C;


{
   ==========================================================================================================================
   Level 1 Double Precision Functions
   ==================================
}


{  *** TBD *** }


{
   ==========================================================================================================================
   Level 1 Complex Single Precision Functions
   ==========================================
}


{  *** TBD *** }


{
   ==========================================================================================================================
   Level 2 Single Precision Functions
   ==================================
}


{
 *  cblas_sgemv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0.2 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE cblas_sgemv(order: CBLAS_ORDER; transA: CBLAS_TRANSPOSE; M: LONGINT; N: LONGINT; alpha: Single; {CONST}VAR A: Single; lda: LONGINT; {CONST}VAR X: Single; incX: LONGINT; beta: Single; VAR Y: Single; incY: LONGINT); C;


{
   ==========================================================================================================================
   Level 2 Double Precision Functions
   ==================================
}


{  *** TBD *** }


{
   ==========================================================================================================================
   Level 2 Complex Single Precision Functions
   ==========================================
}


{  *** TBD *** }


{
   ==========================================================================================================================
   Level 3 Single Precision Functions
   ==================================
}


{
 *  cblas_sgemm()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0.2 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE cblas_sgemm(order: CBLAS_ORDER; transA: CBLAS_TRANSPOSE; transB: CBLAS_TRANSPOSE; M: LONGINT; N: LONGINT; K: LONGINT; alpha: Single; {CONST}VAR A: Single; lda: LONGINT; {CONST}VAR B: Single; ldb: LONGINT; beta: Single; VAR C: Single; ldc: LONGINT); C;


{
   ==========================================================================================================================
   Level 3 Double Precision Functions
   ==================================
}


{  *** TBD *** }


{
   ==========================================================================================================================
   Level 3 Complex Single Precision Functions
   ==========================================
}


{  *** TBD *** }


{
   ==========================================================================================================================
   ==========================================================================================================================
   Latest Standard BLAS Functions
   ==========================================================================================================================
   ==========================================================================================================================
}


{  *** TBD *** }


{
   ==========================================================================================================================
   ==========================================================================================================================
   Additional Functions from Apple
   ==========================================================================================================================
   ==========================================================================================================================
}


{
   -------------------------------------------------------------------------------------------------
   These routines provide optimized, AltiVec-only support for common small matrix multiplications.
   They do not check for the availability of AltiVec instructions or parameter errors.  They just do
   the multiplication as fast as possible.  Matrices are presumed to use row major storage.  Because
   these are all square, column major matrices can be multiplied by simply reversing the parameters.
}


{
   ==========================================================================================================================
   Error handling
   ==============
}


{
   -------------------------------------------------------------------------------------------------
   The BLAS standard requires that parameter errors be reported and cause the program to terminate.
   The default behavior for the Mac OS implementation of the BLAS is to print a message in English
   to stdout using printf and call exit with EXIT_FAILURE as the status.  If this is adequate, then
   you need do nothing more or worry about error handling.
   The BLAS standard also mentions a function, cblas_xerbla, suggesting that a program provide its
   own implementation to override the default error handling.  This will not work in the shared
   library environment of Mac OS 9.  Instead the Mac OS implementation provides a means to install
   an error handler.  There can only be one active error handler, installing a new one causes any
   previous handler to be forgotten.  Passing a null function pointer installs the default handler.
   The default handler is automatically installed at startup and implements the default behavior
   defined above.
   An error handler may return, it need not abort the program.  If the error handler returns, the
   BLAS routine also returns immediately without performing any processing.  Level 1 functions that
   return a numeric value return zero if the error handler returns.
}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	BLASParamErrorProc = PROCEDURE(funcName: ConstCStringPtr; paramName: ConstCStringPtr; {CONST}VAR paramPos: LONGINT; {CONST}VAR paramValue: LONGINT); C;
{$ELSEC}
	BLASParamErrorProc = ProcPtr;
{$ENDC}

	{
	 *  SetBLASParamErrorProc()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in vecLib 1.0.2 and later
	 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
	 *    Mac OS X:         in version 10.0 or later
	 	}
PROCEDURE SetBLASParamErrorProc(ErrorProc: BLASParamErrorProc); C;


{  ========================================================================================================================== }



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := vBLASIncludes}

{$ENDC} {__VBLAS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
