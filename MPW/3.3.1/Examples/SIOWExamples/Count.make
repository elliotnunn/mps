#   File:       count.make
#   Target:     count
#   Sources:    Count.c
#   Created:    Monday, September 17, 1990 10:13:20 AM
#	Modified:	Monday, December 20, 1993 15:41:54


SymOpt = -sym off		# set to "-sym Full" to generate a .SYM file
COptions = -r {SymOpt}
PPCC	=	PPCC
PPCCOptions	=	{SymOpt} -AppleExt On

.c.x	ƒ	.c
	{PPCC} {DepDir}{Default}.c -o {TargDir}{Default}.c.x {PPCCOptions}

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
	Link -d -c '????' -t APPL -map >Count.68k.map ∂
		{SymOpt} ∂
		{OBJS} ∂
		#"{CLibraries}"CSANELib.o ∂
		#"{CLibraries}"Math.o ∂
		#"{CLibraries}"Complex.o ∂
		"{CLibraries}"StdClib.o ∂
		"{Libraries}"SIOW.o ∂
		"{Libraries}"Runtime.o ∂
		"{Libraries}"Interface.o ∂
		-o {Targ}

Count.68k ƒƒ "{RIncludes}"SIOW.r
	Rez -a "{Rincludes}"SIOW.r -o {Targ}

###############################################################################

Count.ppc	ƒƒ	Count.xcoff
	makePEF Count.xcoff -o Count.ppc ∂
		-l InterfaceLib.xcoff=InterfaceLib ∂
		-l StdCLib.xcoff=StdCLib ∂
		-ft APPL -fc '????'
	If "{SymOpt}" =~ /≈[NnUu]+≈/
		MakeSYM -w Count.xcoff -o Count.ppc.xSYM
	End

Count.ppc ƒƒ "{RIncludes}"SIOW.r
	Rez -a "{Rincludes}"SIOW.r -o {Targ} -d APPNAME=∂"Count∂"

Count.xcoff	ƒ	{PPCOBJS}
	PPCLink {SymOpt} -dead on -mf -map Count.ppc.map -d ∂
		{PPCOBJS} 	∂
		"{PPCLibraries}"PPCSIOW.o ∂
		"{PPCLibraries}"StdCRuntime.o ∂
		"{PPCLibraries}"InterfaceLib.xcoff ∂
		"{PPCLibraries}"StdCLib.xcoff ∂
		"{PPCLibraries}"PPCCRuntime.o ∂
		-main __start ∂
		-o Count.xcoff

