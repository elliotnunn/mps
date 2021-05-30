#   File:       Makefile
#   Target:     count
#   Sources:    Count.c
#   Created:    Monday, September 17, 1990 10:13:20 AM
#	Modified:	Thursday, March 09, 1995 10:00:00 AM


SymOpt 		= -sym off		# set to "-sym Full" to generate a .SYM file
C			= SC
COptions    = -proto strict {SymOpt} -w 17
PC			= MrC
PCCOptions	= {SymOpt}

.c.x	ƒ	.c
	{PC} {DepDir}{Default}.c -o {TargDir}{Default}.c.x {PPCCOptions}

.c.o	ƒ	.c
	{C} {DepDir}{Default}.c -o {TargDir}{Default}.c.o {COptions}

###############################################################################

OBJS = Count.c.o
PPCOBJS = Count.c.x

###############################################################################

Count	ƒƒ	Count.68k Count.ppc
	Duplicate -y Count.ppc Count
	echo "include ∂"Count.68k∂" 'CODE';" | Rez -a -o Count
	If "`Exists Count.ppc.xSYM`"
		Duplicate -y Count.ppc.xSYM Count.xSYM
	End
	If "`Exists Count.68k.SYM`"
		Duplicate -y Count.68k.SYM Count.SYM
	End


###############################################################################

Count.68k ƒƒ {OBJS}
	Link -d -c '????' -t APPL -map > Count.68k.map ∂
		{SymOpt} ∂
		{OBJS} ∂
		"{CLibraries}"StdCLib.o ∂
		"{Libraries}"SIOW.o ∂
		"{Libraries}"IntEnv.o ∂
		"{Libraries}"MacRuntime.o ∂
		"{Libraries}"Interface.o ∂
		-o {Targ}

Count.68k ƒƒ "{RIncludes}"SIOW.r
	Rez -a "{Rincludes}"SIOW.r -o {Targ}

###############################################################################

Count.ppc	ƒƒ	{PPCOBJS}
	PPCLink {SymOpt} -dead on -mf -map Count.ppc.map ∂
		{PPCOBJS} 	∂
		"{PPCLibraries}"PPCSIOW.o ∂
		"{PPCLibraries}"PPCCRuntime.o ∂
		"{SharedLibraries}"InterfaceLib ∂
		"{SharedLibraries}"StdCLib ∂
		-t APPL -c '????' ∂
		-o Count.ppc

Count.ppc ƒƒ "{RIncludes}"SIOW.r
	Rez -a "{Rincludes}"SIOW.r -o {Targ} -d APPNAME=∂"Count∂"
