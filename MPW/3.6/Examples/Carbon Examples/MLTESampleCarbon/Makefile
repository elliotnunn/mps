#   File:       Makefile
#   Target:     MLTESampleCarbon
#   Created:    Monday, October 30, 2000 05:02:53 PM


MAKEFILE        = Makefile
•MondoBuild•    = {MAKEFILE}  # Make blank to avoid rebuilds when makefile is modified

ObjDir          = :obj:
Includes        = 
TypeAndCreator	= -t APPL -c GRIT

Sym-cbn         = -sym off

PPCCOptions     = {Includes} {Sym-cbn} -w 18 -d TARGET_API_MAC_CARBON


### Source Files ###

SrcFiles        =  ∂
				  MLTESampleCarbon.c


### Object Files ###

ObjFiles-cbn    =  ∂
				  "{ObjDir}MLTESampleCarbon.c.y"


### Libraries ###

LibFiles-cbn    =  ∂
				  "{SharedLibraries}CarbonLib" ∂
#				  "{SharedLibraries}StdCLib" ∂
#				  "{SharedLibraries}MathLib" ∂
#				  "{PPCLibraries}StdCRuntime.o" ∂
#				  "{PPCLibraries}PPCCRuntime.o" ∂
#				  "{PPCLibraries}PPCToolLibs.o"


### Default Rules ###

.c.y  ƒ  .c  {•MondoBuild•}
	{PPCCPlus} {depDir}{default}.c -o {targDir}{default}.c.y {PPCCOptions}


### Build Rules ###

MLTESampleCarbon  ƒƒ  {ObjFiles-cbn} {LibFiles-cbn} {•MondoBuild•}
	PPCLink ∂
		-o {Targ} -m main ∂
		{ObjFiles-cbn} ∂
		{LibFiles-cbn} ∂
		{Sym-cbn} ∂
		-mf -d ∂
		{TypeAndCreator}


MLTESampleCarbon  ƒƒ  MLTESampleCarbon.rsrc {•MondoBuild•}
	Echo "Include ∂"MLTESampleCarbon.rsrc∂";" | Rez -o {Targ} -append {TypeAndCreator}

MLTESampleCarbon  ƒƒ  Size.r
	Rez Size.r -o {Targ} -a {TypeAndCreator}

### Required Dependencies ###

"{ObjDir}MLTESampleCarbon.c.y"  ƒ  MLTESampleCarbon.c


### Optional Dependencies ###
### Build this target to generate "include file" dependencies. ###

Dependencies  ƒ  $OutOfDate
	MakeDepend ∂
		-append {MAKEFILE} ∂
		-ignore "{CIncludes}" ∂
		-objdir "{ObjDir}" ∂
		-objext .x ∂
		{Includes} ∂
		{SrcFiles}

Clean		ƒ	$OutOfDate
	Delete -i -y ∂
		{ObjFiles-cbn} ∂
		MLTESampleCarbon

