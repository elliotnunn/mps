{
     File:       CGAffineTransform.p
 
     Contains:   xxx put contents here xxx
 
     Version:    Technology: from CoreGraphics-70.root
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CGAffineTransform;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CGAFFINETRANSFORM__}
{$SETC __CGAFFINETRANSFORM__ := 1}

{$I+}
{$SETC CGAffineTransformIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CGBASE__}
{$I CGBase.p}
{$ENDC}
{$IFC UNDEFINED __CGGEOMETRY__}
{$I CGGeometry.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CGAffineTransformPtr = ^CGAffineTransform;
	CGAffineTransform = RECORD
		a:						Single;
		b:						Single;
		c:						Single;
		d:						Single;
		tx:						Single;
		ty:						Single;
	END;

	{	 The identity transform: [ 1 0 0 1 0 0 ]. 	}
	{
	 *  CGAffineTransformIdentity
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{	 Return the transform [ a b c d tx ty ]. 	}
	{
	 *  CGAffineTransformMake()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CGAffineTransformMake(a: Single; b: Single; c: Single; d: Single; tx: Single; ty: Single): CGAffineTransform; C;

{ Return a transform which translates by `(tx, ty)':
 *   t' = [ 1 0 0 1 tx ty ] }
{
 *  CGAffineTransformMakeTranslation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGAffineTransformMakeTranslation(tx: Single; ty: Single): CGAffineTransform; C;

{ Return a transform which scales by `(sx, sy)':
 *   t' = [ sx 0 0 sy 0 0 ] }
{
 *  CGAffineTransformMakeScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGAffineTransformMakeScale(sx: Single; sy: Single): CGAffineTransform; C;

{ Return a transform which rotates by `angle' radians:
 *   t' = [ cos(angle) sin(angle) -sin(angle) cos(angle) 0 0 ] }
{
 *  CGAffineTransformMakeRotation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGAffineTransformMakeRotation(angle: Single): CGAffineTransform; C;

{ Translate `t' by `(tx, ty)' and return the result:
 *   t' = [ 1 0 0 1 tx ty ] * t }
{
 *  CGAffineTransformTranslate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGAffineTransformTranslate(t: CGAffineTransform; tx: Single; ty: Single): CGAffineTransform; C;

{ Scale `t' by `(sx, sy)' and return the result:
 *   t' = [ sx 0 0 sy 0 0 ] * t }
{
 *  CGAffineTransformScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGAffineTransformScale(t: CGAffineTransform; sx: Single; sy: Single): CGAffineTransform; C;

{ Rotate `t' by `angle' radians and return the result:
 *   t' =  [ cos(angle) sin(angle) -sin(angle) cos(angle) 0 0 ] * t }
{
 *  CGAffineTransformRotate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGAffineTransformRotate(t: CGAffineTransform; angle: Single): CGAffineTransform; C;

{ Invert `t' and return the result.  If `t' has zero determinant, then `t'
 * is returned unchanged. }
{
 *  CGAffineTransformInvert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGAffineTransformInvert(t: CGAffineTransform): CGAffineTransform; C;

{ Concatenate `t2' to `t1' and returne the result:
 *   t' = t1 * t2 }
{
 *  CGAffineTransformConcat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGAffineTransformConcat(t1: CGAffineTransform; t2: CGAffineTransform): CGAffineTransform; C;

{ Transform `point' by `t' and return the result:
 *   p' = p * t
 * where p = [ x y 1 ]. }
{
 *  CGPointApplyAffineTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPointApplyAffineTransform(point: CGPoint; t: CGAffineTransform): CGPoint; C;

{ Transform `size' by `t' and return the result:
 *   s' = s * t
 * where s = [ width height 0 ]. }
{
 *  CGSizeApplyAffineTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGSizeApplyAffineTransform(size: CGSize; t: CGAffineTransform): CGSize; C;



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CGAffineTransformIncludes}

{$ENDC} {__CGAFFINETRANSFORM__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
