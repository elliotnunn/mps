#include <stdio.h>
#include <iostream.h>

// #include <Types.h> /* Debugger() */

extern "C"
{
	int main ( int argc, char* argv[] );
};


// main  **********************************************************

int main ( int argc, char* argv[] )
{
	char	s[256];
	int 	len;

	fprintf( stderr, "main - fprintf(stderr)\n" ); fflush(stderr);
	printf( "main - printf stdout  argc=%d\n", argc );
	for ( int i = 0; i < argc; i++ )
	{
		printf( "main - printf stdout  argv[%d]='%s'\n", i, argv[i] );
	}
	cout << "main - cout" << endl;
	cerr << "main - cerr" << endl;

	printf("main - enter a character: \n"); fflush(stdout);
	fgets( s, 255, stdin ); // fgets leaves newline in the string.
	len = strlen( s );
	if ( len > 1 )
	{
		s[1] = '\0';
	}
	cout << "main - you typed '" << s << "'." << endl;

	printf("main - enter a character: \n"); fflush(stdout);
	fgets( s, 255, stdin ); // fgets leaves newline in the string.
	len = strlen( s );
	if ( len > 1 )
	{
		s[1] = '\0';
	}
	cout << "main - you typed '" << s << "'." << endl;

	printf("main - enter a character: \n"); fflush(stdout);
	fgets( s, 255, stdin ); // fgets leaves newline in the string.
	len = strlen( s );
	if ( len > 1 )
	{
		s[1] = '\0';
	}
	cout << "main - you typed '" << s << "'." << endl;

	printf("main - enter a character: \n"); fflush(stdout);
	fgets( s, 255, stdin ); // fgets leaves newline in the string.
	len = strlen( s );
	if ( len > 1 )
	{
		s[1] = '\0';
	}
	cout << "main - you typed '" << s << "'." << endl;

	for ( int j = 0; j < 50; j++ )
	{
		printf("looping 1 .. 50 .. now at %d\n", j );
	}
	
	printf( "end\n" );
	
	cout.flush();
	cerr.flush();
	return 0;
}
