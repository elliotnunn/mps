/************************************************************

	Assert.h
	Diagnostics
	
	Copyright © Apple Computer,Inc.  1987-1990, 1994, 1995, 2000.
	All Rights Reserved.

************************************************************/

#undef assert

#ifdef NDEBUG

	#if defined(__MRC__) && (__MRC__ >= 0x500) && __option(global_optimizer)
	
		#define assert(expression) ( (expression) ? (void) 0 : __noreturn() )
		
	#else

		#define assert(ignore) ((void) 0)
	
	#endif

#else

	#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
		#pragma import on
	#endif
	
	#ifdef __cplusplus
		extern "C" {
	#endif

	void __assertprint(const char* file, int line, const char* expr);

	#ifdef __cplusplus
		}
	#endif
	
	#define assert(expression) \
		( (expression) ? (void) 0 : (__assertprint(__FILE__, __LINE__, #expression)) )

	#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
		#pragma import off
	#endif
			
#endif
