#   File:       Makefile
#   Target:     CFM_MachO_CFM
#   Created:    Monday, October 30, 2000 05:02:53 PM


MAKEFILE        = Makefile
•MondoBuild•    = {MAKEFILE}  # Make blank to avoid rebuilds when makefile is modified

ObjDir          = :obj:
Includes        = 

Sym-cbn         = -sym off

PPCCOptions     = {Includes} {Sym-cbn} -proto strict -d TARGET_API_MAC_CARBON


### Source Files ###

SrcFiles        =  ∂
				  CFM_MachO_CFM.c


### Object Files ###

ObjFiles-cbn    =  ∂
				  "{ObjDir}CFM_MachO_CFM.c.y"


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

CFM_MachO_CFM	ƒƒ  {ObjFiles-cbn} {LibFiles-cbn} {•MondoBuild•}
	PPCLink ∂
		-o {Targ} -m main ∂
		{ObjFiles-cbn} ∂
		{LibFiles-cbn} ∂
		{Sym-cbn} ∂
		-mf -d ∂
		-t 'APPL' ∂
		-c '????'

CFM_MachO_CFM  ƒƒ  CFM_MachO_CFM.r Size.r
	Rez {NewerDeps} -o {Targ} -a

### Required Dependencies ###

"{ObjDir}CFM_MachO_CFM.c.y"  ƒ  CFM_MachO_CFM.c


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
		CFM_MachO_CFM

