#   File:       ShLibExample.make
#
#   Builds an application and it's shared library.
#
#   We don't bother trying to build a 68K version since it does not have the
#   CFM shared library functionality.

AppName = ShLibExample
MakeFile = {AppName}.make
App_Type = 'APPL'
App_Creator = '????'
App_Objects = Main.c.o
App_Resources = {AppName}.r

LibName = SharedLib
Lib_Type = 'shlb'
Lib_Creator = '????'
Lib_Objects = SharedLib.c.o
Lib_Exports = SharedLib.c.x   # Names of export file produced by PPCC for our library.
Lib_Resources = {LibName}.r

Headers = SharedLib.h

SymOpt  = off
PPCCOpt = off

# The '-shared_lib_export on' compiler option causes local function calls to go through
# the TOC like external calls so that if the library is later updated, the local functions
# can be updated.
#
# In addition, the '-shared_lib_export on' option causes the compiler to generate a list of
# all of the exports in the object produced.  In real shared libraries this list would
# most likely be maintained manually since one would rarely want to export everything
# in a library.  Here, we create this list of exports even for our application (Main.c.x)
# even though we will not use it in our link step.
#
# 

PPCC_Options = -w conformance -appleext on -sym {SymOpt} -opt {PPCCOpt} -shared_lib_export on 
PPCLink_Options = -sym {SymOpt}
PPC_Sys_Libraries = "{PPCLibraries}"InterfaceLib.xcoff ∂
				    "{PPCLibraries}"MathLib.xcoff ∂
				    "{PPCLibraries}"StdCLib.xcoff ∂
				    "{PPCLibraries}"StdCRuntime.o ∂
				    "{PPCLibraries}"PPCCRuntime.o
					
PPC_Lib_Equates = -l InterfaceLib.xcoff=InterfaceLib ∂
				  -l MathLib.xcoff=MathLib ∂
				  -l StdCLib.xcoff=StdCLib ∂
				  -l SharedLib.xcoff=SharedLib 


.c.o ƒ .c {MakeFile}  # An object depends upon it's source. All Objects depend on the Makefile.
	 PPCC {PPCC_Options} {default}.c -o {Targ}


All ƒ {AppName} {LibName}

{AppName} ƒƒ {AppName}.xcoff
	MakePEF {AppName}.xcoff -o {Targ} ∂
	        {PPC_Lib_Equates} ∂
		    -ft {App_Type} -fc {App_Creator}

{AppName} ƒƒ {App_Resources} {MakeFile}
	Rez {App_Resources} -a -o {Targ}
	
# In truth, our application depends upon the external interfaces of our shared lib
# (i.e. the application does not have to be rebuilt every time the library is.  But this
# rule makes life simplier since we need a library with some good external interfaces
# to link our application with.

{AppName}.xcoff ƒ  {App_Objects} {LibName}.xcoff
	PPCLink {PPCLink_Options} ∂
		    {Deps} ∂
		    {PPC_Sys_Libraries} ∂
		    -o {Targ}
	If "{SymOpt}" =~ /[oO][nN]/
   	   MakeSYM {Targ}
	End
		

{LibName} ƒƒ {LibName}.xcoff
	MakePEF {Deps} -o {Targ} ∂
	        {PPC_Lib_Equates} ∂
		    -ft {Lib_Type} -fc {Lib_Creator}

{LibName} ƒƒ {Lib_Resources} {MakeFile}
	Rez {Lib_Resources} -a -o {Targ}

{LibName}.xcoff ƒ  {Lib_Objects}
	PPCLink {PPCLink_Options} -xm s    # Note option to create shared lib (-xm s). ∂
			-export `ConvertExportList {Lib_Exports}` ∂
		    {Lib_Objects} ∂
		    {PPC_Sys_Libraries} ∂
		    -o {Targ}
	If "{SymOpt}" =~ /[oO][nN]/
   	   MakeSYM {Targ}
	End

{App_Objects} {Lib_Objects} ƒƒ {Headers}