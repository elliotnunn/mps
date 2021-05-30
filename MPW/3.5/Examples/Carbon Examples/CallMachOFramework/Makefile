#   File:       Makefile
#   Target:     SIOW.app
#   Created:    Monday, December 11, 2000 12:31:28 PM


MAKEFILE        = Makefile
•MondoBuild•    = {MAKEFILE}  # Make blank to avoid rebuilds when makefile is modified

ObjDir          = :obj:
Includes        = -i ":MoreIsBetter Bits:"

Sym-PPC         = -sym on

PPCCOptions     = {Includes} {Sym-PPC} -proto strict


### Source Files ###

SrcFiles        =  ∂
				  CallMachOFramework.c ∂
				  CallMachOFramework.r ∂
				  ":MoreIsBetter Bits:CFMLateImport.c"


### Object Files ###

ObjFiles0-PPC    =  ∂
				  "{ObjDir}"CallMachOFramework.c.y0 ∂
				  "{ObjDir}"CFMLateImport.c.y0


ObjFiles1-PPC    =  ∂
				  "{ObjDir}"CallMachOFramework.c.y1 ∂
				  "{ObjDir}"CFMLateImport.c.y1 ∂
				  "{ObjDir}"MoreInterfaceLib.c.y1


### Libraries ###

LibFiles-PPC    =  ∂
				  ":System Framework Stub:"SystemFrameworkLib ∂
				  "{PPCLibraries}"StdCRuntime.o ∂
				  "{PPCLibraries}"PPCCRuntime.o ∂
				  "{SharedLibraries}"CarbonLib ∂
				  "{SharedLibraries}"StdCLib ∂
				#


### Default Rules ###

:obj:	ƒ	: ":MoreIsBetter Bits:"

.c.y0	ƒ  .c  {•MondoBuild•}
	{PPCC} {depDir}{default}.c -o {targDir}{default}.c.y0 -d USE_CFM_LATE_IMPORT=0 {PPCCOptions}

.c.y1	ƒ  .c  {•MondoBuild•}
	{PPCC} {depDir}{default}.c -o {targDir}{default}.c.y1 -d USE_CFM_LATE_IMPORT=1 {PPCCOptions}


### Build Rules ###

all		ƒƒ	"CallMachOFramework Bundle" "CallMachOFramework Late"

"CallMachOFramework Bundle"  ƒƒ  {ObjFiles0-PPC} {LibFiles-PPC} {•MondoBuild•}
	PPCLink ∂
		-o {Targ} ∂
		{ObjFiles0-PPC} ∂
		{LibFiles-PPC} ∂
		{Sym-PPC} ∂
		-mf -d ∂
		-m main ∂
		-t 'APPL' ∂
		-c '????'


"CallMachOFramework Bundle"  ƒƒ  CallMachOFramework.r {•MondoBuild•}
	Rez CallMachOFramework.r -o {Targ} {Includes} -append

"CallMachOFramework Bundle"  ƒƒ  {•MondoBuild•}
	Echo "Data 'carb' (0) ∂{$∂"00000000∂"∂};" | Rez -o {Targ} -append

"CallMachOFramework Bundle"  ƒƒ  Size.r
	Rez Size.r -o {Targ} -a

##########

"CallMachOFramework Late"  ƒƒ  {ObjFiles1-PPC} {LibFiles-PPC} {•MondoBuild•}
	PPCLink ∂
		-o {Targ} ∂
		{ObjFiles1-PPC} ∂
		{LibFiles-PPC} ∂
		{Sym-PPC} ∂
		-mf -d ∂
		-m main ∂
		-t 'APPL' ∂
		-c '????'


"CallMachOFramework Late"  ƒƒ  CallMachOFramework.r {•MondoBuild•}
	Rez CallMachOFramework.r -o {Targ} {Includes} -append

"CallMachOFramework Late"  ƒƒ  {•MondoBuild•}
	Echo "Data 'carb' (0) ∂{$∂"00000000∂"∂};" | Rez -o {Targ} -append

"CallMachOFramework Late"  ƒƒ  Size.r
	Rez Size.r -o {Targ} -a


clean		ƒƒ	$OutOfDate
	Delete -i -y ∂
		{ObjFiles0-PPC} {ObjFiles1-PPC} ∂
		"CallMachOFramework Late".xcoff "CallMachOFramework Late" ∂
		"CallMachOFramework Bundle".xcoff "CallMachOFramework Bundle" ∂
	#
