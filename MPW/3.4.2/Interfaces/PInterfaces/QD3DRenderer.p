{
 	File:		QD3DRenderer.p
 
 	Contains:	Renderer types and routines	 						 			
 
 	Version:	Technology:	Quickdraw 3D 1.0.6
 				Release:	Universal Interfaces 2.1.5
 
 	Copyright:	© 1984-1997 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QD3DRenderer;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DRENDERER__}
{$SETC __QD3DRENDERER__ := 1}

{$I+}
{$SETC QD3DRendererIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}

{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{
*****************************************************************************
 **																			 **
 **							Renderer Functions								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Renderer_NewFromType(rendererObjectType: TQ3ObjectType): TQ3RendererObject; C;
FUNCTION Q3Renderer_GetType(renderer: TQ3RendererObject): TQ3ObjectType; C;
FUNCTION Q3Renderer_Flush(renderer: TQ3RendererObject; view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Renderer_Sync(renderer: TQ3RendererObject; view: TQ3ViewObject): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **						Interactive Renderer Specific Functions				 **
 **																			 **
 ****************************************************************************
}
{  CSG IDs attribute  }
{  Object IDs, to be applied as attributes on geometries  }
{  Possible CSG equations  }

TYPE
	TQ3CSGEquation 				= LONGINT;
CONST
	kQ3CSGEquationAandB			= {TQ3CSGEquation}$88888888;
	kQ3CSGEquationAandnotB		= {TQ3CSGEquation}$22222222;
	kQ3CSGEquationAanBonCad		= {TQ3CSGEquation}$2F222F22;
	kQ3CSGEquationnotAandB		= {TQ3CSGEquation}$44444444;
	kQ3CSGEquationnAaBorCanB	= {TQ3CSGEquation}$74747474;

FUNCTION Q3InteractiveRenderer_SetCSGEquation(renderer: TQ3RendererObject; equation: TQ3CSGEquation): TQ3Status; C;
FUNCTION Q3InteractiveRenderer_GetCSGEquation(renderer: TQ3RendererObject; VAR equation: TQ3CSGEquation): TQ3Status; C;
FUNCTION Q3InteractiveRenderer_SetPreferences(renderer: TQ3RendererObject; vendorID: LONGINT; engineID: LONGINT): TQ3Status; C;
FUNCTION Q3InteractiveRenderer_GetPreferences(renderer: TQ3RendererObject; VAR vendorID: LONGINT; VAR engineID: LONGINT): TQ3Status; C;
FUNCTION Q3InteractiveRenderer_SetDoubleBufferBypass(renderer: TQ3RendererObject; bypass: TQ3Boolean): TQ3Status; C;
FUNCTION Q3InteractiveRenderer_GetDoubleBufferBypass(renderer: TQ3RendererObject; VAR bypass: TQ3Boolean): TQ3Status; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DRendererIncludes}

{$ENDC} {__QD3DRENDERER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
