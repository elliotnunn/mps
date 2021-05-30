{
     File:       CGGeometry.p
 
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
 UNIT CGGeometry;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CGGEOMETRY__}
{$SETC __CGGEOMETRY__ := 1}

{$I+}
{$SETC CGGeometryIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CGBASE__}
{$I CGBase.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Points. }

TYPE
	CGPointPtr = ^CGPoint;
	CGPoint = RECORD
		x:						Single;
		y:						Single;
	END;

	{	 Sizes. 	}
	CGSizePtr = ^CGSize;
	CGSize = RECORD
		width:					Single;
		height:					Single;
	END;

	{	 Rectangles. 	}
	CGRectPtr = ^CGRect;
	CGRect = RECORD
		origin:					CGPoint;
		size:					CGSize;
	END;

	{	 Rectangle edges. 	}
	CGRectEdge 					= SInt32;
CONST
	CGRectMinXEdge				= 0;
	CGRectMinYEdge				= 1;
	CGRectMaxXEdge				= 2;
	CGRectMaxYEdge				= 3;

	{	 The "zero" point -- equivalent to CGPointMake(0, 0). 	}
	{
	 *  CGPointZero
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{	 The "zero" size -- equivalent to CGSizeMake(0, 0). 	}
	{
	 *  CGSizeZero
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{	 The "zero" rectangle -- equivalent to CGRectMake(0, 0, 0, 0). 	}
	{
	 *  CGRectZero
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{	 The "empty" rect.  This is the rectangle returned when, for example, we
	 * intersect two disjoint rectangles.  Note that the null rect is not the
	 * same as the zero rect. 	}
	{
	 *  CGRectNull
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 or later
	 	}

	{	 Make a point from `(x, y)'. 	}
	{
	 *  CGPointMake()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CGPointMake(x: Single; y: Single): CGPoint; C;

{ Make a size from `(width, height)'. }
{
 *  CGSizeMake()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGSizeMake(width: Single; height: Single): CGSize; C;

{ Make a rect from `(x, y; width, height)'. }
{
 *  CGRectMake()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectMake(x: Single; y: Single; width: Single; height: Single): CGRect; C;

{ Return the leftmost x-value of `rect'. }
{
 *  CGRectGetMinX()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectGetMinX(rect: CGRect): Single; C;

{ Return the midpoint x-value of `rect'. }
{
 *  CGRectGetMidX()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectGetMidX(rect: CGRect): Single; C;

{ Return the rightmost x-value of `rect'. }
{
 *  CGRectGetMaxX()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectGetMaxX(rect: CGRect): Single; C;

{ Return the bottommost y-value of `rect'. }
{
 *  CGRectGetMinY()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectGetMinY(rect: CGRect): Single; C;

{ Return the midpoint y-value of `rect'. }
{
 *  CGRectGetMidY()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectGetMidY(rect: CGRect): Single; C;

{ Return the topmost y-value of `rect'. }
{
 *  CGRectGetMaxY()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectGetMaxY(rect: CGRect): Single; C;

{ Return the width of `rect'. }
{
 *  CGRectGetWidth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectGetWidth(rect: CGRect): Single; C;

{ Return the height of `rect'. }
{
 *  CGRectGetHeight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectGetHeight(rect: CGRect): Single; C;

{ Return 1 if `point1' and `point2' are the same, 0 otherwise. }
{
 *  CGPointEqualToPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGPointEqualToPoint(point1: CGPoint; point2: CGPoint): LONGINT; C;

{ Return 1 if `size1' and `size2' are the same, 0 otherwise. }
{
 *  CGSizeEqualToSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGSizeEqualToSize(size1: CGSize; size2: CGSize): LONGINT; C;

{ Return 1 if `rect1' and `rect2' are the same, 0 otherwise. }
{
 *  CGRectEqualToRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectEqualToRect(rect1: CGRect; rect2: CGRect): LONGINT; C;

{ Standardize `rect' -- i.e., convert it to an equivalent rect which has
 * positive width and height. }
{
 *  CGRectStandardize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectStandardize(rect: CGRect): CGRect; C;

{ Return 1 if `rect' is empty -- i.e., if it has zero width or height.  A
 * null rect is defined to be empty. }
{
 *  CGRectIsEmpty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectIsEmpty(rect: CGRect): LONGINT; C;

{ Return 1 if `rect' is null -- e.g., the result of intersecting two
 * disjoint rectangles is a null rect. }
{
 *  CGRectIsNull()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectIsNull(rect: CGRect): LONGINT; C;

{ Inset `rect' by `(dx, dy)' -- i.e., offset its origin by `(dx, dy)', and
 * decrease its size by `(2*dx, 2*dy)'. }
{
 *  CGRectInset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectInset(rect: CGRect; dx: Single; dy: Single): CGRect; C;

{ Expand `rect' to the smallest rect containing it with integral origin
 * and size. }
{
 *  CGRectIntegral()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectIntegral(rect: CGRect): CGRect; C;

{ Return the union of `r1' and `r2'. }
{
 *  CGRectUnion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectUnion(r1: CGRect; r2: CGRect): CGRect; C;

{ Return the intersection of `r1' and `r2'.  This may return a null
 * rect. }
{
 *  CGRectIntersection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectIntersection(r1: CGRect; r2: CGRect): CGRect; C;

{ Offset `rect' by `(dx, dy)'. }
{
 *  CGRectOffset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectOffset(rect: CGRect; dx: Single; dy: Single): CGRect; C;

{ Make two new rectangles, `slice' and `remainder', by dividing `rect'
 * with a line that's parallel to one of its sides, specified by `edge' --
 * either `CGRectMinXEdge', `CGRectMinYEdge', `CGRectMaxXEdge', or
 * `CGRectMaxYEdge'.  The size of `slice' is determined by `amount', which
 * measures the distance from the specified edge. }
{
 *  CGRectDivide()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CGRectDivide(rect: CGRect; VAR slice: CGRect; VAR remainder: CGRect; amount: Single; edge: CGRectEdge); C;

{ Return 1 if `point' is contained in `rect', 0 otherwise. }
{
 *  CGRectContainsPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectContainsPoint(rect: CGRect; point: CGPoint): LONGINT; C;

{ Return 1 if `rect2' is contained in `rect1', 0 otherwise.  `rect2' is
 * contained in `rect1' if the union of `rect1' and `rect2' is equal to
 * `rect1'. }
{
 *  CGRectContainsRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectContainsRect(rect1: CGRect; rect2: CGRect): LONGINT; C;

{ Return 1 if `rect1' intersects `rect2', 0 otherwise.  `rect1' intersects
 * `rect2' if the intersection of `rect1' and `rect2' is not the null
 * rect. }
{
 *  CGRectIntersectsRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CGRectIntersectsRect(rect1: CGRect; rect2: CGRect): LONGINT; C;



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CGGeometryIncludes}

{$ENDC} {__CGGEOMETRY__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
