#   File:       Makefile
#   Target:     count
#   Sources:    Count.c
#   Created:    Monday, September 17, 1990 10:13:20 AM
#	Modified:	Thursday, March 09, 1995 10:00:00 AM


SymOpt 		= -sym off		# set to "-sym Full" to generate a .SYM file
C			= SC
COptions    = -model cfmseg -proto strict -ansi on {SymOpt}

PC			=	MrC
PCOptions	=	{SymOpt} -w 17

.c.x	ƒ	.c
	{PC} {DepDir}{Default}.c -o {TargDir}{Default}.c.x {PPCCOptions}

.c.n.o	ƒ	.c
	{C} {DepDir}{Default}.c -o {TargDir}{Default}.c.n.o {COptions}

###############################################################################

OBJS = Count.c.n.o
PPCOBJS = Count.c.x

###############################################################################

Count	ƒƒ	Count.cfm.68k Count.ppc
	Duplicate -y Count.ppc Count
	echo "include ∂"Count.cfm.68k∂" 'CODE';" | Rez -a -o Count
	If "`Exists Count.ppc.xSYM`"
		Duplicate -y Count.ppc.xSYM Count.xSYM
	End
	If "`Exists Count.cfm.68k.SYM`"
		Duplicate -y Count.cfm.68k.SYM Count.SYM
	End


###############################################################################

Count.cfm.68k	ƒƒ	{OBJS}
	ILink -c 'moda' -t APPL -map > Count.cfm.68k.map -d ∂
		-model cfmseg -mf {SymOpt} ∂
		{OBJS} ∂
		"{CFM68KLibraries}"NuSIOW.o ∂
		"{CFM68KLibraries}"NuMacRuntime.o ∂
		"{SharedLibraries}"StdCLib ∂
		"{SharedLibraries}"InterfaceLib ∂
		-o {Targ}

Count.cfm.68k ƒƒ "{RIncludes}"SIOW.r
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
	If "{SymOpt}" =~ /≈[NnUu]+≈/
		MakeSYM -w Count.ppc.xcoff -o Count.ppc.xSYM
	End

Count.ppc ƒƒ "{RIncludes}"SIOW.r
	Rez -a "{Rincludes}"SIOW.r -o {Targ} -d APPNAME=∂"Count∂"
