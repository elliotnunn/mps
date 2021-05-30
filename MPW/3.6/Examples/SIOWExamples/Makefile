#   File:       Makefile
#   Target:     count
#   Sources:    Count.c
#   Modified:    Wednesday, October 2, 1996 03:07:56 PM

MAKEFILE    = Makefile
C			= SC
PPCC		= MrC

•MondoBuild• = {MAKEFILE}  # Make blank to avoid rebuilds when makefile is modified

Includes     =
ObjDir•68K   =
ObjDir•PPC   =

Sym•68K      = -sym on 
Sym•PPC      = -sym on 

COptions     = -proto strict {Includes} {Sym•68K} -model far    # -i "{RINCLUDES}" (if needed to access SIOW.h)
CPlusOptions = {Includes} {Sym•68K} -model far

PPCCOptions  = -proto strict {Includes} {Sym•PPC}               # -i "{RINCLUDES}" (if needed to access SIOW.h)
PPCCPlusOptions = {Includes} {Sym•PPC} 

Count_Objects•68K  = ∂
		"{ObjDir•68K}Count.c.o"

Count_Objects•PPC  = ∂
		"{ObjDir•PPC}Count.c.x"

Demo_Objects•68K  = ∂
		"{ObjDir•68K}SIODemo.c.o" ∂
		"{ObjDir•68K}SIODemoMain.cp.o"

Demo_Objects•PPC  = ∂
		"{ObjDir•PPC}SIODemo.c.x" ∂
		"{ObjDir•PPC}SIODemoMain.cp.x"

All		ƒƒ	Count SIO_Demo

###############################################################################

Count	ƒ	Count.68k   Count.ppc
	Duplicate -y Count.68k {Targ}
	MergeFragment Count.ppc {Targ}
	Rez -a "{RIncludes}"SIOW.r  -d DEFAULT_SAVE_PREF=1 -o {Targ}
	############################################################
	

###############################################################################

Count.68k ƒ {•MondoBuild•} {Count_Objects•68K}
	Link ∂
		-o {Targ} -d {Sym•68K} ∂
		{Count_Objects•68K} ∂
		-t 'APPL' ∂
		-c 'siow' ∂
		-mf ∂
		-model far ∂
		"{CLibraries}StdCLib.o" ∂
		"{Libraries}SIOW.far.o" ∂
		"{Libraries}MacRuntime.o" ∂
		"{Libraries}IntEnv.o" ∂
		"{Libraries}Interface.o" ∂
	#

###############################################################################

Count.ppc	ƒ	{Count_Objects•PPC}
	PPCLink ∂
		-o {Targ} {Sym•PPC} ∂
		{Count_Objects•PPC} ∂
		-t 'APPL' ∂
		-c 'siow' ∂
		-mf ∂
		"{PPCLibraries}PPCSIOW.o" ∂
		"{PPCLibraries}MrCPlusLib.o" ∂
		"{SharedLibraries}InterfaceLib" ∂
		"{SharedLibraries}StdCLib" ∂
		"{SharedLibraries}MathLib" ∂
		"{PPCLibraries}PPCCRuntime.o" ∂
	#

# 		"{PPCLibraries}StdCRuntime.o"  not needed.

###############################################################################

"{ObjDir•PPC}Count.c.x" ƒ {•MondoBuild•} Count.c
	{PPCC} Count.c -o {Targ} {PPCCOptions}

"{ObjDir•68K}Count.c.o" ƒ {•MondoBuild•} Count.c
	{C} Count.c -o {Targ} {COptions}

###############################################################################

SIO_Demo ƒƒ {•MondoBuild•} {Demo_Objects•68K}
	Link ∂
		-o {Targ} -d {Sym•68K} ∂
		{Demo_Objects•68K} ∂
		-t 'APPL' ∂
		-c '????' ∂
		-mf ∂
		-model far ∂
		"{Libraries}SIO.far.o" ∂
		"{CLibraries}CPlusLib.o" ∂
		"{CLibraries}IOStreams.o" ∂
		"{CLibraries}StdCLib.o" ∂
		"{Libraries}MacRuntime.o" ∂
		"{Libraries}IntEnv.o" ∂
		"{Libraries}Interface.o" ∂
	#


SIO_Demo ƒƒ {•MondoBuild•} {Demo_Objects•PPC}
	PPCLink -d ∂
		-o {Targ} {Sym•PPC} ∂
		{Demo_Objects•PPC} ∂
		-t 'APPL' ∂
		-c '????' ∂
		-mf ∂
		"{PPCLibraries}PPCSIO.o" ∂
		"{PPCLibraries}StdCRuntime.o" ∂
		"{PPCLibraries}PPCCRuntime.o" ∂
		"{PPCLibraries}MrCPlusLib.o" ∂
		"{PPCLibraries}MrCIOStreams.o" ∂
		"{SharedLibraries}InterfaceLib" ∂
		"{SharedLibraries}StdCLib" ∂
	#

SIO_Demo ƒƒ {•MondoBuild•} SIODemo.r
	Rez SIODemo.r -o {Targ} {Includes} -append
	##########################################
	

"{ObjDir•PPC}SIODemo.c.x" ƒ {•MondoBuild•} SIODemo.c "SIODemo.h"
	{PPCC} SIODemo.c -o {Targ} {PPCCOptions}

"{ObjDir•PPC}SIODemoMain.cp.x" ƒ {•MondoBuild•} SIODemoMain.cp
	{PPCCPlus} SIODemoMain.cp -o {Targ} {PPCCPlusOptions}


"{ObjDir•68K}SIODemo.c.o" ƒ {•MondoBuild•} SIODemo.c "SIODemo.h"
	{C} SIODemo.c -o {Targ} {COptions}

"{ObjDir•68K}SIODemoMain.cp.o" ƒ {•MondoBuild•} SIODemoMain.cp
	{CPlus} SIODemoMain.cp -o {Targ} {CPlusOptions}

