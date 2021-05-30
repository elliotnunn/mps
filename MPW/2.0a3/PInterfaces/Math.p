{
 MATH.p - Pascal interface for Math functions

 Copyright Apple Computer, Inc. 1987
 All rights reserved.
 2/10/87
 
}

UNIT MATH;

  INTERFACE

    { Interface for Math library }

    FUNCTION ArcTanh(x: EXTENDED): EXTENDED; { Hyperbolic arc tangent }

    FUNCTION Cosh(x: EXTENDED): EXTENDED; { Hyperbolic cosine }

    FUNCTION Sinh(x: EXTENDED): EXTENDED; { Hyperbolic sine }

    FUNCTION Tanh(x: EXTENDED): EXTENDED; { Hyperbolic tangent }

    FUNCTION Log10(x: EXTENDED): EXTENDED; { Log base 10 }

    FUNCTION Exp10(x: EXTENDED): EXTENDED; { 10 to the x power }

    FUNCTION ArcCos(x: EXTENDED): EXTENDED; { Arc cosine }

    FUNCTION ArcSin(x: EXTENDED): EXTENDED; { Arc sine }

    PROCEDURE SinCos(VAR s, c: EXTENDED; x: EXTENDED); { Simultaneous sine and
         { s <-- sin(x)		c <-- cos(x)                   cosine }

END.
