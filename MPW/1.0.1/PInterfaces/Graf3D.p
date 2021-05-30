{
  File: Graf3D.p

 Version: 1.0

 Copyright Apple Computer, Inc. 1984, 1985, 1986
 All Rights Reserved

}

UNIT Graf3D;

  INTERFACE

	USES {$U MemTypes.p } MemTypes,
	  {$U QuickDraw.p } QuickDraw;

	CONST
	  radConst = 3754936; {radConst = 57.29578}

	TYPE
	  Point3D = RECORD
				  x: Fixed;
				  y: Fixed;
				  z: Fixed;
				END;

	  Point2D = RECORD
				  x: Fixed;
				  y: Fixed;
				END;

	  XfMatrix = ARRAY [0..3, 0..3] OF fixed;
	  Port3DPtr = ^Port3D;
	  Port3D = RECORD
				 grPort: GrafPtr;
				 viewRect: Rect;
				 xLeft, yTop, xRight, yBottom: Fixed;
				 pen, penPrime, eye: Point3D;
				 hSize, vSize: Fixed;
				 hCenter, vCenter: Fixed;
				 xCotan, yCotan: Fixed;
				 ident: BOOLEAN;
				 xForm: XfMatrix;
			   END;

	PROCEDURE InitGrf3D(globalPtr: Ptr);

	PROCEDURE Open3DPort(port: Port3DPtr);

	PROCEDURE SetPort3D(port: Port3DPtr);

	PROCEDURE GetPort3D(VAR port: Port3DPtr);

	PROCEDURE MoveTo2D(x, y: Fixed);

	PROCEDURE MoveTo3D(x, y, z: Fixed);

	PROCEDURE LineTo2D(x, y: Fixed);

	PROCEDURE LineTo3D(x, y, z: Fixed);

	PROCEDURE Move2D(dx, dy: Fixed);

	PROCEDURE Move3D(dx, dy, dz: Fixed);

	PROCEDURE Line2D(dx, dy: Fixed);

	PROCEDURE Line3D(dx, dy, dz: Fixed);

	PROCEDURE ViewPort(r: Rect);

	PROCEDURE LookAt(left, top, right, bottom: Fixed);

	PROCEDURE ViewAngle(angle: Fixed);

	PROCEDURE Identity;

	PROCEDURE Scale(xFactor, yFactor, zFactor: Fixed);

	PROCEDURE Translate(dx, dy, dz: Fixed);

	PROCEDURE Pitch(xAngle: Fixed);

	PROCEDURE Yaw(yAngle: Fixed);

	PROCEDURE Roll(zAngle: Fixed);

	PROCEDURE Skew(zAngle: Fixed);

	PROCEDURE Transform(src: Point3D; VAR dst: Point3D);

	FUNCTION Clip3D(src1, src2: Point3D; VAR dst1, dst2: Point): BOOLEAN;

	PROCEDURE SetPt3D(VAR pt3D: Point3D; x, y, z: Fixed);

	PROCEDURE SetPt2D(VAR pt2D: Point2D; x, y: Fixed);

END.
