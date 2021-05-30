{ Change History:}
{  2-Feb-87 Added Parameter to InitPerf for CODE, PDEF, etc. }
{ 10-Jan-86 Improve independence from PInterfaces, segmentation }
{ 31-Dec-86 Test the "MeasureRAM" functions. }

program TestPerf;

{$SETC ForBecks := true} { set to false for Mac Plus }

{$Z*}

uses
	MemTypes, 
	Perf,
	{needed for waste procedures, but not for Perf.p:}
	QuickDraw;
	
const
	DEBUG = false; { Set this to true to get more diagnostic writelns. }

var
	ThePGlobals: TP2PerfGlobals;
	
{ These are some procedures that "waste" time (W) in different amounts. }

{ First, some procedures that waste time in CODE segments: }
	
{$S SEG1}

	procedure W2500A;
		var i: integer;
			junk, junk1, junk2: {integer}longint;
		begin
			for i := 1 to 2500 do
				begin
					junk := 1;
					junk1 := junk*5;
					junk2 := (junk +junk1)*5;
				end;
		end; {W2500A}
		
	procedure W100;
		var i: integer;
			junk, junk1, junk2: {integer}longint;
		begin
			for i := 1 to 100 do
				begin
					junk := 1;
					junk1 := junk*5;
					junk2 := (junk +junk1)*5;
				end;
		end; {W100}
		
	procedure W7500;
		var i: integer;
			junk, junk1, junk2: {integer}longint;
		begin
			for i := 1 to 7500 do
				begin
					junk := 1;
					junk1 := junk*5;
					junk2 := (junk +junk1)*5;
				end;
		end; {W7500}
		
{$S SEG2}
	procedure Waste;
		var i: integer;
			junk, junk1, junk2: {integer}longint;
		begin
			for i := 1 to 1 do
				begin
					junk := 1;
					junk1 := junk*5;
					junk2 := (junk +junk1)*5;
				end;
		end; {Waste}
		
	procedure W2500B;
		var i: integer;
			junk, junk1, junk2: {integer}longint;
		begin
			for i := 1 to 2500 do
				begin
					junk := 1;
					junk1 := junk*5;
					junk2 := (junk +junk1)*5;
				end;
		end; {W2500B}
		
{ Second, some procedures that waste time in ROM: }
	
{$S ROMSEG1}

	procedure ROMW2500A;
		var i: integer;
			junk, junk1, junk2: rect;
			dontCare: Boolean;
		begin
			for i := 1 to 2500 do
				begin
					SetRect (junk, 100, 200, 300, 400);
					SetRect (junk1, 200, 300, 400, 500);
					dontCare := SectRect (junk, junk1, junk2);
				end;
		end; {ROMW2500A}
		
	procedure ROMW100;
		var i: integer;
			junk, junk1, junk2: rect;
			dontCare: Boolean;
		begin
			for i := 1 to 100 do
				begin
					SetRect (junk, 100, 200, 300, 400);
					SetRect (junk1, 200, 300, 400, 500);
					dontCare := SectRect (junk, junk1, junk2);
				end;
		end; {ROMW100}
		
	procedure ROMW7500;
		var i: integer;
			junk, junk1, junk2: rect;
			dontCare: Boolean;
		begin
			for i := 1 to 7500 do
				begin
					SetRect (junk, 100, 200, 300, 400);
					SetRect (junk1, 200, 300, 400, 500);
					dontCare := SectRect (junk, junk1, junk2);
				end;
		end; {ROMW7500}
		
{$S ROMSEG2}
	procedure ROMWaste;
		var i: integer;
			junk, junk1, junk2: rect;
			dontCare: Boolean;
		begin
			for i := 1 to 1 do
				begin
					SetRect (junk, 100, 200, 300, 400);
					SetRect (junk1, 200, 300, 400, 500);
					dontCare := SectRect (junk, junk1, junk2);
				end;
		end; {ROMWaste}
		
	procedure ROMW2500B;
		var i: integer;
			junk, junk1, junk2: rect;
			dontCare: Boolean;
		begin
			for i := 1 to 2500 do
				begin
					SetRect (junk, 100, 200, 300, 400);
					SetRect (junk1, 200, 300, 400, 500);
					dontCare := SectRect (junk, junk1, junk2);
				end;
		end; {ROMW2500B}
		
var
	repeats: integer; 

begin

	ThePGlobals := nil;
	{$IFC ForBecks}
	if not InitPerf (ThePGlobals, 4{ms}, 2{bytes}, true, true, 'CODE',
			$75, 'Main', true, 0{low RAM}, $1FFFFF{high RAM (2M)}, 16{default}) then
	{$ELSEC}
	if not InitPerf (ThePGlobals, 4{ms}, 8{bytes}, true, true,  'CODE',
			255, 'ROM', true, 0{low RAM}, $FFFFF{high RAM}, 16{bytes}) then
	{$ENDC}
		begin
			writeln ('Errors during InitPerf.');
			Exit (TestPerf);
		end;
	with ThePGlobals^ do
		begin
			write ('PCOffset = ', PCOffset:1); write (sizeof (TPerfGlobals));
			writeln;
			writeln ('FirstCODE = ', FirstCode:1, ' NumMeasure = ', NumMeasure:1);
		end;

	if PerfControl (ThePGlobals, True) then {turn on, throw away old state};
	
	for repeats := 1 to 5 do
		begin
				{ waste some time in user Code/MUL4 }
			If DEBUG then
				writeln('About to: Waste');
			Waste;
			If DEBUG then
				writeln ('About to: W100');
			W100;
			If DEBUG then
				writeln('About to: W2500A');
			W2500A;
			If DEBUG then
				writeln('About to: W2500B');
			W2500B;
			If DEBUG then
				writeln('About to: W7500');
			W7500;
			If DEBUG then
				writeln ('Done with: W7500!!');

				{ waste some time in ROM calls: }
			If DEBUG then
				writeln('About to: ROMWaste');
			ROMWaste;
			If DEBUG then
				writeln ('About to: ROMW100');
			ROMW100;
			If DEBUG then
				writeln('About to: ROMW2500A');
			ROMW2500A;
			If DEBUG then
				writeln('About to: ROMW2500B');
			ROMW2500B;
			If DEBUG then
				writeln('About to: ROMW7500');
			ROMW7500;
			If DEBUG then
				writeln ('Done with: ROMW7500!!');
		end;

	if PerfControl (ThePGlobals, False) then {turn off, throw away old state};

	if PerfDump (ThePGlobals, 'Perform.out', false, 80) <> 0 then
		writeln ('Errors during dump.');
		
	TermPerf (ThePGlobals);
	
end.