#include <CursorCtl.h>
#include <ErrMgr.h>
#include <FCntl.h>
#include <String.h>
#include <Stream.h>
#include <StdLib.h>

#include "StreamCounter.h"

const int BUFSIZE = 1024;

extern "C" { int tolower(int); }

class TCountTool {

  public:
	TCountTool();

	short Control(int*, char* []);
	
  private:

	enum mode { both =0, charsOnly =1, linesOnly =2 };
	
	mode	fState;
	aCount	fTotal;
	long	fPad;

	short	Parse(int*, char* []);
	void	Print(aCount, char* =0);
};
	

static void
error(char* e)
{
	cerr << "### CountTool Error: " << e << "\n";
	exit(1);
}

TCountTool::TCountTool()
{
	fState = both;
	fTotal.lines = fTotal.chars = 0;
	fPad = 5; // 5 = strlen("Total");
}

short
TCountTool::Parse(int* c, char* v[])
{
	int fc = 0;
	
	for (int p = 1; p < *c; p++) {
		long	length = strlen(v[p]);

		if (*v[p] == '-')
			if (tolower(*(v[p]+1)) == 'c' && length == 2)
				fState = charsOnly;
			else
				if (tolower(*(v[p]+1)) == 'l' && length == 2)
					fState = linesOnly;
				else {
					cerr << "### Count - \"" << v[p] << "\" is not an option.\n";
					cerr << "# Usage - Count [-l] [-c] [files …].\n";
					return 2;
				}
		else {
			if (fPad < length) fPad = length;
			v[fc++] = v[p];
		}
	}
	*c = fc;
	return 0;
}


void
TCountTool::Print(aCount c, char* fn)
{
	long	p = 0;
	
	if (fn != 0) {
		cout << fn;
		p = fPad - strlen(fn);
	} 
	if (fState != charsOnly) {
		cout << form("%*d", p+5, c.lines);
		p = 0;
	}
	if (fState != linesOnly)
		cout << form("%*d", p+7, c.chars);

	cout << "\n";
	cout.flush();
}


short
TCountTool::Control(int* ac, char* av[])
{
	InitCursorCtl(0);

	if (Parse(ac, av) != 0)		//  parse error (bad argument)
		return 2;

	if (*ac == 0) {				//	no parameters - count stdin
		TStreamCounter theCounter;

		SpinCursor(16);
		theCounter.Count();
		aCount	counts = theCounter.GetCount();
		Print(counts);
	} else {					//	count file parameters
		short dirty = 0;
		short tc = 0;
		fstream *fs = 0;
		char buffer[BUFSIZE *8];
		
		for (int i = 0; i < *ac; i++)  {
			int fd = open(av[i], O_RDONLY);
			
			if (fd != EOF) {
				if (!(fs = new fstream(fd, buffer, BUFSIZE *8))) {
					error("No Free store available.");
					dirty++;
				} else {
					TStreamCounter theCounter(fs);
					SpinCursor(16);
					theCounter.Count();
					aCount counts = theCounter.GetCount();
					if (*ac == 1)
						Print(counts);
					else {
						Print(counts, av[i]);
						fTotal.chars += counts.chars;
						fTotal.lines += counts.lines;
						tc++;
					}
					delete fs;
				}
				
				close(fd);
			} else {
				cerr << "### Count - Unable to open file " << av[i] << ".\n";
				extern short MacOSErr;
				char buf[256];
				cerr << "# "<< GetSysErrText(MacOSErr, buf) << ".\n";
				dirty++;
			}
		}
		
		if (tc > 1)	Print(fTotal, "Total");
	
		if (dirty) return 2;
	
	}
	return 0;
}


int
main(int argc, char* argv[])
{
	TCountTool myCounter;
	
	return myCounter.Control(&argc, argv);
}