/*******************************************************************************
*                                                                              *
*      File fenv.h - PowerPC 601 version,                                      *
*                                                                              *
*      A collection of functions designed to provide access to the floating    *
*      point environment for numerical programming. It is modeled after the    *
*      Numerical C Extensions Group’s requirements ( NCEG / X3J11.1 ).         *
*                                                                              *
*      The file <fenv.h> declares many functions in support of numerical       *
*      programming.  It provides a set of environmental controls similar to    *
*      the ones found in <SANE.h>.  Programs that test flags or run under      *
*      non-default modes must do so under the effect of an enabling            *
*      "fenv_access" pragma.                                                   *
*                                                                              *
*      Copyright © 1992 Apple Computer, Inc.  All rights reserved.             *
*                                                                              *
*      Written by Ali Sazegari, started on October 1992.                       *
*                                                                              *
*      CHANGE LOG (most recent changes first)                                  *
*                                                                              *
*      23 Aug 93      ali      included C++ extern "C" wrappers to make        *
*                              them C++ friendly.                              *
*      08 Apr 93      ali      changed "enums" to "macros" to be more          *
*                              compatible with the FPCE of NCEG.               *
*      05 Feb 93      JPO      Changed function types of feclearexcept,        *
*                              fegetexcept, feraiseexcept, and fesetexcept     *
*                              from int to void to reflect changes in NCEG     *
*                              specification.  Changed definition of           *
*                              FE_DFL_ENV from typedef to #define.  Modified   *
*                              comments describing functionality.              *
*                                                                              *
*******************************************************************************/

#ifndef __FENV__
#define __FENV__

/*    The typedef fenv_t is a type for representing the entire floating-point
      environment in a single object.                                         */

typedef      long int      fenv_t;

/*    The typedef fexcept_t is a type for representing the floating-point
      exception flag state collectively.                                      */

typedef      long int      fexcept_t;

/*    Definitions of floating-point exception macros                          */

#define      FE_INEXACT         0x02000000       /*      inexact              */
#define      FE_DIVBYZERO       0x04000000       /*      divide-by-zero       */
#define      FE_UNDERFLOW       0x08000000       /*      underflow            */
#define      FE_OVERFLOW        0x10000000       /*      overflow             */
#define      FE_INVALID         0x20000000       /*      invlalid             */

/*    The bitwise OR of all exception macros                                  */

#define      FE_ALL_EXCEPT      ( FE_INEXACT | FE_DIVBYZERO | FE_UNDERFLOW | FE_OVERFLOW | FE_INVALID )

/*    Definitions of rounding direction macros                                */

#define      FE_TONEAREST       0x00000000 
#define      FE_TOWARDZERO      0x00000001 
#define      FE_UPWARD          0x00000002 
#define      FE_DOWNWARD        0x00000003

/*    Definition of pointer to IEEE default environment object                */

extern fenv_t _FE_DFL_ENV;               /* default environment object        */
#define FE_DFL_ENV &_FE_DFL_ENV          /* pointer to default environment    */


#ifdef __cplusplus
extern "C" {
#endif

/*******************************************************************************
*     The following functions provide access to the exception flags.  The      *
*     "int" input argument can be constructed by bitwise ORs of the exception  *
*     macros: for example: FE_OVERFLOW | FE_INEXACT.                           *
*******************************************************************************/

/*    The function "feclearexcept" clears the supported exceptions represented
      by its argument.                                                        */

void feclearexcept ( int excepts );



/*    The function "fegetexcept" stores a representation of the exception
      flags indicated by the argument "excepts" through the pointer argument
      "flagp".                                                                */

void fegetexcept ( fexcept_t *flagp, int excepts );



/*    The function "feraiseexcept" raises the supported exceptions
      represented by its argument.                                            */

void feraiseexcept ( int excepts );



/*    The function "fesetexcept" sets or clears the exception flags indicated
      by the int argument "excepts" according to the representation in the
      object pointed to by the pointer argument "flagp".  The value of
      "*flagp" must have been set by a previous call to "fegetexcept".
      This function does not raise exceptions; it just sets the state of
      the flags.                                                              */

void fesetexcept ( const fexcept_t *flagp, int excepts );



/*    The function "fetestexcept" determines which of the specified subset of
      the exception flags are currently set.  The argument "excepts" specifies
      the exception flags to be queried as a bitwise OR of the exception
      macros.  This function returns the bitwise OR of the exception macros
      corresponding to the currently set exceptions included in "excepts".    */

int fetestexcept ( int excepts );



/*******************************************************************************
*     The following functions provide control of rounding direction modes.     *
*******************************************************************************/

/*    The function "fegetround" returns the value of the rounding direction
      macro which represents the current rounding direction.                  */

int fegetround ( void );



/*    The function "fesetround" establishes the rounding direction represented
      by its argument.  It returns nonzero if and only if the argument matches
      a rounding direction macro.  If not, the rounding direction is not
      changed.                                                                */

int fesetround ( int round );



/*******************************************************************************
*    The following functions manage the floating-point environment, exception  *
*    flags and dynamic modes, as one entity.                                   *
*******************************************************************************/

/*    The function "fegetenv" stores the current floating-point environment
      in the object pointed to by its pointer argument "envp".                */

void fegetenv ( fenv_t *envp );



/*    The function "feholdexcept" saves the current environment in the object
      pointed to by its pointer argument "envp", clears the exception flags,
      and clears floating-point exception enables.  This function supersedes
      the SANE function "procentry", but it does not change the current
      rounding direction mode.                                                */

int feholdexcept ( fenv_t *envp );



/*    The function "fesetenv" installs the floating-point environment 
      environment represented by the object pointed to by its argument
      "envp".  The value of "*envp" must be set by a call to "fegetenv" or
      "feholdexcept", by an implementation-defined macro of type "fenv_t",
      or by the use of the pointer macro FE_DFL_ENV as the argument.          */

void fesetenv ( const fenv_t *envp );



/*    The function "feupdateenv" saves the current exceptions into its
      automatic storage, installs the environment represented through its
      pointer argument "envp", and then re-raises the saved exceptions.
      This function, which supersedes the SANE function "procexit", can be
      used in conjunction with "feholdexcept" to write routines which hide
      spurious exceptions from their callers.                                 */
      
void feupdateenv ( const fenv_t * envp );

#ifdef __cplusplus
}
#endif


#endif
