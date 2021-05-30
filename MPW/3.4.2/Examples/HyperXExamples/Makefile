#
# Makefile for HyperCard XCMD examples
#
# This makefile is used to build the examples:
#	LittleDialog
#	Reduce
#
# in each individual source code language.
#
# To use, simply type:
#	Make [AExamples | CExamples | PExamples]
#
# on the command line, then press the Enter key.
#

# destination of XCMD or XFCN
Dest		=	"HyperXExample Stack"


# controls MacsBug symbols
Debug		=	-mbg off


# Standard libraries required for XCMDs and XFCNs
Libs		=	"{Libraries}"HyperXLib.o "{Libraries}"Interface.o


# Language-specific libraries required
aLLibs		=	
cLLibs		=	"{CLibraries}"StdCLib.o "{Libraries}"Runtime.o
pLLibs		=	"{PLibraries}"Paslib.o


# Command line options to supply to the compiler
AOptions	=	-w
COptions	=	-b
POptions	=	


# Linker options
LOpts		=	-w -m ENTRYPOINT


# Resource IDs
XFCNSpec	=	12
XCMDSpec	=	10002

#
# Main dependency rules
#
AExamples		ƒƒ	aLittleDialog aReduce

CExamples		ƒƒ	cLittleDialog cReduce

PExamples		ƒƒ	pLittleDialog pReduce

aLittleDialog	ƒ	:AExamples:LittleDialog

aReduce			ƒ	:AExamples:Reduce

cLittleDialog	ƒ	:CExamples:LittleDialog

cReduce			ƒ	:CExamples:Reduce

pLittleDialog	ƒ	:PExamples:LittleDialog

pReduce			ƒ	:PExamples:Reduce

#
# directory dependency rules
#
:AExamples:		ƒ	:AExamples:

:CExamples:		ƒ	:CExamples:

:PExamples:		ƒ	:PExamples:

#
# Dependency rules for AExamples
#
:AExamples:LittleDialog	ƒƒ	:AExamples:LittleDialog.a.o
	Link {LOpts} -rt XCMD={XCMDSpec} -sg LittleDialog -o {Dest} ∂
		:AExamples:LittleDialog.a.o {Libs} {aLLibs}

:AExamples:LittleDialog	ƒƒ	LittleDialog.r
	Rez LittleDialog.r -o {Dest} -append

:AExamples:LittleDialog	ƒƒ	:AExamples:LittleDialog.a LittleDialog.r
	date >> :AExamples:LittleDialog

:AExamples:Reduce		ƒƒ	:AExamples:Reduce.a.o
	Link {LOpts} -rt XFCN={XFCNSpec} -sg Reduce -o {Dest} ∂
		:AExamples:Reduce.a.o {Libs} {LLibs}
	date >> :AExamples:Reduce

#
# Dependency rules for CExamples
#
:CExamples:LittleDialog	ƒƒ	:CExamples:LittleDialog.c.o
	Link {LOpts} -rt XCMD={XCMDSpec} -sg LittleDialog -o {Dest} ∂
		:CExamples:LittleDialog.c.o {Libs} {cLLibs}

:CExamples:LittleDialog	ƒƒ	LittleDialog.r
	Rez LittleDialog.r -o {Dest} -append

:CExamples:LittleDialog	ƒƒ	:CExamples:LittleDialog.c LittleDialog.r
	date >> :CExamples:LittleDialog

:CExamples:Reduce			ƒƒ	:CExamples:Reduce.c.o
	Link {LOpts} -rt XFCN={XFCNSpec} -sg Reduce -o {Dest} ∂
		:CExamples:Reduce.c.o {Libs} {cLLibs}
	date >> :CExamples:Reduce

#
# Dependency rules for PExamples
#
:PExamples:LittleDialog	ƒƒ	:PExamples:LittleDialog.p.o
	Link {LOpts} -rt XCMD={XCMDSpec} -sg LittleDialog -o {Dest} ∂
		:PExamples:LittleDialog.p.o {Libs} {pLLibs}

:PExamples:LittleDialog	ƒƒ	LittleDialog.r
	Rez LittleDialog.r -o {Dest} -append

:PExamples:LittleDialog	ƒƒ	:PExamples:LittleDialog.p LittleDialog.r
	date >> :PExamples:LittleDialog

:PExamples:Reduce		ƒƒ	:PExamples:Reduce.p.o
	Link {LOpts} -rt XFCN={XFCNSpec} -sg Reduce -o {Dest} ∂
		:PExamples:Reduce.p.o {Libs} {pLLibs}
	date >> :PExamples:Reduce
