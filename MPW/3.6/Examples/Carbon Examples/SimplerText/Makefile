#   File:       Makefile
#   Target:     SimplerText
#   Created:    Monday, October 30, 2000 05:02:53 PM


MAKEFILE        = Makefile
•MondoBuild•    = {MAKEFILE}  # Make blank to avoid rebuilds when makefile is modified

ObjDir          = :obj:
Includes        = 

Sym-cbn         = -sym off

PPCCOptions     = {Includes} {Sym-cbn} -bool on -d TARGET_API_MAC_CARBON -prefix SimplerTextPrefix.h


### Source Files ###

SrcFiles        =  ∂
				SimplerText.c ∂
				TTextWindow.cp ∂
				TWindow.cp ∂
				#


### Object Files ###

ObjFiles-cbn    =  ∂
				  "{ObjDir}SimplerText.c.y" ∂
				  "{ObjDir}TTextWindow.cp.y" ∂
				  "{ObjDir}TWindow.cp.y" ∂


### Libraries ###

LibFiles-cbn    =  ∂
				  "{SharedLibraries}CarbonLib" ∂
				  "{SharedLibraries}StdCLib" ∂
#				  "{SharedLibraries}MathLib" ∂
				  "{PPCLibraries}MrCPlusLib.o" ∂
#				  "{PPCLibraries}StdCRuntime.o" ∂
				  "{PPCLibraries}PPCCRuntime.o" ∂
#				  "{PPCLibraries}PPCToolLibs.o"


### Default Rules ###

"{ObjDir}"	ƒ	:

.c.y  ƒ  .c  {•MondoBuild•}
	{PPCCPlus} {depDir}{default}.c -o {targDir}{default}.c.y {PPCCOptions}

.cp.y  ƒ  .cp  {•MondoBuild•}
	{PPCCPlus} {depDir}{default}.cp -o {targDir}{default}.cp.y {PPCCOptions}


### Build Rules ###

SimplerText	ƒƒ  {ObjFiles-cbn} {LibFiles-cbn} {•MondoBuild•}
	PPCLink ∂
		-o {Targ} -m main ∂
		{ObjFiles-cbn} ∂
		{LibFiles-cbn} ∂
		{Sym-cbn} ∂
		-mf -d ∂
		-t 'APPL' ∂
		-c '????'


SimplerText  ƒƒ  SimplerText.r Size.r
	Rez {NewerDeps} -o {Targ} -a

### Optional Dependencies ###
### Build this target to generate "include file" dependencies. ###

Dependencies  ƒ  $OutOfDate
	MakeDepend ∂
		-append {MAKEFILE} ∂
		-ignore "{CIncludes}" ∂
		-objdir "{ObjDir}" ∂
		-objext .y ∂
		{Includes} ∂
		{SrcFiles}

Clean		ƒ	$OutOfDate
	Delete -i -y ∂
		{ObjFiles-cbn} ∂
		SimplerText

