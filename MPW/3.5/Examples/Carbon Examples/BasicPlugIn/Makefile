#   File:       Makefile
#   Target:     BasicPlugIn
#   Created:    Sunday, June 10, 2001 19:23:43


MAKEFILE        = Makefile
•MondoBuild•    = {MAKEFILE}  # Make blank to avoid rebuilds when makefile is modified

ObjDir          = :obj:
Includes        = 

Sym-cbn         = -sym off

PPCCOptions     = {Includes} {Sym-cbn} -proto strict -d TARGET_API_MAC_CARBON


### Source Files ###

SrcFiles        =  ∂
				  PlugIn.c ∂
				  PlugInHost.c


### Object Files ###

ObjFiles-cbn    =  ∂
				  "{ObjDir}PlugInHost.c.y"

ObjFiles-plugin	=  ∂
				  "{ObjDir}PlugIn.c.y"

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

BasicPlugIn		ƒƒ	:Build:FolderStructure PlugInHost PlugIn

:Build:FolderStructure	ƒƒ	{•MondoBuild•}
	for folder in ∂
			':build:' ∂
			':build:PlugInHost:' ∂
			':build:PlugInHost:Contents:' ∂
			':build:PlugInHost:Contents:MacOSClassic:' ∂
			':build:PlugInHost:Contents:PlugIns:' ∂
			':build:PlugInHost:Contents:PlugIns:PlugIn.bundle:' ∂
			':build:PlugInHost:Contents:PlugIns:PlugIn.bundle:Contents:' ∂
			':build:PlugInHost:Contents:PlugIns:PlugIn.bundle:Contents:MacOSClassic:'
		if !"`exists -d -q "{folder}"`"
			NewFolder "{folder}"
		end
	end
	Date >:Build:FolderStructure

PlugInHost  ƒƒ  ':build:PlugInHost:Contents:MacOSClassic:PlugInHost'

':build:PlugInHost:Contents:MacOSClassic:PlugInHost'  ƒƒ  {ObjFiles-cbn} {LibFiles-cbn} {•MondoBuild•}
	PPCLink ∂
		-o {Targ} -m main ∂
		{ObjFiles-cbn} ∂
		{LibFiles-cbn} ∂
		{Sym-cbn} ∂
		-mf -d ∂
		-t 'APPL' ∂
		-c '????'

':build:PlugInHost:Contents:MacOSClassic:PlugInHost'  ƒƒ  PlugInHost.rsrc {•MondoBuild•}
	Echo "Include ∂"PlugInHost.rsrc∂";" | Rez -o {Targ} -append

':build:PlugInHost:Contents:MacOSClassic:PlugInHost'  ƒƒ  Size.r
	Rez Size.r -o {Targ} -a

PlugIn  ƒƒ  ':build:PlugInHost:Contents:PlugIns:PlugIn.bundle:Contents:MacOSClassic:PlugIn' ':build:PlugInHost:Contents:PlugIns:PlugIn.bundle:Contents:Info.plist'

':build:PlugInHost:Contents:PlugIns:PlugIn.bundle:Contents:MacOSClassic:PlugIn'  ƒƒ  {ObjFiles-plugin} {LibFiles-cbn} {•MondoBuild•}
	PPCLink ∂
		-o {Targ} -m MyFactory ∂
		{ObjFiles-plugin} ∂
		{LibFiles-cbn} ∂
		{Sym-cbn} ∂
		-xm sharedlibrary ∂
		-mf -d ∂
		-t 'shlb' ∂
		-c '????'

':build:PlugInHost:Contents:PlugIns:PlugIn.bundle:Contents:Info.plist'	ƒ	Info.plist {•MondoBuild•}
	Duplicate -d -y Info.plist {Targ}
	Setfile -m . {Targ}

### Required Dependencies ###

"{ObjDir}PlugInHost.c.y"  	ƒ  PlugInHost.c
"{ObjDir}PlugIn.c.y"  		ƒ  PlugIn.c


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
		{ObjFiles-plugin} ∂
		:build: FolderStructure
