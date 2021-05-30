#ifndef		TStreamCounter_H
#define		TStreamCounter_H

#include <Stream.h>

struct aCount {
	long	chars;
	long	lines;
};

class TStreamCounter {

  public:

	TStreamCounter(fstream* =0);
		
	void	Reset(fstream* =0);
	void	Count();
	aCount	GetCount() { return fCount; };

  private:
	
	fstream*	fStream;
	aCount		fCount;
};

	
#endif