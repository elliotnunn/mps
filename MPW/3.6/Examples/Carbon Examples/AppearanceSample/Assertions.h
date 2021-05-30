/*
	File:		Assertions.h

	Contains:	Assertion macros.

	Version:    CarbonLib 1.0.2 SDK

	You may incorporate this sample code into your applications without
	restriction, though the sample code has been provided "AS IS" and the
	responsibility for its operation is 100% yours.  However, what you are
	not permitted to do is to redistribute the source as "Apple Sample Code"
	after having made changes. If you're going to re-distribute the source,
	we require that you make it clear in the source that the code was
	descended from Apple Sample Code, but that you've made changes.

	© 1997-2000 by Apple Computer, Inc. All rights reserved.
*/

#ifndef _ASSERTIONS_
#define _ASSERTIONS_

extern void		AssertMsg( char* msg, char* file, int line );

#ifdef _DEBUG
	#define DECLARE_DEBUG_START		unsigned long	qDebugStart
	#define DECLARE_DEBUG_END		unsigned long	qDebugEnd
	
	#define DEFINE_DEBUG_START( mark ) \
		qDebugStart = mark
	
	#define DEFINE_DEBUG_END( mark )	\
		qDebugEnd = mark
	
	#define CHECK_DEBUG_START( mark )	\
		do { if ( ( qDebugStart != mark ) ) AssertMsg( "Trashed Object", __FILE__, __LINE__); } while( 0 )
	
	#define CHECK_DEBUG_END( mark )	\
		do { if ( ( qDebugEnd != mark ) ) AssertMsg( "Trashed Object", __FILE__, __LINE__); } while( 0 )

	#define DEBUG_MARK_FREE( s, c, n )	memset( s, c, n )
	#define DEBUG_MARK_NEW( s, c, n ) memset( s, c, n )
	#define DEBUG_FREE_CHAR		0xEF
	#define DEBUG_NEW_CHAR		0xED
	#define DEBUG_FREE_SHORT	0xEFEF
	#define DEBUG_NEW_SHORT		0xEDED
	#define DEBUG_FREE_LONG		0xEFEFEFEF
	#define DEBUG_NEW_LONG		0xEDEDEDED
	
#else
	#define DECLARE_DEBUG_START
	#define DECLARE_DEBUG_END
	#define DEFINE_DEBUG_START( mark )	
	#define DEFINE_DEBUG_END( mark )	
	#define CHECK_DEBUG_START( mark )	
	#define CHECK_DEBUG_END( mark )

	#define DEBUG_MARK_FREE( s, c, n )
	#define DEBUG_MARK_NEW( s, c, n )
	#define DEBUG_FREE_CHAR
	#define DEBUG_NEW_CHAR
	#define DEBUG_FREE_SHORT
	#define DEBUG_NEW_SHORT
	#define DEBUG_FREE_LONG
	#define DEBUG_NEW_LONG
#endif



#ifdef _DEBUG
	#define ASSERT( condition )	\
			do { if ( !(condition) )		\
				AssertMsg( "Assertion (" #condition ") failed.", __FILE__, __LINE__ );	\
			} while( 0 )
			
	#define ASSERT_GOTO( condition, label ) 	\
			do { if ( !(condition) )	{		\
					AssertMsg( "Assertion (" #condition ") failed.", __FILE__, __LINE__ );	\
					goto label;	\
				}	\
			} while( 0 )

	#define ASSERT_ACTION( condition, action ) 	\
			do { if ( !(condition) )	{		\
					AssertMsg( "Assertion (" #condition ") failed.", __FILE__, __LINE__ );	\
					action;	\
				 }	\
			} while( 0 )

	#define ASSERT_BOOLEAN( x )		if ( x != true && x != false ) AssertMsg( "Boolean assertion failed.", __FILE__, __LINE__ );

#ifdef __cplusplus
	#define ASSERT_OBJECT( p )				do { if ( (p) == NULL ) \
													AssertMsg( "Null Object.", __FILE__, __LINE__ );	\
												 else				\
												 	(p)->Assert();	\
											} while( 0 )
												
	#define ASSERT_OBJECT_NULL_OK( p )		if ( p ) (p)->Assert()
#endif

	#define ASSERT_SHORT( s )		ASSERT( (s != DEBUG_NEW_SHORT) && (s != DEBUG_FREE_SHORT) )
	#define ASSERT_LONG( l )		ASSERT( (l != DEBUG_NEW_LONG) && (l != DEBUG_FREE_LONG) )
	#define ASSERT_CHAR( c )		ASSERT( (c != DEBUG_NEW_CHAR) && (c != DEBUG_FREE_CHAR) )
	
	#define DEBUG_MESSAGE( m )		DebugStr( c2pstr( ( m ) ) )
	
#else
	#define ASSERT( condition )
	
	#define ASSERT_BOOLEAN( x )
	
	#define ASSERT_GOTO( condition, label ) 	\
			do { if ( !(condition) )	{		\
					goto label;	\
				}	\
			} while( 0 )

	#define ASSERT_ACTION( condition, action ) 	\
			do { if ( !(condition) )	{		\
					action;	\
				 }	\
			} while( 0 )

#ifdef __cplusplus	
	#define ASSERT_OBJECT( p )
	#define ASSERT_OBJECT_NULL_OK( p )
#endif
	
	#define ASSERT_SHORT( s )
	#define ASSERT_LONG( l )
	#define ASSERT_CHAR( c )
	
	#define DEBUG_MESSAGE( m )

#endif


#endif