#   File:       Makefile
#   Target:     CFM2IORegistry
#   Created:    Monday, October 30, 2000 05:02:53 PM


MAKEFILE        = Makefile
•MondoBuild•    = {MAKEFILE}  # Make blank to avoid rebuilds when makefile is modified

ObjDir          = :obj:
Includes        = 

Sym-cbn         = -sym off

PPCCOptions     = {Includes} {Sym-cbn} -proto strict -d TARGET_API_MAC_CARBON


### Source Files ###

SrcFiles        =  ∂
				  CallIORegistry.c


### Object Files ###

ObjFiles-cbn    =  ∂
				  "{ObjDir}CallIORegistry.c.y"


### Libraries ###

LibFiles-cbn    =  ∂
				  "{SharedLibraries}CarbonLib" ∂
				  "{SharedLibraries}StdCLib" ∂
#				  "{SharedLibraries}MathLib" ∂
#				  "{PPCLibraries}StdCRuntime.o" ∂
				  "{PPCLibraries}PPCCRuntime.o" ∂
#				  "{PPCLibraries}PPCToolLibs.o"


### Default Rules ###

.c.y  ƒ  .c  {•MondoBuild•}
	{PPCC} {depDir}{default}.c -o {targDir}{default}.c.y {PPCCOptions}


### Build Rules ###

CFM2IORegistry	ƒƒ  {ObjFiles-cbn} {LibFiles-cbn} {•MondoBuild•}
	PPCLink ∂
		-o {Targ} -m main ∂
		{ObjFiles-cbn} ∂
		{LibFiles-cbn} ∂
		{Sym-cbn} ∂
		-mf -d ∂
		-t 'APPL' ∂
		-c '????'

CFM2IORegistry  ƒƒ  CallIORegistry.r Size.r
	Rez {NewerDeps} -o {Targ} -a

### Required Dependencies ###

"{ObjDir}CallIORegistry.c.y"  ƒ  CallIORegistry.c


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
		CFM2IORegistry

