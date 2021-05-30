#######################################################################
#
# Makefile used to build ROM Maps
#
# Copyright © 1993, Apple Computer, Inc., All rights reserved
#
# Written by Greg Branche
#
# This makefile can be used to build a specific ROM Map for use
# with the PerformReport tool.  To build a ROM map for the current
# machine (the one you're running Make on), use the following line:
#
#	Make "Mac`gestalt mach -s`ROM.map"
#
# This will generate the necessary commands to build the map file
# from the correct .lst file (found in ROM.List).
#
# To build all of the current ROM maps, use one of the following
# command lines:
#
#	Make all
#
# or
#
#	Make ROM.Maps
#
# To receive a progress report as the maps are being built,
# substitue 'BuildProgram' for 'Make' in the above command lines.
#
#######################################################################

doFilter = ∂
	Duplicate -y -r "{Deps}" "{Targ}"; ∂
	FilterRomMap "ROM`(evaluate "{Targ}" =~ /≈Mac(≈)®1ROM.map/) ∑dev:null; echo {®1}`" <"{Deps}" >"{Targ}"

1986	=	∂
	MacPlusROM.map

1987	=	∂
	MacSEROM.map ∂
	MacIIROM.map

1988	=	∂
	MacIIxROM.map

1989	=	∂
	MacSE030ROM.map ∂
	MacIIcxROM.map ∂
	MacIIciROM.map ∂
	MacPortableROM.map

1990	=	∂
	MacIIfxROM.map ∂
	MacClassicROM.map ∂
	MacIIsiROM.map ∂
	MacLCROM.map

1991	=	∂
	MacClassicIIROM.map ∂
	MacQuadra700ROM.map ∂
	MacQuadra900ROM.map ∂
	MacPowerBook100ROM.map ∂
	MacPowerBook140ROM.map ∂
	MacPowerBook170ROM.map

1992	=	∂
	MacLCIIROM.map ∂
	MacQuadra950ROM.map ∂
	MacPowerBook145ROM.map ∂
	MacPerforma200ROM.map ∂
	MacPerforma400ROM.map ∂
	MacPerforma600ROM.map ∂
	MacPowerBook160ROM.map ∂
	MacPowerBook180ROM.map ∂
	MacPowerBookDuo210ROM.map ∂
	MacPowerBookDuo230ROM.map ∂
	MacIIViROM.map ∂
	MacIIVmROM.map ∂
	MacIIVxROM.map

1993	=	∂
	MacPowerBook165cROM.map ∂
	MacLCIIIROM.map ∂
	MacColorClassicROM.map ∂
	MacCentris610ROM.map ∂
	MacCentris650ROM.map ∂
	MacQuadra800ROM.map ∂
	MacWorkgroupServer60ROM.map ∂
	MacWorkgroupServer80ROM.map ∂
	MacWorkgroupServer95ROM.map ∂
	MacPerforma405ROM.map ∂
	MacPerforma430ROM.map ∂
	MacPerforma450ROM.map ∂
	MacPowerBook145bROM.map ∂
	MacPowerBook180cROM.map ∂
	MacLC520ROM.map ∂
	MacCentris660AVROM.map ∂
	MacQuadra840AVROM.map ∂
	MacPowerBook165ROM.map ∂
	MacPerforma410ROM.map ∂
	MacPerforma460ROM.map ∂
	MacPerforma466ROM.map ∂
	MacPerforma467ROM.map ∂
	MacPerforma475ROM.map ∂
	MacPerforma476ROM.map ∂
	MacPerforma550ROM.map ∂
	MacLC475ROM.map ∂
	MacQuadra605ROM.map ∂
	MacQuadra610ROM.map ∂
	MacQuadra650ROM.map ∂
	MacPowerBookDuo250ROM.map ∂
	MacPowerBookDuo270cROM.map ∂
	MacQuadra660AVROM.map


All			ƒƒ	ROM.Maps

ROM.Maps	ƒƒ	∂
	{1986}		∂
	{1987}		∂
	{1988}		∂
	{1989}		∂
	{1990}		∂
	{1991}		∂
	{1992}		∂
	{1993}		∂

#-------------------------------------------------------------------------------------------------#
MacCentris660AVROM.map		∂
MacQuadra660AVROM.map		∂
MacQuadra840AVROM.map		∂
							ƒ	:ROM.List:AVROM.lst
	{doFilter}

MacClassicIIROM.map			∂
							ƒ	:ROM.List:ClassicIIROM.lst
	{doFilter}

MacClassicROM.map			∂
MacPerforma200ROM.map		∂
							ƒ	:ROM.List:ClassicROM.lst
	{doFilter}

MacColorClassicROM.map		∂
							ƒ	:ROM.List:ColorClassicROM.lst
	{doFilter}

MacPowerBookDuo210ROM.map	∂
MacPowerBookDuo230ROM.map	∂
MacPowerBookDuo250ROM.map	∂
							ƒ	:ROM.List:Duo210ROM.lst
	{doFilter}

MacPowerBookDuo270cROM.map	∂
							ƒ	:ROM.List:Duo270cROM.lst
	{doFilter}

MacLC520ROM.map				∂
MacPerforma550ROM.map		∂
							ƒ	:ROM.List:LC520ROM.lst
	{doFilter}

MacIIciROM.map				∂
							ƒ	:ROM.List:MacIIciROM.lst
	{doFilter}

MacIIfxROM.map				∂
							ƒ	:ROM.List:MacIIfxROM.lst
	{doFilter}

MacIIROM.map				∂
MacIIxROM.map				∂
MacSE030ROM.map				∂
MacIIcxROM.map				∂
							ƒ	:ROM.List:MacIIROM.lst
	{doFilter} 78

MacIIsiROM.map				∂
							ƒ	:ROM.List:MacIIsiROM.lst
	{doFilter}

MacIIViROM.map				∂
MacIIVmROM.map				∂
MacIIVxROM.map				∂
MacPerforma600ROM.map		∂
							ƒ	:ROM.List:MacIIviROM.lst
	{doFilter}

MacLCIIIROM.map				∂
MacPerforma400ROM.map 		∂
MacPerforma405ROM.map 		∂
MacPerforma410ROM.map 		∂
MacPerforma430ROM.map 		∂
MacPerforma450ROM.map 		∂
MacPerforma460ROM.map 		∂
MacPerforma466ROM.map 		∂
MacPerforma467ROM.map 		∂
MacPerforma475ROM.map 		∂
MacPerforma476ROM.map		∂
							ƒ	:ROM.List:MacLCIIIROM.lst
	{doFilter}

MacLCIIROM.map				∂
							ƒ	:ROM.List:MacLCIIROM.lst
	{doFilter}

MacLCROM.map				∂
							ƒ	:ROM.List:MacLCROM.lst
	{doFilter}

MacPlusROM.map				∂
							ƒ	:ROM.List:MacPlusROM.lst
	{doFilter} 75

MacPortableROM.map			∂
MacPowerBook100ROM.map		∂
							ƒ	:ROM.List:MacPortableROM.lst
	{doFilter}

MacSEROM.map				∂
							ƒ	:ROM.List:MacSEROM.lst
	{doFilter} 76

MacPowerBook140ROM.map		∂
MacPowerBook170ROM.map		∂
MacPowerBook145bROM.map		∂
MacPowerBook145ROM.map		∂
							ƒ	:ROM.List:PB140ROM.lst
	{doFilter}

MacPowerBook160ROM.map		∂
MacPowerBook165cROM.map		∂
MacPowerBook165ROM.map		∂
MacPowerBook180cROM.map		∂
MacPowerBook180ROM.map		∂
							ƒ	:ROM.List:PB160ROM.lst
	{doFilter}

MacLC475ROM.map				∂
MacQuadra605ROM.map			∂
							ƒ	:ROM.List:Quadra605ROM.lst
	{doFilter}

MacQuadra700ROM.map			∂
MacQuadra900ROM.map			∂
							ƒ	:ROM.List:Quadra700ROM.lst
	{doFilter}


MacCentris610ROM.map		∂
MacCentris650ROM.map		∂
MacQuadra610ROM.map			∂
MacQuadra650ROM.map			∂
MacQuadra800ROM.map			∂
MacWorkgroupServer60ROM.map	∂
MacWorkgroupServer80ROM.map	∂
							ƒ	:ROM.List:Quadra800ROM.lst
	{doFilter}

MacQuadra950ROM.map			∂
MacWorkgroupServer95ROM.map	∂
							ƒ	:ROM.List:Quadra950ROM.lst
	{doFilter}

