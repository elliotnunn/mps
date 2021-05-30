#   File:       Makefile
#   Target:     NavSample
#   Created:    Monday, October 30, 2000 05:02:53 PM


MAKEFILE        = Makefile
•MondoBuild•    = {MAKEFILE}  # Make blank to avoid rebuilds when makefile is modified

SrcDir			= :Sources:
ObjDir          = :obj:
Includes        = 
TypeAndCreator	= -t APPL -c ttxt

SymOpt			= -sym off

CommonCOptions	= {Includes} {SymOpt} -proto strict
PPCCOptions     = {CommonCOptions} -i : -prefix ClassicPrefix.h -d ACCESSOR_CALLS_ARE_FUNCTIONS
PPCCCarbonOptions = {CommonCOptions} -d TARGET_API_MAC_CARBON


### Source Files ###

SrcFiles        =  ∂
				"{SrcDir}"Common.c ∂
				"{SrcDir}"document.c ∂
				"{SrcDir}"NavDrag.c ∂
				"{SrcDir}"event.c ∂
				"{SrcDir}"file.c ∂
				"{SrcDir}"menus.c ∂
				"{SrcDir}"Template.c ∂
				"{SrcDir}"Utilities.c ∂
				"{SrcDir}"modern.c ∂
				#

### Object Files ###

ObjFiles-ppc    =  ∂
				"{ObjDir}Common.c.x" ∂
				"{ObjDir}document.c.x" ∂
				"{ObjDir}NavDrag.c.x" ∂
				"{ObjDir}event.c.x" ∂
				"{ObjDir}file.c.x" ∂
				"{ObjDir}menus.c.x" ∂
				"{ObjDir}Template.c.x" ∂
				"{ObjDir}Utilities.c.x" ∂
				"{ObjDir}modern.c.x" ∂
				#
ObjFiles-cbn    =  ∂
				"{ObjDir}Common.c.y" ∂
				"{ObjDir}document.c.y" ∂
				"{ObjDir}NavDrag.c.y" ∂
				"{ObjDir}event.c.y" ∂
				"{ObjDir}file.c.y" ∂
				"{ObjDir}menus.c.y" ∂
				"{ObjDir}Template.c.y" ∂
				"{ObjDir}Utilities.c.y" ∂
				"{ObjDir}modern.c.y" ∂
				#


### Libraries ###

LibFiles-ppc    =  ∂
				  "{SharedLibraries}InterfaceLib" ∂
				  "{SharedLibraries}StdCLib" ∂
				  "{SharedLibraries}MathLib" ∂
				  "{SharedLibraries}ControlsLib" ∂
				  "{SharedLibraries}DragLib" ∂
				  "{SharedLibraries}FoldersLib" ∂
				  "{SharedLibraries}MenusLib" ∂
				  "{SharedLibraries}NavigationLib" ∂
				  "{SharedLibraries}ObjectSupportLib" ∂
				  "{SharedLibraries}WindowsLib" ∂
				  "{SharedLibraries}AppearanceLib" ∂
				  "{PPCLibraries}StdCRuntime.o" ∂
				  "{PPCLibraries}PPCCRuntime.o" ∂
				  "{PPCLibraries}PPCToolLibs.o" ∂
				  "{PPCLibraries}CarbonAccessors.o" ∂
				  #

LibFiles-cbn    =  ∂
				  "{SharedLibraries}CarbonLib" ∂
#				  "{SharedLibraries}StdCLib" ∂
#				  "{SharedLibraries}MathLib" ∂
#				  "{PPCLibraries}StdCRuntime.o" ∂
#				  "{PPCLibraries}PPCCRuntime.o" ∂
#				  "{PPCLibraries}PPCToolLibs.o"


### Default Rules ###

"{ObjDir}"	ƒ	"{SrcDir}"

.c.x  ƒ  .c  {•MondoBuild•}
	{PPCC} {depDir}{default}.c -o {targDir}{default}.c.x {PPCCOptions}

.c.y  ƒ  .c  {•MondoBuild•}
	{PPCC} {depDir}{default}.c -o {targDir}{default}.c.y {PPCCCarbonOptions}

### Build Rules ###

NavSample			ƒƒ	NavSampleCarbon NavSampleClassic

NavSampleClassic	ƒƒ  {ObjFiles-ppc} {LibFiles-ppc} {•MondoBuild•}
	PPCLink ∂
		-o {Targ} ∂
		{ObjFiles-ppc} ∂
		{LibFiles-ppc} ∂
		{SymOpt} ∂
		-mf -d ∂
		{TypeAndCreator}

NavSampleClassic  ƒƒ  "{SrcDir}"NavSample.rsrc {•MondoBuild•}
	Echo "Include ∂"{SrcDir}NavSample.rsrc∂";" | Rez -o {Targ} -append {TypeAndCreator}

NavSampleClassic  ƒƒ  Size.r
	Rez Size.r -o {Targ} -a {TypeAndCreator}

NavSampleCarbon	ƒƒ  {ObjFiles-cbn} {LibFiles-cbn} {•MondoBuild•}
	PPCLink ∂
		-o {Targ} -m main ∂
		{ObjFiles-cbn} ∂
		{LibFiles-cbn} ∂
		{SymOpt} ∂
		-mf -d ∂
		{TypeAndCreator}


NavSampleCarbon  ƒƒ  "{SrcDir}"NavSample.rsrc {•MondoBuild•}
	Echo "Include ∂"{SrcDir}NavSample.rsrc∂";" | Rez -o {Targ} -append {TypeAndCreator}

NavSampleCarbon  ƒƒ  Size.r
	Rez Size.r -o {Targ} -a {TypeAndCreator}

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
		{ObjFiles-ppc} ∂
		{ObjFiles-cbn} ∂
		NavSampleCarbon NavSampleClassic
