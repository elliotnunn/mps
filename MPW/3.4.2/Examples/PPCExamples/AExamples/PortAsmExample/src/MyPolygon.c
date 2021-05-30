/*-----------------------------------------------------------------------------
;	PortAsm Simple Example	by Steven Ellis
;
;	Copyright MicroAPL Ltd 1993/4
;
;	MyPolygon.c - Polygon creation and animation routines.
;		      Animation calls back into 68000 to draw the polygon.
-----------------------------------------------------------------------------*/

#include <stdlib.h>
#include <Math.h>
#include <Memory.h>

#define	SHADOW_OFFSET 10		/* Number of virtual points to offset the shadow polygon */
#define VIRTUAL_OFFSET SHADOW_OFFSET+2	/* used by GetVirtualPolyRect to calculate the bounding rectangle */

#define MIN_X	0			/* Size of the virtual window, */
#define MIN_Y	0			/* used in edge detection */
#define MAX_X	1280
#define MAX_Y	1024

#define True  1
#define False 0

#define POLY  1
#define STAR  0

#define SPOKE 100			/* default spoke about which polygon rotates */
#define PI 3.141592			/* internal value of π */

/* Macro to generate a random value within a given range */
#define Random(Min, Max) ((rand()*(Max-Min+1))/RAND_MAX+Min)

typedef struct Polypt {
	short	x;
	short	y;
} Polypt;

/* The polygon definition must match that in PAExample.inc
 */
#define MAX_POINTS 40			/* Max. number of points in polygon */

#pragma options align=mac68k
typedef struct MyPoly {
	Boolean	randColors;		/* Boolean for random Colors, a unused */
	Boolean	randPoly;		/* Boolean for random polygons, b unused */
	Boolean	randDirection;		/* Boolean for random directions */
	short	phase;			/* Polygon phase */
	int	Xpos;			/* X coordinate */
	int	Ypos;			/* Y coordinate */
	int	velX;			/* X velocity */
	int	velY;			/* Y velocity */
	short	polyOmega;		/* Rotation speed */
	short	polysize;
	short	spokeLength;		/* Spoke length */
	short	spokeOmega;		/* Spoke rotation speed */
	short	color;
	short	numPoints;		/* Number of points in poly */
	Polypt	pt [MAX_POINTS];	/* List of points */
	} MyPoly;
#pragma options align=reset

/*
 * 68000 assembler routine to draw the polygon
 */
extern void DrawOnePolygon (MyPoly *q, int color);


/* GETVIRTUALPOLYRECT
*
 * Returns the smallest bounding rectangle for the given polygon,
 * in virtual co-ordinates. Called from assembler.
 */
Rect	*GetVirtualPolyRect (MyPoly *p)
{
	static	Rect	rect;
	int	i;
	
	rect.left= MAX_X;
	rect.top=MAX_Y;
	rect.right=rect.bottom=0;
	
	/* find bounding rectangle for polygon */
	for (i=0; i < p->numPoints ; i++) {
	    if ( p->pt[i].x < rect.left )
	    	rect.left = p->pt[i].x;
	    if ( p->pt[i].x > rect.right )
	    	rect.right = p->pt[i].x;
	    if ( p->pt[i].y < rect.top )
	    	rect.top = p->pt[i].y;
	    if ( p->pt[i].y > rect.bottom )
	    	rect.bottom = p->pt[i].y;
	}
	
	
	/* adjust value for offset, but allow for edge of virtual window */
	/* offset allows for rounding errors when converting from virtual to real co-ordinates */
	rect.left = ( rect.left > + VIRTUAL_OFFSET ? rect.left - VIRTUAL_OFFSET : 0 );
	rect.right = (rect.right < MAX_X - VIRTUAL_OFFSET ? rect.right + VIRTUAL_OFFSET : MAX_X);
	rect.top = ( rect.top > VIRTUAL_OFFSET ? rect.top - VIRTUAL_OFFSET : 0 );
	rect.bottom = ( rect.bottom < MAX_Y - VIRTUAL_OFFSET ? rect.bottom + VIRTUAL_OFFSET : MAX_Y);
	
	return &rect;

}

/* GENERATEPOLYPOINTS
 *
 * Generate a polygon with the given number of points whose internal radius
 * is a random value between 10 and 50
 * If type is star, real number of points is twice those given.
 * ie. 5 corner star really has 10 points.
 * Returns the number of points.
 */
int GeneratePolyPoints(MyPoly *p, short points, int type)
{
	int f;
	double angle;
	
	if (type == STAR)
	    points=points*2;
	angle=PI*2.0/((double)points);
	p->polysize=2*Random(10,50);
	
	for (f=0; f<points; f++) {
	    p->pt[f].x = (int) SPOKE*cos(angle*f);
	    p->pt[f].y = (int) SPOKE*sin(angle*f);
	    if (type == STAR) {
		f++;
		p->pt[f].x = (int) p->polysize/2*cos(angle*f);
		p->pt[f].y = (int) p->polysize/2*sin(angle*f);
	    }
	}
	return	points;
}

/* ANIMATEONEPOLYGON
 *
 * Moves and then draws polygon. Returns 'True' if is bounced, 'False'
 * otherwise. Called from assembler.
 * The centre of the polygon is on the end of a spoke whose origin moves.
 * The spoke rotates about the origin and the polygon rotates about its
 * centre. Upon hitting a side of the virtual window the x or y velocity
 * is reversed, and a bounce it returned.
 *
 * Uses assembler routine -
 *	extern void DrawOnePolygon (MyPoly *q, int color);
 */
Boolean AnimateOnePolygon (MyPoly *p)
{
	Boolean	bounced;
	static MyPoly	calcPoly;
	MyPoly *q;
	int	i;
	double	theta;
	
	bounced = False;
	
	/* Update polygon phase */
	if ((p->phase++) > 10000)		/* Don't let theta get too big */
	    p->phase=0;
	    
	/* If phase a multiple of 1000 and random on change the polygon */    
	if (((p->phase)%100)==0) {
	    if (p->randDirection) {
		p->velX=Random(1,23);
		p->velY=Random(1,30);
		p->polyOmega=Random(0,15);	/* range 0-15 */
		p->spokeLength=Random(20,170);
		p->spokeOmega=Random(1,10);	/* range 1-10 */
	    }
	    if (p->randPoly)
		p->numPoints=GeneratePolyPoints(p,Random(3,20),Random(0,1));
	    if (p->randColors)
		p->color=Random(0,6);
	}

	/* Rotate polygon about its own axis */
	q = &calcPoly;
	theta = ((double)(p->polyOmega * p->phase))/30.0;
	for (i=0; i < p->numPoints; i++) {
	    q->pt[i].x = (int) (p->pt[i].x * cos (theta) +
			        p->pt[i].y * sin (theta));
	    q->pt[i].y = (int) (p->pt[i].y * cos (theta) -
			        p->pt[i].x * sin (theta));
	}

	/* Update position of polygon */
	p->Xpos += p->velX;
	p->Ypos += p->velY;
	
	theta = ((double)(p->spokeOmega * p->phase))/30.0;
	
	/* Check if the polygon has hit the edge */
	if (p->Xpos + (int) (p->spokeLength * cos (theta)) - p->polysize < MIN_X) {
	    	p->Xpos=p->Xpos - (p->Xpos + (int) (p->spokeLength * cos (theta)) -p->polysize + MIN_X);
		p->velX=abs(p->velX);
		bounced = True;
	} else if (p->Xpos + (int) (p->spokeLength * cos (theta)) + p->polysize > MAX_X) {
		p->Xpos=p->Xpos - (p->Xpos + (int) (p->spokeLength * cos (theta)) + p->polysize - MAX_X);
		p->velX = -abs(p->velX);
		bounced = True;
	}
	if (p->Ypos - (int) (p->spokeLength * sin (theta)) - p->polysize < MIN_Y) {
	    	p->Ypos=p->Ypos - (p->Ypos - (int) (p->spokeLength * sin (theta)) - p->polysize + MIN_Y);
		p->velY = abs(p->velY);
		bounced = True;
	} else if (p->Ypos - (int) (p->spokeLength * sin (theta)) + p->polysize > MAX_Y) {
		p->Ypos=p->Ypos - (p->Ypos - (int) (p->spokeLength * sin (theta)) + p->polysize - MAX_Y);
		p->velY = -abs(p->velY);
		bounced = True;
	}
	
	/* Offset polygon by (x,y) and add in rotation about the spoke */
	for (i=0; i < p->numPoints; i++) {
	    q->pt[i].x += p->Xpos + (int) (p->spokeLength * cos (theta));
	    q->pt[i].y += p->Ypos - (int) (p->spokeLength * sin (theta));

	}
	
	q->numPoints=p->numPoints;
	
	/* Draw the shadow polygon in white */
	DrawOnePolygon (q,0);
	
	/* Offset the polygon*/
	for (i=0; i < q->numPoints; i++) {
	    q->pt[i].x -= SHADOW_OFFSET;
	    q->pt[i].y -= SHADOW_OFFSET;
	}
	
	/* Now draw the polygon in its current color */
	DrawOnePolygon (q, p->color);

	/* Return 'True' if we bounced off an edge, False otherwise */	
	return bounced;
}
	    
/* CREATEONEPOLYGON
 *
 * Returns a pointer to a polygon of the given type and number of points.
 * The size of the polygon is random and set in GeneratePolyPoints().
 * This is called from assembler.
 */
MyPoly *CreateOnePolygon (int type, short points)
{
	MyPoly	*newpoly;
	
	newpoly= (MyPoly *) NewPtr (sizeof(MyPoly));
	
	newpoly->randPoly	= 0;		/* random settings initially off */
	newpoly->randColors	= 0;
	newpoly->randDirection	= 0;
	newpoly->phase		= 0;		/* just started so zero phase */
	newpoly->Xpos		= 500;
	newpoly->Ypos		= 500;
	newpoly->velX		= Random(10,30);
	newpoly->velY		= Random(10,30);
	newpoly->polyOmega	= Random(5,15);
	newpoly->spokeLength	= Random(50,170);
	newpoly->spokeOmega	= Random(5,10);
	newpoly->color		= Random(1,7);
	newpoly->numPoints	= GeneratePolyPoints(newpoly,points,type);
	
	return newpoly;
}
