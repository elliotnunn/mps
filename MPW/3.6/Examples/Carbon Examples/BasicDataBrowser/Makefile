#   File:       Makefile
#   Target:     BasicDataBrowser
#   Created:    Monday, October 30, 2000 05:02:53 PM


MAKEFILE        = Makefile
•MondoBuild•    = {MAKEFILE}  # Make blank to avoid rebuilds when makefile is modified

ObjDir          = :obj:
Includes        = 

Sym-cbn         = -sym off

PPCCOptions     = {Includes} {Sym-cbn} -bool on -d TARGET_API_MAC_CARBON


### Source Files ###

SrcFiles        =  ∂
				  BasicDataBrowser.cp


### Object Files ###

ObjFiles-cbn    =  ∂
				  "{ObjDir}BasicDataBrowser.cp.y"


### Libraries ###

LibFiles-cbn    =  ∂
				  "{SharedLibraries}CarbonLib" ∂
#				  "{SharedLibraries}StdCLib" ∂
#				  "{SharedLibraries}MathLib" ∂
#				  "{PPCLibraries}StdCRuntime.o" ∂
#				  "{PPCLibraries}PPCCRuntime.o" ∂
#				  "{PPCLibraries}PPCToolLibs.o"


### Default Rules ###

:obj:	ƒ	:

.cp.y  ƒ  .cp {•MondoBuild•}
	{PPCCPlus} {depDir}{default}.cp -o {targDir}{default}.cp.y {PPCCOptions}

### Build Rules ###

BasicDataBrowser	ƒƒ  {ObjFiles-cbn} {LibFiles-cbn} {•MondoBuild•}
	PPCLink ∂
		-o {Targ} -m main ∂
		{ObjFiles-cbn} ∂
		{LibFiles-cbn} ∂
		{Sym-cbn} ∂
		-mf -d ∂
		-t 'APPL' ∂
		-c '????'


BasicDataBrowser  ƒƒ  BasicDataBrowser.rsrc {•MondoBuild•}
	Echo "Include ∂"BasicDataBrowser.rsrc∂";" | Rez -o {Targ} -append

BasicDataBrowser  ƒƒ  Size.r
	Rez Size.r -o {Targ} -a

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
		BasicDataBrowser

