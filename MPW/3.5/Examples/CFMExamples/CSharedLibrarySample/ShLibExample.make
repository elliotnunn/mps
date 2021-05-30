#   File:       ShLibExample.make
#
#   Builds a fat application and it's shared library.
#

AppName = ShLibExample
MakeFile = {AppName}.make
App_Type = 'APPL'
App_Creator = '????'
App_Objects = Main.c.o
M68KApp_Objects = Main.o
App_Resources = {AppName}.r

LibName = SharedLib
Lib_Type = 'shlb'
Lib_Creator = '????'
Lib_Objects = SharedLib.c.o
M68KLib_Objects = SharedLib.o
Lib_Exports = SharedLib.c.x   # Names of export file produced by PPCC for our library.
Lib_Resources = {LibName}.r

Headers = SharedLib.h

SymOpt  = off
MrCOPT = off

MrC_Options = -sym {SymOpt} -opt {MrCOPT} -w 17
SC_Options   = -model cfmseg -sym {SymOpt} -mbg full -i {cincludes} -i : -w 17

PPCLink_Options = -sym {SymOpt}
ILink_Options =   -sym {SymOpt} -mf -model cfmseg

ILink_Libraries =  "{SharedLibraries}"InterfaceLib  ∂
				   "{SharedLibraries}"StdClib ∂
				   "{CFM68KLibraries}"NuMacRuntime.o
					
PPC_Sys_Libraries = "{SharedLibraries}"InterfaceLib ∂
				    "{SharedLibraries}"StdCLib ∂
				    "{PPCLibraries}"StdCRuntime.o ∂
				    "{PPCLibraries}"PPCCRuntime.o

.c.o ƒ .c {MakeFile}  # An object depends upon it's source. All Objects depend on the Makefile.
	MrC {MrC_Options} {default}.c -o {Targ}

.o ƒ .c {MakeFile}  # An object depends upon it's source. All Objects depend on the Makefile.
	SC {SC_Options} {default}.c -o {Targ}

All ƒ {LibName} {AppName} 

{App_Objects} {Lib_Objects} ƒƒ {Headers}

{AppName}.68k ƒƒ {M68KApp_Objects} {LibName}
	ILink {ILink_Options}  -xm e ∂
		{deps} ∂
		{ILink_Libraries} ∂
		-o {targ}

{AppName}.ppc ƒƒ {App_Objects} {LibName}
	PPCLink ∂
		{deps} ∂
		-o {Targ} ∂
		{PPC_Sys_Libraries}
		
{AppName} ƒ {AppName}.68k {AppName}.ppc {App_Resources} {MakeFile}
	duplicate -y {AppName}.68k {Targ}
	MergeFragment {AppName}.ppc {Targ}
	Rez {App_Resources} -a -o {Targ}
	
# In truth, our application depends upon the external interfaces of our shared lib
# (i.e. the application does not have to be rebuilt every time the library is.  But this
# rule makes life simplier since we need a library with some good external interfaces
# to link our application with.

		
{LibName} ƒ {LibName}.ppc  {LibName}.68k
	delete -i {targ}
	MergeFragment -x {deps} {targ} 
	Rez {Lib_Resources} -a -o {Targ}
	setfile -c {Lib_Creator} -t {Lib_Type} {targ}

{LibName}.ppc ƒ  {Lib_Objects}
	PPCLink {PPCLink_Options} -xm s    # Note option to create shared lib (-xm s). ∂
		    {Lib_Objects} ∂
		    {PPC_Sys_Libraries} ∂
		    -o {Targ}
	MergeFragment -n {LibName} -c -t pwpc -x {targ}  # use MergeFragment to create a library cfrg

{LibName}.68k ƒ  {M68KLib_Objects}
	ILink {ILink_Options} -xm s 		# Note option to create shared lib  ∂
		    {M68KLib_Objects} ∂
		    {ILink_Libraries} ∂
		    -o {Targ}
	MakeFlat {targ} -o {targ}			
	MergeFragment -n {LibName} -c -t m68k -x {targ}  # use MergeFragment to create a library cfrg