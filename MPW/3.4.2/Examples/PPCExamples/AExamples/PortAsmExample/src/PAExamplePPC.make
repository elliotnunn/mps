#-------------------------------------------------------------------------------
#
#	PortAsm Simple Example	By Steven Ellis
#
#	Copyright MicroAPL Ltd 1993/4
#
#	PAExamplePPC.make - Makefile for PPC version of PortAsm example program
#
#-------------------------------------------------------------------------------

#	Directories for the PPC object files and PortAsm's info files

OBJDIR		=	::obj:objPPC:
INFODIR		=	::obj:info:

OFFSETS		=	{INFODIR}PAExample.offsets

PORTASM		=	PortAsm
PAOPT		=	-proj :PPC_only:PAExample.proj -sym68k

#	Options for MrC

COptions	=	-sym on		∂
			-align mac68k	∂
			-w off
					
AOptions	=	-w off -sym man

AObjs		=	{OBJDIR}PAExample.a.o	∂
			{OBJDIR}DoEvents.a.o	∂
			{OBJDIR}MyPolygon.a.o	∂
			{OBJDIR}AboutDlg.a.o	∂
			{OBJDIR}MySound.a.o	∂
			{OBJDIR}VirtualWin.a.o	∂
			{OBJDIR}MyPolygon.c.o

InfoFiles	=	{INFODIR}PAExample.a.info ∂
			{INFODIR}DoEvents.a.info	∂
			{INFODIR}MyPolygon.a.info	∂
			{INFODIR}AboutDlg.a.info	∂
			{INFODIR}MySound.a.info	∂
			{INFODIR}VirtualWin.a.info

RezFiles	=	PAExample.r	∂
			AboutDlg.r	∂
			MySound.r	∂
			:PPC_only:PAcfrg.r

PPCLibs		=	"{SharedLibraries}"MathLib	 ∂
			"{SharedLibraries}"InterfaceLib  ∂
			"{SharedLibraries}"StdCLib

#	define info file directory dependencies
#
{INFODIR}	ƒ	:

{OFFSETS}	ƒ	{InfoFiles}
											
.a.info		ƒ	.a
			{PORTASM} -nocode {PAOPT} {Default}.a

#	define object file directory dependencies
#
{OBJDIR}	ƒ	{OBJDIR} :
					
.a.o		ƒ 	.a.s
			PPCAsm {AOptions} -o {Targ} {DepDir}{Default}.a.s

.a.s		ƒ	.a
			{PORTASM} {PAOPT} {DepDir}{Default}.a

.c.o		ƒ	.c
			MrC {COptions} -o {Targ} {DepDir}{Default}.c

PAExamplePPC	ƒ	{OFFSETS} {AObjs} {RezFiles}
			PPCLink -sym on -dead off -main _PAStart -o {Targ} {AObjs} {PPCLibs}
			Rez -rd -o {Targ} {RezFiles} -append
			
