
#include <StdLib.h>
#include "StreamCounter.h"

static void
error(char* e)
{
	cerr << "### StreamCounter Error: " << e << "\n";
	exit(1);
}

TStreamCounter::TStreamCounter(fstream* fs)
{
	if (fs == 0) fStream = (fstream*) &cin;
	else fStream = fs;
	fCount.chars = fCount.lines = 0;
}

void
TStreamCounter::Reset(fstream* fs)
{
	fStream = fs;
	fCount.chars = fCount.lines = 0;
}

void TStreamCounter::Count()
{
	int c, c1;
	
	while ((c = c1 = fStream->get()) != EOF) {
		fCount.chars++;
		if ( c == '\n' )
			fCount.lines++;
	}
	
	if (fCount.chars > 0 && c1 != '\n')
		fCount.lines++;
}

