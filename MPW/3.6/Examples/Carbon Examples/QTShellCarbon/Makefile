#   File:       Makefile
#   Target:     QTShellCarbon
#   Created:    Monday, October 30, 2000 05:02:53 PM


MAKEFILE        = Makefile
•MondoBuild•    = {MAKEFILE}  # Make blank to avoid rebuilds when makefile is modified

ObjDir          = :obj:
Includes        = -i ":Application Files:" -i ":Common Files:"
TypeAndCreator	= -t 'APPL' -c 'QTsh'

Sym-cbn         = -sym off

PPCCOptions     = {Includes} {Sym-cbn} ∂
					-prefix MacPrefix.h ∂
					-d TARGET_API_MAC_CARBON=1 ∂
					-d PASCAL_RTN="pascal" ∂
					-d SOUNDSPROCKET_AVAIL=1

### Source Files ###

SrcFiles        =  ∂
				ComApplication.c ∂
				ComFramework.c ∂
				MacFramework.c ∂
				QTUtilities.c ∂
				#

### Object Files ###

ObjFiles-cbn    =  ∂
				  "{ObjDir}ComApplication.c.y" ∂
				  "{ObjDir}ComFramework.c.y" ∂
				  "{ObjDir}MacFramework.c.y" ∂
				  "{ObjDir}QTUtilities.c.y" ∂
				  #

### Libraries ###

LibFiles-cbn    =  ∂
				  "{SharedLibraries}CarbonLib" ∂
				  "{SharedLibraries}StdCLib" ∂
#				  "{SharedLibraries}MathLib" ∂
#				  "{PPCLibraries}StdCRuntime.o" ∂
#				  "{PPCLibraries}PPCCRuntime.o" ∂
#				  "{PPCLibraries}PPCToolLibs.o"


### Default Rules ###

:obj:	ƒ	":Application Files:" ":Common Files:"

.c.y  ƒ  .c  {•MondoBuild•}
	{PPCC} {depDir}{default}.c -o {targDir}{default}.c.y {PPCCOptions}


### Build Rules ###

QTShellCarbon	ƒƒ  {ObjFiles-cbn} {LibFiles-cbn} {•MondoBuild•}
	PPCLink ∂
		-o {Targ} -m main ∂
		{ObjFiles-cbn} ∂
		{LibFiles-cbn} ∂
		{Sym-cbn} ∂
		-mf -d ∂
		{TypeAndCreator}

QTShellCarbon  ƒƒ ":Application Files:MacApplication.rsrc" {•MondoBuild•}
	Echo "Include ∂":Application Files:MacApplication.rsrc∂";" | Rez -o {Targ} -append {TypeAndCreator}

QTShellCarbon  ƒƒ ":Common Files:MacFramework.rsrc" {•MondoBuild•}
	Echo "Include ∂":Common Files:MacFramework.rsrc∂";" | Rez -o {Targ} -append {TypeAndCreator}

QTShellCarbon  ƒƒ  Size.r
	Rez Size.r -o {Targ} -a {TypeAndCreator}

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
		QTShellCarbon

