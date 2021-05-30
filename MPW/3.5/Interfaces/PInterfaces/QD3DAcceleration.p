{
     File:       QD3DAcceleration.p
 
     Contains:   Header file for low-level 3D driver API
 
     Version:    Technology: Quickdraw 3D 1.6
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1995-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QD3DAcceleration;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DACCELERATION__}
{$SETC __QD3DACCELERATION__ := 1}

{$I+}
{$SETC QD3DAccelerationIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{*****************************************************************************
 **                                                                          **
 **                         Vendor ID definitions                            **
 **                                                                          **
 ****************************************************************************}
{
 * If kQAVendor_BestChoice is used, the system chooses the "best" drawing engine
 * available for the target device. This should be used for the default.
 }

CONST
	kQAVendor_BestChoice		= -1;

	{	
	 * The other definitions (kQAVendor_Apple, etc.) identify specific vendors
	 * of drawing engines. When a vendor ID is used in conjunction with a
	 * vendor-defined engine ID, a specific drawing engine can be selected.
	 	}
	kQAVendor_Apple				= 0;
	kQAVendor_ATI				= 1;
	kQAVendor_Radius			= 2;
	kQAVendor_DesignMark		= 3;
	kQAVendor_Matrox			= 4;
	kQAVendor_Yarc				= 5;
	kQAVendor_DiamondMM			= 6;
	kQAVendor_3DLabs			= 7;
	kQAVendor_D3DAdaptor		= 8;
	kQAVendor_IXMicro			= 9;
	kQAVendor_NumberNine		= 10;
	kQAVendor_MicroConversions	= 11;
	kQAVendor_PurpleShark		= 12;
	kQAVendor_VillageTronic		= 14;

	{	*****************************************************************************
	 **                                                                          **
	 **                      Apple's engine ID definitions                       **
	 **                                                                          **
	 ****************************************************************************	}
	kQAEngine_AppleSW			= 0;							{  Default software rasterizer }
	kQAEngine_AppleHW			= -1;							{  Apple accelerator }
	kQAEngine_AppleHW2			= 1;							{  Another Apple accelerator }
	kQAEngine_AppleHW3			= 2;							{  Another Apple accelerator }



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DAccelerationIncludes}

{$ENDC} {__QD3DACCELERATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
