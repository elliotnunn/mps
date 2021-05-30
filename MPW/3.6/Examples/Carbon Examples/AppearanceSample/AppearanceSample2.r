/*
	Version:    CarbonLib 1.0.2 SDK

	You may incorporate this sample code into your applications without
	restriction, though the sample code has been provided "AS IS" and the
	responsibility for its operation is 100% yours.  However, what you are
	not permitted to do is to redistribute the source as "Apple Sample Code"
	after having made changes. If you're going to re-distribute the source,
	we require that you make it clear in the source that the code was
	descended from Apple Sample Code, but that you've made changes.

	© 1997-2000 by Apple Computer, Inc. All rights reserved.
*/

#include "MacTypes.r"
#include "ControlDefinitions.r"
#include "MacWindows.r"
#include "Dialogs.r"
#include "Menus.r"
#include "Icons.r"
#include "Finder.r"
#include "Quickdraw.r"
#include "Processes.r"

resource 'ALRT' (128) {
	{211, 11, 297, 337},
	128,
	{	/* array: 4 elements */
		/* [1] */
		OK, visible, sound1,
		/* [2] */
		OK, visible, sound1,
		/* [3] */
		OK, visible, sound1,
		/* [4] */
		OK, visible, sound1
	},
	centerMainScreen
	/****** Extra bytes follow... ******/
	/* $"0003"                                               /* .. */
};

resource 'ALRT' (129) {
	{55, 39, 153, 407},
	129,
	{	/* array: 4 elements */
		/* [1] */
		OK, visible, sound1,
		/* [2] */
		OK, visible, sound1,
		/* [3] */
		OK, visible, sound1,
		/* [4] */
		OK, visible, sound1
	},
	alertPositionParentWindowScreen
};

resource 'ALRT' (200) {
	{40, 40, 125, 378},
	200,
	{	/* array: 4 elements */
		/* [1] */
		OK, visible, sound1,
		/* [2] */
		OK, visible, sound1,
		/* [3] */
		OK, visible, sound1,
		/* [4] */
		OK, visible, sound1
	},
	alertPositionMainScreen
};

resource 'DITL' (128) {
	{	/* array DITLarray: 2 elements */
		/* [1] */
		{52, 246, 72, 304},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{10, 72, 35, 220},
		StaticText {
			disabled,
			"This is the about box"
		}
	}
};

resource 'DITL' (129) {
	{	/* array DITLarray: 2 elements */
		/* [1] */
		{8, 74, 61, 356},
		StaticText {
			disabled,
			"^0"
		},
		/* [2] */
		{70, 299, 90, 357},
		Button {
			enabled,
			"OK"
		}
	}
};

resource 'DITL' (130) {
	{	/* array DITLarray: 1 elements */
		/* [1] */
		{25, 54, 57, 86},
		UserItem {
			disabled
		}
	}
};

resource 'DITL' (200) {
	{	/* array DITLarray: 2 elements */
		/* [1] */
		{57, 267, 77, 325},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{18, 54, 34, 252},
		StaticText {
			disabled,
			"Here is a test alert."
		}
	}
};

resource 'DITL' (1001) {
	{	/* array DITLarray: 41 elements */
		/* [1] */
		{302, 17, 322, 98},
		Button {
			enabled,
			"Disabled"
		},
		/* [2] */
		{302, 102, 323, 168},
		Button {
			enabled,
			"Enabled"
		},
		/* [3] */
		{302, 173, 322, 231},
		Button {
			enabled,
			"On"
		},
		/* [4] */
		{302, 237, 322, 295},
		Button {
			enabled,
			"Off"
		},
		/* [5] */
		{302, 301, 322, 359},
		Button {
			enabled,
			"Mixed"
		},
		/* [6] */
		{24, 5, 60, 41},
		Control {
			enabled,
			138
		},
		/* [7] */
		{24, 47, 60, 83},
		Control {
			enabled,
			139
		},
		/* [8] */
		{24, 89, 60, 125},
		Control {
			enabled,
			140
		},
		/* [9] */
		{24, 143, 48, 167},
		Control {
			enabled,
			141
		},
		/* [10] */
		{24, 172, 48, 208},
		Control {
			enabled,
			142
		},
		/* [11] */
		{24, 213, 48, 273},
		Control {
			enabled,
			143
		},
		/* [12] */
		{23, 282, 47, 306},
		Control {
			enabled,
			147
		},
		/* [13] */
		{23, 311, 59, 347},
		Control {
			enabled,
			148
		},
		/* [14] */
		{23, 352, 71, 400},
		Control {
			enabled,
			149
		},
		/* [15] */
		{97, 7, 121, 31},
		Control {
			enabled,
			144
		},
		/* [16] */
		{97, 39, 133, 75},
		Control {
			enabled,
			145
		},
		/* [17] */
		{97, 82, 145, 130},
		Control {
			enabled,
			146
		},
		/* [18] */
		{91, 183, 111, 283},
		Control {
			enabled,
			183
		},
		/* [19] */
		{91, 283, 111, 383},
		Control {
			enabled,
			184
		},
		/* [20] */
		{111, 183, 131, 283},
		Control {
			enabled,
			188
		},
		/* [21] */
		{111, 283, 131, 383},
		Control {
			enabled,
			190
		},
		/* [22] */
		{174, 5, 194, 105},
		Control {
			enabled,
			185
		},
		/* [23] */
		{174, 105, 194, 205},
		Control {
			enabled,
			186
		},
		/* [24] */
		{174, 205, 194, 305},
		Control {
			enabled,
			187
		},
		/* [25] */
		{174, 305, 194, 405},
		Control {
			enabled,
			189
		},
		/* [26] */
		{215, 73, 239, 143},
		Control {
			enabled,
			191
		},
		/* [27] */
		{215, 143, 239, 213},
		Control {
			enabled,
			192
		},
		/* [28] */
		{204, 225, 252, 273},
		Control {
			enabled,
			193
		},
		/* [29] */
		{204, 273, 252, 321},
		Control {
			enabled,
			194
		},
		/* [30] */
		{262, 72, 286, 192},
		Control {
			enabled,
			195
		},
		/* [31] */
		{262, 192, 286, 292},
		Control {
			enabled,
			196
		},
		/* [32] */
		{262, 292, 286, 392},
		Control {
			enabled,
			197
		},
		/* [33] */
		{4, 4, 20, 131},
		StaticText {
			disabled,
			"Three Bevel Sizes:"
		},
		/* [34] */
		{4, 141, 20, 178},
		StaticText {
			disabled,
			"Text:"
		},
		/* [35] */
		{5, 280, 21, 347},
		StaticText {
			disabled,
			"Pictures:"
		},
		/* [36] */
		{74, 5, 90, 180},
		StaticText {
			disabled,
			"Icon (can be suite or cicn):"
		},
		/* [37] */
		{74, 182, 89, 358},
		StaticText {
			disabled,
			"Menus and text alignment:"
		},
		/* [38] */
		{157, 5, 171, 80},
		StaticText {
			disabled,
			"Behaviors"
		},
		/* [39] */
		{199, 5, 214, 62},
		StaticText {
			disabled,
			"Combos:"
		},
		/* [40] */
		{217, 5, 233, 72},
		StaticText {
			disabled,
			"Centered:"
		},
		/* [41] */
		{264, 5, 279, 67},
		StaticText {
			disabled,
			"Justified:"
		}
	}
};

resource 'DITL' (1002) {
	{	/* array DITLarray: 16 elements */
		/* [1] */
		{10, 28, 58, 76},
		Control {
			enabled,
			198
		},
		/* [2] */
		{131, 29, 179, 77},
		Control {
			enabled,
			199
		},
		/* [3] */
		{110, 19, 115, 319},
		Control {
			enabled,
			200
		},
		/* [4] */
		{11, 97, 31, 170},
		Button {
			enabled,
			"Icon Suite"
		},
		/* [5] */
		{57, 97, 77, 170},
		Button {
			enabled,
			"Color Icon"
		},
		/* [6] */
		{34, 97, 54, 170},
		Button {
			enabled,
			"Picture"
		},
		/* [7] */
		{80, 97, 100, 170},
		Button {
			enabled,
			"Text Only"
		},
		/* [8] */
		{123, 97, 143, 170},
		Button {
			enabled,
			"Icon Suite"
		},
		/* [9] */
		{147, 97, 167, 170},
		Button {
			enabled,
			"Color Icon"
		},
		/* [10] */
		{171, 97, 191, 170},
		Button {
			enabled,
			"Picture"
		},
		/* [11] */
		{123, 181, 143, 306},
		Button {
			enabled,
			"Icon Suite Handle"
		},
		/* [12] */
		{147, 181, 167, 306},
		Button {
			enabled,
			"Color Icon Handle"
		},
		/* [13] */
		{171, 181, 191, 306},
		Button {
			enabled,
			"Picture Handle"
		},
		/* [14] */
		{10, 181, 30, 306},
		Button {
			enabled,
			"Icon Suite Handle"
		},
		/* [15] */
		{34, 181, 54, 306},
		Button {
			enabled,
			"Color Icon Handle"
		},
		/* [16] */
		{58, 181, 78, 306},
		Button {
			enabled,
			"Picture Handle"
		}
	}
};

resource 'DITL' (2001) {
	{	/* array DITLarray: 7 elements */
		/* [1] */
		{13, 126, 30, 177},
		StaticText {
			disabled,
			"Length:"
		},
		/* [2] */
		{14, 189, 30, 264},
		EditText {
			enabled,
			"100"
		},
		/* [3] */
		{61, 207, 81, 265},
		Button {
			enabled,
			"Cancel"
		},
		/* [4] */
		{61, 275, 81, 333},
		Button {
			enabled,
			"OK"
		},
		/* [5] */
		{3, 4, 54, 120},
		Control {
			enabled,
			281
		},
		/* [6] */
		{12, 11, 30, 117},
		RadioButton {
			enabled,
			"Horizontal"
		},
		/* [7] */
		{29, 11, 47, 117},
		RadioButton {
			enabled,
			"Vertical"
		}
	}
};

resource 'DITL' (2002) {
	{	/* array DITLarray: 4 elements */
		/* [1] */
		{14, 11, 32, 117},
		CheckBox {
			enabled,
			"Left Facing"
		},
		/* [2] */
		{40, 11, 58, 117},
		CheckBox {
			enabled,
			"Auto-Toggles"
		},
		/* [3] */
		{48, 182, 68, 240},
		Button {
			enabled,
			"Cancel"
		},
		/* [4] */
		{48, 250, 68, 308},
		Button {
			enabled,
			"OK"
		}
	}
};

resource 'DITL' (2003) {
	{	/* array DITLarray: 7 elements */
		/* [1] */
		{15, 11, 31, 60},
		StaticText {
			disabled,
			"Height:"
		},
		/* [2] */
		{46, 12, 62, 59},
		StaticText {
			disabled,
			"Width:"
		},
		/* [3] */
		{16, 72, 32, 147},
		EditText {
			enabled,
			"80"
		},
		/* [4] */
		{46, 72, 62, 147},
		EditText {
			enabled,
			"200"
		},
		/* [5] */
		{12, 189, 30, 295},
		CheckBox {
			enabled,
			"List View"
		},
		/* [6] */
		{76, 210, 96, 268},
		Button {
			enabled,
			"Cancel"
		},
		/* [7] */
		{76, 276, 96, 334},
		Button {
			enabled,
			"OK"
		}
	}
};

resource 'DITL' (2005) {
	{	/* array DITLarray: 10 elements */
		/* [1] */
		{21, 12, 37, 58},
		StaticText {
			disabled,
			"Res ID:"
		},
		/* [2] */
		{22, 66, 38, 141},
		EditText {
			enabled,
			"128"
		},
		/* [3] */
		{101, 285, 121, 343},
		Button {
			enabled,
			"OK"
		},
		/* [4] */
		{101, 214, 121, 272},
		Button {
			enabled,
			"Cancel"
		},
		/* [5] */
		{16, 163, 34, 343},
		CheckBox {
			enabled,
			"Don't Respond To Hits"
		},
		/* [6] */
		{59, 12, 75, 61},
		StaticText {
			disabled,
			"Height:"
		},
		/* [7] */
		{92, 12, 108, 61},
		StaticText {
			disabled,
			"Width:"
		},
		/* [8] */
		{60, 66, 76, 141},
		EditText {
			enabled,
			"32"
		},
		/* [9] */
		{92, 66, 108, 141},
		EditText {
			enabled,
			"32"
		},
		/* [10] */
		{42, 163, 60, 319},
		CheckBox {
			enabled,
			"Use Item's Rectangle"
		}
	}
};

resource 'DITL' (2004) {
	{	/* array DITLarray: 4 elements */
		/* [1] */
		{29, 12, 45, 58},
		StaticText {
			disabled,
			"Value:"
		},
		/* [2] */
		{30, 66, 46, 141},
		EditText {
			enabled,
			"0"
		},
		/* [3] */
		{59, 289, 79, 347},
		Button {
			enabled,
			"OK"
		},
		/* [4] */
		{59, 218, 79, 276},
		Button {
			enabled,
			"Cancel"
		}
	}
};

resource 'DITL' (2006) {
	{	/* array DITLarray: 5 elements */
		/* [1] */
		{30, 5, 46, 55},
		StaticText {
			disabled,
			"Length:"
		},
		/* [2] */
		{30, 66, 46, 141},
		EditText {
			enabled,
			"100"
		},
		/* [3] */
		{59, 289, 79, 347},
		Button {
			enabled,
			"OK"
		},
		/* [4] */
		{59, 218, 79, 276},
		Button {
			enabled,
			"Cancel"
		},
		/* [5] */
		{27, 181, 45, 300},
		CheckBox {
			enabled,
			"Indeterminate"
		}
	}
};

resource 'DITL' (2007) {
	{	/* array DITLarray: 14 elements */
		/* [1] */
		{120, 326, 140, 384},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{120, 258, 140, 316},
		Button {
			enabled,
			"Cancel"
		},
		/* [3] */
		{4, 7, 51, 134},
		Control {
			enabled,
			282
		},
		/* [4] */
		{7, 12, 25, 133},
		RadioButton {
			enabled,
			"Primary Group"
		},
		/* [5] */
		{28, 12, 46, 142},
		RadioButton {
			enabled,
			"Secondary Group"
		},
		/* [6] */
		{7, 231, 23, 280},
		StaticText {
			disabled,
			"Height:"
		},
		/* [7] */
		{38, 231, 54, 276},
		StaticText {
			disabled,
			"Width:"
		},
		/* [8] */
		{7, 290, 23, 365},
		EditText {
			enabled,
			"150"
		},
		/* [9] */
		{38, 290, 54, 365},
		EditText {
			enabled,
			"200"
		},
		/* [10] */
		{84, 13, 103, 212},
		Control {
			enabled,
			210
		},
		/* [11] */
		{122, 16, 138, 53},
		StaticText {
			disabled,
			"Title:"
		},
		/* [12] */
		{122, 58, 138, 209},
		EditText {
			enabled,
			"My Group Box"
		},
		/* [13] */
		{83, 290, 99, 365},
		EditText {
			enabled,
			"132"
		},
		/* [14] */
		{84, 223, 101, 278},
		StaticText {
			disabled,
			"MenuID:"
		}
	}
};

resource 'DITL' (2008) {
	{	/* array DITLarray: 6 elements */
		/* [1] */
		{15, 12, 31, 61},
		StaticText {
			disabled,
			"Height:"
		},
		/* [2] */
		{47, 13, 63, 60},
		StaticText {
			disabled,
			"Width:"
		},
		/* [3] */
		{16, 69, 32, 144},
		EditText {
			enabled,
			"50"
		},
		/* [4] */
		{47, 69, 63, 144},
		EditText {
			enabled,
			"100"
		},
		/* [5] */
		{72, 275, 92, 333},
		Button {
			enabled,
			"OK"
		},
		/* [6] */
		{72, 207, 92, 265},
		Button {
			enabled,
			"Cancel"
		}
	}
};

resource 'DITL' (2009) {
	{	/* array DITLarray: 4 elements */
		/* [1] */
		{9, 6, 29, 160},
		Control {
			enabled,
			211
		},
		/* [2] */
		{10, 192, 28, 340},
		CheckBox {
			enabled,
			"Use Small Version"
		},
		/* [3] */
		{47, 283, 67, 341},
		Button {
			enabled,
			"OK"
		},
		/* [4] */
		{47, 215, 67, 273},
		Button {
			enabled,
			"Cancel"
		}
	}
};

resource 'DITL' (2010) {
	{	/* array DITLarray: 7 elements */
		/* [1] */
		{8, 6, 53, 120},
		Control {
			enabled,
			283
		},
		/* [2] */
		{12, 11, 30, 117},
		RadioButton {
			enabled,
			"Horizontal"
		},
		/* [3] */
		{29, 11, 47, 117},
		RadioButton {
			enabled,
			"Vertical"
		},
		/* [4] */
		{13, 126, 30, 177},
		StaticText {
			disabled,
			"Length:"
		},
		/* [5] */
		{14, 189, 30, 264},
		EditText {
			enabled,
			"100"
		},
		/* [6] */
		{61, 207, 81, 265},
		Button {
			enabled,
			"Cancel"
		},
		/* [7] */
		{61, 275, 81, 333},
		Button {
			enabled,
			"OK"
		}
	}
};

resource 'DITL' (2011) {
	{	/* array DITLarray: 9 elements */
		/* [1] */
		{15, 3, 34, 203},
		Control {
			enabled,
			213
		},
		/* [2] */
		{16, 214, 32, 289},
		StaticText {
			disabled,
			"Res ID:"
		},
		/* [3] */
		{17, 273, 33, 348},
		EditText {
			enabled,
			"0"
		},
		/* [4] */
		{92, 298, 112, 356},
		Button {
			enabled,
			"OK"
		},
		/* [5] */
		{92, 229, 112, 287},
		Button {
			enabled,
			"Cancel"
		},
		/* [6] */
		{55, 6, 71, 55},
		StaticText {
			disabled,
			"Height:"
		},
		/* [7] */
		{87, 7, 103, 52},
		StaticText {
			disabled,
			"Width:"
		},
		/* [8] */
		{55, 65, 71, 140},
		EditText {
			enabled,
			"48"
		},
		/* [9] */
		{87, 65, 103, 140},
		EditText {
			enabled,
			"48"
		}
	}
};

resource 'DITL' (2000) {
	{	/* array DITLarray: 33 elements */
		/* [1] */
		{12, 8, 31, 168},
		Control {
			enabled,
			214
		},
		/* [2] */
		{36, 8, 112, 220},
		Control {
			enabled,
			216
		},
		/* [3] */
		{60, 20, 80, 203},
		Control {
			enabled,
			215
		},
		/* [4] */
		{88, 20, 106, 151},
		CheckBox {
			enabled,
			"Offset Contents"
		},
		/* [5] */
		{12, 232, 112, 444},
		Control {
			enabled,
			204
		},
		/* [6] */
		{36, 248, 52, 307},
		StaticText {
			disabled,
			"Menu ID:"
		},
		/* [7] */
		{36, 318, 53, 380},
		EditText {
			enabled,
			"0"
		},
		/* [8] */
		{67, 249, 85, 383},
		CheckBox {
			enabled,
			"Multi-Value Menu"
		},
		/* [9] */
		{87, 249, 105, 364},
		CheckBox {
			enabled,
			"Menu On Right"
		},
		/* [10] */
		{121, 8, 209, 172},
		Control {
			enabled,
			202
		},
		/* [11] */
		{144, 20, 168, 148},
		Control {
			enabled,
			217
		},
		/* [12] */
		{180, 20, 196, 102},
		StaticText {
			disabled,
			"Resource ID:"
		},
		/* [13] */
		{180, 112, 197, 158},
		EditText {
			enabled,
			"0"
		},
		/* [14] */
		{121, 184, 209, 444},
		Control {
			enabled,
			209
		},
		/* [15] */
		{144, 196, 168, 344},
		Control {
			enabled,
			218
		},
		/* [16] */
		{180, 196, 196, 248},
		StaticText {
			disabled,
			"Offsets:"
		},
		/* [17] */
		{180, 264, 196, 280},
		StaticText {
			disabled,
			"H:"
		},
		/* [18] */
		{180, 289, 196, 340},
		EditText {
			enabled,
			"0"
		},
		/* [19] */
		{180, 352, 196, 368},
		StaticText {
			disabled,
			"V:"
		},
		/* [20] */
		{180, 378, 196, 429},
		EditText {
			enabled,
			"0"
		},
		/* [21] */
		{213, 8, 301, 264},
		Control {
			enabled,
			208
		},
		/* [22] */
		{236, 16, 256, 160},
		Control {
			enabled,
			219
		},
		/* [23] */
		{236, 164, 252, 209},
		StaticText {
			disabled,
			"Offset:"
		},
		/* [24] */
		{236, 220, 252, 248},
		EditText {
			enabled,
			"0"
		},
		/* [25] */
		{272, 16, 292, 192},
		Control {
			enabled,
			220
		},
		/* [26] */
		{232, 301, 249, 350},
		StaticText {
			disabled,
			"Height:"
		},
		/* [27] */
		{232, 357, 248, 408},
		EditText {
			enabled,
			"48"
		},
		/* [28] */
		{261, 300, 277, 347},
		StaticText {
			disabled,
			"Width:"
		},
		/* [29] */
		{261, 357, 277, 408},
		EditText {
			enabled,
			"48"
		},
		/* [30] */
		{312, 52, 332, 204},
		EditText {
			enabled,
			"Bevel Button"
		},
		/* [31] */
		{312, 8, 328, 43},
		StaticText {
			disabled,
			"Title:"
		},
		/* [32] */
		{316, 308, 336, 366},
		Button {
			enabled,
			"Cancel"
		},
		/* [33] */
		{316, 379, 336, 437},
		Button {
			enabled,
			"OK"
		}
	}
};

resource 'DITL' (1000) {
	{	/* array DITLarray: 23 elements */
		/* [1] */
		{285, 311, 305, 369},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{285, 238, 305, 296},
		Button {
			enabled,
			"Cancel"
		},
		/* [3] */
		{39, 9, 55, 79},
		StaticText {
			disabled,
			"Error Text:"
		},
		/* [4] */
		{40, 101, 56, 364},
		EditText {
			enabled,
			"You messed up big time!"
		},
		/* [5] */
		{69, 9, 85, 94},
		StaticText {
			disabled,
			"Explanation:"
		},
		/* [6] */
		{69, 101, 123, 364},
		EditText {
			enabled,
			"What the heck were you thinking, anyways"
			"! Geez, now we're going to have to start"
			" all over. Ugh."
		},
		/* [7] */
		{10, 238, 28, 344},
		CheckBox {
			enabled,
			"Movable"
		},
		/* [8] */
		{136, 9, 276, 368},
		Control {
			enabled,
			224
		},
		/* [9] */
		{155, 120, 187, 350},
		Control {
			enabled,
			221
		},
		/* [10] */
		{193, 120, 222, 349},
		Control {
			enabled,
			222
		},
		/* [11] */
		{228, 120, 261, 349},
		Control {
			enabled,
			223
		},
		/* [12] */
		{163, 24, 181, 100},
		StaticText {
			enabled,
			"Button 1:"
		},
		/* [13] */
		{198, 24, 216, 100},
		CheckBox {
			enabled,
			"Button 2"
		},
		/* [14] */
		{233, 24, 251, 100},
		CheckBox {
			enabled,
			"Button 3"
		},
		/* [15] */
		{162, 132, 180, 238},
		CheckBox {
			enabled,
			"Use Default"
		},
		/* [16] */
		{199, 132, 217, 238},
		CheckBox {
			enabled,
			"Use Default"
		},
		/* [17] */
		{233, 132, 251, 238},
		CheckBox {
			enabled,
			"Use Default"
		},
		/* [18] */
		{162, 246, 178, 321},
		EditText {
			enabled,
			"OK"
		},
		/* [19] */
		{199, 246, 215, 321},
		EditText {
			enabled,
			"Cancel"
		},
		/* [20] */
		{236, 246, 252, 321},
		EditText {
			enabled,
			"Don't Save"
		},
		/* [21] */
		{10, 10, 26, 85},
		StaticText {
			disabled,
			"Type:"
		},
		/* [22] */
		{9, 98, 25, 198},
		Control {
			enabled,
			225
		},
		/* [23] */
		{287, 7, 305, 139},
		CheckBox {
			enabled,
			"Show Help Button"
		}
	}
};

resource 'DITL' (2012) {
	{	/* array DITLarray: 5 elements */
		/* [1] */
		{78, 296, 98, 354},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{78, 225, 98, 283},
		Button {
			enabled,
			"Cancel"
		},
		/* [3] */
		{19, 6, 35, 41},
		StaticText {
			disabled,
			"Title:"
		},
		/* [4] */
		{20, 46, 36, 200},
		EditText {
			enabled,
			"Button"
		},
		/* [5] */
		{50, 8, 68, 133},
		CheckBox {
			enabled,
			"Add Default Ring"
		}
	}
};

resource 'DITL' (2013) {
	{	/* array DITLarray: 5 elements */
		/* [1] */
		{67, 250, 87, 308},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{67, 183, 87, 241},
		Button {
			enabled,
			"Cancel"
		},
		/* [3] */
		{10, 8, 26, 45},
		StaticText {
			disabled,
			"Title:"
		},
		/* [4] */
		{11, 47, 27, 152},
		EditText {
			enabled,
			""
		},
		/* [5] */
		{34, 47, 52, 195},
		CheckBox {
			enabled,
			"Auto toggle variant"
		}
	}
};

resource 'DITL' (5000) {
	{	/* array DITLarray: 4 elements */
		/* [1] */
		{8, 8, 26, 142},
		StaticText {
			disabled,
			"Appearance Sample"
		},
		/* [2] */
		{27, 8, 42, 243},
		StaticText {
			disabled,
			"by Edward Voas and Matt Ackeret"
		},
		/* [3] */
		{50, 8, 90, 358},
		StaticText {
			disabled,
			"CarbonLib 1.0.2 version of Appearance Sample"
		},
		/* [4] */
		{96, 300, 116, 358},
		Button {
			enabled,
			"OK"
		}
	}
};

resource 'DITL' (1004) {
	{	/* array DITLarray: 4 elements */
		/* [1] */
		{68, 48, 84, 268},
		Control {
			enabled,
			226
		},
		/* [2] */
		{118, 49, 135, 268},
		Control {
			enabled,
			227
		},
		/* [3] */
		{12, 6, 46, 323},
		StaticText {
			disabled,
			"Drag either the scroll bar or the slider"
			" to affect not only the number, but the "
			"other control."
		},
		/* [4] */
		{94, 142, 110, 176},
		StaticText {
			disabled,
			"0"
		}
	}
};

resource 'DITL' (6000) {
	{	/* array DITLarray: 1 elements */
		/* [1] */
		{10, -2, 242, 439},
		Control {
			enabled,
			228
		}
	}
};

resource 'DITL' (6001) {
	{	/* array DITLarray: 3 elements */
		/* [1] */
		{51, 18, 67, 175},
		Control {
			enabled,
			229
		},
		/* [2] */
		{77, 19, 93, 176},
		Control {
			enabled,
			230
		},
		/* [3] */
		{61, 204, 77, 220},
		Control {
			enabled,
			231
		}
	}
};

resource 'DITL' (6002) {
	{	/* array DITLarray: 9 elements */
		/* [1] */
		{34, 22, 55, 165},
		Control {
			enabled,
			232
		},
		/* [2] */
		{60, 22, 77, 165},
		Control {
			enabled,
			243
		},
		/* [3] */
		{90, 22, 106, 163},
		Control {
			enabled,
			234
		},
		/* [4] */
		{124, 23, 224, 45},
		Control {
			enabled,
			244
		},
		/* [5] */
		{123, 87, 223, 112},
		Control {
			enabled,
			235
		},
		/* [6] */
		{123, 143, 223, 163},
		Control {
			enabled,
			245
		},
		/* [7] */
		{171, 224, 189, 334},
		CheckBox {
			enabled,
			"Live feedback"
		},
		/* [8] */
		{139, 265, 156, 309},
		StaticText {
			disabled,
			"0"
		},
		/* [9] */
		{38, 224, 133, 351},
		Control {
			enabled,
			268
		}
	}
};

resource 'DITL' (6003) {
	{	/* array DITLarray: 15 elements */
		/* [1] */
		{51, 26, 71, 103},
		Button {
			enabled,
			"Engage"
		},
		/* [2] */
		{51, 122, 71, 199},
		Button {
			enabled,
			"Make It So"
		},
		/* [3] */
		{51, 223, 71, 300},
		Button {
			enabled,
			"Eject Core"
		},
		/* [4] */
		{51, 323, 71, 419},
		Button {
			enabled,
			"Raise Shields"
		},
		/* [5] */
		{85, 26, 106, 184},
		Control {
			enabled,
			240
		},
		/* [6] */
		{87, 236, 214, 404},
		UserItem {
			disabled
		},
		/* [7] */
		{87, 403, 214, 419},
		Control {
			enabled,
			238
		},
		/* [8] */
		{213, 236, 229, 404},
		Control {
			enabled,
			236
		},
		/* [9] */
		{112, 26, 130, 132},
		CheckBox {
			enabled,
			"Full Tune-Up"
		},
		/* [10] */
		{131, 43, 149, 219},
		CheckBox {
			enabled,
			"Replace constrictors"
		},
		/* [11] */
		{150, 43, 168, 198},
		CheckBox {
			enabled,
			"Adjust intermix ratio"
		},
		/* [12] */
		{174, 20, 219, 138},
		Control {
			enabled,
			286
		},
		/* [13] */
		{178, 25, 196, 132},
		RadioButton {
			enabled,
			"Dessert topping"
		},
		/* [14] */
		{196, 25, 214, 131},
		RadioButton {
			enabled,
			"Floor wax"
		},
		/* [15] */
		{178, 154, 197, 222},
		Button {
			enabled,
			"It's Both!"
		}
	}
};

resource 'DITL' (6004) {
	{	/* array DITLarray: 10 elements */
		/* [1] */
		{58, 188, 74, 263},
		StaticText {
			disabled,
			"Static Text"
		},
		/* [2] */
		{58, 281, 74, 356},
		StaticText {
			disabled,
			"Static Text"
		},
		/* [3] */
		{60, 31, 76, 143},
		EditText {
			enabled,
			"Edit Text"
		},
		/* [4] */
		{92, 31, 108, 143},
		Control {
			enabled,
			247
		},
		/* [5] */
		{123, 31, 139, 143},
		EditText {
			enabled,
			""
		},
		/* [6] */
		{153, 28, 180, 145},
		Control {
			enabled,
			241
		},
		/* [7] */
		{89, 189, 192, 398},
		Control {
			enabled,
			242
		},
		/* [8] */
		{195, 28, 215, 146},
		Button {
			enabled,
			"Show Password"
		},
		/* [9] */
		{194, 188, 210, 298},
		StaticText {
			disabled,
			"The password is:"
		},
		/* [10] */
		{212, 188, 228, 397},
		StaticText {
			disabled,
			""
		}
	}
};

resource 'DITL' (6005) {
	{	/* array DITLarray: 14 elements */
		/* [1] */
		{40, 15, 221, 229},
		Control {
			enabled,
			248
		},
		/* [2] */
		{64, 21, 216, 220},
		Control {
			enabled,
			252
		},
		/* [3] */
		{122, 237, 127, 417},
		Control {
			enabled,
			249
		},
		/* [4] */
		{139, 27, 214, 216},
		Control {
			enabled,
			251
		},
		/* [5] */
		{67, 24, 132, 142},
		Control {
			enabled,
			284
		},
		/* [6] */
		{70, 26, 88, 132},
		RadioButton {
			enabled,
			"Level 1"
		},
		/* [7] */
		{89, 26, 107, 132},
		RadioButton {
			enabled,
			"Level 2"
		},
		/* [8] */
		{108, 26, 126, 132},
		RadioButton {
			enabled,
			"Level 3"
		},
		/* [9] */
		{160, 35, 178, 213},
		CheckBox {
			enabled,
			"Use Millicochranes"
		},
		/* [10] */
		{184, 35, 202, 189},
		CheckBox {
			enabled,
			"Full Isolinear Check"
		},
		/* [11] */
		{48, 321, 118, 324},
		Control {
			enabled,
			269
		},
		/* [12] */
		{74, 258, 106, 290},
		Control {
			enabled,
			270
		},
		/* [13] */
		{74, 361, 106, 393},
		Control {
			enabled,
			271
		},
		/* [14] */
		{134, 259, 222, 393},
		Picture {
			disabled,
			132
		}
	}
};

resource 'DITL' (6006) {
	{	/* array DITLarray: 23 elements */
		/* [1] */
		{36, 17, 76, 57},
		Control {
			enabled,
			253
		},
		/* [2] */
		{81, 148, 105, 248},
		Control {
			enabled,
			254
		},
		/* [3] */
		{36, 148, 76, 188},
		Control {
			enabled,
			255
		},
		/* [4] */
		{35, 208, 75, 248},
		Control {
			enabled,
			256
		},
		/* [5] */
		{111, 148, 135, 248},
		Control {
			enabled,
			257
		},
		/* [6] */
		{36, 77, 76, 117},
		Control {
			enabled,
			258
		},
		/* [7] */
		{81, 17, 135, 117},
		Control {
			enabled,
			259
		},
		/* [8] */
		{35, 261, 59, 361},
		Control {
			enabled,
			260
		},
		/* [9] */
		{64, 261, 88, 361},
		Control {
			enabled,
			261
		},
		/* [10] */
		{198, 260, 230, 292},
		Control {
			enabled,
			262
		},
		/* [11] */
		{198, 322, 230, 354},
		Control {
			enabled,
			263
		},
		/* [12] */
		{95, 261, 193, 398},
		Control {
			enabled,
			265
		},
		/* [13] */
		{143, 149, 183, 189},
		Control {
			enabled,
			266
		},
		/* [14] */
		{152, 209, 175, 222},
		Control {
			enabled,
			267
		},
		/* [15] */
		{148, 18, 164, 34},
		Control {
			enabled,
			272
		},
		/* [16] */
		{148, 34, 164, 50},
		Control {
			enabled,
			273
		},
		/* [17] */
		{148, 50, 164, 66},
		Control {
			enabled,
			274
		},
		/* [18] */
		{166, 13, 188, 87},
		Control {
			enabled,
			285
		},
		/* [19] */
		{169, 18, 185, 34},
		Control {
			enabled,
			275
		},
		/* [20] */
		{169, 34, 185, 50},
		Control {
			enabled,
			276
		},
		/* [21] */
		{169, 50, 185, 66},
		Control {
			enabled,
			277
		},
		/* [22] */
		{169, 66, 185, 82},
		Control {
			enabled,
			278
		},
		/* [23] */
		{196, 15, 212, 31},
		Control {
			enabled,
			279
		},
		/* [24] */
		{196, 65, 228, 215},
		Control {
			enabled,
			290
		}
	}
};

resource 'DITL' (4000) {
	{	/* array DITLarray: 4 elements */
		/* [1] */
		{8, 53, 42, 358},
		StaticText {
			disabled,
			"Here's an example of auto-sizing of a di"
			"alog. Press the auto-size button to see "
			"the rest of this text. I purposely put m"
			"ore text than could be viewed in the spa"
			"ce allotted. AutoSizeDialog grows the di"
			"alog so that you can read all the text."
		},
		/* [2] */
		{68, 300, 88, 358},
		Button {
			enabled,
			"OK"
		},
		/* [3] */
		{69, 54, 89, 131},
		Button {
			enabled,
			"Auto-Size"
		},
		/* [4] */
		{9, 13, 41, 45},
		Icon {
			disabled,
			1
		}
	}
};

resource 'DITL' (7000) {
	{	/* array DITLarray: 0 elements */
	}
};

resource 'DITL' (2014) {
	{	/* array DITLarray: 3 elements */
		/* [1] */
		{59, 289, 79, 347},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{59, 218, 79, 276},
		Button {
			enabled,
			"Cancel"
		},
		/* [3] */
		{23, 8, 41, 233},
		CheckBox {
			enabled,
			"Password Style (show bullets)"
		}
	}
};

resource 'DITL' (2015) {
	{	/* array DITLarray: 4 elements */
		/* [1] */
		{59, 252, 79, 310},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{59, 181, 79, 239},
		Button {
			enabled,
			"Cancel"
		},
		/* [3] */
		{10, 57, 50, 310},
		EditText {
			enabled,
			"Sample Static Text"
		},
		/* [4] */
		{10, 10, 26, 49},
		StaticText {
			disabled,
			"Text:"
		}
	}
};

resource 'DITL' (2016) {
	{	/* array DITLarray: 6 elements */
		/* [1] */
		{110, 122, 130, 180},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{110, 53, 130, 111},
		Button {
			enabled,
			"Cancel"
		},
		/* [3] */
		{5, 8, 24, 133},
		RadioButton {
			enabled,
			"NonDirectional"
		},
		/* [4] */
		{24, 8, 42, 114},
		RadioButton {
			enabled,
			"Directional"
		},
		/* [5] */
		{42, 8, 60, 114},
		CheckBox {
			enabled,
			"TickMarks"
		},
		/* [6] */
		{59, 8, 78, 150},
		CheckBox {
			enabled,
			"Reverse Direction"
		}
	}
};

resource 'DITL' (2017) {
	{	/* array DITLarray: 7 elements */
		/* [1] */
		{125, 124, 145, 182},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{125, 52, 145, 110},
		Button {
			enabled,
			"Cancel"
		},
		/* [3] */
		{36, 9, 54, 61},
		RadioButton {
			enabled,
			"Time"
		},
		/* [4] */
		{53, 9, 70, 162},
		RadioButton {
			enabled,
			"Time with Seconds"
		},
		/* [5] */
		{70, 9, 88, 60},
		RadioButton {
			enabled,
			"Date"
		},
		/* [6] */
		{87, 9, 105, 119},
		RadioButton {
			enabled,
			"Month & Year"
		},
		/* [7] */
		{7, 9, 25, 158},
		StaticText {
			disabled,
			"Clock Control variant:"
		}
	}
};

resource 'DITL' (2018) {
	{	/* array DITLarray: 9 elements */
		/* [1] */
		{111, 263, 131, 321},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{111, 192, 131, 250},
		Button {
			enabled,
			"Cancel"
		},
		/* [3] */
		{27, 228, 45, 315},
		CheckBox {
			enabled,
			"Use Icons"
		},
		/* [4] */
		{30, 5, 46, 115},
		StaticText {
			disabled,
			"Number of Tabs:"
		},
		/* [5] */
		{30, 123, 46, 198},
		EditText {
			enabled,
			"4"
		},
		/* [6] */
		{62, 6, 107, 90},
		Control {
			enabled,
			287
		},
		/* [7] */
		{64, 8, 82, 79},
		RadioButton {
			enabled,
			"Large"
		},
		/* [8] */
		{64, 81, 82, 152},
		RadioButton {
			enabled,
			"Small"
		},
		/* [9] */
		{63, 160, 83, 314},
		Control {
			enabled,
			211
		}
	}
};

resource 'DITL' (2019) {
	{	/* array DITLarray: 7 elements */
		/* [1] */
		{101, 7, 121, 130},
		Button {
			enabled,
			"Remove Proxy"
		},
		/* [2] */
		{128, 7, 148, 130},
		Button {
			enabled,
			"Add Proxy Fsspec"
		},
		/* [3] */
		{99, 147, 119, 260},
		Button {
			enabled,
			"Add Proxy Alias"
		},
		/* [4] */
		{128, 147, 148, 260},
		Button {
			enabled,
			"Set specific icon"
		},
		/* [5] */
		{9, 147, 54, 247},
		Control {
			enabled,
			288
		},
		/* [6] */
		{9, 7, 25, 133},
		StaticText {
			disabled,
			"Current proxy icon:"
		},
		/* [7] */
		{73, 7, 91, 144},
		Control {
			enabled,
			289
		}
	}
};

resource 'DITL' (2020) {
	{	/* array DITLarray: 0 elements */
	}
};

resource 'DITL' (3000) {
	{	/* array DITLarray: 5 elements */
		/* [1] */
		{85, 394, 105, 452},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{29, 15, 45, 181},
		StaticText {
			disabled,
			"This dialog will go away in"
		},
		/* [3] */
		{29, 183, 45, 200},
		StaticText {
			disabled,
			"10"
		},
		/* [4] */
		{29, 202, 45, 442},
		StaticText {
			disabled,
			"seconds with no user action. Mouse"
		},
		/* [5] */
		{52, 15, 67, 450},
		StaticText {
			disabled,
			"movement or keypresses will reset the ti"
			"mer to the starting value."
		}
	}
};

resource 'MBAR' (128) {
	{	/* array MenuArray: 5 elements */
		/* [1] */
		128,
		/* [2] */
		129,
		/* [3] */
		130,
		/* [4] */
		145,
		/* [5] */
		148
	}
};

resource 'MENU' (128) {
	128,
	63,
	0x7FFFFFFD,
	enabled,
	apple,
	{	/* array: 2 elements */
		/* [1] */
		"About Appearance Sample", noIcon, noKey, noMark, plain,
		/* [2] */
		"-", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (129) {
	129,
	63,
	0x7FFFFFFD,
	enabled,
	"File",
	{	/* array: 3 elements */
		/* [1] */
		"Close", noIcon, "W", noMark, plain,
		/* [2] */
		"-", noIcon, noKey, noMark, plain,
		/* [3] */
		"Quit", noIcon, "Q", noMark, plain
	}
};

resource 'MENU' (131) {
	131,
	63,
	0x7FFFFF77,
	enabled,
	"Popup Button",
	{	/* array: 10 elements */
		/* [1] */
		"Do a little dance", noIcon, noKey, noMark, plain,
		/* [2] */
		"Make a little love", noIcon, noKey, noMark, plain,
		/* [3] */
		"Get down tonight", noIcon, noKey, noMark, plain,
		/* [4] */
		"-", noIcon, noKey, noMark, plain,
		/* [5] */
		"Hood Rat", noIcon, noKey, noMark, plain,
		/* [6] */
		"Hood Rat", noIcon, noKey, noMark, plain,
		/* [7] */
		"Hoochie Mama", noIcon, noKey, noMark, plain,
		/* [8] */
		"-", noIcon, noKey, noMark, plain,
		/* [9] */
		"Get on up", noIcon, noKey, noMark, plain,
		/* [10] */
		"Get Down", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (132) {
	131,
	63,
	0x7FFFFFF7,
	enabled,
	"Popup Button",
	{	/* array: 5 elements */
		/* [1] */
		"One For The Money", noIcon, noKey, noMark, plain,
		/* [2] */
		"Two For The Show", noIcon, noKey, noMark, plain,
		/* [3] */
		"Three To Get Ready", noIcon, noKey, noMark, plain,
		/* [4] */
		"-", noIcon, noKey, noMark, plain,
		/* [5] */
		"Gotta Get up, Get Down", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (133) {
	133,
	63,
	allEnabled,
	enabled,
	"CDEF Tester",
	{	/* array: 24 elements */
		/* [1] */
		"Bevel Buttons", noIcon, noKey, noMark, plain,
		/* [2] */
		"Chasing Arrows", noIcon, noKey, noMark, plain,
		/* [3] */
		"Disclosure Triangle", noIcon, noKey, noMark, plain,
		/* [4] */
		"Visual Separator", noIcon, noKey, noMark, plain,
		/* [5] */
		"Edit Text", noIcon, noKey, noMark, plain,
		/* [6] */
		"Finder Header", noIcon, noKey, noMark, plain,
		/* [7] */
		"Group Box", noIcon, noKey, noMark, plain,
		/* [8] */
		"Icon CDEF", noIcon, noKey, noMark, plain,
		/* [9] */
		"Image Well", noIcon, noKey, noMark, plain,
		/* [10] */
		"Little Arrows", noIcon, noKey, noMark, plain,
		/* [11] */
		"Picture CDEF", noIcon, noKey, noMark, plain,
		/* [12] */
		"Placard", noIcon, noKey, noMark, plain,
		/* [13] */
		"Popup Arrow", noIcon, noKey, noMark, plain,
		/* [14] */
		"Progress Bar", noIcon, noKey, noMark, plain,
		/* [15] */
		"Scroll Bar", noIcon, noKey, noMark, plain,
		/* [16] */
		"Static Text", noIcon, noKey, noMark, plain,
		/* [17] */
		"Tabs", noIcon, noKey, noMark, plain,
		/* [18] */
		"User Pane", noIcon, noKey, noMark, plain,
		/* [19] */
		"Push Button", noIcon, noKey, noMark, plain,
		/* [20] */
		"Check Box", noIcon, noKey, noMark, plain,
		/* [21] */
		"Radio Button", noIcon, noKey, noMark, plain,
		/* [22] */
		"Slider", noIcon, noKey, noMark, plain,
		/* [23] */
		"Clock", noIcon, noKey, noMark, plain,
		/* [24] */
		"List", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (134) {
	134,
	63,
	allEnabled,
	enabled,
	"Title",
	{	/* array: 3 elements */
		/* [1] */
		"Text Title", noIcon, noKey, noMark, plain,
		/* [2] */
		"Check Box Title", noIcon, noKey, noMark, plain,
		/* [3] */
		"Popup Button Title", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (135) {
	135,
	63,
	allEnabled,
	enabled,
	"Title",
	{	/* array: 4 elements */
		/* [1] */
		"East", noIcon, noKey, noMark, plain,
		/* [2] */
		"West", noIcon, noKey, noMark, plain,
		/* [3] */
		"North", noIcon, noKey, noMark, plain,
		/* [4] */
		"South", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (136) {
	136,
	63,
	allEnabled,
	enabled,
	"Title",
	{	/* array: 3 elements */
		/* [1] */
		"Icon Suite", noIcon, noKey, noMark, plain,
		/* [2] */
		"Color Icon", noIcon, noKey, noMark, plain,
		/* [3] */
		"Picture", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (137) {
	137,
	63,
	allEnabled,
	enabled,
	"Title",
	{	/* array: 3 elements */
		/* [1] */
		"Small", noIcon, noKey, noMark, plain,
		/* [2] */
		"Normal", noIcon, noKey, noMark, plain,
		/* [3] */
		"Large", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (138) {
	138,
	63,
	allEnabled,
	enabled,
	"Title",
	{	/* array: 3 elements */
		/* [1] */
		"Momentary", noIcon, noKey, noMark, plain,
		/* [2] */
		"Toggles", noIcon, noKey, noMark, plain,
		/* [3] */
		"Sticky", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (140) {
	140,
	63,
	allEnabled,
	enabled,
	"Untitled",
	{	/* array: 10 elements */
		/* [1] */
		"Sys Direction", noIcon, noKey, noMark, plain,
		/* [2] */
		"Center", noIcon, noKey, noMark, plain,
		/* [3] */
		"Left", noIcon, noKey, noMark, plain,
		/* [4] */
		"Right", noIcon, noKey, noMark, plain,
		/* [5] */
		"Top", noIcon, noKey, noMark, plain,
		/* [6] */
		"Bottom", noIcon, noKey, noMark, plain,
		/* [7] */
		"Top Left", noIcon, noKey, noMark, plain,
		/* [8] */
		"Bottom Left", noIcon, noKey, noMark, plain,
		/* [9] */
		"Top Right", noIcon, noKey, noMark, plain,
		/* [10] */
		"Bottom Right", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (141) {
	141,
	63,
	allEnabled,
	enabled,
	"Untitled",
	{	/* array: 4 elements */
		/* [1] */
		"Sys Direction", noIcon, noKey, noMark, plain,
		/* [2] */
		"Flush Left", noIcon, noKey, noMark, plain,
		/* [3] */
		"Flush Right", noIcon, noKey, noMark, plain,
		/* [4] */
		"Centered", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (142) {
	142,
	63,
	allEnabled,
	enabled,
	"Untitled",
	{	/* array: 6 elements */
		/* [1] */
		"Normally", noIcon, noKey, noMark, plain,
		/* [2] */
		"Left of Graphic", noIcon, noKey, noMark, plain,
		/* [3] */
		"Right of Graphic", noIcon, noKey, noMark, plain,
		/* [4] */
		"Above Graphic", noIcon, noKey, noMark, plain,
		/* [5] */
		"Below Graphic", noIcon, noKey, noMark, plain,
		/* [6] */
		"Sys Direction", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (143) {
	143,
	63,
	allEnabled,
	enabled,
	"WYSIWYG",
	{	/* array: 0 elements */
	}
};

resource 'MENU' (144) {
	144,
	63,
	allEnabled,
	enabled,
	"StandardAlert",
	{	/* array: 3 elements */
		/* [1] */
		"Stop", noIcon, noKey, noMark, plain,
		/* [2] */
		"Note", noIcon, noKey, noMark, plain,
		/* [3] */
		"Caution", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (139) {
	139,
	63,
	allEnabled,
	enabled,
	"Untitled",
	{	/* array: 4 elements */
		/* [1] */
		"Text Only", noIcon, noKey, noMark, plain,
		/* [2] */
		"Icon Suite", noIcon, noKey, noMark, plain,
		/* [3] */
		"Color Icon", noIcon, noKey, noMark, plain,
		/* [4] */
		"Picture", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (146) {
	146,
	textMenuProc,
	0x7FFFFFEF,
	enabled,
	"Title",
	{	/* array: 9 elements */
		/* [1] */
		"Got me a car", noIcon, noKey, noMark, plain,
		/* [2] */
		"It's as big as a whale", noIcon, noKey, noMark, plain,
		/* [3] */
		"And I'm headin' on down", noIcon, noKey, noMark, plain,
		/* [4] */
		"To the Love Shack", noIcon, noKey, noMark, plain,
		/* [5] */
		"-", noIcon, noKey, noMark, plain,
		/* [6] */
		"Got me a Chrysler", noIcon, noKey, noMark, plain,
		/* [7] */
		"It seats about twenty", noIcon, noKey, noMark, plain,
		/* [8] */
		"So hurry up, and bring", noIcon, noKey, noMark, plain,
		/* [9] */
		"Your juke box money", noIcon, hierarchicalMenu, "Ï", plain
	}
};

resource 'MENU' (147) {
	147,
	textMenuProc,
	allEnabled,
	enabled,
	"Hier",
	{	/* array: 3 elements */
		/* [1] */
		"Item 1", noIcon, noKey, noMark, plain,
		/* [2] */
		"Item 2", noIcon, noKey, noMark, plain,
		/* [3] */
		"Item 3", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (130) {
	130,
	63,
	0x7FFFFFF7,
	enabled,
	"Examples",
	{	/* array: 15 elements */
		/* [1] */
		"Finder-like Window", noIcon, "1", noMark, plain,
		/* [2] */
		"Dialog-like Window", noIcon, "2", noMark, plain,
		/* [3] */
		"Bevel Button Dialog", noIcon, "3", noMark, plain,
		/* [4] */
		"NewThemeDialog", noIcon, "4", noMark, plain,
		/* [5] */
		"Standard Alertä", noIcon, "5", noMark, plain,
		/* [6] */
		"Bevel Button Content", noIcon, "6", noMark, plain,
		/* [7] */
		"CDEF Tester", noIcon, "7", noMark, plain,
		/* [8] */
		"Live Feeback Dialog", noIcon, "8", noMark, plain,
		/* [9] */
		"Mega Dialog", noIcon, "M", noMark, plain,
		/* [10] */
		"Utility Window", noIcon, "U", noMark, plain,
		/* [11] */
		"Side Utility Window", noIcon, "S", noMark, plain,
		/* [12] */
		"AutoSizeDialog", noIcon, "A", noMark, plain,
		/* [13] */
		"Vertical Zoom", noIcon, noKey, noMark, plain,
		/* [14] */
		"Horizontal Zoom", noIcon, noKey, noMark, plain,
		/* [15] */
		"ProxyPath Dialog", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (148) {
	148,
	textMenuProc,
	allEnabled,
	enabled,
	"Test API",
	{	/* array: 5 elements */
		/* [1] */
		"Menu Drawing", noIcon, noKey, noMark, plain,
		/* [2] */
		"Dump Control Hierarchy", noIcon, noKey, noMark, plain,
		/* [3] */
		"Hide Menu", noIcon, "H", noMark, plain,
		/* [4] */
		"Dialog Timeouts", noIcon, noKey, noMark, plain,
		/* [5] */
		"SetThemeCursor", noIcon, noKey, noMark, plain
	}
};


resource 'MENU' (145) {
	145,
	63,
	allEnabled,
	enabled,
	"Modifiers",
	{	/* array: 60 elements */
		/* [1] */
		"Normal", noIcon, "J", noMark, plain,
		/* [2] */
		"Cmd-Shift", noIcon, "G", noMark, plain,
		/* [3] */
		"Cmd-Shift-Option", noIcon, "Y", noMark, plain,
		/* [4] */
		"Cmd-Shift-Option-Ctrl", noIcon, "E", noMark, plain,
		/* [5] */
		"Command-Delete", noIcon, noKey, noMark, plain,
		/* [6] */
		"Icon Suites", noIcon, noKey, noMark, plain,
		/* [7] */
		"left-to-right tab", noIcon, "`", noMark, plain,
		/* [8] */
		"right-to-left tab", noIcon, "`", noMark, plain,
		/* [9] */
		"enter", noIcon, "`", noMark, plain,
		/* [10] */
		"shift", noIcon, "`", noMark, plain,
		/* [11] */
		"control", noIcon, "`", noMark, plain,
		/* [12] */
		"option", noIcon, "`", noMark, plain,
		/* [13] */
		"null", noIcon, "`", noMark, plain,
		/* [14] */
		"space", noIcon, "`", noMark, plain,
		/* [15] */
		"delete left", noIcon, "`", noMark, plain,
		/* [16] */
		"left-to-right return", noIcon, "`", noMark, plain,
		/* [17] */
		"right-to-left return", noIcon, "`", noMark, plain,
		/* [18] */
		"nonmarking return", noIcon, "`", noMark, plain,
		/* [19] */
		"pencil", noIcon, "`", noMark, plain,
		/* [20] */
		"downward dashed arrow", noIcon, "`", noMark, plain,
		/* [21] */
		"command", noIcon, "`", noMark, plain,
		/* [22] */
		"checkmark", noIcon, "`", noMark, plain,
		/* [23] */
		"diamond", noIcon, "`", noMark, plain,
		/* [24] */
		"apple logo filled", noIcon, "`", noMark, plain,
		/* [25] */
		"delete right", noIcon, "`", noMark, plain,
		/* [26] */
		"leftward dashed arrow", noIcon, "`", noMark, plain,
		/* [27] */
		"upward dashed arrow", noIcon, "`", noMark, plain,
		/* [28] */
		"rightward dashed arrow", noIcon, "`", noMark, plain,
		/* [29] */
		"escape", noIcon, "`", noMark, plain,
		/* [30] */
		"clear", noIcon, "`", noMark, plain,
		/* [31] */
		"blank", noIcon, "`", noMark, plain,
		/* [32] */
		"page up", noIcon, "`", noMark, plain,
		/* [33] */
		"caps lock", noIcon, "`", noMark, plain,
		/* [34] */
		"left arrow", noIcon, "`", noMark, plain,
		/* [35] */
		"right arrow", noIcon, "`", noMark, plain,
		/* [36] */
		"northwest arrow", noIcon, "`", noMark, plain,
		/* [37] */
		"help", noIcon, "`", noMark, plain,
		/* [38] */
		"up arrow", noIcon, "`", noMark, plain,
		/* [39] */
		"southeast arrow", noIcon, "`", noMark, plain,
		/* [40] */
		"down arrow", noIcon, "`", noMark, plain,
		/* [41] */
		"page down", noIcon, "`", noMark, plain,
		/* [42] */
		"apple logo unfilled", noIcon, "`", noMark, plain,
		/* [43] */
		"contextual menu", noIcon, "`", noMark, plain,
		/* [44] */
		"power", noIcon, "`", noMark, plain,
		/* [45] */
		"f1", noIcon, "`", noMark, plain,
		/* [46] */
		"f2", noIcon, "`", noMark, plain,
		/* [47] */
		"f3", noIcon, "`", noMark, plain,
		/* [48] */
		"f4", noIcon, "`", noMark, plain,
		/* [49] */
		"f5", noIcon, "`", noMark, plain,
		/* [50] */
		"f6", noIcon, "`", noMark, plain,
		/* [51] */
		"f7", noIcon, "`", noMark, plain,
		/* [52] */
		"f8", noIcon, "`", noMark, plain,
		/* [53] */
		"f9", noIcon, "`", noMark, plain,
		/* [54] */
		"f10", noIcon, "`", noMark, plain,
		/* [55] */
		"f11", noIcon, "`", noMark, plain,
		/* [56] */
		"f12", noIcon, "`", noMark, plain,
		/* [57] */
		"f13", noIcon, "`", noMark, plain,
		/* [58] */
		"f14", noIcon, "`", noMark, plain,
		/* [59] */
		"f15", noIcon, "`", noMark, plain,
		/* [60] */
		"control key (ISO)", noIcon, "`", noMark, plain
	}
};

resource 'MENU' (149) {
	149,
	textMenuProc,
	allEnabled,
	enabled,
	"Title",
	{	/* array: 17 elements */
		/* [1] */
		"Arrow", noIcon, noKey, noMark, plain,
		/* [2] */
		"CopyArrow", noIcon, noKey, noMark, plain,
		/* [3] */
		"AliasArrow", noIcon, noKey, noMark, plain,
		/* [4] */
		"ContextualMenuArrow", noIcon, noKey, noMark, plain,
		/* [5] */
		"IBeam", noIcon, noKey, noMark, plain,
		/* [6] */
		"Cross", noIcon, noKey, noMark, plain,
		/* [7] */
		"Plus", noIcon, noKey, noMark, plain,
		/* [8] */
		"Watch", noIcon, noKey, noMark, plain,
		/* [9] */
		"ClosedHand", noIcon, noKey, noMark, plain,
		/* [10] */
		"OpenHand", noIcon, noKey, noMark, plain,
		/* [11] */
		"CountingUpHand", noIcon, noKey, noMark, plain,
		/* [12] */
		"CountingDownHand", noIcon, noKey, noMark, plain,
		/* [13] */
		"CountingUpAndDownHand", noIcon, noKey, noMark, plain,
		/* [14] */
		"Spinning", noIcon, noKey, noMark, plain,
		/* [15] */
		"ResizeLeft", noIcon, noKey, noMark, plain,
		/* [16] */
		"ResizeRight", noIcon, noKey, noMark, plain,
		/* [17] */
		"ResizeLeftRight", noIcon, noKey, noMark, plain
	}
};

resource 'SIZE' (-1, "Our SIZE -1") {
	reserved,
	acceptSuspendResumeEvents,
	reserved,
	canBackground,
	multiFinderAware,
	backgroundAndForeground,
	getFrontClicks,
	ignoreChildDiedEvents,
	is32BitCompatible,
	isHighLevelEventAware,
	onlyLocalHLEvents,
	notStationeryAware,
	dontUseTextEditServices,
	reserved,
	reserved,
	reserved,
	2048576,
	2048576
};

data 'WIND' (128) {
	$"0089 007A 011B 01CA 0401 0100 0100 0000"            /* .‚.z...†........ */
	$"0000 1246 696E 6465 722D 4C69 6B65 2057"            /* ...Finder-Like W */
	$"696E 646F 77"                                       /* indow */
};

data 'WIND' (129) {
	$"0089 007A 011B 01CA 0400 0100 0100 0000"            /* .‚.z...†........ */
	$"0000 1044 6961 6C6F 6720 5369 6D75 6C61"            /* ...Dialog Simula */
	$"746F 72"                                            /* tor */
};

data 'WIND' (130) {
	$"0036 0027 014F 01D6 0400 0100 0100 0000"            /* .6.'.O.˜........ */
	$"0000 0B43 4445 4620 5465 7374 6572"                 /* ...CDEF Tester */
};

data 'WIND' (131) {
	$"005F 0053 00A9 017C 0423 0100 0100 0000"            /* ._.S.©.|.#...... */
	$"0000 0E55 7469 6C69 7479 2057 696E 646F"            /* ...Utility Windo */
	$"77"                                                 /* w */
};

data 'WIND' (132) {
	$"0085 0068 00CF 0191 0433 0100 0100 0000"            /* .÷.h.¶.Î.3...... */
	$"0000 0E55 7469 6C69 7479 2057 696E 646F"            /* ...Utility Windo */
	$"77"                                                 /* w */
};

data 'WIND' (133) {
	$"0028 0028 00F0 0118 0402 0100 0100 0000"            /* .(.(.ï.......... */
	$"0000 0D56 6572 7469 6361 6C20 5A6F 6F6D"            /* ..¨Vertical Zoom */
};

data 'WIND' (134) {
	$"0028 0028 00F0 0118 0404 0100 0100 0000"            /* .(.(.ï.......... */
	$"0000 0F48 6F72 697A 6F6E 7461 6C20 5A6F"            /* ...Horizontal Zo */
	$"6F6D"                                               /* om */
};

data 'WIND' (200) {
	$"0072 003F 0147 01C4 0000 0100 0100 0000"            /* .r.?.G.ü........ */
	$"0000 0C4D 656E 7520 4472 6177 696E 67"              /* ...Menu Drawing */
};

resource 'clut' (-10237) {
	{	/* array ColorSpec: 12 elements */
		/* [1] */
		0, 0, 0,
		/* [2] */
		65535, 65535, 65535,
		/* [3] */
		0, 0, 0,
		/* [4] */
		43690, 43690, 43690,
		/* [5] */
		65535, 65535, 65535,
		/* [6] */
		65535, 65535, 65535,
		/* [7] */
		43690, 43690, 43690,
		/* [8] */
		43690, 43690, 43690,
		/* [9] */
		21845, 21845, 21845,
		/* [10] */
		21845, 21845, 21845,
		/* [11] */
		56797, 56797, 56797,
		/* [12] */
		21845, 21845, 21845
	}
};

resource 'clut' (-10236) {
	{	/* array ColorSpec: 12 elements */
		/* [1] */
		0, 0, 0,
		/* [2] */
		43690, 43690, 43690,
		/* [3] */
		0, 0, 0,
		/* [4] */
		43690, 43690, 43690,
		/* [5] */
		65535, 65535, 65535,
		/* [6] */
		21845, 21845, 21845,
		/* [7] */
		43690, 43690, 43690,
		/* [8] */
		43690, 43690, 43690,
		/* [9] */
		21845, 21845, 21845,
		/* [10] */
		8738, 8738, 8738,
		/* [11] */
		21845, 21845, 21845,
		/* [12] */
		43690, 43690, 43690
	}
};

resource 'clut' (-10235) {
	{	/* array ColorSpec: 12 elements */
		/* [1] */
		21845, 21845, 21845,
		/* [2] */
		65535, 65535, 65535,
		/* [3] */
		21845, 21845, 21845,
		/* [4] */
		61166, 61166, 61166,
		/* [5] */
		61166, 61166, 61166,
		/* [6] */
		65535, 65535, 65535,
		/* [7] */
		65535, 65535, 65535,
		/* [8] */
		61166, 61166, 61166,
		/* [9] */
		61166, 61166, 61166,
		/* [10] */
		21845, 21845, 21845,
		/* [11] */
		65535, 65535, 65535,
		/* [12] */
		65535, 65535, 65535
	}
};

resource 'dctb' (-1) {
	{	/* array ColorSpec: 5 elements */
		/* [1] */
		wContentColor, 56797, 56797, 56797,
		/* [2] */
		wFrameColor, 0, 0, 0,
		/* [3] */
		wTextColor, 0, 0, 0,
		/* [4] */
		wHiliteColor, 0, 0, 0,
		/* [5] */
		wTitleBarColor, 65535, 65535, 65535
	}
};

resource 'dctb' (2000) {
	{	/* array ColorSpec: 5 elements */
		/* [1] */
		wContentColor, 65535, 65535, 65535,
		/* [2] */
		wFrameColor, 0, 0, 0,
		/* [3] */
		wTextColor, 0, 0, 0,
		/* [4] */
		wHiliteColor, 0, 0, 0,
		/* [5] */
		wTitleBarColor, 65535, 65535, 65535
	}
};

resource 'cctb' (128) {
	{	/* array ColorSpec: 4 elements */
		/* [1] */
		cFrameColor, 0, 0, 0,
		/* [2] */
		cBodyColor, 65535, 65535, 65535,
		/* [3] */
		cTextColor, 0, 0, 0,
		/* [4] */
		cElevatorColor, 65535, 65535, 65535
	}
};

resource 'cctb' (129) {
	{	/* array ColorSpec: 4 elements */
		/* [1] */
		cFrameColor, 0, 0, 0,
		/* [2] */
		cBodyColor, 65535, 65535, 65535,
		/* [3] */
		cTextColor, 0, 0, 0,
		/* [4] */
		cElevatorColor, 65535, 65535, 65535
	}
};

resource 'cctb' (130) {
	{	/* array ColorSpec: 4 elements */
		/* [1] */
		cFrameColor, 0, 0, 0,
		/* [2] */
		cBodyColor, 65535, 65535, 65535,
		/* [3] */
		cTextColor, 0, 0, 0,
		/* [4] */
		cElevatorColor, 65535, 65535, 65535
	}
};

resource 'cctb' (132) {
	{	/* array ColorSpec: 4 elements */
		/* [1] */
		cFrameColor, 0, 0, 0,
		/* [2] */
		cBodyColor, 65535, 65535, 65535,
		/* [3] */
		cTextColor, 0, 0, 0,
		/* [4] */
		cElevatorColor, 65535, 65535, 65535
	}
};

resource 'cctb' (133) {
	{	/* array ColorSpec: 4 elements */
		/* [1] */
		cFrameColor, 0, 0, 0,
		/* [2] */
		cBodyColor, 65535, 65535, 65535,
		/* [3] */
		cTextColor, 0, 0, 0,
		/* [4] */
		cElevatorColor, 65535, 65535, 65535
	}
};

resource 'cctb' (131) {
	{	/* array ColorSpec: 4 elements */
		/* [1] */
		cFrameColor, 0, 0, 0,
		/* [2] */
		cBodyColor, 65535, 65535, 65535,
		/* [3] */
		cTextColor, 0, 0, 0,
		/* [4] */
		cElevatorColor, 65535, 65535, 65535
	}
};

resource 'cctb' (135) {
	{	/* array ColorSpec: 4 elements */
		/* [1] */
		cFrameColor, 0, 0, 0,
		/* [2] */
		cBodyColor, 65535, 65535, 65535,
		/* [3] */
		cTextColor, 0, 0, 0,
		/* [4] */
		cElevatorColor, 65535, 65535, 65535
	}
};

resource 'cctb' (136) {
	{	/* array ColorSpec: 4 elements */
		/* [1] */
		cFrameColor, 0, 0, 0,
		/* [2] */
		cBodyColor, 65535, 65535, 65535,
		/* [3] */
		cTextColor, 0, 0, 0,
		/* [4] */
		cElevatorColor, 65535, 65535, 65535
	}
};

resource 'cctb' (177) {
	{	/* array ColorSpec: 4 elements */
		/* [1] */
		cFrameColor, 0, 0, 0,
		/* [2] */
		cBodyColor, 65535, 65535, 65535,
		/* [3] */
		cTextColor, 0, 0, 0,
		/* [4] */
		cElevatorColor, 65535, 65535, 65535
	}
};

resource 'cctb' (217) {
	{	/* array ColorSpec: 4 elements */
		/* [1] */
		cFrameColor, 0, 0, 0,
		/* [2] */
		cBodyColor, 65535, 65535, 65535,
		/* [3] */
		cTextColor, 0, 0, 0,
		/* [4] */
		cElevatorColor, 65535, 65535, 65535
	}
};

resource 'cctb' (218) {
	{	/* array ColorSpec: 4 elements */
		/* [1] */
		cFrameColor, 0, 0, 0,
		/* [2] */
		cBodyColor, 65535, 65535, 65535,
		/* [3] */
		cTextColor, 0, 0, 0,
		/* [4] */
		cElevatorColor, 65535, 65535, 65535
	}
};

resource 'cctb' (220) {
	{	/* array ColorSpec: 4 elements */
		/* [1] */
		cFrameColor, 0, 0, 0,
		/* [2] */
		cBodyColor, 65535, 65535, 65535,
		/* [3] */
		cTextColor, 0, 0, 0,
		/* [4] */
		cElevatorColor, 65535, 65535, 65535
	}
};

resource 'CNTL' (129) {
	{44, 16, 76, 216},
	0,
	visible,
	255,
	0,
	2050,
	0,
	"Green"
};

resource 'CNTL' (128) {
	{76, 16, 108, 216},
	0,
	visible,
	255,
	0,
	2049,
	0,
	"Red"
};

resource 'CNTL' (130) {
	{108, 16, 140, 216},
	0,
	visible,
	255,
	0,
	2048,
	0,
	"Blue"
};

resource 'CNTL' (131, purgeable) {
	{116, 200, 300, 216},
	0,
	visible,
	1,
	0,
	48,
	0,
	""
};

resource 'CNTL' (132) {
	{268, 288, 288, 346},
	0,
	visible,
	100,
	0,
	4,
	0,
	"OK"
};

resource 'CNTL' (133) {
	{240, 16, 260, 219},
	0,
	visible,
	67,
	133,
	1009,
	0,
	"Peaches:"
};

resource 'CNTL' (134) {
	{116, 16, 140, 40},
	131,
	visible,
	128,
	-1,
	65,
	0,
	""
};

resource 'CNTL' (136, purgeable) {
	{116, 104, 168, 160},
	0,
	visible,
	128,
	3,
	65,
	0,
	""
};

resource 'CNTL' (135, purgeable) {
	{116, 48, 156, 88},
	0,
	visible,
	0,
	2,
	64,
	0,
	""
};

resource 'CNTL' (137) {
	{0, 0, 100, 100},
	0,
	visible,
	128,
	2,
	66,
	0,
	""
};

resource 'CNTL' (160) {
	{0, 0, 219, 349},
	0,
	visible,
	0,
	0,
	1104,
	0,
	"CNTL"
};

resource 'CNTL' (161) {
	{0, 0, 20, 100},
	0,
	visible,
	0,
	0,
	160,
	0,
	"CNTL"
};

resource 'CNTL' (162) {
	{0, 0, 20, 100},
	0,
	visible,
	0,
	0,
	160,
	0,
	"CNTL"
};

resource 'CNTL' (163) {
	{0, 0, 16, 150},
	50,
	visible,
	100,
	0,
	scrollBarProc,
	0,
	"CNTL"
};

resource 'CNTL' (164) {
	{0, 0, 16, 150},
	50,
	visible,
	100,
	0,
	scrollBarProc,
	0,
	"CNTL"
};

resource 'CNTL' (165) {
	{0, 0, 100, 16},
	50,
	visible,
	100,
	0,
	scrollBarProc,
	0,
	"CNTL"
};

resource 'CNTL' (166) {
	{0, 0, 16, 110},
	0,
	visible,
	2,
	0,
	radioButProc,
	0,
	"Radio Button"
};

resource 'CNTL' (167) {
	{0, 0, 16, 110},
	0,
	visible,
	2,
	0,
	checkBoxProc,
	0,
	"Check Box"
};

resource 'CNTL' (168) {
	{0, 0, 16, 300},
	50,
	visible,
	100,
	0,
	scrollBarProc,
	0,
	"CNTL"
};

resource 'CNTL' (138, "Bevel Buttons - Small Bevel Empty") {
	{0, 0, 36, 36},
	0,
	visible,
	0,
	0,
	32,
	0,
	""
};

resource 'CNTL' (139, "Bevel Buttons - Medium Bevel Empty") {
	{0, 0, 36, 36},
	0,
	visible,
	0,
	0,
	33,
	0,
	""
};

resource 'CNTL' (140, "Bevel Buttons - Large Bevel Empty") {
	{0, 0, 36, 36},
	0,
	visible,
	0,
	0,
	34,
	0,
	""
};

resource 'CNTL' (141, "Bevel Buttons - Small Bevel w/Text") {
	{0, 0, 24, 24},
	0,
	visible,
	0,
	0,
	32,
	0,
	"Testing"
};

resource 'CNTL' (142, "Bevel Buttons - Medium Bevel w/Text") {
	{0, 0, 24, 36},
	0,
	visible,
	0,
	0,
	33,
	0,
	"Testing"
};

resource 'CNTL' (143, "Bevel Buttons - Large Bevel w/Text") {
	{0, 0, 24, 60},
	0,
	visible,
	0,
	0,
	34,
	0,
	"Testing"
};

resource 'CNTL' (144, "Bevel Buttons - Small Bevel w/Icon") {
	{0, 0, 24, 24},
	0,
	visible,
	128,
	1,
	32,
	0,
	""
};

resource 'CNTL' (145, "Bevel Buttons - Medium Bevel w/Icon") {
	{0, 0, 36, 36},
	0,
	visible,
	128,
	1,
	33,
	0,
	""
};

resource 'CNTL' (146, "Bevel Buttons - Large Bevel w/Icon") {
	{0, 0, 48, 48},
	0,
	visible,
	128,
	1,
	34,
	0,
	""
};

resource 'CNTL' (147, "Bevel Buttons - Small Bevel w/Picture") {
	{0, 0, 24, 24},
	0,
	visible,
	129,
	3,
	32,
	0,
	""
};

resource 'CNTL' (148, "Bevel Buttons - Medium Bevel w/Picture") {
	{0, 0, 36, 36},
	0,
	visible,
	129,
	3,
	33,
	0,
	""
};

resource 'CNTL' (149, "Bevel Buttons - Large Bevel w/Picture") {
	{0, 0, 48, 48},
	0,
	visible,
	129,
	3,
	34,
	0,
	""
};

resource 'CNTL' (150) {
	{0, 0, 24, 24},
	131,
	visible,
	128,
	3,
	36,
	0,
	""
};

resource 'CNTL' (151) {
	{0, 0, 36, 36},
	131,
	visible,
	128,
	259,
	37,
	0,
	""
};

resource 'CNTL' (152) {
	{0, 0, 48, 48},
	131,
	visible,
	128,
	514,
	42,
	0,
	""
};

resource 'CNTL' (153) {
	{0, 0, 150, 400},
	128,
	visible,
	0,
	0,
	136,
	0,
	""
};

resource 'CNTL' (155) {
	{0, 0, 16, 16},
	0,
	visible,
	0,
	0,
	112,
	0,
	"CNTL"
};

resource 'CNTL' (156) {
	{0, 0, 12, 150},
	0,
	visible,
	200,
	0,
	80,
	0,
	"CNTL"
};

resource 'CNTL' (157) {
	{0, 0, 16, 150},
	200,
	visible,
	200,
	0,
	80,
	0,
	"CNTL"
};

resource 'CNTL' (158) {
	{0, 0, 16, 150},
	150,
	visible,
	200,
	0,
	81,
	0,
	"CNTL"
};

resource 'CNTL' (159) {
	{0, 0, 16, 150},
	25,
	visible,
	200,
	0,
	81,
	0,
	"CNTL"
};

resource 'CNTL' (170) {
	{74, 17, 97, 30},
	0,
	visible,
	0,
	0,
	96,
	0,
	"CNTL"
};

resource 'CNTL' (169) {
	{13, 340, 163, 356},
	50,
	visible,
	100,
	0,
	scrollBarProc,
	0,
	"CNTL"
};

resource 'CNTL' (171) {
	{0, 0, 5, 150},
	0,
	visible,
	0,
	0,
	144,
	0,
	"CNTL"
};

resource 'CNTL' (172) {
	{0, 0, 150, 6},
	0,
	visible,
	0,
	0,
	144,
	0,
	"CNTL"
};

resource 'CNTL' (173) {
	{0, 0, 12, 12},
	0,
	visible,
	1,
	0,
	64,
	0,
	""
};

resource 'CNTL' (174) {
	{0, 0, 37, 37},
	129,
	visible,
	0,
	1,
	176,
	0,
	""
};

resource 'CNTL' (175, purgeable) {
	{120, 164, 200, 332},
	0,
	visible,
	0,
	0,
	160,
	0,
	""
};

resource 'CNTL' (176, purgeable) {
	{132, 168, 172, 240},
	0,
	visible,
	0,
	0,
	161,
	0,
	""
};

resource 'CNTL' (178) {
	{0, 0, 100, 200},
	133,
	visible,
	0,
	0,
	162,
	0,
	"Testing"
};

resource 'CNTL' (179) {
	{0, 0, 22, 100},
	0,
	visible,
	0,
	0,
	32,
	0,
	"Test"
	/****** Extra bytes follow... ******/
	/* $"0000 0000"                                          /* .... */
};

resource 'CNTL' (180) {
	{0, 0, 40, 40},
	0,
	visible,
	0,
	132,
	32,
	0,
	""
};

resource 'CNTL' (154) {
	{48, 224, 71, 237},
	0,
	visible,
	0,
	0,
	96,
	0,
	""
};

resource 'CNTL' (177, purgeable) {
	{8, 8, 200, 408},
	128,
	visible,
	100,
	0,
	128,
	0,
	""
};

resource 'CNTL' (181) {
	{0, 0, 20, 20},
	0,
	visible,
	0,
	0,
	64,
	0,
	"CNTL"
};

resource 'CNTL' (182) {
	{0, 0, 20, 20},
	0,
	visible,
	0,
	0,
	64,
	0,
	"CNTL"
};

resource 'CNTL' (183, "Bevel Buttons - Menu To right") {
	{0, 0, 20, 100},
	131,
	visible,
	0,
	0,
	44,
	0,
	"Right Menu"
};

resource 'CNTL' (184, "Bevel Buttons - Downward menu") {
	{0, 0, 20, 100},
	132,
	visible,
	0,
	0,
	40,
	0,
	"Down Menu"
};

resource 'CNTL' (185, "Bevel Buttons - Momentary behavior") {
	{0, 0, 20, 100},
	0,
	visible,
	0,
	0,
	40,
	0,
	"Momentary"
};

resource 'CNTL' (186, "Bevel Buttons - Toggle Behavior") {
	{0, 0, 20, 100},
	0,
	visible,
	0,
	256,
	40,
	0,
	"Toggle"
};

resource 'CNTL' (187, "Bevel Buttons - Sticky Behavior") {
	{0, 0, 20, 100},
	0,
	visible,
	0,
	512,
	40,
	0,
	"Sticky"
};

resource 'CNTL' (188, "Bevel Buttons - Flush Right text") {
	{0, 0, 20, 100},
	0,
	visible,
	0,
	0,
	40,
	0,
	"Flush Right"
};

resource 'CNTL' (189, "Bevel Buttons - Offset contents") {
	{0, 0, 20, 100},
	0,
	visible,
	0,
	-32768,
	40,
	0,
	"Offset Contents"
};

resource 'CNTL' (190, "Bevel Buttons - Flush Left + 5") {
	{0, 0, 20, 100},
	0,
	visible,
	0,
	0,
	40,
	0,
	"Flush Left + 5"
};

resource 'CNTL' (191, "Bevel Buttons - centered left to right") {
	{0, 0, 24, 70},
	0,
	visible,
	128,
	1,
	40,
	0,
	"L to R"
};

resource 'CNTL' (192, "Bevel Buttons - Centered right to left") {
	{0, 0, 24, 70},
	0,
	visible,
	128,
	1,
	40,
	0,
	"R to L"
};

resource 'CNTL' (193, "Bevel Buttons - Text Below Graphic") {
	{0, 0, 48, 48},
	0,
	visible,
	128,
	1,
	40,
	0,
	"Below"
};

resource 'CNTL' (194, "Bevel Buttons - Text Above Graphic") {
	{0, 0, 48, 48},
	0,
	visible,
	128,
	1,
	40,
	0,
	"Above"
};

resource 'CNTL' (195, "Bevel Buttons - System direction justified") {
	{0, 0, 24, 120},
	0,
	visible,
	128,
	2,
	40,
	0,
	"Sys Direction"
};

resource 'CNTL' (196, "Bevel Buttons - Left just + 2") {
	{0, 0, 24, 100},
	0,
	visible,
	128,
	2,
	40,
	0,
	"Left + 2"
};

resource 'CNTL' (197, "Bevel Buttons - Right just - 2") {
	{0, 0, 24, 100},
	0,
	visible,
	128,
	1,
	40,
	0,
	"Right - 2"
};

resource 'CNTL' (198, "Button Content - Bevel Button Example") {
	{0, 0, 48, 48},
	0,
	visible,
	128,
	1,
	32,
	0,
	""
};

resource 'CNTL' (199, "Button Content - Image Well example") {
	{0, 0, 48, 48},
	128,
	visible,
	0,
	1,
	176,
	0,
	""
};

resource 'CNTL' (200, "Button Content - Separator") {
	{0, 0, 5, 300},
	0,
	visible,
	0,
	0,
	144,
	0,
	""
};

resource 'CNTL' (201) {
	{110, 111, 194, 239},
	0,
	visible,
	0,
	0,
	160,
	0,
	"Bevel"
};

resource 'CNTL' (203) {
	{214, 330, 298, 592},
	0,
	visible,
	0,
	0,
	160,
	0,
	"Behavior"
};

resource 'CNTL' (205) {
	{-16, 0, 0, 100},
	0,
	visible,
	0,
	0,
	144,
	0,
	"CNTL"
};

resource 'CNTL' (210) {
	{209, 118, 228, 317},
	0,
	visible,
	60,
	134,
	401,
	0,
	"Variant:"
};

resource 'CNTL' (211) {
	{145, 120, 165, 274},
	0,
	visible,
	-1,
	135,
	401,
	0,
	"Direction:"
};

resource 'CNTL' (212) {
	{0, 0, 16, 100},
	0,
	visible,
	60,
	136,
	1009,
	0,
	"Content:"
};

resource 'CNTL' (213) {
	{0, 0, 19, 200},
	0,
	visible,
	-1,
	136,
	401,
	0,
	"Content:"
};

resource 'CNTL' (202) {
	{120, 8, 208, 172},
	0,
	visible,
	0,
	0,
	160,
	0,
	"Content"
};

resource 'CNTL' (204) {
	{12, 232, 112, 444},
	0,
	visible,
	0,
	0,
	160,
	0,
	"Menu"
};

resource 'CNTL' (209) {
	{120, 184, 208, 444},
	0,
	visible,
	0,
	0,
	160,
	0,
	"Align Graphic"
};

resource 'CNTL' (214) {
	{12, 8, 31, 168},
	0,
	visible,
	50,
	137,
	401,
	0,
	"Bevel:"
};

resource 'CNTL' (215) {
	{60, 20, 80, 203},
	0,
	visible,
	45,
	138,
	401,
	0,
	"Type:"
};

resource 'CNTL' (216, purgeable) {
	{36, 8, 112, 220},
	0,
	visible,
	0,
	0,
	160,
	0,
	"Behavior"
};

resource 'CNTL' (217, purgeable) {
	{144, 20, 168, 148},
	0,
	visible,
	0,
	139,
	401,
	0,
	""
};

resource 'CNTL' (218, purgeable) {
	{144, 196, 168, 344},
	0,
	visible,
	0,
	140,
	401,
	0,
	""
};

resource 'CNTL' (206) {
	{372, 340, 503, 444},
	0,
	visible,
	0,
	0,
	164,
	0,
	"Place"
};

resource 'CNTL' (207) {
	{380, 244, 510, 370},
	0,
	visible,
	0,
	0,
	164,
	0,
	"Align"
};

resource 'CNTL' (208) {
	{212, 8, 300, 264},
	0,
	visible,
	0,
	0,
	160,
	0,
	"Text"
};

resource 'CNTL' (219, purgeable) {
	{236, 16, 256, 160},
	0,
	visible,
	50,
	141,
	401,
	0,
	"Align:"
};

resource 'CNTL' (220, purgeable) {
	{272, 16, 292, 192},
	0,
	visible,
	50,
	142,
	401,
	0,
	"Place:"
};

resource 'CNTL' (221, "Std Alert - Secondary group 1") {
	{243, 202, 275, 432},
	0,
	visible,
	0,
	0,
	164,
	0,
	""
};

resource 'CNTL' (222, "Std Alert - Secondary group 2") {
	{277, 202, 306, 431},
	0,
	visible,
	0,
	0,
	164,
	0,
	""
};

resource 'CNTL' (223, "Std Alert - Secondary Group 3") {
	{306, 202, 339, 431},
	0,
	visible,
	0,
	0,
	164,
	0,
	""
};

resource 'CNTL' (224, "Std Alert - Buttons group") {
	{238, 114, 378, 473},
	0,
	visible,
	0,
	0,
	160,
	0,
	"Buttons"
};

resource 'CNTL' (225, "Std Alert - Type popup") {
	{134, 204, 153, 323},
	0,
	visible,
	0,
	144,
	401,
	0,
	""
};

resource 'CNTL' (226, "Live Feedback - Scroll Bar") {
	{249, 180, 265, 400},
	0,
	visible,
	100,
	0,
	386,
	0,
	""
};

resource 'CNTL' (227, "Live Feedback - Slider") {
	{196, 117, 213, 336},
	0,
	visible,
	100,
	0,
	57,
	0,
	"CNTL"
};

resource 'CNTL' (228, "Mega Dialog - Tabs") {
	{68, 33, 300, 475},
	6000,
	visible,
	0,
	0,
	129,
	0,
	"CNTL"
};

resource 'CNTL' (229, "Mega Dialog - Determinate Progress") {
	{345, 248, 361, 405},
	0,
	visible,
	100,
	0,
	80,
	0,
	""
};

resource 'CNTL' (230, "Mega Dialog - Indeterminate progress") {
	{379, 247, 395, 404},
	0,
	visible,
	0,
	0,
	80,
	0,
	""
};

resource 'CNTL' (231, "Mega Dialog - Chasing Arrows") {
	{0, 0, 16, 16},
	0,
	visible,
	0,
	0,
	112,
	0,
	""
};

resource 'CNTL' (232, "Mega Dialog - Down pointing slider") {
	{143, 90, 164, 233},
	0,
	visible,
	255,
	0,
	49,
	0,
	""
};

resource 'CNTL' (233) {
	{175, 90, 198, 232},
	0,
	visible,
	100,
	0,
	52,
	0,
	""
};

resource 'CNTL' (234, "Mega Dialog - Non-directional slider (horiz)") {
	{335, 226, 351, 367},
	0,
	visible,
	255,
	0,
	57,
	0,
	""
};

resource 'CNTL' (235, "Mega Dialog - Right pointing slider w/Tick marks") {
	{0, 0, 100, 25},
	5,
	visible,
	255,
	0,
	51,
	0,
	""
};

resource 'CNTL' (236, "Mega Dialog - Horiz live scroll bar") {
	{314, 255, 330, 423},
	0,
	visible,
	100,
	0,
	386,
	0,
	""
};

resource 'CNTL' (237) {
	{0, 0, 100, 16},
	0,
	visible,
	100,
	0,
	384,
	0,
	""
};

resource 'CNTL' (238, "Mega Dialog - Vert live scroll bar") {
	{203, 456, 330, 472},
	0,
	visible,
	100,
	0,
	386,
	0,
	""
};

resource 'CNTL' (39) {
	{0, 0, 22, 60},
	0,
	visible,
	1,
	0,
	368,
	0,
	"CNTL"
};

resource 'CNTL' (240, "Mega Dialog - Popup button") {
	{224, 187, 245, 345},
	0,
	visible,
	0,
	146,
	401,
	0,
	""
};

resource 'CNTL' (241, "Mega Dialog - Clock") {
	{269, 95, 296, 212},
	0,
	visible,
	0,
	0,
	242,
	0,
	""
};

resource 'CNTL' (242, "Mega Dialog - List Box") {
	{193, 255, 296, 464},
	6004,
	visible,
	0,
	0,
	353,
	0,
	"CNTL"
};

resource 'CNTL' (243, "Mega Dialog - Up pointing slider") {
	{236, 103, 253, 246},
	0,
	visible,
	255,
	0,
	53,
	0,
	""
};

resource 'CNTL' (244, "Mega Dialog - Left pointing slider") {
	{0, 0, 100, 22},
	0,
	visible,
	255,
	0,
	53,
	0,
	""
};

resource 'CNTL' (245, "Mega Dialog - non-directional slider (vert)") {
	{0, 0, 100, 20},
	0,
	visible,
	255,
	0,
	57,
	0,
	""
};

resource 'CNTL' (246) {
	{0, 0, 120, 160},
	0,
	visible,
	0,
	0,
	1584,
	0,
	""
};

resource 'CNTL' (248, "Mega Dialog - Run Diagnostic group box") {
	{146, 83, 327, 297},
	0,
	visible,
	1,
	0,
	161,
	0,
	"Run diagnostic"
};

resource 'CNTL' (249, "Mega Dialog - Horiz Separator") {
	{233, 303, 238, 483},
	0,
	visible,
	0,
	0,
	144,
	0,
	""
};

resource 'CNTL' (250) {
	{158, 324, 212, 472},
	0,
	visible,
	0,
	0,
	162,
	0,
	"Secondary"
};

resource 'CNTL' (251, "Mega Dialog - Secondary group box") {
	{242, 92, 317, 281},
	0,
	visible,
	0,
	0,
	164,
	0,
	"Secondary"
};

resource 'CNTL' (252, "Mega Dialog - Layout: grouping user pane") {
	{478, 154, 630, 353},
	2,
	visible,
	0,
	0,
	256,
	0,
	""
};

resource 'CNTL' (253, "Mega Dialog - Small Bevel w/icon suite") {
	{0, 0, 40, 40},
	0,
	visible,
	-3994,
	1,
	32,
	0,
	""
};

resource 'CNTL' (254, "Mega Dialog - Bevel button w/text to right") {
	{0, 0, 24, 100},
	0,
	visible,
	-16386,
	1,
	33,
	0,
	"On Right"
};

resource 'CNTL' (255, "Mega Dialog - Bevel with text below graphic") {
	{0, 0, 40, 40},
	0,
	visible,
	-3970,
	1,
	34,
	0,
	"Below"
};

resource 'CNTL' (256, "Mega Dialog - Bevel Button w/text above graphic") {
	{0, 0, 40, 40},
	0,
	visible,
	-3995,
	1,
	33,
	0,
	"Above"
};

resource 'CNTL' (257, "Mega Dialog - Bevel Button w/text to left") {
	{0, 0, 24, 100},
	0,
	visible,
	-16386,
	1,
	33,
	0,
	"On Left"
};

resource 'CNTL' (258, "Mega Dialog - Medium bevel with cicon") {
	{0, 0, 40, 40},
	0,
	visible,
	2,
	2,
	33,
	0,
	""
};

resource 'CNTL' (259, "Mega Dialog - Bevel button w/picture") {
	{244, 199, 298, 299},
	0,
	visible,
	32236,
	3,
	33,
	0,
	""
};

resource 'CNTL' (260, "Mega Dialog - Bevel button with menu to right") {
	{0, 0, 24, 100},
	146,
	visible,
	0,
	0,
	37,
	0,
	"Menus, too!"
};

resource 'CNTL' (261, "Mega Dialog - bevel button w/menu downward") {
	{0, 0, 24, 100},
	146,
	visible,
	0,
	8192,
	33,
	0,
	"Downward"
};

resource 'CNTL' (262, "Mega Dialog - Clickable icon") {
	{0, 0, 32, 32},
	-3985,
	visible,
	0,
	0,
	322,
	0,
	""
};

resource 'CNTL' (263, "Mega Dialog - Non-tracking icon") {
	{0, 0, 32, 32},
	-3982,
	visible,
	0,
	0,
	323,
	0,
	""
};

resource 'CNTL' (264) {
	{154, 179, 174, 269},
	0,
	visible,
	-6046,
	0,
	374,
	0,
	""
};

resource 'CNTL' (265, "Mega Dialog - Clickable Picture") {
	{0, 0, 98, 137},
	131,
	visible,
	0,
	0,
	304,
	0,
	""
};

resource 'CNTL' (266, "Mega Dialog - Image Well") {
	{0, 0, 40, 40},
	-4000,
	visible,
	0,
	1,
	176,
	0,
	""
};

resource 'CNTL' (267, "Mega Dialog - Little Arrows") {
	{0, 0, 23, 13},
	0,
	visible,
	100,
	0,
	96,
	0,
	""
};

resource 'CNTL' (268, "Mega Dialog - Fading Picture User Pane") {
	{0, 0, 95, 127},
	0,
	visible,
	0,
	0,
	256,
	0,
	""
};

resource 'CNTL' (269, "Mega Dialog - Vertical Separator") {
	{0, 0, 70, 3},
	0,
	visible,
	0,
	0,
	144,
	0,
	""
};

resource 'CNTL' (270, "Mega Dialog - Layout pane icon 1") {
	{0, 0, 32, 32},
	-3982,
	visible,
	0,
	0,
	323,
	0,
	""
};

resource 'CNTL' (271, "Mega Dialog - Layout pane icon 2") {
	{0, 0, 32, 32},
	-3987,
	visible,
	0,
	0,
	323,
	0,
	""
};

resource 'CNTL' (272, "Mega Dialog - Toggling bevel button (Bold)") {
	{0, 0, 16, 16},
	0,
	visible,
	129,
	257,
	32,
	0,
	""
};

resource 'CNTL' (273, "Mega Dialog - Toggling Bevel Button (italic)") {
	{0, 0, 16, 16},
	0,
	visible,
	130,
	257,
	32,
	0,
	""
};

resource 'CNTL' (274, "Mega Dialog - Toggling Bevel Button (underline)") {
	{0, 0, 16, 16},
	0,
	visible,
	131,
	257,
	32,
	0,
	""
};

resource 'CNTL' (275, "Mega Dialog - Sticky Bevel Button 1") {
	{0, 0, 16, 16},
	0,
	visible,
	132,
	513,
	32,
	0,
	""
};

resource 'CNTL' (276, "Mega Dialog - Sticky Bevel Button 2") {
	{0, 0, 16, 16},
	0,
	visible,
	133,
	513,
	32,
	0,
	""
};

resource 'CNTL' (277, "Mega Dialog - Sticky Bevel Button 3") {
	{0, 0, 16, 16},
	0,
	visible,
	134,
	513,
	32,
	0,
	""
};

resource 'CNTL' (278, "Mega Dialog - Sticky Bevel Button 4") {
	{0, 0, 16, 16},
	0,
	visible,
	135,
	513,
	32,
	0,
	""
};

resource 'CNTL' (279, "Mega Dialog - auto toggling discl. triangle") {
	{0, 0, 16, 16},
	0,
	visible,
	1,
	0,
	66,
	0,
	""
};

resource 'CNTL' (280) {
	{0, 0, 3, 100},
	0,
	visible,
	0,
	0,
	144,
	0,
	"CNTL"
};

resource 'CNTL' (281, "Radio Group - Divider Dialog") {
	{128, 109, 179, 225},
	0,
	visible,
	0,
	0,
	416,
	0,
	""
};

resource 'CNTL' (282, "Radio Group - Group Box (CDEF Tester)") {
	{129, 113, 176, 249},
	0,
	visible,
	0,
	0,
	416,
	0,
	""
};

resource 'CNTL' (283, "CDEF Tester - RadioGroup (Scroll Bars)") {
	{132, 111, 177, 225},
	0,
	visible,
	0,
	0,
	416,
	0,
	""
};

resource 'CNTL' (284, "Mega Dialog - Radio Group (Layout)") {
	{172, 90, 237, 208},
	0,
	visible,
	0,
	0,
	416,
	0,
	""
};

resource 'CNTL' (285, "Mega Dialog - Bevel Radio Group") {
	{271, 79, 293, 153},
	0,
	visible,
	0,
	0,
	416,
	0,
	""
};

resource 'CNTL' (286, "Mega Dialog - RadioGroup (Classic)") {
	{279, 26, 324, 144},
	0,
	visible,
	0,
	0,
	416,
	0,
	""
};

resource 'CNTL' (287, "Tab - RadioGroup Size") {
	{279, 26, 300, 175},
	0,
	visible,
	0,
	0,
	416,
	0,
	""
};

resource 'CNTL' (288) {
	{192, 351, 237, 451},
	0,
	visible,
	0,
	0,
	176,
	0,
	"CurrentIcon"
};

resource 'CNTL' (289) {
	{73, 7, 91, 144},
	0,
	visible,
	1,
	0,
	371,
	0,
	"Window Modified"
};

resource 'CNTL' (290) {
	{0, 0, 32, 150},
	0,
	visible,
	0,
	0,
	500 * 16,
	0,
	"Custom Control Definition"
};

resource 'STR#' (129) {
	{	/* array StringArray: 2 elements */
		/* [1] */
		"Show Disabled Look",
		/* [2] */
		"Show Enabled Look"
	}
};

resource 'STR#' (128, "Startup Errors") {
	{	/* array StringArray: 3 elements */
		/* [1] */
		"Unable to start the application because "
		"your system is older than God (or approp"
		"riate deity).",
		/* [2] */
		"Unable to start the application because "
		"the Appearance extension is not installe"
		"d.",
		/* [3] */
		"Unable to start the application because "
		"a necessary resource was missing."
	}
};

resource 'STR#' (130, "List Box examples") {
	{
		"Kilroy",
		"was",
		"here",
		"Able",
		"Elba",
		"was",
		"able"
	}
};

resource 'ics#' (128) {
	{	/* array: 2 elements */
		/* [1] */
		$"7000 FC00 BFC0 8E20 8230 81F8 8038 8038"
		$"8038 8038 C038 7038 1C3C 073F 01FF 007C",
		/* [2] */
		$"7000 FC00 FFC0 FFE0 FFF0 FFF8 FFF8 FFF8"
		$"FFF8 FFF8 FFF8 7FF8 1FFC 07FF 01FF 007C"
	}
};

resource 'ics#' (129) {
	{	/* array: 2 elements */
		/* [1] */
		$"0000 0000 0000 0FE0 0770 0770 0770 07E0"
		$"0770 0770 0770 0FE0",
		/* [2] */
		$"0000 0000 0000 0FE0 0770 0770 0770 07E0"
		$"0770 0770 0770 0FE0"
	}
};

resource 'ics#' (130) {
	{	/* array: 2 elements */
		/* [1] */
		$"0000 0000 0000 00FC 0030 0060 00C0 0180"
		$"0300 0600 0C00 3F",
		/* [2] */
		$"0000 0000 0000 00FC 0030 0060 00C0 0180"
		$"0300 0600 0C00 3F"
	}
};

resource 'ics#' (131) {
	{	/* array: 2 elements */
		/* [1] */
		$"",
		/* [2] */
		$"0000 0000 0000 1CE0 0C60 0C60 0C60 0C60"
		$"0C60 07E0 0000 1FF0"
	}
};

resource 'ics#' (132) {
	{	/* array: 2 elements */
		/* [1] */
		$"",
		/* [2] */
		$"0000 0000 0000 0000 0000 3F80 0000 3FFC"
		$"0000 3FE0 0000 3FFC"
	}
};

resource 'ics#' (133) {
	{	/* array: 2 elements */
		/* [1] */
		$"",
		/* [2] */
		$"0000 0000 0000 0000 07C0 0000 1FF0 0000"
		$"07C0 0000 3FF8"
	}
};

resource 'ics#' (134) {
	{	/* array: 2 elements */
		/* [1] */
		$"",
		/* [2] */
		$"0000 0000 0000 0000 0000 01FC 0000 3FFC"
		$"0000 07FC 0000 3FFC"
	}
};

resource 'ics#' (135) {
	{	/* array: 2 elements */
		/* [1] */
		$"",
		/* [2] */
		$"0000 0000 0000 0000 3FFC 0000 3FFC 0000"
		$"3FFC 0000 3FFC"
	}
};

resource 'ics8' (128) {
	$"00FF FFFF 0000 0000 0000 0000 0000 0000"
	$"FFFC FCFC FFFF 0000 0000 0000 0000 0000"
	$"FF2A FCFC FCFC FFFF FFFF 0000 0000 0000"
	$"FF2A 2A2A FCFC FC54 5454 FF00 0000 0000"
	$"FF2A 2A2A 2A2A FC54 5454 80FF 0000 0000"
	$"FF2A 2A2A 2A2A 54FC FCFC FCFF FF00 0000"
	$"FF2A 2A2A 2A2A 2A2A 2A2A FCFF FF00 0000"
	$"FF2A 2A2A 2A2A 2A2A 2A2A 7FFF FF00 0000"
	$"FF2A 2A2A 2A2A 2A2A 2A2A 7FFF FF00 0000"
	$"FF2A 2A2A 2A2A 2A2A 2A2A 7FFF FF00 0000"
	$"FFFC 542A 2A2A 2A2A 2A2A 7FFF FF00 0000"
	$"00FF FFFC 542A 2A2A 2A2A 7FFF FF00 0000"
	$"0000 00FF FFFC 542A 2A2A 7FFF FFFC 0000"
	$"0000 0000 00FF FFFC 542A 7FFF FFFC FCFC"
	$"0000 0000 0000 00FF FFFC 7FFF FFFC FCFC"
	$"0000 0000 0000 0000 00FF FFFF FFFC"
};

resource 'ics8' (129) {
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 FFFF FFFF FFFF FF00 0000 0000"
	$"0000 0000 00FF FFFF 00FF FFFF 0000 0000"
	$"0000 0000 00FF FFFF 00FF FFFF 0000 0000"
	$"0000 0000 00FF FFFF 00FF FFFF 0000 0000"
	$"0000 0000 00FF FFFF FFFF FF00 0000 0000"
	$"0000 0000 00FF FFFF 00FF FFFF 0000 0000"
	$"0000 0000 00FF FFFF 00FF FFFF 0000 0000"
	$"0000 0000 00FF FFFF 00FF FFFF 0000 0000"
	$"0000 0000 FFFF FFFF FFFF FF"
};

resource 'ics8' (130) {
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 FFFF FFFF FFFF 0000"
	$"0000 0000 0000 0000 0000 FFFF 0000 0000"
	$"0000 0000 0000 0000 00FF FF00 0000 0000"
	$"0000 0000 0000 0000 FFFF 0000 0000 0000"
	$"0000 0000 0000 00FF FF00 0000 0000 0000"
	$"0000 0000 0000 FFFF 0000 0000 0000 0000"
	$"0000 0000 00FF FF00 0000 0000 0000 0000"
	$"0000 0000 FFFF 0000 0000 0000 0000 0000"
	$"0000 FFFF FFFF FFFF"
};

resource 'ics8' (131) {
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 00FF FFFF 0000 FFFF FF00 0000 0000"
	$"0000 0000 FFFF 0000 00FF FF00 0000 0000"
	$"0000 0000 FFFF 0000 00FF FF00 0000 0000"
	$"0000 0000 FFFF 0000 00FF FF00 0000 0000"
	$"0000 0000 FFFF 0000 00FF FF00 0000 0000"
	$"0000 0000 FFFF 0000 00FF FF00 0000 0000"
	$"0000 0000 00FF FFFF FFFF FF00 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 00FF FFFF FFFF FFFF FFFF"
};

resource 'ics8' (132) {
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 FFFF FFFF FFFF FF00 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 FFFF FFFF FFFF FFFF FFFF FFFF 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 FFFF FFFF FFFF FFFF FF00 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 FFFF FFFF FFFF FFFF FFFF FFFF"
};

resource 'ics8' (133) {
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 00FF FFFF FFFF 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 00FF FFFF FFFF FFFF FFFF 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 00FF FFFF FFFF 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 FFFF FFFF FFFF FFFF FFFF FF"
};

resource 'ics8' (134) {
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 00FF FFFF FFFF FFFF 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 FFFF FFFF FFFF FFFF FFFF FFFF 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 00FF FFFF FFFF FFFF FFFF 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 FFFF FFFF FFFF FFFF FFFF FFFF"
};

resource 'ics8' (135) {
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 FFFF FFFF FFFF FFFF FFFF FFFF 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 FFFF FFFF FFFF FFFF FFFF FFFF 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 FFFF FFFF FFFF FFFF FFFF FFFF 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 FFFF FFFF FFFF FFFF FFFF FFFF"
};

resource 'mctb' (133, "CDEF Tester menu") {
	{	/* array MCTBArray: 1 elements */
		/* [1] */
		mctbLast, 0,
		{	/* array: 4 elements */
			/* [1] */
			0, 0, 0,
			/* [2] */
			0, 0, 0,
			/* [3] */
			0, 0, 0,
			/* [4] */
			0, 0, 0
		}
	}
};

resource 'mctb' (140, "Untitled menu") {
	{	/* array MCTBArray: 1 elements */
		/* [1] */
		mctbLast, 0,
		{	/* array: 4 elements */
			/* [1] */
			0, 0, 0,
			/* [2] */
			0, 0, 0,
			/* [3] */
			0, 0, 0,
			/* [4] */
			0, 0, 0
		}
	}
};

resource 'mctb' (141, "Untitled menu") {
	{	/* array MCTBArray: 1 elements */
		/* [1] */
		mctbLast, 0,
		{	/* array: 4 elements */
			/* [1] */
			0, 0, 0,
			/* [2] */
			0, 0, 0,
			/* [3] */
			0, 0, 0,
			/* [4] */
			0, 0, 0
		}
	}
};

resource 'mctb' (142, "Untitled menu") {
	{	/* array MCTBArray: 1 elements */
		/* [1] */
		mctbLast, 0,
		{	/* array: 4 elements */
			/* [1] */
			0, 0, 0,
			/* [2] */
			0, 0, 0,
			/* [3] */
			0, 0, 0,
			/* [4] */
			0, 0, 0
		}
	}
};

resource 'mctb' (139, "Untitled menu") {
	{	/* array MCTBArray: 1 elements */
		/* [1] */
		mctbLast, 0,
		{	/* array: 4 elements */
			/* [1] */
			0, 0, 0,
			/* [2] */
			0, 0, 0,
			/* [3] */
			0, 0, 0,
			/* [4] */
			0, 0, 0
		}
	}
};

resource 'PICT' (128) {
	3546,
	{160, 365, 233, 486},
	$"0011 02FF 0C00 FFFF FFFF 016D 0000 00A0"
	$"0000 01E6 0000 00E9 0000 0000 0000 001E"
	$"0001 000A 00A0 016D 00E9 01E6 0098 807A"
	$"00A0 016D 00E9 01E6 0000 0000 0000 0000"
	$"0048 0000 0048 0000 0000 0008 0001 0008"
	$"0000 0000 0125 A780 0000 0000 0000 0008"
	$"8000 00FF 0000 FFFF FFFF FFFF 0000 FFFF"
	$"FFFF CCCC 0000 FFFF FFFF 9999 0000 FFFF"
	$"FFFF 6666 0000 FFFF FFFF 3333 0000 FFFF"
	$"FFFF 0000 0000 FFFF CCCC FFFF 0000 FFFF"
	$"CCCC CCCC 0000 FFFF CCCC 9999 0000 FFFF"
	$"CCCC 6666 0000 FFFF CCCC 3333 0000 FFFF"
	$"CCCC 0000 0000 FFFF 9999 FFFF 0000 FFFF"
	$"9999 CCCC 0000 FFFF 9999 9999 0000 FFFF"
	$"9999 6666 0000 FFFF 9999 3333 0000 FFFF"
	$"9999 0000 0000 FFFF 6666 FFFF 0000 FFFF"
	$"6666 CCCC 0000 FFFF 6666 9999 0000 FFFF"
	$"6666 6666 0000 FFFF 6666 3333 0000 FFFF"
	$"6666 0000 0000 FFFF 3333 FFFF 0000 FFFF"
	$"3333 CCCC 0000 FFFF 3333 9999 0000 FFFF"
	$"3333 6666 0000 FFFF 3333 3333 0000 FFFF"
	$"3333 0000 0000 FFFF 0000 FFFF 0000 FFFF"
	$"0000 CCCC 0000 FFFF 0000 9999 0000 FFFF"
	$"0000 6666 0000 FFFF 0000 3333 0000 FFFF"
	$"0000 0000 0000 CCCC FFFF FFFF 0000 CCCC"
	$"FFFF CCCC 0000 CCCC FFFF 9999 0000 CCCC"
	$"FFFF 6666 0000 CCCC FFFF 3333 0000 CCCC"
	$"FFFF 0000 0000 CCCC CCCC FFFF 0000 CCCC"
	$"CCCC CCCC 0000 CCCC CCCC 9999 0000 CCCC"
	$"CCCC 6666 0000 CCCC CCCC 3333 0000 CCCC"
	$"CCCC 0000 0000 CCCC 9999 FFFF 0000 CCCC"
	$"9999 CCCC 0000 CCCC 9999 9999 0000 CCCC"
	$"9999 6666 0000 CCCC 9999 3333 0000 CCCC"
	$"9999 0000 0000 CCCC 6666 FFFF 0000 CCCC"
	$"6666 CCCC 0000 CCCC 6666 9999 0000 CCCC"
	$"6666 6666 0000 CCCC 6666 3333 0000 CCCC"
	$"6666 0000 0000 CCCC 3333 FFFF 0000 CCCC"
	$"3333 CCCC 0000 CCCC 3333 9999 0000 CCCC"
	$"3333 6666 0000 CCCC 3333 3333 0000 CCCC"
	$"3333 0000 0000 CCCC 0000 FFFF 0000 CCCC"
	$"0000 CCCC 0000 CCCC 0000 9999 0000 CCCC"
	$"0000 6666 0000 CCCC 0000 3333 0000 CCCC"
	$"0000 0000 0000 9999 FFFF FFFF 0000 9999"
	$"FFFF CCCC 0000 9999 FFFF 9999 0000 9999"
	$"FFFF 6666 0000 9999 FFFF 3333 0000 9999"
	$"FFFF 0000 0000 9999 CCCC FFFF 0000 9999"
	$"CCCC CCCC 0000 9999 CCCC 9999 0000 9999"
	$"CCCC 6666 0000 9999 CCCC 3333 0000 9999"
	$"CCCC 0000 0000 9999 9999 FFFF 0000 9999"
	$"9999 CCCC 0000 9999 9999 9999 0000 9999"
	$"9999 6666 0000 9999 9999 3333 0000 9999"
	$"9999 0000 0000 9999 6666 FFFF 0000 9999"
	$"6666 CCCC 0000 9999 6666 9999 0000 9999"
	$"6666 6666 0000 9999 6666 3333 0000 9999"
	$"6666 0000 0000 9999 3333 FFFF 0000 9999"
	$"3333 CCCC 0000 9999 3333 9999 0000 9999"
	$"3333 6666 0000 9999 3333 3333 0000 9999"
	$"3333 0000 0000 9999 0000 FFFF 0000 9999"
	$"0000 CCCC 0000 9999 0000 9999 0000 9999"
	$"0000 6666 0000 9999 0000 3333 0000 9999"
	$"0000 0000 0000 6666 FFFF FFFF 0000 6666"
	$"FFFF CCCC 0000 6666 FFFF 9999 0000 6666"
	$"FFFF 6666 0000 6666 FFFF 3333 0000 6666"
	$"FFFF 0000 0000 6666 CCCC FFFF 0000 6666"
	$"CCCC CCCC 0000 6666 CCCC 9999 0000 6666"
	$"CCCC 6666 0000 6666 CCCC 3333 0000 6666"
	$"CCCC 0000 0000 6666 9999 FFFF 0000 6666"
	$"9999 CCCC 0000 6666 9999 9999 0000 6666"
	$"9999 6666 0000 6666 9999 3333 0000 6666"
	$"9999 0000 0000 6666 6666 FFFF 0000 6666"
	$"6666 CCCC 0000 6666 6666 9999 0000 6666"
	$"6666 6666 0000 6666 6666 3333 0000 6666"
	$"6666 0000 0000 6666 3333 FFFF 0000 6666"
	$"3333 CCCC 0000 6666 3333 9999 0000 6666"
	$"3333 6666 0000 6666 3333 3333 0000 6666"
	$"3333 0000 0000 6666 0000 FFFF 0000 6666"
	$"0000 CCCC 0000 6666 0000 9999 0000 6666"
	$"0000 6666 0000 6666 0000 3333 0000 6666"
	$"0000 0000 0000 3333 FFFF FFFF 0000 3333"
	$"FFFF CCCC 0000 3333 FFFF 9999 0000 3333"
	$"FFFF 6666 0000 3333 FFFF 3333 0000 3333"
	$"FFFF 0000 0000 3333 CCCC FFFF 0000 3333"
	$"CCCC CCCC 0000 3333 CCCC 9999 0000 3333"
	$"CCCC 6666 0000 3333 CCCC 3333 0000 3333"
	$"CCCC 0000 0000 3333 9999 FFFF 0000 3333"
	$"9999 CCCC 0000 3333 9999 9999 0000 3333"
	$"9999 6666 0000 3333 9999 3333 0000 3333"
	$"9999 0000 0000 3333 6666 FFFF 0000 3333"
	$"6666 CCCC 0000 3333 6666 9999 0000 3333"
	$"6666 6666 0000 3333 6666 3333 0000 3333"
	$"6666 0000 0000 3333 3333 FFFF 0000 3333"
	$"3333 CCCC 0000 3333 3333 9999 0000 3333"
	$"3333 6666 0000 3333 3333 3333 0000 3333"
	$"3333 0000 0000 3333 0000 FFFF 0000 3333"
	$"0000 CCCC 0000 3333 0000 9999 0000 3333"
	$"0000 6666 0000 3333 0000 3333 0000 3333"
	$"0000 0000 0000 0000 FFFF FFFF 0000 0000"
	$"FFFF CCCC 0000 0000 FFFF 9999 0000 0000"
	$"FFFF 6666 0000 0000 FFFF 3333 0000 0000"
	$"FFFF 0000 0000 0000 CCCC FFFF 0000 0000"
	$"CCCC CCCC 0000 0000 CCCC 9999 0000 0000"
	$"CCCC 6666 0000 0000 CCCC 3333 0000 0000"
	$"CCCC 0000 0000 0000 9999 FFFF 0000 0000"
	$"9999 CCCC 0000 0000 9999 9999 0000 0000"
	$"9999 6666 0000 0000 9999 3333 0000 0000"
	$"9999 0000 0000 0000 6666 FFFF 0000 0000"
	$"6666 CCCC 0000 0000 6666 9999 0000 0000"
	$"6666 6666 0000 0000 6666 3333 0000 0000"
	$"6666 0000 0000 0000 3333 FFFF 0000 0000"
	$"3333 CCCC 0000 0000 3333 9999 0000 0000"
	$"3333 6666 0000 0000 3333 3333 0000 0000"
	$"3333 0000 0000 0000 0000 FFFF 0000 0000"
	$"0000 CCCC 0000 0000 0000 9999 0000 0000"
	$"0000 6666 0000 0000 0000 3333 0000 EEEE"
	$"0000 0000 0000 DDDD 0000 0000 0000 BBBB"
	$"0000 0000 0000 AAAA 0000 0000 0000 8888"
	$"0000 0000 0000 7777 0000 0000 0000 5555"
	$"0000 0000 0000 4444 0000 0000 0000 2222"
	$"0000 0000 0000 1111 0000 0000 0000 0000"
	$"EEEE 0000 0000 0000 DDDD 0000 0000 0000"
	$"BBBB 0000 0000 0000 AAAA 0000 0000 0000"
	$"8888 0000 0000 0000 7777 0000 0000 0000"
	$"5555 0000 0000 0000 4444 0000 0000 0000"
	$"2222 0000 0000 0000 1111 0000 0000 0000"
	$"0000 EEEE 0000 0000 0000 DDDD 0000 0000"
	$"0000 BBBB 0000 0000 0000 AAAA 0000 0000"
	$"0000 8888 0000 0000 0000 7777 0000 0000"
	$"0000 5555 0000 0000 0000 4444 0000 0000"
	$"0000 2222 0000 0000 0000 1111 0000 EEEE"
	$"EEEE EEEE 0000 DDDD DDDD DDDD 0000 BBBB"
	$"BBBB BBBB 0000 AAAA AAAA AAAA 0000 8888"
	$"8888 8888 0000 7777 7777 7777 0000 5555"
	$"5555 5555 0000 4444 4444 4444 0000 2222"
	$"2222 2222 0000 1111 1111 1111 0000 0000"
	$"0000 0000 00A0 016D 00E9 01E6 00A0 016D"
	$"00E9 01E6 0000 0488 0000 F604 8800 00F6"
	$"0488 0000 F604 8800 00F6 0488 0000 F609"
	$"E600 01FF FFA5 0000 F61A E600 04FF FF00"
	$"FFFF F000 01FF FFE8 0001 FFFF FA00 FEFF"
	$"E000 00F6 1CE7 0005 FFFF 0000 FFFF F000"
	$"01FF FFE8 0001 FFFF FB00 01FF FFDE 0000"
	$"F655 F300 01FF FFFD 0001 FFFF FD00 0AFF"
	$"FF00 00FF FF00 FFFF 0000 FEFF 0800 00FF"
	$"FF00 FFFF 0000 FDFF FE00 FEFF FE00 FEFF"
	$"0100 00FC FF01 0000 FDFF FC00 FDFF 0100"
	$"00FE FFFE 00FE FF08 0000 FFFF 00FF FF00"
	$"00FD FFF7 0000 F657 F200 FBFF FD00 01FF"
	$"FFFE 00FD FF19 0000 FFFF 00FF FF00 FFFF"
	$"00FF FF00 00FF FF00 FFFF 00FF FF00 FFFF"
	$"FD00 02FF FF00 FEFF FE00 04FF FF00 FFFF"
	$"FB00 17FF FF00 00FF FF00 FFFF 00FF FF00"
	$"FFFF 00FF FF00 FFFF 00FF FFF4 0000 F654"
	$"F200 FBFF FD00 01FF FFFE 00FE FFFE 00FC"
	$"FF14 00FF FF00 FFFF 0000 FFFF 00FF FF00"
	$"FFFF 00FF FF00 00FD FF02 00FF FFFD 0004"
	$"FFFF 00FF FFFB 000B FFFF 0000 FFFF 00FF"
	$"FF00 FFFF FD00 06FF FF00 FFFF 0000 FEFF"
	$"F600 00F6 59F1 00FD FFFD 0001 FFFF FD00"
	$"FDFF 0300 00FF FFFD 001A FFFF 00FF FF00"
	$"00FF FF00 FFFF 00FF FF00 FFFF 00FF FF00"
	$"FFFF 00FF FFFD 0004 FFFF 00FF FFFB 0014"
	$"FFFF 0000 FFFF 00FF FF00 FFFF 00FF FF00"
	$"FFFF 00FF FFFD 0001 FFFF F700 00F6 47F1"
	$"00FD FFFD 0001 FFFF FD00 06FF FF00 FFFF"
	$"0000 FEFF FE00 FDFF 0100 00FD FFFE 00FE"
	$"FFFE 00FD FF02 00FF FFFC 00FD FFFB 0001"
	$"FFFF FE00 FEFF FE00 FEFF FE00 FDFF 0000"
	$"FDFF F600 00F6 09D4 0001 FFFF B700 00F6"
	$"08D6 00FE FFB6 0000 F604 8800 00F6 0488"
	$"0000 F604 8800 00F6 0488 0000 F604 8800"
	$"00F6 0488 0000 F604 8800 00F6 08D4 00EB"
	$"4ECB 0000 F60C D400 004E ED00 004E CB00"
	$"00F6 0CD4 0000 4EED 0000 4ECB 0000 F610"
	$"D400 004E FA00 FE7F F700 004E CB00 00F6"
	$"10D4 0000 4EFB 00FC 7FF8 0000 4ECB 0000"
	$"F614 D400 004E FB00 027F 7FFF FE7F F900"
	$"004E CB00 00F6 15D4 0000 4EFB 0003 7F7F"
	$"FFFF FE7F FA00 004E CB00 00F6 16D4 0000"
	$"4EFB 0004 7F7F FF2A FFFE 7FFB 0000 4ECB"
	$"0000 F617 D400 004E FB00 057F 7FFF 2A54"
	$"FFFE 7FFC 0000 4ECB 0000 F618 D400 004E"
	$"FB00 067F 7FFF 2A54 54FF FE7F FD00 004E"
	$"CB00 00F6 19D4 0000 4EFB 0009 7F7F FF2A"
	$"5454 7FFF 7F7F FD00 004E CB00 00F6 18D4"
	$"0000 4EFB 0006 7F7F FF2A 547F FFFE 7FFD"
	$"0000 4ECB 0000 F617 D400 004E FB00 057F"
	$"7FFF 2A7F FFFE 7FFC 0000 4ECB 0000 F616"
	$"D400 004E FB00 047F 7FFF 54FF FE7F FB00"
	$"004E CB00 00F6 15D4 0000 4EFB 0003 7F7F"
	$"FFFF FE7F FA00 004E CB00 00F6 14D4 0000"
	$"4EFB 0002 7F7F FFFE 7FF9 0000 4ECB 0000"
	$"F610 D400 004E FB00 FC7F F800 004E CB00"
	$"00F6 10D4 0000 4EFA 00FE 7FF7 0000 4ECB"
	$"0000 F60C D400 004E ED00 004E CB00 00F6"
	$"0CD4 0000 4EED 0000 4ECB 0000 F60C D400"
	$"004E ED00 004E CB00 00F6 08D4 00EB 4ECB"
	$"0000 F604 8800 00F6 0488 0000 F604 8800"
	$"00F6 0488 0000 F604 8800 00F6 08D4 00EB"
	$"4ECB 0000 F60C D400 004E ED00 004E CB00"
	$"00F6 0CD4 0000 4EED 0000 4ECB 0000 560C"
	$"D400 004E ED00 004E CB00 0056 0CD4 0000"
	$"4EED 0000 4ECB 0000 560C D400 004E ED00"
	$"004E CB00 0056 0CD4 0000 4EED 0000 4ECB"
	$"0000 5610 D400 004E FE00 F47F FD00 004E"
	$"CB00 0056 10D4 0002 4E00 00F2 7FFE 0000"
	$"4ECB 0000 5615 D400 044E 0000 7F7F F6FF"
	$"017F 7FFE 0000 4ECB 0000 5619 D400 024E"
	$"0000 FE7F 00FF FB2A 0154 FFFE 7FFE 0000"
	$"4ECB 0000 5619 D400 004E FE00 FE7F 00FF"
	$"FD54 017F FFFE 7FFD 0000 4ECB 0000 FF18"
	$"D400 004E FD00 FE7F 04FF 5454 7FFF FE7F"
	$"FC00 004E CB00 00FF 16D4 0000 4EFC 00FE"
	$"7F02 FF7F FFFE 7FFB 0000 4ECB 0000 FF14"
	$"D400 004E FB00 FE7F 00FF FE7F FA00 004E"
	$"CB00 00FF 10D4 0000 4EFA 00FC 7FF9 0000"
	$"4ECB 0000 FF10 D400 004E F900 FE7F F800"
	$"004E CB00 00FF 0CD4 0000 4EED 0000 4ECB"
	$"0000 F60C D400 004E ED00 004E CB00 00F6"
	$"0CD4 0000 4EED 0000 4ECB 0000 F60C D400"
	$"004E ED00 004E CB00 00F6 08D4 00EB 4ECB"
	$"0000 F604 8800 00F6 0488 0000 FF00 00FF"
};

resource 'PICT' (129) {
	3462,
	{0, 0, 36, 36},
	$"0011 02FF 0C00 FFFE 0000 0048 0000 0048"
	$"0000 0000 0000 0024 0024 0000 0000 00A1"
	$"01F2 0016 3842 494D 0000 0000 0000 0024"
	$"0024 4772 8970 68AF 626A 0001 000A 0000"
	$"0000 0024 0024 0098 8024 0000 0000 0024"
	$"0024 0000 0000 0000 0000 0048 0000 0048"
	$"0000 0000 0008 0001 0008 0000 0000 0000"
	$"0000 0000 0000 0048 D740 0000 00FF 0000"
	$"FFFF FFFF FFFF 0001 FFFF FFFF CCCC 0002"
	$"FFFF FFFF 9999 0003 FFFF FFFF 6666 0004"
	$"FFFF FFFF 3333 0005 FFFF FFFF 0000 0006"
	$"FFFF CCCC FFFF 0007 FFFF CCCC CCCC 0008"
	$"FFFF CCCC 9999 0009 FFFF CCCC 6666 000A"
	$"FFFF CCCC 3333 000B FFFF CCCC 0000 000C"
	$"FFFF 9999 FFFF 000D FFFF 9999 CCCC 000E"
	$"FFFF 9999 9999 000F FFFF 9999 6666 0010"
	$"FFFF 9999 3333 0011 FFFF 9999 0000 0012"
	$"FFFF 6666 FFFF 0013 FFFF 6666 CCCC 0014"
	$"FFFF 6666 9999 0015 FFFF 6666 6666 0016"
	$"FFFF 6666 3333 0017 FFFF 6666 0000 0018"
	$"FFFF 3333 FFFF 0019 FFFF 3333 CCCC 001A"
	$"FFFF 3333 9999 001B FFFF 3333 6666 001C"
	$"FFFF 3333 3333 001D FFFF 3333 0000 001E"
	$"FFFF 0000 FFFF 001F FFFF 0000 CCCC 0020"
	$"FFFF 0000 9999 0021 FFFF 0000 6666 0022"
	$"FFFF 0000 3333 0023 FFFF 0000 0000 0024"
	$"CCCC FFFF FFFF 0025 CCCC FFFF CCCC 0026"
	$"CCCC FFFF 9999 0027 CCCC FFFF 6666 0028"
	$"CCCC FFFF 3333 0029 CCCC FFFF 0000 002A"
	$"CCCC CCCC FFFF 002B CCCC CCCC CCCC 002C"
	$"CCCC CCCC 9999 002D CCCC CCCC 6666 002E"
	$"CCCC CCCC 3333 002F CCCC CCCC 0000 0030"
	$"CCCC 9999 FFFF 0031 CCCC 9999 CCCC 0032"
	$"CCCC 9999 9999 0033 CCCC 9999 6666 0034"
	$"CCCC 9999 3333 0035 CCCC 9999 0000 0036"
	$"CCCC 6666 FFFF 0037 CCCC 6666 CCCC 0038"
	$"CCCC 6666 9999 0039 CCCC 6666 6666 003A"
	$"CCCC 6666 3333 003B CCCC 6666 0000 003C"
	$"CCCC 3333 FFFF 003D CCCC 3333 CCCC 003E"
	$"CCCC 3333 9999 003F CCCC 3333 6666 0040"
	$"CCCC 3333 3333 0041 CCCC 3333 0000 0042"
	$"CCCC 0000 FFFF 0043 CCCC 0000 CCCC 0044"
	$"CCCC 0000 9999 0045 CCCC 0000 6666 0046"
	$"CCCC 0000 3333 0047 CCCC 0000 0000 0048"
	$"9999 FFFF FFFF 0049 9999 FFFF CCCC 004A"
	$"9999 FFFF 9999 004B 9999 FFFF 6666 004C"
	$"9999 FFFF 3333 004D 9999 FFFF 0000 004E"
	$"9999 CCCC FFFF 004F 9999 CCCC CCCC 0050"
	$"9999 CCCC 9999 0051 9999 CCCC 6666 0052"
	$"9999 CCCC 3333 0053 9999 CCCC 0000 0054"
	$"9999 9999 FFFF 0055 9999 9999 CCCC 0056"
	$"9999 9999 9999 0057 9999 9999 6666 0058"
	$"9999 9999 3333 0059 9999 9999 0000 005A"
	$"9999 6666 FFFF 005B 9999 6666 CCCC 005C"
	$"9999 6666 9999 005D 9999 6666 6666 005E"
	$"9999 6666 3333 005F 9999 6666 0000 0060"
	$"9999 3333 FFFF 0061 9999 3333 CCCC 0062"
	$"9999 3333 9999 0063 9999 3333 6666 0064"
	$"9999 3333 3333 0065 9999 3333 0000 0066"
	$"9999 0000 FFFF 0067 9999 0000 CCCC 0068"
	$"9999 0000 9999 0069 9999 0000 6666 006A"
	$"9999 0000 3333 006B 9999 0000 0000 006C"
	$"6666 FFFF FFFF 006D 6666 FFFF CCCC 006E"
	$"6666 FFFF 9999 006F 6666 FFFF 6666 0070"
	$"6666 FFFF 3333 0071 6666 FFFF 0000 0072"
	$"6666 CCCC FFFF 0073 6666 CCCC CCCC 0074"
	$"6666 CCCC 9999 0075 6666 CCCC 6666 0076"
	$"6666 CCCC 3333 0077 6666 CCCC 0000 0078"
	$"6666 9999 FFFF 0079 6666 9999 CCCC 007A"
	$"6666 9999 9999 007B 6666 9999 6666 007C"
	$"6666 9999 3333 007D 6666 9999 0000 007E"
	$"6666 6666 FFFF 007F 6666 6666 CCCC 0080"
	$"6666 6666 9999 0081 6666 6666 6666 0082"
	$"6666 6666 3333 0083 6666 6666 0000 0084"
	$"6666 3333 FFFF 0085 6666 3333 CCCC 0086"
	$"6666 3333 9999 0087 6666 3333 6666 0088"
	$"6666 3333 3333 0089 6666 3333 0000 008A"
	$"6666 0000 FFFF 008B 6666 0000 CCCC 008C"
	$"6666 0000 9999 008D 6666 0000 6666 008E"
	$"6666 0000 3333 008F 6666 0000 0000 0090"
	$"3333 FFFF FFFF 0091 3333 FFFF CCCC 0092"
	$"3333 FFFF 9999 0093 3333 FFFF 6666 0094"
	$"3333 FFFF 3333 0095 3333 FFFF 0000 0096"
	$"3333 CCCC FFFF 0097 3333 CCCC CCCC 0098"
	$"3333 CCCC 9999 0099 3333 CCCC 6666 009A"
	$"3333 CCCC 3333 009B 3333 CCCC 0000 009C"
	$"3333 9999 FFFF 009D 3333 9999 CCCC 009E"
	$"3333 9999 9999 009F 3333 9999 6666 00A0"
	$"3333 9999 3333 00A1 3333 9999 0000 00A2"
	$"3333 6666 FFFF 00A3 3333 6666 CCCC 00A4"
	$"3333 6666 9999 00A5 3333 6666 6666 00A6"
	$"3333 6666 3333 00A7 3333 6666 0000 00A8"
	$"3333 3333 FFFF 00A9 3333 3333 CCCC 00AA"
	$"3333 3333 9999 00AB 3333 3333 6666 00AC"
	$"3333 3333 3333 00AD 3333 3333 0000 00AE"
	$"3333 0000 FFFF 00AF 3333 0000 CCCC 00B0"
	$"3333 0000 9999 00B1 3333 0000 6666 00B2"
	$"3333 0000 3333 00B3 3333 0000 0000 00B4"
	$"0000 FFFF FFFF 00B5 0000 FFFF CCCC 00B6"
	$"0000 FFFF 9999 00B7 0000 FFFF 6666 00B8"
	$"0000 FFFF 3333 00B9 0000 FFFF 0000 00BA"
	$"0000 CCCC FFFF 00BB 0000 CCCC CCCC 00BC"
	$"0000 CCCC 9999 00BD 0000 CCCC 6666 00BE"
	$"0000 CCCC 3333 00BF 0000 CCCC 0000 00C0"
	$"0000 9999 FFFF 00C1 0000 9999 CCCC 00C2"
	$"0000 9999 9999 00C3 0000 9999 6666 00C4"
	$"0000 9999 3333 00C5 0000 9999 0000 00C6"
	$"0000 6666 FFFF 00C7 0000 6666 CCCC 00C8"
	$"0000 6666 9999 00C9 0000 6666 6666 00CA"
	$"0000 6666 3333 00CB 0000 6666 0000 00CC"
	$"0000 3333 FFFF 00CD 0000 3333 CCCC 00CE"
	$"0000 3333 9999 00CF 0000 3333 6666 00D0"
	$"0000 3333 3333 00D1 0000 3333 0000 00D2"
	$"0000 0000 FFFF 00D3 0000 0000 CCCC 00D4"
	$"0000 0000 9999 00D5 0000 0000 6666 00D6"
	$"0000 0000 3333 00D7 EEEE 0000 0000 00D8"
	$"DDDD 0000 0000 00D9 BBBB 0000 0000 00DA"
	$"AAAA 0000 0000 00DB 8888 0000 0000 00DC"
	$"7777 0000 0000 00DD 5555 0000 0000 00DE"
	$"4444 0000 0000 00DF 2222 0000 0000 00E0"
	$"1111 0000 0000 00E1 0000 EEEE 0000 00E2"
	$"0000 DDDD 0000 00E3 0000 BBBB 0000 00E4"
	$"0000 AAAA 0000 00E5 0000 8888 0000 00E6"
	$"0000 7777 0000 00E7 0000 5555 0000 00E8"
	$"0000 4444 0000 00E9 0000 2222 0000 00EA"
	$"0000 1111 0000 00EB 0000 0000 EEEE 00EC"
	$"0000 0000 DDDD 00ED 0000 0000 BBBB 00EE"
	$"0000 0000 AAAA 00EF 0000 0000 8888 00F0"
	$"0000 0000 7777 00F1 0000 0000 5555 00F2"
	$"0000 0000 4444 00F3 0000 0000 2222 00F4"
	$"0000 0000 1111 00F5 EEEE EEEE EEEE 00F6"
	$"DDDD DDDD DDDD 00F7 BBBB BBBB BBBB 00F8"
	$"AAAA AAAA AAAA 00F9 8888 8888 8888 00FA"
	$"7777 7777 7777 00FB 5555 5555 5555 00FC"
	$"4444 4444 4444 00FD 2222 2222 2222 00FE"
	$"1111 1111 1111 00FF 0000 0000 0000 0000"
	$"0000 0024 0024 0000 0000 0024 0024 0000"
	$"2404 314F F8F9 81FD FAFF 8108 FCA5 FBFB"
	$"FCAC 88AC FDFE AC07 88AC ACFD FDAD B2AC"
	$"FEFD 01AC B322 01F8 56FE F706 4F56 F9FA"
	$"F9F9 FAFD FB02 FCAB FCFC AC0B FCAC FDAC"
	$"FDFD AC88 ADAC FDAC 21FE FA11 F97A F956"
	$"80F9 7A5C 7A81 81FB A5FB A688 ACAC FCFC"
	$"FEAC 06AD ACAC 88FD FC88 2305 FCFB FBFC"
	$"81FB FE81 16FA 7A81 81A5 8781 FBFB A582"
	$"FBFC 81FC ACFC ACAC FDB2 ADFD FDAC 2201"
	$"ACFD FDAC FEFC FEFB 0E81 87A5 8081 FB81"
	$"81FB FA81 FBFC FBFB FEFE 05FD ACFD B2FD"
	$"FD24 03FB ACAC 88FE AC00 88FE FC01 FBA5"
	$"FD81 1280 8181 FAFA F980 FA80 81AD F3AD"
	$"FDFD ACFD ADB2 2506 FC88 ACAC 88AC 88FE"
	$"FC01 FBFC FE81 FFFA FF81 10FA 80FA FA7A"
	$"F956 F9FB FEAC AC88 FEFD FEAC 2310 ACFC"
	$"88FC ACFC ACFC 88FC FC87 FB81 81A5 81FC"
	$"FB05 81FB 81FA 80FB FEAC 04FD ADFD ACFD"
	$"1DFF FD06 ACFD ACFD FCFC ACFE FC05 FBAB"
	$"FC81 A5FB F7FC 0488 FDAC FDB2 FEAC 20FC"
	$"FD03 88FD ACAC FEFC FFFB FE81 FFFC 0088"
	$"FDFC 0B88 ACAC FCAC ADFD FEFD FDB2 AC24"
	$"11AC B2AD ACFD FDAC ACFC ACFC A581 F97A"
	$"5680 FBFD FC05 88FC ACAC FCAC FEFD 04B2"
	$"ADFD ACAD 2214 FEAD B2AD ACFD FDAC ACFC"
	$"FCFB 80F9 557A F9FB FCFB 82FE FC06 ACFC"
	$"ACFC ACFD FEFC AC24 FEFD 00B2 FEAC 1C88"
	$"ABFB 81FA F955 5055 F9A5 88AC ACFC FC88"
	$"FBA6 8782 FDFD ACAC 88AC FC88 2523 ACFC"
	$"FCA6 87FC 81A5 81FA 8056 F8F8 552C 55FB"
	$"EAFE FEFD ACAC FC87 A6AB B3AC FDFD AC88"
	$"ACAC 2409 FBAC FCAC FC81 FB81 FA7A FE56"
	$"044F 2B4F 2B81 FDFD FFAC 0BFB A687 ADD0"
	$"B3FD FDAC FCAC FD25 23FC FBFB 8181 FA80"
	$"F956 5655 4F4F 31F6 2B4F 56FD ADAC FD88"
	$"ACAC 88A6 FCFD ACAC ADB2 ACFD AC24 FE81"
	$"13FB 7B80 567A 56F8 F7F8 F72B 4F2B 2AF8"
	$"FCFE B2AD FDFE AC09 FCAC FCAC ADFD ACFD"
	$"88FD 2213 F980 7AF9 55F9 F855 4F55 5055"
	$"2B4F F62A 2B2B FBFD FEAC FFFD 05AC FCAC"
	$"B2FD FDFC AC20 FF7A 1156 5556 F84F F855"
	$"F74F 2B4F 2BF6 2BF6 F680 ACFE FC05 ACAD"
	$"FDFC ADFD FAAC 2107 5655 F8F8 554F F84F"
	$"FEF7 0E2A F72A 4FF5 F62A F9FD ACAC FCAC"
	$"B2FC FEFD 00AD FBAC 1F12 55F8 4F55 4FF8"
	$"4F31 2B4F 2B4F F74F 2BF6 2A25 56FC AC03"
	$"FCAC ACFD FAAC 00FD 1F12 4FF7 F72B 4FF7"
	$"2A4F F72A 2B2A 2B2B 2AF6 252A F8FB FCFE"
	$"AC00 FDFC AC01 FCAC 22FF F715 2B4F F72A"
	$"4F2B 2A2B 2A2B F62A 2B25 2AF6 4FFB FCFC"
	$"FB82 FEFC 01AC FDFB AC00 AD20 1A4F F74F"
	$"314F F72B 2B4F 2B4F 2B4F 2BF6 2AF5 F62B"
	$"81FC FCFB 87FB FB81 F9AC 00FD 1D09 314F"
	$"314F 314F 554F 314F FD2B 0025 FDF6 0856"
	$"A581 81FB A581 81FB F9AC 1F1B 4FF8 4FF8"
	$"4FF8 F855 4F2B F72A 2AF5 F6F5 F5F6 2A2B"
	$"FAFA 80F9 80FA 8081 F9AC 1F1B F8F7 F855"
	$"5655 56F8 F72B F62B 25F6 F624 F62B 25F6"
	$"F880 567A 567A F97A F9AC 2008 55F8 F856"
	$"567B 8155 2BFE F6FF 2B0E 2A2B F64F F856"
	$"F87A 7A55 7A56 7AFA FBFA AC23 1FF8 5655"
	$"567A 8780 502B F6F7 502A F656 8280 56F9"
	$"567A F955 F956 7A5C FA81 ACAC FCFD AC25"
	$"1C56 F87A 56F9 FAFA F8F7 5056 FA81 FBAC"
	$"FDAC FBF9 8081 567A 55F9 557B 80FB FEAC"
	$"03FC ACAC A620 1C56 7AF9 7950 55F9 567B"
	$"87AC FDAD 88FD AC88 ACFB FCFB 5655 5655"
	$"5680 7BFB FAAC 201C F956 F955 F72B 55F9"
	$"ACFD E0E0 ACFD ACAC 8782 FB81 F9F9 567A"
	$"567A F980 FCFA AC20 1C55 F955 F82B 4FF8"
	$"56FA ADFD FDFE ACAC 8782 8188 ACFA 567A"
	$"F855 FAFA 81A5 FAAC 2509 5655 562B 2A2B"
	$"F8FA 81B2 FEFD 01AC 88FE FC11 ACAD 80F9"
	$"7A7A 567A 8181 FCAC ACFD ACFD ACFD 25FF"
	$"56FF 4FFF 2B04 4F55 F981 FCFE AC15 FCAC"
	$"ACFD ACFB F97A F9F9 7AF9 8081 FBFD ACAC"
	$"FDAC FDAC 2509 564F 312B 4F2B 2BF8 5555"
	$"FEFB 16AC ADAC FDAC FCF9 7A5C F980 5680"
	$"7B80 ACFD FDAC ACFD ACFD 00FF"
};

resource 'PICT' (6003, "Beach") {
	58310,
	{0, 0, 240, 320},
	$"0011 02FF 0C00 FFFE 0000 0048 0000 0048"
	$"0000 0000 0000 00F0 0140 0000 0000 00A1"
	$"01F2 0016 3842 494D 0000 0000 0000 00F0"
	$"0140 4772 8970 68AF 626A 0001 000A 0000"
	$"0000 00F0 0140 009A 0000 00FF 8280 0000"
	$"0000 00F0 0140 0000 0003 0000 0000 0048"
	$"0000 0048 0000 0010 0010 0003 0005 0000"
	$"0000 0000 0000 0000 0000 0000 0000 00F0"
	$"0140 0000 0000 00F0 0140 0040 019D 016B"
	$"5D67 3CFC 673B 0063 3AF8 673B 0063 1BFA"
	$"633B FE63 1B03 673B 673B 633B 633B FB67"
	$"3B06 633B 673B 631B 631A 5F1A 631A 631A"
	$"FE5F 1A03 5F1B 5F1B 5F1A 5EFA FC5F 1A08"
	$"5EFA 5EFA 5AFA 5AFA 5EFA 5AFA 5AFA 5EFA"
	$"5AD9 FC5A FA00 5AF9 FC5A FA06 5AD9 56D9"
	$"5AD9 5AD9 56D9 5AD9 5AD9 FD56 D902 56DA"
	$"56D9 56B9 FD56 D901 52B9 52D9 FE52 B905"
	$"4EB8 52B8 4EB8 4EB8 52B9 52B8 FA52 B9F8"
	$"4E98 164A 984A 984E 984A 984E 984E 984A"
	$"974E 984E 974A 974E 984A 974A 974E 984E"
	$"984E 974E 984E 974E 974A 774A 974E 974A"
	$"97FE 4A77 034A 974A 764A 764A 77FD 4A97"
	$"034E 974A 974A 774A 97FE 4E97 0A4E 984E"
	$"974E 974E 9852 B852 B852 9852 B852 B852"
	$"B752 B7FD 4E97 0852 B752 B84E 9752 B74E"
	$"9752 B84E 974E 9752 B7FB 4E97 004A 97FE"
	$"4A76 FE46 7600 4A56 FA46 5602 4255 4256"
	$"4235 FE42 5601 4255 4256 F342 5507 3E55"
	$"3E55 3E35 3E35 4235 4235 4255 4235 FE3E"
	$"3507 3E34 3E35 3E35 3E34 3E35 3E34 3E34"
	$"3E14 FD3A 1406 3A13 3A13 35F3 39F4 3A14"
	$"3A14 39F4 F635 F304 31D3 31D3 31F3 31F3"
	$"31D3 FD31 F303 35D3 31D3 35D3 35D3 F835"
	$"F3F5 31D3 0131 D22D D2FB 2DB2 0629 B22D"
	$"B22D D229 B22D B229 B229 B201 6601 673D"
	$"673C FC67 3B00 633A FA63 3B03 673B 633B"
	$"633B 631B FC63 1AFE 631B FD63 3B02 673B"
	$"633B 633B FD67 3B03 631B 633B 631B 631B"
	$"FD63 1A02 5F1A 5F1A 5F1B FC5F 1AF6 5AFA"
	$"025A F95A F95A FAFD 5AF9 045A FA5A FA5A"
	$"D95A FA5A FAFD 5AD9 0256 D956 D95A FAF6"
	$"56D9 0152 B852 B9FC 52B8 0152 B952 B9FE"
	$"52B8 FD52 B902 52B8 4EB8 4EB8 F84E 98FE"
	$"4A98 044E 984E 984E 974A 974E 98FD 4A97"
	$"FD4E 97FE 4A97 074E 974A 974A 774A 774A"
	$"974A 974E 974A 77FD 4A97 044A 774A 774E"
	$"974A 974A 97F9 4E97 0052 B8FE 4E97 0152"
	$"B752 B8F8 52B7 014E 9752 B7F9 4E97 024A"
	$"974A 974A 77FB 4A76 0046 56FE 4676 0646"
	$"5646 5646 7642 5542 5642 5542 56FE 4255"
	$"0046 56FE 4255 0346 5642 5642 5546 56FD"
	$"4255 0142 353E 35FE 4255 0142 353E 35FE"
	$"4235 FA3E 3500 3E34 FD3E 35FB 3A14 013A"
	$"1339 F4FE 3A14 F535 F303 31F3 35F3 31F3"
	$"31F3 F435 F300 35F4 FD35 F30B 31D3 31D3"
	$"31F3 31D3 31D3 31F3 31F3 31D3 31D2 31D2"
	$"31D3 31D3 FA31 D2FE 2DD2 032D B22D D22D"
	$"B22D D201 6B02 673D 633B 631A FD63 3B00"
	$"633A FC63 3BFE 631B 0163 3B63 3BFB 631A"
	$"0463 1B63 1B63 3B63 3B63 1BFC 633B 0267"
	$"3B63 3B63 3BFE 631B 0263 1A63 1B63 1BFC"
	$"631A 0463 1B5F 1A5F 1A5E FA5E FAFC 5AFA"
	$"FE5A F9FE 5AFA 015A F95A FAFB 5AF9 FE5A"
	$"D902 5AFA 5AD9 56D9 FE5A D9FB 56D9 0052"
	$"D9FC 56D9 0256 D852 B856 D8F6 52B8 0252"
	$"B94E B852 B8FE 4E98 004E B8FE 4E98 004A"
	$"97FE 4E98 014A 974E 98FE 4A98 FE4E 9802"
	$"4A97 4A97 4A77 FB4A 9705 4E97 4A97 4A97"
	$"4E97 4E97 4A97 F84E 97FE 4A97 F64E 9700"
	$"52B8 FD4E 9700 52B8 FB52 B700 4E97 FE52"
	$"B7F8 4E97 034A 974A 974A 774A 77FD 4A76"
	$"0746 7646 764A 7646 764A 7646 7646 564A"
	$"76F8 4656 0342 5542 5546 5642 56FE 4255"
	$"0442 3542 5542 5542 3542 35FE 4255 033E"
	$"353E 3542 3542 35F9 3E35 043E 143E 353E"
	$"343E 353E 35F0 3A14 FC35 F403 35F3 35F3"
	$"3613 35F3 FD36 1304 35F3 3A14 3A14 39F4"
	$"3A14 FD39 F402 3A14 3A14 35F4 FA35 F301"
	$"31F3 31F3 FB31 D207 31D3 31D2 31D3 31D2"
	$"31D2 31D3 31D2 31D3 FD31 D201 2DD2 31D3"
	$"014C 0763 3D63 1B63 1B63 3A63 1B63 3B63"
	$"1B63 1AFC 631B FE63 1A03 631B 631A 633B"
	$"631B FC63 3BFE 631B 0363 3B63 3B63 1B63"
	$"1BFE 633B FC63 1B02 631A 631A 631B FB63"
	$"1A02 5F1A 5F1A 5EFA FC5A FA02 5AF9 5AFA"
	$"5AFA FE5A F905 5AD9 5AD9 56D9 5AF9 56D9"
	$"56D9 FE56 F901 56D9 56D9 FE5A D905 56D9"
	$"5AD9 5AFA 5AF9 56D9 5AF9 F656 D905 56D8"
	$"56D9 52B9 56B9 56D9 52B9 FD52 B800 52B9"
	$"FC52 B8FE 4E98 004A 98FA 4A97 054A 774A"
	$"774A 974A 984E 984A 98F0 4A97 F94E 9703"
	$"4A77 4A77 4A97 4A97 ED4E 9701 52B8 52B7"
	$"F34E 9702 4A97 4A97 4A77 F34A 7607 4A56"
	$"4A76 4A76 4A56 4A56 4656 4655 4676 F942"
	$"5504 4235 4235 4255 4235 4255 FE42 3500"
	$"3E35 FE42 35FE 3E35 053E 343E 343E 353E"
	$"343A 143E 34FE 3E14 EB3A 1403 39F4 3A14"
	$"35F4 39F4 FD3A 1403 35F4 3A14 3A14 39F3"
	$"FC3A 1401 35F3 35F4 FB35 F303 31F3 35F3"
	$"31F3 31F3 FD31 D307 31D2 31D2 35F3 35D3"
	$"31D2 31D3 31D2 31D3 FA31 D200 31F3 0176"
	$"0363 1C63 1B63 1A63 1AFE 5F1B 045F 1A63"
	$"1A5F 1A5F 1A63 1AFB 631B 0263 3B63 1B63"
	$"3BF4 631B 0167 3B63 3BFD 631B 0463 1A63"
	$"1A63 1B63 1A63 1BFE 5F1A 005F 1BFC 5EFA"
	$"005F 1AF9 5AFA 005A D9FB 56D9 0056 DAFC"
	$"56D9 095A FA5A D95A D95A FA5A FA5A DA5A"
	$"FA5A D95A F95A D9FE 5AF9 F956 D902 52D9"
	$"56D9 52D9 FC52 B90D 52B8 52B8 5298 5298"
	$"52B8 5298 4E98 4E97 4E98 4E98 4E97 4E98"
	$"4E98 4E97 FE4E 9805 4E97 4E97 4E98 4A97"
	$"4E98 4A97 FA4E 9709 4A97 4A97 4A77 4A77"
	$"4A97 4E98 4A97 4A97 4E98 4E98 FE4E 9700"
	$"4E98 F84E 970A 4E98 52B8 52B8 5298 5297"
	$"5298 4E97 4E97 5297 4E97 5298 FE52 97FD"
	$"4E97 0152 B852 97F9 4E97 0A4E 774E 774A"
	$"774E 774E 974A 774E 774E 774A 764A 764E"
	$"77F1 4A76 0446 5646 7646 5546 5642 56FC"
	$"4255 0B42 3546 5642 5542 3542 5642 5542"
	$"3542 3542 5542 353E 3542 35FC 3E35 023E"
	$"343E 143E 34FB 3E14 F43A 1400 39F4 FA3A"
	$"1402 39F4 3A14 3E14 FC3A 1401 3E14 39F4"
	$"F93A 1401 39F4 39F4 FE35 F4FD 35F3 FE35"
	$"D3FE 31D3 0035 D3F8 31D3 FE31 D203 31F3"
	$"31D2 2DD2 31D3 0173 0163 1C63 1BFE 5F1A"
	$"005F 1BFD 5F1A 0063 1AFB 631B 0163 3B5F"
	$"1BFC 5F1A 0363 1B5F 1A5F 1A63 1AFE 5F1A"
	$"0163 1B63 1AFE 631B 005F 1BFA 5F1A 035E"
	$"FA5A FA5E FA5E FAFC 5AFA 005E FAFB 5AFA"
	$"065A F95A FA5A F95A F95A FA5A FA5A F9F9"
	$"56D9 FC5A D909 56D9 56D9 5AD9 5AF9 5AFA"
	$"5AFA 5AF9 5AF9 5AFA 5AFA FD56 D902 56D8"
	$"52B8 52B8 FE52 B906 4EB8 52B8 52B9 52B8"
	$"4EB8 52B8 4EB8 FD4E 98FE 4E97 024E 984E"
	$"9852 98F9 4E98 074E 974E 974E 984A 774A"
	$"974E 974A 974A 97FE 4E97 FC4A 970A 4A77"
	$"4A77 4A97 4A97 4A77 4A97 4E97 4E97 4A97"
	$"4E97 4E98 FB4E 97FD 5297 054E 9752 974E"
	$"974E 9752 974E 97FD 5297 FD4E 9701 5297"
	$"52B7 FA4E 970A 4A77 4A77 4E77 4E97 4E77"
	$"4A77 4E77 4E97 4E77 4E77 4A77 F14A 7600"
	$"4676 FE46 550B 4656 4655 4655 4635 4635"
	$"4655 4635 4235 4256 4255 4235 4256 FD42"
	$"35FA 3E34 013E 143E 14F2 3A14 013A 133A"
	$"13FC 3A14 F33E 1402 3A14 3E14 3A13 F93A"
	$"1404 39F3 39F3 35F3 35F3 39F3 FA35 F3FD"
	$"31D3 0031 F3FD 31D2 0331 D331 D231 D231"
	$"D3FD 31D2 022D D22D D231 D201 6006 631C"
	$"631B 5F1A 5F1A 5F1B 5F1B 631A FE5F 1A07"
	$"631A 631B 631A 631B 631B 631A 5F1A 5F1B"
	$"FD5F 1A00 5AFA FC5F 1AFD 5EFA 045A FA5E"
	$"FA5A FA5A FA5E FAFC 5AFA 075A DA5A FA5A"
	$"FA56 D956 D95A FA56 D956 D9FA 5AFA 035A"
	$"F95A F95A FA5A FAFE 5AF9 FE5A FAFE 5AF9"
	$"FC56 D900 5AD9 F156 D901 52B9 52B9 FE52"
	$"B806 52B9 52B8 52B8 4EB8 4EB8 4E98 52B8"
	$"FE4E B804 4A98 4E98 4E98 4A97 4A97 F74E"
	$"980C 4E97 4E97 4E98 4E98 4A97 4E98 4A77"
	$"4A97 4E97 4E97 4A97 4A97 4E98 F84E 97FE"
	$"4A97 FD4E 9700 4EB8 FD52 B704 52B8 52B8"
	$"52B7 52B7 5297 FE4E 9707 5297 5297 52B7"
	$"4E97 4E97 5298 52B8 5297 FE4E 9702 5297"
	$"4EB7 52B7 FD4E 9709 4E96 4A96 4E97 4A77"
	$"4A76 4A77 4E97 4E77 4E97 4E97 FD4A 77F4"
	$"4A76 FD46 76FB 4655 0242 3542 3546 55F7"
	$"4235 FA3E 3400 3A13 FA3A 1400 3613 F93A"
	$"1400 3A13 FD3A 1401 3E14 3E14 FA3E 3402"
	$"3E14 3E14 3A13 FE3A 14FD 3A13 FA3A 14F8"
	$"35F3 0331 F331 F335 F335 F3FD 31D3 FE31"
	$"D200 2DD2 FA31 D2FD 2DD2 0031 D301 8B03"
	$"631C 631B 5F1A 631A FE63 1B08 631A 633B"
	$"631A 631B 631A 631A 631B 631A 631A FE5F"
	$"1AFE 5AFA 015F 1A5F 1AFE 5EFA FA5A FA02"
	$"5AD9 56D9 56F9 FE56 D902 56DA 56D9 52D9"
	$"FE56 D903 52D9 56D9 52D9 52D9 F656 D902"
	$"5AF9 5AFA 5AFA FD5A F905 5AFA 5AF9 56D9"
	$"56D9 5AD9 5AFA FB56 D90B 56D8 52D8 56D9"
	$"56D8 52D9 52B9 52D9 52B8 52B8 56D9 56D9"
	$"52B9 FD52 B8FE 52B9 0252 B852 B952 B9FE"
	$"52B8 F84E 9805 4E97 4A97 4E98 4A97 4A97"
	$"4E97 FB4E 9801 4E97 4E97 F94E 98FE 4E97"
	$"004E 98FD 4E97 004E 98FC 4E97 064E B852"
	$"B852 B752 B752 B852 B856 B8FD 52B7 014E"
	$"974E 97FD 52B7 094E 974E 9752 B852 B852"
	$"9752 974E 9752 9752 B74E B7FC 4E97 094A"
	$"964A 964E 974A 774E 774E 974A 774E 974A"
	$"774A 77FB 4A76 014A 774A 77FB 4A76 FB46"
	$"76FD 4655 FE42 55FD 4235 003E 35FD 4235"
	$"043E 353E 343E 343E 143E 35F6 3A14 0335"
	$"F436 143A 1435 F3F6 3A14 013E 143E 14FD"
	$"3E34 FA3E 14FE 3A14 0439 F335 F339 F439"
	$"F339 F3FE 39F4 FA35 F301 31D3 31D3 FD35"
	$"D301 31F3 31F3 FD31 D300 31D2 FD31 D30C"
	$"31D2 31D3 2DD2 31D2 2DD2 2DB2 31B2 31B2"
	$"2DB2 2DD2 2DD2 2DB2 2DD3 0166 0463 1C63"
	$"1B63 1B63 1A63 1AFD 633B FB63 1BFD 5F1A"
	$"FE5E FA03 5F1A 5EFA 5EFA 5EFB FE5E FAFD"
	$"5AFA 005A DAFA 56D9 ED52 B900 56B9 FE56"
	$"D9FE 56DA 0556 FA56 DA56 F956 D95A D95A"
	$"D9FD 56D9 0452 D952 D956 D956 D952 D9FB"
	$"52B9 0052 B8FE 52B9 004E B8FD 52B9 0C52"
	$"B852 B852 B952 B852 B84E B852 B852 9852"
	$"B84E 984E B84E 984E B8FD 4E98 064E 974E"
	$"984E 974A 974A 974E 974E 97FB 4E98 0952"
	$"9852 9852 B852 B852 9852 984E 9752 B852"
	$"B84E 98F9 4E97 FE4E 98F9 52B8 FE52 B7FD"
	$"52B8 0156 B852 B8FD 5297 0152 B752 B7FE"
	$"4E97 024E B752 9852 97FE 4E97 FD4A 9706"
	$"4A77 4A97 4A97 4A76 4A96 4A96 4A76 FD4A"
	$"7702 4A76 4A76 4A77 FE4A 7601 4676 4656"
	$"FC46 7607 4656 4256 4656 4256 4255 4255"
	$"4256 4256 FE42 5502 4235 4255 4255 FA3E"
	$"3502 3E34 3E34 3A15 FA3A 1400 3E14 FE3A"
	$"14FD 3614 F93A 1401 3E15 3A14 FC3E 1400"
	$"3E34 F73A 14FE 39F4 0135 F339 F4FE 35F4"
	$"0039 F4FD 35F3 0035 D3F4 31D3 FE31 D200"
	$"31D3 FD31 D201 2DB2 2DB2 FA2D D201 2DB2"
	$"2DD2 015E 0463 1C63 1B63 1B63 3B63 1AFE"
	$"633B FE63 1B07 631A 5F1A 631B 631B 5F1A"
	$"5EFA 5AFA 5EFA FC5A FA01 5EFA 5EFA FC5A"
	$"FA01 5AD9 5ADA FC56 D9FA 52B9 FE4E B801"
	$"52B8 52B8 FC4E B806 4EB9 4EB8 4EB9 4E98"
	$"4EB8 52B8 52B8 F952 B904 52D9 52D9 52B9"
	$"52D9 52B8 FE52 B905 4EB8 4EB8 52B8 4EB8"
	$"4EB8 52B8 FA52 B908 52B8 52B8 4EB8 52D9"
	$"4EB8 52B9 52B9 52B8 52B9 FB52 B804 5298"
	$"4EB8 4E98 4E98 4EB8 F94E 98FE 4E97 FE4E"
	$"9800 4EB8 FE52 B800 5298 FD52 B80A 52B7"
	$"52B7 52B8 52B8 5298 5298 52B8 52B8 4E98"
	$"4E98 5298 F552 B802 52B7 52B8 52B7 FB52"
	$"B803 5298 5297 52B7 5297 FE52 B7F8 4E97"
	$"FE4A 9702 4A77 4A76 4A97 FD4A 7603 4A77"
	$"4A76 4A77 4A76 FD46 76FC 4656 FE42 5600"
	$"4656 F942 5505 4235 4255 4255 4235 4255"
	$"4235 FA3E 3500 3E34 FE3A 1401 3E15 3E15"
	$"F53A 14FB 3614 EB3A 1400 35F4 FD35 F300"
	$"35F4 FC35 F3F9 31D3 082D D331 D331 D231"
	$"D331 D331 D231 D22D D22D D2FD 31D2 002D"
	$"D2FE 2DB2 042D D22D D22D B22D D22D D2FE"
	$"2DB2 0168 0763 1C63 1B5F 1A63 1A63 1A63"
	$"1B63 1B5E FAFB 5F1A F15A FA01 5AD9 56D9"
	$"FD56 DA01 56D9 56D9 FE52 B902 4EB9 4EB9"
	$"4EB8 FB4E 9801 4A98 4A98 FC4E 9805 4EB9"
	$"4E98 4EB8 4EB8 4E98 52B8 FE4E B801 4E98"
	$"4E98 FE4E B802 52B9 4EB8 4EB9 FE4E B8FD"
	$"4E98 0A4E 974E 984E 9852 B84E B84E B852"
	$"B84E B852 B852 B952 B8FC 52B9 0452 B852"
	$"B852 B94E B852 B9FC 52B8 024E B84E 984E"
	$"B8F8 4E98 064E 974E 974E 984E 984E B852"
	$"B84E 98E7 52B8 0152 B752 B7FB 52B8 094E"
	$"9752 B852 B852 B74E 9752 B852 B852 9752"
	$"B752 B7F4 4E97 014E 964A 96FB 4A76 FD46"
	$"76FE 4656 0046 55FA 4656 0242 5542 5542"
	$"56F8 4255 FE42 3502 4255 3E35 3E34 FD3E"
	$"3502 3E34 3E34 3E14 FD3A 1400 3E35 FC3A"
	$"1401 3614 3614 FB3A 14FB 3614 FD35 F305"
	$"35F4 3614 3613 3613 3614 39F4 FD3A 1412"
	$"39F4 3A14 39F4 3614 3614 3A14 3A14 35F4"
	$"35F4 35F3 35F4 35F3 35F3 35F4 35F3 35F3"
	$"31F3 35F3 31F3 F931 D3FE 31D2 0531 D32D"
	$"D231 D231 D32D D22D B2FD 2DD2 FD2D B200"
	$"2DD2 FE2D B202 29B2 29B2 2DB2 0161 025E"
	$"FB63 1C63 1BFE 631A 015F 1A5E FAF8 5AFA"
	$"005A DAFE 5AFA 0756 DA5A DA56 DA5A F956"
	$"D95A FA5A FA5A F9FE 56D9 FE56 DAFE 56D9"
	$"0252 D952 B952 B9FE 4EB9 034E 984E 984A"
	$"984E 98F5 4A98 FC4E 9804 4A97 4A97 4A98"
	$"4E98 4E98 FE4A 9801 4AB8 4A97 FC4A 98FD"
	$"4E98 004E B8FE 4E98 FD4E B8FE 52B8 0352"
	$"B952 B852 D952 B9FD 52B8 014E 984E 98FE"
	$"52B8 024E B84E 984E 97FE 4EB8 FB4E 9802"
	$"4EB8 52B8 4EB8 F652 B800 56D8 F052 B8FE"
	$"52B7 0452 9752 B752 B752 B852 B8FD 4E97"
	$"0352 B752 B852 B84E 97FE 4EB7 0652 B74E"
	$"9752 974E 9752 974E 9752 B7FC 4E97 014E"
	$"964A 96FC 4A76 0046 76FE 4656 0046 76F6"
	$"4656 0142 5546 56F8 4255 FE42 350F 3E34"
	$"3E35 3E35 3E34 3E35 3E35 3E34 3E34 3E35"
	$"3E35 3E34 3E34 3E15 3E35 3A14 3E15 EE3A"
	$"1402 35F3 3614 3614 FC35 F301 3614 3A14"
	$"FA35 F301 35F4 35F4 FD35 F300 31F3 FC35"
	$"F303 31F3 31D3 35F3 31F3 F931 D3FD 31D2"
	$"062D B22D B22D D22D D32D B22D D231 D2FD"
	$"2DD2 FE2D B202 2DD2 2DB2 2DD2 FE2D B201"
	$"A507 5F1B 631C 631B 631B 5F1A 5F1A 5AFA"
	$"5AD9 FE5A DA04 56DA 5ADA 5AFA 56DA 56DA"
	$"F95A FA04 5ADA 56DA 5ADA 56DA 56DA FD56"
	$"D909 56DA 56B9 56B9 56BA 56B9 56B9 52B9"
	$"52BA 52B9 52B9 FE4E 99FC 4A98 044A 784A"
	$"9846 9846 7846 78FE 4A78 024A 984A 984A"
	$"78FA 4A98 0346 774A 7846 7746 78FE 4677"
	$"024A 784A 784A 98FA 4E98 FE4E B8FB 52B8"
	$"004E B8FE 52B8 014E B852 B8FE 4E98 0352"
	$"984E 984E 9852 98FE 4E98 0152 9852 B8FE"
	$"4E98 F952 B804 52B9 52B9 56D9 52B8 56D8"
	$"FD56 B800 52B8 FA56 B805 52B8 56B8 52B7"
	$"56B8 56D8 52B8 FE56 B806 52B7 56B8 52B8"
	$"52B7 52B7 5297 5297 FE4E 9700 4E98 FE4E"
	$"97FE 52B7 044E 9752 984E 9752 9852 98FD"
	$"4E97 004A 97FC 4E97 014A 974A 97FE 4A77"
	$"044A 764A 7646 7646 5646 76F8 4656 0142"
	$"5642 55FE 4655 0146 5646 56F9 4255 0042"
	$"35FE 3E35 FC3E 340A 3E35 3E34 3E14 3E34"
	$"3E34 3E14 3E14 3E35 3E15 3E35 3E15 FD3A"
	$"1400 3E14 F73A 1403 39F4 3A14 35F3 39F4"
	$"FE3A 1401 39F4 35F4 FE35 F301 3A14 39F4"
	$"F835 F303 31F3 31F3 35F3 35F3 FD31 F305"
	$"31D3 31F3 31F3 31D3 31F3 31F3 F831 D30B"
	$"31D2 2DB2 2DB2 31D3 2DD2 2DD2 31D2 31D2"
	$"2DB2 31D2 31D3 2DD3 FD2D D201 2DB2 2DD2"
	$"FD2D B200 2DD2 0186 055F 1B63 1B5F 1A5E"
	$"FA5A F95A DAFB 56DA 0056 D9FE 56DA 015A"
	$"DA5A DAF9 5AFA 0156 DA56 DAFE 56D9 0356"
	$"B952 B952 D952 D9FB 52B9 034E 994E B94E"
	$"994E 98FC 4A98 004A 78F9 4677 FD4A 78FE"
	$"4677 024A 7846 774A 98FA 4677 024A 774A"
	$"784A 98FC 4E98 074E 974E B84E 9852 B952"
	$"B852 B952 B94E B8F8 4E98 014A 974E 97FE"
	$"4E98 054E 974E 974E 9852 B852 B852 98FB"
	$"52B8 FE52 B902 56B9 56D9 52B9 FE56 B901"
	$"52B9 56D8 F656 B803 56D8 56B8 56B8 52B8"
	$"FA56 B804 52B7 52B8 52B8 52B7 4E97 FD4E"
	$"96F8 4E97 0052 98FB 4E97 014A 974E 97FE"
	$"4A97 044A 774A 764A 764A 774A 77FE 4A76"
	$"0646 5646 5646 7646 7646 5646 5646 55FE"
	$"4656 1046 5542 5542 5642 5642 5546 5546"
	$"5546 5646 5646 5546 5646 5642 3542 5542"
	$"5542 3542 55FD 4235 FD3E 34FD 3E35 073E"
	$"343E 343E 143E 143E 153E 153E 353E 14F5"
	$"3A14 0639 F435 F339 F439 F435 F335 F33A"
	$"14FD 39F4 083A 1435 F339 F43A 1439 F435"
	$"F339 F435 F339 F4F6 35F3 FC31 F302 31D2"
	$"31D3 31F3 FD31 D302 31D2 31D3 31D2 FD2D"
	$"D2FE 31D3 072D D22D B22D D22D D22D B22D"
	$"D22D D32D D3FC 2DD2 FC2D B200 2DD3 0180"
	$"075F 1B5E FA5A D95A D956 D956 D956 DA56"
	$"DAFE 56D9 FD56 DA02 56D9 5AFA 5ADA F95A"
	$"FA02 5ADA 56DA 56DA FE56 D9FD 52B9 0252"
	$"D952 B952 B9FD 4EB9 034E 994E 994A 984A"
	$"99FD 4A98 0246 7746 7746 78FA 4677 004A"
	$"78FD 4677 024A 7846 774A 78FE 4677 084A"
	$"784A 984A 9846 774A 774A 984A 984E 984E"
	$"98F8 52B8 004E B8F7 4E98 004E 97FD 4E98"
	$"FE52 B802 56B9 56B9 52B8 FE56 D800 56D9"
	$"FC52 B806 52B9 56D9 52B8 56B9 52B8 52B8"
	$"56D9 FE56 B8FE 56D8 0456 B856 D856 B856"
	$"D856 D8FA 56B8 0056 D8FD 56B8 FE52 B804"
	$"52B7 5297 4E97 5297 5297 FE4E 9701 52B7"
	$"52B7 FC4E 9700 5298 FB4E 9703 4A97 4E97"
	$"4A97 4A97 FB4A 7603 4676 4A76 4676 4656"
	$"FE4A 7604 4656 4656 4255 4656 4656 FD42"
	$"5500 4256 F746 5605 4255 4655 4235 4255"
	$"4235 4255 FC42 35FB 3E35 0B3E 143E 343E"
	$"343E 143E 343E 143A 143E 143A 143A 1435"
	$"F439 F4F7 3A14 0235 F33A 143A 14FE 39F4"
	$"023A 143A 1439 F4FB 3A14 0635 F33A 143A"
	$"1435 F335 F435 F335 F4F9 35F3 FE31 F302"
	$"31D2 31D2 31F3 FC31 D304 2DD2 31D2 31D2"
	$"31D3 31D2 FE31 D3F9 2DD2 F72D B200 2DD2"
	$"0161 065A FC56 DA56 B956 DA56 D956 DA52"
	$"D9FA 56D9 0656 DA56 DA5A FA5A DA5A FA5A"
	$"FA5E FAFD 5AFA 045A DA5A FA5A DA56 DA56"
	$"DAFE 56D9 FA52 B906 4EB9 4EB9 4A98 4A98"
	$"4E99 4A98 4E98 FD4A 9805 4678 4A78 4A98"
	$"4A78 4A78 4677 FD4A 7802 4677 4A78 4A78"
	$"FC4A 9801 4A78 4A78 FB4A 98FE 4E98 0452"
	$"B852 B952 B952 B84E B8FD 52B8 FE4E B806"
	$"52B8 4EB8 4EB8 4E98 52B8 52B8 5298 FE4E"
	$"9802 4EB8 52B8 52B8 FE52 B9FD 56D9 FD56"
	$"D8F8 52B8 0356 B952 B856 B956 B8FD 56D8"
	$"0156 D956 B8FD 56D8 0056 B8FC 56D8 0256"
	$"B856 D856 B8FC 52B8 0152 B752 B7FD 52B8"
	$"0852 B752 B74E 974E 9752 B752 974E 974E"
	$"984E 98F9 4E97 004A 77FE 4A97 074A 774A"
	$"774A 764A 764A 774A 764A 764A 77FD 4A76"
	$"0046 76FC 4656 0746 5546 5642 5542 5546"
	$"5646 5646 7646 76F9 4656 FC46 5502 4235"
	$"4255 4255 FE42 3509 3E34 3E35 3E35 3E34"
	$"3E35 3E14 3E34 3E34 3E14 3E34 FE3E 14DC"
	$"3A14 0139 F339 F3FC 35F3 FD31 F3F0 31D3"
	$"052D D32D D32D D22D D32D D22D D2F7 2DB2"
	$"002D D201 7203 56DB 56DA 52B9 56D9 FE56"
	$"DA04 52B9 56DA 56D9 56DA 56D9 FE56 DA00"
	$"56FA FD5A FA01 5EFA 5EFA FB5A FA00 5ADA"
	$"FD56 DA09 56D9 56B9 52B9 56B9 56B9 52B9"
	$"52B9 4EB9 4E99 4E98 FD4E 9902 4EB9 4E98"
	$"4A98 FC4E 98F8 4A98 F94E 98FD 4EB8 1252"
	$"B84E 984E B852 B852 B952 D952 B952 B852"
	$"B84E B852 B852 B852 B94E B852 B852 B852"
	$"B94E 984E 98FC 52B8 0256 B952 B856 B9FB"
	$"56D9 0052 D9FD 52B8 0056 B8FB 52B8 FE56"
	$"B8F6 56D8 005A D9FC 56D8 0056 B8FE 56D8"
	$"FE56 B801 52B8 52B7 FD52 B801 52B7 52B7"
	$"FE52 B802 52B7 52B8 52B8 FE52 9703 4E97"
	$"52B8 5298 5298 FA4E 970B 4A97 4A97 4A76"
	$"4A76 4A77 4A77 4A76 4A76 4A97 4A76 4A97"
	$"4A77 FE4A 7601 4676 4A76 F846 56FE 4676"
	$"FD46 5601 4655 4656 FB46 5501 4656 4656"
	$"FD42 5501 4234 4235 FE3E 3500 3E14 FD3E"
	$"3502 3E14 3E14 3E35 FE3E 14F8 3A14 003E"
	$"14F2 3A14 003A 13FB 3A14 023A 133A 143A"
	$"14FE 35F4 0135 F335 F4FE 35F3 0331 D331"
	$"D335 F335 F3F7 31D3 FD2D D301 31D3 2DD3"
	$"FE31 D3FC 2DD2 022D B22D B22D D2FD 29B2"
	$"022D B229 B22D B201 84FE 56DA 0156 D956"
	$"D9FE 56DA 0356 D956 DA56 D956 D9FE 56DA"
	$"F35A FAFD 56DA FE56 D903 52B9 56D9 56D9"
	$"52B9 FE4E B908 4EB8 4EB9 52B9 4EB9 4EB9"
	$"52B9 52B8 52B9 52B8 FE52 B900 52B8 FD4E"
	$"B805 4E98 4E98 4EB8 4EB8 4E98 4E98 F652"
	$"B9FE 52B8 0252 B952 D952 D9FE 52B9 0452"
	$"B852 B952 B852 B852 B9FD 52B8 0052 B9FD"
	$"56B8 FC56 D901 56B9 56B9 F552 B803 56B8"
	$"56B8 56D9 56D9 FD56 D8FE 5AD9 F956 D8FE"
	$"56B8 0256 D856 B856 B8FE 52B8 0256 B852"
	$"B752 B7FD 52B8 FD52 B708 4E97 4E97 5297"
	$"52B7 52B7 4E97 4E97 52B7 5297 FA4E 9702"
	$"4E77 4E97 4A97 FE4A 7601 4A77 4A77 FE4A"
	$"7601 4A77 4A77 FD4A 7601 4656 4A76 FD46"
	$"7603 4656 4676 4676 4656 FE46 76FC 4656"
	$"0146 5546 56FE 4655 0E46 5646 5542 5546"
	$"5546 5646 5542 5542 5542 3542 353E 353E"
	$"353E 343E 353E 14FE 3E35 0B3E 343E 143E"
	$"343E 143E 143E 353E 143E 143E 343E 143E"
	$"343A 13ED 3A14 0136 133A 13FE 3A14 FE3A"
	$"1302 3A14 35F4 35F4 FC35 F3FD 31F3 0331"
	$"D331 D331 F331 F3FD 31D3 0631 B231 D331"
	$"D331 D22D D22D D331 D3FD 2DD3 012D D22D"
	$"D3FD 2DD2 FE2D B2FA 29B2 002D B201 6907"
	$"56DA 56DA 52D9 56DA 56D9 56D9 56DA 56DA"
	$"FD56 D9FE 56DA 0056 FAF4 5AFA FD56 DA00"
	$"56D9 FE52 D903 52B9 52B9 56D9 52D9 FE52"
	$"B901 4EB8 52D9 FB52 B902 56B9 56D9 56D9"
	$"FE52 B905 52B8 52B8 52B9 52B9 52D9 52D9"
	$"F552 B907 56B9 56B9 52B8 52B8 52B9 52D9"
	$"52B9 52D9 FD52 B9FC 52B8 0252 B952 B956"
	$"B9F8 56D9 0056 B9F8 52B8 FE56 B801 56D9"
	$"56D9 FB56 D802 5AD9 5AD9 56D9 F856 D8FD"
	$"56B8 FD52 B801 52B7 52B8 FE52 B711 52B8"
	$"4EB7 52B7 52B7 4E97 4E97 4EB7 4E97 4E97"
	$"4EB7 52B7 4EB7 4E97 4E97 4E96 4E96 4E97"
	$"4E97 FE4A 9705 4E97 4A97 4A76 4E97 4A97"
	$"4A77 FA4A 7601 4A77 4A77 F94A 7600 4676"
	$"FD4A 7605 4676 4A76 4676 4656 4656 4676"
	$"FE46 5600 4655 FA46 5604 4255 4255 4676"
	$"4255 4255 FD42 35F9 3E35 033E 343E 353E"
	$"353E 14FD 3E34 033E 353E 343E 343E 14F2"
	$"3A14 0035 F4FD 3A14 0635 F336 1336 133A"
	$"1435 F335 F335 F4FA 35F3 FA31 F301 31D3"
	$"31F3 FE31 D30A 2DD2 31D3 31D3 2DD2 2DD2"
	$"2DD3 31D3 2DD2 2DD3 31D3 31D3 FD2D D2FB"
	$"2DB2 FB29 B200 2DB2 0181 0B56 DB56 DA52"
	$"B956 DA56 D956 D956 DA56 DA56 D952 D956"
	$"DA56 D9FB 56DA 025A DA56 D95A D9FC 5AFA"
	$"005A DAFE 56DA 0156 D956 D9F9 52D9 0056"
	$"B9FE 56D9 1056 B956 D956 DA56 D956 D95A"
	$"DA5A D956 D956 D95A DA5A DA56 D956 D956"
	$"DA56 D956 D956 DAFC 56D9 0052 D9FC 52B9"
	$"FC56 B901 52B8 52B8 FE56 D904 52B9 52D9"
	$"52B8 52B8 52B9 FD52 B800 52D9 FE56 D900"
	$"52B8 FA56 D900 56D8 FD56 D900 56B9 FE52"
	$"B906 56D9 56D9 56B8 56D9 56D9 56D8 56D9"
	$"FD56 D800 56D9 FE56 D800 5AD8 FD56 D802"
	$"56D9 56D8 56D8 FB56 B8FE 52B8 FE52 B700"
	$"52B8 FD52 B702 4EB7 4EB7 52B7 FE4E B7FB"
	$"4E97 FE4A 9703 4A76 4A97 4A76 4A76 FE4A"
	$"77F8 4A76 034A 774A 774A 764A 77F9 4A76"
	$"0046 76FD 4A76 0046 76FC 4A76 FE46 7600"
	$"4656 FD46 7602 4656 4656 4676 FD46 5608"
	$"4235 4255 4235 4255 4235 4235 3E34 4235"
	$"3E35 FD42 3501 3E34 4235 F73E 3404 3A14"
	$"3A14 3E14 3E14 3E34 F73A 1408 35F3 3A14"
	$"35F4 35F4 35F3 35F3 35F4 35F3 35F4 F735"
	$"F3FE 31F3 0331 D331 D331 F331 F3FA 31D3"
	$"012D D32D D3FC 31D3 022D B22D D231 D3FE"
	$"2DD2 FC2D B2FA 29B2 002D D201 57FE 56DA"
	$"FD56 D900 56B9 FC56 DAFE 56D9 F356 DA05"
	$"56D9 56D9 52D9 52B9 52D9 56DA FC56 D900"
	$"56DA F35A FAFE 5EFA 045A FA5A F95A FA5A"
	$"FA56 F9FC 56D9 F956 B902 52B9 56B9 56B9"
	$"FE52 B901 56D9 56B9 FE52 B901 56B9 56B9"
	$"E656 D902 56B8 56D9 56D8 FC56 D9F8 56D8"
	$"0156 B852 B8FE 56B8 FB52 B808 4E97 52B7"
	$"52B8 52B7 52B8 5297 5297 4E98 4E98 FE4E"
	$"B8FD 4E97 0B4A 974A 774A 974A 974A 774A"
	$"774A 764A 774A 764A 764A 774A 76FE 4676"
	$"024A 774A 774A 76FE 4A77 034A 764A 774A"
	$"974A 76FD 4A77 014A 974A 76FE 4A77 FE4A"
	$"7604 4676 4A76 4A76 4676 4676 FC4A 76FE"
	$"4676 0046 56FD 4676 FC46 560A 4255 4235"
	$"4255 4255 4235 4235 4255 4255 4235 4235"
	$"4255 FE42 350C 3E35 3E35 3E34 3E35 3E14"
	$"3E34 3E35 3E35 3E34 3E35 3E35 3E34 3E34"
	$"FC3E 35F8 3A14 FE39 F4F9 35F3 0431 F331"
	$"F335 F335 F331 D3FE 31F3 FE31 D300 31F3"
	$"F831 D300 2DD3 FB31 D304 31D2 31D2 31B2"
	$"2DD3 2DD3 FE2D D202 2DB2 2DB2 2DD2 FA2D"
	$"B200 2DD3 017E 0156 DA56 DAFE 56D9 0552"
	$"D952 B952 B956 DA56 D952 D9FE 56DA 0356"
	$"D956 D956 DA56 DAFC 56D9 0356 DA56 D952"
	$"D952 D9FE 56D9 0852 B952 B952 D952 B952"
	$"D956 D956 DA56 DA56 D9FE 56DA F75A FAFD"
	$"5EFA 025E F95A F95E FAFE 5AF9 0156 F956"
	$"F9F2 56D9 0752 B852 B856 B856 B956 B856"
	$"D956 B956 B9F7 56D9 0056 D8EE 56D9 0256"
	$"D856 D956 B8FE 56D9 0056 D8FA 56B8 F452"
	$"B807 4E97 4E97 52B8 4E97 4E97 4EB8 4EB7"
	$"4E97 FE4E 9806 4EB8 4E97 4E97 4A97 4A97"
	$"4E97 4A97 FE4A 7702 4A76 4A77 4A77 FB4A"
	$"760B 4A77 4A77 4E97 4A97 4A97 4E97 4A97"
	$"4A76 4A76 4A96 4A97 4A76 FE4A 77FE 4A97"
	$"FE4E 77F8 4A76 0046 76FC 4A76 0046 76FC"
	$"4A76 0046 56FE 4676 0A46 5646 5546 5546"
	$"5646 5542 5542 5542 3542 353E 353E 35FC"
	$"4235 043E 353E 343E 353E 343E 34FB 3E35"
	$"FC3E 3403 3A34 3A13 3A14 3613 FD3A 1405"
	$"39F4 3A14 35F3 39F4 39F4 3A14 FE35 F301"
	$"35F4 3A14 FB35 F303 31F3 35F3 31F3 31D3"
	$"FE31 F3FD 31D3 FE31 F304 31D3 31F3 31F3"
	$"31D2 31D2 FA31 D300 2DB2 FE31 D207 2DD2"
	$"2DD2 2DB2 2DB2 2DD2 2DB2 2DD2 2DB2 FD2D"
	$"D200 31D3 0145 0B52 BA52 DA52 B952 D952"
	$"D952 B952 B952 D952 D956 DA56 D956 FAFB"
	$"56DA FB56 D9FD 52B9 FE56 D900 52D9 FE56"
	$"D904 56DA 5AFA 56FA 56D9 56FA FA5A FA01"
	$"5AF9 5AFA F85A F901 5AFA 5AF9 F856 D902"
	$"5AF9 5AD9 5AD9 F856 D901 56D8 56D8 F756"
	$"D903 56B9 52B9 52B8 56D8 F456 D9FE 52B8"
	$"0056 B9FD 56D9 0256 B852 B852 D8EC 52B8"
	$"0452 9752 B84E B74E 974E B7F6 4E97 FE4A"
	$"9706 4E97 4A97 4A77 4A97 4A77 4A76 4A76"
	$"FE4A 9701 4E97 4E77 FE4E 9704 4E96 4E96"
	$"4A96 4A96 4E96 FE4A 9601 4E97 4E97 FD4A"
	$"9701 4A77 4A97 FC4A 7600 4E76 EF4A 7602"
	$"4656 4676 4A76 FE46 7600 4656 FE46 5500"
	$"4255 FD42 3500 3E35 FE42 350D 3E35 3E35"
	$"3E34 3E34 3E35 3E34 3E35 3E34 3E35 3E14"
	$"3E14 3E34 3E14 3E14 FE3E 3400 3A14 FE3A"
	$"13FC 3A14 0935 F33A 1439 F43A 143A 1439"
	$"F439 F436 143A 143A 14F5 35F3 FC31 F3FD"
	$"31D3 0131 F331 F3FA 31D3 FE31 D201 31D3"
	$"31D3 FE31 D2F7 2DD2 0031 D301 6503 56DA"
	$"56DA 52D9 56D9 FE52 D9FD 56DA 035A FA56"
	$"DA56 DA56 FAFA 56DA 0556 D956 DA56 D956"
	$"D952 D956 D9FE 56DA 0156 D956 D9FE 56DA"
	$"FD5A FAF9 5EFA 035A FA5A F95A F95A FAF8"
	$"5AF9 FC56 D907 5AD9 5AF9 5AD9 5AFA 5AF9"
	$"5AF9 56D9 5AD9 FE5A F901 5AD9 56D9 F85A"
	$"D9F1 56D9 0356 D856 D852 B856 D8FD 52B8"
	$"0356 B956 B952 B852 B8FE 56B8 FB52 B801"
	$"4EB8 4EB8 F852 B800 4E98 FE4E 9705 4E98"
	$"4E97 4E98 52B8 52B8 5297 FE4E 9700 5297"
	$"F94E 9700 4A97 FD4E 9700 4A97 F74E 9705"
	$"4A97 4E97 4A97 4E97 4E97 4A97 FB4E 9705"
	$"4A97 4A97 4E97 4A97 4A76 4A76 FE4A 9607"
	$"4E96 4A76 4E96 4E96 4E76 4A76 4A77 4A77"
	$"F34A 7602 4675 4655 4676 FC46 5500 4255"
	$"FD42 3505 3E35 3E35 4235 4235 3E35 3E35"
	$"FE3E 34FE 3E35 FD3E 34FE 3E14 FB3A 1400"
	$"3614 FD3A 14FE 39F4 F93A 1404 3614 3614"
	$"35F3 35F3 3614 FD35 F303 3614 3614 35F3"
	$"3614 FD35 F300 35D3 FD31 D309 35D3 35D3"
	$"31D3 35F3 31D3 31D3 31D2 35D3 31D3 31D3"
	$"F831 D203 2DD2 2DD2 31D2 31D2 FE2D D200"
	$"31D2 0151 055A FB56 DA56 DA5A DA56 D956"
	$"D9FC 56DA FE5A DAFD 56DA 055A FA5A FA5A"
	$"DA56 DA56 DA56 D9FC 56DA 0256 D956 D956"
	$"DAFE 5ADA 005A FAFE 5EFA 005F 1AFE 5EFA"
	$"015F 1A5F 1AF5 5EFA 005E F9FE 5AF9 FD5A"
	$"D902 5AF9 5AF9 5EFA F05A F9FE 5AD9 FA56"
	$"D900 56D8 FE56 D900 52B9 FD52 B800 52B9"
	$"FA52 B800 56B9 F752 B800 5298 FD52 B807"
	$"5298 5298 52B7 4EB8 4EB7 4EB7 52B8 52B7"
	$"FE52 97FD 4E97 004E B7FD 5297 0052 B8FE"
	$"4E97 004E 98FE 4E97 024E 984E 974A 97F6"
	$"4E97 0152 9752 97F4 4E97 004E 77FD 4A77"
	$"014A 764A 76FE 4E76 004E 96FE 4E97 014E"
	$"764E 77FE 4E97 044E 964A 964A 764A 764E"
	$"76F9 4A76 0446 7646 7646 5646 5546 55FE"
	$"4255 FE42 35F8 3E35 023E 143E 343E 34FC"
	$"3E35 023E 153E 143E 14FC 3A14 013A 133A"
	$"13FC 3A14 083A 1339 F339 F33A 143A 1439"
	$"F435 F339 F43A 14FE 39F4 0035 F4ED 35F3"
	$"FE31 D301 35F3 35F3 FB31 D3FE 31D2 0031"
	$"F3FD 31D2 0731 D32D D231 D231 D331 D231"
	$"D22D D231 D201 4416 5AFA 5AFA 5ADA 5ADA"
	$"5AD9 5ADA 56DA 56DA 5ADA 56DA 56D9 56DA"
	$"56D9 56DA 5ADA 5ADA 5AFA 56D9 56D9 5AFA"
	$"56D9 56DA 5AFA FB5A DA03 56DA 56FA 5AFA"
	$"5ADA FC5E FAF0 5F1A FE5E FA08 5EF9 5EF9"
	$"5AF9 5AF9 5EF9 5EF9 5EFA 5AF9 5AF9 FC5E"
	$"FAFA 5AF9 005A FAFE 5EF9 FE5A F902 5AD9"
	$"5AF9 5AF9 FE5A D90B 56D9 56D9 56D8 56B8"
	$"56D9 56D9 52B9 56B9 52B8 52B8 52B9 52B9"
	$"EB52 B807 5298 5298 52B8 52B8 52B7 4E97"
	$"4E97 4EB7 F84E 9705 4EB7 4E97 5298 52B8"
	$"4E97 5297 EC4E 9701 4EB7 4EB7 F44E 9701"
	$"4E96 4E96 FE4A 7601 4E76 4A76 FE4E 7604"
	$"4E96 4E96 4E97 4E97 4E96 FD4E 97F9 4A76"
	$"0046 56FE 4676 FD46 5601 4255 4255 FB42"
	$"35FD 3E35 003E 34FE 3E35 F73E 3401 3E14"
	$"3E14 EE3A 14F4 35F3 0731 F331 D331 F331"
	$"D231 F331 F331 D331 F3FD 35F3 0031 F3FC"
	$"35F3 0931 D331 D231 F331 D331 D331 D231"
	$"D22D D22D D231 F3FD 31D2 0731 D32D D231"
	$"D231 D22D D231 D22D D22D D201 7D09 5AFB"
	$"5AFA 56DA 5AFA 5AFA 5ADA 56DA 56D9 56DA"
	$"56DA FE56 D9FE 56DA 055A DA56 D956 D95A"
	$"DA56 D956 DAFE 5AFA 005A DAFE 5AFA 035E"
	$"FA5E FA5A FA5E FAFC 5F1A FD63 1AFE 5F1A"
	$"0263 1B63 1B63 1AFB 5F1A 015F 195F 19FC"
	$"5EFA FD5F 1A06 5EFA 5EFA 5F1A 5EFA 5F1A"
	$"5EFA 5EFA F95E F905 5EFA 5EF9 5EF9 5AF9"
	$"5AF9 5EF9 FE5A F9FD 56D9 0456 D856 D852"
	$"B856 D952 B9FD 56D9 0452 B952 B852 B852"
	$"B952 B9EE 52B8 0752 9852 984E B852 B852"
	$"B752 9752 9752 B8FD 4E97 024E B752 B74E"
	$"97FE 5297 034E 9752 9852 B852 97FE 4E97"
	$"0552 974E 974E 974E B74E 974E 96F4 4E97"
	$"014E B74E B7F8 4E97 014E 964A 76FD 4E96"
	$"004A 76FE 4E96 FC4A 76FC 4A96 024A 974A"
	$"974A 96FD 4A76 034A 7546 7646 7646 75FE"
	$"4655 0246 7646 5546 55FE 4255 0342 353E"
	$"3542 3542 35FD 3E35 0542 3542 353E 353E"
	$"343E 353E 35F4 3E34 053E 143A 143A 143E"
	$"143E 343E 34F7 3A14 0535 F33A 143A 1435"
	$"F339 F439 F4FA 35F3 FD31 F306 31D3 31F3"
	$"31D3 31D3 31F3 31D2 31D2 F931 D301 31F3"
	$"31F3 FC31 D204 2DD2 31D2 31D2 2DD2 31D2"
	$"F82D D202 2DB2 2DB2 2DD2 014F 005A FBFE"
	$"5AFA 005A D9FE 5ADA 0056 FAFC 56DA FD56"
	$"D9FE 5ADA 0056 DAFD 5AFA 075E FA5E FA5F"
	$"1A63 1B5F 1A5E FA63 1A63 1AFE 5F1A F863"
	$"1A02 631B 631A 631A FA5F 1AFD 631A 025F"
	$"1A63 1A63 1AF8 5F1A FD5E F9FC 5EFA 015E"
	$"F95E F9FD 5AF9 0056 D8FC 56D9 0056 D8FB"
	$"56D9 0152 B952 B9F4 52B8 034E B852 B84E"
	$"B84E B8F9 52B8 0752 984E B84E B84E B752"
	$"9752 B852 9752 B7FB 4E97 FE52 9706 4E97"
	$"4E97 5297 5297 4E97 4E97 5297 EE4E 9701"
	$"5297 5297 FC4E 9703 4E96 4E96 4E97 4A76"
	$"FE4E 9603 4E97 4E97 4E96 4E96 FE4E 9704"
	$"4E96 4A96 4A97 4E97 4A97 FC4A 7600 4A96"
	$"FB4A 7603 4675 4676 4675 4655 FA42 5501"
	$"3E35 4255 F93E 3503 3E34 4235 3E35 3E35"
	$"FA3E 3401 3E15 3E15 FA3E 3502 3E14 3E34"
	$"3E34 F63A 1402 3A13 39F4 39F4 FE3A 1401"
	$"39F4 39F4 FC35 F3FD 31F3 FA31 D301 2DD2"
	$"31D3 FE2D D3FE 2DD2 002D B2FC 2DD2 002D"
	$"B2FD 2DD2 012D B12D B1FC 2DD2 062D B22D"
	$"D22D B229 B22D B22D B22D D201 5804 5EFB"
	$"5AFB 5AFA 5AFA 5AF9 FD5A FA00 5ADA FD56"
	$"DA04 5AFA 56DA 5ADA 5AD9 5ADA FD5A FA04"
	$"5EFA 5EFA 5F1A 5EFA 5EFA F95F 1A02 631A"
	$"631A 633A F863 1A00 633A EF63 1AFE 5F1A"
	$"005F 19FB 5F1A FC5A F906 5AD9 5AF9 5AF9"
	$"5AD9 5AD9 56D9 5AD9 FD56 D900 5AD9 FC56"
	$"D905 52B9 52B8 52B9 52D9 52B9 56B9 FE52"
	$"B800 52B9 FD52 B805 4E98 4EB8 4E98 52B8"
	$"4E98 4E98 FC4E B801 52B8 52B8 FB4E B8FD"
	$"4EB7 0752 B852 B84E 974E 9852 B852 9852"
	$"9852 B8F9 4E97 0052 97FE 4E97 0052 97FE"
	$"4E97 0452 B84E 9752 9752 9752 B8F4 4E97"
	$"074A 764A 764E 974E 974E 964A 764E 964E"
	$"96F8 4E97 F94A 7605 4676 4A76 4A76 4676"
	$"4656 4656 FD42 56FE 4255 FE42 3501 3E35"
	$"4235 F63E 3509 3E14 3E14 3E34 3E34 3A34"
	$"3A34 3E35 3A14 3E35 3E15 FD3E 3502 3E15"
	$"3E15 3E34 FD3E 1401 3A14 3E14 F93A 1400"
	$"35F3 FD3A 1401 35F4 35F4 FE35 F3FA 31F3"
	$"FA31 D304 2DD3 2DD3 31D3 31D3 2DD3 FE2D"
	$"D2F7 2DB2 0431 D315 0C29 B131 D22D B1F8"
	$"2DB2 002D D201 3A01 5AFB 5EFB F85A FAFE"
	$"56D9 055A FA5A FA5A DA5A DA5A FA5A DAFD"
	$"5AFA F95E FAFD 5F1A F463 1A04 633A 633A"
	$"633B 633A 633A F563 1AFE 5F1A FE5F 19FD"
	$"5F1A F85A F904 5AD9 5AD9 56D9 5AF9 5AD9"
	$"FE56 D901 5AF9 5AF9 FD56 D902 56D8 52B8"
	$"52B8 FE52 D9FA 52B8 004E B8FD 4E98 034E"
	$"974E B84E B84E 97FA 4EB8 014E 984E 98FA"
	$"4E97 014E 984E 97FC 4E98 0152 9852 98FE"
	$"4EB8 044E 9852 9852 9852 9752 B7FD 4E97"
	$"0252 B752 B752 97F5 4E97 034E 764E 964E"
	$"974E 96FE 4A76 014E 964E 96FE 4A76 F84E"
	$"97F9 4A76 FD46 76FE 4656 0042 56FC 4255"
	$"0142 3542 35F9 3E35 FE3A 3508 3A34 3A34"
	$"3A14 3A34 3E14 3E14 3A14 3A34 3A35 FE3A"
	$"140C 3E14 3E14 3A14 3A15 3A35 3A14 3A14"
	$"3E15 3E14 3E14 3E34 3E34 3E14 F53A 14FC"
	$"35F4 FE35 F3FE 31F3 0331 D231 D331 D331"
	$"F3F9 31D3 022D D331 D331 D3FC 2DD2 F72D"
	$"B205 10CA 2DD2 31D2 2DB1 2DB2 29B2 F92D"
	$"B201 5C05 5EFB 631B 5EFA 5AFA 5EFA 5EFA"
	$"FC5A FA09 5AF9 5AF9 5AD9 5AF9 5AFA 5ADA"
	$"5AFA 5AFA 5ADA 5AFA FE5E FA06 5F1A 631A"
	$"631A 5F1A 5F1A 631A 631A FE5F 1AF1 631A"
	$"0163 3A63 3AF5 631A 005F 1AFC 5F19 025A"
	$"F95A F95E F9F8 5AF9 0456 D956 D95A F95A"
	$"F95A D9FA 5AF9 0156 D956 D8FE 56D9 0156"
	$"D852 B8FE 52D8 FB52 B8FD 4EB8 0B4E 974E"
	$"974E B84E 984E B84E 984E 984E B84E 974E"
	$"974E 984E 98EF 4E97 0152 9852 98FE 4EB8"
	$"034E 9852 9852 984E 97FE 52B7 0352 9752"
	$"B752 B752 97F4 4E97 074A 964E 974E 974E"
	$"964E 964E 974E 974E 96FB 4E97 034E 964A"
	$"764E 974E 97F6 4A76 0746 7646 5646 5546"
	$"7646 5546 5642 5642 55F2 3E35 073A 343A"
	$"343E 353A 143A 343A 143A 143E 14FE 3A14"
	$"053A 343A 1436 143A 143E 143E 14FC 3A14"
	$"083E 153E 143E 143E 343E 343E 143E 143E"
	$"343E 14FB 3E34 FC3A 14FE 35F4 FE35 F3FE"
	$"31F3 FC31 D303 2DD3 2DD3 31D3 2DD3 FA31"
	$"D300 2DD3 FE2D D2F8 2DB2 0631 D315 0C2D"
	$"B131 D22D B12D B229 B2FC 2DB2 FE2D D201"
	$"6F08 631B 631B 5F1A 5EFA 5F1A 5F1A 5EFA"
	$"5F1A 5F1A FB5E FAFE 5AFA 055A DA5A FA5E"
	$"FA5E FA5F 1A5F 1BFE 631B 0163 1A5F 1AFD"
	$"631A 005F 1AFC 631A 0163 3A63 3AEB 631A"
	$"005F 1AFD 5F19 F55A F9EF 56D9 0156 D856"
	$"B8FB 52B8 FE4E B807 52B8 4EB8 4EB8 4E98"
	$"4EB8 4E98 4EB8 4EB8 FE4E 9802 4E97 4E97"
	$"4E98 F34E 9700 4A97 F34E 9704 5297 5297"
	$"52B8 52B8 5297 FD4E 970A 4A97 4E97 4E97"
	$"4A97 4A97 4A96 4A76 4A96 4A96 4A76 4A76"
	$"FA4E 9705 4E96 4E97 4E97 4E96 4E76 4E76"
	$"FA4A 7601 4675 4676 FA4A 7601 4676 4676"
	$"FE46 5505 4235 4255 3E55 3E35 3E35 4235"
	$"FE3E 350F 3E34 3E35 3A34 3A34 3E34 3A14"
	$"3A34 3E34 3E34 3E14 3A14 3A14 3E14 3E14"
	$"3A14 3E14 F83A 1401 3E15 3E15 FE3A 1405"
	$"3E35 3A14 3E15 3E34 3E34 3E14 FA3E 3406"
	$"3E35 3E35 3E34 3E34 3E14 3E34 3A15 FE3A"
	$"1403 35F4 35F4 35F3 35F3 FB31 F301 31D3"
	$"31D3 FD2D D30B 2DD2 2DD2 31D3 2DD3 2DD2"
	$"2DD3 31D3 2DD3 2DD3 31D3 2DD2 2DD3 FC2D"
	$"B200 29B2 FE2D B206 31D3 14EB 2DB1 31D2"
	$"2DB1 2DB2 29B2 FC2D B202 2DD2 2DD2 2DB2"
	$"0173 0263 1C63 1B63 1BFC 631A 015F 1A5E"
	$"FAFB 5F1A 0363 1A5E FA5E FA5F 1AFD 631A"
	$"FD63 1BF7 631A 0367 1B63 1B67 3B67 3BF5"
	$"631A 025F 1A63 1A63 1BFE 631A 065F 1A5F"
	$"1A5F 195F 195E FA5E FA5E F9FD 5AF9 0156"
	$"F95A FAFE 5AF9 035A D95A F95A D856 D8F2"
	$"56D9 0552 D952 B952 B856 B956 B952 B9FE"
	$"52B8 0C52 B952 B84E B852 B84E B84E 984E"
	$"B84E 984E B84E B84E 984E B84E B8F9 4E98"
	$"FE4E 9703 4A97 4A97 4E97 4E98 FC4E 9702"
	$"4A97 4E97 4E97 FD4A 97F6 4E97 0052 97F5"
	$"4E97 004A 77FE 4E77 FE4E 9706 4E96 4E97"
	$"4E97 4E76 4A76 4E97 4E96 FA4A 7601 4676"
	$"4676 FD46 5607 4676 4676 4656 4656 4655"
	$"4656 4656 4256 FE42 5501 3E35 4255 F93E"
	$"3503 3A35 3A15 3A35 3A35 F73A 1400 3E15"
	$"F83A 1400 3E15 FE3E 14FC 3E35 FC3E 3401"
	$"3E35 3E35 FC3E 3403 3E14 3E14 3E34 3E14"
	$"FD3A 1400 39F3 FC35 F3FD 31F3 0031 D3FC"
	$"2DD3 0E2D D22D D22D D32D D22D D32D D32D"
	$"B231 D331 D32D B231 D331 B32D B22D D32D"
	$"B2FE 29B2 082D B22D B231 D215 0C25 902D"
	$"F329 B12D B22D B2FE 29B2 042D B22D B229"
	$"B229 B22D B201 5C02 631C 631B 631B FB63"
	$"1A00 5F1A FE63 1B00 5F1A FB63 1A00 631B"
	$"FE63 1AFD 631B F963 1A00 673B FE63 1A00"
	$"633A FE63 1AF6 5F1A 0063 1AFB 5F1A 035F"
	$"195E F95E FA5A FAFA 5AF9 FC56 F901 56D8"
	$"56D8 FB56 D908 56B9 56D9 56D9 56B9 52B9"
	$"52B9 52D9 52D9 52B9 F852 B805 4EB8 4EB8"
	$"4E98 4EB8 4EB8 4E98 FE4E B8FC 4E98 064E"
	$"974E 974A 974E 984E 974A 974E 97FB 4A97"
	$"FB4E 9704 4A97 4E97 4E97 4A97 4A97 F34E"
	$"9703 4A97 4E97 4A96 4A97 FC4E 9706 4A76"
	$"4E97 4A96 4A76 4A96 4A96 4A76 FD4E 9601"
	$"4A97 4A77 FB4A 76FD 4676 0342 5542 5642"
	$"5542 56F9 4255 0342 3542 353E 3542 55F9"
	$"3E35 053A 353A 353A 143A 353A 153A 35FD"
	$"3A14 0136 143A 14F5 3614 F93A 14FD 3E35"
	$"013E 343E 34FD 3E35 043E 343E 353E 353E"
	$"343E 34FD 3E14 FB3A 1400 39F3 FC35 F300"
	$"31F3 FE31 D3FB 2DD3 0D2D D22D D22D D32D"
	$"B22D D22D D22D B22D B22D D32D B22D D32D"
	$"B22D B22D D3FC 29B2 052D B235 F410 CA15"
	$"0C36 142D D2FC 29B2 042D B22D B229 B229"
	$"B22D B201 6502 673C 673B 631B F163 1A01"
	$"633A 633A FE63 1AFC 633A 0263 1A63 1A63"
	$"3AFC 673B FA63 1A02 5F1A 631A 631A FA5F"
	$"1A01 5F19 5F19 FE5E FA06 5EF9 5F1A 5F1A"
	$"5F19 5EF9 5AFA 5AFA FE5A F902 5EF9 5EF9"
	$"5AD9 FE5A F900 56F9 FE56 D900 56F9 F856"
	$"D904 52B9 52B9 52B8 52D9 52D9 F752 B811"
	$"4EB8 4E98 4EB8 4EB8 4E98 4EB8 4E98 4EB8"
	$"4EB8 4E98 4E98 4E97 4E98 4E98 4E97 4E97"
	$"4A97 4E98 FD4A 9701 4E97 4A97 F14E 9701"
	$"4EB7 4EB7 F64E 9701 4A97 4E97 FE4A 9709"
	$"4E97 4E97 4A97 4A96 4A97 4A96 4A76 4A96"
	$"4A96 4A76 FD4A 9604 4A77 4A77 4A76 4676"
	$"4A76 FC46 76FE 4255 073E 5542 553E 553E"
	$"353E 553E 353E 3542 55F3 3E35 F83A 14F0"
	$"3614 013A 1436 14FA 3A14 013A 153A 15FE"
	$"3E34 FE3E 3507 3E34 3E35 3E35 3E34 3E34"
	$"3A14 3E14 3E14 FA3A 1400 3A13 FD35 F301"
	$"31F3 31F3 FE31 D3FD 2DD3 FC2D D205 2DB2"
	$"2DD2 2DD2 2DB2 2DD3 2DD3 FD2D B215 2DD2"
	$"29B2 29D2 29D2 2DD2 2DB2 29B2 35F4 10CA"
	$"0CA8 3A13 2DD1 29B1 29B2 29B2 2DB2 29B2"
	$"2DB2 2DB2 29B2 29B2 2DB2 0161 0A67 3C67"
	$"3C63 3B67 3B67 3B67 3A63 3A63 1A63 3A63"
	$"3B63 3AFE 631A 0367 3B67 3B67 3A63 3AFB"
	$"673A FC63 3A01 631A 631A FB67 3AF6 631A"
	$"015F 1A5F 1AFB 5F19 045A FA5E FA5E FA5E"
	$"F95E FAFE 5EF9 FE5E FAFD 5AF9 005A D9FC"
	$"5AF9 FE5A D9FB 56D9 0452 D852 B852 D952"
	$"B852 B8F9 4EB8 004E 97FD 4EB8 064E 984E"
	$"974E 974E 984E 974E 984E 97FD 4E98 014E"
	$"974E 98FE 4E97 004E 98FC 4A97 004E B7FD"
	$"4E97 0052 97FB 52B7 0252 B852 B752 B8FC"
	$"52B7 FE4E B702 4E97 4E97 4EB7 F44E 9702"
	$"4A97 4A97 4A96 FB4A 76FC 4676 0246 5646"
	$"5642 56FE 4255 0046 55FE 4235 FB3E 3501"
	$"4235 4236 FA3E 3505 3A35 3A35 3E35 3A35"
	$"3E35 3A15 FB3A 1403 3614 3614 3A14 3A14"
	$"FB36 1400 35F4 F436 14F8 3A14 013A 343A"
	$"34FC 3E34 013E 353E 35FE 3E34 023A 143A"
	$"143A 34FD 3A14 0039 F3FC 35F3 FC31 F300"
	$"31D3 FE2D D3FD 2DD2 072D D32D D22D D32D"
	$"D329 B22D D32D D22D D3FE 2DB2 0C2D D229"
	$"B229 D229 B229 B22D D22D B235 F31D 0B1C"
	$"EA39 F131 B02D B1FE 2DB2 FB29 B201 6203"
	$"673C 673B 673A 673A FE67 3B00 673A FC67"
	$"3B02 673A 673B 673B FD67 3AFD 673B FD67"
	$"3A09 673B 673B 673A 673A 673B 673A 673B"
	$"631A 673B 673A FA63 1AF6 5F1A FD5E FAFD"
	$"5EF9 005F 1AFE 5EF9 025F 1A5A F95F 1AF9"
	$"5AF9 005A D9FA 56D9 0052 B9FD 52B8 0B4E"
	$"B84E 984E B852 B852 B84E B84E 984E 984E"
	$"B84E 984E 974E 98F9 4E97 004E 98FA 4E97"
	$"004E 98FE 4E97 074E 984E B74E 974E 9752"
	$"9852 9852 B852 B8FD 52B7 0C56 B852 B852"
	$"B856 B856 B852 B852 B752 B752 B852 B852"
	$"B752 B752 B8FC 4E97 FB4A 9700 4A77 FE4A"
	$"9703 4A76 4A76 4676 4676 FA46 56FD 4256"
	$"0142 5542 55FE 3E35 0B42 363E 353E 3542"
	$"5642 563E 353E 3542 353E 353E 353E 363E"
	$"35FE 4256 003E 36FD 3E35 FC3A 3500 3A15"
	$"FC3A 14F9 3614 0135 F43A 14F9 3614 FE35"
	$"F4FD 3614 E83A 1405 35F4 3A14 3614 35F4"
	$"35F3 35F3 FE31 F303 31D3 31D3 31F3 31D3"
	$"F92D D301 2DD2 2DD2 FC2D D302 29B2 2DD3"
	$"29B2 FD2D B2FE 29B2 082D B22D 9239 D329"
	$"2D20 C93D D035 AF2D 8F29 90FA 29B2 002D"
	$"B301 7E03 6B3D 6B3C 673A 673A FE67 3B00"
	$"673A FA67 3B00 673A F867 3BFE 673A 0067"
	$"3BFE 673A 0263 3B63 1A63 3AFE 631A 025F"
	$"1A5F 1A63 1AFE 5F1A 015F 195F 19F6 5F1A"
	$"005E FAFC 5EF9 005A F9FE 5EF9 035F 1A5A"
	$"F95A F95E F9FB 5AF9 025A FA5A F95A D9FC"
	$"56D9 0256 B956 D952 B9F5 52B8 074E 9852"
	$"B852 B84E B852 B852 B84E B74E B7FC 52B8"
	$"0952 9852 B852 B84E 974E B74E 974E 9752"
	$"B84E 9752 97FE 52B8 0952 B752 B752 B852"
	$"B852 B752 B852 B752 B752 D852 D7FC 52B8"
	$"0552 B752 B752 B852 B852 B752 B7FD 4E97"
	$"004A 97FD 4A77 F946 76FC 4255 0042 56FD"
	$"4255 FD42 5605 4255 4235 4235 4256 3E35"
	$"4255 FE3E 3507 3E56 3E35 3E35 4256 4236"
	$"3E36 4256 4256 F93E 35FC 3A35 003A 15FE"
	$"3A14 013A 153A 14FE 3614 0035 F4FC 3614"
	$"0035 F4F4 3614 023A 1436 1436 14F6 3A14"
	$"0236 1435 F335 F3FD 3614 FE35 F304 3614"
	$"3614 35F3 35F3 31F3 FE35 F3FE 31F3 FD2D"
	$"F3FD 2DD3 0031 D3FB 2DD3 0C2D D22D D32D"
	$"B32D B329 B22D B329 B229 B329 B229 B22D"
	$"B229 B22D D2FD 29B2 0829 9139 D32D 0C24"
	$"A749 D039 AE21 4B15 0A2D D2FB 29B2 002D"
	$"D301 6202 6B5D 6B3C 673A FD67 3B00 673A"
	$"FB67 3B01 673A 673A F867 3BFC 673A 0267"
	$"1A67 1A63 3AFD 631A FE5F 1A00 631A FD5F"
	$"1A03 5F19 5F19 5F1A 5EFA FB5F 1A02 5EFA"
	$"5F1A 5EFA FC5E F9FD 5AF9 005E F9F6 5AF9"
	$"FC56 D90B 56D8 52B8 56D8 52B8 56B8 56B8"
	$"52B8 56B8 56B8 56D8 56B8 56B8 F452 B801"
	$"56B8 56B8 FD52 B800 52B7 F652 B8FC 52B7"
	$"0852 B852 B852 D852 D852 B756 D856 D852"
	$"B852 B8FE 52B7 024E 974E 974A 97FE 4A76"
	$"014A 7746 76FE 4677 0046 56FB 4256 FD42"
	$"5502 3E55 3E55 4256 FC42 55FD 4256 0542"
	$"3542 353E 3542 563E 3542 55EE 3E35 003A"
	$"34FE 3A35 FA3A 1404 3614 3614 3A14 3614"
	$"3A14 F936 1405 3A14 3614 35F3 3A14 3A14"
	$"3614 F23A 14FE 3614 0135 F335 F3FC 3614"
	$"FE35 F30A 3614 3614 35F3 3614 3614 31F3"
	$"31F3 35F3 35F3 31F3 31F3 FE2D F303 31F3"
	$"2DD3 2DD2 2DD2 F82D D3FE 2DD2 1829 B22D"
	$"D32D D229 B22D D229 B22D B229 B22D D229"
	$"B22D D321 7021 7025 703D F320 CA28 C949"
	$"F135 8E25 4C1D 6D2D D329 B229 B225 B1FE"
	$"29B2 002D D301 4A03 6B3D 6B3C 673A 673A"
	$"FE67 3B00 673A FD67 3B02 673A 673B 673A"
	$"F567 3B01 673A 673A FE67 1AF5 631A FD5F"
	$"1A01 5EFA 5EFA FD5F 1AFB 5EFA FE5E F9F2"
	$"5AF9 005A D9FC 56D9 0156 D852 B8FE 56D9"
	$"0256 D856 B856 B8FE 56D8 0356 B852 B852"
	$"D852 D8FD 52B8 0052 D8F6 56B8 0252 B756"
	$"D856 D8FA 56B8 FE56 B7FE 52B7 0052 B8FC"
	$"52B7 0252 D752 B752 B7FD 4E97 014A 774A"
	$"76FB 4676 0246 5646 5746 56FB 4256 FB42"
	$"5502 3E55 4256 4256 FC46 56FE 4256 0442"
	$"5542 353E 353E 3542 35FA 3E35 023A 153E"
	$"353A 15FD 3E35 043A 153A 153A 353E 353A"
	$"15FB 3A14 0136 1436 14FA 3A14 0036 14FE"
	$"3A14 0136 1436 14F0 3A14 003A 15FE 3E35"
	$"FC3A 14F8 3614 0A35 F336 1436 1435 F336"
	$"1435 F336 1436 1435 F335 F435 F4FE 35F3"
	$"FD31 F302 31D3 2DD3 2DD2 F82D D307 2DD2"
	$"2DD3 2DD3 29B2 2DD2 29B2 2DD2 2DD2 FD2D"
	$"B20D 29B2 2DD3 2591 190D 2D91 3DF4 1088"
	$"292C 3DD2 318F 256E 2990 2DD2 29B1 FB29"
	$"B201 7203 6B3D 673B 673A 673A FE67 3B00"
	$"673A F867 3BFE 673A 0367 3B67 3A67 3B67"
	$"3AFA 673B F863 1A00 5F1A FE63 1A06 5F1A"
	$"5F1A 631A 5EFA 5EF9 5EF9 5EFA FD5F 1A00"
	$"5EFA FD5E F9F3 5AF9 FE5A D9FE 56D9 005A"
	$"D9FD 56D9 0B56 D856 D856 D956 D956 D856"
	$"D856 D956 D956 D856 D956 D856 D9F9 56D8"
	$"0456 B856 B856 D852 B852 B8FA 56B8 0852"
	$"B752 B856 B856 B852 B856 B852 B852 B756"
	$"B8FA 52B7 0252 B852 B74E B7FC 4E97 044A"
	$"774A 764A 764A 774A 76F9 4676 0046 56FC"
	$"4256 0746 5642 5642 5646 5646 5642 5642"
	$"5542 55FE 4656 0346 7646 7646 5646 76FD"
	$"4256 F43E 3504 3E15 3E35 3E35 3A35 3A15"
	$"FE3A 1405 3A15 3A15 3A14 3A14 3A15 3614"
	$"FE3A 1406 3A15 3A14 3A14 3A15 3A14 3A15"
	$"3A15 F83A 14FE 3614 F53A 1401 3E35 3E34"
	$"FA3A 1405 3614 35F4 3614 3614 35F4 35F4"
	$"FE36 1404 35F3 3614 3614 35F3 35F3 FE36"
	$"14FE 35F3 0731 F335 F331 F331 F331 D331"
	$"F331 D331 D3F9 2DD3 FC2D D200 2DD3 FD29"
	$"B200 2DD2 FD2D B20C 29B2 2DD3 2DB2 1D4F"
	$"2990 31D2 18EB 18EB 31B1 298F 1D4E 29B1"
	$"2DB2 FA29 B201 5403 6B3D 673B 673A 673A"
	$"FE67 3BF8 673A 0067 3BFA 673A 0163 3A63"
	$"3AFA 631A 065F 1A5E FA5E FA5F 1A5F 1A63"
	$"1A63 1AFD 5F1A 035E F95E F95F 1A5E F9FE"
	$"5EFA 005F 1AFE 5EFA FE5E F9F3 5AF9 065A"
	$"D956 D956 D956 D856 D85A F956 D9FD 56D8"
	$"0056 D9FB 56D8 0056 D9F8 56D8 0156 B856"
	$"B8F9 56D8 0856 B856 B852 B752 B856 B856"
	$"B852 B852 B752 B7FD 52B8 0252 B752 B752"
	$"B8FE 52B7 0452 B84E 974E B74A 974E 97FC"
	$"4A97 0A4A 7646 764A 7646 7646 764A 7746"
	$"7646 7646 5642 5646 56F8 4256 FC46 5600"
	$"4676 FB46 5607 4676 4256 4255 4256 4255"
	$"3E56 3E56 3E36 FA3E 35F9 3A35 013E 353A"
	$"35FC 3A14 003A 35EB 3A14 F936 14F1 3A14"
	$"FD36 140D 35F4 35F4 35F3 3614 35F3 35F4"
	$"35F3 3614 35F4 35F4 35F3 35F4 35F3 35F3"
	$"F931 F305 2DD3 2DD3 31D3 31F3 2DD3 2DD2"
	$"FC2D D305 2DD2 2DD2 29D2 29B2 2DD2 2DD3"
	$"FE2D D211 29B2 2DD2 2DD3 2DB2 29B2 29B2"
	$"2DB2 2DD2 2DB2 2170 214F 31B2 190C 0CA8"
	$"35F3 2990 2590 29B1 F929 B201 9903 6B3D"
	$"673B 673A 673A FE67 3BFE 673A 0B63 3A63"
	$"3A67 3A63 3A63 3A67 3A67 3B67 3A63 3A67"
	$"3A63 3A63 3AF8 631A 045F 195F 1A5E F95E"
	$"F95E FAFC 5F1A 065E F95F 1A5E F95A F95A"
	$"F95F 1A5E F9FE 5F1A 005E FAFA 5EF9 015A"
	$"F95A F9FE 5EF9 F95A F9FC 5AD9 025A F95A"
	$"D95A D9FD 56D9 FD5A D908 56D8 56D8 56D9"
	$"56D8 56D8 56D9 56D8 56D8 56B8 F056 D802"
	$"56B8 52B8 56B8 FB52 B800 52B7 FE4E B701"
	$"4E97 4E97 FE4A 97FB 4676 FE42 5601 4676"
	$"4276 F242 5604 4676 4656 4656 4676 4676"
	$"FE46 5601 4676 4676 FD42 5603 3E55 3E35"
	$"3E55 3E55 FE3E 3505 3A35 3E35 3E35 3A35"
	$"3A35 3E35 FB3A 3508 3A14 3A15 3A15 3A35"
	$"3A35 3A15 3A14 3A14 3A15 FD3A 1403 3A15"
	$"3A14 3A14 3A35 FB3A 1408 3614 3614 3A14"
	$"3614 3A14 3614 3614 3A14 3A14 FC36 1403"
	$"3A14 3614 3614 35F3 FA36 1400 35F4 FE36"
	$"1400 35F3 FD36 1407 35F4 3614 3614 35F3"
	$"3614 3614 31F3 35F4 FE35 F304 35F4 3614"
	$"3614 35F4 35F3 FC31 F30A 31D3 31D3 31F3"
	$"31D3 31D3 2DD3 2DD3 2DD2 2DD3 2DD3 2DD2"
	$"FE2D D304 2DD2 2DD3 2DD2 2DD2 29D2 FE2D"
	$"D201 29B2 2DD3 FE2D D2FE 2DB2 0129 B22D"
	$"B2FE 29B2 0629 9131 B21D 2D14 EA35 F229"
	$"B12D D2F8 29B2 0162 036B 3D67 3B67 3A67"
	$"3AFE 673B 0267 3A63 3A63 3BF3 631A 005F"
	$"1AFE 631A FE5F 1A03 5EF9 5F1A 5EF9 5EF9"
	$"FD5F 1AFE 5EF9 FC5E FA00 5EF9 FE5F 1A00"
	$"5EFA FB5E F9ED 5AF9 015A D95A D9FE 56D8"
	$"025A D95A D95A F9FE 5AD9 FA56 D800 56B8"
	$"F956 D806 56B8 56D8 56D8 56B8 56D8 56D8"
	$"56B8 FA52 B804 52B7 4EB7 4EB7 4EB8 4E98"
	$"FE4A 9702 4A77 4677 4677 FE46 7600 4276"
	$"FE42 5600 4656 FE42 5600 4656 F942 5600"
	$"4656 FA42 5602 4676 4676 4656 FB42 5603"
	$"4255 4256 3E56 3E55 F03E 3503 3A15 3E35"
	$"3E35 3A14 FD3A 3503 3A15 3E35 3E35 3A15"
	$"FD3A 1401 3E35 3A34 FE3A 14FD 3614 043A"
	$"3436 1436 143A 143A 14F2 3614 0235 F435"
	$"F436 14FE 35F4 0735 F335 F331 F331 F335"
	$"F331 F335 F336 14FB 35F3 0435 F435 F435"
	$"F331 F335 F3FE 31F3 0035 F3FD 31F3 FB31"
	$"D304 2DD3 31D3 2DD3 31D3 2DD2 FB2D D304"
	$"2DD2 2DD3 2DD2 2DD2 2DB2 FD2D D312 2DD2"
	$"2DD2 2DD3 2DD3 2DD2 29B2 2DD2 2DD2 2DD3"
	$"29B2 29B2 2DD2 2DB2 2DB1 1D2D 190C 2DB0"
	$"2DD2 2DD2 F929 B200 2DD3 0147 016B 3D67"
	$"3BFE 673A 0367 3B67 3A67 3A67 1AEF 631A"
	$"FC5F 1AF1 631A 015F 1A5F 1AFB 5EF9 F85A"
	$"F900 5AD8 FE5A F900 5AD8 F95A F901 5AD9"
	$"5AD8 FA5A D901 56D8 5AD9 FA56 D804 5AD9"
	$"5AD8 56D8 56D8 56B8 FC56 D8FE 52B8 0352"
	$"B752 B84E B852 B8FE 4E98 FE4E 97FD 4A97"
	$"0146 7746 77FB 4676 0346 5646 7746 5646"
	$"76FE 4656 0846 7646 5646 7646 5646 5646"
	$"7646 5746 5646 56F0 4256 FD42 5500 3E36"
	$"F53E 3501 3A35 3A35 FB3E 35FE 3A35 FD3E"
	$"350C 3A35 3E35 3E35 3A35 3E35 3A14 3A14"
	$"3A15 3E35 3E35 3A14 3A14 3A35 FC3A 1402"
	$"3614 3A14 3A14 FA36 14FE 3A14 FB36 14FE"
	$"35F4 0836 1436 1435 F435 F335 F435 F431"
	$"F331 F435 F4FE 31F3 0036 14FD 31F3 0031"
	$"F4F8 31F3 0131 D331 F3FC 31D3 0231 F331"
	$"D331 D3FA 2DD3 0031 D3FA 2DD3 022D D22D"
	$"D32D D3FD 2DD2 0F2D D32D D329 B229 D229"
	$"B22D D329 B229 B22D D22D B22D D21D 2E14"
	$"EB2D B231 D22D B2FC 29B2 032D B229 B229"
	$"B22D B201 4501 673C 673B FE67 3A03 671B"
	$"671A 631A 671A FC63 1A01 671A 673B FC63"
	$"1A00 673A E963 1A02 5F1A 5F1A 5EFA FA5E"
	$"F9FD 5AF9 055E F95E F95A F95A F95E F95A"
	$"F9F8 5EF9 FB5A F9FE 5AD9 025A F95A F95A"
	$"D9FD 56D8 005A D9FE 56D8 005A D8FE 56D8"
	$"0056 B8F9 52B8 004E B8FE 4EB7 FD4A 9707"
	$"4676 4677 4676 4676 4A77 4677 4A77 4677"
	$"FD46 7604 4656 4656 4677 4676 4677 FE46"
	$"7601 4656 4A76 F946 7600 4656 F842 5602"
	$"4255 4256 4256 FC42 5501 4235 4255 F23E"
	$"3500 3A35 F63E 35FD 3A35 0B3E 353E 353A"
	$"353A 153A 143A 353A 143A 143A 353A 143A"
	$"143A 35FE 3A14 0136 143A 14F8 3614 033A"
	$"1436 1436 143A 14FA 3614 0335 F435 F436"
	$"1436 14FC 35F4 0131 F431 F4F2 31F3 FC31"
	$"D300 31F3 FB31 D3F9 2DD3 0031 D3FB 2DD3"
	$"FE2D D214 2DD3 2DD2 2DD2 2DD3 2DD2 2DD2"
	$"29B2 29D2 2DD2 29B2 29D2 2DD2 29D2 29B2"
	$"29B2 31D3 256F 0CA9 31D3 31D2 2DB1 FC29"
	$"B203 2DB2 29B2 29B2 2DB2 0167 0867 3C67"
	$"3B67 3A67 3A67 1A67 1B63 1A63 1A67 1AFC"
	$"631A 0B67 1A67 3B67 1A63 1A63 1A67 1A67"
	$"1A67 3A67 1A67 1A63 1A63 3AED 631A 055F"
	$"195F 195F 1A5E F95F 195F 19F5 5EF9 F95F"
	$"19FE 5EF9 FE5A F9FD 5AF8 045A D85A D85A"
	$"F85A F85A D8FE 56D8 015A D85A F9FD 56D8"
	$"0056 B8F8 52B8 FE4E B800 4EB7 FB4A 9703"
	$"4677 4A77 4676 4676 FE46 7706 4676 4676"
	$"4A76 4A77 4A77 4676 4676 FD46 770A 4676"
	$"4677 4A76 4A77 4A76 4A76 4A77 4A77 4A76"
	$"4676 4A76 FC46 7601 4276 4255 FE42 5600"
	$"4255 FD42 5602 4255 4255 4256 FE42 5504"
	$"4235 4255 4256 4256 3E55 EE3E 350C 3A35"
	$"3A35 3E35 3A35 3E35 3E35 3A35 3A35 3A15"
	$"3A35 3A14 3A14 3A34 FA3A 1400 3614 FE3A"
	$"14F4 3614 0035 F3FD 3614 0135 F436 14F9"
	$"35F4 0236 1435 F435 F4FD 31F3 0031 F4F3"
	$"31F3 0231 D331 F331 F3FC 31D3 FE2D D300"
	$"31D3 FD2D D303 31D3 2DD3 2DD3 31D3 FD2D"
	$"D300 2DD2 FA2D D3FE 2DD2 0B2D B22D D22D"
	$"B229 B229 B22D B231 D329 900C A935 F331"
	$"D229 B1FE 29B2 052D B229 B229 B22D B229"
	$"B22D B201 8401 673C 673B FC63 1A01 6319"
	$"671A FE63 1A0A 671A 671A 631A 671A 671A"
	$"631A 671A 673A 671A 631A 673A EB63 1AFE"
	$"6319 0363 1A63 1A63 1963 1AFD 6319 0763"
	$"1A63 1A63 1963 1963 1A5F 1963 195E F9F9"
	$"5F19 FE5E F905 5AF9 5EF9 5AF8 5AD8 5AF8"
	$"5AD8 FC5A F809 5AD8 56D8 5AD8 56D8 5AD8"
	$"5AD8 56D8 56D8 56B8 56B8 FC52 B8FD 4EB8"
	$"024E 984E 974E 97F8 4A97 074A 774A 974A"
	$"774A 974A 974A 774A 774A 76FB 4A77 0346"
	$"774A 774A 7746 76FE 4A77 064A 974A 764A"
	$"774A 774A 7646 764A 77FD 4677 0546 7646"
	$"7642 7646 5642 5646 76FC 4256 0742 5542"
	$"5642 5642 5542 5642 5542 5642 55FE 4256"
	$"0142 5542 55FE 4256 033E 563E 353E 553E"
	$"35FE 4235 FB3E 35FB 3A35 FE3A 1503 3A14"
	$"3A15 3A14 3614 FE3A 1405 3614 3614 3A14"
	$"3A14 3614 3614 FE3A 14F2 3614 0035 F3FD"
	$"3614 FE35 F400 35F3 FE35 F404 35F3 31F3"
	$"31F3 35F4 31F4 FD31 F300 31F4 F431 F302"
	$"31D3 31D3 31F3 FE31 D301 31F3 31D3 F92D"
	$"D300 31D3 F72D D309 2DD2 2DD3 2DD2 2DD2"
	$"2DD3 2DD2 2DD2 2DB2 2DD2 2DD2 FD2D B206"
	$"31D2 2990 0CA9 35F3 2DD2 29B1 29B2 FE2D"
	$"B201 29B2 29B2 FE2D B201 3A01 673C 631B"
	$"FE63 1A00 631B E963 1A00 671A EF63 1A05"
	$"6319 6319 631A 631A 6319 6319 FA63 1A07"
	$"6319 6319 5F19 5EF9 5F19 5F19 5EF9 5AF9"
	$"FB5E F902 5AF9 5AF9 5AF8 FB5A F9FE 5AD8"
	$"0056 D9FD 56D8 0052 B7FB 52B8 FC4E B802"
	$"4E97 4A97 4E97 FD4A 97FD 4E97 F74A 9701"
	$"4E98 4A77 F64A 9705 4677 4676 4A97 4A96"
	$"4696 4677 F946 7602 4656 4676 4676 FE46"
	$"56FD 4256 0042 55FE 4256 0042 55FD 4256"
	$"0042 55FD 4256 FC42 5502 4235 3E35 3E36"
	$"FC3E 350D 3A35 3A35 3E35 3E35 3A15 3A35"
	$"3A35 3A14 3A15 3A35 3A15 3A14 3A14 3A15"
	$"FD3A 1402 3614 3A14 3A14 F336 1401 35F4"
	$"3614 FE35 F400 3614 F735 F40A 35F3 35F4"
	$"31F3 35F4 35F4 35F3 35F3 31F4 31F3 31F3"
	$"31F4 FD31 F300 35F3 F231 F307 31D3 2DD3"
	$"2DD3 2DF3 2DF3 2DD2 2DD3 31D3 F92D D301"
	$"31D3 2DD3 FB2D D200 2DD3 FB2D D206 2DB2"
	$"2DB2 31D2 29B1 0CA9 35F3 2DD2 FD2D B200"
	$"2DD2 FC2D B201 6D01 633C 633B FE63 1A00"
	$"631B FB63 1AFD 5F1A 025E FA5E FA5F 1AFD"
	$"631A 0063 19E7 631A FC63 19FC 631A FE63"
	$"1900 5F19 FC5E F902 5AF9 5EF9 5AF9 F95E"
	$"F904 5AF9 5AF8 5AF9 5AF9 5AF8 FE5A D806"
	$"5AD9 5AD8 56D8 56D8 56B8 52B7 56B8 FE52"
	$"B808 52B7 52B7 4E97 4E97 4EB7 4EB7 4EB8"
	$"4E97 4A97 FC4E 97FD 4A97 004A 77F9 4A97"
	$"004A 77FC 4A97 0046 97FD 4A97 0346 774A"
	$"9746 7746 77F8 4676 0046 56FE 4676 0442"
	$"5646 7646 7642 5646 56FB 4256 0042 55FA"
	$"4256 0342 5542 5642 553E 55FE 4255 023E"
	$"353E 553E 55FA 3E35 003A 35FD 3E35 083A"
	$"353A 143A 353A 143A 153A 353A 1436 1436"
	$"14FD 3A14 0336 1436 143A 143A 14FB 3614"
	$"093A 1436 1436 1435 F435 F436 1436 1435"
	$"F436 1436 14FE 35F4 0436 1435 F435 F336"
	$"1436 14FB 35F3 0635 F435 F335 F435 F335"
	$"F335 F435 F4F9 31F3 0035 F3F7 31F3 0231"
	$"D331 D331 F3FE 31D3 FC2D D300 31D3 FD2D"
	$"D306 31D3 2DD3 2DD2 2DD2 2DD3 31D3 31D3"
	$"FA2D D20C 2DD3 29B2 2DD2 2DD2 2DD3 29B2"
	$"2DD2 2DB2 31D2 29B1 08A9 2DD2 31F3 FE29"
	$"B2FA 2DB2 0147 0363 1C63 1B63 1A63 19FE"
	$"631A 035F 195F 1A63 1A63 1AFA 5F1A FE63"
	$"1AFE 6319 EE63 1A00 6319 FC63 1AF6 6319"
	$"015F 195F 19FA 5EF9 005F 19F5 5EF9 055A"
	$"F85E F95A F85A F85E F95A D8FE 5AD9 015A"
	$"D85A D8FE 56D8 0056 B8FE 52B8 FD52 B703"
	$"4EB8 4E97 4E97 4EB7 FC4E 97FE 4A97 124A"
	$"774A 774A 974A 774A 974A 974A 774A 7746"
	$"7746 7646 774A 9746 7746 7746 9746 7646"
	$"7646 7746 77F0 4676 FA42 560A 4255 4256"
	$"4256 4255 4256 4255 4256 4255 4255 4256"
	$"3E56 FC3E 5502 3E35 3E35 3E55 F73E 3500"
	$"3A14 FB3A 35FE 3A14 0536 1436 143A 1436"
	$"1436 143A 14EF 3614 FD35 F401 35F3 3614"
	$"FC35 F4F9 35F3 0835 F435 F335 F431 F331"
	$"F335 F335 F331 F335 F4FB 31F3 0035 F3F7"
	$"31F3 0631 D331 D331 F331 D331 D32D D32D"
	$"D3FD 31D3 FA2D D3FE 2DD2 0131 D231 D2FC"
	$"2DD2 002D D3FD 2DD2 0B2D B22D D229 B22D"
	$"D22D B231 D229 B108 A92D D231 F329 B129"
	$"B2FE 2DB2 002D D2FE 2DB2 002D D201 6A01"
	$"673C 631B FC63 1A00 5F19 FA63 1A00 5F1A"
	$"F363 1A03 62F9 631A 5F19 5F19 FE5F 1A06"
	$"5F19 5F1A 5F1A 631A 631A 6319 6319 FD63"
	$"1AF9 6319 FD5F 1901 5EF9 5F19 FE5E F900"
	$"5F19 FD5E F900 5AF9 F65E F900 5AF8 FE5E"
	$"F903 5AF8 5AD8 5AD9 5AD9 FD5A F903 5AD8"
	$"5AF9 5AD9 5AD9 FE56 D8FE 52B7 FE52 B802"
	$"52B7 52B8 52B7 FD4E 9701 4A97 4A97 FE4A"
	$"7701 4677 4A77 FE46 77FD 4676 0246 7746"
	$"7646 77FE 4676 0046 77FD 4676 0B42 5646"
	$"5646 7746 7742 5646 7642 7646 7646 7642"
	$"5642 7642 76FC 4256 FD42 5507 4256 4256"
	$"4255 4256 4255 4255 4256 4255 F43E 35FE"
	$"3A35 003A 15FE 3E35 033A 353A 143A 353A"
	$"35FD 3A15 073A 143A 3536 1436 143A 1436"
	$"1436 143A 14ED 3614 FA35 F400 3614 F835"
	$"F404 35F3 35F4 35F4 35F3 35F3 F731 F300"
	$"35F3 F631 F300 31D3 FE31 F301 2DD3 2DD3"
	$"FE31 D303 31F3 2DD3 2DD3 31D3 FD2D D3FD"
	$"2DD2 0131 D231 D2FD 2DD2 0E2D D32D D22D"
	$"D22D D32D D32D D22D B22D B22D D32D B231"
	$"D22D B108 882D D231 F3FE 2DB2 0229 B22D"
	$"B22D D2FE 2DB2 0031 D301 6A01 673C 631B"
	$"E563 1A08 62F9 631A 5F1A 5EF9 5EF9 5F1A"
	$"5F1A 5EF9 5F1A FC5F 1903 631A 631A 5F1A"
	$"631A FD63 1906 5F19 5EF9 5EF9 5F19 5EF9"
	$"5EF9 5F19 ED5E F9FB 5EF8 025E F95E F85E"
	$"F8FD 5AF9 045A F85A F85A F95A F95A F8FD"
	$"5AD8 0456 D756 D856 B756 B856 B8FD 52B7"
	$"0352 974E 974E 984E 98FE 4E97 034A 974A"
	$"974A 774E 97FC 4A77 0046 76FC 4677 0246"
	$"7646 7646 77FD 4676 0A46 5646 7646 5646"
	$"7646 5646 7646 5642 5646 7646 7642 56FE"
	$"4656 0242 5646 7642 56FD 4255 FC42 5603"
	$"4236 4256 4256 3E56 FC3E 3502 3A35 3E35"
	$"3E35 FE3A 3503 3E35 3A35 3A35 3E35 FE3A"
	$"3507 3E35 3A35 3A14 3A35 3A35 3A15 3A15"
	$"3A14 FD3A 15F8 3A14 0236 1436 143A 14EB"
	$"3614 FD35 F405 31F3 35F4 3614 35F3 35F4"
	$"35F4 FA35 F301 31F3 31F3 FE35 F302 31F3"
	$"31F4 31F4 F731 F30B 31D3 31F3 31F3 31D3"
	$"31F3 31D3 31D3 31D2 31D3 31F3 2DD2 31D2"
	$"F931 D3FD 2DD2 0131 D231 D2FA 2DD2 122D"
	$"B12D D22D D22D B231 D231 D208 882D D231"
	$"F32D D22D D22D B22D B12D B22D D22D B22D"
	$"B229 B131 D301 5007 673B 631B 631A 631A"
	$"5F19 5F19 631A 631A FD5F 1A03 5F19 5F19"
	$"5F1A 5F1A F263 1A03 6319 5F19 5EF9 5F19"
	$"FC5E F9FA 5F19 0463 1963 195F 195F 1963"
	$"19FD 5F19 ED5E F900 5EF8 FE5E F904 5EF8"
	$"5EF8 5EF9 5EF9 5EF8 FE5E F901 5AF9 5AF8"
	$"FD5A D801 5AF8 5AF8 FD5A D805 56D8 56D8"
	$"5AD8 56B7 56B8 56D8 FE56 B8FE 52B7 0052"
	$"97FC 4E97 024A 974A 974E 97FE 4A97 014A"
	$"7746 77FE 4676 0046 77F3 4676 0446 5646"
	$"7646 7642 5646 56FB 4256 0146 7642 56FE"
	$"4255 0042 56FD 3E36 013E 353E 36FD 3E35"
	$"003A 35FB 3E35 053A 353A 353E 353A 353A"
	$"353E 35FD 3A35 053A 153A 153A 353A 353A"
	$"153A 15FD 3A14 003A 15F8 3A14 EF36 1406"
	$"35F3 3614 3614 35F3 35F3 3614 3614 FE35"
	$"F4FE 35F3 0036 14F9 35F3 0331 F335 F331"
	$"F335 F3F1 31F3 FC31 D3FE 31D2 0031 F3FE"
	$"31D2 FD31 D303 2DD2 2DD2 31D3 31D3 FD2D"
	$"D2FE 31D2 FC2D D209 2DB2 2DB1 2DD2 2DD2"
	$"2DB2 31D2 31D2 0487 2DB1 31F3 FE2D D2FC"
	$"2DB2 0129 B12D D201 7D07 631B 631B 631A"
	$"631A 6319 6319 631A 631A FE5F 1A00 5F19"
	$"FE5F 1AF8 631A FE63 190A 631A 631A 6319"
	$"6319 631A 631A 6319 631A 5F19 5F19 6319"
	$"FB5F 1900 631A FD63 1902 5F19 5F19 6319"
	$"FE5F 1901 5EF9 5F19 F85E F902 5AF9 5AF9"
	$"5EF9 FE5A F9FA 5EF9 FE5E F803 5EF9 5EF9"
	$"5EF8 5EF8 FE5E F901 5AF9 5AF8 FE5A D800"
	$"5AF8 F95A D800 56B7 FE56 D803 56D7 56B8"
	$"56B8 52B8 FE52 B7FE 4EB7 064E 974E 974A"
	$"964A 974A 974A 964A 96FD 4676 0046 77F6"
	$"4676 FE42 5601 4255 4656 F842 5601 4255"
	$"4256 FD42 5502 3E56 3E35 3E36 F93E 35FE"
	$"3A35 063E 353E 353A 353E 353A 353A 353E"
	$"35F8 3A35 013A 153E 35FE 3A35 023A 143A"
	$"353A 35F6 3A14 0636 143A 143A 1436 1436"
	$"143A 143A 14F7 3614 0335 F336 1435 F335"
	$"F3FE 3614 0435 F435 F435 F335 F336 14FA"
	$"35F3 0135 F435 F4FC 35F3 0231 F331 F335"
	$"F3F6 31F3 0A31 D331 D331 F331 D331 D331"
	$"F331 D231 D231 D331 D231 D3FE 31D2 022D"
	$"D231 D331 D3FB 31D2 FD2D D202 31D2 31D3"
	$"31D2 FC2D D20C 2DB2 2DD2 2DD2 31D2 31D2"
	$"31F3 0467 2DB1 35F3 2DD1 2DD1 2DD2 2DD2"
	$"FC2D B200 2DD2 016E 0163 1B63 1BEB 631A"
	$"FE63 19F4 631A FE63 1900 631A F963 1906"
	$"5F19 6319 5F19 5EF9 5F1A 5EF9 5F19 FC5E"
	$"F9FA 5AF9 095A F85E F95E F85E F95E F95E"
	$"F85A F85A F85E F95E F9FE 5EF8 005E F9FE"
	$"5EF8 FA5A D805 56D8 5AD8 5AD8 56D8 5AD8"
	$"5AD8 FA56 D804 56B7 56B8 56B8 52B7 52B8"
	$"FE52 B703 4EB7 4EB7 4E97 4E96 FE4E 9701"
	$"4A76 4A96 FE4A 76FD 4A77 004A 76FA 4676"
	$"0442 5642 7642 7642 5646 56FC 4256 0042"
	$"55FC 4256 033E 5542 5642 563E 55FB 3E35"
	$"003E 56FB 3E35 003A 35FC 3E35 FD3A 35FE"
	$"3E35 053A 353A 153A 353A 353A 143E 35FE"
	$"3A35 023A 143A 143A 34F7 3A14 0236 143A"
	$"143A 14FD 3614 023A 1436 143A 14FA 3614"
	$"0035 F4FA 3614 0836 1336 1335 F335 F336"
	$"1336 1435 F335 F435 F4FE 35F3 0735 F435"
	$"F435 F335 F331 F335 F435 F331 F3FE 35F3"
	$"0431 F331 F231 F335 F335 F3F8 31F3 0131"
	$"D331 D3FD 31F3 0131 D231 D3FE 31D2 0131"
	$"D331 F3FB 31D2 FD2D D202 31D2 31D3 31D3"
	$"FC2D D20C 2DB2 2DD2 2DD2 31D2 31D2 35F3"
	$"0466 2DB0 3613 2DD1 2DD1 2DB2 2DD2 FD2D"
	$"B201 2DD2 2DD2 015A 0163 1C63 1BFD 631A"
	$"015F 1A5F 19F8 631A 0663 1963 1963 1A63"
	$"1963 1963 1A63 1AFD 6319 FE63 1A00 6319"
	$"F863 1A02 6319 6319 631A F963 19F7 5EF9"
	$"045E F85A F85E F85A F85A D8FD 5AF8 FD5A"
	$"D800 5AF9 FE5A D805 5AF9 5AF9 5AF8 5AF8"
	$"5AD8 5AF8 F55A D8FD 56D8 0056 B7FB 56D8"
	$"FD56 B800 52B8 FD52 B7FE 4EB7 FC4E 9700"
	$"4E96 FC4E 9702 4A77 4A97 4A77 F74A 7606"
	$"4676 4656 4676 4676 4256 4256 4255 F942"
	$"5604 4236 3E36 4236 3E36 3E36 EB3E 3501"
	$"3A35 3A14 FA3A 3505 3A34 3A34 3A14 3A14"
	$"3A35 3A35 FE3A 3403 3A14 3A14 3A34 3A34"
	$"FE3A 1402 3614 3A14 3A14 FE36 1401 3A14"
	$"3A14 FC36 1401 35F4 35F4 FE36 1400 35F4"
	$"FC36 1401 35F4 35F3 FE35 F400 3613 FD35"
	$"F300 3613 FD35 F301 35F4 35F3 FD31 F300"
	$"35F3 F331 F30A 31D3 31F3 31F3 31D3 31D3"
	$"31F3 31D3 31F3 31D3 31F3 31F3 FC31 D202"
	$"2DD2 31D3 31D3 FD2D D201 31D2 31D3 F92D"
	$"D20F 2DB2 31B2 35F3 0867 2990 3A13 31D2"
	$"2DB2 2DB2 2DD2 2DD2 2DB2 29B1 2DB1 2DD2"
	$"2DD2 0155 0D62 FB63 1B5F 1963 1A63 1A5F"
	$"1A5F 1A5F 1962 F962 F963 1963 1963 1A63"
	$"19FE 631A 0463 1963 1963 1A63 1963 19FD"
	$"631A 0863 1963 1962 F962 F963 1962 F95E"
	$"F963 1963 19FC 631A 025F 1963 1963 19FD"
	$"5F19 0263 195F 195F 19FA 5EF9 005F 19FB"
	$"5EF9 015A F95E F9FE 5AF9 FE5A F8E4 56D8"
	$"0352 B756 D856 D852 B7FE 52B8 FC52 B700"
	$"5297 FC52 B700 4EB7 FC52 B702 4E97 4E97"
	$"4EB7 FE4E 9604 4A96 4E96 4A96 4A96 4E97"
	$"FE4A 9700 4A96 F746 7604 4276 4276 4256"
	$"3E56 4256 FE3E 5604 3E55 3E55 3E35 3E56"
	$"3E56 ED3E 3502 3E34 3E35 3E35 F73A 35FE"
	$"3A34 003A 35F3 3A14 EE36 14FB 35F4 FD35"
	$"F3FE 3613 0535 F335 F335 F435 F435 F335"
	$"F3FD 31F3 0035 F3FE 31F3 0335 F331 F331"
	$"F335 F3FE 31F3 0035 F3FB 31F3 0931 D331"
	$"F331 F331 D331 F331 D331 F331 F331 D331"
	$"D3FD 31D2 0231 D331 D32D D3FE 2DD2 0331"
	$"D231 D22D D231 D2FA 2DD2 0E31 D235 F304"
	$"6629 AF3A 142D D231 D22D D22D D22D B12D"
	$"B129 B12D B12D B129 9001 5C07 631B 631B"
	$"5F19 6319 631A 631A 5F19 5EF9 FA63 1902"
	$"631A 6319 6319 F863 1A0D 6319 62F9 62F9"
	$"6319 62F9 5EF9 62F9 5EF9 5EF9 6319 6319"
	$"62F9 62F9 5EF9 FE5F 1900 5EF9 FA5F 19FC"
	$"5EF9 045F 195E F95A F95E F95E F9FB 5AF9"
	$"035A F856 F856 D856 F8FD 56D8 0352 B852"
	$"D856 D852 B8FE 56D8 0052 B8FB 56D8 FD56"
	$"B709 52B7 52B7 56D8 56D8 52B7 52B7 52B8"
	$"52B7 52B8 52B8 FD52 B7FD 4EB7 FB4E 9707"
	$"52B7 4E97 4EB7 4EB7 52B7 52B7 4E97 4E97"
	$"FC4E 9602 4A96 4E96 4E96 FD4A 76FC 4676"
	$"0046 75FE 4676 0042 76FC 4256 023E 5642"
	$"5642 56F9 3E55 FC3E 3500 3E56 F33E 35F4"
	$"3A35 023A 143A 143A 35F5 3A14 0136 143A"
	$"14F5 3614 0035 F3FE 3614 0636 1336 1335"
	$"F435 F435 F336 1436 14FE 35F4 0136 1436"
	$"14F9 35F3 0131 F335 F3FD 31F3 FE35 F3FC"
	$"31F3 0135 F335 F3F7 31F3 0331 D231 F331"
	$"D331 F3F7 31D2 FD2D D2FD 31D2 0E2D B131"
	$"D231 D231 B12D B12D B12D 902D B02D AF04"
	$"6421 4B31 CF29 8E29 8E29 6EFE 256D 0325"
	$"4D25 6C21 4B1D 0A01 B803 631C 631B 5F19"
	$"6319 FE5F 1A00 5F19 FD63 1900 631A FC63"
	$"19F6 631A 1163 1963 1A63 195E F962 F963"
	$"195E F963 1962 F962 F95E F95F 195E F95E"
	$"F95F 195E F95E F95F 19F8 5EF9 FE5A F9FC"
	$"5AF8 005A F9FC 56D8 0D52 D856 D852 D856"
	$"D856 D852 D852 B852 D852 B852 B752 D852"
	$"D852 B752 D8FB 56D8 0556 B752 B756 B756"
	$"B752 B752 B7FD 56B8 FD52 B700 52B8 FA52"
	$"B70B 4E97 4EB7 4E97 52B7 4E97 4E97 5297"
	$"5297 4E97 4E97 4EB7 52B7 FD4E 9608 4E97"
	$"4E96 4E96 4A96 4A96 4E96 4A76 4A76 4A77"
	$"FE4A 76FE 4676 0146 5546 56FE 4256 FD42"
	$"5503 4256 4255 4256 4256 FD42 5503 4256"
	$"3E35 3E35 4255 F33E 3503 3A35 3E35 3E35"
	$"3A35 FD3E 3504 3A35 3A35 3E35 3A35 3A14"
	$"FA3A 3507 3A34 3A34 3A35 3A35 3A34 3A14"
	$"3A34 3A34 F83A 1401 3614 3A14 FC36 140E"
	$"3A14 3A14 3613 3614 3613 3614 3613 3A14"
	$"3613 3613 3614 3614 35F3 3614 3614 FE35"
	$"F402 3614 3613 3614 FC35 F304 35F4 35F3"
	$"35F3 35F4 35F3 FE31 F3FE 35F3 0031 F3FE"
	$"35F3 0731 F331 F335 F331 F335 F331 F331"
	$"F335 F3FC 31F3 0331 F231 F331 D231 F2FD"
	$"31D3 0331 F32D D231 D231 D3FE 31D2 FE2D"
	$"D210 31D2 31D2 2D8F 256D 254D 254C 254C"
	$"254B 252B 212B 252B 252A 2109 14C6 14C5"
	$"2129 1D08 FE1C E802 1CE7 1CE7 18E7 FE18"
	$"C601 830A 631B 62FA 5EFA 5EF9 5EF9 5F19"
	$"5F1A 5F1A 631A 6319 62F9 FB63 1AFE 6319"
	$"0063 1AFE 6319 FE63 1AFE 6319 0263 1A63"
	$"195E F9FC 6319 EF5E F900 5AF9 FE5A D9F5"
	$"56D8 0352 B852 B856 B856 D8FD 52B8 0056"
	$"D8FE 56B8 0056 D8FD 52B8 0156 B856 B8FE"
	$"52B8 0352 B752 B752 B852 B8FE 56B8 FE52"
	$"B700 52B8 F552 B718 4E96 4EB7 52B7 52B7"
	$"5297 5297 52B7 52B7 4EB7 4EB7 4E96 4E97"
	$"4E96 4E97 4A76 4E97 4E97 4E96 4A96 4E77"
	$"4A76 4A76 4A97 4676 4A76 FB46 7600 4655"
	$"FD46 5603 4255 4676 4656 4656 F842 5503"
	$"3E35 4255 4255 3E55 F03E 3501 3A35 3E35"
	$"FE3A 3502 3E35 3E15 3A15 FE3A 3501 3634"
	$"3A34 FE3A 35EF 3A14 FE36 140F 3A14 3A14"
	$"3614 3A14 3614 3614 3A14 3613 3613 3614"
	$"3613 3614 35F3 3613 35F3 3613 FC36 1409"
	$"35F3 35F3 3614 3614 35F3 35F3 3613 35F3"
	$"3614 31F3 FA35 F300 31F3 FE35 F302 31F3"
	$"35F3 35F3 F931 F303 31D3 31F3 31F3 35F3"
	$"FD31 F30F 2DD2 31F3 31F3 31D2 31D2 31F2"
	$"31F2 31D2 31D2 35D2 35F3 20EA 18A7 1CE8"
	$"1CE7 18C6 FE14 C50B 18C6 14A5 14A5 1CE7"
	$"1084 14A5 1084 1084 1085 1085 1084 1085"
	$"FE10 8400 1085 0189 0363 1A63 1A5E FA5E"
	$"F9FD 5F19 035E F962 FA63 1A62 F9FD 631A"
	$"0463 1963 1A63 1A63 1963 1AF2 6319 FB5E"
	$"F900 5AF9 FE5E F902 5AF9 5AF9 5EF9 FE5A"
	$"F903 5AD8 5AD8 5AF8 5AF8 FE5A D9F2 56D8"
	$"0856 B856 D852 B752 B852 B752 B852 B856"
	$"B756 B8FD 52B7 0352 B852 B756 B852 B8FE"
	$"52B7 0152 B852 B8F7 52B7 024E 9752 B74E"
	$"97FE 52B7 024E 964E 974E 97FE 4EB7 F84E"
	$"970F 4E96 4A96 4A76 4A96 4A76 4A76 4A96"
	$"4A96 4A76 4A96 4A76 4A76 4A96 4A76 4A96"
	$"4A96 FC4A 7608 4676 4676 4A76 4676 4676"
	$"4655 4676 4676 4655 FD42 5503 4256 4255"
	$"4255 4256 FA42 5503 3E55 3E35 3E34 3E55"
	$"F63E 350F 3A35 3A34 3A34 3A35 3A35 3E35"
	$"3A14 3A35 3E35 3A35 3A14 3A14 3A34 3A14"
	$"3A14 3A34 FA3A 14FB 3614 FD3A 14FA 3614"
	$"0C3A 1436 1336 1436 1435 F336 143A 1436"
	$"1336 1435 F33A 1436 1335 F3FD 3613 0635"
	$"F336 1336 1335 F335 F336 1336 13F8 35F3"
	$"0031 F3FD 35F3 FE31 F300 35F3 F231 F300"
	$"31F2 FE31 F30B 31D2 31D2 31F2 31F2 31D2"
	$"31D2 35D2 39F3 1CC8 0822 14A5 1484 FE10"
	$"840D 14A5 14A5 1084 10A5 18C6 0C64 14A5"
	$"14A5 14A6 14A6 14C6 14A6 1085 10A5 FE14"
	$"A501 8404 631B 631B 631A 631A 6319 FE5F"
	$"190F 5EF9 631A 631A 62FA 62F9 631A 631A"
	$"62F9 6319 631A 631A 6319 631A 631A 6319"
	$"631A F563 19F7 5EF9 FB5A F9FD 5AF8 FE5A"
	$"D8F3 56D8 005A D8F8 56D8 0156 D756 B7FE"
	$"56D7 0756 B756 B756 D852 B852 B752 B752"
	$"B852 B8FA 52B7 FC4E B7FE 4E97 064E 964A"
	$"964E 974E 974A 964E 974E 97FD 4A96 054A"
	$"764A 964A 964A 974A 764A 97FB 4A76 004A"
	$"97FC 4A96 024A 764A 964A 96FD 4A76 0146"
	$"7646 76FE 4A76 FD46 7608 4655 4255 4255"
	$"4675 4256 4256 4255 4255 4256 FC42 5505"
	$"3E55 3E55 4255 3E35 3E35 3E55 FA3E 3500"
	$"3E34 FB3E 3500 3A35 FD3A 3400 3A35 FD3A"
	$"3403 3A14 3A14 3A34 3A34 FE3A 1402 3A34"
	$"3A14 3A14 FB36 14FA 3A14 0036 14FD 3A14"
	$"0136 133A 13FE 3613 0636 1436 1336 1435"
	$"F33A 1436 1435 F3FD 3614 0B36 1336 1436"
	$"1435 F335 F336 1336 1335 F336 1335 F336"
	$"1336 13FA 35F3 0031 F3FE 35F3 0231 F335"
	$"F335 F3F9 31F3 0031 F2FE 31F3 0331 F231"
	$"D231 F331 F3FE 31D2 0031 D3FC 31D2 0339"
	$"F321 0908 2214 85FD 14A5 0514 A614 A610"
	$"A510 8514 A610 85FC 1CE8 0518 E810 8510"
	$"A614 A614 A610 A601 7302 671B 631A 5F1A"
	$"FE63 1905 5F19 5F19 6319 5EF9 5EF9 62F9"
	$"FD5E F907 6319 5EF9 5EF9 62F9 631A 631A"
	$"6319 6319 FE63 1AF6 6319 F75E F9F9 5AF9"
	$"FD5A F8FA 5AD8 0056 D8F7 5AD8 0156 D85A"
	$"D8FD 56D8 0656 D756 D856 D856 D752 B756"
	$"B756 B7FD 52B7 0252 B84E B752 B7FB 4EB7"
	$"024E 974E B74E B7FE 4A96 074A 974A 964A"
	$"974A 974A 764A 7646 764A 97FD 4676 0946"
	$"7746 774A 7746 764A 774A 7746 764A 764A"
	$"764A 77F4 4A76 0346 764A 7646 7646 76FE"
	$"4675 0446 7646 7646 5646 7646 56FD 4256"
	$"FA42 5504 3E55 3E35 3E35 4255 4255 F13E"
	$"35FD 3A35 F53A 3401 3A14 3A34 F03A 1403"
	$"3A13 3613 3613 3A13 FE36 1300 3A13 FC36"
	$"1302 3614 3613 3613 FD36 1404 35F3 3614"
	$"3614 3613 3613 FE35 F3FE 3613 0435 F335"
	$"F336 1335 F336 13FB 35F3 0031 F3FE 35F3"
	$"FD31 F304 31F2 31F3 31F3 31F2 31F2 FD31"
	$"F324 31D2 31F3 31D2 31D2 31D3 31D2 31F3"
	$"31D2 31D2 31F3 31D2 31D2 39F3 252C 14A8"
	$"1CE9 252A 18E7 10A5 14A6 14C6 14C6 14A6"
	$"14C6 10A6 14A6 1D08 1CE8 2109 1D09 1CE9"
	$"1CE8 1085 10A6 14A6 14A7 14A6 0173 0567"
	$"1C63 1A63 1963 1963 1A63 1AEF 6319 0063"
	$"1AF4 6319 025E F963 1963 19FE 5EF9 0062"
	$"F9FC 5EF9 FB5E F8FA 5AF8 075A D85A F85A"
	$"F85A D85A D85A F85A D856 D8FA 5AD8 0156"
	$"D756 D7FC 56D8 0056 B8FC 52B7 0152 B852"
	$"D8FC 52B7 034E B74E 974E B74E B7FD 4E97"
	$"FE4A 97FE 4A96 0F4A 974A 7746 774A 974A"
	$"7746 7746 774A 9746 7646 764A 774A 7746"
	$"7646 764A 764A 76EC 4676 0A42 5546 7642"
	$"5646 7646 5642 5642 5542 5642 5542 5642"
	$"56FE 4255 0042 56F5 4255 003E 55F9 3E35"
	$"003E 34FE 3E35 FE3A 3402 3A35 3A35 3E35"
	$"FD3A 3500 3E35 FE3E 3404 3E14 3A14 3A14"
	$"3E34 3A14 FE3A 3402 3A14 3A34 3A34 F83A"
	$"1403 3A13 3A14 3A13 3A14 FC3A 13FE 3614"
	$"013A 143A 14FB 3613 FE35 F3FE 3613 0535"
	$"F335 F336 1336 1335 F336 13FD 35F3 0036"
	$"13FC 35F3 0131 F331 F2FE 35F3 0631 F331"
	$"F235 F335 F331 F331 F335 F3FD 31F3 0231"
	$"F235 F231 F2FE 31D2 0231 F331 D235 F3FC"
	$"31D2 0735 D231 D131 D135 D239 F318 EA08"
	$"6514 C7FD 18C7 0C14 A614 A621 091C E81C"
	$"E81D 091D 091C E810 A614 A614 A610 A614"
	$"C701 7203 671B 673B 6319 6319 FE63 1AE6"
	$"6319 055E F95E F963 1963 195E F963 19F8"
	$"5EF9 025E F85E F85E F9FD 5EF8 015A F85E"
	$"F9FD 5AF8 FD5A D802 56D8 56D8 5AD8 FD56"
	$"D801 5AD8 5AD8 FE56 D805 56D7 56D7 52B7"
	$"52B7 56D7 56D7 F852 B702 4EB7 52B7 52B7"
	$"FB4E 9703 4A97 4A96 4A97 4E97 FE4A 970B"
	$"4A96 4A76 4A76 4A97 4A77 4A77 4A97 4A77"
	$"4A77 4677 4A77 4676 FE4A 77F9 4676 0146"
	$"5646 56FB 4676 0342 5646 7646 7642 76FB"
	$"4256 0042 55FD 4256 FD42 5500 3E55 F142"
	$"5505 3E55 3E55 3E35 3E55 3E55 3E34 FB3E"
	$"3503 3E34 3E34 3A34 3E34 FD3E 3504 3A34"
	$"3A34 3A35 3A34 3A34 FE3E 3403 3A14 3E34"
	$"3E34 3A14 FB3A 3401 3A14 3A34 FA3A 1403"
	$"3A13 3A14 3A13 3A14 FC3A 1304 3A14 3614"
	$"3613 3614 3614 FC36 1300 35F3 FC36 1302"
	$"35F3 3613 3613 FE35 F302 3613 35F3 3613"
	$"FC35 F300 3613 FC35 F3FD 31F2 F735 F309"
	$"2990 31D1 35F2 35F2 31D2 35F2 31D1 2DB0"
	$"31D1 31D2 FE31 D108 2DB0 298F 31D2 31D1"
	$"35D2 1CEA 0845 14C7 18C7 FE14 C609 10A6"
	$"1085 2109 1CE8 1CE8 18E8 1CE8 1CE8 14A6"
	$"14A6 FE10 A601 5205 671B 673A 6319 6319"
	$"631A 631A E263 1903 5EF9 5EF9 6319 6319"
	$"F65E F9FD 5EF8 035A F85A F85A D85A F8F6"
	$"5AD8 0256 D856 D85A D8FE 56D8 0556 B752"
	$"B756 B852 D852 D752 D7FC 52B7 F94E B702"
	$"4E97 4EB7 4E97 FE4A 9703 4A96 4A76 4A97"
	$"4A77 FC4A 970E 4697 4A76 4A77 4A97 4A97"
	$"4A76 4A97 4676 4A76 4A76 4A97 4A76 4676"
	$"4676 4677 F346 7601 4255 4676 FC42 5606"
	$"4255 4256 4255 4256 4255 4255 4256 F042"
	$"55FE 3E55 0642 553E 353E 353E 553E 353E"
	$"553E 55FE 3E35 033E 343E 343E 353E 35FE"
	$"3E34 003E 35FA 3E34 003A 14F8 3A34 003A"
	$"14FE 3A34 023A 143A 343A 34F8 3A14 013A"
	$"133A 14FC 3A13 0136 1436 14F9 3613 0035"
	$"F3F7 3613 0235 F336 1336 13FE 35F3 FA36"
	$"1301 35F3 3613 FD31 F2FB 35F3 0C35 F235"
	$"F335 F235 F310 C92D B031 D12D B02D B12D"
	$"B12D B025 6E31 D1FC 2DB0 0725 6E31 D12D"
	$"B035 D21D 0B08 6514 C718 C7FE 14C7 0C10"
	$"A610 A621 2A1D 091C E81C E81C E91D 0914"
	$"C714 C710 C610 A610 A601 4601 671B 631A"
	$"E663 1902 5EF9 6319 5EF9 FE63 1903 62F9"
	$"5EF9 5EF8 5EF8 F45E F9FD 5EF8 FC5A F803"
	$"5AD8 5AF8 5AF8 5AD8 FE56 D804 5AD8 5AD8"
	$"56D8 56D7 56D7 FE56 D801 56B8 56B8 FC52"
	$"B800 52B7 FC4E B700 4E97 FD4E B704 4E97"
	$"4EB7 4A97 4EB7 4E97 F54A 9709 4697 4A76"
	$"4A96 4A97 4A96 4A76 4A97 4A76 4676 4A76"
	$"FD46 76FE 4677 004A 76ED 4676 0542 5542"
	$"5642 5646 5642 5642 56F1 4255 023E 5542"
	$"553E 35FE 3E55 013E 353E 55FB 3E35 063A"
	$"343E 353E 353E 343E 343E 353E 35F9 3E34"
	$"F53A 3403 3A14 3A14 3A34 3A34 F83A 1401"
	$"3A13 3A14 FC3A 13EB 3613 003A 13FE 3613"
	$"0035 F3FE 3613 0935 F336 1336 1335 F335"
	$"F336 1335 F335 F331 F231 F2FD 35F3 0031"
	$"F3FE 31F2 1935 F339 F310 C931 D13A 1331"
	$"D131 D131 D231 D221 4E35 F331 D131 D131"
	$"D235 F231 D125 6E35 F331 D239 F321 2C08"
	$"6514 C718 C714 C714 C7FE 10A6 021D 091D"
	$"0918 E8FE 1D09 0410 A614 C714 C710 A610"
	$"A601 5B05 671B 631A 6319 6319 631A 631A"
	$"F563 1900 631A FC63 1903 5F19 5EF9 5EF9"
	$"5F19 FC5E F900 6319 F65E F903 5EF8 5AF8"
	$"5EF8 5EF9 FC5A F800 5EF9 FE5A F801 5AD8"
	$"5AF8 FC5A D8FC 56D8 0C56 D756 D752 B852"
	$"B856 B852 B852 B752 B84E B752 B74E B74E"
	$"B752 B8FE 4EB7 044E 974E B752 B84E 974E"
	$"B7FE 4E97 034E B74E 974A 974E 97FE 4A97"
	$"004A 96FB 4A97 FD4A 9602 4A76 4A76 4A97"
	$"FC4A 7600 4A77 FE46 7600 4A77 EE46 76F9"
	$"4656 0446 7642 5646 5642 5546 56EE 4255"
	$"FE42 35FE 3E35 063E 553E 353E 353E 343E"
	$"3542 553E 35FE 3E34 FD3E 35FC 3E34 023E"
	$"143E 343E 34F9 3A34 033A 143A 143A 343A"
	$"34FD 3A14 003A 13FD 3A14 FB3A 1300 3A14"
	$"F63A 13F3 3613 F435 F331 31F2 31F2 35F3"
	$"35F2 31F2 31F2 35F3 35F2 31F2 31F2 35F3"
	$"3A13 10C9 256E 3A33 35F2 31F2 35F3 31D2"
	$"214E 35F3 35F2 35D2 31D2 35F2 31B1 254E"
	$"35F3 35D2 3A13 294C 0C44 18C7 18E7 14C7"
	$"14C7 14A7 14A7 10A6 212A 18E9 18E8 18E9"
	$"18E9 1CE9 10A6 14C7 14A7 10A6 10A6 0169"
	$"0163 1B63 1AFE 6319 0563 1A62 F963 195F"
	$"1963 1963 19FC 5F19 025E F963 195F 19FD"
	$"5EF9 005F 19F5 5EF9 035E F85A F85E F85A"
	$"F8FE 5EF9 FD5A F802 5AD8 5AF9 5AF8 FA5A"
	$"D8FD 56D8 0056 D7FE 56D8 FE56 D7FB 52B7"
	$"0852 B852 B752 B752 B84E B752 B74E B74E"
	$"B752 B7FE 4EB7 024E 974E B74E B7F7 4E97"
	$"F84A 97FD 4A96 0A4A 764A 974A 764A 964A"
	$"964A 974A 764A 7646 764A 764A 76FB 4676"
	$"0642 7646 7646 7642 7646 7646 7642 76FB"
	$"4676 0142 5642 56FB 4656 0546 7646 5642"
	$"5642 5646 7646 56FE 4655 0346 7542 5546"
	$"7546 76EB 4255 033E 3542 5542 553E 35FE"
	$"3E34 FD3E 3502 3E34 3A34 3A34 FC3E 34F6"
	$"3A34 F73A 14F2 3A13 0136 133A 13FA 3613"
	$"0035 F3FB 3613 0235 F336 1336 13FD 35F3"
	$"0935 F235 F336 1331 F235 F331 F231 F235"
	$"F335 F335 F2FE 31F2 0035 F2FE 31F2 1735"
	$"F23E 1410 C915 0A3A 3335 F231 F235 F235"
	$"F225 6E35 F335 D235 D231 D235 D231 D129"
	$"6F35 F331 D13A 1329 4D0C 6518 C818 C8FE"
	$"14C7 0214 A610 A61C E9FE 18E8 011C E91C"
	$"E9FE 10A6 0110 A510 A601 6003 631A 631A"
	$"6319 6319 FE5E F900 6319 FE5F 19FB 5EF9"
	$"005F 19FA 5EF9 025A F95A F95E F9FD 5AF9"
	$"F75A F8FC 5AD8 025A F85A D85A D8FD 56D8"
	$"005A D8F5 56D8 0052 B8F6 52B7 024E B752"
	$"B752 B7F5 4EB7 034E 964E 974E 974A 96FE"
	$"4E97 014A 974A 97FA 4A96 FE4A 9704 4676"
	$"4A97 4A96 4A96 4A97 FE4A 9604 4A97 4A97"
	$"4A96 4A96 4A76 FA46 7600 4276 F346 7607"
	$"4656 4656 4676 4255 4255 4656 4676 4675"
	$"FE46 5505 4675 4676 4655 4655 4675 4675"
	$"FB46 5500 4255 FD46 55FB 4255 0046 55FC"
	$"4255 033E 353E 353E 343E 34FA 3E35 033E"
	$"343E 343A 343A 34FC 3E34 FB3A 34F6 3A14"
	$"F23A 13FC 3613 0035 F3FE 3613 0335 F335"
	$"F336 1335 F3FE 3613 0235 F336 1336 13FD"
	$"35F3 0335 F235 F336 1331 F2FC 35F3 0335"
	$"F235 F335 F335 F2FE 31F2 2435 F335 F23E"
	$"3410 C808 863A 123A 1235 F135 F231 D11D"
	$"2C31 D135 F231 D131 D135 D12D B01D 0B31"
	$"B031 D035 D025 2C0C 6514 A614 A614 C714"
	$"C714 C614 C614 A618 C714 C718 C718 C718"
	$"E818 E814 C7FE 14C6 0018 C701 7E03 631A"
	$"631A 5EF9 6319 FB5E F900 5F19 FD5E F902"
	$"5EF8 5AF9 5AF9 FD5A F809 5AD8 5AD8 5AF8"
	$"5AD8 5AD8 5AF8 5AD8 5AD8 5AF8 5AD8 FE56"
	$"D9FC 56D8 FE5A D8F5 56D8 0052 B7FC 56D8"
	$"0652 B756 D856 D856 B856 B852 B852 B8F6"
	$"52B7 044E B752 B752 B74E B752 B7FE 4EB7"
	$"034E 974E B74E B74E 96FE 4EB7 034E 974E"
	$"9652 974E 96FE 4E97 024A 964A 964E 97FC"
	$"4A96 054A 974A 974A 964A 9746 7646 76FD"
	$"4A97 FE4A 9605 4A76 4A96 4A96 4A76 4676"
	$"4A76 ED46 7601 4675 4655 FD46 7600 4655"
	$"FB46 7500 4655 FB46 75F9 4655 FD42 55FD"
	$"4655 0642 5442 5542 5442 553E 3442 553E"
	$"34FA 3E35 FE3E 3404 3E35 3E34 3A34 3E34"
	$"3E34 FA3A 3402 3A14 3A14 3A34 F83A 14FA"
	$"3A13 003A 14FA 3A13 FE36 1314 35F3 3613"
	$"35F3 3A13 35F3 3A13 35F3 3613 3A13 35F3"
	$"3A13 35F3 3613 3613 35F2 35F2 35F3 35F2"
	$"35F2 3613 3613 F935 F3FD 31F2 1B35 F331"
	$"F231 F235 F239 F23A 120C A708 652D 8E2D"
	$"AF29 8E29 8F25 4D0C A729 8E25 6D25 4D25"
	$"4C21 4C21 2B14 A721 2A21 2A1D 2A1D 0914"
	$"C718 E814 E8FB 1CE8 0218 E718 C718 E7FE"
	$"18C7 0318 C614 C614 C618 C601 9501 62FB"
	$"631A FE5E F900 5EFA FE5E F900 5AF8 FE5E"
	$"F9FE 5AF8 045A F95A D956 D856 D856 D9FE"
	$"56D8 1256 D956 D956 D856 D956 D956 D856"
	$"D956 D856 D952 B856 D952 D952 D952 B852"
	$"B956 D956 D852 D852 B8FD 52D8 0052 B8FD"
	$"56D8 0752 B856 B856 D852 B852 B852 B752"
	$"B852 D8F9 52B8 F652 B705 4EB7 52B7 4EB7"
	$"4EB7 52B7 52B7 FE4E B7FD 4E97 0052 B7FE"
	$"4E97 0052 B7FD 4E97 024E 964E 964E B7F9"
	$"4A96 014E 974E 96FD 4A96 014A 974A 76FE"
	$"4A96 F84A 7607 4676 4A76 4676 4675 4A76"
	$"4676 4676 4A76 F846 7600 4656 FE46 7603"
	$"4675 4655 4675 4A76 F346 750B 4655 4655"
	$"4255 4675 4254 4255 4655 4675 4255 4255"
	$"4254 4655 FA42 5503 3E54 3E54 3E35 3E35"
	$"FC3E 3404 3A34 3E34 3E34 3A14 3A14 FD3E"
	$"3400 3A34 FC3A 1401 3A34 3A34 F93A 14FE"
	$"3A13 0036 13FB 3A13 0036 13F9 3A13 0836"
	$"133A 143A 1336 1335 F33A 133A 1335 F335"
	$"F3FB 3613 0235 F236 1336 13FE 35F2 0335"
	$"F335 F235 F235 F3FC 35F2 FB31 F208 35F3"
	$"39F3 212B 18C8 1CE8 2109 2109 1D09 1D09"
	$"FE1C E801 18E7 1CE8 FC18 C707 14C6 14A6"
	$"14A6 14A5 14A6 14A6 1085 1085 FE10 8400"
	$"0C64 FD0C 6305 0842 0C62 0441 0842 0441"
	$"1084 01B8 085E FB5E FA5A F95A F85E F95E"
	$"F95A F95A F85E F9FE 5AF9 065A F85A F95A"
	$"D85A D856 D856 D956 D9FD 56D8 0056 D9F9"
	$"52D8 FE52 B804 52D9 52D9 52B8 52B8 52D9"
	$"F552 B80A 4EB7 52B8 4EB8 52B8 4EB7 52B8"
	$"52B8 52B7 52B8 52B7 52B7 FE52 B8FE 52B7"
	$"024E B752 B74E B7FE 52B7 024E B752 B752"
	$"B7FC 4EB7 FE52 B703 4EB7 4EB7 52B7 4E97"
	$"FE52 B7FE 4E97 0352 B752 974E 964E 97FE"
	$"4EB7 054E 964E 964E 974E 964A 964A 96FC"
	$"4E96 044A 964E 974A 964E 964E 96FE 4A96"
	$"0A4A 764A 964A 964A 764A 964A 764A 964A"
	$"964A 764A 7646 76FA 4A76 0446 7646 764A"
	$"7646 7646 76FD 4675 0246 7646 7642 55F9"
	$"4675 0046 55F9 4675 134A 7546 5546 7546"
	$"5446 7546 7542 5446 5542 5446 5542 5542"
	$"5442 5542 5442 5442 5542 5442 5542 5542"
	$"54FE 3E54 F13E 340E 3A14 3A14 3A34 3E34"
	$"3A14 3A14 3A34 3A14 3A14 3A13 3A14 3A14"
	$"3A13 3A14 3A14 EA3A 1300 3613 FE3A 1301"
	$"35F3 35F3 FC36 1300 35F3 FE3A 1315 35F3"
	$"3613 35F3 35F3 3613 3613 35F3 2DB1 3A13"
	$"35F2 35F2 35F3 35F3 3613 35F2 2DB0 3613"
	$"31D1 35F2 2D8E 0865 18C7 FD14 A504 10A4"
	$"1084 1084 14A5 1084 FD0C 6317 0C62 0C83"
	$"0C62 0862 0C62 0C62 0861 0C62 0842 0862"
	$"0842 0862 0842 0863 0863 0C63 0842 0863"
	$"0842 0C63 0842 0C42 0842 1063 01A6 0363"
	$"1B5E FA5A F85E F9FE 5AF9 0B5A F85A F95A"
	$"F95A F85A D85A D856 D85A D856 D856 D85A"
	$"D956 D9FE 56D8 0152 D852 D8FD 52B8 FD52"
	$"D800 52D9 FD52 B806 4EB8 4EB8 52B8 52B8"
	$"4EB8 4EB8 52B8 FC4E B808 4EB7 4EB7 4EB8"
	$"4A97 4EB7 4EB7 4EB8 4EB7 4E97 F04E B700"
	$"4E97 FD52 B7FB 4EB7 014E 974E B7FC 52B7"
	$"0D4E 9752 B74E 974E 9752 B74E 9652 B752"
	$"B74E 964E 964E B74E 964E 964E B7FD 4E96"
	$"004A 96FE 4E96 004E 97FD 4E96 004E 97FC"
	$"4E96 FA4A 960B 4A76 4A75 4A75 4A76 4676"
	$"4A76 4676 4676 4A76 4675 4676 4676 FC46"
	$"7500 4655 F846 7500 4655 F846 7501 4655"
	$"4675 FE46 55FC 4654 0342 5446 5442 5442"
	$"54FE 4234 FE42 5401 3E54 3E54 F53E 3411"
	$"3A34 3A34 3E34 3E34 3A34 3A34 3E34 3E34"
	$"3A14 3A34 3A14 3A14 3A13 3A13 3A14 3A14"
	$"3A13 3A34 FE3A 1300 3E33 F53A 1300 35F2"
	$"FA3A 1305 3613 3613 3A13 3A13 35F3 35F3"
	$"FC36 131B 35F3 3A13 3A13 31D1 3A13 35F2"
	$"35F2 35F3 35F3 35F2 298F 2DD1 3A34 35F2"
	$"35F2 39F3 39F3 35F2 2D90 214C 2DAF 256D"
	$"190A 10A7 0C84 14A6 1084 1083 FD0C 6202"
	$"0842 14A5 0C83 FE0C 6300 0C84 FE0C 6300"
	$"0863 FE0C 6302 0C64 0C63 0C63 FD10 8409"
	$"0C84 1084 0C84 0C84 0843 0863 0C63 0C63"
	$"0C64 1084 01B5 0B63 1B63 1A5E F95E F85A"
	$"F95A F95A F85A D85A D85A F956 D85A D8FE"
	$"56D8 005A D8FC 56D8 FE52 D8FD 52B8 0052"
	$"D8FC 52B8 0152 D952 B8F4 4EB8 0A4E 984E"
	$"984E B84E 984E 984E B84E B84E B74E 974E"
	$"B74E B7FD 4E97 014E B74E B7FD 4E97 064E"
	$"B74E B74E 974E B74E B74E 9752 B7FE 5297"
	$"074E B74E 974E 974E B74E B74E 964E 974E"
	$"97FE 52B7 0C4E 974E 9752 B752 B74E 974E"
	$"B64E B652 B752 B74E B64E 9652 B752 B7FA"
	$"4E96 034E 974E 964E 974E 97FE 4E96 0152"
	$"9752 97F8 4E96 FD4A 960B 4A76 4A76 4A96"
	$"4A96 4675 4675 4A76 4675 4A76 4675 4A96"
	$"4676 FE46 7500 4655 FB46 750A 4655 4655"
	$"4675 4675 4655 4655 4675 4655 4675 4675"
	$"4655 FE46 7506 4674 4675 4675 4A75 4654"
	$"4A55 4654 FD46 55FD 4654 F842 54EF 3E34"
	$"033A 343E 343E 343A 14FE 3A34 053A 133A"
	$"133A 343A 133A 133A 34F6 3A13 033A 123A"
	$"133A 133A 12FE 3A13 0036 13FE 3A13 0536"
	$"1336 133A 133A 1335 F335 F3FD 3613 2435"
	$"F336 1336 1335 F219 0B2D D12D B035 F231"
	$"D229 8F25 6E25 6E31 D12D B031 D135 F23E"
	$"1335 D12D 8E18 E914 C814 C714 E80C A60C"
	$"850C 8514 A514 A510 8410 8310 8310 8210"
	$"830C 6218 C614 A410 83FD 1084 050C 8410"
	$"840C 840C 8410 8414 C6F7 14A6 0614 C608"
	$"430C 640C 840C 8410 A50C 8501 8309 631B"
	$"5EF9 5EF8 5EF8 5EF9 5EF9 5EF8 5EF8 5AF9"
	$"5AF9 FB5A D8FE 56D9 005A D9FA 56D8 0B56"
	$"B856 D856 D852 B856 D852 D852 B856 D952"
	$"D852 B852 B852 D8F4 52B8 0252 B752 B74E"
	$"B7F9 52B7 004E 97FC 4EB7 024E 974E B74E"
	$"B7F4 4E97 024A 964E 974A 97F7 4E97 064A"
	$"964A 964E B74E 974E 964E 9752 97FA 4E97"
	$"0352 974E 974E 964E 97FE 4E96 FC52 9601"
	$"4E96 5296 FA4E 9606 4A95 4A95 4A96 4A96"
	$"4A75 4A76 4A96 FD4A 7600 4A75 FA46 7500"
	$"4676 F946 5505 4255 4255 4655 4255 4255"
	$"4675 FC46 5503 4675 4675 4655 4654 FC46"
	$"5501 4654 4655 FC46 54FD 4254 0342 5542"
	$"3442 343E 34FE 4234 013E 3442 34FA 3E34"
	$"003E 33FD 3E34 003A 13FB 3E34 F93A 1300"
	$"3A14 EC3A 132B 3612 3613 3613 35F2 3612"
	$"35F2 3A14 31D1 31B0 31AF 0443 0C86 254C"
	$"296D 212B 1CEA 14C8 1909 14E8 214C 31D0"
	$"298F 3E13 18EA 1D0A 0C85 0863 10A5 1084"
	$"0C63 0C63 0862 14A5 18C6 1084 1063 1084"
	$"1083 0C83 0862 1CE6 14A5 1085 1084 FE10"
	$"8516 1084 1085 1085 0C84 10A5 18E8 10A6"
	$"0C86 10A6 0C85 18E8 14C7 0443 10A6 0863"
	$"14A7 1CE8 0C63 0C84 1084 0C64 14C6 0C85"
	$"016C 015E FA5E F9FE 5EF8 025E F95E F95E"
	$"F8FE 5AF8 FA5A D801 56D8 5AD9 F356 D800"
	$"56D9 FB56 D801 56B8 56B8 FC56 D801 52D8"
	$"52D8 FE52 B804 52B7 52B7 52B8 52B7 56B7"
	$"F852 B703 4EB7 52B7 52B7 4EB7 FD4E 9700"
	$"4EB7 FD4E 9702 4A97 4EB7 4A97 F44A 9603"
	$"4A97 4A97 4A96 4A96 FD4A 97FE 4E96 004A"
	$"96F4 4E96 0252 964E 9652 96F8 4E96 084A"
	$"954A 954A 754A 754A 764A 754A 754A 764A"
	$"76F7 4675 0246 5546 7546 75FC 4655 F642"
	$"5506 4655 4255 4655 4255 4254 4655 4655"
	$"FE42 5502 4655 4254 4654 F742 54FB 4234"
	$"FA3E 340A 3E33 3E34 3E34 3E33 4255 214D"
	$"298E 4676 3E33 3E34 3E14 F93A 1300 3A14"
	$"FD3A 1300 3613 F93A 13FB 3613 023A 1336"
	$"133A 12FE 3612 0036 13FE 35F2 053E 342D"
	$"AF10 A718 E804 2204 43FE 10A6 FE08 6417"
	$"0464 212B 212B 14C9 212B 0023 0C85 0843"
	$"0842 10A5 0C63 0843 0842 0C63 1084 14A4"
	$"14A5 0C63 1083 0C63 0C63 0862 1D07 10A5"
	$"FA10 8514 0C84 0C84 10A6 1D09 0864 0444"
	$"0865 0844 1D09 14C7 0001 0C65 0423 14A7"
	$"1CE9 0C64 0C64 0C84 0C64 14C7 1085 0182"
	$"035E FA5E F95E F85E F8FE 5EF9 005E F8FE"
	$"5AF8 065A F95A F95A F85E F95A F85A F95A"
	$"F9FE 5AF8 075A D856 D856 D85A D85A D856"
	$"D85A D85A D8FE 56D8 FE5A D8F2 56D8 0956"
	$"D756 D856 D756 D856 D856 D756 D756 B756"
	$"D756 D7FA 52B7 034E B752 B74E B752 B7FE"
	$"4EB7 FB4E 970A 4A97 4A97 4A96 4A97 4A97"
	$"4A96 4A96 4E97 4A96 4A96 4E97 FC4A 96FE"
	$"4A97 034E 974A 964A 974A 97F7 4A96 EC4E"
	$"9607 4A96 4A75 4A75 4A96 4A76 4A75 4A75"
	$"4A76 F446 75FC 4655 F842 55FD 4254 FA42"
	$"55F9 4254 0042 34F9 4254 FD42 34FE 4254"
	$"0D3E 343E 343E 333E 333E 343E 3342 5446"
	$"5404 441D 0A52 D83E 333E 333E 13F9 3A13"
	$"053E 343A 133A 333A 133A 1336 13F8 3A13"
	$"FA36 1301 39F2 39F2 FE36 1242 35F2 3A13"
	$"3E13 31B0 212A 0022 0863 0C63 0863 0442"
	$"0443 0842 0442 0863 0864 0884 18E8 0C85"
	$"0864 0C63 0442 0C63 0842 0442 10A5 0863"
	$"0442 0863 0862 1084 1083 1CE6 0C62 1083"
	$"1083 0C83 0442 1D08 14C6 1085 10A5 1085"
	$"1086 1085 1085 10A5 10A5 1085 10A6 1D09"
	$"0C65 0864 0C85 0C65 1D09 14C7 0443 0C85"
	$"0864 10A6 1CE9 0C85 0864 1085 0C85 14C7"
	$"10A6 019C 0362 FA62 F95E F85E F8FE 5EF9"
	$"005E F8FA 5EF9 FA5A F807 5AD8 5AF8 5AF8"
	$"5AF9 5AD8 5AD8 5AF8 5AF8 F25A D805 56D8"
	$"56D8 5AD8 56D8 56D7 56D8 FC56 D7FD 56D8"
	$"FE52 B700 56D8 FB52 B701 4E96 52D8 FD4E"
	$"B700 52B7 FC4E 9700 4EB7 FD4E 9705 52B7"
	$"4E96 4E96 4EB7 4E97 4E97 FD4E 9603 4E97"
	$"4E97 5297 5296 FE4E 9605 4E97 4E97 4A96"
	$"4E97 4A96 4A96 FC4E 96FC 4A96 F44E 960C"
	$"4A96 4A96 4A95 4A76 4A75 4A76 4A76 4A75"
	$"4A76 4A76 4A75 4675 4A75 F946 75FE 4655"
	$"0246 7546 7546 55F9 4255 FB42 5402 4255"
	$"4255 3E35 FE42 550F 4254 3E54 4254 4254"
	$"3E34 3E54 3E54 4254 3E34 4234 4234 4254"
	$"4254 4234 4233 4233 F542 3407 3E34 4233"
	$"4E75 3DF1 0000 1D0A 5AF9 4254 FD3E 3303"
	$"3A33 3A13 3A13 3A33 F13A 1302 3613 3613"
	$"35F3 FC36 130C 39F2 3A13 3A12 3A13 31D1"
	$"298F 35F2 4234 1D0A 0844 0442 0842 0C62"
	$"FE08 6205 0842 0441 0C84 0C84 0864 10A5"
	$"FE08 4200 0C63 FE08 422A 10A4 0862 0441"
	$"0842 0842 1084 0842 14A4 14A5 1083 1083"
	$"0C63 0442 1D08 14C6 1085 10A5 1086 10A6"
	$"10A6 1085 0C64 0864 0C85 14C7 210A 0C65"
	$"0443 0C85 0864 1D09 14C8 0864 0C86 0C65"
	$"14C7 1D09 0C85 0C64 0C85 0C84 18C7 10A6"
	$"01B0 0A63 1A5E F95E F85E F863 195E F95E"
	$"F85E F85E F95E F85A F8FA 5EF8 015A D85A"
	$"D8FC 5EF8 095A F85A F85A D85A D85A F85A"
	$"D85A D85A F85A D85A D8FE 5AF8 F75A D8F9"
	$"56D8 0452 D852 D852 B752 B756 D8FB 56B7"
	$"EB52 B700 52B6 FC52 B7FE 52B6 0052 96FC"
	$"52B6 0652 B752 B74E 9652 964E 964E 964E"
	$"B6F2 4E96 014A 964A 96FC 4E96 084A 964A"
	$"964A 954A 764A 754A 754A 764A 754A 75FE"
	$"4A76 FE4A 75FC 4675 034A 7546 7546 754A"
	$"75FE 4675 F846 5501 4255 4655 FE42 5502"
	$"4655 4655 4255 FD42 540F 4234 4254 3E34"
	$"4234 4234 4254 3E34 4234 3E34 4234 4254"
	$"3E34 3E34 4234 3E34 4234 FE3E 3405 3E33"
	$"4234 4254 4254 4234 3E33 FE42 3406 4233"
	$"56B7 318D 0000 14C7 5AF8 4675 FD3E 3300"
	$"4234 FE3E 33FC 3E13 FE3A 1304 3E13 3A13"
	$"3A12 3A13 3A13 FE3A 1205 3A13 3A13 35F2"
	$"3A13 3A13 35F2 FE3A 132B 35F2 3A12 31D1"
	$"190B 0CA7 214C 4234 18C7 0001 0842 0842"
	$"0862 0862 0842 0842 0862 0842 0842 0C63"
	$"14A5 1084 10A4 1084 0C63 0C63 0422 0842"
	$"0442 14A5 0C84 0842 0842 1063 14A4 0841"
	$"0C63 1CE6 1063 1083 0C83 0862 1908 14C7"
	$"0CA5 FE10 A611 1086 0C85 0C65 0C64 1085"
	$"10A6 210A 0C65 0444 0C85 0865 18E9 14C8"
	$"0C86 10A7 0C86 14C7 18E9 FD0C 8501 14A7"
	$"0C86 01A0 0162 FA62 F9FE 5EF8 015E F95A"
	$"D8FD 5EF8 005A D8FB 5EF8 015A F85A F8FD"
	$"5EF8 055A F85A F85E F85E F85A D85A F8F4"
	$"5AD8 FE56 D804 5AD8 5AD8 56D7 56D7 56D8"
	$"FB56 D702 56D8 56B7 56B7 FE56 D7FD 56B7"
	$"FE52 B701 56D7 52B7 FE56 B7FA 52B7 0052"
	$"B6F7 52B7 0252 B652 B752 B7F9 52B6 0252"
	$"B74E 9652 96F3 4E96 004A 96FB 4E96 094A"
	$"964A 954A 954E 954E 954E 964E 964E 754A"
	$"754A 76F7 4A75 FC46 7504 4A75 4675 4675"
	$"4A75 4A75 FA46 7506 4655 4675 4655 4655"
	$"4654 4655 4655 FD46 54F9 4254 0242 3442"
	$"3442 54FD 4234 0342 5442 343E 3442 34FD"
	$"3E34 FE3E 33FE 4234 0A3E 333E 3342 3442"
	$"3442 3356 B71C E800 000C 6456 D84A 96F9"
	$"3E33 073E 133E 133E 333E 333E 133E 133A"
	$"133A 13FE 3E13 FC3A 1212 3A13 3A13 3A12"
	$"3A13 3A12 35F2 35F2 3A13 3E33 214C 298E"
	$"14E8 0C85 0864 0C84 1CE8 1084 0C63 0C62"
	$"FD08 4209 0843 0842 0842 0442 0863 1084"
	$"0C63 1084 0C84 18C6 FE08 422B 0441 14A5"
	$"1084 0842 0842 14C5 14A5 0842 0862 18C6"
	$"14A5 0C83 0C84 0843 18E8 14C7 0C86 0C85"
	$"10A6 10A6 0C65 0C86 0C85 0865 0C86 0C85"
	$"14E8 0865 0C65 0C65 10A6 10A7 0C86 0865"
	$"0865 0444 0445 0C86 0C86 0445 0444 0444"
	$"0445 0444 0190 015E FA5E F9FA 5EF8 015A"
	$"D85A D8FC 5EF8 035A F85A D85A D85A F8FB"
	$"5AD8 FE5A F805 5AD8 5AD8 5AF8 5AD8 5AD8"
	$"5AF8 FA5A D8FB 56D8 FD56 D700 5AD8 FA56"
	$"D704 56B7 56D7 56D7 56B7 56D7 FE56 B7FA"
	$"52B7 0052 B6FB 52B7 FA52 B605 52B7 52B7"
	$"52B6 52B7 52B6 52B7 FD52 B6FC 5296 FC4E"
	$"9600 5296 F64E 9601 4E95 4E95 FC4E 9607"
	$"4A95 4A95 4E96 4E95 4E95 4E96 4E95 4E95"
	$"FE4A 7500 4E96 FC4A 7501 4675 4675 FA4A"
	$"75F6 4675 0346 5446 7546 5446 54FE 4674"
	$"FB46 5404 4254 4654 4654 4254 4654 F642"
	$"5401 4234 4234 FE42 3301 3E33 4234 FA3E"
	$"3313 3E13 4654 4E75 0843 0000 0443 52D7"
	$"4A96 3A32 3E33 3A12 3A12 4254 35F1 3A12"
	$"3E33 3E33 3A13 3E33 3E33 FD3E 1303 3E33"
	$"3E12 3E12 3E13 F63A 1208 4234 3E11 0864"
	$"0884 0863 0C63 0C62 0C62 0C41 FE0C 6200"
	$"0841 FD08 4237 0442 0442 0842 0842 0421"
	$"0442 0442 0C84 14A5 0C63 0C84 1084 0C63"
	$"18C7 14A5 0C63 0443 0C85 0864 0443 0864"
	$"1085 0864 0843 0444 0444 14C7 10A6 0C86"
	$"0C85 0865 0C86 0865 0865 0023 0423 10A7"
	$"10A7 0886 0023 10A7 0C65 0845 1086 0C86"
	$"0023 0865 0444 0023 0866 0C87 0445 0444"
	$"0024 0023 0024 01B9 015E FA5E F9FC 5EF8"
	$"035A F75E F85A D85A D8FE 5EF8 015E D85E"
	$"F8F9 5AF8 FA5A D800 5AF8 F95A D8FE 56D8"
	$"015A F85A F8FE 56D8 015A D85A D7FE 56D7"
	$"035A D756 D756 D756 D8FE 56D7 0356 B756"
	$"B75A D756 D7FC 56B7 0152 B756 D7FE 52B7"
	$"0056 B7FA 52B7 0252 B652 B652 B7FE 52B6"
	$"FD52 B706 52B6 52B6 52B7 5296 52B6 52B7"
	$"52B6 FC52 96F7 4E96 0052 96FE 4E96 0452"
	$"9652 964E 964E 954E 95FD 4E96 FE4E 9500"
	$"4E96 FE4E 95FE 4A95 FA4A 75FE 4675 FC4A"
	$"75F9 4675 0746 7446 7446 5446 5446 7442"
	$"5446 7446 74F2 4654 0D42 5446 5446 5442"
	$"3342 5446 5446 5442 5442 3342 3442 5442"
	$"3342 3442 34FE 4233 0042 54FE 4234 1B42"
	$"333E 333E 3342 343E 334A 754A 5400 0100"
	$"0014 A65B 1942 543A 1342 5514 E931 D03A"
	$"1219 0B35 F12D AF3A 333E 333A 123E 333E"
	$"123E 123E 133E 13FD 3E12 FE3A 1201 3E12"
	$"3E12 FE3A 1212 3E12 3E12 3A12 4654 318C"
	$"0421 0420 0842 0C62 0C62 0C42 0C62 0842"
	$"0C63 0842 0842 0C62 0862 0841 FC08 42FE"
	$"0843 1310 8521 091C E71C E818 C718 C721"
	$"0910 8504 2200 2404 4508 4510 A70C 8608"
	$"6504 2408 4504 2408 4514 A7FE 10A7 1304"
	$"450C 870C 660C 6604 2404 4414 C810 A708"
	$"6508 4514 A70C 8608 6510 860C 6600 2310"
	$"A80C 8608 650C 65FE 0C66 0208 4508 4404"
	$"2301 C607 62FA 5EF9 5EF8 5EF8 5EF9 5EF9"
	$"5AF8 5AF8 FB5E F802 5AD8 5AD8 5EF8 FE5A"
	$"D805 5ED8 5EF8 5ED8 5AD8 5AD8 5EF8 FE5A"
	$"D802 5AF8 5AD8 5AF8 F85A D807 5AD7 5AD8"
	$"5AF8 5AD8 56D7 56D8 56D7 5AD7 F756 D7FD"
	$"56B7 0656 D756 B756 B752 B752 B756 B752"
	$"B6FD 52B7 0956 B752 B752 B652 B752 B752"
	$"B652 B752 B752 B652 B7F8 52B6 0552 9652"
	$"B652 B652 9652 B652 B6FD 5296 0152 B652"
	$"96FE 4E96 0752 9652 964E 964E 9652 B652"
	$"9652 964E 95FE 4E96 0152 964E 96FE 4E95"
	$"014E 964E 96FD 4E95 074E 964E 964E 954E"
	$"754E 964E 954E 964E 75EE 4A75 014A 544A"
	$"75FE 4654 054A 5446 5446 7446 5446 5446"
	$"74F8 4654 FE42 5400 4654 FE42 540C 4654"
	$"4654 4253 4653 4654 4253 4233 4233 4234"
	$"4234 4233 4234 4654 FE42 3300 4234 F942"
	$"3311 4A75 4632 0000 0000 1CE8 5F1A 4255"
	$"3E12 35D0 0001 2129 14A5 14C6 18E8 1D09"
	$"4655 4234 3A12 FC3E 13FB 3E12 003A 12FD"
	$"3E12 FE3A 1211 4254 35D0 14A5 0421 0842"
	$"0842 0C62 0C62 0841 0842 0842 0C63 0842"
	$"0842 0C62 0842 0842 0841 FC08 421F 0C64"
	$"0843 10A5 1D09 18C7 18C6 0842 14A5 2109"
	$"1085 0423 0024 0445 0C87 14C9 0866 0866"
	$"0C66 0845 0024 0866 1087 0C66 0C66 0C86"
	$"0865 0C86 0C66 0C87 0866 0846 0C87 FD08"
	$"4606 0866 0445 0445 0424 0424 0C66 0866"
	$"FD0C 66FE 0C65 0004 2301 9806 62FA 5EF9"
	$"5EF8 5EF8 5AF8 5EF9 5EF9 F65E F800 5ED8"
	$"FC5E F805 5AD8 5EF8 5AD8 5AD8 5AF8 5AF8"
	$"F85A D800 5AD7 FC5A D801 56D7 56D8 FE56"
	$"D700 5AD8 FC56 D7FE 56B7 0056 D7FA 56B7"
	$"0152 B652 B6FA 52B7 0452 B652 B752 B752"
	$"B652 B7F2 52B6 0352 9652 9652 B652 B6FD"
	$"5296 0052 B6FC 5296 0B4E 964E 9652 B652"
	$"9652 964E 964E 9652 9652 964E 9652 964E"
	$"96FA 4E95 024E 964E 954E 96FC 4E95 EF4A"
	$"7500 4A74 FE4A 7506 4654 4654 4A75 4A74"
	$"4A74 4654 4674 FD46 5400 4675 FA46 54FD"
	$"4254 FA46 5402 4253 4233 4233 FE42 54FE"
	$"4234 0542 3342 3442 3342 3342 3442 34FC"
	$"4233 134A 7546 5300 2100 001D 0856 F83A"
	$"1139 EF1C E800 2008 620C 8308 6308 643A"
	$"114A 763E 333E 133E 123A 12F9 3E12 003A"
	$"12FD 3E12 0F3A 113A 123E 123A 1231 B018"
	$"E904 2208 420C 6308 4108 420C 6204 2108"
	$"4208 420C 63FC 0842 0008 41FD 0842 1608"
	$"630C 8404 4208 6414 C721 0918 C604 2108"
	$"4218 C710 A508 4400 2404 4508 660C 870C"
	$"660C 8708 4504 4504 2508 4508 45FD 0425"
	$"180C 8708 6608 8608 8608 650C 6608 4508"
	$"4608 4504 2404 2500 2404 2404 2404 2504"
	$"2400 0408 450C 650C 660C 8608 4404 4408"
	$"4404 2301 CA01 62FA 5EF9 FE5E F802 5EF9"
	$"5EF8 5AF8 FD5E F800 5AD8 FA5E F80A 5AD8"
	$"5AD8 5EF8 5ED8 5AD8 5AF8 5AD8 5AF8 5AD8"
	$"5AD8 5AF8 FA5A D8FD 5AD7 025A D85A D85A"
	$"D7FC 56D7 025A D856 D756 B7FE 56D7 FE56"
	$"B700 56D7 FC56 B702 56D7 56B7 52B6 FE52"
	$"B700 52B6 FD52 B704 52B6 52B7 52B6 52B6"
	$"52B7 F652 B607 5296 52B6 52B6 4E96 5296"
	$"5296 52B6 52B6 FE52 9602 4E96 4E96 5296"
	$"FD4E 9600 5296 FD4E 9607 5296 4E95 4E96"
	$"4E96 4E95 5296 5296 4E96 F34E 95F8 4A75"
	$"064A 744A 754A 754A 7446 7446 744A 75FE"
	$"4A74 004A 75FE 4A74 0646 744A 7446 7446"
	$"5446 544A 744A 74FE 4654 0046 74FA 4654"
	$"0542 5446 5442 5342 5342 5442 53FC 4654"
	$"0242 5342 3342 33FE 4254 0042 34F9 4233"
	$"173E 3342 333E 333E 3342 3346 544E 7404"
	$"2100 0010 A531 AD14 E714 C50C 6204 4108"
	$"6210 A500 0121 2A56 F83E 333E 123E 123E"
	$"13FA 3E12 013A 123A 12FD 3E12 0F3A 123E"
	$"123A 1142 5331 AE04 4408 440C 4308 4308"
	$"4208 4108 4208 4204 2108 4308 41FA 0842"
	$"1608 2208 4208 4204 4208 430C 6404 4210"
	$"A51C E831 8D25 2A04 0004 2118 C614 A508"
	$"4300 2304 2404 4510 A70C 6608 4504 24FE"
	$"0444 1D08 4404 4404 4408 4504 240C 6608"
	$"850C 860C 6508 6508 650C 6510 8608 4408"
	$"440C 4508 240C 650C 6500 0204 2304 2308"
	$"640C 850C 6408 6408 4304 4308 4408 6401"
	$"B301 5EFA 5EF9 FC5E F800 5AF8 F95E F803"
	$"5ED8 5AD8 5AD8 5EF8 FE5A D800 5EF8 FE5A"
	$"D800 5AF8 FE5A D800 5AD7 FA5A D802 5AD7"
	$"5AD8 5AD8 FE5A D7FD 56D7 065A D756 D756"
	$"D756 B756 D756 D756 B7FD 56D7 F856 B705"
	$"52B6 56B7 56B7 52B7 52B6 52B7 F352 B602"
	$"5296 52B6 5296 FE52 B601 4E96 4E96 FE52"
	$"9600 4E96 FE52 9602 4E96 5296 5296 FE4E"
	$"9605 5296 5296 4E95 4E96 4E96 52B6 FD4E"
	$"95FE 4E96 024E 954E 964E 96F6 4E95 014E"
	$"754E 95FE 4A75 054A 744A 754E 954A 754A"
	$"744A 75F5 4A74 FC46 7404 4654 4654 4A54"
	$"4654 4674 F746 540D 4653 4654 4654 4253"
	$"4654 4654 4253 4253 4654 4253 4233 4233"
	$"4254 4254 F942 3315 3E33 4233 3E33 4233"
	$"3E33 3E33 4233 4E75 4633 0000 0000 0421"
	$"0C83 0442 0842 0843 0422 18E7 10A6 0000"
	$"31CF 4EB7 F83E 120E 3A12 3A12 3E12 3E13"
	$"3E12 3A12 3A12 3E13 3E12 39F1 3E32 4232"
	$"252A 0001 0843 FC08 4201 0841 0841 FE08"
	$"4200 0821 FC08 4200 0822 FE08 4211 0442"
	$"0442 0C64 296B 296C 2109 2108 0420 0421"
	$"18C6 1084 0442 0C65 1065 0844 1085 0844"
	$"0423 FE08 431E 0442 0C85 1085 0443 0C65"
	$"0844 0864 0C64 0C64 0863 0843 0422 0843"
	$"1085 0C64 0822 0843 0822 1084 1064 0421"
	$"0842 0421 0C64 1085 0863 0843 0843 0C64"
	$"1084 1084 01C4 015E FA5E F9FD 5EF8 005A"
	$"D7FC 5EF8 FD5A F8FD 5EF8 085A D85A D85E"
	$"F85E F85E D85E D85A D85E D85E D8F3 5AD8"
	$"095A D75A D856 D75A D75A D756 D756 D75A"
	$"D756 D756 D7FE 56B7 0256 D756 B75A D7FA"
	$"56B7 0556 D756 B756 B656 B656 B756 B7FD"
	$"52B6 0052 B7FE 52B6 0152 B752 B7FA 52B6"
	$"0552 9652 B652 B652 9652 9652 B6FD 5296"
	$"0052 B6FB 5296 0D4E 954E 964E 964E 9552"
	$"9652 964E 9552 954E 9552 9552 9652 954E"
	$"954E 95FD 5295 034E 9552 954E 9552 95F8"
	$"4E95 FE4E 7507 4A75 4E75 4A74 4A75 4E75"
	$"4A75 4A74 4A75 F44A 7403 4674 4674 4A74"
	$"4A74 FD46 5400 4A74 FD46 5400 4A74 FC46"
	$"5407 4653 4654 4654 4653 4654 4654 4633"
	$"4633 FD42 3300 4253 F742 3314 4232 4232"
	$"3E32 3E32 4254 4233 5296 294B 0000 0000"
	$"0421 0C62 0841 0C63 0822 1084 1D08 0001"
	$"0C84 31AE 4232 F83E 1214 3A12 3E33 39F1"
	$"296E 3A12 3E33 3E13 3E12 31AF 254B 3E11"
	$"296B 0C84 0442 0862 0841 0C62 0842 0C62"
	$"0C62 0421 FD08 4208 0421 0842 0842 0821"
	$"0822 0842 0822 0842 0422 FE08 420E 0863"
	$"1085 1085 0C64 1084 0842 1063 1CE6 0C42"
	$"0841 1084 1084 0842 0C63 0C43 FE08 4208"
	$"0C43 0C63 1084 1064 0C64 1084 0863 0843"
	$"1064 FE10 850E 0C64 0C64 14A5 18C6 1085"
	$"0C64 1085 14C7 14C6 14C6 18C7 18C6 18C7"
	$"18C7 18A6 FD18 C700 1CE7 0197 025E FA5E"
	$"F85E F7FA 5EF8 095A F85E F85A D85A D85A"
	$"F85A F85A D85A D85A F85E F8FC 5AD8 005A"
	$"F8FA 5AD8 005A F8FB 5AD8 0A5A D756 D75A"
	$"D756 D75A D75A D756 D756 D756 B756 D75A"
	$"D7F4 56B7 0052 B6FE 56B7 0252 B652 B656"
	$"B6F8 52B6 0052 B7F9 52B6 0252 9652 9652"
	$"B6FC 5296 034E 954E 9552 9652 96FE 4E96"
	$"0152 9552 96FD 4E95 FE52 95FE 4E95 FE52"
	$"96FC 5295 054E 754E 9552 9552 964E 9552"
	$"95FA 4E95 FC4E 7508 4A74 4A75 4E75 4A75"
	$"4A74 4A75 4A74 4A75 4A75 F64A 7400 4A54"
	$"FE4A 74F3 4654 FD46 5303 4654 4654 4653"
	$"4654 FE46 5300 4654 F542 332D 4232 3E12"
	$"4233 4233 35AF 3DF1 1085 0001 0000 0420"
	$"0C62 0C62 0842 0842 294A 10A5 0863 1D09"
	$"18E8 39F0 4A74 3E12 3E32 3E32 3A12 3E32"
	$"3E32 35F0 39F1 39F1 3E32 212B 0444 3E12"
	$"4233 31AF 1D0A 0864 1086 1D08 18C7 0C63"
	$"0863 0842 0842 0862 F908 4200 0822 FD08"
	$"4216 0822 0842 0843 0442 0C63 0842 0843"
	$"0842 0843 0843 0C64 0C84 0842 2108 1CE7"
	$"18C6 18C6 1CC7 1CE7 1CC7 1CE7 1CE7 1CE8"
	$"FE1C E7FC 1CE8 1118 E710 851C E821 091D"
	$"091C E918 E81C E821 091D 091C E818 E818"
	$"E81D 091D 0918 E81C E918 E8FB 1CE8 0118"
	$"E81C E801 C402 5EFA 5EF8 5EF7 FD5E F801"
	$"5EF7 5EF8 FE5A F803 5AD7 5AD8 5EF8 5EF8"
	$"FE5A D806 5AD7 5AD7 5AD8 5AD8 5AD7 5AD8"
	$"5AF8 FE5A D8FE 56D7 035A D75A D85A D85A"
	$"D7FD 5AD8 0256 D756 D75A D7FE 56D7 0156"
	$"B756 B7FE 56D7 0256 B756 D756 D7FD 56B7"
	$"0D56 B656 B756 B756 B656 B656 B752 B656"
	$"B752 B656 B652 B652 B656 B756 B7F0 52B6"
	$"084E 9552 B652 9652 9652 B652 B652 964E"
	$"954E 95FD 4E96 044E 9552 B652 9652 9652"
	$"B6FD 4E95 0052 95FC 4E95 0252 9552 9652"
	$"96FD 5295 FC4E 9501 5295 5295 FC4E 9508"
	$"4E75 4A75 4E75 4A75 4E75 4A75 4A74 4A75"
	$"4E75 FD4A 7401 4A75 4A75 F34A 74FB 4654"
	$"004A 74FB 4654 0546 5346 5346 5446 5346"
	$"5346 54F9 4653 0142 3342 53F6 4233 2942"
	$"324A 7525 4C10 A518 C60C 630C 6304 0004"
	$"200C 620C 6304 430C 641C E904 2310 A614"
	$"C710 8625 4C3E 3214 E82D AE42 533E 3246"
	$"5431 AF10 861C E918 E81D 0914 A708 4421"
	$"0A18 E81D 0918 C710 A618 C71C E818 E70C"
	$"8410 84FE 0842 010C 6208 41FE 0842 1704"
	$"2108 4208 220C 4208 4208 2108 2208 4204"
	$"2108 4208 430C 6410 8508 6308 630C 430C"
	$"630C 6310 840C 8304 211C E725 2921 29FC"
	$"2109 0A21 0821 0921 0821 0821 0921 0821"
	$"081D 081D 0821 0821 08FB 1CE8 0218 E71C"
	$"E81C E8FE 18C7 0118 E718 C7FD 14C6 0114"
	$"A614 C6FD 14A5 0010 A501 D302 5EFA 5EF8"
	$"5EF7 FE5E F80E 5AD7 5EF8 5EF8 5AF8 5AD8"
	$"5AF8 5AD8 5ED8 5EF8 5ED8 5AD8 5EF8 5AD8"
	$"5AD7 5AD7 FE5A D805 5ED8 5ED8 5AD8 5ED8"
	$"5AD8 5AD7 FD5A D800 5AD7 FC5A D808 56D7"
	$"56D7 5AD7 5AD7 56B7 56B7 56D7 56B7 5AD7"
	$"FC56 D701 56B7 56D7 FC56 B705 56B6 56B6"
	$"56B7 56B6 56B7 52B6 FE56 B601 56B7 56B6"
	$"F652 B600 5296 FC52 B602 5296 52B6 5296"
	$"FD52 B600 5295 FC52 9600 4E95 FE52 9600"
	$"52B6 FC4E 9508 5295 5296 4E95 5295 4E95"
	$"4E95 5295 5296 5296 FD52 95FE 4E95 0052"
	$"95FA 4E95 014E 754A 75FE 4E75 064A 744A"
	$"744A 754A 754A 744A 744A 75F3 4A74 0646"
	$"544A 7446 5446 5446 5346 534A 74F8 4654"
	$"0646 5346 5346 5446 5346 5346 5446 53FE"
	$"4233 0246 5342 3342 53F8 4233 333E 323E"
	$"3231 D039 F142 334E 9535 CF04 2204 220C"
	$"620C 630C 4204 0000 0008 410C 8308 6208"
	$"4208 6304 4204 4208 630C 641D 0918 E904"
	$"6410 A642 334E 954A 5418 E80C 6504 430C"
	$"640C 8414 C610 A508 430C 8521 0918 C710"
	$"850C 8418 C714 A610 8510 8508 4204 4108"
	$"4208 4208 41FE 0842 1804 2108 4208 220C"
	$"430C 6304 2108 2108 4208 210C 630C 6308"
	$"6318 C710 8508 2208 430C 6310 8318 A510"
	$"6204 2010 8425 2918 E718 C7FC 18C6 FE14"
	$"A501 10A4 10A5 FA10 8401 1083 1084 FC0C"
	$"630A 0C62 0C62 0C63 1063 0842 0842 0862"
	$"0862 0842 0841 0842 FD08 4100 0421 01DF"
	$"025E F95E F85E F8FE 5EF7 0D5A D85E F85E"
	$"F85A D85A D75E F85E F85A D85E F85A D85A"
	$"D85E F85A D85A D7F8 5AD8 025A D75A D75A"
	$"D8FE 5AD7 0556 D75A D75A D756 D756 D75A"
	$"D7FA 56D7 035A D756 D756 B756 B6FD 56D7"
	$"0756 B656 B756 B656 B756 B756 B652 B656"
	$"B6FD 56B7 0056 B6F7 52B6 0056 B6FE 52B6"
	$"0452 9652 9652 B652 9652 B6FB 5296 0152"
	$"9552 B6FD 5295 0152 B652 B6FD 5295 024E"
	$"9552 9552 96FE 5295 FE4E 9500 5295 FE4E"
	$"9503 5295 5295 4E95 4E95 FC52 9502 4E95"
	$"4E95 4E75 FE4E 9501 4E74 4E74 FD4E 7502"
	$"4E74 4A74 4A74 FB4E 74FD 4A74 014A 544A"
	$"54FE 4A74 024A 544A 744A 74FD 4A54 0146"
	$"544A 54F9 4654 0046 53FD 4654 0146 5346"
	$"53FD 4633 0242 3242 3246 53FB 4233 FE42"
	$"3213 4653 4674 2D6C 1CE8 1085 1D09 39EF"
	$"52B5 18C7 0001 0C63 1063 0C62 0C41 0420"
	$"0400 0821 20E7 0C63 0821 FE0C 421C 0C62"
	$"18C5 1CC6 1486 1085 0864 4211 4A74 2D6C"
	$"1CE7 2529 0842 0843 1085 1486 1085 0C64"
	$"1085 1085 0C64 1085 14A6 1085 10A5 1085"
	$"1084 0843 0842 0C42 FD08 421E 0843 0843"
	$"0C43 0C64 0C63 1064 0C43 0C63 1084 0842"
	$"1084 0863 0C63 294A 18C6 0421 0C63 18C6"
	$"18C6 14A5 0842 0C42 1083 14A4 0C63 1084"
	$"1063 1083 1063 1062 1083 FC0C 6212 0841"
	$"0420 0C42 0C62 0C62 0C42 0C63 0842 0842"
	$"0C62 0862 0842 0C62 0842 0C42 0842 0C42"
	$"0C42 0C62 FE08 4201 0C42 0841 FB08 4201"
	$"DD08 5EF9 5EF9 5EF8 5EF7 5ED7 5EF7 5ED8"
	$"5ED8 5EF8 FE5A D805 5EF8 5AD8 5AD8 5AD7"
	$"5AD8 5AD8 FB5A D704 56D7 5AD7 5AD7 56D7"
	$"56D7 FE5A D70B 56D7 5AD7 5AD7 56D7 56D7"
	$"5AD7 5AD7 56D7 56B7 56D7 56D7 56B7 FD56"
	$"D706 56B7 56D7 56D7 56B6 56B6 56B7 56D7"
	$"FD56 B602 52B6 56B6 56B6 F552 B600 5296"
	$"FA52 B601 5296 4E96 FD52 B6FE 5296 0C52"
	$"B652 B652 9652 9552 954E 9552 9552 9652"
	$"9652 9552 B652 954E 95FC 5295 024E 9552"
	$"9552 95FB 4E95 0352 954E 9552 9552 95F9"
	$"4E95 074E 754E 954E 954E 744A 744A 744E"
	$"744E 75FE 4A74 FE4E 74F9 4A74 FC4A 5403"
	$"4654 4654 4A74 4A74 FD4A 5402 4653 4A54"
	$"4653 FC46 5408 4653 4654 4654 4653 4653"
	$"4654 4654 4633 4653 FE46 3304 4653 4232"
	$"4232 4252 4232 FA42 3332 4653 35D0 35CF"
	$"10A5 0422 18E7 14C6 1D08 2D8C 0863 0422"
	$"0C63 0C63 0841 1083 0821 0000 0841 18C6"
	$"0842 0842 0C62 0C42 0841 1084 2108 1CE7"
	$"18C6 14A6 14C7 2D8D 212A 14C6 31AC 296A"
	$"0842 0C84 0C64 0C84 1085 1085 0C84 0863"
	$"1085 14A5 1085 0C64 14A5 10A5 0C84 0843"
	$"FB08 4208 0843 0842 0C63 1084 0842 0863"
	$"14C6 294A 318B FE0C 630F 1084 1D08 14C5"
	$"1084 14A5 1CE7 1CE6 1083 0421 0C62 0842"
	$"0C83 1084 1084 1083 1484 FE10 83FE 1062"
	$"0710 830C 6208 4104 2008 410C 620C 6208"
	$"42FE 0C62 0008 42FE 0C62 FB08 4203 0C42"
	$"0842 0842 0C42 FC08 4201 0C42 0842 01D6"
	$"075E F95E F85E F85E F75A D75E F85E F85E"
	$"D8FE 5AD8 055A D75A D85A D85A D75A D75A"
	$"D8F6 5AD7 0556 D75A D75A D756 D75A D75A"
	$"D7FD 56D7 075A D756 D75A D75A D756 D756"
	$"B756 D756 D6FC 56B6 0156 D756 D7FD 56B6"
	$"FD52 B600 56B6 ED52 B605 5296 4E96 52B6"
	$"5296 52B6 52B6 FE52 9601 52B6 5296 FD52"
	$"9500 52B6 FC52 9505 4E95 4E95 5295 4E95"
	$"4E95 5295 FA4E 9500 5295 F54E 95FD 4E75"
	$"084E 744A 744A 744E 754E 754E 744E 744A"
	$"744E 74F5 4A74 034A 544A 744A 5446 54FE"
	$"4A54 FE46 5409 4653 4653 4654 4653 4654"
	$"4654 4653 4654 4653 4653 FE46 5403 4653"
	$"4633 4633 4653 FD46 3300 4653 FD42 325E"
	$"4233 4233 4653 4633 4232 4633 4232 318E"
	$"14A6 10A6 0C65 10A6 1D0A 18E9 10A7 1086"
	$"0843 0844 0C63 0C43 0842 1CC7 0C64 0000"
	$"0421 1084 0C63 0842 0C63 0843 0842 14A5"
	$"2108 2108 1CE8 18E8 14C6 1D08 10A5 2129"
	$"35CE 18E6 0863 0C84 0C63 0C84 1084 0C84"
	$"0C83 10A4 14A5 14A5 0C63 0C63 1084 0C84"
	$"0C63 0863 0C63 0C64 0C63 0863 0C63 0C63"
	$"0842 0421 0C63 10A4 0441 0863 2D8B 4231"
	$"4A73 18C6 0421 0862 0C84 18C6 14A5 14A5"
	$"10A4 14C5 18E6 0C62 0842 0842 0841 1083"
	$"10A4 14A4 1083 14A4 1083 1083 1483 FE10"
	$"8306 0C63 0C63 0C62 0421 0842 1083 0C62"
	$"FE0C 6300 0C83 FD0C 6300 0C62 FC0C 630A"
	$"0862 0862 0C63 0C62 0842 0C62 0842 0C62"
	$"0842 0C62 0842 01C4 025E F95E F85A D7FE"
	$"5EF7 015A D85E D8FE 5AD8 FC5A D700 5AD8"
	$"EF5A D7FC 56D7 005A D7FE 56D7 0156 D656"
	$"D6FB 56B6 0056 D7FE 56B6 0152 B656 B6F4"
	$"52B6 0056 B6FA 52B6 0052 96FE 52B6 0452"
	$"9652 B64E 9552 964E 96FC 5296 0F52 9552"
	$"954E 9552 9552 954E 954E 9552 954E 9552"
	$"954E 9552 9552 954E 954E 9552 95FE 4E95"
	$"FA52 9500 4E74 FE4E 950F 5295 4E74 4E74"
	$"4E75 4E95 4E95 4E75 4E74 4E75 4A74 4E74"
	$"4A74 4A74 4E74 4A74 4E74 F84A 7402 4A54"
	$"4E74 4E74 FE4A 7406 4A54 4A74 4A54 4654"
	$"4A74 4A74 4A54 FE46 54FD 4653 0346 5446"
	$"5346 5446 54FC 4653 FD46 3304 4233 4633"
	$"4654 4212 39F0 FE42 320F 4233 4232 4654"
	$"4632 252B 2D8D 3DF1 250A 18A7 20E8 1485"
	$"1085 14A6 2109 18C7 10A5 FC10 8427 1064"
	$"1CE8 14A5 0000 0000 0C63 1D07 0842 0442"
	$"0863 0C84 14C6 18E8 1CE8 18E8 1D09 1086"
	$"10A6 10A6 296C 2529 0863 0842 0C84 18E7"
	$"0C63 1084 0842 0C62 1083 0C82 1083 0841"
	$"0C63 2107 18C6 0842 0C64 1085 14C6 FE10"
	$"841D 0C83 0842 0420 1084 10A5 0442 0442"
	$"18E7 14E7 2109 0C64 0421 0442 1084 14A5"
	$"0C63 14A5 1084 0C63 18C5 0841 1083 0842"
	$"0841 0C62 1083 14A4 1083 14A4 1484 FE10"
	$"8309 1062 1083 0C63 1083 0842 0420 0C62"
	$"1083 0C62 1083 F70C 6305 0C62 0C63 0C63"
	$"0C62 0C63 0C63 FE0C 62FC 0842 01AF 075E"
	$"F95E F85A D85A D75A F75A F75A D75A D8F3"
	$"5AD7 005A D8F1 5AD7 0356 B756 D756 D756"
	$"B7FE 56D7 0356 B756 D756 B756 B7F9 56B6"
	$"0052 B6FE 56B6 F852 B601 5296 52B6 FB52"
	$"9602 5295 5296 5296 FC52 9500 52B6 F352"
	$"9500 4E95 FE52 9502 4E95 4E95 5295 FE4E"
	$"9500 4E75 FB4E 9512 4E94 4E74 4E75 4E74"
	$"4E95 4E75 4E74 4E74 4E95 4E75 4E74 4E75"
	$"4A74 4E95 4654 35F1 4A95 4E75 4A75 F94A"
	$"7401 4A54 4A74 F94A 5401 4A74 4653 FE46"
	$"5403 4653 4A54 4654 4A54 F646 53FC 4633"
	$"4246 5446 5346 5429 4B1D 0946 5431 AE46"
	$"5446 5346 534A 531C E804 221C C725 0918"
	$"C61C C71C C618 A51C C618 A518 C614 A514"
	$"A614 A614 A510 8518 C61C E614 C518 E618"
	$"C600 0100 000C 4225 2A0C 6308 4214 C61C"
	$"E818 E718 C618 C718 A71C C810 8508 4210"
	$"851C C714 8408 4204 2214 A525 2914 A61C"
	$"E708 430C 6310 840C 830C 6308 4214 A431"
	$"8C2D 6A10 8410 83FE 1084 0B10 8310 830C"
	$"6208 4208 410C 620C 6308 4208 4104 4108"
	$"4108 41FE 0842 080C 630C 630C 8310 A40C"
	$"830C 6318 C508 210C 62FE 0841 0710 830C"
	$"6214 8418 C514 A414 A410 8310 84FE 1083"
	$"1110 8408 4104 2010 830C 830C 6310 840C"
	$"830C 830C 840C 630C 830C 630C 630C 830C"
	$"630C 630C 83F6 0C63 0108 420C 6301 C302"
	$"5ED8 5EF8 5AD8 FE5A D700 5EF8 E75A D701"
	$"56B7 56B7 FC5A D705 56D7 56D7 56B7 56B7"
	$"56D7 56B7 FD56 B600 56D7 FD56 B601 56B7"
	$"56B6 FE52 B600 56B6 F752 B600 5296 FD52"
	$"B603 4E96 4E96 5296 4E96 FE52 9500 5296"
	$"F452 9503 4E95 5295 5295 4E95 FE52 95F9"
	$"4E95 074E 754E 754E 954E 744E 954E 954A"
	$"744E 94FE 4E74 004E 95FC 4E74 074A 744E"
	$"754A 7456 D72D 8E18 E85A F94E 75FB 4A74"
	$"034A 544A 744A 744A 54F8 4654 0346 5346"
	$"5346 5446 54FC 4653 0146 3346 33F9 4653"
	$"5642 3346 3346 5346 3346 3346 5346 5335"
	$"CF21 0A10 8514 A725 4B21 2A4E 9546 5352"
	$"9621 2A08 2214 A618 C614 A514 A514 8514"
	$"8414 A514 A510 6410 8410 640C 6414 A510"
	$"8508 4210 8410 A40C 8314 C618 E70C 6400"
	$"0104 201C E70C 6414 A518 E721 0814 C608"
	$"430C 6410 840C 8410 A410 8408 630C 8414"
	$"A510 8408 4314 A625 2A21 0920 E820 E821"
	$"0914 A508 620C 8308 6214 C525 4921 080C"
	$"8308 620C 6208 610C 6208 4108 6208 4208"
	$"4204 4108 420C 6208 4208 4108 4108 42FE"
	$"0841 0908 4208 620C 8310 A310 830C 8214"
	$"A414 A408 4110 83FE 0841 0710 830C 6214"
	$"A418 C50C 6314 8414 8414 A4FE 1083 1710"
	$"840C 4204 2010 8310 8410 8514 A510 8410"
	$"A510 8510 A510 8510 850C 8410 8510 8510"
	$"8410 8510 8410 8510 8510 840C 8410 84FA"
	$"0C84 01B6 025E F95E F85E F8FE 5AD7 005E"
	$"F7F5 5AD7 005A D8F0 5AD7 0D56 B75A D75A"
	$"B756 B756 D756 B756 B656 B756 B756 B656"
	$"B652 B656 B656 D6FD 56B6 0252 B656 B656"
	$"B6F6 52B6 0652 9652 B652 964E 964E 9652"
	$"B652 B6FE 4E96 0452 9652 9652 9552 9652"
	$"B6FD 5295 044E 9552 954E 954E 9552 95FD"
	$"4E95 FE52 9501 4E95 5295 FB4E 9503 4E74"
	$"4E95 4E95 4E74 FE4E 7501 4E74 4E95 FB4E"
	$"74F9 4A74 044A 5456 D829 6C18 C863 1AF8"
	$"4A74 F546 5400 4A54 FE46 5304 4A53 4653"
	$"4A53 4653 4633 FB46 5347 4232 4653 4633"
	$"4233 4633 4232 4233 4A74 4633 254B 0C85"
	$"1085 1085 10A6 0C85 254B 31AE 4653 4E74"
	$"0C64 14A5 14A5 1084 0843 0C63 1084 14A5"
	$"14A5 14A6 0C63 0C64 1084 0C63 18C6 14A4"
	$"0842 0C63 0C83 0C83 18C7 14A7 0C65 0421"
	$"0000 0C62 1084 14A4 10A4 18C6 1084 0842"
	$"0C63 0C62 0862 10A4 14A5 0C63 10A5 10A5"
	$"14A5 1085 18C6 1CE8 18C7 18C7 2109 18C6"
	$"1084 0C83 0C62 0862 1083 FE0C 8301 0862"
	$"0861 FA08 4101 0842 0842 FE08 4100 0441"
	$"FE08 411E 0C83 1083 10A3 1082 0C81 0C61"
	$"14A3 1083 0420 1083 0C62 0841 0841 1083"
	$"0C62 1484 14A4 0841 0C62 14A4 14A4 1084"
	$"1083 1063 1083 0C62 0420 1083 1084 18C6"
	$"10A5 FB10 8501 0C84 0C85 FD0C 84FD 0C64"
	$"0214 C608 840C 84FC 0C85 01B6 015E F95E"
	$"F8E7 5AD7 FD56 B70A 5AD7 5AD7 56B7 56B7"
	$"5AD7 5AD7 56B7 56B7 56B6 56D7 56D7 FA56"
	$"B600 56D6 FD56 B6F7 52B6 0552 9652 B652"
	$"B652 9652 9552 B6FA 5296 0152 9552 96FA"
	$"5295 F74E 9500 5295 FA4E 95FE 4E75 034E"
	$"954E 754E 744E 95FE 4E75 014E 744E 75FE"
	$"4E74 024A 744A 744E 74F8 4A74 0356 D825"
	$"4B18 E963 3AFA 4A74 004A 53FE 4A54 0046"
	$"53FD 4A54 FE46 5302 4654 4653 4654 F846"
	$"5333 4632 4653 4633 4633 4653 4232 4653"
	$"4633 4654 4232 2D8E 4A74 3E11 252A 0C84"
	$"1085 10A5 14A5 1084 10A5 2D6C 18C7 254A"
	$"252A 1084 18E6 14A5 1084 0C63 0C63 0C84"
	$"10A5 10A5 14A6 0C84 0C84 0C83 1084 14A5"
	$"1084 0C63 1083 0C63 0862 18C6 18C7 1085"
	$"0842 0420 0841 0C62 0C83 FE0C 63FE 0C83"
	$"FE10 8315 0C63 1083 14A4 1084 0C63 14A5"
	$"2108 1CE8 1CE8 18C6 0C62 14A5 14A4 0C62"
	$"1083 0C83 1083 1083 1082 0C62 0841 0842"
	$"FE08 410E 0441 0C62 0C62 0842 0842 0841"
	$"0841 0842 0441 0841 0841 0C82 1083 10A3"
	$"14A3 FE0C 610C 14A3 1083 0420 0C62 1083"
	$"0841 0841 1083 0C62 0C62 1083 0842 0841"
	$"FE14 A410 1083 1483 1483 1083 0000 0C83"
	$"10A4 1CE8 0864 0863 0C64 0843 0863 1085"
	$"0C85 1085 0C85 FD10 850B 0443 0442 0843"
	$"0843 18E8 0C85 0864 0C85 0C85 0C65 0C85"
	$"0865 01C1 015E D85A D8ED 5AD7 0356 B656"
	$"B65A D756 B6FE 5AD7 0356 B656 B65A D75A"
	$"D7FE 56B7 0156 B656 B7EF 56B6 0252 B652"
	$"B556 B6FE 52B6 0252 B552 B556 B6FE 52B6"
	$"0352 9652 9552 9652 96F0 5295 FC4E 9504"
	$"4E75 4E75 5295 5295 4E75 FE4E 95FE 4E75"
	$"014E 744E 95FA 4E74 FD4A 7403 4E74 4A54"
	$"4E74 4E74 F74A 7411 56F8 212A 18E9 5EF9"
	$"4A74 4A74 4A53 4A53 4A74 4A54 4653 4653"
	$"4A53 4A53 4653 4653 4A53 4653 FA4A 530E"
	$"4653 4653 4632 4232 4654 3DF1 31AF 4654"
	$"4653 296D 35D0 3DF1 39F0 4633 4653 FD35"
	$"CF07 294C 18E9 2D6C 18C7 0C64 10A5 14A5"
	$"1084 FE14 A501 1CC6 1085 FD10 8402 0C63"
	$"1083 1084 FE10 8302 1084 1084 1083 FD10"
	$"841F 14A5 14A5 0842 0841 0C63 18C6 18C7"
	$"0C64 0421 0820 0C21 0C42 0C63 0863 0862"
	$"0862 0C63 0C42 0C63 0C63 1084 0C42 0C63"
	$"0C63 1084 0C63 0842 1084 2D6B 2109 2108"
	$"14A5 FC10 8306 14A4 1083 1083 0C82 0C62"
	$"0841 0C42 FD08 41FE 0C62 2B08 4108 4104"
	$"2108 4108 4208 4108 4114 C410 8310 A210"
	$"8208 6108 6108 4118 C40C 6208 2108 4110"
	$"8308 210C 4210 8310 830C 4108 410C 6208"
	$"410C 6210 6210 8310 6214 841C E714 A500"
	$"000C 6410 A51C E80C 640C 6410 840C 6308"
	$"430C 84FD 0C64 0E08 630C 6408 6304 2204"
	$"2204 4208 4318 E80C A608 640C 850C 8508"
	$"650C 8608 6501 CA01 5AD8 5AD8 FE5A D700"
	$"5AD6 F95A D701 56D7 56B7 FC5A D7FA 56B6"
	$"005A D7FE 56B6 FD56 B702 56B6 56B7 56B7"
	$"F956 B600 52B6 F956 B6FE 52B5 0052 B6FE"
	$"52B5 FC52 9500 5296 F252 9501 4E95 5295"
	$"F74E 9501 4E75 4E95 FE4E 7404 4E75 4E74"
	$"4E95 4E75 4E75 FE4E 7400 4E75 FD4E 7406"
	$"4A74 4E95 4A74 4A74 4E74 4A74 4E74 FA4A"
	$"7410 4A54 4A54 4A74 4653 56D8 212A 1D09"
	$"5AF9 4653 4A74 4A53 4A53 4A74 4A53 4653"
	$"4A74 4A53 FB46 531C 3E11 4211 4653 35CF"
	$"4232 4E74 3E11 4211 2D8D 2D8D 39CF 254B"
	$"1D09 31AE 318D 1D09 254B 294B 296C 35CE"
	$"2D8C 14A6 14C6 14A5 14A5 10A5 18E7 14A6"
	$"10A5 FD14 A501 14A4 18A5 FB14 A401 1084"
	$"1083 FD10 8414 1083 1083 0C63 0C63 1083"
	$"0C63 0C63 0842 1084 1CE7 0400 0841 10A4"
	$"18E6 18C7 0843 0842 0841 0801 0842 0C62"
	$"FE08 6201 0842 0842 FE0C 6312 0842 1084"
	$"1084 10A4 1084 0842 1084 294A 1CE8 1CE8"
	$"14A5 0862 0862 0C61 10A3 14A3 1083 1082"
	$"1082 FE0C 6200 0842 FE08 4101 0C42 0842"
	$"FE0C 6201 0C42 0420 FE08 4128 0C62 18C5"
	$"14A4 0C82 0840 0861 0C82 0841 14A4 0842"
	$"0821 0842 1483 0841 0C62 1083 1062 0821"
	$"1062 0C62 0841 0C62 0C62 1063 0C62 18C6"
	$"2108 14A5 0000 0C64 10A5 1CE8 1085 0C63"
	$"1084 0C63 0843 0442 0842 0422 0842 FD04"
	$"2205 0442 0843 0422 0843 18E8 0C86 FB08"
	$"6501 F301 5AD8 5AD8 F85A D7FD 56D7 0056"
	$"B7FE 5AD7 0056 B7FE 56B6 005A D7F3 56B6"
	$"0056 B7F9 56B6 0152 B652 96FB 56B6 0252"
	$"B552 B656 B6FB 5295 FD4E 9508 5295 5295"
	$"4E95 4E95 5295 4E95 5295 5295 4E95 FC52"
	$"95FD 4E95 004E 74FA 4E95 FE4E 7401 4E95"
	$"4E95 FE4A 7405 4E75 4E74 4A74 4E95 4A74"
	$"4A53 FD4A 7400 4653 FB4A 7419 4653 4653"
	$"4232 4E95 4653 39F0 3E12 3E12 39F0 35CF"
	$"35CF 39F0 31CF 4E96 1D09 210A 5AD8 4A74"
	$"3E11 39CF 4211 3E11 39F0 39F0 3DF0 3DF0"
	$"FE39 F00C 35CF 318D 31AE 254B 2D8D 2D8D"
	$"1D09 31AE 35CF 254B 318E 252A 252A FE21"
	$"0919 1D09 252A 212A 2109 252A 294B 2108"
	$"1085 1084 10A4 1084 1084 10A5 18E7 1084"
	$"10A4 1084 0C84 1084 1084 0C63 0C63 1083"
	$"0C83 0C62 0C62 FD0C 631A 0C62 0842 0842"
	$"0862 0842 0C62 0842 0842 0C63 0842 0C63"
	$"0842 1084 2109 0421 1083 14C5 18E6 18C7"
	$"0C64 1084 1483 0821 0421 0842 14A5 10A4"
	$"FD10 8417 10A5 1085 14A5 14A5 14A6 14C6"
	$"0863 0C83 14A5 252A 1CE8 2108 1084 0441"
	$"0C83 1082 14A3 10A3 0C61 0C82 1083 0C82"
	$"0C82 1082 FE0C 6206 0841 0842 0842 0C62"
	$"0862 0C62 0C63 FD08 4127 0C42 18C4 14A4"
	$"0861 0840 0861 0861 0841 14A4 0842 0420"
	$"0C62 14A4 0420 0C41 1062 1062 0841 14A4"
	$"0C62 0841 1062 0C62 1083 0C62 2108 1CE7"
	$"14A5 0000 0C63 1084 1D08 1085 0843 0C64"
	$"0863 0843 0422 0842 0441 FC04 420B 0842"
	$"0442 0442 0843 18E8 0C85 0865 0865 0C85"
	$"0865 0444 0864 0206 015A D85A D8FE 5AD7"
	$"065A D65A D756 B75A D756 B756 D756 D7FE"
	$"56B7 0256 D756 D75A B6E4 56B6 0052 B6FE"
	$"56B6 0652 9556 B556 B652 B552 B552 B652"
	$"B5F6 5295 0052 96FD 5295 FB4E 9507 5295"
	$"4E95 4E95 4E94 4E95 5295 4A74 4A75 FD4E"
	$"9535 4A74 4E95 4A74 4E95 4E95 4A74 4E95"
	$"4A53 4A74 4A74 4E74 4E95 4E95 4653 35CF"
	$"2D8D 35CF 35CF 39F0 31AE 298C 31AE 35CF"
	$"39F0 3E11 4232 39F0 256C 254B 296D 4233"
	$"296D 254B 2D6D 296D 296C 294C 254B 254C"
	$"254B 35CF 14C8 18E9 4212 39F0 296C 212A"
	$"318D 296C 254B 254B 294C 294B 294B FE25"
	$"4B00 212A FE25 4B0A 252B 252A 252B 212A"
	$"212A 254B 252A 20E9 1CE8 1CE8 1CE9 FE21"
	$"0905 1CE8 294B 294B 18C6 0C43 1084 FE0C"
	$"6309 14A6 18C7 0842 0863 0C64 1084 10A4"
	$"1084 1084 0C84 FC10 8400 1085 FE10 8418"
	$"0C84 1084 0C83 1084 14A4 1084 1085 14A5"
	$"1085 14A5 1084 1485 2509 1484 18C6 18C6"
	$"14C5 14C6 1085 14A4 14A4 0821 0400 0841"
	$"14A5 FE10 8419 0C83 0C84 0C64 0C64 10A5"
	$"0C84 10A5 18E7 0C63 0C83 1084 252A 1CE8"
	$"2109 1084 0862 10A3 1083 0C62 1083 1083"
	$"10A3 10A3 0841 1083 10A3 FE0C 6201 0842"
	$"0841 FE08 422F 0C62 0862 0C62 1083 18A5"
	$"0C63 0420 14A4 0C62 0840 0C61 0861 0020"
	$"1083 1083 0842 0420 0C62 1483 0820 0C62"
	$"1083 1062 0841 18A4 0C41 0C41 1063 1062"
	$"0C41 14A4 2929 1064 0842 0000 0C64 1084"
	$"1D08 0C84 0442 0C64 0C63 0843 0421 0842"
	$"0842 0841 0842 FD04 4205 0842 0442 0843"
	$"18E8 0C85 0864 FE0C 8501 0864 0864 0226"
	$"005E D8FD 5AD7 0C5A B65A D65A D75A D756"
	$"B65A D756 B65A D75A D756 B656 D65A D656"
	$"D6FB 56B6 005A D7FC 56B6 0156 B756 B7EF"
	$"56B6 0552 B652 B656 B652 B552 9552 B6FC"
	$"5296 0F52 9552 B64E 9552 9556 9652 9556"
	$"B652 943D F035 AE4A 5352 9446 3252 9556"
	$"B54E 94FE 4E95 FD52 950B 52B6 4E74 254B"
	$"31AE 56D6 52B6 4E94 4E95 4E94 4E94 4E74"
	$"4E95 FE4E 7429 4A74 4653 3A11 4232 4A74"
	$"3E11 2D8E 294C 294C 296C 296C 2D6D 212A"
	$"1CE9 1D09 212A 296C 2D6D 2D6C 2109 18E8"
	$"1D09 252A 294C 294B 2D6C 2D6C 294C 2D6C"
	$"294B 294B 254B 254B 296C 14C7 18E9 2D8D"
	$"254B 252B 294B 294B 254B FE25 4A05 252B"
	$"294B 294B 252B 254B 254B FD25 2A01 254A"
	$"2129 FE21 0900 2108 FD21 0918 20E9 2109"
	$"20E9 2109 292A 2109 18C6 1063 0C63 0C63"
	$"0C64 0C63 14A6 14C6 0843 0863 1084 18C7"
	$"0C64 14A5 14A5 1084 1084 1085 1085 FE10"
	$"8407 1064 1084 1063 1063 1083 0842 0C63"
	$"0C64 FC0C 6320 0842 0842 2529 1085 1084"
	$"14A5 14A5 14C7 0843 0C63 1083 0C62 0420"
	$"0420 0841 0C62 1083 0C62 0C42 0C43 0C43"
	$"0C63 1083 0862 0862 1CE7 0C84 0C63 1084"
	$"2109 1CE8 18C7 18C6 FE10 830B 0C83 0C83"
	$"1083 1083 0C82 0C61 1CE6 0C62 1062 1063"
	$"0C62 0C42 FE08 4230 0421 0842 0421 14C5"
	$"318C 4631 1084 0000 0C62 0841 0841 0861"
	$"0841 0420 14A5 0C62 0C42 0420 0C42 1483"
	$"0820 0C61 1062 1062 0840 1082 0C62 0841"
	$"1083 0C62 0C62 20E6 20E7 1063 0841 0420"
	$"0C63 10A5 1CE8 0C84 0422 0C64 0C63 0843"
	$"0422 0442 0842 0842 0843 FE08 420B 0442"
	$"0442 0422 0844 18C8 10A6 0C85 0C85 0885"
	$"0C85 0C85 0865 0238 005E D8FE 5AD7 0E5A"
	$"D65A D75A D65A D756 D656 B65A D656 B65A"
	$"D65A D656 D65A D65A D656 B656 D6FB 56B6"
	$"0E56 B756 B656 B756 B656 B752 954E 755A"
	$"D75A D74E 7446 3256 D656 B656 B652 B5F8"
	$"56B6 3652 B652 B552 9552 9552 B552 B552"
	$"9552 9552 B656 B642 324E 7556 B63E 1121"
	$"2A42 115A D75E F84A 7321 2A1D 0821 0929"
	$"4B31 8C25 2946 315E F752 B552 9452 9452"
	$"954E 953E 1142 3242 323D F12D 8D14 C721"
	$"2A56 B556 D64E 9452 954E 744A 534E 944E"
	$"944E 744E 954E 744E 7531 AE21 2A2D 8D31"
	$"AEFD 296C 0B29 4C29 6C29 6C21 2A1D 0921"
	$"0921 0921 2A29 4B21 2A1D 091D 09FE 2109"
	$"0C25 2B29 4B2D 6C29 4B29 4B25 4A21 2A21"
	$"2A25 4B29 4C18 C71C E92D 6CF9 252A 0029"
	$"2AFB 252A 0121 2921 09FE 252A 0129 4A25"
	$"29FD 2109 0221 081C E81C E7FE 2108 0F25"
	$"2921 0818 C60C 620C 620C 630C 6308 6314"
	$"A618 C708 6308 430C 8418 C608 420C 63FD"
	$"0C62 060C 6308 4208 420C 6208 420C 6208"
	$"41FC 0C62 0208 4108 410C 62FE 0842 6E0C"
	$"6329 4A14 8410 A414 A414 C514 C60C 640C"
	$"8310 8210 830C 6208 4104 2010 8310 8308"
	$"4110 830C 630C 6214 A410 830C 610C 621C"
	$"E60C 820C 8314 A521 0818 C718 C61C E70C"
	$"6310 8310 8310 820C 6210 8210 820C 6210"
	$"8214 A40C 4210 8310 8310 630C 6208 4208"
	$"4108 420C 4208 4200 2018 E73D EF52 9414"
	$"8500 0004 210C 6208 6208 4104 4108 4214"
	$"A408 4208 4108 410C 6214 8404 200C 4110"
	$"6210 6208 4010 820C 6208 4110 620C 4108"
	$"410C 4214 8410 630C 6200 0008 6210 A518"
	$"E710 8504 2210 850C 6408 4204 2208 4208"
	$"4204 2204 4104 4104 4200 2104 4204 4204"
	$"2208 4314 C710 8608 6408 8404 64FE 0864"
	$"023F 005E D8FC 5AD7 015A D65A D7FE 5AD6"
	$"075A D756 D656 D65A D65A D656 B65A D65A"
	$"D7FD 56B6 1156 D65A D756 B756 B656 B75A"
	$"D75E F82D 6C35 AF63 1963 1946 3239 CF5A"
	$"F856 D64E 7456 B65A D7FA 56B6 0752 B552"
	$"9556 B552 B552 B556 B546 3146 31FE 4E95"
	$"092D 8C42 3242 1121 2A10 A62D 6B5A D75A"
	$"F71D 0810 A6FE 2109 2725 2921 0829 4B52"
	$"944E 9446 3246 324E 7439 F018 E825 4B25"
	$"4B25 2A25 2A21 2A1C E846 525F 184A 734E"
	$"942D 8C46 5256 B64E 744A 744A 533E 113D"
	$"F025 2A25 2A2D 6C29 6C29 6B29 6C29 4B29"
	$"6B29 6C29 6C29 4C21 2AFD 2109 0021 2AFB"
	$"2109 0C25 2A25 2A29 4B25 2A29 4B25 2A21"
	$"0921 2925 2A25 4B14 A61C E82D 6CFA 252A"
	$"0929 4A25 2A25 2925 0925 2A25 2A25 2921"
	$"2921 0821 08FD 2109 FE1C E8FE 1CE7 0118"
	$"C61C E7FE 2108 0225 0821 0818 C6FE 0C62"
	$"4408 6208 4214 A618 C604 4208 630C 6418"
	$"C608 4310 840C 630C 630C 620C 620C 630C"
	$"6308 420C 630C 6308 4214 A421 070C 620C"
	$"6210 6310 830C 630C 6210 830C 8310 8310"
	$"8318 C625 2914 A414 A410 A314 A410 A50C"
	$"6410 8410 830C 620C 6208 4104 200C 6204"
	$"4114 A410 830C 8310 8321 0714 A410 A410"
	$"8318 E514 A314 A418 E618 E614 A61C E71C"
	$"E70C 6210 8310 A20C 8210 82FE 0C61 070C"
	$"6214 A418 C50C 4210 8310 830C 6208 41FE"
	$"0C62 3E08 4100 0014 A639 CF4A 5218 C600"
	$"0008 210C 6208 4108 4204 410C 6214 A408"
	$"4108 4208 4110 6314 A404 200C 4114 8310"
	$"6208 4014 8310 6208 410C 610C 4108 200C"
	$"4120 C60C 4110 6304 210C 6310 A418 E70C"
	$"8504 4210 8408 6308 4204 2208 4208 4204"
	$"2104 4104 2108 4404 2408 4408 2404 2208"
	$"4314 C70C A508 6408 8404 6404 6408 640C"
	$"8502 5000 5ED8 FA5A D700 56D6 FE5A D601"
	$"56D6 56D6 FE5A D619 5AD7 4E74 4A53 5AD6"
	$"56B6 56D6 5AD7 56B6 3DF1 4A53 6319 4E74"
	$"3DF0 18C7 294B 5AB7 56B6 2D6C 252A 4A74"
	$"4A53 296B 4231 4A53 4632 4A53 FE56 B60F"
	$"5275 5295 56B6 52B5 4E94 52B5 5AD7 4A53"
	$"2109 296B 3E10 39F0 2D8C 2109 254A 212A"
	$"FE21 0910 39CE 39EF 18C7 2109 210A 2109"
	$"210A 2509 2109 210A 318D 318D 296C 296C"
	$"2D6D 294C 210A FC25 2A14 212A 35AE 4231"
	$"318D 318D 18E8 3DF0 4211 39F0 318D 318D"
	$"2D6C 294B 252A 252A 294B 294C 294B 294B"
	$"254A 254A FE29 4BFD 2109 0021 29FA 2109"
	$"0025 29FE 252A 0C29 4B25 2925 2929 2A25"
	$"2A25 4B14 A618 C725 4B21 0925 2921 0921"
	$"09FE 2529 2B21 0821 0821 0921 0821 0821"
	$"0921 0821 081C E81C E71C E81C E718 C718"
	$"E71C E81C E818 C818 C71C E81C E818 C721"
	$"0821 0820 E71C E721 0825 2921 0810 8410"
	$"840C 830C 840C 6314 C614 C60C 6314 A50C"
	$"630C 6418 C618 C610 8410 8510 85FE 14A5"
	$"7D10 8410 A514 A614 A51C C714 A50C 631C"
	$"E710 8414 A518 C714 A618 C618 C614 A518"
	$"C61C E718 C618 C514 A414 C414 A510 8410"
	$"A514 A514 A510 8314 A414 8304 2008 200C"
	$"621C E618 C510 842D 6B29 4A21 081C E818"
	$"C621 0718 C518 E518 E614 C518 C61C E71C"
	$"E710 8410 830C 820C 6110 820C 8210 A310"
	$"A314 A31C E610 6308 4118 C50C 620C 6210"
	$"8310 A30C 820C 610C 6210 840C 633D F042"
	$"1018 C604 2010 6210 630C 6210 830C 6210"
	$"8310 8308 4114 A410 8410 6314 8304 200C"
	$"4114 8310 820C 4114 8210 6208 2010 620C"
	$"4108 2010 6218 A40C 410C 6204 2008 6210"
	$"A518 E80C 8508 420C 640C 6304 4204 2204"
	$"2208 4204 2200 2200 2319 0B1D 2E0C AA08"
	$"6804 4608 6614 C808 8608 8508 85FE 0865"
	$"0010 A702 5A0B 5ED8 5ED8 5AD7 5ED7 5AD7"
	$"5EF7 4E74 3DF0 56B6 5EF8 5AB7 5AB7 FD5A"
	$"D732 6318 4A53 2109 2D6C 4211 4211 5AD7"
	$"6319 318D 2109 3DF0 56B6 252A 1CE9 252A"
	$"294B 3DF0 318D 2109 2109 318D 2D6C 1CE9"
	$"294B 294B 252A 318D 3DF0 4211 4632 35AF"
	$"35AF 4211 4212 35AE 4211 4232 318D 2109"
	$"252A 35AF 318D 1CE8 2109 2109 252A 252A"
	$"2109 2109 252A 294C FB25 2A00 250A FD25"
	$"2A02 294B 292B 252A FE29 2BFE 252A 0929"
	$"2A29 2B29 4B25 4B21 2A25 4A29 4B29 4A2D"
	$"6C25 2AFE 294B 0725 2A21 0925 2A29 4B29"
	$"4B25 2A25 2A25 2BFE 294B 2025 2A25 0A21"
	$"0A25 0A25 2A25 2A25 2925 2A25 2A29 2A29"
	$"4B29 2A29 4B29 2A29 4B29 2A2D 4B2D 6C29"
	$"4B25 2A25 2A21 0914 C714 C721 2A29 2A25"
	$"2A21 0921 0925 0921 0921 0925 09FE 2109"
	$"0821 0825 2921 0821 081C E829 2B29 4B21"
	$"081C E7FD 1CE8 0120 E920 E8FE 2108 6221"
	$"0721 080C 621C C725 091C E718 C61C E618"
	$"C618 C610 A518 C71C E81C C714 8510 6310"
	$"6439 CE1C E71C E81C E718 C718 E71C E71C"
	$"E618 E618 E618 C618 C614 A529 4B1C E71C"
	$"E70C 6210 841D 0818 C618 C614 A404 2014"
	$"A518 E618 C51C C618 C61C E614 C60C 8414"
	$"A618 E621 0814 A41C C51C C510 8300 000C"
	$"6221 0725 2814 A531 8C29 2A20 E81C C71C"
	$"E71C E61C E614 C60C 841C E81D 0918 E718"
	$"C614 A418 C514 A418 C518 C414 C414 C410"
	$"A314 A41C E50C 6208 4210 8308 421D 0721"
	$"0710 830C 620C 6210 8435 AD0C 6235 AC42"
	$"100C 630C 42FE 14A4 1F18 A414 8318 C40C"
	$"6210 8331 8C18 A518 A510 4208 200C 4114"
	$"6214 830C 620C 6210 6308 2110 620C 420C"
	$"620C 6220 C629 0829 2804 2008 4110 A418"
	$"E80C 850C 6310 6310 63FD 0C62 1008 6204"
	$"4208 8625 9125 B41D 7315 3215 1014 EF0C"
	$"6A04 2608 6608 6408 6508 6408 6410 8502"
	$"4527 5AD8 671A 56B6 5295 56B5 4E73 318D"
	$"2109 5295 673A 5294 5294 5295 5295 4E73"
	$"4E74 4A53 252A 2109 252A 294B 2D6C 4632"
	$"4211 1CE9 252B 318D 318D 2109 252A 252B"
	$"2D6C 35AE 252A 252A 252B 252B 294B 252A"
	$"252B FE25 2A0F 294B 294C 2D6C 252B 292B"
	$"2D4C 2D6C 252B 294B 254B 254B 252B 294B"
	$"296C 294B 2109 FD25 2B02 252A 2D6C 2529"
	$"FE25 2A02 2529 252A 2529 F825 2A06 2D6C"
	$"2D6C 252A 294A 294A 252A 252A FE29 4B05"
	$"254B 254B 252A 294B 2D6C 292A FE29 4BFE"
	$"252A FB29 4B00 2D4C FE29 4B18 2D6C 252A"
	$"292A 294B 294B 2D6B 2D6B 2D6C 2D6C 2D6B"
	$"2D6B 294B 294A 294A 2D6B 316B 294A 2D6B"
	$"1CE7 0C63 18C7 1CE8 212A 2529 2529 FD21"
	$"081D 2509 2108 2529 2109 2529 2108 1CE6"
	$"1CE7 18C7 2509 2D6C 2929 2529 2128 2949"
	$"2528 1CE7 2528 2107 18C5 18E5 1CE6 18C5"
	$"18E6 39CE 1084 1084 1CE7 14A4 1083 FD14"
	$"A40A 14C6 2108 1084 14A5 294B 2109 318D"
	$"18E8 252A 18C6 18C6 FB14 C548 10A4 10A4"
	$"52B5 18E7 18C7 14A6 0843 14A5 18C5 14A4"
	$"18C5 1483 1CC5 1082 10A3 1D07 1CE6 10A4"
	$"0C84 0C84 14A6 18A6 18A5 1083 14A4 18C4"
	$"2507 0820 0C41 1CC5 1CC6 1063 318B 2D4A"
	$"18A5 18C6 2107 18C5 14A4 0C83 0842 1D09"
	$"2109 1D09 1CE8 1085 1085 1CE6 1CC5 1082"
	$"1083 1082 0861 0C62 14A4 1CC5 0420 0842"
	$"2D6A 296B 1CE7 0C63 1084 1084 14C5 35CD"
	$"1D07 4631 39CE 0C63 0842 0C63 1484 FE14"
	$"8309 1CC5 0C62 1484 2528 1062 1CC5 1062"
	$"0C41 0C41 1084 FE10 8325 0C62 0841 0C62"
	$"0C62 0841 18C5 398C 460F 3DEE 0000 0842"
	$"10A4 18C7 18C6 1083 1484 1483 1083 1083"
	$"0C62 1082 1082 0C62 0864 14E9 192E 29B4"
	$"1D72 1D52 10CE 0448 0025 0444 0843 0843"
	$"0842 0841 0C62 025A 1146 3346 3331 8D31"
	$"8D39 CF31 8C2D 6C29 4B3D F04A 5231 8C35"
	$"AD35 CE35 AD2D 6C2D 6C29 4B29 2AFD 294B"
	$"052D 6C2D 6C29 4B29 4B29 4C29 4CFE 294B"
	$"0229 4C29 4B25 2AFE 294B 0425 2A29 4B29"
	$"4B25 2B25 2AFE 294B 0B25 2B25 2B25 2A29"
	$"2B25 2B29 4B2D 6C25 4B25 4B25 2B25 4B29"
	$"4BFE 252A FE25 2B05 252A 294B 2109 2529"
	$"252A 252A FE25 29FC 252A 0921 2A21 0929"
	$"6B2D 8E3D F139 D018 C829 4C25 2B25 2BFE"
	$"294B 0825 4A29 4B25 4A25 2A29 4A29 4A25"
	$"292D 6B2D 6BFC 294B 002D 6CFE 318D 1E2D"
	$"6C31 8D31 8D31 8C35 8D35 AD2D 6C35 AD31"
	$"8D35 AE31 8D31 8C35 8D31 8C31 6C35 AD29"
	$"4A29 4929 4A31 8B31 6A2D 6A2D 6B18 C604"
	$"0118 C621 0829 4A29 4A2D 4A29 4AFE 2929"
	$"0829 4925 2925 2929 4921 0710 8408 4114"
	$"A510 84FE 1CE7 7F31 8C2D 6A29 4921 0718"
	$"C629 4918 E610 A410 8410 A40C 6335 AE52"
	$"9514 A718 C829 4C18 C710 A514 A514 A518"
	$"C618 C61C C614 A50C 4231 6B29 2A2D 4B1C"
	$"C818 C825 2A18 C614 A514 A414 A518 C618"
	$"C614 A514 C510 A514 C646 5314 A61C E810"
	$"8508 4318 C61C E610 8329 4931 8A21 0704"
	$"2008 4114 A50C 8308 6208 8310 A61C E818"
	$"C714 8414 8410 8314 A42D 6910 6204 2014"
	$"8414 8408 222D 6B2D 4B18 C721 0921 0808"
	$"420C 8314 C408 6221 281D 081C E821 0925"
	$"2925 293D CD14 8300 0010 820C 620C 6110"
	$"8218 A40C 6200 0025 283D EF0C 630C 8310"
	$"8414 A518 E618 E621 2825 2825 4921 080C"
	$"8410 8410 8410 8310 8314 8314 A414 A404"
	$"4114 A41D 0618 C414 A418 A514 A410 A414"
	$"C510 A325 4818 C513 0440 0C62 0C62 0841"
	$"0820 2D49 35AB 39CD 358C 14A5 0821 14A4"
	$"1CE7 1CE7 14A4 14A4 1083 1083 0C42 0820"
	$"FE08 410E 0441 0CA5 190A 258F 1D2E 1D2F"
	$"0449 108A 0866 0423 0443 0823 0843 0421"
	$"0841 025C 0E29 4C29 4C29 4B2D 4B2D 6C2D"
	$"6C31 6C2D 4B29 6C29 4B25 2A25 4B25 4B25"
	$"2A25 4BFE 294B 0629 2B29 2A29 2A29 2B29"
	$"4B29 2A25 2AF5 294B 0625 2B29 4B29 4B25"
	$"2B29 4B25 2B29 4BFD 252B 0729 2B29 4B21"
	$"0A2D 6C21 2A25 2A25 2A21 2AFD 252A 0925"
	$"2B25 4B25 2A25 2B21 0A25 2A25 2A29 2B29"
	$"2B25 2BFC 252A 7F29 4B25 2A25 4B21 2A29"
	$"6B29 6D29 6D29 6C21 2A29 4C29 4B2D 6C2D"
	$"6C2D 4C2D 6D31 8D29 6C10 8514 C618 C610"
	$"8521 093D EF31 8C31 8C31 8D31 8D25 2925"
	$"2931 8D35 AE35 AD31 8D31 8C31 8D2D 6C2D"
	$"6B2D 8B2D 6B2D 6A31 8C2D 6B29 4A20 E825"
	$"2931 6B2D 6B2D 6A31 6B29 282D 4A29 4931"
	$"8B2D 4A21 0825 294A 3208 4314 A61C E721"
	$"2921 0721 0721 0821 0721 071C E721 071C"
	$"E721 0821 0808 4214 A421 0818 C504 201C"
	$"E73D F014 A610 841C E714 A514 A518 C61C"
	$"E710 840C 8308 6208 620C 6342 3129 6C18"
	$"E821 0A25 4B10 A614 A518 C614 C614 A518"
	$"C61C E808 4208 4220 E825 292D 4B21 0918"
	$"C720 E81C E710 8514 A61C E714 A610 8514"
	$"C61C E710 A521 0935 CE14 A614 A610 8410"
	$"6425 2920 E70C 4260 316B 39AC 1CC6 0000"
	$"0841 0822 0842 1083 10A5 14C6 14A6 1085"
	$"1083 0842 14A4 0C63 2949 0C63 0420 0862"
	$"18C6 0842 2108 1CC7 0C63 1CE6 18C5 0841"
	$"2969 3DED 14A3 18C5 18C5 18C6 2107 5293"
	$"4E51 398C 1483 0820 0420 20E6 2107 2107"
	$"1CC5 0000 0C63 3DCF 1CE7 0C63 14A5 14A4"
	$"14A5 2DAA 14E4 0CA3 14C4 18E5 18E6 0C83"
	$"1084 18C6 2107 14A4 18C5 1CE6 14A3 0000"
	$"1CE7 2D8B 14C5 18E6 18C5 14A4 14C4 14C4"
	$"10A3 1D06 14A3 0C61 0841 14A3 14A3 1CC5"
	$"2928 2527 2107 4630 4630 0000 14A5 1CE6"
	$"14C5 14A5 0C83 0842 0C62 FE04 2110 0420"
	$"0421 0421 18E7 214A 1D09 214C 1D2C 10A9"
	$"210B 18C7 0843 0842 0422 0842 0421 0C61"
	$"0254 0829 4C29 2C29 4C29 4C29 4B25 2A29"
	$"4C29 2B29 2BFB 252B 0229 2B25 2B25 2BFD"
	$"252A 0025 2BFA 252A 0221 2921 2A25 2AF9"
	$"252B 0625 4B25 2B25 4B29 4B25 4B29 4B29"
	$"4BFE 294C 0329 4B21 0921 0929 4BFE 2D6C"
	$"0029 6CFD 2D6C 062D 8D29 4B31 8D31 8E2D"
	$"6D2D 6C2D 6CFE 294B 212D 6C29 4B29 4B25"
	$"2A29 4B25 4A2D 6C25 2A21 2925 4A25 2A25"
	$"2929 4B25 4A25 4A25 2B25 2B2D 6D21 090C"
	$"6410 8510 850C 8418 C620 E818 C718 C61C"
	$"E71C E718 C518 C618 C61C E71C E7FE 18C6"
	$"7F1C E71C E818 C614 A518 A620 E820 E818"
	$"C610 851C E720 E720 E725 0825 0829 291C"
	$"C61C C625 0818 A60C 4331 8C52 9504 2218"
	$"C61C E718 C710 8418 C618 C714 A514 A51C"
	$"E718 C618 C631 6C20 E704 0041 EF39 AD20"
	$"E70C 432D 4B3D D014 A608 4318 C614 8421"
	$"071C E621 0710 840C 6310 840C 6214 A425"
	$"2929 4B29 4B29 2A25 090C 6421 2921 0810"
	$"8410 8418 A618 A604 010C 4321 0831 6C25"
	$"2A29 2B1C C825 091C E818 A618 C625 2914"
	$"A414 A421 081C C61C E729 4A31 8C10 841C"
	$"E725 4A1C E71C C618 A518 A535 AC31 8B14"
	$"A404 210C 6214 8414 8414 A510 A510 A614"
	$"A71C C70C 420C 4225 081C E635 8B08 4104"
	$"2008 4131 6B14 8320 E618 A40C 4225 072D"
	$"4925 0739 AC4A 2F25 071C A431 6925 0714"
	$"8351 3DCD 2928 1883 2507 0400 0000 2529"
	$"318B 2507 1CC5 0400 1CC6 39AD 14A5 14A5"
	$"18E6 18C4 20E6 318A 14C4 0C82 10E3 14E4"
	$"14C4 10A3 1084 18C6 2529 2507 2928 2927"
	$"0841 0000 2549 4651 0C62 1D07 18E6 14A4"
	$"18C6 18C6 18E6 2108 1063 0C62 1CC6 2D49"
	$"2928 2507 1CC5 0C62 1084 39CE 41F0 0001"
	$"0C64 18C7 14A6 10A5 10A5 0C64 0C84 0843"
	$"0843 0C63 0843 0843 1064 14A6 1CE7 294A"
	$"2D6C 3DCF 316C 20E7 1083 0C62 0C63 0863"
	$"0863 0C63 1084 024D 0125 2B25 2BFC 252A"
	$"F925 2BFC 294B 0029 4CFB 2D6C 002D 6DFC"
	$"2D6C 052D 6D29 4C29 4B31 8D31 AE31 AEFC"
	$"318D FE2D 6C2A 318D 2D6D 294B 294C 254B"
	$"2109 1D09 254A 252A 294B 294B 252A 252A"
	$"2109 1CE8 254A 2D6B 2129 18E8 1D08 18E7"
	$"14C7 14C6 14C6 1D08 18C7 2109 1085 1CE8"
	$"18C7 14A6 14A5 14A5 1085 1CE7 14A5 18C6"
	$"14A6 14A5 1084 14A5 14A4 14A5 FE10 847F"
	$"1085 14A6 14A6 1085 1064 18A6 14A6 18C6"
	$"1084 18C6 14A5 1084 18C6 18C5 1084 18C6"
	$"18C6 2529 18C7 18C6 10A5 1CE7 2108 18C6"
	$"18C7 14A5 14A5 252A 18E7 14A6 18C7 2109"
	$"14A6 14A6 18C7 1084 1063 2D6B 358D 0C64"
	$"2109 18C6 1085 0843 1CE7 14C6 14A5 14A5"
	$"2108 0C63 294A 2D6B 0842 1CE7 4E73 2529"
	$"294A 1084 294A 294B 2108 14A5 0C64 14A6"
	$"252A 1CE7 2129 1084 1084 2528 1CC6 1063"
	$"2529 39CF 210A 2D4B 18A6 14A5 2949 18C6"
	$"10A4 14A5 18C6 1885 1CC6 0C63 2D6B 3DCF"
	$"20E8 2D4B 18A7 0C42 18A5 2D4A 2949 316B"
	$"2508 2507 1CE6 24E7 2528 2949 2D6B 0C62"
	$"2D6B 318C 20E7 20E6 2928 2D49 2107 0C42"
	$"1484 2929 2508 2508 2507 1CE6 18C6 0C63"
	$"2509 316C 1483 18A5 358B 358B 316A 0400"
	$"0908 2014 833D CD20 E629 2820 E518 A42D"
	$"2839 8B31 69FE 316A 551C E531 8A25 2808"
	$"412D 6A29 492D 4910 6200 0000 0008 4125"
	$"2825 281C C514 821C C41C E510 830C 8314"
	$"A50C 6320 E718 E614 E508 8210 C31D 2619"
	$"060C 8314 A410 A414 A431 8B39 AC25 2800"
	$"0004 2129 6A3D EE14 C51C E618 E618 C61C"
	$"E718 E621 0818 C618 C529 4931 8B2D 6A25"
	$"0725 2820 E618 C514 A425 286F 7A14 A504"
	$"2118 C614 A514 A510 A410 8414 A510 8410"
	$"8414 A410 8310 8410 8400 0014 A52D 6B29"
	$"4A31 8C25 2818 A504 2008 420C 620C 6308"
	$"4210 8410 8502 6004 2D6D 318D 2D6C 2D6C"
	$"2D8C FD31 8D00 2D6C F331 8D7F 316D 2D6D"
	$"318D 318D 2D6C 2D6C 294B 252B 2529 252A"
	$"1CE8 2108 294B 2109 2108 2108 2109 1CE8"
	$"2109 1CC7 14A6 1CE8 1CE7 1CE7 14C6 18C6"
	$"1CE8 14A5 1085 18C6 14C6 1084 14A6 14A5"
	$"10A5 18C6 1084 0C63 18C6 1D07 1484 0C63"
	$"1064 1484 2108 1CC7 18C6 1CE7 0C63 1084"
	$"14A6 1CE7 14A5 14A5 14A6 14A6 14A5 292A"
	$"1084 2108 1CE8 14A5 1485 14A5 14A4 14A4"
	$"1083 1084 14A4 1484 14A5 18A6 1085 1084"
	$"14A6 14A5 0C64 2108 2108 1084 1084 18C6"
	$"0C63 18C6 14A5 18C6 2109 1084 1084 14A5"
	$"18C6 14A6 14C6 14C6 0C63 1CE7 318D 10A6"
	$"1085 10A6 1085 1085 14A6 1CE8 1084 0842"
	$"2D6B 3DEF 1084 1CE8 10A5 10A5 14A5 18C6"
	$"1084 14A5 18C5 14A4 14A4 318B 14A5 0421"
	$"294A 35AD 2529 1D08 0421 1CE7 4D18 C61C"
	$"E718 C614 A618 C721 2921 2925 4A10 8418"
	$"C52D 4A29 2814 833D CE31 6C1C E825 0918"
	$"C61C C620 E620 E61C E51D 0625 281C C625"
	$"0804 0031 8C35 8D18 A625 0914 850C 411C"
	$"A435 8B2D 492D 492D 2829 282D 4931 4931"
	$"492D 4920 E614 832D 4920 C520 E635 8A31"
	$"6A39 8B10 6204 0020 C541 EE31 4A31 6A2D"
	$"492D 6929 4910 6325 0839 AD2D 2818 A32D"
	$"4839 AC25 0700 000C 4125 0629 2731 6939"
	$"8A24 E51C A431 6935 8AFE 3169 0835 8A1C"
	$"C435 8A25 2714 833D CD31 6A14 A400 00FE"
	$"0421 3014 A42D 692D 491C C41C C51C E70C"
	$"8508 6504 4404 2310 861C E618 E610 C308"
	$"8114 E418 E510 A314 A40C A30C 8329 4931"
	$"6A18 A408 4110 8321 072D 6A25 0718 C518"
	$"C618 C518 C618 C610 A504 2014 A418 C614"
	$"A514 A414 A418 C518 C41C E510 8225 2763"
	$"1610 8308 41FE 18C4 1614 A318 C41C C518"
	$"C51C C51C E518 C518 E518 C410 8218 C529"
	$"280C 620C 6210 A30C 6300 0000 2004 4110"
	$"8310 831C E621 0702 7A0B 252B 294B 212A"
	$"252A 252A 2129 252A 212A 2108 2108 252A"
	$"2109 FE1C E835 1CE7 18E7 18C6 18C6 14C6"
	$"18C6 14C6 14A5 14A5 14A6 18C6 18C6 18A6"
	$"18C6 14A6 1085 1485 18A6 2108 18A6 1CC7"
	$"1CC7 18C6 18C6 18A6 18C6 1CE7 252A 14A5"
	$"1085 18C7 18C7 18C6 14A5 2509 18C6 1484"
	$"18C6 1CE7 18A5 1CC6 18C7 1084 14A6 1CE7"
	$"1084 1084 18C7 1484 0C63 1084 1084 1CE7"
	$"2529 FE14 A50B 1083 1484 14A5 18C6 1CE7"
	$"14A5 1CC7 252A 14A5 1CE7 14A5 1CE7 FE18"
	$"C67F 14A5 1485 14A5 0C63 1064 1CE7 14A5"
	$"14A4 18A5 1084 14A5 14A5 1084 1084 1CE7"
	$"0C63 18C6 1CC6 1083 14A5 18A5 0842 18C6"
	$"18C6 0C63 1084 18C7 18C6 14A5 18C7 14A5"
	$"0C63 2109 2108 14A6 1CE7 18C7 18C7 18A6"
	$"1CC7 1CC7 1CE7 0843 39AE 39CF 1085 18E7"
	$"18C7 1085 2108 2107 18A5 18A5 1CC6 18C5"
	$"2507 20E6 1063 0841 14A5 2109 2108 1CE7"
	$"2108 1CC6 0C62 14A4 20E7 2949 2508 2528"
	$"2107 2528 2508 2949 2D69 2948 2106 316B"
	$"0C63 1084 1484 18A5 314A 3169 2D49 2948"
	$"2D69 318A 2107 1CE6 0821 318C 1CE7 0C63"
	$"1484 2508 24E7 1CA5 398B 356A 3569 3169"
	$"3569 3569 3169 358A 2927 18A4 24E6 20C5"
	$"1462 2907 3DCD 316A 358A 1CA4 20C4 2927"
	$"3DAC 3149 3169 3169 3189 2D69 0C42 2508"
	$"3DCD 0D39 8A0C 4029 2745 EE1C C500 0018"
	$"8339 8C2D 4935 6935 6929 0620 C439 8AFE"
	$"3569 5735 6A39 8B1C C435 8A29 272D 483D"
	$"CC14 8310 6300 0008 6310 850C 6318 C542"
	$"0F31 6A1C C525 291C E804 2304 4404 2304"
	$"2221 0929 4A0C 6214 C408 8108 8108 610C"
	$"8210 830C 820C 6214 A410 6304 2008 4104"
	$"4125 4929 4920 E614 A410 8314 A414 A50C"
	$"8408 6204 2008 4008 410C 610C 6118 A31C"
	$"C41C E521 051C E525 0629 4808 200C 6018"
	$"C31C E41C E418 C31C C41C E420 E520 E525"
	$"0625 0625 2625 2625 0629 062D 480C 4104"
	$"0008 4008 4104 4004 2004 410C 620C 6210"
	$"8318 C502 6519 1CE8 1CE8 18C6 1CE7 14A6"
	$"18C6 18C7 14A5 14A5 18C6 1CE7 18C6 14A5"
	$"1485 1485 14A5 14A5 1084 14A5 14A5 18C6"
	$"14A5 1485 1085 20E8 1CE7 FE14 A537 18A6"
	$"1CC7 18A6 2109 292A 18C6 1485 1084 1CE8"
	$"1CE7 14A5 18A6 1CE7 18C6 1085 14A5 1084"
	$"18C6 18C6 18A6 20E8 18A5 1CE7 2107 18A5"
	$"1CC6 2529 18C7 0C64 1485 14A6 1084 2108"
	$"2108 1084 1084 14A5 14A5 18C6 14A5 1063"
	$"1484 14A5 1064 18C6 2529 1484 1CC6 1485"
	$"1CE7 294A 0421 18A6 252A 14A5 0C64 FE14"
	$"A50A 1085 18C6 0C63 2108 1CE8 14A5 14A5"
	$"1084 14A5 1CC6 14A5 FE10 8439 1064 20E8"
	$"1484 0C42 1084 1083 0C63 1083 10A4 14A5"
	$"1485 2508 2508 14A4 14A4 14A5 1084 2129"
	$"1CE9 18C8 14A7 18C7 252A 18C6 14A5 2108"
	$"20E9 18A7 318D 2108 0C64 14A6 1CE7 1CE7"
	$"2529 2929 20E7 20E7 2508 2508 2D4A 2508"
	$"2507 20E7 2507 2929 18A5 356B 398C 2D49"
	$"1041 1CA5 398C 358B 316A 2D49 2D69 316A"
	$"FC35 6A05 2508 0000 0842 1063 2D29 3DAC"
	$"FE35 8A36 3569 358A 3149 20E6 1062 3DCD"
	$"1483 1483 20C6 1CA5 28E6 3149 356A 3569"
	$"3169 3169 3168 3168 3569 398A 24E5 24E5"
	$"3148 1883 1883 24E6 3DAC 2D28 3148 24E6"
	$"24E5 2506 39AB 3569 3148 3149 316A 2928"
	$"0841 2508 41EF 2528 0400 314A 4A30 1484"
	$"0000 1CC5 39AD 398C 3569 3169 3569 2506"
	$"358A FE35 6935 3549 398B 24E6 2927 20E6"
	$"316A 2D49 0C41 0C43 0400 2108 2528 0C62"
	$"2D4A 316B 1CC6 1064 1CE8 18C8 0023 0444"
	$"0002 0843 358D 2D6A 0000 0861 0861 0840"
	$"0440 0C61 1483 0C42 0C62 0C62 0400 0420"
	$"0841 0420 2528 2107 18A4 1484 0841 1083"
	$"1083 0861 0C61 1482 18A3 18C4 1CC4 20E5"
	$"2106 FC25 0604 20E5 20E5 1CC4 2105 2506"
	$"FE20 E500 24E6 FD25 060F 2507 2927 2506"
	$"2507 2928 1CC4 1CC5 20C5 20C5 1CC4 18A4"
	$"18A4 14A4 14A3 1483 1484 0278 7F21 0918"
	$"C714 A51C E718 C625 091C C710 8414 8518"
	$"C618 C614 A514 A518 C618 C714 A514 A518"
	$"C61C C71C E714 A514 8518 A618 C721 0818"
	$"C718 A610 8510 8418 C614 A618 C720 E81C"
	$"E814 A510 8514 A514 A510 8518 C614 A518"
	$"C618 C610 6314 A510 8429 4A1C E710 8518"
	$"C614 851C E718 C614 A518 A518 C614 A510"
	$"8418 C61C C714 A625 2918 C610 8418 C618"
	$"A614 8514 8510 6414 8410 8418 C614 8418"
	$"C618 C60C 421C C610 6320 E729 290C 631C"
	$"E71C E718 C614 A510 8414 A514 A510 8414"
	$"A514 A529 491C E714 A610 8514 851C E825"
	$"0918 C718 A610 8418 A61C C71C E710 8414"
	$"A618 C61C C618 C614 A425 282D 6A14 A518"
	$"C614 A410 8318 C510 A410 8329 4A10 850C"
	$"640C 6420 E829 4A18 A51C E620 E70E 2107"
	$"2949 2929 1CE7 0420 1084 318C 316B 2D49"
	$"316A 2D49 2D29 314A 316A 356A FE31 6A19"
	$"39AC 20E6 18A4 3DCD 358B 3149 1862 24E5"
	$"3DAC 356A 3169 3169 356A 358A 3569 3569"
	$"358A 358A 39AB 2928 0400 0820 20C6 41EE"
	$"398B 356A FE31 6971 3149 398B 1483 1CC5"
	$"460E 1062 1CC5 3DAC 1462 3149 398A 3169"
	$"3169 3569 3569 3148 3569 3569 398A 24E5"
	$"2906 358A 1CA4 20C5 1CC4 3DAC 3149 3569"
	$"2927 2506 2D27 356A 3169 3148 3148 3169"
	$"2D49 18A4 2928 318B 1CC6 0400 2D49 41EE"
	$"1062 0400 1483 316A 314A 24E5 3148 3569"
	$"2D48 3169 3148 358A 3169 3148 398A 2506"
	$"0C41 18C4 316A 2D6A 1484 0000 0C63 2D6B"
	$"2949 18E6 18E6 1084 18C6 18A4 20E6 2108"
	$"1485 14A5 1083 20E6 398B 2D28 0C40 1061"
	$"0C61 0C61 0841 0C62 18C5 1063 1083 1483"
	$"0C62 1483 1CC5 1CC5 2907 2927 2906 2506"
	$"1CC4 1CC4 1CC5 1CC5 2507 3149 3169 3148"
	$"3149 3148 2D48 2D27 2D28 2928 FC2D 4819"
	$"3168 2D48 2D28 2D48 2D48 2506 2506 2D28"
	$"2D28 2D48 2928 2928 2927 2D28 2D28 2907"
	$"2927 2927 2D28 2907 2928 2928 2507 2928"
	$"2928 2507 0263 1714 A614 A514 A518 C61C"
	$"E81C E810 8510 8418 C625 2920 E810 8410"
	$"6420 E81C E714 8518 A61C E71C E718 C610"
	$"8414 8518 C618 C6FE 18A6 1414 A514 A61C"
	$"E718 C618 C714 A614 A50C 6418 C618 C610"
	$"6414 8518 C610 8318 C514 A50C 6314 A518"
	$"C629 2A14 A5FE 1CE7 6A1C C718 C614 A510"
	$"8410 840C 6318 C618 C614 A518 C618 C710"
	$"6410 8525 291C C710 840C 6318 A51C C625"
	$"082D 4A18 A510 6314 841C C61C C614 841C"
	$"C618 C61C E61C E618 A518 C618 C514 A418"
	$"A518 A510 8310 831C E61C C614 A414 A414"
	$"A518 A518 C614 A51C E720 E814 8425 0921"
	$"0825 0914 A525 2921 0729 2831 6A29 2831"
	$"6A35 8B29 2820 E620 E629 2731 6925 0729"
	$"492D 6908 430C 6310 6425 0839 8C2D 2931"
	$"6A31 4931 682D 4835 8A29 4800 0010 6239"
	$"AC35 8B31 6935 6A31 6931 4935 6931 4935"
	$"6A31 6931 4835 8A35 8A10 622D 4839 8B39"
	$"AB2D 2820 A32D 273D AC35 6935 6935 8AFC"
	$"3569 1935 8939 AB2D 480C 410C 4039 8C3D"
	$"AC31 4935 6931 4835 6935 6A31 6935 8B08"
	$"202D 4845 EE14 6314 634A 0F18 8435 6A35"
	$"8A2D 4831 6935 69FE 3148 2331 6935 6924"
	$"E52D 2735 6920 C52D 2829 0739 8A31 4935"
	$"692D 482D 482D 2835 6931 4831 4731 6831"
	$"6931 6925 2729 282D 4925 0720 C531 6931"
	$"6910 6208 2014 833D CC31 492D 2731 4831"
	$"4831 69FE 3569 1331 692D 4839 AA21 0618"
	$"A41C E520 E631 6B14 6314 8318 A425 0729"
	$"4810 8314 A318 C52D 4935 6935 6931 69FE"
	$"2D48 1531 6935 6A31 4829 0629 0625 061C"
	$"E514 A41C E521 0621 0625 0729 282D 4831"
	$"6935 6A35 6A31 4935 6931 6935 6931 69FE"
	$"2D48 0931 6931 6931 4935 6935 6931 6931"
	$"492D 4831 4831 69FE 3148 0031 49FE 3169"
	$"0029 07FE 2507 0825 0629 0729 282D 4929"
	$"2829 0729 2829 282D 49FC 2D28 0531 692D"
	$"4825 0729 282D 492D 4802 626B 14A5 1085"
	$"1085 14A6 14A6 1085 1084 1085 20E8 2108"
	$"18A6 1085 1485 1CE8 1485 1485 1084 14A5"
	$"1CE7 1CE7 1084 1084 14A5 14A5 18C7 1485"
	$"1085 18C7 18C7 18C6 18C6 1085 14A5 18C6"
	$"1084 1CC7 1CE7 18C6 18C6 1485 1CC6 1CE7"
	$"14A5 1CC6 1CE7 18A5 18C5 14A4 1CE6 18C5"
	$"1CC6 1CC7 20E8 1CC6 1485 18A5 1CE6 1CE7"
	$"1084 1084 20E8 18C6 18A6 18C7 1CE7 18C6"
	$"1084 14A5 2508 1CE7 2529 20E8 1485 1484"
	$"1CC7 1CC7 18A6 18C6 18A5 1084 1483 1083"
	$"1483 1083 1483 1083 0C62 1083 1063 1483"
	$"1062 0C62 1083 1483 1483 18A4 20E6 18A4"
	$"2928 2507 20E6 2507 2908 3149 2927 3149"
	$"2907 2D28 FD35 6AFB 3569 1335 8A31 6A0C"
	$"6308 220C 4218 A439 AC35 8B35 6935 6931"
	$"6931 6935 8A18 A314 A320 C535 6A35 8A31"
	$"4931 69FE 356A FE35 692E 3168 398A 3169"
	$"1CC4 39AB 358A 3DAB 2D27 24C5 3148 398B"
	$"3149 358A 3169 3569 3149 356A 3169 3169"
	$"3569 3148 356A 1CC5 0C41 398B 356A 3149"
	$"3169 3148 358A 3569 3149 2D48 1062 358A"
	$"3DAC 1463 20C5 41CD 20C5 356A 3569 2D27"
	$"3569 3148 2D48 2D48 FE31 480F 2906 3569"
	$"3169 24E6 3569 3149 2D27 2D27 3148 3569"
	$"3148 3148 358A 3148 3169 3569 FD31 6921"
	$"358A 356A 358A 39AB 2928 0820 0400 2928"
	$"41ED 356A 3569 358A 3569 356A 3569 3169"
	$"3569 3569 3148 39AB 20E6 3169 2927 2506"
	$"356A 2907 3148 2D48 3569 3169 2927 3149"
	$"356A 3149 FE31 6908 3168 3169 2D28 3169"
	$"2D49 3149 3169 356A 2D48 FE31 69FE 356A"
	$"3531 6935 6A31 6931 6931 4931 4831 6935"
	$"6A31 6931 6931 4831 4831 6935 692D 282D"
	$"4831 6935 6935 6931 6931 4831 4835 6931"
	$"6931 6935 6931 692D 2829 072D 482D 282D"
	$"4929 272D 2825 0729 0729 272D 482D 2829"
	$"2829 2720 E62D 4831 4931 6A2D 2829 0731"
	$"4831 6925 0725 0729 282D 482D 4902 5D1A"
	$"18C7 1485 14A6 18C6 14A6 14A6 14A5 18C6"
	$"1CE7 18A6 18C6 18A6 1CC7 20E8 2509 2508"
	$"1485 1485 18A6 14A5 1064 1084 1084 14A5"
	$"1CC7 14A6 18C6 FD18 C742 14A6 1CE8 2509"
	$"18C6 2108 2529 2529 2509 1CC7 1CE7 1CC7"
	$"18A6 2508 20E7 1084 1063 1084 1CA6 18A6"
	$"1CA6 1CC5 18A4 1484 1CC6 2909 2D4A 1CC6"
	$"1484 1CE7 20E7 20E7 2D6B 2529 18C7 18C6"
	$"1085 1CE8 1CE7 1084 1CE7 1CE7 1084 1484"
	$"14A5 1484 18A5 1CE7 2107 1CE6 1484 0C42"
	$"1063 1083 1084 1083 1084 14A4 18A5 18C6"
	$"1063 1063 1484 1884 1883 2507 398A 3148"
	$"FE31 4903 3148 3148 3569 3169 FE31 48FA"
	$"3569 1635 8A35 8A35 6935 8A35 8A10 8308"
	$"210C 4214 8339 AB39 8B35 6935 8A35 6939"
	$"8B29 070C 4035 8A2D 2831 6935 6A31 4931"
	$"49FE 3569 FD31 480F 3569 3148 3148 3169"
	$"2D48 3149 2906 20C4 2D27 3169 2D48 3148"
	$"3148 3169 2D48 3169 FE31 4929 2D28 398B"
	$"2927 1041 2907 356A 3149 2D28 3149 3148"
	$"3169 3569 3148 3148 356A 398A 1CA4 2D28"
	$"39AB 24E5 2D49 3149 3148 3149 2D27 3569"
	$"3169 3169 3148 3148 3169 358A 3169 2D48"
	$"3569 3169 3148 3169 358A 356A 3169 3169"
	$"FE35 690E 3169 3569 3569 3169 358A 3169"
	$"3569 358A 358A 2D49 0400 0000 316A 41CD"
	$"356A FE35 6944 356A 3569 3169 356A 3169"
	$"3169 358A 1CC4 2927 2506 20E5 2506 2506"
	$"2927 3149 2D49 2D48 2D48 2907 24E6 2907"
	$"2507 2506 20E6 2928 2507 20E6 2928 20E6"
	$"24E6 2907 2907 2507 3169 356A 3149 3169"
	$"3149 3148 3149 3149 3569 3169 3169 356A"
	$"3569 356A 3148 3169 3169 3149 3569 356A"
	$"2D48 2907 316A 316A 3169 2D28 3149 356A"
	$"3169 2D48 3149 2D49 2928 2928 2D49 2928"
	$"FE2D 2801 2D49 2908 FE2D 490F 2928 2928"
	$"2507 2507 3169 2927 2928 20E5 1884 1CC5"
	$"2507 14A4 14A4 20E6 2528 2528 0252 1C25"
	$"2A18 C714 A618 C618 C61C E71C E721 081C"
	$"E618 A518 A51C E625 0825 2929 4925 281C"
	$"E618 E610 8408 4310 8418 C614 A610 8514"
	$"A518 C614 A514 A514 A4FE 18C5 4221 0825"
	$"0914 A514 8418 A525 081C E71C E718 A510"
	$"8410 8418 C618 C614 A50C 6318 C51C C618"
	$"A51C C61C C61C C525 082D 2929 291C C618"
	$"A510 6314 8418 A531 6B35 8C25 0820 E721"
	$"0825 0821 0818 A51C C62D 6B25 2814 A41C"
	$"C620 E720 E725 282D 6A2D 692D 4914 A40C"
	$"4114 A41C C51C C61C E620 E725 0725 0729"
	$"2825 0729 2729 282D 282D 2831 4935 6A31"
	$"4931 48FE 3569 0131 4931 49FE 3569 0135"
	$"8A31 69FD 3569 1731 6935 6935 8A35 6931"
	$"6935 6935 6925 0625 0629 0729 2735 6A35"
	$"6931 6935 6931 6935 8A29 2714 8231 8A2D"
	$"4929 272D 4831 49FE 3148 032D 4831 4831"
	$"4831 69FB 3148 072D 482D 272D 2731 4831"
	$"692D 482D 4831 48FE 2D48 0931 4831 6935"
	$"6931 4831 6929 0620 E520 C531 6935 6AFE"
	$"3169 FE35 690B 356A 3149 3569 2907 3569"
	$"39AB 2927 2D28 356A 3149 3169 2D48 FA35"
	$"690F 3148 3569 358A 3569 3569 3169 3569"
	$"358A 3148 3148 3569 3169 3169 358A 358A"
	$"3169 FE35 692B 358A 3148 358A 356A 0C41"
	$"0000 316A 41ED 3149 3569 3569 3148 3149"
	$"3169 3169 3148 3148 2D48 2927 2506 2906"
	$"2927 2D27 2D27 2D48 2927 2927 2D48 2D28"
	$"2D28 2906 2927 2D48 2D28 2506 2D48 3169"
	$"2506 3149 2D48 2D48 3148 3149 2D48 FC31"
	$"690D 2948 2948 3169 3169 3149 3169 3569"
	$"356A 3569 3149 3149 3569 3169 3149 FE31"
	$"6926 2D49 3149 3149 358A 2D28 316A 3149"
	$"2928 316A 3169 2D28 2D49 2D49 3169 3169"
	$"2D49 2D48 2D49 2D48 2928 2928 2507 2D28"
	$"316A 358B 1CC5 20E6 2D49 2507 20E5 1CC4"
	$"1CC4 20E5 20E6 2507 2928 2D49 1CE5 1082"
	$"0256 0325 2A21 291D 0814 A6FE 14A5 0618"
	$"C514 A510 8410 8418 C518 A514 A5FE 18C6"
	$"3B1D 0714 A508 4214 A51C E714 C614 A514"
	$"A414 A514 8410 8310 8310 630C 6210 8318"
	$"A518 A518 C60C 631C C729 4A10 8318 A514"
	$"A410 8314 A414 A518 C518 C61C E71C E718"
	$"A520 C631 4B31 4B20 C729 0835 8B25 0720"
	$"E620 E718 A520 E625 082D 4A2D 2929 2829"
	$"082D 492D 4929 2829 2831 6A35 8B31 6931"
	$"6931 6A31 6A35 6A35 8AFE 316A 0829 2825"
	$"072D 4931 6931 4931 6935 6A35 6A31 69FE"
	$"356A FE35 6902 3169 3569 3589 F835 690D"
	$"398A 3569 3569 358A 358A 3169 3169 3589"
	$"358A 3148 3148 3569 396A 3168 FE35 6913"
	$"3169 3169 3569 3569 3149 3169 3169 2506"
	$"2D48 3168 2927 2927 2D48 2D48 2D28 2D48"
	$"3169 3569 3169 3569 FD31 481E 3169 3569"
	$"3148 3148 3169 3569 3569 3148 3569 3569"
	$"358A 3569 3148 3569 3169 3589 3169 3569"
	$"3148 3569 2907 2D28 3569 3149 3149 3569"
	$"3169 3169 3569 3169 3168 FE35 8A00 398A"
	$"FD35 6936 358A 3569 358A 3569 3569 356A"
	$"3569 3569 3169 3169 3569 3569 3169 3169"
	$"3148 3569 398A 3148 3148 358A 3148 358A"
	$"3569 3169 3569 398A 3148 3569 358A 3569"
	$"39AB 2D28 0820 0400 358B 41ED 3149 356A"
	$"3569 3148 3169 3169 2D27 3148 3169 2D48"
	$"2906 2D48 2D48 3148 2D27 3148 3569 2D47"
	$"2D27 FE31 481E 3569 3169 3148 3169 3148"
	$"3569 3169 3148 398A 3148 3569 3589 3169"
	$"3569 358A 3569 3148 3149 3169 3169 2D69"
	$"2D49 358A 3169 2D48 3169 356A 2928 2506"
	$"3149 356A FD2D 4827 398B 2D48 2D28 3169"
	$"356A 2D48 39AB 2D48 2D49 39AC 358A 2D49"
	$"3169 2D49 2D48 2927 2927 2D48 2927 2506"
	$"1CC5 18A3 1CC4 2507 3169 2D48 1CC5 20E6"
	$"2927 2927 20E5 2927 3169 316A 358A 358B"
	$"3149 3149 1CC4 0C40 0253 1E29 2A29 2A1C"
	$"E80C 6310 8410 8410 A410 A414 A514 A514"
	$"A618 C614 A514 A514 A614 850C 6314 8518"
	$"C614 A518 A510 8410 8410 6310 8418 C61C"
	$"C620 E721 0714 8410 83FE 20E7 041C C614"
	$"8529 2929 2910 63FE 20E6 1D20 E725 0729"
	$"0829 292D 4A2D 4A29 2925 0824 E731 2A18"
	$"6431 4A35 8B25 072D 492D 4A2D 4931 6A31"
	$"4A2D 4931 492D 4931 492D 4829 2831 4935"
	$"6A35 6A31 6A35 6AFD 3569 2035 8A35 6931"
	$"6935 6A35 6935 6A35 8A35 6931 6935 6931"
	$"6931 6935 6935 6939 8A35 6935 6935 8A35"
	$"6931 6935 6935 8935 8A35 8935 8A35 6931"
	$"6935 6935 6931 4831 6935 6931 69FE 3569"
	$"0231 4831 4831 69FE 3148 052D 4831 4831"
	$"4931 2829 0735 49FE 3569 012D 272D 28FD"
	$"3169 0335 6931 4835 6931 49FC 3569 0031"
	$"48FE 3569 0235 6835 6935 69FE 3169 0C35"
	$"6935 6931 4835 6935 6931 6935 8A35 6931"
	$"6935 6931 4835 6A31 48FE 3169 0B35 8A31"
	$"4831 4931 4935 6935 6A35 6931 6935 6931"
	$"4831 6935 8AFE 3569 0031 48FD 3569 0435"
	$"8A35 8A35 6931 4939 8AFD 3569 0331 4835"
	$"8A35 6931 49FE 3569 0731 6931 4835 8A35"
	$"6935 692D 272D 4735 89FE 3569 2239 8A35"
	$"693D AB25 0600 0004 2039 AC3D AC2D 4835"
	$"6931 4831 6835 6931 482D 4831 4831 692D"
	$"482D 482D 2735 6931 482D 2731 4835 6931"
	$"4931 4831 4931 4831 4935 6A31 6931 4835"
	$"8A35 6AFE 3169 4235 6931 6931 6935 6935"
	$"6931 6935 6A31 6935 6931 6931 6935 6A2D"
	$"482D 2835 8A2D 482D 4839 8B35 6A29 2829"
	$"272D 4931 492D 4931 492D 2829 2835 6A2D"
	$"4831 6931 692D 4831 482D 4829 272D 2831"
	$"4929 2725 0729 0720 E61C C518 A420 E620"
	$"E61C C525 061C C525 0729 2820 E625 0729"
	$"2829 282D 4931 6931 6A29 282D 4835 8A39"
	$"8B35 6931 282D 2831 492D 4820 E502 5B03"
	$"2509 1CC7 14A5 14A4 FD18 A50D 18A6 18C6"
	$"14A6 14A6 14A5 18C6 18C6 1085 1484 18A5"
	$"1CC5 1CC6 18A5 18A5 FE1C C52A 1CA5 20E6"
	$"2928 2929 20E7 2508 2D4A 2D4A 2929 2908"
	$"2929 314A 314A 2D49 2D4A 314A 314A 3149"
	$"316A 316A 2D49 316A 3149 314A 1884 1463"
	$"2507 20C6 398B 2928 2D28 356A 3169 356A"
	$"356A 3169 3149 3169 356A 356A 3169 356A"
	$"356A FE35 691D 358A 356A 3569 356A 398A"
	$"398A 3569 396A 396A 358A 398A 398A 3569"
	$"356A 3569 356A 3149 3549 3149 3569 3569"
	$"3148 3569 3149 2D28 3128 3549 3149 3149"
	$"3569 FE31 6949 2D48 2D28 3149 2D28 2D48"
	$"356A 2D48 3148 3148 3149 2D27 3148 398A"
	$"2D28 2906 2D27 3569 2907 2D27 398A 356A"
	$"3169 3148 2907 3148 3149 3169 3569 3148"
	$"3149 3569 3569 3128 3569 3569 398A 3969"
	$"3569 3148 3569 398A 396A 356A 398A 398A"
	$"3169 356A 3169 3569 3148 2D27 398A 3569"
	$"3169 3148 3569 398B 3149 3149 398A 3169"
	$"356A 356A 358A 3569 358A 398A 3569 356A"
	$"3569 3169 3149 398A 3148 F935 6902 3169"
	$"3149 356A FE35 6903 398A 3569 3569 3149"
	$"FE31 480A 3149 358A 3569 358A 3569 356A"
	$"3569 3148 3569 3149 3148 FB35 690B 3548"
	$"3DAB 2907 0000 1062 41ED 3169 3148 358A"
	$"3149 3169 358A FD2D 4857 3569 3569 3128"
	$"3569 2D28 3148 3148 3549 2D27 2D48 3148"
	$"3148 3169 356A 356A 3149 3569 3169 398B"
	$"3148 3569 3569 3169 3589 3169 2927 3148"
	$"3569 356A 398B 3169 3169 398A 3569 2906"
	$"398A 3149 3169 398B 356A 356A 3149 356A"
	$"316A 3169 316A 3169 2928 3149 2D28 3149"
	$"2D28 2928 2506 20C5 1CA4 1CC5 1062 18A4"
	$"1CC5 1CC5 20E6 20E6 2507 2907 20C5 2907"
	$"2D49 2D28 356A 316A 3149 3149 356A 3149"
	$"358B 356A 316A 356A 316A 2D48 3169 3169"
	$"3149 2927 3148 398B 356A 025A 1B18 C618"
	$"A518 A51C C618 C518 A518 A51C C620 C620"
	$"E71C C61C C620 E725 0821 081C C620 E729"
	$"2824 E729 0829 2829 2929 2829 2929 2829"
	$"0729 2829 28FD 2D49 012D 4A31 4AFB 316A"
	$"0031 49FE 316A 1331 4931 4931 6A31 6931"
	$"492D 282D 2831 6931 4935 6931 4935 6A35"
	$"6A35 6935 6935 6A35 6935 6935 8A35 8AFE"
	$"356A 0035 8AFE 356A 0B35 6935 8A35 6935"
	$"6931 6931 4831 6935 6A31 6931 4931 6935"
	$"69FE 2D48 4029 072D 282D 2829 0731 4831"
	$"482D 272D 2731 4935 692D 4831 482D 4835"
	$"6931 4931 4935 6931 492D 2831 4831 4931"
	$"492D 2835 6931 6935 6A31 4835 692D 4835"
	$"6939 8A2D 482D 4731 4831 4931 6935 6935"
	$"6931 482D 2831 4931 482D 4831 4931 4931"
	$"6931 4931 6935 6935 6931 4935 6A39 6939"
	$"8A35 6935 6931 4831 6935 6939 8A39 8A35"
	$"6935 6931 6931 69FD 3148 0635 6931 4835"
	$"6935 6931 4839 8A31 48FE 3569 0035 8AFE"
	$"3569 2535 8A35 6931 6835 6931 4831 4835"
	$"6939 8A31 6935 692D 2735 6931 6931 4831"
	$"692D 4831 492D 282D 4831 482D 2831 4931"
	$"6935 6935 6931 6835 6931 6931 4831 4831"
	$"6935 692D 4831 4831 6935 6935 692D 48FD"
	$"3169 FE35 6915 3169 3148 396A 398B 20E6"
	$"0000 1CC5 41ED 2D28 3149 398B 356A 3149"
	$"3149 2506 3169 316A 2D28 3149 2D48 2D28"
	$"2D28 FD2D 484F 20E5 3148 2D27 2927 3149"
	$"3148 3149 3169 2D28 356A 398A 2927 398A"
	$"358A 3148 3569 3149 2906 356A 3569 358A"
	$"3169 356A 356A 398A 3148 2D27 398B 2D28"
	$"3149 356A 3169 358A 2D28 2D49 3149 358A"
	$"3149 2907 3169 3569 3148 356A 1CC4 20C5"
	$"2507 2928 2D49 2927 20C5 316A 316A 2D49"
	$"358A 316A 3149 356A 356A 358A 3569 3169"
	$"3149 3148 356A 398B 3149 3149 2D49 2928"
	$"2D49 398B 2D49 2927 316A 398B 3169 2907"
	$"316A 358B 2D48 0253 FD25 0806 2507 2507"
	$"2508 2508 2908 2908 2508 FE29 2909 2508"
	$"20E7 2508 2928 2507 2928 2928 2507 2507"
	$"2928 FE2D 2806 2D49 3149 2D28 2D28 3149"
	$"316A 316A FD35 6A06 316A 3169 3169 3569"
	$"358A 356A 3169 FE35 6AFE 358A 0435 6935"
	$"6A35 6931 6935 6AF9 3569 0035 8AFE 3169"
	$"4A31 492D 482D 2731 492D 4829 272D 482D"
	$"272D 282D 4831 492D 4831 482D 282D 2831"
	$"492D 482D 482D 2731 4931 492D 2835 6935"
	$"8A31 4831 4831 6931 4931 4831 4931 4831"
	$"4935 6931 4831 4931 482D 482D 482D 2831"
	$"492D 282D 4831 4931 492D 4831 4825 062D"
	$"4831 4829 062D 472D 4831 4835 6931 482D"
	$"4831 492D 2831 6931 4831 4831 6931 4931"
	$"4931 6935 6931 4935 6A31 6931 4935 8A35"
	$"8931 6935 6935 69FE 358A 0639 8A31 4831"
	$"4831 4931 4835 6931 48FD 3169 033D AB2D"
	$"4829 2731 69FE 3569 1931 6931 6931 4831"
	$"6931 4831 6831 4831 4835 6935 6931 692D"
	$"4735 6931 6931 482D 2731 482D 4831 6935"
	$"692D 2731 492D 4831 4835 6931 69FC 3569"
	$"7C31 6935 6931 4835 6935 6931 492D 4831"
	$"4831 6935 8A31 4931 6931 6929 062D 4831"
	$"4839 8A39 AB31 692D 4839 8A39 AB3D CC1C"
	$"C400 0020 E631 6A20 C525 0735 6931 6931"
	$"492D 482D 282D 482D 4929 2829 2729 2829"
	$"282D 2829 2735 6A35 8A2D 282D 2731 4829"
	$"072D 2835 6A31 4931 692D 4829 2735 8A35"
	$"692D 2735 6935 8A31 4835 6939 8A31 4835"
	$"6A31 4935 6931 4939 8A39 8A35 6931 4835"
	$"6939 8A31 492D 4835 8A31 4931 6A2D 4931"
	$"492D 4935 6A31 4935 6A39 8B35 6939 8B35"
	$"6A25 062D 4831 6935 8A39 AC35 8A39 AB3D"
	$"AC35 6A35 8A35 8A35 6A35 8A39 AB35 6935"
	$"6A39 8A35 6935 6931 4835 6935 8B2D 2831"
	$"4924 E629 0735 8A39 8B2D 4929 2831 6A31"
	$"6A2D 482D 2831 6A35 8A35 8A02 5F0E 292A"
	$"2929 2929 2D29 2928 2908 2929 2D29 2D29"
	$"2908 2929 2929 2508 2508 2929 FE2D 4909"
	$"2D29 314A 316A 2D49 2D49 3149 3149 316A"
	$"356A 316A FD35 6A05 316A 3169 3169 3569"
	$"358A 3569 FE35 8A00 3569 FD35 8A02 3569"
	$"358A 358A FE31 6922 358A 3149 3149 3169"
	$"2D28 3149 3149 2D28 2927 2907 2927 2D28"
	$"2D27 2927 2D47 2D28 2D28 2907 2927 3149"
	$"2D48 3148 3169 3169 356A 3148 3569 3148"
	$"3569 3569 2D28 3149 3148 3149 3569 FE2D"
	$"2825 3169 3169 3148 2D28 3169 3149 2D27"
	$"3148 2D27 2D28 3148 2927 2D48 2927 2506"
	$"2506 2907 2928 2907 2928 2928 2D28 2D28"
	$"2907 2927 2D28 2927 2506 2D28 3149 3149"
	$"2D27 2D28 356A 3569 2D28 3169 3169 FD2D"
	$"4809 3149 356A 2D48 3148 2D49 2928 3148"
	$"3169 3169 3148 FE35 6915 3169 3149 3169"
	$"3148 3148 3569 3569 3149 3569 2D27 3148"
	$"3569 358A 2D27 3569 3149 3569 356A 3149"
	$"2D28 2D28 3149 FC2D 4808 3149 3169 2D48"
	$"2D28 3569 3169 2D48 3169 3148 FE31 6909"
	$"3149 3569 356A 3569 3169 2D27 2907 358A"
	$"358A 3149 FE2D 4802 2D28 356A 3169 FE2D"
	$"4874 3149 3169 2927 356A 2D28 2D48 3569"
	$"2D48 2D48 2D28 2507 3149 398B 3569 3DCC"
	$"1063 0000 20E6 2928 1CC5 2907 2D28 3149"
	$"3169 3148 2D28 24E6 2D48 3169 2507 2907"
	$"3149 316A 20E5 2928 3149 2D28 3148 2D28"
	$"2D27 2927 3149 3149 3569 2906 20E5 3569"
	$"2D48 20E5 3569 398A 2906 398A 356A 3148"
	$"358A 356A 356A 3149 3148 398B 3569 2D48"
	$"2D48 398B 3169 3149 316A 358A 316A 3169"
	$"3169 2D28 358B 3DAC 3DAC 2D28 3569 358A"
	$"2D48 356A 358A 358A 39AB 398B 3569 3DAB"
	$"3569 3569 398A 398B 3DAB 41CC 398A 2D27"
	$"3149 39AB 356A 3169 356A 398B 3149 2D28"
	$"2928 2928 3149 398B 356A 2D49 2507 2D48"
	$"2928 316A 2928 2D28 2D49 358A 0265 0629"
	$"2929 0829 282D 2829 2829 282D 49FE 314A"
	$"0031 6AFE 2D49 0131 6A31 6AFE 356A 0039"
	$"8BFD 356A 2939 8B39 8B35 6A2D 2835 6A39"
	$"8B39 8A35 6A35 6A31 6A31 4935 6A35 6A35"
	$"6935 8A35 6935 6A31 6935 6939 8A35 8A31"
	$"6935 6935 6A2D 492D 2829 072D 2831 4929"
	$"2829 2829 0729 272D 2829 2725 0729 2829"
	$"282D 482D 4929 272D 48FE 356A 0331 4931"
	$"4935 6A31 48FE 3569 0535 8A31 4835 6931"
	$"6931 4935 69FE 3149 0D31 6931 692D 2731"
	$"4831 6931 4931 692D 4831 4931 6931 482D"
	$"282D 2829 28FE 2D28 1D2D 4829 0729 0729"
	$"282D 482D 492D 4831 492D 282D 4931 492D"
	$"4931 4931 6935 6A31 4931 6931 6931 4920"
	$"E52D 2835 6A31 4929 2835 8A31 692D 482D"
	$"4935 6A31 48FE 3169 0535 6935 8A2D 4831"
	$"4935 6A35 69FE 3149 0235 6A31 492D 49FE"
	$"3149 1E35 8A2D 4831 4935 6A29 2731 4831"
	$"4835 6935 6931 4931 4931 6A35 6A31 492D"
	$"2831 4931 492D 2831 4931 4931 6931 6931"
	$"4835 6A2D 4825 072D 4835 8A35 6A35 6A31"
	$"69FE 2D48 7529 2831 4935 6A2D 4920 C510"
	$"6229 283D CD2D 4925 0720 E525 0720 E61C"
	$"C531 6A31 6A20 C61C C520 C520 C529 0724"
	$"E635 6A35 6A31 6A2D 4929 2825 0725 0729"
	$"2835 8B31 4931 6A35 6A04 0004 0025 072D"
	$"4929 482D 4829 2829 282D 2831 492D 4829"
	$"272D 4831 4925 0625 0635 6A29 281C A418"
	$"A431 6931 4929 2825 0729 2825 0629 2729"
	$"2831 492D 2820 C52D 2831 6A2D 2731 6931"
	$"4831 693D AB2D 482D 273D AB35 8A39 8A31"
	$"492D 4839 8A39 AC2D 4831 4935 8A39 8B35"
	$"6A31 6A35 8B31 6A2D 2839 8B39 8B3D CC3D"
	$"CC35 8A31 6939 8B35 8A35 8A39 AB35 8A39"
	$"AB39 AB35 6A35 6A39 AB39 8B39 8A35 8A39"
	$"8B39 8A39 AB31 6931 4935 6A35 6A2D 4831"
	$"49FE 358A 0E2D 4929 2835 8B39 AB35 8B35"
	$"8A31 692D 282D 4935 6A3D AC31 6A2D 282D"
	$"2835 8B02 4801 2D29 2D4A FE31 4900 3169"
	$"FE31 6A00 356A FD31 6AF7 356A 0635 8A39"
	$"8B35 6931 4935 6935 8A35 8AFC 356A 1631"
	$"4935 6A35 6A31 6935 6935 6931 4935 6931"
	$"692D 2835 6931 6931 492D 482D 4831 6A31"
	$"4931 6935 6A31 4931 4931 6931 69FD 356A"
	$"0631 6931 6935 6A35 6935 8A35 6A31 49FE"
	$"3148 0035 8AFD 3569 1531 4835 6929 272D"
	$"4831 6931 4931 4835 6931 4831 4835 6935"
	$"6931 4831 4931 4831 6931 6931 482D 4931"
	$"492D 282D 28FE 3149 2931 6935 6A31 6A29"
	$"272D 2839 AC35 6A31 492D 282D 492D 4931"
	$"492D 4931 492D 2831 492D 272D 4829 272D"
	$"4831 692D 482D 4931 6A2D 492D 4831 6935"
	$"6A31 6A31 6A2D 4929 2829 2729 072D 2835"
	$"6A31 6929 2729 2731 6A31 6931 49FE 2D49"
	$"0235 8A35 6A2D 48FE 3169 0635 6A31 482D"
	$"4831 6931 6931 4931 49FC 356A 0E2D 2831"
	$"4939 8B35 8A35 8A35 6935 8A39 8A29 2714"
	$"832D 4935 8B2D 4931 6931 49FE 24E6 722D"
	$"282D 4831 492D 2820 C52D 2831 6A2D 4929"
	$"2829 2729 282D 4920 E625 0731 6A31 6A2D"
	$"2825 072D 492D 4829 2725 0735 8B35 6A29"
	$"2829 282D 492D 4931 6A2D 4825 0720 E535"
	$"6A29 0700 0008 2031 6A35 8B35 8B25 0725"
	$"0729 2720 E62D 482D 2829 282D 4931 6A29"
	$"0731 4931 6A2D 482D 482D 2831 6935 8A29"
	$"2829 282D 492D 4829 4831 4931 6A35 6A31"
	$"4935 6A35 8A35 6A35 6A2D 4839 8A35 8A2D"
	$"282D 483D AC3D AB39 8B35 8A35 6A3D AB3D"
	$"AC31 4935 8A31 6939 AB39 AB35 8A39 8B35"
	$"8A31 4939 8B39 8B39 AB39 8B39 AB41 CC35"
	$"8A35 6A35 8A35 6A35 6A39 8B39 8B35 8A39"
	$"AB39 AB35 6A31 6935 8A39 8B31 6939 8B31"
	$"6935 8A39 8BFE 358A 1139 AB39 8B31 4931"
	$"4935 8A39 AC31 4931 6935 6931 692D 4931"
	$"6A35 6A39 AC31 6924 E629 0735 8B02 5D0A"
	$"316A 356A 356A 3169 3169 356A 356A 316A"
	$"356A 356A 358A FC35 6A00 3169 FC31 4906"
	$"356A 356A 358A 398B 356A 356A 3569 FD35"
	$"8AFD 356A 0035 8AFE 356A 1635 8A35 6A35"
	$"8A35 6931 6935 6A31 6935 6A35 6935 6A35"
	$"8A31 6931 6939 8B35 8A35 6A35 8A31 6935"
	$"6A35 8A35 6A35 6931 49FE 3169 0135 6931"
	$"69FE 3148 0831 6935 6931 4831 6931 6835"
	$"6931 6935 6929 27FE 3149 0935 6935 6935"
	$"4931 4835 8A31 6935 6935 6931 6935 69FE"
	$"3169 7F31 492D 2831 6935 6A2D 4831 4935"
	$"6A35 6A31 6A20 E629 2735 8B2D 2835 6A2D"
	$"2829 2829 0731 492D 492D 2829 2731 4925"
	$"0629 072D 282D 482D 4929 282D 492D 4929"
	$"2831 8A35 8B1C C425 0720 E61C C514 8318"
	$"A414 8325 0635 8A25 0714 831C A425 071C"
	$"C518 A420 E620 E625 0731 6A20 E520 C52D"
	$"492D 2829 282D 4831 6A2D 4825 0625 0735"
	$"6B2D 4931 4931 6A35 6A31 4931 4929 072D"
	$"283D CD35 6A35 6931 6939 CB31 692D 482D"
	$"4935 AB31 6929 482D 282D 4931 4935 6A35"
	$"6A2D 482D 4831 6931 6931 4939 AB31 4935"
	$"6A2D 4829 2731 6A2D 4925 0725 0729 2839"
	$"AB31 491C C52D 4935 8B29 281C C529 282D"
	$"4929 2829 4829 4825 0729 0731 6A2D 2829"
	$"083D AC29 2800 0008 412D 4931 6A35 6A29"
	$"0739 AC2B 356A 20E6 2507 2928 2D28 3149"
	$"2928 2D48 39AB 2D49 2D48 2D49 358A 39AC"
	$"358A 2928 2D49 2D49 2928 3169 358A 356A"
	$"3169 398B 356A 3169 358A 3169 356A 39AC"
	$"358B 3569 39AB 3DAB 39AB 39AB 3DAB 398B"
	$"358A 358A 356A 398B 358A 3DCC FD39 AB26"
	$"3169 358A 398A 398B 398A 398A 3DAC 3169"
	$"2D28 3149 358A 356A 39AB 39AB 398B 358A"
	$"316A 3149 358A 358A 316A 356A 398B 398A"
	$"356A 3169 39AB 398B 39AB 3DAC 356A 3149"
	$"3169 39AB 39AB 3148 3169 3569 3569 FE35"
	$"6A04 39AB 3149 3169 356A 358A 026E 0C35"
	$"6B35 6A35 6A35 6931 4935 6935 8A35 6A31"
	$"6935 6A35 8A35 6A35 6AFD 3569 0631 4931"
	$"4931 6931 4935 6935 6A35 8AFB 356A 0535"
	$"6935 6A39 8A31 6935 6935 69FE 356A 0035"
	$"69FE 358A 2835 6A35 6935 8A35 6931 6931"
	$"6931 4931 6935 6A31 4931 6935 6A35 6A35"
	$"8A39 8A35 6935 6931 6931 6931 4931 4935"
	$"6931 6935 6931 6935 6935 6931 6935 6935"
	$"6931 6935 6A35 6931 6935 6931 6935 6935"
	$"6935 6A35 4931 49FE 3569 0231 6935 8A31"
	$"49FE 356A 7F35 6931 6935 6A35 6A2D 4831"
	$"4831 6931 6929 0631 6931 6931 4935 6A2D"
	$"492D 4929 2825 0720 E62D 4931 6A2D 2831"
	$"4931 6931 6931 4931 492D 282D 492D 4931"
	$"6A31 6929 2720 E625 2729 272D 491C E510"
	$"621C C514 A418 A51C C520 E720 E62D 4931"
	$"6A14 8318 A418 A414 A40C 6210 6214 8420"
	$"E620 E618 A414 8318 A425 071C C414 8320"
	$"E625 2718 A418 A418 A525 082D 2829 282D"
	$"4931 692D 4835 6A31 4929 0731 6A29 2829"
	$"282D 492D 492D 4831 6A31 6A29 482D 6A29"
	$"2825 072D 4829 2839 AC35 6A20 E529 2729"
	$"0729 2835 6935 8A35 8A3D AB2D 4829 2831"
	$"6929 2829 2829 2731 6A39 AB2D 4920 E62D"
	$"4835 8B29 4820 E61C E625 2829 282D 492D"
	$"4824 E629 273D AC39 8B31 4A39 AC20 E500"
	$"000C 4131 6A62 358B 398B 3169 356A 2D48"
	$"3169 3149 2928 3149 3169 2D28 3149 398B"
	$"3169 2948 318A 358B 358B 316A 356A 316A"
	$"316A 2D49 316A 398B 358B 356A 39AB 3569"
	$"356A 356A 2D48 358B 39AC 358B 398B 3DAB"
	$"358A 398A 3169 39AB 3DAB 398A 358A 39AB"
	$"39AB 3DAB 39AB 358A 398B 39AB 39AA 3168"
	$"3148 358A 39AB 358A 3569 356A 2927 356A"
	$"356A 358A 3149 39AB 356A 3169 356A 3169"
	$"316A 3DAC 3169 3169 358A 358B 358A 3169"
	$"356A 358A 398B 39AB 356A 3149 398A 39AB"
	$"398B 398A 356A 398A 398A 3569 356A 356A"
	$"358A 356A 3149 356A 356A 398B 0265 0839"
	$"8B35 6A31 4935 6935 6A35 6935 6A35 6A31"
	$"49FE 356A 0D31 4935 6939 8A35 6A35 8A31"
	$"6931 4931 6931 4831 6935 6A39 8A35 6A35"
	$"6AFC 3569 0635 6A35 6A31 4935 6935 6931"
	$"4931 49FE 356A 0235 6935 6A35 69FE 356A"
	$"2335 692D 2831 4939 8B35 6A31 4931 6931"
	$"4835 6A31 4931 6A31 4935 6A2D 492D 282D"
	$"4831 4935 6A35 6935 6939 8A35 6935 8A35"
	$"8A39 8A39 8B35 6A2D 482D 2825 072D 4920"
	$"E625 0729 0824 E724 E6FE 3149 0435 8A31"
	$"692D 2835 6A35 6AFE 3149 0031 6AFC 356A"
	$"1D35 8A29 072D 272D 2835 6A2D 2829 271C"
	$"C514 A310 8214 6231 4939 8C2D 482D 282D"
	$"492D 492D 2825 0729 282D 492D 4931 4925"
	$"0620 E614 A310 8214 8314 8410 63FE 1484"
	$"7814 831C C629 2820 E72D 4929 2818 A418"
	$"C514 A410 830C 630C 620C 4225 0718 A510"
	$"6318 A418 A520 E71C C614 8318 8418 A418"
	$"A41C A51C C529 082D 4820 E625 0729 0729"
	$"2835 8B25 0729 282D 4924 E629 2831 6A20"
	$"E62D 282D 4929 2829 2831 492D 4839 8B31"
	$"6929 2731 6929 2829 2829 072D 4931 6931"
	$"6935 8A35 8939 AB39 8B39 8B35 6A29 272D"
	$"2835 6A39 AC39 8B35 6A31 4935 6A35 6A2D"
	$"282D 2835 6A39 8B31 6A39 8B31 692D 2831"
	$"6939 8B31 693D AB35 8B14 8300 0010 633D"
	$"CD3D CD35 8A35 8A31 4935 6A39 8B31 4931"
	$"4939 8B39 8B39 AB31 693D AC35 8A31 6939"
	$"AB35 6A31 6935 8A35 8A39 8B3D AC39 AB39"
	$"8A35 8A39 8A39 AB39 8B31 4835 8A39 AB35"
	$"6935 8AFE 398B 3631 6931 6935 8A31 4939"
	$"8A3D AB39 8B39 8B35 8A35 6A39 8B39 8B35"
	$"6939 8A39 8A39 8B39 8A35 8A39 AB39 AB31"
	$"6939 8B35 6A31 4935 8B35 8B35 8A2D 4939"
	$"8B35 6A31 4939 8B35 8A35 6A39 8B35 6A31"
	$"6935 8A39 8B35 6A35 6A35 8A31 6A39 8B39"
	$"8B31 6A2D 2835 8B3D AC39 AB39 8B31 6935"
	$"6A39 8B35 69FE 356A 0439 8A35 8A39 8A39"
	$"8A35 6902 6B07 356A 3149 3149 3569 3569"
	$"356A 356A 358A FE31 6A64 356A 3169 356A"
	$"398A 356A 356A 3149 356A 3169 3169 398A"
	$"356A 3569 2D28 356A 3149 3569 3569 3149"
	$"3569 3148 3149 3569 3569 3169 3149 3569"
	$"356A 358A 3569 3569 356A 356A 358A 398A"
	$"398B 356A 2D48 358A 3169 2D68 3169 2D69"
	$"2D48 2927 20E6 2908 2D49 316A 2507 24E6"
	$"2507 2507 3148 2D28 3149 358A 3169 39AB"
	$"3569 2907 2928 2507 1CC4 18A4 18A4 2507"
	$"1CC5 20E6 24E6 2507 20E6 316A 2D28 2D48"
	$"356A 24E6 24E6 2507 2928 2507 2D49 2928"
	$"316A 2D49 2908 2D29 3149 3149 2907 24E6"
	$"1CC5 2907 2927 1CE5 1CE5 1CC5 18C5 18C4"
	$"20E6 2928 FD25 070A 2D28 2928 20E6 2507"
	$"2928 316A 2507 1CC5 2106 1CC5 1082 FD10"
	$"8372 1063 1484 1484 18C5 18C5 20C6 314A"
	$"20E6 1CC5 1CC5 1CC6 1CE6 1CE6 18C5 18C5"
	$"2949 14A4 1CC5 20E6 1CC5 2507 2507 20E6"
	$"20C6 1CC5 2907 2907 3149 316A 2D49 2928"
	$"356A 2927 2506 3169 3169 358B 3169 2D49"
	$"358B 358A 2D49 316A 2D49 2D49 356A 356A"
	$"358A 3DAC 3569 2D48 2927 358A 39AB 356A"
	$"398B 358A 3149 398B 358A 356A 356A 398B"
	$"316A 316A 356A 356A 358B 39AB 358A 3149"
	$"398B 358B 356A 358B 398B 356A 356A 39AB"
	$"398B 358A 398A 398A 358A 3DAC 3DCC 1483"
	$"0400 1484 3DCD 3DAC 3169 398A 356A 398B"
	$"3149 3569 39AB 358A 356A 398B 39AB 39AB"
	$"2D48 3169 358A 2D48 358A 39AB 398A 398A"
	$"398B 39AB 398A 3149 FE39 8B08 3148 358A"
	$"398A 3569 398A 398B 358A 3169 3569 FE35"
	$"8A14 398B 39AB 398B 3DCC 356A 3149 358A"
	$"39AB 398A 3DAB 398A 398B 398B 398A 39AB"
	$"398A 356A 358A 358A 358B 358B FB35 6A1F"
	$"358A 3569 3149 3149 358A 3569 398B 398B"
	$"2D28 3149 3149 316A 358B 398B 3169 2D48"
	$"3149 398B 3DAC 398B 3149 356A 358A 398A"
	$"398B 356A 3569 398B 398A 398B 3149 356A"
	$"026D 0835 6B35 6A31 6935 6935 6935 6A35"
	$"6A39 8B35 6AFE 3169 0F31 4931 4935 8B31"
	$"6A31 4931 4935 6A31 4935 6A35 6A35 8A35"
	$"6A31 4931 6935 6931 69FE 356A 1D31 4935"
	$"6A2D 2835 6935 8A29 272D 2831 6931 6935"
	$"8A31 492D 4835 6A35 6A31 6931 6929 272D"
	$"492D 4929 282D 4925 0725 081C C618 A514"
	$"841C C525 0720 E620 E6FE 1CC5 1E25 0620"
	$"E520 E62D 282D 4939 8B29 2825 0625 0729"
	$"282D 4929 2731 6A31 692D 4929 2729 2731"
	$"4924 E62D 482D 4931 492D 2824 E61C C51C"
	$"C520 E629 2829 2820 E62D 49FE 2507 1A2D"
	$"2929 281C A524 E731 6A2D 4925 0720 E621"
	$"0621 0625 0629 2729 2829 2729 282D 4929"
	$"282D 2831 692D 4929 2829 2829 4825 0720"
	$"E621 0721 06FD 2507 0821 0725 071C C525"
	$"2825 071C E625 2831 6931 6AFE 2928 1A25"
	$"062D 4835 8A25 072D 492D 4924 E629 282D"
	$"2829 0731 4935 8B2D 4931 692D 4935 8A29"
	$"2831 4931 692D 4835 8B39 AB31 692D 4931"
	$"692D 6929 28FD 3169 6235 8A31 6A31 6931"
	$"6A35 8B35 8B35 8A39 8B31 4931 6931 6939"
	$"8A35 8A39 8A39 8A35 8A35 6A39 AB35 6A31"
	$"4931 6A39 8B35 8B35 8B39 8B35 6A39 8B3D"
	$"AC2D 4929 0731 6A39 AC39 AB35 8A35 6A31"
	$"6A35 6A39 8B39 8B35 8A35 8A39 AB35 6A31"
	$"693D AC14 8308 2118 A53D CD39 AC35 6A35"
	$"6935 8A39 AB35 8A35 8A35 6A39 8B39 8A31"
	$"4835 6A31 4931 6939 AB35 8A31 6939 AB39"
	$"AB35 6931 6935 8A39 8A35 6935 6A39 8B39"
	$"8B39 AB35 8A39 8A31 6931 4939 8A39 AB35"
	$"8A31 6939 8A39 AB3D AB35 6935 8A39 8B39"
	$"AB35 6A31 4939 8A3D AC39 8A3D AB3D ABFE"
	$"398A 2D39 AB3D AB39 AB35 8A31 6935 8A39"
	$"AB35 6A31 4939 8B39 8B31 4935 8B39 8B39"
	$"8B35 6A31 4831 6935 6A39 8B35 6A35 6A31"
	$"4931 4935 6A35 8B39 8B31 6A31 492D 4835"
	$"6A39 8B39 8B35 6A31 4935 8A39 8B35 8A3D"
	$"AB31 6935 6A39 8B31 4931 4935 8A35 8A02"
	$"6600 398B FD35 6A02 3569 356A 356A FE31"
	$"693F 2928 2506 24E6 2507 20E6 2907 2907"
	$"3149 356A 356A 3149 356A 398B 3169 2928"
	$"2907 3149 3149 2506 2D28 356A 2D29 20E6"
	$"314A 316A 1CC5 20E6 24E6 2907 2D49 24E6"
	$"24E6 356A 356A 2D49 2D28 1CC5 20C5 20E6"
	$"2D49 2928 2507 2949 2507 1CC6 18A4 2907"
	$"2507 2507 2D28 2928 2907 2D48 2D49 24E6"
	$"2507 2928 2928 3149 2D28 2507 2908 2D49"
	$"356B FE31 6A0E 3149 2D49 3149 3149 2D28"
	$"356A 316A 2D28 2928 3149 3149 2D49 2D28"
	$"316A 356A FE31 49FE 316A 1529 2825 0735"
	$"6A35 6A31 6A31 6931 6931 492D 2831 4931"
	$"4931 6931 4935 6A35 6A31 4935 6A35 6A31"
	$"4929 0831 4935 8BFE 2D49 3D29 282D 4931"
	$"6A2D 4931 4931 6A35 8B2D 4935 8B31 6A2D"
	$"282D 4931 6A35 8B2D 4831 6931 6924 E629"
	$"2835 8B2D 2835 6A35 8B2D 4931 4931 492D"
	$"4835 8A35 8A35 6A35 6A31 6A31 6A2D 4835"
	$"8A31 6931 6A39 8B35 8B35 8A35 6A31 6A2D"
	$"482D 6935 8A2D 492D 2835 8A39 AC31 6A35"
	$"6A35 8A31 6A35 6A31 692D 482D 4835 6939"
	$"8B39 8B35 6931 69FE 358A 1035 6A2D 4831"
	$"4935 6A39 8B39 8B35 6A35 8A31 6A31 6A35"
	$"6A31 6A31 4935 8B39 8B35 8B35 8BFC 356A"
	$"3231 6935 8A35 8A31 6931 493D CD14 830C"
	$"421C C641 EE3D AC31 6A31 6935 6A39 8A39"
	$"8A35 6A31 693D AB39 8A31 4931 6935 8A39"
	$"AB39 8B35 8A39 AB39 AB35 8A35 6A35 6A3D"
	$"AB35 6931 493D AB39 AB39 AB39 8B35 8A35"
	$"8A31 692D 4835 8A3D AC39 AB35 8A39 8A39"
	$"AB3D CC35 6935 6AFE 398A 2835 8A39 8B39"
	$"8A35 6A39 8B3D AB39 8A39 8A35 8A39 AB3D"
	$"CC39 AB35 8A31 6935 8939 AB35 6A31 6A39"
	$"AB35 6A31 6A39 8B39 AB39 8B39 8B35 6A35"
	$"8A39 8B39 AB35 6A35 6931 4935 6A39 8B35"
	$"8B31 6A31 4935 8A31 4935 8B35 8BFE 356A"
	$"0A35 8A35 8A31 6935 8A35 8A35 6A31 6931"
	$"6935 6A39 AB31 6A02 7912 356A 316A 3149"
	$"3169 3149 3169 2D48 2928 2508 2507 20E7"
	$"1483 1083 1484 1483 1483 1463 1884 2D49"
	$"FE31 6A4A 358B 358B 2908 24E7 24E7 2D28"
	$"2928 1CA4 2907 316A 2D49 20E6 20E6 2908"
	$"18A4 2507 2D49 2D49 2928 24E6 2D48 356A"
	$"316A 2D49 2928 2907 2928 2927 316A 2D48"
	$"2D49 2D49 316A 2507 2927 39AB 358A 2D49"
	$"2D49 3149 3169 358B 3169 2907 2D48 2D48"
	$"2D49 3149 2928 2928 3149 3149 316A 356B"
	$"356A 356A 3149 2D49 3169 356A 2928 356A"
	$"356A 2D48 3169 3169 356A 356A 3169 356A"
	$"356A 3169 3149 3149 356A FE31 497F 3169"
	$"3169 3149 3169 3149 3149 356A 356A 3169"
	$"3169 358A 358A 356A 3149 3149 356A 3169"
	$"2927 2907 3169 316A 3169 2D49 316A 2D28"
	$"2D48 316A 2D49 356A 398B 356A 3149 358A"
	$"398B 3569 3148 316A 356A 2D48 358A 3DAC"
	$"2D49 2D28 3149 2928 358B 316A 2D49 3169"
	$"3169 3148 3569 358A 358A 356A 316A 3149"
	$"3169 356A 356A 3569 356A 398A 398A 356A"
	$"3169 2D27 39AB 358A 2D49 358A 358A 3169"
	$"2D48 358A 356A 358A 356A 2D48 2D28 358A"
	$"3169 3169 356A 358A 3169 3169 3149 2D48"
	$"2D28 2D48 3169 356A 356A 398B 356A 356A"
	$"3149 2D28 3DAC 3DAC 358A 358A 356A 358B"
	$"358A 358A 316A 3169 3149 2D48 2928 2D49"
	$"358A 2D28 3DAC 39AC 1062 0C41 20E6 39CC"
	$"3169 2D69 2D69 3149 356A 356A 398B 3F31"
	$"4935 6A39 8B35 6A35 8A39 AB35 8A35 6A39"
	$"AB3D CC20 C520 E63D AC35 8A35 6A31 692D"
	$"2831 6931 6935 8A39 8B39 8B35 6A31 6931"
	$"6A31 4935 6A35 8B31 6A2D 4935 8A39 AB31"
	$"4935 8A35 6A39 8B3D CC39 8A39 8A39 8B2D"
	$"2831 6939 8B39 AB39 AC35 8A31 6A31 6A39"
	$"AC39 AB35 8A31 6939 8B39 AC39 8B35 6A2D"
	$"4935 6A35 8B39 AB35 8B35 8A31 6A31 49FE"
	$"39AB 1535 8A31 4935 6A35 6A35 8A31 6939"
	$"8B39 AB39 8A2D 4931 6A39 8B35 8A35 6A35"
	$"6A39 8B35 8B31 6A35 8B35 6A31 6A31 6AFE"
	$"356A 0276 2131 6A31 492D 492D 482D 4829"
	$"281C C414 831C C518 A518 A418 A41C C520"
	$"E618 A418 A414 631C C529 282D 2835 6A35"
	$"6A31 6A2D 4925 072D 2829 2835 6A35 6A2D"
	$"4931 6A35 6A35 8B2D 29FE 2908 1931 6A39"
	$"8B35 8B31 492D 4935 8B31 6A2D 4931 6A31"
	$"6931 4935 6A2D 492D 4931 692D 4929 2835"
	$"8A2D 482D 4935 8B35 8A31 6A31 4931 6A2D"
	$"49FE 2D28 2531 6A35 6A31 6A31 6931 4931"
	$"4931 6A35 8B35 8A2D 4931 6931 6A29 2731"
	$"6939 8B35 6A31 6935 8A31 4931 6935 8A31"
	$"4931 4935 6A31 6A35 6A35 8A31 6931 6935"
	$"6935 6A31 4839 8A39 8B35 6931 4835 6935"
	$"69FE 356A 0031 6AFE 3169 2535 6A2D 282D"
	$"2831 492D 492D 4831 4931 4935 6931 6A2D"
	$"4929 282D 4920 E61C C529 072D 282D 4935"
	$"6A31 4931 4939 8B35 6A29 2725 0631 6931"
	$"6931 4935 6A39 AB35 6A31 692D 4829 2831"
	$"6A29 2831 492D 49FE 3169 7F35 6A35 6935"
	$"8A35 6A31 4931 6931 6A35 8B35 8A31 6935"
	$"6A39 8B35 8A31 4931 6935 8A31 6A31 692D"
	$"4831 692D 4835 6A39 AC31 6A31 4931 4939"
	$"8B31 6931 692D 282D 2731 4935 8B31 6929"
	$"282D 2831 6935 6A35 8A35 6A31 6A35 6A35"
	$"6A31 6935 8A31 4931 693D CC2D 2824 E62D"
	$"4835 8A35 8A31 6A35 6A31 6A2D 282D 2835"
	$"8A2D 4831 6A31 6A31 4935 8B2D 4918 831C"
	$"C52D 492D 4829 4829 2729 4835 6A39 AC31"
	$"4924 E62D 4839 8B35 6A31 4931 6935 8B31"
	$"6931 6935 8A2D 4808 2029 2741 ED35 8A29"
	$"2829 2720 E625 0725 072D 4935 AB31 6A29"
	$"282D 493D CD2D 4929 072D 492D 492D 2831"
	$"6A31 6A2D 4935 8B31 4939 8B39 AB35 8A31"
	$"693D AC31 4931 6931 6A39 8B39 AB31 6A25"
	$"0720 E635 8B39 AC39 AB39 AB22 398B 398B"
	$"316A 356A 356A 39AC 39AC 358B 356A 39AB"
	$"2D48 2D49 3DCC 398B 358B 356A 3169 356A"
	$"316A 316A 356A 356A 398B 398B 2D28 356A"
	$"39AC 358B 3149 316A 358B 316A 2D49 316A"
	$"358A FE35 6A01 316A 2D49 0268 1E31 6A31"
	$"4931 492D 492D 2829 2720 E625 072D 4920"
	$"E629 2831 6A31 6A29 2829 282D 492D 2831"
	$"4931 6931 6935 6A31 6A35 8B35 8B31 6A2D"
	$"4929 2831 6A35 8B31 492D 49F8 356A 152D"
	$"492D 4931 6A2D 492D 4931 6A2D 282D 4935"
	$"8A35 6A35 8A35 8A29 272D 2835 6A2D 4831"
	$"6A35 8B31 6A31 6A31 6931 6AFE 2D28 0331"
	$"4939 8B31 492D 28FE 3149 2931 6935 8A31"
	$"6A2D 482D 492D 4929 2835 8B35 6A2D 4831"
	$"6931 4935 6A31 6931 4931 492D 2835 6A31"
	$"4931 6939 8B31 6931 4935 6935 6A35 6A3D"
	$"AB39 8A35 6935 6931 4839 8A39 8B35 6A31"
	$"6935 8A31 6A2D 4931 6931 4931 4931 69FE"
	$"3149 FE35 6A5B 2D28 2507 2D28 2908 1CC5"
	$"20E6 2507 20E6 2D28 3169 3149 3149 3169"
	$"2D48 3149 2D48 3169 2D48 3149 3169 358A"
	$"356A 3148 2927 2928 20E6 1CC5 2D49 2D49"
	$"356A 358A 3149 3169 358A 398A 3169 356A"
	$"358A 358B 2D49 2D48 3149 3149 358B 358B"
	$"316A 3149 2D49 2927 2D28 2D48 356A 3169"
	$"2D49 356A 358B 2927 2927 3149 2D28 358A"
	$"3169 2D48 3149 316A 3169 2D48 3149 358A"
	$"358A 356A 356A 358A 3169 3149 3169 398B"
	$"358A 39AB 358A 2927 24E6 2D48 356A 398A"
	$"358A 356A 2D48 2907 356A 358A 2507 FE2D"
	$"4968 2D48 358A 3169 2D49 2D48 2928 2D49"
	$"2507 2928 2D49 2D49 24E6 20C5 356A 39AB"
	$"3169 2D28 3169 358B 316A 3169 2D48 2928"
	$"2506 316A 398B 39AB 2D49 2D49 2928 2507"
	$"2507 2928 2928 2507 2507 316A 39AC 356A"
	$"2D29 2D28 316A 2D49 316A 316A 358A 398B"
	$"2927 2D28 2D49 3149 316A 3DAC 3169 358A"
	$"398A 398A 358A 3169 2D28 1CC5 2907 2D49"
	$"356A 39AB 3149 356A 3169 316A 356A 358B"
	$"358B 356A 3169 358A 2D48 398B 39AB 316A"
	$"358A 316A 3149 316A 356A 316A 358A 3169"
	$"316A 3169 2D49 358A 316A 2D49 2507 2928"
	$"2928 316A 39AB 3149 316A 3149 2928 2D48"
	$"3149 316A 0267 2031 6A31 4931 4931 6931"
	$"692D 492D 4939 8B35 8B29 282D 4935 6A35"
	$"8A31 6A31 6935 8B31 4931 4931 6935 6A35"
	$"6A31 6A35 8B35 8B35 8A31 6A2D 4931 6A31"
	$"6A2D 492D 4929 282D 28FD 356A 0035 8BFE"
	$"356A 1031 6A2D 2831 4931 6A31 4931 6935"
	$"6A35 6A35 8A39 8A35 692D 4835 6A2D 4829"
	$"2731 6A39 8BFD 316A 152D 4931 4935 6A35"
	$"6A31 6A29 0731 6935 6A31 4935 8B35 8A2D"
	$"2831 4931 6931 492D 4831 4939 8B35 6A2D"
	$"2835 6A31 49FD 3169 2E31 6A35 6A31 4931"
	$"4931 6935 6A35 6935 6A39 AB39 AC31 6A25"
	$"0724 E629 072D 4935 8A35 8A39 8A31 6931"
	$"6931 492D 4931 6A35 8B2D 492D 4931 4935"
	$"8B29 272D 2839 AB35 8A29 0729 2831 492D"
	$"492D 4825 0725 062D 2831 4929 0724 E625"
	$"0625 0629 2731 49FE 2D28 0931 6931 492D"
	$"4920 C529 2731 4935 6A29 2720 E52D 49FE"
	$"356A 152D 2831 4935 692D 282D 4939 8B35"
	$"6A2D 491C C52D 2831 4935 6A31 6935 8B35"
	$"8B29 2829 0729 2829 2835 8A31 492D 28FE"
	$"3169 172D 4931 4931 4931 6939 AB31 4931"
	$"4935 8A35 6A39 8B35 8A39 8B35 8A2D 4831"
	$"6A39 8B31 6939 8A39 8A35 8A35 6A35 693D"
	$"AB39 8AFE 358A 0F39 8B39 8B35 8A31 692D"
	$"482D 2831 4931 6A2D 4829 2831 6931 4931"
	$"4939 8B31 4831 49FE 316A 1131 4935 6A31"
	$"492D 4929 2835 8A2D 4835 8A2D 492D 4939"
	$"8B39 AB35 8A31 6935 8A35 8A29 2731 69FE"
	$"356A 4C39 AB31 692D 4831 6931 6931 4935"
	$"8A31 6A31 6A2D 4935 6A39 AB31 4931 6929"
	$"2835 8B35 8A39 AB35 6A25 0620 E525 072D"
	$"4935 8A35 8A31 6935 8A39 8A2D 4831 6935"
	$"8A31 6A2D 492D 492D 4829 2835 6A31 4935"
	$"8B39 8B35 6A2D 282D 4935 6A39 AC39 8B2D"
	$"492D 4839 8B35 6A35 8A35 8B39 AB29 2829"
	$"2735 8B39 AC35 8A2D 492D 4829 2720 E531"
	$"6A35 8B35 8A31 692D 4829 2835 8B3D AC2D"
	$"2831 492D 482D 2831 492D 4931 4A02 780E"
	$"2D49 2D29 314A 356A 316A 2D49 3149 356A"
	$"356A 3149 3169 3149 356A 3149 3149 FE35"
	$"6A18 3169 316A 3149 3149 356A 356A 358B"
	$"316A 3149 356A 3149 356A 316A 2D28 3149"
	$"398B 356A 2D49 3149 356A 316A 3149 3149"
	$"316A 2928 FE2D 4916 316A 356A 316A 3149"
	$"2D49 2D28 2D48 2D49 2D49 2928 316A 356A"
	$"316A 3169 3169 356A 2D28 3149 3149 2D28"
	$"398B 3149 3149 FE35 6A7F 3149 2D28 3149"
	$"316A 2D48 2928 3169 358B 2D49 2D28 3169"
	$"3169 2D49 356A 39AB 358B 356A 316A 3149"
	$"2D28 2D28 3149 3149 3169 358B 39AC 2D49"
	$"2928 2507 2927 3169 358A 398B 3149 2907"
	$"2507 2907 2928 316A 358B 2D49 2D28 2D49"
	$"2D49 2507 2928 356B 2D49 2D49 3149 2927"
	$"316A 2928 1483 2927 2928 24E6 2507 20E6"
	$"2907 2928 2D49 316A 2D28 356A 316A 316A"
	$"2D49 2507 2507 316A 2948 24E7 2D49 2D29"
	$"316A 356A 2D28 3169 398B 356A 2928 2507"
	$"358B 316A 1CC5 20C5 2928 356A 358B 39AC"
	$"1483 20E6 316A 3149 358B 3169 2D48 316A"
	$"2507 2927 39AB 356A 2D48 2D49 2D49 3149"
	$"316A 3149 2928 3169 358A 2D28 3149 356A"
	$"358A 2948 316A 358A 2928 398B 398B 2D48"
	$"3169 356A 398B 358A 358A 0131 6A39 8BFE"
	$"358A 3431 492D 4829 2731 6A35 8A35 8A35"
	$"8B31 6A2D 4931 6935 8A39 AB2D 2835 6A35"
	$"6A39 AB31 492D 4935 8B31 4A31 4935 6A35"
	$"6A2D 4935 8A35 6A35 8A31 4935 8A35 8B2D"
	$"4935 8B31 692D 2835 6A39 AC35 6A31 6A35"
	$"6A39 8A35 6A3D CC31 6935 8A3D AC31 6A35"
	$"6A35 6A39 AB3D AC2D 4829 072D 48FE 39AB"
	$"3A2D 4929 2831 693D AC35 8B25 0729 2731"
	$"4931 6A31 6920 C52D 2831 4A31 6A31 6A35"
	$"6A31 6931 6939 AB39 AB3D AB3D AB35 8A31"
	$"4935 6939 8A35 6A31 4929 0729 2831 4931"
	$"6A35 8A39 AC39 8B24 E624 E631 4931 6A24"
	$"E629 2839 8B20 C520 C539 8B35 8B39 8B35"
	$"8B2D 4931 4935 6A39 8B31 6931 492D 2835"
	$"8A35 8A31 4931 4902 7E4A 316A 356A 316A"
	$"356A 3149 3149 356A 3169 2D28 2927 2D28"
	$"2D28 3149 3149 2D48 3149 356A 3149 2D28"
	$"316A 3149 2D28 2D28 2D49 2D49 2928 2928"
	$"356A 3149 3149 316A 356A 358A 3149 358A"
	$"3149 3149 398B 3149 2D49 2D49 358B 2D49"
	$"2928 2927 2D49 316A 3169 2D49 2D48 2506"
	$"2507 2D48 2D48 3169 2928 2928 316A 3149"
	$"3149 356A 356A 3149 3149 2907 3149 398B"
	$"316A 3149 358B 316A 2928 2D28 2D49 2D28"
	$"FE2D 497F 316A 3169 2D49 356A 2D49 358A"
	$"316A 358A 39AB 3169 316A 356A 316A 3149"
	$"2907 3149 316A 2928 2D28 316A 3169 356A"
	$"2D48 2D48 3169 398A 316A 2928 2928 2D28"
	$"2D49 2D48 316A 358B 3169 316A 3169 358A"
	$"2D48 2927 3169 356A 358B 3149 316A 2D49"
	$"2D28 2928 3149 316A 2507 2D49 3149 20E6"
	$"2928 358B 316A 2927 3169 2927 2D28 2928"
	$"316A 358B 20E6 14A4 1062 2507 3DCD 39AC"
	$"18A3 20E6 358A 398B 2928 20C5 3169 39AB"
	$"358B 2907 24E6 2927 356A 41EE 2D49 1483"
	$"1CE5 316A 39AC 398B 316A 356A 316A 2928"
	$"2907 2D28 2D28 3169 2D48 2D28 3149 356A"
	$"316A 3149 2928 314A 314A 3149 2D49 2928"
	$"2D49 39AC 2907 3149 41ED 2927 2907 39AB"
	$"39AB 2927 2D28 3169 358A 398A 358A 398A"
	$"3169 358A 6935 692D 2739 AC35 8B31 6925"
	$"0731 6925 0731 6935 8A31 6A31 692D 4935"
	$"8B31 6A25 0729 282D 492D 282D 4835 8B31"
	$"6A35 6A31 4935 6A39 8B31 4835 6A35 8A31"
	$"6A35 8A31 6A35 8A39 AB35 8B35 6A31 692D"
	$"4831 6935 6A39 AB35 8A39 8A35 6929 2735"
	$"6935 6935 8A39 AB31 6931 6835 8A35 8A31"
	$"6931 692D 4825 0735 8B3D AC31 6A25 0720"
	$"E62D 2831 6A2D 491C C425 072D 4935 6A39"
	$"AB35 6A2D 482D 4839 AB39 AB35 8A39 8A39"
	$"8A35 6A39 8B35 8A2D 482D 2831 4935 6A31"
	$"6A39 8B35 6A31 6935 6A31 4929 072D 282D"
	$"4931 6A39 AC35 8B25 0731 4935 6A31 6A31"
	$"492D 482D 4835 6A35 8BFE 358A 0435 6939"
	$"8B31 4931 4935 6A02 691C 398B 356A 2D49"
	$"2D49 2928 2D28 358B 3149 2907 2927 2D49"
	$"2D48 3149 358A 3149 316A 3149 24E6 2507"
	$"3169 2D49 2907 2907 2927 2928 2D28 3149"
	$"356A 2D49 FD31 492D 2D48 398B 356A 3169"
	$"3149 3149 316A 356A 3DAC 3169 2927 2928"
	$"3169 398B 316A 2928 2907 2927 356A 358A"
	$"2D69 2D48 2D48 358B 316A 2907 2D28 316A"
	$"2D28 356A 358A 2D28 3149 3169 3169 3149"
	$"398B 316A 2507 2928 3149 3149 358A 358B"
	$"316A 2D49 FE31 6A0C 2D49 2D49 316A 3169"
	$"2D49 316A 358B 358A 2D49 2928 2D49 3169"
	$"3169 FE2D 490D 2D28 358A 398B 398B 3149"
	$"2D49 2928 2927 2928 358B 398B 316A 3169"
	$"3169 FE35 8A46 356A 3569 2D48 2927 2927"
	$"2D49 3149 3149 2928 316A 316A 3149 358A"
	$"2D28 2D49 2928 2506 3169 39AC 3149 2D48"
	$"2D28 2506 3169 2D49 39AB 2928 18A4 1CC5"
	$"1CE6 2507 3DCD 2D49 1CA4 358A 3DCC 3169"
	$"2D28 2506 356A 39AB 3DAC 356A 2D48 2907"
	$"2507 358B 316A 2506 2D28 39AB 39AB 2D49"
	$"2D49 356A 316A 358B 2928 20E5 2D48 358A"
	$"3569 3149 3169 358A 3149 3149 2D28 316A"
	$"3149 2928 FE2D 493D 2D48 2927 398B 39AB"
	$"2D27 358A 3DAC 2D48 24E5 3148 39AB 358A"
	$"3569 398A 3569 3569 398A 356A 358A 39AB"
	$"2D48 1CC5 18A4 39AB 3169 318A 316A 2928"
	$"2928 358A 318A 2927 2927 2D48 2D49 2D28"
	$"2D49 356A 3149 2927 356A 358A 398A 358A"
	$"3169 2928 3169 358A 358A 3569 3149 3569"
	$"3DAB 356A 2506 3149 356A 356A 358A 358A"
	$"2927 2D48 FD35 8A05 39AB 3569 3168 3569"
	$"2D48 3169 FE31 6A2B 3169 358B 356A 3149"
	$"358A 356A 358B 2928 2927 2D49 398B 39AC"
	$"3169 2506 2507 3169 3169 3149 356A 358A"
	$"356A 3DCC 356A 2D48 3149 358B 398B 316A"
	$"358B 356A 316A 398B 356A 3149 2D28 2D28"
	$"398B 398B 3149 3169 39AB 2D48 2D28 358A"
	$"FD39 8B01 356A 3149 FE35 8A02 3149 3169"
	$"398B 0270 2035 6B2D 2920 E620 E629 072D"
	$"4935 6A35 6A31 6A31 6935 6A2D 492D 4935"
	$"8A2D 2831 492D 4820 E629 2835 8B31 4929"
	$"282D 282D 4935 8A35 8B31 6A35 8B31 4931"
	$"492D 492D 2839 8BF9 356A 5635 8B35 8B2D"
	$"492D 4831 4931 6A31 4935 6A31 4931 4939"
	$"8B31 4931 6931 6931 4935 6A2D 4931 4935"
	$"8A31 492D 4935 6A35 8A2D 4829 2729 272D"
	$"282D 4831 6A2D 4829 282D 2831 4931 6935"
	$"6A31 492D 4929 282D 4831 6A35 8B31 692D"
	$"4931 6A29 2829 2735 8B39 AC31 6A29 282D"
	$"4831 6A29 282D 482D 4929 282D 4929 272D"
	$"4835 6A35 6A2D 4820 E525 062D 4929 2831"
	$"6A35 6A31 6A2D 4931 6935 8A2D 492D 4931"
	$"6935 8B25 0718 A429 2735 8B39 8B29 072D"
	$"4935 6A2D 492D 4931 69FD 2D48 7F31 6935"
	$"8A2D 482D 272D 4831 6931 492D 492D 4929"
	$"2829 4825 2729 282D 4935 8B31 4935 8A3D"
	$"AB35 6935 8A35 692D 482D 4839 8B39 8A24"
	$"E620 C52D 2825 0620 E62D 4829 072D 2835"
	$"6A2D 482D 4931 6A31 6A2D 282D 492D 4835"
	$"6A39 AB31 6931 492D 4831 4935 8A31 4831"
	$"6929 272D 4829 0725 072D 4831 692D 4931"
	$"6931 4931 4935 6931 693D AB35 6931 4831"
	$"6935 6935 692D 4831 6931 4931 6935 8A35"
	$"6A31 4939 8B39 AB25 071C C525 073D CD3D"
	$"CD35 8A2D 4929 2829 482D 6931 6A35 8B2D"
	$"4931 6931 6A2D 282D 2835 6A35 6A2D 482D"
	$"4931 6935 8A3D AB2D 4829 2735 8A35 8B35"
	$"8A31 4831 4839 AB39 8B35 6929 2731 4935"
	$"6A35 6A2D 2831 6931 6A35 8A2D 4931 6931"
	$"6929 2831 6935 6A35 6A2D 2825 0620 398B"
	$"358A 2927 2D48 316A 2D48 2D48 358A 358B"
	$"358A 39AC 358A 2D49 358A 398B 358A 316A"
	$"2D49 356A 358B 358A 358A 356A 3169 39AB"
	$"39AB 2D27 3169 398B 3DAC 3DAC 2D49 3149"
	$"FE39 8B17 358B 398B 356A 356A 358A 356A"
	$"358A 398B 39AB 2D28 2907 3DAC 3DAB 358A"
	$"3569 358A 3149 2927 3169 356A 358A 3169"
	$"3149 358A 0270 032D 4935 6A2D 2829 28FE"
	$"3149 1F35 6A31 6A2D 282D 492D 2831 492D"
	$"4924 E629 2831 492D 2831 4939 8B31 492D"
	$"2835 8B35 6A35 6A35 8A31 4935 8B31 6A31"
	$"492D 4935 6A39 8B29 0729 0729 2831 4935"
	$"6A31 6AFE 3149 1039 8B31 6935 8A31 6A31"
	$"4931 6A35 6A35 6A35 8B25 0618 A420 E61C"
	$"E618 A418 8329 0739 8BFE 3169 FE2D 490B"
	$"2D28 2927 2D28 356A 316A 3169 3169 3149"
	$"356A 356A 358A 2D48 FE2D 2853 358B 398B"
	$"2D48 316A 3169 2928 3149 398B 358A 2D48"
	$"316A 358B 356A 2D28 3169 3149 2928 2D28"
	$"2D49 398B 3149 3169 3169 2927 3569 398B"
	$"2D28 2D49 356A 316A 3169 358B 356A 316A"
	$"3149 2D28 356A 2507 2928 39AB 39AC 358B"
	$"20E5 2507 2928 316A 316A 2D49 2D48 356A"
	$"3149 3169 3169 358A 3569 2907 2D27 24E5"
	$"2907 358A 3149 2D48 2D27 3169 2D28 2D28"
	$"398B 39AB 358A 2D48 2907 356A 3149 2D28"
	$"2D28 356A 356A 2D48 2D48 356A 2D28 2928"
	$"3149 398B FE2D 2809 358B 398B 3149 2D49"
	$"2928 316A 358B 316A 2507 2D48 FE31 6909"
	$"2927 2927 2506 2D48 2D48 3149 2927 20E5"
	$"24E6 316A FE2D 497E 3169 356A 2907 3149"
	$"358A 3149 3149 356A 356A 3148 398A 39AB"
	$"3569 2927 356A 398B 2D28 2D28 3149 398B"
	$"358A 3169 3169 3149 2D48 3149 3DAC 398B"
	$"3149 356A 356A 2D28 3149 3569 3DAC 3DAC"
	$"3169 356A 358A 3DAC 356A 2D49 2D28 2D48"
	$"356A 398B 358B 358A 3169 398B 358A 3169"
	$"2D48 2907 2D28 398B 398B 356A 3169 356A"
	$"2D49 2D49 316A 316A 3149 2907 2D28 39AB"
	$"316A 2D49 3169 2D49 24E6 2928 3169 358A"
	$"3DCC 3169 2D48 2D28 3149 316A 3169 3149"
	$"316A 358A 358A 356A 39AC 358B 316A 358B"
	$"2D28 2907 356A 39AB 398A 356A 2D28 3149"
	$"3569 358A 398B 358A 356A 398A 356A 3149"
	$"3149 358A 398B 39AB 3569 3148 3DAC 39AB"
	$"3569 398A 398A 356A 3169 398B 398B 358A"
	$"358A 3569 398A 0273 0131 6935 8BFE 356A"
	$"2D31 4935 6A35 8A31 6929 272D 4939 8B39"
	$"8B31 6A31 4935 6A39 8B35 6A31 6A35 6A31"
	$"492D 2831 4931 492D 4931 692D 492D 4935"
	$"8A31 6A35 6A31 492D 2820 C524 E631 4935"
	$"6A31 6A2D 2831 4935 6A35 6A35 6939 8A35"
	$"8A29 0729 2829 282D 483D AC31 69FC 1CC5"
	$"6720 C52D 4935 6A29 272D 2831 4931 6A2D"
	$"492D 4931 4931 6A31 4931 6931 6A41 CD31"
	$"4929 072D 4935 6A35 6A31 4931 6A35 6A35"
	$"6A39 8B31 6A2D 4935 8B31 6931 6A35 8B35"
	$"6A35 8A39 8A39 AB35 8A31 6931 6935 6931"
	$"4935 6A35 6939 8A39 8B35 6935 6A39 8B39"
	$"AB3D AB35 692D 2835 8A35 8B35 8B35 6A31"
	$"4931 4935 8B2D 282D 493D CD29 2829 0735"
	$"6A35 8A31 6A25 0725 0735 8A35 6A2D 2831"
	$"4931 4935 8B29 282D 4931 6931 6931 4929"
	$"2731 4925 062D 4831 692D 4831 6929 272D"
	$"4824 E52D 4931 6A35 8A31 6A29 2829 272D"
	$"492D 2831 6931 6A35 6A35 8B35 6A31 492D"
	$"28FE 3149 3931 6A2D 4929 0729 0731 4935"
	$"6A2D 4829 272D 4835 8A35 8A31 492D 4831"
	$"4931 692D 4935 6A2D 482D 2831 6931 4831"
	$"4931 6931 691C C520 E631 6A2D 4935 8B2D"
	$"4831 6925 0725 0639 AC3D CC29 2729 2831"
	$"6931 6935 8A3D AB35 6A35 6931 6935 8A35"
	$"6A31 4935 6A35 6A31 492D 4831 6935 8A31"
	$"6A2D 482D 4831 6A31 6AFE 358A 4C35 6935"
	$"6A31 6935 8A35 6939 8B39 AB39 8A39 AB31"
	$"6931 4931 6935 6A39 8B35 8A2D 482D 4831"
	$"4931 6935 6A35 6A2D 4825 072D 4935 6A35"
	$"8A39 AB3D CC35 8A2D 482D 482D 492D 4931"
	$"4935 8A39 AB39 8B39 AB35 8A2D 4929 0729"
	$"2731 4935 8B3D AC39 AB2D 4929 272D 4831"
	$"6A29 2825 0729 2831 6A35 8B31 6A31 4931"
	$"492D 4831 6931 6A31 6A35 6A35 8A39 AB35"
	$"8A35 8A31 8A35 8A35 8A31 6935 8A35 6A2D"
	$"4831 4931 6931 69FE 356A 0F39 8B35 8A29"
	$"2735 6A39 8A35 6935 6A39 8A39 8A39 8B39"
	$"AB35 6A35 8A39 8A35 8A39 8B02 6C50 356A"
	$"358B 2D49 316A 316A 356A 398B 3DAC 356A"
	$"2D48 3149 39AB 398A 2D48 3149 356A 3DAC"
	$"356A 2D28 2907 2D49 316A 2928 2D28 316A"
	$"358A 2D28 3169 2D49 3169 316A 2D49 2D49"
	$"2928 316A 356A 316A 3149 2D28 398B 358B"
	$"356A 356A 3569 2D27 2506 2D49 2507 2907"
	$"3149 2D49 3149 3169 2D49 2D28 2D28 2928"
	$"2D48 2D49 356A 3149 3149 3169 3169 3149"
	$"356A 356A 2D28 3169 358A 3DAC 3149 2907"
	$"2D28 356A 356A 398B 39AC 356A 3169 356A"
	$"FD31 6A04 2D49 316A 356A 358A 398A FE35"
	$"8A06 398B 358A 3148 356A 3169 3148 3569"
	$"FE39 AB29 3569 3149 356A 398B 358B 3169"
	$"2D28 2928 2D28 3149 3169 3149 358A 356A"
	$"2506 2927 398B 316A 2D49 2D48 2D28 39AB"
	$"2907 20C5 2D48 316A 316A 2507 2D49 316A"
	$"358A 358B 2927 2927 2D28 3169 2D28 2907"
	$"3169 2927 2506 1CC5 FD2D 495A 2928 2507"
	$"2D29 2928 3149 316A 358A 398B 356A 2928"
	$"2928 3149 3149 2D49 2D28 3149 2928 2D28"
	$"3149 3169 3169 2D49 3169 358B 358A 2D48"
	$"2D48 356A 358A 3169 398B 316A 2D48 316A"
	$"2D28 316A 39AB 39AB 2928 2927 356A 358B"
	$"358A 358A 316A 2D48 358A 39AC 316A 2928"
	$"2D28 3169 3169 316A 3169 3149 358B 398B"
	$"356A 316A 3149 356A 3169 2D28 2D48 3169"
	$"398A 358A 2D49 316A 3169 2D49 316A 3169"
	$"39AB 3149 3149 356A 2927 2D48 398A 3169"
	$"358A 3169 3148 358A 39AB 39AB 3149 2927"
	$"2D28 FD35 8A2E 356A 2D48 3149 356A 3169"
	$"356A 3DAB 398A 3148 2927 2927 2928 2D49"
	$"3169 398B 3DAB 3DAB 3169 2D48 2D48 2D28"
	$"3169 39AC 39AB 356A 316A 2507 2907 316A"
	$"3DCC 2D49 24E6 2D49 39AB 39AB 2D49 2D28"
	$"2907 20E6 2507 2928 2D49 2D49 316A 358B"
	$"39CC 39AB FE35 8AFE 3169 162D 482D 282D"
	$"4835 6A35 8A35 6A35 8A35 8A31 6929 062D"
	$"283D AC35 6A31 6935 6A31 4939 8A35 8A35"
	$"6939 8A35 8A35 8A31 6902 702A 356A 316A"
	$"356A 3169 356A 398B 398B 39AB 3569 3149"
	$"3569 3569 3149 3149 398B 3DAB 3DCC 2928"
	$"2507 2507 316A 39AC 398B 316A 316A 3149"
	$"2507 2907 2928 358B 39AC 358B 2507 2907"
	$"3149 2D28 316A 356A 3149 356A 356A 358B"
	$"356A FE2D 4915 3169 2927 2507 24E7 2928"
	$"356A 3DAC 356A 3148 3148 2927 3169 3149"
	$"356A 316A 356A 398A 358A 2D27 2D27 2D48"
	$"2D28 FE35 6A01 358B 316A FC35 6A07 398B"
	$"358B 356A 356A 316A 3169 3169 358A FE39"
	$"8B7F 356A 356A 358A 358A 398B 398B 356A"
	$"356A 3169 3149 398A 3DAB 3569 356A 3148"
	$"3149 398B 3DAC 39AB 2D49 2D48 2928 2928"
	$"356A 358A 398B 398B 2927 2D28 358A 39AB"
	$"2D49 2D28 2927 2928 358B 2907 2948 358B"
	$"2D49 2507 20E6 2927 2D48 3169 2D49 2506"
	$"24E6 2928 2928 24E6 2507 2907 2D28 2D49"
	$"2D69 2D69 2107 1CE6 20E7 1CC5 1CC6 2929"
	$"2D49 2928 2507 2927 2D49 2507 2928 358B"
	$"3149 2D28 3149 356A 398B 356A 20E6 24E6"
	$"2927 358B 2D28 2D49 398B 3149 3169 316A"
	$"2927 3169 3169 358A 2D49 2D48 2D49 2D49"
	$"316A 39AC 3149 316A 356A 398B 358A 3169"
	$"356A 3149 316A 3149 3149 358A 356A 356A"
	$"3169 2D48 2507 2507 356B 358B 3169 2D48"
	$"2D28 3149 3169 3149 2D48 2D27 3148 3169"
	$"39AB 2335 6A39 8B31 6931 492D 4831 4931"
	$"692D 4839 8B31 492D 2735 6A35 6A31 4835"
	$"8A2D 2831 6939 AB39 AB39 8B31 4929 2731"
	$"4835 8A35 6A35 6931 492D 4831 6935 6A31"
	$"6A31 4931 4931 6A35 6931 69FE 316A 3031"
	$"6931 6939 AB41 CC35 692D 2731 4931 4831"
	$"6935 8A35 8B35 6A35 8A31 6A2D 4929 2831"
	$"4939 8B35 6A31 4939 AB3D AC39 8B2D 2829"
	$"0725 0725 0720 E625 0720 E614 832D 493D"
	$"CC3D CC3D AC35 6935 6939 8B39 AB31 692D"
	$"482D 282D 4831 6935 6A35 8A35 8B35 8A31"
	$"49FD 356A 0A29 0729 282D 492D 2831 6A31"
	$"4935 6935 6A35 8A39 8A31 4802 6D2A 356A"
	$"356A 358B 356A 3149 3149 358A 358A 398B"
	$"398B 2D28 2D49 3149 358A 3DAC 3DAC 358B"
	$"2D49 2D49 316A 358B 358B 316A 2507 2928"
	$"2D28 2D49 2D28 2D49 398B 398B 2D28 2507"
	$"2928 2D49 2D49 3149 2D49 3149 316A 3169"
	$"358A 2D49 FE29 2816 2D49 2D49 2928 2D49"
	$"2507 2D48 358A 2907 2D28 316A 3149 3149"
	$"2D49 316A 356A 398B 398B 3169 3149 356A"
	$"358B 3149 356A FE39 8B3B 3149 2D28 356A"
	$"356A 3149 3149 398B 3DAC 398B 358A 356A"
	$"356A 358A 398B 358A 398B 398B 358A 398B"
	$"3149 3149 3569 3DAB 398B 316A 3149 356A"
	$"3149 2D28 2907 2D28 3148 3149 3149 2D28"
	$"2907 2928 2D49 2928 2928 3149 2D49 358B"
	$"3DAC 356A 356A 358A 356A 316A 2907 20C5"
	$"2507 2D49 316A 2928 2928 1CC6 20E6 20E7"
	$"24E7 FE25 0704 2907 2928 2D49 2507 20E6"
	$"FE2D 492D 2928 2928 20E7 18C5 2107 20E6"
	$"14A4 18C5 20E7 2507 2507 2928 2507 2908"
	$"2D49 2D28 2507 3549 3569 358A 398B 3169"
	$"2928 1CC5 1CC5 20E6 2D29 2D29 2D28 2D48"
	$"2D48 358A 2927 1CC5 2D49 2928 358B 2927"
	$"2506 2D49 3169 2928 2D28 2907 3149 356A"
	$"FE2D 490F 2D28 2D28 3149 3149 3169 356A"
	$"3149 3149 2928 2507 2507 2928 2D49 2D49"
	$"2928 2D49 FE35 6A04 358A 2D27 2D27 2D48"
	$"3149 FE35 6A02 3169 2D28 2D49 FE31 494F"
	$"356A 2D28 3149 358A 356A 2D48 356A 356A"
	$"358A 358A 2D28 356A 358A 3569 3569 356A"
	$"316A 356A 3169 3169 398B 398B 316A 3149"
	$"3149 356A 3149 2D28 3569 398A 398A 358A"
	$"398A 3DAB 358A 2D48 3169 358A 358A 398B"
	$"398B 356A 3149 356A 356A 3569 2D28 3149"
	$"3DAC 39AB 39AB 398A 356A 2D48 2D28 316A"
	$"358B 398B 358B 356A 2507 1CC4 356A 3D8B"
	$"41CC 41AC 396A 3148 3148 3549 396A 3169"
	$"3169 2D28 3149 398B 39AB 39AB 356A 316A"
	$"FD35 6A0A 2928 2D28 2D49 316A 2D49 356A"
	$"398B 358A 398B 3169 2D48 0266 0131 4931"
	$"6AFE 3149 1A31 6939 8B31 6931 6A31 6A2D"
	$"4831 6A31 4931 6A31 6A31 6935 8A2D 4929"
	$"2839 8B31 6A2D 492D 492D 282D 2831 6A35"
	$"6A31 4931 4935 6A35 6A29 28FD 2D49 0529"
	$"2829 2831 692D 492D 4931 6AFE 2D49 172D"
	$"4831 6A31 6A2D 4935 6A2D 4931 692D 4925"
	$"072D 2831 6A35 6A31 6A31 4935 8B31 4935"
	$"6A31 4931 6939 8B31 4939 8B31 4931 49FE"
	$"356A 3731 492D 4935 6A31 4931 492D 4935"
	$"6A39 AC35 8A35 6A35 8A35 8A39 8B35 6A31"
	$"4935 6A31 6939 8B3D AC31 4931 6935 8B35"
	$"8A35 6A2D 4935 8B35 8A29 2829 2825 0725"
	$"072D 4931 4931 4929 0720 E629 282D 492D"
	$"4931 4935 6A35 8B35 8B39 8B31 692D 2831"
	$"6931 4931 6A25 0725 0729 282D 4931 492D"
	$"4935 6AFE 2928 132D 2831 4935 6A35 8A31"
	$"6A2D 492D 4925 0729 2831 6A2D 4925 0725"
	$"2725 0825 0725 0829 2918 C51C E621 07FE"
	$"20E6 1F25 0825 0729 2831 492D 4829 2835"
	$"6939 8B31 492D 2825 0720 E51C C525 072D"
	$"2831 4931 6A31 4931 4931 6A31 6925 062D"
	$"482D 4820 E631 6918 A418 A42D 4931 4929"
	$"2829 28FD 2D28 0431 4935 6A35 8A31 4931"
	$"69FE 356A 282D 2829 272D 2835 8A39 8B31"
	$"6931 6935 6A31 492D 4839 8B31 4935 6A35"
	$"6931 4939 8B39 8A35 6A2D 4835 8A39 8A31"
	$"6931 6935 6935 8A2D 4831 4931 492D 2831"
	$"6935 6A29 272D 2835 6A39 AB39 AB31 6931"
	$"6935 8A35 8A31 48FE 2D48 4631 6931 4931"
	$"4931 6931 6A35 6A35 6A31 6935 6A31 6931"
	$"6935 6A35 6A35 8A35 6A35 6A39 AB39 8B31"
	$"4831 6935 8A35 8A39 8A35 6A31 4824 E635"
	$"6A39 AB35 6A31 4939 8B3D CC39 8A39 AB35"
	$"6929 2725 0729 2835 6A35 8B39 8B39 8B35"
	$"6A31 4929 2831 4931 6939 AB35 8A31 692D"
	$"282D 282D 4835 6A39 8B39 AB31 492D 4831"
	$"6939 AB2D 4831 6931 6A2D 2831 4931 6A31"
	$"492D 282D 482D 492D 48FE 3149 0031 69FE"
	$"356A 0278 092D 2835 6A31 4931 4939 8B2D"
	$"492D 4835 8A35 6A2D 49FE 3149 0A2D 2824"
	$"E629 0735 6A31 4931 6A35 8B2D 492D 2831"
	$"4935 8AFD 3149 182D 2831 4935 6A31 6A31"
	$"6A31 4931 4931 6935 8A39 AB31 6924 E625"
	$"0631 4931 6A35 8B35 6A2D 4829 2835 6A31"
	$"6A35 6A31 6A2D 492D 49FE 316A 442D 492D"
	$"4935 6A39 AC2D 282D 482D 4839 8B35 6A2D"
	$"2831 6A31 4931 492D 282D 2831 4935 6A35"
	$"6A31 692D 2831 4935 6A35 6A39 8B31 492D"
	$"2831 6931 6935 6A31 6935 6A39 8B35 6A3D"
	$"CC39 AB2D 482D 282D 2829 0729 072D 4839"
	$"AC35 8B2D 482D 4825 0729 2731 6A31 6A2D"
	$"4829 072D 2829 2831 4935 6A35 6A39 8B35"
	$"6A39 8B35 6A31 4929 072D 282D 2835 8A35"
	$"8B2D 492D 4831 49FE 358B 7F31 6935 8A39"
	$"8A39 8B39 AB35 8A35 6A31 692D 492D 4829"
	$"2829 2825 0729 282D 4820 E520 E625 0725"
	$"0720 E625 0725 2821 071C E625 072D 492D"
	$"4920 E725 072D 4931 6A31 6A35 8B35 8B31"
	$"6A31 6929 2829 2825 0731 6A35 8B35 6A35"
	$"8A35 8A31 4931 692D 482D 282D 4829 2725"
	$"072D 4920 E625 072D 4929 282D 482D 4831"
	$"4931 6A35 6A31 6A35 6A31 6A31 692D 2835"
	$"6939 8B39 AB39 AB2D 482D 2831 493D AC3D"
	$"AB31 4931 4939 8B35 6929 2731 692D 2835"
	$"6A39 8B39 8B39 8A2D 2831 4929 0735 6A31"
	$"692D 2735 8A31 6931 6929 2739 AB35 8A31"
	$"4935 8A2D 4820 C52D 2831 693D AB41 CC39"
	$"AB39 8A31 6935 6931 692D 482D 482D 4931"
	$"4931 6A31 692D 4831 6931 4931 4935 6A35"
	$"8A39 8B31 6931 4835 6935 693F 398A 356A"
	$"3569 3DAC 3148 2927 358A 3DCC 398B 398B"
	$"3DAC 356A 2D48 3149 3149 356A 3DAB 398A"
	$"398A 3DAB 356A 2927 2928 2D29 3169 398B"
	$"3DAC 358A 3149 2D48 3149 398B 356A 3169"
	$"39AB 398B 358A 358A 398B 3DAC 39AB 358A"
	$"3149 2D48 3149 39AB 3169 356A 316A 2D48"
	$"316A 358B 2928 20C5 2928 356A 356A 358A"
	$"3169 3149 3149 2D49 2D49 356A 026D 3D35"
	$"6A3D AC31 6A35 6A35 8B29 0729 283D AC35"
	$"6A2D 4935 6A35 6A31 6929 0720 E62D 4939"
	$"AC35 8B39 8B31 6A31 492D 492D 4931 6931"
	$"6A31 492D 2831 4931 4935 6A31 6A35 6A31"
	$"492D 2831 6A31 6A35 8A35 8A2D 4825 0624"
	$"E629 0735 6A39 8B35 8B31 492D 2835 6A35"
	$"8A31 6A35 6A31 6A35 8B35 8B31 4929 2829"
	$"072D 4935 8B35 8B31 6A35 8AFE 356A 2B31"
	$"4931 4931 6A35 6A31 4935 8B35 6A35 6A31"
	$"6A2D 282D 4935 6A35 6A35 8B35 6A31 6931"
	$"692D 4831 6935 8A35 8A39 AB35 8A2D 4831"
	$"6931 4931 4929 0720 E624 E729 082D 4935"
	$"8B35 6A35 8A35 6A31 6931 4839 8A39 AB2D"
	$"4929 2831 4931 49FE 356A 0A35 8A39 8B39"
	$"8B31 692D 482D 2831 4931 4931 6A35 8A2D"
	$"49FE 2928 1D2D 4931 8A39 AB39 AC39 AB31"
	$"6A25 0725 0729 2825 072D 2835 6A39 8B31"
	$"6A25 072D 4829 2825 0625 0729 0729 2829"
	$"282D 4929 2825 0725 072D 4931 6A35 6B31"
	$"49FE 316A 0D2D 4935 8B35 8A35 8B31 6A25"
	$"0725 071C C52D 4939 8B39 8B35 6A2D 2829"
	$"07FE 3149 772D 4931 6A35 8B2D 4929 272D"
	$"4931 6931 6A35 8A31 4931 6939 8B39 AB35"
	$"6A29 072D 4829 0731 483D CC35 8A35 6931"
	$"4931 4931 6935 6A39 8B2D 4829 0739 8B39"
	$"8B31 4931 4931 6A31 4935 6A31 6935 6A31"
	$"4929 2735 8A25 0624 E620 E529 272D 4929"
	$"2729 2735 8A3D CC2D 4825 0629 072D 482D"
	$"4835 8A39 8B39 8A35 6A2D 2729 2731 4835"
	$"8A39 AB39 AB31 6A35 8A31 492D 482D 4931"
	$"6935 8A2D 4831 4935 6931 4939 8A39 8A35"
	$"8A35 8A31 6939 8A31 4935 693D AC35 692D"
	$"2731 6935 8A35 6A35 8A35 8A2D 4825 062D"
	$"2835 6A35 6A3D AC39 8B39 AB39 AB35 6931"
	$"4931 692D 4931 6935 6A35 6935 8A35 8A31"
	$"4935 6A3D AC35 6935 6935 8A39 AB35 8A35"
	$"693D AB41 CCFC 398B 0A39 AB2D 4829 0725"
	$"0729 2831 6A35 6A2D 4935 6A39 AB3D ACFD"
	$"356A 0331 492D 4931 4939 8B02 610F 356A"
	$"316A 2D28 2D28 3149 356A 358A 358A 3149"
	$"3169 356A 398B 358A 356A 358B 398B FD35"
	$"6A1C 358A 356A 316A 3149 356A 314A 2907"
	$"356A 3DAC 358A 356A 39AB 356A 2D28 3149"
	$"3149 356A 3149 358A 39AC 2D28 24E6 398B"
	$"356A 356A 3149 3169 2D49 356A FE39 8B14"
	$"316A 3149 2D28 3149 316A 356A 398B 39AC"
	$"356A 398B 358B 358A 356A 3149 3149 356A"
	$"398B 398B 3DAC 398B 398B FD35 6A37 3569"
	$"3169 3169 358A 3169 3169 398B 358A 356A"
	$"3169 3169 2D28 2D28 2D49 356A 3149 3149"
	$"2D28 3169 3569 356A 356A 398B 356A 3569"
	$"358A 3DAB 356A 3149 3149 356A 356A 358B"
	$"356A 356A 398B 398B 358A 356A 356A 2D28"
	$"3149 2D28 2908 2D49 316A 358A 3569 2D28"
	$"3149 358B 398B 356B 39AC 316A 2907 FE31"
	$"4903 356A 358B 398B 358B FD31 493D 2D49"
	$"2D49 2928 2D49 316A 316A 3149 3149 2D48"
	$"3169 356A 316A 2D48 2928 2D49 3149 316A"
	$"2D28 2D48 2D49 2D48 2D49 2907 2D48 316A"
	$"356A 2907 2D27 2D48 3149 2D49 316A 314A"
	$"2D49 356A 2D28 2D48 3569 358A 398A 358A"
	$"3149 356A 398B 358B 356A 3149 398B 2D49"
	$"3149 316A 2506 2928 3169 316A 356A 356A"
	$"358A 398B 358A 39AB 2D48 FD31 6916 358A"
	$"2D48 2507 2506 2D28 358A 20E7 14A4 20E6"
	$"2928 316A 356A 316A 3DAC 316A 2907 1CC5"
	$"2907 398A 358A 398A 358A 3149 FE29 070B"
	$"2D28 2D49 356A 356A 2907 3169 39AB 358A"
	$"3149 358A 3169 2D48 FE31 4906 398B 3DAC"
	$"3DAB 3569 3148 316A 3149 FD35 6A29 2D48"
	$"2D28 2D49 2D49 2D28 2927 2928 316A 316A"
	$"2D49 358A 3569 3148 3148 3149 358A 39AB"
	$"356A 398B 356A 2D28 3149 2D48 3149 358B"
	$"398B 3149 398B 356A 358A 2D48 356A 41CC"
	$"3DAC 356A 398B 396A 3169 3569 398B 356A"
	$"3149 FD2D 490B 3149 358B 356A 316A 3569"
	$"2D27 3149 356A 398B 398A 398B 398A 0270"
	$"1535 6A31 4A31 4931 4935 6A39 8B39 8A39"
	$"8B35 8B31 492D 4835 6A31 6A31 6A35 6A2D"
	$"2829 282D 282D 4931 492D 2835 6AFE 3149"
	$"2835 6A35 6A35 8A35 8A31 4935 8B35 8A31"
	$"6A35 8A31 4931 4935 6A31 6939 8B3D AC31"
	$"4931 4835 6A35 6931 6939 8B35 692D 4835"
	$"6A35 8A35 6A31 6A2D 282D 4831 4935 6A2D"
	$"4931 6A35 8A31 6A29 2835 8B31 6A2D 482D"
	$"2831 49FE 2D48 0531 4935 6A35 8A35 6A39"
	$"8A35 8AFD 3569 0F31 4929 282D 4839 8B35"
	$"8A31 4931 6939 AB39 AC2D 4929 2729 2729"
	$"0729 2739 8B35 6AFE 398B 0035 8AFE 398A"
	$"2339 AB39 8A31 4929 282D 2831 4931 4935"
	$"6A31 4931 6939 AB35 8A31 6935 6A31 6A2D"
	$"282D 2829 282D 2831 4935 6A39 AB35 6A29"
	$"0729 2735 6A35 8A35 8B3D AC31 692D 2831"
	$"4935 6939 8A31 6931 69FE 356A 1531 492D"
	$"282D 4829 2829 282D 492D 492D 482D 482D"
	$"492D 4825 062D 2839 8B2D 4829 0729 282D"
	$"2831 6A31 692D 492D 49FE 2D48 1429 2829"
	$"0735 6A35 6A31 4935 8A31 6931 4929 072D"
	$"4931 4831 4935 8A35 8A31 692D 4829 282D"
	$"4831 4931 492D 48FE 316A 7F39 8B35 6A2D"
	$"2825 0720 E51C C520 E62D 482D 4931 4931"
	$"6939 8A39 8B35 6A31 692D 4835 8A35 8A31"
	$"6931 4931 6931 492D 482D 492D 4829 2825"
	$"0825 0725 0729 282D 4935 6A35 6A35 8B31"
	$"6931 492D 2835 6A31 6931 492D 282D 2825"
	$"0725 0631 692D 4931 6935 6A31 6A2D 4831"
	$"6939 8B31 6931 6931 4935 8A39 8B39 8B39"
	$"AB35 8A31 4931 4935 6A35 8A31 4935 6939"
	$"8B35 8A31 492D 482D 4835 8A35 6A35 6A35"
	$"6931 6935 8A35 8A31 6935 6A35 6935 6A35"
	$"8A35 6931 4931 6931 6935 8A3D CC35 6939"
	$"8B39 8B2D 282D 4931 6A35 8B39 AB31 6A2D"
	$"2831 4931 4931 6A35 8A41 CC41 CD35 692D"
	$"0731 4931 4931 482D 2735 6A39 8B39 AB31"
	$"4929 2829 282D 4831 4931 6935 8A39 8B35"
	$"6A2D 282D 4835 693D AC39 AB01 398A 356A"
	$"0278 5435 8B35 8B35 6A31 4931 4935 6A35"
	$"6A39 AB35 6A2D 282D 2831 4935 6A31 492D"
	$"2831 4931 492D 2829 282D 2835 6A35 8A35"
	$"8B39 8B31 4935 6A35 6A31 4931 6A31 6A35"
	$"6A31 6A31 6935 6A31 6931 4931 6931 4939"
	$"8B35 6A35 6939 8A39 8A3D AB39 AB39 AB35"
	$"6A31 6A35 6A31 4935 6A31 492D 282D 4931"
	$"492D 2825 072D 4931 6A31 492D 482D 482D"
	$"492D 482D 4831 6935 6A2D 4831 6935 6A35"
	$"8A35 8A35 693D AB35 6931 4931 6935 8A39"
	$"8A2D 282D 4839 AC35 8B31 6931 69FE 358A"
	$"052D 4929 282D 482D 4935 8A39 8BFE 356A"
	$"7F35 8A39 8B3D AC3D CC3D AC39 8B39 8A35"
	$"8A31 492D 482D 4931 6935 6A31 6A35 6A35"
	$"8A35 8A39 8A39 AB39 8A35 6A2D 4831 4931"
	$"6A31 6935 8A39 8A31 692D 282D 4935 6A2D"
	$"2831 4935 8A29 2729 2725 0635 8A35 8A2D"
	$"4835 6A35 8A39 AB3D AC39 8B31 6931 482D"
	$"282D 4935 8B2D 4920 E620 E625 0729 2825"
	$"0629 0729 282D 4831 6931 6935 8A39 AB35"
	$"6A31 6A35 6A2D 4931 692D 492D 2831 6935"
	$"8A35 6A31 4929 2829 2839 8B2D 4835 8A35"
	$"6931 4831 6931 692D 4831 4931 4931 6A2D"
	$"4931 692D 492D 482D 2829 2831 6A2D 4929"
	$"2729 2729 2825 2721 0631 6939 AB35 8B31"
	$"6939 8A39 8A31 4831 4831 4931 4931 482D"
	$"4831 492D 482D 4929 282D 4829 282D 4831"
	$"6A31 8A25 071C A42D 2835 6A35 8B39 8B3D"
	$"AC10 3169 3169 3569 3169 3149 3149 358A"
	$"316A 2506 2927 2928 3169 358B 358B 316A"
	$"356A 3169 FE2D 4806 356A 3169 358A 3DAB"
	$"398A 2D48 2927 FE31 4938 2D49 3169 2D48"
	$"3169 39AB 39AB 398A 356A 356A 39AB 3569"
	$"2506 2D28 3569 356A 358A 3149 2D48 3149"
	$"316A 356A 358A 358B 356A 2927 358A 398B"
	$"2D49 316A 316A 2D49 2D49 2506 2907 2D28"
	$"3169 398B 3DAC 3DAB 3169 2907 2D28 398B"
	$"39AB 398A 2927 2D48 358B 398B 24E6 20E6"
	$"356A 358B 358B 398B 39AC 39AB FE31 4904"
	$"2D48 3169 3149 3169 3149 0275 FD35 6A4E"
	$"398B 398B 356A 398A 356A 356A 2D28 316A"
	$"358B 358B 398B 3DAC 356A 2D28 2927 2D28"
	$"316A 3149 356A 398B 358B 358A 356A 316A"
	$"358A 316A 316A 314A 3149 398B 358B 358B"
	$"39AB 39AB 316A 2D28 3149 356A 356A 398B"
	$"398B 316A 2D28 2D49 316A 358B 356A 3149"
	$"2D48 2507 2927 3149 316A 316A 356A 3149"
	$"358A 3169 3149 2D48 356A 398A 3DAB 3DAB"
	$"3DAC 3DAB 398A 3149 3569 398A 3169 3149"
	$"2D48 398A 3149 3149 356A 39AB 39AB FE39"
	$"8B00 358A FD35 6A0C 398B 358A 3169 358A"
	$"356A 358A 398A 3DAC 3DAC 3DAB 398A 39AB"
	$"3DAC FE35 8B7F 316A 358B 39AC 358B 398B"
	$"39AB 3DAB 3DCC 358A 3169 398B 39AB 3DAC"
	$"358A 39AB 41CC 3149 24E6 2907 2928 2928"
	$"2D28 316A 3149 2D49 2D48 2907 3DCC 3169"
	$"2D48 356A 3169 3569 358A 358A 398A 398B"
	$"3169 358A 39AB 3169 2928 2928 2507 2928"
	$"2D49 2D49 2D28 358A 39AB 39AB 358A 2D48"
	$"2928 358A 358B 3169 398B 2D28 2507 2D49"
	$"3569 3DCC 3149 2928 316A 316A 2D28 3569"
	$"356A 3148 3148 3149 398A 398A 356A 3569"
	$"316A 358B 316A 2D48 2D48 2928 2D49 2D49"
	$"2928 2D49 3169 316A 358B 358B 3169 2928"
	$"358A 3DAB 358A 2D48 2D48 3169 3149 2D28"
	$"356A 3149 2928 2D48 2507 2928 2D49 358A"
	$"2D69 2D69 18C4 20E5 39AB 358A 316A 356A"
	$"356A 3149 356A 356A 398A 356A 3DAB 3DAB"
	$"356A 2927 20E6 5425 062D 4939 AB31 692D"
	$"492D 492D 2831 6939 8B35 6A35 6A29 072D"
	$"4835 8A35 8A35 6A39 AB35 8A2D 2831 4931"
	$"6A35 8A31 6931 6939 AB3D AB2D 4829 272D"
	$"2831 6A2D 4925 0731 6A35 8B2D 482D 492D"
	$"492D 4831 6935 6A31 6A35 8A35 8A31 6A31"
	$"6A35 6A31 492D 4939 8B2D 4825 072D 4820"
	$"E629 282D 2839 8B3D AC39 8B35 6A2D 482D"
	$"4835 8A3D CC39 AB39 8A2D 482D 4831 6A35"
	$"8B2D 4931 6A39 AC35 8B35 8A35 8B35 8A31"
	$"692D 4931 6A35 6A2D 4929 2729 0729 2829"
	$"2802 7304 356A 314A 316A 356A 3DAC FE39"
	$"8B18 3149 2D48 2D28 3149 356A 316A 356A"
	$"3169 358B 39AC 2D49 2927 2928 2907 2D49"
	$"356A 39AB 398B 398B 3149 2D49 3169 356A"
	$"316A 356A FD35 8B00 2D49 FE29 2861 2D28"
	$"314A 316A 2D49 1CC5 1CA5 2907 3149 398B"
	$"356A 398B 358A 2907 358A 3DCD 356B 314A"
	$"316A 398B 3DCD 2927 24E6 2507 2D49 316A"
	$"316A 358A 39AB 39AB 316A 3169 316A 2D28"
	$"2927 2D48 356A 3569 3569 398A 3569 39AB"
	$"3569 3569 398A 3DCC 39AB 398A 398B 39AB"
	$"398B 39AB 398B 39AB 3DAC 39AB 39AB 398B"
	$"3DAC 39AB 358A 358A 39AB 358A 356A 3149"
	$"3169 358A 3DAB 3DCC 39AB 39AB 3DCC 3DAB"
	$"39AB 3148 3169 3DAB 41AC 3DAB 3DAB 3DAC"
	$"398B 3148 3169 356A 358A 358A 398B 398A"
	$"398A 3DAB 398A 398A 39AB 3DAB 3DAC 2D48"
	$"2D28 FE31 492D 3169 356A 2D48 3149 358B"
	$"356A 3169 3169 316A 316A 356A 3149 3149"
	$"316A 3149 3149 2907 2507 2D28 356A 2D28"
	$"3149 356A 2D49 2D49 3169 3149 356A 2D28"
	$"2928 2D28 2907 2D28 2D48 3149 2D49 398B"
	$"358A 2D49 2928 2928 2927 2D49 3149 3149"
	$"2D49 FE31 4952 3569 398B 398A 398A 3DAB"
	$"39AB 3569 3169 358A 3DCC 398B 356A 3149"
	$"2D27 3169 3149 356A 3DAC 2D48 3169 358A"
	$"2D48 3149 2D49 2D28 2928 2D49 3149 39AB"
	$"41ED 2927 20E6 2907 2907 316A 316A 358A"
	$"398B 358B 3DCC 3169 2D49 2D28 2928 3149"
	$"398B 398B 2D28 3149 24E6 24E6 398B 39AB"
	$"358A 358A 2D48 3169 356A 3149 356A 3169"
	$"316A 356A 3149 356A 358A 3149 2D48 2907"
	$"2D48 2D48 2D49 316A 3149 2D49 316A 358B"
	$"2D49 2507 2D49 2D49 2907 2928 FE2D 492A"
	$"2928 2928 2D49 3149 3149 3569 358A 2D48"
	$"2506 3149 358B 398B 316A 356A 356A 398B"
	$"358A 2D49 2D48 39AB 398A 358A 3DAB 358A"
	$"2506 2928 316A 398B 39AB 398A 358A 356A"
	$"3569 356A 3169 3149 356A 358B 358B 2D49"
	$"2D48 3149 2D49 0261 082D 282D 2931 4935"
	$"6A35 6A39 8B39 8B31 6931 49FE 356A 0631"
	$"6A31 4931 492D 4935 8B39 8B29 27FE 2507"
	$"0029 07FE 2D28 1631 4924 E620 E62D 2835"
	$"6A35 8B35 6A29 2825 0729 2829 2831 492D"
	$"4925 072D 2931 4A31 6A31 6A31 4931 6A2D"
	$"282D 2835 6AFE 398B 1A31 4831 4939 8B2D"
	$"4935 6A39 8B39 AB39 AB31 6A25 0729 2725"
	$"0725 0729 282D 2839 AB3D CC31 692D 4835"
	$"8B31 6A24 E629 0739 AB3D AB39 8A39 8BFE"
	$"398A 1331 4931 6935 6939 AB35 8A35 8A39"
	$"8B39 8B35 6A35 6A39 8B3D AC39 AB39 8B39"
	$"8B35 6A35 6A35 6935 6A39 ABFD 398A 323D"
	$"AB41 CC3D AB3D AB39 AB35 6A39 AB35 6A31"
	$"4831 482D 2831 6939 8A3D AB3D AB39 AB39"
	$"8A39 8B3D AB39 8B39 8A39 8B35 6A35 6A39"
	$"8A3D AB3D AB39 AB39 8B3D AC39 8B2D 282D"
	$"4931 492D 492D 482D 492D 482D 2831 4935"
	$"8A31 6A31 6A35 6A31 6A31 4931 4931 6A31"
	$"492D 282D 49FE 3149 0C2D 4831 6929 2829"
	$"2831 6A35 8A2D 492D 482D 4835 8B29 2825"
	$"0729 28FE 2D49 0B39 AB39 8B39 AC35 8A2D"
	$"282D 482D 482D 2831 4935 8A39 8A35 69FE"
	$"3169 1235 8A3D AB39 8A35 8A35 8A31 6931"
	$"6935 6A35 8A39 8B39 8B35 8A35 6A2D 272D"
	$"4839 8B3D AB39 AC25 07FE 3149 0035 6AFE"
	$"2D48 4131 6935 8A39 AC39 8B2D 4829 282D"
	$"4831 4935 8B31 4935 8B39 8B39 AB39 AB31"
	$"692D 482D 282D 4831 4935 6A39 AC2D 4820"
	$"C508 2025 0741 EE2D 4831 4931 6A35 6A39"
	$"8B39 8B31 692D 4824 E625 0629 2831 4939"
	$"8B35 8B31 6A2D 4925 072D 2831 6939 8B35"
	$"8B20 E629 272D 4925 072D 492D 482D 492D"
	$"4929 2829 282D 492D 482D 4831 4935 6939"
	$"6A35 6A35 8A35 6AFE 3169 1335 6A35 6A31"
	$"6931 4935 6A39 AC39 AB31 6A29 282D 4831"
	$"6A31 4939 8B3D AB35 692D 2729 282D 4935"
	$"6A39 8BFC 398A 0835 6A31 6A2D 492D 4929"
	$"4829 4831 6939 AB39 AB02 6B01 314A 316A"
	$"FE35 6A12 398B 398B 3149 2D49 356A 39AC"
	$"398B 356A 316A 316A 3149 316A 2D28 2D28"
	$"3169 2907 2507 2928 3149 FE29 2813 2507"
	$"24E6 2D29 2D29 2D28 3149 2D28 2D48 3149"
	$"358A 3DAC 3149 2D49 356A 356A 3169 358B"
	$"39AC 39AB 316A FE35 6A2F 2D28 3149 3169"
	$"316A 2D49 2907 3149 356A 356A 3169 2D48"
	$"2D48 2D49 2D48 2928 2D28 398B 3DCC 358A"
	$"2D48 2D49 358B 39AB 3149 3169 398B 3169"
	$"358A 398A 398B 3DCC 358A 2906 24E6 2927"
	$"356A 398B 398A 356A 356A 3569 3569 358A"
	$"398B 356A 3169 2D48 356A FE39 8B08 358A"
	$"39AB 3DAB 398A 358A 3DAB 3DAB 39AB 39AB"
	$"FE39 8B16 2D48 356A 358A 3149 3149 356A"
	$"398B 3DAB 358A 3169 3149 3149 3169 358A"
	$"39AB 2D28 2927 398A 358A 3169 3148 3149"
	$"3149 FD29 283A 2D28 2D49 2D49 2927 3149"
	$"358B 39AC 398B 398B 358A 356A 2D28 2928"
	$"2D28 2907 2D28 2907 3149 398B 358A 2D49"
	$"2D49 2928 2D28 316A 316A 2928 2D28 2D48"
	$"3169 2506 2506 2D49 358A 39AC 358B 39AB"
	$"398A 3169 3169 356A 3169 3569 398A 398A"
	$"39AB 398A 3DCC 3DAB 2D48 2D28 3569 3569"
	$"3169 3149 3569 358A 398B 398A FE35 8A10"
	$"3169 358A 3569 398A 41ED 39AA 2D48 2506"
	$"2928 2D28 2D49 316A 39AB 39AB 2506 2D48"
	$"2928 FE31 690A 358A 39AB 3169 3169 3149"
	$"358A 356A 358A 398A 3169 2D48 FE31 6945"
	$"39AB 3169 18A3 20E5 2928 39AB 2D49 20E5"
	$"2507 2928 3149 356A 358A 3168 2927 2927"
	$"3169 356A 358A 3DAC 358A 316A 358A 316A"
	$"2D48 2D28 356A 3149 3149 3DCC 316A 2927"
	$"358A 316A 358B 39CC 398B 358B 41CD 39AB"
	$"398A 398B 3DAB 3D8A 3149 3148 3149 3149"
	$"2D48 3149 3169 3169 398B 3DAC 3DAC 39AB"
	$"398B 356A 2907 2507 2D48 3169 358A 358A"
	$"398A 358A 356A 356A 358A 398B FE39 8A0A"
	$"3569 356A 3169 3149 2D28 2D28 2928 2D48"
	$"3169 398B 3DCC 0271 0235 6A31 4931 4AFE"
	$"398B 5135 6A2D 482D 4935 6A39 8B2D 2829"
	$"0729 0731 4935 8A39 8B31 6A31 4931 6A29"
	$"2829 2831 4931 6A2D 492D 4929 2824 E71C"
	$"C524 E725 0729 0729 0735 8A39 AB35 6A39"
	$"8B39 8B31 6931 6935 6A39 8B31 6A35 8A2D"
	$"492D 4939 8B3D AC35 6A2D 2820 E531 6935"
	$"8A35 8A31 6A29 0729 072D 2831 6939 8B39"
	$"8B31 4931 4935 6A31 6935 8A3D AC39 8B31"
	$"6935 8A35 8B35 8B35 6A2D 4829 272D 2831"
	$"4835 8A39 8B3D AC3D AC29 2820 E529 2731"
	$"4939 8B39 8B39 6AFE 356A 0839 8A35 8A39"
	$"8A39 8B35 6A35 6A39 8B35 6A39 8BFE 398A"
	$"1B3D AB39 8A39 AA3D AB39 AB3D AC39 AB31"
	$"6931 6A35 8B39 AC31 6A25 0620 E524 E631"
	$"4939 8B3D AC3D CC35 6A29 072D 2835 6A39"
	$"AB39 AB2D 2831 4939 8BFD 358A 042D 2825"
	$"072D 4925 0729 28FE 2D49 4C20 E625 072D"
	$"4831 6931 6A31 6A31 492D 2829 0729 072D"
	$"282D 2835 6A31 4935 6A35 6A31 492D 2829"
	$"2829 272D 4931 6A39 8B35 6A31 282D 2731"
	$"692D 282D 2731 4935 8A35 8A31 4935 6935"
	$"6A35 6939 8A39 8A2D 2831 4839 8A35 6A35"
	$"6931 4935 8B31 6929 0724 E629 072D 282D"
	$"2831 4835 6A35 8A35 8A31 6931 4935 8A39"
	$"8B39 8B39 AB39 8A39 AB35 8A35 8A35 6931"
	$"6931 6A35 8B35 8B3D AC3D CC31 6925 0635"
	$"8931 492D 28FE 3169 4C39 AB35 8A39 8B39"
	$"8A39 8B35 8A35 6931 482D 2731 4835 8A31"
	$"4931 4835 6A2D 282D 2841 CC3D AB35 6A25"
	$"0629 2729 2725 0720 E625 072D 2831 4931"
	$"6939 8B3D AC39 AB3D AB3D AB2D 492D 282D"
	$"492D 4829 2831 6931 6A31 4939 8B3D AB35"
	$"6935 6A35 6A2D 2835 6A3D CC41 CC3D AB3D"
	$"CC24 E525 0631 6935 6935 6935 6A35 6931"
	$"492D 2729 0729 0731 4935 8A39 AB3D AC35"
	$"8A35 6A39 AB31 6A25 0625 0629 272D 4935"
	$"8A39 8AFE 358A 1035 8B35 6A35 6A39 8A39"
	$"AB3D AB31 6935 6A35 8A35 6A35 6935 8A31"
	$"6931 6935 8A39 8B41 CC02 6D00 2D28 FE31"
	$"4925 3169 316A 316A 3169 3149 2D29 2928"
	$"2907 20E6 1CC5 2D49 358B 3149 2D28 2D28"
	$"2907 2907 356A 356A 2D28 314A 2908 20E6"
	$"2507 20E6 2507 2907 2507 3128 41CC 398B"
	$"3148 356A 356A 3149 2D48 356A 356A FE29"
	$"071A 356A 3DAC 398B 316A 2D28 2D48 358A"
	$"3149 316A 2D28 2927 3149 398B 3D8C 398B"
	$"356A 2907 2507 2D48 2D48 3569 41CD 3DAC"
	$"356A 398B 3569 356A FE31 6904 356A 3DAC"
	$"3DAB 3DAC 398B FD35 6A43 398B 356A 356A"
	$"3149 2D28 2D28 3149 3149 2D48 3569 398A"
	$"356A 3569 3149 3149 356A 356A 2D48 3169"
	$"3169 356A 356A 398A 3DCC 41CC 39AB 2D49"
	$"358A 3DAC 3DCD 2D49 2927 2928 24E6 356A"
	$"41CD 3DAC 398B 3149 2D28 398B 358B 3149"
	$"2D48 2908 356A 39AB 3DAB 398B 3169 2907"
	$"24E6 2D28 398B 3169 2D48 2928 2928 2948"
	$"20E6 1CC5 20C6 20E6 2507 2928 2928 2927"
	$"2D28 FD31 4901 356A 356A FE31 49FE 2D48"
	$"1431 6A35 6A31 482D 2831 6939 AC31 6A2D"
	$"282D 272D 272D 4829 062D 4831 6939 8B31"
	$"692D 282D 2835 8A35 8A2D 28FE 2928 7F2D"
	$"4929 282D 4835 6A39 8A31 4931 4935 6A35"
	$"6A31 692D 4835 6A39 8A39 AB39 AB35 8A31"
	$"4935 8A31 493D CC41 CD39 8B39 8B3D AB31"
	$"6935 6931 6931 4831 4835 8A31 6931 6935"
	$"8A35 6931 6935 8A35 6A2D 4931 4931 6A31"
	$"6931 6935 6935 6935 6A39 8B31 4831 4935"
	$"6935 6A3D AB39 8B31 6935 8A35 8A3D AB39"
	$"AB35 6931 4935 6935 6A31 6A35 8B39 AB35"
	$"6A31 6931 4929 2718 A41C C525 0729 282D"
	$"4835 8A35 6A35 6A35 8A31 692D 482D 282D"
	$"2829 272D 4835 6A3D AB39 8A25 060C 4010"
	$"611C A425 0629 282D 492D 2825 0725 072D"
	$"2829 2829 0729 2831 4939 8B39 8A39 AB39"
	$"AA2D 4829 2829 272D 2839 8B39 8B31 4929"
	$"282D 2835 6A35 8A31 4935 693D AB3D CC3D"
	$"AB29 0631 6931 692D 4835 6939 8A35 6903"
	$"398A 398A 3169 3569 026B 0735 6A35 6A24"
	$"E629 072D 4931 6929 2725 06FD 2928 1520"
	$"E620 E631 4A31 4A24 E61C A529 0729 0735"
	$"6A35 8B31 492D 2831 6A29 0829 2831 6A2D"
	$"492D 4A25 0729 0735 6A39 8BFE 3149 0F31"
	$"692D 2829 272D 2825 0729 0829 282D 4935"
	$"6B31 6A35 8B35 6A29 072D 4835 6A31 49FE"
	$"356A 1F39 6A39 8B3D AC39 8B31 692D 492D"
	$"4931 6A2D 282D 2831 6939 8A39 8B39 8B39"
	$"AB35 6A31 6A35 8A31 4935 6A3D AC39 AB39"
	$"8B35 8A39 8A35 8A39 8A35 8A39 8A39 AB35"
	$"6A25 06FD 2507 1525 0629 072D 2731 4835"
	$"6935 6935 8A39 AB31 6A1C C529 2824 E620"
	$"C52D 2739 8A41 CC3D CC3D CC39 AB39 AB39"
	$"8B3D ACFE 2D48 7229 072D 2831 4931 4931"
	$"6935 6A35 8B35 8B25 0725 0625 0629 072D"
	$"2831 4935 6935 6935 6A31 4931 4935 8A35"
	$"6935 8A2D 4829 272D 4831 692D 6925 2825"
	$"0720 E61C C529 282D 4929 282D 282D 2831"
	$"4835 8A35 6A35 6935 8A35 6935 6935 6A39"
	$"8B31 6929 282D 482D 2831 4935 8A35 8A35"
	$"8B35 6A2D 282D 2831 6939 8B31 6935 6A35"
	$"8A35 6A2D 4835 6A35 8A35 8A2D 2829 272D"
	$"4831 6939 AB31 692D 4831 6935 8B39 8A35"
	$"8A39 8A35 8A2D 2735 6935 693D AB39 8A31"
	$"6929 062D 282D 2731 693D CC41 CD39 8A39"
	$"8A39 AB31 6925 0625 072D 482D 4831 4935"
	$"6A39 8B31 482D 483D AB39 8B31 6935 6A25"
	$"0729 272D 482D 4835 6935 8A35 69FE 3169"
	$"0135 6A39 8AFE 3169 1B35 6939 8A39 AB39"
	$"8A39 8A35 8A35 6935 6935 6A31 6939 8B31"
	$"692D 2829 0725 0629 071C C524 E635 8B39"
	$"AB35 8B3D AC35 8B35 6A35 6A31 692D 482D"
	$"28FE 2D48 2A35 6A35 8A29 2721 0625 0625"
	$"2725 2829 282D 492D 4929 2829 282D 4831"
	$"492D 4929 0729 272D 2835 8A35 8B39 8A31"
	$"6935 6939 AB39 8B39 8B39 AB35 6A2D 282D"
	$"482D 2835 6935 8A35 6935 8A3D AC3D AB35"
	$"6920 E52D 482D 492D 4935 6AFE 39AB 0235"
	$"6A31 4931 4902 7102 3149 2D28 2928 FE31"
	$"493B 24E6 20E6 356A 356A 316A 2928 2507"
	$"2928 3149 2907 2907 2D28 39AB 39AC 398B"
	$"356A 356A 358A 358B 356A 2D49 2928 2D49"
	$"2D49 2928 24E7 2507 2507 2907 3149 3169"
	$"3169 3149 2D27 24E7 2907 2D28 2507 316A"
	$"2D49 2D28 398B 356A 3148 356A 356A 3169"
	$"398B 398A 3169 356A 41CC 39AB 3169 316A"
	$"3149 316A 2928 1CA4 3149 FD39 8B23 3169"
	$"3149 2D29 2D28 2907 2D28 356A 3149 3569"
	$"3569 356A 358A 398A 398A 39AB 3169 2506"
	$"20E5 2507 2507 2928 2928 2907 2D48 358A"
	$"398A 3DAB 358A 3169 2948 2928 2507 2928"
	$"2928 3149 398B FE3D AB0A 3DCC 41ED 39AB"
	$"398B 398B 2928 2D48 2D49 2D28 2D28 3149"
	$"FE35 6A0E 3169 2907 20E6 2927 2907 2907"
	$"2506 2927 358A 3169 3169 358B 398B 2927"
	$"2506 FE2D 4820 3149 358A 398B 316A 3169"
	$"2D48 2507 3169 316A 2D49 2928 2506 2927"
	$"358A 358A 398A 358A 3569 3569 398B 39AB"
	$"3169 2527 2D48 358A 398B 39AB 358A 398A"
	$"3169 2927 2D48 358A FE35 6A73 3169 3169"
	$"358A 398B 358A 358A 3149 3169 3169 358A"
	$"3169 2927 20E5 2506 2927 3148 398A 398A"
	$"3569 2D27 3148 358A 3DAB 39AB 3169 1CC4"
	$"2D48 2927 2D48 39AB 39AB 3DCB 41CC 358A"
	$"2D48 2D27 3169 358B 358B 398B 398B 398A"
	$"3148 358A 3DCC 39AB 3169 2927 2927 3169"
	$"3169 2D48 358A 398A 356A 358A 3169 3168"
	$"358A 3DCC 3569 3169 3589 398A 358A 3569"
	$"3569 398A 358A 3569 3169 2927 2927 3169"
	$"3169 2D48 2D28 3149 316A 3169 3169 39AB"
	$"398B 398A 3DAB 358A 398B 358A 356A 356A"
	$"358A 356A 2D48 3149 356A 3569 3148 3169"
	$"3149 2D28 3149 356A 2D49 2927 2927 2D28"
	$"3149 316A 358A 2D49 3149 3169 3149 2D48"
	$"2D49 316A FE39 8B17 358A 3149 2D27 3169"
	$"398A 3569 3569 3169 356A 398B 39AB 3169"
	$"2927 20C5 2D49 358B 316A 3149 356A 39AB"
	$"39AB 356A 2D49 2D49 0266 FC31 493C 316A"
	$"316A 358A 358B 398B 316A 2507 2D49 316A"
	$"2D49 2506 2D48 3DAC 3DAC 356A 3569 3149"
	$"3149 356A 3149 2D29 2507 20E6 2507 2507"
	$"2908 2928 2928 2D49 2D49 316A 398B 398B"
	$"356A 3148 3149 358A 356A 356A 39AB 2D28"
	$"2D28 316A 3148 3569 356A 39AB 398B 3DAC"
	$"3DCC 39AB 41CC 3DAC 2D48 2D28 2D49 2D29"
	$"2949 2929 2908 2D28 FE29 070A 3149 356A"
	$"356A 3149 2D28 3149 3169 3149 2D27 2D28"
	$"2D28 FE31 4905 356A 3149 2907 2907 2D28"
	$"2D49 FE31 6A16 356A 398A 396A 396A 358A"
	$"358B 2D49 2506 2507 2927 2928 3149 356A"
	$"39AB 39AB 3DAB 39AB 3DAB 39AB 398B 398B"
	$"3169 2D49 FE31 6A5D 3169 2D49 2928 2928"
	$"2D28 3149 3149 2D49 3169 3169 316A 2D49"
	$"3169 39AB 358A 358A 316A 356A 3149 3149"
	$"356A 358B 316A 3169 356A 358A 356A 358A"
	$"358A 356A 3DAC 3DCC 2D49 20E6 20E6 2507"
	$"2907 2D49 358A 398A 398B 41CC 3DAC 3169"
	$"2D48 2507 316A 3DCD 356A 2D48 356A 356A"
	$"3148 2D48 358A 356A 3149 3169 3169 358A"
	$"356A 398B 358A 398B 398B 398A 3169 2D49"
	$"2928 2D28 2D48 20E6 24E6 2D49 358A 398B"
	$"3169 3149 3149 3569 398B 39AB 3DCC 398B"
	$"3148 3149 3569 3169 356A 3DAB 41CC 3DAC"
	$"398B 39AB FE39 8A2C 3589 398A 358A 358A"
	$"398B 398B 398A 398A 3169 2928 2928 2D28"
	$"2D48 2D28 3149 3169 358A 3DAB 3569 398A"
	$"3DAB 358A 3148 2D48 3148 3148 3569 398A"
	$"3DCC 3DAB 3169 3148 3148 2D49 2D28 2D28"
	$"2D48 3148 356A 39AB 398A 39AB 398B 356A"
	$"356A FD39 8A11 398B 358A 3169 3149 3149"
	$"356A 398B 358A 3569 3148 2D48 2948 2D48"
	$"3169 316A 2907 2D28 3149 FE31 6907 356A"
	$"358A 398B 398B 2907 20E6 2908 2D29 FD2D"
	$"4816 2927 2D28 398B 398A 3169 2D48 2D27"
	$"356A 39AB 39AB 3169 2D48 18A4 2507 316A"
	$"2D49 2D28 2D48 2D48 2D49 3149 3149 358B"
	$"0266 FE31 4903 356A 356A 3149 356A FE39"
	$"8B00 358B FD35 6A42 3149 3149 396A 356A"
	$"3569 3569 3149 2D28 2928 2907 3149 316A"
	$"2D49 2D28 2D28 2D49 2907 2D28 3169 356A"
	$"316A 358B 3169 3169 358A 3D8B 398B 356A"
	$"398A 3149 3149 398A 3569 3549 356A 398A"
	$"41CC 41CC 3DAB 3DAC 3DAB 356A 2507 2907"
	$"3149 39AC 316A 2927 2507 1CC6 20C6 2507"
	$"2D28 2D28 358A 398B 3DAC 398B 356A 3169"
	$"2D48 2D48 3148 3169 356A 356A 3149 FE35"
	$"6A01 3149 3149 FC35 6A20 2D28 2907 3569"
	$"398A 398B 39AB 358A 3169 3149 2D48 3149"
	$"3169 3569 398B 39AB 3DAB 398A 398B 398B"
	$"39AB 356A 2D28 2D28 2927 2D49 358A 316A"
	$"39AB 2D28 3149 3169 358A 358A FE31 690E"
	$"356A 356A 358B 316A 2D49 356A 2D48 3149"
	$"358B 398B 3DAB 398B 358A 356A 3169 FE31"
	$"4915 356A 358A 39AC 39AB 2D49 2D48 314A"
	$"314A 3149 356A 356A 396A 41AC 3DAB 3148"
	$"24E6 3148 398A 41CC 356A 2906 2927 FE31"
	$"495C 356A 358B 316A 316A 39AB 356B 356A"
	$"3149 3169 3169 358A 358A 398A 398B 356A"
	$"358A 358B 2D48 2928 3149 356A 39AC 39AC"
	$"3149 2D48 3169 398B 3DAB 3DAB 3DAC 39AB"
	$"398A 3569 3DAB 398A 358A 3DAB 398B 398A"
	$"358A 398A 398A 3DAB 398A 3148 356A 398A"
	$"398B 3569 3569 398B 39AB 398A 3169 2D48"
	$"2D49 3149 3149 2D49 2D48 2D49 2D28 2907"
	$"3169 2D49 2D28 2D48 3169 3169 398B 398B"
	$"3DCC 3DEC 3169 2927 2507 2928 3149 316A"
	$"3169 3169 3569 3569 39AB 3DAB 3DAC 39AB"
	$"3149 3169 356A 3149 3149 3169 FE35 6A15"
	$"3149 3169 358A 39AC 398B 356A 358A 398B"
	$"39AB 358A 3169 2928 2D28 2D29 356B 358B"
	$"358A 358A 398A 398B 3DAC 398B FE24 E61B"
	$"2507 2507 2928 2928 2D28 314A 358B 39AB"
	$"398B 358A 3569 3169 356A 316A 316A 3149"
	$"2D49 2507 2507 2928 2D28 2D29 2D28 2907"
	$"2907 2927 3169 39AC 0277 5F2D 2831 4935"
	$"6A31 492D 282D 282D 4835 6A3D AC39 8B35"
	$"6A31 4931 4935 6A35 6A2D 4831 4935 6A39"
	$"8B39 8B35 8A2D 4825 0729 2829 2839 8B39"
	$"AC39 8B31 6A31 4935 6A31 4931 4935 8A35"
	$"6A31 492D 492D 4839 AB35 8B31 692D 492D"
	$"492D 482D 2839 8B3D AC35 6A39 8A39 8B3D"
	$"AB41 CC41 CC3D AB35 8A31 492D 482D 4835"
	$"8A39 8B39 AB35 8A31 692D 4831 6A29 282D"
	$"4935 8A2D 282D 4835 6939 8A39 AB35 6A31"
	$"482D 4831 6939 8B3D AC3D AC39 8A35 6A35"
	$"6935 8A35 8A35 6A31 6935 6931 6931 6935"
	$"8A31 492D 2831 6A39 8B35 6AFE 3149 2035"
	$"6A35 6A31 6931 4935 6931 6939 8A39 8A35"
	$"8A35 6A35 6A35 692D 4829 272D 2829 0720"
	$"E531 692D 4931 6939 AB31 4931 4935 6A35"
	$"8A39 AB35 8A2D 4829 072D 282D 4831 492D"
	$"48FE 2927 072D 282D 492D 4931 6935 6A35"
	$"8A35 8A2D 48FE 2928 572D 282D 2831 6935"
	$"6931 693D AB3D CC35 692D 2835 6A2D 2839"
	$"8B39 8B31 4831 4831 4939 8B39 8A39 8A35"
	$"6935 6931 692D 4925 0720 E625 2729 2829"
	$"2831 6935 8A35 8A35 6A31 692D 482D 4831"
	$"6A35 6A39 8B3D AC39 AB31 692D 2725 0631"
	$"492D 4831 493D AB3D CC31 692D 482D 4835"
	$"6A39 8B41 CD3D AB3D AB31 6935 6939 8A39"
	$"8A39 AB39 AB39 8A35 8A39 8A3D AB3D CC39"
	$"8A2D 4831 6939 8A35 8A2D 4831 4835 6A39"
	$"8A35 6A35 8A31 6A31 6931 492D 492D 492D"
	$"482D 2829 2729 0729 28FD 3149 5135 6A39"
	$"8B39 AB2D 4831 692D 6829 272D 4825 072D"
	$"2839 8A45 ED41 CC39 AA31 4831 4839 8B39"
	$"AB39 AB3D CC35 8A31 6931 4931 492D 4831"
	$"4931 4939 8B39 8B31 4931 6935 8B3D AC35"
	$"8B31 6935 8A3D AB39 AB35 8A35 8A35 6935"
	$"8A35 8A39 AB39 8A31 6939 AB39 8B39 8A35"
	$"6A31 6A31 6929 2829 2831 4931 6A35 6A35"
	$"6B35 8A3D AB3D AC35 8A2D 4831 492D 2829"
	$"2725 2725 0725 0729 2831 4935 6A31 6A2D"
	$"4831 4931 6A31 492D 4829 2829 2831 6A39"
	$"AB02 7444 2D28 3149 3149 2D28 2928 2D49"
	$"2D48 3149 2D28 2907 2507 2907 3149 2D48"
	$"3149 356A 398B 398B 356A 358A 356A 2928"
	$"3169 358A 358A 358B 398B 3149 2907 2D48"
	$"358A 398B 39AB 356A 2D48 3169 398B 39AC"
	$"39AB 3149 2D69 2D49 2928 2507 2907 2D49"
	$"2D49 3149 356A 398B 398B 3DAB 3DCC 358A"
	$"3149 3149 3169 3169 358A 3149 3149 356A"
	$"358A 3DCC 3DCD 2928 20E6 2907 2D48 FE35"
	$"6A69 39AB 398A 356A 356A 3149 356A 3169"
	$"2D28 2506 358A 3DAC 3169 3149 3169 2D48"
	$"3169 3169 3149 2D48 3149 398B 398B 316A"
	$"356A 3569 356A 398A 398B 398B 2D28 2907"
	$"3569 398A 398B 398B 2D28 2D48 3169 3569"
	$"2D48 39AB 3DCC 2928 3169 398B 2506 3169"
	$"39AB 3149 3148 356A 398B 39AB 358A 316A"
	$"2D49 3149 316A 358A 3169 2948 2927 2928"
	$"2D28 3149 2D48 2D48 358A 358A 2D28 2507"
	$"2928 3149 39AC 2506 2506 2D48 356A 356A"
	$"358A 2D48 1CC4 20C5 20E5 1462 2D28 356A"
	$"3149 398A 356A 358A 3148 358A 398A 3169"
	$"3169 2507 20E6 2106 2106 20E6 2927 358A"
	$"3DCC 3DAB 3169 FE2D 4816 356A 358A 3169"
	$"39AB 3569 2927 2D48 398A 398B 358A 41CC"
	$"3DAB 3148 358A 3169 2D48 2D28 398B 41CD"
	$"3DAB 3DAB 3569 398A FD3D ABFE 39AB 683D"
	$"AB39 AB31 482D 282D 272D 282D 4831 4931"
	$"692D 4831 6935 8A39 8B2D 492D 492D 482D"
	$"4929 2729 072D 282D 482D 482D 4931 6A31"
	$"6A2D 2831 4939 8B41 CD2D 4829 0629 2725"
	$"0729 2831 692D 4831 493D AB41 CC3D AB39"
	$"8A2D 4829 062D 482D 4935 6A39 8A35 6A35"
	$"6A31 4935 6A35 8A35 8A35 6939 8A39 8B35"
	$"8A35 8A39 AB3D CC39 AB35 8A39 AB41 CC39"
	$"8A35 8A35 8A39 AB39 AB3D AB3D CB31 482D"
	$"2835 6A31 4935 6A35 6A31 6A2D 4925 072D"
	$"4835 6A35 8A39 AB35 6A39 8A3D AB35 692D"
	$"4829 0729 0724 E629 0725 0725 0725 272D"
	$"4831 6931 6935 6A39 8B35 8A35 6A31 4931"
	$"49FE 2D49 0031 6A02 6600 358B FE35 6A26"
	$"2D49 2D48 2927 2907 2D28 2D28 2927 2D48"
	$"356A 3149 356A 398B 39AB 39AB 356A 398B"
	$"356A 3569 3DAB 3DAB 39AB 3169 3169 3149"
	$"3149 39AB 3DAC 398B 398B 3148 2927 358A"
	$"3DAC 316A 2D49 3149 316A 316A 2D48 FD29"
	$"2817 2508 3149 39AB 39AB 398A 358A 3169"
	$"2D48 3149 2928 2506 2507 20E6 2928 358B"
	$"3DAC 3DAC 3149 2507 2506 356A 3DCD 3149"
	$"2907 FE2D 2815 3149 356A 358A 356A 2D48"
	$"2907 2507 358B 356A 2927 2D49 2D49 2928"
	$"2927 2908 2928 2D49 3169 3169 3149 2D48"
	$"398A FD39 8B00 39AB FE31 4915 356A 2D48"
	$"2D28 20E5 2D48 39AB 2D48 2927 316A 358A"
	$"2927 3169 2D28 2906 3DAC 3DAC 2506 3569"
	$"358A 356A 356A 358A FE31 69FE 316A 1F31"
	$"8A2D 492D 2831 4931 6A35 6A35 8A39 AB29"
	$"2720 E524 E625 0735 6A39 8B1C C520 E529"
	$"272D 2829 2725 0618 A414 841C C518 8310"
	$"6229 2835 8B31 6935 8A2D 282D 482D 48FE"
	$"3169 2035 8A31 6A31 8A31 6A31 6931 6935"
	$"8A35 8A31 6929 272D 2831 6A35 8A35 8A39"
	$"AA39 8A31 4835 8A31 6931 6939 8A31 6931"
	$"693D AB35 6A29 0720 E62D 482D 4829 2735"
	$"6A3D AB39 8BFD 3DAB 4641 CC3D AB35 6935"
	$"6939 AA3D CB3D AB35 8A39 8B35 8A31 692D"
	$"282D 2831 4931 6A2D 492D 2831 6931 492D"
	$"492D 282D 482D 4831 6A18 A424 E631 6931"
	$"492D 6931 8A35 AB39 AB35 6A35 8A3D AB39"
	$"8B35 6931 6931 6A35 8B31 4925 072D 2831"
	$"483D AC3D AB3D 8B31 692D 2729 272D 4929"
	$"2831 6925 0620 C529 2829 0731 4939 AB39"
	$"AB39 8A31 6931 4931 6931 6935 8A39 AB39"
	$"AB39 8B3D AB39 8BFE 3149 2939 8B39 8A3D"
	$"AB3D AC25 0629 2831 4931 6A2D 4835 6931"
	$"492D 492D 2831 4935 6A39 8B39 8B31 6935"
	$"6A31 6931 4935 6931 6931 6931 4931 6931"
	$"692D 4831 6935 8A35 6A35 8A39 8B3D AB31"
	$"692D 482D 2829 2729 0729 0729 282D 4902"
	$"5602 358A 358B 358A FE35 6A07 3169 356A"
	$"398B 398B 356A 3149 356A 356A FE39 8B07"
	$"356A 3569 398B 358A 356A 358A 356A 3549"
	$"FE35 6AFE 398B 0B39 8A3D AC39 6A31 4935"
	$"6A35 8B31 6A31 6A2D 4929 2829 2825 07FE"
	$"2D49 2631 6931 693D AC3D AC39 8B35 6A35"
	$"6A31 492D 4931 692D 492D 482D 4829 2831"
	$"6939 8B35 8B2D 4925 0729 0831 6A39 AC2D"
	$"4920 E620 E625 0624 E629 072D 2831 4931"
	$"6A31 6935 6A2D 2829 282D 2829 282D 4935"
	$"8AFE 2D49 0F31 4A31 4935 8A35 8A31 6931"
	$"6935 8A3D CC39 8B35 6A35 6A31 6A31 4931"
	$"6A29 0724 E6FE 2928 0E29 2735 8A35 8A29"
	$"2725 0729 0731 6A31 492D 4820 E629 2841"
	$"CD35 8A31 4939 8AFD 356A FC31 691F 356A"
	$"316A 2D49 2D49 316A 316A 3149 358A 3169"
	$"20E6 20E6 2107 20E6 2508 2507 20E7 2508"
	$"2507 2928 2D49 2907 2507 2928 2928 2D48"
	$"358A 39AB 2D28 2507 2507 1CC5 20E6 FE2D"
	$"491B 3169 398B 39AB 398B 356A 2D49 2D49"
	$"2D48 2948 2928 2907 3149 3DAC 39AB 3149"
	$"2D28 2D48 3169 356A 356A 3DAC 3DAB 358A"
	$"3169 3169 2506 2507 24E7 FE25 070D 2D48"
	$"3149 398B 3DAC 39AB 356A 3569 358A 2D48"
	$"2D48 358A 3DAC 3DAC 3DCC FE39 AB51 398B"
	$"2928 2507 2507 2D49 2D48 2507 2907 2927"
	$"2D48 3149 3149 356A 3DAC 20E5 2927 398B"
	$"398A 398B 398B 398A 356A 3148 3148 3149"
	$"2D48 3149 3149 358B 3DAC 2928 2927 2D49"
	$"316A 358A 398B 39AB 2507 20E6 2507 20E6"
	$"18A4 2908 1484 1083 1483 1062 2D48 39AB"
	$"356A 2D28 24E6 2907 2507 2507 2927 3149"
	$"356A 358A 3569 3569 3169 3149 3569 358A"
	$"356A 3DAB 398A 2D27 3569 39AB 3169 2D48"
	$"3169 3569 3569 398A 3569 356A 3169 2D27"
	$"2927 FE2D 28FB 3149 0E2D 2831 6A35 6A35"
	$"6A39 8B39 8B35 6A31 492D 282D 492D 2829"
	$"282D 4831 6935 8A02 740D 398B 398B 356A"
	$"356A 358B 398B 398B 3DAC 39AB 356A 2928"
	$"2907 2D28 3149 FC35 6A3F 358A 3169 3149"
	$"2D28 2D28 2D48 358A 3169 398A 3DAC 3569"
	$"3569 396A 398B 358A 356A 356A 3169 2D48"
	$"2928 2927 2D49 2928 2D29 2D49 2D49 3169"
	$"358A 358A 398A 358A 356A 358A 3169 3149"
	$"2D48 316A 3DCC 358B 3149 3169 358B 358A"
	$"3169 2D49 2D49 2D29 3149 316A 316A 3169"
	$"2D49 2D49 3149 356A 358A 356A 356A 358A"
	$"358A 398B 358B 316A 2D49 FE2D 4830 3149"
	$"356A 3DAC 398B 398B 358A 356A 398B 39AC"
	$"39AC 358B 356A 2D49 3149 2D28 358B 2D28"
	$"2907 2928 3149 3169 356A 316A 2907 20E6"
	$"24E7 2907 356A 358B 2907 2D28 398B 39AB"
	$"398B 39AB 39AB 398A 39AB 39AB 398B 358A"
	$"3169 2D49 316A 2D49 3169 2D49 2D48 3169"
	$"FE35 6A7F 398B 358A 2927 2928 2907 2928"
	$"2D49 2D49 316A 2D69 2D49 2D69 3169 2D49"
	$"3169 3149 2D48 3169 358B 358A 2D49 2907"
	$"20E6 20E6 3169 358B 3149 3149 356A 398B"
	$"398B 356A 3149 2D28 3169 356A 356A 316A"
	$"3169 398B 39AB 2D48 3569 358A 358A 39AB"
	$"398B 41AC 41CC 3DAB 356A 2907 2907 2928"
	$"2D48 2D28 2928 2927 3169 358A 398B 3DAC"
	$"3DAB 39AB 2D27 2927 2D28 2D48 358A 3DAC"
	$"398B 398B 3DAB 3DAB 41CC 398A 3169 24E6"
	$"2927 2927 2D48 2928 2506 2928 2D48 2D49"
	$"3169 356A 398B 3DAB 2D27 356A 3DAB 356A"
	$"3169 3569 3149 3148 3148 3149 3148 2D28"
	$"2927 3149 3169 2D28 2907 2D28 2D48 3149"
	$"3569 3569 3169 2507 20E5 2507 20E6 1CC5"
	$"2507 1CC5 18A5 18C4 2D48 3169 2D48 3149"
	$"24E6 2907 0029 28FE 2507 1129 2831 6A35"
	$"6A35 6935 6A35 6A39 8A39 8B35 8A35 6935"
	$"6935 8A35 8A3D AC39 8B31 6939 8B3D ACFE"
	$"398B 1C35 692D 482D 4831 4831 6931 4931"
	$"492D 492D 492D 4829 282D 492D 4929 2831"
	$"4931 4931 6935 6A39 8B35 8A29 2825 0729"
	$"0829 282D 492D 4931 6A35 8A35 8B02 5E0B"
	$"2D48 3149 356A 356A 3169 356A 316A 356A"
	$"3149 2D49 3169 3169 FD31 4901 3169 356A"
	$"FE31 4915 2D28 2907 2D28 2D49 316A 356A"
	$"3DCC 3DAB 3169 398A 356A 2D49 3149 2D48"
	$"2D28 2D48 3149 316A 358B 39AB 356A 358A"
	$"FE35 8B2F 358A 3149 2D49 3169 316A 3169"
	$"2D48 2D28 2D28 398B 3DCD 356A 316A 358B"
	$"2D49 2507 24E6 24E6 20E6 1CC5 2507 316A"
	$"39AC 39AC 398B 3DAC 398B 358A 3169 3169"
	$"356A 3169 3169 356A 316A 2D49 2D49 2928"
	$"2927 2D28 358A 3DAC 3DCC 358A 316A 3149"
	$"358B 358B FE35 6A09 3169 2D28 3149 2D28"
	$"358A 2D49 2D49 3149 3569 3148 FE31 693B"
	$"2D49 3149 3149 358B 358A 3169 356A 2D28"
	$"3148 398B 39AB 358A 398B 3DAB 39AB 358A"
	$"356A 3149 2D48 358A 2928 2907 2928 3169"
	$"358B 3169 3569 3569 356A 356A 2D28 2907"
	$"2907 316A 3149 3169 2D49 2507 2527 2507"
	$"2907 2D49 3149 2D48 2D28 358A 398B 3169"
	$"3169 2D48 3149 358A 39AB 356A 3149 3149"
	$"2D49 2D28 2928 2928 FD35 6A06 398B 39AB"
	$"356A 358A 3149 2D48 39AB FE39 8A1C 398B"
	$"3DAB 398A 398A 2927 20E5 24E6 2507 2507"
	$"2927 3169 398A 3DAC 3DCC 39AB 3148 2D48"
	$"356A 2907 2506 2D28 356A 398B 358B 2D28"
	$"3569 398A 39AB 39AB FE2D 4836 316A 2928"
	$"2928 2927 2527 2928 2D49 3169 3169 356A"
	$"398A 41CD 39AB 3DCC 39AB 3169 356A 3569"
	$"3149 3148 3169 356A 3569 3169 3169 2D49"
	$"2D48 3149 3169 356A 3569 358A 3169 3169"
	$"358A 3169 2D48 2928 2907 2507 2106 1CC5"
	$"1CA4 3169 41ED 2927 2D48 358A 2D48 316A"
	$"2507 2527 2927 2927 2D48 FD35 6A17 3149"
	$"3DAB 3DAB 358A 356A 3169 356A 3169 358A"
	$"398A 3DAB 3DAC 3DAB 3DCC 398A 3169 398A"
	$"398B 3569 3149 3169 2D49 3169 356A FD31"
	$"6900 316A FE35 8A05 316A 39AB 2D49 20E6"
	$"20E6 2508 FE29 28FE 2D49 0035 8A02 6710"
	$"2907 3149 3149 2907 2928 2D28 2D28 2D49"
	$"398B 39AB 39AB 356A 316A 3169 2D28 2907"
	$"2D28 FD31 490B 2907 2D28 3149 356A 398B"
	$"398A 39AB 358B 358A 358A 2D48 2506 FE2D"
	$"2812 358B 398B 39AC 3DAC 358A 2D49 3149"
	$"3169 3169 358A 358B 316A 2D69 2D49 3169"
	$"316A 358B 356A 356A FE39 8B0A 358B 3169"
	$"2928 2927 2928 3149 316A 314A 356A 358B"
	$"358B FE39 8B18 356A 2D48 2D28 356A 2D28"
	$"2D49 398B 358B 398B 39AC 398B 358B 356A"
	$"316A 3169 2D49 2D48 2928 2D49 316A 398B"
	$"356A 398A 3569 356A FD2D 2807 3149 3169"
	$"3169 3149 316A 3149 358A 358A FE31 69FE"
	$"3149 153D AC39 8A2D 4831 4935 6935 8A35"
	$"6A39 AB3D AB3D AC2D 4829 2731 6931 4935"
	$"8B2D 492D 282D 4935 6A35 8A35 6A2D 49FD"
	$"2928 1625 072D 4931 6A2D 482D 4929 0725"
	$"0729 2725 072D 2831 4A35 6A31 4931 6941"
	$"CD35 8A2D 4831 4935 6A3D AC41 CC35 8A2D"
	$"48FE 2D49 7F31 6A2D 692D 492D 482D 4931"
	$"6A35 6A3D CC3D CC2D 282D 2829 0735 8A39"
	$"AB31 6931 4931 4935 6935 8A31 6935 8A2D"
	$"4829 2829 2825 0725 0729 2835 8B39 AB31"
	$"692D 4825 0629 272D 4931 4929 2829 282D"
	$"2835 8A35 8A2D 2831 4935 8A39 AB3D AB31"
	$"6931 4835 8A31 6A2D 492D 4931 6A31 8A2D"
	$"6931 6931 8A35 8A39 8B35 6A39 8A41 CC3D"
	$"AB41 CC39 8A35 6939 8A35 6A35 8A39 8B39"
	$"8A39 8A35 6931 4931 692D 4829 272D 2831"
	$"4935 8A39 8B39 8B31 6931 6935 6931 6931"
	$"6929 282D 482D 492D 692D 4931 4939 8B3D"
	$"AB35 8A39 AB35 8A39 8B35 8A2D 482D 4829"
	$"282D 4835 6939 8A31 6931 6935 6A35 6A39"
	$"8A39 8A35 6A35 8A35 8A39 8B35 8A35 8A39"
	$"AB39 8B35 6A39 8A35 8A35 6A31 6935 6A39"
	$"8B31 692D 4808 2D48 3149 398A 3DAB 3149"
	$"3148 2D48 2D48 3149 FE31 690C 2D48 358B"
	$"2928 20E5 2927 2D48 2D49 2D49 3149 3169"
	$"3569 356A 398A 026E 4F31 4A35 6A2D 2931"
	$"4931 6931 492D 2831 4939 8B35 6A31 492D"
	$"4831 4931 6931 4929 0729 0731 4939 8B35"
	$"6A2D 2829 0729 0731 4939 8B39 8B35 6A39"
	$"8B3D AC39 8B2D 4929 2729 0731 4935 6A39"
	$"8B3D AC3D CC41 CD39 8B29 0729 072D 2829"
	$"072D 2831 4935 8B39 8B39 8B31 6A31 4935"
	$"6A35 8B29 282D 4939 AC3D AC3D AC35 8A35"
	$"693D AC3D AC3D AB39 AB39 AB35 6A31 6939"
	$"8A39 8B35 6A35 8A35 6A31 4931 4939 8B39"
	$"8B25 0631 6935 8B35 8BFC 356A FE2D 4807"
	$"3149 316A 398B 358B 2D28 2D27 2D28 2906"
	$"FE29 0706 2D28 2D28 3DAB 398B 398B 358B"
	$"358B FE35 6A1C 316A 358A 358A 356A 3149"
	$"3169 39AB 3DAC 3149 3148 358A 398B 398B"
	$"3DAB 3DCC 39AB 2507 1CC5 2507 2507 2908"
	$"2507 2907 2D48 3169 358A 358A 3149 2D49"
	$"FE31 6A0E 3149 316A 316A 356A 316A 3149"
	$"316A 3149 2D49 3169 3169 3149 2D28 356A"
	$"3DAC FE35 8A5A 3169 3149 316A 2D28 2928"
	$"2D48 3169 398B 3DCD 39AB 316A 3149 356A"
	$"3DAB 39AA 3DCB 398A 2D49 2D28 2D48 39AC"
	$"3149 2907 2D28 3149 356A 358B 3149 358A"
	$"398B 398B 3569 2D48 3149 356A 398B 316A"
	$"20E5 20E6 20E6 358A 356A 3169 2D27 2D48"
	$"2D48 3149 3169 3169 398A 398A 3DAB 398A"
	$"2D48 2D48 3149 2928 2507 2D28 316A 356A"
	$"3149 39AB 41CC 39AB 398B 356A 398B 3569"
	$"3149 356A 2907 3148 3569 3169 358A 3DAC"
	$"3148 3169 3569 2D28 2507 20E6 2506 2D48"
	$"3149 3569 3DAB 3DAB 3169 356A FE35 8A42"
	$"3169 3169 358A 39AB 3569 3148 3169 3169"
	$"3569 3169 3169 358A 3169 3169 3149 3149"
	$"358A 39AB 3149 2907 2D49 39AB 39AB 398B"
	$"358A 2D48 2D48 2D49 2D48 2928 2928 2D28"
	$"2928 2507 2928 356A 3DAC 39AB 2D27 2D27"
	$"3148 3569 358A 3149 356A 356A 2D28 2D28"
	$"2928 2928 2D48 3169 3169 356A 356A 398B"
	$"356A 3149 356A 356A 398A 398A 398B 3DAB"
	$"398B 356A 3148 0269 0B35 6A31 6A31 4935"
	$"8A35 8A35 6A35 6931 492D 482D 4931 4931"
	$"69FE 3149 1C2D 2831 6A39 8B39 8B2D 4831"
	$"6931 492D 4839 AB39 AB31 6A31 6A35 8A35"
	$"6A2D 4929 2825 072D 2731 4935 693D AB3D"
	$"AB41 CC3D CC35 692D 4831 4929 2729 27FD"
	$"3149 0235 6935 6A35 6AFE 316A 1939 AC3D"
	$"CD3D AC35 8A31 4835 6A3D AB31 6935 6935"
	$"6931 4931 4831 4935 8A39 8A2D 2831 4939"
	$"8A39 8B39 8B35 6A35 6A31 492D 482D 4931"
	$"49FE 24E6 112D 2835 8A39 8B3D AB3D AB39"
	$"8B39 8A35 6A2D 282D 2824 E625 0729 0720"
	$"C624 E731 4935 6A31 69FE 358A 2A35 6A31"
	$"4931 4935 6A35 8A35 6931 6935 8A39 8A35"
	$"6931 482D 282D 2829 072D 4835 6A39 8A39"
	$"AB35 8A35 8A31 492D 4829 2829 2824 E624"
	$"E629 2831 4939 8B35 6A39 8B31 492D 2829"
	$"2820 E535 8A35 8A29 272D 482D 4831 4935"
	$"6A35 6AFE 358A 0331 6931 692D 2831 49FE"
	$"356A 1635 6935 6929 2729 0729 2831 692D"
	$"4929 2731 6939 AC3D AC2D 2835 6A35 6A2D"
	$"4839 8A39 8B35 692D 2729 072D 2831 4931"
	$"49FE 2928 5231 4935 6A39 8B2D 2831 4939"
	$"8B31 4924 E62D 2735 8A39 AB35 6A25 071C"
	$"A420 C525 0735 8B2D 4829 272D 272D 4835"
	$"6935 8A35 6A31 6931 4931 482D 2729 272D"
	$"272D 482D 482D 2831 492D 4831 4835 6939"
	$"8A45 ED41 CC35 6929 2735 6A2D 4818 A318"
	$"832D 2829 0729 272D 482D 4831 6935 8A2D"
	$"4831 6939 AB39 AA31 6929 272D 4835 8A35"
	$"8A3D AB41 ED3D AB35 6A35 8A39 8B35 8A35"
	$"6A31 6931 6935 8A39 AB35 8A31 6935 6939"
	$"8B35 8A31 4931 492D 482D 28FE 2D49 1C39"
	$"8B35 8B2D 4835 6941 CC3D AB35 8A35 8A35"
	$"692D 4831 482D 492D 4929 2829 0729 2725"
	$"0625 072D 483D AB41 CC3D AB29 272D 2731"
	$"492D 2729 2729 2831 49FE 356A 0735 8A35"
	$"6A39 8B39 8B35 6A39 8B35 6A39 8BFE 358A"
	$"0739 8A39 AB31 6935 6935 6935 6A35 6935"
	$"6902 75FE 3149 7F3D AC39 8B39 8A39 8A35"
	$"6935 6A39 8B35 8B35 6A31 4931 4931 6935"
	$"6A35 8A39 AB35 8A35 6A39 8B35 6A39 AB3D"
	$"CC39 8B35 6A31 692D 482D 282D 482D 4829"
	$"282D 282D 4839 8B41 CC3D AB39 AB35 8A35"
	$"6935 6A35 6A31 4931 492D 4829 0729 072D"
	$"2835 8A39 8B39 AB31 6929 282D 4831 693D"
	$"AC3D CC39 8A39 AB35 6A24 E620 E52D 282D"
	$"482D 2831 4935 6A41 CC41 CC2D 282D 4839"
	$"8B35 8A31 6A35 6A39 AC31 6A1C C529 072D"
	$"4831 692D 4925 0631 6941 CC3D AC41 CC41"
	$"CC35 8A35 6A31 6931 4931 4929 0729 0731"
	$"4A29 282D 4939 8B31 492D 4839 8B39 AB31"
	$"6931 692D 2831 4935 8A35 8A31 4935 6A39"
	$"AB3D CC39 AB35 6931 492D 2831 4931 6935"
	$"8A35 8A31 692D 482D 4829 072D 4935 6A31"
	$"492D 482D 4831 6919 41CD 3169 2D48 3169"
	$"24E6 20C6 18A5 1884 316B 2928 1CC6 2507"
	$"2507 3148 398B 3DCC 39AB 3169 2D48 2D49"
	$"2D48 2907 2927 3149 356A 3169 FE35 6930"
	$"358A 3169 398B 3169 2D49 356A 358B 358A"
	$"3169 398B 358A 398B 398A 3149 2907 2506"
	$"2907 2D48 2D49 3149 358B 358B 398B 358A"
	$"356A 358A 24E6 1CA4 20C5 1883 1041 1CC5"
	$"20E6 20E6 1CC5 1CC5 18A4 2928 3149 316A"
	$"3149 3169 356A 398A 356A 356A 358A 3569"
	$"3169 FE31 494B 3169 3569 3569 3169 356A"
	$"398B 356A 358A 41ED 41CC 3569 24E5 2D28"
	$"316A 20C5 0C41 0C40 1CC5 2927 2D28 3169"
	$"3569 398A 39AB 3DCB 3569 3148 39AA 358A"
	$"358A 3149 2D27 358A 398A 39AB 3589 3569"
	$"358A 3569 3169 3148 3148 3169 358A 398B"
	$"39AB 398A 39AB 41CC 398A 2D48 2927 2507"
	$"2507 2928 2D49 2928 2D28 2928 2907 3148"
	$"398A 3569 3569 39AB 398A 356A 358A 39AB"
	$"316A 2D28 2927 2928 2928 2D49 356A FE3D"
	$"AB0D 356A 2506 2506 2D27 3169 358B 39AB"
	$"39AB 358B 398B 398B 358A 358A 3148 FD31"
	$"490A 3169 3169 356A 398A 358A 2927 2D27"
	$"3169 356A 3569 358A 0269 2C31 492D 2831"
	$"493D AC39 8A35 6935 6931 6939 8B39 8B31"
	$"492D 282D 282D 4831 4935 6A35 6A39 8B39"
	$"8A39 8A39 8B39 8B39 8A39 8A35 6A35 8A31"
	$"492D 282D 482D 482D 4929 2831 4935 6A3D"
	$"AC3D AC31 6931 4931 482D 4831 4931 4931"
	$"6A35 6A35 6AFE 3149 2A35 6A31 6931 6A2D"
	$"482D 2829 2735 6941 CC39 AB3D CB3D CB2D"
	$"4829 272D 282D 4931 4939 8B35 8A3D AB41"
	$"CD39 8B2D 2831 4831 4931 492D 493D AC3D"
	$"AC25 071C C525 0629 0739 AB39 8B35 693D"
	$"CC41 CC3D AB3D AB39 8A31 6A35 6A35 6AFD"
	$"3149 5439 8A39 AB35 8A31 6935 8A3D AC3D"
	$"AC2D 2924 E631 4931 4939 8B39 8B35 6A35"
	$"6935 6939 8A39 AC3D AC3D AC35 8A35 6A31"
	$"492D 4835 692D 4829 272D 482D 4829 072D"
	$"4931 692D 492D 292D 2835 6A39 AB31 692D"
	$"4831 6829 2620 E61C C525 0729 2820 E629"
	$"0731 4939 AB3D CC39 AB39 AB31 6925 0631"
	$"4939 8B31 6A29 282D 492D 4931 4931 6935"
	$"6931 4935 6A39 AB39 AB35 8A2D 4835 8A35"
	$"8B31 6A35 8B39 8B35 8A39 8B3D AC39 8B31"
	$"6931 4931 4939 8A39 8A35 6935 69FE 39AB"
	$"1E31 6931 6935 8B29 281C E518 A410 620C"
	$"410C 4110 420C 4110 620C 4114 8339 8B3D"
	$"AC35 6A39 8A39 8A39 8B39 8A31 4829 072D"
	$"4835 6931 6A35 8A35 8A39 8A39 8B39 8BFD"
	$"398A 0E35 6A39 8A41 CC2D 2731 482D 2731"
	$"6931 692D 4920 E50C 4110 621C C529 2839"
	$"8AFD 3DAB 1331 482D 063D AB39 8B3D AC31"
	$"4929 2729 272D 282D 282D 4935 8A35 8A35"
	$"6935 6935 8A39 8A39 AB39 8A35 8AFE 39AB"
	$"0F39 8B31 6929 2725 0624 E625 0620 E625"
	$"0620 E625 0725 0625 0724 E620 C525 0631"
	$"49FE 356A 2035 8A39 8B31 6A29 2825 0625"
	$"072D 4831 6935 6A35 8A39 8A39 8A35 6929"
	$"272D 4839 8B35 6A39 8B39 8B39 8A39 8A39"
	$"8B35 8A35 8B35 8A31 6939 8B35 6A31 6931"
	$"6931 4931 4935 8AFD 3169 0335 8A39 8B35"
	$"6935 6902 6902 2D28 3149 314A FD35 6A4D"
	$"358B 39AB 316A 2928 2507 2927 2D48 356A"
	$"398B 3DAC 3DAC 3DAB 3D8B 398B 358A 356A"
	$"3569 3169 2D48 3169 356A 356A 3149 3149"
	$"3169 316A 356A 316A 3149 2D28 356A 398B"
	$"356A 358A 358A 39AB 41CC 3DAC 398B 398B"
	$"356A 356A 3169 3169 3149 3149 358A 398B"
	$"398B 356A 358A 356A 2928 3149 358A 3DAB"
	$"41CD 3DAC 358B 358B 316A 3169 3149 2D28"
	$"2D48 3149 358A 3DED 2D69 1CE5 20E6 2506"
	$"2D27 398B 3149 3148 358A 398A FE35 6A51"
	$"3149 2D28 2D28 3149 3169 358A 398A 358A"
	$"3169 2928 2D28 358A 356A 3149 2507 2907"
	$"2D48 2D48 39AB 39AB 356A 3149 3169 356A"
	$"398B 3DCC 358B 2928 2928 2927 2D49 2D49"
	$"2928 2928 2D49 2507 2507 2928 2928 2D48"
	$"2D28 2928 3149 356A 358A 356A 398A 3569"
	$"316A 2D28 2D48 2D28 2D28 3149 358B 398B"
	$"398A 3569 3149 3148 356A 41CD 3DAC 358A"
	$"398B 39AB 356A 3169 356A 398B 356A 3148"
	$"3169 2D48 2927 2D28 3DCC 356A 358A 398B"
	$"398B 398A FE39 8B00 358A FE39 8A0B 3DCC"
	$"398B 3569 2D49 2928 2948 2927 2D28 3149"
	$"2D49 2928 2508 FE20 E732 2507 20E6 1CC5"
	$"1CC5 20E6 3149 356A 2D49 398B 356B 316A"
	$"2507 2106 18A4 1884 2907 2D28 2D28 3169"
	$"39AB 3569 2D48 2D28 3149 3569 3169 3169"
	$"3569 3169 3148 3DCC 398A 2D49 2928 3DAC"
	$"358B 2928 2507 2927 2D49 356A 356A 398B"
	$"3DAB 3169 3148 398A 39AB 3DAC 3DAC 3149"
	$"FE31 691F 358A 3169 356A 398A 358A 398A"
	$"398A 3DAB 3DAB 398A 39AB 3DAC 39AB 398A"
	$"3589 3169 3149 2D28 2928 2508 2507 2507"
	$"20E6 2507 20E6 2506 1CA4 18A4 2928 3149"
	$"3169 398A FD3D AB17 358A 3149 3169 358A"
	$"358A 398B 398A 356A 3569 3569 3169 3169"
	$"358A 358A 398B 358A 356A 3169 3169 3149"
	$"356A 3569 358A 398B FE35 6A02 3149 3149"
	$"358B FE35 6A00 398B FE39 8A00 39AA 0272"
	$"1029 072D 2831 6A35 6B39 8B35 8B35 6A39"
	$"8B35 8B31 6A2D 492D 4931 692D 4931 4935"
	$"6A39 6BFD 398B 7739 AB3D AC3D AB39 8A35"
	$"8A39 8A35 6A2D 4829 2829 2825 0724 E62D"
	$"282D 482D 4931 6939 AB39 8B35 6A31 6935"
	$"6939 AB39 AB31 6935 6A39 8B35 8A39 8A39"
	$"8A35 6A35 6935 6A39 8B35 8A35 6A31 492D"
	$"2831 4931 4935 8B39 8A45 ED41 CD31 4935"
	$"8B31 4929 072D 282D 282D 4931 4931 6939"
	$"8A3D CC2D 4825 0729 282D 2935 6B31 6A29"
	$"2825 062D 4931 4929 2729 2729 0729 2731"
	$"492D 4831 6935 6A35 6A31 492D 2825 0620"
	$"E620 E625 0729 272D 492D 4931 4931 4935"
	$"6A35 8A35 8A31 6935 6A35 8A39 8B41 CC35"
	$"8A29 2731 6931 6A35 8A35 6A35 6A31 6935"
	$"6A35 8A2D 4931 6935 8A2D 4929 2725 0725"
	$"0631 4935 8B35 8A3D AB3D AB39 8B39 8B35"
	$"8A35 6A35 8A35 8AFE 356A 7F35 6935 6A35"
	$"8A39 AB3D AB3D AC3D AB35 6931 4831 492D"
	$"4831 4831 6935 6931 6931 482D 2829 2731"
	$"4839 8B39 8A39 8A3D AB3D 8B39 8B39 8B35"
	$"6A31 4831 4931 4839 8A39 AB35 8A31 6929"
	$"0720 C514 831C C520 E720 E729 072D 282D"
	$"492D 492D 2829 2820 E625 0725 0729 2829"
	$"2931 4931 4931 692D 4929 2729 0725 0725"
	$"0620 E629 4825 0718 A425 072D 2831 4935"
	$"8A39 AB2D 4829 2725 0629 072D 2731 4831"
	$"6935 6939 AB39 8A35 692D 4829 282D 483D"
	$"CC35 8A31 6931 692D 4829 2829 282D 282D"
	$"4931 4931 4835 6A39 AB3D AB41 CC35 8A2D"
	$"4835 6935 8939 AA35 8A29 272D 2835 6A35"
	$"8A35 8A39 8A3D AB39 8A31 4831 693D CC39"
	$"8A35 692D 482D 282D 4931 492D 492D 4829"
	$"2825 0720 E620 E625 0729 2815 24E6 2907"
	$"3169 356A 358A 3DAC 3DAC 398A 398B 39AB"
	$"39AB 358A 3169 2D48 2927 2D48 3149 3149"
	$"3569 398B 398B 356A FE35 8AFE 3569 0235"
	$"8A35 8A35 69FE 356A FE35 8A0A 316A 3169"
	$"316A 3149 3169 3149 3169 3149 3569 39AB"
	$"39AB 0258 0529 082D 2931 4935 6A31 4931"
	$"69FE 356A 0439 8A39 AB31 6929 2820 E6FE"
	$"24E6 1229 0729 0735 6A3D CC3D AC3D AC3D"
	$"AB39 8B39 8A39 8A31 492D 4829 2829 0725"
	$"0729 0735 6A31 6A2D 48FE 2D28 0431 4931"
	$"4935 6935 6A31 69FE 356A 2535 6939 8A39"
	$"8A35 6A39 8A3D AC39 AB35 8A35 6A31 692D"
	$"2831 4935 6A35 8A39 8B41 CC39 AB31 4931"
	$"492D 4931 6A31 6931 4935 8B35 8A35 6935"
	$"8A31 6931 4929 2831 492D 282D 282D 492D"
	$"2824 E62D 492D 49FE 2928 072D 2831 6931"
	$"4931 492D 482D 492D 2829 28FE 2507 FE29"
	$"0732 2928 3149 358A 398B 398B 398A 398A"
	$"39AB 398A 3DAB 398A 3569 39AB 358A 3569"
	$"358A 356A 3DAB 3DCC 39AB 358A 358A 2948"
	$"2927 2507 2106 2507 20E6 356A 3DCC 398B"
	$"398A 398A 3569 3149 2D48 2D48 2D28 2D28"
	$"2927 2927 2D28 2D28 3569 398A 3DAB 3DAC"
	$"398B 3569 2D27 2927 FB31 4902 3169 2D48"
	$"3148 FD39 8A17 3569 3569 398B 398B 356A"
	$"3569 3149 3569 41CC 358A 2506 2506 2507"
	$"20E6 1CC5 2507 2929 316A 358B 3169 316A"
	$"358B 358A 358A FE31 6903 3149 2D48 3149"
	$"2D49 FD2D 481D 2928 2506 2927 358B 3169"
	$"2D48 3169 3149 3149 2907 2D28 356A 3148"
	$"3569 398A 398A 3569 3169 3569 3589 3569"
	$"3569 3169 3149 3169 358A 3169 2906 2506"
	$"2506 FE25 0730 2907 2927 3569 3DCC 3DAC"
	$"41CC 358A 2D48 3169 358A 39AB 358A 2505"
	$"2506 2D48 3149 398B 398B 39AB 398A 398A"
	$"2906 2D48 358A 3149 2D28 2507 2506 316A"
	$"3149 3169 3169 316A 3169 2D48 2D28 358B"
	$"358B 3169 3149 2D28 2D28 3169 398B 356A"
	$"356A 398B 3DAB 356A FE29 2701 2D48 3148"
	$"FE31 490A 356A 358A 358A 356A 356A 358A"
	$"356A 3569 398A 398B 358A FE39 8A0E 39AB"
	$"39AB 398B 358A 3169 3169 316A 356A 3149"
	$"2928 2507 24E6 24E6 2507 2928 0269 0135"
	$"6B35 6AFE 2D28 0631 4931 6931 4935 693D"
	$"CC35 6A29 07FE 2507 0724 E725 0724 E620"
	$"E63D AC41 CC3D AB3D ABFE 398B 0535 6A31"
	$"6935 6A31 492D 492D 48FE 3149 062D 4831"
	$"4931 6A35 6A35 6A31 492D 28FD 356A 1431"
	$"6935 6A39 8B35 8A35 693D AB39 AB39 8B39"
	$"8A31 6931 4931 4931 6939 6A39 8B3D AC3D"
	$"AC35 8A31 6931 6931 49FE 356A 1435 8B31"
	$"492D 282D 482D 2831 4931 4835 8A29 2731"
	$"4939 8B31 4929 272D 2731 4831 6935 6A35"
	$"6A31 4931 6A35 6AFD 316A 422D 492D 482D"
	$"492D 2829 2729 282D 282D 4935 6A39 AB3D"
	$"AB39 AB39 AB3D AB35 892D 4831 4929 073D"
	$"AC39 8B29 272D 282D 2831 4939 8B39 AB35"
	$"8A35 8A2D 4925 0724 E625 0725 072D 2831"
	$"493D AC35 8A35 6A31 6935 8A31 692D 4831"
	$"492D 2829 2829 2729 0729 072D 4831 6935"
	$"6A35 6935 6931 492D 2829 072D 272D 492D"
	$"482D 282D 492D 4931 6935 6A31 6A31 6935"
	$"8BFE 358A 0B39 8A39 8A39 8B39 AB39 8B39"
	$"AB3D AB31 492D 4831 4829 0625 07FE 2928"
	$"582D 4931 6935 8B3D CD31 6A20 E620 E62D"
	$"4835 8B39 AB3D CC3D AB35 6A31 6935 6935"
	$"6931 6931 6931 6A35 8A35 8B39 8B31 4835"
	$"6931 4931 4831 6929 2720 E51C C414 8320"
	$"E635 6A29 0735 8A41 ED3D AB3D AB39 AB35"
	$"8A29 062D 2731 6935 6931 6A29 2835 6A2D"
	$"4825 0729 2829 282D 492D 4829 2829 2829"
	$"2739 AB41 ED3D AB39 8A2D 2731 483D AB3D"
	$"AC3D AC29 2724 E631 6935 6A39 8B3D AC3D"
	$"AB39 8B3D AB31 6925 0635 6935 8A2D 482D"
	$"2829 082D 4935 8B35 8A35 6A35 6A35 8B35"
	$"8A35 8AFE 3169 2F35 8A31 4929 0725 062D"
	$"282D 2839 8B3D AC35 6931 6931 4831 4931"
	$"6935 8A35 8A35 6A31 6A35 6A35 8A35 8B35"
	$"8A39 8A31 6935 8A39 8A35 8A31 4939 8A39"
	$"8A35 6A39 8A39 AB39 8B35 6A31 492D 2829"
	$"2829 282D 492D 292D 2829 0725 0724 E620"
	$"E620 E620 C620 E602 5B0A 316A 2D49 2928"
	$"2D49 2D49 2928 2D28 314A 398B 3DAC 356A"
	$"FE31 4910 2D28 2D27 2D08 28E7 3549 45CD"
	$"41CC 3D8A 398A 398A 398B 398B 356A 3169"
	$"356A 3169 316A FC35 6A16 398B 356A 3569"
	$"3149 2D28 3149 3DAC 356A 3149 3169 3149"
	$"358A 356A 2D28 2D28 356A 358A 356A 3149"
	$"2907 3149 398B 358A FD35 6A14 398B 398B"
	$"356A 2D48 3149 2D49 2D28 2928 20E5 20E6"
	$"2D48 2928 3149 3148 2906 2506 398B 39AB"
	$"356A 3149 3149 FD35 6A39 3569 3DAB 358A"
	$"3DAC 3DAC 398B 3149 2928 2D29 316A 3149"
	$"2928 2D49 3149 2D49 3169 3DAC 3DAC 398B"
	$"39AB 358A 2D48 2928 2D49 2D29 316A 2D49"
	$"2D28 2D49 358A 358A 3148 356A 398B 3DAB"
	$"356A 3169 2D28 3569 356A 356A 3149 3149"
	$"2D28 2D28 2928 2D49 2928 2D49 356A 2928"
	$"2D49 3169 316A 358B 358A 3169 356A FE31"
	$"690A 3149 3169 3169 356A 356A 358A 316A"
	$"398B 39AB 316A 358A FE39 8A01 3D8B 398A"
	$"FE3D ABFE 398B 5F2D 2825 0625 0629 2729"
	$"282D 492D 4935 8A35 8A31 6939 8B3D AB41"
	$"CC35 AB25 0620 E635 8A3D CC3D AB3D AB39"
	$"8A35 6939 8A3D AB35 6924 E629 2729 272D"
	$"482D 4931 4935 8A35 8A29 0635 6A35 6A29"
	$"2821 071C E618 A51C C52D 4931 493D CC3D"
	$"CC39 8A39 AB39 AB2D 481C C420 E525 0629"
	$"2729 2829 2831 6931 6A35 8A39 8A2D 4839"
	$"8B35 8B31 6935 6935 8A39 AB31 6931 4931"
	$"492D 2835 6939 8A39 AB3D AB35 6935 8A35"
	$"8A31 492D 4931 692D 4929 282D 2825 062D"
	$"2839 8B39 8A35 6935 6935 6A35 8A31 692D"
	$"492D 282D 4935 6AFE 3169 1231 492D 492D"
	$"2824 E620 E620 E629 2829 282D 282D 4929"
	$"062D 2835 6935 6A35 6A3D AB39 AB39 8A39"
	$"8BFD 356A 0C31 4931 4935 8B35 6A35 6A35"
	$"6935 6939 8A39 8B39 8A35 6A29 2825 07FD"
	$"20E6 0625 0720 C625 0729 0825 0725 0729"
	$"08FE 2507 0256 1F2D 4929 0820 E625 0724"
	$"E720 E625 072D 2829 072D 4931 4935 8B39"
	$"8B39 AB35 8A35 6931 4939 6A3D AC3D AB3D"
	$"AB39 8A35 6A35 6A31 492D 282D 2831 493D"
	$"AC3D AC2D 4929 28FE 3149 0839 8B39 8B35"
	$"6A35 6A35 6931 4935 8A39 8B35 8AFD 2D49"
	$"0224 E725 0731 49FE 356A 2E39 8B31 4931"
	$"6A35 6A31 492D 4831 4931 4935 6A39 8B35"
	$"6931 482D 482D 492D 4931 692D 4925 0735"
	$"6A3D AC35 8A35 6A29 2729 272D 2839 8B39"
	$"8A35 8A35 8A39 8A39 8B35 6A31 6931 6931"
	$"493D AB41 CC39 8B35 6A31 6929 0724 E629"
	$"072D 4929 0739 8B3D ACFE 316A 0235 6A35"
	$"8A39 8AFE 358A 2931 6931 692D 292D 4931"
	$"4924 E62D 2839 AC35 8A31 4935 8A35 8B31"
	$"6935 6A35 8A35 8A35 6A31 492D 2829 0729"
	$"2729 2825 0729 2829 2820 E629 282D 2824"
	$"E62D 282D 2835 6A39 8B2D 482D 4939 AB35"
	$"8A35 6A35 8A39 8B3D AC39 8BFC 358A 0135"
	$"6A31 48FD 3DAB 1B39 8A31 4831 4931 492D"
	$"2829 2829 2825 071C C51C C529 0729 2831"
	$"4935 8A39 AB41 CC39 AB39 8A3D AB3D AB3D"
	$"CC35 8A29 262D 4839 AB35 6935 6939 6AFD"
	$"398A 3C29 271C A425 0625 0729 282D 4935"
	$"6A39 AB35 8A29 2731 6939 AB35 8A31 6A35"
	$"8A31 692D 2835 8A3D CC35 8A31 6935 6939"
	$"8B39 AB2D 4920 E625 0725 2725 2729 282D"
	$"2831 6A35 693D CC39 8B31 4935 6A2D 492D"
	$"4835 8A3D CC35 8A25 0629 272D 282D 2831"
	$"6931 4835 6939 AB39 8A39 8A31 6935 6A35"
	$"8A35 8A31 8931 692D 482D 2731 69FE 358A"
	$"0539 8A35 6A29 0720 E529 2731 49FC 358A"
	$"2331 6A29 2825 071C C520 E620 E621 0625"
	$"2729 282D 4931 4931 6935 6A35 6A3D AB3D"
	$"AB39 8A3D AB31 692D 4831 482D 482D 2829"
	$"282D 492D 492D 2831 6931 6931 4935 6A35"
	$"6A31 4829 2725 0729 28FE 2507 0220 E625"
	$"0620 E6FD 2507 0029 28FE 2507 0261 022D"
	$"2824 E724 E6FD 24E7 3720 E624 E62D 2835"
	$"6A3D AC3D AC39 AB3D AC39 8A39 AB3D AB39"
	$"8B31 692D 492D 282D 2835 6A35 6A29 282D"
	$"2835 6A3D AC35 6A25 0729 0731 4931 6939"
	$"8B39 8B2D 2829 272D 4831 4831 6935 6A35"
	$"8A31 6929 282D 492D 2825 0729 0739 8B41"
	$"CC35 6A35 8A3D CC39 AB35 6A31 4931 492D"
	$"4831 492D 492D 2835 6AFE 3169 1235 8A39"
	$"8B39 AB39 8B35 8B39 AB3D CC3D AC35 8A35"
	$"6931 4931 492D 492D 482D 4831 6935 8A35"
	$"6A31 69FE 2927 2A31 4839 8B39 8B2D 2829"
	$"2829 272D 4829 0731 4935 8A2D 2841 ED3D"
	$"AC31 4931 692D 482D 492D 4831 4835 6939"
	$"8A31 6929 2731 492D 4829 2829 2820 E52D"
	$"4939 AC31 6929 2835 6A35 6A2D 4931 6935"
	$"6A2D 4931 6A31 4931 6931 4931 49FE 2D49"
	$"122D 4829 2831 6A2D 492D 282D 492D 4835"
	$"8A35 6929 0639 AB3D CC35 8A35 6939 8A3D"
	$"AC39 8B35 6935 8AFE 356A 0E3D CC35 6A35"
	$"6941 CC35 8A31 692D 4825 0625 0620 E625"
	$"0629 272D 4925 2829 49FE 2928 0A2D 4935"
	$"6A39 8A45 ED3D AB35 6931 6935 6931 6931"
	$"692D 48FD 2927 332D 2731 4939 8B39 8B35"
	$"8A39 AB2D 482D 4935 8A31 6A31 6A35 8A35"
	$"8B29 2820 E525 0729 0735 8A35 8A39 8A3D"
	$"AB39 AB35 8A31 6A31 6A2D 4929 2731 4935"
	$"8A35 8B29 2825 0725 2729 4829 482D 4931"
	$"6A39 8B39 AB3D CC35 8A2D 482D 482D 4931"
	$"6939 AB41 ED39 AB2D 2735 6A35 8B39 8AFE"
	$"358A 0A35 6935 6935 8A35 8935 8A35 8A35"
	$"8931 6931 6935 6935 8AFD 398A 0639 8B35"
	$"8A29 2725 0631 6939 AB35 8BFC 358A 2831"
	$"6A29 2825 071C E625 0720 E621 0629 2829"
	$"2831 492D 2831 4935 6939 8B39 8A3D AB39"
	$"AB2D 4831 4831 6931 692D 4925 0720 E625"
	$"0729 2829 282D 482D 4931 6935 6A31 6931"
	$"6935 6A35 8A2D 492D 4829 2829 2729 2829"
	$"28FE 2507 0425 0629 2729 2825 0729 2802"
	$"6602 358B 2D49 2908 FE29 2812 2D49 2D49"
	$"356A 398B 3DAC 3DAC 398B 398B 3DAC 3DAB"
	$"39AB 358A 3149 2907 2507 2928 2D28 358A"
	$"398B FD31 4922 2D49 2D49 3149 316A 356A"
	$"316A 3149 2D28 3149 356A 3169 356A 3149"
	$"314A 3149 2D49 3169 358B 3169 3149 398B"
	$"3148 2D48 3DAB 39AB 356A 3169 3169 3149"
	$"2D48 3169 2D48 316A 358B 3149 FD35 6A0C"
	$"358A 3569 398A 41CC 41CC 358A 3569 3149"
	$"2D48 2506 20E5 2506 2928 FE2D 492E 2928"
	$"2928 2D49 316A 398B 3169 20E5 2506 2D48"
	$"3169 398B 358B 39AB 398B 356A 398B 356A"
	$"316A 316A 3169 356A 356A 358A 3569 3569"
	$"2D48 3149 356A 3169 316A 316A 2506 3169"
	$"39AB 316A 2507 3149 398B 3569 2D48 2907"
	$"3148 3569 2906 2907 2D28 3149 FE2D 4952"
	$"2D28 3149 356A 3169 316A 356A 398B 3DAB"
	$"398B 3569 41CD 3DAB 358A 3DAB 3DAB 39AB"
	$"358A 3169 358B 356A 356A 39AB 3DCC 2927"
	$"358A 316A 2106 2527 2948 2D48 2D48 3169"
	$"358A 39AB 3149 20E6 2928 3149 3149 2D49"
	$"3169 356A 3DAB 41CC 3169 2506 2927 2D48"
	$"2D48 2D49 2D69 3169 3169 2D48 3149 3169"
	$"358A 358A 3569 3DAB 39AB 358A 39AB 39AB"
	$"358B 358A 316A 316A 2928 20C6 24E7 2908"
	$"356A 39AB 3DCC 3DCC 3169 2D48 2507 2107"
	$"2528 2507 2507 FD29 2814 2507 2507 2528"
	$"2928 356A 3DAC 3DCC 3DAB 3569 3169 356A"
	$"398B 398B 39AB 41ED 358A 24E6 358A 356A"
	$"358A 3169 FE31 492C 3148 3569 3569 3149"
	$"3149 2D48 2927 2D48 356A 356A 3569 3569"
	$"358A 3569 3569 356A 3169 2D48 3149 356A"
	$"356A 358A 3148 3148 3569 3169 356A 3149"
	$"3169 2D49 316A 2527 2507 2928 3149 3569"
	$"3169 358A 358A 398B 398A 358A 2D48 3149"
	$"3149 FE35 6A08 316A 3169 358A 356A 3149"
	$"3149 3169 356A 398A FE35 8AFE 356A 0B31"
	$"6A35 6A35 8A35 6A2D 4929 2829 2729 272D"
	$"492D 4929 282D 4802 5C07 398C 356B 316A"
	$"356B 356B 356A 356A 358A FE39 8B04 358B"
	$"356A 398B 398B 358A FE35 6A04 2D49 3149"
	$"314A 3149 314A FE31 490E 3169 316A 3169"
	$"356A 356A 358A 398B 358B 398B 356A 3149"
	$"3149 2D49 2D48 2D48 FE31 4958 2D49 2D49"
	$"2927 24E7 2908 2907 356A 358B 356A 358B"
	$"358A 358B 358A 316A 316A 358A 39AC 358B"
	$"2D49 2D28 2D28 2907 2D28 2D48 2D28 3169"
	$"41CC 41CD 358A 2D49 2928 2507 2507 2928"
	$"2D49 2D4A 2D4A 316A 358B 398B 358A 3569"
	$"358A 358A 2D48 2506 2907 358B 358B 316A"
	$"3169 316A 2D49 2D49 2D28 2907 2D28 356A"
	$"398B 39AB 39AB 3149 2D48 398B 358A 358A"
	$"358B 3569 39AB 39AB 3169 356A 398A 356A"
	$"2D48 398B 39AB 3149 2D28 3569 41CC 3148"
	$"2906 3149 2D49 2927 3149 3149 2D49 FE31"
	$"49FE 356A 2B39 8B39 8A39 8A3D CC3D AB39"
	$"8A35 8A39 8B35 6A31 6935 6935 6A3D AC35"
	$"6A35 6A39 AB31 6935 6A31 6929 2829 2739"
	$"AB35 6A35 8A39 AB41 CC39 AB35 8A2D 2829"
	$"0731 6939 8B35 8A35 6A35 6A39 8B41 CC3D"
	$"AC35 6929 2735 8A35 8A31 6935 8AFE 398B"
	$"0D35 6A35 6A35 8A39 8A35 8A39 8A3D AC39"
	$"8B35 8A35 6A31 4935 6A35 8A39 8BFE 356A"
	$"0B39 8B35 8A35 8A35 8B35 4929 0720 E51C"
	$"E521 072D 6939 AC35 8BFE 3169 1635 8A35"
	$"6A2D 4929 2825 0725 0739 8B41 ED3D AB39"
	$"AB39 AB39 8A39 8A3D AB3D AB39 8B3D AC39"
	$"8A35 6935 8A35 6A35 8B35 6AFE 3169 0131"
	$"4935 6AFE 358A 1235 6935 6931 6935 6935"
	$"6931 692D 482D 482D 282D 2831 4931 4931"
	$"6A35 6A39 8B31 692D 492D 2831 49FB 356A"
	$"1735 8A31 4931 6935 8A39 8B3D AC3D 8B35"
	$"6A2D 482D 2829 0729 0725 0725 0829 282D"
	$"4931 6A35 6A39 8A39 AB3D AB39 8B39 8B35"
	$"8AFC 356A 0F31 492D 2831 4931 6A31 4935"
	$"6A31 4929 2829 0824 E725 0729 2839 8B31"
	$"6A2D 4931 4902 6614 398B 398B 356A 356A"
	$"3149 3149 2D49 3149 3149 2D49 2D28 2D28"
	$"2D49 316A 3169 3169 316A 356A 3169 3149"
	$"3149 FE2D 4917 2D29 2D28 3149 398B 3DAC"
	$"398B 398B 3DAC 41CD 3DAC 316A 2D28 2928"
	$"2D28 3149 3149 358B 356A 2D48 2927 2507"
	$"2907 2507 24E6 FE25 0739 2928 3149 39AB"
	$"398B 39AB 358A 358A 3169 398B 39AB 398B"
	$"356A 2D48 2928 2D28 3149 3169 3149 2927"
	$"356A 45ED 3DAB 39AB 358A 358A 3169 358A"
	$"398B 358A 358A 3DAC 356A 39AB 398B 24E6"
	$"20E5 3149 358A 316A 2928 316A 3149 2928"
	$"2507 2506 2507 2507 2907 2928 2D28 3149"
	$"356A 398B 39AA 39AB 2927 358A 3DAB FD35"
	$"8A41 39AB 398B 356A 3569 358A 358A 398A"
	$"3569 3149 2D28 356A 3DAC 3DCC 3148 358A"
	$"356A 3149 3169 398B 3149 2D48 3169 358A"
	$"358B 3DAC 398B 398A 39AB 398B 39AB 3DCC"
	$"39AA 398A 358A 358A 398A 398A 3DAB 3DAB"
	$"3DCC 398B 358A 3569 3569 39AB 358A 2D48"
	$"2D48 3569 3149 3569 398B 3569 356A 3DCC"
	$"358A 358A 398A 358A 358A 3569 3169 3569"
	$"3DAB 45ED 3DAB FE35 6907 3169 358A 358A"
	$"398A 398B 398A 358A 398A FE35 8A21 398B"
	$"358A 3149 3169 3569 398A 356A 356A 358A"
	$"358A 39AB 358A 2927 2506 2106 1CC5 1CC5"
	$"2507 2948 358B 39AB 39AB 3DAB 358A 3169"
	$"3148 3148 356A 356A 316A 2D49 2D49 39AC"
	$"398A FE39 AB04 3169 39AB 3DCC 3DAC 358A"
	$"FD31 4927 3169 3169 3149 3169 2D48 2928"
	$"2D49 356A 358B 358A 358A 3169 3169 358A"
	$"356A 3149 3149 2927 2D28 2D49 2D49 3DAC"
	$"3DAC 358A 3149 2928 2507 2506 2507 2D49"
	$"2928 2927 2D48 356A 3DAC 358B 2507 2507"
	$"2D48 3169 FE31 4911 2D28 2928 2907 2507"
	$"2507 2506 2507 2928 2D49 358A 398A 398B"
	$"398A 3DAB 39AB 398B 356A 3149 FE2D 4903"
	$"3149 2D48 2D49 2D48 FE2D 28FE 2907 0625"
	$"062D 2835 6A31 6931 6935 6931 6902 6913"
	$"398B 356A 2D28 3149 3169 356A 398B 356A"
	$"2507 20E6 2507 2928 356A 316A 314A 358B"
	$"358B 398B 3169 2D48 FD29 280D 2908 2D28"
	$"3149 316A 3149 2928 3169 41ED 3DAC 2D28"
	$"2907 2927 2D28 2D49 FE39 8B53 316A 2D49"
	$"2928 2907 2928 2D28 2D49 2D28 2D49 358A"
	$"398B 39AB 398B 358A 398B 358A 356A 3569"
	$"398A 3169 3148 3148 356A 398B 39AB 398B"
	$"398B 3569 3149 3DAC 41CC 3DCB 3DCB 3DCC"
	$"3DCC 398A 358A 398A 398A 3DAB 41CC 2D48"
	$"3169 2506 18A3 2927 358B 2D49 2928 316A"
	$"358B 2D49 2928 2507 2506 2507 2507 2928"
	$"2D28 3149 356A 358A 398B 39AB 3169 2506"
	$"358A 39AB 398A 398A 39AA 398A 358A 356A"
	$"3569 398A 398A 3149 3169 356A 398A 398B"
	$"3DAB 3DAB FE39 8A0F 39AB 358A 356A 3169"
	$"2D48 2D48 3169 3149 3149 356A 3148 358A"
	$"398B 398A 39AB 398B FE39 8A0F 3DAB 3DCC"
	$"3DAB 3DAB 398A 3169 2D48 2907 24E6 2D48"
	$"2D48 3149 3169 3148 3169 356A FE35 8A3D"
	$"398B 39AB 356A 3569 3169 3169 2906 2927"
	$"2906 2D48 398A 45ED 398B 398A 356A 3569"
	$"398B 39AB 3569 398A 39AB 398B 3569 3169"
	$"3149 3169 358A 398B 3DAB 398B 358A 2D48"
	$"2D48 3148 3149 3169 398A 3DCC 39AB 2D48"
	$"3169 2D48 2507 2928 2D49 3169 358A 3169"
	$"3169 3569 3148 3148 2D48 2D48 3148 2D28"
	$"2D28 2927 2508 2928 2D28 2D48 FE31 690B"
	$"39AB 358A 356A 3149 2D28 2D28 2927 2D28"
	$"2D48 3149 3149 2D49 FE29 280D 3169 356A"
	$"358A 356A 2D28 2907 2928 2928 2907 2928"
	$"2928 2D28 3169 356A FE39 AB10 358A 316A"
	$"2D49 2927 2507 2928 2D49 3169 358B 3DAC"
	$"41CD 2907 1483 20E6 2507 2507 24E7 FE25"
	$"0710 2927 2D28 2D49 2D49 2D48 2D28 2D48"
	$"358A 398B 398A 398B 398A 398A 358A 3169"
	$"3149 2D48 FD29 280F 316A 3DAC 3149 2928"
	$"2D49 3149 356A 316A 2D48 3149 3169 3169"
	$"2D48 3169 358A 3DAB 0265 0139 8B35 6AFE"
	$"3149 1435 6A39 8B35 6A29 2820 E625 072D"
	$"4931 6A1C A520 C62D 2931 492D 492D 4929"
	$"2825 0725 0729 0825 0729 0729 28FE 2D28"
	$"5331 4941 CD41 CD31 4929 2829 072D 2831"
	$"4935 6A39 8B3D AC39 AC35 8B31 4931 492D"
	$"4931 6935 8A39 8B3D 8B3D AC41 AC3D AB3D"
	$"AB39 8A31 692D 482D 2831 4831 4931 492D"
	$"282D 4831 6939 8A3D AC3D CC39 8B35 6A35"
	$"6A39 8A3D AB41 CC3D CC41 CC41 CC35 8A31"
	$"4831 6935 6A39 8B39 8A35 8A31 4935 692D"
	$"4829 2739 AA39 AB35 6A31 6935 8A39 AC35"
	$"8B31 6A31 4929 2831 4935 6A31 6A35 6A35"
	$"8B39 AC39 8B39 8B35 6A29 0731 4935 8A39"
	$"8B39 8A35 8A39 8B35 8AFE 356A 1639 8A35"
	$"6A35 6A39 AB39 AB39 8B3D AC3D AC3D AB3D"
	$"CC3D AB3D CC39 AB2D 482D 282D 272D 282D"
	$"482D 4825 062D 2835 6A31 49FE 356A 1C39"
	$"8A35 6935 8A39 8B3D AB35 8A31 4931 492D"
	$"2829 0725 0725 0720 E720 E629 0829 082D"
	$"2831 6931 6935 8A39 AB39 AB35 8A31 6931"
	$"692D 482D 282D 282D 49FE 3149 172D 4831"
	$"4939 AB39 AB31 4831 6931 4831 6939 8B39"
	$"8B39 8A39 AB35 6931 4831 4831 4931 6935"
	$"6A39 8B3D AC45 ED3D AC2D 482D 27FE 3149"
	$"1435 6A39 8A39 AB39 8A39 8A39 AB35 8A25"
	$"072D 4829 2725 062D 482D 4831 6935 AB35"
	$"8A31 6A2D 4825 0720 E624 E6FE 2507 1125"
	$"0829 2825 0725 0729 282D 492D 4929 2829"
	$"282D 2829 0729 2725 0725 072D 4831 4931"
	$"482D 48FE 3169 032D 282D 2829 2829 28FC"
	$"2507 2329 2829 282D 2935 8A35 8B35 8A3D"
	$"CC3D AB35 8A3D AC39 AB2D 2831 4839 AB3D"
	$"AC39 8B39 8B3D AB35 8A1C A41C C51C E621"
	$"0725 0725 0725 0829 0725 072D 492D 4931"
	$"6935 6A31 6A35 8B35 8A31 69FE 356A 0539"
	$"8A39 8A31 692D 482D 2829 07FD 2928 0F31"
	$"4935 6A29 282D 2831 6A35 6A35 6A31 492D"
	$"2831 4931 6931 4931 6931 6939 8B41 CD02"
	$"611E 358B 314A 2D28 2907 2907 2D28 2D28"
	$"2907 20E6 24E6 2928 314A 2D28 18A4 2907"
	$"356A 3149 314A 314A 2D28 2928 2D28 2908"
	$"2907 2908 2D28 3149 356A 398B 3DAD 358B"
	$"FE2D 2830 2928 2D28 3149 356A 398B 41CD"
	$"3DCC 2D48 2D48 356A 356A 3DAB 41CC 3DAB"
	$"3DAC 3D8B 3569 398A 3DAC 3569 2927 2927"
	$"2D28 2928 2D28 2D48 3149 356A 398B 3DAC"
	$"41CC 3DAB 398A 3569 356A 398A 41CC 41CC"
	$"3DAB 41CC 398A 3148 3569 3169 3569 358A"
	$"356A 3DAB 41CC FD3D AB0A 358A 356A 3149"
	$"2D49 3169 3149 3149 358A 358A 398B 39AB"
	$"FE39 8A0A 356A 356A 3569 3149 3149 398A"
	$"358A 39AB 398B 39AB 39AB FD39 8A03 3DAB"
	$"3DAB 398A 39AB FE3D AB1B 3DAC 3DAB 3DAB"
	$"398B 3DAB 3DAB 3569 3569 3169 3169 3569"
	$"2D28 2D27 3569 2907 2D28 356A 358A 358A"
	$"398B 358A 39AC 356A 3149 2507 2D28 316A"
	$"316A FD2D 4902 3149 3149 2D49 FE35 6A3B"
	$"358A 39AB 39AB 398A 3569 356A 3169 314A"
	$"356A 356A 3149 356A 3169 3169 39AB 39AC"
	$"2908 20C5 2506 2907 2D48 356A 3DAC 398B"
	$"398A 2D48 2D28 356A 356A 398B 3DAB 39AB"
	$"3DAB 45EE 358A 2506 3569 39AB 398A 398B"
	$"398A 398A 39AB 358A 3DAB 3DAB 3589 2927"
	$"316A 356A 3169 358A 398A 3DAB 3DAC 316A"
	$"2D49 2507 2506 20E6 FE25 0701 2928 2908"
	$"FB29 282C 2927 2928 3149 3149 2D49 2D28"
	$"2D28 316A 356A 3149 3569 358A 3169 2927"
	$"20E6 24E6 20E7 2508 2928 2D49 2928 2507"
	$"2507 2928 2D28 3149 358A 398A 3DAB 3DAB"
	$"3169 39AB 45ED 3DAB 3148 398A 39AB 398A"
	$"3169 3148 3149 2907 2506 2507 20E6 FE25"
	$"0727 2928 2D49 3149 316A 356A 3169 3149"
	$"358A 39AB 2D28 2D48 358A 3169 356A 398B"
	$"3149 2D48 2907 2D28 2D28 3149 3169 3149"
	$"3169 3569 356A 398B 3569 2D28 2D28 3149"
	$"3149 3169 3169 2D28 2D28 3149 3169 358A"
	$"39AB 0242 022D 4925 0720 E5FB 20E6 0829"
	$"2831 6A35 6B31 6A31 4935 8B31 492D 282D"
	$"49FE 2D28 302D 292D 282D 2831 4935 8B35"
	$"8B39 8C31 6A29 0824 E729 072D 282D 2831"
	$"4931 4931 6A39 8B39 8B41 CD3D AC2D 2831"
	$"6935 6A35 6939 8B3D AB39 8A39 8A35 6935"
	$"6935 6A35 6A35 692D 4831 692D 492D 4931"
	$"4935 6A39 8B3D AC41 CC41 CC3D AB3D AB39"
	$"8A35 6935 693D ABFE 41CC 1B3D AB31 4831"
	$"6931 482D 4831 6931 4839 8A41 EC41 CC3D"
	$"AB39 AB35 6A31 4929 2729 2831 6931 6A35"
	$"8A35 8A35 8B35 8A2D 492D 482D 2829 0729"
	$"0729 28FD 2507 0329 2725 072D 2835 6AFD"
	$"398A 0839 AB39 8A35 8A3D AB3D AB35 6939"
	$"8A39 8A39 8BFB 398A 0D35 6935 6939 AB39"
	$"AB41 ED35 8A29 0635 6935 8A2D 4839 AB39"
	$"8B35 8A39 ABFE 398B 0731 4929 0729 0729"
	$"2835 6A31 6A31 6A31 49FE 3169 0D31 492D"
	$"4835 6931 492D 482D 4831 4931 6935 6A31"
	$"6935 6A35 6A35 8A39 8BFE 398A 1035 6935"
	$"6935 8A2D 4920 E625 0629 0731 4935 6939"
	$"8A3D AC39 8A39 8A31 4831 4839 8A39 ABFD"
	$"3DAB 1939 8A2D 272D 2739 AB3D AB39 AB39"
	$"8B39 8A3D AB3D AB39 AA3D AB35 6931 6835"
	$"6A41 CC41 CD3D CC3D AB39 8A31 482D 2729"
	$"2731 4931 692D 49FC 2928 FC2D 4909 2D28"
	$"2928 2D49 316A 316A 3149 2D48 2D49 2D48"
	$"2D48 FD31 6A08 2507 1CC5 2507 2507 20E7"
	$"2928 356A 356A 3149 FD2D 280B 3569 398A"
	$"398A 41CC 3589 3569 41ED 41CD 2927 24E5"
	$"358A 3569 FE2D 4803 2D49 316A 3169 2D49"
	$"FE29 2828 2D48 3149 3149 2D48 3169 3DAC"
	$"3148 2D28 3148 2D28 2D28 356A 3169 3149"
	$"358A 398B 356A 3569 3169 356A 3569 356A"
	$"358A 358A 398A 398A 398B 356A 356A 2D28"
	$"3148 3169 356A 358A 398B 3169 3169 356A"
	$"358A 356A 398A 0259 112D 492D 282D 4831"
	$"6A31 692D 482D 482D 2829 0829 0829 0729"
	$"0829 282D 282D 492D 492D 2829 28FC 2D28"
	$"2835 6A39 AC31 6A29 2829 2820 E620 E725"
	$"0829 282D 2831 4935 6A35 8A35 8A39 8B39"
	$"AB41 CC35 8A2D 4835 8A39 8A35 8A35 6A3D"
	$"AB3D AB35 8A35 6A35 8A39 8A35 6A35 6A39"
	$"8A39 AB3D AC39 8B31 6A35 6A39 8A35 6A35"
	$"6A39 6AFE 398A 0135 6935 69FE 41CC 163D"
	$"AB39 8A2D 4831 4831 4835 6939 8A39 8A41"
	$"CC3D AB35 6931 692D 482D 2831 4931 6A35"
	$"8B39 8B35 8A35 8A39 AB39 AB35 8AFE 3169"
	$"FE2D 49FE 2928 0D25 0729 282D 2831 6939"
	$"8B39 8B35 6939 8A39 AB39 AB39 8A39 AB3D"
	$"CC39 ABFE 358A 2E31 4935 6A35 8A39 8B39"
	$"8B39 8A35 6A35 6935 8A35 8A39 AB39 AB2D"
	$"272D 273D AB3D AC3D AC35 8A35 8A39 8B39"
	$"8A31 492D 2729 0724 E625 0620 E624 E61C"
	$"C520 C52D 4931 6931 4931 6935 6935 6A35"
	$"6935 8A31 6931 6931 492D 282D 2829 2729"
	$"072D 482D 48FE 3169 0A35 6931 482D 4831"
	$"492D 4825 272D 4839 AB31 6A39 AB39 8AFE"
	$"3569 0531 6931 6935 693D AB39 8A35 8AFE"
	$"3569 0431 6935 8A3D CC3D AB35 8AFE 398A"
	$"143D AB3D AB39 AB35 6935 8A39 8A41 CC45"
	$"ED41 CC3D AB3D AB39 8A2D 2725 0629 0735"
	$"8A39 8B31 6A31 692D 492D 48FD 2D49 412D"
	$"282D 4929 2829 0729 282D 492D 492D 4829"
	$"2729 2829 2725 0724 E62D 4935 8B39 8B31"
	$"6A25 071C C425 0725 0724 E639 6A52 3028"
	$"E62D 2735 6A39 8B39 8A31 6935 6939 8A3D"
	$"AB41 CC31 6935 693D AB35 8A20 E524 E635"
	$"8A35 6931 4931 6935 6A35 AB35 AB31 6931"
	$"4935 8B31 6A31 6935 8A2D 482D 4831 4835"
	$"8A35 8A35 6935 6A31 4929 272D 4831 4931"
	$"4935 6AFE 398B 0535 8A39 8A39 AB39 8B39"
	$"8A39 8AFE 358A 0235 6A35 6939 8BFD 356A"
	$"0739 8A35 8A39 8A39 8A39 8B39 8A35 6935"
	$"6902 6812 2D29 316A 398B 3DAC 398A 39AB"
	$"3DAC 2D28 24E7 2908 2907 2907 2908 2928"
	$"2D28 3149 316A 2D49 2D49 FE31 490A 356A"
	$"39AC 2D49 2927 2507 2927 20E6 2507 2508"
	$"2D29 356A FD39 8B1C 398A 398A 358A 3169"
	$"356A 398B 3DAB 3569 3569 398A 356A 3149"
	$"3149 3569 398A 39AB 39AB 398B 41CC 39AB"
	$"2D28 24E5 2907 2D28 2D28 3149 356A 398A"
	$"398A FE35 69FE 3DAB 1D35 8A35 6935 8A39"
	$"8A39 AB39 AB3D AB3D AC39 8B31 492D 4829"
	$"272D 2831 6931 4925 072D 2835 8A39 8B3D"
	$"AB3D AB39 AB39 8A39 8A39 8B39 8B35 8B35"
	$"8A39 AB39 8AFE 358A 0139 AB39 ABFE 2D28"
	$"0629 0731 4835 8A35 8A39 8A39 8B39 ABFE"
	$"398A 4339 8B35 6935 8A39 8A3D AB39 AB39"
	$"AB39 8A39 8A35 6931 692D 482D 4839 AB41"
	$"EC41 CC3D AB39 8B35 6A35 6A31 4925 0620"
	$"C520 E521 0621 0725 0725 0725 081C C51C"
	$"C529 282D 282D 282D 4831 6935 8A39 8B39"
	$"8B39 8A39 8A35 6A31 6935 6A35 6A35 8A39"
	$"8B39 8A39 8B35 6931 6935 6A2D 282D 4935"
	$"8B39 8B2D 2839 AB3D CC39 8A39 AA31 6929"
	$"2729 272D 2831 4939 8B35 6AFE 2D28 082D"
	$"4831 4831 4831 6935 693D AB39 8A31 4835"
	$"8AFE 398A 1839 AB39 8A3D AB39 8A39 8A3D"
	$"AA3D AB39 8A3D AB41 CC39 8A31 692D 4835"
	$"6939 AB39 8B35 8A31 6A35 6A31 6A31 6A29"
	$"2825 0729 2729 07FE 2507 5029 0829 0729"
	$"0725 0729 2839 AB31 6A2D 492D 4931 6A39"
	$"8B35 6A39 8B39 8B2D 482D 282D 2839 2952"
	$"0F45 AC14 2031 483D AA39 AB35 6935 6931"
	$"6939 8A3D AB35 692D 2729 0731 4835 8A2D"
	$"4931 6931 6931 6A31 6935 8A3D AC35 8A29"
	$"2729 272D 2831 6931 4931 4939 8B35 6A35"
	$"8A31 6929 2831 4935 6A31 492D 492D 4829"
	$"072D 2835 8A3D AC3D AC35 6A35 6A35 693D"
	$"AB39 8A35 8A39 8A39 AB39 AB39 8A35 8A35"
	$"8A35 6A35 8A35 6A35 6A31 6935 6AFE 3569"
	$"0435 4935 6931 4835 6935 6902 6032 314A"
	$"396B 3D8B 39AB 3DAB 3DAB 398A 2D48 2D28"
	$"2908 2908 2928 2928 2D29 3149 358B 398B"
	$"396A 398A 3DAB 398A 356A 39AC 3149 2928"
	$"2928 2D29 2928 2507 2928 316A 358B 398B"
	$"356A 356A 3569 3149 2D28 3128 3149 314A"
	$"398B 3DAC 398A 356A 356A 358A 356A 356A"
	$"3169 356A FE39 8A06 3DAB 3DAB 2927 1CC5"
	$"20E6 2928 2D28 FE35 6AFE 398B 0931 6935"
	$"6A39 8B3D AB3D AC41 CC31 4931 4939 8A35"
	$"69FC 3149 122D 4831 4931 6931 4924 E620"
	$"C535 6A3D AC3D AB39 8B35 8A35 6935 693D"
	$"AB39 8A35 6939 8A39 8A3D 8BFC 398B 0131"
	$"4925 06FE 2928 1A2D 2831 4935 6935 6A35"
	$"8A39 8B35 6A35 8A39 AB39 8B35 8A39 8A35"
	$"8A3D AB35 6A35 6A2D 4829 2729 2829 0731"
	$"4941 CC45 CC39 8A35 6939 8A31 48FE 24E6"
	$"1320 E62D 4920 E720 E625 0829 0825 0725"
	$"0825 0729 2829 2829 272D 4931 4935 8A39"
	$"8A39 AB3D AB3D AB39 ABFD 358A 3639 8B39"
	$"AB31 492D 2835 693D AB3D AB35 8A31 6931"
	$"6935 8B29 0735 6A31 6935 6935 8931 6931"
	$"6931 6A35 6A35 8A39 8B35 6A35 6A35 8A39"
	$"8A35 8A31 492D 282D 2831 4939 AB31 4824"
	$"E624 E624 C629 0735 4935 6931 482D 0724"
	$"E52D 2835 6939 8A3D AB45 ED39 AA2D 4831"
	$"4931 6A35 6A39 8A39 8B39 8BFD 398A 2831"
	$"6A2D 4935 6A31 492D 492D 4929 2820 E610"
	$"622D 2831 493D AC3D AC39 8A39 AB39 AB35"
	$"6A29 2829 0731 692D 2829 0731 4935 6A3D"
	$"4A45 8B35 2814 4029 0631 4939 8B31 6931"
	$"4931 4935 6A35 6A29 2820 E620 E525 072D"
	$"49FE 3149 3335 6A35 8A39 AB39 AB31 4929"
	$"272D 482D 4831 4931 4935 6935 6A31 4931"
	$"692D 4829 2731 4931 492D 492D 4935 6A31"
	$"6935 6A39 8A39 8B35 8A35 6931 4935 6A39"
	$"8A31 4835 6941 CC3D CC39 8A35 6A35 8A35"
	$"6A35 6A31 6935 6A31 6935 6A35 8A39 8B35"
	$"6A35 8A35 6931 6931 6935 6935 8A02 780F"
	$"356A 398B 3D8B 39AB 398A 358A 356A 3149"
	$"3149 2D49 2D49 2D28 2D28 316A 316A 358A"
	$"FE35 6A0E 398B 3169 356A 398B 316A 358B"
	$"356B 314A 2928 2507 2928 2D49 2928 24E6"
	$"2908 FD29 2809 2D29 314A 356A 398B 398B"
	$"3149 356A 358A 398B 358A FE39 8B3C 356A"
	$"356A 398B 398B 3569 2928 2D49 356A 358A"
	$"358B 398B 2D49 2507 2D28 398B 398B 356A"
	$"3169 398A 3DAC 3DAC 3DCC 2D48 2D28 358A"
	$"3169 316A 2D49 3169 356A 316A 3149 3149"
	$"2927 2507 2507 3149 398B 356A 356A 398A"
	$"3149 2D48 398A 398A 2927 2906 2D27 2D28"
	$"2D48 2D48 316A 3149 2D28 2D28 2927 2D48"
	$"358B 358A 358A 398B FE35 8A7F 398A 3DAC"
	$"3569 3148 3149 398A 356A 2D28 3569 3169"
	$"3148 3569 3149 316A 356A 3149 358A 39AB"
	$"356A 3569 3169 2927 20E6 20E5 2507 20E6"
	$"2107 2D6A 1CC5 2507 2D28 2D49 3149 2D48"
	$"2D49 2D49 2D28 2D48 3149 3169 398A 356A"
	$"358A 3569 358A 356A 3169 356A 3569 3569"
	$"398A 358A 2907 2D28 3149 3DAB 3DAB 39AB"
	$"3169 3149 356A 2D49 356A 398B 398A 398A"
	$"3149 356A 398A 356A 3149 2D48 3DAB 3DAC"
	$"398A 398A 2D27 24E6 358A 398A 3148 2927"
	$"24E6 24E6 20C6 1483 1483 18A4 18A4 1462"
	$"0C41 20E5 356A 39AB 41CC 41CC 3DAB 2D27"
	$"3148 3149 316A 358A 3569 356A 356A 3169"
	$"2D28 2907 2D49 2D49 316A 2D49 2D48 3169"
	$"316A 316A 2D48 2928 358B 3DAC 39AB 398A"
	$"398B 398B 358A 316A 2928 2D48 4C31 692D"
	$"2831 4939 8B39 8A3D 6A39 482D 0718 621C"
	$"A331 4939 AC39 8B35 6A35 6931 6935 8A31"
	$"692D 4829 2725 2625 0731 4931 6A39 8B35"
	$"8B35 8A35 8A31 6931 6935 6A31 6935 6A39"
	$"8B39 8B35 6A31 6935 6A31 6A31 492D 282D"
	$"482D 4831 6A35 8A35 8B35 8A39 8A35 6A35"
	$"6A31 4935 6935 6A39 8A39 8B35 6A39 8B39"
	$"AB35 6A31 4831 4831 492D 4829 2729 0729"
	$"272D 4831 4935 6A35 8B2D 4929 2731 6931"
	$"8A35 AB46 0F56 9302 6F07 396A 398B 398B"
	$"398A 358A 356A 358A 3169 FE35 6A1F 39AC"
	$"398B 3149 2D28 2D48 2D29 2D28 3169 3169"
	$"3DAB 3DCC 316A 358B 2D49 2928 2908 2507"
	$"24E6 2507 2908 2507 2507 2D49 316A 316A"
	$"2D49 2D49 314A 358B 358A 356A 316A FE31"
	$"4920 3169 3569 398A 358A 3169 3169 358A"
	$"3169 2D48 356A 398B 39AB 39AC 3DAC 3DAC"
	$"2D28 20E6 2507 2D48 2D49 2D28 356A 358A"
	$"398B 39AB 3DAB 39AB 358A 316A 2D49 2928"
	$"316A 2D48 FC29 2837 2507 2928 316A 316A"
	$"3149 3169 3169 3149 2927 2D28 2907 20E6"
	$"20E5 20E6 20E6 2506 2928 2928 316A 358A"
	$"356A 3169 2D49 2D48 3169 356A 398A 3DAB"
	$"358A 39AB 398B 398A 398B 2D27 2906 2D27"
	$"398A 3149 2D27 398B 3569 398A 3DCC 41CC"
	$"356A 3169 2927 2927 356A 3149 3149 2D48"
	$"2928 2D49 316A 2D49 FE29 2812 2D69 316A"
	$"358A 358A 356A 3169 3149 2D28 3149 356A"
	$"3149 3169 398A 358A 39AB 3569 356A 3569"
	$"3149 FE35 6A5E 398A 356A 358A 3169 2506"
	$"3DAB 358A 3DAB 398A 398B 3DAC 39AB 3169"
	$"2D48 2928 24E6 20C5 2506 2506 2907 2907"
	$"2D28 358A 358A 39AB 3DAC 2D28 2D48 356A"
	$"2927 20E5 20E5 20E6 2507 2508 1CE6 14A4"
	$"1083 18C5 1CE6 20E6 358B 39CC 41CC 45ED"
	$"3DAB 3569 2D27 2D28 2506 2D28 3149 3569"
	$"356A 3569 3149 2D28 2907 2907 2507 2507"
	$"2907 2928 2928 3169 398B 358B 358A 2D48"
	$"398B 3569 3149 3148 2D48 3169 3169 398B"
	$"3DAC 398B 358A 356A 3569 3148 3D8B 3528"
	$"20A4 20A4 1862 24E6 316A 41ED 39AB 398A"
	$"3569 358A FE39 8A25 356A 356A 39AB 39AB"
	$"39AC 39AB 398B 358A 398A 39AB 358A 3569"
	$"3169 356A 3149 24E6 20E6 2907 2507 24E6"
	$"24E6 2507 2507 2907 2D28 3149 316A 3569"
	$"3149 2D28 3169 39AB 39AB 398B 2D48 2D28"
	$"356A 3169 FE31 490F 3169 356A 2D48 2506"
	$"2927 2D48 3149 3149 318A 39CC 39CC 4630"
	$"4631 4210 56B5 5EF7 025A 2639 8B3D AB39"
	$"8B35 8A35 6A31 6931 6A31 492D 4931 4935"
	$"8B35 6B2D 2824 E620 C529 082D 2931 6A35"
	$"6A35 8A3D CC31 6A31 692D 2825 0724 E629"
	$"082D 2829 2829 2831 6A39 8B35 6A35 6A35"
	$"8A35 6A31 492D 482D 48FE 3149 FC35 6A10"
	$"39AB 398A 356A 3149 2D48 2927 2507 2507"
	$"2928 3149 3149 356A 39AC 2D49 2506 2928"
	$"2D49 FE31 490D 39AB 3DCC 3DAB 398A 398B"
	$"358A 316A 2D48 2928 2D48 2928 2907 2907"
	$"2527 FD29 2801 2507 2928 FD2D 490F 2928"
	$"2507 2908 2507 24E7 2507 2507 20E6 2928"
	$"2928 3149 398B 398A 3169 358A 39AB FE35"
	$"8A03 398B 3DAB 398A 398A FE35 692F 2D48"
	$"3148 3169 358A 3149 398A 3DAC 3DAB 41CC"
	$"41CD 398B 2D28 3149 3149 2927 356A 2D49"
	$"316A 358B 358B 39AB 39AB 358B 358A 398B"
	$"358A 358A 3169 3149 3149 2D48 2927 2907"
	$"2907 2D48 3149 3149 398A 3DAB 3DAC 3DAC"
	$"356A 358A 398A 356A 398A 398B 398A FD39"
	$"8B02 358A 39AB 398A FE3D AB1B 398A 3149"
	$"2507 2507 20E6 1CC6 20E6 2106 2106 2507"
	$"2907 3149 358A 3DCC 3DAB 2D48 24E5 20E6"
	$"20E6 24E6 2527 2927 2948 2D69 316A 2D49"
	$"2948 2948 FE35 8B04 3DAB 3DAB 41CB 3DAB"
	$"3569 FE35 6A2D 3149 3169 316A 356A 3169"
	$"316A 356A 3169 358A 3569 2D49 2D48 2D49"
	$"2D28 316A 398B 3DAC 356A 2D48 2D48 3169"
	$"3148 3148 2D48 3149 2D49 358A 3DCC 3DAB"
	$"398B 398A 3148 2907 2906 396A 2D07 20A4"
	$"2D07 1863 1CA4 20E6 358B 356A 358A 3169"
	$"3169 FE35 6A13 398B 398B 3D8B 398B 3DAB"
	$"398A 3569 3149 356A 3569 3148 3148 3149"
	$"3169 2907 1CC5 20E6 24E6 2507 2506 FE25"
	$"0702 2527 2928 2D49 FE35 6A1B 358A 398A"
	$"398A 398B 2D49 20E6 2928 356A 2D48 2D28"
	$"2D49 3149 358A 398B 2D48 2506 2928 3149"
	$"356A 2D48 4E71 5AB4 4610 5694 5ED7 4211"
	$"4210 6319 0258 0A3D AC35 6A35 6A31 4A35"
	$"6A31 4931 4929 2831 4939 8B31 6AFD 20E6"
	$"1025 0729 072D 282D 2929 0829 072D 4935"
	$"8A31 6A31 492D 2839 8B39 8B35 6A2D 4839"
	$"8A39 8BFD 356A 3531 6935 6A35 8A35 8A35"
	$"6931 4935 6A31 6935 6A35 6A35 6935 6935"
	$"6A39 8B35 6A31 4931 6A2D 4829 282D 4831"
	$"6A2D 2835 6A39 8B35 6A35 6A39 8B39 8B35"
	$"8A39 8B39 8B39 AB3D AB39 8B35 6A31 6931"
	$"692D 492D 4931 4931 4929 2729 2831 6935"
	$"6A31 6931 4931 4931 6A39 8B35 8B39 8B39"
	$"AB39 8BFE 358A 0F31 6A29 2829 2831 4A29"
	$"0829 0835 6A31 4939 8B31 492D 2725 0635"
	$"6A39 8B39 8A35 6AFE 398B 0935 6939 8A39"
	$"8A3D AB3D AB39 8A39 8A39 AB39 8A3D 8BFD"
	$"3DAB 2639 8A35 6931 4931 692D 4825 0639"
	$"8B39 AB35 8A39 AB3D AB3D AB3D AC3D AB3D"
	$"AB39 8A39 8A35 8A35 8A39 8A35 8A31 6A31"
	$"692D 4929 4829 4831 4935 6A39 8B3D AC39"
	$"8B35 6A39 8B39 8B39 8A39 8A3D AB3D CC39"
	$"ABFA 3DAB FD35 6926 356A 356A 316A 2D49"
	$"2928 2D49 2D49 2928 2908 2908 398B 39AB"
	$"39AA 2927 1CC5 1CC6 20E7 2928 3149 316A"
	$"358A 358A 39AB 358A 358A 398B 39AB 39AB"
	$"398A 398A 39AB 39AA 3569 358A 2D48 3569"
	$"398A 398A 358A FE2D 483D 3169 356A 358A"
	$"398B 398B 356A 358A 39AB 398A 2D48 358A"
	$"398B 3DAB 3148 3169 398B 398A 398B 39AB"
	$"3569 358A 398A 356A 3149 2927 3149 398B"
	$"3149 2927 2506 396A 3128 3969 49CD 1C82"
	$"1C83 1CA4 20C5 2D28 356A 356A 2D49 2D28"
	$"3169 398A 3DAC 356A 398A 398A 39AB 358A"
	$"358A 3569 3169 3169 356A 356A 2D28 2506"
	$"1CC5 1CC5 2106 FB25 0721 2928 2928 3149"
	$"356A 398B 39AB 3DAB 3149 3149 39AB 2D28"
	$"24E6 2928 2928 2927 2928 2D49 316A 398B"
	$"356A 356A 2D48 2D49 3169 316A 460F 62F7"
	$"5ED7 4611 4E73 62F8 4211 39AE 5ED7 0259"
	$"0331 492D 492D 292D 29FE 3149 0329 2831"
	$"4A31 6A2D 28FC 2507 0520 C620 E625 0720"
	$"E629 073D ACFE 398B 1D39 AB3D AC39 8A31"
	$"492D 2835 6A35 6A35 8B39 8B31 6931 4939"
	$"8B3D AC35 6A31 4835 6A35 6A31 4929 2829"
	$"2829 072D 2831 4931 4931 6A31 6A35 8B39"
	$"AB35 8A31 6AFE 356A 0639 8B35 6A35 6A2D"
	$"4935 6A35 8B35 8AFE 398B 0B39 8A31 6931"
	$"4931 4931 4831 4939 AB39 8B35 6A2D 492D"
	$"4831 69FE 356A 0331 4939 8B35 6A35 69FE"
	$"3149 0029 07FE 2928 2925 0625 0731 6931"
	$"492D 492D 4931 6A35 6A25 0725 072D 2735"
	$"8A39 AB39 8B39 8A3D AB39 AB39 8A31 6935"
	$"6A35 6A35 8A35 6931 4931 6931 6935 6A3D"
	$"AB39 8B39 8B35 8A35 6935 8A35 8A35 6A39"
	$"8A35 6A35 6A39 8B35 8A39 8A39 8BFE 358A"
	$"FE39 8AFE 3DAB 1A39 AB39 8A39 AB39 8B35"
	$"8A35 8A35 6A31 6935 6A31 492D 2829 0729"
	$"2739 8B31 6925 0639 8B3D AC39 AB35 8A39"
	$"8B39 8B39 8A39 AB3D AB39 AB31 69FE 2D48"
	$"0131 6931 69FE 356A 0E31 6A35 8A35 8A31"
	$"6931 4931 6935 8A31 692D 2825 0620 E629"
	$"0831 493D AC3D ACFC 3DAB 0139 8B3D ABFE"
	$"398B 7239 AB39 AB35 6931 4835 6931 4835"
	$"6935 8A41 CC29 2725 062D 482D 2735 6939"
	$"8A35 6A39 8A39 8A39 AB39 AB35 8931 4829"
	$"0729 282D 4831 492D 4935 6A39 8B39 8B3D"
	$"AC39 8B31 482D 272D 2729 0724 E624 E525"
	$"0631 4935 8A31 6931 6939 6A31 273D 6956"
	$"5024 A318 621C A41C A41C A529 0831 492D"
	$"492D 4929 2739 8B3D CC2D 2831 4835 6935"
	$"8A39 8A39 8A35 6A35 6A35 8A39 8A35 6A31"
	$"492D 2825 0720 E525 0725 0720 E620 E625"
	$"0725 072D 4929 282D 4935 6A39 8B35 6A39"
	$"8A39 8B29 072D 4835 8B31 6931 4931 492D"
	$"2831 4831 6931 4831 6931 6935 8A35 8A35"
	$"8B39 AC35 8B3D EE56 B45A D667 1931 6C46"
	$"325E F835 AE31 8E42 1102 6302 2507 2907"
	$"2507 FE24 E724 24E6 24E6 2D28 3149 316A"
	$"316A 3149 2D49 2928 2927 2507 2507 2927"
	$"2907 3169 398B 3148 398B 3DCB 3DCC 398A"
	$"3569 3148 3149 356A 356A 398B 356A 356A"
	$"3149 358A 356A 3149 3149 316A 2D49 2928"
	$"FE25 0706 2D28 3149 2D28 2D28 2D48 2D49"
	$"2D49 FD31 4919 356A 356A 2D28 2D28 2907"
	$"2D28 3149 356A 356A 358A 358A 3169 3149"
	$"3169 358A 398A 3DAC 41CD 3DCC 358A 3149"
	$"2928 2928 2927 2907 2506 FE29 0707 24E6"
	$"20E5 2506 20E6 20E5 2507 2D48 3149 FB31"
	$"691F 358A 3169 2928 2D48 398B 3569 3169"
	$"3569 3569 2D48 3148 3169 2D49 2D49 3149"
	$"3149 2D28 2907 2927 2D48 3569 3DAB 398A"
	$"3569 2D27 2D48 3149 3148 398B 3DAB 3569"
	$"398A FE35 6927 356A 3168 3148 3148 3169"
	$"3569 3DAB 3DAB 398A 2506 24E6 2907 3569"
	$"398B 398A 3569 3549 3169 3569 356A 3169"
	$"2D48 2D28 358A 2D48 3169 41CC 398A 356A"
	$"398A 396A 3569 3549 3DAB 39AB 3569 2D48"
	$"2D27 3148 3169 FD35 693C 3169 3149 3149"
	$"2D48 2D28 2927 2506 2D48 2D48 3149 3169"
	$"356A 358B 398B 41CC 41CC 3DAB 39AA 3DAA"
	$"3DAA 398A 398A 39AB 3DAB 39AB 3DAB 39AB"
	$"398A 356A 3148 2D48 358A 398A 41CC 3569"
	$"24E5 3569 398A 2D48 3569 358A 398A 398A"
	$"39AB 398A 2D28 2506 24E6 24E6 2507 2928"
	$"2D49 314A 2D48 3569 398B 3DAC 3DAB 358A"
	$"3148 2D27 FD24 E621 3148 356A 3569 356A"
	$"356A 3128 3969 3948 20A3 20A3 20A4 1CA4"
	$"1CA5 20C5 20E6 2D49 39AC 358A 398B 358A"
	$"20C5 24E6 398B 39AB 398A 358A 356A 356A"
	$"3569 358A 398A 39AB 3DAB 358A FE2D 2826"
	$"2907 2507 2907 2D28 3149 2D49 316A 3DAB"
	$"398A 3569 358A 356A 3149 316A 356A 358A"
	$"3DCC 3169 2D48 3169 316A 356A 358B 39AB"
	$"39CC 3DEE 420F 4630 4E73 5AD6 5AD6 5ED8"
	$"3DF1 18C7 41F1 6319 294C 292B 318E 025F"
	$"2420 C620 C624 E720 E620 E624 E724 E72D"
	$"2931 4931 4935 6A39 8B39 8B31 6A2D 492D"
	$"482D 2829 0729 0725 0629 072D 4839 AB41"
	$"CC3D AC39 8B31 6935 6935 6935 8A35 8935"
	$"8931 492D 2829 0725 0729 07FE 2D28 1E29"
	$"0729 2825 0725 0729 2729 072D 492D 4931"
	$"4931 492D 282D 492D 4929 4829 0729 282D"
	$"282D 482D 2829 272D 282D 482D 2831 492D"
	$"4831 6935 6A31 6931 4935 8A35 69FE 358A"
	$"0639 8B35 8A31 492D 2829 2829 0725 07FE"
	$"20E6 021C C629 082D 49FE 316A 0435 8B39"
	$"8B39 8B39 AB3D ABFE 398B 1539 8A35 6A35"
	$"8A35 6A31 4935 6935 8B29 2829 0729 0731"
	$"692D 2831 492D 492D 282D 4931 492D 4935"
	$"6A35 6A35 8A35 6AFE 3569 0935 8A31 6931"
	$"492D 2831 6939 8B39 8A39 8A35 6935 69FE"
	$"3148 1735 6A35 6939 8A35 8A35 6A31 692D"
	$"2829 2721 0629 2831 6A39 8B3D AC39 8B31"
	$"4835 6939 8A39 8A35 6A39 8B39 8B39 8A39"
	$"8B39 8AFD 3DAB 0635 8A35 6935 6A39 8B3D"
	$"AC39 AB39 8AFE 3569 0535 8931 4935 6935"
	$"6935 4931 49FD 3148 0A31 492D 4935 6A35"
	$"8B39 AB39 AB3D CC35 6939 8A35 8A39 8AFE"
	$"3569 1139 8A35 6939 AA3D AB3D AB39 AB3D"
	$"CC41 CC39 AB31 4829 062D 2739 8A3D AB3D"
	$"AB2D 2739 8A39 8BFE 356A 0129 0629 07FE"
	$"2906 1E20 E620 E625 0724 E624 E625 0729"
	$"2825 0729 072D 2831 6939 8A39 AB3D CC3D"
	$"AB31 4820 E625 0729 282D 4835 6A3D AB3D"
	$"AB35 6931 4935 4935 4928 C524 C420 A320"
	$"A4FE 20A5 171C A51C A531 4939 8B39 8B31"
	$"492D 282D 483D AC39 8A35 6931 4831 4931"
	$"6935 6935 8A39 8A39 8A39 8B31 692D 482D"
	$"2831 492D 48FE 3149 222D 482D 2831 4935"
	$"6A35 6A2D 2831 4935 8A39 8A35 6A31 6939"
	$"AB41 ED35 8B31 6A35 8C42 1046 314A 534E"
	$"734E 734E 744A 534A 535E F867 3B56 962D"
	$"6D18 A720 E93D F067 1A21 0A18 C835 8E02"
	$"6701 20E6 20E6 FE24 E706 2507 2907 2D28"
	$"3149 3169 358A 356A FD31 4927 356A 3149"
	$"3569 2D28 2D27 398A 3DAB 398A 396B 3149"
	$"3149 398A 39AB 39AB 358A 356A 3169 2D49"
	$"2907 24E6 2507 2D49 2907 2928 2D28 2928"
	$"2907 2908 2D28 2D28 2D49 2D28 314A 3149"
	$"356A 398B 3149 2928 2507 2928 FD2D 2855"
	$"2D49 3149 316A 2D49 3149 3149 3169 2D27"
	$"3149 356A 3169 3569 3149 3129 3569 41CC"
	$"3569 2D48 2D49 2D28 2D29 2507 2907 2928"
	$"3149 398B 358B 358B 3149 3149 398A 3DAB"
	$"356A 398A 3DAB 398A 398B 356A 3569 3569"
	$"356A 3569 398A 3148 2927 2D48 356A 358A"
	$"398B 358A 358A 3169 3169 398B 358A 3569"
	$"398B 358A 398A 3569 2D27 3569 3DCC 41ED"
	$"3DCC 39AB 398A 358A 398A 3569 398A 356A"
	$"358A 2927 2928 2D48 398B 314A 316A 356A"
	$"2D48 2928 2D48 3169 3D8C 3DAC FE3D AB05"
	$"3168 2D48 39AB 39AB 356A 3148 FC39 8A17"
	$"3DAB 398A 398A 3DAB 3569 398A 398A 358A"
	$"398B 398A 3D8B 3D8B 3DAB 39AB 3569 3569"
	$"398A 398A 356A 3149 3148 2D48 3169 3DCC"
	$"FE39 AB3C 398A 3569 398A 3DAB 3148 41CC"
	$"398A 398A 3569 2927 2D48 356A 358A 41AB"
	$"3D8A 3969 3149 3DAB 398B 2D28 2506 2906"
	$"3569 3DAB 3DAB 398A 356A 3149 3148 3148"
	$"3569 3569 20E5 2506 24E6 24E6 2506 2507"
	$"20E7 2507 20E7 20E6 20E6 2508 2507 2D28"
	$"2D28 3149 3569 3569 3DAB 39AB 3569 2928"
	$"2907 2907 2D48 358A 41CC 398A 2D27 FE31"
	$"4920 28E6 20C5 20A4 20A4 20C5 20C5 20A5"
	$"20A5 1CA4 1CA4 24E7 2D49 2908 354A 396A"
	$"356A 3569 3149 3149 3569 398A 3D8B 398B"
	$"3569 396A 3149 2D28 2D28 2D29 2D28 2D49"
	$"2D28 2927 FD25 071F 2D49 2D49 2507 358B"
	$"3DCD 41EE 41EE 460F 4A32 4A53 4E53 4A53"
	$"5275 5296 4E75 4E75 4E54 4A54 4E54 4613"
	$"4612 5EF9 6B5C 3DF1 14A7 1CE9 1CE9 4E75"
	$"5EF9 14A7 1086 35AF 026B 2D20 C620 E624"
	$"E729 0729 2829 0724 E629 0735 6A35 8B2D"
	$"2824 E62D 2835 8B35 8B35 6A35 6A35 8A35"
	$"8A2D 4829 072D 2829 072D 2831 4935 8A39"
	$"AB3D AC3D AB3D AC39 8B39 8B35 6A35 6A31"
	$"4931 6A35 8B35 6A20 C524 E629 0829 0829"
	$"282D 2829 282D 28FE 3149 0735 6A35 6A31"
	$"4929 0729 2829 282D 492D 28FE 2D49 1E31"
	$"4931 6939 8B35 6A31 6935 6A31 4829 0735"
	$"8A35 6A31 6935 6A31 4931 4939 AB41 CC31"
	$"692D 4931 692D 4931 4931 4931 6939 8B39"
	$"8B35 8A31 6931 492D 482D 4831 69FD 358A"
	$"0B31 692D 482D 282D 2835 6935 8A2D 4831"
	$"692D 2831 4839 8B39 8AFE 398B 1F35 8A35"
	$"6A35 8A39 AB35 6939 AA35 6931 6939 AB35"
	$"8A39 8A3D CC3D CC3D AB39 AB3D AB39 AB35"
	$"8935 6935 6A39 8B31 692D 4824 E624 E629"
	$"0725 0725 0729 2835 6A35 6A39 8BFC 3DAB"
	$"4839 AA39 8A31 6935 6A39 8B39 8B31 6A35"
	$"8A39 AB39 AB3D AB39 AB39 AB3D 8B39 8A39"
	$"8A3D AB39 8A35 8A2D 4824 E629 0731 4935"
	$"6935 6939 8A39 8A35 6935 6939 8A39 8A35"
	$"6935 6A35 6A31 4935 6A3D CC39 AB39 8A35"
	$"8A31 6931 6941 CB3D AB39 8A3D AB39 8A39"
	$"8B31 6920 E529 2731 6931 6931 4924 E624"
	$"E620 C525 072D 482D 4831 4939 8A39 8A39"
	$"8B39 8A35 6A31 492D 282D 4831 4931 6A2D"
	$"4925 06FD 2507 4820 E620 E625 0720 E61C"
	$"E61C E620 E625 282D 2831 4835 6935 8A39"
	$"8A41 CC35 8A31 4929 2829 2729 2731 493D"
	$"AC39 AB31 4831 6935 6935 6931 482D 2720"
	$"C424 C520 C420 A420 A41C A420 C51C A51C"
	$"A41C A41C A520 E631 4931 4935 6A35 8A35"
	$"8A35 6A35 6A39 6A35 8A31 6935 893D AB31"
	$"6829 2620 E520 E529 2731 8A2D 492D 492D"
	$"6A31 8C35 AC35 8C39 CF3D F042 1046 524A"
	$"534A 734E 744E 744A 53FE 4E74 134E 544A"
	$"5446 3242 1242 1246 3346 333D D13D F167"
	$"3B67 1A25 2B18 C821 0A1C E96B 5C4A 540C"
	$"6514 A72D 6D02 5BFE 2D49 FE31 4913 2D28"
	$"3149 358B 3149 2907 2D28 398B 3DCC 3DAC"
	$"398B 358A 316A 2907 24E6 2907 2D28 2D28"
	$"2D49 358B 3DAC FE39 AB01 358A 3149 FE2D"
	$"2808 3149 398B 3DAC 398B 2507 2507 3149"
	$"3149 2928 FC2D 2801 2928 2D28 FE2D 4919"
	$"316A 356A 316A 3169 358A 356A 398A 358A"
	$"358A 3DAB 39AB 356A 39AB 356A 3149 398B"
	$"358A 358A 3149 3169 356A 398B 39AA 39AB"
	$"358A 356A FD39 AB24 398A 3569 3569 398A"
	$"398A 398B 3DAB 398B 398A 398B 398B 3569"
	$"3149 2D49 316A 2D49 356A 358A 2D48 2D48"
	$"398B 398A 3569 3148 358A 3569 356A 39AB"
	$"358A 358A 3589 3569 3DCB 39AB 398A 39AB"
	$"39AB FE3D AB0A 3DCC 3DAB 3DAB 398A 358A"
	$"3169 358A 356A 2907 2507 24E6 FE25 070C"
	$"2928 2D48 356A 3DCC 45CD 398A 3969 3989"
	$"3589 398A 39AA 39AB 398A FD3D AB2D 41AC"
	$"3DAB 3DAB 3D8A 3D8B 3D8B 398B 396A 398B"
	$"39AB 3569 2907 2907 1CC5 20C5 2506 2927"
	$"3169 3569 356A 3569 3169 3DAB 3569 2506"
	$"398A 3DAB 398B 3DAB 3DAB 39AA 3DAB 398A"
	$"398A 41CC 41CB 3DCB 39AA 3169 3589 3DCC"
	$"2D48 20E6 2506 2507 2507 FE20 E609 2507"
	$"3149 358A 398B 398B 3169 3149 2D48 2D48"
	$"3149 FE2D 4812 3169 316A 2D49 2928 2507"
	$"2527 2527 2507 2106 2507 2928 2507 20E6"
	$"20E6 2507 2928 2D49 356A 398B FE3D AB35"
	$"2D48 2927 24E6 2928 3149 358A 39AB 356A"
	$"3569 358A 3169 2D27 3169 3148 24E5 20C4"
	$"24C5 20C5 1CA4 1CA4 1CA5 1CA5 1CA4 1CA4"
	$"18A4 1CA5 2506 2D49 3169 39AC 39CD 316A"
	$"398C 39AC 316A 39AB 3DCC 39AB 35AB 2D69"
	$"2527 2528 39CE 3DEE 3DEF 4631 4A52 4A53"
	$"4A53 4A54 4A54 4E54 4A33 4A54 FE46 3318"
	$"4612 4633 4A33 4A53 4A53 4632 4212 3DF1"
	$"3DF0 4212 4613 3DF1 39D0 4A33 739E 4A54"
	$"18A7 1CE9 1CE9 2D6D 739E 318E 1086 1CC8"
	$"210A 024B FE2D 4911 3149 2D28 2D28 2D48"
	$"356A 398B 356A 398B 3DAC 39AB 356A 3149"
	$"2D28 2908 24E6 2507 2D49 2D49 FE31 4917"
	$"3569 3569 398A 39AB 2D28 2907 20E6 20E6"
	$"20C5 24E6 316A 3DCD 3DAC 3149 2908 2D49"
	$"398B 398B 3149 3149 2D29 2D28 314A 398B"
	$"FE35 8B22 316A 356B 356A 398B 356A 398A"
	$"3DAC 3DAB 3DAC 3DAB 39AB 3DAB 3569 3569"
	$"398A 398B 356A 356A 398B 3148 3148 398A"
	$"356A 398A 3DAB 3DCC 3DAB 3569 3DAB 398B"
	$"398A 398A 3148 3148 356A FE39 8A11 39AB"
	$"39AB 356A 358A 356A 2D27 20E5 2928 356A"
	$"3149 3149 398B 316A 356A 398B 2D27 2D27"
	$"3148 F939 8A00 41CC FC3D AB03 39AB 398A"
	$"39AB 398A FD35 8A17 398B 39AB 358A 2D49"
	$"2D48 358A 316A 358A 398A 358A 398B 41CC"
	$"3DAB 3569 3989 3569 3168 358A 398B 356A"
	$"398A 41CB 3989 3569 FC31 4837 3569 3569"
	$"356A 356A 3569 2D48 2906 1CC4 2506 2507"
	$"20E6 24E6 2D28 358A 398B 39AB 3DAB 398B"
	$"41CD 2D27 20E5 3148 3569 3569 356A 398A"
	$"358A 358A 398A 398A 3DCB 3DAB 3DAA 3989"
	$"3168 3DAB 41ED 358A 2D48 2928 2507 2507"
	$"20E6 2927 3169 358A 398B 356A 3549 2D07"
	$"24E6 2D27 2D48 356A 398B 358A FC39 AB01"
	$"356A 2D49 FE31 691C 316A 316A 356A 2D28"
	$"2D48 2D48 316A 2D49 3149 3569 3569 3169"
	$"2D27 2D27 2907 2906 358A 358B 358A 356A"
	$"3569 398A 39AA 398A 3149 2507 2D48 2D28"
	$"2907 FE20 C5FC 1CA4 3A1C A518 A418 841C"
	$"8424 E61C A531 6A41 EF41 EF5A D64E 5331"
	$"6C41 F035 AD35 AD42 1042 1052 945E F852"
	$"9631 8E3D F14E 754A 3346 3346 3342 1242"
	$"1242 1142 1142 1242 1242 3242 1242 124A"
	$"544A 3346 1242 123D F13D F03D F03D F142"
	$"123D F135 AF3D F15E F967 1A25 2B14 A725"
	$"2B18 C842 126F 7D18 C818 A81C E91C E902"
	$"5906 24E7 2908 2D29 2908 2507 2507 356A"
	$"FE39 8B0C 3DAB 3DAC 3569 2927 2928 2927"
	$"2928 2908 314A 358B 3169 3149 2D48 FE31"
	$"4929 3DAC 398A 2927 2D28 2D49 2D49 2908"
	$"314A 39AC 356A 2D29 24E7 2D28 356A 41CD"
	$"398B 3149 356A 398B 356A 356A 316A 2D49"
	$"2D28 2907 2507 24E6 20E6 24E6 2507 2D08"
	$"3149 356A 398B 39AC 398B 358B 3149 2D28"
	$"3128 3569 3149 FE35 6924 398A 3549 396A"
	$"41AC 3DAB 41AC 398A 2D48 2D48 2D28 2D28"
	$"2907 2907 2D28 2D48 3149 358B 356A 398B"
	$"398A 398A 398B 398B 316A 2907 24E7 2D28"
	$"356A 3569 3DAB 358A 358A 3169 3149 398B"
	$"3DAB 3DAB FD39 8A0C 3D8B 396A 396A 3569"
	$"3549 398A 396A 356A 354A 3149 2D27 3148"
	$"356A FE39 ABFE 3DAB 0535 6929 2731 4939"
	$"AB31 6931 6AFE 356A 1335 8A39 8A39 8A3D"
	$"AB3D AB3D AC3D 8B3D AB39 8A39 8A3D AB39"
	$"8A31 6929 2729 0731 492D 482D 282D 482D"
	$"48FE 3149 0831 6A29 2820 C525 072D 4925"
	$"0731 4939 8B3D ABFE 41CC 153D AB35 8B29"
	$"2729 072D 2835 6935 6935 6A39 8A39 8B39"
	$"8A39 8A39 AB39 AB39 8A39 AB3D AB3D AB3D"
	$"CB41 CC39 AB35 8AFE 2D48 1429 0835 6B39"
	$"8B3D CB3D CB25 061C C524 E625 0729 2831"
	$"6A3D AB3D CB3D AB41 CB3D AB39 8B35 6A35"
	$"6931 6931 69FE 356A 0335 8A39 AB31 6929"
	$"07FE 2D28 0929 0729 282D 282D 2929 2825"
	$"0725 0720 E631 4939 8BFE 356A 0C31 6939"
	$"8A35 8931 4831 4931 492D 282D 282D 4828"
	$"E620 C524 C524 C4FE 20A4 FD1C A417 1863"
	$"1883 0C42 18A5 4A32 4A53 5ED8 4A32 39AF"
	$"4212 210A 39CF 5696 4E54 5AB7 62D8 39AF"
	$"294C 3DF1 4A54 4212 4211 3DF1 3DF1 FD42"
	$"121B 3DF1 4212 4633 4212 4633 41F1 39D0"
	$"39D0 3DF1 3DD0 3DF1 4212 3DD1 39AF 3DD0"
	$"5276 6F7D 35AF 18C8 210A 210B 14C8 5AB8"
	$"56B8 1087 1CC9 1CEA 1CE9 024C 1429 0829"
	$"0824 E725 0729 0731 4939 8B35 6A35 4939"
	$"6A39 8A39 8A35 6A31 6935 6A31 6A35 6A35"
	$"8A35 8A35 6A35 6AFE 3149 1631 6A35 6A35"
	$"8A35 8A31 692D 482D 482D 2829 2829 2829"
	$"0825 0724 E72D 2939 8C39 8B31 4929 2725"
	$"072D 2829 2829 0729 07FE 2928 FD25 0703"
	$"2907 2907 2D29 2D29 FD2D 4938 316A 3169"
	$"2D48 356A 398B 3569 3169 3169 3DCC 3569"
	$"3569 3DAB 3DAB 39AB 358A 3169 2928 2928"
	$"2927 2527 2927 2D28 3149 3149 356A 396A"
	$"356A 398A 3DAB 3DAB 358A 398A 3169 2D49"
	$"2928 3149 356A 398B 39AB 358A 398A 356A"
	$"398B 3D8B 41CC 398A 3569 358A 3169 2907"
	$"2907 24E6 2907 2507 2928 3149 356A FD2D"
	$"280A 3149 398B 3DAB 3DAB 398B 3DAB 3DAB"
	$"358A 2D27 3169 398A FE31 69FD 356A 1739"
	$"8A3D AB41 CC41 CC3D AC35 6A35 6931 482D"
	$"2839 8A3D AB35 6A2D 4835 6A35 6A2D 4831"
	$"492D 482D 4831 4831 6931 4939 AB35 8AFE"
	$"3169 3E35 693D AB41 CC41 CC41 CB3D AA39"
	$"8931 4729 2725 0725 062D 4835 6A35 8A39"
	$"AB39 AB3D AB3D AB39 AB39 AB39 8A35 8A3D"
	$"AB45 ED41 CB3D AB3D AB39 AB35 6A31 4931"
	$"6931 6935 4939 8B3D AB3D AB39 AA2D 4825"
	$"0625 2729 0731 6939 AB3D AB3D AB41 CC39"
	$"8A35 692D 482D 482D 282D 4831 4931 6931"
	$"6931 4931 4935 6A24 E624 E631 6929 2829"
	$"07FE 2507 182D 2825 0720 E620 E624 E735"
	$"8B31 4935 8A39 8B35 6A31 4935 6929 272D"
	$"4831 4931 6A31 6931 4931 4931 4828 E624"
	$"C524 C420 C420 C4FC 1CA4 1314 6314 830C"
	$"4208 4242 1142 1135 AE46 534E 7546 3329"
	$"4C31 8D4A 5442 113D F035 8E29 4C2D 6D39"
	$"D046 32FD 4212 FE3D F1FE 4212 023D F13D"
	$"F13D D1FC 39D0 0E3D F139 D039 AF35 AF46"
	$"336F 7D4A 5414 A721 0A25 2B1C E91C EA6B"
	$"5C35 AF10 86FE 1CEA 0263 1129 0720 C625"
	$"072D 2831 6935 6A35 8A35 6939 8A35 6931"
	$"6935 6A31 6931 4931 4935 6931 6931 49FE"
	$"356A 0A31 6935 6A35 6A31 6A2D 4931 4935"
	$"8A31 692D 4829 2829 07FE 2507 1529 0829"
	$"2839 AC35 8B25 0725 0625 0729 0725 072D"
	$"2831 4935 8A35 8B35 6A31 6A2D 2829 2829"
	$"282D 4929 2829 282D 29FD 2928 042D 4835"
	$"6A31 4931 4935 6AFE 39AB 023D AB41 CC39"
	$"ABFE 3DAB 1839 AB39 8A35 8A31 6A31 6A2D"
	$"4929 282D 492D 282D 4939 8B2D 2829 0735"
	$"4931 483D AB35 6931 6839 AB31 4931 6A35"
	$"8B35 8B39 8B3D ABFD 356A 0B39 8A39 8B3D"
	$"AC35 6935 8A31 692D 4829 0729 2829 282D"
	$"4931 49FE 316A 102D 282D 482D 4831 4835"
	$"8A3D AB3D 8B3D AB3D 8A3D AB35 6939 8A39"
	$"8A3D AC3D AB35 8A39 8AFE 358A 2339 8A35"
	$"6A39 8A41 CC39 8A35 6A35 6A35 6931 4929"
	$"0629 0735 6A35 6A2D 282D 2831 6931 6935"
	$"6935 6A31 4931 6931 6935 6A35 6939 AB3D"
	$"AB3D AB39 8A35 6939 8B41 CC41 CC3D AA3D"
	$"AA39 8A35 69FE 2927 0D31 6935 8A2D 4831"
	$"4835 6A39 8B39 8B39 8A39 8A35 8A39 8A39"
	$"AB41 CC45 EDFE 3DAB 0639 8A35 6A31 6931"
	$"492D 4831 4935 6AFE 398A 0539 AB35 8A35"
	$"8A35 8B39 8B39 ABFE 398A 2935 6931 692D"
	$"282D 282D 492D 4931 492D 492D 4929 272D"
	$"4835 8A25 0625 0635 6A29 0729 0729 2829"
	$"0829 0829 2829 0820 E620 E625 0729 282D"
	$"2835 8A31 692D 482D 4831 6929 0735 6A31"
	$"6A35 6A35 6A31 6935 6A39 6A35 4928 E6FE"
	$"20A4 3C1C 831C A41C A41C 8418 8414 8310"
	$"6210 6304 212D 8C3E 1029 4B46 324A 7446"
	$"3242 1141 F14A 3346 123D F131 8E35 AF31"
	$"8E39 F042 1242 3242 1241 F13D D035 AF39"
	$"D042 1242 1239 D035 AF39 D039 D039 AF35"
	$"AF35 AF31 AF31 AE39 D039 D035 AF39 D039"
	$"D067 3A5A D81C E914 A725 2C21 2B14 C831"
	$"8F67 1B18 C914 A821 0A1C EA1D 0A02 5E09"
	$"2907 2D28 398B 3569 398A 398A 3DAB 398A"
	$"3169 2D48 FD31 4903 3569 3569 356A 3169"
	$"FE35 8A2B 356A 398B 3169 24E6 2D49 358A"
	$"39AB 358A 3169 3169 3149 2D49 2928 2928"
	$"2D28 2928 2D49 2908 24E7 2D28 2D28 3149"
	$"356A 3DAC 398B 356A 3149 2D28 2928 2907"
	$"2907 2928 2928 2D28 2D49 314A 316A 2D49"
	$"3149 316A 316A 3169 3149 396A FE3D AC1C"
	$"3D8B 398A 3DAB 41AC 3DAC 3DAB 3DAB 3DCC"
	$"39AB 39AB 358A 358A 3149 2D28 3149 1CA4"
	$"24E6 316A 20C5 24E6 24E6 24C6 2906 2907"
	$"398A 398B 2D49 358B 3DAC FD39 8BFE 358B"
	$"5235 6A39 6A35 6A2D 482D 4831 4931 6A31"
	$"6A31 492D 482D 492D 492D 2831 6A31 4931"
	$"492D 272D 273D AB41 CC41 CC3D AB39 8A39"
	$"8A35 692D 273D AB3D AC41 CC3D AB39 8B39"
	$"8B39 AB39 8A35 8A31 6931 4931 4831 4931"
	$"4831 6935 6A35 8A39 8B35 6A31 4931 4831"
	$"4931 4935 6A35 8A35 8A35 6A35 6A31 4931"
	$"4935 6A39 8B39 8B35 8A35 6A39 6A31 4835"
	$"493D AB45 CD39 8A39 8A3D AB35 8A31 692D"
	$"2831 6A35 6A3D AC35 6A29 0731 482D 272D"
	$"4835 6A35 8A39 ABFD 398A 2A3D AB3D AA39"
	$"AA39 AB39 AB35 8A35 6A2D 4829 0729 2829"
	$"272D 2835 6A39 8B39 8B39 8A39 8A39 8B39"
	$"8A35 6939 8A35 8A39 AA3D AB2D 2825 0729"
	$"2729 2829 282D 4831 492D 492D 4941 CD3D"
	$"CC31 6931 6931 492D 282D 492D 2829 2829"
	$"08FC 2507 0129 2831 69FE 3149 0E2D 2829"
	$"272D 483D AC35 6935 6A35 6931 6939 8A39"
	$"8A3D AB31 2820 A420 A320 A4FE 1CA4 1A1C"
	$"8418 8318 8310 6210 6308 4218 C642 112D"
	$"6C39 CF4E 7341 F041 F141 F041 F046 3246"
	$"3242 3242 3346 3346 5346 3342 3246 3242"
	$"1241 F13D F1FE 4212 0039 D0FD 35AF 1631"
	$"AF31 AE31 8E35 AF3D F139 D035 AF39 F056"
	$"B76B 3B25 0B14 A718 C921 0B21 2C14 A846"
	$"3446 3414 871C EA21 0A1C EA1C EA02 630A"
	$"2D28 356A 398A 398A 39AB 39AB 358A 356A"
	$"3169 3149 3149 FC35 6AFE 398B 1435 8A35"
	$"6A35 6A39 AB31 4929 0739 8B3D AC3D AC2D"
	$"2829 0731 4931 4931 6A31 492D 492D 2829"
	$"2831 6A2D 4831 69FE 398B 1D39 AB31 4931"
	$"4935 6A31 4929 2825 0724 E725 0829 0825"
	$"0729 2829 282D 2831 4931 4A35 6A31 6A31"
	$"4939 8A39 8B3D AC3D 8B35 4931 4931 282D"
	$"2831 4935 6A35 49FE 356A 3831 492D 2829"
	$"2829 272D 4925 0714 8314 8314 A421 071C"
	$"E618 C518 A420 C51C C529 0739 8B31 6931"
	$"6939 8A39 8B39 8A35 6A31 6931 6A2D 4829"
	$"2729 0724 E624 E725 0720 E629 282D 4920"
	$"E620 E629 072D 4931 4A31 4931 4935 8B39"
	$"8B39 8B39 6A35 6A3D 8B3D AB3D AB3D 8A31"
	$"4831 4828 E62D 2841 CD3D AB3D ABFE 398A"
	$"0039 8BFE 356A 0A31 6931 6935 8A39 8B39"
	$"8A39 8A39 AB3D AB3D CC39 8B35 8AFE 398B"
	$"3531 4929 0724 E62D 282D 282D 4839 8B35"
	$"6A2D 282D 2831 4835 6A35 6A39 8B3D AB39"
	$"8A3D AB41 CC31 4825 0625 062D 2831 6931"
	$"4931 6935 6A31 6A2D 4824 E624 E62D 2831"
	$"4935 8A35 6939 8A35 8A3D AB3D AB35 6935"
	$"693D AB39 AB35 6931 692D 492D 4829 2825"
	$"0725 072D 4935 6A35 6935 6931 48FE 398A"
	$"2E39 AB39 AB3D CC35 8A24 E625 0720 E620"
	$"E62D 2831 4931 6935 6A3D CC41 CC3D CB35"
	$"8A35 6931 692D 4829 2825 0620 C625 0729"
	$"0829 282D 4931 6A35 8B39 8B3D 8C39 6B3D"
	$"AC35 8A2D 2729 2731 693D AC35 6931 4935"
	$"4935 4935 6931 4931 492D 282D 0724 C6FE"
	$"20A4 231C A418 8318 8314 8314 6214 6310"
	$"620C 6239 CE2D 6B31 8D4A 323D CF35 8D25"
	$"0925 0929 2A2D 4B31 6D35 8E39 AF39 AF35"
	$"8E35 AE39 AF35 AF39 AF3D D13D D13D F142"
	$"1242 113D F13D F139 F139 F1FE 39D0 FD3D"
	$"F10F 4A33 6F5C 35AF 1066 1CE9 1CE9 1D0A"
	$"212B 18C9 4633 2D6D 18C8 210A 1CE9 1CEA"
	$"1CE9 0267 1D35 6A35 8B39 8B3D AC39 AB39"
	$"8A35 6A39 8A35 8A35 6A35 6A35 8A35 6A39"
	$"8A39 8A39 8B3D AB3D AB39 8A39 8A31 4835"
	$"693D AC3D AB35 6A35 8A35 8A35 8B29 0725"
	$"07FE 2928 232D 292D 292D 282D 2831 4931"
	$"4939 AC3D AC39 8B39 8B31 6918 A42D 4939"
	$"AB35 6A2D 292D 2929 2829 2829 0829 2829"
	$"0829 0829 0729 282D 2831 4931 4935 6A3D"
	$"AC39 8B31 492D 4829 2829 2729 07FE 2D28"
	$"1C2D 4831 4929 2731 6A2D 4825 0729 272D"
	$"4929 4825 0710 8218 C418 C521 0721 070C"
	$"6218 A424 E625 0629 2831 6A2D 482D 4835"
	$"692D 482D 4825 0729 2729 27FD 2507 0C25"
	$"282D 4929 282D 4925 2720 E62D 6A3D AC3D"
	$"CC39 AB39 8B31 6935 6AFE 398B 1329 0720"
	$"E535 6A35 6A31 6929 272D 4935 693D 8B39"
	$"8B31 4831 4931 6935 6935 6939 8B35 8A39"
	$"8B3D AB3D ACFE 3DAB 0F39 AB39 AB3D AB39"
	$"AB39 8A39 AB39 AB3D AB29 2824 E71C C518"
	$"A51C C620 E620 C625 07FE 2D28 2A2D 4835"
	$"6A39 6A35 6A39 8A39 8A39 AB3D AB35 6A29"
	$"2725 072D 4831 6A35 6A35 6A35 8A35 8A29"
	$"2825 0725 2729 2831 4935 6935 6A39 AB3D"
	$"AB31 6935 6935 6935 4931 4935 8A35 8A35"
	$"6931 692D 4931 492D 4931 492D 482D 4931"
	$"4931 49FE 398A 3035 6939 8A3D CC39 AB2D"
	$"4825 0625 0625 0825 0725 0731 6A31 6935"
	$"6A3D AC3D AB41 CC3D CB31 482D 4831 6931"
	$"6929 4825 0620 E631 4939 AB35 8B39 AB3D"
	$"AB39 AB35 6931 4931 4831 482D 4825 0729"
	$"283D AC35 6B2D 2731 4835 6A35 692D 482D"
	$"2731 4829 062D 2835 6AFE 20A4 121C A318"
	$"8318 8314 6214 6314 8310 620C 412D 6A29"
	$"4A2D 4B3D D035 8E18 A614 8514 A518 A618"
	$"A61C C7FE 1CC8 0D1C E820 E91C E91C E920"
	$"E91C E921 0A25 2B25 4C2D 6D31 8E35 AF39"
	$"B039 D0FE 3DF1 0E42 1242 1246 3242 1262"
	$"F952 7510 6518 C821 0A1C E91C E91D 0A1C"
	$"E931 8F21 0AFD 1CE9 001C C902 6318 358B"
	$"398B 356A 358A 3569 356A 39AB 3DAC 3DAC"
	$"398B 356A 358A 398A 398B 3DAC 41CC 3DCC"
	$"3DAB 39AB 398A 3569 398A 3DAB 398A 358A"
	$"FE35 6A16 3149 3149 2D49 2D48 2928 2D28"
	$"2928 2928 2D28 2D49 356A 356A 358B 356A"
	$"356A 3149 2D28 356A 356A 3149 2D49 356A"
	$"356A FE2D 4932 2928 2D49 2D28 2D28 356A"
	$"358A 356A 356A 398B 3569 2928 2928 2D48"
	$"2D49 3149 2D49 2D49 3169 3169 358A 358B"
	$"39AC 3169 3169 316A 358B 318A 316A 2507"
	$"2507 316A 2D6A 18C4 1062 18A4 24E7 316A"
	$"2D28 356A 3149 3149 2D48 2927 2D49 2928"
	$"358A 358B 2D49 2928 2D28 2D48 FD31 490D"
	$"356A 3DAB 41CD 39AB 2D48 2D28 2907 2D28"
	$"3149 2D28 2D49 358B 2D48 2506 FE35 8A0E"
	$"316A 316A 2D28 2927 20E6 2506 2D27 2D28"
	$"3148 3149 356A 358A 3DAC 398B 398A FE3D"
	$"AB47 398A 3569 3169 3148 358A 398A 39AB"
	$"3169 1CC5 1CC6 1CC6 1CE6 1CC6 1CE6 20E6"
	$"18A5 1CC5 24E6 2907 2D28 3149 2D28 3149"
	$"398B 41ED 3DAB 398A 3169 3169 358A 39AB"
	$"39AB 398A 356A 3149 2506 2927 318A 358A"
	$"39AB 398B 358A 398A 41CC 3589 2D27 3149"
	$"3169 3149 3148 2D48 3149 398A 356A 3569"
	$"3569 3169 356A 358A 356A 3169 3149 356A"
	$"356A 3149 3148 3149 316A 2D49 2507 2507"
	$"2527 FE29 083A 2928 2D49 3DAC 3DAC 41CC"
	$"41CC 398A 3569 3569 2D48 2D28 2506 2506"
	$"2D28 356A 358B 356A 358A 398A 3589 3569"
	$"3169 2906 24E6 2507 2506 356A 398B 3148"
	$"3569 3569 358A 358A 3569 3169 3148 2906"
	$"28E7 3D8C 2D07 20A3 1CA3 1C83 1883 1462"
	$"1062 1462 1462 1062 0821 18C5 2529 2529"
	$"2D6C 18A6 1085 14A5 1084 1085 FC14 A601"
	$"18C7 18C7 FE14 A714 14A8 14C8 18E9 14CA"
	$"18EA 1CEA 1CEA 210A 210A 252B 252B 294C"
	$"2D6D 3DD0 41F2 4E75 5AB7 20E9 14A7 20E9"
	$"1CE9 FE18 E901 1CE9 210A FC1C E900 1CC9"
	$"0255 0F35 6A31 4931 4835 6935 6935 8A3D"
	$"AC3D AC35 6A2D 2829 072D 2831 4935 6A39"
	$"6A39 8BFD 358A 0339 8B39 8A39 8A35 69FA"
	$"356A 0A31 492D 492D 2829 082D 282D 2831"
	$"4931 4931 6A35 6A35 6AFD 398B 0135 8B35"
	$"6AFE 358B 1031 6A31 492D 492D 492D 4829"
	$"0724 E631 4939 8B31 6935 6A35 8A2D 2829"
	$"2831 4931 4931 69FE 356A 4039 8B39 8B39"
	$"AB31 6925 062D 4839 8B39 8B35 8A35 6A31"
	$"6929 2831 6A39 AB35 8A2D 4929 2825 0735"
	$"6B35 8B2D 2835 6A31 6935 6A31 4935 6939"
	$"8B31 493D AC35 8A29 2829 0729 2831 4931"
	$"6931 4935 6A35 6A39 8A39 8A31 692D 2829"
	$"0729 0729 2835 6A31 6A29 2831 493D CC3D"
	$"AB35 8A39 8A39 AA35 8A29 0624 E624 E625"
	$"0729 072D 282D 2831 4931 4935 6AFE 398B"
	$"0F39 8A2D 2739 8A41 AC41 CC3D AB35 8A35"
	$"6935 6935 8A3D AB39 8A31 6929 2825 0725"
	$"07FD 20E6 5A1C C51C A420 C524 E629 0729"
	$"272D 2835 6A41 CC45 CD3D AB3D AB35 6935"
	$"6A39 8B3D AC39 8B35 8A31 4925 0625 0639"
	$"AB3D AC39 AB39 AB31 6931 4835 8A39 8A35"
	$"6931 482D 2831 6A2D 492D 2829 072D 483D"
	$"AB39 8A39 AB3D AB39 8A31 6835 6935 6A31"
	$"4929 2729 282D 4931 4935 6A35 6A2D 492D"
	$"4829 2825 0725 0720 E625 0729 0729 0735"
	$"6A41 CC41 AC3D AB3D AB35 8A35 6931 692D"
	$"482D 4829 2725 0629 072D 4935 6A35 6A39"
	$"8A39 8B39 AB3D AB35 8A2D 2820 E625 0631"
	$"6A39 8B29 2739 8A3D 8A39 69FE 398A 0535"
	$"6931 482D 2724 C645 CD3D 8BFE 1C83 0F18"
	$"8314 6210 6210 6210 6110 6208 2008 4221"
	$"081C E718 C714 A614 A610 8510 8414 A5FE"
	$"14A6 FE10 8518 10A6 1086 0C85 1086 1086"
	$"10A8 18EA 10C9 14EA 18EA 1D0B 1CEA 18C8"
	$"18C7 1CC8 1CE8 1CC8 2109 252B 318E 292B"
	$"18C7 20E9 1CE8 1CC8 FE18 C803 1CE9 1CC8"
	$"1CE8 2109 FD1C E902 742A 3DAC 398B 398B"
	$"398A 398A 356A 356A 3149 2928 2507 24E7"
	$"2507 2507 2907 2D28 2928 3128 3149 356A"
	$"398B 358A 356A 358A 356A 356A 314A 3149"
	$"316A 3149 3149 356A 356A 356B 316A 2D29"
	$"2D29 3149 2D28 2907 2D28 2D29 312A 314A"
	$"FE31 4901 358A 358A FE39 8B28 356A 2D49"
	$"2929 2D4A 20E7 20C6 1463 2928 2D28 2507"
	$"356A 358A 3149 358B 316A 3149 316A 398B"
	$"356A 356A 398A 3149 2D28 1CC5 1CC4 3149"
	$"356A 356A 2D28 356A 3149 3149 316A 314A"
	$"3149 314A 2908 2507 358B 3149 2927 FE31"
	$"6A7F 2D49 314A 2D29 2D49 3DAC 358B 2D49"
	$"2928 2928 2D28 3149 2D28 2D28 3169 3169"
	$"2D49 3149 316A 3149 3149 316A 356A 398A"
	$"398A 3569 3569 358A 398A 356A 3169 3169"
	$"20E5 20E5 20E6 2507 2928 2D49 2D49 2D48"
	$"356A 39AB 41CC 39AB 398A 398A 3148 3DAB"
	$"3DAB 3DAC 398B 316A 3149 3149 2D28 3169"
	$"3569 356A 356A 3169 2D28 2907 2507 20E7"
	$"20E6 1CC6 1CA5 1CC5 1CC5 2907 316A 356A"
	$"3DAB 3DAC 398B 398A 398A 356A 398A 39AB"
	$"398B 39AB 39AB 356A 2D28 39AB 41ED 356A"
	$"356A 358A 3149 3149 398B 3DAC 398B 2927"
	$"2D48 2D49 2928 2507 20E6 2D28 398B 3DAB"
	$"3DAB 41CC 398A 3149 398A 398B 316A 2506"
	$"2D48 2D69 3149 356A 356A 3169 356A 3169"
	$"358A 2D69 3149 316A 3149 3149 356A 3569"
	$"398B 3635 8A35 6A35 6A31 6931 4931 6935"
	$"6A35 8A31 6931 4935 6A35 8B39 8B39 8B39"
	$"AB3D AB39 8B35 6A31 492D 4831 6939 AB31"
	$"692D 483D AB39 8A39 8B3D 8B39 8A39 8A31"
	$"4835 6931 4824 C449 CD45 AC20 8318 8218"
	$"6218 8214 6210 6210 410C 410C 4108 2004"
	$"2018 A518 C614 A618 C614 A608 4310 8410"
	$"84FC 1085 150C 640C 850C 850C 650C 6508"
	$"4518 EA0C 8700 0404 6614 CA21 2D25 4D18"
	$"C814 8614 A718 A718 C818 C718 C718 C818"
	$"C8FE 1CE9 0B18 C818 C81C E918 E81C C918"
	$"C81C E81C E91C E91C E81C E818 C802 6315"
	$"41AC 41CC 3DAB 398A 3569 3569 3149 2D28"
	$"2927 2927 2507 2907 2507 2928 2D49 2D28"
	$"3148 3569 398A 398B 398B 358A FD35 6A0D"
	$"3169 2D49 2D28 2D28 2D49 356A 3DAB 3569"
	$"2506 2907 2928 2508 2508 2929 FE29 2802"
	$"2507 2506 2D28 FE35 8A3C 398B 356A 358A"
	$"2D49 2928 3169 2948 2528 2507 2D49 20E6"
	$"1CC5 2928 2D28 356A 3149 2D28 316A 3149"
	$"3149 2D28 2928 2D49 2D28 2D28 2907 2D49"
	$"2D49 2928 2D28 2D49 2D49 2D28 2D48 2D49"
	$"2928 2908 2928 2908 2507 2D49 2928 2907"
	$"2D49 3149 316A 2D49 2D28 2507 2927 3149"
	$"3149 3169 3149 3149 2D28 2D49 2D28 3569"
	$"3DAC 358A FE2D 4914 2928 2907 2D28 2D28"
	$"3149 3149 2927 358A 398A 398A 358A 3169"
	$"3149 2506 2506 2507 2507 2D49 398B 358A"
	$"358A FE39 AB0E 358A 358A 398A 3DAB 39AA"
	$"398A 3149 2D48 2D49 3149 3148 2D28 3169"
	$"3569 3569 FE35 8A49 316A 2D49 2528 2528"
	$"2507 2908 2907 2928 316A 356A 3149 3169"
	$"3149 3569 3169 3149 356A 398A 358A 398A"
	$"39AB 39AB 358A 356A 3DAC 398B 2907 2D28"
	$"356A 3569 398A 3DAB 41CC 356A 3169 3569"
	$"2D28 2D28 2927 2927 3169 39AB 3DCC 3DAB"
	$"398A 356A 3569 398A 356A 3149 2928 2D49"
	$"2D48 3169 358A 356A 356A 398B 3169 3569"
	$"3169 3169 3149 3149 2D48 2927 356A 41CD"
	$"3169 2907 356A 3569 3169 3169 FE35 8A0D"
	$"398B 356A 2D49 3149 3169 3149 2D28 3148"
	$"3149 2D48 3148 3169 3589 358A FC39 8A0C"
	$"3569 398A 398A 3D8A 3127 20A3 396A 41AB"
	$"24C4 1861 1461 1462 1061 FE0C 4125 0820"
	$"0420 0420 0841 1084 14A5 18C6 1084 0421"
	$"0421 0842 0843 0C63 0C64 0C63 0C64 0863"
	$"0843 0863 0443 0422 0C65 1CEA 0003 0002"
	$"0466 10C9 0C67 252D 1CC9 14A7 1085 1086"
	$"14A6 14A6 14A7 18A7 18A7 FC18 C809 1CE8"
	$"18C8 18C7 18A7 14A7 18C7 14A6 1486 1485"
	$"1085 0256 1739 8B39 8B35 6A35 6931 6931"
	$"6935 6A35 6A39 AC35 8A2D 492D 492D 4831"
	$"4931 6931 6A39 8A39 8B3D AC3D CC39 AC35"
	$"6A31 6A35 8BFE 356A 3835 6931 4831 2835"
	$"6A3D AB35 AB29 2720 E620 E624 E625 082D"
	$"492D 4929 4829 4829 2825 0731 6A35 8C39"
	$"8C35 8B35 8A31 6929 072D 4831 6935 8A39"
	$"8B35 6A31 6931 6A2D 4929 2824 E620 C620"
	$"C624 E620 C524 E62D 2829 0729 2829 282D"
	$"2831 6931 4935 6A2D 4929 2829 2729 272D"
	$"282D 492D 282D 482D 492D 28F9 2928 012D"
	$"282D 28FD 316A 1129 072D 2835 8B39 8B39"
	$"8A35 6935 6A3D AC3D CC45 ED35 8A2D 482D"
	$"492D 2825 0720 E624 E62D 28FE 3149 1A35"
	$"6941 CC41 CC3D AB35 8A2D 4831 4831 4935"
	$"6A35 6935 8A3D AB3D AB39 AB3D AB35 6935"
	$"6935 6A35 8A39 8A39 AA39 8A31 6831 692D"
	$"272D 282D 28FE 3149 0135 6935 69FE 356A"
	$"2535 8A39 AB35 8A2D 4931 6935 8B35 8B31"
	$"4925 0725 0624 E624 E629 072D 2835 6A31"
	$"492D 4831 4935 6A35 8A39 8B39 8B39 8A35"
	$"6935 6A39 8B39 8B31 6935 6A35 8B35 6939"
	$"8A3D AB39 8B35 6935 8A35 692D 48FE 358A"
	$"0139 AB41 CCFE 3569 2735 8A35 8A39 AB39"
	$"8B31 692D 4835 6A31 6A31 6A31 6931 6935"
	$"8A35 8A2D 282D 282D 272D 4831 4935 8A2D"
	$"2829 273D AC39 AB24 E629 2735 8A35 6A39"
	$"8A35 8A35 6A39 8B39 8A35 692D 2831 4929"
	$"2725 0729 0729 2731 69FE 3569 2435 8A39"
	$"AB39 AB39 AA3D AA39 AA39 AA39 8939 8A39"
	$"8939 6939 8A31 4829 0631 283D AB29 0618"
	$"8314 8214 820C 410C 400C 4108 2008 2008"
	$"2108 4208 420C 6210 8410 840C 4204 2100"
	$"0000 0004 2104 22FC 0421 0F04 2200 2100"
	$"211C E908 6500 0208 6619 0C08 6604 461C"
	$"EB1C C818 A714 8610 6410 64FE 0C64 0710"
	$"8514 8614 A614 A610 8610 8510 A614 A6FE"
	$"1085 010C 6408 43FE 0C43 026F 0135 8B31"
	$"6AFE 2D49 4B2D 6946 0F5E D55E F746 3041"
	$"EE41 EF3D CD39 8B35 8A3D AC41 EE4A 3052"
	$"7256 B452 733D CE42 0F4E 5246 303D CD35"
	$"8B35 8B39 AC3D CD4A 505A B44A 7339 CF2D"
	$"6A20 E720 E625 0731 692D 4829 4925 0829"
	$"4941 EF56 944E 5346 1139 CE39 AD35 8C2D"
	$"4931 6A35 8B39 8B35 6A31 4931 6935 8A31"
	$"6A31 6A2D 4925 2825 0825 2829 0829 282D"
	$"4929 2831 4935 6935 6931 4931 4931 692D"
	$"492D 2829 2829 282D 482D 4931 49FD 2D49"
	$"0631 6A2D 4929 282D 4929 2829 282D 28FD"
	$"3149 2135 6A35 8B29 0731 694A 3052 7246"
	$"0F41 ED3D AC35 8A39 8B39 8A35 692D 2731"
	$"4935 8B31 6A31 6A35 8A39 8B39 8B39 8A39"
	$"8A39 AB41 CC39 8A31 4824 E524 E52D 483D"
	$"AC41 CD35 6935 69FE 398A 3435 692D 2731"
	$"2831 482D 4831 4839 AA3D AB31 4831 482D"
	$"2731 4931 492D 4831 4931 4931 482D 2831"
	$"4931 6931 4831 4931 4831 482D 273D AB3D"
	$"AB31 6A29 2820 E620 C51C C51C C529 072D"
	$"2831 482D 2731 4931 493D AB35 6A35 6939"
	$"8A39 8B31 4931 6939 8B3D AB31 492D 2731"
	$"693D AB39 8BFE 356A 0235 8A35 6A35 6AFE"
	$"3569 3939 8A35 6931 4831 6931 6939 AB46"
	$"0E35 8A35 8A35 6A35 6A35 8B39 8B31 6A31"
	$"4935 8A31 4935 6A31 492D 2825 0629 0735"
	$"6A3D AC31 4931 4931 6925 0625 0639 AB3D"
	$"CC39 AB39 AB39 8A39 8A35 6A31 4931 4831"
	$"4835 692D 4825 0729 2831 6A35 8B39 8A39"
	$"8A39 AB39 AB3D CB3D AB39 AA3D AB41 AC3D"
	$"AB39 6931 482D 27FE 2927 3F2D 2831 4935"
	$"6A2D 282D 2829 2725 071C C51C C518 A40C"
	$"420C 6210 8410 8310 830C 630C 620C 4208"
	$"4104 2104 2100 0100 0104 2100 2104 2100"
	$"0104 0100 0104 2200 2108 6414 A800 0304"
	$"6514 EA08 8700 2410 8714 8710 6510 6510"
	$"640C 6308 4204 2104 0108 430C 4308 430C"
	$"640C 6408 430C 640C 850C 8510 8510 8510"
	$"860C 650C 8510 850C 850C 8502 5E38 4632"
	$"3DCF 41EF 4631 4631 56B5 631A 5EF9 5296"
	$"4612 4E54 5696 5696 4E74 4E74 5695 5AD7"
	$"5EF9 671A 631A 5697 4A33 5ED8 671A 671A"
	$"56B7 4A53 56B6 5EF8 56B6 5AD7 5696 4A34"
	$"41F2 3DD0 3DCF 292A 2929 358B 316A 39AE"
	$"41F0 5275 5ED8 5275 4211 41F1 3DF0 41D0"
	$"41F1 41EF 358C 316A 358B 39AC 3DCE 4631"
	$"FD4A 521F 4631 4A52 4211 316C 2D4A 316A"
	$"316A 356A 316A 2D49 2D49 316A 316A 2D69"
	$"316A 35AC 39AC 358B 356A 398B 358B 39AC"
	$"39AC 39AB 398B 358A 358A 356B 316A 3149"
	$"358A 358A FE2D 2810 3149 2D49 20E7 41F0"
	$"5AD7 5AD7 5AB6 5274 356C 20E7 1CC6 20C6"
	$"24E7 24E6 2907 3149 3149 FD39 8B19 39AB"
	$"3DCC 3DAB 2D29 1CC5 20E6 1CC5 3149 398A"
	$"39AB 398A 3549 3149 3149 3569 3569 3549"
	$"2D27 3148 2907 2D28 3DAB 3DAB 3569 3169"
	$"2D48 FD31 6936 3149 3148 3149 2D48 3149"
	$"3149 2D28 2D48 3148 3169 398A 39AA 358A"
	$"2D29 2508 24E7 20E6 18A5 1884 20E7 2908"
	$"24E6 3149 398B 398A 398A 2906 3149 398B"
	$"39AB 3569 3169 3149 3569 3149 2927 3149"
	$"41CC 398B 3569 356A 356A 398B 356A 356A"
	$"3569 356A 356A 398B 3169 356A 316A 356A"
	$"41CD 41ED FE31 4921 3169 3149 3569 356A"
	$"356A 398B 358A 3DAC 398A 3569 2D48 2906"
	$"3DAB 3149 39AB 356A 3169 2928 316A 398B"
	$"398B 358A 358A 398A 39AB 398A 358A 3148"
	$"3169 398B 358A 2907 2D28 398A FD3D AB0D"
	$"3DCB 39AA 3DAB 39AA 3DAB 3DAB 2D27 24E6"
	$"20E5 24E6 20E6 20E6 2107 24E6 FE29 0707"
	$"2D28 3149 3149 2D28 2907 2928 1CC5 18A4"
	$"FD10 8300 1063 FE0C 6208 0843 0442 0422"
	$"0001 0403 0423 0424 0844 0424 FE04 4415"
	$"0003 0445 1D0C 0446 0446 0C86 1085 0C43"
	$"0C43 0C44 1064 0C43 0822 0822 0843 0C64"
	$"0C64 0843 0C64 1085 1085 0C65 FE10 8603"
	$"1487 1487 14A7 18A7 FE14 A702 6939 4E55"
	$"4A54 4A53 4A54 62F9 62F9 4633 3DF1 3DD1"
	$"4613 4E55 5AB8 5ED8 5696 4A33 4632 4A53"
	$"4A54 4A34 4A33 41F2 41F1 5ED8 6B3B 671A"
	$"5AD7 5ED8 6B5B 5AD8 4211 3DD1 39D0 39B0"
	$"358F 35AF 3DF1 4633 5AD8 5AD7 4A54 4E75"
	$"4A54 4633 3DD0 35AF 358E 39AF 3DF0 3DD0"
	$"41F1 3DF0 318D 4611 5AD6 6318 6319 673A"
	$"673A FD63 1942 673B 62F9 5295 39AD 316B"
	$"358B 39AB 316A 2D48 460F 4E73 4A52 4631"
	$"4E94 5F18 5AD7 56B5 4A52 3DCD 39AC 39AC"
	$"358B 358A 356A 356A 358A 3569 3569 398A"
	$"39AB 2D69 1CC5 1CE7 2529 31AD 4210 4E74"
	$"5AF7 52B6 6319 56B6 4612 3E11 4211 2D8D"
	$"2D8C 318C 2D8C 31AD 35AD 3DEE 4A30 420F"
	$"39AC 39AC 3DCC 398B 24E6 1062 1CC5 20E6"
	$"2D28 398B 3569 356A 3569 2D28 FE31 4846"
	$"3569 3169 2927 3148 2907 3DAB 41CC 358A"
	$"3569 398A 398A 39AB 3169 316A 3169 3169"
	$"3149 3169 3169 3149 3149 356A 356A 39AB"
	$"358A 3169 2D48 2D27 2507 2508 20E7 1CE6"
	$"18A4 1083 1CC5 2508 2D28 398B 358A 398A"
	$"3148 2506 3169 398A 3569 358A 3148 2D27"
	$"2D48 3569 2927 3149 398A 356A 358A 356A"
	$"3569 398B 356A 3169 3149 398A 398B 356A"
	$"358A 358A 356A 358A 398A 358A 3569 FD31"
	$"4920 356A 358A 39AB 3DAB 3DAC 39AB 398A"
	$"3569 3148 2927 3569 3148 398B 3149 2D48"
	$"2D48 2D28 2928 2928 2927 2D28 3149 3569"
	$"398A 3169 2907 3149 3169 2D28 20E5 2D28"
	$"398B 3DAC FE3D AB07 3DAA 398A 3DCC 358A"
	$"3149 24E6 18A3 20C5 FB20 E610 24E6 2507"
	$"2907 2907 2927 2507 1CA4 1483 20E6 2107"
	$"2507 1083 0C62 1083 1083 1062 1063 FE0C"
	$"6219 1084 0862 0842 0844 0023 0423 0423"
	$"0424 0844 0023 0002 0001 14E9 0C87 0024"
	$"1087 0C65 0C64 0842 0C64 1085 1085 10A6"
	$"1085 0C64 0C64 FE08 640D 0C85 0C85 1085"
	$"0C85 1086 1486 1086 1086 14A6 14A7 18A7"
	$"14A7 14A7 18C8 0255 4A3D D13D D241 F25E"
	$"D95E D939 AF31 8E31 AE31 8F3D D146 1356"
	$"975A D84E 7539 CF39 D046 334A 534A 544A"
	$"3446 1246 1262 F96F 5C63 1A67 1A63 1A4A"
	$"3439 B035 8F31 8F2D 6E2D 8E31 AF42 124A"
	$"555E FA63 1A46 3439 D139 B035 8F31 8E2D"
	$"6D29 4C31 8D39 D046 334A 534A 534E 754E"
	$"7463 1967 1A62 F963 1A62 FA63 1A63 1A67"
	$"1A67 3A63 1A63 1962 F967 3A5A D73D EF25"
	$"0731 8B35 8B4A 5173 9B63 3A5E F963 3AFE"
	$"631A 4167 5B5E F946 3246 5246 103D EF35"
	$"AD31 6B35 8B2D 4931 6A35 8A35 AB31 8B2D"
	$"6A39 CE56 D65F 1867 3A6B 5A67 395A D756"
	$"B65E F863 1952 9646 334E 7552 954E 744E"
	$"7456 B652 7452 956B 5956 9435 8C29 292D"
	$"4A39 AC2D 491C C520 E629 2824 E635 6A3D"
	$"AB35 6A39 8A35 6935 8A35 8A31 4831 6935"
	$"8A39 AB39 8A35 6935 6A3D AB31 492D 2835"
	$"6939 AB3D AB3D ABFE 358A 2139 8A35 8A39"
	$"8A39 AB39 AB39 8B3D AB3D AB2D 4729 062D"
	$"4829 2725 0625 072D 4A25 2825 281C C614"
	$"8318 A42D 4939 8B39 8B35 8A3D AB39 AB35"
	$"6939 8A39 8A35 6935 8A39 8A31 482D 48FE"
	$"3149 0B35 6939 8A35 8A39 8A39 8A35 8A31"
	$"6931 6935 6A35 6A2D 2829 27FD 3169 0135"
	$"6939 8AFD 356A 0539 8B39 8B39 8A3D AB39"
	$"8A3D ABFE 398A 0835 8A35 8A39 8A39 8A31"
	$"6931 492D 282D 2824 E6FE 20E6 0425 072D"
	$"2831 4935 6A2D 48FE 2928 0525 0724 E629"
	$"2839 8B39 AB39 ABFD 3DAB 0439 8A20 E520"
	$"C514 8318 84F9 20E6 2125 0729 2820 E618"
	$"A410 620C 4110 6214 A31C C520 E610 6214"
	$"8310 8310 630C 6210 830C 620C 4220 E625"
	$"0725 0735 8B25 0814 A50C 6408 430C 4408"
	$"4300 0000 0000 211D 0904 4304 23FE 0C64"
	$"110C 630C 8510 8510 A614 A714 A621 0925"
	$"2B18 C718 E814 A610 A610 8510 8510 8610"
	$"8614 A610 A6FC 14A7 0110 8614 C702 6775"
	$"35AF 4633 5AD8 5276 35B0 2D6D 318E 318E"
	$"358F 358F 39D1 41F2 5276 5AB7 5AB7 5AD8"
	$"5AD7 5EF9 631A 5ED9 5AB7 5275 671A 6F5C"
	$"673A 673B 4A54 2D4D 318F 2D4D 294D 294C"
	$"4213 5296 5697 4A55 4212 35AF 2D6D 2D6D"
	$"294C 294C 2D6D 2D8E 35AF 4633 56B7 56B8"
	$"4E74 4E74 56B7 56B7 5AD8 5AB8 5697 5697"
	$"5296 5296 56B6 5AD7 6319 5EF8 6318 5EF8"
	$"631A 6B5C 5EF8 4A53 5695 5ED7 673A 673A"
	$"6319 631A 673A 671A 671A 673A 673B 631A"
	$"5EF9 633B 633B 5F19 56D7 5296 4E74 4632"
	$"4A54 4E95 52B6 56B6 5EF7 6B5B 737C 6719"
	$"62F8 5AB5 41F0 41EF 5294 5EF7 6719 4E74"
	$"39D0 41F1 4E53 4A33 5295 5AB5 5AB6 5ED6"
	$"41F0 1CC7 20C7 1CC6 18A6 24E8 FE29 2917"
	$"2928 2928 39AB 398B 398A 3569 398A 398A"
	$"398B 398A 3DAB 3DAB 3569 3569 398A 3DAB"
	$"2927 20E5 2907 398A 3DAC 398A 3969 396A"
	$"FE39 8A18 3DAB 3DAB 398A 398A 3969 398A"
	$"3DAB 2906 2506 3149 2928 2908 2D29 358B"
	$"2D4A 316A 2928 18A5 1CA5 398C 3DAB 3DAC"
	$"41CC 41CC 3DAB FC39 8A03 398B 356A 3149"
	$"3148 FE35 6926 398A 398A 3DAB 3DAB 3569"
	$"3569 3148 3149 2908 20C5 24E6 24E6 2907"
	$"2907 2928 3149 356A 398A 398B 398A 3DAB"
	$"39AB 39AB 39AA 398A 39AB 39AA 358A 358A"
	$"398B 3DAB 41CC 3DAB 2907 2506 24E6 2506"
	$"2507 2506 FE25 0717 2928 2D48 316A 3149"
	$"2D28 3169 2D49 2D48 2D28 2507 2907 2D48"
	$"358B 39AB 39AA 3DAB 3DAB 398A 24E6 20E5"
	$"2507 1CC5 18A4 1CC5 F920 E63C 2507 20E6"
	$"1CC5 1062 0C41 0C61 1062 1483 1CC5 1062"
	$"1484 1483 1083 0C42 0C62 0C42 314A 398B"
	$"3128 418C 418B 2D07 24E6 20C6 20C6 24E8"
	$"20E7 0841 0000 0001 1084 0843 0843 0442"
	$"0864 0884 0C85 10A6 14A7 18C7 18C8 210A"
	$"4612 4632 39D0 3DF0 358E 2D4C 210A 14A6"
	$"1085 10A6 14A7 18C8 1CE8 1CE9 1CE9 18C8"
	$"18E8 1CE9 318D 026A 3F3D F163 1A56 B742"
	$"1241 F13D F13D F141 F23D F235 AF35 8F39"
	$"B046 1352 7667 1B6B 3B56 965A B767 1A5A"
	$"D852 9656 966F 5C6F 5C6B 3C56 B831 AF29"
	$"6D29 4D29 4D2D 6E31 8F42 1339 D131 AF29"
	$"6D25 2C25 4B29 4C2D 8D39 F14E 965A D956"
	$"D85A D95E F963 1A5E F95A B75E D863 1A63"
	$"1A62 F95E F95E F95A D95A B856 B75A B75A"
	$"D85E D85A D75A D863 1AFE 673B FE6B 3B05"
	$"631A 62F9 631A 62F9 631A 671A FE67 3B00"
	$"671A FD67 3B7D 6B5C 675B 673B 675B 6B3C"
	$"6F5C 6F5C 6B3A 62F8 5AB6 5695 4E53 41F1"
	$"358E 2D4B 4E54 5696 3DD0 4632 4A53 5275"
	$"5275 4A53 4E54 5295 5AB7 56B7 39D0 18C8"
	$"18C8 1CC8 1CE8 1485 1084 18A6 2D4B 314A"
	$"2D28 2D28 3569 356A 3149 3569 398A 3149"
	$"398B 398A 356A 2D28 2906 3148 398B 358B"
	$"20E6 20E6 2D28 3DAB 398A 3549 3549 356A"
	$"3569 356A 398A 398A 356A 3169 3569 3149"
	$"398A 39AB 3148 3169 398A 398B 358A 358A"
	$"358B 356A 358B 358B 2D48 2D49 39AC 3DAB"
	$"41AC 41AB 3DAA 3D8A 3DAB 396A 3569 356A"
	$"396A 398B 398A 398A 356A 356A 396A 356A"
	$"396A 3569 398A 3569 3169 356A 20C5 2507"
	$"2107 2508 2929 2507 2507 2508 2D49 3549"
	$"396A 3D8B 3DAC 3DAB 398A 3DAB 3DAB 398A"
	$"398A FC3D AB28 398A 3169 2507 1CC5 20C6"
	$"2507 2908 2507 24E7 24E7 2507 2507 2928"
	$"2D48 3149 3148 3569 358A 358A 3169 2D48"
	$"2927 2507 3149 39AB 3DAB 3D8B 3DAB 3DAB"
	$"3148 2906 2506 2107 20E6 20E6 1CE6 20E6"
	$"20E7 20E6 20E6 20E7 FC20 E63A 18A4 18C5"
	$"18C5 1CA5 1884 1CC5 20E6 18C5 1483 1083"
	$"0C42 0C42 24E7 3129 5A51 3107 2083 2CC6"
	$"3D6B 396A 3128 2D28 20C5 1CC5 20E7 18A5"
	$"1063 0422 0422 1084 14C6 0863 0864 0CA7"
	$"14EA 18EB 296E 318F 294C 318E 4212 41F2"
	$"4614 4A33 3DD0 39AF 358D 252A 212A 254C"
	$"2D6D 358E 318D 39CE 39CF 31AD 39CF 4211"
	$"4E74 025F 364E 5652 773D F142 1246 334E"
	$"755E F962 F95A D84E 7546 3239 D035 AE4E"
	$"7567 3B63 1A56 9756 975E D84A 344A 5462"
	$"F973 7D6B 5C5A F939 D029 4D29 6D25 4C25"
	$"4D29 6D29 6E29 6D2D 8E2D 8E31 AF39 F046"
	$"5352 965A D863 1A67 3A63 1A5E F95A B75A"
	$"B75E D85A B752 9656 B75E D85E F95E D85E"
	$"D95E FAFE 5EF9 0762 F963 1A62 F95E F85E"
	$"F967 3A67 3B67 3BFE 673A 0467 3B67 3A67"
	$"1A67 1A67 3AFE 673B 426B 3B6B 3B67 3B6B"
	$"3B67 1A62 F96B 5C6B 5B6B 5B6B 3B67 3A67"
	$"1967 195E D752 7546 3242 1142 1242 1131"
	$"AF2D 8D39 F04A 7431 8E2D 6C4A 5352 7556"
	$"B652 954E 744E 745A D75F 195A D842 1331"
	$"AE25 2B18 C71C E818 C71C E729 0939 8D31"
	$"4A31 4A2D 2831 4935 6A35 6935 6A31 4929"
	$"272D 482D 2829 0729 272D 4835 6A39 8B35"
	$"8A2D 482D 2831 693D AB35 6939 8A35 49FE"
	$"3149 0935 6935 6931 6935 6939 8A35 8A39"
	$"8A35 8A35 6935 8AFE 398A FE35 6A34 3169"
	$"356A 356A 3569 356A 398B 3DAB 3DAB 398A"
	$"3D8A 3DAB 3148 3148 3149 3149 356A 356A"
	$"398B 398A 358A 398A 396A 398A 398A 3DAB"
	$"3569 398A 2D48 18A4 20E6 20E6 2507 2928"
	$"2928 2507 2929 358C 356A 398B 3DAC 398A"
	$"3569 3549 3569 3569 398A 3DAB 398B 3569"
	$"358A 3169 3569 2D48 FE20 E612 2507 2508"
	$"2507 20E7 20E7 24E7 2507 2507 2928 2D28"
	$"3149 3569 398A 3569 398B 398A 3569 3169"
	$"3169 FD39 8BFE 3DAB 0239 AB2D 4825 27FA"
	$"20E6 1D29 2825 0725 0620 E625 0620 E520"
	$"E529 2820 E620 E61C C521 071C C520 E610"
	$"8210 8214 A431 493D AC3D 8A3D 8A1C 6214"
	$"2039 2856 0F35 2824 A524 C51C A418 A4FE"
	$"18A5 1F0C 6308 4218 C61D 0721 2A1D 2A21"
	$"4C25 4E25 2C31 8F2D 6D21 0A18 E921 2B25"
	$"6E29 903D D23D D142 123D CF39 AE3D EF3D"
	$"CE41 EF41 F146 324A 534A 534A 3342 123D"
	$"F13D F102 670F 3590 316F 2D4D 4212 5296"
	$"5296 5AB7 5296 5295 5AD7 5EF9 5696 3DF0"
	$"5696 5AD8 5ED8 FE56 B716 41F1 56B7 6F7D"
	$"6B3B 5697 39F1 296D 254C 254C 210B 296D"
	$"39F1 4233 4A54 4E96 56B7 5AF9 633B 6B5C"
	$"6B3B 671A 6319 56B6 FE56 9612 5ED8 5ED8"
	$"5AB7 5AD7 631A 673B 5EF9 56B7 5AB8 5AB8"
	$"5EF9 62F9 5EF9 6319 6319 62F9 6319 671A"
	$"673A FD67 3B09 6B3B 6B5B 673B 673A 673B"
	$"6B3B 6B5B 6B3B 6B5B 6B5B FE6B 3B28 62F9"
	$"62F9 737C 6B3A 6719 6719 62F8 5EB6 5ED6"
	$"5695 5295 5275 4A54 4E75 4E96 4A74 4A75"
	$"52B6 4E75 4653 5295 5AD7 5296 5AD7 4E74"
	$"4A74 56B7 6B5C 6B5C 5F19 56B7 4A53 35CF"
	$"31AD 2D6C 2D6B 39AD 3DCE 2D29 2D28 358B"
	$"FE35 6A01 3169 356A FE31 4917 2D48 2D48"
	$"3169 356A 39AB 398A 39AB 3569 3569 398A"
	$"3DAC 39AB 398B 2907 2907 20C5 2D28 358A"
	$"398A 3569 3589 398A 358A 358A FD35 6910"
	$"3169 3148 2D28 2D27 2D27 2D28 2D27 2D27"
	$"2927 2D28 398B 3DAC 398A 3DAB 41CC 398A"
	$"2907 FD2D 2826 3149 396A 356A 3169 358A"
	$"398A 398A 3DAB 398A 3569 398A 20E6 18A4"
	$"20E7 20E7 24E7 24E7 2908 20E6 2507 316A"
	$"3149 356A 398A 3149 3569 3569 358A 356A"
	$"398A 3169 2D28 2927 2928 2907 2D28 2928"
	$"2506 2527 FD25 0761 2107 2507 2507 20E7"
	$"24E7 2928 3149 356A 398A 398A 356A 398A"
	$"398A 3DAB 3DAB 3569 3549 398A 39AB 398A"
	$"398A 3DAB 3DAB 358A 316A 2D49 2928 2907"
	$"2507 20E6 1CC5 2507 20E6 358B 3149 3169"
	$"3149 3169 2D48 356A 3169 20E5 1082 14A3"
	$"2106 20E6 2927 18A4 20E6 39AB 41CC 2D27"
	$"28E6 24E5 1862 1861 3106 3D69 2CE6 28C6"
	$"24C5 1C84 1884 18A5 1885 18A5 1484 1CE6"
	$"2507 18C6 318C 31AD 39D0 31AF 2D6D 252A"
	$"294B 2109 0C85 10C8 190B 150C 214D 318F"
	$"3DF1 39AF 41EF 4A10 4A30 4A31 4611 4611"
	$"41F1 3DD1 3DD1 35B0 358F 39B0 025A 3631"
	$"8E3D F152 9663 1A5A D74E 544E 754E 754E"
	$"545A D867 3B5A D852 965E D852 755A B75E"
	$"F952 9662 F95E D95A B84E 7542 1235 AF2D"
	$"8D29 4C21 2B25 2C35 D152 975E F95A B85E"
	$"F967 1A6B 3B6B 5C6B 5C6B 3B63 1A5E F95E"
	$"F95A B85E F95E F963 1A63 1A5E F962 F967"
	$"3B6F 5C6B 3C5A D852 9662 FA67 1BFC 631A"
	$"FE67 3A3F 673B 6B3B 6B5B 6B5B 6B5C 6B5B"
	$"6319 5ED8 6319 6B5B 6B3B 6B3B 673B 6B3B"
	$"673B 6B5B 6B5B 671A 5AB6 5696 5274 41F0"
	$"4A12 5254 5274 4E32 4A32 3DAF 41F1 4A33"
	$"5696 5AB7 56B7 62F9 62F9 5ED8 5AD7 62F9"
	$"62F9 5EF8 62F9 5EF8 56B7 673A 6F7D 6B5C"
	$"6B3B 673A 673A 5EF8 4E73 4210 318D 4210"
	$"56B5 35AC 20E7 2928 39AC 3DAC 3149 2D27"
	$"2D28 2D49 FE31 4917 2D28 3149 2D27 396A"
	$"3D8B 3149 398A 2D47 3569 41CC 41CC 3DAB"
	$"3169 2927 1CC5 1CA4 3149 3DAC 398A 398A"
	$"3569 3569 356A 356A FC31 4900 2927 FA25"
	$"0700 316A FE3D AC03 3DAB 41CC 3149 2907"
	$"FD2D 2814 3128 3149 3128 3149 316A 356A"
	$"398A 398A 358A 39AB 3169 2507 20E6 20E6"
	$"20E7 2507 24E7 2928 20E6 24E7 2928 FE31"
	$"4901 3169 356A FE39 8A2F 358A 2D28 2D28"
	$"2D49 2D48 2D28 2928 2D49 356A 358B 316A"
	$"2928 2907 2507 2507 20E6 2508 2908 20E6"
	$"2928 398B 39AB 356A 3569 396A 3DAB 3DAB"
	$"41CC 396A 28E6 2906 2D06 3128 2D07 28E6"
	$"3569 3548 24E5 398B 356A 316A 3149 3169"
	$"2D28 20E6 2D28 2D28 39AB FE39 8A3C 3569"
	$"1CA3 20C4 3169 3569 2D49 2D49 316A 398B"
	$"398B 356A 356A 3169 3128 2907 24E7 1CC5"
	$"2507 2907 28E6 3D49 3107 28C6 20A4 20A4"
	$"1CA4 1CA5 1885 1885 1883 1CA5 2507 2D49"
	$"18A4 0C62 2529 3DCE 4632 318D 294B 2529"
	$"2D6B 254B 254C 296E 298F 31AF 35D0 41F1"
	$"5695 5274 4E53 3DF0 292B 252B 2D6D 2D6E"
	$"318F 318F 318E 31AF 026F 285A 9862 FA5E"
	$"F95A D752 7546 3342 1252 755E D867 1A6B"
	$"3C52 964A 3352 755A D763 195E D846 335A"
	$"D85A D83D F131 8E31 8F2D 6D25 4D21 2C31"
	$"8F4A 5567 3C63 1B5E F95E FA62 FA5E D95A"
	$"B85E D856 B752 7652 7652 965E B8FE 62FA"
	$"4063 1A63 1962 F967 3A6B 5C67 3B67 1A62"
	$"F95E F96B 3C67 3B5E F95E D85A 975A B75E"
	$"B862 D862 F96B 1A6F 3B6F 5B6F 5C6F 5C6B"
	$"3B67 1A5E D85E F867 3B6B 3B6B 3A6B 3B67"
	$"1A62 F962 F956 B652 744A 3346 123D F035"
	$"CF31 AE35 AE39 D039 AF39 AF3D F139 D04A"
	$"5456 965E D862 F962 F966 F95E D856 9662"
	$"F96B 3B63 1967 3B6B 3B67 3B6F 5C6B 3B67"
	$"195E D7FE 62F8 0F62 D85A 964E 333D AE67"
	$"1852 7335 8D20 E82D 2841 CD35 6A2D 482D"
	$"482D 4931 4931 49FC 2D28 3D45 EE31 4929"
	$"0731 4935 693D 8B41 CC35 692D 272D 282D"
	$"2820 E629 0735 6A3D AB35 6A35 6935 6939"
	$"8A35 6A31 4931 4831 492D 482D 492D 4820"
	$"E524 E62D 2829 0725 0729 072D 2831 493D"
	$"CC3D AB3D AB41 CC41 CC2D 4829 0729 2729"
	$"2729 2829 082D 2931 4A2D 2925 0731 6A39"
	$"8B3D 8B39 6A39 8B39 8B31 692D 492D 4829"
	$"2721 0725 0729 28FD 2507 0429 2835 6935"
	$"6931 4935 69FD 398A 6F35 8A2D 2831 4931"
	$"692D 482D 482D 2835 6A39 8B3D AB39 8A31"
	$"692D 2825 0729 2825 0735 8B39 AC2D 4831"
	$"4939 AB35 6A29 0739 8B45 CD45 CD39 8B2D"
	$"2825 0625 0620 E510 411C A414 830C 4120"
	$"E61C C51C A439 8B35 6935 6939 8A39 8A35"
	$"6935 6931 4829 0635 6939 8B39 8A35 6A35"
	$"6929 072D 272D 2839 8A3D 8C3D 8B35 6A35"
	$"6A35 4931 4935 692D 2729 0629 072D 482D"
	$"2835 6A29 0731 2931 2820 631C 6318 6318"
	$"6318 8318 841C A41C 8418 8414 631C A429"
	$"0718 8414 6314 831C A539 AE46 3241 F139"
	$"AF42 113D F13E 114A 534A 544A 544E 744E"
	$"7452 754E 7442 1231 6D14 A71C EA2D 6D29"
	$"4C25 2C25 0B21 0B25 2B02 6C5A 62FB 5AB8"
	$"4633 4212 3DF1 35B0 41F2 5AD8 5AD8 673B"
	$"673B 4E54 41F1 4633 62F9 673A 5EF9 4633"
	$"4212 56B7 4213 31AF 35D0 318F 39D0 4E76"
	$"62FA 673B 62FA 5AD8 5297 4E75 5AD8 4E75"
	$"39D0 4212 3DF1 4613 4A54 4E75 5276 5697"
	$"5ED8 5EF9 62F9 631A 671A 6B3B 673B 671A"
	$"631A 62FA 673B 673B 56B7 5AD8 5AB8 4E55"
	$"41F1 3DD0 3DD0 41F1 4A33 4E33 5274 5675"
	$"5275 5695 5675 5275 5275 4E33 4A12 4A12"
	$"4611 41D0 3DAF 41F0 3DAF 4E33 5296 4A74"
	$"4A54 4A74 4E96 56D7 5AD8 56B6 5295 56B7"
	$"5AD8 FE5A D71C 5AB6 5254 4E54 4A33 5AB6"
	$"779D 671A 5ED8 6B5B 673B 673B 671A 5AD7"
	$"5295 4612 41F0 3DD0 3DD0 41F1 45F1 41F1"
	$"41F0 5695 41EF 358D 2509 398B 3149 2907"
	$"FE31 4919 2D28 2D28 2928 2927 2D28 2928"
	$"3DCC 356A 2D48 3169 2D28 356A 3149 2907"
	$"20C5 24E6 2928 2D28 3149 3149 356A 398B"
	$"356A 398A 396A 3569 FC2D 480F 2928 2928"
	$"2507 2927 2D49 2928 2D48 3169 3169 39AB"
	$"3DAC 3DAA 3DCB 39AB 3148 2506 FD25 0716"
	$"24E6 358B 358B 2D28 2D28 39AB 3DCC 3DAB"
	$"3569 2D48 2907 2928 3149 2D49 2928 2928"
	$"3149 358B 2D48 2D28 2D28 2928 2D28 FD35"
	$"69FE 398A 7039 AA35 6A2D 2835 6A35 6A31"
	$"4931 4939 8A39 8B3D AC35 8A35 6931 4829"
	$"2729 2831 6A39 AC3D CC39 AB31 692D 4831"
	$"6939 8A35 6A41 CD3D 8B35 6929 0718 A31C"
	$"C420 E618 A410 6314 8318 C510 8310 831C"
	$"C524 E739 8B35 6939 8A39 8A35 6939 8A3D"
	$"AB20 E518 8339 8A3D AC2D 282D 2735 6A35"
	$"6A39 8A31 4831 4924 E629 0724 E629 0629"
	$"0729 272D 2829 2729 062D 272D 272D 2829"
	$"2724 E629 0728 E620 A418 8314 4114 6218"
	$"8318 841C A418 8318 8418 8318 8418 841C"
	$"A41C C61C C514 631C C631 6C3D EF39 CE3D"
	$"EF42 1142 115F 1846 1241 F14E 7446 3246"
	$"324E 5446 122D 6C14 A721 0A29 4C25 2B21"
	$"0A1C E918 C81C E902 767F 4614 3DD2 39D0"
	$"35B0 358F 3590 4E55 5AB8 5ED8 6B5B 5EF9"
	$"5295 4A54 5296 62F9 631A 673A 5296 4A74"
	$"5F1A 4E96 4633 4233 4212 4634 4A55 4A55"
	$"4634 4613 3DF2 358F 318F 5AD9 56D8 4A55"
	$"4E75 5276 56B7 5AB7 5ED8 5AD8 5ED8 62F9"
	$"5AD8 5AB7 5AD8 5AB7 5AB7 5AD8 5696 5276"
	$"5AB8 6B5C 631A 5296 5AB7 631A 633B 5AF8"
	$"56B7 52B6 4E95 4653 4653 4632 4612 3DF0"
	$"3DF0 35AE 316D 2D4C 250A 210A 250A 250A"
	$"210A 20E9 292B 294C 358E 358E 358F 3DF1"
	$"5696 6B3B 671A 5696 4612 39AF 4A33 4A33"
	$"4612 4212 4612 3DF0 39D0 41F2 4A54 6F5C"
	$"737D 62F8 62F8 62D8 62F9 671A 5696 4611"
	$"39CF 3DD0 3DF0 4612 39D0 294C 292C 1CC8"
	$"39AF 5ED8 5695 18A5 20E7 2928 1CA4 2927"
	$"2D49 2D48 2D48 2507 2507 1729 2829 2829"
	$"2739 8B3D AC2D 4839 AB31 6925 0729 2818"
	$"8318 A420 E624 E729 2829 2735 8B2D 2835"
	$"6A35 6A31 6935 6939 6A35 69FE 2D48 2D29"
	$"2729 2729 282D 4931 6A2D 4931 6931 4931"
	$"4931 693D AB3D AC39 8A39 AA39 8A31 482D"
	$"2831 692D 4829 2829 282D 282D 2835 8A25"
	$"061C C529 072D 2835 8A31 6925 0729 272D"
	$"282D 4935 6A35 6A35 8A35 8A39 8B39 AB39"
	$"8B35 8A35 6A35 6A31 4935 69FD 398A 0D41"
	$"CC41 CC3D AB31 6935 6939 AB31 4824 E631"
	$"493D CC3D AC39 AB2D 272D 28FE 2927 2F39"
	$"8B39 AB35 8A31 482D 2735 6939 AB41 CC39"
	$"AB31 4829 0729 0625 061C E51C E518 C51C"
	$"E61C E620 E621 0718 A510 831C C524 E635"
	$"6A35 4939 8A31 4831 4835 6A24 E620 E535"
	$"6A35 6A35 6929 2729 2731 6931 6939 8A2D"
	$"2720 C518 A425 062D 4818 A329 073D ACFE"
	$"358A 0D39 8A35 6931 4931 4829 0720 E525"
	$"0720 C51C A418 6218 8318 8318 A418 A4FE"
	$"1884 1D18 8318 8414 6318 A41C C620 C620"
	$"E720 E625 0829 2839 AD41 EF39 CE56 9535"
	$"AE2D 6D52 754A 3342 124A 5352 9531 8D1C"
	$"E921 0A25 2C29 4C25 0B1C E918 C81C E902"
	$"787F 3590 3590 35AF 318F 2D6E 35B1 4A35"
	$"5AB8 6B3B 6B3A 5696 5AB7 62F9 5ED8 5696"
	$"5AB8 5AB8 5696 4633 4E55 4E55 4E75 4633"
	$"4213 3DF2 39D1 35B0 318F 2D6E 316E 250C"
	$"358F 673C 631A 4E55 39D0 4633 4E75 4A33"
	$"4A33 5275 5AB7 5AB8 5696 5276 4E75 4A54"
	$"4212 4A34 4633 4A54 671A 6F7D 5EF9 5296"
	$"4E55 5AB7 671A 6B3B 6B5C 6B5B 673B 631A"
	$"673B 633A 633A 5F19 5AF9 56D8 4E96 4A75"
	$"4233 3E33 3A12 3A12 35D1 31B0 35D0 39F1"
	$"39D1 4633 5276 5EF9 5ED8 5275 41F2 3DD0"
	$"318E 318E 39D0 39D1 39B0 39D0 4212 4633"
	$"4E75 5AB8 673B 6F7D 671A 6B3B 5ED8 4611"
	$"6B3A 5A96 398E 292A 2509 292B 316C 4612"
	$"4A54 210B 1CE9 41F1 671A 5695 1464 0400"
	$"1CC6 2507 2507 2928 24E6 2506 2507 24E6"
	$"2506 412D 282D 2835 693D AC31 4935 6A35"
	$"6A29 0721 0620 E610 6318 A524 E720 E725"
	$"0729 0735 6A31 4931 4939 8B31 4929 0731"
	$"4831 482D 4831 4931 4929 2731 6A35 8A35"
	$"8A31 6A35 8A39 8A39 8A35 8A39 8A3D AB39"
	$"8A3D AB3D AB31 4824 E62D 282D 282D 272D"
	$"2829 2729 082D 2825 071C A51C C520 C620"
	$"E631 4A25 0724 E729 082D 2831 4935 6935"
	$"6939 6A35 6931 28FE 3148 2635 6A35 8A35"
	$"6A35 6A39 8A39 8B3D AB3D 8B3D AB39 8A39"
	$"8A31 6935 8A39 8A29 0720 E53D AC45 EE3D"
	$"AC2D 4729 2731 4931 6931 4935 6A39 AB35"
	$"8A35 8A2D 4831 6935 8A35 6A2D 4829 0729"
	$"2729 0729 0720 E61C C5FE 20E6 2B25 0724"
	$"E618 8318 A414 8310 6218 8329 0631 4824"
	$"E535 8A31 4929 2729 2731 6A31 6A2D 4931"
	$"4931 4931 6931 6939 8A41 CC29 271C C429"
	$"283D CC35 8A08 0029 274A 0E41 CC39 8B35"
	$"6935 492D 272D 0728 E61C A420 C425 0620"
	$"E61C A41C 83FE 1863 0118 8318 A4FD 1884"
	$"1B14 6314 8318 8418 A420 C620 C624 E620"
	$"E625 0729 292D 4B31 8D2D 6D25 0A39 CF31"
	$"6D29 2B3D D063 1935 8E18 C825 2B21 0A25"
	$"2B1C EA1C E918 C81C E902 6D42 31B1 318F"
	$"31AF 318F 294D 3DD1 5AD8 671A 6B1B 62D9"
	$"5275 5ED8 5ED8 4633 35AF 35B0 39D1 4A55"
	$"4213 41F2 4613 41F2 39B0 3DF1 4634 4634"
	$"3E12 39F2 2D6E 252C 1CEA 3DF2 779F 5EFA"
	$"41F2 35B0 4633 4633 39D0 39D0 35AF 3DF1"
	$"4A55 5276 5276 56B7 5AD8 4E75 5275 4E54"
	$"5AB7 737D 673B 62F9 6319 5AD8 5ED8 62F9"
	$"6319 671A 671A 6319 673A 673B 673A 671A"
	$"673A FE67 3B63 631A 631A 62F9 5ED8 5AD7"
	$"56D8 631A 5EF9 5EF9 5AD8 5AB9 56B8 4A54"
	$"3DF1 39D0 35D0 318F 2D6E 2D6E 4634 4E76"
	$"4634 4A55 5297 5AD8 631A 6B3B 6319 5ED8"
	$"5EF8 6B5B 4A33 250A 5274 2D4B 1CC7 1CC7"
	$"1CE8 2109 2109 316D 4211 316E 3DD0 4E53"
	$"2D4A 0821 0400 1062 18A4 2908 2D49 2507"
	$"20E6 2927 2948 2928 2D49 3149 3148 398A"
	$"356A 2D48 358A 2D49 2507 2508 1CC6 18A4"
	$"1CC6 20E7 20E6 20E6 2507 2907 24E7 2D28"
	$"39AC 356A 2928 2928 2D48 3149 356A 358A"
	$"356A 39AB 398B 356A 358A 398A 3DAB 3D8B"
	$"3D8B 396A 396A 3DAB 41AB 3149 2907 FD20"
	$"E63D 24E6 24E6 20E6 20E7 20E6 1CC6 1CC5"
	$"1CC5 20E6 2528 20C6 20E6 24E7 2D28 2D29"
	$"2D28 2D28 2D49 2D28 24E6 2507 2907 3149"
	$"39AB 39AB 358A 3149 3149 356A 356A 3569"
	$"3149 3149 2D28 3149 2D28 24E6 2506 3149"
	$"398B 356A 3569 3169 3569 3149 356A 356A"
	$"358A 358A 3569 3569 3149 3569 3149 2907"
	$"20E6 20E6 2507 2507 20E6 1CC5 20C6 FE20"
	$"E60D 2907 1463 0C41 1483 1483 14A4 1CE6"
	$"2507 2D49 3149 3DAC 2D28 2506 2506 FE2D"
	$"4826 3148 3149 398A 398B 3DAB 398A 3569"
	$"398A 41CC 41AC 20E5 0820 18A3 2D48 398B"
	$"2D28 2907 3149 2D48 2D28 24E6 0C20 20C5"
	$"20C5 18A4 1CA4 20C5 1883 1862 1862 1883"
	$"1CA4 1C84 1883 1884 1884 18A4 1484 1484"
	$"FD18 840E 18A4 1884 1CC6 2509 1CE7 292B"
	$"1CE9 210A 1D09 14A7 3DF1 5EF9 294B 1065"
	$"1CC8 FE1C E9FE 18C8 0266 3731 8F2D 6E31"
	$"8E2D 6D29 2C4E 556B 3C62 F963 1963 1A56"
	$"B756 B752 B74A 753E 1229 6D2D 4D35 B03D"
	$"F242 134A 553D F229 2C35 AF4E 7631 B031"
	$"AF39 F235 D029 4D18 C962 F97B DF46 3431"
	$"8E31 6E46 334A 5439 D039 D039 B041 F246"
	$"333D F142 125E F967 1A5A D85A B75E D86B"
	$"3B6F 5C63 1962 F967 1A67 1AFE 631A FE67"
	$"3A01 673B 673B FE67 3A47 6319 5EF9 5EF8"
	$"5AD8 56B7 5696 5275 56B6 631A 6B5B 5AD8"
	$"5AD8 5275 4212 3DF1 39D0 35AF 2D8E 296D"
	$"2D8F 318F 4A54 631A 5AD8 5AB8 631A 62F9"
	$"5EF8 5696 4A54 4E74 5296 5EF9 6F7C 4212"
	$"0C65 20E9 0C64 0C64 1085 1CE7 2529 2509"
	$"292B 316C 2D4B 2509 1063 0821 1063 18A4"
	$"20E6 2928 316A 3149 3149 3169 35AA 358A"
	$"2D48 2D28 2507 20C5 1CC4 20E5 24E6 2507"
	$"24E6 2507 2507 1CC5 1CC5 FE20 E610 2507"
	$"2928 2907 2907 356A 3DCC 3569 3DAB 3DAC"
	$"356A 3DAB 398A 398A 3DAB 398A 398A 3569"
	$"FD39 8A05 396A 3569 3D8B 41CC 3D8B 316A"
	$"FD29 280F 2D49 2507 1CE5 20E6 20E6 1CC5"
	$"18C5 18C5 1CC6 1CE6 20E6 1CC6 24E7 2928"
	$"2928 2507 FD29 2829 2927 2D49 316A 398B"
	$"358B 356A 2D28 2928 2D28 2928 2927 3149"
	$"3169 316A 3149 2D48 2927 2927 3149 3149"
	$"24E6 20C5 24E5 2927 3169 2D49 2D48 356A"
	$"358A 358A 356A 3149 356A 3149 2D27 20E5"
	$"1CC5 20E6 2507 24E7 20E6 1CC6 FD20 E639"
	$"20C5 0C62 18A4 20E6 2948 2D48 398B 3DAC"
	$"356A 3569 2D48 20E5 20E6 2928 2D49 2D49"
	$"2D48 3148 398A 39AA 3DAB 39AB 358A 3DCC"
	$"3DAB 3DAB 3569 3148 2527 1CE5 20E6 2D48"
	$"2907 2907 2D28 3149 2D49 18A4 1041 1CA4"
	$"1463 1462 1CA4 20C5 1CA4 1883 1C83 1883"
	$"1CA4 1884 1883 1884 1483 1484 14A4 14A4"
	$"1484 1484 FE18 8313 1483 1484 18C6 18C6"
	$"1CE8 18C8 18C8 1D09 18C8 3DF1 4A54 18C8"
	$"1086 14A7 18C8 1CE9 1CE9 18E8 18C8 18C8"
	$"025D 373D D13D F139 CF35 AF46 1367 1C6B"
	$"3C5E D85E D95A B852 764E 554E 5546 1341"
	$"F246 133D D139 B035 AF35 8F3D D146 3446"
	$"134E 763D F22D 6E31 8F31 8F35 D02D 6E39"
	$"B07F DF5E D931 8E31 8E2D 6D35 AF3D F231"
	$"8F3D D146 334E 7542 1246 125A B767 1A56"
	$"9656 9652 755A B65E D862 F966 F966 F967"
	$"1966 F9FE 6319 FE67 1A5A 6B3B 6B3B 6719"
	$"673A 673A 6319 62F9 62F9 631A 631A 6319"
	$"673A 6B5B 673A 56B7 4633 4212 39F0 35AF"
	$"31AF 318E 31AF 39D1 3E13 4E76 4E76 5AD8"
	$"5697 4E75 5275 5696 5295 5696 4E54 4A54"
	$"56B7 631A 673B 77BF 4212 0002 0843 0C63"
	$"1085 14A5 1CE7 18C6 14A5 24E8 20E7 14A4"
	$"0C42 1063 1484 20E6 314A 356A 2928 2D27"
	$"3148 39AA 41CC 3DCC 2D48 20E5 1CC4 1062"
	$"1483 18A4 1CC6 20C6 24E7 2D48 2D49 2927"
	$"2507 2927 2D48 3169 3169 358B 39AB 358A"
	$"398A 3DAB 3DCB 3DAB 41CC 3DAB 3D8A 3DAB"
	$"FE39 8A15 3569 356A 3569 398A 398A 3D8A"
	$"3D8B 3D8B 3DAB 41AC 41CC 3D8B 2D48 2D48"
	$"2927 2927 358B 358B 2928 20E6 1CC5 1CC5"
	$"FE18 C500 1CC5 FE20 E62C 2507 2D28 2507"
	$"2927 2D49 3169 316A 316A 356A 358A 358A"
	$"356A 3149 2D27 2D27 2928 2507 20E6 2D48"
	$"358B 39AB 39AB 358A 3169 3149 2D48 2D48"
	$"2907 1CC5 1CA4 1CA4 1CC5 2507 2928 2D48"
	$"356A 358A 358A 3569 3149 398A 3169 2927"
	$"20E5 20E5 FE20 E619 1CC5 1CC5 20E6 2507"
	$"2927 2927 2507 1CE5 316A 39AB 3DAC 3DAB"
	$"3DAB 398A 3148 3148 2506 1462 1CC5 316A"
	$"3149 3149 3569 398A 3DAA 3DAB FE3D AA1D"
	$"3DAB 3989 398A 3148 3DAB 358A 2506 2506"
	$"2D48 2927 24E6 24E6 3169 2D28 20E6 1884"
	$"1062 1041 1062 1883 1CA4 20C5 1C83 1862"
	$"18A3 1CA3 18A4 1883 18A4 1483 FE18 8300"
	$"1483 FC18 8302 1062 14A4 18C5 FE18 C705"
	$"1CE8 210A 39AF 358E 1086 14A7 FA18 C802"
	$"5442 5AB8 5AD8 4E74 4E75 5697 5697 4E55"
	$"4E54 4A54 4613 3DF1 3DD1 39B0 358F 318F"
	$"39D1 3DF1 4633 3DF1 2D6E 294D 31AF 3DF2"
	$"4212 39D0 39F1 39D1 4213 4A55 3DF2 5EFA"
	$"6F5D 39B0 2D6E 35AF 294C 294D 5296 4A55"
	$"4A54 5296 4633 4633 56B7 62F9 5696 4E74"
	$"4E53 4611 45F1 4A12 4E33 4E33 5674 62D8"
	$"62D8 671A 62D8 5AB7 5A96 5A97 5696 5EB7"
	$"5ED8 5ED7 5ED8 62D8 FE5E D81A 671A 6B3B"
	$"6B5B 5EF9 5295 4A33 41F1 39CF 39F0 39F0"
	$"3DF1 4213 4A54 4A55 4A55 4E75 4E75 5296"
	$"4E76 4E75 4E75 5296 5696 5696 5AB7 5AD8"
	$"62F9 FE6B 3B27 737D 358D 0000 0843 1CE7"
	$"2108 14A5 1084 0C63 1083 14A4 1063 1063"
	$"1463 1463 1CA5 2D49 2D48 2927 2926 3148"
	$"358A 41CC 3DAB 3DAB 2D28 2928 2928 2507"
	$"2D6A 358C 2928 2928 2D49 356A 3149 3148"
	$"356A 3569 356A FC39 8A27 3DAB 3DAB 41CC"
	$"3DAB 398A 3148 3148 3569 356A 3149 2D28"
	$"2D48 3149 3149 356A 3569 396A 398A 398A"
	$"3DAB 41AC 4A0E 356A 2928 356A 2927 24E6"
	$"356A 3DAC 3169 3169 2528 2107 18C5 18C5"
	$"18A4 1062 2507 24E7 2907 FE2D 49FE 356A"
	$"1631 6931 4931 4935 6935 6A31 692D 4829"
	$"2729 282D 482D 2831 693D AC35 8B35 6A31"
	$"492D 2829 2724 E61C C420 E620 E61C C6FE"
	$"1CC5 261C E61C C525 072D 4931 4935 6A35"
	$"6935 4939 8A35 6A29 2729 2725 0620 E620"
	$"E61C C514 8325 072D 482D 492D 482D 4935"
	$"8B39 8A3D AB41 AB41 AC39 6A35 8A29 2729"
	$"2731 4920 E618 A424 E635 6A2D 4835 6A3D"
	$"ABFE 3D8A 053D AA3D 8A41 AA3D 8A3D AA3D"
	$"AAFE 398A 1424 E624 E52D 282D 2725 0629"
	$"072D 4829 0729 071C C518 8310 4110 6214"
	$"6214 6224 C524 E618 6218 8218 A318 A4F5"
	$"1883 0B10 620C 421C C618 A618 C614 A618"
	$"C718 E825 2B21 0A14 A718 A8FD 14A7 0214"
	$"C814 C718 C802 6F79 5AB9 5697 4E55 5275"
	$"4A54 4A54 4E75 4E75 4E54 4E55 4E54 4633"
	$"4212 39D0 35D0 35AF 318E 3DF1 4633 4A54"
	$"35B0 39D0 4633 4A54 4E75 4E76 4A55 4E76"
	$"4A55 4634 4E76 4A35 3DF2 31B0 2D6E 1CEA"
	$"3DF2 77BF 671B 5EFA 5EF9 5276 4E75 5AD8"
	$"56B7 4E54 4A33 41F0 3DCF 3DD0 41F0 3DCF"
	$"39AE 3DCF 4611 5254 5696 4E75 5276 4E55"
	$"4633 4613 4612 3DF1 41D1 41D1 4A33 4E54"
	$"5275 5AB7 62F9 56B6 4E75 4632 3DF1 4212"
	$"4632 4653 4A75 4A74 4E76 4A34 4212 4212"
	$"4E54 5EF9 673B 673B 5EF9 5696 5275 5696"
	$"4E75 4632 3DD0 3DF0 41AF 4E12 4E12 4A11"
	$"4A11 1484 0000 1484 314A 2D49 18C5 18C5"
	$"10A4 1083 1084 1063 1064 1484 1483 1CC5"
	$"2928 2D49 3169 3169 398A 398A FE35 690F"
	$"3169 39AB 3DAB 3DAC 41CC 39AB 3169 2D49"
	$"2D49 3149 3149 3148 3569 398A 3D8B 398B"
	$"FE39 8A28 398B 3DAB 3D8B 3DAB 356A 2D48"
	$"2D28 2D48 3149 356A 3569 2D28 2907 2928"
	$"2D49 2D49 3149 356A 398A 39AA 3DCB 45EC"
	$"41EC 3168 2D28 358A 3169 3148 398B 3DAB"
	$"3569 358A 2D49 2D48 2928 20E6 18C5 1063"
	$"1CE6 2507 2D28 FE31 4910 356A 3148 2D27"
	$"2927 2D28 2D28 356A 358A 2D28 2928 2948"
	$"2D49 356A 398B 398B 3169 2D28 FE29 2703"
	$"20E7 1CC5 1CC6 20E7 FE1C C538 20E6 1CC6"
	$"1CC6 1CC5 20E6 2507 2927 2D48 2D48 3149"
	$"356A 3149 3149 358A 2D49 2907 1CC5 1483"
	$"2D49 3DCD 358B 3569 3569 398A 41CB 3D8A"
	$"398A 3DAB 3D8A 3569 2D27 2906 3149 20E5"
	$"20C5 2927 2D48 3148 3548 41AB 3DAA 3989"
	$"3989 3DAA 3DAA 3D8A 3DAA 41AB 3DAA 3D8A"
	$"3989 3989 398A 24E5 18A4 2928 2507 FE29"
	$"070E 2D28 20C5 1CA4 2507 20C5 1462 1061"
	$"1062 1CA4 28E6 2083 1C82 1C83 1CA4 1C83"
	$"FE18 8303 1483 1483 1463 1483 FE18 8307"
	$"1483 1062 0821 1CE6 14A6 18A6 14A5 18A6"
	$"FE18 C708 18A7 18A7 14A7 14A7 14A6 14A6"
	$"14A7 14A6 14C7 0261 1C4E 5546 1346 1346"
	$"1242 1146 3246 1246 1241 F246 1346 3446"
	$"334A 344E 7656 B74A 5542 1246 334A 544A"
	$"3442 123D F13D F13D F23D F23E 1239 F139"
	$"D035 AFFE 35B0 4D42 333E 1239 F13D F25E"
	$"F963 1A5A B862 F963 1A63 1A5A D856 964E"
	$"7446 3241 F141 F14E 7356 B65A D74E 7446"
	$"3242 1142 1146 3242 123D F146 3346 334A"
	$"544A 544E 754E 754A 334A 545A B74E 754A"
	$"3346 3342 113D D046 3352 9652 964E 754A"
	$"7446 3339 F131 AE39 D14A 545A D762 F967"
	$"3A6B 5B5E D746 3242 1256 B763 194E 7539"
	$"CF35 AF35 AE35 AE35 AF31 8E21 0A25 2A20"
	$"E800 0008 2129 2931 6A1C C51C C521 0714"
	$"C514 A4FD 1084 5D0C 6225 072D 4931 6935"
	$"6A35 4935 6931 4831 4835 6931 4839 8A3D"
	$"AB3D AB41 CC41 CC35 6925 0725 0729 282D"
	$"482D 4931 4935 6A39 8B39 AB39 8A39 8A39"
	$"AB39 8A39 8A31 4931 4931 6929 2724 E62D"
	$"4831 4935 8A39 AB39 AB35 8A29 2829 2725"
	$"0729 2831 4935 6A35 8A39 AB3D AB41 EC3D"
	$"AA2D 272D 2831 6931 482D 4835 6A39 8B39"
	$"8A31 6925 0729 0731 6A2D 6929 4929 2820"
	$"E625 072D 4831 482D 482D 4829 282D 2829"
	$"2729 282D 492D 4939 8B31 691C C435 8A3D"
	$"AC35 6A31 492D 4829 0720 E625 0725 0721"
	$"0625 06FE 20E7 2B1C C51C C51C C61C C620"
	$"E61C C518 C51C C51C C525 0729 2831 492D"
	$"4831 4835 6A31 6935 8A39 AB35 8A31 6925"
	$"0629 2746 0E41 ED39 8A39 8A41 CC45 EC41"
	$"AB35 692D 272D 2731 4831 482D 4831 482D"
	$"2718 A424 E62D 482D 2831 4835 693D ABFE"
	$"398A 0039 AAFD 3DAA 1D39 8939 893D 8A39"
	$"8935 6924 E61C C429 0725 0629 0725 0624"
	$"E625 0620 C520 C531 4929 0718 8310 6114"
	$"8214 6220 A428 C51C 8218 8218 831C A318"
	$"8318 8314 83FE 1462 0714 8314 8318 8314"
	$"8314 8310 6204 2014 A5F9 14A6 0114 A714"
	$"A7FD 14A6 0110 8510 A502 6379 39B0 358F"
	$"358E 39AF 358E 35AE 35AF 318E 358F 3DF1"
	$"4212 4A34 4E75 4E75 5276 4A34 3DF1 39B0"
	$"358F 318E 39D0 3DF1 4633 4E55 4E75 4E96"
	$"4A75 4654 4233 3E12 3E12 35D0 4233 5AF9"
	$"5AF9 5AD9 4E75 4E55 5696 5697 5AD8 5ED8"
	$"5AD8 5AB7 5AB7 5696 5AB6 62F9 6B3A 5ED7"
	$"5ED7 5AB6 5695 5696 5696 62F8 631A 5296"
	$"4E75 4633 4633 4A54 62F9 671A 4E74 4632"
	$"4211 39AF 39AF 41F1 5295 5AD8 56B7 4E75"
	$"4212 39D0 31AE 296D 39F1 4A75 631A 6B5C"
	$"675B 6B5B 673A 5295 41F1 4E74 6B5B 77BE"
	$"5EF9 294C 1CE8 318D 294B 252A 318E 4233"
	$"254B 18C7 0C43 0842 1485 358C 2107 1CC5"
	$"1CC6 1CE6 18C6 18C5 14A5 14A5 1084 1084"
	$"14A4 2949 2507 2907 2D27 3128 2D27 2D48"
	$"FE35 693F 3DAB 41CC 41AB 398A 2907 1CA4"
	$"1482 2507 2507 2928 2D49 356A 358A 398B"
	$"39AB 398A 398A 39AB 398A 358A 2927 3169"
	$"3169 20E5 2506 3148 3169 39AB 3DCC 3DCC"
	$"39AA 3169 3169 2927 2D48 2D28 3149 3569"
	$"398A 41CC 41CC 3589 2506 2907 24E6 24E6"
	$"2907 3149 398B 3569 3169 3149 2927 2D48"
	$"2D48 2D49 2D49 2D28 2D28 3148 2D48 2D27"
	$"2D48 2D48 FE2D 4907 356A 398A 39AB 3148"
	$"3569 4A2F 356A 2906 FD25 0733 2D48 2506"
	$"1CE5 3169 2D69 2507 18C4 18A4 1CC5 1CC5"
	$"1CC6 20E6 1CE6 1CC5 18A4 20E6 2928 2928"
	$"2D49 3169 3169 3DAB 3569 358A 39AB 39AB"
	$"398A 398A 39AA 41CC 3DAB 3DAA 3DAB 41CB"
	$"41CB 41AA 3DAB 3148 2906 2906 2907 3149"
	$"2D48 1CC5 2507 2907 2927 2927 398A 3DAB"
	$"3DAB 3DAA FB3D 8A09 3D89 3969 3989 3DAA"
	$"3569 398A 3169 24E5 24E5 2506 FD24 E603"
	$"20C5 24E6 316A 2907 FE18 A314 1061 1C83"
	$"41AB 1C83 1461 1882 1C83 1462 1883 1883"
	$"1462 1482 1482 1483 1883 1883 1482 1462"
	$"1062 0400 1084 FC14 A604 10A6 14A6 10A6"
	$"14A6 14A6 FE10 8502 14A6 1084 1485 0269"
	$"FD35 8E7F 316D 316D 318E 318E 4E75 5696"
	$"3DD0 39D0 3DF1 3DD1 39B0 358F 316E 292B"
	$"316D 4613 5276 4A54 4633 4A54 4E75 5276"
	$"5296 5297 56B7 56B8 52B7 4E96 673B 673B"
	$"5EF9 56B7 5296 5296 5AB7 5AD8 5AD8 5696"
	$"56B7 56B6 5ED8 673A 6B3B 6F5C 6B3A 5ED7"
	$"5AB6 5695 4A53 5274 5ED7 6F5B 6319 4A33"
	$"4612 4632 4E54 5275 4E75 4633 3DD0 358E"
	$"35AF 4A53 56B6 56B7 56B7 4A54 3DF1 35B0"
	$"2D6D 294C 31AF 56D8 6F7D 6B7D 6B5C 6B5B"
	$"673B 5AD8 4E75 4A55 5AD9 6B5D 737D 5ED8"
	$"4632 18C7 0C64 294B 252A 2529 39AE 35AE"
	$"20E8 2529 2929 2108 2528 2949 2107 2507"
	$"2107 2107 20E7 1CE6 18C6 18C6 1484 1484"
	$"18A5 20E6 20C6 24E6 2927 3169 3148 2D48"
	$"3569 398A 3DAB 3DAB 41AB 3569 20E4 18A3"
	$"0C61 1062 0820 E620 E629 0731 4935 4935"
	$"6A39 8A39 8A3D ABFE 398A 2F35 8A35 8A39"
	$"AB31 482D 2731 4935 6939 8B3D AB41 CB3D"
	$"CB35 8A39 AB39 AB31 692D 4831 4931 4935"
	$"6939 AA41 CC3D CC2D 4824 E524 E61C A420"
	$"E624 E631 4931 6931 4935 6A39 8A31 6929"
	$"2729 272D 2829 272D 272D 2831 492D 282D"
	$"0831 4931 4931 4831 4835 69FD 398A 1C45"
	$"ED39 AA20 E525 0631 6931 6A35 8A39 AB35"
	$"AB2D 482D 4839 AC2D 4925 271C C418 A420"
	$"E61C C51C C520 E620 E61C C518 A425 0729"
	$"282D 4931 4931 4931 68FE 398A 1B3D AB41"
	$"CC41 CC41 AB3D AB3D AB41 CC41 AB3D AB41"
	$"AB3D AA3D AA35 8A35 6931 482D 2829 0729"
	$"0725 0725 0729 0729 072D 2835 6939 8B3D"
	$"AB3D AA3D 8AFE 398A 0D39 8939 8A3D 8A39"
	$"6935 4835 6939 8A39 8A3D AB39 8A2D 2725"
	$"0629 0629 07FE 24E6 0F20 C520 E631 4929"
	$"0729 0624 E51C C414 4120 A45A 5128 E514"
	$"4018 6218 8214 6218 82FE 1462 0C14 8214"
	$"8314 8314 8214 6210 620C 4104 0010 8414"
	$"A614 A514 A614 A6FC 1085 060C 8510 8510"
	$"8510 8410 640C 6410 8402 737F 316D 2D6D"
	$"2D6C 294B 316D 4612 4E54 4E54 5AB7 4A54"
	$"2D4C 292B 318E 318E 2D6D 2D6D 316D 35AF"
	$"4633 4A54 41F1 318E 316E 35AF 3DD1 3DF1"
	$"4613 4A55 4E75 56B7 5AB8 5AD9 62FA 62FA"
	$"671B 671B 671A 62F9 5EF9 5ED8 5AB7 56B7"
	$"5AD7 5696 56B6 5EF8 6B3B 6F5B 6B3B 62F8"
	$"5ED7 5AD7 5274 62F8 6B5B 5AB7 3DD0 316D"
	$"358E 358E 39D0 3DD1 3DD1 39B0 39B0 4A55"
	$"5AD8 5AB7 4A53 3DF0 35AF 318E 2D6D 252B"
	$"296D 4233 673B 739E 6B5C 673B 6B3B 673A"
	$"5295 4612 62F9 5AD7 671A 6B3B 5295 41F1"
	$"4211 18C7 0001 14A5 1CE7 318C 39AD 20E7"
	$"2D49 39AC 358B 3169 2D69 2927 2927 2507"
	$"2527 2528 2107 20E7 20E6 20E6 1CC6 18A5"
	$"1484 18A4 24E6 24E6 2D28 356A 3148 3569"
	$"398A 398B 3DAB 398A 2907 20E5 141C C61C"
	$"E618 A514 8318 A418 A41C C520 E629 072D"
	$"2831 4935 4939 8A39 8A35 693D AB39 AB39"
	$"AB39 8A31 6939 8AFE 39AB 193D AB41 CB41"
	$"AB39 8A39 8A35 6A39 8A35 6935 492D 2835"
	$"6A39 8B3D AC31 6929 2724 E618 A418 A41C"
	$"C520 E631 492D 2831 493D AB39 AB35 6AFE"
	$"2D28 3729 2720 E525 072D 2824 E629 072D"
	$"4831 4831 6935 6935 6935 4939 8A3D AB41"
	$"CC39 8B29 0729 0635 693D AB3D AB41 AB41"
	$"CC41 CC3D AB39 8A35 8A35 6931 4929 2825"
	$"0725 071C E51C C520 E61C C61C A51C A529"
	$"072D 2835 6A35 6931 4931 4839 8A3D AA3D"
	$"8A41 CB41 CB41 AB3D 8A3D 8B39 6A3D 8B35"
	$"6935 69FE 398A 3635 6931 6931 4931 492D"
	$"4929 2829 2725 2724 E624 E625 0729 272D"
	$"4831 4835 693D 8A3D AA39 8A39 8A39 8939"
	$"8A39 8935 6939 8A39 AB35 893D AA3D AA39"
	$"8A39 6931 4829 2729 0724 E624 E620 E520"
	$"C520 C529 0729 273D 8B31 2828 E61C 6228"
	$"E556 2F35 481C 8214 4014 6118 6214 6214"
	$"6114 6210 61FD 1462 0610 6210 620C 2108"
	$"2014 8310 8410 85FE 1084 0710 850C 640C"
	$"640C 6308 430C 630C 630C 43FE 0842 0261"
	$"6B31 6D35 8E39 AF42 1156 B65E F84E 743D"
	$"F135 AE31 8D2D 4C29 4B2D 6C2D 6C2D 8D31"
	$"8D39 AF42 1146 123D D039 CF3D F039 CF31"
	$"8D31 6D35 8F42 124A 544E 7552 7652 9652"
	$"965A B85E D967 1B67 1A56 964E 544E 544A"
	$"334A 534E 5452 7552 7552 965A B75E F867"
	$"1A5A B74E 5356 B656 B55E F76F 7C5A D73D"
	$"F02D 6D2D 6D2D 6C39 D046 334E 9552 9652"
	$"965E D856 B742 1131 8E31 AE31 8E29 6D29"
	$"6C31 8E42 335E F96F 7D6B 5C6B 3B6B 3B6B"
	$"3A5E F93D F142 1167 3B5A D75E F86B 5B63"
	$"1946 3342 1146 3314 A600 0010 8418 A52D"
	$"4A31 6A29 2831 692D 492D 4931 6A31 6A2D"
	$"492D 492D 4829 2829 28FD 2507 1121 0720"
	$"E61C C518 A420 E62D 2839 8B39 8B39 8A39"
	$"8A35 6A35 8A35 8A2D 2824 E625 0725 0721"
	$"06FE 1CE6 0E14 A410 6314 8318 841C C524"
	$"E625 0629 0731 693D AB41 CC41 CC3D AB3D"
	$"AB39 8AFE 3DAB 0F39 AB3D AB3D AB39 8A35"
	$"6935 8A39 8A39 AB39 8A35 6A31 4831 4931"
	$"6935 6A2D 4931 6AFD 2928 1D2D 4935 8A31"
	$"693D AC3D CC3D AB39 AB35 8A31 6931 4929"
	$"2820 C524 E629 2820 E620 E62D 4831 4931"
	$"6931 4835 6939 8A39 8B35 8A31 6931 4931"
	$"492D 4839 AB3D CCFE 3DAB 3C41 AB3D AB39"
	$"8A31 2845 CD31 482D 2831 692D 6929 2829"
	$"2825 0720 E620 E621 0625 072D 4835 6A31"
	$"6935 8A31 6939 AB3D AB39 8A3D AB3D AB35"
	$"6931 4835 692D 282D 2831 4835 6939 8A35"
	$"6935 8A31 492D 282D 2831 492D 492D 4829"
	$"282D 4829 0729 0720 E520 E625 062D 4839"
	$"8A3D AB3D AB3D AA3D AA3D AB39 8939 893D"
	$"AA39 8A39 8AFE 3DAA 1341 CB3D AB39 8939"
	$"8A35 6931 482D 2729 0620 C51C A329 2731"
	$"4831 4835 4831 2728 E42D 0641 8A31 2624"
	$"C3FC 1461 0210 6110 4110 61FE 1041 0B0C"
	$"4108 2008 2008 4110 6208 420C 4308 4208"
	$"4208 4308 4308 42FB 0421 0204 0004 2104"
	$"2102 6B10 4A54 4E75 5275 56B6 5696 4A33"
	$"35AF 2D6D 39AE 3DF0 4632 4A53 4E74 4E74"
	$"52B5 5295 5695 FE5A D765 56B6 5AD7 5295"
	$"4632 3DF0 35AE 3DF1 4633 4A33 4A54 4633"
	$"4633 4E55 5276 5276 4A33 3DD0 358E 318D"
	$"39CF 3DF0 3DF1 3DF1 4632 4A54 4E75 5296"
	$"5AB7 5696 5275 5295 56B6 739D 5AD7 35AF"
	$"2D6C 39D0 4653 52B6 631A 673B 6B5B 739D"
	$"5AF8 35AD 318D 3E11 5296 5F19 56D8 56D7"
	$"56D8 631A 6B5C 6B5C 6B5B 6B5B 6F5C 673A"
	$"56B6 4211 39CF 739D 5AD7 4E75 6F7D 631A"
	$"631A 5AD7 56B6 4653 10A6 0000 1084 1484"
	$"20E6 2D28 2928 2928 2907 2506 2D28 3169"
	$"358A 358A 3169 3169 3149 2D28 2D48 2D28"
	$"2907 2507 2507 2927 2D48 3569 398A 3DAB"
	$"398A 3569 3148 FE31 49FE 2928 0E25 2725"
	$"2721 0625 2821 271C E614 A414 841C C521"
	$"0729 282D 4831 693D AB41 EDFD 3DAB 1739"
	$"8A3D AB39 8A39 8A3D AB39 AB39 8A35 8A31"
	$"483D AB3D CC3D AB3D CB39 8A31 692D 4831"
	$"6939 8A39 AB39 AB35 8B39 AB39 AB35 8BFE"
	$"39AB 3B3D AC39 8B3D AB3D CB3D AB31 6931"
	$"6931 492D 4825 0625 0720 C520 E635 6A35"
	$"6A31 6939 8A3D AB39 8A39 8A31 6931 4835"
	$"8A39 AB39 AB3D CC3D CC3D AB3D AA3D AA39"
	$"8939 8A39 692D 2735 492D 272D 482D 2829"
	$"2831 6935 8B31 6A31 6931 692D 492D 4835"
	$"6931 6935 8A39 8A39 8A41 CB41 CB3D AA35"
	$"6831 4831 482D 482D 282D 48FE 356A 4835"
	$"6931 482D 2729 2729 072D 2731 4931 492D"
	$"482D 4931 4931 4929 2725 062D 4831 6935"
	$"893D AB41 CB41 AB41 CB3D AA3D AA39 8A39"
	$"8939 8A39 693D AB3D AB41 AB41 AA3D AA35"
	$"6839 8A41 AB39 8A39 8A3D 8B35 6931 4824"
	$"E52D 072D 2731 4831 4820 C424 E531 272D"
	$"0628 E524 C318 6114 4014 6110 4010 4110"
	$"400C 400C 400C 200C 2010 6208 2004 0004"
	$"0008 210C 4108 4108 4108 2104 2104 2104"
	$"20FD 0000 FE04 0002 0420 0821 0841 025A"
	$"034A 5546 344E 5546 33FE 4212 044E 545A"
	$"B75A D763 1967 1AFE 673A 2A63 1A62 F862"
	$"F967 1963 195A D75A D756 B652 9556 B64E"
	$"744A 5346 334A 3346 3346 1342 1242 1346"
	$"333D F135 AF2D 6D29 4B35 CF5A F85A D85A"
	$"D756 B75E F85A D756 B752 965A B75E F967"
	$"1A5E F863 1A6B 5B4E 753E 114A 5463 1A67"
	$"3BFE 6B3B 056F 5B52 7431 6C39 CE63 186B"
	$"5BF9 6B3B 356F 5B6F 5C63 194A 7435 AE31"
	$"8D6F 7C73 7D46 3267 3A6F 5C63 1963 195A"
	$"D75A D646 3210 8504 2210 8410 8314 A425"
	$"0729 2829 0825 062D 2839 AB3D AB39 AB39"
	$"AB35 8A35 8A39 8A35 8A35 8A39 8A35 6A35"
	$"6A35 8A3D AC41 CC3D AB35 6939 6935 6931"
	$"482D 2829 2729 2729 2829 282D 482D 482D"
	$"29FE 2D49 0B29 482D 4929 4829 4831 8B35"
	$"8B39 AB39 AC3D CC3D CB39 8A3D 8AFE 398A"
	$"FE35 694E 398A 3D8B 398B 398A 398A 3569"
	$"41CC 45EC 41CB 3DAB 398A 3549 3149 356A"
	$"3DAB 3DAB 39AA 3DAB 39AB 39AB 398A 3DAB"
	$"398A 3DAB 398A 398A 41CC 45ED 39AB 3169"
	$"3169 39AB 358A 2D48 2928 3149 356A 3169"
	$"3149 398A 39AB 3DAB 398A 398A 3569 3148"
	$"398A 3DAB 3DCB 398A 3DAA 3D8A 3DAA 3DAA"
	$"3569 3148 3148 2D27 2927 2D28 2D48 2927"
	$"2927 3169 398A 356A 358A 358A 3168 3169"
	$"358A 3569 398A 398A 41AB 41CB 41CC 3989"
	$"2D06 FE24 E507 20E6 2527 2907 2928 2D28"
	$"2D48 2927 2906 FE25 0609 2D48 2D48 2D28"
	$"3149 356A 358A 3569 3569 398A 39AB FE39"
	$"8A25 3969 398A 3569 3568 398A 3D8A 3989"
	$"3569 398A 41AB 41AA 3DAA 3D89 3969 3D8A"
	$"3989 3148 3148 3549 3149 3569 2D27 28E6"
	$"2906 3569 24E5 1461 2D07 3549 1C83 24C5"
	$"24C5 1CA3 1040 1040 0C20 1041 0C20 FD08"
	$"2000 0C41 FE04 0009 0821 0C42 0C41 0C62"
	$"0C42 0C42 0841 0421 0400 0000 FE04 0004"
	$"0420 0820 0821 0841 0C41 00FF"
};

resource 'PICT' (32236) {
	38054,
	{0, 0, 96, 139},
	$"0011 02FF 0C00 FFFE 0000 0048 0000 0048"
	$"0000 0000 0000 0060 008B 0000 0000 00A1"
	$"01F2 0016 3842 494D 0000 0000 0000 0060"
	$"008B 4772 8970 68AF 626A 0001 000A 0000"
	$"0000 0060 008B 009A 0000 00FF 822C 0000"
	$"0000 0060 008B 0000 0004 0000 0000 0048"
	$"0000 0048 0000 0010 0020 0003 0008 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0060"
	$"008B 0000 0000 0060 008B 0040 012C 047A"
	$"7978 7A7C FE7D 057E 7F80 7F80 81F9 82FD"
	$"8106 7F7C 7C7F 8D97 98FD 9903 9A9B 9C9D"
	$"FD9C F69D F29C 1E9B 9A9A 9996 9694 978C"
	$"5C44 5352 5E5B 4333 3436 3E41 5172 8A8E"
	$"9390 9396 9595 F596 0D95 8E8B 8C8B 8A89"
	$"8786 8583 8281 8007 7F7E 7D7B 7978 7775"
	$"FE74 0484 8382 8486 FE87 0588 898A 898A"
	$"8BF9 8CFD 8B06 8886 8689 97A1 A3FD A403"
	$"A5A6 A7A8 FDA7 F6A8 F2A7 1EA6 A4A4 A3A0"
	$"A09E A195 654D 5C5B 6764 4C3C 3D3F 4749"
	$"597B 9498 9D9B 9EA1 A0A0 F5A1 02A0 9995"
	$"1295 9493 9290 8F8E 8B8A 8988 8786 8584"
	$"8382 817F FE7E 046C 6B6A 6C6E FE6F 0570"
	$"7172 7172 73F9 74FD 7306 726F 6E6F 7D85"
	$"85FD 8603 8788 898A FD89 F68A EF89 1B88"
	$"8584 8387 7F50 3847 4652 4E39 2C2C 2E36"
	$"3948 6979 7D80 7C7E 7F7D 80FD 83FE 83FC"
	$"7F15 7E77 7678 7776 7573 7271 7372 7170"
	$"6F6E 6D6C 6B6A 6967 FE66 0131 0177 79FE"
	$"7BFF 7D06 7C7E 7E7F 7F80 81F9 82FD 8106"
	$"827C 787C 8D97 98FD 9903 9A9B 9C9D FD9C"
	$"F69D F29C 1F9B 9A9A 9995 9094 7B66 3C48"
	$"4047 372E 2E40 444C 3635 3A52 6D82 8389"
	$"9192 9293 97F6 960D 958E 8B8D 8B8B 8987"
	$"8685 8382 8180 0780 7F7E 7C7A 7978 76FE"
	$"7401 8183 FE85 FF87 0686 8888 8989 8A8B"
	$"F98C FC8B 0586 8286 97A1 A3FD A403 A5A6"
	$"A7A8 FDA7 F6A8 F2A7 1FA6 A5A4 A39F 9A9E"
	$"846D 434F 474E 3E36 3546 4A52 3C3B 4058"
	$"758B 8C93 9C9D 9D9E A2F6 A102 A099 9512"
	$"9694 9492 908F 8E8B 8A89 8888 8786 8584"
	$"8382 80FE 7E01 696B FE6D FF6F 066E 7070"
	$"7171 7273 F974 FD73 0675 6F6A 6D7D 8585"
	$"FD86 0387 8889 8AFD 89F6 8AF2 891F 8887"
	$"8988 8581 856C 582F 3B33 3A2A 2124 383C"
	$"442E 2E32 4961 7674 777E 7C7A 7E84 FE83"
	$"FE83 FC7F 157E 7776 7977 7775 7372 7173"
	$"7271 7070 6F6E 6D6C 6B6A 68FE 6601 4606"
	$"7778 787B 7D7E 7FFA 7E00 80F5 810A 7F79"
	$"7F8F 9596 9999 9A9B 9BFA 9AF6 9C01 9A9B"
	$"FC9C 069B 9A9B 9B9A 9899 FE9B 2098 9595"
	$"917A 504D 373F 3D35 2727 3B47 4749 3A37"
	$"3137 4858 5E79 8489 9192 9893 9497 FA96"
	$"FF97 038C 8D8C 8BFE 8905 8786 8484 8282"
	$"1180 7F7E 7C7A 7978 7877 7675 8182 8285"
	$"8788 89FA 8800 8AF6 8B0B 8A89 8389 99A0"
	$"A1A4 A4A5 A6A6 FAA5 F6A7 01A5 A6FC A706"
	$"A6A5 A6A6 A5A3 A4FE A620 A29F 9F9B 8459"
	$"533B 4441 392C 2C40 4B4B 4D3E 3B35 3B51"
	$"6167 838E 949C 9DA3 9E9F A2FA A1FF A2FF"
	$"97FF 94FE 9217 908F 8C8C 8A8A 8887 8685"
	$"8483 8282 8180 7F69 6A6A 6D6F 7071 FA70"
	$"0072 F673 0B75 726B 6F7E 8383 8686 8788"
	$"88FA 87F6 8901 8788 FC89 2A88 8788 8887"
	$"8586 8887 8887 8587 846F 4641 2A32 3028"
	$"1A1A 303D 3D40 302D 272D 404E 526A 7477"
	$"7D7E 8580 8184 FE83 FD7F FF80 0374 7778"
	$"77FE 7510 7372 7474 7272 706F 6E6D 6C6B"
	$"6A6A 6968 6701 3A05 7778 787A 7C7D FC7E"
	$"FE80 F481 0A7F 797F 8F95 9699 999A 9B9B"
	$"FA9A F69C 029A 999B FB9C FD9B 2499 979A"
	$"9A98 9B93 7A47 302D 292D 2E20 2D2C 2D2A"
	$"313E 352B 262B 2C2D 3142 5976 8895 9694"
	$"9397 FA96 FF97 038C 8D8C 8BFE 8905 8786"
	$"8484 8282 1081 807F 7C7A 7978 7877 7675"
	$"8182 8284 8687 FC88 FE8A F58B 0B8A 8983"
	$"8999 A0A1 A4A4 A5A6 A6FA A5F6 A702 A5A4"
	$"A6FB A7FD A624 A4A2 A5A5 A2A5 9D83 5038"
	$"312D 3132 2431 3031 2D35 4239 2F2A 2F34"
	$"353B 4B63 8092 9FA1 9F9E A2FA A1FF A2FF"
	$"97FF 94FE 9216 908F 8C8C 8A8A 8988 8785"
	$"8483 8282 8180 7F69 6A6A 6C6E 6FFC 70FE"
	$"72F5 730B 7572 6B6F 7E83 8386 8687 8888"
	$"FA87 F689 0287 8688 FB89 FD88 2486 8486"
	$"8587 8C86 703F 2922 1E22 2315 2221 221E"
	$"2633 2A20 1A20 2222 2736 4D68 7A84 8281"
	$"8084 FE83 FD7F FF80 0374 7778 77FE 7510"
	$"7372 7474 7272 7170 6F6D 6C6B 6A6A 6968"
	$"6701 4706 7778 7979 7B7C 7DFD 7EFE 80F4"
	$"810A 7F79 7F8F 9596 9999 9A9B 9BFA 9AF6"
	$"9C02 9B95 9BFD 9CFF 9D27 9A99 9897 999B"
	$"9896 9595 7746 231F 2826 2B26 1D38 2D1F"
	$"1F25 2726 2425 2320 2222 1C26 4372 9494"
	$"9593 F996 FF97 038C 8D8C 8BFE 8905 8786"
	$"8484 8282 1182 8180 7D7A 7978 7877 7675"
	$"8182 8284 8586 87FD 88FE 8AF5 8B0B 8A89"
	$"8389 99A0 A1A4 A4A5 A6A6 FAA5 F6A7 02A5"
	$"A0A6 FDA7 FFA8 27A5 A4A3 A2A4 A6A3 A19F"
	$"9F80 4F2B 262A 292D 2820 3A2F 2222 282A"
	$"2927 2826 292B 2B25 2F4C 7B9E 9FA0 9EF9"
	$"A1FF A2FF 97FF 94FE 9203 908F 8C8C FE8A"
	$"1089 8886 8483 8282 8180 7F69 6A6B 6B6D"
	$"6E6F FD70 FE72 F573 0B75 726B 6F7E 8383"
	$"8686 8788 88FA 87F6 8902 8882 88FD 89FF"
	$"8A28 8786 8584 8689 8381 8486 6B3E 1D1A"
	$"1D1C 201B 132D 2312 0F15 1716 1415 1314"
	$"1616 121D 3B6B 8780 8280 83FE 83FD 7FFF"
	$"8003 7477 7877 FE75 0373 7274 74FE 7209"
	$"7170 6E6C 6B6A 6A69 6867 014C 0677 7879"
	$"797A 7C7C FA7E 0080 F581 0A7F 797F 8F95"
	$"9699 999A 9B9B FA9A F79C 049D 9B92 9A9B"
	$"FD9C 289A 9796 958D 9094 8D94 9388 4C24"
	$"1523 2621 1E13 1E23 1916 1B16 1A1E 191A"
	$"171B 2123 261B 1338 7497 9594 F996 FF97"
	$"038C 8D8C 8BFE 8905 8786 8484 8282 1183"
	$"8281 7D7A 7978 7877 7675 8182 8383 8485"
	$"86FA 8800 8AF6 8B0B 8A89 8389 99A0 A1A4"
	$"A4A5 A6A6 FAA5 F7A7 04A8 A69D A5A6 FDA7"
	$"28A6 A3A1 A099 9C9F 989F 9C92 552C 1D2B"
	$"2823 2015 2024 1B18 1D18 1D22 1C1C 1A24"
	$"2A2C 2E23 1B3F 7DA2 A09F F9A1 FFA2 FF97"
	$"FF94 FE92 1790 8F8C 8C8A 8A8B 8A89 8684"
	$"8382 8281 807F 696A 6B6B 6C6D 6EFA 7000"
	$"72F6 730B 7572 6B6F 7E83 8386 8687 8888"
	$"FA87 F789 048A 877F 8788 FD89 2987 8483"
	$"827A 7D81 787F 8279 401C 0F1F 1B16 1409"
	$"1317 0F07 0804 080D 0707 050C 1317 1C13"
	$"0C35 6984 8281 8202 8283 83FD 7FFF 8003"
	$"7477 7877 FE75 1073 7274 7472 7273 7271"
	$"6E6C 6B6A 6A69 6867 0190 0374 7374 7BFD"
	$"7D0A 7E7F 807C 7D7E 7F7F 8081 81FE 80FD"
	$"820B 7F80 7B7E 9097 9897 9899 9C9B FC99"
	$"FF9B 039A 9B9D 9DFE 9CFF 9DFF 9B21 9794"
	$"9597 9697 9796 9695 9696 8F79 8184 8A8F"
	$"762D 171B 2726 2516 181C 1412 161A 151A"
	$"FE1D 0F1C 2325 2831 2921 1C3B 7D94 9592"
	$"9395 97FD 9605 9894 8C8B 8B8A FE88 0586"
	$"8586 8582 80FF 80FE 7E05 7C7A 7876 7575"
	$"FE82 0084 FE82 FF83 FF85 0786 8788 8989"
	$"8A8B 8BFE 8AFD 8C0B 888A 8588 9AA2 A3A2"
	$"A3A4 A7A6 FCA4 FFA6 03A5 A6A8 A8FE A7FF"
	$"A8FF A606 A5A3 A3A5 A4A5 A4FC A328 9C87"
	$"8E8F 9197 7E35 1F24 2E25 2315 161A 1211"
	$"1415 1015 1919 1819 2529 2B34 2B24 1D42"
	$"8BA2 A39E 9F9E A0FD A103 A39F 9796 0196"
	$"95FE 9304 9190 908F 8CFE 8A08 8987 8584"
	$"8280 7F7E 7DFE 69FC 6C0A 6E6F 6F6E 6F70"
	$"7171 7273 73FE 72FD 74FF 7309 6D6F 8085"
	$"8584 8586 8988 FC86 FF88 0387 888A 8AFE"
	$"89FF 8A33 8988 7F7C 7F82 8184 8684 8382"
	$"8383 7C66 6D74 7D80 671E 070A 1617 1708"
	$"090D 0504 0302 0001 0505 0405 1215 1823"
	$"1D16 1032 7585 8079 037B 8085 80FE 7F05"
	$"817D 7576 7877 FE75 0473 7277 7673 FE71"
	$"0870 6F6D 6C6A 6867 6665 0189 FF73 0271"
	$"777C FE7B 047C 7D7D 7B7B FE7D 007E FC7F"
	$"FD81 0B7F 7E78 7E91 9798 9696 989B 9BFC"
	$"99FF 9B03 9A9B 9D9D FD9C 069B 9A99 9596"
	$"9295 FE99 2998 9792 9298 7C6C 646F 6E65"
	$"5E30 201F 2128 1C12 1B15 1213 1412 1317"
	$"1A1C 2021 2122 2129 2829 2610 3174 94FE"
	$"9500 94FD 9605 9894 8C8B 8B8A FE88 0086"
	$"FE85 0183 82FF 80FE 7E09 7C7A 7878 7776"
	$"8181 7F81 FD82 0483 8485 8586 FE87 0088"
	$"FC89 FD8B FF88 0982 889A A2A3 A1A1 A3A6"
	$"A6FC A4FF A603 A5A6 A8A8 FDA7 37A6 A5A4"
	$"A0A3 9EA1 A5A5 A4A3 A29C 9DA3 8777 6F77"
	$"746B 6536 2725 2726 190F 1813 1011 110F"
	$"1014 1719 1C1F 2425 242B 2A2B 2817 3D80"
	$"9FA0 A09F 9DFD A103 A39F 9796 0196 95FE"
	$"9314 9190 8F8E 8D8C 8A8A 8987 8584 8280"
	$"807F 7E69 6967 6AFD 6B04 6C6D 6E6D 6EFE"
	$"6F00 70FC 71FC 730A 706A 6F80 8585 8383"
	$"8588 88FC 86FF 8803 8788 8A8A FD89 3488"
	$"8785 7C7E 7B7F 8486 8888 8782 8388 6D5C"
	$"5460 6157 4F20 110F 111B 0E05 0E08 0506"
	$"0300 0002 0508 0B0D 0F10 1017 1718 1504"
	$"2866 7F7D 027F 8181 FD7F 0581 7D75 7678"
	$"77FE 7510 7372 7676 7473 7171 706F 6D6C"
	$"6A68 6867 6601 9804 6C72 7075 7AFE 790A"
	$"7A7B 7C7A 7B7C 7B7A 7B7C 7DFE 7EFF 80FE"
	$"7F0A 7C76 7E91 9798 9695 989A 9AFC 99FF"
	$"9B03 9A9B 9D9D FE9C 079B 9A99 9797 999A"
	$"97FE 9816 9B94 8C8D 723D 3F3B 545E 494E"
	$"3424 1917 180D 0D10 1212 0EFE 0F13 0E10"
	$"1418 1C1C 1F20 201C 1F1E 1314 4185 9496"
	$"9793 FD96 0598 948C 8B8B 8AFE 8805 8685"
	$"8383 8484 FF80 FE7E 007C FE79 1478 777A"
	$"807F 8182 8281 8283 8485 8485 8685 8485"
	$"8687 FE88 FF8A FF89 0B88 8680 889B A2A3"
	$"A1A0 A3A5 A5FC A4FF A603 A5A6 A8A8 FEA7"
	$"21A6 A5A4 A2A3 A4A4 A1A2 A1A2 A49C 9495"
	$"7A46 4844 5A62 4D51 3827 1C1A 150A 0A0D"
	$"0F0F 0BFD 0C12 0D10 1519 1D21 2222 1F21"
	$"2018 1C49 8E9F A1A2 9EFD A103 A39F 9796"
	$"0196 95FE 930B 9190 8D8D 8E8E 8A8A 8987"
	$"8584 FE81 0580 7F63 6968 69FD 6A0A 6B6C"
	$"6D6C 6D6E 6D6C 6D6E 6FFE 70FF 720D 7172"
	$"726E 686E 8085 8583 8285 8787 FC86 FF88"
	$"0387 888A 8AFE 8922 8887 8684 8081 8481"
	$"8385 878D 8880 8165 3133 2F46 4F3A 3F26"
	$"160C 0A0D 0303 0606 0703 02FE 0004 0103"
	$"080B 0AFE 0C07 090B 0902 0631 7380 0282"
	$"8480 FD7F 0581 7D75 7678 77FE 750B 7372"
	$"7474 7575 7171 706F 6D6C FE69 0168 6701"
	$"9510 6A71 7174 7677 7776 7777 7878 7B7C"
	$"7A7A 7BFE 7CFE 7DFF 7EFF 7F13 7774 7F90"
	$"9696 9595 9799 999A 9899 9A9A 9B9B 9A9B"
	$"FC9C 429A 9998 979E 9D9F 9B92 8F8E 7D67"
	$"5C4E 2B18 1F22 323B 3D30 2418 0E0E 0C09"
	$"0E0C 0A08 0709 0807 060A 0B0B 0C10 1519"
	$"1C1D 1D18 1915 2363 8D93 9594 9596 9697"
	$"9894 8E8C 8A8A FE88 0586 8584 8384 83FF"
	$"8111 807E 7E7D 7B7A 7978 777B 8281 8281"
	$"8283 8282 FE83 0485 8684 8485 FE86 FE87"
	$"FF88 1589 8881 7E89 9AA0 A1A0 A0A2 A4A4"
	$"A5A3 A4A5 A5A6 A6A5 A6FC A740 A5A4 A3A2"
	$"A6A4 A6A2 9996 9483 6D61 5330 1E25 2736"
	$"3E3F 3326 1910 0F08 050B 0807 0503 0607"
	$"0705 090A 0A0C 1015 191D 1D1E 191B 1827"
	$"6996 9EA1 A0A0 A1A1 A2A3 9F99 97FF 95FE"
	$"9315 9190 8E8D 8E8D 8B8B 8A87 8685 8382"
	$"8180 7F64 6A6B 6A69 FC6A FF6B 046D 6E6C"
	$"6C6D FE6E FE6F FF70 1571 7369 6670 7F84"
	$"8382 8284 8686 8785 8687 8788 8887 88FC"
	$"8920 8786 8584 8485 8885 7D7C 7B6F 5D51"
	$"4320 0E15 1725 2E30 241A 0E05 0603 0106"
	$"0402 01FA 00FF 010B 0203 0608 0807 0205"
	$"0311 527B 0C81 8382 7E7F 7F80 817D 7677"
	$"7877 FE75 1073 7275 7475 7472 7271 6F6E"
	$"6D6B 6A69 6867 018A 066A 6E6E 7074 7576"
	$"FD75 1877 7B7B 7A7A 7C7D 7C7B 7C7D 7C7D"
	$"7E7F 8072 7681 8E94 9493 9597 FE99 0197"
	$"99FA 9A00 9BFE 9CFF 9B1C 9799 9F9E 9894"
	$"7E72 613F 3229 1F1B 1E1D 1C21 2521 1811"
	$"0904 0406 090C 0AFE 0600 05FE 041C 0304"
	$"0505 0B0E 1317 1A1C 201E 1917 2F70 9693"
	$"9295 9596 9797 948E 8C8A 8AFE 8805 8685"
	$"8584 8382 1182 8180 7F7E 7D7C 7A78 7876"
	$"7D81 8180 8081 82FD 8118 8285 8584 8486"
	$"8786 8586 8786 8788 8989 7C80 8B98 9E9F"
	$"9EA0 A2FE A401 A2A4 FAA5 00A6 FEA7 FFA6"
	$"1CA2 A4A6 A49E 9A84 7866 4435 2D23 1F22"
	$"2020 2327 2219 1209 0404 0305 0806 FE02"
	$"FE03 1B04 0303 0505 080B 1015 171B 1F1D"
	$"1917 3276 A09F 9FA0 A0A1 A2A2 9F99 97FF"
	$"95FE 9317 9190 8F8E 8D8C 8C8B 8A88 8685"
	$"8482 8080 7E68 6C6C 6968 6A6A FD69 186A"
	$"6D6D 6C6C 6E6F 6E6D 6E6F 6E6F 7071 7464"
	$"6871 7E82 8080 8284 FE86 0184 86FA 8700"
	$"88FE 89FF 8816 8486 8786 807F 6A5F 4F30"
	$"261D 130F 1311 1014 1615 0E09 03FE 0002"
	$"0306 04F4 0009 0304 0405 0707 0505 1F60"
	$"0C85 8180 7E7E 7F80 807D 7677 7877 FE75"
	$"1073 7276 7574 7373 7271 6F6E 6D6C 6A68"
	$"6866 017F 0668 6A6C 6E73 7475 FD74 1876"
	$"7A7A 7979 7B7C 7B7B 7C7D 7C7D 7E7F 7F73"
	$"7980 8E94 9493 9597 FE99 0197 99FA 9A00"
	$"9BFD 9C16 9997 9D99 8E89 6B4A 392B 1F23"
	$"1F1A 1E1E 1D15 1419 0F0A 06FE 0202 0307"
	$"06FD 0300 02FE 01FF 001A 0103 080A 0E10"
	$"1316 1A1A 1B19 1942 829E 8F94 9596 9797"
	$"948E 8C8A 8AFE 8805 8685 8584 8382 1182"
	$"8180 7F7E 7D7C 7B79 7878 7B7E 7F7E 8081"
	$"82FC 81FF 84FF 8313 8586 8585 8687 8687"
	$"8889 887D 838A 989E 9F9E A0A2 FEA4 01A2"
	$"A4FA A500 A6FD A716 A4A3 A89E 928E 704F"
	$"3D2F 2326 211D 2221 2119 1519 0E08 04FD"
	$"0001 0302 F700 FF01 1603 0509 0D10 1418"
	$"1716 1518 468C AB9E 9FA0 A1A2 A29F 9997"
	$"FF95 FE93 1791 908F 8E8D 8C8C 8B8A 8886"
	$"8584 8381 8080 686A 6D69 6769 69FD 6818"
	$"696C 6C6B 6B6D 6E6D 6D6E 6F6E 6F70 7173"
	$"656B 717E 8280 8082 84FE 8601 8486 FA87"
	$"0088 FD89 1486 848A 8176 7456 3627 190F"
	$"140F 0B10 0F0F 0705 0A02 FE00 0401 0200"
	$"0302 F500 FF01 0902 0100 0103 0304 0509"
	$"340C 748E 7D7D 7E7F 8080 7D76 7778 77FE"
	$"7510 7372 7675 7473 7372 716F 6E6D 6C6B"
	$"6968 6801 8106 6A69 6D6D 7273 73FE 7206"
	$"7175 7979 7878 7AFE 7B0F 7C7D 7C7D 7E7F"
	$"7E7A 777F 8F94 9493 9597 FE99 0197 99FA"
	$"9A00 9BFE 9C19 9B97 9791 8985 6D37 251A"
	$"1215 1C1A 171B 1A1C 1813 140F 0A05 0504"
	$"FC03 FE04 0003 FE01 FE00 1902 080A 0B0F"
	$"1112 1214 1515 111B 458E 9393 9596 9797"
	$"948E 8C8A 8AFE 8805 8685 8584 8382 1182"
	$"8180 7F7E 7D7C 7C7B 7979 7D7D 817E 8081"
	$"81FC 80FF 83FF 8200 84FE 850F 8687 8687"
	$"8889 8783 8189 999E 9F9E A0A2 FEA4 01A2"
	$"A4FA A500 A6FE A718 A6A2 A29B 8E89 713B"
	$"291E 1519 201C 1A1F 1D1F 1C13 110D 0701"
	$"01F8 00FD 01FF 00FF 0116 0001 0409 0C0D"
	$"0E0D 0D0F 0F1E 4F9C A39F A0A1 A2A2 9F99"
	$"97FF 95FE 9317 9190 8F8E 8D8C 8C8B 8A88"
	$"8685 8484 8381 816B 6A6F 6866 6868 FD67"
	$"0568 6B6B 6A6A 6CFE 6D0F 6E6F 6E6F 7071"
	$"726C 696F 7E82 8080 8284 FE86 0184 86FA"
	$"8700 88FE 891E 8884 847E 726E 5822 1108"
	$"0105 0C09 060A 080B 0602 0401 0000 0104"
	$"0503 0201 01FA 02FE 01FE 0301 0402 FC00"
	$"0202 0310 0C38 7F81 7C7E 7F80 807D 7677"
	$"7877 FE75 1073 7276 7574 7373 7271 6F6E"
	$"6D6C 6C6B 6969 0186 0470 6F71 7072 FD74"
	$"FF75 0076 FE79 FF7A FE7B 037C 7D7C 7CFE"
	$"7E0D 7D75 8090 9593 9395 9798 9899 9798"
	$"F79A FF9B 1E99 9783 785D 3C23 1613 100E"
	$"0F10 0F14 1618 1A18 130F 0A06 0504 0507"
	$"0404 0504 FE03 0202 0102 FE00 1001 0708"
	$"090B 0D0F 1111 0E0B 0707 145F 9697 FE95"
	$"0596 948D 8C8A 8AFE 8805 8786 8584 8382"
	$"0F82 8180 7F7E 7D7C 7C7B 7979 7F7E 807E"
	$"7EFD 80FE 8104 8283 8384 84FE 8504 8687"
	$"8686 88FE 870C 7F8A 9AA0 9E9E A0A2 A3A3"
	$"A4A2 A3FA A500 A6FD A719 A3A1 8C7A 5E3D"
	$"2417 1410 0F0F 1010 1416 191A 1711 0D06"
	$"0100 0001 FA00 FB01 FF02 1600 0102 0407"
	$"0A0C 0C08 0707 0919 69A0 A2A0 A1A1 A29F"
	$"9897 FF95 FE93 2192 918F 8E8D 8C8C 8B8A"
	$"8887 8685 8584 8282 6968 6B67 6567 6867"
	$"6868 6969 6A6B 6B6C 6CFE 6D14 6E6F 6E6E"
	$"7070 7270 6770 7F83 7F80 8284 8585 8684"
	$"85FA 87FE 88FF 8909 8583 6F65 4A2A 1205"
	$"0301 FD00 0E03 0507 0907 0401 0000 0102"
	$"0302 0102 FE04 0105 04FE 02FF 01FF 02FF"
	$"0502 0402 00FE 0103 0001 0000 0509 558A"
	$"847F 7EFE 7D03 7778 7877 FE75 1074 7376"
	$"7574 7373 7271 6F6E 6D6C 6C6B 6A69 0172"
	$"FF75 FF74 0973 7576 7677 7879 7879 7AFB"
	$"7B0F 7C7D 7B7B 7D7D 7E7C 7581 9196 9192"
	$"9596 FC97 FA99 0F98 9697 9795 9791 6840"
	$"2C23 170F 1010 0FFC 0E14 0F11 110E 0C0B"
	$"0A0A 0C0D 0B08 0908 0403 0101 0200 01FD"
	$"0014 0405 0606 070A 0B0D 0D0B 0906 0020"
	$"759A 9692 9195 93FE 8B01 8A89 FD87 0385"
	$"8483 820A 8281 807E 7D7C 7B7B 7A79 78FE"
	$"7EFF 7D08 7F80 8081 8283 8283 84FB 8503"
	$"8687 8585 FE87 0886 7F8B 9BA0 9D9D A0A1"
	$"FCA2 FAA4 FDA5 FFA1 099A 6F3E 2A21 140D"
	$"0E0E 0DFE 0CFF 0B0D 0D0E 0F0C 0A07 0505"
	$"0607 0201 0202 FB00 0B01 0203 0304 0000"
	$"0102 0407 08FD 0A0B 0802 257A A4A1 9E9D"
	$"A19E 9696 0296 9594 FD92 108F 8E8D 8C8C"
	$"8B8A 8887 8685 8584 8382 6666 FE65 0867"
	$"6868 696A 6B6A 6B6C FB6D 0F6E 6F6D 6D6F"
	$"6F72 6E67 7180 847E 7F82 83FC 84FA 860C"
	$"8584 8485 8484 7E55 311E 1508 00FE 01FD"
	$"000D 0102 0203 0200 0001 0203 0300 0001"
	$"FD02 0001 FA00 0504 0303 0100 00FC 0100"
	$"000D 001B 6F8A 827B 777B 7C77 7978 7776"
	$"FD74 0E76 7574 7373 7271 6F6E 6D6C 6C6B"
	$"6A69 0173 FD73 0974 7576 7677 7879 7879"
	$"7AFB 7B0F 7C7D 7B7B 7D7E 7A78 7780 9193"
	$"9294 9496 FC97 FA99 0F96 9495 9793 9277"
	$"3110 100C 0C0F 0F0C 0BFE 0C00 0BFE 0A11"
	$"0706 0A0C 1119 1E1E 1C19 1A17 0F10 0809"
	$"0501 FC00 1404 0506 0608 090C 0C0E 0A07"
	$"0901 0025 7B9A 9794 9593 FE8B 018A 89FD"
	$"8703 8584 8382 0A82 8180 7E7D 7C7B 7B7A"
	$"7978 FD7D 097E 7F80 8081 8283 8283 84FB"
	$"850F 8687 8585 8788 8382 818A 9B9E 9D9F"
	$"9FA1 FCA2 F9A4 FEA3 0A9D 9A7E 360E 0E0A"
	$"0A0D 0D0A FD09 FE08 2E07 0505 0808 0C14"
	$"1715 110F 110F 080B 0406 0400 0102 0303"
	$"0400 0002 0204 0709 090A 0808 0A04 052B"
	$"85A4 A2A0 A29E 9696 0296 9594 FD92 0E8F"
	$"8E8D 8C8C 8B8A 8887 8685 8584 8382 FD65"
	$"0966 6768 6869 6A6B 6A6B 6CFB 6D0F 6E6F"
	$"6D6D 6F70 6E6A 6971 8181 7E81 8183 FC84"
	$"FA86 0E84 8282 8381 8166 1F01 0301 0001"
	$"0100 FB01 FE00 0F01 0202 0308 0B09 0404"
	$"0707 0003 0002 03FB 000B 0102 0201 0102"
	$"0302 0201 0102 FF00 0B20 6D88 817C 7C7B"
	$"7678 7877 76FD 740E 7675 7473 7372 716F"
	$"6E6D 6C6C 6B6A 6901 73FD 7209 7475 7676"
	$"7778 7978 797A FB7B 0F7C 7D7B 7B7D 7E79"
	$"7577 8191 9292 9494 96FC 97FA 990E 9896"
	$"9799 9579 5019 0E0C 0C09 0C0C 0BFB 0A15"
	$"0807 080D 1013 1F27 2F33 2F2C 2C29 1C1E"
	$"1416 0F05 0001 FE00 1404 0506 0505 070A"
	$"0C09 0907 0407 0200 4E8E 9794 9693 FE8B"
	$"018A 89FD 8703 8584 8382 0A82 8180 7E7D"
	$"7C7B 7B7A 7978 FD7C 097E 7F80 8081 8283"
	$"8283 84FB 850F 8687 8585 8788 827F 818B"
	$"9B9C 9D9F 9FA1 FCA2 F7A4 0BA3 9C7F 531B"
	$"0B09 0906 0909 08FB 072F 0504 0509 0A0C"
	$"181F 2527 201E 211E 1216 0C11 0C04 0001"
	$"0203 0200 0002 0101 0305 0806 0708 050A"
	$"0704 5798 A29F A29E 9696 0296 9594 FD92"
	$"0E8F 8E8D 8C8C 8B8A 8887 8685 8584 8382"
	$"FD64 0966 6768 6869 6A6B 6A6B 6CFB 6D0F"
	$"6E6F 6D6D 6F70 6C67 6971 8180 7F81 8183"
	$"FC84 FA86 0F83 8282 8584 683F 0902 0101"
	$"0001 0100 01FC 02FF 0010 0306 0402 070C"
	$"0E0F 0909 0C0B 0104 0006 07FC 000C 0100"
	$"0001 0100 0103 0300 0001 000D 0301 0044"
	$"8084 7D7E 7B75 7878 7776 FD74 0E76 7574"
	$"7373 7271 6F6E 6D6C 6C6B 6A69 0153 0370"
	$"7272 75FA 76FE 78FB 7901 7A7C FD7D 047B"
	$"7776 8390 FE95 FA96 FA99 FF98 0A9B 9897"
	$"5A2B 130C 0C0A 090B FE0C FE0B FF0A 1C0C"
	$"0B0D 1419 2433 3F45 4A42 3937 3731 2922"
	$"2015 0D09 0501 0201 0505 0404 FD05 FF07"
	$"1704 0212 1800 2F8A 9593 9893 8B8A 8988"
	$"8787 8685 8486 8584 830E 8281 807E 7D7C"
	$"7B7B 7978 797A 7C7C 7FFA 80FE 82FB 8301"
	$"8486 FD87 0784 8180 8D9A A0A1 A0FA A1FA"
	$"A4FF A30A A5A0 9E5E 2D14 0909 0706 08FE"
	$"09FE 08FF 0716 0908 090D 1119 262F 3438"
	$"3028 2728 241D 1718 0E08 0402 00FD 01FF"
	$"00FD 010E 0305 0404 151E 0236 939F 9EA4"
	$"9F97 9519 9493 9292 9190 8F90 8F8E 8D8C"
	$"8B8A 8887 8685 8583 8283 6264 6467 FA68"
	$"FE6A FB6B 016C 6EFD 6F07 6E69 6874 7F83"
	$"8282 FA83 FA86 0B83 8084 8486 4A1E 0802"
	$"0200 00FE 02FD 03FF 020A 0403 0405 0509"
	$"1016 1618 14FE 0D04 0B06 0007 05EF 0020"
	$"0E16 0028 8086 7E80 7B73 7576 7574 7473"
	$"7171 7776 7574 7372 716F 6E6D 6C6C 6A69"
	$"6A01 5E03 7072 7274 FE75 FD76 FE78 FB79"
	$"017A 7CFD 7D04 7B77 7683 90FE 95FE 9600"
	$"97FE 98F9 9907 9A99 9C8E 2E19 0A09 FE08"
	$"FE0A FC0B 1B0F 110E 1220 2D42 5362 6E6A"
	$"5C4B 3F41 413A 312A 201C 1A12 0B09 0603"
	$"03FB 04FF 0617 0300 0D2E 0F1A 8699 9398"
	$"938B 8A89 8887 8786 8584 8585 8483 0E82"
	$"8180 7E7D 7C7B 7B79 7879 7A7C 7C7E FE7F"
	$"FD80 FE82 FB83 0184 86FD 8707 8481 808D"
	$"9AA0 A1A0 FEA1 00A2 FEA3 F8A4 FFA3 0491"
	$"3019 0A06 FE05 FE07 FD08 1909 0C0E 0B0C"
	$"141F 323E 4954 4F47 372C 2E32 2A22 1D13"
	$"1010 0902 02FE 0000 01FC 000E 0103 0302"
	$"0F33 1321 8EA2 9EA3 9F97 9505 9493 9292"
	$"9190 FE8F 108E 8D8C 8B8A 8887 8685 8583"
	$"8283 6264 6466 FE67 FD68 FE6A FB6B 016C"
	$"6EFC 6F06 6968 747F 8382 82FE 8300 84FE"
	$"85FA 8607 8381 8288 7D1F 0D03 FA00 FD01"
	$"1702 0506 0502 030C 1B23 2A31 2A26 170C"
	$"1215 0E07 0703 0104 01F9 00FE 01FD 0020"
	$"0B2C 0E18 7E8B 8080 7B73 7476 7574 7473"
	$"7171 7676 7574 7372 716F 6E6D 6C6C 6A69"
	$"6A01 6B02 7072 73FD 74FD 76FE 78FB 7901"
	$"7B7C FC7B 0377 7683 90FE 95FE 9600 97FE"
	$"98F9 9909 9794 A273 110C 0708 0809 FD0A"
	$"FD0B 1D0D 0E0C 0B1A 3547 5E6F 7F8A 8271"
	$"6050 4743 423D 352D 2A2B 271D 1812 0505"
	$"04FC 03FF 05FE 02FF 270D 0F6A 9D94 9693"
	$"8B8A 8988 8787 8685 FE84 0183 810D 8281"
	$"807E 7D7C 7B7B 7978 797A 7C7D FD7E FD80"
	$"FE82 FB83 0185 86FD 8507 8481 808D 9AA0"
	$"A1A0 FEA1 00A2 FEA3 FAA4 0BA3 A19C A777"
	$"130A 0404 0505 06FE 0700 08FE 091D 0B0C"
	$"0A0A 1224 3448 535E 675D 5849 3B32 2F30"
	$"2C24 1A18 1C17 0E0A 0502 0201 FC00 0E01"
	$"0202 0305 2C2C 1672 A69E A19F 9795 0894"
	$"9392 9291 908F 8E8E FE8C 0C8B 8A88 8786"
	$"8585 8382 8362 6465 FD66 FD68 FE6A FB6B"
	$"016D 6EFD 6D07 6F69 6874 7F83 8282 FE83"
	$"0084 FE85 FA86 0A83 7E7B 8C62 0503 0100"
	$"0001 FD02 0001 FE00 FF01 1800 0101 0919"
	$"2932 3B41 3638 291B 1413 1410 0A03 0309"
	$"0803 0301 FC00 0201 0201 FD00 2000 2626"
	$"0E65 9383 7F7B 7374 7675 7474 7371 7175"
	$"7574 7273 7271 6F6E 6D6C 6C6A 696A 0160"
	$"0170 72FC 7303 7675 7676 FE78 FB79 017B"
	$"7CFC 7B03 7776 8390 FE95 FA96 F999 099C"
	$"999C 4703 080A 0909 0BFD 0C21 0B0A 0B0B"
	$"0C0A 0B17 2F50 6270 7A88 8984 776B 6156"
	$"5253 4C44 3F3A 3935 2C28 210D 0905 FC03"
	$"FF04 FF01 1500 112E 0A63 9994 9793 8B8A"
	$"8988 8787 8685 8484 8381 810C 8281 807E"
	$"7D7C 7B7B 7978 797A 7CFC 7D03 807F 8080"
	$"FE82 FB83 0185 86FD 8507 8481 808D 9AA0"
	$"A1A0 FAA1 FAA4 05A3 A5A0 A049 03FE 0606"
	$"0709 0A09 090A 0AFE 091D 0A07 0815 253B"
	$"4B56 5A62 5F5A 5A51 4840 3C3E 372F 2926"
	$"2622 1A16 1109 0602 FB00 FD01 0915 3311"
	$"6AA2 9EA2 9F97 9517 9493 9292 9190 8F8E"
	$"8D8C 8B8C 8B8A 8887 8685 8583 8283 6264"
	$"FC65 FD68 FE6A FB6B 016D 6EFD 6D07 6F69"
	$"6874 7F83 8282 FA83 FB86 0B87 8281 8187"
	$"3700 0103 0001 03FD 0400 02FB 0017 090D"
	$"1929 3334 3D39 3339 322A 221F 211C 130D"
	$"0C11 110C 0B07 FC00 0201 0302 FD00 2000"
	$"112F 0A5F 8F82 7F7B 7374 7675 7474 7371"
	$"7174 7473 7273 7271 6F6E 6D6C 6C6A 696A"
	$"0179 0D71 7374 7372 7271 7371 7170 7979"
	$"7AFD 7B0D 7A79 7B7B 797A 7B7C 7973 7584"
	$"8E92 FE94 0296 9797 FE96 FA97 0799 9D9A"
	$"7E1C 040B 0AFD 0928 0A0E 0F08 0408 0E10"
	$"1220 324F 6B75 8085 8884 847F 7A74 6E6C"
	$"6A62 564C 4440 3F3A 332C 1E15 0C06 0100"
	$"00FD 0109 0001 0720 1876 9597 9491 FE8A"
	$"0189 88FD 87FD 8001 807F FE7E 0E7D 7C7D"
	$"7B78 797B 7C7D 7D7C 7E7F 8080 FD7F FC80"
	$"1381 8485 8583 8485 8683 7D7F 8E98 9C9E"
	$"9EA0 A1A2 A2FE A1FA A207 A4A6 A081 1D04"
	$"0806 FD0B 240C 0F11 0A06 0708 0505 1021"
	$"3447 525B 5F5F 5A5A 5753 4F4B 4A48 4139"
	$"342E 2A2B 2821 1B11 0801 FE00 FF02 FE01"
	$"0B00 0106 201E 7FA0 A3A0 9D95 9402 9392"
	$"91FD 90FC 8D11 8C8B 8987 8685 8684 8182"
	$"6769 6A67 6467 686B FE6D FF69 FB6A 126C"
	$"6D6D 6B6C 6D6E 6B64 6675 7F83 8583 8183"
	$"8484 FE83 FA84 0785 8A8C 7517 0107 04FD"
	$"0028 0103 0401 0001 0403 0000 0A14 222C"
	$"3638 3731 3138 3430 2E2F 2D26 1E19 1412"
	$"1310 0C06 0200 0003 0301 00FD 0100 000D"
	$"0107 2016 6C83 8078 7977 7776 7574 F873"
	$"0972 716D 6A69 6869 6764 6501 7C0E 7172"
	$"7373 7272 6F73 6E6E 6F77 7977 78FC 790B"
	$"7A7B 797A 7B7C 7973 7584 8E92 FE94 0296"
	$"9797 FE96 F997 0699 8D51 080A 090A FD07"
	$"2808 0908 0507 0C0F 1223 3345 6176 7B81"
	$"878A 8789 8882 7C77 7472 6A5D 524B 4543"
	$"413B 352B 2013 0801 0000 FD01 0902 0403"
	$"0D1F 8B93 9394 91FE 8A01 8988 FD87 FD82"
	$"0C82 8180 7F7E 7D7C 7D7B 7879 7A7B FE7C"
	$"047E 7D81 7D7D FE80 017E 80FE 8113 8283"
	$"8485 8384 8586 837D 7F8E 989C 9E9E A0A1"
	$"A2A2 FEA1 FAA2 07A1 A293 5209 0A06 06FD"
	$"0826 090A 0907 070A 0807 1220 3144 5055"
	$"5B60 615C 5E5F 5B57 5250 4F47 3F38 3330"
	$"2D2E 2924 1B13 0801 00FA 010A 0403 0D27"
	$"949E 9FA0 9D95 9402 9392 91FD 90FC 8C18"
	$"8B8A 8887 8685 8684 8182 6768 6A67 6468"
	$"666C 6A6C 6E69 6A68 69FD 6A12 6B6C 6D6B"
	$"6C6D 6E6B 6466 757F 8385 8381 8384 84FE"
	$"83FA 8408 8387 8048 0407 0504 01FE 00FE"
	$"01FF 0017 0405 0207 0C17 232B 3035 3938"
	$"3235 3E3B 3734 3433 2C24 1D18 FE15 0911"
	$"0E08 0300 0203 0201 00FE 0100 020D 0403"
	$"0D1D 8180 7A79 7977 7776 7574 F873 0972"
	$"716D 6A69 6869 6764 6501 8301 6F71 FC72"
	$"066C 5C6B 6B6F 7977 FD79 0D78 7778 7A79"
	$"7A7B 7C7A 7375 848E 92FE 9402 9697 97FE"
	$"96FA 9707 9897 6517 0906 0708 FD03 2902"
	$"0103 0707 0D18 2439 5061 707C 7E82 8B8F"
	$"8D90 8E87 817D 7B78 7066 5E57 514D 4A44"
	$"3E33 2C1F 0D04 0200 00FE 0109 0203 0101"
	$"339E 9493 9391 FE8A 0289 8887 FE85 0383"
	$"8282 8319 8382 817F 7E7D 7C7D 7B78 7978"
	$"7A7B 7C7C 7E80 796B 7A7B 7882 8081 FE82"
	$"FF81 1182 8483 8485 8684 7D7F 8E98 9C9E"
	$"9EA0 A1A2 A2FE A1F9 A206 A06B 1A0A 0604"
	$"04FC 0328 0203 0706 080E 1424 3645 4F56"
	$"575A 6164 6164 635E 5A57 5654 4D47 433C"
	$"3834 332F 2923 1D11 0400 0100 00FE 010B"
	$"0203 0101 3AA7 9F9F A09D 9594 0393 9291"
	$"90FE 8EFC 8C17 8B8A 8887 8685 8684 8182"
	$"6567 6866 6467 6965 5869 6962 6B68 FD6A"
	$"FF69 116A 6C6B 6C6D 6E6B 6466 757F 8385"
	$"8381 8384 84FE 83F9 8403 8557 1005 FE03"
	$"FB00 FF02 2500 0105 0812 1E29 2D30 3132"
	$"383A 373A 3F3C 3735 3735 2F29 251F 1C1A"
	$"1915 0F07 0501 0001 0405 03FE 0100 020E"
	$"0301 012F 9381 7B78 7977 7776 7574 73FE"
	$"71FC 7009 6F6E 6C6A 6968 6967 6465 0184"
	$"0170 71FE 721C 7172 6566 6D6B 6B76 7578"
	$"7676 7777 7677 797A 7A7B 7C7A 7278 858F"
	$"9293 94FE 95F6 9707 988F 3D03 0503 0C06"
	$"FD01 2800 0103 0506 101F 374C 6873 7A82"
	$"8387 8C90 9296 928C 8886 8480 796E 6661"
	$"5A58 544D 4638 352C 170C 0602 FD01 0902"
	$"0302 0052 9F8F 9494 90FE 8A09 8988 8685"
	$"8786 8485 8483 FF84 2A83 807E 7D7B 7B7D"
	$"7A7A 797A 7B7B 7D7D 8072 757B 7B77 817F"
	$"8382 8182 8180 8183 8484 8586 847C 828F"
	$"999C 9D9E FEA0 F5A2 0697 4306 0603 0903"
	$"FD01 2900 0103 0503 0813 2332 4850 545B"
	$"5A5D 6265 6668 6762 5F5D 5E5C 544D 4842"
	$"3E3C 3B34 2D25 231C 0C04 0100 00FE 010B"
	$"0203 0200 5AA9 9AA0 A09C 9694 0693 9291"
	$"8F8E 908F FE8C FE8B 2D8A 8887 8684 8486"
	$"8383 6667 6866 6467 695E 626A 695F 6967"
	$"6B6A 696A 6968 696B 6C6C 6D6E 6B63 6976"
	$"8083 8483 8182 82F5 8406 7C30 0002 0008"
	$"03FD 0229 0102 0604 0000 0410 182B 2F30"
	$"3433 3438 3A3A 3E40 3D3A 3A3B 3832 2C28"
	$"2320 1F1E 1812 0707 0400 0103 0503 FE01"
	$"0002 2003 0200 4D95 7C7B 7879 7777 7675"
	$"7472 7173 726F 706F 6E6F 6E6D 6B6A 6967"
	$"6769 6666 0196 156E 6F70 7172 7070 6A6D"
	$"6F6C 6F76 7174 7577 7776 7677 79FE 7A07"
	$"7B79 7078 848E 9191 FD94 0096 FE97 FD96"
	$"FE97 079B 8444 0C00 0810 08FD 0129 0003"
	$"0304 0A18 2745 5F78 7E84 8888 8E93 9598"
	$"9A97 928F 8985 837F 756D 6962 5D5A 534D"
	$"3E39 3220 130A 0402 FE01 0903 0402 0058"
	$"9291 9194 8FFE 8AFF 8807 8586 837A 7879"
	$"7876 2077 7879 7574 7572 6E6E 6D72 7778"
	$"797B 7C7C 7E77 7C7D 7C7B 817D 8081 8383"
	$"8180 8183 FE84 0785 837A 828E 989B 9BFD"
	$"9F00 A1FE A2FD A1FE A207 A58C 4A0E 0008"
	$"0D04 FD01 0000 FE03 2504 0E19 2E40 5454"
	$"5A5F 5F63 6668 6A6B 6A67 6560 5E5D 5A51"
	$"4C48 433F 3D38 3228 241F 130A 0300 00FE"
	$"010B 0304 0100 5F9C 9C9D A09B 9594 2B92"
	$"9191 8E8F 8C83 7E7F 7E7C 7D7E 7F7D 7D7E"
	$"7B77 7776 7B64 6566 6564 6667 6369 6C6A"
	$"6469 6668 696A 6C6A 6869 6BFE 6C08 6D6A"
	$"6169 757F 8282 83FE 8100 83FE 84FD 83FE"
	$"8407 8771 3606 0004 0C03 FD02 0E01 0405"
	$"0200 0305 1422 3231 3437 3639 FE3D 123E"
	$"423F 3D3A 3938 352E 2927 2321 1F1A 1408"
	$"0604 FD01 0002 FE01 0003 2004 0200 5388"
	$"7E79 7877 7677 7574 7471 726F 6661 6261"
	$"5F60 6162 6060 615E 5A5A 595E 0182 0F6F"
	$"7071 7272 706F 7071 6C66 7074 7172 73FD"
	$"7600 78FD 7907 7A77 6F76 838E 9191 FD94"
	$"0095 FA96 FD97 0688 590B 0405 0806 FB01"
	$"0E02 060A 192F 5171 8288 8C8D 9095 9A9C"
	$"FE9E 159B 958F 8B87 827B 7671 6C67 6159"
	$"5447 4038 291A 1009 03FE 01FE 0206 0021"
	$"7E95 9093 8EFE 8909 8887 8587 7565 696B"
	$"6A68 1F6B 6764 635F 5B5E 6368 6065 7879"
	$"7A7B 7C7C 7D7D 807B 777D 817E 7F80 8384"
	$"8180 82FD 8307 8481 7980 8D98 9B9B FD9F"
	$"00A0 FAA1 FEA2 03A1 915F 0DFE 0500 02FD"
	$"010E 0001 0302 020E 1E37 4E57 575E 6365"
	$"6AFE 6E15 6F71 706A 6563 615C 5753 4F4B"
	$"4743 3A36 2F27 2219 0E06 FC01 FE02 0800"
	$"2887 A09C 9F9A 9493 FF91 2890 8E90 7E6D"
	$"6F71 6F6D 716D 6A6A 6864 676C 7169 6E65"
	$"6667 6564 6666 696D 6A64 6568 6666 686B"
	$"6B69 686A FD6B 086C 6860 6774 7F82 8283"
	$"FE81 0082 FA83 FE84 0783 764C 0401 0204"
	$"02FB 0023 0201 0001 0719 2C33 3237 3A3B"
	$"3F42 4241 4046 453F 3D3C 3A36 312F 2C29"
	$"2722 1C18 120C 0602 FE00 FD01 0002 FF02"
	$"1E00 1C73 8377 7776 7576 7474 7371 7361"
	$"5050 5250 4E51 4E4A 4C4B 474A 4F54 4C51"
	$"0188 0170 71FE 7210 706F 7071 665A 6C6F"
	$"7175 736F 7074 7778 79FE 78FF 7905 7078"
	$"848E 9191 FD94 FD95 FD96 FF97 0898 9297"
	$"6916 1102 0203 FD01 2A02 0001 080D 1D39"
	$"5E79 848E 8A8D 9197 9C9F A2A3 A2A0 9792"
	$"918D 8581 807A 7471 675D 5A4C 4740 2F22"
	$"160E 0600 FE01 0800 0202 0474 9C90 928D"
	$"FE88 0987 8685 876D 5F69 6B6A 680D 6D64"
	$"5E5B 5452 606A 575C 6479 7A7B FE7C FF7D"
	$"0D80 7469 797C 7E82 817D 7E80 8082 83FE"
	$"82FF 8305 7A82 8E98 9B9B FD9F FDA0 FDA1"
	$"FFA2 08A3 9C9F 6F17 1203 0001 FE02 2A01"
	$"0201 0204 0311 2540 5458 595A 6466 6B6F"
	$"7072 7475 746C 6768 655E 5C5B 5653 5047"
	$"3F3B 322D 2A1F 160D 0602 FD01 0A00 0103"
	$"0B7D A79C 9E99 9392 2B91 908F 8E90 7669"
	$"6F70 6E6D 7269 6262 5E5B 6973 6066 6E67"
	$"6869 6764 6666 696D 6357 6062 6468 6763"
	$"6467 696A 6BFE 6A08 6B6A 6169 757F 8282"
	$"83FA 81FD 83FF 8405 857E 845E 120D F700"
	$"FF01 2004 0D1F 2D30 3232 3A3C 4042 4244"
	$"4548 4941 3D3F 3C37 3636 312F 2D26 1E1D"
	$"1A16 0D03 FE00 FC01 2000 0203 0269 8877"
	$"7676 7576 7473 7271 7459 4C4F 504F 4D52"
	$"4942 4441 3F4C 5643 4951 0198 016C 6EFE"
	$"6FFF 700B 6D6C 5D54 6162 6B72 6D63 6670"
	$"FE79 FE78 0C79 7871 7984 8E91 9293 9494"
	$"9594 FE93 FE95 0996 9797 9892 996A 1C1A"
	$"04FD 03FE 01FF 0040 0610 2648 6C7E 878E"
	$"8A8D 919A 9FA2 A6A6 A9A4 9B94 928F 8D8B"
	$"8783 7D78 6D65 5E52 5249 372A 1F16 0D04"
	$"0502 0101 0304 0056 998D 918C 8787 8585"
	$"8484 876B 636C 6C67 681D 6B63 5E61 5F5D"
	$"6367 4C5D 6876 7778 7A7B 7B7C 7B7D 706A"
	$"7576 7D84 7F73 777E FE83 FE82 0983 827B"
	$"838E 989B 9C9E 9EFE 9FFE 9EFE A00A A1A2"
	$"A2A3 9DA3 7222 1D05 03FE 012D 0203 0301"
	$"0203 0919 314B 5658 5A5A 6063 696D 7072"
	$"7376 736B 6766 6564 625E 5A56 5249 423C"
	$"3134 2E25 1D15 0D06 0002 FD01 0803 025D"
	$"A297 9C96 9292 1790 8E8E 8D8F 7369 7070"
	$"6C6D 716A 6468 6664 6A6E 5464 7060 62FE"
	$"6310 6567 676A 5D57 6262 6A70 6A5E 6167"
	$"6A6B 6BFD 6A0B 6962 6A75 7F82 8383 8283"
	$"8483 FB82 0C83 8484 857F 865B 1313 0002"
	$"0101 FD00 2801 0303 0209 1627 2E31 3633"
	$"3539 4043 4548 484D 4A43 3E3D 3C3B 3C3A"
	$"3733 3129 221E 1D1C 1106 0201 0000 FE01"
	$"0002 FF01 1E02 004F 8A78 7772 7072 7170"
	$"6F6E 7054 4A4D 4D49 4B4E 4740 4849 464D"
	$"5036 4752 019D 156C 6D6E 6D6D 706F 6D69"
	$"5758 5B5A 646D 675B 6170 7A79 79FD 7805"
	$"7670 7984 8D91 FE92 0294 9594 FC93 FF95"
	$"FF96 0B97 9198 7527 1F12 0000 0504 01FE"
	$"0041 0107 1732 5676 838A 8C8D 8B8F 989E"
	$"9FA3 A7AB A59E 9992 8F8D 908F 8C84 7B75"
	$"6D65 5C5A 5042 362B 2016 0808 0201 0203"
	$"0400 2F8D 9091 8A88 8683 8483 8487 6C62"
	$"696C 676B 066B 6A67 6968 676A FE69 166A"
	$"7677 7879 7A7A 7B7A 7C71 7476 757D 847E"
	$"7075 7E84 8383 FD82 0580 7A83 8E97 9BFE"
	$"9C02 9D9F 9EFE 9DFF 9EFF A0FE A106 9FA5"
	$"7F31 2414 02FE 0001 0103 FE01 2904 0E22"
	$"3E53 595A 5B5C 5C60 656A 696C 7175 716C"
	$"6A67 6464 6562 605A 524D 4640 3738 322C"
	$"251E 160B 0002 01FE 0208 0100 3494 979A"
	$"9591 9111 908E 8E8C 8D71 676A 6D6B 6F70"
	$"7271 716F 6E71 FE70 1371 5D5E 5F60 6264"
	$"6566 685B 5F68 666E 746C 5D62 68FE 6BFD"
	$"6A05 6761 6A75 7E82 FE83 0285 8685 FE84"
	$"FF80 FF82 FF83 0984 7F84 631A 150C 0001"
	$"01FD 0028 0206 0404 0F1E 2C2F 353A 3731"
	$"363D 4242 454A 4F49 4541 3D3A 383E 403E"
	$"3933 2F28 2221 1F15 0C08 0603 01FE 0000"
	$"0400 02FE 0018 2B83 7E79 6F6B 6D6E 6D6B"
	$"6B6C 5147 474A 484C 4E4E 4C51 5352 55FE"
	$"5300 5401 9A15 6B6C 6D6C 6D70 6F6E 6A57"
	$"5D60 6065 6E67 5F66 7379 7877 FD78 0B76"
	$"6F78 828B 8F91 9192 9394 94FC 93FF 95FE"
	$"960A 9394 8A44 1A21 0101 0503 01FE 0029"
	$"020E 213E 627D 8B90 938F 8A8B 8E90 949A"
	$"9EA1 9F9E 9B95 908E 9194 8F87 807E 766E"
	$"6366 5D4A 3E31 261B 0906 FE02 1403 0500"
	$"0B7E 9990 8B89 8583 8483 8587 6A64 6769"
	$"6966 1C57 5B59 5759 5858 565A 5B56 7677"
	$"7879 7A7A 7B7B 7D70 787B 797D 847C 747A"
	$"FE82 0081 FD82 0B80 7982 8C95 999B 9B9C"
	$"9D9E 9EFE 9DFF 9EFF A0FE A1FF A013 944D"
	$"1F23 0200 0001 0103 0101 0307 142B 4659"
	$"6162 FE61 1F5F 6061 6468 6C70 706F 6E6C"
	$"6867 696A 6760 5A58 534B 3E43 3F32 2A21"
	$"180F 0101 00FE 0208 0100 1085 A199 9592"
	$"910E 908E 8D8D 8E70 6969 6B6D 6A5D 6363"
	$"5FFE 6015 5D62 625E 5F60 6161 6365 6667"
	$"695B 6368 6669 7066 5D62 FE6A 0069 FD6A"
	$"0B67 6069 737C 8082 8283 8485 85FE 84FF"
	$"80FF 82FE 83FF 8005 7937 111C 0002 FC00"
	$"2801 0303 0414 2532 383B 3F3D 3939 3B3C"
	$"3F44 484B 4A49 4743 3F3E 4245 423C 3838"
	$"312C 2629 2112 0C07 0201 FE00 0004 0002"
	$"FE00 1208 7388 7871 6E6D 6E6D 6B6C 6D50"
	$"484A 4D4E 4C40 FE45 FE49 0346 4B4B 4701"
	$"9415 696B 6C6B 6D70 6F6E 6B56 6266 6566"
	$"6D67 6A6B 7477 7677 FD78 0574 6E76 828A"
	$"8FFE 9001 9192 FB93 FF95 FD96 3695 9763"
	$"2223 0102 0502 0100 0003 0618 2E4E 7287"
	$"9093 948A 807D 7A79 7B7F 8285 888C 8D8A"
	$"8A8C 8D8E 8881 7D75 7564 6D6D 6856 493C"
	$"3021 0B06 FE02 1403 0500 005E 9A92 8B89"
	$"8483 8483 8687 6965 6868 695D 0D19 1116"
	$"1613 1717 1616 1517 7778 79FE 7AFF 7B0D"
	$"7E6F 7D7E 7D7E 827A 7C7E 8280 8081 FD82"
	$"057E 7880 8C94 99FE 9A01 9B9C FD9D FF9E"
	$"FFA0 FEA1 FEA2 076B 2726 0201 0001 01FD"
	$"0204 0C1C 3654 62FE 672D 635D 5853 5153"
	$"5457 5C60 6466 6464 6666 6863 5C5B 5455"
	$"4449 4B48 3C32 281E 1403 0101 0302 0201"
	$"0202 65A2 9B95 9390 2B90 8E8D 8E8E 6F69"
	$"6B6C 6C61 2018 1F1E 1A1F 1F1E 1D1D 1F60"
	$"6162 6264 6769 6A6B 5B69 6967 676B 6262"
	$"6369 6868 69FD 6A05 655F 6773 7B80 FE81"
	$"0182 83FD 84FF 80FF 82FD 8308 8286 571D"
	$"1D01 0300 00FD 01FF 0029 031B 323B 4042"
	$"4442 3E39 3533 3437 3939 3D40 423F 3F41"
	$"4140 3D38 3731 3324 2F30 2C1E 130A 0102"
	$"0100 0104 0002 FD00 1555 8A7B 7370 6D6E"
	$"6D6B 6C6D 4F4A 4F51 5349 0F08 0C0D 0CFE"
	$"0FFF 0E00 0F01 9114 676A 6D6B 6D70 6F6D"
	$"6D57 5C68 6568 6E6B 6D70 7375 76FD 7706"
	$"796C 6C75 848C 8FFC 9000 91FE 92FD 94FE"
	$"954F 9493 9677 2A1B 0003 0402 0100 0104"
	$"0A23 3A5A 7985 827D 7C74 6967 6464 6364"
	$"686C 6F79 7B7A 7E7F 807E 7772 6F6F 685C"
	$"6965 635B 5146 3B28 1005 0300 0102 0402"
	$"0039 9693 8C87 8684 8584 8486 6B62 6567"
	$"655B 1F11 1015 1717 1817 191A 1B1C 7478"
	$"7B79 797A 7A7B 7F6F 777F 7B7D 807E 7D80"
	$"807F 80FD 8106 8376 767F 8E96 99FC 9A00"
	$"9BFE 9CFD 9FFE A008 A1A0 A07F 2F1E 0002"
	$"00FD 012C 0002 1428 435B 625F 5A5A 564F"
	$"4A46 4342 4244 4B4D 5658 575B 5B5C 5B55"
	$"5150 504B 3F4A 4846 423A 3227 1908 0001"
	$"02FE 0107 0501 3E9E 9D96 9192 0D91 8F8F"
	$"8D8D 7067 6A6B 6A62 1819 20FD 2118 2324"
	$"2426 6063 6665 6669 6A6A 6F5F 666A 6667"
	$"6964 6366 6767 68FD 6906 6A5D 5D66 757D"
	$"80FC 8100 82FE 83FD 81FE 8239 8180 846A"
	$"2116 0004 0000 0303 0100 0102 0824 3C40"
	$"3C38 3839 3530 2D2B 292A 2C2A 2C36 3838"
	$"3B3C 3A37 302E 2E31 2B20 302E 2E27 1E14"
	$"0605 0200 0103 1901 0001 0300 3187 7E75"
	$"6F70 6E6D 6D6B 6C50 484E 5253 4D08 0B13"
	$"17FE 1803 1A1B 1B1D 0191 1469 6A6A 6D6D"
	$"706F 6E6D 5A5E 6967 696E 6D6E 7174 7475"
	$"FD77 0778 6D70 7385 8C8F 8FFD 9000 91FE"
	$"92FD 93FE 9508 9394 9588 390B 0003 02FD"
	$"0142 0613 2B44 616E 6C63 5752 4E44 4347"
	$"4B4B 4F53 565D 6366 6B6F 716F 6B66 6261"
	$"6256 5E60 5C5A 5650 4940 3015 0502 0101"
	$"0204 0100 2B98 9089 8886 8484 8385 8669"
	$"6264 6563 5603 151D 211F FD22 1723 2425"
	$"7878 797B 7979 7A7A 7F72 787F 7C7B 807D"
	$"7C7F 807E 7FFD 8107 8277 7A7D 8F96 9999"
	$"FD9A 009B FE9C FD9E FDA0 06A1 9F91 3D0E"
	$"0003 FE01 FE00 3607 1B33 4C52 4F45 3A38"
	$"372F 2D30 3130 3236 3B41 4547 4A4C 4C4D"
	$"4A46 4444 473B 4446 4241 403C 372F 230D"
	$"0001 0201 0100 0200 2F9F 9892 9092 0F91"
	$"8F8E 8D8C 6F67 6A6B 6B5E 1E28 2C2A 2CFE"
	$"2BFF 2D15 2E65 6666 6867 696A 6C71 6268"
	$"6E69 686B 6866 6868 6667 FD69 076A 5E61"
	$"6476 7D80 80FD 8100 82FE 83FD 80FE 8239"
	$"8081 837B 2F06 0004 0100 0305 0100 0103"
	$"112D 3431 281E 1A1E 1B17 1B1E 1D20 231F"
	$"2429 2B2E 3233 2F2A 2727 282A 2029 302C"
	$"2D2A 241B 0C0D 0800 0103 1901 0000 0300"
	$"288B 7D73 7171 6E6D 6C6C 6B4F 474C 4F51"
	$"490C 1A22 21FD 2402 2526 2701 8314 6567"
	$"6A6D 6D70 6F6F 6D5F 616D 6D67 706E 6F71"
	$"7373 74FC 75FF 7105 7584 8B8E 8E8F FA90"
	$"FD92 FE93 0892 9495 955F 0E00 0302 FE01"
	$"4303 081C 334A 5953 4D45 3932 2C22 2025"
	$"2C31 3B42 424B 5159 6065 6763 5D58 5756"
	$"4D50 524A 4748 4947 423C 3018 0502 0101"
	$"0204 0000 228A 9388 8885 8384 8284 8468"
	$"6263 6163 4F03 101D 1F1F FC21 1622 2373"
	$"7678 7B79 797A 7C7F 777C 7F7E 797F 7C7B"
	$"7E7E 7D7E FC7F FF7B 057F 8E95 9898 99FA"
	$"9AFD 9DFE 9E07 9FA1 9F9E 6410 0002 FE01"
	$"FE00 190D 233B 463C 352D 2522 1B11 0F12"
	$"171B 232B 2D32 373D 4144 4543 3EFE 3A19"
	$"3235 3A37 3434 3736 322C 2410 0001 0201"
	$"0100 0200 2891 9B91 9090 0E90 8E8D 8C8B"
	$"6E67 6A6A 6C59 1C28 2B2A FC2D 162E 2F62"
	$"6467 6968 6A6C 6F71 686C 7170 696F 6A6A"
	$"6C68 6466 FC67 FF62 0565 747C 7F7F 80FA"
	$"81FD 7FFE 8039 7F81 8389 5509 0004 0100"
	$"0306 0300 0309 1827 211C 160C 0706 0302"
	$"0508 0C15 1C11 161C 2228 2B2C 2822 1F22"
	$"221B 2024 2423 2526 2218 0B0E 0A00 0103"
	$"1901 0001 0500 1D7D 8172 7270 6D6C 6B6B"
	$"6A4D 4748 494F 4109 1922 22FC 2301 2425"
	$"017D 0459 626B 6C6D FE70 0C6D 6264 6E6E"
	$"6770 6E6F 7273 7274 FB75 066F 7783 898D"
	$"8D8F FA90 FD91 FD93 0692 9495 8521 0002"
	$"FD01 4303 0A23 3A48 473C 3A39 362F 261F"
	$"1D1A 1B1F 262C 3139 4651 595D 5F5C 544D"
	$"473E 3939 3126 2425 282B 2E2F 2916 0702"
	$"0001 0204 0000 0253 9D89 8683 8282 8184"
	$"8367 6161 6062 4A02 101B 1EFC 2117 2021"
	$"236A 737C 7B79 797A 7C7F 7A7E 8080 777F"
	$"7B7B 7E7D 7C7E FB7F 0679 818D 9397 9799"
	$"FA9A FD9C FE9E 09A0 9F9E 9E8A 2400 0202"
	$"01FE 002A 0113 2B3B 3626 2425 2523 1B11"
	$"0D09 090B 1116 1D23 2D36 3C3E 3E3B 362F"
	$"2B24 1F20 1916 1414 181C 1F21 1D0E 02FD"
	$"0108 0002 0306 5AA5 9290 8F0E 8F8D 8C8C"
	$"8A6D 676A 6A6B 541C 272A 2CFC 2D16 2E2F"
	$"5862 6B6A 696A 6D71 726B 6F76 756B 716D"
	$"6B6E 6964 66FC 6707 6660 6974 7A7E 7E80"
	$"FA81 FD7E FD80 177F 8287 7C1D 0003 0000"
	$"0506 0300 050F 1A19 0D0E 1110 0B05 02FD"
	$"001C 0409 0308 131D 2327 2724 1D18 160F"
	$"0C0D 0705 0609 0C0A 0803 0808 0001 0218"
	$"0100 0105 0000 498C 7573 6F6C 6C6A 6B6A"
	$"4D47 4647 4D3C 0B17 1FFC 2302 2223 2501"
	$"8912 5864 6E6E 7370 7372 7168 6B6D 6769"
	$"6A69 7071 73FB 7505 7671 6D74 848B FE8E"
	$"038D 8F91 90FA 91FE 9438 9390 9295 9A2A"
	$"0002 0102 0407 0711 2B3D 453A 3439 3E40"
	$"423D 3730 2721 2123 2625 2E3C 4C59 5C56"
	$"534D 4035 2A24 1B14 0D0C 0F15 181E 2020"
	$"1408 02FE 00FE 0105 0039 A388 8180 FD82"
	$"0684 6560 6061 6146 0310 2220 20FE 2100"
	$"22FE 2312 6C73 7975 7979 7E7E 827C 8083"
	$"7D7D 7B78 7E7D 7EFB 7F05 807B 777E 8E95"
	$"FE98 0397 999B 9AFE 9BFD 9CFD 9FFF 9D05"
	$"9EA0 2C00 0201 FD00 2E04 1D2E 332A 2226"
	$"2B2C 2D2B 271F 140C 0B0B 0E14 1922 303D"
	$"413C 3930 251E 1814 0E09 0504 060A 0D10"
	$"1212 0900 0002 0403 FE01 0500 3BAD 948E"
	$"8E0D 8E8D 8C8A 8A6A 6466 6A6A 4F19 2B2C"
	$"FD2D 002E FE2F 125F 6871 6D71 7178 7A7E"
	$"797D 837B 7671 6B6C 6B68 FB67 0568 625F"
	$"6676 7DFE 8003 7E80 8281 FE82 FD7E FE81"
	$"2B82 7F7C 8391 2B00 0202 0101 0505 060F"
	$"161F 140B 1013 1515 130F 0903 0000 0205"
	$"0404 0A14 2127 241F 1812 100B 06FC 0008"
	$"0203 0606 0704 0306 02FF 0017 0103 0300"
	$"338C 6F6D 7070 6E6E 6D6E 4F49 484A 4D3A"
	$"1125 1F1F FE23 0024 FE25 018E 0B5D 666E"
	$"6E72 726F 6D6E 696C 72FE 6C03 686B 6E73"
	$"FB75 0C76 6F6D 7483 8B8D 8E8E 8D8F 908F"
	$"FE90 FD91 FD93 3791 9596 9927 0002 0102"
	$"0407 081D 3943 443B 3C41 4449 4A48 433B"
	$"3027 2524 2523 2A3A 4D5D 605A 5245 342A"
	$"231F 1914 1315 1A23 2625 211E 1207 03FE"
	$"0007 0102 0000 539D 8783 FE81 0880 8283"
	$"6461 625F 6149 0310 2120 20FE 2100 22FE"
	$"2311 7276 7975 7A7E 7E7D 807D 8185 807F"
	$"7E7A 7B7E FA7F 0C80 7977 7E8D 9597 9898"
	$"9799 9A99 FE9A FD9C FE9E 089F 9DA0 A09F"
	$"2900 0201 FD00 370E 2A32 3027 272B 2E32"
	$"3132 3127 1B10 0A09 0911 1520 313F 4440"
	$"392B 1C13 100D 0907 0A0C 1016 1816 110F"
	$"0600 0002 0302 0101 0000 57A6 9390 8EFF"
	$"8D0B 8B89 8969 6568 686A 5219 2A2C FD2D"
	$"002E FE2F 1262 696E 6B70 7477 7A80 7E83"
	$"8982 7C75 6B69 6A68 FB67 0C68 615F 6675"
	$"7D7F 807F 7E80 8180 FE81 FD7E FE80 3983"
	$"7F7F 8290 2800 0202 0101 0303 0E1B 1715"
	$"0D0E 1316 1A1A 1B19 1108 0100 0001 0302"
	$"0715 2227 221D 140A 0907 0300 0001 0306"
	$"0B0D 0803 0300 0206 02FF 001B 0103 0200"
	$"4885 6D6F 716F 6F6E 6C6D 4E4A 4A49 4D3D"
	$"1025 1F1F 2423 2324 FE25 0183 135C 6671"
	$"706B 6D6C 6B61 6170 7672 6E68 676A 686F"
	$"76FC 750C 766D 6E74 8089 8C8C 8D8F 8D8C"
	$"8EFE 8FFD 91FD 9228 9394 979A 1F00 0101"
	$"0204 070D 243E 4A44 3E42 413A 363B 4243"
	$"3A2F 2925 2322 1E28 3E57 696C 6559 4431"
	$"25FD 2015 1F25 2D31 3030 2D23 1208 0400"
	$"0001 0102 000C 7F94 8584 FE80 087F 8181"
	$"6362 625E 5F44 010F 1EFC 21FD 2212 7076"
	$"7B7A 797D 7F7F 787A 8887 8380 7C7A 7D7B"
	$"7DFB 7F0C 8077 787E 8A93 9696 9799 9796"
	$"98FE 99FD 9CFE 9DFE 9F05 A19F 2100 0101"
	$"FD00 2B12 2D38 2F29 2D2C 2320 242E 2F24"
	$"180E 0A06 060B 1122 3747 4C48 4130 1B10"
	$"0B0B 0C0C 1219 2022 201E 1B13 0600 00FE"
	$"0208 0102 000D 839E 9191 8D0C 8C8B 8988"
	$"8668 6668 6768 4D19 28FC 2DFD 2E12 5E64"
	$"6B6A 6972 787D 7B7F 8F8F 8980 746C 6A66"
	$"66FB 670C 685F 6066 727B 7E7E 7F80 7E7D"
	$"7FFE 80FD 7EFE 7F08 8281 7E85 9020 0001"
	$"03FE 010F 020E 1C19 0F0B 1012 0C0A 101B"
	$"1D13 0902 FE00 0B02 010B 1C29 2B25 241B"
	$"0C08 06FD 050A 0B10 120F 0B05 0300 0104"
	$"01FE 0016 0401 0B73 7D6B 706F 6E6D 6C6C"
	$"6A4C 4B4A 484B 3810 221F 1FFE 23FD 2401"
	$"9214 6068 6E6E 6562 6865 5C64 6D73 716D"
	$"6E67 6064 6D75 74FD 7505 766A 6B76 808A"
	$"FE8C 038D 8C8A 8DFE 8EFF 90FF 91FE 9243"
	$"9193 939F 7704 0102 0001 0305 1838 4C46"
	$"3C3C 3021 1C20 2326 2724 2121 201D 1E19"
	$"2545 667A 7D7B 6343 281C 1E21 2023 222E"
	$"3738 3938 312B 1C10 0902 0102 0301 0011"
	$"8B90 8582 FE80 087F 8280 5F61 615E 5F3A"
	$"010E 1DFC 20FD 2114 7175 787C 7877 7D7E"
	$"7780 8884 837F 827B 767B 7D7E 7EFD 7F05"
	$"8074 7580 8A94 FE96 0397 9694 97FE 98FF"
	$"9BFF 9CFE 9D08 9E9F 9EA9 7D05 0102 01FE"
	$"0023 0924 3532 2B2B 1F11 0E13 1518 1913"
	$"100F 0B07 0806 0D26 4354 5854 4934 1607"
	$"0608 070B 141E FE27 0524 1C19 0D05 04FC"
	$"0106 0013 8F9A 918E 8D0E 8C8B 8A89 8664"
	$"6567 6768 4318 262C 2DFE 2CFD 2D11 5F61"
	$"6469 686C 797F 7E8C 9795 9083 7E70 6465"
	$"FE66 FD67 0C68 5C5D 6872 7C7E 7E7D 7E7D"
	$"7B7E FE7F FF7D FF7E FE7F FF81 377D 8C6E"
	$"0504 0103 0100 0006 161E 160E 1008 0301"
	$"0609 1012 0E0B 0A07 0404 0001 1126 3334"
	$"2F2B 1F09 0304 0605 0604 0E16 1412 0F05"
	$"0602 0001 01FE 0016 0301 1180 7A6B 6D6F"
	$"6E6D 6C6D 6A49 4A49 484B 2E0F 211E 1EFE"
	$"22FD 2301 9515 646A 6C6C 6864 696A 6466"
	$"6A72 6E69 7066 5F69 6E73 7374 FE75 0977"
	$"6A69 7781 8A8C 8B8B 8CFE 8DFD 8E02 8F90"
	$"91FE 9242 9091 959F 4500 0301 0000 040B"
	$"2A4A 5247 3B31 1B10 1011 0C07 070A 151D"
	$"171E 1E1D 2349 7189 8F8D 6B3F 2116 181A"
	$"1A1F 2730 3734 2C33 352A 1F20 1803 0203"
	$"0503 0004 7797 83FD 8008 7F82 7E5D 5F5F"
	$"5D5F 3603 0F1C 1F1F FE1E FD1F 1071 7578"
	$"7B7B 7A7E 827F 8286 8885 7F85 7A73 FE7C"
	$"017D 7EFE 7F09 8174 7381 8B94 9695 9596"
	$"FE97 FE98 0399 9A9B 9CFC 9D05 A0A9 4A00"
	$"0301 FD00 0A1A 3537 302A 210E 0507 0A07"
	$"FE00 2A08 0F07 0D0C 0B09 274A 5E64 604D"
	$"2F0D 0102 0303 0918 2127 231B 2021 1710"
	$"1512 0100 0001 0300 057B A18F 8C8D 0E8C"
	$"8B8A 8984 6163 6566 683F 1926 2B2B FE2A"
	$"FD2B 1561 6365 6A6F 737D 8788 9097 9D96"
	$"8785 7363 6865 6465 66FE 6709 695C 5B69"
	$"737C 7E7E 7D7D FE7E FE7F 037B 7C7D 7EFE"
	$"7FFF 800F 7F8C 3C00 0501 0202 0100 0C1E"
	$"1C17 140B FE00 FF01 FE00 1F05 0B04 0807"
	$"0200 112D 3E41 3C2F 1A01 0001 0100 030C"
	$"1419 140A 0E0E 0602 0709 0219 0301 0105"
	$"0203 6C81 6A6B 6F6E 6D6C 6D68 4648 4747"
	$"4B2A 1020 1D1D FE20 FD21 0187 1569 6B6C"
	$"696A 6D6B 6C6C 656E 6F66 656D 6765 7071"
	$"7273 74FE 7508 766C 6C75 8089 8B8A 8CF9"
	$"8E01 8F90 FD91 4F8E 8F94 982B 0002 0100"
	$"0003 123F 5452 4537 2A26 2829 2A21 1B1D"
	$"1927 271E 2233 2F2D 5276 8F9C 976F 3F22"
	$"211D 1619 1A18 1C21 2A2A 2527 2A28 2924"
	$"0602 0505 0102 006A 9A80 7F7D 7F7F 7E81"
	$"7B5D 6060 5C5F 3103 101C 1E1F FA1E 1570"
	$"7578 787A 7E7F 8286 818A 8E85 7F83 7A75"
	$"7D7C 7C7D 7EFE 7F08 8076 767F 8A93 9594"
	$"96FA 9802 999A 9BFD 9CFF 9B04 9FA2 2F00"
	$"03FE 012F 0007 2F3E 3528 1F15 1418 1C20"
	$"1A10 0E09 1716 0B0F 1E1D 1430 4D61 6C65"
	$"4B2A 0B0B 0802 0609 0C10 141B 1B14 1518"
	$"181E 1D02 FE00 0701 0200 6DA3 8C8B 8B0E"
	$"8B8A 8988 8162 6466 6568 3A1A 252A 2BFA"
	$"2A15 6367 696E 767E 8388 8F8C 98A3 9889"
	$"8473 666B 6664 6566 FE67 0868 5E5E 6772"
	$"7B7D 7C7D FA7F 027B 7C7D FC7E 387D 7E85"
	$"2400 0502 0203 0001 1920 1710 0B01 0205"
	$"080E 0806 0803 0D0A 0004 100D 0016 3042"
	$"4D46 2F13 0003 0200 0002 070B 0E13 1009"
	$"0B0B 060B 1003 1905 0100 0204 005F 8366"
	$"6A6D 6D6C 6B6B 6547 4948 464B 2511 201C"
	$"1DFA 2001 9EFF 6E13 6A6B 6E6D 696C 6A64"
	$"6F5C 5660 6E6B 6A74 7272 7374 FE75 0876"
	$"6D6D 727F 888A 898A FE8D FC8E 028F 9091"
	$"FE90 4F8F 8E92 9B32 0002 0200 0006 264C"
	$"5353 4C4A 4F50 483E 3C34 3239 373B 3C3C"
	$"3A4A 3E43 6175 8DA1 996B 462E 3424 1319"
	$"1509 0507 0E1C 2019 222F 2826 0A03 0505"
	$"0300 1F8B 9081 7E7D 7E7E 7D7F 785E 6060"
	$"5B5E 2B07 121C 1D1E 1D1C 1C1E FE1F 1570"
	$"7577 7879 7A7B 7E81 7E89 837B 7E86 7C76"
	$"7B79 7C7D 7EFE 7F08 8077 777C 8992 9493"
	$"94FE 97FD 9803 999A 9B9C FE9B 059C 9A9D"
	$"A438 00FE 0224 0003 1D3D 3C35 2928 2F34"
	$"302B 2D28 2121 1F23 2221 1E2F 2F2B 3E4A"
	$"5C6C 6142 2D15 1F12 030C 0AFE 0008 020E"
	$"1108 101D 1C1F 05FE 0007 0200 218E 998D"
	$"8A8A 128A 8988 877E 6364 6664 6734 1B25"
	$"292A 2928 282A FE2B 1567 6B6B 737F 8183"
	$"878C 8896 998F 8988 766A 6B65 6465 66FE"
	$"6708 685F 5F64 717A 7C7B 7CFE 7EFD 7F03"
	$"7B7C 7D7E FE7D 2A7F 7B7C 872A 0004 0202"
	$"0404 1324 1B16 1113 191C 160D 0E08 0A13"
	$"1010 0D0B 0715 1811 222D 4052 4A29 1403"
	$"1308 FE00 0B03 0000 020C 0D04 0609 0710"
	$"0419 0502 0005 001F 807A 6869 6C6C 6B6A"
	$"6A62 4749 4845 4A22 1420 1B1C FE1F 0320"
	$"2121 2201 A115 6569 676A 6D6C 6B70 6C65"
	$"6756 5562 6E6B 6C6F 6F71 7172 FE73 0874"
	$"6D6D 7280 8688 8989 FE8A 008C FE8D FF8F"
	$"FF90 FE91 4F90 8C92 9E33 0004 0201 0118"
	$"4A59 5B5C 6168 6F6D 614F 433B 3534 393B"
	$"434A 5052 4D59 6978 8DA6 9463 4F3E 3E35"
	$"292B 2A23 1A13 1010 0E0E 1726 2A27 0C04"
	$"0503 0000 5D9C 8683 7F7E 7D7E 7D7F 755C"
	$"6060 5C5C 291A 111B 1B1C 1B1C 1C1E 201F"
	$"1F71 787A 7977 797B 8180 7A7D 7776 7E85"
	$"7CFE 7902 7C7D 7DFE 7E08 7F77 777C 8A90"
	$"9293 93FE 9400 96FE 97FF 9AFF 9BFE 9C3B"
	$"9B99 A0AC 3900 0201 0200 1039 413E 3B3D"
	$"444B 4A41 332C 2720 1E22 242B 2F34 3634"
	$"3B44 4959 7061 3D34 2327 2016 1C1E 150D"
	$"0603 0300 0206 151E 1F06 0001 FE00 0560"
	$"A190 8E8B 8BFF 8929 8786 7B60 6465 6363"
	$"311A 2528 2A27 2828 2A2C 2B2B 6D77 787D"
	$"8180 8188 8984 8B8F 8C8A 8775 6A65 6466"
	$"6767 FE68 0C69 5F5F 6472 787A 7B7A 7A7B"
	$"7B7D FE7E FF7C FF7D FE7E 3080 7E82 912E"
	$"0006 0304 020C 2724 1C19 1F29 2F2C 2115"
	$"0D0A 0607 0A0B 1114 191A 171D 262E 3E57"
	$"4823 1B0C 1511 070C 0E10 0801 FD00 0401"
	$"090C 1004 2006 0704 0300 578C 6E6A 6B6E"
	$"6B6B 6A6A 5F45 4946 454A 2110 1D1A 1B1B"
	$"1C1C 1E20 1F1F 0186 1159 6264 6165 666A"
	$"6E6B 6962 6468 6B6D 6C6E 6EFA 6F0A 706B"
	$"6C73 8085 8789 8988 8AFC 8BFD 8FFD 914E"
	$"8E8D 9920 0006 0200 0432 5B63 6A6A 6D74"
	$"7676 6E60 574C 433D 4043 4952 595C 5F67"
	$"6D7B 8FA9 885D 574D 4342 3B33 3234 302B"
	$"2524 1F1A 1B19 272A 0F03 0301 0100 6B97"
	$"8881 807E 7D7D 7C80 7259 5F60 5E5A 2716"
	$"0F1A 191A 1B1C 1D1E 1F1E 1C70 797C 7476"
	$"7A7F 8482 8079 7BFE 7FFE 7BFA 7C0A 7D75"
	$"767D 8A8F 9193 9392 94FC 95FD 9AFD 9C03"
	$"9D9F AB27 FC00 3124 4243 4846 4A51 5150"
	$"493D 3832 2D2A 2A2C 3238 3F42 3B45 4749"
	$"5674 5B3A 3A30 292A 251F 1E1F 1D18 1516"
	$"130F 0B08 1A1F 0800 01FE 0005 6E9D 928C"
	$"8B8B 1889 8887 8778 5E63 6462 5F2D 1926"
	$"2929 2728 292A 2B2A 2870 7D83 FE7D 0C80"
	$"8587 8B87 9596 8C81 736B 6365 FE68 FE69"
	$"0A6A 5D5E 6572 7779 7B7A 797B F87C FF7E"
	$"3A7D 8285 8392 1D00 0603 0400 1729 2425"
	$"2328 2F2D 2C27 1F1D 1A13 0C0D 1016 1D24"
	$"261A 2226 2C3C 583C 1D21 1913 1613 0F0E"
	$"120F 0B07 0706 0203 040C 1104 2005 0907"
	$"0500 5F82 6F6A 6D6E 6B6A 696A 5C43 4843"
	$"4549 1F0B 1A1B 1A19 1A1B 1C1D 1C1A 0189"
	$"125C 6164 5958 5B5F 5E64 6264 7275 716F"
	$"7173 7371 FB6F 0A70 686C 737F 8587 8989"
	$"888A FC8B FD8E FD90 0E8A 8D8E 0D01 0703"
	$"010F 4D5B 6470 7172 FD7A 3B73 685D 5756"
	$"5A5E 6872 736C 696A 6E7C 92A5 835F 5655"
	$"4D4A 4237 2F29 2624 272A 282A 3022 212B"
	$"1502 0201 0007 638C 8980 7F7D 7C7C 7B80"
	$"6F58 5E5E 5D5A 211D 111B 191A 1B1C 1D1E"
	$"1F1E 1C70 7578 7172 767B 7B83 8182 8486"
	$"7F7C 7C7B 7A7B FB7C 0A7D 7276 7D89 8F91"
	$"9393 9294 FC95 FD99 FD9B 0398 9F9E 11FD"
	$"003B 093F 4446 4E4D 4D53 5150 504B 453E"
	$"3937 3A3E 4951 514B 4648 474A 596E 543B"
	$"3837 3030 291F 1915 1212 161A 1B1F 2011"
	$"1220 0D00 0001 0008 6793 938B 8B8A 0588"
	$"8786 8775 5DFE 621F 5F29 1C27 2828 2728"
	$"292A 2B2A 286E 777D 7677 777C 7C87 8A8E"
	$"9C9B 8A7D 756C 6666 FA68 095A 5E65 7177"
	$"797B 7A79 7BFC 7CFD 7BFF 7D3A 7C81 8183"
	$"8408 0002 0102 0730 2B26 2B2B 2C2F 2D2B"
	$"2C29 2522 1E19 1D21 2C34 352E 2425 262D"
	$"3E52 351D 2020 1B1C 160D 0707 0504 060A"
	$"0A0D 1306 000C 0620 0105 0403 0458 7970"
	$"696C 6D6A 6968 6A59 4247 4144 491A 0E1B"
	$"1A19 191A 1B1C 1D1C 1A01 9712 6366 615A"
	$"5456 5752 595B 616E 7170 6F72 7271 70FE"
	$"6F0D 6E6D 6E6F 646C 747F 8587 8989 888A"
	$"FC8B FD8D FF8F 288E 908D 8F84 2606 0A07"
	$"0120 5C5B 6670 7279 8081 878C 887F 7875"
	$"777E 8386 8783 7971 6F73 8197 A687 6456"
	$"FE58 2453 4B42 3830 2B29 2B2F 3945 3D2F"
	$"311F 0302 0000 0947 8D88 7E7D 7C7B 7B7A"
	$"806C 565D 5C5B 591C 1D13 1B18 191B 1C1D"
	$"1E1F 1E1C 7579 7571 6F73 7572 797C 7F7E"
	$"807D 7B7B 7A79 7BFE 7C0D 7B7A 7B7B 6F76"
	$"7E89 8F91 9393 9294 FC95 FD98 FF9A 4299"
	$"9B9B A092 2700 0001 0016 4B45 494E 4E52"
	$"5454 585E 5B57 534D 4B52 595C 5E59 504C"
	$"4C4B 4F5E 6F56 3E36 3739 3A36 2E26 2019"
	$"1616 1A1F 2A33 2A1F 2517 0001 0000 0A4B"
	$"9393 FE89 2887 8684 8772 5B61 6060 5E23"
	$"1E27 2628 2728 292A 2B2A 286F 7675 7675"
	$"7474 737E 858B 9190 8579 746C 6667 FE68"
	$"0D67 6667 6757 5E66 7177 797B 7A79 7BFC"
	$"7CFD 7AFF 7C05 7A81 8282 761A FD00 3013"
	$"3B29 272B 2D30 3130 3136 3433 332F 2D34"
	$"3A3D 3F3B 3129 2829 3142 5237 211E 1F22"
	$"2420 1913 1009 0605 080D 1721 1505 0A0A"
	$"1700 0101 0205 3C79 6F67 6A6B 6968 676B"
	$"563F 4640 4248 1410 1BFE 1905 1A1B 1C1D"
	$"1C1A 0193 FF68 1D64 635F 5F5C 5C5A 655C"
	$"6769 6A6A 6368 686A 6E6E 706C 6D6D 6B63"
	$"6B73 7D85 87FE 8801 898A FD8B FB8D 508F"
	$"8C8C 8B94 5F0A 1617 0930 5F5B 676F 747F"
	$"8587 9199 9795 9495 9492 908B 8B84 7D78"
	$"757A 869F B08E 6D5E 5D61 6668 665F 5149"
	$"4342 454B 4F52 5045 3B2A 0601 0001 0134"
	$"8D87 7E7D 7B7A 7B7A 7F6A 585C 5B5B 5718"
	$"0515 1A17 181B 1CFD 1D05 1C77 7875 7572"
	$"FE74 1772 7D75 7A7D 7C7C 7479 7978 7B7B"
	$"7D79 7A7A 786D 757D 878F 91FE 9201 9394"
	$"FD95 FB98 4599 979A 9BA0 5E00 0409 0021"
	$"4D47 4C4E 5155 5958 5F65 6566 6865 5F5E"
	$"5E5A 5B56 4F51 5051 5364 785B 453C 3A3D"
	$"4345 433C 332C 2728 2D35 393B 3832 2D22"
	$"0302 0201 0137 9491 8A88 88FF 860E 8487"
	$"705C 605F 605C 1F20 2626 2727 28FD 2925"
	$"286E 726F 7576 7371 7375 847E 8382 7C75"
	$"6869 6664 6767 6965 6666 6455 5D65 6F77"
	$"797A 7A79 7A7B FD7C FB7A 3A7B 7D80 7C83"
	$"4E00 0203 001D 3929 282B 3036 3634 383D"
	$"3D40 4544 3E3D 3C38 3933 2C2D 2B2E 3447"
	$"5A3B 2924 2126 2A2D 2A25 1F18 1314 181F"
	$"2325 1E11 0E10 1B01 0000 0400 2979 6E68"
	$"6A6A 6868 666A 5441 453F 4246 1012 1A18"
	$"1819 1AFD 1B00 1A01 99FF 6707 686B 6D6B"
	$"696C 696E FE69 1168 644E 5F5D 5E6A 6E6E"
	$"6C6D 6C69 626A 717C 84FD 8701 8889 FD8A"
	$"FD8D 028B 8D8E FE8D 409E 750D 3028 183E"
	$"615C 6169 737E 8588 909A 9FA0 9C9C 9991"
	$"8B88 837C 7573 747D 90A8 AF93 7667 6066"
	$"7079 7B77 726E 6A63 6369 6B67 5A4E 4334"
	$"0C00 0003 0056 8D84 7F7C FE7A 0879 7E66"
	$"585C 5C5A 5215 0718 1917 181A 1B1C 1CFE"
	$"1B1E 7375 7776 7475 7479 787B 787E 7F7F"
	$"7C66 7877 7177 7B7B 797A 7976 6C74 7B86"
	$"8EFD 9101 9293 FD94 FD98 4796 9899 9899"
	$"9CA8 7100 1713 0027 4D48 494B 4F56 5A59"
	$"5E65 6A6D 6C67 605B 5758 5550 4B4B 4D51"
	$"5A6A 7460 4D41 393E 464D 4F4A 4745 413E"
	$"3E45 4847 3D36 322B 0900 0202 0059 938F"
	$"8A88 8712 8685 8386 6C5D 6060 5F57 1C22"
	$"2527 2726 2728 28FE 2724 6668 696F 736F"
	$"6C72 757C 7C7B 7976 6F57 6664 5D63 6767"
	$"6566 6562 555C 636E 7679 7978 7879 7AFD"
	$"7BFD 7A3C 787A 7B7D 7F7C 8960 0011 0600"
	$"2034 2724 272F 393C 3738 3D42 4747 453F"
	$"3934 3431 2B25 2728 2E3B 4D57 3E30 2B21"
	$"242D 3232 2E31 2F2B 2626 2C2F 2E1F 1311"
	$"181D 0601 0206 004B 796B 6869 6968 6766"
	$"6950 4244 3F41 410B 1419 1817 1819 1A1A"
	$"FE19 0195 FE66 1B69 6B6A 6A6C 6B6A 6C6C"
	$"6A6C 6853 5F5F 5E69 6D6D 6C6D 6C69 6269"
	$"717E 83FD 8700 88FC 89FD 8C52 8B8C 8D8E"
	$"8C8B 9985 2243 281C 415E 585A 6676 8184"
	$"878D 969C 9C97 9693 8C86 8179 6C66 7477"
	$"828F A5AD 9170 6964 6476 7F83 7F83 817D"
	$"7674 7777 6F5E 5347 3911 0001 0111 7F8C"
	$"847D 7A78 7979 787D 6257 5D5E 594F 12FF"
	$"19FF 1703 191A 1B1B FE1A 1E71 7274 7372"
	$"7576 7979 787B 7C7B 7E7B 6875 7671 767A"
	$"7A79 7A79 766C 737B 888D FD91 0092 FC93"
	$"FD97 0196 97FE 9842 9BA3 7F0C 2710 0029"
	$"4944 4247 5158 5C5C 5D62 6769 6661 5B57"
	$"5455 5046 424B 4E56 5968 715D 4442 3B37"
	$"4950 524E 4F4E 4D47 464A 4B49 3F38 342F"
	$"0D00 0300 1282 928E 8986 86FF 8410 8284"
	$"685C 6062 5E53 1A23 2527 2625 2627 27FE"
	$"2623 6163 6368 6B69 686D 7074 7A75 7173"
	$"6E59 6564 5E62 6666 6566 6561 545B 6370"
	$"7579 7978 7879 FC7A FD79 3C78 797A 7E7D"
	$"7983 6B06 1E04 001F 3021 1C23 313E 413D"
	$"393C 4043 4240 3C37 3332 2C21 1C24 2831"
	$"3748 513A 272B 231D 2C32 322F 3A39 3731"
	$"2F33 3431 2316 141E 1D0B 0106 050F 7378"
	$"6B66 6768 6766 6468 4C41 4542 403E 0916"
	$"1919 1717 1819 19FE 1801 9B01 6665 FE66"
	$"FF67 1765 6965 686C 6A6D 6C63 6367 666B"
	$"6B6E 6C6D 6C68 6069 727F 83FD 8702 8889"
	$"89FE 88FD 8B3D 8A8B 8C8F 8C89 938F 3549"
	$"281D 435B 5558 6574 7F82 868A 9297 9491"
	$"908C 847C 7568 586A 7A7A 858D A0A6 8D68"
	$"666A 5A6C 7C87 8A8E 8A87 8582 807D 715F"
	$"5448 3D13 FE00 1146 8187 827D 7A78 7778"
	$"777C 6156 5C5F 594C 11FF 19FF 1700 19FE"
	$"1AFE 191E 6F70 7271 7074 7675 7876 7877"
	$"7679 7972 7378 7477 787B 797A 7975 6B73"
	$"7C89 8DFD 9102 9293 93FE 92FD 9631 9596"
	$"9799 9898 9B86 1F2D 0E00 2945 4142 4751"
	$"565C 5B5A 6063 6160 5C57 5350 4D44 3648"
	$"5152 5857 636A 583B 3E41 2C3E 4C55 5556"
	$"FE51 084F 504C 483F 3833 3210 FE00 0647"
	$"858D 8D88 8685 FF83 1081 8366 5B60 635E"
	$"5218 2425 2726 2426 2726 FE25 255F 6060"
	$"6364 6363 646B 6C70 6E6C 6E6C 6565 6862"
	$"6364 6765 6665 6154 5B64 7175 7979 7878"
	$"797A 7AFE 79FD 783C 7778 797F 7D77 7B71"
	$"1321 0300 1F2D 1F1B 2330 3C42 3F39 3C3E"
	$"3C3E 3D38 332E 2A20 1123 2B2B 3436 444B"
	$"351E 2828 1222 2C34 3741 3D3B 3B39 3935"
	$"3024 1815 231D 0F02 0401 4176 736A 6667"
	$"6765 6563 674A 3F45 4340 3B09 1619 1916"
	$"1617 1818 FE17 018A 0564 6566 6767 69FC"
	$"6AFC 6D00 6CFE 6D01 6E6F FE6E 0B6D 6569"
	$"6F7E 8387 8785 8485 86FD 8756 8889 8A8B"
	$"8A8B 8C8E 908A 9196 3D4C 3019 4557 5155"
	$"636E 747D 8082 898A 8B89 877F 756D 5F56"
	$"607D 7B7D 7F85 8E97 8C6E 696F 5155 6F80"
	$"878B 8A88 8783 7F7D 6F60 554B 400D 000C"
	$"386E 7B86 817C 7B77 7778 777B 5E54 5A5D"
	$"5C4E 1203 1D1E 1B18 FD19 FE18 066D 6E6F"
	$"6F70 7172 FD73 FA75 0376 7878 79FE 780B"
	$"776E 7278 878D 9191 8F8E 8F90 FD91 4B92"
	$"9394 9594 9596 9597 9799 8D26 2C13 0231"
	$"4641 424C 5250 5355 565A 5B5B 5855 504D"
	$"4C3E 3338 524D 4E4D 5259 6154 3B3E 482E"
	$"2F43 4D51 5557 5557 5451 4E48 4036 3131"
	$"0904 1C41 7684 8F8A 8584 8312 8483 8182"
	$"6459 5E62 6153 1623 2523 2326 2526 26FE"
	$"2507 5D5E 5F60 6062 6363 FE64 FB66 0467"
	$"625F 6162 FD60 0A5B 5E63 7175 7877 7576"
	$"7778 FC79 3F7A 7B7C 7B7C 7D7E 7F7C 7D77"
	$"141A 0400 2231 2621 262A 2C34 3537 3B3D"
	$"3C3A 3932 2A23 150E 1736 2F30 3236 3E47"
	$"3A22 252D 1214 2936 3B38 3A38 3C3A 3836"
	$"2C26 211B 2219 0800 0726 5B68 726D 6767"
	$"6566 6563 6648 3E43 3E42 3B08 171C 1B16"
	$"FA14 018C 0664 6566 6667 6869 FD68 F96C"
	$"026D 6E6F FE6E 0B6D 6368 6F7D 8286 8685"
	$"8485 86FD 874A 8889 8A8B 8A8B 8C8E 8F8C"
	$"919A 474C 3C1F 4656 4B52 5F67 6C73 7577"
	$"7B7B 7D7B 7B75 6962 524D 737A 6F6F 6C74"
	$"797D 806E 696E 5A49 5D6E 7A86 8989 857F"
	$"7C7A 6E63 574A 3F0C 105A 7C7E 7C83 807B"
	$"7AFE 7708 7679 5B55 5A5C 5949 15FF 1D00"
	$"1BFD 1700 16FE 1506 6B6D 6E6E 6F70 71FD"
	$"70FA 75FF 7601 7779 FE78 0B77 6C71 7886"
	$"8C90 908F 8E8F 90FD 914B 9293 9495 9495"
	$"9694 9697 9894 312E 1E09 3546 3D42 494E"
	$"4A4B 4D4E 4F4E 4F4C 4B46 4140 3029 4C50"
	$"4644 3F45 4A4B 4C3F 424A 3927 3540 4853"
	$"5657 5550 4F4C 4844 3931 2F07 156B 8687"
	$"858C 8984 8382 0E83 8281 8161 5A5E 615E"
	$"4E19 2223 2222 FE24 0023 FE22 065D 5E5F"
	$"5F60 6162 FD61 FA64 1261 5E5F 605F 5F60"
	$"5F59 5E64 7074 7776 7576 7778 FC79 3F7A"
	$"7B7C 7B7C 7D7D 7E7D 7D7C 1D1B 0B00 212F"
	$"2021 2729 262A 2C2D 2F2F 302E 302C 211B"
	$"0B07 2F36 2625 242B 3136 3829 2930 1E0B"
	$"1B28 3136 393B 3A38 3735 2E2B 251B 2019"
	$"070E 4D68 6A68 6F6D 6766 6565 6463 6445"
	$"3F43 4040 380B 191C 1B16 FE13 0012 FE11"
	$"0186 0662 6465 6566 6768 FD67 F86B 016C"
	$"6EFE 6C0B 6B5F 6770 7C81 8585 8484 8586"
	$"FD87 5688 898A 8B8A 8B8C 8D8C 8C8F 9A55"
	$"454D 414C 514E 525A 6065 6B6C 6D6F 6F73"
	$"7271 6C63 5A55 546D 6D57 565B 5E5F 656A"
	$"6461 6157 4651 5F6C 797D 807F 7876 766B"
	$"6157 4A3D 043A 8A7F 7B80 827F 7A79 7576"
	$"7675 7757 575B 5B58 4412 041A 1B1B 1615"
	$"FE16 FE15 066A 6C6D 6D6E 6F70 FD6F FA74"
	$"FF75 0176 78FE 760B 7568 7079 858B 8F8F"
	$"8E8E 8F90 FD91 0892 9394 9594 9596 9493"
	$"FE97 3F44 292C 2A38 403F 4145 4644 4747"
	$"4647 4546 4642 3E3A 3633 3147 4535 3337"
	$"3836 3B3E 3D40 4239 272F 3842 4A4E 5252"
	$"4D4C 4B48 453B 322F 0142 9A89 8489 8B88"
	$"8382 800D 8281 7F7E 5D5B 5F60 5C48 161F"
	$"2122 FC21 FE20 065B 5D5E 5E5F 6061 FD60"
	$"FA63 0360 5D5E 60FE 5E0B 5D55 5D64 7073"
	$"7675 7476 7778 FC79 157A 7B7C 7B7C 7D7C"
	$"7B7D 7C7E 2F15 1913 1F26 2223 2628 25FE"
	$"2726 2827 2A28 2928 1E16 1313 2E2E 1716"
	$"1C1E 1F27 2C29 2A2A 1F0B 141E 292E 3238"
	$"3934 3536 2E2C 281E 2019 0038 7C6B 676C"
	$"6E6B 6665 6364 6361 6241 4043 4342 350C"
	$"181A 1B16 FD13 FE12 0182 0662 6364 6465"
	$"6667 FD68 F96A 006B FC6C 056B 5D67 717C"
	$"80FD 8401 8586 FD87 5688 898A 8B8A 8B8C"
	$"8B89 8D8E 9A68 4260 534E 5151 5256 5A5D"
	$"6161 6263 6368 686A 625C 6265 5256 513D"
	$"3B43 4845 4850 4F43 484A 444B 515F 6A6F"
	$"7276 7371 7164 5B55 4A33 0462 897B 7C80"
	$"7E7E 7979 7573 7475 7555 585A 5B5B 400C"
	$"0718 1A1B 1715 1514 15FE 1706 6A6B 6C6C"
	$"6D6E 6FFD 70F9 7300 75FC 7605 7466 707A"
	$"858A FD8E 018F 90FD 914B 9293 9495 9495"
	$"9694 9297 979C 5D29 3D3A 393E 4041 4242"
	$"3F40 3F3F 3E3D 403F 3E36 343C 402E 322C"
	$"201F 2628 2526 2C30 282D 2E28 2D32 3C3E"
	$"4348 4D4B 4A4B 4641 3B35 2602 6A98 8585"
	$"8987 8782 8280 1280 7F7F 7D5B 5D5E 5F5D"
	$"440F 1D20 2221 1F1F 1E1F FE21 065B 5C5D"
	$"5D5E 5F60 FD61 FA60 015E 5CFC 5E0B 5D53"
	$"5D65 6F72 7574 7476 7778 FC79 157A 7B7C"
	$"7B7C 7D7C 7A7D 7B81 4514 2A1F 1B20 2323"
	$"2528 24FC 2224 2524 2924 1B21 2514 1B18"
	$"0C09 1113 0F0F 151B 1518 170E 1115 2023"
	$"2A2F 3635 3536 2D29 2920 171D 005C 7867"
	$"686C 6A6A 6565 6362 6161 603F 4143 4648"
	$"3509 1619 1A17 1414 1315 FE16 0186 FD63"
	$"0265 6667 FA69 FB6A 146B 6D6E 6B6C 6C5C"
	$"646F 7B81 8283 8384 8586 8787 8686 FD88"
	$"0389 8A89 8AFE 8B4B 937C 4F65 5953 5150"
	$"5152 5354 5657 585C 5D5E 5E5F 595B 696E"
	$"583B 311F 1E29 3232 3135 3123 2E3A 4749"
	$"4952 6165 686B 6A65 645C 544F 472B 147F"
	$"807C 7D7E 7F7D 7979 7574 7374 7454 5957"
	$"565B 3E0C 0117 15FB 14FF 1500 17FD 6B02"
	$"6D6E 6FFD 71FE 72FC 7315 7475 7778 7576"
	$"7665 6D78 848B 8C8D 8D8E 8F90 9191 9090"
	$"FD92 0393 9493 94FE 950E 9977 3A40 3C3B"
	$"3C3F 413F 3D3B 393A 3BFE 3C2E 3B39 3032"
	$"4149 3418 1107 0710 1918 1618 190E 161F"
	$"2B2D 2E36 3B3E 4247 4744 4341 3F39 3421"
	$"1286 8F85 8687 8886 8282 800E 807E 7E7B"
	$"5A5D 5B5A 5E42 101C 1C1E 1DFC 1C01 1D1E"
	$"FD5C 025E 5F60 FD62 FE5F FD60 0B5E 5C5D"
	$"5F60 5D5E 5E52 5A63 6EFD 7306 7677 7879"
	$"7978 78FD 793C 7A7B 7A7B 7C7B 797D 5E23"
	$"2E20 1C1D 2124 2425 201D 1F1F 2121 2222"
	$"251E 1C28 301C 0503 0200 0509 0400 0006"
	$"0306 0B15 1311 1821 262C 3232 3130 2A27"
	$"2820 0F17 0C75 6C68 696A 6B69 6565 6262"
	$"6061 5F3E 4240 4249 3306 1111 FD0F FF0E"
	$"020F 1011 0187 FD63 0265 6667 FA69 FD6A"
	$"FF69 0F6A 6C6D 6C6C 685B 626E 7A80 8082"
	$"8283 84FE 85FF 86FC 8715 8889 898A 8A89"
	$"8A94 5F6A 6556 5352 4D4C 4C4B 4A4D 4E50"
	$"FE51 3253 515E 676E 613B 271B 1B1D 2224"
	$"2427 1F18 2341 4F49 4246 5558 5B5D 5C5C"
	$"5951 4946 4026 278D 787B 7B7D 7E7C 7878"
	$"7471 7176 7152 FE57 0259 5B41 0A42 3D35"
	$"302E 2925 211E 1B19 FD6B 026D 6E6F FD71"
	$"FE72 0073 FE74 FF73 0F74 7677 7676 7264"
	$"6B77 838A 8A8C 8C8D 8EFE 8FFF 90FC 9101"
	$"9293 FE94 1B95 9696 4E42 443B 3D41 3E3C"
	$"3A35 3334 3535 3434 3331 2C35 3E48 3D1B"
	$"0CFE 0722 0A0C 0A0C 0803 0922 2E2A 272D"
	$"3336 3A3D 3E3F 3D3C 3933 301C 2494 8684"
	$"8486 8785 8181 7F15 7D7C 8078 585C 5B5B"
	$"5D60 4548 4541 3A35 302C 2825 2320 FD5C"
	$"025E 5F60 FD62 FE5C FD5D 115C 5B5C 5E5F"
	$"5E5D 5A51 5862 6D72 7271 7275 76FE 77FA"
	$"7813 797A 7B7B 7A78 787A 3630 2A1F 1F23"
	$"201E 1D1B 1A1C FC1D 061C 161E 232C 2404"
	$"FD00 FF01 1500 0101 0001 131C 130A 0E1B"
	$"2125 2A2B 2C2B 2524 241C 0920 1B81 6266"
	$"6869 6A68 6464 625F 5D63 5C3C 4140 4045"
	$"4B34 3833 2924 231F 1A16 1311 0E01 91FD"
	$"6302 6566 67FA 69FD 6A0D 6968 696B 6C6D"
	$"6B65 5A62 6D79 7F80 FE81 0583 8482 8286"
	$"87FD 8510 8486 8A88 8788 8686 926C 6364"
	$"5556 514A 48FE 463E 484A 4A49 4A4B 4D56"
	$"616B 6C60 4B37 2720 1D1F 1E1E 2120 232F"
	$"4F57 5245 414A 4E52 5353 5653 4B42 3E3B"
	$"2041 8F76 7879 7A7C 7B76 7773 7372 736C"
	$"5157 5657 535C 57FF 5503 5456 5854 FE51"
	$"014D 4BFD 6B02 6D6E 6FFD 71FE 73FD 740D"
	$"7372 7375 7677 756F 636B 7682 8989 FE8B"
	$"058D 8E8C 8C90 91FD 8F47 8E90 9494 9392"
	$"9396 995B 363F 373D 3F3B 3935 3231 3233"
	$"3330 302F 2E32 3A42 453E 2F1F 160E 0807"
	$"0503 0307 0D12 2B32 3128 282C 2E33 3539"
	$"3C39 3734 2D2D 173E 9585 8181 8284 837F"
	$"807E 157F 7D7D 7357 5C5A 5D58 615C 5C5F"
	$"6060 5D5A 5757 5653 50FD 5C02 5E5F 60FD"
	$"62FE 5AFE 5B17 5C5B 5A5B 5D5E 5F5D 574F"
	$"5761 6C70 7170 7174 7576 7474 7879 FD76"
	$"3C75 777B 7B7A 7976 767B 4325 291F 2221"
	$"1C19 1516 191A 1B1B 1A1A 1918 191F 2526"
	$"2012 0504 0100 0102 0407 0809 0D21 221A"
	$"0B09 1519 1F23 262B 2A22 1F1E 1904 1B36"
	$"815D 6465 6667 6662 6361 615F 6057 3B41"
	$"3F3E 3E4B 4847 4640 4346 42FE 3F01 3D3A"
	$"0192 FD64 0865 6666 6768 6869 6A6A FC6B"
	$"FE69 136A 6B6C 6961 595F 6C77 7F7F 8081"
	$"8282 8181 8285 86FC 8514 878A 8786 8888"
	$"8991 723C 4946 544E 4B48 4240 4244 45FE"
	$"4639 4950 5E69 6F6A 5E51 4438 2D27 241F"
	$"1F20 2227 3755 5E5D 5040 4247 494A 494B"
	$"4941 3A38 3721 6689 7477 7778 7A79 7272"
	$"7095 8D78 6D4F 5858 5A57 534F 0A4A 4045"
	$"494C 4B4A 4A4F 4A49 FD6C FF6E 076F 7070"
	$"7171 7374 74FE 7500 74FE 7313 7475 7673"
	$"6B61 6875 8088 898A 8B8C 8C8B 8B8C 8F90"
	$"FC8F 1091 9493 9191 9494 986C 2631 2E3F"
	$"3B3A 3833 FC2E FF2C 0C2E 3039 4349 443C"
	$"3226 2116 0F0A FE05 150C 131C 2F38 3930"
	$"2326 2C2F 3032 3431 302F 2929 1765 90FE"
	$"8102 8284 83FE 7C15 A298 8274 555C 5B5B"
	$"5858 5553 4C50 5452 5251 5156 5252 FD5B"
	$"FF5D 065E 5F5F 6060 5E5E FC5F 165C 5B5B"
	$"5C5D 5E5B 5350 5662 6C72 7171 7374 7473"
	$"7374 7778 FC76 3B78 7B79 7777 7677 7E58"
	$"1A23 1C27 1D1A 1714 1213 1314 1413 1316"
	$"151A 252B 2820 180D 0F07 0302 0204 0607"
	$"0913 262A 271A 0B0F 1518 1C1E 2221 1D1B"
	$"1917 061A 5679 6163 6465 6766 5F5F 5D81"
	$"7864 583A 4342 3C3A 3A39 3A39 4447 45FD"
	$"4701 3C36 019A FE63 FD64 2167 696A 6A6C"
	$"6D6E 6D6C 6B69 6A6B 6969 6869 6462 575F"
	$"6D76 7E7F 7F81 8280 7F80 8384 84FD 8552"
	$"8687 8986 8588 898D 9660 081C 2C55 4E4C"
	$"4840 3E42 4344 4445 4549 5467 6C66 625B"
	$"524B 433C 332B 2624 2426 2B3D 5861 635B"
	$"433B 4140 4244 4340 3832 3332 3380 7A75"
	$"7576 7779 7673 6D91 B5A2 A382 4B5A 585D"
	$"563E 570A 4910 151F 2226 292E 2E41 45FE"
	$"6CFD 6D21 7072 7374 7476 7776 7574 7274"
	$"7573 7372 736E 6B5F 6876 7F86 888A 8B8C"
	$"8A89 8A8D 8E8E FD8F 4790 9193 9291 9294"
	$"9399 650B 111E 443B 3938 322C 2D2D 2C2B"
	$"2A2A 2D33 4249 443F 3930 2924 1F18 110D"
	$"0C0D 1218 2334 3A3F 3A25 2128 282C 2F2F"
	$"2E2C 2A27 252B 8084 8380 8182 8481 7E78"
	$"9D15 C3AD AD89 515F 5C5A 5541 5D51 181D"
	$"2629 2B2E 3335 4A50 FE58 0059 FE5A 1F5D"
	$"5E60 6062 6365 6462 6160 5E5C 5C5A 5A5B"
	$"5654 5057 666D 7371 7173 7472 7172 75FB"
	$"7614 7778 7A78 7675 7579 8657 050B 122D"
	$"1D18 1715 1110 10FD 0F0C 1315 202A 2725"
	$"211A 1413 0E07 01FE 0013 0307 1427 2D2E"
	$"2911 0810 1016 1A1B 1A18 1816 1419 206A"
	$"6B6A 6363 6466 6360 5A7D 9F8A 8D6B 3546"
	$"4341 3A24 413F 1732 3831 3A3F 423B 403A"
	$"0196 FE61 0062 FE63 FF66 0368 6969 6AFE"
	$"6B0F 6A69 696A 6967 6768 6065 575F 6F77"
	$"7D7E FC7F 0280 8183 FC84 5285 8688 8686"
	$"8787 8B97 4D00 0821 574D 4A46 403E 4243"
	$"4445 494B 4D56 635E 5B58 5552 504F 4A3E"
	$"3534 3131 2F30 3F52 5C61 5F4A 353A 3E3D"
	$"3E3C 3B34 2E31 3046 8673 7675 7577 7876"
	$"6E83 B3AD AAAB 8544 5A59 5955 3E55 0A4E"
	$"0026 4610 1912 131E 404C FE6A 006B FE6C"
	$"FF6F 0371 7272 73FE 740F 7372 7373 7271"
	$"7072 6A6F 5F68 7880 8687 FC89 028A 8B8D"
	$"FC8E 018F 90FE 920C 9190 929B 5100 0015"
	$"483B 3736 31FE 2D23 2C2D 2E30 3037 433F"
	$"3B38 3633 3130 2D22 1B1B 191A 191B 2532"
	$"3840 402F 1C21 2527 292A 2926 FE24 0B40"
	$"8A7D 8380 8082 8381 798E C015 BAB6 B68D"
	$"495F 5D57 533F 5952 002C 4A13 1C14 1521"
	$"4654 FE57 0058 FE59 055B 5C5D 5E5F 60FE"
	$"6110 605F 5E5C 5B59 5A5B 5358 4F57 676D"
	$"7270 70FD 7101 7273 FB75 1176 7779 7976"
	$"7574 7887 4300 000E 301E 1615 14FC 1125"
	$"1315 171A 2420 1F1D 1D1C 1B17 1409 0404"
	$"0304 060A 1420 272C 2A17 030A 0D10 1415"
	$"1413 1213 122C 2073 6469 6262 6465 635B"
	$"719F 9591 926C 2C44 4346 412C 494C 0746"
	$"6322 302C 292D 474A 019F FE62 0063 FC64"
	$"7265 6769 6A6B 6D6E 6D6C 6A69 6867 6769"
	$"6361 5C5E 6A75 7C7D 7E7D 7C7E 7F7F 8082"
	$"8283 8382 8284 8687 8685 8584 8892 3606"
	$"0716 504B 4846 4242 4647 484A 4F53 5556"
	$"5152 5856 5759 5A5A 5449 4646 4140 3D3C"
	$"434B 5456 5952 423A 3B38 3736 3430 2D30"
	$"3048 8174 7274 7576 776F 7BBB B2AB A5A5"
	$"904D 5657 FE58 0056 0A4B 0C3C 6A30 3B31"
	$"3164 4F44 FE6B 006C FC6D 3B6E 7072 7374"
	$"7677 7675 7372 7170 7072 6C6A 6467 737E"
	$"8586 8887 8688 8989 8A8C 8C8D 8D8C 8C8E"
	$"9091 9291 8F8D 8E96 3907 010C 413A 3636"
	$"3430 3131 3031 35FE 382C 3637 3B3A 3A3B"
	$"3B3A 342C 2A2B 2727 2525 292E 3538 3D37"
	$"2A23 2423 2425 2221 2325 2847 857E 7F7F"
	$"8081 827A 86C5 BF15 B8B1 AF97 525A 5B58"
	$"5859 5A50 1242 7136 4135 366A 584E FE59"
	$"005A FE5B 1F5A 5B5C 5E60 6162 6465 6463"
	$"615F 5E5D 5D5F 5957 5556 626B 716F 706F"
	$"6E70 7171 72FD 74FF 7312 7577 7879 7875"
	$"7376 822C 0000 072E 1F16 1517 14FE 1310"
	$"1418 1C1D 1D19 1B21 2122 2425 1D18 1010"
	$"11FE 0F12 1216 1A21 2124 1E10 0B0C 0D0E"
	$"100E 0E11 1315 3220 6E65 6561 6163 645C"
	$"68A8 9F96 9090 7A38 4245 4745 4749 4712"
	$"4F78 303F 3635 6247 3501 A306 6768 6869"
	$"6968 67FE 691F 6A6C 6E6F 7071 7172 6D68"
	$"6864 6463 635D 5E5E 6875 7B7D 7E7D 7C7E"
	$"7E7F 8081 8281 FE82 3D83 8486 8685 8685"
	$"898C 1C00 0409 4649 4648 4344 4949 4B4F"
	$"565A 5950 4950 5659 5B5A 5652 5154 514C"
	$"4848 4A4E 4F4B 4B49 4F53 5143 3A33 3231"
	$"312F 2F31 2955 82FD 7310 7577 7279 909A"
	$"A2A4 A9AF 5B1B 2B33 343B 3F12 3B35 4052"
	$"504F 4A50 6652 4A6E 7171 7071 7070 71FE"
	$"7202 7477 78FE 7918 7A76 7070 6D6D 6B6C"
	$"6666 6771 7E84 8688 8786 8888 898A 8B8C"
	$"8BFE 8C47 8D8E 9091 9190 8F8F 911E 0001"
	$"033B 3A36 3833 3235 3334 383C 3F3C 3530"
	$"373B 3D3E 3B37 2E2E 3231 2D2A 2A2E 3435"
	$"3131 2F36 3A3A 2D25 2120 2121 2025 2A24"
	$"5789 7D80 7E7E 8082 7D84 9BA7 FFAE 1BB2"
	$"B55F 1E2E 3436 3F43 423C 4859 5656 5057"
	$"6D5A 535E 6161 6061 6060 61FE 6202 6467"
	$"68FE 6918 6A66 6060 5D5D 5B5C 5657 5660"
	$"6B70 6F70 6F6E 7070 7172 7374 72FE 7311"
	$"7475 7679 7977 7578 7E16 0000 022B 2015"
	$"1717 FD14 2619 1E21 1F1A 181F 2527 2726"
	$"2117 181D 1D1B 191A 1D21 221C 1A17 1D20"
	$"2015 0D0A 0A0B 0C0D 1317 1041 2071 6466"
	$"6060 6264 5F66 7D8A 9496 9CA1 4D0E 1F28"
	$"292E 3132 2E40 4B40 413C 4154 3A2D 019E"
	$"0B59 5455 524F 4E4D 4C4D 4F50 52FD 55FF"
	$"530E 4C45 4341 4241 434B 565F 6C75 797D"
	$"7EFD 7D5A 7E7F 8081 8081 8283 8283 8483"
	$"8486 868C 740C 0200 043A 4744 4945 464D"
	$"4F50 575E 5D52 423E 4443 4241 3D39 393B"
	$"4141 3D39 3B3F 464C 4B45 4343 474E 4C40"
	$"342F 2E30 2F35 2B4D 7172 7171 7272 7478"
	$"7373 7474 767B 8191 4004 0702 0205 0716"
	$"0506 090F 1518 1D21 2227 2A61 5C5D 5A57"
	$"5655 5455 5758 5AFD 5DFF 5B0E 544C 4A48"
	$"4948 4A53 5E68 757E 8287 88FD 8746 8889"
	$"8A8B 8A8B 8C8D 8C8D 8E8F 8F90 9092 790F"
	$"0301 0232 3B35 3934 3438 3939 3F44 4235"
	$"2825 2926 2320 1A14 1113 1A1C 1815 191F"
	$"2832 3431 2D2D 3139 372D 221F 1F22 222A"
	$"264D 777C 7CFE 7D05 7F83 7E7E 7F80 2181"
	$"8489 9744 0709 0506 090C 0B0B 0F13 191C"
	$"2024 262B 2E53 4E4F 4C49 4847 4647 494A"
	$"4CFD 4F10 4E4D 4740 3E3C 3D3C 3E47 4F57"
	$"646B 6E70 70FD 6F44 7071 7273 7172 7374"
	$"7374 7578 7A78 777C 6907 0002 0024 2215"
	$"1816 1416 1818 1F24 2215 0F13 1715 120F"
	$"0A06 0408 1011 0F0E 1215 1A22 211C 1716"
	$"181F 1E14 0B08 090D 0F18 1237 60FE 63FF"
	$"5F01 6165 FE60 1666 6D72 7787 3800 0202"
	$"0102 0200 0106 090E 1115 1818 1B1C 018D"
	$"0D3F 2C2F 261F 1E1D 1F1F 1E1E 2124 25FD"
	$"230C 2423 2225 2729 2B40 5361 6E73 78FB"
	$"7C05 7D7E 7F80 7F80 FE81 2282 8381 8182"
	$"828D 4D07 0400 0023 4444 4845 484E 5456"
	$"585C 5745 2B1D 2126 2B35 3B3C 3E35 FE2D"
	$"2B2F 3131 2B28 3035 3737 414B 4D42 3630"
	$"2F30 3534 2E7F 6F6F 6C70 7171 7376 7173"
	$"746B 6A69 5657 544A 4437 3027 2104 1913"
	$"0C06 01FB 000D 4735 372E 2726 2527 2726"
	$"2629 2C2D FD2B 0D2A 2929 2C2E 3032 475B"
	$"6A76 7C81 85FC 8605 8788 898A 898A FE8B"
	$"368C 8D8D 8B8C 8C93 5009 0401 001D 3A35"
	$"3735 363A 3F3E 4143 3D29 1002 0304 050D"
	$"100E 110A 0404 0507 0A0B 070B 1D25 2622"
	$"2A37 3C31 2521 2224 FE29 0C83 7B7D 797A"
	$"7C7C 7E81 7C7E 7F78 0F76 745F 5D59 4E47"
	$"3E37 2D26 1C15 0F07 01FB 0006 3A27 2A21"
	$"1A19 18FD 1902 1C1F 20FD 1E0C 2122 2124"
	$"2628 2A3F 4C59 6569 6DFB 6E05 6F70 7172"
	$"7071 FE72 1873 7476 7876 757F 4202 0305"
	$"0014 2116 1615 1416 1C1C 1E21 1B07 FC00"
	$"1D01 0303 0903 0000 0105 0808 0204 0F14"
	$"1412 191C 2217 0E0A 0B0E 1518 156C 611A"
	$"635F 615E 5E60 635E 6061 5A5B 5947 4743"
	$"3C37 2F28 211C 1410 0905 02FB 0001 9A0B"
	$"2311 120B 0807 0606 0708 0A0D FE11 0F16"
	$"1B21 262A 2F30 3033 3949 5862 6D73 77FA"
	$"7B59 7D7E 7F7E 7F7F 807F 8082 8080 8182"
	$"8536 0A02 0100 1542 4243 4347 4D54 5658"
	$"5B51 3526 3035 414B 525A 5F6A 5D4F 4E53"
	$"5750 4335 2616 1821 2A3D 494B 3F38 3231"
	$"3438 2E44 806A 6D6C 706E 6F72 756D 7168"
	$"3449 5F56 5A5F 5E5F 5C5A 5A59 1658 554F"
	$"4A43 3D37 302A 251E 2A19 1A12 100F 0E0E"
	$"0F10 1215 FE19 101E 2329 2E31 3637 373A"
	$"4051 606B 767C 8084 FB85 0A87 8889 8889"
	$"898A 898A 8C8C FE8A 408B 390C 0302 0011"
	$"3833 3433 3539 3F3F 4041 371A 0913 141C"
	$"2326 2C30 3A30 2224 2A2E 281B 1008 0308"
	$"1117 2637 3A2E 2925 2527 2A23 4084 767B"
	$"787B 797A 7D80 787C 7340 3456 6A60 6165"
	$"6263 6665 6361 5C59 524D 4640 3A34 2D28"
	$"201E 0D0E 0704 0302 0303 0405 090C 0C0D"
	$"1116 1C23 2A2E 2F2F 3238 4751 5A65 696C"
	$"FA6D 436F 7071 6F70 7172 7171 7275 7675"
	$"7678 2B05 0307 000B 2115 1313 1415 1C1D"
	$"1F20 1400 010A 0B11 1518 1C20 3026 1A1C"
	$"2227 2117 0E04 0001 0408 171C 1E13 100D"
	$"0E11 1711 2C6D 5C20 615F 605B 5C5F 625B"
	$"5E55 2033 4840 4348 4A4A 4343 4549 4947"
	$"423D 352D 261F 1915 1001 9401 0201 FC00"
	$"2001 0407 0A0E 1114 151A 1F27 2E30 3537"
	$"3A3D 404D 5B63 6D74 7879 7A79 797B 7C7C"
	$"7D7E FC7F FD80 4E81 8284 7F2C 0402 0403"
	$"0E39 3A3D 4146 474E 5354 564E 4349 5758"
	$"565B 595B 6173 7670 7277 796C 5B54 4629"
	$"1C15 1A33 534C 4636 3132 3933 1E5B 806E"
	$"6B6C 6B6C 6B6F 6E6A 6E55 1F3A 6A5B 5C56"
	$"5756 5657 595A FF5D FE5B 2D59 5758 5855"
	$"5202 0101 0305 0606 080B 0E11 1518 1B1C"
	$"2126 2E35 373C 3E42 4448 5564 6E78 7E82"
	$"8384 8383 8586 8687 88FC 89FE 8A0A 8B8C"
	$"8B8C 8431 0703 0200 09FE 3236 3536 353A"
	$"3D3B 3A30 2329 3735 3133 2E2E 323C 3E39"
	$"3B40 4335 2827 1D08 0101 0B24 3431 3329"
	$"2624 262C 225F 8677 7778 7877 7579 7874"
	$"7860 2616 3D6E 6060 5A5A 585A 5C5D 5E61"
	$"6160 5F5E 5C5A 5B5B 5855 02FB 0020 0103"
	$"070A 0D0F 1414 191E 262D 2F33 3435 363A"
	$"464D 5660 666A 6B6C 6B6B 6D6E 6E6F 70FC"
	$"71FD 72FF 7126 746F 1F00 030A 0204 241C"
	$"191B 1916 1C1F 1D1B 1006 0D19 1A17 1C19"
	$"1920 2E32 2C2E 3336 281B 1B15 07FE 000C"
	$"1018 1313 0D0C 0F13 1408 456A 5A20 595A"
	$"5A5B 5A5E 5D59 5D44 112C 5846 4441 4648"
	$"4142 4345 4848 4748 4947 4546 4643 4001"
	$"9527 0001 0100 0103 040A 0C0F 1214 171B"
	$"1D21 2730 383C 4145 484C 4E58 6168 6F74"
	$"7778 7979 7879 7B7B 7C7D FC7E FE80 FF7F"
	$"4D80 827C 2D04 0301 0407 3238 393E 4443"
	$"474E 4F53 5763 6D67 6361 5D57 5355 5B5D"
	$"6066 6566 6159 5450 453B 2F27 3F54 5148"
	$"3835 363A 2D24 7978 7473 716F 706F 7068"
	$"6A6E 6454 5567 5A5E 5B56 5653 5251 50FF"
	$"50FE 5101 5253 FD54 2700 0101 0409 0A0B"
	$"1113 1619 1B1E 2223 282E 373F 4348 4C50"
	$"5457 616B 7279 7E81 8283 8382 8385 8586"
	$"87FC 88FE 8AFF 8B2F 8A8B 8232 0603 0000"
	$"022C 302F 3235 3235 3937 3839 444D 4540"
	$"3D38 312D 2C2A 2B2F 3534 342E 2B2B 2924"
	$"1E18 162E 3536 352B FE29 0F26 297E 7E7C"
	$"7E7D 7C7A 797A 7274 786F 5B08 586B 5E62"
	$"5F59 5957 55FD 5404 5554 5455 56FD 5727"
	$"0001 0100 0103 040A 0D10 1213 161A 1C21"
	$"262F 373B 4041 4345 4750 535A 6166 696A"
	$"6B6B 6A6B 6D6D 6E6F FC70 FE72 3971 6F6F"
	$"726C 2000 0307 0301 1F1B 1618 1814 171B"
	$"1818 1925 2D26 2221 1E1A 1617 1B1C 2026"
	$"2525 1F1C 1E1F 1D13 0B03 1518 1717 0F10"
	$"1216 100E 6362 6013 605F 5E60 6061 595B"
	$"5F55 4647 5544 4745 4548 403E FD3D FF3E"
	$"FF40 0041 FD42 0199 2702 0506 0608 0C0D"
	$"1216 191B 1C1E 2225 2B32 3C46 4B53 575A"
	$"5E60 666B 6F72 7376 7778 7877 797A 7A7B"
	$"7CFC 7DFE 7EFF 7D4D 7E7F 8139 0303 0104"
	$"072F 3435 3940 3E40 4746 505F 6C73 685E"
	$"5C5A 544D 484C 4B51 5450 5052 4C4A 514F"
	$"5253 4B4D 5158 3F3B 3738 3925 4088 7776"
	$"7473 716E 6D69 5E6D 6B65 696C 635A 5C62"
	$"5F5E 5C5A 5958 0757 5552 504F 4D4A 4AFE"
	$"4C27 0407 080A 0F13 1419 1D20 2223 2529"
	$"2C32 3943 4D52 5A5E 6267 696F 7479 7C7D"
	$"8081 8282 8183 8484 8586 FC87 FE88 FF89"
	$"FE88 333D 0602 0000 0229 2C2B 2E32 2E2E"
	$"332F 3643 4E52 453D 3A3B 352E 2A23 2127"
	$"2A26 2628 2528 302F 3539 3335 363F 2B2D"
	$"2C2C 2A1F 458D 7DFD 7E07 7877 7368 7775"
	$"6F6F 126F 675E 6066 6261 605E 5D5C 5B59"
	$"5654 5150 4D4D FE4F 2701 0405 0608 0C0D"
	$"1216 191B 1B1D 2124 2A31 3B44 4950 5254"
	$"5758 5E5D 6064 6568 696A 6A69 6B6C 6C6D"
	$"6EFC 6FFE 7018 6F6D 6D6F 712C 0003 0603"
	$"001C 1712 1415 0F10 1410 1623 2F32 26FE"
	$"1E1D 1A14 1013 1319 1C18 181A 1618 2220"
	$"2221 1616 1821 0E13 1216 1809 2C73 6364"
	$"FF63 1B62 5F5E 5A4F 5E5C 5659 5B50 4445"
	$"4C4D 4E49 4746 4544 423F 3E3D 3B38 38FE"
	$"3A01 9B1A 080B 0D0D 0E13 1517 1A1D 1F21"
	$"2428 2A31 3A44 4E54 5B61 656A 6C6F 71FE"
	$"7300 75FE 7705 7678 7979 7A7B FC7C FE7E"
	$"4F7C 7B7C 7C8A 4701 0201 0309 3130 3236"
	$"3E3B 3940 434F 6069 706C 6159 544F 4640"
	$"413F 3F3D 3E41 4544 464C 515B 6264 5B54"
	$"4D3C 3E38 3734 216A 7E72 6E66 5F5A 5449"
	$"4B54 7365 4B59 6F62 5C60 4459 5859 5A5C"
	$"5C25 5B5A 5A59 5756 5455 5552 510A 0D0F"
	$"1115 1A1C 1E21 2426 282B 2F31 3841 4B55"
	$"5B64 696D 7375 787B FE7D 007F FE81 0580"
	$"8283 8384 85FC 86FD 88FF 8641 8590 4B03"
	$"0200 0004 2B28 282A 302C 292D 2D37 444C"
	$"5048 403A 3734 2E29 211D 1E1C 1D20 2325"
	$"292F 3540 4547 3F3B 3528 2E2B 2C28 1E6F"
	$"8378 7570 6A66 5E53 555E 7D6F 5560 3072"
	$"6760 6448 5C5B 5C5D 5F5F 5E5D 5D5C 5A59"
	$"5758 5855 5407 0A0C 0C0E 1315 171A 1D1F"
	$"2023 2729 3039 434C 5057 5B5E 6262 6563"
	$"FE65 0067 FE69 0568 6A6B 6B6C 6DFC 6EFE"
	$"7000 6EFE 6B35 7A3B 0002 0702 011D 130F"
	$"1013 0D0B 0F0D 1623 2C2F 281F 1B19 160F"
	$"0B0F 0D0D 0C0C 0F12 1518 1D1F 2527 261A"
	$"1D19 0D15 1417 1508 566A 5E5C 2055 4E4B"
	$"463B 3D46 6557 3D4A 5C50 484A 3046 4647"
	$"484A 4A49 4848 4745 4442 4343 403F 0193"
	$"190D 0E0E 1014 181B 1E20 2224 2727 2C31"
	$"3640 4950 565D 6568 6A6D 70FE 7300 74FC"
	$"7603 7879 7878 FB7A FE7D 067B 7A7D 7B87"
	$"5600 FE02 4509 362F 2C2F 3738 3739 3E4C"
	$"5C65 6B6A 625B 534D 4540 3A31 3032 3333"
	$"393F 444C 5461 6B6C 604F 3F3C 3735 3428"
	$"316D 6057 504A 4641 403B 475E 7655 485D"
	$"6C5F 555D 475A 5250 5152 5424 5456 5756"
	$"5556 5856 5153 5311 1213 161B 1F22 2527"
	$"292B 2E2E 3338 3D47 5057 5E65 6D71 7376"
	$"79FE 7D00 7EFC 8003 8283 8282 FB84 FE87"
	$"FF86 4287 858E 5B02 0200 0005 3027 2223"
	$"2A2B 2928 2B36 434B 4C46 413D 3732 2D29"
	$"1D14 1315 1616 1C24 2A31 3944 4E4D 4339"
	$"2B28 2628 2A20 3072 655C 5854 504E 4944"
	$"5067 7F5E 5163 2F6E 6259 604B 5D55 5354"
	$"5557 5759 5A59 5859 5B59 5456 560C 0D0D"
	$"1014 181B 1E20 2224 2626 2B30 353F 484D"
	$"5157 5D60 6063 64FE 6500 66FC 6803 6A6B"
	$"6A6A FB6C FE6F 396C 6A6C 6B77 4A00 0208"
	$"0202 2212 090A 0C0A 0A08 0A15 212B 2A24"
	$"1E1B 1714 0D0A 0A02 0103 0404 0A12 171A"
	$"1C24 2B29 1D1C 110F 0F14 170E 1B5B 4D44"
	$"4010 3B36 3434 2F3B 526A 493C 4E59 4D45"
	$"4D38 48FE 400C 4244 4446 4745 4344 4644"
	$"3F41 4101 9719 1215 1718 1B1F 2224 2528"
	$"292C 2C31 373D 454D 5358 5E65 686A 6D70"
	$"FE72 0073 FD74 0175 76FE 7700 78FC 79FE"
	$"7BFF 794D 7C7B 7D71 1300 0202 083A 2F29"
	$"2B31 3334 353B 4957 5F65 6660 5D58 5551"
	$"4D45 3D38 3839 373A 4248 4D59 6268 6459"
	$"3E34 3537 332B 264D 544D 4B49 4643 403E"
	$"404B 656E 5152 6665 581A 1F3E 4342 4344"
	$"4648 244C 5154 5355 5658 5653 5252 181B"
	$"1E1F 2226 292B 2C2F 3033 3338 3E44 4C54"
	$"5B60 666E 7173 7779 FE7C 007D FD7E 017F"
	$"80FE 8100 82FC 83FC 8504 8684 8475 16FE"
	$"0005 0434 271F 1E24 FE26 2429 333F 4748"
	$"443F 3C38 3531 2E25 1D18 1819 1719 242D"
	$"323E 464C 473B 2D24 2325 2522 214D 5851"
	$"FE50 094D 4C47 4954 6E77 5A5C 6C2F 685A"
	$"1C20 4045 4546 4749 4B4F 5457 5658 595B"
	$"5956 5555 1114 1618 1B1F 2224 2528 292B"
	$"2B30 363C 444C 4F50 575D 5E5E 6163 FE64"
	$"0065 FD66 0167 68FE 6900 6AFC 6BFE 6D39"
	$"6A69 6B6A 6D64 0F00 0702 0226 1206 0506"
	$"0607 0608 111D 2625 1F1C 1917 1512 110F"
	$"0702 0203 0103 1018 191F 252B 281E 1108"
	$"0910 1310 0F39 433B 3938 2038 3534 3335"
	$"405A 6345 4759 574D 1318 3636 3334 3436"
	$"393D 4244 4243 4446 4441 4040 018D 1919"
	$"1B1C 1E21 2528 2A2C 2D30 3334 383E 434A"
	$"5056 5A5E 6568 6A6D 70FA 7102 7274 75FE"
	$"7600 77FC 78FE 791A 7778 7B7A 777F 4600"
	$"0102 113D 2F29 272B 2C2F 3238 4451 585F"
	$"6563 63FD 6605 6561 5B58 5A58 FD56 265C"
	$"6160 574A 3227 2C32 2C21 4556 4F4B 4A48"
	$"4745 423E 3F54 7066 4A59 6569 4000 022C"
	$"2A23 2422 2122 2424 262A 2C2F 3539 3F43"
	$"4547 2224 2626 282C 2F31 3334 373A 3B3F"
	$"454A 5157 5D63 686E 7173 777A FA7B 027C"
	$"7E7F FE80 0081 FC82 FD83 0584 8583 7D83"
	$"48FE 003A 0C37 271F 1B1E 2224 2527 2F3A"
	$"3F44 4541 3F40 3F3D 3C3E 3B35 3234 3230"
	$"3337 3941 4745 3C2F 2418 1A1E 1D19 4358"
	$"514E 4E4F 514F 4E48 485D 796F 5362 6A2F"
	$"6A40 0002 2B2B 2427 2524 2527 292D 2F32"
	$"383C 4246 484A 181A 1B1D 2125 292A 2C2E"
	$"3032 3237 3D43 4A50 5253 575B 5D5E 5F62"
	$"FA63 0264 6667 FE68 0069 FC6A FE6B 1B69"
	$"686A 6A67 7240 0006 0208 2A12 0601 0000"
	$"0303 050D 181E 1F1E 1C1D 20FE 211A 2521"
	$"1B19 1A19 161D 231E 2025 2723 1B07 0002"
	$"0B0B 0731 443D 3A39 3A17 3A39 3734 354A"
	$"675C 4150 5A60 3C00 032B 2418 1614 1213"
	$"1618 FE1D 0523 272C 3132 3501 901C 2022"
	$"2324 272A 2C2D 2F31 3435 373B 424A 5056"
	$"5A5D 6166 6A6C 6E6F 6E6F 6FFD 7006 7174"
	$"7576 7574 76F9 7701 7677 FE78 337C 6D15"
	$"0003 1E3E 342B 2224 282C 3237 3F4A 5158"
	$"636B 6D6D 6F72 7476 7574 7479 7670 6B62"
	$"5D61 605B 4E3F 2C29 2B29 1932 544E 4E4C"
	$"4CFE 4510 4342 3F5E 7764 455F 6361 2105"
	$"0B25 2320 20FE 1E04 1D1E 1D19 18FE 191F"
	$"1A1C 1F29 2B2C 2C2E 3133 3436 383B 3C3E"
	$"424A 5158 5E61 666A 6F73 7577 7878 7979"
	$"FD7A 067B 7E7F 807F 7E80 F981 FD82 4080"
	$"8374 1A00 041B 372A 211A 191A 1E23 272E"
	$"393F 4043 4B4A 4746 4647 4B4B 494A 4E4B"
	$"4544 413D 4244 4135 2719 181A 1A11 3157"
	$"5353 5152 4C4D 4D4C 4B47 657F 6C4E 686B"
	$"0867 270B 112B 2A27 2221 FE20 0321 201C"
	$"1BFE 1C1F 1D1F 221F 2122 2326 2A2B 2D2E"
	$"3133 3436 3A41 464C 5354 5358 5C5F 6062"
	$"6360 6161 FD62 0663 6667 6867 6668 F969"
	$"0167 66FE 6708 6D61 0E00 000E 2413 09FE"
	$"0228 0508 0A0F 161C 1C1E 2627 2425 2728"
	$"2D2D 2B2B 302D 2726 211D 2326 261E 1302"
	$"0204 0901 2047 4140 3E3E 3820 3839 3836"
	$"3250 6A57 3953 595A 1D02 0821 1E17 1412"
	$"1111 0E10 0E09 0707 0808 090B 0E01 931C"
	$"2227 2929 2C2F 302F 3135 373B 3F44 484D"
	$"535A 5D60 6368 6B6C 6D6E 6D6D 6EFD 7007"
	$"7173 7475 7372 7474 FD75 FC76 FE75 3176"
	$"754A 1C13 3A3E 362D 1E20 262B 3336 373E"
	$"4752 5E67 6F70 7475 767A 7B7B 7C7E 7A75"
	$"726A 6663 5C55 4535 2929 261B 214C 4F4C"
	$"4CFE 4A15 4641 3D32 3C68 7362 566C 6B58"
	$"3632 231A 0F0D 1416 1819 FE19 FE1A FE18"
	$"1E16 1529 2E30 3033 3637 3638 3C3E 4246"
	$"4B51 555B 6166 696C 7174 7576 7677 7778"
	$"FD7A 077B 7D7E 7F7D 7C7E 7EFD 7FFD 80FE"
	$"7FFF 803E 7F54 281A 3835 2A24 1A16 1319"
	$"2226 282F 3A3D 4149 4E4D 4D4B 4C4E 4F4F"
	$"5051 4D48 4A48 4545 423C 2F20 1417 1613"
	$"1F4F 5554 5452 5151 4E49 443A 4470 7B6A"
	$"5E74 7432 6341 3D2E 251B 1815 1719 1A1B"
	$"1C1C 1D1D 1C1B 1B1A 1918 2126 2828 2B2E"
	$"2F2E 3034 363A 3E40 4447 4C52 5455 595E"
	$"6262 6364 5F5F 60FD 6207 6365 6667 6564"
	$"6666 FD67 FE68 0067 FD65 3466 6439 1606"
	$"221D 120D 0405 060A 0E0E 0C0F 171C 2027"
	$"2B29 2828 272D 2D2E 2F30 2B27 2520 2126"
	$"2522 1608 0204 0503 0F40 4641 3E3D 3C3C"
	$"1B39 332E 222D 5963 5247 5D5F 502D 2819"
	$"1006 050E 100F 0E0C 0B09 0B0D 0CFE 0A01"
	$"0907 018D 1C27 2B2D 2D30 3334 3437 3A3D"
	$"4245 4B4F 5358 5D60 6164 676A 6B6C 6D6C"
	$"6C6E FD6F 0670 7172 7372 7172 FC73 FA75"
	$"4B74 7774 7059 4A5B 3837 301F 1E25 282D"
	$"3233 3640 4E5B 5C6B 7073 6F70 7777 7576"
	$"7571 7372 6864 6058 4E3C 2E27 2520 173F"
	$"594F 4D4A 423C 3530 2F33 3346 746F 5D6B"
	$"7561 6260 544B 3E2F 2620 1B15 10FE 0B20"
	$"0A0B 0C0D 0F11 1112 2E32 3434 3639 3A3B"
	$"3E41 4449 4C52 575B 6066 696A 6D70 7374"
	$"75FE 7600 78FD 7906 7A7B 7C7D 7C7B 7CFC"
	$"7DFA 7F40 7E81 7E7B 6651 592E 2A25 1A15"
	$"1217 1E23 2327 323A 4140 4C4F 4F4A 494E"
	$"4E4C 4D4C 4849 4D49 4645 4038 281B 1614"
	$"1110 3D5C 5455 524B 443D 3838 3B3B 4E7C"
	$"7765 737D 6A0A 6B69 5D54 4738 2E22 1C16"
	$"12FE 0E24 0D0C 0D0E 1012 1313 262A 2C2B"
	$"2E31 3233 3538 3B40 4347 494D 5156 5757"
	$"5A5D 6061 6262 5E5E 60FD 6106 6263 6465"
	$"6463 64FC 65FD 67FD 6634 6865 6252 3D43"
	$"1612 0E03 0205 080A 0B09 0913 1B21 202C"
	$"2D2D 2726 302F 2D2E 2D29 2B2C 2525 2624"
	$"1E10 0403 0301 002C 4C45 413A 332D 2620"
	$"2120 2424 3765 604E 5C66 5558 564A 4134"
	$"251C 1B16 0E08 0100 0001 0304 0407 0809"
	$"0901 931C 2A2F 3031 3336 373D 3F42 4549"
	$"4C52 565A 5D61 6363 6568 6A6A 6B6C 6B6B"
	$"6DFE 6EFF 6D05 6E6F 716F 6E70 FC71 FE73"
	$"FF74 FF73 4B75 7675 7470 766F 313A 321F"
	$"1B1E 2026 2A2D 3137 4455 5259 626A 6567"
	$"6C6A 6668 696B 6E6A 5F5C 544D 4130 2720"
	$"1C17 2243 4638 3633 3538 3F45 4A4E 515E"
	$"756E 585F 684E 5657 555A 5658 5351 4B43"
	$"3D27 352E 2317 1210 0C08 0605 0431 3637"
	$"383B 3D3F 4446 4A4C 5054 595E 6266 6A6C"
	$"6C6E 7173 7374 7574 7577 FE78 FF77 0578"
	$"797B 7978 7AFC 7BFE 7DFD 7EFF 80FF 7F3C"
	$"7C7B 6C27 2B26 1912 0F12 181D 2024 2A33"
	$"3D39 3E42 4942 4148 4542 4444 4749 4942"
	$"403D 382F 2016 1210 0E1E 4349 3D3E 3B3D"
	$"4047 4D52 5659 667D 7660 6770 56FF 5F30"
	$"5D62 5E60 5B56 4F47 4139 3226 1A13 110E"
	$"0A07 0606 292E 2F2E 2F32 3338 3B3E 4146"
	$"484D 4F53 5558 5A59 5B5E 6060 6262 5D5D"
	$"5FFE 60FF 5F05 6061 6361 6062 FC63 FA65"
	$"FF67 FD66 2F55 0F13 0D02 0001 0306 0707"
	$"0A0F 171F 1C1F 252B 2223 2C29 2628 282B"
	$"2D2C 2523 221F 1708 0203 0100 0E33 382D"
	$"2923 2629 2F1D 353A 3F42 4F66 5F49 5058"
	$"414C 4C4A 4F4C 4E49 453F 3833 2A24 1A10"
	$"0C08 0502 FE00 0195 1D2D 3133 3538 3C40"
	$"4446 494B 5053 575B 5D60 6263 6566 6768"
	$"696A 6B6A 6B6C 6DFE 6C05 6E6F 6F70 6F6F"
	$"FB70 FE72 FF71 FF73 4B74 7374 7473 7C71"
	$"2F3C 3524 191B 1C1E 2226 282E 3B47 4446"
	$"505A 5A5E 5D5A 595B 5E62 635F 5550 4940"
	$"3325 1F1A 1514 2C3B 4040 474D 5255 5658"
	$"5857 5565 7165 4F61 5D4C 4F4C 4E4F 4C4F"
	$"5356 5856 5728 5753 504B 443D 352E 261F"
	$"1734 383A 3D40 4448 4C4E 5153 585B 5F62"
	$"6669 6B6C 6E6F 7071 7273 7474 7576 77FE"
	$"7605 7879 797A 7979 FB7A FE7C FF7B FF7C"
	$"FC7D 3B80 6C22 2C28 1C10 0D0F 1116 1A1C"
	$"222B 3430 2F35 3D3B 3E3E 3A3A 3C3F 4344"
	$"433C 3835 2E24 1814 110E 0F2D 3E45 474E"
	$"555A 5D5E 6060 5F5D 6D79 6D57 6966 5233"
	$"5452 5454 5255 585C 5E5C 5D5C 5855 4E47"
	$"4037 3029 2119 2C30 3232 3337 3B3F 4143"
	$"464C 4E50 5355 5657 595B 5C5D 5E5F 6061"
	$"5C5D 5E5F FE5E 0560 6161 6261 61FB 62FD"
	$"640D 6566 6667 6667 6768 6A55 0B12 0E04"
	$"FE00 2701 0305 070D 1319 1514 1A21 1E21"
	$"2421 2023 262A 2A29 2320 1E18 0E03 0103"
	$"0101 1C2D 3436 393B 4144 4500 47FE 461C"
	$"5662 5640 524E 3E43 4042 4340 4347 484A"
	$"4A4B 4B48 4540 3931 2922 1B14 0C01 8D21"
	$"3537 3B3B 3D43 474B 4C4F 5054 5658 5B5F"
	$"6061 6464 6566 6767 6869 696A 6C6B 6A6B"
	$"6C6D FE6E F96F FD70 0472 7372 7172 FE73"
	$"467C 642E 3D38 291A 191A 191E 2323 2A31"
	$"3939 3D44 4A4B 4F4E 4C4F 5050 5353 5148"
	$"413D 3628 211B 1314 1956 6560 5967 655D"
	$"5A56 5654 5048 666E 5A4D 665D 4E53 5251"
	$"4953 4D49 4749 474A 2C4D 4E4F 4E50 5351"
	$"4E4D 4946 3C3E 4142 454B 4F53 5556 585C"
	$"5E60 6468 696A 6D6D 6E6F 7070 7172 7374"
	$"7675 7475 7677 FE78 F979 FE7A 2079 7A7C"
	$"7B7A 7B7C 7C7B 7F5E 202D 2820 100C 0E0C"
	$"1216 161D 242B 2929 2E31 2F33 3332 FE35"
	$"FE38 1D32 2E2D 291D 1815 1011 1757 6A66"
	$"606E 6D64 615E 5E5C 5850 6E76 6255 6E65"
	$"54FF 5635 554C 5751 4D4D 4F4E 5154 5658"
	$"5453 5754 5150 4C4A 3436 3A37 373D 4145"
	$"4649 4A4E 5051 5354 5556 585A 5B5C 5D5D"
	$"5F5F 5C5C 5E5D 5C5D 5E5F FE60 F961 FE62"
	$"0E63 6667 6665 6667 6765 6745 0712 0F05"
	$"FD00 0D04 0706 0D11 1211 1315 1716 191C"
	$"1BFE 1E15 2120 2320 1B1A 160A 0402 0506"
	$"0C48 5954 4D58 524B 4844 2044 423E 3957"
	$"5F4B 3E57 4E40 4645 443C 4640 3D46 4844"
	$"4342 403E 3E40 4441 3E3D 3A36 018F 1B3C"
	$"3E41 4448 4C4D 5153 5557 595B 5D5E 5F62"
	$"6464 6364 6566 6667 6867 67FE 6900 6AFC"
	$"6B00 6CFA 6DFE 6E4F 6D6E 7171 706E 6D6A"
	$"6F7F 5732 403A 2C1E 1916 171A 1C1D 2124"
	$"2C30 3537 3838 3738 3C3E 3E41 4241 3F39"
	$"352D 271C 1C15 0F0E 376D 6F75 809B 9D91"
	$"8773 614F 454E 6E6B 5052 6858 4E55 504D"
	$"3B51 5144 242A 3035 2237 3A3D 4047 4446"
	$"4548 494A 4345 484B 5054 5559 5B5D 5F61"
	$"6266 6768 6B6D 6D6C 6D6E 6E70 FD71 FE73"
	$"0074 FC75 0076 FA77 FE78 4476 777A 7A79"
	$"7776 7376 8150 242E 2A22 140D 0A0B 0F10"
	$"1115 1921 2225 2522 1F1F 2327 282A 2C2C"
	$"2A29 2624 201D 1618 1211 1038 7276 7C88"
	$"A3A5 9990 7B69 584D 5676 7358 5A70 6054"
	$"3158 5351 3E54 5447 282E 353B 3E41 4646"
	$"4946 4947 4B4B 4C3B 3D41 3F40 4446 4A4B"
	$"4E4F 5153 5554 5354 5658 595A 5B5C 5C5E"
	$"5E59 59FE 5B02 5C5D 5DFE 5C00 5EFA 5FFD"
	$"6038 6366 6664 6362 5E5E 6836 0812 0F07"
	$"0101 0000 0103 050A 090D 0D0F 0F0C 0907"
	$"0E12 1415 1717 1519 1A17 100C 0303 0108"
	$"072D 6465 6A74 8B89 7E74 6020 4E3C 323E"
	$"5F5C 4243 5949 4047 4240 2D43 4438 3138"
	$"3B3B 3937 3936 3836 3937 3B3B 3C01 8A1F"
	$"4446 494C 4F51 5255 5659 5A5A 5B5E 6061"
	$"6365 6362 6364 6466 6767 6565 6768 6869"
	$"F66A FF6B FF6C FF6D FF6C 4C69 5C49 362A"
	$"416C 4637 413D 3122 1A15 1616 1416 1719"
	$"1C1F 292C 292C 2923 2A2C 2D2E 2E2B 2A29"
	$"261A 1919 1714 0E11 6884 9CA3 909D B8B3"
	$"B4B0 A79A 8D88 8C81 6C66 685A 4B4F 4A42"
	$"4042 503C 0F2F 591A 051A 1714 2547 45FE"
	$"4421 4342 4B4D 5054 585A 5B5E 5F62 6362"
	$"6467 6969 6C6F 6D6B 6C6D 6D6E 6F70 6F6F"
	$"7071 7173 F474 FD76 FF75 4172 6552 3F32"
	$"476C 3F28 2D2B 2519 110B 0C0C 090C 0D11"
	$"1414 1C1B 1718 1413 1A1C 1C1E 1D1A 1A18"
	$"1711 1214 1412 1316 6E8C A4AC 9AA7 C1BB"
	$"BCB8 B0A3 9590 9588 746E 7063 5010 514D"
	$"4543 4553 3F15 365E 201F 1C1A 2848 46FE"
	$"4521 4443 4346 4948 4749 4A4D 4E51 5253"
	$"5456 5455 5656 5758 595A 5B5B 5D5D 5757"
	$"595A 5A5B FC5C FA5D 005C FE5E 3960 6262"
	$"6053 402C 2032 5425 0B12 0F09 0403 0001"
	$"0100 0204 0302 030A 0804 0401 0108 0A0B"
	$"0C0C 090D 100C 0302 0201 000B 0E63 7B91"
	$"9782 8BA3 9E9F 9B20 9386 7979 7D71 5D56"
	$"594B 3C40 3B34 3234 412F 1E40 6A2E 312E"
	$"302F 3E3E 3D3C 3C3B 3A01 9112 4A4B 4E4F"
	$"5053 5457 5759 5A5D 5E5F 6060 6162 64FE"
	$"67FD 68FF 67FF 6903 6869 6B68 FE65 FD66"
	$"FD6A 226C 6E6F 6C6D 6046 2718 0D01 0426"
	$"423F 4644 3B2C 231C 1816 1414 1616 1518"
	$"1B1C 1D21 221F FE20 FE1F 041C 1816 1213"
	$"FE15 2112 239E A9B6 9C96 A9B3 B6AD A9A0"
	$"A0A6 A19F 9B94 9183 7D6E 6757 473C 414B"
	$"3F18 3E6E 381C 3229 2F4B 3B42 4343 403E"
	$"3E52 5356 5758 5B5C 5F60 6162 6566 6768"
	$"6869 6AFD 6BFD 6C01 6B6C FE6D 026E 6F70"
	$"FE71 FD72 FF73 0272 7371 FE73 0978 6D56"
	$"3726 1606 0928 3AFE 2D11 271B 130C 0908"
	$"0608 0D0B 080B 0E0F 1115 1511 FE12 FF11"
	$"1F10 1111 0E0A 0B0C 0C0D 1025 A4B6 C6A8"
	$"9DAF B8BB B2AD A5A4 ABAA A9A4 9D9A 8B85"
	$"7617 7060 4E43 4852 461F 4575 3F39 2F36"
	$"5141 4849 4A47 4646 4547 FE49 0C4B 4D50"
	$"5052 5356 5758 5959 5A5B FD5C FD5D FF5A"
	$"FF5C 035B 5C5E 5EFE 5DFD 5E1B 5F5D 5D5C"
	$"5B5C 5C5B 5F58 442A 1B0B 0010 2224 0C0D"
	$"110B 0505 0204 0501 FD00 0502 0405 0508"
	$"09FD 08FE 0713 0502 0200 0102 0305 0414"
	$"8A92 9F85 7F90 979C 9490 208A 8B92 8A88"
	$"857F 7E70 6B5B 5344 352B 313C 3318 3F6F"
	$"3934 2A32 4935 3B3B 3832 2F2F 0190 124D"
	$"4F51 5253 5657 5859 5A5A 5D5E 5F60 6061"
	$"6263 FE64 FD66 0764 6566 6766 6768 67FE"
	$"66FD 67FF 68FF 6920 6A6D 6A6B 623A 1910"
	$"0A04 0000 0B42 4043 453D 312A 2119 1614"
	$"1313 1414 1313 1415 17FC 18FF 172A 1813"
	$"0E0F 1112 0F11 1612 3BC6 B2A7 9FAA ABA0"
	$"8D6E 6B6C 7593 A2A5 A29B 9791 8F92 9085"
	$"7C75 6956 514B 454C 471B 4B42 4A5D 3441"
	$"4041 403D 3E55 5759 5A5B 5E5F 6060 6262"
	$"6566 6768 6869 FC6A FD6C 056B 6C6D 6E6D"
	$"6EFC 6F00 70FE 71FF 721C 7170 6F72 6E73"
	$"6F47 2820 170D 0400 0B3A 2D2C 2D29 2118"
	$"1009 0706 0508 09FE 0603 0708 0A0C FD09"
	$"FD08 FF07 1B08 0906 080D 0F3C CBBE B6AB"
	$"B1B0 A491 716E 6F78 96A9 ADAA A39F 9A98"
	$"9B17 9A8D 847D 715E 5853 4D54 4F53 4A53"
	$"6439 4748 4847 4546 4849 FE4C 0D4F 5051"
	$"5253 5356 5758 5959 5A5B 5DFE 5EFE 6008"
	$"5F58 5859 5A59 5A5B 5BFE 5A00 5BFE 5CFE"
	$"5B1A 5958 5B57 5D5B 371B 1710 0501 0708"
	$"210C 0C10 0E07 0602 0001 0100 00FE 01FF"
	$"0002 0102 03FA 0200 01FE 000F 0100 0107"
	$"0732 B49E 928A 9495 8B78 5B59 205C 6785"
	$"9093 9089 847D 7B7E 7C71 6964 5A47 4443"
	$"3E45 4044 3B43 572D 3837 3531 2D2D 018A"
	$"124F 5153 5455 5859 595A 5B5C 5D5E 5F60"
	$"6061 6261 FE60 FD62 FF61 0462 6362 6364"
	$"FD65 0066 FA67 1E68 676C 693A 120E 100C"
	$"0400 0015 453F 4444 4039 3027 211C 1713"
	$"1213 1311 0F0F FE10 FE13 0012 FE11 290F"
	$"0D10 1211 0F11 1910 54D0 B07C 5E70 869B"
	$"4736 404F 525B 7087 9CA3 9C96 9596 958E"
	$"9397 8C7B 726B 6A5F 571B 4B49 4543 3D42"
	$"4142 3E3C 3D57 595B 5C5D 6061 6162 6364"
	$"6566 6768 6869 FC6A FF6B FE6C 006D FE6E"
	$"026F 7070 FE6F FD70 FD6F 1E70 6F73 7347"
	$"211F 2119 0C03 0012 3B2F 2D2C 2C28 2016"
	$"100D 0805 0506 0503 0101 FE02 FE03 0002"
	$"FE01 1E02 0507 0908 0608 100D 55D5 BC8A"
	$"6977 8B9F 4B39 4353 555F 778E A3AB A49F"
	$"9E9F 179E 969A 9F94 8379 7574 6961 5553"
	$"504B 434A 4849 4543 454A 4CFE 4E0D 5152"
	$"5253 5455 5657 5859 595A 5B5D FE5F FE60"
	$"025F 5554 FE56 0257 5858 FE57 FD58 FB57"
	$"195B 5F3A 1617 1C17 0A00 040B 200E 0D10"
	$"110C 0501 0202 0100 0001 02FB 00FE 0300"
	$"02FE 01FF 0011 0204 0301 030A 054C C09F"
	$"6B4B 5A73 8E3A 2935 2045 4A53 677C 8F94"
	$"8C84 7F81 817B 8186 7D6C 655D 5B51 483C"
	$"3B36 3835 3937 3732 2E2D 018F 0C4E 5053"
	$"5455 5859 5A5A 5C5C 5D5E FE5F 0261 6261"
	$"FE5F FE61 0860 5F60 6162 6162 6364 FE65"
	$"0066 FE67 FF66 1B65 6462 6463 4015 100F"
	$"0D0D 0501 041A 433F 4242 413D 352E 2B25"
	$"1B16 13FD 12FD 0FFE 12FF 11FF 1029 0F0D"
	$"0D0E 1013 1619 0D73 C7A8 928C 7B80 B894"
	$"6E4E 4B4A 494F 454E 6695 9998 A2A0 9A94"
	$"8D88 8883 7F80 7F78 1770 6B61 5652 4640"
	$"3D3B 393A 5658 5B5C 5D60 6162 6264 6465"
	$"66FE 6700 69FC 6AFE 6C08 6B6C 6D6E 6F6E"
	$"6F70 6FFE 6D00 6EFE 6FFE 6D1B 6E6D 706E"
	$"4E25 2222 1E19 0C03 0113 372F 2E2D 2D2C"
	$"251E 1B14 0D07 0405 FE04 FD01 FD03 FE02"
	$"FE03 1B04 0609 0D11 0B75 CCB4 A198 8486"
	$"BD98 7253 504E 4C55 4B54 6D9D A2A1 AB17"
	$"A9A3 9C95 908F 8B88 8A88 827A 756B 5E59"
	$"4D47 4442 4041 494B FE4E 0751 5253 5355"
	$"5556 57FE 5802 5A5B 5BFE 5AFE 5C08 5B53"
	$"5354 5554 5556 56FE 5500 56FE 571A 5453"
	$"5355 5458 553E 1F1D 2120 1C0D 0301 0A1D"
	$"0E0F 1212 0B04 0203 03FD 0003 0102 0300"
	$"FE01 FD04 FF03 FC02 0F04 0609 0B00 63B7"
	$"967F 7561 6BA9 8561 4320 4140 414B 3F46"
	$"5B86 8582 8D8C 8782 7C78 7976 7071 6F69"
	$"615C 514A 493A 3532 2F2C 2D01 8F08 5152"
	$"5354 5657 585B 5BFE 5D0C 5E5F 5D5C 5F61"
	$"6160 6162 6362 61FD 6004 6264 6363 65FA"
	$"67FF 6623 6463 6362 461B 0D0F 0E0F 1205"
	$"0109 283F 3E42 4140 3E3A 3631 2A23 1E18"
	$"1312 1313 0F0F 1010 FE0D 2D0F 100F 0D0C"
	$"0C0E 0E10 1418 1B0D 8DD0 A9AD B0AF B3B2"
	$"B8AE 8866 5346 423C 331F 78AC 9A8C 9D9C"
	$"8D88 898A 8B84 8482 7E13 7A7B 7877 716E"
	$"6559 5447 3F59 5A5B 5C5E 5F60 6363 FE65"
	$"0466 6765 6467 FE69 096A 6B6C 6B6A 6969"
	$"6A6A 6CF9 6DFB 6C10 6D6E 6F54 2C20 2422"
	$"211E 0B02 001C 312E 2EFE 2C06 2824 201A"
	$"130E 08FD 05FA 0122 0304 0301 0002 0403"
	$"060A 0F12 0D8F D6B5 BCBD B8BB BCC0 B690"
	$"6E5A 4D48 4239 2680 B5A4 951E A6A4 9590"
	$"9192 928D 8D8C 8783 8481 7F78 756C 605B"
	$"4E46 4C4D 4E4E 4F50 5154 54FE 560D 5758"
	$"5655 585A 5856 5758 5959 5756 FE52 0454"
	$"5656 5556 FD57 FE56 FF52 2354 5558 5C40"
	$"201F 2425 2522 0C02 000D 160E 1011 110A"
	$"0504 0302 0102 0100 0002 0401 0304 06FE"
	$"0317 0405 0403 0405 0403 0406 080A 0078"
	$"BC95 9796 8F98 9FA4 9C77 2057 4439 3D37"
	$"2B14 6998 8477 8989 7B77 797B 7E78 7877"
	$"726E 6F6C 6B64 6159 4E49 3B35 018C 1B51"
	$"5253 5456 5758 5A5B 5C5D 5C5D 5E5F 6060"
	$"6164 6665 6462 6365 6664 65F8 66FD 6725"
	$"6466 6660 5E4E 200D 0C0B 0C0F 130E 031D"
	$"363D 3B3E 4040 413F 3B36 302B 2520 1B15"
	$"1311 1212 1111 FD0C FF0B FF0A 280C 0D0E"
	$"1014 1B1F 175E A69F A4A5 ABAD B5B3 B3AE"
	$"9C8B 7361 594F 357D A99B 7B90 948E 8F8C"
	$"8C89 8385 8786 2680 7E7D 7C79 7473 797A"
	$"7F5E 595A 5B5C 5E5F 6062 6364 6564 6566"
	$"6768 6869 6A6A 6968 6667 696A 6869 FD6A"
	$"FF6B FE6A FD6B 2369 6B6D 6B6B 5D32 2123"
	$"2322 2221 1402 0D27 2E2B 2B2C 2C2D 2C28"
	$"2521 1B15 100D 0806 0404 03FB 02FF 01FF"
	$"001D 0103 0407 0B13 1817 60AB AAB2 B2B4"
	$"B7C1 BFBE B9A6 967C 6860 563D 85B2 A484"
	$"3199 9D96 9794 9490 8C8E 908F 8987 8685"
	$"817B 7A80 8186 654C 4D4E 4E4F 5051 5354"
	$"5556 5556 5758 5959 5A5B 5B5A 5957 585A"
	$"5B57 57F8 59FE 5A1A 5953 5559 585A 4E24"
	$"1A23 2426 2724 1602 0613 110A 0F12 110D"
	$"0A07 04FD 0200 01FE 0003 0304 0507 FD03"
	$"FF02 1401 0304 0302 0003 080B 004A 948F"
	$"918C 8A90 9E9C 9C98 2089 7862 584E 4227"
	$"6E96 8666 7C81 7C7E 7C7D 7C7A 7E7F 7E78"
	$"7675 716A 6666 6D70 7656 019D 2151 5253"
	$"5456 5758 595A 5B5C 5B5B 5E5F 5B56 5052"
	$"524E 4A49 4B4E 4F53 5759 5B5C 5D60 5FFE"
	$"5DFD 5E25 615F 5F50 3227 110A 0808 090E"
	$"1316 1434 383C 3D3B 3E42 4442 3F3C 3831"
	$"2C27 211C 1816 1412 110F FE0B FF0A 000B"
	$"FE0C 2710 1314 181F 221E 1324 4F7B A3A3"
	$"A0A8 A4A4 A8AA A6A1 A09A 9690 A2A0 9B92"
	$"9491 8E8D 8B8C 8A86 8886 8413 837F 807F"
	$"807F 8184 8472 3959 5A5B 5C5E 5F60 6162"
	$"FE63 1464 6768 6560 5B56 514D 4947 494C"
	$"4E54 5659 5B5B 5D5F FD60 FD61 2565 6467"
	$"5B3F 3824 2123 2322 2321 1C12 2025 2B2D"
	$"2A2B 2D2F 2C2A 2A27 231E 1714 110D 0A07"
	$"0502 01FE 0201 0100 FE02 1D03 060A 0C11"
	$"181C 1C14 2758 87AE AAA9 B5B1 B0B4 B6B1"
	$"ACA9 A29E 98AA A9A3 9B37 9D99 9695 9394"
	$"918F 918F 8D8C 8889 8888 8789 8B8B 793F"
	$"4C4D 4E4E 4F50 5152 5354 5554 5457 5754"
	$"4F49 4B4F 4B46 4546 4A4B 484A 4E4F 4F52"
	$"5454 FE53 FE54 1B53 5252 574D 3532 1F1E"
	$"2123 2425 231A 0C13 0F0D 0D0E 1212 100F"
	$"0A07 02FE 01FF 0205 0102 0203 0403 FC00"
	$"FF01 1302 0305 0301 0205 080E 091C 4972"
	$"9289 8691 8E8E 940C 9995 918D 8683 7D8F"
	$"8D87 7E80 7EFE 7C10 7D7E 7B7D 7B79 7874"
	$"7673 7070 7278 7A6A 3301 A21D 5253 5455"
	$"5858 5757 5858 555A 5D58 4C43 392F 2C2B"
	$"2A27 2628 2A2A 2E30 3335 FE37 0439 3A3A"
	$"3937 FE36 123A 3B3A 280F 0E0B 0908 0907"
	$"0B12 1622 3234 3C3E FE3D 4040 4441 3F3B"
	$"3734 2F2A 2421 201E 1C1A 1812 1010 0F0F"
	$"1112 1414 161B 1C1F 2221 2008 0000 1071"
	$"C2AF AA9F A09B 958A 91A1 AEA9 A8AB ACA8"
	$"A09A 988C 878A 8787 8987 8786 3085 8283"
	$"7F7D 838C 8B62 2B23 5A5B 5C5B 5C5E 6062"
	$"6366 6363 645D 4E41 362B 2420 1F1C 1C1D"
	$"1F20 2728 2B2E 2F2F 3031 3232 3130 FE2F"
	$"2736 3838 2D1D 2321 1F20 2321 2222 1F24"
	$"2324 2B2C 2B2D 2E2E 2D2D 2B28 2521 1D19"
	$"1512 0F0E 0C09 0705 04FE 0300 05FE 061C"
	$"090F 1115 1919 1A06 0005 197B C9B7 B7AC"
	$"ACA9 A398 9FAB B7B2 B1B4 B5B0 AA2D A6A2"
	$"9792 9591 9192 9090 8F8E 8C8C 8885 8B93"
	$"9268 312A 4D4E 4F4E 4E4F 4F51 5153 4F53"
	$"5653 463D 342B 292A 2825 2526 FE28 022A"
	$"2C2F FE31 0432 3333 3231 FE30 2633 3435"
	$"2B19 201E 1E20 2422 2121 1D21 160E 0F0B"
	$"0B10 1413 120F 0A06 0403 0102 0302 0203"
	$"0404 0301 FC00 FE02 1103 0505 0608 0913"
	$"0400 0213 6EBA 9E93 8A8C 8920 857C 838B"
	$"9894 9397 9995 8E88 867B 777A 7778 7B78"
	$"7877 7572 726C 6B74 7F82 5A24 1D01 A425"
	$"5253 5456 5958 5655 5254 5458 4F3D 3231"
	$"2A26 2321 2324 2021 2323 2222 2325 2625"
	$"2325 2828 2622 FE21 2E1D 1B1A 160E 0A07"
	$"0909 0C0A 0C13 171D 272E 373D 3E3D 393D"
	$"4443 403C 3B38 3631 2B28 2523 2322 211B"
	$"1718 1716 1718 1A1D FE1E 2421 2320 200B"
	$"0002 000A 89C2 B2AF B0AD A7A2 9DA2 A69C"
	$"888D 9A99 A59E 9A9B 9393 8D8B 8A84 8481"
	$"FF80 2283 8589 8C44 4F38 232A 5A5B 5C5B"
	$"5A5D 5F62 6166 655E 533C 2B24 1912 1010"
	$"1213 1010 1212 FE16 0818 1A18 1716 1717"
	$"1511 FE10 1312 0F0F 151C 221F 1C1B 2122"
	$"2426 2321 2226 282B 2DFE 2E0F 2F2E 2B27"
	$"2523 201D 1814 1110 0F0E 0D0C FE09 0108"
	$"09FE 0A1C 0C10 1015 1716 1706 0009 0913"
	$"90CA BCB9 BABA B4AF AAAC AFA5 9196 A3A1"
	$"B03B ABA7 A79F 9F99 9792 8C8C 8988 888C"
	$"8E91 934B 553E 2931 4D4E 4F4E 4D4E 4F4F"
	$"4D51 5050 4838 2E2D 2724 1F1B 1E1F 1B1B"
	$"1D1E 2122 2223 2523 2221 2222 201D FD1C"
	$"0719 181B 1D1E 1B1D 20FE 23FF 2514 2418"
	$"140F 0B09 0C14 1511 110E 0B09 0603 0405"
	$"0301 00FE 011A 0302 0101 0000 0101 0003"
	$"0406 0A0C 0B11 0400 0908 0F8C B699 989A"
	$"9A20 9791 8E8E 9187 7378 8583 918C 8888"
	$"8080 7A79 7B75 7471 6E6E 7070 757D 3A47"
	$"311B 2101 9F0F 5152 5355 5656 5755 5759"
	$"5347 3328 2420 FE1F 021D 1E1F FD1E 031B"
	$"1C1D 1FFE 2104 2224 2422 1EFE 1D12 1613"
	$"110E 130A 0609 0809 0C10 0F0D 0D15 2536"
	$"38FE 3B40 4044 4442 3F3C 3A38 322C 2927"
	$"2526 2627 211D 1E1D 1C1D 1E1F 2325 2020"
	$"2223 1F1F 0A00 0206 002C ADAC B2B5 B3B1"
	$"B4AD AEAA AB98 9491 8E92 8B8E 9597 9594"
	$"9693 918C 8820 857F 828C 8D47 1432 2927"
	$"2C59 5A5B 5C5C 5D5D 5E5F 625A 4731 2219"
	$"110B 0A0B 0D0E 0FFD 0E03 0F10 1113 FE15"
	$"FE14 0112 0EFE 0D22 0C07 070D 2021 1D1B"
	$"1A1D 2225 1F17 1114 202C 2B2B 2A2C 2E2F"
	$"2F2D 2A27 2522 1E1A 1714 12FE 1325 120E"
	$"0F0E 0C0E 0F0F 1114 1212 1517 1618 0700"
	$"0A10 0833 B5B3 B9BC BAB8 BBB4 B7B3 B4A1"
	$"9D9A 979C 1796 99A0 A2A0 9FA1 9B99 9490"
	$"8D87 8A94 954F 1B38 2E2E 334C 4DFE 4EFF"
	$"500E 4F51 534C 3F2B 211D 1A19 1A19 1819"
	$"1AFC 1902 1A1B 1DFE 1FFE 1E01 1C18 FE17"
	$"4014 100E 1220 1E19 1C1E 1F22 241E 1811"
	$"0D12 170C 0A0A 1113 1112 100D 0A08 0506"
	$"0604 0302 0405 0708 0606 0504 0507 0405"
	$"0806 0608 0A08 0F03 0009 0E03 2DA3 979D"
	$"A1A0 209F A29B 9894 9582 7E7B 787C 7577"
	$"7F81 7F7E 8083 817D 7974 6E71 797B 3A0A"
	$"2B22 1F22 01A2 5850 5152 5253 5558 5A59"
	$"4F3B 2C22 2523 1D1D 1F1D 1A1B 1D1F 1D1C"
	$"1B1A 1A1C 1C1B 1D1E 2022 2220 1B19 1918"
	$"1216 130A 140D 0506 0309 0E06 0200 0101"
	$"0C2B 383C 3939 3F44 4544 423E 3C39 342E"
	$"2B28 2928 2727 2421 2122 2223 2425 2625"
	$"FE22 2321 1D1E 0800 0206 070B 5269 7788"
	$"A1AC B3B5 ADAE ACA9 A9A3 A29D 9A96 8E89"
	$"7F81 8589 8F8E 900E 8F8A 898E 6F1E 2E2A"
	$"2928 2C58 595A 5BFE 5E1E 5D59 4E38 2519"
	$"1813 0A08 0709 0B0B 0D0F 0D0C 0B0E 0E10"
	$"100F 1012 1211 1210 0BFE 092C 0708 0708"
	$"1F22 1A18 161C 2016 0D04 0203 0C27 302F"
	$"2A27 2B2F 302F 2D29 2724 201C 1916 1515"
	$"1414 1310 0F11 1112 13FC 14FF 1617 1419"
	$"0702 080F 1016 596D 7B8C A4AF B5B7 B6B8"
	$"B5B2 B2AC AAA7 3BA5 A198 938A 8C8F 9197"
	$"9597 9792 9196 7725 3430 2E2F 334B 4C4D"
	$"4E50 5153 5351 4732 2218 1C1A 1515 1717"
	$"1516 181A 1817 1618 1819 1A19 1A1C 1C1B"
	$"1C1A 15FE 1321 1011 100D 1F1F 1719 181D"
	$"2015 0D04 0201 0617 1712 0B0B 1012 1312"
	$"100C 0A07 0606 0403 FD05 1A0A 0707 0808"
	$"090A 0908 0807 0708 0705 0D02 0006 0D0C"
	$"114C 5866 778E 2099 A0A1 9798 9692 928D"
	$"8C86 827E 7671 6769 6D77 7E7D 7F7F 7B79"
	$"7D60 1226 2422 2022 01A1 254F 5152 504F"
	$"5558 554A 3626 201F 2320 1C1C 1E1C 1A1B"
	$"1C1B 1A19 1817 191A 1B1B 1C1E 1F21 211F"
	$"1BFE 190A 1618 150A 1210 0405 010C 0CFB"
	$"0045 1235 3E38 373E 4144 4341 3F3B 3936"
	$"312E 2D2B 2926 2425 2423 2426 2627 2827"
	$"2425 2222 211E 1C0B 0001 0308 0B24 2A34"
	$"3D4E 6479 8E96 A3A6 ACAE AAA7 A7A6 9F9B"
	$"9790 8B82 7A80 7E7E 3084 8B89 9271 3126"
	$"2428 252C 5759 5A5A 5C5C 5B53 442E 1A11"
	$"1011 0D06 0507 080A 0B0C 0B0A 0908 090B"
	$"0C0C 0D0E 0F0F 1111 0F0B FD09 0A08 0706"
	$"1C24 1817 131B 1805 FE02 2201 0012 3135"
	$"2A26 292C 2F2E 2C2A 2623 2320 1C1B 1916"
	$"1311 1313 1213 1415 1516 1413 1714 FE15"
	$"161A 0C03 0A0F 1516 2B2F 393F 5063 778C"
	$"9EAD AFB5 B7B3 B0B0 26AE A7A4 A098 938B"
	$"8489 8787 8C93 9099 7838 2C2B 2D2C 334A"
	$"4C4D 4D4E 5153 4E42 2E1B 1515 1917 1313"
	$"FE15 0B16 1716 1514 1313 1516 1717 18FE"
	$"1A02 1B19 15FE 13FF 123E 100C 1D22 1617"
	$"141C 1906 0201 0103 0008 1E1D 100B 0D0F"
	$"1211 0F0D 0906 0809 0606 0705 0302 0908"
	$"0809 0A0B 0B0A 0706 0806 0706 060B 0400"
	$"070E 1313 2321 282F 3F20 5265 7880 8E91"
	$"9799 9592 8F8B 8581 7D76 7169 656C 6B6D"
	$"747B 7B84 6629 2020 211C 2101 9B17 4F50"
	$"5150 524F 453A 2F22 1D1E 2121 1D15 171B"
	$"1919 1B1B 1A1A FE18 0019 FD1A FF1C FF1D"
	$"001B FC18 091A 180B 0B0F 0303 080F 04FB"
	$"0013 011C 3C3A 3638 3C40 4242 403E 3B38"
	$"312E 2E2C 2A26 FD24 0026 FE28 0027 FE25"
	$"2524 2221 1E1C 0E00 0101 0207 1C17 191E"
	$"2329 3442 4856 6A7D 8D9D A2A7 A7A3 A19E"
	$"9B6E 738E 8883 792F 7A8A 8C79 3F20 211D"
	$"211E 2A57 5859 595C 5445 3524 140D 0C0F"
	$"0E09 0202 0707 0A0B 0B0A 0A08 0807 0809"
	$"0908 090B 0C0D 0D0B FD08 FF09 0807 0514"
	$"2214 1319 1B0B FE01 FF02 1401 031C 3830"
	$"2825 272B 2D2D 2B29 2524 201C 1C1A 1713"
	$"FD11 2213 1515 1414 1315 1817 1615 161A"
	$"1004 0D0F 0F13 2520 1F22 2529 313F 505F"
	$"7286 96A5 ABAF 35AD AAA7 A4A1 747A 9792"
	$"8C81 8292 9380 4525 2723 2725 314A 4B4C"
	$"4C4F 4B40 3428 1B15 1719 1915 0E10 1313"
	$"1516 1615 1513 1312 1315 1514 15FE 1601"
	$"1715 FD12 FF13 2311 0C16 2013 1218 1C0D"
	$"0201 0001 0400 000F 261B 120B 090E 1010"
	$"0E0C 0809 0805 0605 0502 01FE 0700 09FE"
	$"0A13 0804 0508 0605 0404 0905 0009 0F0F"
	$"1322 1615 1718 201A 212D 3645 586C 7C8B"
	$"9192 8E8B 8885 8255 5B77 716E 676A 7C80"
	$"6F37 1A1E 1A1C 151D 019A 194E 4F50 534C"
	$"382B 1E1B 191A 1B1F 1F17 1112 1617 1919"
	$"1B1A 1817 17FD 1901 1A1B FE1C 011D 1BFD"
	$"18FF 1A23 1810 070F 0906 0C07 0002 0303"
	$"0102 090E 183A 403A 363A 3E43 4443 413F"
	$"3A33 2F2F 2D2B 2825 FE23 0026 FE28 2927"
	$"2525 2627 2421 1D1A 0B00 0101 0303 1A1B"
	$"1111 141C 2221 1C20 2631 3E55 667A 8996"
	$"9EA0 9E79 6B99 6A57 8A22 8D8E 843E 1C1A"
	$"1C17 1715 1856 5758 5950 3928 160F 0A09"
	$"090D 0D06 0002 0707 0909 0B0A 08FA 0705"
	$"0809 0A0D 0D0B FD08 2509 0808 090D 201A"
	$"161B 1101 0100 0102 0109 111C 3A3C 3125"
	$"2429 2E2F 2E2C 2A27 221E 1D1B 1915 13FE"
	$"0F00 12FD 151D 1415 181A 1916 151B 0E09"
	$"0F0F 1111 2627 1C19 181D 1F1F 2328 2D38"
	$"465C 6E80 2F8E 9AA2 A5A3 7D70 A374 6092"
	$"9595 8B44 221F 211C 1D1B 1F49 4A4B 4C46"
	$"3326 1A17 1517 171B 1912 0B0C 1112 1414"
	$"1615 1312 12FC 1305 1516 1516 1715 FD12"
	$"FF13 0912 1010 1F19 141A 1102 02FE 0016"
	$"0208 0B13 2E2C 200D 060C 1112 110F 0D0B"
	$"0805 0605 0402 00FE 0300 06FE 0813 0704"
	$"0408 0907 0402 0702 000B 1012 1225 2316"
	$"110D 200F 120F 1015 1A25 3249 5A6A 7482"
	$"8A8C 8A65 5781 5241 787E 817A 3617 181B"
	$"1612 0B0C 01A3 254D 4E50 4A32 1D1F 1B18"
	$"1616 181E 1B14 0E10 1516 1819 1918 1816"
	$"1619 1917 1618 1A1B 1B1A 1B19 17FE 1824"
	$"1A1B 1916 0D0D 0805 0200 0004 0503 0109"
	$"1116 152E 3938 393A 3B40 4343 4241 3C34"
	$"3030 2E2C 28FD 2600 28FE 2929 2825 2526"
	$"2625 2321 1909 0203 0103 010C 1311 140E"
	$"1521 2019 1D1C 1C1E 212A 323C 4A57 6471"
	$"8289 8E82 7589 308B 8A51 1B1E 1E1A 1A16"
	$"1310 5556 594E 3019 1811 0C09 0607 0C0B"
	$"0500 040B 0907 0909 0808 0606 0707 0504"
	$"0608 090A 0B0B 0907 FE08 250A 0708 0E12"
	$"1C17 140E 0501 0100 0101 030E 181A 333A"
	$"342A 2426 2B2E 2E2D 2C29 2320 1E1C 1A17"
	$"14FE 1100 13FD 1501 1415 FE19 1818 191B"
	$"0F0D 1211 120F 1B23 201F 1418 211F 1F24"
	$"2223 2428 3036 1D3F 4D5A 6774 848C 978D"
	$"7E91 9391 5822 2423 1F1E 1B19 1748 494B"
	$"4228 161A 18FE 171A 161C 1910 0A0D 1312"
	$"1214 1413 1311 1113 1311 1012 1415 1514"
	$"1513 11FE 120B 1412 1215 141C 1713 0D04"
	$"0101 FE00 1602 0C13 1329 2D28 1406 090E"
	$"1111 100F 0D08 0506 0504 0200 FE04 0006"
	$"FE07 0506 0303 0607 06FE 05FF 0008 0D10"
	$"1311 1C23 1D1A 0D20 0C14 1011 1614 1517"
	$"1A23 252B 3947 5460 7177 746A 5F77 7C7E"
	$"4816 1C1C 1918 1109 0300 00FF"
};

resource 'PICT' (130) {
	902,
	{0, 0, 75, 165},
	$"0011 02FF 0C00 FFFE 0000 0048 0042 0048"
	$"0042 0000 0000 004B 00A5 0000 0000 00A1"
	$"01F2 0016 3842 494D 0000 0000 0000 004B"
	$"00A5 4772 8970 68AF 626A 0001 000A 0000"
	$"0000 004B 00A5 009A 0000 00FF 8294 0000"
	$"0000 004B 00A5 0000 0004 0000 0000 0048"
	$"0042 0048 0042 0010 0020 0003 0008 0000"
	$"0000 0000 0000 0000 0000 0000 0000 004B"
	$"00A5 0000 0000 004B 00A5 0040 0008 81CE"
	$"81CE 81CE 92CE 0008 81CE 81CE 81CE 92CE"
	$"0008 81CE 81CE 81CE 92CE 0008 81CE 81CE"
	$"81CE 92CE 0008 81CE 81CE 81CE 92CE 0008"
	$"81CE 81CE 81CE 92CE 0008 81CE 81CE 81CE"
	$"92CE 0008 81CE 81CE 81CE 92CE 0008 81CE"
	$"81CE 81CE 92CE 0008 81CE 81CE 81CE 92CE"
	$"0008 81CE 81CE 81CE 92CE 0008 81CE 81CE"
	$"81CE 92CE 0008 81CE 81CE 81CE 92CE 0008"
	$"81CE 81CE 81CE 92CE 0008 81CE 81CE 81CE"
	$"92CE 0008 81CE 81CE 81CE 92CE 0008 81CE"
	$"81CE 81CE 92CE 0008 81CE 81CE 81CE 92CE"
	$"0008 81CE 81CE 81CE 92CE 0008 81CE 81CE"
	$"81CE 92CE 0008 81CE 81CE 81CE 92CE 0008"
	$"81CE 81CE 81CE 92CE 0008 81CE 81CE 81CE"
	$"92CE 0008 81CE 81CE 81CE 92CE 0008 81CE"
	$"81CE 81CE 92CE 0008 81CE 81CE 81CE 92CE"
	$"0008 81CE 81CE 81CE 92CE 0008 81CE 81CE"
	$"81CE 92CE 0008 81CE 81CE 81CE 92CE 0008"
	$"81CE 81CE 81CE 92CE 0008 81CE 81CE 81CE"
	$"92CE 0008 81CE 81CE 81CE 92CE 0008 81CE"
	$"81CE 81CE 92CE 0008 81CE 81CE 81CE 92CE"
	$"0008 81CE 81CE 81CE 92CE 0008 81CE 81CE"
	$"81CE 92CE 0008 81CE 81CE 81CE 92CE 0008"
	$"81CE 81CE 81CE 92CE 0008 81CE 81CE 81CE"
	$"92CE 0008 81CE 81CE 81CE 92CE 0008 81CE"
	$"81CE 81CE 92CE 0008 81CE 81CE 81CE 92CE"
	$"0008 81CE 81CE 81CE 92CE 0008 81CE 81CE"
	$"81CE 92CE 0008 81CE 81CE 81CE 92CE 0008"
	$"81CE 81CE 81CE 92CE 0008 81CE 81CE 81CE"
	$"92CE 0008 81CE 81CE 81CE 92CE 0008 81CE"
	$"81CE 81CE 92CE 0008 81CE 81CE 81CE 92CE"
	$"0008 81CE 81CE 81CE 92CE 0008 81CE 81CE"
	$"81CE 92CE 0008 81CE 81CE 81CE 92CE 0008"
	$"81CE 81CE 81CE 92CE 0008 81CE 81CE 81CE"
	$"92CE 0008 81CE 81CE 81CE 92CE 0008 81CE"
	$"81CE 81CE 92CE 0008 81CE 81CE 81CE 92CE"
	$"0008 81CE 81CE 81CE 92CE 0008 81CE 81CE"
	$"81CE 92CE 0008 81CE 81CE 81CE 92CE 0008"
	$"81CE 81CE 81CE 92CE 0008 81CE 81CE 81CE"
	$"92CE 0008 81CE 81CE 81CE 92CE 0008 81CE"
	$"81CE 81CE 92CE 0008 81CE 81CE 81CE 92CE"
	$"0008 81CE 81CE 81CE 92CE 0008 81CE 81CE"
	$"81CE 92CE 0008 81CE 81CE 81CE 92CE 0008"
	$"81CE 81CE 81CE 92CE 0008 81CE 81CE 81CE"
	$"92CE 0008 81CE 81CE 81CE 92CE 0008 81CE"
	$"81CE 81CE 92CE 0008 81CE 81CE 81CE 92CE"
	$"0008 81CE 81CE 81CE 92CE 00FF"
};

resource 'PICT' (131) {
	40710,
	{0, 0, 98, 137},
	$"0011 02FF 0C00 FFFE 0000 0048 0000 0048"
	$"0000 0000 0000 0062 0089 0000 0000 00A1"
	$"01F2 0016 3842 494D 0000 0000 0000 0062"
	$"0089 4772 8970 68AF 626A 0001 000A 0000"
	$"0000 0062 0089 009A 0000 00FF 8224 0000"
	$"0000 0062 0089 0000 0004 0000 0000 0048"
	$"0000 0048 0000 0010 0020 0003 0008 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0062"
	$"0089 0000 0000 0062 0089 0040 018A 4069"
	$"6768 6765 6665 6666 6567 6668 6866 6464"
	$"635F 5F60 6061 6061 5F60 5F5D 5D5C 5A5B"
	$"5C5D 5E5D 5D5B 5A5A 5D5C 5B5B 6062 6264"
	$"6867 6664 6463 6364 6261 5E5D 5C5D 5C5B"
	$"FD5D 005B FE5A FF59 075A 5B5A 5A5B 5C5B"
	$"5AFE 5BFF 5AFE 5CFD 5BFE 5C00 5BFC 5C04"
	$"5D5C 5D5F 5EFE 5F06 6265 6768 6B6C 6EFE"
	$"6F05 6C69 6768 6766 1465 6769 6765 6462"
	$"6263 8E8C 8D8E 8D8D 8C8B 8B8A 8C8B FE8D"
	$"FE8B FE88 0487 8887 8886 FE87 0686 8585"
	$"8687 8687 FE86 FF85 0483 8487 8686 FE89"
	$"1E8D 8C8C 8B8B 8A8A 8B89 8A88 8786 8786"
	$"8685 8484 8584 8383 8584 8584 8584 8485"
	$"FE84 FC85 FE87 FD86 FE87 0086 FC87 0288"
	$"8787 FE88 FF86 0689 8C8E 8F92 9294 FE95"
	$"1D92 908E 8F8E 8D8C 8E90 8E8C 8C8B 8B8C"
	$"DFDC DADB DCDC DBDC DDDB DCDB DDDD DCFE"
	$"DAFE D704 D6D7 D6D7 D5FE D609 D5D4 D3D4"
	$"D5D5 D6D5 D5D4 FDD3 15D5 D3D3 D6D6 D7DB"
	$"DAD9 D8D8 D7D7 D8D6 D7D4 D3D2 D3D2 D1FE"
	$"D313 D4D3 D2D2 D3D2 D3D1 D1D0 D1D3 D4D3"
	$"D0D1 D1D2 D3D3 FED5 03D4 D3D2 D2FE D302"
	$"D2D4 D6FE D505 D6D5 D5D7 D7D6 FFD3 14D6"
	$"D9DB DDDE DDDF E0DE DEDB DBDC DCDB DCDB"
	$"DDDD DBD9 FEDA 00DB 0186 046D 696B 6866"
	$"FD69 0268 6766 FD67 0166 64FD 610B 6261"
	$"6261 6160 5D5E 5E5A 5A5D FC5C FF5A 215C"
	$"5D5D 5F62 6263 6667 6766 6564 6261 6362"
	$"6260 5E5D 5E5D 5D5E 5D5E 5B5C 5B5B 5958"
	$"59FD 5BFF 5A04 5B5A 5B5B 5AFD 5905 5A5B"
	$"5C5B 5A5A FE5B FF5C 005B FD5C 155D 5F5E"
	$"5F60 6263 6566 676B 6D6E 6F70 6F6B 6A69"
	$"6767 6900 66FE 671D 6664 6362 6492 8E90"
	$"8E8D 9090 8E8E 8D8D 8C8D 8F8E 8D8D 8C8A"
	$"8B89 8889 8889 FE88 FE87 FF85 0088 FC87"
	$"0086 FE85 0587 8889 898A 8BFD 8C10 8B89"
	$"888A 888A 8A88 8788 8787 8584 8483 85FE"
	$"8401 8384 FD85 FF83 FF84 FE85 FD84 0585"
	$"8687 8685 85FE 86FF 8700 86FD 870C 8688"
	$"8788 8789 8A8C 8D8E 9293 9409 9596 9591"
	$"9190 8E8E 908D FE8E 108D 8C8C 8B8D E3DE"
	$"DCDB DDDF DFDE DEDC DDDC FEDD FFDC 07DB"
	$"D9DA D8D7 D8D7 D8FE D7FE D6FF D300 D6FC"
	$"D509 D4D3 D3D4 D6D6 D5D6 D7D9 FEDA 07D9"
	$"D8D6 D5D7 D6D7 D6FE D4FF D30B D4D3 D3D2"
	$"D4D3 D3D2 D1D2 D2D0 FED1 01D2 D3FD D1FD"
	$"D205 D3D4 D4D2 D1D1 FED2 02D4 D5D4 FCD5"
	$"02D7 D6D6 1AD4 D6D7 D9DA DBDE DDDF E0DF"
	$"DEDA DCDD DBDB DEDC DDDC DBDA DADB DADC"
	$"0182 0B6D 6A6C 6A6B 6C6B 6B6A 6A67 65FE"
	$"6604 6766 6362 62FC 630D 6261 605F 5D5E"
	$"5B5C 5C59 5A5A 5B5A FE5B 0C5E 6163 6464"
	$"6568 6968 6766 6563 FE62 0261 5F5E FD5D"
	$"FF5F 015E 5CFE 5BFE 59FD 5BFF 5A04 5B5A"
	$"5B5A 5BFD 5913 5A5B 5A5A 5B58 5A5B 5B5C"
	$"5C5B 5C5C 5E5D 5E5F 5F60 FE62 FF64 0266"
	$"6B6C FE6E 066C 6B6A 6967 6869 0F67 6668"
	$"6867 6663 6264 928F 9191 9293 92FE 90FD"
	$"8F02 8D8E 8CFD 8BFD 8A00 89FE 8813 8687"
	$"8587 8786 8788 8985 8686 8788 8889 8B8B"
	$"8C8C FD8D 018C 8AFE 89FF 8A02 8987 88FE"
	$"87FF 85FB 84FD 8507 8483 8384 8485 8485"
	$"FD84 1285 8685 8586 8385 8686 8787 8687"
	$"878A 8987 8888 FD89 FF8B 038D 9192 941C"
	$"9493 9291 9090 8E8F 908E 8D8F 8F8E 8E8C"
	$"8B8E E4DF DDDD E2E2 E1DE DCDC DDFE DE02"
	$"DCDD DBFD DAFD D900 D8FE D70E D5D6 D4D5"
	$"D5D3 D4D5 D6D3 D4D4 D5D6 D7FE D800 D9FC"
	$"DB08 D9D8 D5D6 D7D7 D5D4 D3FE D4FF D50E"
	$"D4D3 D4D3 D4D2 D2D4 D3D0 D1D1 D2D2 D3FE"
	$"D000 D1FD D210 D3D4 D2D1 D2CF D1D2 D2D4"
	$"D5D4 D5D5 D7D7 D6FE D7FE D6FF D80C DADD"
	$"DDDF DFDC DBDA DBDD DBDC DFFE DD00 DCFE"
	$"DB01 DADD 018D 166F 6D6C 6D6E 6D6D 6E6D"
	$"6C69 6768 6765 6664 6365 6463 6163 FE62"
	$"0861 6260 5F5E 5F5E 5F5D FD5C 0F5B 5A5C"
	$"5F60 6466 6667 686A 6B6C 6867 66FE 64FF"
	$"6205 6362 605F 605E FD5D FD5C 0159 5AFE"
	$"5C06 5B5C 5C5A 5A59 5AFD 5B09 5C5B 5959"
	$"5A59 5A5B 5B5C FE5D 015F 61FE 600F 6163"
	$"6566 6566 686A 6B6B 6D6D 6C6B 6A6B FE6A"
	$"0069 FE68 0A69 6867 6565 6895 9392 9395"
	$"FE94 0192 91FE 9010 8F8D 8E8D 8B8D 8C8B"
	$"8B8C 8C8A 8A89 8A89 88FB 87FE 86FF 8402"
	$"8789 89FE 8B04 8D8F 8F8E 8FFE 8DFE 8BFE"
	$"8925 8887 8687 8788 8887 8685 8484 8686"
	$"8584 8485 8584 8384 8583 8384 8485 8485"
	$"8584 8586 8584 8585 FE86 0187 88FD 890A"
	$"8A8C 8C8D 8C8D 8E90 9190 92FF 9301 9290"
	$"FD91 0090 FE8F 0D90 8F8F 8D8D 8FE7 E2E1"
	$"E3E4 E3E3 E1FD DE11 DFDE DDDD DCDA DBDB"
	$"DADA DBDB DADA D9DA D8D7 FDD6 FDD5 0ED4"
	$"D3D2 D5D8 D8D9 D9DA DAD7 DADC DDD8 FED7"
	$"08D8 D9D5 D5D7 D7D6 D4D4 FED3 29D4 D2D1"
	$"D1D2 D3D1 D2D2 D1D2 D2D1 D0D1 D1D2 D3D4"
	$"D3D0 D2D4 D4D2 D2D4 D3D1 D3D2 D4D5 D4D5"
	$"D6D8 D7D8 D8D9 DA0E D9DA D9DB DBDD DEDD"
	$"DFE0 DFDD DCDE E0FE DF08 DEDD DDDE DDDD"
	$"DCDC DE01 8A54 716E 6C6D 6F6D 6E6D 6A69"
	$"6768 6766 6261 6263 6564 6360 6161 6262"
	$"6161 6261 6262 6161 5F5E 5D5D 5E5D 5C5E"
	$"6061 6466 686B 6C6B 6968 6867 6665 6462"
	$"5E5E 5D5D 5C5C 5B5C 5C5D 5C5A 5757 5A5B"
	$"5653 5254 5555 5658 5A5A 59FD 5AFE 5B00"
	$"5AFC 5B00 5CFE 5D00 5FFE 6207 6162 6264"
	$"6668 6667 FE6B FF6D 086C 6D6C 6A6A 6C6B"
	$"6A69 0169 6AFE 68FF 69FF 680E 9795 9294"
	$"9694 9593 908F 8E90 8F8E 8BFB 8C00 8BFD"
	$"8C24 8B8A 8B8A 8B89 8888 8787 8686 8785"
	$"8486 888A 8B8B 8D90 9293 9294 9390 908D"
	$"8C8A 8888 8788 86FE 85FF 84FF 860A 8382"
	$"8082 8081 8283 8482 83F8 85FE 84FF 8503"
	$"8684 8485 FE86 1087 8889 888A 8B8B 8C8D"
	$"8F8D 8D8F 9090 9292 0A92 9493 9191 9392"
	$"9190 9091 FE8F FF90 FF8F 0FE9 E2E2 E5E4"
	$"E3E4 E2E0 DEDE DFDF DEDB DBFD DC01 DBDA"
	$"FCDB FFDA 3AD9 DAD8 D7D7 D6D6 D5D5 D6D4"
	$"D3D6 D8D9 DAD9 DBDD DCDE DFDD D9D9 DADA"
	$"D9D7 D7DA D8D7 D6D4 D1D2 D4D4 D6D5 D2D1"
	$"D1D3 D0CE CED0 D1D0 D2D4 D3D0 CED1 D6D4"
	$"FCD3 09D4 D3D4 D3D3 D4D5 D5D6 D6FE D803"
	$"D9DA DADB 06DA DCDA DADD DEDE FEE0 09E1"
	$"E0DE E0E3 E1E0 DFDF E0FE DEFF DFFF DE01"
	$"9401 726F FE6C FF6B 0F68 6665 6463 6262"
	$"5F60 5F61 6062 6261 60FE 5F3D 5E5F 6263"
	$"6262 6363 615F 605F 6061 5F60 5F61 6267"
	$"6969 6C6A 6665 696D 727C 8186 8F98 9DA2"
	$"A9AB ABAF B0B0 AFB0 ADAE A8A7 A29C 9890"
	$"887C 7268 655E 5756 5758 FE59 1C5B 5C5D"
	$"5E5E 5C5C 5D5D 5E60 6162 6362 6161 6264"
	$"6867 686A 6B6C 6B6D 6E6D FE6C 046B 6C6B"
	$"6B6A 0469 6A69 6869 FD68 1598 9693 9292"
	$"9192 9190 8E8E 8D8B 8C8C 8D8B 8B89 8C8D"
	$"8CFC 8B06 898A 8C8B 8A89 89FD 88FF 890B"
	$"8889 898A 8A8D 8F8F 9190 908F FE90 0997"
	$"9DA3 A5AB B2B4 B5B7 B7FE B813 BABD BABB"
	$"B6B7 B5B2 AFA6 9F99 938D 8883 8081 8282"
	$"FE83 0084 FE85 1786 8585 8686 8788 8989"
	$"8A89 8A8A 8B8C 8F8E 8F8F 9091 9091 9200"
	$"92FE 9316 9293 9292 9190 9190 8F90 8F8F"
	$"8E8F EAE3 E2E3 E1E0 E1E1 E0FE DFFF DDFF"
	$"DB04 DADC DCDD DDFB DA03 D8D9 DADA FED8"
	$"FDD7 0DD8 D9D7 D8D8 D9D9 DBDD DFE0 DDDA"
	$"DBFE DE00 DDFE E001 E4E7 FEE6 01E3 E1FE"
	$"DF1B E2DF E1E5 E6E3 E0E1 DCDB DAD6 D3D2"
	$"D0CD CFD2 D4D4 D3D3 D4D2 D1D2 D2D4 FED5"
	$"09D6 D7D8 D8D9 D8D9 D9DA DA08 DCDB DCDD"
	$"DEDF DEDF E1FC E00C E2E1 E1E0 DFE0 DFDE"
	$"DFDE DEDD DE01 9A0F 706D 6867 6867 6562"
	$"6263 6261 6060 5F5F FE5E 055F 6060 5F5E"
	$"5EFE 5DFF 605B 5E5F 5F61 605F 6061 6261"
	$"5E61 5F5D 5D65 6C78 8694 9FAB B3B9 BFC4"
	$"C7C4 C2BF B7B5 B3AC A7A6 A59A 9DA7 A7A8"
	$"AEAF B0B3 B5B9 BAC1 C2BE B8AD ACA4 958A"
	$"7B6A 5F57 575A 5D5E 5B5C 5E5D 5D5E 6061"
	$"6061 6262 6363 6666 686A 6C6D 6C6B 6C6D"
	$"6C6B FE6C 026B 6A6A 0F69 6A69 6768 6766"
	$"6568 9795 908E 908F 8EFE 8C01 8D8C FD8B"
	$"028A 8989 FE8B 0189 88FE 8A44 8889 8988"
	$"8889 8A89 898B 8B8A 8C8A 8A88 8785 888C"
	$"959D A9B3 BCC0 C4C8 CDCF CCCB C9C1 BEBA"
	$"B3AF ADAC A3A3 A8A9 A9B0 B3B6 BABE C4C3"
	$"C7CA CAC4 BABB B7AC A092 8A84 8182 8284"
	$"85FD 8612 8889 898A 898A 8A8B 8C8B 8E8E"
	$"8F90 9292 9191 92FF 9300 92FE 930D 9291"
	$"9190 9190 8F90 908E 8E90 E9E3 FEE0 00DF"
	$"FDDE FFDF 03DE DDDB DCFE DB04 DDDC DAD9"
	$"D8FE D905 D8D9 D9D8 D8D9 FEDA 04D9 DADA"
	$"D9D6 FDD7 32DA DCE0 DDE2 E7E9 E4E1 DEDC"
	$"DAD3 CCC4 B6B4 B5AC A7A2 9F98 999E 9D9E"
	$"A8A9 ACAF B4C0 C4CD D5D9 DBD9 E0E1 DDD9"
	$"D4D5 D3D2 D3D3 D2D1 FDD4 09D6 D9DB D9D7"
	$"D8D9 DADB DAFF DC18 DDDE DFE0 DFDF E0E0"
	$"E1E0 E1E1 E2E1 E0E0 DFE0 DFDE DFDE DDDC"
	$"DF01 9105 6664 6162 6361 FE5F FE60 0E61"
	$"6262 6160 605F 5F60 6161 605E 5D5D FE5E"
	$"075D 5A5B 5C5D 5E5D 5DFE 5A4D 6778 91A4"
	$"AFBB C3CC C5BC B1A4 9F9A 9AA4 A07C 99A4"
	$"97AB AE97 A9B3 8D87 ADA7 A4B2 A99D AFA2"
	$"7190 9D92 9398 98A4 B1BC C0C4 C5BC AF9F"
	$"8670 5F58 5756 5A5E 5F61 605D 5F62 6564"
	$"6364 6465 686B 6C6B 6C6C FB6B FF6A 006B"
	$"FF6A 0C66 6566 6564 6465 918F 8C8B 8D8B"
	$"FE89 FE8A 078B 8C8C 8B8A 8A89 89FE 8AFF"
	$"89FC 88FF 8701 8889 FE8A 0089 FE86 4D8A"
	$"93A3 B2BD C6CB D2CC C2B4 A5A3 9E98 A39E"
	$"7794 9D8D 9FA3 8B9D A985 7DA0 9C99 AAA1"
	$"95A6 9E73 8F99 8E8E 989A A4B2 BFC8 CECA"
	$"C3BB B3A2 9489 8182 8587 8889 8B8B 898B"
	$"8C8D 8D8C 8D8D 8E90 9393 9293 93FB 92FF"
	$"910F 9291 918F 8E8F 8E8F 8F90 E4DE DCDF"
	$"DFDD FEDB 0ADC DDDE DFDF DEDD DCDC DBDB"
	$"FEDC 56DA D8D7 D7D9 DADA D9D8 D9DA D7D6"
	$"D7D7 D6D6 D5DE E1E4 E5E0 E0DC DCCF C0AD"
	$"9C94 8A80 8785 6278 786B 7F7D 6A79 8062"
	$"607D 7373 837A 6E7D 7954 727B 7479 8489"
	$"98AB BDC8 D2DA DDDA DFDB D5D4 D5D4 D3D4"
	$"D6D6 D8D8 D6D7 DADD DCDB FFDC 07DD DEDF"
	$"E0DF E0E0 DFFC E1FF E005 E1E0 E0DE DDDE"
	$"FEDD 00DE 019A 1160 5E5C 5E5F 5F5D 5D5F"
	$"5F5D 5E5F 6160 605F 5FFD 6007 6160 5F5D"
	$"5D5E 5D5C FD5D 475A 585C 6D85 A0AF C2CA"
	$"C5BC AFA1 A08E 90A2 A0A8 BCB2 A9BD B770"
	$"96B4 A3BE C2A2 AABB 9190 BBB0 ABC4 BCAC"
	$"C4B5 77AF C1AB B8CC B1A6 B396 7699 8F91"
	$"A6B5 C2C8 C4AD 9B7F 685C 5C5E 6163 63FE"
	$"640C 6365 6564 6467 6A6B 6D6C 6A6B 6CFE"
	$"6BFF 6C00 6B0B 6A69 6766 6665 6364 648D"
	$"8C8A FE89 FF87 FF89 0787 8889 8B8A 8A89"
	$"89FE 8AFE 8900 8AFE 8801 8786 FE87 4888"
	$"8784 828C 9BB1 BCC9 CEC9 BEAE A4A5 918E"
	$"9C96 9BB0 A79C B2AF 688D A996 B0B4 949F"
	$"B38B 83AA 9F9B B6AE 9DB7 AE71 A4B3 9CA9"
	$"BFA4 99A8 9170 9496 9BAE BDC9 CDCA C0B2"
	$"9889 8486 8A8B 8C8C FE8D 058C 8E8E 8D8E"
	$"91FE 9400 9302 9192 93FE 92FF 9301 9291"
	$"FE90 058F 8E8E 8F8F E3FE DDFF DBFF D9FE"
	$"DBFF DD04 DEDC DCDB DBFE DC05 DBDC DBD9"
	$"D7D7 FDD9 4ED7 D8D8 DAD8 D5DB E0E5 E2DF"
	$"D8CA BAA4 928E 7A79 8074 798A 7D72 8482"
	$"4668 7B69 8282 6672 8361 6182 7270 877D"
	$"6D85 7F4A 7E86 707E 937A 7080 6E5B 8382"
	$"8AA3 B7CC DADF DDDE D6D3 D4D7 DBD5 D7D6"
	$"DBDD DCDB FFDD 09DC DADD E0E1 E1E0 DEE2"
	$"E2FE E1FF E201 E1E0 FEDF 04DE DDDC DDDD"
	$"018E 6C5F 5D5B 5D5E 5F5D 5E5F 5F5E 5E5D"
	$"6060 5F61 5F61 6060 5F60 605E 5F5E 5E5D"
	$"5B5A 5959 6177 9BBA D6D4 BEB3 A096 A6A9"
	$"96AE B982 7DB5 ADA9 BFB4 ABBF BB70 87AE"
	$"97A9 BC9B A4BC 9284 AB9D 9EB5 A49F B49D"
	$"6EAE B9A2 BECA A7B3 C792 7FC0 C1AE BAAD"
	$"948B 8D9B B4CF CFB7 9275 6661 6264 6263"
	$"FE65 FE63 0265 686D F86C 006B 7F6A 6969"
	$"6766 6563 6565 8C8B 8A89 8889 8788 8989"
	$"8888 878A 8A89 8B88 8B8A 8988 898A 8A89"
	$"8888 8787 8683 8288 91A8 C0DA D9C3 B6A4"
	$"98A2 A28F A4B0 8479 A99F 9CB2 A89F B8B9"
	$"6C80 A58B 9CB0 8E99 B38B 799E 9191 A896"
	$"92A9 9867 A1AB 95B2 BD99 A5BC 8A74 B5B2"
	$"9FAE A591 8B92 A8C0 DAD8 C4AA 958B 898B"
	$"8C8B 8D8F 8E8F 8D8E 8F92 9294 93F9 93FF"
	$"9275 9092 908F 8F8E 9090 E4DE DFDE DADB"
	$"D9DA DCDB DCDC DBDD DDDB DDDB DDDC DBDA"
	$"DBDB DAD9 D7D9 DAD9 D8D5 D3D8 D8DE E1EA"
	$"DABD A693 8285 816B 7E87 5F5F 8A78 7687"
	$"7A76 888B 4B5E 7A61 6F7F 616D 8463 5674"
	$"6266 7D6A 667A 6C45 7F82 6984 906B 758B"
	$"6357 8F87 7789 8478 7C89 A3C0 E0E8 DFD7"
	$"D3D5 D3D6 DCDC DBDC 09DC DDDC DBDB DEDF"
	$"E1E0 E0FA E2FF E107 DFE1 DFDE DEDC DEDE"
	$"0199 FF62 7361 5F5F 5E5E 5F60 5F5F 615D"
	$"5F61 6060 6160 6061 615F 5D5E 5C5A 5959"
	$"606F 92AB C7C9 C3BA A897 769C A894 B1B6"
	$"A0AB BB9C 67A2 AC9F BAB2 9BAD B077 7FBB"
	$"A3A6 BFA4 AABD 9887 B6A9 A6C1 B1AA C398"
	$"6EAE B29A B9C0 9BB2 B86D 8AC6 BFAC C5C1"
	$"B0C2 B676 8B97 95A3 B7CC C3AE 8C6B 6262"
	$"6566 6768 6667 696B 6EFE 6D02 6E6F 6FFE"
	$"6E00 6C17 6B68 6867 6766 6464 658C 8C8B"
	$"8A8C 8A8A 898A 8989 8B87 898B FE8A FD89"
	$"568B 8A8A 8988 8883 838A A3BD D3CB C2BD"
	$"AC9B 7997 9F8C A7AC 949E AF99 649B 9F93"
	$"AFA8 93A5 A970 75AB 9499 B297 99AE 8D7A"
	$"A79C 99B2 A29C B692 69A1 A28A AAB4 90A6"
	$"B069 81BC B39E B8B4 A1B3 AA76 8E9A 9BA8"
	$"BAD1 D0C1 A491 8B8B FD8F 0590 9193 9495"
	$"94FF 9402 9596 96FD 9504 9491 9190 90FE"
	$"8F00 90FE E2FF DFFE DD06 DEDD DDDF DBDD"
	$"DFFE DE06 DDDE DCDA DAD9 DCFE DA51 D6D5"
	$"D9E1 E5E3 D1C0 B19A 8663 7C7E 667E 816B"
	$"7586 754A 7E7B 6D85 7C65 767A 4B58 8869"
	$"6C82 6B6E 8265 577D 6D6D 8776 708A 6C48"
	$"7C79 6180 8A65 7682 4A65 8E85 738D 8773"
	$"8780 5A70 8185 9CBD DCE7 E6D9 D2D9 DDDC"
	$"FEDC 04DE DFE1 E1E2 FEE1 03E2 E4E5 E5FE"
	$"E404 E3E0 E0DF DFFE DE00 DF01 940E 6663"
	$"615F 5E5E 5D60 6061 6162 6260 60FE 61FF"
	$"60FF 615E 6361 5B5B 6175 99BE CCC8 B8AC"
	$"A396 8DA8 A06E 8AB0 9CA1 AEA5 A5B2 A366"
	$"82AE 97AF B297 AFBD 8478 C5AF A3C2 AFA9"
	$"B998 8FC2 B1AC C7B8 B1CF 8E79 C7C3 A7BA"
	$"BCA3 C1AA 649A BCB1 A7C3 B4A4 C1A3 72B3"
	$"C1AA A1A4 9493 A9BA CFB8 8C6D 6460 6367"
	$"6A6C 6EFE 6FFB 7001 6F6D 056C 6A6A 6968"
	$"67FE 6505 908D 8A8A 8C8B FE8A FF8B FF8C"
	$"FF8A FE8B FF8A FF8B 608E 8D8B 8686 8FA8"
	$"C9D2 CABF B0A2 9184 9F9D 6C83 A794 99A5"
	$"9B9B A99E 6480 A58B A4A7 8DA6 B37D 6FB7"
	$"A196 B6A2 9BAD 9286 B5A6 A1B8 A9A2 C289"
	$"75BB B599 ACAF 97B8 A35F 8EAE A49A B6A7"
	$"97B7 9B6A A9B1 9C99 9E92 97B1 C6D5 C4A8"
	$"938B 8B91 9295 9697 9696 0096 FB97 FF96"
	$"0595 9393 9291 91FE 900E E6E3 E0DF DFDE"
	$"DDDE DEDF DFE0 E0DE DEFE DF5B DEDF DEDA"
	$"DDDD DFDA DADD E3E9 E1CA B49B 8A78 687C"
	$"7651 6E88 6F73 7F74 7482 7848 6381 647B"
	$"7C60 7885 5A53 9576 6A86 766D 7C65 608B"
	$"7674 8B7B 7495 6354 9488 6D80 826A 8978"
	$"3F6D 8277 6E8A 7B6C 8C73 4E82 816C 6F7C"
	$"7786 ABC9 E5E7 DDD7 FFD9 FFDE 01E0 E1FD"
	$"E3FE E40A E5E6 E6E5 E5E4 E2E2 E1E0 E0FE"
	$"DF01 9D7F 6764 6360 5E5E 5F60 5F62 6362"
	$"6161 6061 6160 5E5F 5F5E 5F63 7499 C4CD"
	$"C5B4 9394 8C8B A6A2 88A3 A680 6BA1 9C8D"
	$"A3A2 98A9 A977 74B6 A1AF BB9E B1C2 9266"
	$"B9AF A0C3 B3A3 BC9D 89C0 ADA7 C3B3 ABC0"
	$"7B7E C3BD A9C3 C0A9 C590 77BA C5A9 B0C4"
	$"ABA2 B186 72BA C2AD C3CB B5A9 A483 84B0"
	$"BFD1 BC8E 6C66 696B 6F71 7071 7271 6F6F"
	$"7170 6F6C FF6A 146B 6A68 6866 6566 928E"
	$"8C8B 8B8C 8C8A 898C 8D8C 8B8C FC8B 638C"
	$"8E8D 8A8A 91AC CBCE C9BB 9A97 8E86 9A96"
	$"7D98 9E80 6B9C 9688 9D9A 91A2 A476 77B0"
	$"94A3 AF92 A4B6 8B61 AFA4 93B6 A696 B298"
	$"82B6 A59D B5A5 9DB3 7679 B7AF 9BB6 B19C"
	$"BE8B 6FAE B79B A3B7 9E96 AA82 6BB0 B49E"
	$"B4BD A59A A08A 8BB5 C4D8 CAAA 9590 9496"
	$"9798 980C 9899 9896 9698 9796 9593 9394"
	$"93FE 916F 9091 E7E4 E3E0 DEDF DFDE DDE0"
	$"E1E0 DFE0 DEDF E0DF DEDF DFDD DCDE DFE0"
	$"E8D6 BFAB 8881 7266 7974 5970 7464 5780"
	$"7464 7875 6B7C 7B59 5A8D 6D7A 8466 798A"
	$"6843 8B78 6686 7B6B 836F 5D8B 7470 8575"
	$"6B85 5058 9181 6E88 826E 9163 4E86 8A6F"
	$"778B 716B 835F 4D88 8673 8484 706E 7B6D"
	$"78A7 C0E4 15E6 D8D2 D9DF E1E3 E4E4 E5E6"
	$"E5E3 E5E7 E6E5 E4E2 E2E3 E2FE E001 DFE0"
	$"019F 7F6B 6867 6461 6263 6464 6263 6364"
	$"6160 6663 605F 5D5E 6B92 BFD1 C7B4 9F9E"
	$"896D 8A92 869C 9E8D 919C 916D 83A4 90A9"
	$"AA92 ACB3 846F 99AF A6BA A2A3 BD9E 5FA4"
	$"AA93 AFA5 90B1 987B ADA1 9CB6 A29E B079"
	$"83B6 B1A4 BEB9 AAA6 9883 BAC5 A9C2 CCA9"
	$"B39D 8383 BAB4 AAC0 C0B2 C3BC 7D93 B6AA"
	$"9FAE BFCF B88E 726D 7071 7271 6F70 706F"
	$"6F6E 6D7F 6D6C 6C6B 6A69 6867 6995 9290"
	$"8E8C 8D8D 8C8C 8A8D 8D8E 8D8D 8C8C 8E8D"
	$"8986 8CA5 C8D2 CABD A49E 8B6D 818C 8195"
	$"9787 8B96 8F6D 7A9D 8BA2 9E89 A2AB 7F6C"
	$"92A3 9CB0 9697 B197 5A9F A48B A69C 86A4"
	$"8F74 A194 92AC 9894 A872 7CAF A698 B1AC"
	$"9D9D 917D B1B9 9BB4 BE9F AC96 7C77 AFA9"
	$"9DB3 B2A4 B7B3 778A B0A8 9EB3 CBDC C6A9"
	$"9793 9799 FF99 0198 97FE 961C 9594 9493"
	$"9494 9392 9190 92E7 E4E3 E1DE DFDF E1E1"
	$"DFE1 E1E2 E1E1 DFDD DFFE E158 DEE0 EDE3"
	$"C7AE 8F80 6D5B 6969 5E75 7363 6A73 6C50"
	$"627F 657A 775F 7B83 5C4D 727F 7385 6C6D"
	$"8772 3D7E 7A60 7D73 607D 6851 7B69 697D"
	$"6B68 7D50 5E87 796C 867F 7374 6B58 8689"
	$"6D83 8E70 7D6D 5853 837D 7386 8678 878A"
	$"5D71 8982 8406 A3CC E9E5 D7D9 E2FE E510"
	$"E7E3 E2E4 E6E5 E4E3 E3E2 E3E3 E2E1 E1E0"
	$"E201 997F 706C 6A67 6666 6565 6666 6564"
	$"6566 6767 615E 6283 B1CE CEBC A4A1 908F"
	$"9F94 7075 928A 889B 948C A5A5 797F 9298"
	$"9EB1 9AA1 AE8F 767B A091 A89A 8CA4 8E5B"
	$"7D8C 7B89 8576 8A7F 6C86 807D 8C7C 838C"
	$"7178 A09D 95AF A59D 999E 85C2 C3AC CAC7"
	$"AEAE A782 A8CA ADA1 BDAE A2C5 A272 BDC9"
	$"C0AD BAA7 A1B9 C5C9 A27F 716E 7273 716E"
	$"6F6E 6D6D FF6C 006B FE6A 0869 6869 9896"
	$"9390 8F8F FB8E 6A8F 8E8C 8E8E 8A86 99BC"
	$"D4D4 C2A5 A08D 8797 9777 718C 8582 9690"
	$"849A 9E72 7990 9392 A690 97A5 8870 7497"
	$"8AA0 9385 9C8B 597A 8874 827F 7081 7A69"
	$"7D76 7789 787F 896F 749C 958C A69C 9693"
	$"997E B7B6 9EBE BAA5 A7A0 799B BDA0 94B0"
	$"A196 BC9B 6DB4 BCB0 9BAE A29F BBD4 DEBA"
	$"9B93 FF97 0698 9997 9796 9595 FB94 0692"
	$"9192 EAE7 E4E2 FEE1 66E2 E3E3 E2E2 E3E2"
	$"E2E6 E2DF D7E0 EDE3 D2B3 9184 6F6A 7370"
	$"595E 7264 6171 6A65 7A79 5460 726E 6E80"
	$"6672 8065 5157 7866 796C 5E75 6840 6267"
	$"5460 5C4E 5D55 485D 5153 6152 5B66 5159"
	$"766D 657F 726C 6C73 588C 8571 8C8A 787C"
	$"7955 7591 7469 8475 6C96 7952 918D 806C"
	$"117E 838D A9CB EBE6 DCDB E5E7 E8E3 E2E6"
	$"E5E4 E4FE E3FF E203 E3E2 E1E2 019F 7774"
	$"6F6C 6A67 6667 6867 6769 6867 6662 5E6A"
	$"93B8 D1CC AA9B 8889 9A96 879C 987F 6482"
	$"9686 9DA0 8A99 A17E 7C81 9290 A897 899B"
	$"8766 747B 7D89 8479 8684 6A66 7575 878A"
	$"869A 9074 9D95 898F 7C6F 776B 718F 8584"
	$"9188 8583 7A78 B0AF A6C1 BDAF A4BD 7DBC"
	$"C5A8 B8C6 A6A9 A18E 74BF CDB4 BDCB B8A3"
	$"B29D 9EC9 CDB6 89FE 7004 6D6C 6C6B 6AFF"
	$"6A7D 6867 6668 6969 689D 9895 9491 9091"
	$"9090 8F92 9291 9292 8A8C A4C2 D7D0 AE9F"
	$"8B84 9590 7E94 9883 667F 8F80 989B 8391"
	$"9C7A 7680 8F88 9F8F 8098 8667 7275 7785"
	$"8176 8382 6661 7170 8386 7F8F 8970 9289"
	$"828C 786A 7467 6886 807F 8D82 8181 7A75"
	$"A9A4 9BB7 B3A6 9CB5 75AE B89B ACBA 999D"
	$"9A87 6EB4 BFA4 ACB7 A79B ABA2 ADD7 D5C0"
	$"0AA5 9595 9999 9797 9695 9495 FE94 0A93"
	$"9292 90EF EAE7 E6E3 E2E3 FEE5 FFE6 61E5"
	$"E4E5 E7E2 E6E9 E0C3 978B 7968 706B 5C71"
	$"715D 4F6A 725F 7376 636F 765B 5C61 6F68"
	$"7A67 5D73 6449 595D 5A64 5F55 615F 4C4C"
	$"5452 615F 5B69 624E 6F61 5B66 5449 5753"
	$"5264 5D5C 6A60 5F61 5B55 847A 6E86 837C"
	$"7790 4F86 896D 7E8B 6A70 796C 4F89 9076"
	$"7E10 8975 6B80 7E9E D9E8 E8DC D7E5 E5E3"
	$"E5E5 E4FE E300 E2FE E1FF E200 E101 9E7F"
	$"736E 6D6C 6968 696A 6A69 6A69 6565 76A0"
	$"C9D5 B5A0 8972 8392 8396 9888 8B96 936D"
	$"768E 8A92 A58A 8194 836C 8D7D 7F89 867A"
	$"827F 686C 6C74 8793 8BA4 AF7D 67A2 888F"
	$"8B87 9C9A 7BA9 9785 8F8D 9A97 678F BAA1"
	$"919E 8479 7F59 7A8D 8989 9693 889E A182"
	$"BFBC A5C3 C3A6 AEA3 887E B0B7 A2C0 C8AD"
	$"C0C9 9771 A6A7 C5D4 BD95 6E67 6A69 6A67"
	$"0167 68FE 677A 6867 6768 9D98 9795 9392"
	$"9391 9292 9395 918D 94AF CEDB BDA7 8E73"
	$"808A 7A90 9483 848F 8E6E 758A 8189 9F83"
	$"7A91 8266 877A 7C87 8377 8180 6A6D 6972"
	$"8489 829D A877 619B 8389 8681 9392 75A2"
	$"907E 8786 9594 6488 B099 8793 7B73 7B56"
	$"7483 8182 918F 8398 9B79 B3AF 98B6 B59A"
	$"A79C 7F73 A1A7 97B8 BC9E B4B8 8E6F A8A9"
	$"BE07 D1CD AF96 9498 9795 FE94 FE93 0494"
	$"9292 93EF FEE8 69E5 E4E5 E8E7 E5E7 E9E6"
	$"E7E5 E4E3 DDB5 9378 6369 685C 6E72 6264"
	$"6E6A 515D 7262 657A 625A 6E61 4B6D 5F5F"
	$"6661 575B 5C48 5253 5965 655E 7885 5B49"
	$"7B5E 6460 5C6F 6E54 7F6A 5C65 636F 7047"
	$"6A8A 7160 6C5B 565D 3858 625C 5B67 6560"
	$"7778 588B 826A 8885 6B7D 785C 4D71 7A6D"
	$"8A16 8A6B 8487 6A56 949B B6CF E6E0 D8E0"
	$"E7E4 E3E3 E2E4 E2E1 E1FE E200 E301 9E03"
	$"726E 6E6D FE6C 7869 6B6F 6C6B 82AE D4D6"
	$"B094 8990 9176 758D 8A89 9693 8597 9D7B"
	$"6C80 8783 9287 7583 7D63 7169 697A 877F"
	$"98A7 7F82 7A7B A398 8384 8071 6084 878A"
	$"8C7F 7C7B 6981 8085 928D 8F79 6269 818A"
	$"8EAB 9D81 8E7A A5BC 9D8D 8A74 7272 687C"
	$"A7A5 A2BC B8A0 9DBD 79A5 BCA3 93AE B4A2"
	$"C0A6 6CA9 CCC4 9E9F AECC C49E 7564 6569"
	$"0068 FE69 FF6A 0666 676A 9C9A 9997 FE96"
	$"6F98 9694 9290 9EBD D3D3 B89B 8B8E 8E79"
	$"798C 8584 908D 7E90 977A 6B7F 807A 8C83"
	$"7180 7D66 746C 6A7A 877E 93A2 7C82 7777"
	$"9D96 8387 8274 6483 8386 877D 7C7B 6579"
	$"7A7E 8A87 8C7A 686E 7E83 86A1 967A 8774"
	$"9BB0 9789 8672 7271 6576 9F9E 9CB1 AB98"
	$"97B4 6E97 AD94 86A3 A897 B7A1 67A2 BFB9"
	$"9709 9BAC D1D2 B396 9093 9493 FD94 0795"
	$"9494 97EF E8E9 EBFE E866 E3E6 E7E5 E4E6"
	$"ECE4 C9A4 8876 6F6F 6366 7168 6670 6E60"
	$"6E74 5B4F 6665 5C6A 6054 645F 4C5C 5450"
	$"5D69 6170 815C 615B 5B7C 7462 6462 5748"
	$"6361 666A 5F5D 5C4A 5F5D 666F 696A 5C54"
	$"5B67 6463 7C72 5B65 4F75 8368 6163 5053"
	$"574B 5C78 7470 867F 6E72 8D46 6D7D 675A"
	$"731A 7767 857C 5082 908A 6F78 92C7 E4E4"
	$"D7D7 E1E1 E0E0 E2E3 E4E4 E3E3 E601 9F7F"
	$"706F 6E6D 6E6C 6D73 6E6E 86B2 D7CA A397"
	$"9B8F 8394 9783 657B 9082 909D 8787 998A"
	$"677A 786E 7A7E 7478 8073 6788 7685 9582"
	$"8C8C 7578 7364 888B 8387 907F 699C 97A0"
	$"AC98 AAA4 79B9 A8A2 BAA7 A495 8082 9D8F"
	$"8F92 8263 8271 849C 8B91 9D83 8E79 658E"
	$"9083 8E9E 938B AFA1 77AE B294 B0B7 9490"
	$"987E 77C7 CBBD C1D1 BA8D A2C7 CB9C 7569"
	$"7F6B 6869 6A69 6968 686A 9A9A 9897 9897"
	$"9696 9895 9DBC DAD0 AB97 958B 7F90 9485"
	$"6B7D 8C7F 8E9A 8383 9689 6577 786F 7B7F"
	$"7375 7C70 6485 7280 917F 878A 767C 7765"
	$"8988 7F81 8979 6592 8B94 A089 9D9C 70AD"
	$"9D96 A998 978B 7C7C 9287 8A90 7E5E 7C6D"
	$"8095 888B 977E 8B76 5E86 887B 8593 8F89"
	$"A698 6CA1 A787 A2A9 8787 937E 70BC C0AF"
	$"B40D C3A9 88AC D4D7 B39A 9092 9395 9594"
	$"FE95 6E96 EDE8 E8EA EAE9 E8E8 EEE6 E3EA"
	$"DEB6 917E 7E6C 5C6B 7169 546A 7261 6E7B"
	$"6360 716A 4A5E 635A 5D5F 5659 6056 4B6C"
	$"5A67 735E 696D 5B61 5F4E 6B6A 6164 695B"
	$"4770 656C 7661 7471 4986 6D68 7E6D 6D65"
	$"5C5F 7167 676C 5F47 6654 6573 6460 6E5C"
	$"6857 4565 6358 6472 6C67 806C 4674 7458"
	$"7273 1A55 5C6E 6255 928D 8289 9C80 6393"
	$"C8DF DAD8 DAE7 E6E3 E4E3 E4E5 E4E5 019C"
	$"0271 706E FE6C FF6D 777E B7F4 E3A4 958A"
	$"7E96 998A 868D 8769 7089 8A80 938D 7E8C"
	$"8764 6D72 606E 8181 829A 8460 917C 7199"
	$"8C81 817A 6A86 738D A197 9FB1 8F5D A798"
	$"A2B0 9AA5 A774 B2AA A5C2 A8B3 AD7B A1C9"
	$"B0B9 C398 819C 7085 8F8B ADA2 758E A070"
	$"BABD 959F 8F73 7996 718B A8A0 9DBC BA8E"
	$"938E 688C B7BE ABD1 D2C0 ADBD A39C FADF"
	$"9000 68FD 69FF 66FF 6703 9B9A 9796 FD97"
	$"6E9E C4F5 E0A2 9688 7E95 9686 848A 8770"
	$"7488 897F 918B 7C8B 8764 6D77 6671 817F"
	$"7E93 8361 927D 6F97 887D 7F79 687F 6B83"
	$"9689 8EA5 8A58 9E8F 99A8 8C99 A16D A7A2"
	$"9DB5 9DAA A575 9CBD A0AB B794 7E97 6B81"
	$"8B8A A89D 718A 9A68 B2B4 8C96 8772 7B90"
	$"6A80 9B96 92AD AC83 8B8B 6A85 A9B3 A1C6"
	$"0CC7 B3A0 AE9F A3FD EDAE 9196 9595 FD94"
	$"0495 F0E9 EAEB FEE9 66E8 E1EB FFD6 897B"
	$"6E60 7473 6463 6D6C 535E 736F 6071 6A5A"
	$"676A 4854 6554 5864 6060 7565 4373 635B"
	$"7C6A 6365 614D 654F 626E 6268 7E63 3576"
	$"646E 7963 7075 4781 726C 856F 7F7A 4E77"
	$"906D 7B8B 6958 764D 656A 6A81 7652 6471"
	$"478B 8661 6C63 5860 6F46 5E6A 6063 7B74"
	$"1A54 666A 4760 8185 7297 9984 7285 7D90"
	$"FAF5 D3CD E2E5 E5E4 E4E3 E5E7 019F 7F6D"
	$"6C6A 6A69 6C6F 729F C4BF 9569 8093 8A8C"
	$"968A 7D8C 907F 6B7B 847D 8687 7276 776D"
	$"5D6C 756E 8985 7B81 826B 7778 6278 8881"
	$"979B 6979 848D 9F94 8EA8 8B5A A99D 9BAF"
	$"98A6 AD71 9799 96AD 969C A55E 97BA 9CAD"
	$"B8A6 94A4 77BF AA90 9C78 6580 7A79 9999"
	$"8EA3 958F 7E60 608C 9A94 A0B0 9E86 9385"
	$"7AB7 BEA7 A1BE C0AB C7CD A962 818B 790C"
	$"6D67 6867 6566 696A 6E9A 9997 99FE 986F"
	$"93AF CBC6 9969 7D8E 8688 9386 7A88 8E80"
	$"6D7D 857C 8485 7075 7871 6170 786E 8883"
	$"787F 836D 797C 6577 827B 9296 6273 7D83"
	$"9388 829B 8451 9D8F 8FA3 8C9B A265 8C8F"
	$"8C9F 8B93 9A55 90B0 8E9F AB9B 8B9C 6EB4"
	$"A38A 9874 637E 7576 978F 859D 928E 7D5F"
	$"5B86 9288 92A3 957F 877E 74AE B097 93B4"
	$"7FB8 A1B9 BB9C 6A84 8C8B 9897 9495 9494"
	$"9393 95EF E8E7 EAE8 E9EB E3E0 C7B5 8F59"
	$"6674 6668 7569 5C6B 705F 526F 6F5F 6669"
	$"555A 5E54 4A5D 6459 6E65 5B61 6752 5E63"
	$"515F 685A 6E6E 4156 5B5E 6B5F 5974 5A34"
	$"7663 6377 6370 7743 6862 5F73 5E68 7032"
	$"6B81 6373 7C6F 5D74 4D87 7461 7253 4868"
	$"5D56 726A 5F76 6C6E 5E3D 4068 6E60 6C76"
	$"611A 5767 584F 8484 6C67 8485 778F 8E72"
	$"507F 8693 C8E2 E9E6 E5E5 E3E4 E801 9F7F"
	$"6964 6567 6A6A 6C72 7E8D 8F8B 6F71 888D"
	$"7D8A 8F89 8091 8B70 6C78 726A 7671 6C7F"
	$"8361 7785 7877 9285 868E 7774 8B6A 8BA1"
	$"8C96 A578 6097 879E 9B88 9F8A 61B3 A89E"
	$"B89E ACB6 729F 9D98 B49D 9EB1 67A0 C29F"
	$"B8B4 A5B5 7677 C0AF A8C6 9D7F A07B 89AF"
	$"A8B2 B586 8E9A 8C97 C1A1 8A92 9485 8F9E"
	$"6E9C BABF AABE B79D A6C1 BE7D 584D 3B60"
	$"7F73 686A 6866 6464 6977 9093 9492 9697"
	$"999B 9AA0 9D93 726F 858C 7B86 8B85 7B8F"
	$"8B73 6E79 746C 7672 6D7E 8463 7987 7A78"
	$"8D80 818C 7673 8864 8498 838E 9D72 5C90"
	$"7F92 8F7C 9585 5BA9 9B91 AB92 A1AB 6491"
	$"908B A38D 91A3 5B95 B692 ABA8 95A7 6E70"
	$"B3A2 9ABB 9475 9C78 83A5 9AA6 AC82 8C94"
	$"8288 B697 7D88 8E80 8993 6593 B1B3 9DB0"
	$"A97F 8F97 B5B4 765A 4B49 829D 9696 9593"
	$"9192 9395 D9E6 E8E4 E8E9 E8EB EABC 8E80"
	$"625F 6D6D 5F6C 706A 5F70 6B58 5A65 5E57"
	$"615A 5362 654A 626E 6360 7064 6470 5A57"
	$"6D48 6374 6068 744F 3C6C 576A 6754 6D5A"
	$"3D81 6E65 7F6A 757F 446E 645F 7560 6578"
	$"3C72 8866 7D77 6779 444B 8771 6D8A 6856"
	$"7E58 6587 757E 825F 6F74 6367 8969 5965"
	$"655B 1A6A 6F3C 6983 8572 847A 5E6A 8589"
	$"5748 4341 9BEB E6E5 E4E3 E3E6 E6E2 019E"
	$"7F96 7075 7869 6566 6A6E 8494 9582 676E"
	$"8688 7F91 9081 8789 745B 656C 6875 7D72"
	$"7E83 7267 857C 6A7C 847C 8885 6E84 818F"
	$"9E95 98AA 886D 9D8C 979F 899C 8E5F 9DA0"
	$"90AA 97A0 AB73 A19F 9AAF 9199 A46B 9AB8"
	$"9EBD B4A9 CB87 89BC A4AD BCA8 95A9 89A5"
	$"9A8A 9E76 6F9A AA77 9CB4 AAA9 A687 737B"
	$"8665 AEB7 A2AF C7BE ACC1 BA8A 5C52 4B50"
	$"787F 696B 6D69 6A7D 8088 58B4 9899 9B92"
	$"9296 9796 9EA1 9D85 686D 8687 7D8E 8D7D"
	$"8689 775D 6872 6D77 8176 7C82 7266 8581"
	$"6E7B 827B 8582 6A7F 7988 978B 8EA0 8068"
	$"9683 8B93 7D93 8A5A 9492 839D 8B96 A065"
	$"9191 8BA2 858F 9B64 94AE 91B1 A89D BF7A"
	$"7EB4 9A9F AD9A 879D 819F 9686 9C77 6C93"
	$"A773 99B1 A29F A085 737C 8060 A4AD 9AA4"
	$"B9AD 7F98 AEB0 875D 534A 6CA5 9699 9693"
	$"95A3 A3A5 63CC D2E8 EAE3 E5E6 EAE8 DDB0"
	$"8F78 5B57 696C 5F6E 6D5F 686A 5C46 5361"
	$"5B61 6556 5F64 584D 6A69 5764 6B63 6964"
	$"4D62 5C66 726A 6B7A 5D47 7059 636B 556A"
	$"5F3C 6C66 5771 626A 7545 6F66 6176 5A67"
	$"7140 6F7F 6380 746D 8E54 5B86 6770 7B6A"
	$"5C78 5E77 6A64 7B55 5075 7F51 7882 7777"
	$"7461 5D12 6860 3B7A 7C6A 778C 7F6A 7F7A"
	$"5E45 4649 77DE E7FD E303 E9E3 E496 019F"
	$"7FD3 E1EC F0B3 6267 6967 6B8A 9792 7067"
	$"7D8C 8183 8F82 6773 7169 6576 7776 7A77"
	$"6B7F 7F66 777B 6570 8776 8E94 6373 9F8C"
	$"A399 8EA0 9065 9293 95A6 8F9F A561 93A6"
	$"92B0 9B9D A776 A9A4 A1BA 98A5 A964 A4B0"
	$"95B6 A6A3 B981 95BA A5B7 B9A4 B78C 7AC0"
	$"BC9F A978 658E 9673 ACA4 8CA7 988A 9E76"
	$"547A 8C9E 92B3 BEA7 BDCF B369 5851 4771"
	$"697F 696B 6A69 8BEC FFB5 3BCE E3EC F0C9"
	$"8C94 9697 95A0 9D96 7868 7C8A 8081 8E83"
	$"6B77 746C 687B 7A78 7C7A 6D7F 7F67 7B80"
	$"686D 8574 888D 5F6D 9683 9B91 8698 865F"
	$"8C87 8798 8192 9D59 8697 83A2 9093 A06C"
	$"9C98 95AC 8C9C A25A 98A4 8AAB 9B9A B177"
	$"8AAD 98A9 AE98 A97F 70B5 B194 9B73 648B"
	$"916D A7A0 87A1 9184 9974 5375 8698 8AAA"
	$"B19A 7FAE BDAA 6756 4F57 9C98 9799 9692"
	$"A2EE FDB0 39CC E6F4 F8E1 C9E7 E9E5 E5D7"
	$"A487 6459 6B6F 6264 6D65 5460 5E57 5365"
	$"6764 6461 5467 6751 676C 555A 6D57 676E"
	$"4150 765E 786C 6071 663F 6660 6272 5B69"
	$"7435 646F 5875 6267 7647 766A 677F 5D6C"
	$"7537 7374 597B 6B6C 8256 637F 697B 816A"
	$"7758 4E86 8068 754E 4973 724C 7A76 6476"
	$"6A67 7C10 5639 5A60 6E5F 7D81 6B82 8D77"
	$"4749 445E C9FE E506 E4E3 D6F7 FFB0 4001"
	$"9F7F EDE3 FDFF FBA1 626A 6565 718A 908B"
	$"6868 8285 6E77 746B 707B 7A60 747D 7574"
	$"7B75 7F8C 6C66 796C 8297 8487 9C72 679C"
	$"838B 9C82 9094 5A87 9893 A992 99A1 6787"
	$"A58A A898 939E 72A0 A19A B497 A49E 5BAB"
	$"B1A0 C0A9 B4B3 68A4 AE9F B1A7 94BB 817A"
	$"D1B6 B0D0 A881 9A7A 88CB C0B3 C792 8795"
	$"9B79 BBA5 857F 9C9F 9BBE C180 5851 4267"
	$"7066 FF69 7D67 81A0 F3DB 4C4A E4DE FDFF"
	$"FFBF 8B97 9694 94A2 9A8E 6A69 8186 6F78"
	$"756D 727D 7C62 767F 7676 7D72 7E8F 7068"
	$"7A69 798F 7C80 966E 6295 7D84 947A 888C"
	$"5682 8C88 9E88 8F9B 617B 977D 9C8D 8997"
	$"6993 968E A68A 9B97 52A0 A595 B59E ABAC"
	$"5E99 A091 A39D 89B1 7771 C7A9 A2BE 9C7C"
	$"9574 81C3 B4A5 BD8A 8290 8F72 B199 7C77"
	$"9496 937F B7B5 7957 504C 8AA0 9496 9796"
	$"939D F4D7 4954 DFD1 F0FB FED1 D2EC ECE8"
	$"E8C9 967C 5B5B 6B6B 545D 5C56 5B66 654B"
	$"5F69 6261 6654 606F 5754 6350 5C6F 5B5E"
	$"7550 4676 5862 6F55 636A 3762 6862 7761"
	$"6572 3C5A 7153 6F60 5D6D 456F 6862 795D"
	$"6C6C 317D 7666 8871 7E7C 3C71 7264 766E"
	$"5B80 5151 977A 7090 6D52 7358 6699 8570"
	$"8C65 606B 1A6D 4E83 6A51 526F 6F6B 8683"
	$"5145 4B46 A3E9 E4E5 E7EC DBB8 EED1 4353"
	$"019F 7FB2 E1E5 FFFF EE87 6366 6565 768C"
	$"8D7B 5A69 7168 6976 7B70 7D83 665D 7F81"
	$"6F7C 7C70 6F6C 5E77 8885 928D 7E92 8358"
	$"878B 7E9A 8386 925F 6999 859C 918E 9C6E"
	$"79A3 80A0 9893 A470 989D 94AB 8FA1 9059"
	$"9EA1 97B4 9EB5 946E A8AF 9FB6 9F95 AD65"
	$"97BF A3B2 C7B2 B09D 758E 928F AB86 7B9B"
	$"BD83 8CC9 C1AD AB89 7892 AC99 6152 444A"
	$"7066 6A7F 6867 7798 A0DA 6C44 2DAF D9DD"
	$"FDFF F6A7 9297 9795 9A9A 9280 5D6A 736B"
	$"6B77 7B70 7D83 665E 8083 717D 8075 736F"
	$"5D71 7F7E 8B85 778C 8053 8286 7A92 7B7E"
	$"8C5D 668F 7C94 8986 996A 6F99 7696 8D89"
	$"9D65 8B91 889D 8396 8953 9597 8CA9 93AC"
	$"8D64 9DA1 91A9 948D A85E 8EB5 97AB BAA8"
	$"AA95 6F89 8D8B A782 7593 B477 84BE B3A1"
	$"A485 738C 7FA7 915C 544F 689E 9596 9695"
	$"949A 96D5 6346 41B5 CFCF F8FF F7C7 DDEE"
	$"E9E8 E1BE 856F 5058 5A53 5762 6256 646A"
	$"4D44 686C 5C6A 685C 5A58 4655 615C 6A64"
	$"566C 6138 6563 596E 5558 663F 4C6D 556D"
	$"625B 6D45 4E73 4E6A 5F5C 7243 6966 5E72"
	$"576A 5F33 736A 607D 6881 5E42 7674 647C"
	$"635C 7738 6986 6879 8A75 766C 4F69 6D67"
	$"7F65 5C71 891A 515A 8B7E 7076 5951 6F7F"
	$"6841 4743 74DC E9E8 E7E8 E5C2 94CD 6045"
	$"4201 9F7F 71D2 DDDC F9FF EA75 676A 6868"
	$"8187 8769 556B 726E 787E 7476 7A74 6A81"
	$"7E83 596D 708B 8E5F 6691 7B84 8E7F 9193"
	$"6666 8978 8C85 7F91 715C 998C A19F 93A9"
	$"7F68 A786 9B97 86A0 6E97 9D95 AE90 AD8D"
	$"5FAC A49E B7A2 AA8B 7CA9 A497 BA9E AB8C"
	$"6BC1 BB9F B5AD A5C8 9174 A69D 8E75 5E7F"
	$"9394 708F 9288 8EA0 9279 727D 665A 4D42"
	$"7269 6B6B 7F64 6B9C A691 5F4A 491D 78D0"
	$"D4D3 F7FF F29F 9499 9794 9C8C 896E 5970"
	$"7773 7C80 7678 7C76 6D80 808C 606C 7392"
	$"9361 638B 757D 8876 8A8E 6162 8574 857D"
	$"788C 6D59 9385 9997 8BA3 7C61 9D7D 928D"
	$"7C97 638B 928A A284 A285 5AA6 9B92 AB97"
	$"A283 749E 988F AD8F A087 63B5 B093 AAA3"
	$"9EBF 8A76 AD9D 8C7B 647E 8E92 6B89 8E84"
	$"8A9E 9277 6C7F 7964 5951 589D 9993 9496"
	$"91A2 A08C 5A4B 5835 84CC C4C8 F2FF F3C8"
	$"E3EE E7EA E49E 795B 4A5A 635F 6769 5F61"
	$"6862 596C 6979 5962 6187 8B4F 456B 545C"
	$"6556 6B6E 464A 6653 6258 4F64 4B3A 735D"
	$"7271 647B 5844 7B56 6762 526C 4069 6861"
	$"7859 755F 3A7E 6D66 7C65 735A 5075 6A5F"
	$"7D5D 715E 3F8A 7C66 7F76 6C8D 605D 9A85"
	$"6E60 526A 6E6D 1A4E 686C 5F62 776D 5751"
	$"5F4C 4C44 56CA E9E8 E7E6 EAD7 A77E 564A"
	$"593A 019F 7FEB 82A5 D7D8 FEFF CD6D 6A6F"
	$"666B 8484 825F 667C 7F72 7B7C 7677 7F6F"
	$"5B79 9A63 8591 A495 644D 7689 7A93 8A82"
	$"9172 5C7E 838F 9A88 9A82 5C79 8A8A 897B"
	$"856E 5071 6C6F 6F69 6F5C 5E6A 6B77 6B7A"
	$"6A57 8688 8FA3 999F 8E7F BDA7 A8BD 9E9B"
	$"8088 C5B4 B0C9 ACAB AF6B 7A85 8488 7E6E"
	$"8EAB 7E96 BDAC A4AD A594 B7B7 7C58 5D45"
	$"606F 6367 677F 688A AE9E 5D49 3731 32F4"
	$"87A3 CCCE FFFF DF99 9898 9798 9884 8363"
	$"6678 7D70 7778 7276 7D6E 597E A66B 8798"
	$"B09C 674F 7482 758D 817A 8C6E 587B 8086"
	$"907D 9481 5977 8685 8476 836F 506D 696D"
	$"6C65 6C58 5967 6772 6775 6754 8281 879B"
	$"9197 8474 B197 9AAD 9293 7A7E B8A9 A4BC"
	$"A2A4 A869 8595 8A85 8077 8DA0 748B B0A4"
	$"9CA5 9D8C ADAA 7F75 535A 5081 A095 9596"
	$"8F9A AD99 5A4A 4246 48F6 819B C2BF F5FF"
	$"E5C4 E6ED EAEC CE8E 7551 5263 6456 6162"
	$"5C5F 6657 4267 9567 838F B3A0 5D3A 5D65"
	$"546A 615B 6B50 3E5E 6065 6E59 6F5C 3857"
	$"6362 5F56 6350 3957 4D4C 4F4A 4F3E 3D46"
	$"4852 4755 4B39 605B 5F71 656E 6252 8667"
	$"6779 6267 555B 8A73 768E 7070 7641 739C"
	$"9680 7671 8183 521A 6D88 7875 7B72 6785"
	$"8150 414F 459A EAE6 E3E8 E8DD BD95 554B"
	$"424A 5201 9F7F E489 89F6 CADD FFFF C068"
	$"6C6A 6774 8A80 7459 707E 7670 817A 6B79"
	$"7250 70A3 4666 7D73 657E 605B 8878 7F87"
	$"7589 8260 7581 8790 7A7D 6C51 545E 6368"
	$"6569 6651 5760 6870 6673 5E6C 746C 7063"
	$"615B 586F 6B6C 6E6A 6E62 6494 8BA9 B1A3"
	$"95A0 8FBE 9EAE BE9F B98F 6C7A 5577 9867"
	$"6E8C A16E BAC7 B0C0 CCB5 B4C4 B36F 7063"
	$"5B78 6867 6666 7F7E AFAB 7042 622C 323B"
	$"EB97 90EF BED5 FFFF D892 989B 9A9B 9984"
	$"7755 6878 716D 7D76 6977 7051 77AC 4A67"
	$"817A 657B 5F59 8374 7C7E 6D83 7D5B 717D"
	$"828B 747A 6C4F 525A 6066 6368 6953 5660"
	$"6870 6674 5C6A 736A 6E61 5F59 576B 676A"
	$"6B67 695C 5F90 829C A99E 909C 85B1 93A1"
	$"B095 B188 677A 5878 8F63 788C 9862 AAB5"
	$"A2B3 BFA8 A5B2 A47F 686C 5F74 A697 9696"
	$"9496 ACA6 6C41 6B3A 474E ED92 8FEC ADC5"
	$"FCFF E6CF ECE8 F0E8 CC84 6448 545C 5353"
	$"645D 4D5B 5434 60A0 445E 6F70 5D68 4944"
	$"6755 5B5F 4E63 5E3E 535F 5C66 515B 5137"
	$"3D4A 4D4E 4949 483A 4146 4A4F 4551 3F4C"
	$"4F4A 5345 433E 3C4E 484A 4E4C 5147 436B"
	$"5A74 7D72 6575 6183 5D74 8064 815F 4662"
	$"4E6A 7B52 7180 793E 1A7F 826D 838D 7678"
	$"8578 4259 5379 DDEE E6E3 E9E0 C19E 6843"
	$"6B3E 505E 019F 7F8E C9E8 FFE7 C6EB FFFF"
	$"A365 6E6E 6D7D 8580 6A54 7B80 6E72 7567"
	$"6C75 606A A843 5B76 716B 8578 566B 7D7B"
	$"8D80 858B 5760 5A5E 5D57 5A5E 5256 5C67"
	$"716D 7C7A 5467 706A 6E68 775E 6F77 6874"
	$"6D7C 5460 8F78 766F 666A 4F5D 6663 6C6F"
	$"7382 729C BFA0 BBB1 A093 7C8C B394 B0BE"
	$"5974 9877 92CA B8A1 C0BC A9CD CD81 7485"
	$"6A73 706B 6967 717F A3B4 8B48 5A6A 3A2D"
	$"2995 D3EB FFE0 B9E3 FFFF C495 9B9B 989F"
	$"9281 6952 777E 6F74 7666 6B74 5F70 B44A"
	$"5774 6F66 8176 5569 7B79 887B 8088 565F"
	$"585C 5B55 5A5F 5355 5C67 726C 797A 5365"
	$"6F6A 6E67 795F 6F77 6873 6C7C 555F 8C74"
	$"7571 6969 4C5B 6662 6970 707D 6E92 B093"
	$"AEA6 9588 7182 AA8A A4B7 587E A173 89BC"
	$"A893 B4B0 9DBF BF76 7F6B 7E79 989C 9596"
	$"948F AAAE 8646 5D72 4841 419B D1EB FFDA"
	$"AAD5 FEFE D7D4 E7EB ECEB AF77 5D44 6264"
	$"5557 5C4E 535C 445D AB42 4A5D 514B 665B"
	$"3B4C 5D5A 675A 606B 3D48 4346 453F 4449"
	$"3E42 464E 534F 5C5A 384C 5147 4D49 5942"
	$"5257 4852 4B5A 3643 6F55 524B 4552 3942"
	$"4743 494F 525F 5171 8662 7E71 655E 505F"
	$"8161 7585 3773 945D 661A 8A75 6084 7F6C"
	$"908F 5058 706A BEE9 E9E3 E9E6 CFA9 824A"
	$"6274 4F4D 5101 9F7F C377 F2FF FFE2 CDF1"
	$"FFF3 916A 6F6B 6E8A 8071 5963 7E71 626E"
	$"7365 6C67 7F9F 5357 677F 6C75 7857 6D72"
	$"7681 7163 614F 464E 5361 6464 765B 5F5D"
	$"6771 6768 6357 5D6A 6666 6260 585B 6264"
	$"6F6A 6656 5F76 747D 7E65 6F55 8188 7374"
	$"6866 5951 6E83 87AF AA9B A590 A2B8 A3BF"
	$"8C53 787E 67B6 C0AB B9C0 A8B1 C8AA 6D8F"
	$"896E 6C68 6864 6B91 7FB3 9C4E 5368 6343"
	$"282F CD7A EFFF FCDA C2ED FFFB B296 9D9A"
	$"9A9F 8375 5D62 7B72 646F 7163 6964 86AF"
	$"5E57 687C 6773 7959 6C72 7580 6F61 6151"
	$"484F 5361 6565 795E 615D 6671 6768 6356"
	$"5A69 6565 6262 5B5B 6365 6D69 6958 5D72"
	$"6E79 7E67 6E53 8086 7375 6762 554D 6779"
	$"7EA7 A394 9D84 95AE 9AB5 8B58 818C 5FA8"
	$"B29D ACB4 9CA6 BCA1 67FF 877D 919C 9597"
	$"9591 9EAC 944A 556D 664E 3C4B D080 F4FF"
	$"F9CE AFE4 FFFB CCD8 F2EA EEE8 9669 4D4F"
	$"6859 4858 5B4C 534B 75A8 554A 5860 4B5B"
	$"5F3E 5056 5963 5449 493C 363E 404C 4B4B"
	$"6145 4945 4D55 4D4E 493E 4650 4749 4645"
	$"4146 4B4A 4F4B 483D 4759 5560 5C46 5034"
	$"5E65 5251 484C 3E33 4B5A 5A7E 7366 735F"
	$"6B7C 6983 5C3B 7A82 4B82 1A83 6B78 836C"
	$"768C 7444 7575 9AE0 E8E7 E4E6 DAB4 884C"
	$"5A70 6B56 4759 019F 7FBB 15BE FFFF FEDF"
	$"D0F6 F6DE 8E6C 6E6A 7484 6D6B 5465 7469"
	$"6471 6763 6C92 9855 5459 7274 6D7E 6253"
	$"5D56 5658 585F 654D 6455 616D 636B 5D5D"
	$"595B 6562 646D 5263 746D 7869 7F64 6B76"
	$"707D 6C72 5565 7A6D 6C6E 5E68 6178 827D"
	$"856C 7361 668A 7270 716F 738D 77BC B2A1"
	$"B770 5778 768A C4AE A0BF B2AB C6B6 7682"
	$"907C 6F65 6563 6988 AB7F A15E 4D6B 655C"
	$"3524 33C9 1ABD FAFD FCD8 C7F5 F3E7 B19D"
	$"A19F 9D98 756F 5563 7367 626F 6560 6C9B"
	$"A75C 555C 716F 6A7E 6354 5E57 585A 5A62"
	$"674E 6557 6571 666D 5F60 585A 6562 646E"
	$"5261 736C 7868 7C62 6975 7078 6871 5563"
	$"7669 6D6E 5C67 6279 837C 856B 705E 6386"
	$"6E6C 6D6D 718C 70B2 A996 AC6D 5B83 827D"
	$"B4A0 92B2 A79F BAAC 707F 7F90 939C 9895"
	$"9893 97A9 9B5B 4D6F 675A 403E 4EC9 24C4"
	$"FAF9 F6D0 B5EC F1E8 D2E7 EFEF F3D3 8262"
	$"4452 5A4C 4C59 4E4A 5189 9F54 474D 5A55"
	$"5163 4A40 4A43 4446 444A 4F39 5242 4D57"
	$"4C56 4748 4444 4B48 4A53 394B 594D 5749"
	$"5D43 4B55 4D59 4950 394C 5B4E 4F4E 414D"
	$"4459 625B 604B 5340 4268 524F 4F4E 5069"
	$"4F8B 7763 7C46 4177 7A67 871A 7061 7D75"
	$"6F88 7F4D 6679 8AD1 E9E8 EAE6 D7B8 9252"
	$"5072 6B61 4848 5D01 9F7F 923A F2FC F2FF"
	$"FECC CFF5 FBDE 7E7B 7A75 8483 5B56 4C6E"
	$"6E5F 6872 6765 9592 5755 5062 7864 695C"
	$"3F48 5255 5F59 5D64 4C62 5D59 6E60 605F"
	$"4F61 6974 7770 8852 6A86 7987 738D 6971"
	$"857C 8E78 895C 769B 828A 796E 6162 6D72"
	$"7E7A 5B83 6F71 8D7B 7E77 6A5D 4962 8B8B"
	$"B2A0 5C5F 797F ABC1 A5BB BB9C B9C4 8254"
	$"717F 7B6F 716F 6B81 A2A3 7F62 4269 6A59"
	$"5D42 2536 9F42 F1F7 EFFF FCBE C1F0 F9EF"
	$"A5A0 A4A3 A78D 5E58 4969 6B5A 6670 6565"
	$"A1A0 5B57 5463 7562 6B5F 414A 5459 645F"
	$"6267 4F65 605D 7363 6161 5060 6974 7871"
	$"8952 6985 7987 738B 666E 837A 8973 865B"
	$"7698 7F8D 7A6B 6164 6E72 7D7B 5C80 6C6F"
	$"8B77 7B74 6A5E 4B61 8887 AB98 5961 838A"
	$"9EAF 97AD AE8E ADBA 7A4F 717F 859D 9996"
	$"9395 989F 9E62 466C 6D59 5A4E 3F4D 9D48"
	$"F4F4 EDFF FEB6 AAE4 F9F1 CAE8 E9E5 EDB6"
	$"604A 3A53 5144 5059 4F4C 8F9A 5649 4651"
	$"5E4B 544C 3239 4345 4D45 474C 354E 4D48"
	$"5B4A 4847 374A 515B 5950 6733 4D65 5561"
	$"4D65 434C 5E54 654F 6139 5676 5E66 534A"
	$"4547 5256 605B 3E64 4D4C 6655 5953 4E43"
	$"334A 6A5E 7F6E 3946 7485 877D 1A68 7C7B"
	$"5F7E 8B53 3861 75BA DCE3 E8E7 DCC2 9757"
	$"4771 705D 6156 495D 019F 7F53 5AFF FFF0"
	$"F8FE 90D7 C1E7 EBC5 BCC0 C0C5 713A 4943"
	$"4556 7260 6E69 5498 8E48 604D 5465 6679"
	$"7549 485E 545C 6B64 6F5E 5656 5562 686C"
	$"794F 7173 767F 6F83 5767 8278 8B73 8263"
	$"6B80 7786 7186 677C 9887 9B85 8A77 6E96"
	$"7679 6958 6A6E 898E 848C 7176 6E54 7E79"
	$"6477 6C54 8086 79A4 A6A6 C1B6 BBA8 503C"
	$"342D 90CE BABA B3BB 7955 507F 3862 6E61"
	$"5360 4A35 3D5B 5FFF FEEF F7FD 83C6 B3DB"
	$"E2C3 B9BB C0C9 743B 463D 4154 6D5E 6C67"
	$"54A5 9E4A 624F 5765 657E 7A4C 4B62 5860"
	$"6F68 7362 5958 5763 696C 794F 7174 7780"
	$"7084 5765 8278 8870 8363 687E 7582 6E83"
	$"6379 9684 9983 8878 6E93 7278 6B5C 6C6F"
	$"8C8F 838B 7072 6C55 7E7A 6577 6A51 7E8C"
	$"87A0 9998 B3A8 AA9F 4C35 2F2D 7F8E CDB9"
	$"B8AF B678 5753 3A64 6F61 5362 5547 4C59"
	$"5DFF FEEE F7FD 80B2 9ECB CBAB AEAF B2BB"
	$"7333 352B 2D40 5A49 5752 3D94 9B49 5441"
	$"4955 5673 713D 3749 4048 5751 5B47 4346"
	$"434D 4F50 5D33 5556 585E 4D61 394C 5F55"
	$"654D 5E43 4758 5260 4A5F 4557 6F61 725B"
	$"6055 4D70 525C 4E3F 5554 6868 5B64 4957"
	$"4E3A 6C69 4F5D 533A 6578 8588 661A 6984"
	$"797C 762C 1E22 207E C2B0 B2A9 AF71 4E4A"
	$"3561 6F63 5662 5142 4B01 9F7F 307A FFFF"
	$"E59D F7B9 F99C DCE3 E4E5 E5EC A046 5555"
	$"544B 3367 6661 6B5E 988A 4644 494E 5964"
	$"7069 5844 675E 506E 645F 614F 5D66 7279"
	$"6E7D 5967 776D 7F72 8464 6686 758A 7584"
	$"656B 8377 8370 8862 8593 8196 7E91 7A6E"
	$"9B83 9988 8162 5A72 7A89 8062 858B 6B6F"
	$"6967 685B 5263 6D7E A89C ADB0 9FCF 6B33"
	$"4036 55DB E3E2 DBDF D044 382F 7F4A 7363"
	$"3F4F 6054 404C 357D FFFF E7A0 F5B2 F18E"
	$"D1D7 D6D4 D2E2 9F44 504E 4D49 3464 645F"
	$"695E A79B 4846 4B50 5A65 736C 5A47 6A61"
	$"5472 6862 6552 6069 767B 6E7D 5967 776F"
	$"8073 8564 6486 7587 7185 6468 8174 806D"
	$"855E 8191 7F93 7B8E 796D 9980 9689 8466"
	$"5F77 7D89 7F63 868B 696F 6C6A 6A5B 5262"
	$"758E A38F 9FA1 91BE 642F 3B33 527F CFD0"
	$"CFCA C9BB 3B38 314B 7465 4252 6258 4B54"
	$"3078 FFFC E399 EEAC F07D B8BC B3B4 B7C4"
	$"7E2E 403E 3D37 2151 4F4A 5449 9896 4338"
	$"3D42 4C58 6860 4833 544B 3E5C 544E 4D3F"
	$"464D 575D 5261 3D4E 5A4C 5D51 6246 4A63"
	$"5265 4F60 4447 5B51 5D4A 6242 636A 5A6E"
	$"5668 5D52 7155 7162 5D4A 4456 5C6B 6145"
	$"666A 4D5B 5B56 5548 3E4F 638E 9162 1A6F"
	$"7262 9242 172B 2745 BCBB B7AD A89D 2C33"
	$"314B 7466 4354 6354 444E 019F 7F12 AAFF"
	$"FFD4 4DB1 D8FB C4FC FEFD FCFF CA72 777C"
	$"7674 7435 3870 6568 61A2 803B 3F44 4649"
	$"5257 5960 5359 614E 595F 6173 516B 6F6A"
	$"776A 7A6B 5484 7082 7582 7264 8372 8575"
	$"8267 6B85 7987 7187 578B 9084 9587 9452"
	$"8297 8599 8195 745C 9472 7157 6483 6979"
	$"7668 7A68 505C 4B65 8183 9CBC A9B9 8C3E"
	$"625D 5DDB FBEF F2F4 F87E 4E57 517F 5E68"
	$"4913 425F 5455 6517 ABFF FED8 52A7 D2F9"
	$"BEF8 F9F7 F8FE CB76 7476 7271 7337 366D"
	$"6266 60AF 913E 4046 484C 555A 5C64 565C"
	$"6350 5C61 6578 546E 726E 796A 7A6B 5384"
	$"7284 7683 7362 8272 8272 8266 6783 7685"
	$"6F84 5488 8E83 9284 9252 8195 8295 7F96"
	$"755E 9674 7359 6686 6B76 746A 7C69 525F"
	$"4D6F 9381 91B0 9BAB 7C37 5F5A 5CDB 7FF6"
	$"E8EB EBF2 7B4F 5B52 5E69 4E1B 4962 575F"
	$"6D13 A7FF FDD2 469B CAF5 B5EF F5F3 F3FA"
	$"C66F 686D 6861 6326 2759 4D51 4CA3 8A36"
	$"3238 3A3C 4348 484F 4148 513D 484D 4B5B"
	$"3D54 564E 5B4E 5E50 3E68 4D5F 5461 5448"
	$"5F4E 5F4E 5D46 475C 5362 4B5F 376B 675B"
	$"6F61 6F37 636F 596E 576E 5440 7054 593F"
	$"4C66 4758 5648 5B4B 3C49 365C 9475 6B1A"
	$"816C 7B5D 1D49 4A52 D4ED E1E4 E4EA 7650"
	$"615A 626B 4E1B 4963 5659 6401 9E09 0DC6"
	$"FFFF AF51 7AB9 FBDD FDFF 71D7 7F7D 787D"
	$"7877 7440 2B56 684A 4BDE 9341 4E43 4E46"
	$"5668 5D61 5A50 5663 6974 656F 5C47 7570"
	$"7D71 7474 5474 727E 7A7D 825D 8A78 887C"
	$"8568 6989 7D8A 7283 5193 8F85 9487 7E53"
	$"8E8E 8996 809C 527E 988A 9270 756D 628F"
	$"9491 945C 527B 637F 7E6B 6781 9AC1 4A59"
	$"6655 ADFF F5F3 FCFF B94F 5D56 557F 554F"
	$"1F0D 2E5F 545A 6A0F C7FF FFB0 537A B4F9"
	$"DBFF FFFE FFD6 7F7E 767A 7777 7441 2B4D"
	$"664B 45E2 A246 5147 5248 586B 6266 5F54"
	$"5864 6A76 6873 5F49 7773 7F73 7575 5475"
	$"747E 787C 815A 8977 897E 8767 6788 7B8C"
	$"7485 4F91 8F84 9288 8052 8C8D 8995 7F9B"
	$"507C 988B 9371 766C 608E 9492 935B 527C"
	$"6388 8D71 6380 92B2 4155 6453 A9FD 7FED"
	$"ECF2 FCB4 4C60 5C56 5855 281C 3A64 5A62"
	$"7514 C2FF FFAA 4A70 B0F5 D6FF FAF7 FFCF"
	$"7775 6D70 6967 6531 1C40 5237 37D5 963A"
	$"4136 413B 4B57 4B53 4B41 4651 545D 4C56"
	$"4534 5E54 5F54 5657 3D59 525A 5558 6041"
	$"6852 6359 614A 4C64 5867 4E5F 3474 655D"
	$"695F 5F3A 6D66 6270 5A76 335C 6F62 6F4F"
	$"5752 466D 6865 6D3C 3A5E 476E 876C 4A1A"
	$"5F6E 8D29 3B4E 4AA6 FBEB E6EE F9B3 4D64"
	$"625C 5B54 2619 3965 585A 6701 9F7F 1AD6"
	$"FFFF 855B 775C C6D6 EBE2 E4C8 6F69 7376"
	$"7673 7265 3D3B 2E3E 3863 FF8E 3D56 475C"
	$"434B 5359 565B 4C50 7060 6D66 6A6B 4365"
	$"7076 7A70 775F 6576 7979 707B 566B 646B"
	$"6A6B 6054 6963 6A61 6B58 7E80 828E 877B"
	$"6892 8A8B 857B 7751 9A93 8C91 799B 6A6B"
	$"6F73 876E 4E81 865D 8179 8384 6A6C 5B4F"
	$"6653 88F5 F0F1 E8E1 CF53 4848 4545 7F46"
	$"231E 1027 6158 545D 22D8 FFFF 8B62 7E5E"
	$"C5D0 EAE5 E5CB 756C 7474 7371 7167 3F3C"
	$"2A3F 385B FF9B 415A 4C60 464D 565B 545A"
	$"4B51 7363 706A 6F6F 4668 7379 7B71 7860"
	$"6577 7876 6D79 586E 676C 6C6D 6356 6C66"
	$"6C64 6E57 7B7E 818E 887C 6591 898B 877D"
	$"794F 9791 8B90 799A 6C6C 7074 886F 4E81"
	$"875E 8B88 8A80 6466 5549 6350 85F2 E97F"
	$"E7DD DBCC 534E 504E 4B4E 2D29 1A2F 665B"
	$"5C6A 24D3 FFFF 8559 7555 BDCA E4DC DBC5"
	$"6E67 6F6C 6964 6359 302E 1E2C 2852 FF91"
	$"354A 3C51 393F 4449 444A 3B3D 5C4C 574E"
	$"5254 3252 5A5D 5D53 5B47 4A59 5855 4C5C"
	$"4355 4B50 5051 4B3F 4E49 5047 513E 5E5A"
	$"5E69 615C 4A6D 6064 6358 5532 786C 646A"
	$"5374 4951 5756 6A55 3667 6741 6B7F 8564"
	$"1A43 4A3C 334A 3D7D EEE5 E4DF D9C6 5253"
	$"5351 4D50 2E28 192E 675A 5760 019E 112E"
	$"6DD1 FF5A 2F46 10B8 524C 514C 2E2A 1862"
	$"87FE 772C 6239 4033 2836 72FF 8B32 504D"
	$"5047 444F 5A5C 6565 616A 696C 6E6D 6F6D"
	$"6F75 7475 7476 7673 7578 7977 7775 7476"
	$"77FE 7801 7677 FE76 3575 7674 7779 7777"
	$"7875 7F7B 7E7C 7A6F 737A 777B 7B77 7F6E"
	$"7B6E 6866 5E49 635C 5F63 8073 6567 553D"
	$"655A 61E2 F8F1 FECA 3031 1810 1210 0A48"
	$"3D1A 1409 1A62 5B3D 2C35 64C9 FF5F 354B"
	$"17BE 5854 5A55 3836 1F63 8575 7577 663C"
	$"4335 2D36 6AFF 9837 5351 544A 4751 5C5F"
	$"6767 666F 6D6F 7372 7472 7479 7A7D 7B7E"
	$"7D7A 7D7E 7D7B 7C7A 79FD 7B32 7C7B 7D7A"
	$"7979 787A 787C 7F81 7E7C 7984 8182 7E7D"
	$"7277 7F7D 7E7C 7A82 727D 716A 6860 4C62"
	$"5B5F 6C8E 7960 624F 375E 555F DFF5 EB7F"
	$"F4C2 3A40 2018 1A19 1449 2922 0E1C 675C"
	$"4539 3366 C9FF 5D2F 4511 B953 4D4F 4933"
	$"3924 6A80 6A68 6958 2F36 281B 2867 FF8F"
	$"2A45 4346 3A36 404D 505A 5952 5B5D 5F60"
	$"5F61 5F61 6767 6867 6A69 676A 6967 6567"
	$"6969 6C69 6868 6A66 6568 6666 6566 6364"
	$"666A 6365 656B 6569 6462 5860 6762 6464"
	$"5D62 5265 5852 544C 374E 4144 538B 794A"
	$"1A4A 3A24 4B40 4ED6 EDE4 EFC7 3E49 2716"
	$"1613 1148 2A21 0F1E 675C 4336 019D 362D"
	$"437A EA3C 3137 2FD2 2045 4F3E 2C2F 2369"
	$"8078 7778 6432 3E41 3233 89FF 9D3D 5653"
	$"544D 4252 5F60 6265 686A 6B6C 6B6E 6D70"
	$"7271 7372 7374 FE75 2D76 7779 7978 7B7A"
	$"7B7A 797B 7C7B 797A 7B7B 7975 7776 7678"
	$"787A 7776 7777 7679 7572 7274 7272 7171"
	$"6D6E 6B6C 5651 5DFE 6414 7B72 6360 4F52"
	$"633D 91FF F4F5 FCDD 1B19 090A 0A06 001A"
	$"3B25 0C06 1354 6141 222D 386C EA43 3232"
	$"2FD6 2D52 5A4B 3634 236C 81FE 7732 6536"
	$"3F3F 3533 87FF A142 5A57 5852 4654 6366"
	$"6669 6C6E 6F70 7174 7375 7877 7878 797A"
	$"7C7E 7D7C 7D7E 7F7D 807F 7E7C 7C7F 8180"
	$"7EFE 7F07 807E 7F7F 7D7E 7D7E FD7B 1F7A"
	$"7D7A 7778 7876 7675 7672 736E 6C57 525F"
	$"6266 6B8A 795E 624E 4F5D 3B90 FEED EE60"
	$"F3D6 2229 100B 0F0C 0449 361C 0D10 4C5E"
	$"4729 2A37 6EEA 3C29 2E2D D326 4D55 4533"
	$"3324 6C7C 706F 6F5D 2D37 3628 297B FFA2"
	$"394A 4748 4237 4754 5759 5D5E 5F62 6364"
	$"6766 686C 6B6D 6E6F 7070 7171 6F6F 7170"
	$"6D70 706F 6D6C 6F70 6F6E 6E6F 6E70 6F6E"
	$"6DFD 6E1A 696A 6A67 676A 6865 6566 6462"
	$"605E 5B5B 5758 433B 4849 4752 887C 4E1A"
	$"4A37 3B4B 2A86 FAE9 E9EF D424 361B 0C0A"
	$"0605 4A36 1A0E 114B 5D44 2701 9F7F 3758"
	$"6D93 3E41 525F 8A3F 5157 3F5B 3C3C 7995"
	$"9F99 A996 656B 9561 23A1 FFAC 3949 4A4D"
	$"4454 4F48 5356 5658 5055 5051 515A 6156"
	$"5655 5F62 5F5B 5554 565C 6168 625D 6864"
	$"6966 645D 6663 6761 675F 6863 5E59 5757"
	$"5B64 6567 5A65 5B63 6257 595A 5E59 6569"
	$"6360 5660 5351 6663 6179 715E 4F5D 6151"
	$"54C3 F5F0 F0F5 E15E 725C 1F1E 1C13 7F38"
	$"361E 1817 495E 4C34 304F 6894 3F42 4F5D"
	$"8E4B 5C60 4761 3C37 7A96 9E98 A899 6A6A"
	$"9563 1D9C FFAB 3C4D 4E51 4858 534C 575A"
	$"5A5B 5459 5556 565F 685C 5D5A 6266 6460"
	$"5A59 5A60 646B 6660 6C67 6B69 6761 6A67"
	$"6C65 6C63 6965 605C 595A 5D67 676A 5F6A"
	$"5F65 6458 5B5E 615C 6468 615F 555E 5454"
	$"6566 6788 7B5D 535F 5F52 59C6 F0E7 E761"
	$"ECDF 6378 5F21 2222 1C47 452C 2113 3F5B"
	$"4E34 354F 6895 3A3A 4F5B 8643 585C 4360"
	$"4039 7690 9993 A393 6365 8B59 1691 FFAE"
	$"343C 3D3F 394A 453E 494C 4B4C 4449 4648"
	$"4851 5B4F 504C 5256 5351 4C4B 4B51 555C"
	$"5650 5C58 5C59 5751 5A56 5A53 5953 5B54"
	$"4F4F FE4D FF56 0559 4E59 4F54 53FE 480F"
	$"4C47 5156 504B 414C 3D39 4946 4E82 794D"
	$"1A3D 4E52 454E BFED E5E6 EADA 5E78 5D1D"
	$"2225 244D 4A2C 2214 3C57 4B35 019F 7F36"
	$"626F 5E26 3B4C 717A 352D 2439 9144 3A6D"
	$"7A7C 6FAC 791D 26A9 E4C6 EBFF EBB4 4652"
	$"534F 5E53 4057 5D5C 5F42 4541 505E 5C62"
	$"4950 4A57 6355 5A4A 5658 6561 6C60 5E72"
	$"6473 6F70 5A79 6D77 6A77 617E 707A 6860"
	$"5461 6B6E 7057 7A51 7A74 766A 4F60 598D"
	$"8B87 7B53 6A5A 6D87 7A67 6A6B 6C58 5E52"
	$"3A45 C6F5 F1F2 FC95 2581 6308 0E0C 057F"
	$"2642 2612 1046 5454 2F2B 5566 5A23 3A4B"
	$"717C 3A38 2735 9445 356F 7B7B 6DAD 8024"
	$"24A6 E4BF E1FB E6B3 4A56 5753 6257 435A"
	$"6261 6346 4944 5361 6068 5058 505B 685A"
	$"5D4D 595D 6B66 7167 6477 6877 7375 607E"
	$"727C 707D 647F 727C 6B64 5766 7074 765D"
	$"7F57 7C75 776C 5364 5D8C 8A86 7A52 6959"
	$"6F87 7C6E 7676 725C 5E53 404F C9F0 E9EA"
	$"7FF5 9228 8262 0A12 110F 3552 3318 0E40"
	$"4B4F 3435 5865 5A1E 334A 6D72 3230 2233"
	$"9045 376E 7776 68A8 791C 1EA1 DBB7 D9F6"
	$"E4A8 3845 4543 5449 364D 504A 4E33 3631"
	$"3F4D 4C55 3C44 3B45 5143 493A 4544 4F4B"
	$"564B 495D 4E5D 595A 4564 5861 5461 4A65"
	$"555E 4F47 3B47 4E52 553F 6239 5E56 574F"
	$"3749 416A 6863 5D3F 5743 5264 605F 7376"
	$"6B1A 595D 4531 42BF EAE6 E6F3 9329 8561"
	$"0413 1716 3B57 331A 0E39 4750 3701 9F18"
	$"5C7A 5644 1D38 486C 5C2E 1C1A 38A1 392E"
	$"7272 7466 AA69 121C C0FE FF11 FBFE FF7B"
	$"4053 5463 4F45 515A 5451 544D 5B4F FE60"
	$"4E5B 5155 5462 5E6E 5E6E 6A6E 6C70 6C67"
	$"796C 7573 7764 8175 7B72 796D 8379 8476"
	$"7E6A 786E 6B5E 5A6C 606E 6E76 5C67 5F60"
	$"6D67 7D5E 566D 6875 7975 6460 6464 6A5C"
	$"3D3D 30A5 FAF3 FDBA 5921 3B31 0305 0400"
	$"7F18 492F 1004 2E4E 453D 546A 443D 1B31"
	$"3E6A 5D33 271F 2D9E 392B 7071 7264 AA70"
	$"1C1C B9FF FDF6 F0F9 FF7D 4656 5769 544A"
	$"5560 5956 5A53 6053 6464 6661 575B 5967"
	$"6372 6372 6E73 7175 6F6B 7D70 7A78 7B67"
	$"847C 8076 7D70 877E 887A 816D 7B71 6E62"
	$"6073 6571 6F78 5E6A 6367 6F69 7F60 576E"
	$"6A76 7A78 6A67 6C6B 6E5F 3F44 37A3 F3EA"
	$"F63F B357 2140 3605 0908 0423 5532 1404"
	$"2438 3A4B 5D6A 443E 172C 3A61 5128 211C"
	$"2B98 3429 7570 6D5E A368 1318 B1FE F5F1"
	$"EBEF FB75 384A 4C5C 483E 4950 4848 4B42"
	$"4E42 FE53 3C4F 4448 4756 5263 5464 6065"
	$"6368 635D 6E62 6D6A 6F5B 766B 7068 7165"
	$"786C 7766 6D59 665B 574C 4B5D 4F58 565F"
	$"4754 4D4F 544E 664A 465A 535C 5C63 6369"
	$"706D 1A74 6334 3429 99EE E7F0 AD53 1F3C"
	$"3202 090B 0622 5839 1805 2233 364B 019F"
	$"05BD 4C56 432C 3CFE 490F 301E 1E42 8220"
	$"2C73 686A 60BE 4B1A 19B0 FEFF FFFD 61FF"
	$"CE34 4E53 6453 3540 4546 445B 4B5F 5149"
	$"5A51 6853 6B65 6B67 6C5E 536E 666E 7174"
	$"4E75 6C75 706C 6A96 878D 8987 6D96 848A"
	$"8181 608B 7681 777E 666A 626A 595B 7667"
	$"575A 575F 3D54 6D6F 8C66 81CA 7A63 6366"
	$"5D3C 3421 8FF9 FAE4 6362 301D 2D02 0405"
	$"007F 0F49 3019 0830 4443 49B7 4350 3E22"
	$"2E37 3D41 2D1F 2134 7E22 2F75 6B6C 64C0"
	$"5027 1CAD FFF7 F5F4 F7FF CF3C 5356 6A5A"
	$"3B46 4B4D 4A61 5166 5950 6157 6C57 706B"
	$"716D 7365 5A75 6D74 7778 537A 7079 7475"
	$"719B 9094 8E8C 729C 8B91 8687 668F 7985"
	$"7A83 6F6F 666E 5D5F 7B6E 5E5C 5A64 4157"
	$"7172 8D68 84C9 7967 6B6E 6343 402B 94F5"
	$"EFDC 7F5B 602E 2435 0608 0802 1549 291D"
	$"1128 2A30 4AB9 3B49 3D22 2D35 393D 261E"
	$"2338 8024 2C75 6967 5CB9 4C1F 17A2 FEF4"
	$"F8F2 EFFF CA2F 464D 6050 313B 3F42 4156"
	$"4456 4840 5149 5F4A 625E 635F 6B5D 5268"
	$"5D66 6A6E 466C 626B 6669 678E 8184 8182"
	$"698D 7982 7979 5880 6A75 6A72 5D5E 4F55"
	$"4544 5E54 4749 4955 3347 5D5B 6F4C 74C1"
	$"756B 731A 7462 342D 1B89 F0EC D553 602E"
	$"2030 0307 0B06 1551 2E1B 0E2A 2728 4601"
	$"9F7F 7F51 7B6C 4141 3644 446D 846D 568E"
	$"568D A99F 9E9A CC8A 847F ADD9 D1D2 D1CB"
	$"F2E7 3E46 4F67 5538 3B3F 4E3C 5952 474D"
	$"4C61 6375 5B5D 6A68 6C6E 6E4E 7877 7C73"
	$"7847 7470 7672 6D53 8F85 8A88 716E 9A91"
	$"9A95 7D72 A58D 9889 8E5D 837C 735D 5E67"
	$"5E57 526A 5D38 5F6A 6E88 6E73 D4AD 4F51"
	$"4D69 8A79 73A5 E5E9 B582 9651 182E 1313"
	$"1831 7F2A 444F 3930 3436 404A 6A3A 6B5F"
	$"3230 232C 2F5A 7767 4485 4980 9D93 928F"
	$"C17F 7B74 A6D1 C7C6 C5C2 EEEA 474A 536D"
	$"5B3E 4145 5442 5F58 4E54 5367 6B7C 6264"
	$"706E 7376 7656 7F7E 837B 804E 7C77 7C76"
	$"7C66 978D 9391 7975 A098 A19D 857A AC95"
	$"9F8F 9366 8880 7761 636D 635B 536C 613C"
	$"626D 7189 6F72 CAA3 4E52 4D67 8A74 6B9B"
	$"D9DA A77F 7389 4E20 3718 1616 2217 2E36"
	$"2624 241E 2A3A 6731 5E57 2F2E 2430 2C50"
	$"6350 3677 3B68 8278 7670 A569 6057 85B3"
	$"AEB1 ACA7 D9DC 393B 4864 5134 3539 4833"
	$"4F4A 3E41 3F54 5E70 5656 6260 6569 6949"
	$"6F6C 716A 7241 6F66 6B66 674F 857C 8080"
	$"6B69 8F84 918E 766B 9980 8B7B 8253 7767"
	$"5C47 4954 4C47 3F5A 512A 4F5C 5D6A 5160"
	$"BA8F 4356 1A55 6677 5B54 87C8 CB96 6079"
	$"451C 3617 1414 1F10 2A31 1F1E 211B 2536"
	$"019F 7F56 5574 743F 3831 4D4E B7E3 C082"
	$"9EB2 DED9 D8D9 D5D1 DDDD D7D2 CDCC CCCD"
	$"C2BC E747 3A54 6656 3E4B 3754 545B 5448"
	$"656A 6A68 6A62 4C6E 7376 706E 4F61 6869"
	$"686D 4D56 5F5F 5D4C 3A65 6A69 6354 6D75"
	$"767B 756B 7191 949F 9981 6C91 8D93 8578"
	$"5C64 6B6F 7D51 4C70 676F 6A73 51BC C89C"
	$"958E AED9 D1CF CDC9 CBCC D1C1 3B28 2C2F"
	$"2C33 527F 3E37 4352 4A3B 2B3D 4046 3E5D"
	$"6332 2B22 302E 99CF AF65 879B CAC5 C3C4"
	$"C1BF CCCC C5BF BDBE BCBD B3AE E74C 3F58"
	$"6C5C 4451 3D5A 5C62 5B4E 6C71 7071 736C"
	$"5473 797C 7976 5767 6D6E 6F76 565F 6B6E"
	$"6E69 5C76 7373 6D5E 757A 7C82 7F75 7B9A"
	$"9DA9 A287 7597 9197 897E 6369 6F73 8157"
	$"5073 6A72 6A6F 4AAC B68D 867D 9BC6 BDBC"
	$"B8B3 B3B4 2BBA AE38 2E33 362E 2B33 1B19"
	$"2431 2A1D 122A 303D 3754 592D 2921 2F24"
	$"83A8 8749 6C76 9E9B 9A99 9492 A2A5 A097"
	$"93FE 9150 8789 D544 364E 6252 3944 324E"
	$"4A50 4C40 5F63 6366 6861 4866 6C6F 6B69"
	$"495C 6362 636C 4F5B 6360 5F52 3C5D 6165"
	$"6155 6D6F 6E75 7067 6C86 8691 8D77 6384"
	$"7B80 716B 5253 5659 6941 3A5C 5762 575B"
	$"3992 8D67 6B1A 637F A49A 9998 918D 8D90"
	$"8726 2C38 362E 282F 130F 1B27 1D12 0B26"
	$"2F01 9F7F 6222 3744 5E30 4D31 36A9 D6AE"
	$"8D74 BCBF BEC3 BDD2 BABB C7A8 B8E7 EBEA"
	$"E8E7 C1C0 594D 5764 5839 4A2D 3C48 5F5B"
	$"534F 6766 6F68 6E51 575E 6360 5D56 5157"
	$"6E65 7255 5A6E 5850 504E 4D60 6F70 5E75"
	$"7572 755B 6166 7977 7C70 7476 92A4 A899"
	$"8764 756C 6A47 4E68 6467 7171 6441 D8E6"
	$"E3E4 E1DA CBC6 C3C0 D2C8 CAD3 7529 3330"
	$"2E30 3123 7F38 434E 4649 4135 4745 5616"
	$"2A37 5325 3B1E 259F CDA0 7F6A B3BF BBBA"
	$"AECA B8B6 C29A 9FD7 E2DE DEDD AFBB 5853"
	$"5F6B 5F40 5033 4350 6763 5C56 6E6E 7670"
	$"765A 5F66 6B6A 6761 595F 776E 7B5D 6379"
	$"6563 6563 6371 7777 657B 7B78 7B62 686D"
	$"7E7D 867A 7B7E 9BAA AC9E 8D6C 7C73 714E"
	$"556E 686A 726D 5D39 CED5 D3D6 D3D0 C2BC"
	$"BFBB C5B9 BE7F CA76 303D 3C3B 372D 0C1A"
	$"2428 262B 2119 3234 4D0D 2230 5125 381D"
	$"2091 B98C 6C59 A6A9 ACAC A0BA A7A7 B28A"
	$"89C3 CCC9 CAC8 989F 4E4C 5561 5634 442A"
	$"353E 5954 4D4F 6461 6D65 674E 595F 6461"
	$"5E57 5459 6A61 7456 5C6B 3B2A 302A 2F53"
	$"6C6D 5B70 6F6C 7058 5E63 716A 716C 716D"
	$"8694 9787 795A 6A5F 5C3B 4559 4F56 5F5B"
	$"4E2D C0C0 BCC3 1ABC B7B1 ACAB A8B6 A7A7"
	$"B76B 2D42 4240 3E2D 050F 1B20 1B20 170E"
	$"222B 019F 7F38 171C 2238 3547 2524 4F3C"
	$"4345 3E47 454C 4F47 8A47 4649 4485 F1FF"
	$"FCFB FFF0 9644 5C5C 6257 3449 3533 455E"
	$"4352 525C 636A 5B5E 554E 4F60 6560 5B5A"
	$"506C 696A 5666 7F7D 8988 7D72 7574 6F68"
	$"7272 7571 5967 6B79 7A6C 5F5E 6E74 7F93"
	$"8C8B 685B 6660 3D51 5456 6971 734B 54ED"
	$"FAE2 E5F7 FD7B 313D 2A89 5334 3424 2920"
	$"1D19 1A1C 297F 4422 5941 3437 3942 3B2E"
	$"0D12 192D 2637 2134 6445 464D 5468 6767"
	$"563C 8C5F 604F 3A72 E8F9 F4F4 F9ED 9443"
	$"5F62 695E 3C50 3D3C 4D65 4A5A 5962 6971"
	$"6265 5E59 5A6A 6F6A 6565 5C79 7472 6169"
	$"6549 4F52 5161 7C7A 746D 7878 7B78 606E"
	$"727D 8076 6965 767C 8698 9291 6F62 6D68"
	$"4458 5959 6B6F 6C45 53EC F2D8 DFF0 FD86"
	$"4456 4497 6048 4443 2E2E 272B 2C26 1A1A"
	$"2E0A 3C22 1516 1A24 1F27 060D 1529 2234"
	$"1929 5A40 4247 4B5F 5F60 5540 8C5A 5A4B"
	$"376B E5F5 EFEF F1E0 7A35 565A 6256 3348"
	$"3833 415D 414E 515C 626A 595A FE56 FF66"
	$"3561 5C5D 5168 6468 5663 531F 1312 142F"
	$"616B 655E 6A6A 6C6B 5665 6873 7064 5D5C"
	$"6A6E 7688 8181 6052 5D56 3349 4C4C 5E62"
	$"5A36 44E8 F1D3 DA1A F0F6 7F45 5946 9B61"
	$"4547 332D 262D 302B 1B15 2706 3A1E 0F0E"
	$"0F17 1901 9F7F 3721 2C17 2940 3B2F 785B"
	$"1A47 596A 7176 6347 4B81 7075 4663 DFFF"
	$"FBFC FDFE FFB4 285D 595A 5343 503B 3145"
	$"633B 4F51 4A48 5C61 5E60 5656 536A 5C5F"
	$"586E 6D78 7667 7987 6F82 8076 6A7C 7979"
	$"6F79 7C7A 7973 5C73 727C 6274 657E 7274"
	$"6862 6E5A 5080 6739 5B5F 5F62 725F 4A62"
	$"DFFF BAA0 FDDD A851 5940 7792 4F23 2C57"
	$"3A2C 3637 2925 7F32 1A35 4D3B 303D 423E"
	$"2E19 2310 1D2F 2D33 9776 1946 6D98 ADAC"
	$"8C55 4288 9395 4B5C D5FC F5F4 F4F7 FFB3"
	$"285E 5E60 594A 5B45 3C4D 6941 5658 514F"
	$"6268 656A 6362 5F74 6569 6076 757F 7E74"
	$"775F 222A 2C2A 3E78 7E7C 727E 8381 807A"
	$"637A 7682 6B7E 6E87 7A7C 706A 7460 5586"
	$"6E3F 6066 6562 6C57 4865 DEF4 AC97 F5DB"
	$"BD7F 8C66 8FB1 692C 2924 472F 2531 3421"
	$"171D 031E 2D1A 1017 1D17 2A14 1E0C 1627"
	$"2A27 8469 1641 6183 959C 7B4C 4281 8589"
	$"4150 CDF8 F2FE EF4F FCAB 2052 575C 5445"
	$"5645 3645 653D 4F51 4C4D 5E61 5D61 5A59"
	$"566C 5D60 596C 656F 7166 6F59 1B1E 201C"
	$"2A68 6D6B 616D 7271 7070 5970 6D74 5C72"
	$"5E77 6B6E 625C 6752 4878 5E31 555C 5955"
	$"5D46 3855 D8F1 9B7E 1AE6 CBAE 6F7D 5B86"
	$"A35A 2626 4029 222F 2F19 1116 001E 2E16"
	$"080D 1114 019F 4B2C 4C5C 203D 442D 569D"
	$"3F29 4C61 9DAE ACAB 5A45 5C7F 6352 99F2"
	$"F4F3 F5F1 F3FF CA3C 4258 534E 495D 4634"
	$"3F60 494D 584A 5858 685E 6050 555E 6F6A"
	$"735B 7972 7A6F 6F66 7B41 5253 5446 7082"
	$"775F 7AFE 7C30 825F 857C 8066 6469 7B79"
	$"7F69 7B69 7A67 8058 456F 595A 676D 4464"
	$"64C9 FCCC 74EB 9FC6 908B 8095 C940 211D"
	$"3C44 3632 392B 177F 2F1A 294C 433E 4B38"
	$"301B 4354 122E 3724 58B2 4D23 466B B8D5"
	$"D5C4 5A3F 5F8A 7154 8DE9 EFEB EAEA EEFE"
	$"C63A 435C 5956 5268 513F 4B6C 5559 6255"
	$"6261 7167 6856 5D65 7771 7B61 7F78 8075"
	$"766B 6C20 2621 2421 6082 7963 7D80 8081"
	$"8A67 8C80 8571 7172 8481 856D 7F6D 7F6C"
	$"8560 4D75 6161 6566 3F64 66C7 F5C2 6BE3"
	$"9AD7 B7BB 9DA1 D739 7F15 1A31 2A19 1F2C"
	$"1C08 1E08 0F29 1C14 2312 0D1A 3E4D 0E2A"
	$"3320 52A6 4420 415F ABC6 C5BA 583E 5881"
	$"694C 85E1 E6E7 E7E4 E8F9 CB39 3B56 5250"
	$"5063 4C39 4567 5055 6050 5C5F 6C61 614E"
	$"545D 6D68 7158 746B 7269 6A5F 652A 393B"
	$"3D2C 6175 6857 7371 7070 7A57 7D71 755F"
	$"6063 7273 755B 6E5C 6D5A 7452 3E6D 5B55"
	$"5757 3155 57BF F0BC 621A D691 CDA8 A68F"
	$"9DD0 330C 1530 2713 1724 1403 1A07 0F22"
	$"0F08 1709 0501 9F7F 3147 4921 4034 3050"
	$"4F2B 3449 4855 646F 6C55 594F 3334 4358"
	$"E1FD F8F9 F8F1 EDBA 6135 4F5A 433B 5C4D"
	$"373E 534B 5252 4956 6156 5B60 5955 7170"
	$"7077 5763 767A 7276 597E 502F 352E 3E7D"
	$"847B 577C 7C7F 8075 678C 7F85 7D6F 6D7A"
	$"7462 6E7C 6772 7163 4646 5A5E 616D 5A50"
	$"705A BBFC FAAF CFCA B263 6C66 8EA2 3C30"
	$"2C26 3135 392F 2521 3E35 3122 2F2E 2D3B"
	$"352D 1F38 3D14 3225 2242 4C22 213A 4762"
	$"7580 6B49 4E47 2D31 3943 D8FC F5F1 F0EC"
	$"EBB7 5F36 515D 4A43 6758 424A 5F57 5D5C"
	$"5460 6A5F 6468 605C FE78 3D7F 5F6C 7F84"
	$"7A7D 608B 6141 4D43 4784 8880 5F83 8287"
	$"8779 6B90 838B 877A 7583 7C69 7483 6E79"
	$"786A 4D4E 6163 636A 554E 6F5A B8F5 F1A5"
	$"C4BE B06E 6F6C 939D 217F 1421 1717 1623"
	$"2215 0F23 200B 140F 0E22 190F 1E35 360F"
	$"2F22 1F40 471F 2237 3E59 6B76 6745 4A46"
	$"2C2C 333D CDF0 ECEB EBE6 E5B6 5B2E 4955"
	$"4240 6454 3D47 5D55 5C5C 505B 685B 5D61"
	$"5854 706C 6B72 535F 6F74 7074 567C 6463"
	$"7870 6983 796E 5177 7375 7469 5B80 7177"
	$"7268 6771 6E5B 6574 5F69 695B 4643 595D"
	$"585C 453E 5F49 AFEF ECA0 1ABB B8AB 6A6B"
	$"6795 9F21 0A1C 1715 0F1A 1C11 081F 1F05"
	$"0606 091B 1104 019F FF2C 7D2D 202B 2C2D"
	$"2F3B 2F46 3955 3B52 6933 4440 4536 2233"
	$"4BD0 F2E4 FAFD FFD6 E188 3B3D 534B 4C5A"
	$"4844 4E4E 4952 5054 4F69 5F63 676A 5A6E"
	$"716F 7063 5E73 7A73 725B 6C6C 5A69 596E"
	$"7A70 725C 7B77 7E81 646C 7879 7D7B 6376"
	$"7A73 676C 635E 5F64 5953 4F57 6362 6446"
	$"656F 57B9 FFF5 E8D1 D1AF 4C51 5557 652C"
	$"2736 2B2B 3C3B 2225 347F 2F45 1D1E 2F23"
	$"2D20 271B 171D 151C 1A19 1F2C 1A33 2F5A"
	$"4E67 7B31 3733 382A 1721 2FC1 EEDF F3F5"
	$"FCD4 DF88 3D3F 544F 5264 524E 5A5A 555D"
	$"595E 5972 686C 6F71 6174 7977 776C 697D"
	$"857D 7D65 7B7E 6D7D 6D7D 7E78 7D68 857F"
	$"8689 6C73 8081 8583 6A7E 837A 6F75 6C67"
	$"676B 6059 565F 665E 6041 6770 54B6 FAEB"
	$"DECB CFB1 575B 6661 6416 7F0F 2016 131B"
	$"2014 151B 1A35 090A 1C0F 1709 101C 1617"
	$"0F1A 1919 1B28 1933 2B50 4359 6E2B 332F"
	$"3527 141A 28B7 E4D5 EDF0 F6CC D47F 3236"
	$"4A46 4F63 514D 595A 555E 5B5E 5771 6466"
	$"6868 586C 706E 6F67 6475 7C75 745D 7276"
	$"6F87 7880 776F 7061 8076 7C7E 636A 7774"
	$"7673 5D70 706D 666B 6260 6468 5E58 4F57"
	$"6055 5231 535B 41AC F4E7 D91A C2C6 A54C"
	$"4E56 5C65 1507 1914 1014 1610 1312 1533"
	$"0907 180E 1306 0A01 9F7F 3829 1E2C 3423"
	$"362C 3F39 365A 5F41 6965 333F 2135 4523"
	$"2C5C 99A8 89E8 F7FF C0C2 944A 423F 524D"
	$"5543 3F4D 403B 4F4E 594F 6264 6A68 7065"
	$"5363 6D6D 725A 597B 6B6F 5462 7971 776E"
	$"736E 787E 567F 7081 6D6D 7E83 7F79 706C"
	$"897F 7C7F 665C 7068 633F 6F47 5758 634F"
	$"5370 5D51 ACFF F9CB D0DE CD56 5683 413D"
	$"3A20 4035 1836 4825 1B2E 7F29 2525 353B"
	$"382E 1D1D 241C 0F1C 2614 261A 2C2B 2A4D"
	$"5A48 8073 2A35 1A2E 3C16 1A44 8497 75DD"
	$"F0FB BEC3 974A 4440 5351 5E4C 4857 4B46"
	$"5A58 6359 6B6D 7472 786E 5C6B 7576 7B63"
	$"6385 767A 606D 837A 7D75 7D76 7F87 5F86"
	$"768A 7977 868A 857F 7873 8E84 8084 7064"
	$"7874 6F49 754D 5E57 5C4B 5170 5F4E A6FA"
	$"F0BF C7D8 C955 5887 3E36 2B7F 1428 1D04"
	$"1B2B 130E 1A11 130D 1A26 2514 070B 2318"
	$"0B1B 2412 2218 2A27 2848 5240 7067 2530"
	$"1426 3412 163C 788A 69D3 E8F0 B3B5 8A3E"
	$"3B38 4848 5B4A 4558 4F49 5B58 6358 6867"
	$"6967 7166 5567 706F 765F 5E7F 7074 596A"
	$"7B6D 7269 716F 787E 5880 6E80 6E6F 7D7E"
	$"7C78 7068 7D72 6F77 6256 6A67 6644 7340"
	$"5452 513C 425D 4D42 A3F8 EDBB 1ABC CAB4"
	$"4645 7737 2E25 0C20 1A02 1727 110D 140C"
	$"100B 141D 1E0F 0309 019F 7F39 3434 3829"
	$"2831 2A3F 1A26 5B39 4F79 4541 2648 304C"
	$"4544 495D 3A3A AACE F0B4 6C76 5754 3941"
	$"5344 373F 413E 3645 5350 515F 656B 6569"
	$"6456 5675 7772 5C54 726F 725B 7579 7F7D"
	$"7284 8186 8561 7A78 7F67 7187 9395 6E69"
	$"7793 8182 7E69 6672 6B4F 405B 3E3A 6055"
	$"486A 6D3D 4D9D FDF6 B9CE E5AA 3D40 443A"
	$"363E 3230 3620 254B 432A 1F7F 190B 2139"
	$"292C 292C 2A25 2A26 261C 1B24 172C 101A"
	$"4B2F 518D 4C36 1A3A 233F 3832 354F 302B"
	$"A1C4 ECB1 727E 5455 3A43 584E 4148 4C49"
	$"4150 5D5A 5B68 6E75 6F72 6D5F 607F 817B"
	$"655D 7C7A 7D66 7E83 8987 7B8D 8A8F 8E6A"
	$"8280 8972 7A8E 989B 7774 8197 8587 8374"
	$"6F7A 775A 4A62 4542 6050 4669 6E41 4D99"
	$"F7EC ADC8 DCA0 3937 3627 1A20 7F18 1B23"
	$"0F13 3328 1615 0C01 1123 1820 181D 1C24"
	$"2623 2519 151D 162B 0C18 4627 497F 4232"
	$"1433 1E37 322F 2D45 2922 93B6 E2AA 6C76"
	$"4F4E 3339 4F4C 3F46 4D4B 4351 5C59 5A65"
	$"676A 646B 6658 5B78 7873 5E56 7574 7760"
	$"767A 807F 7485 8286 8461 7976 7E68 7184"
	$"8D90 6C68 7489 7778 7665 606E 6E56 4A5E"
	$"3737 5B44 365A 5D35 4697 F5E9 A81A C1D6"
	$"942E 2C2A 2219 1B0F 1321 0C13 3527 1813"
	$"0A00 0E1B 111B 1614 1501 9E7F 3F37 4136"
	$"1A2F 273D 351E 3F4B 346D 5D4A 4A2A 5138"
	$"424A 4D35 4E1F 4CB1 C0DD AA6A 4555 5D47"
	$"3456 5457 5A5D 605F 6466 676C 756E 6D7A"
	$"7A79 7470 7B7D 726B 7477 797F 7581 7E82"
	$"817A 8180 8181 707C 7B7E 7563 717E 8170"
	$"757B 7F78 6E6F 7662 6666 5E5A 5954 505E"
	$"4258 7055 364D 8DFC F7CA D0EA 954C 2632"
	$"3C2F 432D 244E 2F26 413D 3029 7F1D 0F14"
	$"2226 1E40 2A4D 2F28 3128 0E22 1A2D 2811"
	$"2C37 296C 603C 3518 3D25 303B 3B23 4211"
	$"359F B5DB A977 5355 5D48 3A60 6163 6669"
	$"6C6B 6F70 7176 7E77 7683 8382 7D79 8487"
	$"7C74 7D81 858A 808C 898D 8B83 8A8A 8D8D"
	$"7C89 8988 7E6F 7A84 897A 8388 8880 777A"
	$"8670 7171 6864 635E 5B63 4258 6F5C 3F52"
	$"8DF7 ECBB CBE3 8B48 1A1C 2210 1F57 0F13"
	$"4024 1A2C 2014 1A14 0806 0D12 1136 1E3F"
	$"2D25 2E25 0919 1229 250F 2B30 1F63 5839"
	$"3413 3720 2732 381D 3C13 3291 A9D1 A176"
	$"4F50 5541 335B 6162 6569 6C6B 6F6F 7076"
	$"7A72 707D 7C7B 7775 7F7E 746D 7679 7C81"
	$"7783 8083 847F FD85 2374 8181 8378 6674"
	$"8182 7077 7E80 796F 737E 686C 6F67 635F"
	$"5751 5D38 455B 4937 4B86 F2E6 B41A C1E1"
	$"893E 1315 1D11 1C09 0D3D 2115 2416 0B11"
	$"0F06 0409 0C10 3417 3A01 9C3B 3230 3B47"
	$"1C2D 292A 2837 363E 2A46 464A 3233 3934"
	$"2536 3D65 AE1E 58BF E198 A77D 384A 5952"
	$"455C 6064 676A 6F73 7577 7A7B 7B7F 7E7F"
	$"7F81 8284 8384 8286 FE83 0D80 8484 8283"
	$"8382 7F81 8180 817C 7BFD 7D2E 7C78 7B78"
	$"7776 7677 7672 7474 7171 706D 6965 6454"
	$"6464 3937 4688 F9F9 C8B8 F1A2 4623 323E"
	$"3B29 2515 391B 1F39 3147 4639 271D 171F"
	$"241E 3649 6F22 1D29 370D 201E 1C1D 2720"
	$"2C22 4947 4126 2527 2313 232C 58AF 1539"
	$"A7D5 90AB 8C45 4D5B 534B 656C 6F72 757A"
	$"7E80 8183 8484 FD88 118A 8B8D 8C8E 8B8E"
	$"8B8C 8D8B 8E8D 8A8B 8B8A 87FE 8900 8AFE"
	$"8607 8586 8481 7E84 8181 FD7F FF7E 1A7C"
	$"7A7A 7877 736F 6A55 6464 4242 4F8A F6ED"
	$"B8B0 EB97 3A15 2023 2010 7F10 0B2D 1112"
	$"2316 2B2E 190E 0309 0D0C 2430 5522 1F2A"
	$"350C 190F 181C 221C 2518 3F40 3B20 1D20"
	$"1D0C 1C28 52A7 1334 9CCF 88A0 873F 4754"
	$"4B44 626B 7073 7375 797B 7D80 807D 8383"
	$"8281 8283 8684 8383 8683 8183 8183 8380"
	$"8284 8481 8383 8284 8080 8180 7D7F 7F7C"
	$"807E 7C78 7879 7A78 7A77 7372 7072 6E66"
	$"6249 5050 3440 4881 EFE8 AE1A 9EE0 8D2D"
	$"101D 1F1A 0B0C 072D 110F 1E10 2527 140C"
	$"0508 0A0B 212D 5701 9E36 2E2B 3237 2C39"
	$"1C1F 2B31 2A3D 3537 3141 272E 2541 262F"
	$"4792 822D 5DA7 796B B565 2952 4C53 4E4F"
	$"4548 4D4F 5356 5658 5B5C 635E 6162 6265"
	$"66FE 65FF 6622 686D 6264 6567 6465 6363"
	$"6465 6665 6664 5E62 6060 5E5F 5D5E 5E5C"
	$"5A5A 6059 5A58 5A59 57FE 541D 5251 5D66"
	$"5A34 2842 7EF6 F6C2 A9BD 8736 191C 2F30"
	$"1B40 1941 2723 2B38 3637 3D28 0B14 1039"
	$"1E27 463E 2E2B 3335 2530 0F13 1D1F 1A31"
	$"2E32 2836 1B20 1632 171F 3783 7A1D 4492"
	$"675C BB75 3558 4F55 5053 4C4E 5457 5C5F"
	$"6061 6465 6C66 6A6B 6BFE 6E00 6FFE 6E07"
	$"7076 6B6D 6F6F 6E6E FD6D FF6C 056D 6C66"
	$"6A69 67FE 66FF 6721 6564 6369 6161 5F61"
	$"605E 5B5A 5A59 545D 685B 3B33 4A81 F2EB"
	$"B08F A46C 210F 0E16 1C0E 4A30 0E32 1714"
	$"1921 1E28 2002 0603 2E10 091D 1A15 1316"
	$"1F19 240E 0D16 1916 2A26 2B23 2F13 1A12"
	$"2D13 1A2F 7D78 193B 8861 56B0 6B2D 574D"
	$"4E48 4F4A 4D52 545A 5D5D 5F61 6369 6467"
	$"6869 6B6C 6A6B FE6A 1869 6E68 6A6B 6D67"
	$"686B 6A6A 6B6A 6A6B 6A64 6867 6664 6561"
	$"6262 FE61 1567 5F60 5D5E 5E5C 5858 5552"
	$"4D4E 544F 3634 4574 EBE7 A71A 8698 6018"
	$"060A 1514 042D 0E2F 120E 131B 1928 1E01"
	$"0603 2A0F 091C 1901 9F7F 8379 7B77 7C7D"
	$"2D0D 283C 363A 3633 353F 2937 2240 2735"
	$"4553 3936 5D7E 4181 9852 2456 3245 5359"
	$"2B35 3A4A 5E46 4440 4B5A 5955 5264 625D"
	$"564D 4F56 585C 5165 4945 4844 5450 4E4C"
	$"4D51 5351 545E 5152 4E58 5C59 534F 5257"
	$"6165 5E57 5261 524B 4B60 6439 3453 6347"
	$"453C 2443 6BF4 D0B5 566C 3B3D 321A 1726"
	$"3021 1B4D 3816 213C 3533 7F5B 2415 0B27"
	$"2F2D 2F2F C5BD C0B7 B2A1 3E0A 182D 2C2F"
	$"2925 2631 1B28 1431 1A28 3540 281F 4B73"
	$"2D6E 9B61 3263 3849 585D 303A 3F54 6950"
	$"4D4B 5665 6561 5D70 6E68 6158 5A61 6366"
	$"5A71 5652 5551 635F 5B59 5A5E 605F 626C"
	$"6062 5C64 6864 605D 6065 6F73 6C63 5D6C"
	$"5D57 566B 6B3F 3B55 644C 493E 2947 6AF0"
	$"C4A1 3C53 2428 230D 081A 267F 1A0D 3824"
	$"0811 231B 2958 200D 031F 2415 1010 3A28"
	$"2A2B 2B3C 1B08 1625 242A 2420 202B 1626"
	$"112A 1422 2E3A 281E 4067 2B65 8A57 2B5F"
	$"3945 4F59 2C33 354F 6A54 524E 5968 6762"
	$"5E70 6E67 615A 5D64 6264 5971 5B58 5B58"
	$"635C 5F60 6063 615F 626C 5F61 5C65 6A65"
	$"6260 6367 6F73 6D63 5D6D 605A 5A6E 6539"
	$"3750 553A 423A 2641 60E4 BB9A 1A34 491B"
	$"1C1B 0907 131E 180E 351C 030D 1B14 2854"
	$"1C0B 011A 2114 0C0D 019F 0086 FE82 7B8F"
	$"A997 3D16 3C39 3933 2D47 3C2C 3142 4039"
	$"473A 252E 3891 9A45 685F 4921 552F 314A"
	$"5A33 373F 4B4B 4343 3D43 526A 615B 5A5D"
	$"5D5E 544F 5966 604F 6540 4039 3C4F 514A"
	$"4748 4B50 4D57 6D5E 5854 6972 765E 5D70"
	$"6B72 7167 8581 7447 484E 6B62 3732 585D"
	$"2E48 4227 3D64 D885 7E39 4F2B 2C28 2815"
	$"182F 2324 3B52 2B19 394D 204C 3516 0E0A"
	$"2B37 2321 36DD DCDC DAE0 EDD2 5E14 2D2F"
	$"312E 2434 2C1F 2332 3128 342A 1720 1E80"
	$"912F 515C 572F 6638 3751 5F36 3A43 5659"
	$"504F 4A4F 5F77 6E68 676C 6B6D 625D 6674"
	$"6D5B 7250 514A 485B 5CFE 592F 5B5E 5A65"
	$"7A6A 6560 747D 816B 6A7D 7980 7E75 908B"
	$"7F54 595F 7B6B 3F3A 5A5D 364F 412A 3D5C"
	$"CD70 6320 3612 1715 1B0B 0920 7F1B 1828"
	$"3E1F 0C20 3014 2E0F 0300 202B 1712 2033"
	$"2325 2A2B 3C30 1913 2B23 2A25 1C2D 271D"
	$"2330 281F 2E23 1120 1D75 862D 4E54 4D28"
	$"603A 364A 5A32 3135 4C55 5254 4C51 6176"
	$"6C66 6263 6365 5B57 606C 6558 7356 564F"
	$"505C 5857 5858 5A5B 5862 7562 5D57 6770"
	$"745F 6073 6D71 6F66 8885 784E 555A 755C"
	$"3131 534F 274A 3C21 3756 C166 611A 1C30"
	$"0C0D 0F15 0907 1D1D 1B2D 4421 0918 2713"
	$"2B0D 0300 1D27 130A 1A01 9F7F 817E 7D81"
	$"8C98 8F96 6533 4540 433A 3045 2D2B 3242"
	$"4D38 1D2C 3D50 8E46 3445 3659 2558 2A27"
	$"5056 373E 3B56 4347 4947 4751 684B 5953"
	$"5960 635F 5358 6664 5B68 3F4C 4548 4F54"
	$"5851 5453 5754 5D71 5E53 5C6B 7271 5B5A"
	$"6E6C 6761 6760 6355 474D 4D50 413B 3E54"
	$"4C27 4545 2846 686D 403E 3C2D 3D1A 1821"
	$"1B10 132B 2922 2E3E 1D27 482D 0937 0310"
	$"0532 2514 1F30 D8FE D672 DBE7 E2DE 9035"
	$"3331 3931 2131 1F1B 1F2E 3625 101C 2A3D"
	$"7B36 263C 3A62 3064 3735 515D 3D45 415E"
	$"5156 5453 535C 6F55 6661 636B 6E6A 5E63"
	$"706E 6573 4E5C 5456 5D63 655D 5F5F 615F"
	$"677C 6A5E 6673 7978 6465 7977 726A 7067"
	$"6D62 525A 5F5C 4942 4557 5134 4E46 2542"
	$"5F5F 2D26 2519 2409 0A14 0F05 0A57 241E"
	$"151E 3215 1C3B 2330 0009 022E 1A09 121F"
	$"3323 2524 2B2E 1E2F 2216 3028 342D 2032"
	$"1D1A 1A27 3020 091D 2D36 7130 2135 2F59"
	$"2A62 3735 515C 3C3D 3B5A 4F59 5A56 5660"
	$"7256 655E 6269 6D69 5960 6F6C 6274 5562"
	$"5B59 5E64 675F FE61 245B 677B 655B 616B"
	$"7170 6060 726E 6762 6A65 6B5C 525D 5E5B"
	$"413A 3E50 4627 4840 1E3A 5657 2721 1A1B"
	$"0D19 0708 0F0A 0109 241D 151F 3111 1634"
	$"212F 0009 002A 1604 0D1A 019F 7F82 7D7D"
	$"7F8E 9A86 8A9A 874F 2D49 362C 5437 2644"
	$"3F42 2736 3A4E 483C 3146 513D 4E32 5C2C"
	$"2B57 5130 3A32 5154 414D 4A3D 485C 4954"
	$"484B 4C5E 645B 4D5A 544F 694B 463A 4D48"
	$"4F54 494C 4B4E 505D 6651 5E62 6067 695A"
	$"7469 655B 5A62 6B63 494C 565B 6839 353B"
	$"5155 2F40 4325 4068 7732 3526 1829 1C2F"
	$"3E23 1012 0C0B 0B28 3A0A 1037 457F 1A08"
	$"1F1C 2140 252B 23D9 D6D6 D5DC E8DA E1E9"
	$"BB5B 2138 291E 4028 1730 292E 1E2F 2E3D"
	$"382C 2134 4239 5038 6538 3A58 5734 3E36"
	$"5862 515A 584A 5568 5560 5455 5667 6E66"
	$"5865 5F5A 7459 5449 5A54 5A5F 5457 5659"
	$"5B68 705B 686C 6B72 7462 7B72 6E66 656D"
	$"776E 5454 5D62 6F40 3C42 5458 3741 3A1C"
	$"385C 6820 2014 0C1A 0A1D 2D13 0308 7F04"
	$"0504 1F30 0108 2D3D 1300 0E0A 1535 181A"
	$"1034 2326 222C 301C 1B1C 2A24 1A38 271E"
	$"4127 132B 232C 1B2A 2E3A 3324 182D 392D"
	$"4731 6337 3756 532E 312B 505C 4F5C 5B4E"
	$"5869 545C 5154 5566 6C5F 5560 5752 6F5B"
	$"564B 5C57 5D62 575A 5957 5364 6D55 6366"
	$"6067 6959 7366 615F 606A 6E66 5055 5F63"
	$"6C38 3439 4C4D 2C3D 3614 2E53 611B 1B1A"
	$"0F07 1709 1A28 0E02 0602 0404 202F 0006"
	$"2B3C 1200 0C07 0D2C 1417 0E01 9F7F 817E"
	$"7D7F 9197 878D 8B9F 7323 3B2F 364D 3332"
	$"3D37 4626 3C3E 5136 3E39 3F50 2D3B 465A"
	$"2E2F 554B 3138 414D 5042 4945 4047 5043"
	$"4B53 4F4D 6563 5657 544D 4E6B 4E54 555A"
	$"6456 5C59 6153 5F67 5F6F 6061 6659 5B63"
	$"676A 726A 5863 6064 5C4B 515C 5470 383D"
	$"3750 4F39 4341 3038 4C60 3A3B 2621 101D"
	$"4A3F 3121 1215 0E0E 2111 101F 2A10 090D"
	$"1925 3D3E 3837 2920 D8FE D672 DEE4 DADC"
	$"DCED 9D20 261F 2838 2523 2A21 321E 342F"
	$"4328 302C 3041 2536 4761 3C3F 5653 373F"
	$"4854 5D51 5655 4F56 6152 575D 5957 6F6E"
	$"6162 5E58 5976 5A60 6166 6F60 6865 6E60"
	$"6A72 6A78 6869 6F66 6770 7376 7E77 6570"
	$"6D72 6855 565B 5074 4045 4052 4E3B 3A2D"
	$"1F2B 3C4F 2929 1317 0608 3229 1D11 047F"
	$"0A09 0616 0605 1524 0904 0B0A 1617 1C26"
	$"160C 3324 2622 2E2D 1B20 2028 2817 211B"
	$"283A 241C 231E 321A 2C2A 3A25 2A23 2B3C"
	$"1E2D 405D 3739 524D 3233 3C50 5C54 5B58"
	$"5259 6656 5A5D 5856 6F68 575B 5C56 5674"
	$"5960 6061 6A5C 6260 675A 6569 6473 6162"
	$"675D 5F67 6A6B 6F69 5F6D 6C6F 6552 555B"
	$"4E6D 3439 334A 4533 3929 1821 3548 2322"
	$"1A0D 1205 062E 241B 1203 0506 0415 0503"
	$"1424 0A04 0A06 1110 1523 130B 019F 7F82"
	$"7E7E 8195 9389 8E8B 976C 203B 2534 3743"
	$"413C 4251 3A29 463B 3038 3149 382D 3C4A"
	$"522D 3852 4C2F 344D 543D 4346 4644 5053"
	$"474C 5154 4E60 5952 5758 5450 604B 5354"
	$"5864 5C62 5C64 585F 6256 6759 5758 5A5E"
	$"6B69 5E61 5E5D 6B5B 5F52 4F3D 5E3E 5D3A"
	$"4231 4F4F 3A40 3E3C 2C3B 3C24 272D 3D0E"
	$"122E 2C46 4527 120D 0D28 2025 4D51 357F"
	$"1426 3934 352D 2F2A 1BD9 D8D8 D6E4 E3DB"
	$"DCDD E896 1D27 1926 2735 322E 2F3B 2719"
	$"362B 262C 223D 2D1F 3148 5A38 4155 5038"
	$"3D54 5B4B 5554 5757 6165 585C 6062 5C6F"
	$"6963 6968 6461 715D 6465 6772 6A71 6B73"
	$"676F 7367 7669 6667 686D 7B77 6B6E 6C6C"
	$"7A6A 6D61 5A40 5E3D 5F3F 463B 5148 3839"
	$"2523 1829 2C12 121B 2D04 051F 1F33 321A"
	$"7F09 0805 1B0F 1139 432D 0A0C 1715 130E"
	$"1B14 0632 2024 2230 281A 1F1D 2622 0E26"
	$"141F 212E 2B29 2E3E 2916 3028 2327 1C36"
	$"2A1F 2A41 5635 3F53 5038 3648 564B 5A5D"
	$"5D5C 6668 5B5F 6366 6072 6860 666A 6864"
	$"745F 6768 6772 6A6F 686F 6470 7266 7769"
	$"6668 696C 7776 6B6D 6A6B 7A6A 6E60 5A42"
	$"5F3C 5A37 392F 4C45 3336 1D19 122C 2D0C"
	$"081A 1225 0004 1D1A 3131 1506 0504 1B0C"
	$"0831 3F2A 0809 1213 110A 1913 0501 9F7F"
	$"817F 7E82 9990 8B8D 8A98 6724 4128 2723"
	$"3943 462D 3B45 372B 2A38 2D3C 581C 3446"
	$"5B4E 333F 5242 3633 4E5C 3E46 4749 4855"
	$"584C 4F51 5252 6056 5153 5555 5665 5658"
	$"585A 5A5E 625A 5E5E 5B5A 5E66 595D 605E"
	$"5E61 5F5A 5C5B 5A56 5E5C 5A5A 3B53 4A59"
	$"4346 404D 5437 3A39 4238 3830 1418 3E4B"
	$"2009 1017 1F33 3C13 2322 2D31 2D49 594D"
	$"3B13 2E2C 3435 3D35 2E1F D8D9 D8D6 E7E1"
	$"DCDC DDEA 901F 301D 1713 272E 3720 2A33"
	$"271E 1B2C 212A 470E 2138 5550 353C 4D42"
	$"3F3A 5462 4A56 5558 5A63 675C 5FFE 6103"
	$"6F69 6365 FE67 1677 686A 696A 696D 7169"
	$"6E6E 6D6C 7079 6C70 716E 6E71 6E69 FE6A"
	$"1F66 6E69 6965 3C51 4958 3E3D 3B46 4830"
	$"3225 2B25 2925 0807 2A36 1100 060D 1527"
	$"317F 0D18 131B 1E1A 3445 3E07 130C 1C1C"
	$"211E 1708 311F 2322 3325 1A1F 1C29 2313"
	$"2B14 100C 2029 311D 2933 251B 1624 1621"
	$"3F08 1B31 4E4A 323B 4D43 4137 4C5D 4A5C"
	$"5F60 626C 6C60 6366 6868 766D 6768 6C6D"
	$"6D7D 6E70 706F 6E73 766C 7070 7171 747D"
	$"7074 756E 6E71 706C 6E6D 6F6B 726D 6B6A"
	$"4052 4958 3833 3244 4428 2D1E 211D 231F"
	$"0404 1A23 2E0E 0005 0B12 232A 0916 121B"
	$"1E18 3141 3906 1109 1C1C 1F1D 1607 019C"
	$"3882 7F7D 8399 8E8B 8D8A 9757 2625 2542"
	$"3D30 3537 1839 4337 1A22 3C32 443F 2749"
	$"5061 4431 444D 3931 3040 5C3A 393C 3A3A"
	$"4D49 3A40 3F40 3D56 473E FD42 425B 4146"
	$"4647 484E 5445 4C4C 4948 4D5E 4349 494C"
	$"4A54 5245 4947 4744 524E 474A 4642 4E5D"
	$"4241 4A43 5131 321C 313E 2E2A 1913 1C30"
	$"2910 090C 0A1C 390A 232C 4A5E 204E 3C22"
	$"0D38 311E 3323 2E2A 3A24 D9D9 D7D7 E7FE"
	$"DD30 DCE9 7F20 1419 2E29 1C22 280A 2835"
	$"2A10 1428 2234 301C 3841 573F 2E3A 443D"
	$"3B36 4560 4546 4545 4958 5647 4D4D 4E4B"
	$"6459 50FD 5308 6C52 5757 5657 5D62 53FE"
	$"5A0A 595E 6F55 5A5A 5B59 6362 56FE 591F"
	$"5764 5B55 5447 3F4B 593A 313B 3444 2728"
	$"111F 2E1C 1B0D 040C 1F1F 0701 0303 1027"
	$"4A03 161D 3A4F 133E 240B 291B 0521 111A"
	$"1928 1331 2022 2334 221A 1D1B 2924 1D10"
	$"1126 2217 1A22 0624 3029 0F0E 2117 2D2D"
	$"1630 3C50 3628 3A43 3B3D 3642 5D46 4D51"
	$"5152 635E 4E54 5557 536C 6159 FD5B 3074"
	$"595F 5F5D 5E64 695B 6162 6160 6576 5C61"
	$"615F 5F6C 695C 6060 615F 6C63 5C5F 4B3E"
	$"4D5C 3327 3330 3B1C 220D 1624 1211 0A03"
	$"1A06 191D 0601 0502 0C22 0012 1937 4E14"
	$"3D1E 0729 1B03 2011 181C 2C16 019D 4580"
	$"7F80 869A 8B8B 8C8A 9545 0717 3B43 3D3C"
	$"3D27 2540 5435 3527 2E3E 4837 3A47 547A"
	$"3533 4150 422F 3240 4D39 3536 3835 4B44"
	$"363B 3A3B 3656 443A 3C3D 3C3C 583A 403E"
	$"3F40 454E 3CFD 4109 465A 3C40 4041 3E4C"
	$"493A FE3F 283D 4D4A 3C41 3A3C 4960 4541"
	$"4741 4A2E 181E 1E35 3423 311E 1410 0F19"
	$"120E 0B18 321A 1546 393E 1840 492E 554B"
	$"3539 2216 2121 2A21 D7D8 D7D8 E8DC DDDD"
	$"DEE3 6500 0630 312B 2A2E 1914 2C45 2828"
	$"191B 2B38 282B 3643 6C2B 2E36 4647 393B"
	$"454F 4243 4243 4356 4F41 4747 4944 6453"
	$"494B 4C4D 4D68 4A50 4F4E 4F54 5D4C 5251"
	$"5252 566A 4CFE 5026 4D5B 5A4C 5050 4F4D"
	$"5C55 4C4D 3735 455B 392F 352F 361F 0D15"
	$"1126 2413 220F 0B06 0814 0D0A 0409 2157"
	$"1009 3628 2F0E 322F 1131 161A 0F03 0B15"
	$"2016 3021 2223 311D 1C1F 1B26 1D01 052C"
	$"3027 2527 140F 2740 2525 1718 2734 2425"
	$"2E3D 6626 2A37 4544 393C 474F 4349 4E51"
	$"5064 5D4E 5252 5550 705E 5456 5858 5672"
	$"575C 5B59 595F 6756 FD5B 235F 7455 595A"
	$"5C5B 6A66 565A 5B5C 5966 6056 593E 2D41"
	$"5F34 262D 292E 1708 120A 1F1D 0F1D 0C1A"
	$"0702 0511 0B0B 0405 1E0E 0735 242B 0C2B"
	$"2509 2C11 170D 0109 121D 1401 9F04 817F"
	$"8289 99FE 8B77 8A96 3D13 1935 4934 343F"
	$"203E 3952 3F3F 433A 2B54 4544 4C6C 5E3D"
	$"3A41 5044 3B39 4049 3231 3033 3349 3A33"
	$"3838 3730 5641 3A3B 3A38 3C55 373C 3B3C"
	$"3B3F 4A35 3B3C 3E3C 4159 3A40 403C 3949"
	$"4836 393B 3B38 4846 373D 3332 4C5F 4641"
	$"373E 2D3E 1819 1626 3B24 1826 1F0F 0D11"
	$"1812 1216 1F32 2037 3127 3640 5E3B 7F35"
	$"2830 2A20 2939 2417 D8D7 D7D8 E5DC DEDD"
	$"E1DD 520E 0C2A 3925 262E 0E2D 283F 2C2D"
	$"352A 1A3F 2D2D 3556 4C30 2E2F 3E3D 383F"
	$"454A 3B40 3F41 4157 4741 4648 4740 664F"
	$"4848 4A4A 4D67 474C 4C4D 4C50 5B47 4D4E"
	$"4E4C 5168 484D 4E4D 4A5A 5948 4B4C 4B48"
	$"5852 494C 2E27 475E 342A 242C 192F 0E10"
	$"0B19 311A 0E1C 1708 0508 1210 0908 1550"
	$"2918 2A20 162A 3149 271C 0B0F 140B 1129"
	$"160C 3122 2322 2D1B 1D21 1A26 1B07 0928"
	$"3C24 2128 0C2A 243D 2A2A 3025 163A 2626"
	$"2E50 472C 2A2C 3C37 353B 4448 3C47 4A4E"
	$"4D64 574E 5153 534C 725A 5253 5453 546F"
	$"54FE 582B 5659 6653 595A 5B5A 5F75 555B"
	$"5B59 5666 6554 5758 5752 605D 5257 391F"
	$"405D 3223 1D28 172A 0A0E 0813 2D19 0D1A"
	$"1A14 0502 0610 0F09 0713 2713 2718 0F26"
	$"283F 2017 080C 0E05 0E29 160B 019F 7F81"
	$"7F80 8C97 898A 8A89 9049 2B13 304D 2628"
	$"302A 3D3B 2E25 3939 2824 4F45 4A4B 496A"
	$"473E 434A 3E3A 4141 4E27 3339 3C38 5041"
	$"4041 443C 365B 443D 3D3A 4148 5943 4645"
	$"4346 4F56 4B52 504E 464D 5F49 4F4C 4A46"
	$"484B 3B43 443D 4453 4644 4737 2B36 4E44"
	$"342F 1A24 4323 0B18 2139 1D0C 0C13 150E"
	$"0D1B 4E2A 1729 1F3A 3031 444A 3C3A 287F"
	$"3620 2338 2717 1516 13D8 D7D6 DBE3 D9DD"
	$"DDE0 D859 230A 243E 1719 1D18 2F2D 1E14"
	$"292B 1811 3A2F 3535 3153 3130 2F31 2F32"
	$"4241 4E30 4248 4B47 6053 5252 564F 486D"
	$"564F 4E4B 525A 6B55 5757 5557 6167 5C63"
	$"6060 585E 7059 5F5C 5C57 5A5D 4D56 5650"
	$"5767 5957 563E 262C 4C37 211E 0E19 391A"
	$"020E 132A 1103 060B 0D06 040F 3E1A 0A1F"
	$"7F15 2D23 2438 3D2D 2D18 260E 132A 1605"
	$"0508 0931 2221 252C 191D 1E17 2C25 1605"
	$"1D3A 1415 1612 2B2C 1E15 2926 130D 382E"
	$"3434 2E4E 2926 282C 282E 3D3E 4C31 4851"
	$"514E 6658 5A5C 5F56 5075 5C55 5552 595E"
	$"6E5B 5D5C 5A5C 6668 5961 5E60 595F 705A"
	$"5F5F 615D 5F65 565E 5F59 5C6A 5F5E 5E48"
	$"272D 452E 1819 0C15 3517 000A 0D29 1102"
	$"041A 080A 0302 0D3C 190A 1E14 2B26 2432"
	$"3526 2614 2410 1125 1202 0607 0701 9F7F"
	$"827E 808E 988A 8B89 8894 352A 144C 3520"
	$"433C 2B28 171F 3933 423E 4149 3842 3E58"
	$"5C3F 2F39 4E36 4547 4F50 4449 4F51 4D60"
	$"5557 5E63 5251 6357 5251 4E54 555F 494F"
	$"4E50 5758 5F59 5B59 5355 545E 4D50 4C50"
	$"5552 534C 5558 4C50 6254 544E 4947 2349"
	$"3729 1B13 192F 3B12 1C27 2D27 1025 1212"
	$"0E0A 0F40 391D 1C15 2F50 3434 242F 1D13"
	$"7F25 1A21 1616 150F 0C13 D9D7 D5DC E4DA"
	$"DDDC DFD8 4220 0C3F 2511 342A 191A 0C13"
	$"2E28 342D 2C36 2A34 2E40 4529 2126 3426"
	$"3C43 484F 4D55 5B5F 5A6F 6769 7076 6464"
	$"7A69 6463 5F62 636E 5C60 5E60 6867 6B64"
	$"6665 6366 666D 595E 5D61 6463 655E 686B"
	$"5F65 7767 635C 594B 1941 2C1A 0F0A 1025"
	$"3009 121C 1C17 061D 0B0B 0605 0428 1D0C"
	$"147F 0B1D 3D24 2918 1F13 0F1F 151A 0D09"
	$"0803 0206 3322 2226 2B19 1C1C 1432 1B1A"
	$"0939 200C 2F22 1418 0B13 2E28 312C 2B36"
	$"2933 2E3D 3F20 1A21 2F21 393F 4851 505C"
	$"6362 5D71 6A6E 7985 706A 8274 6E6A 666A"
	$"686F 5C61 5F62 696A 6E65 6866 6769 6B73"
	$"5E62 5F63 6766 6B67 6F72 686C 7F6E 6A62"
	$"614F 1E3B 2212 0B09 0E23 2E05 0D15 1614"
	$"0117 FF09 FF04 1602 261D 0A0F 0918 3B1F"
	$"2011 1A0F 0A1B 1519 0C09 0803 0106 019F"
	$"7F83 7E7E 9397 8B8B 8989 931B 1738 3D34"
	$"3742 4322 2723 3841 1A2C 4745 4A3C 253C"
	$"3D25 2A2F 4A58 3447 3D49 4F33 3B3A 4A45"
	$"544C 4C5C 8F49 4D7D 777F 6B3E 5673 6D5D"
	$"5D55 4B47 5055 5354 5252 4E50 6354 5A5F"
	$"7163 4166 847C 764A 5A93 4B50 4C4B 4D3A"
	$"3C37 2812 1528 252F 1316 1C1C 1912 190B"
	$"151A 0C07 2B37 412E 1320 3638 393E 331C"
	$"0B7F 1121 1913 0B0D 0807 13D8 D8D5 E1E3"
	$"DBDC DDE0 CD24 112E 2F20 2634 3615 1A15"
	$"2834 0F1B 3531 372F 192B 2C15 1B20 323F"
	$"2233 3246 553C 4243 5550 5F58 5D7A B05F"
	$"66A4 9A9E 8654 6A88 8474 7067 5D5B 666A"
	$"6567 6566 5C5E 7569 747C 8573 5681 A298"
	$"8B55 75B2 5855 5452 4B34 3227 1505 0B1D"
	$"1A25 0B0D 130E 0D09 0F05 0D10 0602 1C1D"
	$"2820 7F0C 1524 272D 3424 0C02 0614 100B"
	$"0306 0401 0435 2323 2925 171C 1A15 340F"
	$"0E29 281D 232F 2D12 1610 2934 0E18 312E"
	$"352C 1529 270F 151C 2D3A 1F30 2E41 5740"
	$"4748 5A55 645F 6589 CD76 6EB0 B5BA 995D"
	$"719C 907E 7C73 655E 6D75 7071 7070 6264"
	$"7F74 7E88 9682 5F8E B8B1 A062 7EC2 655B"
	$"5958 5036 3122 0F03 0915 121D 0307 0E08"
	$"0705 0E1A 050B 0E05 001B 1D23 1B09 141F"
	$"1E26 2C1E 0C02 0612 0F0A 0104 0200 0501"
	$"9F7F 837F 7E98 968C 8B88 8B8B 120F 2A1C"
	$"1331 2428 3037 1C38 3A18 3739 3645 2E2B"
	$"3E37 3241 3855 3F3A 3A34 4D45 3247 3040"
	$"4253 433D 5791 3C44 968A 966F 2C58 8C7C"
	$"878B 795A 3780 8C90 8E90 9152 498E 8D8D"
	$"909E 7330 74A9 9F80 3753 AA4D 2D3D 4B40"
	$"2B3C 3331 2D1B 2315 0E16 120D 1614 0A11"
	$"1117 5A1A 1C24 1E33 6921 411B 212D 4B22"
	$"4125 7F14 2112 1112 0C0A 070E D8D9 D5E5"
	$"E1DB DCDD E3C2 1606 1D0D 0623 151B 232A"
	$"0E29 2D0D 2327 2A35 1E1D 2A27 212C 2542"
	$"2B2A 3034 5550 3D52 3A4B 4C5D 4D51 7EB8"
	$"5966 BFBA BF91 4876 B0A6 B0B1 9D72 51A4"
	$"B2B3 B2B5 B46C 60AE B4B4 B7BB 8A4B 9AD2"
	$"BE8D 3367 C954 2B3F 4936 2132 2622 2113"
	$"1A0B 050D 0905 090C 0407 060A 4C12 0F13"
	$"1021 530A 1A3D 0E0E 1E3F 1534 1706 13FE"
	$"0A71 0403 0203 3122 212D 2418 1C16 1739"
	$"0903 1909 031D 1116 1E23 0A27 2A0B 2023"
	$"2631 1918 2521 1B28 213B 2428 2F32 5350"
	$"3E53 3D51 5263 555A 8AD7 7572 D2E7 EDB6"
	$"5B82 D7CA D2D5 C08B 62B5 CDD4 D2D5 CC79"
	$"6ABD CFD4 DBDD A358 A6ED E2AD 4573 DA60"
	$"2D41 4D39 1F2C 1F18 1C11 1608 0307 0502"
	$"0508 0207 1A05 0748 0E0D 130F 1C50 1939"
	$"0C0B 1935 0F2F 1405 1108 0908 0302 0102"
	$"019F 7F83 7F81 9C93 8C8B 888E 8111 2338"
	$"472F 192A 2831 281B 3C2F 2434 212E 5042"
	$"432D 2F45 432A 3535 4238 4C6C 6460 6761"
	$"6166 6E63 6373 8666 6683 8088 7259 6D83"
	$"787F 8077 6959 777E 7F7E 7E80 605D 7C7F"
	$"7F81 8471 4E6F 9570 5040 3D87 5146 2F40"
	$"4027 1E23 2726 111E 140D 1318 291E 150E"
	$"1C1A 1F4B 5235 2D27 1922 2D26 1B15 1130"
	$"1924 2D7F 1C13 1417 110D 0C0C 0AD8 D9D8"
	$"E9DE DBDC DBE5 B914 1728 3826 0D1B 1A25"
	$"1B0D 2D22 1929 141E 3D2F 3419 1830 3118"
	$"2726 3330 4E76 726E 756E 6D71 7A74 7184"
	$"9776 7E9B 9AA0 8A6B 7E97 9199 988D 796A"
	$"8F97 9997 9794 706F 959A 989B 9E83 5F87"
	$"AB79 4930 3F91 503F 2A3A 361F 1719 1A1D"
	$"0B17 0C05 090D 1E13 0F0A 130C 0E39 4523"
	$"1C18 0E1A FF1C 7D0E 0A04 210F 1921 130C"
	$"0C0F 0904 0305 0130 2121 3022 181D 1B1B"
	$"3909 1325 3221 0717 181E 160B 281D 1524"
	$"0F1B 3829 2C13 152B 2B16 201D 302D 4971"
	$"6F6C 736C 6B70 7975 7085 A47F 7DA6 ACB1"
	$"9270 85AC A0A8 A99E 8671 96A4 A8A6 A7A3"
	$"7873 A0AD ABAE B190 6792 BC89 5334 3E95"
	$"563F 293E 3A1E 110F 0F15 0814 0A02 080B"
	$"1C0D 0704 0FFF 0A18 3339 1A17 160A 151F"
	$"1A0D 0802 1C0B 171B 0E08 0A0E 0803 0204"
	$"0101 9E7F 837F 849F 8D8B 8989 926A 1039"
	$"2334 2A23 2026 3216 213B 3D40 2223 303C"
	$"2F3D 3B28 3842 303A 4C4C 4F67 867E 8686"
	$"8A89 8A8B 8D8D 8C88 8A8B 8785 8482 8685"
	$"8686 8583 8081 827F 7D7B 7A7A 7B7C 7C77"
	$"7573 7270 7173 6F6F 655E 3F2F 475B 3B31"
	$"393A 2914 1224 1913 1215 190C 1343 1C0E"
	$"1411 121C 236A 442D 3D24 2A13 0D15 260F"
	$"1F22 0C0E 0C1A 1C0D 1413 1013 1512 DAD9"
	$"D8EE FEDD 23DC E79A 0F2B 1527 211C 1719"
	$"290B 112C 2F32 1818 232E 212B 2917 2731"
	$"1B25 3638 4363 8A85 91FE 920E 9495 9593"
	$"9290 9696 908D 8F91 938F 8BFD 8A0B 8C8D"
	$"8A88 8785 8583 8585 8283 FE80 267F 817C"
	$"7A6E 6238 2541 4D28 1F2B 2D1E 0605 170C"
	$"080A 1015 0406 3210 050A 0806 0D18 5731"
	$"1D2D 1720 5708 050B 1D06 1518 0306 1315"
	$"060C 0A05 0507 0430 2123 311E 1D1E 1B21"
	$"3803 2312 241D 0C0E 1120 0A11 292B 2F16"
	$"1520 2A1D 2821 1324 3018 1B2A 313A 6086"
	$"7E89 888A 8A8B 8C90 8D8C 8D8F 8C8A 8888"
	$"898D 8B8A 8786 8584 898A 8484 85FE 8424"
	$"8584 8282 7F7F 7E7E 807C 7B6F 6136 233E"
	$"5027 1C2C 2713 0402 1209 0506 0C12 0404"
	$"2C0D 0207 061A 050C 1253 2D19 2C17 1F07"
	$"030A 1B04 1318 0407 1013 060B 0904 0406"
	$"0401 9F4D 817E 87A0 8A89 8884 9260 1727"
	$"0B15 282B 3423 2B21 2A46 5240 2238 3C46"
	$"4342 463D 452B 2D44 4A4C 5A6F 6A5F 7A7B"
	$"7F7F 7E82 8283 8384 8582 7E7C 7D7B 7D7F"
	$"7E7D 7B79 797B 7D7A 7675 7475 7573 7270"
	$"6E6E FE6B 176A 6769 5F3C 3937 3444 3F26"
	$"1F1F 251C 070F 0F0E 1011 0F08 0CFE 1213"
	$"0D0C 151F 1618 1622 211E 1D0B 101F 1616"
	$"2016 081E 3436 1120 0F09 0D13 1116 D8D8"
	$"D9EE DBDC DDDE E47D 1523 070F 2023 2C15"
	$"2217 1932 3E2D 1227 2734 322E 322A 3118"
	$"152A 3037 4E63 6257 7A81 FE85 1E88 8687"
	$"8786 8888 8583 8483 8281 7F80 7E7D 7C7E"
	$"7F7C 7B7B 7A7B 7977 7576 7776 FE73 2572"
	$"7071 643D 2E29 2C3A 2E18 1414 1B11 0008"
	$"0705 070C 0B01 0307 0708 0303 0A0F 0C0C"
	$"0914 1211 1241 0206 160C 0C16 0B00 152D"
	$"0816 0703 0508 050B 2E20 2532 1C1C 1E1A"
	$"2129 0B1B 0309 1919 250E 170F 1631 3D2B"
	$"0E22 2430 312D 2A21 2A15 1325 2C30 435F"
	$"5A4D 6D74 7A7D 7C7F FE7B FF7E 0E77 757A"
	$"7A76 7879 7474 7775 7479 7A76 FE75 FF76"
	$"0474 7372 7171 FE6D 1C6C 6A6C 6039 2B29"
	$"2C39 2912 110F 130E 0008 0804 0508 0801"
	$"0204 0406 0202 1A09 0E08 0A08 1210 0F10"
	$"0005 140B 0914 0B00 1125 0711 0301 0307"
	$"0409 019F 4C82 7E89 9D8A 8988 8694 602A"
	$"0B0B 1827 2425 1B3D 3624 2F4B 4817 2533"
	$"2742 4643 4535 203A 3D41 434A 4848 544C"
	$"5959 5A5F 645A 6061 6F63 616F 6966 6762"
	$"656E 6462 6869 625E 615E 6261 6666 6062"
	$"615B FE5E 285C 595D 585D 4424 3A3C 3034"
	$"261D 1219 1C12 090D 0D0C 0907 0506 050F"
	$"120F 0D17 201C 0A0B 1315 160C 1A19 FE12"
	$"031B 1016 277F 381A 1C1D 1409 0E0C 19D8"
	$"D7DC EBDB DBDD DDE0 7824 0808 141F 1B1C"
	$"0C32 2B14 203B 390A 1521 142E 2F2C 3323"
	$"0F27 292C 323B 3532 4048 6163 6369 6E67"
	$"6E6F 7A6F 7385 7873 726C 727D 7576 7976"
	$"6E69 6D6A 6F6E 7271 6B6D 6E6A 6C6C 6A68"
	$"656B 6669 4C21 2F31 2A2A 1D15 090F 1209"
	$"0104 0304 0403 0102 0106 0805 040B 1113"
	$"0302 0807 0902 7711 1008 0909 1106 0C1B"
	$"2D10 1013 0F04 0502 0F2F 2027 2F1C 1C1D"
	$"1921 2820 0605 0C18 181A 0A2C 2410 1D38"
	$"3603 0E1A 102D 2F25 2C1E 0D24 2A2F 2E37"
	$"3630 3D43 5E64 676D 7167 6D6E 7C70 748C"
	$"877E 786D 7483 8081 8584 7570 7673 7474"
	$"7875 6F70 7270 7372 7371 6E72 6D71 5428"
	$"3331 2621 1410 060B 0F09 0105 0301 01FE"
	$"0004 0105 0604 021A 0A0F 0D01 0107 0605"
	$"000D 0E07 0806 0F07 0D1A 2305 080C 0B03"
	$"0401 0D01 9F7F 8482 909C 898B 888A 9248"
	$"1C19 112D 3E3B 1911 2E3B 1319 3827 1A31"
	$"312C 3836 2C42 3135 3333 3043 492A 3C38"
	$"3C39 3737 434C 4D49 4153 3B4A 8C7B 8462"
	$"3755 8177 8074 7258 367C 5360 6668 6961"
	$"6160 5F63 6565 5D5C 6761 5D67 491F 3D43"
	$"3B28 1610 0C19 140A 080C 0B08 0812 0E0E"
	$"100C 0E0E 1417 140A 0A0B 0F11 0E2A 2206"
	$"1021 1521 2711 0D1A 221F 1C2C 4D09 0A09"
	$"D8D7 DFE8 DAFE DD6E E05E 0F10 091F 2E2F"
	$"1206 222D 060C 291E 0C23 241C 2523 1729"
	$"1F23 2022 2234 3419 2F2F 3C43 4647 535C"
	$"625D 5668 566D B6A8 B07E 4E78 A99C AB9B"
	$"9271 59A1 6E7A 8082 827A 7979 7A7F 807E"
	$"7674 817A 747A 4E1B 322C 2417 0C0A 030D"
	$"0801 0305 0405 060A 0608 0B07 0909 0D0F"
	$"0D05 0405 0607 037F 1F1B 000A 190A 171D"
	$"0610 1814 1225 4500 0203 2F1F 2A2C 1B1E"
	$"1D1F 2A23 0E0B 061A 2729 0B02 202A 0409"
	$"261A 081D 221B 2221 1428 181C 1A1D 1D31"
	$"3A1A 282E 404B 5151 5E67 706C 6474 6382"
	$"D5CF D5A5 678A C9C7 D5C5 BD90 69B8 8C90"
	$"9799 958B 898D 9195 9692 8B89 9892 8B8E"
	$"5B20 2E2C 2011 0707 020B 0700 0002 0001"
	$"0209 0406 0803 0506 020E 0F0C FE02 1405"
	$"0601 1B18 0007 1508 141B 0409 0D0D 0C22"
	$"4300 0001 019F 7F85 8295 9B89 8A87 8D8D"
	$"3833 3423 203B 3C1B 0E24 3628 191B 3739"
	$"3F37 3339 2723 3338 5137 474C 4C3B 3738"
	$"433E 4A52 4A4D 5D57 544D 5554 5667 6C80"
	$"6A48 648A 8182 7E78 5F44 8054 666B 6A6D"
	$"6866 6765 6869 6964 636A 6857 5247 293F"
	$"3531 2421 130A 0F0C 0C0E 0D0A 090D 1719"
	$"1411 150E 0A15 1D14 080A 090A 0D10 110B"
	$"0E12 1414 130C 0C7F 0D1E 200A 1021 110B"
	$"07D7 D6E1 E6DA DDDC DDD4 4623 2719 112A"
	$"3012 0518 271C 0E0B 2526 2E28 2327 1611"
	$"1D25 3D22 333A 3C2C 2C31 403D 4959 5B5E"
	$"6F6B 6862 6867 697C 88A1 825C 82AB 9FA6"
	$"9F93 7562 A06C 7C82 807F 7978 7B7B 7E7E"
	$"7C77 7681 7A5D 4F41 2033 211C 1314 0803"
	$"0903 0306 0604 0508 0E0F 0A0B 0F0A 040D"
	$"140C 0205 0504 0505 7F05 0206 0A0C 0D0C"
	$"0503 0516 1702 0717 0602 022E 1E2D 2A1B"
	$"1D1B 1F2A 1D1E 1E14 0F25 290D 0216 241A"
	$"0D0B 2624 2827 2323 130D 161B 3820 2F34"
	$"3626 262A 3D3F 5465 6467 7875 726C 706E"
	$"7388 9AB5 9D70 93C7 C3C5 BEB4 8B69 AD81"
	$"8D93 9191 8B85 8B8D 9091 908B 8992 8868"
	$"5746 1F2C 1A14 0F12 0903 0702 0103 0301"
	$"0205 0C0D 0807 0B05 021A 0D14 0C00 0201"
	$"0305 0404 0104 0709 0A09 0301 0210 1501"
	$"0817 0500 0001 9D31 8581 9798 8A8A 878B"
	$"8A1A 1634 3B11 2922 272F 2126 242F 353E"
	$"3141 483D 3B34 2439 3A42 4142 3A4B 2D25"
	$"4337 3550 5252 5365 5454 FE58 0961 6D54"
	$"5558 5C5E 5E62 56FE 5B0C 5C5B 5D5B 6262"
	$"5F5F 6461 5A60 5EFE 5F2D 5457 564A 3E31"
	$"3934 2522 2211 0D0A 060B 100B 0713 170C"
	$"1312 0F12 0E10 1212 0E0A 0A09 090A 0E18"
	$"0E10 1616 0E2D 110B 4A07 1A28 1F07 0A10"
	$"0B09 D7D6 E2E2 DBDC DCDF CB27 0822 3109"
	$"1B15 1B24 1417 1623 2626 1B2E 372B 2921"
	$"132B 262E 2F30 2738 1F16 3429 2F57 6163"
	$"6477 6666 6A6A 696E 7863 686D 6E6F 6E73"
	$"686D 6D6B FE6C 086A 7070 7172 7771 676D"
	$"FE6C 256D 6363 5D4B 3624 2824 1510 1609"
	$"0404 0103 0703 0109 0D03 0908 0609 0507"
	$"0808 0404 0505 0301 0315 0C04 060C 0D06"
	$"2509 0402 131F 1600 0205 0203 2E1D 2F27"
	$"FE1C 391A 260E 0516 2607 1912 1721 1214"
	$"121E 2226 1927 332A 251E 1022 1C29 2C2A"
	$"1E2B 120E 2C23 2C57 666B 6B7F 6E6F 7174"
	$"7477 806A 6F74 7374 777D 7175 76FE 7529"
	$"7470 7777 7977 7A77 7176 7574 7576 6E6E"
	$"6954 3820 1F18 0B08 1009 0404 0001 0502"
	$"0008 0C02 0706 0406 0305 FF06 0003 FC01"
	$"1202 0903 040A 0C05 2409 0300 0E1A 1400"
	$"0203 0100 019F 7F85 8298 948A 8B88 8886"
	$"231B 2B3E 191E 4428 4F33 1425 232E 2734"
	$"3D47 371C 2241 393B 3742 4444 513A 3434"
	$"3D41 4A4D 4948 624A 4C4A 4C4F 576A 4754"
	$"5655 5551 5D52 5655 5455 5560 6168 6769"
	$"6A6A 5F5D 6366 5242 4B30 496B 5D4A 332C"
	$"3D24 141A 2018 3012 0C23 2822 222E 1009"
	$"0C11 0D0C 1715 1213 0D0A 0A09 091A 261B"
	$"0C1D 2C0D 1B12 0FFF 137D 1014 1218 0D0C"
	$"0DD8 D5E4 E1DC DCDB E1C8 2B0E 1D33 1012"
	$"3417 4127 0917 131E 1322 2E36 290E 1230"
	$"2D29 242E 2E2B 3826 2122 333B 434C 5659"
	$"7257 5B5C 5D5F 6578 5663 6667 6662 6D62"
	$"6A6B 6A69 6874 757C 7B7B 7C7C 7472 7976"
	$"5545 4D33 517A 6844 2618 2E17 030C 150B"
	$"220D 0417 1B16 1623 0803 0507 0605 0D0A"
	$"0708 0604 0403 0413 7F1E 1103 1321 0110"
	$"0709 0C0C 080B 0A0E 0403 052F 1D2E 231D"
	$"1D1C 192A 130B 1429 0D0F 3215 3C23 0714"
	$"0E17 0B1A 242F 230A 0D2A 2A25 212F 2F23"
	$"2C1B 191D 313C 4A53 5C61 7860 6363 676F"
	$"7582 5D6A 6D6E 6E6A 756B 7271 7273 717F"
	$"838A 888A 8A89 8080 8786 6751 543A 5B86"
	$"7950 220E 2611 0009 1205 1A09 0215 1913"
	$"1320 0803 0406 0403 0A03 0705 0503 FE01"
	$"1300 0F1A 0F02 1120 0210 0809 0C0B 0508"
	$"070E 0301 0201 9F45 8483 9991 8B8B 8A8C"
	$"7B28 2317 1E44 423D 2C33 1B33 311C 452D"
	$"1B2E 4C2B 3334 433D 2B32 4446 4743 2732"
	$"2F47 5438 403E 3A5A 393E 3B37 3C47 6033"
	$"3A40 4143 404F 3D43 4342 4341 6364 FE6A"
	$"3669 6B62 5E67 6661 471A 3925 4652 2D32"
	$"1D30 260F 131C 162F 2715 1727 2F26 2C0C"
	$"0909 0D0B 080E 1010 1812 0F0E 100B 1D31"
	$"3215 0D11 0D14 1118 4E16 0C13 120D 1A0F"
	$"090D D7D6 E6E0 DCDC DBE3 B929 180F 1334"
	$"362E 1B22 0C27 260D 331A 0C1F 3B1B 2221"
	$"2E31 1E20 2D2D 302E 1620 1B30 412E 3D47"
	$"4B6B 4349 4544 4C58 713C 4750 4E4E 4D5C"
	$"4951 5352 5350 7376 FE7C 2D7B 7D74 707A"
	$"796D 4B18 3928 4B53 2022 071C 1603 0409"
	$"0520 1E0B 0D18 1F1A 2206 0404 0506 0404"
	$"0505 0E0A 0605 0804 16FF 297D 1005 0702"
	$"0A08 0E0D 030B 0A05 1307 0105 2F1D 2D20"
	$"1D1D 1C1C 2C0F 120C 1131 2E28 161C 0825"
	$"2610 3317 081A 3615 1C19 2729 191B 2D2D"
	$"2C28 0F1A 182D 3F2A 3D4F 5574 5357 4F4C"
	$"5661 7345 515D 5D5C 5763 535F 6360 605D"
	$"8185 8A8A 8887 8982 8089 887E 561B 3B2C"
	$"515C 261B 0517 1201 0409 0116 1B0A 0B16"
	$"1C16 1E06 0404 0503 0103 1A03 020C 0704"
	$"0305 0012 2527 0D02 0501 0707 0E0E 030A"
	$"0803 0F05 0003 019F FF84 7D9A 918A 8B8A"
	$"9171 0D0B 0A17 532F 292C 1112 252E 1825"
	$"3C42 4650 3F4E 483E 361C 2144 3639 3D26"
	$"2D22 3F39 333A 3D3F 5C30 3B33 2B3D 475B"
	$"302E 3740 3E39 4834 3F43 413D 3A63 6469"
	$"6869 686A 6362 5D5B 5F55 3B1C 251F 341A"
	$"201D 1816 0D1A 170D 1825 130F 0E0F 161B"
	$"0C0E 0C0B 0E0B 0E0C 0C0D 0E0F 0F10 0B0B"
	$"0E1B 1E09 1621 0A10 0F6A 1115 2428 1021"
	$"0F08 0BD7 D7E7 E0DC DCDA E6A7 1006 030B"
	$"4022 1E22 0403 141F 0C18 2C2F 323C 2A38"
	$"352C 280D 102D 1E26 2C17 1C0D 2728 2D3B"
	$"4447 6B41 483D 3346 5469 3A39 454D 4946"
	$"5641 4B4E 4F4D 4A73 767B 7A7B 7A7D 736F"
	$"6562 6B5C 3B1B 221B 2F10 110B 0607 0511"
	$"0B03 0D1B 09FE 0508 0B10 0507 0403 0807"
	$"06FE 0400 06FE 0701 0203 7305 1119 010C"
	$"1803 0804 060B 1C21 0919 0800 032E 1F2F"
	$"201D 1D1B 212C 0301 0009 3D1B 171A 0201"
	$"111A 0711 262C 303A 2633 2D22 270D 1029"
	$"1820 2711 1509 2423 2638 4C54 744F 584B"
	$"4050 5E76 4644 4E58 554F 5E4C 585C 5D5B"
	$"5781 8489 8887 8688 827E 736D 7061 401C"
	$"221B 2C0A 0B09 0203 020F 0900 0919 08FE"
	$"0308 090F 0305 0301 0604 05FF 02FF 03FF"
	$"0414 0502 0103 1016 000A 1601 0603 0409"
	$"191E 0716 0600 0001 9B7F 8387 9B8F 8A8A"
	$"8897 6813 1311 1241 4920 110D 1410 101A"
	$"183A 5742 363F 3B49 3934 2B3A 5333 4255"
	$"4A42 1935 4C47 4838 4969 3B39 6663 2E64"
	$"7E73 7446 3667 7D7E 8783 6047 4454 6566"
	$"6D6D 6E6A 6A68 6341 3E4F 1E35 0C0F 0F11"
	$"0F13 1C12 1120 2642 201C 271F 0A08 0B0F"
	$"110E 1312 0D0F 1510 0A0A 0B09 0A0B 0A06"
	$"0706 0908 080F 1807 0E17 6A16 1412 1214"
	$"0E09 0B09 D7D9 E8DE DCDC DAE9 9314 110B"
	$"062E 3917 0905 0904 0610 0B29 4230 232A"
	$"2A38 2B27 1C27 3E1C 2A3B 3330 0B24 3B3A"
	$"4336 4973 4A4B 7E75 3D80 A19B 965F 5286"
	$"9A97 9F9B 7558 5563 7678 7F7F 7E7D 7D79"
	$"6D3E 354D 1D36 0A0B 080A 090A 1208 0715"
	$"1C39 1713 1B15 FE05 FE04 0509 0804 090F"
	$"07FE 04FF 0303 0403 0202 FF01 4B03 0008"
	$"1202 080B 0A07 080A 0B05 0104 022E 202F"
	$"1E1C 1C1A 262B 0A0A 0704 2D36 1303 0206"
	$"0204 0C07 253D 2B1D 2523 3022 2418 2339"
	$"1623 332C 2B08 1F35 333E 3A51 7851 5691"
	$"8C4B 88B3 B4AD 7662 94FE B32E A67C 615F"
	$"6E83 878D 8D8A 8989 847B 4B3B 4E21 3A0C"
	$"0704 0605 070B 0304 1019 3616 1218 1102"
	$"0103 0404 0206 0703 060B 06FE 04FF 01FD"
	$"02FF 0108 0200 0710 0005 0908 05FE 0803"
	$"0401 0201 019D 7481 8B9E 8C89 8988 9A65"
	$"0B15 1917 1D20 1414 120F 4E62 1B19 2136"
	$"413A 4540 5847 3C46 5056 393A 3C46 3E2A"
	$"3951 4E44 2854 713F 3DA2 9824 7CAB BBBB"
	$"683B A0CB 948B 7665 5250 5C66 676D 6F70"
	$"6A6D 6757 452F 5454 493E 100D 1016 2218"
	$"1012 2223 2A46 301C 261A 090B 0D09 060E"
	$"100E 0E0F 0D09 080B 0A0A 0908 FD07 0608"
	$"0607 0609 0F12 5018 2017 1E1E 0C07 0B16"
	$"D6DA EADD DDDC DBEC 8D09 1111 0C0E 110C"
	$"0A07 0344 5F19 1315 2231 262C 2A45 3528"
	$"2D32 3E25 2626 2E2B 1D28 393B 3920 4F76"
	$"454B BAA7 2F93 CCDF D87D 4BB2 E0A4 9B87"
	$"7663 626E 7879 7F80 FE7F 2B6D 553E 2853"
	$"5650 3C09 0508 1218 0A04 0819 181D 3923"
	$"111D 1404 0306 0301 0708 0606 0706 0302"
	$"0504 0503 0301 01FF 017D 0200 0201 0409"
	$"090E 160B 1414 0200 0510 2C20 301B 1D1C"
	$"1B2A 3004 0A0D 080C 1108 0404 0142 5C17"
	$"0E0D 1B28 1E26 253E 2F25 2A2D 381E 1F21"
	$"2E27 1623 3532 301E 5279 4A4F C5BA 3793"
	$"D3F1 E58A 56BA EDB4 A388 7868 6877 8487"
	$"8D8E 8C8A 8C79 5D44 2958 6058 420A 040A"
	$"0E12 0402 0410 131B 3721 0E19 0F00 0003"
	$"0100 0408 0503 0403 FF01 0504 0203 0102"
	$"02FD 010E 0002 0102 0607 0C15 0E11 0F03"
	$"0204 0D01 9F7F 828D 9E8A 8A88 8898 5A0A"
	$"2311 100E 2423 0D14 0FA7 FF74 7A89 8090"
	$"743F 553C 2E32 3532 3F46 334F 2D29 1E39"
	$"4D48 4342 5863 3E3C AE8E 2488 C3D7 CD6E"
	$"41C0 A259 4D4E 5D4F 4A4E 6565 6B6B 6869"
	$"7053 2E33 3443 643E 6316 152C 2223 1413"
	$"0D18 1613 2125 0C07 0C04 0600 174A 1F0B"
	$"0D0C 0D0C 0909 0809 0809 0A0A 0808 0907"
	$"0C0E 0710 2010 3313 3113 2518 0704 1549"
	$"D7DC EBDC DDDB DCEA 840C 1D07 0703 181E"
	$"0607 009F FF7A 7E8C 8490 6D30 402C 2223"
	$"231E 2B32 1F3D 1F19 0C26 36FE 313B 485C"
	$"4040 B596 2B8E C6D8 D074 47C4 A767 6464"
	$"7262 5D61 7677 7D7E 807D 8354 1E23 2238"
	$"6044 6615 1327 1817 060A 0610 0D09 171B"
	$"0C05 0B00 0200 1848 1B03 FE04 0505 0403"
	$"0202 03FE 0400 0274 0204 0206 0801 0B1B"
	$"070A 290A 1D10 0000 0F40 2D23 311A 1D1B"
	$"1A2D 3102 1804 0300 1519 0205 009D FF7A"
	$"7D89 7E8B 6B2E 3C27 1B1B 1C19 242A 1737"
	$"1C14 081E 2C23 252B 4357 3D3D B294 2785"
	$"C1D9 CF6F 44C7 AC69 696F 806D 686F 8585"
	$"8B8B 8A89 8F5E 1A1B 2138 6443 691A 1628"
	$"1512 0106 040C 0803 1215 0806 0AFE 0007"
	$"1748 1801 0301 0202 0402 0100 0101 FE02"
	$"FF01 1002 0105 0802 0817 0609 270B 190B"
	$"0000 0C3B 0194 1581 909F 8A8A 8989 9A47"
	$"3F2E 2919 1A38 2A0C 2233 A8FF F8FC FF53"
	$"BB45 1B1B 1C37 3122 3632 3F20 1420 2B45"
	$"4A4A 4945 3E40 37BF 8421 88AD C5C1 6347"
	$"A562 604F 5563 4C48 5E64 676D 6C6A 6C6A"
	$"541E 1E22 2F2B 2856 3724 1818 191F 282E"
	$"0B0C 0A08 1864 8076 7A7C 5C92 F858 010D"
	$"0B0D 0B07 FC08 0007 FE0A 0709 1617 0808"
	$"090D 0F1E 0918 100E 0909 0B10 2DD6 DFEB"
	$"DBDD DCDD E668 3A23 1C11 1129 2102 1221"
	$"A2FF F8FC FF2A BF42 140F 0E29 2411 211E"
	$"2D11 0714 1B2D 2F34 3631 313D 36C3 8E2A"
	$"8CAF C7C2 674E A868 746C 717F 645C 7377"
	$"79FE 7F12 7C81 6924 1B18 2523 2453 341F"
	$"1009 0D12 2028 05FE 0812 196C 8982 8888"
	$"6699 FA56 0005 0304 0301 0202 03FE 0201"
	$"0504 FF04 FF10 FF03 2104 0809 0314 0A08"
	$"0405 090A 222D 2631 191D 1C1A 3023 2D20"
	$"1A0D 0C24 1C01 1221 9EFF F7FC FF52 BC3C"
	$"110B 0925 240E 1A18 270F 040D 1325 262A"
	$"302B 2831 31BD 8725 85A2 BBB9 5E44 A972"
	$"7A71 7D86 6A65 7E85 878D 8D8A 888B 722E"
	$"1D11 1D20 1E50 3720 0D09 0A0C 1B25 0405"
	$"0304 1461 8D84 8588 679B FC52 0002 0102"
	$"02FF 0100 00FD 01FD 020F 0E0F 0303 0205"
	$"0601 1009 0500 0304 051C 0195 5F85 959A"
	$"898B 8A8B 9B30 1716 2216 0C0E 0F0E 1924"
	$"C3E0 70BC C0C7 C7CE F085 0318 1C3B 4434"
	$"2940 442B 1C1D 2A36 4F35 3D3B 4939 3557"
	$"4D2E 7685 89C0 5B3C 7373 6645 4A5A 4A47"
	$"5663 6469 6A69 6765 635B 3328 2C28 2137"
	$"3E34 3023 2B21 212E 0F13 0C06 A1FB FF04"
	$"E0F7 5F00 0FFE 0E02 0A08 09FD 070A 090A"
	$"0B09 0F0C 0A06 0307 0B68 0607 0506 070A"
	$"0A08 07D3 E2E8 DBDC DCDD DF45 0F08 150F"
	$"0806 0806 0B0F BCE0 5FA7 B5BA B9BF EC84"
	$"000C 0B27 2E1F 162F 351D 0E0F 1A22 381F"
	$"2A2F 4337 365B 5637 7E91 94C3 5D3F 7D86"
	$"7D60 6676 605A 6976 777C 7D7C 7B79 7668"
	$"3725 251F 1726 2C25 2217 2017 1524 080B"
	$"070A ADFC FF11 FEDE F660 0008 0606 0704"
	$"0203 0203 0302 0204 7105 0208 0504 0502"
	$"0205 0102 0103 0405 0402 012E 282E 1B1D"
	$"1C1C 3913 0D04 120B 0302 0201 090E B5D6"
	$"59A1 A9B3 B3BA E07C 0005 0621 291C 122A"
	$"3018 090A 141D 331B 262B 3F32 3257 5235"
	$"7B8C 8CBD 573F 848E 856D 7383 6964 7684"
	$"858A 8B88 8685 8476 3C24 241B 101F 271F"
	$"1E18 1F12 1220 0408 0508 ABFC FF08 FDDD"
	$"F458 0005 0303 0400 03FE 01FD 0212 0405"
	$"0106 0402 0100 0103 0001 0002 0304 0301"
	$"0101 9F73 8497 9789 8B8B 8A95 220F 1412"
	$"0E11 0C0D 0F0E 1AD5 C529 371F 2E37 363A"
	$"5327 1A1E 1C20 2E43 4734 1D3A 2E37 4743"
	$"2E48 424F 4B4A 4642 4B54 4F3F 5E4D 4C59"
	$"6F69 4C51 6150 4E4E 6462 6667 6463 6267"
	$"531A 4238 2B28 211F 2232 151E 2816 130E"
	$"0F08 1FB6 BDB8 BAB6 A45C 84FF 6300 0E0D"
	$"0C0B 0907 0607 0807 FE06 0807 080A 0909"
	$"0402 070E 7F09 0805 0508 0706 0805 D2E5"
	$"E6DB DCDC DDDC 360B 0A06 060B 0506 0804"
	$"08CD C41D 230F 1B24 2328 431A 1213 0F10"
	$"1B2F 3422 0D2A 1D20 3233 1D34 364A 4D50"
	$"5250 535B 5A48 6154 505D 7978 6166 7564"
	$"6261 7674 7879 7877 7779 5D1B 3B2F 201B"
	$"1211 1829 0C14 1E0B 0907 0902 1BB3 B4AF"
	$"B2A9 934F 7EFF 5E00 0705 0404 0504 0203"
	$"0403 0202 030C 0302 0504 0403 0202 0802"
	$"0201 01FE 036F 0501 2A27 281B 1D1D 1B3D"
	$"0E05 0604 0308 0102 0200 07CB BE17 1D08"
	$"1018 1820 3F18 0A0D 090B 172B 311F 0824"
	$"171B 2B2C 182F 3144 484D 524F 5059 5643"
	$"5E4F 4E61 7D7C 6D73 826D 6A6C 837F 8485"
	$"8281 8082 651F 3C2E 1D15 0E0D 1224 0B13"
	$"1C0A 0704 0801 15A7 ACA7 AAA0 8943 75FF"
	$"5700 0402 0101 0A02 0101 0203 0201 0102"
	$"0200 FE02 0C01 0000 0601 0100 0002 0201"
	$"0200 019C 7484 9994 8B8B 8A8C 892A 210A"
	$"0E12 170D 0E0F 0D1A E4A1 0510 322E 2312"
	$"1322 2121 3344 3F2F 5143 4F3E 3D49 3A36"
	$"3E39 3D49 4932 39A0 662F 7785 7988 4341"
	$"6C65 5D47 4F58 564F 3A5C 5F5F 6161 6065"
	$"5E55 4C2E 1F1F 1814 0D0A 0915 1516 0C0C"
	$"090A 0C10 1213 1515 1407 0054 FF6F 000F"
	$"100E 0E09 0502 0406 0504 FE03 0705 0604"
	$"080C 0706 0C5B 0B07 0505 0607 0503 03D2"
	$"E6E4 DDDC DBDF CB33 1702 0509 0E06 0709"
	$"080E DDA0 030A 2724 1909 0612 1516 2736"
	$"2F1D 3C2B 372B 2B36 2623 2B26 2A3C 443A"
	$"41A8 7038 7E90 818D 4F4E 736D 6C56 5E66"
	$"645C 476B 6F6E 706F 6D71 6E64 522D 1C1A"
	$"0F09 FE04 FE0F FE04 0406 0709 0A0A FE0C"
	$"1202 0056 FF64 0009 0806 0808 0501 0102"
	$"0101 0203 FF03 7D04 0205 0A07 0105 0602"
	$"0101 0204 0403 0229 2825 1B1E 1C1C 3718"
	$"0A01 0205 0900 0202 000B DFA1 0001 1E1F"
	$"1605 030D 0F10 2432 2D1A 3929 3424 232E"
	$"1F1A 211D 2235 3C38 3DA1 6A35 7B8C 7F8C"
	$"4B4A 7673 6F5D 656D 6A64 5176 7978 7A78"
	$"767A 786F 5C32 1614 0B07 0201 030A 0C0F"
	$"0404 0206 0504 0303 0405 0500 0052 FF60"
	$"0006 0503 0504 0401 0000 01FE 00FF 010D"
	$"0002 0102 0704 0004 0401 0000 0103 FE00"
	$"019B 6E87 9E95 8B8A 8891 7E11 1614 0B0C"
	$"0E0F 0F10 0E18 EFAD 0E12 2D31 1E19 171F"
	$"1C19 2236 4A2D 2935 472F 2E35 1C2A 2432"
	$"1B43 4A23 36A0 5326 82B6 B8B0 4F43 B0B0"
	$"9662 63A1 5940 3B5B 6163 6665 6265 5B64"
	$"6D3C 3822 130E 0D0C 0E10 0D0F 0C0D 0909"
	$"0708 0908 0705 0B0C 0046 FF7E 000C 0B09"
	$"0B06 FC04 0B06 0504 0406 0305 0707 0507"
	$"0915 0B06 0705 0A10 0705 05D4 EAE1 DDDC"
	$"DAE3 B61B 130F 0505 FE07 4A08 050E EAA9"
	$"060A 2324 120C 0A12 0F0C 1224 361B 171F"
	$"321F 1E26 0E1C 1424 1540 4C2D 3BA7 5C29"
	$"82B5 B5B0 554C B6B7 A172 73B1 6F57 526F"
	$"7376 7978 7578 6E75 7A46 3C1E 0A06 0505"
	$"0709 0808 0709 FD03 1105 0605 0307 0700"
	$"46FF 6F00 0806 0406 0401 01FE 0202 0402"
	$"011F 0103 0003 0304 0302 0406 0202 0105"
	$"0C06 0505 2B2B 221B 1E1B 202F 0A0A 0C02"
	$"0103 FE04 4001 0DED AB04 0419 2010 0805"
	$"0906 050E 2032 1612 1A2C 1816 1D07 130D"
	$"1D0E 3C4A 2E39 9D54 2A80 ACA9 A54A 44AF"
	$"AB9B 7778 B470 5F62 7E80 8386 837F 827C"
	$"8788 4E3C 1B08 FE03 1805 0706 0806 0804"
	$"0302 0204 0202 0004 0500 46FF 6C00 0603"
	$"0105 0002 FD00 1501 0301 0000 0100 0102"
	$"0302 0203 0501 0100 0409 0303 0201 9871"
	$"879D 918B 8988 956B 000B 1308 090C 0C0E"
	$"100A 28FF A60F 1721 1515 1413 1D21 1A25"
	$"2027 4640 4C4B 2F24 1816 1826 2C4A 6760"
	$"4A5C B665 3E88 B3B4 9F4E 52AB AE9A 787E"
	$"AD57 4C6A 655F 6365 6462 645C 665E 3A47"
	$"1D10 0C0B 0C0C 0602 0C0D 0807 0807 0807"
	$"0607 090D 0E00 39FF 8900 0606 0304 0504"
	$"0503 FB04 0706 0906 0504 0405 0663 0905"
	$"0402 050B 0905 08D4 E9DE DDDB DAE7 9E0A"
	$"0B10 0305 0604 0608 0020 FCA4 0610 1B0A"
	$"0A09 0811 150E 1711 1632 2A34 331F 1911"
	$"0D0E 1C24 496E 6E53 5FBD 7148 8FB7 B8A7"
	$"5B5A AEB3 A07F 86B5 6960 7E77 7175 7675"
	$"7273 6C75 6A44 4A16 0605 0506 0504 0208"
	$"0502 FE03 FF04 1606 0708 0A09 003B FF7A"
	$"0004 0302 0200 0101 0203 0302 0102 7F01"
	$"0205 0201 0000 0104 0702 0302 040A 0804"
	$"072C 2B1F 1B1E 1C24 2400 060C 0001 0302"
	$"0405 001E FAA2 0408 1005 0606 0208 0D06"
	$"100C 112B 242D 2D18 1208 0505 131D 446A"
	$"6C55 5FB7 6D4C 90B0 A99A 4E52 A6A7 9777"
	$"7DAC 6467 8A83 7E82 837E 7B7C 7883 754C"
	$"4F16 0604 0304 0502 0008 0401 0102 0203"
	$"0302 0304 0707 0039 FF79 0002 0100 00FD"
	$"00FF 01FD 0010 0105 0101 0000 0103 0601"
	$"0100 0207 0602 0601 9C6D 879A 8C88 8A88"
	$"9760 0012 100B 0A0F 0C0C 0F04 3DFF 9513"
	$"2114 1013 0C16 2313 131C 1A29 3B35 5452"
	$"2F32 752A 5659 3E74 A8A4 9D9F 9D9A A1A5"
	$"A5A2 9D94 8C91 9089 8183 8F7F 7A7E 7874"
	$"7371 7070 6E69 6862 524C 200B 0B08 0706"
	$"0506 0905 120A 0607 0606 0405 0809 0600"
	$"30FF 8D00 040E 1404 FE06 0904 0607 0406"
	$"0302 0406 05FE 0401 0302 7607 0509 0A03"
	$"0C08 020B D8EA DDDC DBDB E88E 080F 0C05"
	$"0409 0404 0700 38FF 930B 1A0C 080A 030D"
	$"190A 0A12 0D1A 2820 3C39 1E2B 792D 575A"
	$"3B6D A6A7 A6A4 A4A1 A5A8 AAA8 A399 9399"
	$"9790 8689 9488 8588 8480 7F7E 7B7B 7976"
	$"776D 594A 1905 0904 0302 0608 0705 1309"
	$"0303 0202 0304 0708 0600 34FF 7F00 060E"
	$"1503 FE02 0503 0606 0407 0403 0201 0201"
	$"FE00 7801 0207 0508 0902 0B07 010A 2E2B"
	$"1D1A 1E1C 2727 0008 0A03 0105 0201 0400"
	$"35FF 8C06 1406 0206 0008 1204 030A 0814"
	$"231A 3634 1825 7429 5356 3665 9E9E 9693"
	$"9390 989D 9A9C 9A93 8992 948B 8385 9080"
	$"8287 807C 7B7A 7E7D 7B79 7B71 5E50 1903"
	$"0601 0001 0308 0C0B 1508 0102 0101 0001"
	$"0303 0200 31FF 8400 020B 1001 0002 FE01"
	$"FF04 0502 0401 0000 02FB 0008 0503 0506"
	$"0008 0500 0901 9C3F 8997 8989 8A89 9554"
	$"0314 0D12 080C 121A 1109 53FF 860E 1717"
	$"1C17 251E 1522 242C 3D44 1C1C 353A 2E42"
	$"E7D6 F6ED D898 96AA AAA4 A19E B6BA B3B4"
	$"B3B1 9E92 8F91 8D88 FD84 3583 807E 7C7A"
	$"7A76 7474 756D 631B 050A 0502 0B49 4D48"
	$"344F 1203 0807 0505 060A 0D05 002D FD8B"
	$"0014 1B19 0906 0705 0607 0908 0402 0209"
	$"08FD 0301 0201 4904 0805 0A05 0B08 0306"
	$"DAE8 DBDD DCDC E77F 0A10 0A10 0708 0E16"
	$"0E06 4EFF 8808 1315 1A12 211B 0E1B 1B24"
	$"3336 0B0B 2429 203E E7D9 F9F5 DB96 93A8"
	$"AAA2 9FA0 BABE B8B8 B6B3 A195 9094 938E"
	$"8BFE 8A06 8985 8482 7F7F 7BFE 7A28 7062"
	$"1600 0804 030F 5359 523A 5313 0003 0302"
	$"0406 0A0C 0500 2FFC 8100 131A 1807 0305"
	$"0303 0506 0705 0204 0307 0601 01FE 0066"
	$"0204 0804 0703 0805 0205 2D26 1B1A 1D1D"
	$"2727 0108 040A 0305 0C14 0A03 4EFF 8000"
	$"0E10 160C 1B14 0815 141D 2D2F 0706 1D20"
	$"1836 E5D7 F9F5 DA8E 8493 9892 918C A4AA"
	$"A2A5 A5A3 938C 8A8B 8A85 8180 8382 8383"
	$"827F 7D7C 7979 7C7D 7666 1600 0501 0010"
	$"6069 6547 5A14 00FE 010D 0405 090A 0200"
	$"2EFE 8700 0F16 1404 0C01 0302 0203 0505"
	$"0300 0106 0500 FD01 0900 0205 0205 0207"
	$"0300 0401 9E74 8C95 8A8A 898A 9149 0113"
	$"140E 090A 1619 112A 70FF 7919 0E4B 8347"
	$"C3A7 1B55 342D 401C 191C 3435 3A4D D961"
	$"8EA7 BD61 7272 6F6B 6E6D 7779 7679 7978"
	$"7472 7476 6F6D 7072 706D 6B67 6363 605D"
	$"5E60 5857 5841 1012 160A 0115 4238 321B"
	$"5016 0206 040A 0A06 0907 0A09 2EFA 8D07"
	$"2214 0A09 0406 0708 0708 05FE 03FF 0C02"
	$"0103 03FE 023F 0209 0608 130F 0903 16DA"
	$"E7DB DDDC DCE3 6C02 0C10 0F0A 0616 1B14"
	$"2767 FF7E 1A0C 4784 40C1 A917 4E2B 2437"
	$"1413 1529 2729 41D4 5280 97AB 566E 736B"
	$"686B 6873 7571 FE73 3C70 6F71 746E 6C6F"
	$"7573 716D 6764 6463 6161 625A 585A 4614"
	$"1415 0A05 173E 342F 1A4E 1502 0403 0808"
	$"0508 060A 082D F986 001F 1106 0603 0506"
	$"0504 0403 0202 4802 0C0C 0102 0100 0001"
	$"0108 0508 130E 0503 162C 241A 1A1B 1D24"
	$"1F00 0306 0704 0312 160E 256E FF7A 1107"
	$"407F 3BB7 9F11 4725 1C2E 090B 0E20 1D20"
	$"39CC 4B73 8AA1 4F63 655F 5B5E 5C65 6764"
	$"FE6A 3367 6566 6C69 676B 6F6C 6A68 6360"
	$"5F5D 5B5C 5D56 5557 4411 0F12 0902 1642"
	$"3832 1C55 1A00 0001 0506 0306 0407 082E"
	$"F98A 001A 0E03 0306 0103 0404 0204 02FE"
	$"00FF 0C0E 0102 0201 0100 0006 0306 120B"
	$"0302 1701 9672 8F94 898B 8989 9040 0B11"
	$"1309 0707 160B 081B 79FF 621C 147E 9479"
	$"F6F0 402C 2D20 5271 404E 3E34 2F58 C016"
	$"1930 3430 743A 3361 4A55 413A 3D3F 3F40"
	$"413E 4C52 4546 5562 5A51 4B41 464B 493D"
	$"4259 3939 3831 242E 2516 0804 1004 0602"
	$"4F19 0409 0F19 1D16 070D 0D0A 2AF1 9D1E"
	$"2F2A 0509 0809 0A0B 05FC 03FE 0204 0304"
	$"0302 0233 0206 0B09 1712 0805 0EDD E5DB"
	$"DDDC DCE1 5D0A 0B11 0A08 0214 0E10 1E75"
	$"FF66 1F0D 718E 6DEE F03F 2726 164B 6E3B"
	$"452F 2320 48BB 1218 FE29 0775 403E 6C57"
	$"6049 42FE 4539 4647 4553 5B4E 505F 6D65"
	$"5C55 4A50 544F 4348 5E3D 3D3E 372B 362B"
	$"1A0B 050F 0204 024E 1804 0B11 1B1C 1506"
	$"0D0E 0B2C F399 1B2F 2905 0909 0A0A 0B04"
	$"FD02 FB02 7901 0001 0105 0A08 1611 0503"
	$"0F2F 221B 1A1B 1C24 1B06 0408 0303 000F"
	$"0606 1777 FF64 1808 6A88 65E1 E437 1F1F"
	$"1143 6232 4028 1B19 44B6 1214 241F 1D6F"
	$"3F3F 6E58 5D42 3C3E 4343 4445 4452 584A"
	$"4C5B 6F6A 6159 4D52 564B 3F44 5D3E 3A37"
	$"3024 3028 190B 050F 0204 0153 2105 080F"
	$"1817 1002 0A0C 0829 F099 1629 2501 0509"
	$"0708 0809 0301 0100 0001 FE02 FF03 0B02"
	$"0100 0004 0806 140F 0302 0F01 977B 9192"
	$"898A 898A 8E38 140E 1308 050F 110B 3154"
	$"9AFF 5116 277D 489E CFE6 2D23 2C3B C796"
	$"9087 3E69 4651 CE4A 463A 352D 8139 2BCF"
	$"DEFC AB18 2D2E 292C 2A22 3E4D 2C2D 3641"
	$"3B38 342A 3A42 301F 2C4E 1F1C 1B20 1D2B"
	$"3228 2124 230C 260E 4B20 1C1A 1F14 2428"
	$"1725 1410 3DE6 B513 1B40 180C 0C0E 080F"
	$"0905 0304 0304 0202 0101 FD02 7F02 030A"
	$"0605 1108 0506 E0E4 DBDD DCDD DE54 1810"
	$"130A 080D 1012 4367 A0FF 5013 1F73 3D8C"
	$"C3E5 3024 2B37 C38E 8B84 3A69 4647 C84C"
	$"5147 3C2C 843E 2FD0 DDFC B123 3736 3236"
	$"342C 4554 3334 3D4A 4542 3C32 444A 3A29"
	$"3556 2726 2525 2334 3C30 2427 2812 2B0F"
	$"4B20 2022 271A 282D 1B27 1412 40E8 B312"
	$"1D42 1A0E 0E10 0A0F 0905 0303 0203 0302"
	$"0201 FD00 FF01 1402 0804 040E 0403 0531"
	$"211A 1A1B 1C24 1E14 060B 0202 FE09 5D33"
	$"5497 FF4D 0F19 6936 7EB2 DB28 1A24 33BD"
	$"8783 7D31 5C3D 45C6 4646 3E36 2A7E 382E"
	$"CFDD F9AB 1E35 3330 3433 2B44 512F 3039"
	$"4D4B 483F 3143 4A39 2734 5625 1F1B 1D1D"
	$"2E3B 3226 2828 122B 104F 2521 2227 1929"
	$"2D1B 2915 0E3A E4AF 0C17 3C15 0905 0B0D"
	$"060D 0703 FD01 FF02 FC01 FE00 0607 0303"
	$"0D03 0105 0197 7B94 9388 8A8A 8790 2E0A"
	$"080A 0D09 1A09 1D31 46AD FC33 1933 9853"
	$"A4B2 883C 2B50 3567 45AF 5B33 6938 90D9"
	$"6266 6055 4892 5252 985B 7B6E 4D44 839F"
	$"9388 7E9F 5B42 6F76 6966 605E 5E5A 5C57"
	$"382D 604E 4A46 4939 2445 4145 281E 3438"
	$"0F46 2722 232D 1A0C 3225 2C28 1B2D DFC2"
	$"0301 342A 100A 0B06 0A09 0405 0404 0302"
	$"0201 01FE 0200 01FF 017D 060B 0419 2A05"
	$"09E1 E5DC DCDD DDDE 480F 090A 0F0D 1E0F"
	$"2D4C 57AB FF33 172E 9347 92A6 8A48 395C"
	$"3C6D 3CAB 552A 6231 8AD3 555F 6056 4B99"
	$"5755 944D 696B 5648 89AB 9D90 86A3 5F4B"
	$"777E 706D 6764 6665 6261 4236 6857 5652"
	$"5141 2C4D 4648 2B25 3F3E 1049 2D2B 2D35"
	$"1E10 3B2B 2D27 1C2D DEC2 0303 362A 0F0A"
	$"0B06 0A09 0405 0303 FE02 0001 FD00 FE01"
	$"7403 0700 1526 0205 3220 191C 1B16 2B1B"
	$"0A03 0809 0717 0620 3A4A A4F7 2C0D 278E"
	$"427F 8F7D 3E2D 5030 6032 9E4E 2458 2987"
	$"D357 5956 4F44 9150 518D 4C61 614E 4686"
	$"A598 8D82 9F5C 4A76 7D71 6F68 6568 6664"
	$"6243 386A 5957 5453 452B 4E4E 4D2B 2740"
	$"4213 4B2D 2D2E 351D 1039 2A2F 2719 2ADC"
	$"BA00 0133 260C 0B08 0904 0806 0203 0201"
	$"0002 02F9 0106 0407 0013 2300 0301 9475"
	$"9891 878B 8C8B 8C31 0C05 0A1F 070B 170F"
	$"3743 BAF3 2729 4758 6865 473C 5634 7261"
	$"526D B565 2729 0FBF BB00 0508 1016 8234"
	$"498F 0809 0D4C 0F9B 9F4C 5A49 C647 4AA0"
	$"6162 577C 7C4E 5759 7947 1874 4F41 3B48"
	$"5C0B 4931 4233 3734 2F25 482D 2B25 1C0C"
	$"0B1F 190D 2135 28D7 CC0D 0131 220A 110E"
	$"0508 0604 0905 FE03 FF01 FD02 0001 FF01"
	$"0802 0B07 081E 090A E5E3 FEDC 71DE D54A"
	$"1105 091F 0A0F 1E1D 4D4C B3F5 292A 4556"
	$"5F5A 3E42 6845 8074 6369 B363 2528 08BB"
	$"BC01 0B12 161B 8A39 4A91 0A0C 1250 0E99"
	$"9D43 5145 C648 4A9F 6164 5A80 7C4F 5A58"
	$"784A 1F78 4D40 3A4A 5D0C 4F35 4435 4042"
	$"382A 4E36 332B 210E 0C27 1E0F 2337 2AD5"
	$"CB0C 0233 2209 110E 0507 0503 0804 0201"
	$"0203 FE01 FE00 FD01 7309 0607 1D08 0936"
	$"1E18 1C1B 1A2D 1D07 0005 1A05 0814 113D"
	$"43B4 F31F 1C3D 5259 4D31 365B 3875 6956"
	$"5EA1 5619 1A02 B6B8 0000 020A 1180 3243"
	$"8808 060C 4A0B 9695 3843 38BE 454A 9F61"
	$"6358 7E7B 4D58 587A 4B1E 7A52 4139 4961"
	$"0E4E 3946 3343 433B 2E51 3835 291D 0909"
	$"2018 0D22 3327 D4C3 0701 301E 070A 0F0C"
	$"0305 0301 0602 0100 03F8 0106 0309 0304"
	$"1C06 0801 9473 998E 888D 8E8C 8921 1006"
	$"0A24 1015 1A0A 2526 D0E9 2144 4B39 9B3A"
	$"3B34 8252 846C 1CC3 F0AB 2F32 15C1 A500"
	$"0916 100F 8F26 4C87 0411 1153 109B 7603"
	$"1811 BF3C 4B90 242C 0F69 661B 3726 5948"
	$"136F 210B 001F 5D04 4734 4233 3A36 3D40"
	$"4231 3332 2A09 0223 1B0C 2D3C 36CC D214"
	$"0227 290F 0E0E 0B08 0603 FE04 0403 0202"
	$"0101 FE02 0001 FE01 7203 0A04 0104 02E6"
	$"E0DD DDDC DDCD 3916 050D 2B19 1F21 1535"
	$"2AC8 EC23 4145 3294 3637 3892 608A 7225"
	$"C0EC A72C 320D BFA9 000D 1913 179A 304E"
	$"8B08 1A17 5511 9878 0417 12C0 3F4F 9528"
	$"3012 6C6B 2B4A 3361 4E18 7326 0D01 2260"
	$"0852 3F4A 3B46 4648 464A 3B3E 3B32 0E02"
	$"261D 0D32 4139 CBD2 1304 2929 FE0E 030B"
	$"0705 02FE 03FE 0200 01FD 00FD 0173 040B"
	$"0601 0503 371B 191C 1C1E 2E0F 0502 0723"
	$"1115 170A 2722 CEEB 1C3A 3E2A 8B2E 2F2D"
	$"8654 826C 18AD DB9D 2122 02B6 A200 020C"
	$"0809 8D24 457F 0511 1151 0F92 7200 0E0A"
	$"BB3C 4C91 252E 116B 6925 432E 5D4B 1573"
	$"2509 001E 6108 5345 4E3A 4746 4A4B 4F3F"
	$"413C 320D 0427 1E0E 303C 36C9 CA0E 0227"
	$"240B FF0C 0909 0503 0101 0201 0002 02F9"
	$"0106 0203 0702 0105 0300 00FF"
};

resource 'PICT' (6002) {
	35680,
	{0, 0, 95, 127},
	$"0011 02FF 0C00 FFFE 0000 0048 0000 0048"
	$"0000 0000 0000 005F 007F 0000 0000 00A1"
	$"01F2 0016 3842 494D 0000 0000 0000 005F"
	$"007F 4772 8970 68AF 626A 0001 000A 0000"
	$"0000 005F 007F 009A 0000 00FF 81FC 0000"
	$"0000 005F 007F 0000 0004 0000 0000 0048"
	$"0000 0048 0000 0010 0020 0003 0008 0000"
	$"0000 0000 0000 0000 0000 0000 0000 005F"
	$"007F 0000 0000 005F 007F 0040 0174 1E8B"
	$"8A89 8A8B 8D8F 908E 8F8E 8A8A 898A 8882"
	$"7C7E 7D7B 797D 7D7F 8081 8284 8381 FE80"
	$"FF7D 017C 79FE 7822 7A79 7877 7673 7273"
	$"7374 7472 7472 7373 7473 7272 706D 6D6E"
	$"7071 7370 716F 6D6C 6F6F 6DFD 6CFF 6F2D"
	$"6E6C 6D6B 6968 6869 7175 7472 7475 7779"
	$"766D 6B6D 6B6A 6C6B 6A6A 6D6F 6F6E 6B68"
	$"6867 676A 655F 5D5A 5959 5A5A 5BA1 1DA1"
	$"9FA1 A1A3 A5A5 A4A4 A3A1 A09F A09C 9995"
	$"9594 9493 9798 9A9A 9B9C 9C9B 9AFE 9903"
	$"9796 9693 FE92 0594 9393 9291 90FE 8F0B"
	$"8E8F 8F8E 8C8D 8E8E 8C8B 8989 FE8A FE8C"
	$"118A 8B89 8787 8A88 8886 8587 8688 8786"
	$"8586 84FE 830A 848A 8D8C 8B8C 8D8E 8E8B"
	$"86FC 8517 8281 8283 8485 8583 807F 807F"
	$"807D 7875 7372 7271 7274 DCD6 13D7 D6D7"
	$"D8DA DBD9 DCDB D6D7 D8D8 D5D2 D0D1 D0D0"
	$"CEFE D104 D3D4 D5D5 D3FD D202 D1CF CFFE"
	$"CCFF CDFE CC02 C9C8 CAFB C905 C5C6 C7C7"
	$"C5C4 FBC3 2AC4 C5C3 C3C1 C0BF C2C2 C0BF"
	$"C0C1 C0C1 BFBF BEC0 BEBC BABB BCC2 C3C0"
	$"BFC0 C1C0 C1C1 BCBA BAB9 B8BA B9B8 B9BB"
	$"FEBA 08B6 B5B7 B5B6 B8B4 AFAD FEAB FFAA"
	$"00AC 0179 1D88 8A88 8684 8286 898C 8F90"
	$"8F8D 8D8E 8D89 8481 807C 7977 7678 7A7C"
	$"7D80 82FE 811A 7E7D 7F7E 7D7C 7A78 7777"
	$"7877 7676 7575 7472 7173 7271 7273 7372"
	$"72FE 703B 6E6F 6E6D 706F 7070 6D6C 6D6E"
	$"6F70 6F6E 6B6C 6C6D 6D6C 6968 6A6A 6C6F"
	$"7072 7171 7677 7677 7471 706D 6D71 7170"
	$"6F70 7274 7370 6E6C 6969 6C6B 645D 5C5B"
	$"FE59 015A 9E07 9F9D 9D9C 9C9D A0A4 FEA5"
	$"23A3 A2A3 A3A1 9F9A 9894 9392 9392 9496"
	$"9798 9A9B 9A9A 9898 9796 9595 9492 9090"
	$"9190 8F8F 8EFE 8F1D 8D8C 8B8B 8C8D 8D8C"
	$"8B8A 8A8B 8988 8988 8988 8A8A 8988 8688"
	$"8889 8A88 8686 FE85 0786 8483 8384 8688"
	$"8BFE 8A0A 8D8F 8D8D 8B87 8586 8787 88FE"
	$"87FE 8810 8583 8280 8082 817C 7675 7472"
	$"7172 75DA D612 D6D5 D3D4 D6D7 D9DC DDDA"
	$"D9DA DBDB D9D6 D2D2 D0FC CE01 CFD1 FDD2"
	$"04D3 D0CF D0CF FECE 0ACC CACA CBCC CBC9"
	$"C7C7 C8C9 FEC7 05C5 C8C8 C6C5 C4FD C306"
	$"C4C3 C1C3 C2C3 C2FC C00F C2C1 BFBE BEBD"
	$"BDBF BEBB BBBC BDBD BFC2 FEC0 FFC2 FFC0"
	$"06BD BBBB BCBC BDBC FEBB 11BD BCBA BAB8"
	$"B7B7 B6B7 B6B2 AEAD ACAB ACAB AB01 7618"
	$"8C8A 8A89 8684 8385 888B 8F91 8F8F 9091"
	$"9290 8D89 827C 7874 74FE 7708 797B 7A7D"
	$"7D7C 7B7B 7CFE 7A01 7977 FB76 FE74 0F73"
	$"7474 7371 7071 716E 6D6D 6E6F 6F6E 6EFE"
	$"6F02 7270 70FE 6E08 6F70 706E 6D6D 6F6E"
	$"6CFE 6927 6B6A 6C6D 7277 7776 7171 7674"
	$"7372 7173 7475 7276 7879 7878 7774 716F"
	$"6C6F 726D 6560 5F5C 5B5A 59A1 23A0 9F9F"
	$"9D9D 9B9B 9EA0 A4A6 A4A4 A5A6 A8A8 A4A1"
	$"9B95 9290 9091 9291 9294 9496 9796 9594"
	$"95FE 930D 9190 8F90 8F8F 8E8F 8E8E 8D8D"
	$"8E8D FD8C 048B 8987 8788 FE89 FF88 0489"
	$"8A8B 8A89 FD87 FE88 1487 8688 8685 8383"
	$"8284 8385 868A 8D8C 8B8A 8B8D 8B8A FE88"
	$"0389 8A89 8AFD 8C10 8B88 8684 8184 8682"
	$"7C79 7875 7473 74DC D717 D7D6 D5D5 D4D4"
	$"D6D7 DCDD DBDB DADD DDDC D9D7 D3CF CDCB"
	$"CDCD FECC 0FCD CED0 D0CF CECD CDCE CECD"
	$"CBCB CACA C9FE CA11 C8C7 C7C6 C6C8 C7C6"
	$"C6C5 C4C3 C1C2 C1C3 C3C2 FEC1 03C2 C4C3"
	$"C2FD C0FF C100 C0FE BFFF BEFF BC14 BBBD"
	$"BCBD BDC0 C1C1 BFBD BFC1 BFBE BCBB BCBD"
	$"BDBB BDFD BF0E BEBB B9B8 B5B8 BAB6 B2B0"
	$"B0AE ACAB AB01 72FF 8E15 8C8A 898A 8B87"
	$"8687 8A8C 8E92 9091 9496 918C 837E 7B76"
	$"F975 0E78 7A7A 7978 7778 7776 7573 7475"
	$"7372 FE73 0672 7171 7273 7270 FE6F 006D"
	$"FE6C FF6D 3D6E 6D6D 6E6F 6F73 706D 6F6F"
	$"706F 6E6F 7172 7170 706E 6D6D 6C6B 6E72"
	$"7675 7573 7070 6E6F 6F71 7274 7776 787A"
	$"797A 7B79 7674 7375 7672 706D 6765 6561"
	$"5F5E A202 A3A2 A1FE A00F 9D9E 9EA0 A2A4"
	$"A7A5 A6A9 ABA6 A29D 9894 FE90 1B8F 8E8D"
	$"8F90 8F90 9394 9190 9192 8F90 908F 8F8E"
	$"8D8D 8E8D 8D8C 8D8C 8BFE 8C05 8A89 8887"
	$"8788 FB87 0588 898A 8D8A 88FE 89FE 88FF"
	$"8A10 8988 8786 8685 8486 8789 8C8B 8A89"
	$"8988 85FE 8704 888A 8C8C 8DFE 8E11 8D8B"
	$"898A 8889 8A86 8583 7E7C 7C79 7676 DDD9"
	$"14D9 D7D7 D8D7 D5D6 D6D9 DADC DDDA DBDE"
	$"DFDA D8D4 D1CF FCCB FFCA 00CC FECD 07CC"
	$"CDCC CDCB C9CA CAFD C901 C8C9 FEC8 FFC7"
	$"02C6 C7C5 FEC4 0EC3 C4C3 C1C2 C3C2 C3C1"
	$"C0C2 C3C1 C4C3 FDC1 06BF C0C1 C2C2 C1BF"
	$"FEBE FEBD 11BF C0C2 C1BF BEBD BCBB BDBD"
	$"BEBD BDBE BEBF C0FE C10E BEBC BCBB BBBD"
	$"BAB7 B7B4 B2B2 B0AF AF01 76FF 8C02 8B8C"
	$"8BFE 8917 8A89 8788 898E 8F90 9292 8F88"
	$"8181 807C 7875 7474 7272 7372 FD75 FF74"
	$"FF76 0F74 7674 7475 7472 7071 7271 6F6F"
	$"6D6E 6FFE 70FD 6FFF 6D3E 6B6D 6E6D 6D6C"
	$"6C6D 7171 6F6E 6D6D 7072 7072 7372 7271"
	$"6E6F 7171 6E6E 7173 7472 706F 716F 6E6E"
	$"7174 7376 7878 7A7A 7974 7374 7679 7775"
	$"7474 706E 6C68 6662 A10D A2A0 A1A2 A0A0"
	$"9F9F A09E 9E9F A4A6 FEA7 09A4 9E9B 9897"
	$"9692 908F 8EFD 8DFF 8EFE 8F0A 9190 8F8E"
	$"8F8E 8F8F 8E8E 8DFE 8BFF 8A1B 898A 8B8A"
	$"898A 8988 8889 8888 8788 8786 8788 8889"
	$"8B8C 8A89 8788 8A8B FE8A FF89 008A FD88"
	$"1087 8889 8A8C 8A89 8687 8685 8588 898A"
	$"8C8E FD8D FF89 FF8A FF8C FE8A 0786 8382"
	$"7F7D 7BDC D804 D8D9 D8D9 D9FE D8FF D702"
	$"D9DB DBFE DC18 D9D6 D3D2 D2D0 CBCA CCCC"
	$"CAC9 CBCB CCCB CBCA CACB CBCA C9CA C8FE"
	$"C904 C8C7 C6C6 C4FE C5FE C4FF C501 C4C5"
	$"FEC3 10C4 C3C2 C0C0 C1C2 C0C2 C3C3 C1C1"
	$"BFBF C2C3 FEC1 03C0 C1C1 BFFE C0FF BFFF"
	$"C101 C0BF FEBD 07BB BDBD BEBE BDBF BFFD"
	$"C00E BCBB BCBD BFBE BDBB BBB9 B6B4 B5B4"
	$"B101 7700 8BFD 8903 8788 8B8D FE8B 1A89"
	$"888B 9090 918F 8B84 8282 817C 7974 7271"
	$"7071 7272 7170 7071 7273 FD75 0778 7676"
	$"7573 7270 6EFE 6D0D 6B6A 6B6C 6E6F 7070"
	$"6E6D 6E6C 6D6B FE6A 0C6C 6E6F 7171 7071"
	$"7070 6F70 7271 FE6E 0D6C 6B6F 6E6D 6C6E"
	$"6F6D 6D6F 7071 6DFE 6B17 6D6C 7073 777B"
	$"7875 7171 7478 7875 7574 716E 6B6B 6965"
	$"61A1 029F 9E9E FE9F 01A0 A2FE A1FF 9F0F"
	$"A2A6 A5A6 A4A1 9D9B 9B9A 9796 928F 8D8D"
	$"FC8E 038D 8E8E 8DFE 900F 9192 9190 8F8D"
	$"8B8A 8988 8788 8988 8889 FE8A 038B 8A88"
	$"88FE 87FD 8606 888B 8D8C 8A89 89FE 8A01"
	$"8C8B FE87 FF86 2787 8687 8687 8986 8687"
	$"8788 8584 8585 8685 8889 8C8E 8D8B 8888"
	$"898A 8B8A 8988 8684 8182 7F7C 7CDB D406"
	$"D5D6 D7D6 D7D8 DAFE D902 D7D6 D7FE DB20"
	$"DAD8 D5D3 D4D2 CDCD CCCB CBC9 CACA C9C9"
	$"C8C8 C9CA CACC CBCB CCCD CCCB CAC8 C7C4"
	$"C4FE C508 C3C2 C4C5 C5C4 C4C5 C3FD C2FF"
	$"C000 C1FD C2FF C31C C2C3 C2C2 C1C2 C4C2"
	$"C0C0 BFBE BDBF BEBF BEBF C1BE BDBD BFBE"
	$"BBBB B9B9 BBFE BC0D BFC0 BEBC BABA BCBE"
	$"BEBD BCBA B8B6 FEB4 FFB2 016E FF8C 008B"
	$"FE89 058A 8B89 8B8D 8EFC 8FFF 901E 8F8B"
	$"8581 7F7D 7B78 7574 7471 7070 6E6C 6C6E"
	$"6F6F 706F 7274 7574 7576 7372 70FE 6DFF"
	$"6C20 6D6B 6B6C 6C6D 6C6B 6D6E 6F6E 6D6E"
	$"6D6E 6F6F 7171 7070 7170 6E6F 7072 6F6D"
	$"6D6E 6DFD 6905 6B6C 6D6C 6B68 FD69 FE6A"
	$"166C 6D6F 7276 7673 7474 7879 7875 7474"
	$"716C 6A68 6664 64A2 0CA2 A09F A09F 9FA1"
	$"A0A1 A3A3 A4A5 FEA4 FEA6 0AA3 9E9A 9897"
	$"9592 908F 908D FD8C 028B 8A8A FE8C 098E"
	$"8F90 8D8E 8F8D 8C8A 88FE 8706 8988 8887"
	$"8887 87FE 8801 8789 FD88 FF89 1088 8A8B"
	$"8A89 8B8A 8989 8A8C 8987 8788 8684 FE83"
	$"FF85 0286 8584 FC83 FF84 FE83 1584 878A"
	$"8B88 898A 8C8B 8B8A 8888 8681 7F7E 7D7C"
	$"7CDC D6FF D60C D7D4 D5D8 D8D9 DBDB DAD9"
	$"D8D9 DAFE DB05 DAD6 D2D0 CFCE FECC 04CB"
	$"C9C8 C9C8 FEC7 FFC6 FDC9 15CA C9CA CBC8"
	$"C7C7 C6C5 C4C3 C4C4 C3C3 C4C2 C3C3 C2C1"
	$"C2FE C30F C2C0 C2C1 C1C2 C3C2 C2C3 C3C2"
	$"C2C3 C5C1 FEBF 01BE BCFE BB06 BCBD BDBC"
	$"BBBA BBFB BAFD BB0C BCBE BBBC BDBF BEBE"
	$"BCBB BBB8 B4FE B201 B0B2 016D 0391 8F8E"
	$"90FE 9105 908F 8D8C 8C8F FE91 2A94 9190"
	$"9196 938A 8480 7C7B 7A76 7373 7173 726F"
	$"6F70 6E6F 6F6E 6F70 7072 7576 7573 7371"
	$"706F 6F6D 6D6E 6E6D FE6E FE6D FD6E 006D"
	$"FE6C FF6E FF6D 056C 6B6A 6A6B 6CFE 6B06"
	$"6967 6666 6566 67FE 690E 6867 6664 6567"
	$"6867 6765 676A 6F72 72FE 6F0D 7376 7978"
	$"7472 7371 6F6B 6969 6AA6 00A5 FDA4 1EA5"
	$"A4A2 A2A1 A2A5 A6A7 A6A7 A7A6 A6AA A8A1"
	$"9C98 9593 9390 8F8F 8D8D 8E8C 8A8A FE89"
	$"0C8A 8B8B 8D8C 8D8D 8E8D 8D8B 8A89 FD88"
	$"FD87 FF88 FF87 0288 8787 FA88 FF87 0086"
	$"FE87 1486 8785 8685 8381 8080 7F81 8384"
	$"8382 8081 817F 8081 FC80 0A81 8488 8884"
	$"8485 888A 8D8B FE86 0183 81FE 7F02 80DD"
	$"D816 DAD9 D9D8 D9D8 D7D7 D9DB DDDC DAD9"
	$"DBDA DBDA DEDB D5D2 D0FE CEFE CCFF CA02"
	$"CBC9 C8FC C7FF C601 C7C8 FECA 05C7 C8C7"
	$"C7C5 C4FD C3FD C204 C1C2 C2C1 C1FE C208"
	$"C3C1 C0C1 C1C0 C0BF BFFE C000 C1FE BE28"
	$"BDBB BAB9 B8B9 BABC BBBA B8B9 B8B6 B7B8"
	$"B9B8 B8B7 B8B8 B9BB BBBA B9B8 BBBC BFBD"
	$"BAB9 B9B6 B4B2 B3B3 B401 5F1E 9794 9495"
	$"9597 9897 9796 9593 9293 9394 9696 9492"
	$"9597 948E 8885 827F 7B78 77FD 7610 7573"
	$"7271 6F6E 6F6E 6F71 7273 7375 7574 74FE"
	$"73FF 70FE 6F08 6E6D 6D6E 6D6B 6B6C 6BFE"
	$"6C01 6A6C FE6A FC6B FF6A 0F69 6764 6161"
	$"6364 6162 6264 6666 6567 68FD 6707 6667"
	$"6969 6A6A 6869 FE6C FF6E FF6C 086D 6F70"
	$"6F6D 6F70 6FAB 03A9 A8A9 A8FB A9FF A8FF"
	$"A70F A6A9 AAA8 A6A9 AAAA A6A1 9B98 9795"
	$"9291 FE90 038F 8D8D 8CFB 8AFE 8B00 8DFE"
	$"8F07 8E8D 8C8C 8B8A 8988 FB87 0388 8687"
	$"86FE 85FF 86FF 84FD 85FD 840F 8382 7F7F"
	$"7D7C 7D7F 7F7D 7E80 807F 8181 FC80 FF81"
	$"0B80 8181 807F 8181 8284 8481 81FE 82FF"
	$"8304 8586 85E1 DAFF DB02 DADC DDFD DC1B"
	$"DBDC DBDA D9DC DDDB DADC DDDB D7D5 D2D1"
	$"CFCE CDCB CBCC CCCB CACA C9C8 FCC7 FFC8"
	$"11C7 C6C8 C8C9 C9C8 C7C7 C6C4 C3C3 C2C3"
	$"C2C0 C0FE C100 C2FE C115 BFBE C0BE BDBF"
	$"C0BF C0BF BDBE BEBC BCBB BAB9 B8B8 B7B9"
	$"FCB8 FFB9 FBB8 FFB9 01BA B9FE B8FF B6FF"
	$"B9FF B7FD B603 B5B7 B8B8 016E FF9C 029B"
	$"9A9A FE99 059A 9B9B 9A99 9AFE 9912 9A9B"
	$"9A97 9494 9696 938F 8A85 827F 7E7D 7C7A"
	$"77FE 7904 7773 7372 72FE 7312 7476 7576"
	$"7573 7476 7776 7474 7271 716F 6E6F 6EFE"
	$"6D04 6E6D 6C6B 6BFE 6804 6769 6867 68FE"
	$"692A 6A66 6463 6260 6160 5F60 5F61 6364"
	$"6563 6364 6566 6667 6867 6665 6566 6769"
	$"6A6B 6969 6E6F 706F 706E 6B6B AE00 AEFD"
	$"ACFF ABFF ACFF AD02 ACAD AEFD AD1C AEAC"
	$"AAA9 A9AB A9A5 A19C 9996 9595 9494 9191"
	$"928F 8F8E 8D8D 8E8C 8C8D 8DFD 8E01 8D8E"
	$"FE8F FF8D FE8B 0489 8789 8A88 FE87 FF86"
	$"FF85 2783 8283 8484 8382 8484 8383 8481"
	$"807E 7E7D 7C7C 7B7C 7C7D 7E7E 7F7E 7D7E"
	$"7E7F 8081 8180 807F 7D7E 7FFD 8001 7F83"
	$"FE85 0586 8482 82E3 DBFF DCFB DD19 DFDD"
	$"DCDD DCDC DEDD DCDE DCDA DADC DCDA D8D5"
	$"D2D1 CFCF D0CE CCCB FECC 02CA C9C9 FBC7"
	$"0EC8 C9C8 C7C6 C8CA C9C8 C5C6 C4C3 C5C5"
	$"FEC3 FFC1 FFC2 03C0 BFBE C0FE BF02 BDBE"
	$"BFFC BD04 BCBB BAB8 B8FE B7FE B6FE B705"
	$"B8B7 B6B7 B6B7 FCB8 FFB6 07B7 B6B6 B7B7"
	$"B6B6 B8FE B703 B8B6 B4B4 016B 2296 9594"
	$"9597 9796 9798 9799 9B9A 9999 9C9E 9D9E"
	$"9D9B 9A97 9696 999A 9997 9491 908B 857F"
	$"FE7D 187C 7B79 7777 7879 797A 7A79 7A79"
	$"7877 7476 7879 7675 7573 7272 FD71 FF70"
	$"0E71 6F6F 706F 6E6D 6D6B 6B68 6665 6668"
	$"FE69 0D6A 6865 6263 6361 5D5E 5E5D 5D5E"
	$"5FFD 6000 61FE 6400 66FE 650E 6665 6466"
	$"6867 6869 6A6B 6A6A 696A A905 AAA9 A9AA"
	$"ABAA FEAB 1EAC AEAD AEAF B0B0 AFB0 B1B0"
	$"AFAD ABAB ACAD ACAA A9A7 A5A0 9B98 9696"
	$"9594 9393 F992 0793 9291 8F8E 8F91 91FE"
	$"8F03 8D8C 8C8B F98A FE89 1288 8786 8684"
	$"8383 8282 8383 8484 8382 817F 7E7E FE7B"
	$"017A 7BFD 7AFF 7B04 7C7F 7F7D 7FFA 7E01"
	$"7F7E FE80 0681 8081 8082 E0D8 FFD9 10DA"
	$"DBDC DDDD DCDD DCDA DBDB DEDE DDDE DEDD"
	$"FEDB FEDC 13DA D9DA D8D8 D5D2 CFCF CECE"
	$"CDCC CCCA C9C9 CACB CBFD CC08 CAC8 C7C8"
	$"C9C9 C8C8 C9FE C603 C5C3 C4C4 FEC3 06C2"
	$"C3C2 C2C1 C0BF FEBD 03BC BDBC BBFD BC1B"
	$"BBBC BBB9 B8B8 B4B5 B5B4 B6B5 B4B3 B4B5"
	$"B5B4 B6B5 B5B7 B7B5 B6B6 B5B5 FEB4 07B7"
	$"B4B3 B4B3 B4B3 B501 6A01 9391 FE92 FE93"
	$"2C94 9595 9899 9A9C 9C9D 9C9E 9D9E 9E9F"
	$"9F9E A0A0 9FA1 A4A3 A29D 9891 8A86 8584"
	$"807E 7E7D 7B7B 7A7B 7D7E 7E7D 7D7B FC79"
	$"0078 FE76 0974 7372 7271 6D6E 6F6F 6DFE"
	$"6FFF 6DFF 6E0E 6D6C 6C6B 6A68 6967 6868"
	$"6564 6364 65FE 63FE 6101 6263 FE65 FF64"
	$"0262 6163 FE62 FD61 FF63 0862 6568 6662"
	$"6464 65A7 17A6 A5A6 A7A7 A8A8 A7A8 A9AB"
	$"AAAC ADAE AFAF B0B0 B2B3 B2B2 B1FE B000"
	$"B2FE B307 B0AC A6A0 9C99 9897 FE96 FF95"
	$"0A93 9495 9696 9593 9391 9292 FD91 0F90"
	$"8F8D 8D8C 8B8B 898A 8B88 8989 8889 89FB"
	$"8822 8685 8484 8383 8282 8180 7F80 8180"
	$"7E7C 7C7B 7B7D 7F80 7F7E 7E7D 7B7D 7B7B"
	$"7A7A 7B7B 7AFE 7B08 7D7E 7E7B 7B7C 7DDD"
	$"D801 D7D8 FCD9 04DC DBDC DBDC FEDD 1EDC"
	$"DDDE DEDD DEDE DDDD DCDB DCDE DEDD DCD9"
	$"D6D4 D1D2 D1CE CFCF CECD CDCB CCCE FDCD"
	$"FDCA 00C9 FCC8 1DC7 C6C5 C4C4 C3C2 C2C1"
	$"C1C2 C1C1 C0C1 C0C0 C1C0 C0BE BDBC BDBC"
	$"BCBB BCBB BAFE B8FF B7FF B60C B7B6 B5B7"
	$"B8B8 B6B6 B5B4 B6B4 B4F9 B302 B4B6 B4FE"
	$"B100 B201 6DFD 930A 9193 9290 9192 9395"
	$"9699 9BFC 9926 989A 9EA1 A2A4 A5A5 A8AA"
	$"AAA8 A7A5 A29E 9B93 8E8B 8785 8485 8583"
	$"8483 8482 7E7C 7B7A 7978 7B79 78FD 7707"
	$"7574 7372 7172 726F FE6D FF6C FF6D FE6C"
	$"FF6B FF6C FE6A 1369 6868 6A6A 6C6C 6D6C"
	$"6A68 6764 6463 6263 6263 63FE 6210 6160"
	$"5F5F 5E5E 5D5E 5D5E 5E5C 5C5D 5E5F A6FF"
	$"A50C A6A4 A6A7 A5A5 A6A7 A8A9 AAAA ABFE"
	$"ACFF AE07 AFB1 B3B4 B5B6 B7B8 FDB7 07B6"
	$"B4B0 ABA6 A1A0 9DFC 9A06 9B99 9998 9694"
	$"93FE 9100 92FD 91FF 900B 8E8D 8D8C 8B8A"
	$"8A89 8988 8686 FE87 FE86 0C87 8887 8687"
	$"8584 8381 8182 8284 FE85 0A83 8080 7D7D"
	$"7E7E 7D7C 7D7D FE7C 047B 7A79 7878 FE77"
	$"0976 7877 7675 7676 77DE D8FF D800 D7FD"
	$"D8FF DAFE DBFF DC09 DBDA DBDC DBDB DCDE"
	$"DEDD FDDE FFDD 0ADE DDDD DBDA D6D5 D5D2"
	$"D1D0 FDCF 04CE CFCF CDCC FECA 03C9 CBC8"
	$"C8FE C907 C8C6 C5C6 C5C3 C3C2 FEC1 00C0"
	$"FEBF FDC0 00BF FEBE 02BD BEBD FEBC 01BD"
	$"BAFE BC0B BBBA B9B9 B6B6 B7B6 B5B4 B5B5"
	$"FDB4 03B3 B2B2 B1FE B007 AEAF AFAE AEAF"
	$"AFAE 0176 2194 9191 9091 9291 9090 9294"
	$"9493 9697 9897 9897 9898 9A9A 9C9E A1A2"
	$"A2A6 A6A5 A5A8 A6FE A428 A19A 938F 8C8C"
	$"8B89 8A8C 8D8C 8C89 8580 7C7A 7878 7777"
	$"7876 7475 7675 7573 7071 716F 7170 6E6A"
	$"6B6C 6CFE 6BFF 6A12 6C6D 6D6E 6E70 7270"
	$"706E 6B69 6867 6664 6565 63FE 61FE 60FF"
	$"5FFF 600F 5D5E 5E5D 5C5B 5C5A 5958 5757"
	$"595A 5AA7 FDA5 FDA6 05A7 A8A8 A7A9 AAFD"
	$"ABFE AC3A AEAF B0B3 B5B6 B7B6 B6B7 B8B7"
	$"B8B6 B5B2 AEA8 A5A2 A1A0 9FA0 A2A3 A2A1"
	$"9D9A 9694 9391 9190 8F91 908F 908F 8E8E"
	$"8D8C 8D8D 8B8B 8A89 8887 8686 8585 86FE"
	$"8510 8687 8788 8989 8888 8685 8382 8281"
	$"8081 7FFE 7D00 7EFE 7C0C 7B7A 7A79 7879"
	$"7777 7675 7574 75FD 7303 7273 DDD8 0AD8"
	$"D7D7 D8D8 D9D9 DADB DBDA FDDB FFDA FFDB"
	$"FFDA 37DB DCDE DEDD DEDD DCDD DEDB DEDD"
	$"DCDA D9D6 D5D3 D3D2 D0D2 D4D5 D4D3 D1CE"
	$"CCCB CBC7 C9C9 C8C9 C8C6 C7C7 C6C6 C5C4"
	$"C5C4 C3C4 C3C1 C1C0 BFBF BEFE BF07 BEBD"
	$"BEBE BFBF C1C0 FEBF 1CBD BCBB BABA B8B8"
	$"B7B6 B5B5 B4B3 B2B2 B5B4 B4B3 B1B3 B1B1"
	$"B0AF AEAD ADAC FDAB 00AD 0169 0591 8F90"
	$"9290 90FE 910F 9295 9493 9294 979A 9C9B"
	$"9A9A 9B9A 9A9B FC9C 0E9F A0A1 A1A3 A4A3"
	$"A19F 9C98 9390 8D8C FE8B 008E FE90 2E8C"
	$"8886 8381 7F7D 7C7B 7775 7574 7372 6F6F"
	$"7171 7271 706E 6D6D 6C6C 6A6B 6E6F 6F70"
	$"706F 6E6E 6C6C 6A69 6967 6867 6563 FE61"
	$"0A5F 5D5F 5E5D 5B5D 5E5D 5C5D FE5C FD5B"
	$"0759 5859 5A5A 5958 A5FF A503 A4A3 A4A5"
	$"FEA6 0EA8 A9A8 A7A8 A9AB ADAC ACAE AEAD"
	$"AEAE FEAF 00B1 FEB2 24B3 B5B6 B5B5 B4B2"
	$"AFAA A7A5 A29F A0A1 A1A3 A5A4 A3A1 9E9C"
	$"9997 9694 9292 9191 8F8E 8E8D 8C8C FD8B"
	$"038A 8888 87FE 86FE 8700 88FE 8914 8887"
	$"8786 8483 8381 8180 807F 7E7E 7D7C 7B7B"
	$"7A7B 7AFE 7900 76FD 770C 7675 7475 7473"
	$"7474 7374 74DC D609 D8D7 D6D6 D8D8 D6D9"
	$"DBDB FDDA F9DB 01D9 DBFE DCFF DBFE DC05"
	$"DDDB DAD9 DAD8 FED5 02D2 D1D2 FCD3 FFD2"
	$"16D0 CECC CDCB CACA C9C6 C5C7 C6C5 C4C3"
	$"C4C4 C3C3 C2C3 C2C1 FEC0 05BF BEBF BFBE"
	$"C0FD BF01 C0BE FEBB FFBA 01B9 B8FD B6FE"
	$"B3FF B2FD B3FF B200 B1FD B008 AFAE AEAC"
	$"ADAC ACAB AC01 6334 8A89 8789 8B8B 8D8F"
	$"9192 9496 9899 9A9B 9C9D 9D9C 9C9B 999B"
	$"9C9C 9D9A 9899 9A99 9998 9C9E 9E9F A1A2"
	$"A29C 9996 928F 8D8D 8C8D 8C8C 8EFE 8D0D"
	$"8C8A 8886 8580 7F7C 7A75 7370 6E70 FE6E"
	$"0071 FC72 0F71 6E6F 6F70 6E6D 6D6C 6B6A"
	$"6764 6363 62FD 6012 5F60 5F5F 5E5D 5E5D"
	$"5C5B 5B5C 5D5C 5C5B 5A5A 5BFD 5A01 5B5C"
	$"FE59 009E FC9F 06A1 A3A5 A6A8 AAAB FEAD"
	$"06AE AFAF B0AF AFAD FDAE FFAC FEAD 13AE"
	$"ADAF B0B0 B1B2 B1B1 AFAC A9A5 A3A3 A2A2"
	$"A3A2 A0FD A212 A19F 9E9B 9998 9793 928F"
	$"8C8D 8A8A 8B8A 8B8C 8CFD 8B05 8A87 8887"
	$"8888 FE87 0E85 8484 817F 807F 7E7D 7C7D"
	$"7C7D 7C7B FE7A FF79 FD78 FF76 0077 FE76"
	$"0075 FB74 FF73 01D8 D1FF D2FF D407 D5D6"
	$"D6D7 DBDB DADB FBDC 00DB FDDA 05DB DCDA"
	$"D9D9 DAFE D800 DBFD DA1C D9D8 D7D6 D5D4"
	$"D2D3 D3D1 D2D1 D1D3 D1D0 D1D2 D0D0 CECF"
	$"CCC9 CAC9 C6C4 C3FE C2FF C1FC C203 C1C0"
	$"BFC0 FEBF FEBE FEBD 0BBA B9BA B8B7 B7B6"
	$"B7B7 B8B6 B4FE B30D B5B4 B2B2 B3B2 B1B2"
	$"B2AF AEB0 B0AF FDAD FEAC 0170 0385 8282"
	$"85FD 87FF 8A1C 8B8D 9093 9394 9797 9596"
	$"9698 999A 9C9C 9A9B 9B99 9897 9796 9796"
	$"979A 9DFD 9E34 9C9A 9692 9392 908F 8F8C"
	$"8989 8788 8A89 8888 8585 8484 817F 7D7A"
	$"7975 7272 7578 7776 7675 7470 6E6D 6C6B"
	$"6A68 6662 615F 5F60 6160 60FE 5FFF 5EFF"
	$"5D00 5CFE 5DFF 5E12 5D5C 5C5D 5B5B 5C5D"
	$"5D5C 5B5C 5B5A 5B58 5A5A 9C19 9C9A 9A9B"
	$"9B9C 9D9F A0A2 A3A4 A7A8 A8A9 AAAB ABAA"
	$"ADAD AEAF AEAC FEAD 17AC ABAA A8A9 AAAA"
	$"ACAF B0B1 B2B1 AEAB A7A6 A5A5 A4A2 A3A1"
	$"9FFE 9EFF 9F0B 9D9E 9C9B 9A9A 9895 9391"
	$"908F FE8D FE8F 0D90 8E8C 8A89 8988 8784"
	$"8384 8280 7EFE 7DFC 7CFD 7BFF 7AFF 7800"
	$"79FC 7706 7577 7776 7777 75FD 76FE 7401"
	$"D6D1 06D3 D0CF CFD0 D0D4 FDD5 FFD8 22D9"
	$"D7D6 D6D8 D8DA DBDA D9DB DAD9 D9D8 D7D6"
	$"D7D5 D7D6 D6D9 D9D8 D8D7 D8D9 D7D5 D5D6"
	$"D5D3 FDD1 17D0 CFD0 D1D0 CECF CECD CCCA"
	$"CAC9 C9C6 C4C4 C2C3 C4C5 C3C3 C5FE C2FE"
	$"C011 BFBD BCBB B9B9 B7B7 B9BA B9B9 B7B7"
	$"B8B8 B6B6 FEB5 07B3 B4B5 B2B2 B1B2 B2FE"
	$"B101 B0AF FEAE FEAD FFAB 00AC 0171 0083"
	$"FE81 3582 8384 8686 8789 8B8C 8F92 9494"
	$"9390 8E8D 8D8E 8F90 9293 9598 9999 9897"
	$"9695 9495 9799 9A9D 9FA0 9F9F 9C97 9491"
	$"8F8B 8B89 8A88 8586 86FD 8202 8182 85FE"
	$"860D 8480 7873 7477 7674 7271 6E6B 6B69"
	$"FE66 0D62 6160 6160 5F5F 6160 5F5F 5C5C"
	$"5DFE 5B00 5DFE 5B15 5C5D 5D5C 5C5E 5E5D"
	$"5C5D 5D5C 5C5B 5A59 5A59 595A 589C 1A9B"
	$"9A98 999A 9A9C 9D9F A0A0 A2A3 A5A7 A7A6"
	$"A5A2 A1A2 A3A4 A5A7 A7AA FEAB 17AC AAAA"
	$"A9A8 A9AA ACAD AFB1 B2B1 AFAE A9A6 A5A3"
	$"9FA0 A09F 9DFE 9CFF 99FF 971A 999A 9B9C"
	$"9B9B 9996 918E 8D8F 908F 8C8C 8A88 8786"
	$"8582 8281 817F 7FFE 7EFE 7DFD 7CFF 7BFD"
	$"7904 7778 7877 78FA 77FF 76FE 7506 7475"
	$"7473 74D8 D100 D1FE CF08 D1D3 D2D2 D3D4"
	$"D6D7 D7FE D60D D4D3 D3D4 D5D6 D5D6 D6D5"
	$"D6D8 D8D7 FED6 01D5 D6FD D704 D8D9 D8D8"
	$"D7FE D400 D2FE D0FF CF02 CDCE CEFC CB0B"
	$"CCCD CECF CECB CAC5 C4C5 C6C4 FEC3 07C1"
	$"BFBE BCBB BBBC B9FE BAFE B70A B8BA B9B6"
	$"B5B7 B6B3 B5B5 B6FE B4FF B301 B2B3 FEB2"
	$"06B1 B0B0 AFAF B0AF FEAD 03AC ABAC AB01"
	$"730C 8782 7F80 8281 8285 8788 8A8B 8CFE"
	$"8E30 8985 8586 8481 8282 8182 8588 8B8D"
	$"8D8E 8E90 9192 9698 9A9D 9E9E A09F 9D98"
	$"918D 8C8B 8785 888D 8E8B 8685 8280 7D7E"
	$"7E7C 79FE 770B 7674 7270 6F6F 6E6C 6A68"
	$"6765 FE64 FF62 0061 FE60 FF61 0060 FE5F"
	$"025C 5D5D FE5C 015B 5CFD 5B14 5A5C 5C5B"
	$"5D5C 5A5C 5B5A 5B5A 5958 5758 5859 5859"
	$"9D0B 9A98 9799 9899 9B9D 9EA0 A1A1 FEA2"
	$"30A1 9E9C 9B99 999A 9C9B 9B9D 9FA1 A3A3"
	$"A4A4 A6A7 A7AA ABAC AFB1 B1B0 AFAE ACA7"
	$"A2A1 A19E 9B9D A0A1 A09C 9B98 9895 9697"
	$"9392 FE91 088F 8E8C 8A8A 8B89 8785 FE84"
	$"0183 82FE 8101 807F FD7E 007F FE7E 027B"
	$"7C7C FE7B 017A 7BFE 79FB 780B 7776 7776"
	$"7576 7473 7374 7272 FE73 01D7 D009 D0CF"
	$"D0CF D1D3 D1D2 D2D3 FED4 18D3 D2D1 D2D2"
	$"D0CF D0D1 D1D0 D1D2 D2D3 D4D5 D4D5 D4D4"
	$"D6D7 D6D8 FED7 02D8 D6D5 FED2 15D0 CECE"
	$"CFD0 D0CF CDCD CBC9 C8C9 CAC8 C7C6 C7C7"
	$"C6C6 C4FE C200 C1FE C003 BFBD BBBB FABA"
	$"FEB8 FEB7 07B5 B7B6 B6B5 B3B4 B5FE B4FE"
	$"B3FF B20F B3B2 B0B1 AFAE AFAF AEAC ACAB"
	$"ACAB ABAC 0174 1687 8484 8382 8385 8889"
	$"898A 8B8C 8A85 8280 7F7E 807F 7D7C FE7B"
	$"FF7C 2B7D 7F80 8184 8B8E 9094 9698 9A9C"
	$"9C9A 948C 8788 8986 8587 8687 8887 8481"
	$"7E7B 7775 7576 7674 7270 6F6C 6C6B 68FE"
	$"6704 6664 6361 62FD 610A 6260 6160 6061"
	$"605F 5F60 60FE 5E11 5F5D 5B5C 5D5C 5B5B"
	$"5A59 5B5B 5A5B 5B5A 5C5C FD5B FF5A 0559"
	$"5A5A 595B 9DFF 9B38 9A99 9A9B 9C9E 9E9F"
	$"A1A1 9E9C 9A98 9796 9897 9697 9795 9697"
	$"9696 9899 9A9B 9FA3 A4A8 A9AA ADAF AEAB"
	$"A7A1 9E9F 9F9C 9C9E 9C9E 9F9D 9A97 9593"
	$"93FE 9012 8E8D 8C8B 8A88 8788 8886 8584"
	$"8483 8381 807F 7FFD 80FE 7F01 7D7F FD7E"
	$"FF7C FF7D FF7B 027C 7B7A FE79 FF78 FF77"
	$"0778 7777 7676 7576 76FE 75FE 7403 7375"
	$"D5CE 08D0 CFD0 D0D2 D3D3 D2D1 FED2 06D0"
	$"D1D1 D0CE D0D0 FDCF FDCE 00CF FED0 22D1"
	$"D2D1 D4D4 D6D7 D6D4 D4D5 D1CF D0D1 CECC"
	$"CECE CFD0 CECB CACA C8C6 C6C7 C7C6 C5C4"
	$"C3C2 FEC1 FFC0 06BF BEBD BEBE BCBC FEBB"
	$"FEBA FFBB FFBA 0FB8 B7B8 B6B7 B8B7 B8B8"
	$"B5B4 B5B4 B2B2 B4FC B304 B4B1 AFAF B0FE"
	$"AFFF AE05 ADAB ACAC ABAD 016D 1686 8584"
	$"8383 8485 8686 8584 8584 8381 7E81 807E"
	$"807F 7D7D FE7B 167A 7B7C 7D7E 7F82 888B"
	$"8D8E 9092 9593 908A 8480 7F7E 7E7F FE80"
	$"197F 7E7E 7C7A 7775 7373 7270 6F6E 6C6B"
	$"6A66 6567 6866 6566 6563 64FE 6314 6160"
	$"6162 6061 605F 6060 5E60 605F 5F5E 5E5F"
	$"5E5C 5BFE 5CFE 5DFE 5C00 5EFD 5FFD 5EFF"
	$"5D05 5C5B 5B5C 5C9C 039C 9B9A 9AFE 9B0C"
	$"9C9B 9B9C 9C9A 9999 9897 9798 98FC 9613"
	$"9596 9596 9799 9A9D A0A2 A4A4 A6A8 A8A6"
	$"A09C 9796 FE98 FF99 FE97 0E96 9492 8F8E"
	$"8D8D 8C8C 8A8A 8987 8786 FD85 FF84 0083"
	$"FD81 FE80 FF7F 0180 7FFE 7E03 7F7D 7D7E"
	$"FD7D FF7C FE7B FF79 0778 797A 7978 7879"
	$"7AFE 79FF 7802 7978 77FD 76FF 7701 D3CD"
	$"06CF CECF D0D1 D1D0 FECF FED0 0DCF D0CF"
	$"CED0 D0CC CDCE CDCD CCCD CDFE CE0E CDCF"
	$"D1D2 D2D3 D3D4 D2D1 CFCD CACA CBFD CCFF"
	$"CAFF CB1A C8C9 C8C6 C5C5 C4C3 C2C2 C1C0"
	$"C1BF C0BF BEBD BDBE BDBC BDBC BCBB BAFE"
	$"BBFF BAFD B901 B7B9 FEB8 FEB6 05B5 B4B3"
	$"B3B2 B2FE B3FF B200 B1FE B2FF B1FF AF00"
	$"B0FE AF04 ACAD ADAC AC01 5C0F 8382 8180"
	$"7E7F 8182 817E 7B7A 7B79 7A7B FC7D 007C"
	$"FC7B FE7C 0C7F 817F 8081 7F7E 7F7E 7F7D"
	$"7D7C FE7A FF79 FE7A FF79 0C78 7674 7473"
	$"7170 6E6E 6D69 6866 FD68 0367 6867 66FC"
	$"650B 6462 6363 6261 6261 6061 6060 FE5F"
	$"005E FE5F FE5E 035D 605E 5EFE 5D0F 5E5F"
	$"6061 6160 6161 6061 605E 5C5C 5B5A FE5B"
	$"009B 039A 9999 98FE 9906 9796 9695 9593"
	$"95FD 96FF 9700 96FE 95FF 96FE 9703 989A"
	$"9999 FE98 FF97 0599 9897 9594 94FD 930D"
	$"9493 9493 9292 908F 8D8C 8C8A 8888 FE87"
	$"FF86 FC85 FE84 FF83 FB82 FF81 FF7F FF80"
	$"FF7F 017E 7FFD 7E06 7C7D 7D7C 7D7B 7BFB"
	$"7AFF 7C05 7B7A 7A79 7A79 FE78 0077 FE76"
	$"0277 D2CE 0FCE CCCD CCCE CFCE CECD CDCE"
	$"CCCD CDCE CDFB CEFE CD20 CCCD CECF CFCD"
	$"CDCE CDCC CCCB CDCC CCCA C9C8 C8C9 CACA"
	$"C8CA CAC9 C7C9 C6C6 C4C3 C2FE C1FF C0FF"
	$"C106 C0BF BFBE BDBE BEFE BDFF BCFF BB01"
	$"BABB FEBA 02B9 B8B8 FEB9 FEB8 FEB7 FEB5"
	$"06B4 B5B3 B3B4 B2B2 FCB3 FEB2 07B0 B1B1"
	$"B0AF AFAE ACFE AD01 6800 81FE 7C02 7A79"
	$"7BFE 7A02 7978 7AFD 7BFF 792C 7A7B 797A"
	$"7A7B 7A7A 7979 787A 7A77 7577 7877 7676"
	$"7777 7676 7577 7775 7476 7573 7171 7372"
	$"706E 6C6D 6B6C 6D6C 6BFE 6906 6A6B 6A69"
	$"6968 68FE 6506 6664 6362 6463 63FC 62FF"
	$"60FF 611C 6061 605F 6161 5F60 6163 6261"
	$"6262 6362 6162 6461 6160 5F5F 605F 5C5A"
	$"5BFE 5CFF 5B00 9705 9695 9594 9495 FE94"
	$"FF93 FE94 0196 95FA 94FF 950B 9694 9593"
	$"9493 9293 9292 9190 FE91 FD90 0191 92FE"
	$"910C 908F 8E8D 8D8B 8B89 8A89 8988 87FE"
	$"8802 8786 87FE 8602 8586 85FC 84FF 83FE"
	$"8206 8180 8081 7F80 80FB 7FFF 7E01 7F7D"
	$"FE7E FE7D 057C 7D7E 7D7B 7BFE 7A06 7978"
	$"7778 7776 75FE 7601 D2CC 06CD CBCA CACD"
	$"CCCB FECC 0ECD CCCC CDCD CBCB CCCC CBCB"
	$"CACB CCCC FECB FFCC FEC9 07CB C9C9 CAC9"
	$"CAC9 C9FD C8FC C7FF C6FF C5FF C300 C4FE"
	$"C1FF C01A C2C3 C1C1 C0BF C0BF BEBE BCBC"
	$"BDBC BCBB BABC BCBB BAB9 B9B7 B7B9 B9FC"
	$"B70A B8B9 B8B6 B5B4 B6B5 B4B4 B5FE B4FF"
	$"B50E B3B2 B0B0 B1B1 B0B0 AFAE ADAC ADAC"
	$"AD01 6000 7CFE 7A02 7977 77FE 78FE 79FF"
	$"7A07 7978 7778 797A 7778 FE79 0277 7878"
	$"FD77 0178 77FC 7501 7375 FE74 0375 7373"
	$"71FE 7000 6EFE 6F08 6E6B 6B6C 6D6D 6C6B"
	$"69FE 6A1D 6968 6968 6867 6565 6665 6665"
	$"6463 6263 6362 6263 6361 6061 6463 6565"
	$"6363 FC62 FF61 FF62 FE63 0762 6160 605E"
	$"5C5E 5EFE 5B02 5C5D 5DFE 5B00 9400 94FE"
	$"93FC 92FF 9301 9293 FE94 0D93 9494 9594"
	$"9493 9494 9292 9190 90FE 91FF 9204 908F"
	$"9090 8FFE 9015 9190 8F8F 8E8E 8D8C 8C8B"
	$"8A8A 898A 8B8B 8A89 898B 8989 FE88 0987"
	$"8686 8485 8686 8584 85FE 84FC 82FF 8109"
	$"8081 8081 8081 807F 8080 FD7F 0180 7FFE"
	$"7D06 7C7D 7D7C 7B7B 7AFE 79FF 7802 7677"
	$"77FD 7501 D0CA 17CB CACB C9CA CBCB CCCB"
	$"CCCB CBCC CBCB CACB CBCC CACC CACB CBFC"
	$"CAFB C912 C7C8 C9C7 C8C6 C7C8 C7C6 C6C5"
	$"C5C4 C5C3 C4C2 C3FB C2FF C101 BFC1 FBBF"
	$"17C0 BFBC BCBE BDBE BDBB BCBD BCBC BBBA"
	$"B8B9 B9B8 B6B8 B8B9 B9FE B700 B6FE B5FF"
	$"B6FB B403 B3B2 B2B1 FDB0 07AF AEAD AEAE"
	$"ACAC AD01 5E08 7A78 7876 7777 7879 79FD"
	$"780C 7776 7575 7675 7877 7675 7577 77FE"
	$"76FF 741E 7576 7777 7572 7375 7472 7372"
	$"7271 7071 7170 6E6F 6F6D 7071 6F6F 6E6D"
	$"6C6D 6DFE 6BFB 6A00 68FE 67FF 66FD 65FD"
	$"6404 6365 6363 62FE 630D 6463 6464 6361"
	$"6162 6160 5F5E 5F60 FE61 0D62 5F60 605D"
	$"5E5F 5D5D 5C5C 5B5A 5AFE 5900 94FF 9300"
	$"92FD 9101 9290 FB91 0692 9391 9293 9192"
	$"FE91 0690 9191 8F90 9191 FD90 098F 9091"
	$"908E 8D8E 8F8D 8EFE 8D08 8C8B 8C8D 8C8B"
	$"8D8C 8BFE 8AFE 89FE 8803 8788 8887 FE86"
	$"0C85 8485 8483 8584 8483 8381 8182 FE81"
	$"0080 FC81 FE80 0E81 7F7E 7F7F 7E7D 7C7D"
	$"7C7D 7C7C 7A7B FE7A 0479 7777 7676 FE75"
	$"0276 CFC9 15CB CACA C9C9 CACB CBCC CCCB"
	$"CBCC CACA CBCB CCCA C9CA C9FE CAFF C9FF"
	$"C800 C9FE C8FF C7FF C800 C7FB C6FF C7FE"
	$"C4FF C308 C5C4 C3C4 C3C2 C1C1 C2FE C1FF"
	$"C0FF BF03 C0BF BEBF FDBE 02BD BCBC FCBB"
	$"02BA B9B7 FEB9 FFB7 00B8 FDB7 FDB6 03B5"
	$"B6B5 B5FD B302 B4B2 B2FD B1FF B000 AEFE"
	$"ADFD AC01 590F 7877 7676 7474 7577 7776"
	$"7574 7476 7575 FC74 1573 7475 7775 7473"
	$"7472 7373 7473 7471 7172 7273 7473 71FE"
	$"70FF 7200 70FE 6E00 6FFD 7008 6F6E 6C69"
	$"6B6D 6C6A 6AFD 6B02 6A69 68FE 6913 6866"
	$"6567 6665 6665 6567 6665 6564 6465 6462"
	$"6362 FD61 FF60 FF5F FF60 FF5F FF60 115E"
	$"5D5D 5E5B 5B5C 5B5B 5958 5959 5858 5756"
	$"9105 9190 908F 9091 FE90 FF91 0090 FE91"
	$"FF90 0191 90FE 9202 9192 90FE 9100 90FE"
	$"9100 8FFE 9004 8F90 908E 8FFC 8E01 8D8C"
	$"FA8D 078C 8D8C 8C8B 8A89 89FD 88FF 8900"
	$"88FC 87FF 86FD 85FF 8401 8584 FD82 0083"
	$"FC81 FF80 0281 8080 FE7E FF7D FC7C 0A7B"
	$"7A7A 7979 7877 7677 7675 FE74 FF73 01CD"
	$"C7FF CAFC C9FF CBFD CA06 CBCA C9CB CAC9"
	$"C9FC CAFE C8FF C902 C8C7 C8FD C704 C6C5"
	$"C7C6 C5FE C606 C5C4 C4C5 C5C6 C5FD C4FF"
	$"C2FC C1FF C207 C1C0 BFBF BEBF BFBE FEBD"
	$"02BC BDBE FEBB 0DBC BBBA BABB B9B9 BAB9"
	$"B8B8 B7B6 B7FD B6FE B500 B4FD B300 B2FE"
	$"B1FE B000 AFFE AE01 ADAC FEAB 00AA 0166"
	$"0C76 7474 7372 7274 7475 7676 7474 FE76"
	$"1475 7475 7373 7273 7274 7673 7375 7473"
	$"7374 7372 7071 FD73 0072 FD71 2270 6F6F"
	$"706F 6F71 7270 7071 6F6E 6D6B 6B6C 6C6B"
	$"6A6B 6B68 686A 696B 6B68 696B 6766 6768"
	$"FE67 0265 6665 FE64 0165 64FE 62FD 6008"
	$"5F5D 5E5E 5F5F 5E5E 5FFE 5C07 5D5B 5B5C"
	$"5D5C 5A59 FE57 0556 5A57 5758 9100 90FC"
	$"8F04 8E90 8F91 91FB 900A 9291 9292 9091"
	$"9291 9190 90FD 9108 908F 9090 8F8F 908F"
	$"90FD 8F06 8E8D 8E8E 8D8C 8CFE 8D06 8E8D"
	$"8E8E 8C89 89FB 8A04 8988 8889 88FD 8715"
	$"8685 8685 8485 8484 8382 8381 8281 8182"
	$"8280 8081 807F FD7E 007D FE7C 007B FE7A"
	$"FE78 0177 78FC 7606 7573 7272 73CF C802"
	$"C9CA C9FE C804 CAC9 C9C7 C8FE C908 C8C9"
	$"CBCA CAC9 CACA C9FE C8FF C9FD C806 C6C7"
	$"C7C6 C6C7 C5FE C604 C5C6 C6C4 C4FE C500"
	$"C7FD C507 C3C4 C3C1 C1C2 C1C0 FCC1 03C0"
	$"BFBE BFFE BE06 BDBC BEBF BCBB BCFE BBFF"
	$"BA0C B8B9 B8B7 B8B8 B7B6 B7B6 B6B5 B5FE"
	$"B4FE B3FF B1FF B2FF B105 B0AF AFAE AEAD"
	$"FEAC 00AD FEAB 0166 1275 7474 7272 7574"
	$"7375 7776 7575 7475 7677 7677 FD75 FF74"
	$"0376 7473 75FC 74FF 7310 7273 7474 7272"
	$"7172 7273 7370 7271 7071 72FE 7407 7372"
	$"7171 6F6C 6D6E FE6C FF6D 026B 6C6C FC6A"
	$"0169 68FE 6900 68FE 671C 6866 6663 6364"
	$"6365 6361 6060 6262 6061 6160 5F5E 5E5F"
	$"5F5E 5D5C 5D5C 5EFE 5C03 5D5C 5A5A FE59"
	$"0257 5591 FF91 0390 8F90 8FFD 900D 9192"
	$"9190 9190 9193 9190 9091 9192 FE91 FF90"
	$"FF92 FE91 FF90 FE91 FE90 018F 90FE 8FFD"
	$"8EFF 8F06 908F 908F 8E8E 8DFD 8BFE 8A07"
	$"8B89 8A8A 8989 8888 FD87 FF86 0F87 8585"
	$"8483 8484 8382 8280 8181 807F 7FFE 80FF"
	$"7FFF 7EFE 7DFE 7BFF 7AFD 79FF 7809 7776"
	$"7776 7574 7475 CFC8 05C8 C7C8 C7C7 C8FD"
	$"C905 CAC9 CAC9 C9CA FEC9 01C8 CAFE C904"
	$"C8C9 CAC8 C8FE C905 C8C7 C6C6 C7C8 FAC6"
	$"06C5 C6C5 C4C5 C7C5 FEC6 0BC5 C4C4 C3C2"
	$"C1C1 C0C0 C1C2 C1FE C002 BEBF BFFC BE0B"
	$"BCBB BCBB BABA BBBA BAB9 B8B8 FEB7 04B6"
	$"B5B5 B7B7 FEB5 00B4 FEB3 0EB4 B2AF B1B2"
	$"B1B0 B0AE B0AF AEAE ACAD FEAC FFAB 015E"
	$"2B76 7473 7476 7574 7675 7474 7678 7777"
	$"7877 7775 7676 7576 7576 7675 7676 7576"
	$"7674 7675 7573 7475 7674 7473 74FE 730F"
	$"7273 7271 7273 7476 7574 7575 7672 7071"
	$"FD70 FE71 0C6F 6E6D 6E6D 6C6B 6A6B 6B6A"
	$"6B6B FE69 086A 6665 6664 6565 6464 FB62"
	$"FF63 1262 6162 6261 6160 5E5D 5D5F 5D5B"
	$"5C5C 5D5C 5D5B FE5A FF57 0090 FF91 0590"
	$"9190 8F90 90FB 9103 9291 9293 FD92 FF93"
	$"FF91 0292 9192 FC91 0390 9191 90FE 91FE"
	$"90FC 8F00 8EFE 8F09 9091 9190 8F90 8E8D"
	$"8C8C FE8D FC8C 028B 8A8A FD89 0788 8789"
	$"8887 8786 85FE 8404 8382 8182 82FC 8100"
	$"80FC 7F00 7EFE 7D00 7CFE 7BFE 7AFE 7800"
	$"77FD 7603 7576 CDC8 08C8 C6C8 C7C7 C9C8"
	$"C8C9 FCCA FFC8 01C9 C8FD C903 CAC9 C9CA"
	$"FEC9 FFC8 07C9 C8C8 C7C8 C7C8 C7FB C6FF"
	$"C50C C6C5 C5C6 C6C8 C7C6 C5C5 C4C3 C3FE"
	$"C219 C1C2 C2C0 C0C2 C1BF C0C1 C0BF BEBF"
	$"BDBC BCBD BCBD BCBA B9B9 BAB9 FDB8 FEB7"
	$"0CB6 B5B5 B6B6 B5B5 B4B3 B3B4 B2B0 FEB1"
	$"FFAF 0AB1 AFAF AEAE ADAC ABAC ABAC 0167"
	$"0376 7572 75FD 7609 7473 7677 7776 7677"
	$"7878 FC76 2975 7475 7677 7778 7776 7576"
	$"7674 7575 7373 7576 7675 7473 7274 7373"
	$"7273 7577 7877 7674 7375 7370 7172 72FE"
	$"6FFF 6E06 6F6C 6E6F 6E6C 6BFC 6A00 69FE"
	$"6805 6A68 6667 6765 FD64 0065 FE64 0363"
	$"6264 64FC 6302 6261 60FE 5EFF 5CFF 5E01"
	$"5C5D FE5C 035B 595A 92FC 91FF 90FD 9104"
	$"9091 9291 92F9 9302 9192 93FE 920B 9192"
	$"9190 9190 9192 9192 9191 FD90 0191 8FFE"
	$"9001 9192 FE91 1290 8F91 908D 8C8C 8E8D"
	$"8D8C 8C8B 8A8B 8A89 898A FE88 0089 FD87"
	$"0686 8585 8485 8484 FE83 FF82 0483 8180"
	$"8081 FE80 077F 807F 7D7E 7D7D 7CFD 7B0C"
	$"7A79 7A79 7876 7775 7675 76CE C8FF C7FE"
	$"C805 C9C8 C8C9 C9C8 FECA 15C9 CAC9 CAC9"
	$"CACA C9C9 C7C8 C9C8 C9C9 C8C9 C9C8 C8C7"
	$"C7FE C80E C7C6 C5C5 C7C6 C7C5 C6C7 C7C6"
	$"C7C6 C6FE C505 C4C5 C4C3 C4C4 FEC1 07C0"
	$"BFC1 C0BF C0C0 BFFD BEFD BD01 BCBB FEBA"
	$"13BB B9B7 B8B9 B8B5 B6B7 B6B4 B4B7 B5B3"
	$"B3B5 B3B1 B1FE B00E AFB0 B0AF AEAF AFAD"
	$"ADAB ACAB ABAA AB01 6B01 7877 FD76 0777"
	$"7676 7777 7877 77FE 7604 7779 7877 77FE"
	$"7508 7674 7476 7777 7574 74FE 7614 7573"
	$"7474 7576 7574 7676 7775 7474 7576 777A"
	$"7978 77FE 763C 7271 7070 7270 6F6D 6D6E"
	$"6D6C 6D6D 6C6C 6B6C 6C6B 6A6B 6B6A 6A69"
	$"6867 6667 6765 6667 6668 6564 6463 6465"
	$"6564 6262 6364 6362 6161 605F 6160 5F5C"
	$"5D5F 5EFE 5DFF 5C00 92FE 910A 9290 9191"
	$"9293 9193 9192 92FD 930E 9493 9493 9392"
	$"9393 9292 9192 9192 91FE 9207 9193 9392"
	$"9191 9290 F991 0092 FE93 0092 FE91 008E"
	$"FD8D 098C 8D8C 8B8C 8B8A 8A8B 8AFD 8900"
	$"88FC 87FF 86FF 8500 84FE 83FF 8201 8382"
	$"FE81 0580 7F80 807F 7FFE 7E02 7D7C 7CFE"
	$"7BFF 7A00 79FE 78FE 77FF 7601 CEC9 0BC6"
	$"C7C9 C9CA C9CA CAC9 CAC9 CAFE C9FD CA00"
	$"CBFD C9FC C817 C7C8 C8C7 C6C5 C5C8 C6C5"
	$"C6C7 C6C6 C5C4 C5C5 C4C5 C4C5 C6C5 FDC4"
	$"0CC3 C5C2 C1C3 C2C2 C1C1 C0C0 C2C1 FDBF"
	$"00BE FEBD 25BC BBBA BABB BBBA BBB9 B8B7"
	$"B6B7 B7B6 B4B3 B5B5 B4B5 B6B4 B1B2 B4B4"
	$"B1B1 B0B0 B2B1 B0B0 AFAE AFFE AD05 AAAB"
	$"ABAA A9A9 0160 FF77 0579 7877 7778 79FE"
	$"78FF 7901 7677 FD79 FF78 FD77 0778 7776"
	$"7777 7676 75FD 76FF 7724 7674 7576 7475"
	$"7675 7673 7274 7476 787A 7978 787A 7874"
	$"7372 7070 7271 6F70 6E6E 706F 6F6E 6EFD"
	$"6D14 6E6D 6C6B 6A69 6B69 6868 6969 6867"
	$"6668 6867 6465 64FE 6500 64FE 63FF 64FF"
	$"6307 6261 6061 605E 5C5D FE5E 045D 5C5C"
	$"5D94 FF93 FD92 FD93 0394 9593 93FE 94FF"
	$"93FF 9401 9395 FE94 0693 9493 9292 9393"
	$"FD92 FE93 FE92 0391 9292 93FE 9201 9091"
	$"FE94 FE93 0391 908F 8EFC 8DFE 8C02 8D8B"
	$"8BFE 8AFC 8901 8786 FE87 0686 8785 8584"
	$"8382 FD83 1E81 8282 8180 8180 8180 807F"
	$"7E7D 7E7D 7C7B 7C7C 7B7A 7978 7877 7677"
	$"7677 CDCA FFC9 0CC8 C9CA CAC9 CACA CBCB"
	$"C8C9 CBCB FDCA 06CB CACB CAC9 C8C7 FCC8"
	$"00C7 FDC8 02C7 C4C4 FDC6 1AC5 C4C6 C6C4"
	$"C4C5 C4C6 C5C5 C3C5 C6C5 C3C1 C1C3 C1C2"
	$"C1C0 C0BF C0C0 FDBD FEBE 01BD BBFD BAFF"
	$"B9FD B801 B6B7 FEB5 06B3 B4B3 B4B4 B5B3"
	$"FEB2 04B0 B2B1 B1AF FEB0 FFAE 04AD AEAE"
	$"ADAB FEAA FEA8 0166 097C 7978 797A 7B7C"
	$"7A7A 79FD 7AFF 7B18 7A79 7978 7779 7A7A"
	$"7979 7A79 797A 7978 7879 7A79 7677 7A79"
	$"77FE 7812 7775 7677 7677 7776 7778 7A7B"
	$"7B7A 7979 7674 74FE 730C 7271 7271 7170"
	$"7172 7170 6F6F 6EFE 6DFD 6C0D 6D6C 6C6B"
	$"6A6B 6768 6969 6868 6765 FD66 FE65 0064"
	$"FE65 0264 6362 FE61 0A60 5F60 5F5E 5F5D"
	$"5E5D 5D96 0493 9493 9493 FD94 0795 9495"
	$"9494 9594 94FD 9509 9495 9594 9594 9595"
	$"9494 FE93 FF94 0193 94FD 9305 9293 9192"
	$"9291 FD92 FD94 FE93 0091 FC8F 0F8E 8D8D"
	$"8C8C 8D8C 8C8B 8A8B 8B89 8A89 89FE 88FF"
	$"87FF 8606 8786 8783 8485 84FE 8204 8382"
	$"8281 82FE 8102 807F 7FFE 7E00 7DFE 7C05"
	$"7B7A 7979 7879 FD77 01CD C711 C9C8 C7C8"
	$"CBC9 C8C9 CBCA CAC8 C8C9 CBCA C8C8 FDC9"
	$"FFC7 0BC9 C7C7 C8C7 C7C6 C4C6 C6C5 C5FE"
	$"C6FF C7FD C502 C7C6 C4FE C509 C6C5 C4C4"
	$"C3C3 C4C2 C1C1 FEC0 02BF BEBF FCBE 00BD"
	$"FEBC 0EBA BBBB BABB BAB9 B8B9 B8B7 B8B6"
	$"B8B4 FEB5 FEB3 FFB2 02B3 B2B3 FEB1 FEB0"
	$"FEAF 00AD FEAC FFAD 00AB FEA9 FDA8 015E"
	$"047D 7B79 7B7B FE7C 0C7D 7C7B 7B7C 7E7E"
	$"7D7A 7B7A 7979 FD7B FF7C 097A 7B79 7A7B"
	$"7B7A 797A 7BFC 7A16 7B7A 7A78 7879 7978"
	$"787B 7878 797B 7D7C 7978 7774 7577 75FE"
	$"74FF 73FF 72FF 73FF 72FE 70FD 6FFF 6DFF"
	$"6E02 6D6C 6DFD 6B03 6A69 6869 FC68 FD67"
	$"FF66 0365 6466 65FE 6306 6160 6160 6160"
	$"5EFE 5D01 5E96 0095 FE94 0096 FE94 FD95"
	$"FE96 0594 9695 9695 96FE 95FF 9603 9496"
	$"9494 FE95 0294 9595 FA94 0093 FD92 0593"
	$"9293 9292 93FE 94FF 9300 92FE 8F08 908F"
	$"8E8D 8C8D 8C8D 8DFE 8CFF 8BFE 8A05 8889"
	$"8889 8988 FE87 FF86 FF85 FF84 0082 FE83"
	$"0F82 8382 8181 8080 7F7F 807E 7E7D 7C7C"
	$"7BFE 7AFE 7906 7879 7877 77CD C906 CAC7"
	$"C7C8 C9C8 C7FD C80B C9CA C9C7 C8C7 C8C8"
	$"C9C9 C8C6 FDC8 FDC7 09C6 C5C5 C6C5 C5C6"
	$"C6C5 C5FD C4FE C3FF C405 C3C4 C5C4 C4C3"
	$"FEC2 07C0 C1C2 C0BF BFBE BDFD BEFE BDFF"
	$"BC00 BBFD BAFD B805 B7B5 B6B7 B7B6 FEB5"
	$"02B3 B4B4 FDB3 FEB2 00B1 FEB0 02AF B0AE"
	$"FEAD 02AC ABAB FEAA 04A8 AAAA A8A8 0171"
	$"FF7C 047D 7C7A 7B7C FE7D 1A7C 7B7D 7F7E"
	$"7F7C 7D7D 7B7C 7B7B 7D7C 7D7B 7C7B 7A7B"
	$"7C7D 7C7B 7B7C FD7B FF7A FF7B FF7A FF7B"
	$"FF79 077A 7979 787C 7B79 77FE 76FF 75FF"
	$"7603 7374 7475 FE73 FF72 0271 7272 FE71"
	$"FF70 0B6F 6E6E 6D6D 6E6C 6D6C 6D6C 6BFE"
	$"6A02 6968 6AFE 68FF 67FF 6605 6867 6566"
	$"6663 FC62 0060 FE5F 045D 5F5E 5E96 0296"
	$"9596 FE95 FF94 FE95 FF96 0494 9697 9796"
	$"FE97 0096 FE97 0295 9696 FE95 0094 FE95"
	$"1896 9594 9495 9594 9493 9595 9493 9493"
	$"9392 9393 9494 9392 9291 FE90 018F 90FC"
	$"8E07 8D8E 8D8C 8B8B 8C8B FD8A 0089 FD88"
	$"0E89 8787 8686 8584 8485 8483 8283 8382"
	$"FE81 FF80 FE7F 047D 7E7D 7D7C FE7B 097A"
	$"7978 7978 7977 77CB C704 C8C7 C7C6 C7FC"
	$"C803 CACB C9CA FEC7 06C8 C9C8 C7C6 C7C9"
	$"FDC7 00C8 FEC6 15C5 C6C7 C6C3 C3C4 C5C4"
	$"C6C4 C3C3 C2C4 C4C3 C3C2 C3C3 C4FE C200"
	$"C1FE C00B C1BF BFBE BFBE BEBD BBBD BEBD"
	$"FDBC FFBB 06BA B9B7 B9B8 B6B5 FEB6 0BB5"
	$"B4B5 B4B4 B3B2 B4B3 B3B1 B1FE B200 B1FE"
	$"B00C AFAE ADAD ACAC ABAB ADAB AAA9 A9FD"
	$"A801 6205 7E7C 7D7D 7B7C FE7D FF80 1781"
	$"8080 7E80 7F7E 7F7D 7E7D 7E7F 7F7E 7E7F"
	$"7E7D 7D7C 7E7D 7DFE 7B08 7C7D 7B7A 7B7B"
	$"7C7C 7BFD 7AFE 7904 7A79 7B7A 78FD 7702"
	$"7879 78FC 7600 74FD 72FF 73FF 72FF 6F03"
	$"716F 706F FE6D FE6C 136B 6A6B 696A 6C6A"
	$"696A 6868 6768 6766 6866 6766 67FE 650C"
	$"6465 6262 6362 6260 5F5D 5E5F 9710 9796"
	$"9695 9596 9594 9797 9896 9896 9898 97FE"
	$"9802 9798 98FE 9703 9897 9898 FE97 FF96"
	$"0795 9694 9696 9595 94FD 95FC 94FC 93FF"
	$"9202 9192 91FE 9001 8E8F FC8E FF8D FF8C"
	$"FE8A 0289 8A8A FB88 0886 8787 8584 8583"
	$"8384 FE83 FF82 0083 FD81 FF80 0A7F 7E7D"
	$"7D7C 7D7C 7A7B 7A79 FE78 FF77 0278 CBC6"
	$"1BC8 C7C6 C6C8 C7C7 C9C9 C8C7 CAC8 C9C9"
	$"C8C7 C5C8 C8C9 C8C6 C7C6 C6C7 C7FE C603"
	$"C5C3 C5C5 FDC4 FFC5 02C4 C2C1 FEC3 FEC2"
	$"12C3 C2C3 C2C2 C0C1 C1BD BDBF C0BF BCBC"
	$"BFBE BEBC FEBB 02BC BBBA FEB8 0BB7 B8B8"
	$"B7B6 B5B3 B4B6 B7B6 B4FD B509 B2AF B0B1"
	$"B2B1 B1B2 B1B2 FDB0 01AF AEFD AD04 ACAB"
	$"ABAA A8FB A701 6400 81FC 7FFF 8004 7E7F"
	$"8182 7FFC 8000 7FFD 80FE 81FE 8005 7F7E"
	$"7F80 7F7F FA7D 157C 7E7D 7D7B 7B7C 7B7C"
	$"7B7B 7A7A 797A 7B7A 7A79 797A 79FE 7824"
	$"7573 7475 7574 7374 7473 7272 7171 7071"
	$"7170 7170 706F 6C6C 6B6B 6C6B 6A6B 6C6A"
	$"6969 6A69 67FE 6905 6869 6867 6866 FD65"
	$"0A63 6263 6362 6160 5E5F 6197 0B97 9696"
	$"9596 9796 9798 9899 96FE 9802 9798 98FE"
	$"9904 9897 9898 97FE 98FF 9702 9897 97FD"
	$"96FF 97FF 950F 9695 9594 9495 9394 9493"
	$"9493 9391 9290 FE92 FF91 FE90 FE8E FF8F"
	$"0A8E 8D8E 8D8C 8B8A 898A 8B8A FC88 0387"
	$"8687 86FE 85FF 8301 8483 FD82 0D83 8280"
	$"8181 807F 807F 7D7D 7B7C 7CFD 7A07 7978"
	$"7877 7778 CCC6 FDC7 24C8 C7C8 C8C9 C9C6"
	$"C7C6 C9C9 C7C7 C8C7 C6C5 C4C4 C5C4 C4C6"
	$"C6C5 C5C6 C3C4 C5C3 C1C2 C3C2 C4C2 FEC3"
	$"02C2 C3C4 FDC1 06C2 C1C1 BFBF C0C0 FDBD"
	$"01BC BBFD BD0F BBB9 B9BB BCBA B9B8 B8B7"
	$"B8B7 B8B6 B4B3 FEB4 04B3 B4B3 B4B4 FEB3"
	$"03B1 B0B1 AFFC B002 B1B0 ADFD AC06 AEAC"
	$"ABAB A9AB AAFD A602 A4A3 A501 5305 8380"
	$"807E 7F7F FA80 FF81 0F82 8081 8082 8382"
	$"8181 8281 7F7F 807F 7CFE 7FFE 8006 7F7D"
	$"7D7E 7E7D 7EFE 7CFF 7D0E 7C7A 7B7C 7B7A"
	$"7A79 7B79 7878 7979 78FE 77FF 760B 7776"
	$"7575 7475 7474 7174 7372 FD71 0070 FE6F"
	$"FF6E 0F6D 6B6A 6A6B 6C6B 6B69 6A69 6767"
	$"6868 69FE 6801 6766 FC65 FF63 0062 FE61"
	$"FF5F FF5E 0097 FC96 0A97 9697 9798 9797"
	$"9898 9999 FD98 0699 9898 9999 9898 FE97"
	$"0198 97F8 9602 9596 93FE 94FF 9500 94FE"
	$"93FF 9201 9192 FE91 0290 9190 FE8F FD8E"
	$"FF8D FE8C FE8B FF8A FE89 FE88 FD87 0385"
	$"8685 85FE 8405 8381 8383 8282 FE81 0080"
	$"FE7F 067E 7D7D 7B7B 7A7A FE79 0778 7977"
	$"7776 77CA C30E C6C5 C6C5 C5C6 C7C5 C6C8"
	$"C8C6 C4C7 C5FD C6FF C400 C5FC C407 C6C4"
	$"C5C4 C5C5 C3C3 FCC2 06C0 C3C4 C3C0 C1C2"
	$"FCC0 FFBF FFBE FCBD 00BC FBBB 08BA B9B9"
	$"BABB BAB9 B7B7 FEB6 FEB4 FDB3 FEB2 00B3"
	$"FDB0 0BAE AFAE AEAF AFAE ADAD AEAE ACFD"
	$"AB0D ACAA A9A8 A8A9 A9A6 A5A5 A3A5 A4A2"
	$"0166 0283 8282 FE81 1282 8080 8181 8082"
	$"8281 8381 8283 8583 8281 8182 FD81 FF80"
	$"FF7F 0280 8182 FD80 137E 7C7C 7E7D 7C7D"
	$"7E7D 7C7B 7D7D 7C7B 7A7B 7C79 78FD 7A11"
	$"797A 7977 7877 7876 7575 7474 7574 7473"
	$"7272 FE71 FF70 176E 6D70 6F6E 6D6B 6A6B"
	$"6B6C 6D6B 6A6A 6B6A 6968 696A 6867 65FE"
	$"6604 6564 6263 61FE 6005 615F 5F5E 5D97"
	$"FF97 FE96 0098 FE97 0798 9799 9998 9A99"
	$"99FE 9806 9997 9899 9898 97FE 9814 9798"
	$"9897 9697 9596 9796 9695 9593 9494 9394"
	$"9493 93FA 92FE 9008 918F 8F90 8F8E 8E8D"
	$"8EFE 8D00 8CFD 8BFE 8AFF 8902 8887 88FE"
	$"8704 8685 8485 84FD 83FF 8203 8182 8281"
	$"FE80 0E7F 7E7D 7E7D 7D7C 7B79 7978 7979"
	$"7677 FE76 0275 C7C3 0EC4 C2C3 C3C4 C2C4"
	$"C6C6 C5C6 C5C4 C5C3 FEC5 FFC4 02C5 C4C3"
	$"FBC4 00C3 FEC2 FEC1 04C2 C1C2 C1BF FAC0"
	$"FFBF FFBE 02BD BEBE FDBD 08BC BDBD BBBC"
	$"BCBA B9B8 FEB9 00B8 FDB7 02B8 B6B5 FBB4"
	$"00B3 FEB2 0FB0 B1B1 B0B0 AFAF B0AE ADAD"
	$"AEAE ADAC ACFE AB02 AAAB AAFE A8FF A6FE"
	$"A505 A4A5 A3A2 A1A1 0159 1A84 8383 8281"
	$"8182 8181 8283 8384 8482 8384 8381 8384"
	$"8382 8283 8280 FA81 0D82 807E 8080 7E7E"
	$"7F80 7D7F 7E7C 7CFE 7D07 7E7D 7E7E 7C7B"
	$"7C7B FD7A 0879 7A7A 7977 7776 7776 FD75"
	$"0574 7374 7372 72FD 7117 6F70 706F 6E6E"
	$"6D6E 6C6B 6D6C 6A69 6A69 696A 6A69 6769"
	$"6867 FE66 0764 6362 6162 6261 60FE 5FFE"
	$"5E00 97FE 97FF 9602 9897 97FE 9801 999A"
	$"FD99 FF98 0099 FE98 FF99 FA98 FE97 FE96"
	$"0695 9695 9594 9595 FD94 FE93 FF92 0293"
	$"9292 FE91 FB8F FF8E FE8D FF8B 028D 8C8B"
	$"FD8A FF89 FE88 0787 8686 8586 8583 84FD"
	$"8302 8281 82FD 81FF 7F02 807F 7EFE 7DFF"
	$"7B05 7A79 7978 7777 FD76 0375 74C8 C300"
	$"C4FE C2FF C3FF C4FF C500 C4FE C504 C4C5"
	$"C3C3 C4FD C300 C4FE C2FF C008 C1C0 C0C3"
	$"C1BE C1C0 C0FE BF07 BEC0 C0BF BFC0 BFBF"
	$"FDBE FFBD 03BE BDBC BCFC BB06 BAB9 B8B7"
	$"B8BA B8FD B6FF B501 B4B5 FCB4 02B3 B2B1"
	$"FDB0 01AF AEFE AF07 AEAD AEAD ACAD ADAC"
	$"FEAA 0BA9 A8A9 A9A7 A7A6 A5A5 A4A3 A3FD"
	$"A2FF A101 5B04 8785 8582 81FD 8200 83FE"
	$"85FE 8301 8483 FE82 FD83 0082 FD81 FF80"
	$"0281 8281 FD80 037E 7F80 7FFE 7E02 7F7D"
	$"7DFE 7C06 7A7C 7E7C 7A7C 7CFE 7A0F 7978"
	$"7879 7877 7776 7576 7775 7573 7474 FE73"
	$"FD71 0A70 6F6F 6E6E 6C6B 6D6C 6C6B FE6A"
	$"FF69 0B68 6968 6768 6867 6666 6565 64FE"
	$"6306 6261 6061 5F60 5EFD 5D00 98FF 97FF"
	$"9601 9897 FB98 FF99 FF98 FF99 FF98 FE99"
	$"0498 9797 9898 FC97 0796 9596 9695 9696"
	$"95FE 9403 9594 9394 FE93 0094 FE93 0192"
	$"91FE 9004 8F8E 8E8F 8FFE 8E05 8D8C 8C8B"
	$"8B8C FE8B FE8A 0888 8788 8887 8686 8585"
	$"FE84 FE82 FF81 FC80 007F FE7E FE7D FF7C"
	$"027B 7A79 FE78 FF77 0375 7675 74FE 7301"
	$"C8C1 06C3 C2C3 C3C1 C3C2 FBC3 FFC4 FFC3"
	$"FEC2 0AC1 C0C0 C1C3 C1C2 C0BF C0BF FEC1"
	$"FFC0 FDBF FFBE FFBD 0FBE BDBE BEBD BDBC"
	$"BDBD BBBB BCBA BABB BAFD B9FD B8FF B7FF"
	$"B60D B5B4 B6B5 B4B4 B5B3 B2B3 B2B3 B2B1"
	$"FEAF 01B0 AEFC ADFC AC00 ABFE AAFE A8FE"
	$"A7FF A60B A5A4 A4A3 A3A2 A2A1 A2A1 A09F"
	$"0157 1686 8484 8381 8284 8384 8483 8283"
	$"8585 8482 8382 8383 8482 F981 FF80 1081"
	$"8280 807E 7F80 8180 7F7E 7D7D 7E7E 7D7C"
	$"FE7D FF7C FF7B 037D 7B79 79FB 780E 7776"
	$"7675 7576 7574 7372 7070 7172 71FE 6FFF"
	$"6EFF 6D00 6CFE 6BFF 6AFF 6811 6968 6768"
	$"6766 6665 6667 6765 6564 6462 6162 FE61"
	$"0960 5F5E 5E5B 5B5D 5C5A 98FF 9701 9896"
	$"FE97 FC98 0297 9897 FE98 0297 9898 F797"
	$"FC96 0795 9495 9593 9394 94FB 93FE 92FE"
	$"91FC 900D 8F8E 8D8E 8E8D 8C8B 8C8B 8C8A"
	$"898A FE89 0288 8787 FE86 FF85 FF84 FE83"
	$"FF82 1381 807F 807F 7E7F 7E7D 7D7C 7D7D"
	$"7C7C 7B7A 7A79 78FE 7704 7675 7673 73FE"
	$"7203 7172 C6C0 00C1 FDC2 13C0 C1C2 C2C3"
	$"C5C4 C4C3 C2C2 C1C0 C1C2 C1C0 C0C1 C1FE"
	$"C004 BFBE BFC1 C0F9 BF06 BDBA BCBE BDBB"
	$"BAFD BB04 BAB8 B8BB BBFE BA0B B8B6 B7B8"
	$"B7B7 B6B7 B5B2 B3B4 FEB3 FEB2 0EB3 B1B1"
	$"B2B1 B1B0 AEAE AFAE ACAD ACAC FEAB FFAA"
	$"FEA9 01A8 A7FD A900 A7FE A500 A4FD A3FF"
	$"A2FF A004 9E9D 9F9E 9E01 6807 8483 8381"
	$"8182 8382 FC83 0A84 8385 8282 8381 8182"
	$"8182 FD81 1080 8181 7F80 8081 7F80 807E"
	$"7F7F 7E7D 7C7C FD7D FF7C 027B 7A7A FE7B"
	$"077A 7977 7877 7675 75FE 7605 7574 7372"
	$"7273 FE71 FF70 FE6F 116E 6C6C 6B6C 6B6B"
	$"6A68 6A69 6868 6666 6867 66FE 65FE 6400"
	$"66FE 6411 6362 6060 6160 5E5F 605F 5D5D"
	$"5C5A 5B5A 5A97 0097 FD96 1297 9695 9697"
	$"9897 9796 9798 9897 9696 9796 9697 FD96"
	$"FF97 FF96 0695 9694 9695 9494 FD93 FD92"
	$"1093 9292 918F 9091 9090 8F8F 8E8F 8E8E"
	$"8D8B FE8C 008B FC8A FF88 FE87 0785 8686"
	$"8584 8483 83FE 82FF 8100 80FE 7FFF 7EFF"
	$"7D03 7C7B 7C7C FE7B 007A FE79 0178 77FE"
	$"7603 7574 7373 FE72 FD70 01C4 BD00 C0FD"
	$"C105 BFC1 C3C2 C1C1 FEC2 FFC1 19C2 C0C1"
	$"C1C0 C2C2 C0BF C0BF C0BE BCC0 BFBE BDBC"
	$"BCBD BEBE BCBC BDFE BC12 BAB9 B7BA BBBA"
	$"B9B8 B8B6 B8B9 B8B8 B7B4 B4B6 B6FC B403"
	$"B1B2 B4B2 FEB1 FFB0 01B1 AFFE AE07 ADAE"
	$"ABAB ACAB ACAB FDA9 FEA8 00A7 FDA6 0FA5"
	$"A6A5 A6A6 A4A3 A3A2 A1A1 A09E 9F9F 9EFC"
	$"9D00 9C01 6D05 8283 8382 8283 FD82 0F83"
	$"8281 8284 8384 8382 8184 8381 8182 81FE"
	$"82FF 7F03 7E7F 807E FE7F 147D 7C7B 7C7D"
	$"7C7C 7E7D 7D7A 7A7B 7A79 797A 7C78 7778"
	$"FE76 0975 7473 7475 7473 7372 71FE 70FF"
	$"6F1B 706F 6E6E 6D6B 6D6C 6B6B 6A6B 6A69"
	$"6A68 6867 6868 6766 6465 6566 6462 FC63"
	$"FF61 0460 5F5F 5E5C FE5B 075A 5959 5757"
	$"5455 9600 96FE 95FE 9400 95FC 9602 9796"
	$"97FE 960E 9796 9595 9694 9495 9594 9493"
	$"9493 93FE 9204 9392 9392 92FE 9101 9091"
	$"FD90 028E 8F8F FD8E 088D 8C8B 8A8B 8B8A"
	$"8B8A FE88 FC87 FE85 0284 8584 FE83 0581"
	$"8081 817F 7EFE 7F00 7EFE 7DFE 7CFF 7B06"
	$"7A79 7A7A 7978 78FE 770F 7574 7371 706F"
	$"6F6E 6D6D 6B6B 6A6A C3BD FFBE FCBF FFC1"
	$"FFBF 07C0 C1C0 C1C1 C0BE BFFE BD0C BEBD"
	$"BEBE BDBC BBBB BEBD BCBD BDFE BC08 BDBC"
	$"BCBB BABB BABA B9FE BA03 B9B8 B7B8 FEB7"
	$"0BB5 B6B5 B4B3 B3B4 B3B2 B4B2 B3FE B206"
	$"B1B0 AEAF ADAD AFFE ADFE ACFF AB04 AAA9"
	$"A9A8 A9FE A8FD A70A A6A7 A5A5 A3A3 A4A5"
	$"A5A4 A3FE A10B A09F 9D9C 9C9B 9999 9697"
	$"9696 016F FF81 1982 8080 7F81 8382 8181"
	$"8081 8282 8081 8081 8081 8280 7F7F 807F"
	$"80FE 7FFE 7E11 7D7C 7D7E 7D7C 7B7C 7C7B"
	$"7C7C 7A7A 7B79 787A FD79 FF78 FE76 0075"
	$"FC74 0175 73FE 70FE 6FFF 6E32 6C6A 6B6A"
	$"6968 6867 6765 6161 6262 5F5F 5D5C 5B5A"
	$"5A58 5657 5553 5250 4F4E 4D4D 4C4B 4A49"
	$"4847 4544 4442 413F 3D3C 3938 3836 9402"
	$"9392 93FE 92FF 940C 9394 9393 9595 9495"
	$"9594 9594 94FE 9306 9493 9392 9393 91FE"
	$"9209 9190 9192 9190 9091 9090 FD8F FE8E"
	$"FD8D 038C 8D8C 8CFC 8BFF 8A02 8987 87FE"
	$"86FF 8535 8483 8280 8180 7F7E 7C7C 7B7A"
	$"7978 7776 7473 7272 706E 6D6D 6A6B 6967"
	$"6665 6564 6362 615F 5E5D 5B59 5756 5553"
	$"5251 504F 4C4C 4A4A C2BD FEBD FEBE 03BD"
	$"BEBF BFFD BD00 BFFD BE0C BDBC BDBC BBBB"
	$"BCBC BABB BAB9 B9FE BAFF B8FF BAFF B901"
	$"B8B9 FDB8 FFB6 22B7 B5B7 B6B6 B5B4 B4B5"
	$"B4B5 B5B3 B3B1 B1B2 B1AF B0B1 B0AE AEAC"
	$"ADAC AAAA A9A9 A8A5 A5A4 FEA2 10A1 9E9C"
	$"9C9B 9997 9897 9593 9492 908E 8D8C FE89"
	$"1188 8785 8382 817E 7C7A 7776 7575 7471"
	$"716F 6E01 770B 807E 7E7D 7D7F 8081 807F"
	$"7E7F FE80 0681 7F81 7F80 7F7F FE7D FF7E"
	$"FD7D 067C 7D7C 7B7D 7C7B FE7A FF79 FF78"
	$"0977 7574 7472 7170 706F 6CFE 6AFF 671D"
	$"6967 6361 625F 5F5E 5C5A 5C59 5656 5553"
	$"514E 4D4D 4C4B 4948 4847 4645 4342 FE41"
	$"1A40 3F3E 3D3C 3B39 393A 3838 3736 3736"
	$"3837 3635 3735 3433 3434 3331 FE2F 042E"
	$"2D2F 2E91 0691 9091 9192 9293 FE92 0793"
	$"9293 9392 9293 92FD 93FF 9205 9392 9392"
	$"9393 FD91 4790 8F90 8F8F 8E8E 8D8C 8C8A"
	$"8A89 8987 8585 8484 8381 7F7F 7E7C 7C7B"
	$"7A78 7675 7573 7270 6E6E 6C6A 6967 6664"
	$"6261 605F 5D5C 5C5A 5958 5656 5554 5353"
	$"5250 4F4E 4E4D 4C4C 4B4B 4A4A 4BFE 4A0A"
	$"4947 4846 4645 4445 4444 43FE 42FE 4101"
	$"C0BA 12BD BCBC BBBC BBBA BCBD BDBA BDBD"
	$"BEBD BCBD BCBB FEBC FFBB 00BA FBB9 3DB6"
	$"B9B9 B7B7 B6B7 B5B4 B4B3 B2B1 B2B2 B0AF"
	$"ADAD ACA9 A7A7 A8A7 A5A4 A4A2 A2A1 9F9C"
	$"9B9A 9896 9594 9190 8E8C 8B89 8887 8685"
	$"8280 807F 7D7C 7A79 7877 7675 74FD 7207"
	$"706E 6E6C 6C6A 696A FE69 1068 6768 6666"
	$"6563 6463 6261 6261 6160 605F 016B 0380"
	$"7C7B 7CFD 7D01 7A7B FC7A FF78 247C 7976"
	$"7572 7372 7070 6E6C 6D6C 6C69 6967 6465"
	$"6360 605F 5E5D 5D5A 5857 5654 5253 524F"
	$"504F FE4C FD4B 0049 FD48 1C47 4644 4445"
	$"4444 4343 4142 4041 413F 3F3E 3E40 3F3F"
	$"4040 3D3C 3D3B 3A3B FE3C 043A 3936 3A3C"
	$"FD3A 143C 3B39 3839 3A38 383A 3839 3837"
	$"3736 3838 3535 368F 0090 FD8F 018E 8FFD"
	$"8EFF 8DFF 8C28 8A8B 8B88 8988 8685 8483"
	$"8280 807E 7D7C 7D7B 7878 7676 7474 7370"
	$"6F6C 6B6B 6A68 6767 6664 6463 6361 60FE"
	$"5F03 5E5D 5C5C FD5A FF59 0058 FD57 FB55"
	$"FF54 FF53 0351 5252 53FE 51FF 5005 4F4E"
	$"4E50 4E4F FC4D FE4B 144C 4B4B 4A4B 4949"
	$"4A49 4847 4848 4545 4744 4445 BEB7 06B8"
	$"B9B8 B6B7 B9B7 FEB8 FFB7 FFB6 28B5 B4B1"
	$"AEAF AEAE ADAC ABAA A7A6 A4A2 A1A2 A09E"
	$"9F9D 9B99 9897 9393 9291 8F8E 8D8C 8B8A"
	$"8887 8585 8383 FD82 177E 7D7E 7D7D 7C7C"
	$"7979 7A7A 7878 7977 7775 7577 7775 7474"
	$"73FD 72FF 7000 71FD 7007 6E6F 6D6E 6B6D"
	$"6D6B FE6C 136D 6C6A 6B69 6967 6765 6467"
	$"6363 6665 6363 6161 6201 7403 6863 6060"
	$"FE5F 085D 5B5D 5C5D 5B5A 5759 FE58 0456"
	$"5754 5354 FE53 FE51 284F 5151 4F4D 4E4D"
	$"4B4C 4C4D 4E4D 4C4C 4B4B 4C4B 4A4E 4D4B"
	$"494A 494B 4A4A 494B 4B48 4749 4846 4745"
	$"4344 FD45 1444 4343 4140 403F 3D40 4140"
	$"413F 403E 3E3C 3C3D 3C3A FE3B FF3A 1339"
	$"3A3C 3938 3A3B 3B39 393B 3B3A 3737 393B"
	$"3D3A 38FE 3603 3433 3477 0C77 7575 7373"
	$"7270 6F6F 6E6D 6C6D FE6B 066A 6B6A 6A69"
	$"6767 FE66 0664 6565 6464 6363 FE62 FF60"
	$"1A61 6261 605F 6161 5F60 605E 6160 5F5E"
	$"5E5F 615E 5E5D 5E5E 5C5B 5D5D FE5A 0159"
	$"57FC 5820 5657 5654 5353 5154 5654 5453"
	$"5351 5351 5251 504F 504F 4E4E 4F4C 4D4E"
	$"4C4B 4B4C 4BFE 4DFF 4C0E 494A 4C4A 4B4B"
	$"4A46 4647 4544 43A3 9B03 9B9A 9997 FE96"
	$"0495 9494 9392 FE8F FE8E 0A8F 8E8D 8A88"
	$"8989 8685 8484 FE85 0283 8584 FC83 0282"
	$"8182 FD81 107E 817F 7D7D 7E7F 817E 7E7D"
	$"7E7D 7B7B 7D7D FD7A 0479 7878 7978 FE76"
	$"1274 7373 7271 7474 7374 7374 7372 7071"
	$"716F 6E6E FD6D FF6C 006D FC6C FF6D 0F6B"
	$"6A69 6868 696A 6C6A 6968 6666 6462 6301"
	$"7809 504F 5152 5354 5350 5152 FE51 FE52"
	$"1751 5255 5150 5152 5151 5251 5051 514E"
	$"5050 5152 4E4E 4F51 4FFE 5000 51FD 4F21"
	$"514D 4C4C 4A4A 4B4A 4A4C 494B 4B49 4645"
	$"4646 4545 4342 4443 4242 443F 3D3D 3F3D"
	$"3E3F FE3E 0C3F 3E3E 373D 3A38 393B 3939"
	$"3836 FE37 1A36 3537 3636 393B 3A37 3837"
	$"3839 3635 3637 3636 3533 3131 3031 3363"
	$"0862 6464 6365 6462 6263 FD64 0766 6464"
	$"6566 6465 65FE 6401 6665 FC64 2163 6463"
	$"6263 6263 6261 6362 6362 6261 5F61 5F5F"
	$"615F 6060 5F5F 605D 5E5E 5D5B 595A 5AFE"
	$"591D 5657 5556 5558 5553 5356 5352 5452"
	$"5355 5452 534C 504F 4D4D 4E4D 4D4B 4A4B"
	$"FE4C FF49 034A 494A 4BFE 4A11 4948 4948"
	$"4849 4846 4745 4544 4343 4446 8A84 0887"
	$"8585 8787 8886 8685 FE86 0B87 8685 8688"
	$"8687 8988 8885 86FC 8404 8583 8484 82FE"
	$"85FF 8216 8382 8281 8280 8082 8081 817C"
	$"7F80 7E7E 817F 7F7E 7B7A 7BFD 7C16 7B78"
	$"7876 7776 7874 7373 7674 7473 7173 7674"
	$"7173 6C71 6EFE 6D12 6C6D 6967 6B6B 6C6C"
	$"6969 6A69 6B6C 6B6B 6C6A 69FE 6A0A 6B6A"
	$"6767 6566 6462 6364 6601 7B06 504C 4F53"
	$"5453 53FE 5216 5453 5351 5555 5654 5457"
	$"5553 514F 4D51 5250 544F 5151 50FD 4FFF"
	$"4D18 5350 4F4D 4D4B 514D 494C 4849 4644"
	$"4446 4741 4444 454C 4646 4BFE 491C 4841"
	$"4345 4340 3B41 3E3D 3C3A 3C3B 3E3E 3A3B"
	$"3A39 3C3B 3A3B 3B3D 3E3C 3BFE 3908 373A"
	$"3A39 3938 3A3C 39FE 3810 3639 3A39 3A37"
	$"3839 3637 3736 3634 3335 650E 6364 6364"
	$"6364 6566 6566 6566 6568 65FE 66FF 6803"
	$"6663 6463 FE64 4067 6264 6463 6362 6363"
	$"6261 6462 6361 605D 635F 5A5C 5D5E 5C59"
	$"595B 5B55 5859 5C61 5A5B 625F 5E5D 5D56"
	$"5556 5453 5157 5352 5351 5251 5452 4F52"
	$"5250 504F 4E4F 504F FE50 FF4E 0E4F 4E4E"
	$"4C4D 4E4D 4D4F 4C4C 4B4C 494B FE4D FF4B"
	$"044C 4949 4847 FE46 0247 8A84 FF85 FF86"
	$"FD88 0A89 8889 878A 8887 8887 8989 FE87"
	$"FE84 1782 8782 8385 8484 8382 8283 8283"
	$"8284 8181 7F82 7D7B 7D7E 81FE 7CFF 7B22"
	$"777A 7A7D 877D 7A85 807F 7F7E 7576 7674"
	$"7271 7673 7172 7373 7173 7270 7473 7070"
	$"6D6E 6FFD 7003 726F 6E6F FE6E 056F 706F"
	$"6E6F 6CFE 6D01 6A6B FE6E FF6D 086E 6A69"
	$"6968 6766 6667 017F 494E 4B4B 4F50 4E4D"
	$"4E4D 4E51 5250 4E50 4F51 4E50 514F 4F4D"
	$"4C4A 4B4C 4C4E 4D4E 4D4B 4B49 4C4C 484C"
	$"4D4B 494A 4948 4648 4747 484A 474B 464A"
	$"5152 5054 5554 4A4B 4F47 4346 4442 4146"
	$"4343 42FE 412A 403D 3E3E 3C3E 3A3B 383B"
	$"3A3B 3C3D 3A3D 3E3C 3B3A 393B 3B39 3A3A"
	$"3839 3A38 383C 3C3B 3A39 3737 393A 3637"
	$"39FE 3704 3637 3637 6202 6160 5FFE 6109"
	$"6261 6163 6562 6063 6064 FE62 0363 6460"
	$"62FD 5EFF 61FF 6005 5C5D 5D5F 605D FE60"
	$"245E 5F5D 5C5D 5E5C 5A5A 5B5A 5F5C 5F65"
	$"6664 686A 6A61 6164 5D5B 5D58 5758 5C5A"
	$"5858 5A58 5656 FE53 0452 5350 5250 FE51"
	$"2752 5350 5356 5352 5150 504F 4C4D 504F"
	$"4F50 4D4D 4E4E 4F4E 4E4C 4B4C 4C49 4A4C"
	$"4A49 4A49 4A47 4986 8102 8281 82FE 830F"
	$"8283 8788 8581 8381 8583 8484 8383 8283"
	$"FE7E 0D7D 8082 827F 7C7E 7D80 807D 8080"
	$"7FFE 7E03 7D7C 7E7D FE7B 4B79 807D 7F87"
	$"8984 888B 8E83 8084 7F7D 7E7A 7779 7E7C"
	$"7A7B 7A79 7978 7675 7472 7370 716F 7372"
	$"7274 7472 7678 7876 7273 7371 6E6F 7271"
	$"7070 6D6D 6F6F 706E 6E6B 696B 6D69 6A6C"
	$"6A6B 6B6A 6A68 6A01 770D 4E4A 4A49 4A4B"
	$"4D4C 4B4A 484C 4E4E FE4D FB4C 534E 4D4D"
	$"4C4A 4B4D 4B4C 4C4D 4C4E 4C4C 4E4B 4D52"
	$"5453 5861 6056 514D 4C4F 4D4B 5151 4F4D"
	$"4B4A 4647 4A47 4346 4547 4745 4244 4445"
	$"4643 4140 4041 3D3C 4040 3B3D 3F3B 3D3F"
	$"3B3A 3C3C 3939 383A 3736 3839 3637 3836"
	$"35FE 3711 3637 3535 3437 3636 3738 3533"
	$"3030 3232 3560 FF5F 135D 5E5F 6060 5F60"
	$"5F61 6160 5F60 6261 6160 6061 5FFD 6002"
	$"5F60 61FC 6037 615F 5F61 5F62 6668 676C"
	$"7675 6B66 6161 6665 6368 6765 6462 605E"
	$"5F60 605B 5E5B 5B5C 5A59 5B5B 5C5E 5A57"
	$"5657 5754 5357 5652 5355 5251 5452 FE51"
	$"FF4E 204C 4E4C 4B4D 4D4B 4D4D 4B4A 4D4B"
	$"4B4A 4849 4947 4948 4648 4845 4442 4344"
	$"4244 847D 0082 FE81 FF82 0C83 8482 8384"
	$"8281 8182 8285 8381 FE82 FD81 6282 8483"
	$"8281 8381 8380 8384 8285 898B 898F 9795"
	$"8E8B 8482 8787 898D 8C8A 8885 8382 8484"
	$"8280 8280 7F7F 7D7B 7E7E 7F81 7D7C 7B7C"
	$"7B76 7578 7670 7477 7272 7170 7172 716F"
	$"6D6A 6C67 666A 6B68 6B6C 6A69 6B69 6765"
	$"6566 6665 6766 6465 6562 615E 5D60 5E61"
	$"017F 7F4F 514F 535E 5955 5454 5056 5854"
	$"5354 5252 5751 5355 5758 5759 4F53 5659"
	$"5951 4F4F 5C64 5A59 5A59 535E 6863 6364"
	$"5F62 5B58 6058 565A 5453 4E4E 5154 575A"
	$"5449 4648 4943 4952 4743 4043 414F 4241"
	$"5440 423F 3933 3945 3838 4036 3630 3236"
	$"3333 3130 302D 3036 3233 302F 3232 302F"
	$"2E33 3431 3132 3230 3034 3534 3332 3433"
	$"3536 6304 6663 6874 6CFD 6702 6D6C 6AFE"
	$"6870 676B 6669 6A6A 6C6B 6D66 6A6A 6D6F"
	$"6A65 636E 766E 706F 6E68 717C 7978 7A74"
	$"776F 6B74 6B69 6E68 6863 6466 686C 7269"
	$"5E5D 5E5E 5A5E 665B 5756 5D5A 6658 5768"
	$"5457 514B 4950 584A 4A51 4748 4547 4946"
	$"4642 4342 3F41 4642 4443 4346 4645 4242"
	$"4342 4443 4242 3F3E 4244 4241 3F41 4143"
	$"4387 857C 858B 968E 8887 8989 9293 8C8B"
	$"8B89 898C 888D 8B8C 8F8E 9089 8D8C 8E8E"
	$"8986 838F 988F 908E 8F8B 929B 9995 9593"
	$"978F 8B95 8B8A 9088 857F 8386 858B 958B"
	$"7C7B 7D7D 787C 8379 7674 7A77 806F 6F82"
	$"6E72 6B62 626D 7867 6467 5D5F 5D5F 5E5B"
	$"5B55 5757 5255 5D5A 5D5C 5C60 6160 5D5B"
	$"5A5A 5D5D 5B5C 5959 5A5C 5E5D 5858 5A5E"
	$"6001 8057 383F 3840 4F4D 4342 3B46 5E4D"
	$"4E50 5B44 5062 6169 4755 515B 4E71 6566"
	$"5A84 8D80 7D7E A287 A5A7 B0A9 A9B0 BFB2"
	$"ACB9 AC8A 828C 9087 9380 727A 6C6C 7471"
	$"7A74 6D56 544C 433F 3E3D 423B 453B 443F"
	$"3B40 3F3E 3A36 2F36 4334 3737 FE34 FF35"
	$"2236 3839 3B44 4A44 4449 4948 493A 3535"
	$"373A 4040 3F3E 3D3E 3B3C 4145 424B 504A"
	$"4447 4B4A 7F52 4952 605F 5654 4C58 7160"
	$"6164 6C56 6374 737A 5867 5F6D 6483 7577"
	$"6D97 998B 8E8E B297 B4AF B5B3 B2BB CCBC"
	$"B7C5 B795 909D A395 A090 7E8A 7F7E 827F"
	$"8982 7D68 655F 5A55 4F4F 544F 5A51 5852"
	$"4E52 504F 4948 454D 5447 4B4C 4847 484A"
	$"4A48 494B 4E57 5B55 5459 5957 574C 4948"
	$"4A4D 4F4E 504F 4D4F 4B4A 5155 525A 6059"
	$"5457 5E61 667C 5F6A 7772 6A68 606A 877B"
	$"777B 8570 7A87 8A94 6E7D 7682 7E99 8488"
	$"7FA7 A79A A1A2 C8AC CFC7 C5BE C0CD DDCB"
	$"C9D6 CAA3 9EAD B7AE B5A2 8D97 9694 9C9C"
	$"A69C 9480 7D76 7170 6B69 6F6A 776E 756E"
	$"696C 6967 6160 5F6A 7463 6869 6361 6365"
	$"6564 6465 6B75 7872 7072 7473 746A 6767"
	$"696B 6E6D 6E6D 6C6C 6869 6F74 747E 827A"
	$"7578 7D01 7E7F 3332 3537 353E 4240 383A"
	$"3931 3B3B 3E3A 4443 4249 373C 3F48 3E55"
	$"474B 4E5E 7257 6D6F 795D 766E 7F81 8B90"
	$"B08C 787B 6C6E 6A6B 7287 7A67 6568 6260"
	$"5E69 5F60 5B51 504F 4A4A 4442 4347 4643"
	$"464B 4847 4A50 4C4E 4D4A 5166 5447 4745"
	$"423E 3D3E 4249 4B6A 6558 605C 4F55 5446"
	$"4348 4B50 595B 5555 575B 5754 5A57 5659"
	$"5E5A 5153 5144 FE46 4144 4E52 5049 4C4C"
	$"454E 4B4F 4E57 5654 5D49 4D4D 574E 6356"
	$"5B5B 6B7D 637B 7D88 6980 788B 8D96 98BC"
	$"9B87 8776 7977 7D85 9285 7876 7872 706F"
	$"786E 716D 6563 645F 5F59 59FD 5736 595F"
	$"5C5A 5E62 5B5F 605C 6278 685D 5B59 5752"
	$"5051 565D 607D 7568 706C 5F65 6457 575B"
	$"5D62 6C6B 6264 686C 6865 6B66 666A 6F6B"
	$"6163 625D 5C7C 5E5F 5C65 6966 5D63 615C"
	$"6762 6564 706D 6C76 6265 646E 687D 6E70"
	$"7080 917A 9493 9E7E 9892 A0A0 AAB1 D0BB"
	$"A199 8E94 9194 A0AE 9D94 9294 8F8C 8B95"
	$"898B 8A83 7F7E 7C7E 7877 7675 7475 797F"
	$"7B79 7D81 7A7E 807C 8298 897C 7A78 7571"
	$"7172 777C 829F 9588 908B 7E86 8579 787E"
	$"8286 8F8D 8687 8B8D 8B8A 8F8B 8B8F 938D"
	$"8486 8601 8005 6F67 5E68 6E76 FE77 7664"
	$"6069 657B 7B67 6B63 655E 6269 756C 6C6B"
	$"686E 9993 8973 7673 8C92 9195 A4A0 9795"
	$"968D 7982 928E 817D 7F81 6B74 7675 736D"
	$"656A 7374 6F67 6B68 6864 605E 5A5F 5C58"
	$"5F63 5F60 6A75 6861 5C52 596D 6C76 6164"
	$"5850 4F57 5458 5A5E 5B55 5B5E 6364 5C5E"
	$"5859 5B5F 5E5D 5354 5C64 6A67 665A 5859"
	$"585B 5752 4F81 7F7B 7079 7E86 8687 8975"
	$"717A 7588 8C7B 7E77 7A73 737A 867B 7C7C"
	$"797D A7A3 9A83 8583 9A9E 9FA1 B1AF A6A4"
	$"A69D 8A91 A19D 908C 8F8F 7A82 8484 837D"
	$"787D 8385 8179 7E7B 7B78 7270 6B70 6F6B"
	$"7276 7273 7C86 7974 7167 6E81 7F8B 7477"
	$"6B61 636A 676A 6B6F 6B67 6C6F 7474 6C70"
	$"6D6D 6E72 716E 6667 6D75 7A77 766B 696A"
	$"6768 6662 5EA3 9A7C 9299 A0A7 A7A5 A795"
	$"9198 90A6 A999 9E97 9991 9399 A59A 999A"
	$"9A9C C4C0 BAA4 A4A1 B7BB B8BC CBCC C6C2"
	$"C6BC AAB5 C0BD B3AE AFB1 9BA0 A3A3 A19D"
	$"999D A4A6 A29B A09C 9B99 9593 8F92 8F8D"
	$"9397 9394 9DA9 9D95 9189 91A4 A4AF 9698"
	$"8C83 858B 898D 8D91 8D89 8E92 9695 8C91"
	$"8F92 9293 9390 888A 9198 9C9A 988D 8C8D"
	$"898B 8985 8101 8002 A9A7 90FE 9579 A8B9"
	$"ACA2 A2B1 99A1 A7A2 BBBB B8B7 AD91 8088"
	$"8A70 7F8E B09D A3B6 B39C A2B5 A68D 8C8E"
	$"8D92 9C89 8C8A 9D9F 9895 9785 8E82 6F77"
	$"8074 7673 7384 7069 6E79 6762 665D 5E5A"
	$"5D70 6E65 616C 726B 6165 6D71 6A6F 736F"
	$"7069 7273 6962 6B60 7261 5156 6569 6C6F"
	$"6660 6370 6360 5E5B 5D57 606D 766E 6260"
	$"6664 6467 7571 78B3 7FB5 9DA1 A4A2 B2C6"
	$"B8AD ADBD A9AF B5AF C6C5 C3C5 BFA5 9097"
	$"9B82 8F9A BAA8 AFC3 C2AC B1C1 B49E 9C9F"
	$"9DA0 AB99 9D99 A9AD A7A3 A493 9D92 7E87"
	$"9385 8684 8394 8179 7C86 7976 786E 716E"
	$"7081 8177 757E 827B 7278 8082 7B81 8480"
	$"817A 8385 7A75 7E72 8372 6368 7679 7B7E"
	$"736E 7581 7571 6D6B 6D69 717D 847A 7072"
	$"7975 7376 8483 87DA D57C C1C4 C6C5 D4E4"
	$"D7CC CDDB C9D1 D7CF E2E0 DCDF DDC6 B2B9"
	$"BCA3 B2BA D7C4 CCE0 DFCB CEDE CEBA BBBE"
	$"BEC1 C8B7 BEBB C9CA C5C3 C6B5 BEB2 9EA6"
	$"B2A8 A8A6 A5B5 A09A 9EA8 9A97 9990 938E"
	$"93A5 A298 97A0 A49B 939B A2A5 9DA2 A5A1"
	$"9F9B A6A7 9D95 A096 A491 8489 989B 9E9F"
	$"938D 96A5 9691 8F8D 8F8C 94A0 A89D 9295"
	$"9C98 9498 A6A6 AF01 807F 7B80 8C99 8F8E"
	$"939F 938F A196 9989 95A0 99A3 A29E 9D93"
	$"848C 8B8F A4A4 A6B2 B8B0 B4AF BABF BBB8"
	$"BCC8 CDB8 A4A2 A0A4 B4C1 BFB6 998E A58E"
	$"8692 918A 8C7D 7E71 6D80 757C 7D82 767A"
	$"6A7A 7B72 7878 7D83 7079 735E 7170 717F"
	$"7882 8F78 8A82 8272 7787 897C 8D8A 96A0"
	$"9A99 A091 A1A5 A89D 9FA7 A599 A3AC B1AB"
	$"A6B4 B2A9 ADB0 B9AF A087 7F90 99A7 9C9A"
	$"9EAB 9F9C AEA4 A796 A1AA A2AD ADA9 A8A1"
	$"949D 9B9C B0B0 B1BE C3BB C0BB C5C9 C6C3"
	$"C5D0 D3C1 B0AE ADAF BBCA C7C0 A59B B39B"
	$"94A3 A398 9A8D 8F82 7F91 848D 8E94 858D"
	$"7D8C 8C83 8788 8F93 808B 856F 8180 828F"
	$"8993 9E88 988F 8D82 8896 988C 9D9C A7AE"
	$"A8A8 AD9F B0B6 B5A8 A9B1 B0A5 B1B9 BDB6"
	$"B3C2 C0B7 B8BC C2AA 8EB0 B27C BDC9 BFBC"
	$"BDC9 BEBC CFC4 C8B5 C0C9 C1C9 C8C6 C5BE"
	$"B2BC BBBF D1CE CFD9 DED7 DCD7 E0E3 E0DF"
	$"E1E8 E9D8 C9C9 CACC D7E3 DDD6 C0B9 D3BC"
	$"B4C2 C2BB BDAF B1A4 A0B2 A5AE B3B6 A4AE"
	$"9FAD AEA6 A9AB B4B6 A2AD A591 A2A1 A4B2"
	$"AAB4 BEA8 B9B1 AEA0 A8B7 B5A9 BDB9 C5CF"
	$"C8C7 CCBC CED6 D6C8 C8CE CEC6 D2D9 DED8"
	$"D3E1 E1D9 D8DE E4CA AA01 8014 B19F A8AC"
	$"B6B9 A39E A6AE A2B0 B7B9 BBBF B4AF B8B4"
	$"B9FE B867 BFBB BCCA BFC9 CDC8 CAD2 D0CB"
	$"CDD2 D6D6 D4CC C4C6 C8C9 C6C8 C5C4 C2C5"
	$"C1C1 C8C8 C2BB B5BB B7B0 AEBC B2BB A2AC"
	$"ADBA A3AD A396 AFB6 B8A0 91A2 A08E 9AA3"
	$"AAB7 B5B9 C4B4 BEB5 BABC BCCB C2C4 C7C5"
	$"C1C6 BCBB BDBE BBB6 BEB9 BAB7 B3B3 A8A5"
	$"A5A6 A2A0 978F 8EA8 B1B0 B7B9 7FAD B3B5"
	$"C3C7 AFA9 B2BB AEB9 C0C1 C2C6 BEB7 BEBC"
	$"C2C2 C3C1 C7C1 C3D3 C7D0 D5CF D0D6 D6D3"
	$"D3D7 DBDB D9D1 CACD D0D0 CBCE CCCB CBCE"
	$"CBC9 D0D2 CDC4 BEC5 C1BA B9C8 BCC6 AEB8"
	$"B8C6 B0B9 B0A3 B8C0 C4AE A1B1 B09F AAB2"
	$"B8C5 C2C3 CEC0 C9C1 C7CA C8D6 CCCC CFD1"
	$"CCCF C5C6 C8C8 C3BC C2C0 C3BE BABB B1AF"
	$"AEAE AAA9 A09B 949D 8871 78DC C9FF D257"
	$"E1E5 CDC8 D1D8 CAD7 DBDC DADE D6D0 D6D4"
	$"DBDC DDD9 DDDA DAE9 E0E8 EAE5 E6EB E9E7"
	$"E9EE F1F1 F0EA E2E2 E5E7 E3E3 E2E2 E3E7"
	$"E4E3 E8E9 E7DE D8DF DCD7 D5E3 D6E0 CDD7"
	$"D3E1 CED7 CEC1 D6DC E1CA BFD1 CCBB CBD0"
	$"D6E2 DFE0 E7DD E7E0 FEE5 1FF1 E7E8 EAEC"
	$"E8EA E0E1 E3E3 DED9 DDDC DEDB D7D8 CECD"
	$"CDCC C8C6 BFBB B7C4 9560 5301 7F7F B4B0"
	$"6E63 9DA1 A9AF BBB4 A6AE A7A4 A9AA A39B"
	$"8E98 9F86 8290 A08B 919E A6A9 B3B9 B6C7"
	$"C9C8 C6C8 C7C3 BBB2 B0B7 C1BB B7B7 B0B2"
	$"B7B7 ACAD BAB1 C1A1 A29E AEC1 C9CB CCCC"
	$"C7C7 C2C7 CACD C2BD C1BB BDB5 B1B6 BCBB"
	$"B8B7 B1AB A7A9 A4A5 A799 979C 9996 918A"
	$"827E 7E7C 7271 796F 6A67 6562 6761 6565"
	$"5E5F 6060 615E 657E A5B7 B8BA B6BC 7FBB"
	$"705C 98A0 ACB4 BEB8 AEB7 AEAA AEB0 A6A0"
	$"939B A590 8997 A994 97A3 ABAF BBC2 BDCC"
	$"CBCC CACD CCC8 C1B6 B4BC C7C3 C1BF B8BB"
	$"C0BE B4B6 C3BA C8A7 A7A4 B2C5 D0D1 D0D1"
	$"CECE C9CD D1D3 CCC6 C9C4 C6BF BBC0 C5C3"
	$"BFBE B8B3 AEAF A8AA ADA0 9CA0 9B97 938D"
	$"837F 807F 7473 7A6E 6965 6461 6663 6567"
	$"6264 6362 615D 626C 7670 646A 68DD D23D"
	$"8569 A3AF C1CD D8D0 C5D0 C9C5 C7C7 BCB2"
	$"A7B1 BBA8 A0AA BFAF B0BA BFC1 CFDA D4E1"
	$"E0E0 DEE1 E1DB D4CB C8CF DFDD D9D6 D1D4"
	$"D9D4 CACD D9D4 DFBD BCB6 C5D8 E4E8 FDE5"
	$"3AE0 E7EB ECE5 E2E3 DEDF D7D7 DDDF DCD9"
	$"D6D0 CAC5 C6BF BFC1 B5B1 B1AA A7A1 9991"
	$"8D8E 8C82 8287 7A73 6D6B 6A72 6E72 7571"
	$"7372 7070 6D72 7972 6254 5545 0180 408B"
	$"741F 151F 292D 4054 576E 7C7D 7F87 888A"
	$"8785 8082 8080 8182 807B 8184 7E89 8A89"
	$"9090 9692 8D8F 867E 948C 8392 8D8C A1AE"
	$"A693 8081 837E 8189 7186 8B8B A1BB 9794"
	$"FE93 3B8D 8B8D 8981 827B 7274 7073 736F"
	$"6B69 6968 6865 6662 6563 605B 5C5A 5954"
	$"5A5B 5554 5154 5557 515A 5B58 5D5B 595C"
	$"5B5F 5E56 555A 688D ADB9 BABB B2A1 947F"
	$"7C1F 0D17 2328 3A4E 5570 8082 828C 8E92"
	$"908D 888B 8888 8A8D 8C87 8B8E 8893 9495"
	$"9C9A 9C9A 9796 8C85 9C95 8B99 9998 A8B7"
	$"B29F 8A8B 8D88 8D95 798D 9495 A9C3 9F9B"
	$"9B9A 9C97 9495 928C 8C87 7C7C 7778 7674"
	$"706E 6B6A 6A65 6762 6463 605A 5B59 5853"
	$"5A59 5353 5153 5355 4F59 5A57 5A58 5759"
	$"575D 5B53 505E 738B 846D 6365 5B63 B594"
	$"7C2B 1018 262F 4258 6482 9397 9BA6 A8AD"
	$"ABA8 A4A6 A2A2 A4A9 A9A4 A8AB A3AC B0B3"
	$"B7B6 B8B5 B0B1 A59B B0AB A7B7 B4B5 C6D2"
	$"CEBC A4A3 A7A4 A8B0 93A6 ABAB BFD9 B9B5"
	$"B4B6 B9B3 AFB1 ADA7 A8A0 9493 8C8D 8A86"
	$"817D 7A76 746F 6F68 6B67 665F 5F5D 5D56"
	$"5A5B 5655 5356 5859 515B 5D5B 5C59 585B"
	$"5A5F 5E55 525D 7A9E 8357 626F 5342 0180"
	$"7F79 6A47 3F51 5646 3930 3946 383C 4755"
	$"5857 636E 6E6D 7174 747D 797C 797A 7F83"
	$"8582 8486 7D7D 7883 8183 9B9D 8984 7D7D"
	$"7F80 8380 7575 7175 7370 7677 787E 7F92"
	$"706F 6F6E 6B6B 6A6A 6766 6562 6566 6664"
	$"6768 6661 6463 6162 605F 5957 5653 5653"
	$"5858 555E 5F5F 6161 5E5F 6064 6B67 6567"
	$"6561 6362 6061 7592 A6B8 BCBB BAB1 9A7F"
	$"797F 6B47 3E51 5948 392D 3645 373B 4554"
	$"5754 606B 6D6D 7072 747F 7C80 8083 888C"
	$"8F8C 8F92 8B89 848D 8C8C A5A9 948E 8787"
	$"8A8D 908C 8282 7F82 7D77 7E80 8187 8596"
	$"7575 7772 6E70 6D6D 6968 6865 6666 6564"
	$"6767 645E 6361 5F5F 5E5D 5756 5552 5651"
	$"5757 535D 5C5C 5E5F 5D5E 5F63 6963 6265"
	$"635E 605E 5C5E 7C97 8E73 655E 626C 7F98"
	$"8B77 0F52 465C 6754 4135 3E4C 3F43 4E5D"
	$"6261 6EFE 7969 7D80 828E 8B90 9398 9FA4"
	$"A9A7 ABAF A9A7 A1AA A9AB C2C5 B2AA A3A4"
	$"A8AB ACA8 9EA0 9A9C 9691 9696 979E 9DA7"
	$"8488 8A85 7E7F 7C7B 7774 7470 706F 6C6B"
	$"6D6C 6A64 6765 6464 615F 5A5A 5856 5B57"
	$"5B5A 555E 605F 6162 6264 6468 6C68 676A"
	$"655F 605F 5D5D 728E 865E 4D67 694E 5594"
	$"0180 FF6E 2073 7471 6D6F 706C 6C6F 6769"
	$"6463 6263 5F5C 5650 4A4E 4657 4F5B 5B5D"
	$"6259 646E 6D6D FE6C 076E 706E 6E72 7371"
	$"70FE 6F0D 7271 6D6F 6C6C 6B6B 6D6C 6B69"
	$"6565 FE68 FF69 FF68 396B 696A 6869 696A"
	$"6367 6663 5E59 5A5F 5C5D 5E59 5F5E 5B5C"
	$"5F5C 615E 5A5F 6766 6067 6062 6867 6765"
	$"6664 6364 6565 738E ADB7 C2C2 BFBA AB94"
	$"91A3 6C1E 6C70 716F 6D6F 706B 6B6F 6769"
	$"6765 6462 5E5B 534E 4648 4152 4753 5356"
	$"5B54 64FE 715D 7071 7172 7473 7276 7673"
	$"7371 7372 7373 7172 6E6F 6D69 6D6B 6A69"
	$"6464 6868 6969 6867 686A 6969 6768 6869"
	$"6165 6463 5D59 5A5C 595B 5D59 5A5A 595B"
	$"5D5B 5F5A 575A 6060 5961 5E60 6564 6461"
	$"6362 5F62 5F5C 799B 9E74 676B 696B 8998"
	$"8669 7471 FF78 1F77 7579 7873 7679 7173"
	$"6F6D 6B69 6563 5A54 4D4E 4554 4A55 555A"
	$"5E57 6C7C 7D7F 7FFE 8057 8280 7F80 8180"
	$"7F7E 7F7E 7F7F 7B7D 7A7A 7775 7774 7271"
	$"6C6C 6D6E 7070 6E6D 6E70 6E6D 696A 6A6D"
	$"6569 6764 5F5B 5B5E 5C5B 5C58 5C59 595D"
	$"605D 5F5D 5A5C 6260 5862 5F64 6867 6965"
	$"6562 6264 625A 719A A46E 4C4A 4C54 5E8C"
	$"A9A7 017F 0A70 6E6F 6A6D 706E 6D6C 6D6D"
	$"FE6E 1D6F 6B6B 696A 6D6A 6864 5E56 4C46"
	$"4D45 403F 5769 6366 6767 6666 696A 6868"
	$"66FE 68FF 6736 6669 6867 6569 6A68 676B"
	$"696E 6A6A 6E6B 6B6A 6C69 6869 6661 6265"
	$"676A 6667 6366 6563 6366 6B67 6866 6561"
	$"6865 6667 6A62 6363 6967 6268 67FE 6814"
	$"6764 6666 6765 738C 90A2 C1C9 BFBD BFBB"
	$"B1AE BDB5 6D2A 6C6D 666A 6E6C 6B6C 6C6A"
	$"6D6D 6C6E 6A6B 6A6A 6E6B 6965 6057 4B44"
	$"4A40 3C3C 5568 6165 6666 6463 6769 6565"
	$"64FE 66FE 652D 6766 6766 6868 6565 6967"
	$"6B68 686C 6969 686A 6665 6661 5F5F 6365"
	$"6864 6561 6463 615F 6266 6467 6560 5C62"
	$"5F63 6467 FE60 0866 645E 6262 6164 6463"
	$"FE60 1162 616C 98A1 8B87 7E6D 6F7A 817D"
	$"5A4F 5676 7208 746D 7174 7271 7172 71FE"
	$"7470 7372 7271 7275 7371 6D68 5D52 4A4F"
	$"463D 3B56 6C65 676A 6B68 676A 6B68 6766"
	$"6868 6968 6967 6A68 6867 696A 6766 6B69"
	$"6C69 696C 6A6B 696C 6968 6964 5F5D 6164"
	$"6663 6360 6463 6160 6466 6366 6460 5C63"
	$"5F5F 6367 5F5F 6064 615D 615F 5F62 6261"
	$"6060 5D5F 5D65 98C2 C4AD 6B42 454C 5F8D"
	$"9286 9601 802E 6863 6466 6569 6665 6666"
	$"6C67 6367 6A64 6564 6868 6263 6263 6667"
	$"6869 6762 6467 6663 6465 6062 6066 6362"
	$"6563 6167 67FE 644D 5E5D 6163 6765 6563"
	$"6666 6A66 6568 6466 6864 6868 6465 6064"
	$"6568 6661 6269 6864 6363 6466 6769 6A68"
	$"6B6C 6669 6769 686B 6265 6960 606C 6E68"
	$"6569 6064 6365 93AE A996 96AE BFBD C1C7"
	$"BBB3 A889 6563 1762 6364 6467 6564 6665"
	$"6B64 6064 6662 6363 6665 6062 6161 63FE"
	$"6234 635F 6061 615E 6061 5D5F 5E64 615E"
	$"6061 5E63 625F 6262 5D5D 6060 6261 6160"
	$"6462 6664 6264 6362 6260 6464 6161 5B5E"
	$"6064 6260 6064 63FE 612C 6062 6567 6764"
	$"6766 6065 6367 6768 5F61 665E 5D66 6663"
	$"6166 5B60 5F62 697F 9D83 A29A 8580 8A81"
	$"5E4D 5868 706B 6716 686A 696D 6A69 6B6A"
	$"716A 6568 6965 6767 6A6B 6565 6363 64FE"
	$"6362 6461 6163 605B 5D5F 5C5B 5A60 5E5C"
	$"5F60 5E63 605E 6160 5D5C 5E5D 605D 5E5E"
	$"6260 6561 6061 6162 6260 6463 5E5F 5B5D"
	$"5D62 605C 5D62 605F 5F5E 5F63 6566 6663"
	$"6564 5C60 5F64 6364 5B5E 635D 5C65 6460"
	$"5F63 5B5E 5E69 7693 CBBA CDA9 5E50 6680"
	$"7B8B 98A6 C301 7F04 585C 5E5F 5FFE 5E14"
	$"5C62 615D 605E 6267 6465 5C61 6263 635A"
	$"5D61 6560 62FE 5FFF 6515 6365 6261 6361"
	$"5E5C 6260 6062 6367 6667 6666 6565 6364"
	$"FE66 4469 6A68 6566 6661 5F62 6667 6065"
	$"6061 6269 544D 6769 6466 6366 6464 6766"
	$"5E65 6C69 6769 6366 6969 6766 6861 6769"
	$"6566 6461 5A5C 69A0 BB95 807E 8DB4 C4C6"
	$"C8AF 9694 8758 7355 FF59 1C5C 5B58 5A5B"
	$"585F 5F5A 5C58 5E64 6162 575C 5F61 6057"
	$"5C5E 615C 5D5C 5B5B FD61 FF5F 5A63 605A"
	$"5960 5F5E 5F60 6361 6363 6564 6260 6363"
	$"6263 6566 6360 6162 5F5E 6063 625E 635B"
	$"5D5E 6550 4B63 625F 6360 6362 6162 6159"
	$"5F67 6161 635E 6365 6663 6367 6065 6660"
	$"6262 5C54 5F6E 8F96 9EB2 B39B 8075 6E67"
	$"595D 7085 7B6E 5B5C 655D 5E5D 5B5D 5D5B"
	$"6161 5A5C 595F 6462 6059 5D5F 6262 595E"
	$"6260 585C 5A58 5C64 605F 605D 5D5F 5E59"
	$"585D 5C5C 5D5D 605F 6061 6160 5F5D 5F61"
	$"6060 6364 635F 5F61 5E5C 5E60 605C 6059"
	$"5D5D 634F 4B63 615E 6260 615F 5F60 5B54"
	$"5D63 5F5E 615C 6164 6461 5F63 5E62 63FE"
	$"5F13 5B52 5D6D 8387 B1DC DAC8 9983 8399"
	$"989A A8A0 B1BC 017E 3361 685F 646B 6562"
	$"6464 6063 6561 5E63 6264 6863 6160 6064"
	$"6161 6467 6464 5F63 6165 6466 6665 6464"
	$"5F5E 6260 6264 6366 6869 6561 63FE 68FF"
	$"6320 6061 6760 6A67 6567 5F5F 6968 6362"
	$"6157 6965 6060 5F65 6368 6762 635E 6663"
	$"6365 65FC 67FF 63FF 681C 6B67 696A 6868"
	$"6B6A 6366 87A5 9681 8BA2 B2BD C5B7 9B78"
	$"5567 957D 89AD 5B7F 635B 6065 605E 6061"
	$"5D61 635F 5D60 5E5F 645F 5F5E 5D61 5E5E"
	$"6062 6060 5B5F 5E62 6162 6261 6160 5B5A"
	$"5F5E 5D60 6063 6666 625F 6265 6364 6161"
	$"5D5F 635D 6562 6164 5D5B 6464 5F5D 5D52"
	$"6664 5F5D 5C62 6165 635F 625C 645E 5E61"
	$"6163 6263 6564 6160 6262 6764 6466 6462"
	$"6565 606D 8A9C A5AB 9578 6D59 595E 696A"
	$"6B72 867D 654C 5F63 7C5D 6265 6060 6161"
	$"5F61 625E 5E63 6062 655F 5D5D 5C61 605F"
	$"6061 5E5D 595D 5E62 6060 6261 605E 595B"
	$"6060 5F5F 5E61 6364 615F 6263 6163 5F5F"
	$"5B5D 625B 635E 5D61 5C5B 6260 5B5A 5A50"
	$"6563 5D5C 5D61 5F64 625E 635C 625A 5A5E"
	$"5F61 6261 6060 5E5E 605F 6562 6263 6261"
	$"6463 5C6D 8FA1 AFCB C5B3 A287 99A3 A9B8"
	$"BABA 8989 A081 0180 5066 6865 6566 6561"
	$"6365 6066 5F56 6162 6867 6760 6065 6666"
	$"6064 6667 6163 6064 6361 6865 6663 6360"
	$"6066 6566 6568 6465 6769 6965 6669 6563"
	$"6165 615F 606B 6965 6669 6664 6C62 5F65"
	$"6762 635E 6367 6264 6764 FE62 2B60 655F"
	$"6763 6263 6565 6365 6360 6764 6869 5F62"
	$"6463 5F58 6C97 A893 9AAD BBC0 B095 785E"
	$"4C48 4359 8699 AEAE 6112 6361 6061 615C"
	$"6163 5D63 5D55 6060 6462 635E 5FFE 6369"
	$"5F63 6361 5C5E 5B60 615E 6360 6161 605C"
	$"5C64 6261 5F62 5F5F 6365 6662 6263 6260"
	$"5E63 5F5D 5D67 6561 6466 625F 675E 5C60"
	$"5F60 625B 5F63 5E60 635F 5E5E 605E 635E"
	$"635C 5D62 6264 6264 625E 6460 6364 5B60"
	$"6260 5B60 7E86 8A7C 8576 4F4E 5564 6C70"
	$"6F72 6E72 7B58 4349 6364 FF63 FF62 5360"
	$"6262 5E64 5E58 6363 6863 615F 5F63 6362"
	$"5F63 615F 595C 595E 5E5C 6260 5F5F 605B"
	$"5A62 6261 5E5F 5C5D 5F62 6462 6161 6060"
	$"5D60 5C5B 5B64 615D 5F62 5F5E 665B 5A5D"
	$"5D5C 605A 5E60 5B5E 625F 5B5D 615D 615B"
	$"605A 5BFE 6121 5F62 5F5A 615D 5F60 575F"
	$"625F 5A5E 8AB3 B4A9 BBA8 7F8E 97A9 BDC8"
	$"CCC9 C4C0 BAA6 865E 0180 3565 6362 6364"
	$"6564 6465 6A67 5F60 6364 6761 6261 6565"
	$"6A66 6367 6865 5F5A 6267 5859 635E 6060"
	$"635B 6166 6568 6063 6265 6264 6B6B 655A"
	$"60FE 6446 6264 646A 6766 6661 666A 6D65"
	$"6366 6467 6665 6566 6669 6867 6665 5E64"
	$"6462 5D63 6160 636A 6B6E 7065 6366 6265"
	$"6465 6A66 657F A0B3 BCBF C0AB 9C74 5E54"
	$"584F 5966 5181 A5AC AEAD 603B 5E5D 5F60"
	$"6260 6262 6463 5D5E 6162 655E 5F5F 6361"
	$"6360 6063 6562 5D58 6063 5555 5F5A 5C5F"
	$"6157 5C61 5F61 5A5F 5E61 5E5F 6666 6058"
	$"5E61 6162 6062 6165 FE62 405D 6064 6B63"
	$"6163 6163 6263 6163 6365 6362 6161 5D63"
	$"635C 5960 5F5E 6065 6469 6B63 6261 5E63"
	$"6061 6764 6D83 7D61 5652 5454 666D 767D"
	$"8075 8393 6C5F 473A 4957 635E FF5F 0161"
	$"63FE 622D 6563 5C5F 6361 6360 6160 6462"
	$"6460 5F62 6461 5B56 5F61 5355 5F5A 5A5D"
	$"6157 5B5F 5D5E 585B 595E 5B5E 6364 5E54"
	$"5B5F FE5E 0E61 6064 5E5E 5F5C 5F63 6961"
	$"5F62 5F61 FE60 3261 6061 6060 5E5F 5B60"
	$"615C 565E 5D5C 5D62 6468 6A61 6060 5B60"
	$"5F61 675F 6B9C B49D 9686 9097 A6BA CDD7"
	$"D6C5 CBCC BAB8 9987 723B 0180 165F 5C5C"
	$"6264 6363 6863 6868 6766 6163 635F 6564"
	$"6762 6264 FE65 6567 6667 6460 6365 6262"
	$"6563 625D 6864 6367 6461 5E6C 6063 676A"
	$"6466 6968 6769 6868 6765 6462 6269 6B68"
	$"6568 6A6B 6766 6967 6666 646C 6865 6368"
	$"6367 666C 6769 6D67 686C 6B67 6A68 6468"
	$"6469 6661 6077 B6BB BFBB AE8C 6A65 7370"
	$"7E8B 827A 6F67 92AE ABAA AEAD 5A36 5857"
	$"5D60 605F 635F 6465 6262 5E5F 605C 6160"
	$"635E 5F60 6163 6264 6262 605E 6162 605E"
	$"6061 6159 6560 5D62 605E 5965 5B5D 6266"
	$"5F62 6565 62FE 640E 6361 605E 5D65 6663"
	$"6165 6567 6262 64FE 6233 6066 6361 5E64"
	$"5E62 6168 6466 6A64 6466 6462 6666 6162"
	$"6166 615E 5C62 8052 4455 6467 6D8F A18E"
	$"8B93 9AA3 9F75 523E 3A3D 4E4F 5E59 0A5A"
	$"5C5D 5F60 6460 6565 6264 FE5E 6E5B 6360"
	$"635E 5E5F 5F60 6163 6061 5E5B 6160 5E5D"
	$"5D5F 5F59 645E 5A5F 5E5D 5963 595C 6062"
	$"5C60 6162 6062 6161 5F5E 5E5D 5D62 635F"
	$"5E61 6164 6060 6260 6161 5D64 605E 5D61"
	$"5B5E 5D65 5F64 6860 6263 6260 6463 5F62"
	$"6064 5F5D 5C67 9893 8686 A1B0 C0D1 D5BA"
	$"A397 9EB8 C4B3 A37D 7580 5947 017C 5D64"
	$"6565 6463 5F60 6364 6263 6566 6660 6769"
	$"6667 6862 5E60 6565 6465 6162 5B57 6366"
	$"6764 6966 6565 6060 5F65 6261 6266 6365"
	$"6665 6066 6D67 6362 6663 6262 6361 6567"
	$"6868 6268 656B 6E69 6468 6462 6267 6961"
	$"6063 665F 5F63 666A 6A67 6D64 69FB 681B"
	$"6B6A 6480 B6B9 A386 6A54 445F 7495 B0B3"
	$"B19F 7F60 79A7 ABA9 AAAA AC5F 5B63 6161"
	$"5F5A 5C60 605D 5D5F 6162 5B63 6361 6263"
	$"5C5A 5E63 635F 615E 5C57 525E 6266 6065"
	$"6262 645F 5E5B 615F 5D5C 605E 6062 625E"
	$"6369 635E 5E64 605F 5E60 5D61 6364 6460"
	$"6460 6567 6461 655F 5D5E 6265 5F5D 5F62"
	$"5D5C 5E62 6564 6266 5FFD 641F 6564 6669"
	$"6860 5858 545A 6572 7676 9D9A 8376 6969"
	$"779C 8459 3E38 383C 4246 6463 7C64 605F"
	$"5B5E 6161 5E5E 6062 635B 6262 6162 625C"
	$"5B5D 6160 5E60 5F5E 5750 5C5E 615E 635F"
	$"5F61 5E5E 5B5F 5E5C 595E 5C5E 5F60 5D61"
	$"655F 5C5D 625E 5E5C 5D5A 5E60 6161 5E63"
	$"5D62 6561 5E63 5E5D 5C60 635B 5E5D 5F5A"
	$"595C 5F62 615E 635D 6362 6261 6363 6467"
	$"665C 6385 91A2 B1C1 CCD1 E2BA 7B4E 3732"
	$"4387 B2B0 8D7E 8681 6C74 0180 475F 6468"
	$"6761 5D61 5E5E 6361 5E63 6565 6766 635D"
	$"6261 5D65 665B 565E 6662 655F 5960 6562"
	$"6164 6562 5C62 585B 6463 6165 6864 5C63"
	$"6660 6465 6766 695D 666C 6962 6461 636A"
	$"6D64 666B 6AFE 6D30 605D 605E 5B68 6568"
	$"6565 6C5F 6266 5D65 6965 6A66 6A64 6569"
	$"6664 6F8B A3A3 947D 4842 3E57 94A9 B9B4"
	$"B2B2 A07F 684B 82AB A7FE AA00 583D 6064"
	$"635B 575C 5B5D 605D 5B61 6261 6260 5F58"
	$"5E5E 5A63 6458 535B 625D 5F59 545C 5F5D"
	$"5D61 615E 5860 5657 615F 5C61 635F 595F"
	$"635E 5F61 6464 675A 6367 645E FE61 3E66"
	$"6761 6366 656A 6867 5C59 5C5C 5864 6062"
	$"5F62 6959 5D63 5A62 635E 6464 665E 6164"
	$"6360 6366 6E71 6C82 7371 6F7D 8B6B 6D69"
	$"6863 6B94 8B5E 5C52 4446 4A53 5E5F 3C64"
	$"635F 595D 5C5E 625E 5C61 6563 6460 605C"
	$"5F5E 5A63 6458 525B 635C 5E59 5156 5B59"
	$"5B5F 5E5B 575F 5555 5D5D 5B5F 605B 555D"
	$"6059 5C5D 6263 6456 6065 615B FE5E 3C61"
	$"635E 5F64 6264 6563 5655 5758 5762 5E5E"
	$"5C5D 6456 5A5F 5760 615B 615F 625C 6064"
	$"5F5E 647B 9FAD 90A0 BDD0 D1D2 A54A 312E"
	$"3232 337A B6B2 AF75 5E65 615F 0180 FF5E"
	$"7D61 5F60 635E 5C61 6B63 5C64 6267 6566"
	$"625E 635F 5955 5654 5B5E 6356 5C57 5F5F"
	$"5C5F 5B5B 565D 6060 555E 6B5D 5F69 6362"
	$"6164 6065 5C59 6870 6766 6463 675F 6C6D"
	$"6865 6964 6A66 6164 6968 6561 6868 6263"
	$"6264 6560 6263 6163 6566 645E 6968 5D5D"
	$"696A 685E 7790 9595 9981 3F4B 5F93 ADB5"
	$"AFB2 B0AB 8F66 6039 55A4 A9A7 9F98 572D"
	$"5A5F 5D5D 5F5D 5B5C 6660 585F 5C62 6166"
	$"625D 605B 5652 5453 5A5D 5F52 5753 5A5C"
	$"595B 5759 5357 5C5E 535A 6657 5C66 FE5E"
	$"4E63 5C61 5A57 636A 6464 625F 625B 686A"
	$"6361 645E 6461 5C5F 6164 625E 6463 5D60"
	$"5E60 625D 5F5E 5D5F 6161 6059 6363 595B"
	$"6667 645D 7379 796E 6D90 6E76 8177 6768"
	$"6373 6E63 7C8E 8A65 6574 6A6E 6A77 5C59"
	$"7C62 605D 5F5D 5A5C 6660 5960 5D63 6164"
	$"635D 5F5B 5653 5552 595B 5E50 5652 585B"
	$"5A59 5557 5155 5A5B 5058 6253 5863 5D5C"
	$"5C60 5B5D 5756 6268 615F 5E5C 5F56 6467"
	$"605D 6059 605D 575B 5F60 5E5B 605E 595D"
	$"5B5E 5F5B 5C5C 5B5D 5F60 5F56 6060 5659"
	$"6566 5F5C 91A0 8968 559E C2D4 CA89 3C2E"
	$"3A44 342C 4E94 BAB3 BC78 3339 435B 0180"
	$"0163 60FE 6209 605F 6162 6765 5C5F 6261"
	$"FE62 6D59 6064 5B58 555F 5E62 5D61 5F60"
	$"5B5C 6058 5851 585A 6463 6864 6760 5D66"
	$"6662 6766 6565 5E65 6A69 6B69 6769 6562"
	$"676A 6963 6560 5F5E 6266 6764 6567 6A69"
	$"6566 6064 6668 6A5F 5F65 6A64 6066 6268"
	$"5C5E 696A 5F70 8A92 9BA7 A8A1 646C 91AD"
	$"B3B6 AEB2 AB96 8258 4339 3763 6D7B 8392"
	$"5E7F 5B5E 5F5D 5B5D 5D5B 5F62 595A 5D5D"
	$"5E5E 5F56 5A5F 5956 545E 5A5D 575C 5B5B"
	$"5658 5C57 554D 5554 5F5E 635F 635B 5963"
	$"635E 6362 6060 5B62 6564 6767 6364 615F"
	$"6063 645F 625D 5B59 5E61 635F 5F61 6464"
	$"6265 5D60 6263 665C 5E61 6661 5C63 5F64"
	$"595C 6664 6376 7B6B 5F5F 5D89 8690 7C61"
	$"6D6D 5C69 6277 9882 6C61 5D6C 6872 767D"
	$"645A 7C5C 605F 5D5E 5F5D 6062 5A5C 5F5F"
	$"5E5E 5F53 575E 5858 555E 5A5C 575B 5959"
	$"5357 5B54 544C 5452 5C5B 5F5C 625A 575F"
	$"5F5D 6060 5E5D 595E 6260 6462 5F61 5D5B"
	$"5C5F 615C 5E59 5857 5B5D 5E5C 5D5E 6060"
	$"5D61 5B5D 6062 6259 5D62 645E 5961 5F63"
	$"565A 6361 6086 8C61 453D 3575 B5CC 8336"
	$"2E38 423E 2C40 94B1 B3BA BFBF 9993 8272"
	$"0180 7F61 5F5E 5D61 645C 5A5D 5D65 6560"
	$"635D 635E 6460 6162 5E60 6464 5C60 6062"
	$"625F 5858 6259 5F57 535A 5F60 635B 5A62"
	$"5A5B 5E60 6065 6462 6F6A 6063 6D69 6C62"
	$"6256 5362 6A69 5965 6861 6567 6765 6469"
	$"6868 6C65 615E 5D66 676C 6360 5B64 686A"
	$"696D 6563 6C63 7CA6 B2B2 A9A5 AE9F 627B"
	$"A7AF B1B5 B4AD 977B 4A37 3A45 5E7B 9197"
	$"AAAA 5D7F 5B59 565B 5F59 5658 5861 625C"
	$"5E58 5E5B 5F5C 5D5E 5C5D 6161 575B 5C5C"
	$"5B5A 5352 5B52 5752 4E55 5A58 5E58 555C"
	$"5558 5B5C 5B60 5F5E 6964 5D60 6865 6A5E"
	$"5D51 4E5C 6465 5464 675F 6062 6160 6065"
	$"6363 685F 5D5C 5C63 6569 615E 5861 6465"
	$"6268 6260 6964 6A6A 5854 5D62 5673 8382"
	$"635F 686E 6862 7194 725F 6167 7274 7475"
	$"8772 615C 2C59 565C 605A 585A 5962 635D"
	$"5F56 5D5A 605C 5C5E 5C5C 5F5F 5659 5A5C"
	$"5A57 504F 5951 5751 4E55 5854 5B59 585C"
	$"5357 FE5B 4C5E 5B59 6560 5A5E 6561 665C"
	$"5C50 4C58 6061 5263 6660 605F 5D5B 5C62"
	$"6060 655C 5A59 5B63 6469 605D 5B63 6466"
	$"6165 615F 6566 7967 3D34 3345 2E4B A6AD"
	$"4728 3030 2E26 3E94 B6BB BEBB B69A 7353"
	$"5E3B 017E 7F61 5C5F 6061 6359 5A5F 6464"
	$"635E 635E 6364 6458 6161 6260 6266 5D62"
	$"635C 5760 5F66 6561 5D5B 6062 625D 615B"
	$"5860 5B5F 5C52 6268 6263 6766 6260 6B6B"
	$"6158 5C5C 5966 6565 676E 6764 6766 6767"
	$"696B 6460 6765 6667 6567 6668 6768 6C65"
	$"6C69 666F 6466 6082 AEB8 B1A4 989B 9B7A"
	$"5C80 A7AD B3B0 A28C 7954 586E 829B A6B2"
	$"A581 90A4 5A4E 585A 5B5D 6055 5458 5D5F"
	$"5F5A 5E5B 6060 5F53 5C5D 5F5C 5E61 595E"
	$"6059 535D 5B5E 5E5B 5755 5A5B 5C57 5C57"
	$"555D 575B 594E 5E64 5C5D 6263 5F5A 6466"
	$"5D56 5958 5660 5F61 6167 615F 6262 6363"
	$"6568 605A 61FC 622B 6061 6264 6560 6963"
	$"5D68 6063 6378 654E 4555 6B5A 5E85 9184"
	$"655C 6367 6B83 9873 6B70 747B 7271 7088"
	$"7D64 5F5A 7C5C 5B5E 5F56 575A 5E5E 5F5B"
	$"5F5A 6061 5F52 5A5C 5E5B 5C5F 575C 5E5A"
	$"535E 5C5F 5C58 5555 5859 5954 5B57 545A"
	$"5559 564B 5B62 5C5C 6062 5E5A 6364 5B56"
	$"5A56 5461 5E5F 6065 5F5E 5F5E 615E 6165"
	$"5E5A 615F 6160 6062 5E5E 5F61 655F 6863"
	$"5A65 5F5E 668F 6D43 4D4A 5642 3681 C29B"
	$"4327 2B29 325F 9EB4 B396 795F 4031 295C"
	$"833E 0180 7F5E 6164 605D 5D65 6562 6564"
	$"6066 6361 6361 5F54 626A 6660 6361 6368"
	$"625D 5F63 6169 6465 635F 5F68 645C 625E"
	$"5F64 6360 625F 6966 6363 6566 635C 686D"
	$"6663 606E 695C 6160 6566 6767 6368 685C"
	$"5F5F 5962 5E60 6548 4850 595E 6D6A 6158"
	$"656B 6267 6865 7BA8 B5AC A898 97A4 765C"
	$"6665 7788 897C 6E67 8299 A7AA AAA9 9A8C"
	$"726A 92A7 567F 5C60 5C5A 5A60 605D 605F"
	$"5B60 5D5C 5D5D 5C4F 5D66 625A 5D5D 5F63"
	$"5E57 5A60 5A63 5F5F 5D59 5962 5E57 5C59"
	$"5A5F 5C5C 605B 6360 5D5E 6262 5F56 5F66"
	$"625F 5B69 6459 5D5C 5F5F 6162 5E64 6459"
	$"5C5B 535C 585A 5E42 444A 5358 6764 5A54"
	$"6167 5C60 6167 615C 5144 4B6B 5963 7D9A"
	$"9E91 877A 7E81 929B 8777 7575 776C 6693"
	$"9B93 7170 5A5B 7C60 5C5B 5A61 615D 5E5D"
	$"5C63 5E5A 5E5F 5D50 5C65 6259 5C5B 5E63"
	$"5E59 5B5F 5A62 5E5C 5B57 555F 5C55 5B56"
	$"595B 5A5A 5D59 605E 5C5D 5F62 5D55 5E65"
	$"625F 5966 6357 5B5A 5E5F 6061 5D63 6357"
	$"5C5D 545C 585B 5D41 4449 5158 6560 5752"
	$"6166 5B5F 6067 6E51 3F51 4E53 453B 7BC1"
	$"C5B3 936B 6870 93BC A163 4430 2B26 1F6E"
	$"A8B4 712E 0180 085F 5B5E 5D59 5667 655F"
	$"FE60 7362 5F59 5F64 5955 655C 5C5E 6164"
	$"6164 6268 6462 6363 5C61 655F 6561 6165"
	$"675F 5F63 5F52 6065 6462 5B63 6661 6763"
	$"6867 6A5F 6467 6964 706D 6F6C 5D5E 696D"
	$"6662 5A64 575E 4C5B 6154 5669 6860 6065"
	$"4E5C 6B62 6366 6782 A6B5 AFAD ADA0 9161"
	$"4251 5043 4E5C 7079 707F A6AE A6A2 A8A6"
	$"9D66 477D 8D81 581C 5759 5854 5062 605B"
	$"5C5C 5D5E 5A53 585E 5653 6157 585A 5B5F"
	$"5E61 5E63 5FFE 5E5F 555D 625A 605D 5C5F"
	$"615D 5A5D 5C50 5C63 605D 565E 615A 6160"
	$"6361 675D 5E61 6460 6D68 6968 5758 6368"
	$"6260 575F 535A 4856 5B50 5367 665B 5B5F"
	$"4B5A 685F 5F62 6364 5653 4A4C 5461 6D73"
	$"7185 776A 8084 818C 9B83 736E 626B 7B6E"
	$"7A98 9299 8A8A 5F57 055A 5956 5365 61FE"
	$"5C11 5D5E 5A53 5A5F 5653 6157 585A 5C5F"
	$"5D61 5F64 FE5E 5E5D 535B 635A 5D59 5A5E"
	$"605B 5A5A 584D 5C61 5F5B 535C 5F59 5E5F"
	$"645F 635A 5D5F 625E 6B67 6867 5859 6468"
	$"605F 5760 545A 4756 5A50 5465 645B 595D"
	$"4A57 665D 5D63 646C 462E 434E 3D34 5C9C"
	$"BFC7 BBBC C7B7 9B8B AC95 452B 262C 2F25"
	$"2B76 B6C6 8E7C 0180 3F57 5362 5A63 5D5C"
	$"6158 5E5C 6165 635E 5E64 5C61 655F 5D64"
	$"5E5D 5D63 6063 5E61 5962 6564 615B 6763"
	$"6262 5F62 605C 5E65 6469 645D 5D5E 6267"
	$"6664 6765 6D62 6A5D 66FE 6A3C 6768 565C"
	$"6A60 6A6A 6064 595A 6064 5E69 676B 685F"
	$"5B5E 616A 695E 6B68 7099 B0B0 AEAD A57F"
	$"4935 3F50 657E 97A5 A7A1 9697 939F A0A3"
	$"9E8D 7858 6188 6C47 567F 5160 555B 5757"
	$"5A53 5959 5E61 5F5B 5A5F 575C 605B 5960"
	$"5959 5B61 5D5F 5A5D 565E 6162 5F57 625C"
	$"5D60 5B5D 5A57 5A62 6368 5F58 5C5D 5F61"
	$"5F5F 6361 695D 6457 6264 6364 6162 5357"
	$"635B 6564 595E 5758 5D62 5A64 6367 665E"
	$"5758 5C66 675A 6465 6568 6054 5557 6372"
	$"6C62 666B 7175 7B7C 7786 8372 898D 6D7A"
	$"8585 8E95 7B6D 7D8B 5952 7C65 585B 5556"
	$"5A53 5A5B 6161 5D5C 5D60 575A 5E59 5960"
	$"5859 5B60 5C5F 585D 5861 6162 6056 605A"
	$"5D62 5E5D 5957 5A62 6266 6057 5A5C 5E62"
	$"5F5F 625F 675C 6455 5F63 6364 6162 5258"
	$"6357 6262 595F 5659 5D5E 5562 6266 655C"
	$"5458 5C62 6359 6264 7476 492F 312B 3770"
	$"B0C8 C4BA AA8F 6F4B 3650 6D4B 6483 3D37"
	$"4E5F 77A4 AEA5 A6B3 0180 7F61 5D5A 6466"
	$"6360 5959 5D5C 5E63 6563 6159 595C 6263"
	$"6069 6255 5F5D 625D 5662 5D64 6462 5D59"
	$"4C5C 666B 665B 605E 6165 6664 6660 6C67"
	$"6268 5B5C 6260 5F64 6062 6667 635C 6463"
	$"6A6A 6266 6570 6C5C 5E63 6463 575F 6560"
	$"6567 615F 6F65 665B 5C56 798E 969B 9E94"
	$"6D43 566D 8E9F B0B0 ADAF A5A9 9E87 607B"
	$"7A68 605B 638B 8688 6C46 5B7F 5855 5D5F"
	$"5D5A 5456 5A59 585C 605F 5E56 5657 5E5E"
	$"5B62 5D52 5C5A 605A 525C 5861 605F 5855"
	$"4857 6167 6357 5D5D 6060 615F 635B 6663"
	$"5E62 5858 5E5F 5E61 5D5E 6262 5E58 5F5D"
	$"6767 5F62 626C 6758 5A5F 6061 555D 615D"
	$"6160 5B5B 695F 6056 5C64 746B 605B 5A59"
	$"746B 6F73 7E7B 7E6A 6E76 6A71 789B 958C"
	$"858E 8C79 708E 4439 7989 5F58 2A55 5E60"
	$"5D5A 5457 5B5A 5A5D 605E 5D57 5859 5E5E"
	$"5C63 5D53 5C57 5E5A 525C 5761 5E5D 5956"
	$"4A56 5F66 6357 5D5E FE60 4E5E 605A 6764"
	$"5F64 5957 5B5D 5D60 5B5D 6262 5C56 5E5C"
	$"6464 5D61 6169 6759 595D 5F5E 525A 605E"
	$"5F5F 595A 685C 5E54 5974 AA7F 493F 3836"
	$"7FBC BD9B 8459 4328 252D 2A34 3C84 AEA3"
	$"7991 ADAC A9C3 8877 A2B1 017F 115B 505C"
	$"605C 6261 6061 5D5F 5E5E 6462 5B5E 64FE"
	$"606A 6264 6262 5D5E 6562 6562 6165 5C5B"
	$"6965 5861 6766 6C64 645B 615A 5B62 6D70"
	$"6461 6D67 6168 665E 5C66 6770 6C6A 6362"
	$"646E 6A68 5A63 6A6C 6B5C 646B 6364 5E62"
	$"6460 6068 6267 7069 6861 6678 7A7B 8090"
	$"9091 8597 A3AD B4A2 B3A9 AAA8 A691 7252"
	$"5547 4364 8797 95A7 816B 6272 547F 4B5A"
	$"5C55 5B5C 5D5E 5B5B 5959 5F5E 5658 615C"
	$"5C5D 5E61 605E 595B 625F 605D 5E62 5755"
	$"6261 545B 6263 685F 5F56 5D57 585D 676B"
	$"5D5C 6963 5D65 645D 5A61 626D 6865 5E5E"
	$"626B 6764 5A61 6665 675A 6169 6162 5A60"
	$"615E 5D64 5F65 6B66 635B 657F 7066 5A5B"
	$"5774 7D7E 767A 775D 7D6D 737C 828B 9A93"
	$"9288 8773 5548 3F7B 6876 907B 594D 1059"
	$"5D59 5C5A 5F61 5A59 5859 5F5E 575A 605C"
	$"FE5D FE5F 655A 5B62 5E61 5C5E 6358 5663"
	$"6154 5C63 6369 605F 575D 5758 5C67 6A5D"
	$"5C68 625B 6361 5957 6163 6C67 645C 5D61"
	$"6962 6156 5F66 6365 585D 675F 5F59 5D5F"
	$"5B5A 635C 6168 6161 5A6F AC8E 6750 4636"
	$"5982 6F42 332C 1C35 242A 3649 6091 B2B8"
	$"AEB2 AE91 735B 9E98 A2B8 9801 807F 4755"
	$"615C 5E5F 5E62 5F5C 6063 6364 6260 6366"
	$"555D 6561 6363 5C5D 6866 6761 6065 6B65"
	$"626F 5D56 6257 6865 6363 5D61 6665 6F69"
	$"645C 6367 615C 6364 6265 666C 6F6F 6A6E"
	$"6D66 6A67 6A65 5859 5566 6F71 615E 6960"
	$"5961 6866 6A61 6669 646F 725F 655D 7292"
	$"A4AA AEAD ABA8 ADB0 A8A8 998E 846D 594E"
	$"524A 5178 96A1 AA96 7D58 668D A346 0152"
	$"5EFE 597A 575C 5A56 5B5F 605F 5F5B 5E64"
	$"5359 625D 5F60 5A5A 6363 645E 5B60 6761"
	$"5E6C 5951 5F55 6661 5D5E 595D 6261 6A64"
	$"5F57 5E62 5B57 5F5F 5E5F 5F63 686A 6368"
	$"675F 6663 6462 5757 5263 6E6D 5F5C 645A"
	$"565F 6762 655D 6163 606A 6463 7F78 6365"
	$"6E75 7A74 716F 7779 7181 848A 9899 9692"
	$"9188 7867 505B 6F55 8197 8368 4A49 567C"
	$"5E58 5B5B 575D 5B56 5A60 615E 5F5C 5F63"
	$"545A 625D 5F5F 5A5B 6362 625D 5B5F 6560"
	$"5E6A 5750 6057 6761 5B5E 595C 6161 6964"
	$"5E55 5C60 5854 5E61 5C5C 5F64 6767 6166"
	$"665E 615E 625F 5456 5262 6C6A 5D5C 6358"
	$"565D 6560 635B 5F60 5D66 638B CBBE 965F"
	$"4B3A 3A2C 2527 2E2D 2838 4664 90A7 B0B7"
	$"B6AF AEA8 8151 3830 91BD A67B 5301 7F74"
	$"585D 6262 5955 5C62 6053 5F61 6166 6164"
	$"6865 6267 6460 5F65 5E66 636B 6766 5E5E"
	$"6967 6964 605C 6567 6B5F 6566 6B6E 6365"
	$"6661 6365 685C 605A 6265 5E5D 6364 6469"
	$"616C 6A63 6967 5F6B 5D5B 656C 686A 626B"
	$"675C 6764 5F5F 6566 686B 6A68 674B 617F"
	$"97A1 A8AF ABAA A2AA 9B8A 7561 5453 5150"
	$"5257 5558 8DFE A207 A680 6D72 94A1 A051"
	$"6C56 5A5C 5450 555C 5D52 5C60 5D62 5D5E"
	$"6160 5D62 625D 5D62 5960 5F68 6262 5C5B"
	$"6563 6662 5D58 6063 685D 6262 6768 5E5F"
	$"5E5B 5D60 6257 5A55 5D5F 5958 5D5C 5D65"
	$"5B65 645D 6261 5A66 5A58 6167 6365 6068"
	$"6258 6560 5B5B 6163 6367 675E 6566 7172"
	$"786C 7574 6B6F 6B7F 8387 8C8B 8E94 FD92"
	$"0E8E 6B50 4E60 766F 578C 6F40 393A 5758"
	$"FF5A 7A55 5156 5B5B 525F 625E 615D 6061"
	$"615E 6261 5E5E 6058 6160 6863 625C 5A64"
	$"6468 605C 5761 6165 5B61 6366 655C 605F"
	$"5A5C 6062 585C 545C 6058 575D 5C5C 6259"
	$"6363 5C5F 5D57 645A 565F 6662 635D 6860"
	$"5566 615D 5B5F 5F60 6563 6289 AEAC 825D"
	$"352F 2E23 2524 3944 5D7B 93AB B9B8 B5B2"
	$"B5B5 9F80 6149 3230 4CAE 9C58 5876 017E"
	$"FE59 365E 5D57 5E5A 6658 5D64 6863 626A"
	$"6264 635F 6063 6261 6064 6269 6864 6568"
	$"6A6B 685E 6865 6364 676C 6862 676B 5F62"
	$"6968 6267 6A6A 6D6C 6C6A FE5A 0558 6D62"
	$"5E65 62FE 6A39 6B72 7065 6262 6365 6668"
	$"6B5E 666E 6066 6764 6568 6778 8193 AFA2"
	$"ACA5 AFA8 A08F 7D68 5960 625C 6551 5152"
	$"5453 5E7F A8A4 9FA4 9B81 7083 9CA2 A252"
	$"7F52 5458 5651 5753 6254 5B61 625D 5B64"
	$"5D5E 5E5A 5C5E 5E5C 5A5D 5C63 6362 6366"
	$"6665 655A 6461 5F5F 6268 6560 6467 5B5E"
	$"6464 5E62 6665 6566 6865 5454 5554 695C"
	$"575E 5D64 6565 666B 6960 5D5C 5B5D 6062"
	$"6657 6069 5C62 6460 5F61 6365 6473 8466"
	$"7063 7574 7A84 898B 8A8C 8C86 9592 9092"
	$"928E 7951 6F78 6A68 4C68 8F47 2F37 3B55"
	$"516B 5556 5653 5B55 6358 5D61 615E 5D66"
	$"5C5D 5C5A 5D60 5D59 595E 5B62 6361 6468"
	$"6865 655B 6663 5F5E 5F67 6460 6464 5A5F"
	$"6261 5E61 6363 6564 6463 5355 5551 6659"
	$"555D 5B63 6464 6569 675D 5A59 595B 5E60"
	$"6255 6069 5C62 615D 5D5F 6274 7054 532C"
	$"291F 2D2B 3B55 748F A3A5 9E9D A9AF FDB2"
	$"0CAF 7948 2D25 2D41 85B9 6E60 807F 0180"
	$"7F5C 505A 625B 5959 5D64 6668 6760 5D66"
	$"6563 6763 5F62 554F 5B62 6762 656B 6F66"
	$"6561 6266 666A 615A 5F66 6563 646D 6F6F"
	$"6260 6468 6A67 7165 5F67 6C62 615E 6867"
	$"6061 5D5F 6A6F 736D 6F6A 6E61 455B 6869"
	$"616B 6C5F 696C 696D 735C 4B78 ACAA A7AA"
	$"A8A4 9D91 7759 5154 5B83 9EA7 9E87 574F"
	$"5450 5581 A6A3 A1A8 A3A2 878B 8C9D A0A0"
	$"557F 4C56 5D56 5555 575F 6161 605A 565E"
	$"5D5C 635D 595E 514B 565E 625D 6067 6A62"
	$"605B 5C61 6164 5E57 5B62 5F5E 5F68 6767"
	$"5D5C 6264 645F 6B61 5B61 665A 5B58 6362"
	$"5A5D 585B 6469 6C67 6964 6A60 4255 6164"
	$"5E67 6659 6467 6368 6E57 4664 7965 5D6E"
	$"7174 7D85 8E8B 888B 897F 7475 738F 938E"
	$"9190 7F57 6166 6471 5F40 497E 4333 373C"
	$"5B4C 0158 5CFE 5777 5B63 6364 6159 565D"
	$"5E5B 625F 5C61 544C 585D 625D 626A 6B62"
	$"635C 5C62 6365 6058 5B62 615F 6068 6766"
	$"5B5A 6063 655E 675E 5961 6559 5855 605F"
	$"585B 575A 6365 6863 6460 6A5E 4255 6062"
	$"5B63 6358 6366 6368 6E56 475D 5734 2A48"
	$"4233 405F 829F AFAF AC88 4C36 315F A1B1"
	$"B5B3 AD8C 5232 433D 344F 72A5 5F65 7269"
	$"0180 7F5B 615A 5862 6061 625C 5E60 5B5E"
	$"696C 6668 655C 5D63 6863 6367 6C67 666E"
	$"6E66 665F 6068 6668 6B5F 5F62 6467 6B6B"
	$"6C68 6A6A 696C 6B6A 6861 5D6C 5F68 6262"
	$"645F 5858 5E68 6966 646D 6C73 716C 5C5E"
	$"6964 5A57 5C65 6B6A 6D74 6F64 79A6 AEA6"
	$"9CA1 8367 5656 5973 8E9C A7A9 A6A6 997A"
	$"5355 5954 79A0 AB9F A0A4 9CAC 99A1 9D9E"
	$"9F9F 547F 5C57 555E 5B5C 5D57 595A 5559"
	$"6467 6060 5F57 575A 6260 6064 6763 6167"
	$"6660 6259 5A63 5F61 685E 595F 5F60 6465"
	$"6561 6565 6467 6664 605A 5864 565F 5C5D"
	$"5F5B 5655 5A64 6460 5E67 666C 6967 5958"
	$"635E 5453 5A62 6766 686C 6861 6470 6248"
	$"3F7A 8D8B 8C8F 9089 7B7F 7F60 5253 6899"
	$"9290 9386 5F57 6D44 4056 606D 4749 3933"
	$"343A 5A5D 7C57 555E 5B5C 605A 5B5C 565B"
	$"6565 6061 6058 5A5E 625E 5F63 6663 6168"
	$"6761 645C 5B63 6162 685D 595D 5E60 6465"
	$"665E 6265 6265 6461 5E59 5663 545E 595B"
	$"5D57 5455 5860 615E 5D66 6568 6766 5758"
	$"635E 5552 5861 6464 686E 6762 634F 4051"
	$"5564 7C91 A9B9 BEA7 6A4D 4A2B 2125 2D7A"
	$"ABB2 B5AE 9964 374A 684C 293D 485D 5470"
	$"7976 0180 4C62 655E 6261 6163 605D 635D"
	$"515D 625F 6768 5C58 6064 6366 6165 6A6B"
	$"696B 6A6B 6964 6269 6967 6660 656A 6360"
	$"6067 6E6D 686C 6B6C 6E68 6252 606A 6163"
	$"6560 5C5C 5B5F 656B 6B65 6870 756D 5F60"
	$"625C FE64 2F60 6567 6366 716B 7176 9DAC"
	$"A2A7 9A78 4C4A 4B50 709C A2A9 ABA5 A79F"
	$"935D 505C 525D 8DA7 A0A0 A1A0 9EAB 979C"
	$"A09E A0A2 5C5E 6059 5C5B 5C5F 5B59 5F58"
	$"4B58 5C5A 6163 5650 585E 5E60 5A5E 6265"
	$"6365 6567 635E 5D66 6460 605F 6063 5D5C"
	$"5A61 6866 6165 6566 6862 5D4D 5961 5C5E"
	$"625C 5657 575B 6067 655E 6069 6D65 5859"
	$"5D58 5F5E 5E5B 6163 5C5F 6962 6A68 6A59"
	$"3D39 4686 92FE 901D 856B 5969 6851 5259"
	$"8A97 8E93 8D82 565E 553B 485A 676F 3C33"
	$"3836 383C 605D 7C57 5C5B 5B5E 5C5A 615A"
	$"4D5A 605C 6265 5852 595E 5F63 5D60 6364"
	$"6265 6768 645E 5E68 645E 5F5D 5F63 5D5B"
	$"5A61 6766 6065 6364 6660 5B4E 5A62 5A5E"
	$"625D 5755 565B 5F65 655C 5E69 6C63 5757"
	$"5C58 5E5E 605D 6161 5A5E 6961 6867 5636"
	$"4A73 5F7B B1BA B9BB A356 222B 2A20 2626"
	$"559A B2B5 B0B3 965A 4361 472D 2D3E 3E61"
	$"7661 5A6B 0180 0965 605C 5F5B 5B59 6268"
	$"64FE 5E72 605F 616B 6265 6161 6267 6261"
	$"6269 6863 6F6E 6E6A 686D 695D 6961 5E6B"
	$"5F66 6E6C 6656 3B50 625C 5A60 7063 5A64"
	$"6261 605B 5E46 5967 6A69 6951 5574 7361"
	$"4640 575B 545D 615E 6466 6064 6669 718A"
	$"A99E 9DA2 875F 4545 476B 95A4 A4A7 A3A8"
	$"A2A1 9674 6052 537F 9EA8 A19C A1A1 A4A0"
	$"9A9B A0A5 A5A0 6008 5B57 5B56 5553 5B61"
	$"5EFE 5851 5B5A 5D66 5E63 5C5F 5E60 5E5D"
	$"5E65 635D 6969 6664 6467 6459 645C 5864"
	$"585E 6767 6051 3548 5C55 5257 6A5F 545E"
	$"5C5B 5B58 5B41 5361 6464 654E 536D 6D5A"
	$"403B 5457 4E56 5955 5B5F 5B5F 5E61 6A6A"
	$"5B3C 363C 598A FE8E 1E83 6353 5555 4C50"
	$"5368 8590 938A 835F 5871 5B4D 6475 7352"
	$"3836 3B47 483D 645B 0758 5D56 5655 5C61"
	$"5EFE 5A71 5C5A 5D6A 6264 5C5F 6063 5F5E"
	$"5E65 635F 6C6B 6864 6367 6457 635B 5763"
	$"585E 6664 5F52 364A 5C55 5156 675D 545D"
	$"5B5B 5A56 5B41 5361 6564 634A 536D 6A57"
	$"3F3B 5458 4F57 5953 585D 5B5E 5F5E 6765"
	$"443B 727A 5C8D B1B5 B7A3 5027 2A31 3635"
	$"292E 4A7E A9AD AE98 6B43 3853 4A33 3039"
	$"4B64 6437 2649 0180 7F5C 5F60 6160 6360"
	$"6267 5E62 655B 5F59 5E68 6662 6268 6164"
	$"6062 6069 6966 6C5C 5E6B 6D6C 666B 675A"
	$"6966 646D 6D6C 615F 4A44 5D4F 525E 6D6A"
	$"6768 6154 5863 6762 5B5D 6868 6E60 656D"
	$"7067 4E52 6961 5C63 6045 4158 6E76 6F69"
	$"7398 A19D 9E9A 8F54 4D42 6599 A4A5 A5A4"
	$"A7A4 A3A3 A199 6746 6C91 A99C A7A1 A1A6"
	$"A09E A09C 9EA4 AB9F 561E 5B5C 5D5B 5E5B"
	$"5C62 585B 5F56 5C56 5A62 6360 5E62 5D61"
	$"5E5E 5A63 625F 6456 59FE 655D 6064 6156"
	$"645F 5D67 6665 5D5D 4841 584C 4C57 6565"
	$"5F62 5D50 545D 6260 5857 6263 685C 6168"
	$"6A61 4B51 665B 5860 5C42 3E53 6A72 6C68"
	$"695C 4239 3A44 848B 8F90 8866 5159 574E"
	$"4D4A 5056 5D85 9483 7452 7466 726C 6C70"
	$"573E 3A36 3B50 5A40 5A5C 7C5E 5F5C 605E"
	$"5F64 5A5C 6058 5E57 5C65 6261 6164 5E61"
	$"5D5D 5A62 625F 6555 5968 6864 5F63 6257"
	$"635E 5B63 6465 5C5D 4842 584C 4D56 6262"
	$"5E5F 5B4F 535E 625F 5756 5F5F 6559 6266"
	$"665D 4851 665A 565E 5B43 4053 6770 6B66"
	$"6C5F 3351 6959 78A1 B8B5 AD5C 222A 2A2F"
	$"443E 2E27 2749 8DA9 A969 4224 312A 2F39"
	$"3D4D 5C5A 5535 2638 0180 3D5C 4F5A 645D"
	$"5965 6063 6465 6062 6058 6B66 5D5B 5D63"
	$"5F6C 6258 5B5A 5550 5F60 6663 5E63 6064"
	$"6767 706C 6C6A 6861 5F57 3D3B 4A48 5968"
	$"6367 585F 6F68 6B6B 66FE 6030 6B66 6E71"
	$"706A 6D6C 6B73 6E56 5C5F 6164 5D59 6D74"
	$"6E6E 818D A09C A1A3 9482 4D60 959F A8A5"
	$"A6A5 A8A5 A3A4 9E89 524F 8493 A4FE A101"
	$"999C FE9B 05A1 A2A0 AD9E 587F 4D56 615B"
	$"5560 5D5F 5C5F 5E5F 5D54 6760 5857 585E"
	$"5A67 5E53 5455 534C 595C 635F 585D 5B5E"
	$"6261 6A66 6665 625C 5A50 3636 4748 5763"
	$"5C5F 5057 6A64 6768 645E 5E5D 6861 686B"
	$"6B64 6766 656D 6851 575B 5E61 5B59 6A6E"
	$"675F 482C 3B3C 434B 5C92 878C 7D53 6162"
	$"544E 514F 5353 5683 8C85 725D 7B71 6B61"
	$"483E 3B38 363A 4350 6042 5B4F 075C 625B"
	$"5763 5E5F 5DFE 6071 5E56 685F 5857 585F"
	$"5D69 5D54 5857 544D 5B5C 625F 595E 5A5C"
	$"6161 6866 6664 615C 5B51 3637 4A4B 5861"
	$"5B5D 4E55 6761 6566 615F 5E5B 665F 676A"
	$"6A63 6664 636A 6651 5759 5B5F 5856 686C"
	$"665F 6458 5350 5A44 388B A9B7 852C 2D2A"
	$"2C2D 2D29 2A2A 2550 8FB1 A653 362C 2A25"
	$"3E60 595E 7270 4327 3245 0180 775F 5664"
	$"6055 6068 6164 6864 5F5C 5E5E 6562 5861"
	$"6565 5E68 625E 5D69 6A69 6962 676A 6561"
	$"656D 6758 6B64 6D6B 615F 5F5D 4F54 5963"
	$"6460 5C66 5A58 7475 6F6A 606E 6360 6872"
	$"6665 716A 7274 7371 6E64 5A5D 6E69 5B6D"
	$"7169 6978 9195 999F A0A1 A08E 6082 A49E"
	$"A6AB A5A5 A7A3 A5A2 966E 4666 879E A3A0"
	$"A5A4 979E 97FE 9B04 9D9A A4A0 5C46 5560"
	$"5D54 5C62 5C5E 605D 5C58 5959 605B 525C"
	$"6160 5862 5D59 5765 6865 675F 6365 605C"
	$"5F68 6051 655E 6866 5E5C 5B5B 4D51 565F"
	$"5E5C 5761 5752 6A6D 6965 5B6A 615C 626A"
	$"605F 6A66 6EFE 6C35 6A62 5859 6862 5668"
	$"6B64 6254 3A2D 323B 3C3C 3F70 9090 6B52"
	$"6B75 4F3F 4844 5053 6891 8590 6460 6B65"
	$"7465 3A3E 3737 3635 363C 564C 6055 2963"
	$"5E57 6166 5E60 6361 5F5B 5B58 615D 545E"
	$"6261 5A64 5D59 5966 6866 655E 6263 605D"
	$"6066 5C4E 625D 6764 5CFE 5B4F 4D52 5860"
	$"5F5C 5861 5653 6B6C 6763 5A69 605C 626A"
	$"615E 6A66 6D6A 6A69 6761 5857 6760 5365"
	$"6760 6052 4B5F 6B70 7061 354D 9CB3 5623"
	$"3333 435E 4A47 3C28 337A A0B8 9551 3843"
	$"3937 575A 5374 7772 6549 404A 0180 6055"
	$"5765 585C 6051 5664 585F 6460 6065 6059"
	$"6161 5E5E 6366 695D 656B 6970 6464 6B5C"
	$"4F5B 666B 5A54 646D 6C65 6A5E 5C62 7161"
	$"5459 5358 6F54 5557 6C71 6A68 5D5F 5C56"
	$"5864 6058 666A 706C 6D61 5B68 5B60 7165"
	$"656B 6A6B 768B 9B91 99A0 A09E 9E83 5C86"
	$"FEA5 1BA9 ABA2 A2A4 A69B 804D 5265 7E98"
	$"9CA0 AC97 8D9E 959B 9998 9A92 9EA4 4F7F"
	$"5461 5456 5B4A 4E5E 525A 5F59 5B61 5B54"
	$"5C5C 5958 5E61 6356 5E64 626B 5F5E 6759"
	$"4C55 5F68 554F 5E66 6762 6557 545D 6D5A"
	$"4C52 4E54 6C4F 5254 666D 635F 575B 5851"
	$"525C 5A56 6165 6966 655A 5766 585A 6C5F"
	$"5C61 6366 6552 412C 323B 3731 3B71 908A"
	$"725F 585F 5440 494D 525C 8786 8E8F 5A58"
	$"5854 6945 5C67 3A37 3533 3130 5555 5354"
	$"7C63 5358 5E4F 505E 535B 5F5B 5B5F 5A53"
	$"5B5C 5958 5E60 6256 5D61 5F68 5E5D 6658"
	$"4A53 5D65 544E 5B62 6460 6356 535B 6B58"
	$"4A50 4E53 6A4E 5052 666B 625D 545B 574F"
	$"505B 5752 5D63 6761 6157 5463 5657 685C"
	$"5B5E 5C60 5D40 3E59 737A 7A75 5F62 A39F"
	$"4427 2A3B 5658 3736 2F2B 5B94 AEB2 8F7E"
	$"7E69 444C 897A 3C61 7475 7769 5A4E 0180"
	$"4B57 5F5A 4E58 4D50 636E 6363 6C5F 5966"
	$"6A5E 6B6A 5A5C 636B 6350 6367 666D 666C"
	$"6562 6866 5E68 6C5C 6671 6A65 6158 5E61"
	$"6950 324D 626D 5945 646F 676B 605B 4E5E"
	$"6360 6763 636B 6153 6266 655B 62FE 6F30"
	$"6B60 6161 6862 7894 A093 999E 948C 7365"
	$"7298 A7A6 A3A4 A5A4 A4A6 A08F 5B4F 5B52"
	$"6960 7D98 9070 546B 8E9B 9A9A 9896 9E9C"
	$"507F 5A56 4953 484A 5B67 5D5E 6658 525F"
	$"635A 6664 5356 5D64 5F4D 5D60 6067 6065"
	$"615F 6360 5863 6857 616B 6460 5C52 595C"
	$"644E 2E48 606B 5540 5F6A 6063 5955 4959"
	$"5D5C 645F 5E65 5B4D 5D61 5F55 5D68 6967"
	$"635B 5B59 6358 4C4E 4B35 3B38 3357 798F"
	$"8273 6455 473D 3D44 5053 5380 8C85 948B"
	$"928E 6D3B 5572 8287 6242 3A34 3135 4841"
	$"545B 7C56 4C55 494B 5D68 5C5E 6757 515F"
	$"6258 6464 5557 5D64 5E4E 5E5D 5D65 5F63"
	$"5F5E 605E 5861 6559 626A 615D 5951 585A"
	$"614B 2E47 5E6B 543F 5E68 5F61 5854 4858"
	$"5C59 615C 5B63 594C 5A5B 5C53 5B65 6361"
	$"5F59 5A56 5E55 4434 363B 556E 738D 9EA8"
	$"975A 2E2B 4068 7B53 2926 224B 8AA8 B1AA"
	$"B5B4 A671 7494 A6AB 713B 4561 6367 6B5C"
	$"0180 1067 604D 3E41 536A 6A61 636D 6758"
	$"6570 6965 FE60 6B68 6457 545E 696E 615E"
	$"6863 636C 635C 5B67 6E6B 5B5F 5E58 6165"
	$"5E62 675E 5865 6167 5361 6C5B 5461 5C5C"
	$"605F 5E6B 716D 6B64 5C59 6864 6264 6763"
	$"605D 6066 6167 6267 8199 A197 9C9B 8C7C"
	$"4F7A 9EA3 A2A6 A6A4 A5A4 A99F 9E79 4861"
	$"5059 5A43 5970 5D41 5349 6C94 9797 9A99"
	$"9795 5F7F 5C4A 3A3D 4F64 645B 5C67 6253"
	$"606B 6460 5A58 5861 5E52 4F59 6468 5A57"
	$"625D 5C66 5F56 5562 6763 5458 564F 575F"
	$"585B 6158 525F 5B61 4B5B 6756 4F5E 5656"
	$"5A58 5764 6A67 655E 5752 625F 5D5E 605D"
	$"5957 585D 5A63 5E49 344B 5643 3E33 437E"
	$"8D87 6856 4C4E 4A3F 4550 5B53 7599 8095"
	$"8C90 978A 8173 8481 8E89 8657 3739 3934"
	$"3230 645A 7C49 3B3E 4E63 645C 5D68 6453"
	$"6068 625F 5958 5760 5C51 505B 6266 5957"
	$"635D 5A63 5B55 5563 6662 5357 534D 575E"
	$"5758 5D57 515B 5960 4957 6353 4E5C 5453"
	$"5655 5561 6660 605B 5653 5F5A 5A5B 5D5A"
	$"5552 545B 565E 5A4B 383D 251C 4D70 7FA4"
	$"AD9F 4C22 2935 3E61 512F 281F 3A85 9FB6"
	$"AAB1 B6AC ACA0 A8A6 B4AA A968 424B 4B58"
	$"6769 017F 7F69 5F57 5E62 6966 5E59 5C57"
	$"4B57 605E 5C56 525F 6162 5E52 5D5F 6869"
	$"5C5B 5360 6969 6666 635E 5A4E 5052 4F58"
	$"6267 5C59 5963 615C 5051 5C67 4F3A 504B"
	$"575C 6159 596C 7271 676A 6663 5F4E 4D55"
	$"5957 5859 515C 6065 5C79 8A99 A198 998E"
	$"8E86 8093 9FA5 A6A7 A3A5 A49D A495 8965"
	$"525A 4F5C 4A44 4650 4043 5542 6B8F 9696"
	$"9D9F 9A9A 6210 5E56 5A5C 6461 5955 5852"
	$"4551 5B59 5851 4DFD 5A6A 4E57 5A61 6258"
	$"584F 5A60 6261 605D 5955 494B 4D4C 545C"
	$"5F55 5252 5C59 5549 4A57 624A 364C 4551"
	$"575C 5453 656A 6862 6560 5E59 4B4B 5254"
	$"5253 544B 5459 624D 3D28 4A5C 3F37 3E3F"
	$"4279 674E 514C 4F49 484E 5875 8299 9286"
	$"9189 938B 8B8C 9180 7E8E 8483 4733 343B"
	$"413E 4263 5A7C 535A 5C62 5F58 5457 5144"
	$"515B 5755 504C 595A 5A59 4D57 585F 6055"
	$"564E 595E 5D5D 5E5A 5654 494A 4B4B 5459"
	$"5D53 5151 5957 544A 4B55 5E49 374D 4551"
	$"5357 5150 6265 625C 615F 5C55 4A4B 5051"
	$"4F51 5149 5356 5D4C 4442 3522 365C 6378"
	$"7A96 561F 2730 343C 492E 2538 4784 A8A5"
	$"B0A9 B3AC ACAE B3A5 A5B0 A3A8 6153 5E66"
	$"4635 3B00 00FF"
};

resource 'PICT' (132) {
	34516,
	{0, 0, 88, 134},
	$"0011 02FF 0C00 FFFE 0000 0048 0000 0048"
	$"0000 0000 0000 0058 0086 0000 0000 00A1"
	$"01F2 0016 3842 494D 0000 0000 0000 0058"
	$"0086 4772 8970 68AF 626A 0001 000A 0000"
	$"0000 0058 0086 009A 0000 00FF 8218 0000"
	$"0000 0058 0086 0000 0004 0000 0000 0048"
	$"0000 0048 0000 0010 0020 0003 0008 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0058"
	$"0086 0000 0000 0058 0086 0040 0190 1E69"
	$"6869 6B6B 6D6E 7170 7174 7679 7A7D 7D7E"
	$"7F81 8283 8485 8586 8585 8687 8889 FE8A"
	$"FF8C FF8E 128F 8E8E 908F 8F90 8F90 8F8F"
	$"908F 9290 9193 9292 FC91 4192 908F 8E8F"
	$"8E8D 8D8C 8C8B 8A89 8A87 8786 8685 8380"
	$"7E7E 7B77 7371 6D6A 6254 4339 3431 2F2C"
	$"2929 2421 1F1F 2020 1F1D 1D1C 1915 1826"
	$"2D2F 3031 322F 2E2C 2634 3B3C 2F17 2F1C"
	$"3133 2C1F 5757 585A 5A5C 5D60 5F60 6263"
	$"6667 6B6B 6C6C FE6D 036E 6F6F 70FE 6F02"
	$"7071 72FE 73FF 74FF 7514 7675 7577 7675"
	$"7676 7778 7779 7879 7778 7979 7878 77FD"
	$"7803 7776 7576 FE75 3374 7574 7372 7370"
	$"7170 6F6E 6E6C 6A69 6666 635F 5E5A 564D"
	$"3E32 2E2C 2B28 2525 2322 201F 1E1E 1C1A"
	$"1A19 1817 1927 2D2E 3033 3330 2D14 2D28"
	$"3437 3628 2716 2C2E 261A 4039 3A3F 3E40"
	$"4142 41FE 42FF 45FF 4701 4847 FD48 FF47"
	$"0648 4747 4647 4849 FE4A FF4B FD4D 114C"
	$"4E4D 4D4E 4D4E 4D4B 4D4C 4D4B 4C4F 4E4B"
	$"4BFE 4CFF 4B03 4A4C 4D4D FE4C FF4B 0F4A"
	$"4949 4A47 4847 4645 4644 4243 4342 40FE"
	$"3D18 3935 2A1F 1B19 1715 1212 0F0D 0B0C"
	$"0D0C 0B0A 0A09 0908 0A18 1DFF 1C0F 1E20"
	$"201E 1B19 2626 2516 1606 1B1C 1508 0189"
	$"1169 686A 6A6B 6E6E 7071 7174 7678 7B7D"
	$"7C7D 80FE 81FF 8400 86FE 85FF 8700 89FE"
	$"8A09 8B8C 8C8E 8E8D 8E8E 9090 FE8F 1191"
	$"8F8F 9091 9492 9293 9493 9394 9393 9292"
	$"91FE 8F08 8E8D 8D8C 8B89 8A89 8AFE 8617"
	$"8483 8381 7F7E 7975 7271 6D68 6155 4439"
	$"3531 2D2C 2C2B 2524 FE22 1520 1F1C 1C1A"
	$"1816 1827 2E30 3235 3725 221E 0520 3C3D"
	$"2B1D 281D 362F 2B22 5857 5959 5A5D 5D5F"
	$"6060 6263 6569 6B6A 6B6D 6D6E 6C6E 6E70"
	$"FE6F FF70 0072 FB73 FF75 0F74 7575 7777"
	$"7676 7778 7777 7978 7977 77FB 78FE 77FD"
	$"7600 75FD 7403 7273 7273 FE6F 2A6E 6D6D"
	$"6B69 6865 6462 5E5D 5A55 4C3D 312D 2C2A"
	$"2827 2622 2320 2120 1F1E 1D1D 1B19 1719"
	$"282F 3234 3432 1B18 231C 071F 3937 231F"
	$"1532 2B26 1D40 393B 3E3E 4141 4042 4243"
	$"4345 4747 4647 4848 4948 4946 47FE 48FF"
	$"4700 49FE 4AFE 4BFF 4D04 4C4D 4C4E 4EFE"
	$"4D09 4E4C 4B4D 4C4E 4C4C 4D4E FD4D FE4C"
	$"0C4B 4C4D 4D4C 4B4B 4A4A 4849 494A FE46"
	$"0845 4446 4442 4342 403E FE3D 183B 342A"
	$"201C 1917 1514 130F 0F0D 0D0C 0B0A 0A0B"
	$"0808 0709 181F 1123 2426 230B 060B 0016"
	$"2724 0F0D 061F 1812 0A01 82FF 69FF 6A13"
	$"6B6E 6F70 7172 7677 787B 7C7D 7D7F 8181"
	$"8284 8486 FE85 FF87 0088 FE8A 118B 8C8D"
	$"8F8E 8D8E 8F90 908F 908F 9190 8F91 91FA"
	$"9345 9492 9391 9292 8F8F 8D8F 8E8F 8D8B"
	$"8A89 8888 8786 8583 8382 807E 7E7A 7572"
	$"726D 6861 5545 3835 322F 2F2E 2B26 2423"
	$"2322 201F 1B1B 1919 1619 2933 2C27 271A"
	$"1F29 1D06 193C 3B2B 1D28 1C37 2E2A 2357"
	$"5859 595A 5D5E 5F60 6163 6365 686A 6B6A"
	$"6B6D 6D6C 6D6E 70FE 6FFF 7000 71FC 730E"
	$"7476 7675 7676 7777 7678 7779 7877 79F9"
	$"782F 7976 7776 7777 7676 7476 7576 7474"
	$"7372 7171 706F 6F6D 6D6C 6A68 6765 6361"
	$"605D 5A55 4C3E 302D 2D2B 2A29 2623 2322"
	$"2221 FD1F 0B1D 1C17 1A2A 312A 2629 1713"
	$"1D17 1602 1338 3524 1E14 322A 251F 403B"
	$"3B3E 3E41 4241 4243 4443 FE46 0247 4647"
	$"FE48 0249 4647 FD48 0147 48FD 4A0E 4B4C"
	$"4E4B 4A4A 4C4E 4E4D 4B4A 4B4B 4CF8 4D03"
	$"4E4C 4D4B FE4C 074D 4B4D 4C4C 4B4A 49FE"
	$"4827 4746 4644 4445 4341 4343 3F3E 3E3D"
	$"3C3A 342A 1F1B 1A18 1716 1310 0F0E 0E0D"
	$"0B0B 0C0C 090A 070A 1A23 111B 1719 0D04"
	$"0507 000C 2722 100F 0823 1912 0B01 8B14"
	$"696A 6B6C 6C6E 6F70 7173 7577 777B 7D7E"
	$"7E80 8181 82FD 8410 8587 8887 8889 8A8B"
	$"8B8C 8D8D 8E8E 8F8F 91FE 8FFE 90FF 91FF"
	$"9201 9394 FC93 FF92 2C91 9291 918D 8E8E"
	$"8B89 898A 8A89 8987 8785 8483 8282 807E"
	$"7D79 7572 716B 6861 5545 3935 312F 2F2D"
	$"2C27 2623 2423 FE21 121F 1E1D 171B 2B35"
	$"242E 3211 1840 2200 1941 392D 0726 1E35"
	$"2A26 2257 59FE 5B09 5D5E 5F60 6263 6464"
	$"686A FE6C FE6D FD6E 0C6F 7171 7071 7273"
	$"7474 7374 7476 FD77 FF76 0377 7877 78FE"
	$"7902 7778 79FC 78FF 773C 7677 7778 7475"
	$"7572 7070 7373 7271 706F 6E6E 6D6C 6C6A"
	$"6967 6564 625F 5C59 564C 3E32 2E2C 2B2A"
	$"2827 2526 2323 2220 201F 1E1D 1D18 1C2C"
	$"321B 1E25 0407 3510 1F00 163C 3326 1D15"
	$"2F26 211D 403A 3D40 3FFE 4109 4244 4344"
	$"4446 4648 4847 FE48 0A49 4646 4748 4948"
	$"4748 494A FD4B 074C 4948 494B 4F4D 4DFE"
	$"4944 4B4D 4D4E 4C4C 4D4D 4C4D 4E4D 4C4B"
	$"4B4C 4C4E 4B4C 4C49 4747 4949 4848 4747"
	$"4545 4444 4543 4243 4340 3F3E 3C3C 3B34"
	$"2A21 1C19 1817 1514 1212 0E0F 0E0C 0D0D"
	$"0C0B 0C09 0C1C 2511 0A07 0D00 0016 0A00"
	$"0F2B 2011 0E0B 2317 0E0A 0185 FF69 156A"
	$"6C6C 6D6F 7274 7678 797A 7D7D 7E7F 7F80"
	$"8182 8281 83FE 85FE 88FF 890D 8B8A 8D8C"
	$"8C8E 8F8F 9090 8E8F 9292 FE91 0092 FA93"
	$"4692 8F91 908A 8176 7880 7270 726E 6E78"
	$"807F 7F86 8786 8481 7F7E 7D7B 7A77 7471"
	$"706C 6661 5445 3731 302E 2C2B 2926 2422"
	$"2124 2222 1F1D 1D1E 1920 2D36 203D 570C"
	$"1A41 3600 184E 372E 141F 2139 271D 2257"
	$"585A 5B5B 5C5E 5F61 6363 6465 696A FE6B"
	$"016C 6DFA 6FFE 71FF 720A 7473 7473 7475"
	$"7676 7778 76FD 7702 7677 77FA 78FE 7911"
	$"7873 6A5E 5F69 5E5C 5D57 555D 6565 646C"
	$"6E6D FD6C 276B 6966 6363 615E 5C58 554B"
	$"3D32 2E2D 2B29 2826 2726 2423 2321 2120"
	$"1F1F 1E17 1F2D 3413 2646 0604 2D14 2E00"
	$"1848 2F23 161B 3320 171C 403A 3B40 3F40"
	$"413F 41FE 430E 4548 494A 4A47 4748 4846"
	$"4747 4647 47FE 48FF 4905 4B4A 4B4A 4A4C"
	$"FE4D 044C 4A4B 4C4C FE4B FF4C FF4B 3E4A"
	$"4C4B 4B4C 4A49 4947 4139 3843 3938 382E"
	$"2930 3939 3741 4849 4644 4445 4443 4342"
	$"413F 3D3C 3A3A 332A 1F19 1816 1615 1312"
	$"110F 0E11 0F0F 0E0C 0C0E 0A0E 1C23 110A"
	$"1426 0002 1214 0015 3B20 1306 0D27 1609"
	$"0C01 8D0C 6A69 6A6B 6D6E 7073 7375 7778"
	$"7AFE 7D0A 7E7F 8082 8281 8183 8585 86FD"
	$"88FF 8903 8A8C 8D8D FE8E FF8F 058E 8F92"
	$"9391 91FE 92FF 93FF 9230 9394 9392 908B"
	$"7B68 615B 5946 3B50 5756 5D67 7077 8086"
	$"8583 817E 7C7B 7A79 7772 706F 6C67 6256"
	$"4637 3332 312D 2B2A 2725 22FE 2314 2220"
	$"1E18 171A 1F2D 3727 3B75 231C 281D 0713"
	$"3130 2B1C 131D 321F 1423 5858 595A 5C5D"
	$"5F60 6062 6365 6669 6A6A 6B6B 6C6E 6F6F"
	$"6EFE 6F00 70FD 71FF 72FE 7300 74FE 75FF"
	$"7705 7677 7778 7776 FE77 FF78 FF77 FC78"
	$"3D75 6552 4B48 4836 2C3F 4441 424A 5157"
	$"626D 6E6C 6C6B 6A69 6866 6362 615D 5C59"
	$"564D 3E31 2D2C 2B29 2927 2726 2324 2222"
	$"2121 2019 1718 1D2D 3618 1F62 1D0F 1E26"
	$"1704 0F30 2C23 0F1E 321E 0F1D 413A 3B3F"
	$"4041 4240 4042 4244 4548 4949 4A47 4749"
	$"4846 4647 4646 47FD 48FF 49FE 4A00 4BFD"
	$"4CFF 4A06 4B4C 4D4B 4B4C 4CFE 4BFF 4AFF"
	$"4B2E 4A4B 4C4B 3E2B 2523 2415 0A18 1913"
	$"141C 2229 3341 4746 4543 4443 4142 4341"
	$"3F3C 3C3B 3A36 2B1F 1A18 1717 1614 1311"
	$"0EFE 10FF 0F06 0D08 080B 0C1C 2411 0C10"
	$"3205 0206 0702 0923 1C12 0210 230F 030E"
	$"0193 FF6A 2D6B 6D6E 6E70 7273 7674 7477"
	$"7C7D 7D7E 7F80 8181 8281 8284 8687 8788"
	$"8788 8988 8A8C 8D8E 8E8D 8E8F 8E8E 8F91"
	$"9293 93FD 9200 93FE 9247 9394 9384 725E"
	$"5654 5445 3D2D 2E3C 3B42 515C 7482 8081"
	$"8380 7D7A 7A79 7876 7371 6F6B 6761 5545"
	$"3933 3232 2C2C 2928 2826 2624 2422 2221"
	$"1B18 1B21 3037 292C 4920 191F 170D 2934"
	$"2B27 120D 202F 2318 2758 5A5B 5B5D 5D5F"
	$"5F60 6363 6467 FE6A FF6B 036C 6D6E 6FFE"
	$"6E0E 7071 7071 7071 7271 7373 7475 7574"
	$"75FE 7604 7776 7678 78FD 7700 78FE 77FF"
	$"7824 776E 5E4A 4241 4133 2E21 202E 2A2F"
	$"3A40 5160 676A 6B6A 6A68 6867 6563 6262"
	$"5D5C 5954 4C3E 32FE 2BFF 2915 2625 2523"
	$"2423 2321 2322 1C18 181F 2F35 221E 3E1A"
	$"0B1A 1815 091F 2A24 220B 1F2F 2112 2141"
	$"3C3C 4041 4142 3F40 4342 4245 FD49 2346"
	$"4748 4747 4645 4547 4847 4847 4849 484A"
	$"4A4B 4C4C 4B4C 4C4A 4A4B 4B4C 4D4D 4C4C"
	$"4B4A 4BFE 4A17 4C4A 4A44 3928 1E19 180D"
	$"0902 040A 0407 1114 242B 3443 4643 FE42"
	$"FF41 0942 403F 3C3C 3B39 342A 20FE 18FF"
	$"1603 1312 1210 FE11 080F 1110 0A09 0C0E"
	$"1F22 110B 0816 0501 080A 020D 0B0B 1101"
	$"131E 1006 1201 9114 6A68 6A6D 6E6F 7071"
	$"7374 7576 787B 7E7F 7E80 8181 82FE 830B"
	$"8685 8686 8788 8989 8A8A 8B8C FE8D 588E"
	$"8F8D 8D8F 9091 9192 9190 9190 9190 9291"
	$"918E 856D 544C 4F5E 675D 4D3D 2D28 253D"
	$"5453 6570 767F 807C 7D7A 7A79 7774 7370"
	$"6D69 645F 5343 3733 3230 2B2B 2829 2824"
	$"2525 2625 2120 2120 1D22 323E 342B 4215"
	$"090C 0E0D 3B46 2B1B 0E0A 272B 221C 2A59"
	$"595A 5C5D 5E5F 6062 FE63 0566 686A 6C6B"
	$"6CFE 6DFE 6E01 706F FE70 0271 7272 FE73"
	$"FE75 FF76 0477 7577 7877 FC78 3179 7778"
	$"7876 7879 776E 5943 3A37 4249 4233 2C23"
	$"1D15 293A 3645 515B 666B 6B6A 6868 6765"
	$"6362 605D 5A58 544D 3E31 2D2B 2A2A 29FE"
	$"2601 2425 FE23 0D22 2122 201A 1F2F 3727"
	$"243F 0F00 0525 0B09 323A 2419 0826 291D"
	$"1624 413A 3B40 3F41 4140 4143 4242 4547"
	$"4949 4747 4848 4646 4746 4746 FE47 0548"
	$"4949 4A4A 49FE 4BFF 4C2A 4D4B 4B4E 4B4C"
	$"4C4D 4D4C 4D4B 4C4B 4D4C 4C4A 4435 231C"
	$"181A 1A0F 0504 0202 030E 140C 1720 2B3D"
	$"4543 4243 44FE 4212 413E 3C3C 3B39 342A"
	$"1F1A 1918 1616 1214 1412 13FD 1006 0F10"
	$"0F0C 1020 2711 100B 2406 0203 0404 130F"
	$"080A 031B 170E 0714 0183 1069 6769 6B6E"
	$"6E6F 7172 7375 7879 7C7E 7F7F FE80 0882"
	$"8483 8485 8685 8587 FD89 FE8B 098C 8D8C"
	$"8D8C 8D8D 8F90 91FC 9000 8FFE 9048 8B84"
	$"7868 5345 4747 615C 5C58 574A 291D 2655"
	$"675A 5866 747D 7C7C 7977 7875 7271 6F6C"
	$"6864 6053 4337 3230 302B 2B2A 2926 2523"
	$"2624 2421 2020 1F19 1E2F 4432 1414 0A02"
	$"0B0D 0432 4126 1418 0D2A 2F2C 2D35 5A58"
	$"5A5B 5D5D 5E61 6263 6465 6668 6A6B 6B6C"
	$"6CFD 6D05 6E6F 706F 6E70 FD72 FE74 0675"
	$"7675 7775 7676 FC78 FF79 FD78 3577 7570"
	$"6556 4236 3832 4740 413F 403A 1E0F 173B"
	$"473F 3F49 5766 6B69 6765 6665 6260 5E5D"
	$"5A58 544E 3F30 2D2A 2B2A 2A29 2624 2624"
	$"2422 22FD 2109 1C20 2F37 1E06 1108 0008"
	$"280E 032E 391F 100C 292A 2627 2F42 3A3B"
	$"3F3E 3F3F 4041 4242 4445 4749 4746 4747"
	$"4847 4647 4746 4746 4547 FD49 0A4B 4A4A"
	$"4B4C 4B4C 4B4C 4C4E F84C FF4D 0D4A 453B"
	$"3020 1516 101B 1212 1012 0FFE 020E 1718"
	$"0F12 2131 3F42 4243 4142 4240 3EFE 3C0F"
	$"3B39 342A 1F1A 1718 1616 1514 1314 1212"
	$"FE10 FF0F 0410 0B10 2029 1110 0005 0301"
	$"0607 0215 1507 0405 1D1A 1617 1F01 900F"
	$"6A69 6A6B 6C6F 7071 7274 7578 787C 7F7F"
	$"FE80 0D81 8383 8484 8584 8486 8789 8888"
	$"89FE 8B0D 8D8C 8D8E 8D8E 8D8D 8F90 8F90"
	$"9091 FE90 4A8F 8D7E 6F61 5444 3C3F 3E48"
	$"4231 4252 452A 231E 314A 433F 5071 7D7B"
	$"7A7A 7877 7571 726F 6C68 635E 5143 3831"
	$"2E2F 2B28 282A 2624 2323 2222 2120 201E"
	$"1A1F 2E3B 2205 0E03 0811 1103 263D 302E"
	$"072D 363F 3E40 405A 5AFE 5B0A 5E5F 6162"
	$"6463 6565 696B 6BFE 6CFE 6DFF 6EFF 6F06"
	$"6E6F 7072 7171 72FE 740A 7675 7677 7677"
	$"7677 7878 77FB 78FF 7717 6A5D 4E43 352F"
	$"332E 3630 1E2E 3B30 1B12 101A 322E 2836"
	$"5260 FE68 1066 6564 6162 5F5C 5957 544C"
	$"3E31 2B28 292A FE27 1324 2525 2423 2322"
	$"2122 201C 2230 3A1F 030D 0206 0F1A 1203"
	$"2136 2A27 2830 3736 3737 413B 3D3F 3D40"
	$"4140 4143 4244 4448 4AFD 4703 4847 4647"
	$"FE46 0545 4647 4948 48FD 4A0D 4C4B 4C4D"
	$"4C4D 4C4C 4B4C 4B4C 4C4D FE4C 224B 4A40"
	$"352B 2113 0B0E 0C0D 0A00 0A10 0801 0100"
	$"050E 0604 0F2B 3941 4544 4240 413F 403C"
	$"FE3B 0439 322A 1F18 FE16 FF13 0715 1213"
	$"1314 1313 10FE 0F03 0B11 1F26 110F 0008"
	$"0000 0605 0013 1D15 1618 232A 2528 2801"
	$"84FE 6A01 6D6E FE70 1573 7576 7878 7B7E"
	$"7E7F 7F80 8082 8384 8385 8485 8686 88FE"
	$"8904 8A8B 8B8C 8CFB 8DFF 8F51 908F 9090"
	$"8F90 908F 8B75 6254 4533 282A 3331 3334"
	$"403E 4343 4032 2420 2435 4F71 7877 7878"
	$"7674 7371 6F6E 6B67 625D 5243 352E 2E2C"
	$"2A29 2927 2724 2423 2221 2222 211F 1D21"
	$"313B 2419 2C24 282D 2F31 373F 4041 1D42"
	$"4041 4041 415A 5B5B 5D5D 5E5F 6063 6364"
	$"6465 686A 6A6B 6B6D 6C6D 6D6E 6DFE 6E02"
	$"706F 71FE 7204 7374 7475 75FA 76FE 77FC"
	$"782F 7775 6250 4336 271B 1D23 1F21 202A"
	$"2427 2620 170B 1014 1D33 5159 6066 6765"
	$"6362 615F 5E5C 5957 534C 3E30 2C2B 2A29"
	$"2828 FD25 1024 2322 2221 201E 1C20 2F39"
	$"2214 261F 2226 1A2A 2C2F 3839 393B 3939"
	$"3837 3742 3C3C 413F 4241 4042 4243 4344"
	$"4748 FE47 0549 4847 4647 46FE 4502 4746"
	$"48FE 49FE 4AFF 4BFB 4C00 4BFE 4C43 4D4B"
	$"4B4C 4C4B 4839 2E26 1908 0102 0801 0305"
	$"0900 0508 0402 0001 0102 0720 2F3D 4544"
	$"4140 403F 3E3D 3B3A 3A38 322A 1E18 1715"
	$"1714 1412 1413 1415 1413 1010 0F0E 0C11"
	$"1F27 110F 0814 0E14 1819 2021 282A 2A29"
	$"2A2C 2728 2801 911A 696A 6A6C 6D72 7271"
	$"7375 7778 797B 7B7D 7D7E 807F 8283 8484"
	$"8586 87FE 8658 8789 898A 8B8A 8C8C 8D8C"
	$"8D8C 8D8E 8E8F 908F 8F8E 8E8F 8F90 8B71"
	$"5A4C 3423 2033 464B 4C57 645F 6673 6F66"
	$"4F31 2849 7A7C 5C6B 7975 7472 7370 6D6B"
	$"6964 615C 5345 342C 2B2A 2928 2A27 2825"
	$"2523 2221 221F 2120 1B21 3039 3638 3EFE"
	$"4105 4344 4242 4041 0C40 3E3E 3F40 3F59"
	$"5B5B 5C5D 5E5F FE61 0464 6566 686A FE6B"
	$"076C 6B6C 6D6E 6D6E 6FFC 70FF 720E 7374"
	$"7375 7576 7576 7576 7675 7677 77FE 78FF"
	$"7744 7875 5E4B 3D28 190E 1B2A 2B28 303D"
	$"3636 3C3B 3426 140E 264E 5641 5265 6464"
	$"6261 5F5E 5C5A 5856 534C 3E32 2D2B 2B27"
	$"2729 2627 2425 2523 2322 1F21 211F 2130"
	$"3832 3137 3A39 39FF 3BFF 3A21 3839 3A38"
	$"3839 3736 413C 3C41 4043 4340 4141 4344"
	$"4546 4647 4847 4949 4745 4746 4546 FC47"
	$"FF49 024A 4B4A FE4C 024B 4C4B FE4C 2A4D"
	$"4E4E 4D49 494B 4B4C 4A38 2B22 0C02 0106"
	$"100E 0C11 190F 1018 150D 0902 0007 1F21"
	$"1531 4542 4240 403E 3F3F FE39 0437 342B"
	$"1F18 FE17 FF15 0E13 1512 1315 1413 100D"
	$"0F10 0E11 1F25 0E1F 1E21 262C 2D2E 2F2D"
	$"2C2C 2D2C 2A2A FE2B 0191 FE6A 146B 6C71"
	$"7270 7376 7778 7879 7B7C 7D7E 7F7F 8183"
	$"8385 FE86 0D85 8786 8788 8A89 8A8B 8D8C"
	$"8B8D 8BFE 8D35 8E8F 8E8E 8F8D 8E8F 8F90"
	$"8463 463E 2D1F 3754 636E 7476 7A81 878E"
	$"8C89 7F73 5C48 545A 455D 7775 7271 706E"
	$"6C68 6864 605D 5244 342D 2C2B FE29 1128"
	$"2626 2521 1F22 2325 292C 3037 3D40 3F40"
	$"42FE 4105 4241 4143 4140 0042 FE41 0240"
	$"3F5A FE5B 025C 5D5F FE61 0463 6465 6669"
	$"FE6A FF6B FF6C 006D FC6F 0C71 7070 7173"
	$"7273 7476 7574 7674 FE76 3975 7675 7778"
	$"7778 7777 7873 543B 3522 0F1B 2F37 3A3D"
	$"3D3F 4243 4545 443F 382F 2635 3E2E 4863"
	$"6462 6160 5F5F 5C59 5855 544B 3E30 2B29"
	$"2927 2828 27FE 2510 2321 2423 2529 2C2E"
	$"3236 3939 3B3B 3A39 3906 3A39 393B 3938"
	$"39FE 3819 3738 423C 3D40 4042 4340 4042"
	$"4343 4444 4546 4747 4849 4645 4647 FD46"
	$"0C48 4747 484A 494A 4B4D 4B4A 4C4A FD4C"
	$"384D 4C4D 4D48 484A 4B4C 4A31 1E19 0900"
	$"0812 1819 1B1B 1C1C 1A1D 1D1A 160F 0702"
	$"0D13 0723 4342 403F 3E3D 3F3E 3B3B 3A38"
	$"322B 1E18 1616 1815 1314 FE13 0A10 0F12"
	$"1114 171B 1F24 2827 1127 282A 2B2C 2C2D"
	$"2C2C 2E2C 2B2D 2C2B 2C2E 2C01 85FF 6AFF"
	$"6B21 6E71 7270 7276 7677 787A 7C7D 7C7E"
	$"7F7F 8283 8384 8585 8684 8687 8988 8889"
	$"8A8B 8B8A FD8C FF8D FF8E 038F 8E8E 8DFD"
	$"8E42 6D4C 3223 2030 5066 727D 8387 898D"
	$"9599 9696 9797 8F69 3027 3854 7175 7371"
	$"6E6C 6866 6864 5F5B 5243 342E 2D2D 2A29"
	$"2927 2729 2A2E 3134 383A 3C3E 3F42 4344"
	$"4140 4141 42FC 4301 4241 1942 4342 3F3F"
	$"3D5A 5B5B 5C5D 5E5E 6061 6163 6465 676A"
	$"6B6A 6A6B 6BFE 6D0E 6E6F 6E6F 6E70 7172"
	$"7172 7273 7474 73FC 75FF 7601 7576 FD77"
	$"FE76 3B5E 422B 1C16 1C2E 3B3F 3F42 4544"
	$"4648 4745 4647 484B 3B18 1525 405C 6563"
	$"605F 5F5D 5C59 5754 524B 3E2F 2A29 2827"
	$"2728 2626 2828 292C 3032 3436 3838 39FE"
	$"3804 3B3A 393A 3BFD 3B2D 3A39 3837 3633"
	$"3131 413B 3D40 4042 4240 4142 4243 4445"
	$"4647 4647 4847 4745 4647 4645 4645 4748"
	$"4948 4949 4A4B 4B4A FD4B FC4C 034D 4C48"
	$"48FE 4A0C 3A22 1107 0608 121F 2120 1E1F"
	$"20FE 210D 1F24 211C 160F 0000 0118 3C44"
	$"413F FD3D FF3C 0C3B 3832 2A1D 1716 1618"
	$"1513 1314 FE16 0919 1D21 2425 292A 2C2C"
	$"2804 2728 2D2E 2DFC 2E07 2D2C 2B2B 2927"
	$"251F 0190 1768 696B 6C6C 6F70 7072 7375"
	$"7475 797C 7B7C 7D7E 7E80 8081 81FE 84FF"
	$"85FF 8603 8887 888B FE8A 078C 8B8C 8C8D"
	$"8D8C 8BFE 8C3A 8D8B 8B8F 8251 2A1F 1724"
	$"4E64 717A 828A 9195 999A 9D9D 9FA3 A6A2"
	$"9554 243F 5963 7170 6E6C 6B69 6866 625D"
	$"5A4F 4133 2D2D 2E30 3031 3537 393A 3B3C"
	$"3CFE 3D10 3F41 3F3F 4344 4341 413F 3E3E"
	$"3C39 3632 32FF 3019 2F2A 2928 5658 5A5B"
	$"5B5D 5F5F 6162 6464 6567 6968 696B 6C6C"
	$"6D6D FC6E FF6F FF70 0372 7172 74FE 733A"
	$"7574 7473 7474 7776 7775 7576 7576 766C"
	$"4521 1811 1532 3D41 4243 4647 4649 494A"
	$"484B 4E4F 4E51 3013 2C3F 4D62 615F 5E5D"
	$"5A5A 5855 5351 4A3E 2E2B 2AFE 2B05 2C30"
	$"3234 3536 FD37 0536 3738 3939 38FD 3901"
	$"3736 1C35 3330 2D2A 2924 2221 1C1B 1A3F"
	$"3A3C 403F 4242 4143 4443 4243 4648 4748"
	$"FD46 0145 46FD 45FF 46FF 4703 4948 494B"
	$"FE4A 004C FE4B FF4C 124B 4A4B 4A49 4A4A"
	$"4C4C 472A 0A06 0206 1A21 2726 FE25 1E24"
	$"2524 2522 2221 1F1F 1D07 0008 1524 4444"
	$"4241 3F3C 3C3B 3A39 3A34 2A1C 1717 FE18"
	$"0819 1D1F 2122 2324 2427 FE26 0325 2627"
	$"29FF 2A0F 2B2C 2A28 2725 221D 1918 120F"
	$"0E0A 0806 0178 016A 69FE 6C12 6E70 7172"
	$"7273 7576 787B 7C7B 7D7D 7E7F 8080 82FD"
	$"840D 8586 8687 8789 8A8A 8B8A 8B8B 8C8C"
	$"FE8B FE8A FF8C FF8A 2D8B 6E43 2014 152D"
	$"596B 767E 8790 999B 9FA1 A3A6 AAAF B3B0"
	$"AC7C 3731 4453 6A70 6E6C 6B6B 6866 625D"
	$"5A4E 4036 3435 37FE 39FA 3BFE 3C10 3F41"
	$"3D3C 3C38 3430 2B29 2321 1F1D 1C19 19FF"
	$"1905 1817 1615 5859 FE5B 0E5D 5F60 6161"
	$"6365 6667 6869 686B 6C6C FE6D FC6E 096F"
	$"7070 7171 7273 7374 73FD 7405 7374 7675"
	$"7574 FD75 0E74 5C3A 180C 0C1D 3B41 4245"
	$"484B 4F4D FE4E 1B50 4E50 5351 5846 1C1D"
	$"2E3E 5A61 5F5D 5C5C 5958 5654 514A 3E30"
	$"2F30 32FE 34FA 36FF 3700 38FE 3707 3634"
	$"2F2C 2924 221D 1F1A 1816 1512 1211 100F"
	$"0E0D 0B41 3A3D 403F 4142 4243 4342 4344"
	$"4547 4847 4645 46FE 4500 46FD 4509 4647"
	$"4748 4849 4A4A 4B4A FA4B FE4A FE4B 154A"
	$"4B3A 1F04 0000 0C23 2627 2828 2A2E 2A2A"
	$"2827 2726 24FE 2218 1601 0008 1C3D 4442"
	$"403F 3F3C 3B3B 393A 3429 1E1C 1D1F 2021"
	$"21FA 23FE 2404 2526 2424 210B 1D19 1713"
	$"110C 0A08 0605 0202 FE03 0202 0100 0180"
	$"216A 696B 6C6C 6E6F 7171 7272 7475 787B"
	$"7C7B 7B7D 7D7E 7F80 8184 8385 8685 8586"
	$"8687 88FE 8AFE 8B00 8AFA 89FF 8B31 898A"
	$"8962 2A1C 1B18 315E 6F7A 838B 9098 9BA1"
	$"A5A7 A8AD B2B9 BDC0 964A 3037 4E6A 6F6E"
	$"6D6D 6B69 6663 5E59 4D41 3A3B 3C3D 3A3A"
	$"FE3B 183A 3B3A 3A39 3935 3030 2821 1D1A"
	$"1716 1413 1412 1010 0F0E 0D0D 1709 0807"
	$"0706 0558 595A 5B5B 5D5E 6060 6162 6565"
	$"6767 6968 69FE 6B0C 6C6D 6D6E 6D6E 706F"
	$"6F71 7071 72FE 73FC 74FC 7300 72FE 73FF"
	$"740B 5425 140F 0B1F 3D42 4447 484B FE4E"
	$"1C4F 504F 4E51 5758 5E53 271B 273C 5A60"
	$"5F5E 5D5C 5A58 5755 514B 4033 3334 FE35"
	$"FB36 0F35 3435 302B 271D 1A16 1310 0F0C"
	$"0A0B 0A11 0A09 0908 0706 0505 0404 0302"
	$"413B 3D41 3F41 FE42 1843 4142 4345 4748"
	$"4743 4545 4443 4544 4544 4547 4646 4847"
	$"4849 FE4A FC4B FF4A FF4B 354C 4B4C 4C4A"
	$"494D 370D 0201 010D 2628 2728 272A 2D2B"
	$"2A28 2624 2425 2527 261B 0501 0623 3D43"
	$"4241 413F 3D3A 3B3B 3934 2A21 2123 2322"
	$"22FA 2308 2220 1C16 1510 0B08 0501 0201"
	$"FE00 0401 0202 0102 FE00 0401 0001 0201"
	$"017E FF6A 0B6B 6C6C 6E6F 6F71 7173 7576"
	$"78FD 7B08 7D7C 7E7F 8081 8382 82FE 8504"
	$"8687 8888 87FC 8AFF 88FE 8735 8887 8688"
	$"8787 8888 6F2D 1319 1833 6071 7B84 8C91"
	$"989B 9FA2 A5A7 A9AE B5C0 C9A4 5230 3550"
	$"6A6F 6D6B 6A68 6765 645F 5B50 4238 3A3C"
	$"3B38 FE37 0C36 3534 3330 2E2F 2B1B 1410"
	$"0C0B FD08 0809 0806 0505 0403 0202 0001"
	$"FC00 1A58 595A 5B5B 5D5E 5E60 6062 6465"
	$"6667 6868 696B 6A6B 6C6C 6D6E 6D6D FE6F"
	$"0870 7172 7271 7373 7474 FC73 0272 7372"
	$"FD71 3D72 7464 260C 0E0B 203D 4143 474A"
	$"494C 4E4F 4E50 504F 5156 5B65 5A2E 1A27"
	$"405B 615F 5E5D 5B59 5958 5450 493E 3232"
	$"3432 3433 3331 302E 2B2B 2826 2621 150E"
	$"08FC 0503 0304 0302 0202 0301 F800 0D41"
	$"3B3C 403F 4142 4142 4142 4343 44FE 4701"
	$"4446 FE45 FF46 0245 4444 FE46 3447 4849"
	$"4948 4A4A 4B4B 4A49 4A49 494A 4B4A 494B"
	$"4B4A 4A4D 430F 0003 0110 292A 2729 2829"
	$"2C2A 2A27 2725 2323 2429 2A20 0601 0C2A"
	$"4143 FE40 193E 3D3B 3C3B 3832 2B21 2123"
	$"2221 2020 1D1C 1815 1412 100C 0902 01FD"
	$"00FF 0002 0102 00FE 0101 0001 FC00 FE01"
	$"0165 726A 696A 6B6C 6E6F 6F71 7273 7576"
	$"787B 7C7B 7B7C 7C7E 7F80 8081 8281 8485"
	$"8586 8788 8987 8889 8888 8989 8887 8886"
	$"8585 8484 8384 8586 733B 1412 193B 6270"
	$"787F 8792 9BA0 A0A1 A4A6 ACAF B2B6 C3B3"
	$"5F2C 2B4B 686C 6B68 6765 6563 6361 5E57"
	$"493A 3838 3638 3533 3031 3232 302F 3032"
	$"301F 1206 0203 F400 FE00 FE01 FF58 FF5A"
	$"095B 5D5E 5E60 6260 6263 65FE 680A 696A"
	$"6A6B 6B6C 6D6E 6F6D 6EFE 6F06 7071 7271"
	$"7273 72FE 7301 7271 FE72 0073 FD71 116F"
	$"7266 3310 0B0D 263F 4242 454A 4B4F 5251"
	$"50FE 5229 5556 5864 6136 171B 3C5A 5F5E"
	$"5C5C 5B5B 5958 5551 4B42 3531 312F 312F"
	$"2D2A 2927 2624 2325 2522 1711 0600 FC01"
	$"FE00 F500 1B41 3A3B 3F3F 4142 4241 4042"
	$"4342 4347 4847 4546 4747 4647 4644 4544"
	$"45FE 4606 4748 4948 494A 49FE 4A02 4948"
	$"49FD 48FF 49FE 4A3A 4119 0203 0216 2D2C"
	$"2828 292B 2D2A 2A29 2927 2627 2826 2925"
	$"0800 0625 413F 3E40 3E3D 3C3B 3D3C 3734"
	$"2F22 1E1D 1C1A 1715 100E 0A08 0807 0907"
	$"0502 03FD 00EF 0001 5A1B 6A68 6A6C 6B6D"
	$"6F6F 7171 7375 7678 7C7B 7A7C 7C7D 7D7E"
	$"7F7F 8180 8184 FE85 0486 8788 8787 FC88"
	$"3D87 8686 8383 8183 8382 8284 8575 3A10"
	$"0E19 4A66 635C 626D 7F92 A0A5 A6A8 A9AA"
	$"A498 91A0 B46A 312D 4D66 6B6A 6865 6465"
	$"6462 6161 5E58 4C45 4140 4140 403F 40FD"
	$"44FF 4503 3E2B 1602 F200 FE00 FE01 1758"
	$"5759 5B5A 5C5E 5E60 6161 6263 6569 6867"
	$"6A6A 6C6A 6A6B 6BFE 6EFE 6F02 6E6F 70FE"
	$"71FC 723C 7170 7071 706E 7070 6E6E 6D70"
	$"6A35 0E0B 0E30 403E 3537 3E46 5054 5556"
	$"5655 5452 4C49 5162 3C1D 1E3D 585F 5D5A"
	$"5B59 595A 5755 5553 4D43 3C38 3636 3435"
	$"35FC 3607 3739 3123 1706 0101 FA00 F500"
	$"0F41 393B 3F3E 4042 4241 3F42 4342 4448"
	$"47FE 4607 4745 4546 4544 4344 FE46 0245"
	$"4647 FE48 FC49 2D48 4747 4645 4447 4846"
	$"4747 4846 1B01 0203 212E 261C 1A1D 272D"
	$"2A2B 2C2A 2825 231D 181B 2B09 0008 2A3F"
	$"3E3D 3E3C 3CFE 3B16 3C3D 3B36 2B23 1F1E"
	$"1C1A 1C19 1817 1619 191A 1D13 0706 01FE"
	$"00EF 0001 65FF 68FF 6900 6BFE 6D06 6F70"
	$"7273 7678 79FE 7B0D 7A7C 7C7E 7F7E 8081"
	$"8184 8485 8586 FC87 FF88 3A87 8685 8684"
	$"8282 8081 807F 7F80 8078 4110 0F22 5367"
	$"5749 4E56 5F71 8A9D A9AE AAA0 9489 8891"
	$"A46B 3034 5768 6967 6464 6363 6262 6161"
	$"605C 554E 4845 FD47 0D48 4B4B 4D4C 4B4D"
	$"442D 1C06 0100 00FE 01F8 00FE 00FE 01FF"
	$"57FF 5910 5B5D 5C5C 5E60 6161 6365 6668"
	$"6869 686B 6AFD 6BFF 6DFF 6EFE 6FFF 70FE"
	$"71FF 7203 7170 6E70 FE6E 016D 6EFE 6D32"
	$"6C6D 6B3D 0F0B 1537 4037 2E2F 3233 3B47"
	$"4F55 5855 504A 4548 4A57 3D1A 2547 595D"
	$"5A58 5958 5857 5755 5554 504A 443F 3C3B"
	$"3939 3BFE 3C07 3E3D 3C3D 3628 1C06 F800"
	$"F500 043F 393B 3E3F FE40 FF3F FF42 1041"
	$"4345 4747 4544 4645 4546 4543 4444 4545"
	$"FE46 FF47 FE48 FF49 0448 4745 4745 FE46"
	$"0247 4646 FD47 3A22 0201 0A29 2F1E 1110"
	$"1013 1922 282B 2925 1E18 1418 1724 0C00"
	$"1036 403E 3B3C 3C3B 3B3A 3C3B 3C3B 352F"
	$"2A24 2122 2121 2222 201E 1F1E 1E21 1809"
	$"0802 FE01 0201 0201 F200 0169 1065 6768"
	$"6869 6A6B 6C6D 6F70 7176 7877 797A FE7B"
	$"0E7C 7D7D 7F80 8182 8283 8485 8586 8685"
	$"FC87 FF85 FF84 3581 807F 7E7C 7B7A 7A7B"
	$"7645 140E 2E5B 6560 6873 7B78 6F74 8DA7"
	$"BAB7 ADA7 ACB9 C5B5 7834 375F 6665 6363"
	$"6260 6061 6160 6160 5A55 524D 4BFE 4903"
	$"4849 4B4C FE4E 0451 432B 1C08 FD00 FF01"
	$"F800 FE00 FE01 0455 5859 595A FE5B 085C"
	$"5E60 6162 6464 6667 FE69 0E6A 6B6B 6C6A"
	$"6B6C 6C6D 6E6F 6F70 706F FC71 FF6F 286D"
	$"6E6D 6D6B 6A6A 6B6B 6A6B 663D 1107 1C3C"
	$"423E 3E44 4745 3E3B 4550 5A5B 5655 5A64"
	$"6A64 431A 2951 5A5A FE58 0057 FE55 0854"
	$"5352 504D 4844 413E FE3D FF3E 093D 3E3F"
	$"3E3E 3829 1E07 00FC 01FE 00F5 0010 3D39"
	$"3A3D 3D3E 3E3D 3E40 4241 4143 4345 46FD"
	$"450D 4445 4543 4445 4344 4546 4647 4746"
	$"FC48 FF46 3844 4547 494A 4846 4747 4849"
	$"4424 0300 1331 3128 2427 2721 1819 2326"
	$"2825 1D20 252A 2923 0F00 173D 3E3E 3B3D"
	$"3D3B 3A3B 3B3A 3939 3532 2F2B 2824 FE23"
	$"0222 211F FE21 0322 1D0F 09FE 0100 0002"
	$"0001 01F2 0001 69FF 660B 6768 6869 6A6C"
	$"6D6E 6E70 7577 FE79 067B 7C7A 7B7C 7D7F"
	$"FE82 FF83 FF84 1185 8686 8586 8788 8687"
	$"8583 8180 7E7D 7B7C 7CFE 7921 7874 5727"
	$"1134 6167 5F5F 6163 6B69 6175 A0C1 B597"
	$"7E7E 98BA CA8D 3F3D 6064 6361 615F FE5E"
	$"175F 5D5F 5E59 5755 514F 504E 4B4A 4C4D"
	$"5150 5150 5145 2D1E 06F2 00FE 00FE 0103"
	$"5657 5859 FE5A FF5C 045D 5F60 6164 FE66"
	$"5F69 6A68 696A 6B6B 6C6D 6C6D 6D6E 6E6F"
	$"7070 6F70 7172 7071 7070 6F6D 6D6C 6A68"
	$"696A 6A69 6865 4A1A 0724 4345 3E39 393B"
	$"3C3D 353D 5161 5C4F 4243 4F61 724E 202D"
	$"5257 5755 5656 5454 5253 5151 504F 4D48"
	$"4543 4240 3E3D 3E3E 3F3E 3F3F 4039 271C"
	$"06FD 00FF 01FE 00F5 0009 3E38 3A3D 3C3D"
	$"3D3E 3E3F FE40 0042 FD45 0046 FE44 FC45"
	$"FF44 FF45 5446 4747 4647 4849 4748 4746"
	$"4443 4747 4846 4645 4647 4643 310E 0018"
	$"3632 2724 1F1B 1D1D 161B 262D 201A 1919"
	$"1F29 3115 001A 3F3E 3D3C 3B3B 3A3A 3839"
	$"3737 3634 3331 2E2B 2826 2423 2321 211F"
	$"2020 231D 0D0B 0400 0102 FF02 0001 F200"
	$"016A 0165 64FE 670B 686A 6C6D 6E6E 6F74"
	$"7778 7978 FE7A 067C 7B7C 7D80 8282 FE83"
	$"1284 8584 8586 8586 8687 8683 8180 7F7B"
	$"7879 7A7C FE78 2077 7566 4622 3866 6753"
	$"443B 3747 505A 6D9E BDA4 7854 4E75 99C3"
	$"9D4A 475E 6261 6060 FD5D 085E 5D5E 5D59"
	$"5A5C 5956 FE58 1057 585A 5D5E 5E5F 625A"
	$"4B42 3228 2823 1102 F700 FE00 FE01 FF55"
	$"FF58 FF59 0A5A 5B5C 5C5E 5F61 6465 6666"
	$"FE68 016A 69FE 6AFF 6CFE 6D05 6E6F 6E6F"
	$"706F FE70 FF6F 0570 6E6E 6D6A 6AFD 6921"
	$"6867 6555 3116 2A48 4535 2922 1E27 2E33"
	$"364D 5D57 3E2C 2539 496B 5827 3652 5655"
	$"5455 FE53 FF52 0051 FE50 034E 4C49 47FE"
	$"480F 4748 4849 4A4A 4B4C 483D 3525 1E1F"
	$"1608 FC00 F500 063D 3639 3C3B 3C3D FE3E"
	$"0540 3F3F 4244 45FE 44FF 4505 4344 4343"
	$"4545 FE44 0545 4645 4647 46FD 4709 4645"
	$"4443 4544 4846 4644 FE45 1F43 361D 061A"
	$"392F 180D 0806 0C12 1A1C 2B30 1B0F 0E08"
	$"151C 301F 0320 3F3E 3E3D 3CFC 3819 3736"
	$"3634 3435 322F 2F2E 2E2D 2E2C 2A28 2829"
	$"2825 1C1B 1510 0F0C 0004 F000 016F FF63"
	$"1365 6667 6868 6B6D 6E6E 6F71 7475 7577"
	$"7878 7979 7CFE 7DFF 7E06 8283 8384 8385"
	$"85FD 8453 8584 807D 7C7A 7A77 7576 7775"
	$"7474 7575 7361 3E3E 6770 6B68 6662 5D5C"
	$"6773 98B6 A78B 8395 AEBE C5A0 7057 5D60"
	$"5E5F 605F 615F 6062 6567 6766 6A6C 6B6D"
	$"6F70 7274 7575 7778 7B7D 7E7F 8082 8583"
	$"8680 6341 1100 0101 FB00 FB00 FF55 1756"
	$"5757 5959 5859 5B5C 5E60 6365 6466 6868"
	$"6967 696A 6A6B 6BFC 6C03 6D6E 6F71 FD70"
	$"096F 6E6E 6D6A 6A69 6968 66FE 6525 6665"
	$"5B43 262A 4749 453F 3E3C 3636 3D38 4355"
	$"5649 4551 6165 6A53 3F42 5255 5252 5453"
	$"5554 5656 FE57 1C58 5A5B 5A5C 5C5D 5F5E"
	$"5F5F 6163 6564 6668 6A6A 6967 6963 4B30"
	$"0C01 0100 F500 043C 393A 3A39 FE3C 073E"
	$"3F3F 3E3E 4143 43FE 4407 4543 4344 4443"
	$"4344 FD45 0344 4546 47FD 46FE 4508 4645"
	$"4847 4746 4442 42FE 4423 3C28 101A 3A31"
	$"2122 2425 1F1D 231E 2329 1D18 212A 2E28"
	$"2A1D 1725 3B3D 3939 3A39 3A39 3A3B FD3D"
	$"FF3E 133D 3F3D 3E40 3F3E 3E3F 3E40 403E"
	$"3E40 4041 4041 3D02 2718 06F2 0001 6EFE"
	$"5EFF 611B 6466 686A 6A6D 6F6F 7175 7577"
	$"797A 7B7B 7C7D 7C7C 7D7D 8081 8183 8282"
	$"FD83 0C82 8081 7E7B 7B79 7876 7273 7371"
	$"FE70 2C6F 766D 4B3E 6B79 8084 7D77 736E"
	$"6E77 99B8 B7A7 A1AF BCC4 C79F 8677 625F"
	$"5C5B 5D60 6263 6568 6B6C 6D6D 7172 7274"
	$"FE77 127A 7D7E 7F80 8386 898B 8C8F 8F93"
	$"9690 7B75 4204 F900 FB00 FF50 1651 5352"
	$"5658 5759 5A5C 5E5F 6165 6566 6667 6967"
	$"6869 696A FE6B FF6C FE6E 006F FE70 0B6F"
	$"6E6E 6D6D 6B69 6867 6766 64FD 6228 615A"
	$"462B 2949 4D51 504B 473F 3C3A 3743 4F51"
	$"5250 5B62 636C 4F46 5451 5351 5152 5456"
	$"5759 5859 5B5C 5CFE 5E08 6062 6363 6465"
	$"6768 69FE 6A0C 6C6E 7271 7072 6F5C 5533"
	$"0300 00F5 0021 3B3A 3738 393B 3C3B 3D3E"
	$"3F3F 3C3E 4343 4443 4445 4343 4443 4243"
	$"4344 4545 4644 4445 FD46 FE45 3844 4546"
	$"4746 4444 4342 4143 4442 3D2C 1217 3D35"
	$"2C2C 2827 2422 201D 2324 1E20 242D 2E29"
	$"2F18 1B2F 3338 3638 383A 3C3D 3D3E 3F40"
	$"4242 4342 4243 FE42 FF41 0243 4241 FE43"
	$"FE42 0340 4244 3F02 2D30 1AF2 0001 7106"
	$"4F4E 4C4E 4F57 62FE 670A 696C 6E72 7475"
	$"7679 7879 7BFE 7CFF 7B04 7C7E 7F7E 7FFD"
	$"81FF 8235 7F7D 7D7C 7A79 7876 736F 6D6F"
	$"6D6B 6969 6A72 7052 3E69 7D88 928B 8481"
	$"7A73 7B9A B7C2 BDB1 ABAE BACC B48E 8D7A"
	$"7470 635C 6064 635E 6163 FE61 0564 696A"
	$"6868 6AFE 6B10 6D6F 7274 7777 797B 7C84"
	$"9198 9079 714A 0AF9 00FB 0012 4342 4243"
	$"414C 5659 5859 595C 5F62 6565 6667 67FC"
	$"68FF 690B 6A6C 6D6C 6D70 6F6F 6E6F 6F6E"
	$"FE6D 3A6C 6967 6664 6463 6260 5F5E 5E5F"
	$"553F 2D29 4449 4F52 4E49 4744 3833 414F"
	$"5456 5553 5457 6759 3B59 6161 5F56 5054"
	$"5757 5455 5454 5656 5354 5553 5355 FE56"
	$"1258 595A 595A 5E60 6364 6A71 736D 5953"
	$"3B06 0001 F500 0632 302D 302F 333A FD3B"
	$"FF3C 113F 4343 4443 4243 4342 4343 4141"
	$"4343 4444 43FC 444F 4548 4647 4543 4245"
	$"4543 4141 4342 4041 4142 3A27 1216 3933"
	$"2C2B 2A27 2725 1C1B 2124 2423 2224 2426"
	$"3121 0D29 363C 3D36 343A 3C3D 3C3D 3D3B"
	$"3B3A 3A3C 3E3C 3B3D 3E3B 393B 3B3A 3B3C"
	$"3D3C 3C3E 4446 453B 0428 2B19 0002 F400"
	$"0174 FF4B FF4A 1D49 515F 6566 6669 6C6D"
	$"7174 7575 7778 7879 7B7C 7A7A 7B7B 7D7D"
	$"7E7E 7F81 81FE 8243 7F7B 7A7B 7A77 7574"
	$"716D 6D6C 6968 6766 6770 6F5F 4E64 7486"
	$"9395 8F88 7970 7D9C AEBC C5B5 AEB3 BFCE"
	$"C8B0 9A88 8681 6D5D 645A 3B5A 6265 6967"
	$"6B6D 7073 7579 797E 7C7C 7A7D FE7C 0B7F"
	$"7D75 7246 7E9A 957A 6F45 09F9 00FD 00FF"
	$"01FF 3FFF 4010 3F47 5356 5858 595B 5D60"
	$"6365 6566 6667 66FE 6707 6869 696B 6B6C"
	$"6C6D FB6F 006D FE6A 0668 6765 6463 625F"
	$"FC5E 4354 3D35 3543 4347 4F4F 4B4B 4339"
	$"3843 4A54 5C58 5456 5A65 6155 626A 6A6B"
	$"5A4F 5850 3859 6062 6465 6A6E 7376 7777"
	$"797B 7A7C 7A7A 797B 7773 736C 6835 6579"
	$"6F5B 5839 0500 00F5 0007 362B 2C2C 2D30"
	$"3939 FE3B 143C 3D40 4343 4243 4444 4343"
	$"4442 4042 4244 4445 4443 FC46 0847 4646"
	$"4542 4142 4645 FE42 FF40 FE41 3D3B 2717"
	$"1D39 342B 2D2C 2A28 211D 1E22 2124 2320"
	$"2527 292E 2720 2B3C 403F 3432 3E39 2756"
	$"5D5F 6870 7779 7C7F 8181 8285 8788 8685"
	$"8483 7B7A 7977 6E2F 4548 3C04 2B2C 1700"
	$"01F6 0001 0100 0177 1743 454A 4A49 505E"
	$"6365 6668 6B6D 6F72 7373 7779 7978 7979"
	$"78FE 7A06 7C7E 7D7E 7E7F 80FE 810C 7D7B"
	$"797A 7B74 7271 6C69 696A 66FD 6441 6B73"
	$"6E5E 6771 7B8E 9B92 7C70 6F83 A1B5 B8B4"
	$"AFB7 C3D1 D6D5 BD8D 7984 856A 5867 4940"
	$"E4ED EEEC DBD3 DCDE E0E1 DAD6 DDDF DEDF"
	$"DDD8 D4D8 D3D4 DDE6 7966 9F96 7D74 4408"
	$"F900 FE00 1601 0202 3E3E 4041 4145 5154"
	$"5657 575A 5C5E 6163 6364 6565 FD66 FE68"
	$"066A 6C6B 6C6B 6C6D FE6E FF6D 086A 6869"
	$"6665 6361 605E FE5C FE5B 2F56 463B 394A"
	$"473E 4C54 4C41 3B39 4049 4A4D 5051 565D"
	$"6466 6966 6062 6A6E 574A 5B42 42E7 F0F0"
	$"F2EB E8EF F0F2 F4F1 EFF1 F0FE F110 F2EC"
	$"EAED EEEC EF75 4C7A 705C 5937 0300 00F7"
	$"0015 0100 2F26 312D 2D2F 3937 383A 393C"
	$"3E40 4341 4042 4445 FE43 FF42 FF43 0644"
	$"4645 4543 4445 FE46 FF44 3D45 4646 4240"
	$"4543 4140 3F3E 3D3E 3F3E 3C30 2220 3F3E"
	$"2C2D 2F29 1D1A 1D25 2A26 1F1B 1D27 2A2D"
	$"2B2A 2A2D 3B45 4132 2F41 2F3D EEF7 F6F9"
	$"FAFA FDFC FDFE FFFE FDFE FFFF FDFE FF06"
	$"FEFD FFA3 5B50 39FF 2C00 14F4 00FF 0101"
	$"7D10 8653 3249 484E 5C62 6264 6669 6B6E"
	$"7272 73FC 7503 7677 797A FE7B 3A7C 7D7E"
	$"7F80 7F80 7E7C 7A78 7877 7270 6E6A 6666"
	$"6461 6063 6362 6571 7564 626D 7388 978B"
	$"7467 667D A3C1 BFB1 A3AF C4D7 D8C7 9A52"
	$"3876 8A68 5266 4457 FDFF 01EC EBFE F816"
	$"F9DE D2EE F1F1 F0F0 EABF 9B98 9DC5 E785"
	$"67A1 987D 7542 08FA 0000 01FE 0014 0102"
	$"0390 5D32 413E 434F 5353 5556 585A 5C61"
	$"6263 64FD 65FF 6619 6768 6869 696A 6A6B"
	$"6C6D 6C6D 6B6B 6C69 6765 6363 605E 5E5C"
	$"5A5B FD59 2157 4D42 3A44 473D 4650 463A"
	$"3633 3D4E 5653 4B44 4F5F 6869 6657 392C"
	$"6172 5747 5A3C 56FD FF01 F9F8 FEFE 03FF"
	$"F1E6 FCFE FAFF F90F E3D6 D6D5 E5FD 894D"
	$"7B71 5C5A 3503 0000 FC00 0001 FD00 FF01"
	$"05A1 6935 3230 2FFE 36FF 3818 3A3C 3F42"
	$"4140 4243 4342 4142 4140 4242 4343 4443"
	$"4344 4544 45FD 430A 4544 4140 4341 3E3F"
	$"3F3E 3DFE 3E21 3D36 2C21 333F 2E29 2B1E"
	$"1513 1624 3030 2219 1320 2B2C 2B2A 2415"
	$"1540 4931 2B3F 2A57 FDFF FFFB FDFF 01F9"
	$"F4FD FE0B FDFC FAFB FCFB FCFF D070 4D3A"
	$"032B 2E13 01FA 0000 01FD 0001 0102 017B"
	$"12DD 992B 3C49 4D5B 605F 6264 676A 6C70"
	$"7173 7271 FE73 FF74 FF77 3D79 7A7B 7B7C"
	$"7D7E 7F7F 7D7C 7A79 7777 7571 6E6C 6967"
	$"6562 605E 6060 5F5F 6766 6059 626E 7F88"
	$"7F79 6A55 5F8A AEB5 BFAB 97B0 CAC3 8758"
	$"2E1E 6B8E 674F 6640 61FD FF01 EEF4 FDFF"
	$"01F0 EBFB FF0D D996 948F B8E0 7B6C A398"
	$"7F76 4006 FA00 0001 FD00 FF02 15FA B93B"
	$"383F 424E 5150 5254 5759 5C60 6263 6463"
	$"6465 64FE 6502 6667 68FE 6912 6A6B 6C6C"
	$"6A69 6A69 6766 6462 615E 5D5D 5B58 59FD"
	$"5721 5652 493F 3C41 3D3D 423D 3A35 292C"
	$"404E 4C52 4B41 5361 694B 3B2D 1A58 7557"
	$"465A 3960 FDFF 01F9 FBFD FF01 F8EE FBFF"
	$"0FF4 D2D5 CFE0 F87C 507E 715D 5C32 0200"
	$"00FC 0000 01FC 0006 01FF D15C 3932 2EFE"
	$"341A 3536 393B 3E41 4040 4140 4241 4041"
	$"4140 4142 4243 4342 4243 4444 43FE 4202"
	$"4344 43FE 412A 403F 403F 3E3D 3F3E 3E3D"
	$"392E 2227 3730 241D 1316 150B 0F22 2519"
	$"1A14 0E22 2729 1519 190C 3D4E 2F2B 3F27"
	$"64FD FF02 F9FA FEFE FF11 FBF6 FEFA FCFC"
	$"FAFB FBF6 FEFD FCFC CC6F 4B3A 052C 2E11"
	$"0000 01FC 0000 01FD 00FF 0101 7220 E6CB"
	$"4636 4A4D 595E 5F5F 6165 676A 6C6F 7072"
	$"7273 7272 7475 7676 7579 7A7B 7B7C 7BFE"
	$"7C33 7B78 7775 7473 706C 6967 6664 6361"
	$"5F5C 5C5B 5C5D 5F61 555A 6A79 7973 7574"
	$"6D6D 7A9A B1BB BC9D 9CC0 AC5A 3126 2373"
	$"936A 4F67 4166 FEFF 03FD F8FA FEFE FF16"
	$"EDD8 F0F3 F2F4 F7F5 D9B7 C9AB C4E8 7773"
	$"A59A 8379 4004 00FA 01FD 01FF 000F F9EA"
	$"5E31 4242 4A4E 4F50 5256 585B 5D60 FE62"
	$"0D63 6262 6465 6666 6567 6869 696A 69FE"
	$"6A09 6968 6765 6464 6360 5E5C FE59 0B56"
	$"5556 5655 5654 5554 433D 3BFC 3C15 3836"
	$"3746 4E51 5749 485E 603C 2E2A 1E5A 7757"
	$"455C 3964 FDFF 01FC FEFD FF02 FAEC FCFE"
	$"FDFF FF0C F1DD F2DA E4FC 7950 8074 5F5F"
	$"32FE 00F5 000D FFF4 823E 3230 3335 3533"
	$"3539 3B3E FE3F FF41 0D42 4040 4243 4444"
	$"4341 4243 4344 43FE 4403 4345 4543 FD42"
	$"FE40 2841 403E 3D3C 3C3B 3D39 3936 2A2C"
	$"2D23 1614 191E 1916 161E 1F1E 2114 1526"
	$"240D 161C 1343 4F2F 2A41 2765 FDFF 01FC"
	$"FEFD FF11 FBF7 FEFC FCFD FCFE FFFD FEF9"
	$"F7FF C270 4D3A 052B 2F11 0001 01F5 0001"
	$"7816 E5EC 752A 4A4B 565C 5E5F 6264 6669"
	$"6B6E 6F71 7172 7273 72FD 74FF 77FF 79FF"
	$"7AFD 7B32 7976 7473 716E 6A68 6764 625F"
	$"5F5D 5C5B 5B5C 5C60 654C 4B62 7A7F 6A63"
	$"6D79 8187 94A9 B1AB A9AB BD9B 4E30 2926"
	$"759B 6E52 6938 6AFE FFFF FDFF FEFF FF17"
	$"FEEB A7B2 DFE3 C1AB ACB4 D6EF D5DB EB7F"
	$"78A9 9D87 7C3D 0300 FD01 0203 0201 FE02"
	$"1201 0000 F3FF 8D28 423F 484C 4E4F 5355"
	$"575A 5C60 FE61 0362 6162 63FD 64FF 65FF"
	$"67FF 68FD 690C 6866 6463 6161 5F5D 5B58"
	$"5859 57FE 56FF 5520 5356 5B3F 3239 4445"
	$"3833 3539 3B3C 3F4C 504D 4F50 605B 3529"
	$"291F 5E7D 5744 5D34 6CFA FFFF FE15 FFFB"
	$"D9D9 F4FA E7DE DFDB ECFF EDED FD80 5481"
	$"7560 602E FE00 FE00 FF01 FA00 10FD FFA8"
	$"3532 2D31 3334 3336 383A 3D3F 3F3E FD40"
	$"0141 40FD 42FF 41FD 42FD 4332 4544 4241"
	$"4040 413F 403E 403E 3E3D 3C3B 3B3C 383A"
	$"3C24 2126 211B 1211 1718 1919 151D 2018"
	$"1B1C 2421 0B16 1E13 4454 2D29 4220 6DFD"
	$"FF00 FEFC FF11 FDFA FBFB FDF9 FCFD F7F9"
	$"F8F6 FAFD BE69 4C3B 052E 300F 0001 01FE"
	$"0002 0201 00FE 01FE 0001 8211 E3F5 8C25"
	$"4A4C 555A 5C5E 6163 6468 6B6F 6F70 FD71"
	$"0972 7373 7474 7777 7977 77FD 7A0D 7976"
	$"7573 7270 6E69 6765 645F 5C5C FE5B 2259"
	$"5C5D 6065 4339 5E7B 8E71 5553 6570 7986"
	$"9CA9 A09A B4BA 8241 2623 2C5C 886C 546D"
	$"3474 FDFF 1CFE FFFE FEFF F4C6 9396 BFCF"
	$"BC96 8C9D CCE3 D2DB E87E 7EAC 9F8A 7E3B"
	$"0300 FD01 0203 0201 FF02 FF01 FF00 11EC"
	$"FFA4 2542 4046 4A4C 4E52 5455 595C 5F61"
	$"60FD 6102 6263 63FD 6402 6665 65FD 680D"
	$"6766 6563 6260 605E 5C5A 5857 5756 FE55"
	$"0053 FE54 1E5D 3A24 3841 4C3D 2A1F 2629"
	$"2B2D 3946 4944 5763 4F2E 1C21 254D 7158"
	$"4561 337A FDFF 1AFE FFFF FEFF FFEB D5D5"
	$"E5EE EAD6 D3D5 EAF8 E9EE F97D 5A83 7460"
	$"5F2B FE00 FE00 FF01 FA00 11FC FFBD 3532"
	$"2E2F 3233 3135 3738 3C3E 3F3E 3FFE 400A"
	$"3F40 4141 4242 4343 4541 3FFD 4207 4143"
	$"4341 403F 403F FE3E FF3D 003C FE3B 2239"
	$"3B39 393E 1E11 2521 2111 0605 0F0D 0C0C"
	$"161C 140E 2024 1608 0811 1134 4B34 2D45"
	$"1F79 FDFF 00FE FDFF 12FC FDFD FCFB FCFE"
	$"FDFD FBFC FDF9 FCFF BD68 493C 052F 300C"
	$"0001 01FE 0004 0201 0001 01FD 0001 7157"
	$"E0FC 9629 494D 5459 5A5B 5E61 6367 6C6C"
	$"6B6E 7071 7170 7172 7475 7474 7575 7678"
	$"7979 7777 7877 7574 7271 6D68 6361 615E"
	$"5B5A 5A58 5958 585A 6069 4423 4F6C 8984"
	$"7161 6173 8193 ADBF B7AA B4AC 6940 1F17"
	$"242D 4059 585A 2881 FBFF FFFE 18FF F0A9"
	$"8A8D 91B1 D7B8 9490 9AA3 A3BE D072 81AC"
	$"A08B 803A 0400 FA01 FD01 1402 01EA FFA2"
	$"2540 3F44 494B 4D50 5254 575C 5E5F 5E5F"
	$"FE60 0261 6262 FE63 0564 6564 6565 66FE"
	$"6736 6665 6463 6260 5D5A 5959 5554 5555"
	$"5354 5353 5155 5C3A 1430 3848 4C40 2F29"
	$"2B2D 3546 5658 525A 5D3E 3319 101C 2531"
	$"4645 4F2A 86FF FFFE FEFC FF18 FEDF D5D8"
	$"D2DD F5E4 D5D4 D6D9 D9E4 EB6D 6086 7564"
	$"612A 0001 00F7 00FF 010D FCFF B42F 3132"
	$"3132 3131 3335 373B FD3F FF41 0E40 3E3D"
	$"3E41 4140 4243 4341 4041 4143 FE44 0943"
	$"4241 4040 3F3D 3D3F 3EFB 3C3D 3D39 393D"
	$"1B07 221E 221E 1A12 1317 1516 2225 1F1B"
	$"231E 080D 0204 0A0D 152A 2A34 1883 FFFF"
	$"FDFE FDFD FFFE FFFD FAFC FDFC FBFE F8FD"
	$"FFFB FDFD FBFC B969 4D3A 022E 300B F200"
	$"0167 15D4 F69A 2749 4D52 5658 5A5D 6062"
	$"666B 696A 6C6E 6D6E 6FFE 7108 7273 7473"
	$"7475 7778 77FD 75FF 732F 716C 6A65 615F"
	$"5D5E 5C59 5858 5757 5658 606B 4010 3A58"
	$"6F80 7B74 6C7A 8FA3 B6C3 BDB4 AF9A 4F40"
	$"2914 2123 2735 3F3E 2377 FBFF FFFE 17FF"
	$"F1C4 A68F 90A7 C4BE 9B8C 8B8E 8C97 9C60"
	$"8CB0 A18B 8138 04FC 00FE 01FD 01FF 0215"
	$"E9FF AF27 3F41 4247 4A4C 4E51 5356 5B5C"
	$"5E5D 5E5E 5D5F FE61 0162 63FC 64FB 65FF"
	$"6307 6260 5F5C 5A58 5655 FE54 0053 FE52"
	$"2050 545D 3C0B 2836 3D47 423E 3735 3B49"
	$"555C 5E5C 5B55 2B34 230C 1A1E 2029 3437"
	$"2175 F8FF 15FC E6DF D7D4 DAEA EDDA D4D5"
	$"D4D4 D9CC 5B65 8476 6661 27FE 00F7 00FF"
	$"0113 FCFF C439 3234 3230 3132 3234 3639"
	$"3E3F 403E 403F FD3E 023F 4041 FE42 0341"
	$"4243 42FD 43FF 410A 3F3D 3E3D 3C3C 3D3E"
	$"3D3C 3CFD 3DFF 3930 3F1A 001D 2520 1D1A"
	$"1A14 1519 1D22 1F1C 1D1D 1800 150A 0007"
	$"0306 0F18 1F10 6DFF FFFE FEFF FEFF FEFE"
	$"FDF6 FBFF FEFB FBFD FEFD FF05 FEF9 C471"
	$"4D39 FF2F 0109 01F3 0001 781B CFF2 A425"
	$"454A 4F55 5759 5C60 6264 6869 686A 6A6B"
	$"6D6F 6F70 6F6F 7071 FD72 1173 7474 7273"
	$"7372 726D 6965 6161 5E5B 5D5B 58FE 57FF"
	$"5540 5762 6E3B 0926 4D58 6D7A 7A7E 899C"
	$"B0BE C3BE B0A8 8543 3E31 282D 2925 2428"
	$"2F39 3C66 A4E1 F6FF FFFE FEFF F1DA D9B1"
	$"928D 9097 959C B5BA A297 8858 96B4 A38E"
	$"8035 05FC 00FE 01FF 01FF 0218 0302 E1FF"
	$"C029 3D40 4145 494B 4D51 5354 575B 5C5E"
	$"5D5E 5D5E 5FFE 6101 6261 FD62 FF63 0064"
	$"FE63 FF62 095F 605E 5B59 5754 5452 53FE"
	$"5226 5150 5056 6139 0A1D 3937 4044 4544"
	$"4047 545B 6062 5A5A 4C29 3228 1E24 221E"
	$"1C21 2931 3561 9DDB F6FC FF03 FBF1 F7E4"
	$"FDD8 0DD5 D6E3 E6DA DBC3 556A 8679 6861"
	$"25FE 00F7 0029 0201 FCFF D746 3430 312E"
	$"2F30 3033 3637 3B3E 3E3D 3D3E 4040 3E3F"
	$"4140 423F 3F40 4041 4142 4240 4041 4040"
	$"FE3C FD3B 033D 3C3A 3AFD 3B07 383A 441A"
	$"0013 2D24 FD1D 1A1A 1C20 2021 1E18 1C14"
	$"0217 0E05 0907 0505 0D17 2022 4A91 D9F6"
	$"FFFF FEFE 12FD FCFD FDFF FEFD FCFD FDFB"
	$"FAF8 FEFC C972 4E3C 0332 2E06 01F7 00FF"
	$"01FF 0001 780E CDF6 B420 414A 4C54 5556"
	$"595C 6063 65FD 6864 696A 6B6B 6D6B 6D6E"
	$"6F70 706F 6E6D 6E6F 6F71 7170 706C 6965"
	$"605C 5B5B 5957 5655 5655 5552 5763 6F3E"
	$"0E24 464E 5C70 7F8A 98AB C0C7 C5B8 A594"
	$"5F3C 4038 4031 2727 262C 2E2B 3137 4260"
	$"7FA4 EFFF FEFF EDAF A7A2 9893 9294 91A8"
	$"D0DD CEAE 895A 98B4 A48F 7D32 04FC 00FE"
	$"01FD 0111 0201 DCFF CE26 3C41 4045 4648"
	$"4A4D 5154 565A FE5B FD5C 175E 5D5F 605F"
	$"5F60 605F 5F60 5F5F 6161 605F 5D5D 5B59"
	$"5654 53FD 5200 51FE 5009 4F56 5F37 0A1C"
	$"3836 3840 FE46 214F 5C61 635D 5854 362B"
	$"342D 3726 1E1E 1F24 2422 282B 354F 729C"
	$"EEFF FFFE FBDE DEDF D8FE DA10 D6DA EFF7"
	$"EFE1 C055 6F89 7969 6023 0001 01F7 0009"
	$"0100 FBFF DF45 332F 302F FE2E 0330 3437"
	$"39FD 3DFF 3E02 3F3D 3FFE 40FF 3D40 3E40"
	$"4241 413E 3E3F 3D3D 3F3D 3C39 373C 3A39"
	$"3A3B 3A3B 3C3B 3B3A 373B 421C 0011 292B"
	$"2624 2422 2124 2823 241B 171B 0608 1612"
	$"1A0A 0608 0B0E 0C0D 141A 253E 6491 EAFE"
	$"FF05 FEFB F9FD FEFE FEFF 09FC FEFE FCFA"
	$"F7C3 704F 3B04 302D 0601 01F4 0001 7312"
	$"C9F2 B823 3F4B 4B50 5256 585B 5E61 6468"
	$"6967 67FE 6809 696A 6B6C 6D6E 6F6F 6E6D"
	$"FD6C 0B6F 6C6B 6B6A 6862 5E59 595B 56FC"
	$"5542 5451 5765 6E3D 1520 3B4C 4D5A 6D83"
	$"929F B4BA B2A3 9975 4739 3937 3E2F 2229"
	$"2523 2D3A 413C 4246 5E61 85F5 FEFF E9A2"
	$"8E91 9594 9594 9296 9FA2 A6A1 855E 9AB5"
	$"A594 7C2E 03F9 00FD 00FF 021A DDFF D42B"
	$"3940 4141 4348 4A4B 4F53 5659 5A59 595A"
	$"5B5B 5C5C 5B5D 5EFD 5F14 5E5D 5C5C 5D5E"
	$"5F5F 5E5D 5C5A 5854 5250 4F50 4F4F 50FD"
	$"4F2A 575E 3512 1A2C 3734 383C 4448 4B58"
	$"5F5B 5356 442B 2E2F 3036 271C 231F 1B23"
	$"3036 3038 3646 4A7C F5FF FFFC DCFE D813"
	$"D9DA DAD9 D4D6 DCDD DEBE 5473 8978 6C61"
	$"2000 0101 F500 1AFA FFE2 4D32 302F 2D2C"
	$"2E2D 2E32 3639 3C3D 3C3C 3D3D 3E3F 4141"
	$"3F3D FE3E 083F 4040 3E3B 3B3D 3F41 FE3F"
	$"023B 3839 FE38 333A 3939 3C3C 3B39 383C"
	$"3F1A 040B 1F2E 2720 1F22 2321 2422 1F14"
	$"1A0F 000C 1214 1B0C 060E 0904 0916 1E1E"
	$"2A26 2F2E 6CF4 FFFD FCFC FDFB FF09 FDFB"
	$"FCFC FEF8 C46F 4B3A 0430 2E06 0201 F700"
	$"FE01 0181 10CA F0C1 2E3B 4C4B 5053 5458"
	$"5C5D 6063 6668 FE67 0066 FD68 FF69 076B"
	$"6D6C 6C6A 6866 63FE 61FF 603A 5F5D 584F"
	$"4F56 5957 5655 5554 5455 5055 6672 3C14"
	$"1221 4648 454C 6172 7D8B 9390 9382 573D"
	$"4535 292C 2422 2A29 3448 514F 3836 4956"
	$"605C 96E4 DABD 99FE 95FF 94FF 95FF 9410"
	$"9291 9784 609F B9A7 967C 2A01 0001 0001"
	$"01FE 00FE 0007 0102 02DD FFDD 3534 FE41"
	$"0844 4749 4D4E 5154 575A FE59 4E58 5A5A"
	$"5B5C 5D5E 5D5F 5E5D 5A58 5756 5554 5351"
	$"514F 4F4C 4549 4E4E 4D4E 4D4E 4F4F 504E"
	$"4D56 6337 150E 1535 3531 2F35 3D3E 444C"
	$"4C51 4B31 283A 2E24 261E 1C24 232B 3D47"
	$"452F 2F3C 4247 4590 F6F1 E7DB FBD9 FDD7"
	$"09D6 DCBA 5477 8B7A 6F61 1FFE 0002 0001"
	$"01F8 0010 F9FF EA5A 3331 2E2C 2D2D 2C2F"
	$"3134 373A 3DFE 3C4F 3B3D 3D3E 3F3D 3C40"
	$"4241 3F3A 3837 3836 3536 3430 2D2E 2D2A"
	$"2E35 3838 3A38 393B 3B3C 3835 3C43 1903"
	$"000B 2D28 1D14 161A 1716 1817 1B18 0605"
	$"1A10 0B0C 0406 0E0D 172A 2F2C 1C1F 2B2A"
	$"2B2A 8BFF FFFD FEFE FDFF FFFE FFFF 07FE"
	$"FFFE F9C3 694E 3C08 342D 0401 0100 0001"
	$"01FB 00FE 0101 7813 CDED CB37 3A4D 4B50"
	$"5254 565A 5D5F 6365 6766 6767 FD66 FF64"
	$"1365 6357 5450 4E4E 4D4A 4E4F 535E 6068"
	$"6C66 6E36 29FE 5031 5150 5253 534E 5668"
	$"633B 1411 1033 504C 484D 5A68 757D 8880"
	$"5A3A 3A3F 2F1F 2224 1E24 3048 5B54 453D"
	$"3143 4B54 6470 B9E7 AA90 FE94 1393 9495"
	$"9695 9696 8F94 7F60 A3BA A897 7A25 0001"
	$"02FB 00FE 00FF 0114 02E2 FEE8 3F32 4241"
	$"4143 4647 4B4E 5054 5658 5859 59FE 5816"
	$"595A 5A5C 574B 4846 4544 4648 4C4D 545F"
	$"6069 6D67 7034 26FE 4C45 4D4C 4D4E 4F4C"
	$"4D58 5636 1410 0D27 3B35 2E2E 363A 3E45"
	$"4948 3525 2B35 2A1B 1E20 181E 2B3F 5148"
	$"3B36 2C38 3E40 4C5A BBFF DED7 D7D8 D9D8"
	$"D9D8 D6D5 D6D7 D7DD B351 7A8A 7A70 5F1C"
	$"FE00 F600 0701 FBFF F468 3534 2EFE 2C09"
	$"2B2E 3134 3739 3B3B 3C3C FE3B FF3D 283B"
	$"3A3C 312E 2D2D 2C2F 3538 3B42 4F54 616D"
	$"6C78 3119 3535 3636 373A 3A3B 3636 3E39"
	$"1F08 0604 2130 271B FE13 1D14 181E 1B0A"
	$"020D 190D 0306 0702 0815 283A 3628 221B"
	$"2527 272E 3EA7 FFFB FDF9 FFFF FBFF FE04"
	$"F8BF 654D 3D04 342C 0301 01F5 0000 0101"
	$"802E D1EB D949 384E 4D4E 5055 5557 5B5E"
	$"6264 6565 6465 6361 6263 6362 635A 1E44"
	$"B5AF B9BF C7D3 CDA9 A5A1 9791 83AB 5412"
	$"43FE 4D33 4E51 5150 5054 5039 2017 1614"
	$"2647 575C 6671 7B80 7F78 5D41 333E 3228"
	$"2328 2F1C 1B31 4243 3F3C 4936 2B40 656B"
	$"8D89 B9B5 8F90 9190 FD92 0D90 9192 8E96"
	$"7962 ABBD AC9C 7822 01FC 00FE 01FE 0168"
	$"0301 02E7 FAF1 592E 4241 4242 4546 494D"
	$"5053 5556 5756 5757 5657 595A 595A 541B"
	$"41B8 B9C2 C7CF DCDB BEB5 B1AB A18D B256"
	$"103F 4746 4A4B 4C4C 4B4A 4D47 3321 150E"
	$"111F 343B 393F 464A 4C48 4337 2E26 322C"
	$"221C 222C 1715 2839 3B37 3340 3121 3252"
	$"5068 75C1 E7D6 D5D6 D6FE D70D D6D5 D5D6"
	$"D8DE AB51 7C8C 7A70 5C16 FE00 F800 1901"
	$"0000 FAFF FC82 3534 302C 2B2C 2C2E 3234"
	$"3638 393A 393A 3A39 3BFE 3C46 3D37 043A"
	$"BEC4 CCD3 DBE2 EAE3 E6E4 DFDE CEEB 8B1A"
	$"2F34 3235 3739 3938 3537 321E 0E0A 0704"
	$"132B 2F2A 251F 1F21 1E1B 120B 0513 1008"
	$"050B 1505 0213 2225 221F 2A18 0B1A 362B"
	$"3B3F B8FC FF00 FEFE FFFF FE07 FFFE FFFA"
	$"B766 483C 0535 2904 0301 01F8 0002 0200"
	$"0101 6C08 D6EF EC5E 364E 4D4D 50FE 5502"
	$"5A5C 5EFE 61FF 600A 5E5D 5D5E 5C5C 5B56"
	$"1643 FEFB FF52 A028 332D 2B27 543C 103C"
	$"4A49 494C 5050 4F49 3F30 2017 171C 2028"
	$"374C 5A71 8281 7466 5848 423C 4232 2921"
	$"1C24 2221 333F 362D 3C43 2F26 567B 7087"
	$"8A6E 8C93 8C8F 9191 9291 9190 9092 8F96"
	$"7668 B0BF AD9F 7620 01FC 00FE 01FB 0113"
	$"E7F8 FD6D 2C42 4142 4244 4648 4C4E 5253"
	$"5455 5454 FE53 FE55 0454 5013 43FE FBFF"
	$"51B1 3341 3C34 2E5A 410C 3443 4245 494B"
	$"4B4A 473E 2E1D 1815 131A 2127 363A 434A"
	$"4945 3C35 2F33 2F36 2B24 1A16 211E 1A2A"
	$"362E 2532 3729 1F43 6151 656C 62BC E0D7"
	$"D6D5 D6D7 D6D6 D5D5 D6D7 DCA5 5280 8E7B"
	$"735A 14FE 00F5 0012 F7FD FF8D 3335 322B"
	$"2B2C 2B2D 3233 3336 373A 39FD 38FF 39FF"
	$"3802 3903 42FA FF42 D978 837A 756D 9771"
	$"1623 2E2F 3035 3838 3732 2919 0905 0708"
	$"0A12 1A2B 2D2C 2725 2018 1611 160E 160F"
	$"0B05 020C 0908 1622 1A0F 1B20 1307 2740"
	$"2A3C 3746 D1FF FEFF FEFE FFFE FEFE FF05"
	$"FEF8 B866 493D 0538 2702 0301 01F5 0001"
	$"7A77 D4E2 E767 3850 4D4C 4E54 5356 585A"
	$"5B5E 5E5C 5A5B 5756 5556 5455 5451 1A26"
	$"D5EE EAE4 DCD3 C282 121D 2120 1B75 640A"
	$"3048 4547 4A4E 4F4B 3835 2920 1E1E 2028"
	$"302B 404C 5F71 6858 4D41 4646 4447 3829"
	$"1D21 1C27 3044 3F30 2F3E 301F 3771 6D80"
	$"7C84 816A 9790 8E91 9091 9090 9291 928F"
	$"9674 6DB2 BEAE A173 2101 FC00 FE01 FB01"
	$"17EE F4FF 792C 4441 4140 4345 484A 4E50"
	$"5353 5251 514F 4F4E 4FFD 4E5A 1A28 D9F2"
	$"EBE7 E1D7 CE93 1B28 2C2A 2682 6F09 2940"
	$"3D43 4749 4A45 3633 271D 1F1E 181F 2A1F"
	$"3234 3840 3A34 312D 3437 363B 3222 151B"
	$"1A23 293A 3528 2838 2C1A 295A 5364 5E64"
	$"6274 D4D8 D4D4 D5D6 D5D5 D7D6 D6D8 DE9F"
	$"5282 8F7B 7557 14FE 00F5 0017 FBFD FF9D"
	$"3834 2C2A 292A 2A2D 2F31 3135 3537 3636"
	$"3535 3435 FE34 5835 0825 E0FA F8F6 F2EE"
	$"E7C0 5A66 6C69 60BD A821 1D2B 2A2F 3336"
	$"3732 2320 140B 0B0A 060E 170F 2025 2623"
	$"1A16 1516 1917 141B 150B 0408 050C 1428"
	$"2516 101B 1108 1338 2B3A 3438 2E64 F3FF"
	$"FDFC FFFF FEFE FFFF FEFF FEF6 B762 4B3E"
	$"0539 2403 0301 01F6 0000 0101 8814 D5D6"
	$"CA56 3850 4E4D 4F52 5354 5858 595C 5D58"
	$"5656 54FE 5351 5455 5550 2408 385D 4845"
	$"3F39 2E28 2321 221C 2797 A021 1F42 4345"
	$"484C 4835 2A31 2922 222B 221B 3429 3547"
	$"484E 4E4C 493D 4F50 4C4C 3E2D 191F 1F21"
	$"274B 3F2A 2B2A 211B 536C 5999 8965 7C6F"
	$"8098 9091 8F91 9090 FE91 0A8D 9674 6FB5"
	$"BFB0 A271 1E02 FE00 0401 0001 0203 0002"
	$"FE01 FF02 14F4 F2F2 7732 4441 3F41 4345"
	$"464A 4B4C 4F50 504F 4E4D FD4C FE4D 4D26"
	$"0A3F 6955 534E 473F 382E 2C2F 2A34 A4AA"
	$"231A 3A3C 4146 4846 3428 3028 2425 281C"
	$"162E 1F23 312F 2F30 3437 2E3F 4041 4136"
	$"2A15 1B1A 1B21 4437 2323 211C 1640 5644"
	$"7A6E 4D61 5C9D D8D5 D3D4 D6D5 D5FE D609"
	$"D8DD 9D55 858F 7D75 5712 FE00 FB00 FF01"
	$"0000 FE01 06FB FDFB A949 312C FD29 5B2A"
	$"2D2E 3033 3436 3534 3435 3434 3535 3634"
	$"1103 5298 878B 8681 7975 7170 7269 70DF"
	$"EB4A 1227 292C 3134 3322 1B21 1711 1115"
	$"0703 1C0C 101E 1A16 141B 2118 201C 1E23"
	$"190F 0408 0807 0A30 2710 0C09 0606 2430"
	$"1F4E 3C23 3632 A4FF FFFD FDFE FEFD FF05"
	$"FDF7 B162 483C 0536 2301 0301 01FC 00FF"
	$"01FD 0000 0101 834F DBE1 D76E 324E 524F"
	$"4E51 5354 5758 5A5C 5C56 5555 5251 5153"
	$"5453 534F 2C03 33A3 4F12 1C1C 1E1E 2221"
	$"221D 254C 6E1D 173F 423F 3B37 2F22 2523"
	$"201D 172C 2C17 2543 3E45 464A 5052 463F"
	$"5053 434B 462B 1316 FE1D 2344 3A25 482C"
	$"1628 7A66 5BAB 9B4D 4D6E 7D99 8D8D 8C8D"
	$"8D8F 8F90 908F 946C 70B8 C2B0 A46E 1BF9"
	$"0000 01FF 01FF 0015 0201 F4F8 FF98 3343"
	$"413F 4043 4546 494A 4C4D 4F4F 4E4D FE4C"
	$"014D 4CFE 4B4A 2E05 39AC 6128 3030 322F"
	$"3231 332F 3459 7A21 1437 3A3A 3935 2F24"
	$"2625 2120 1929 2814 203D 3034 383B 4147"
	$"3E32 4046 3C41 3E29 1212 1618 183F 351F"
	$"3E22 1322 624F 4684 7C38 3B56 76CD D6D1"
	$"D3FD D4FF D509 D6DC 9252 8892 7F77 5511"
	$"FE00 FB00 FF01 FF00 0A02 01FE FFFF BC49"
	$"332F 2926 FE28 0C2B 2E31 3234 3534 3333"
	$"3434 3535 FE34 4819 0048 E0A0 7176 7677"
	$"7376 7573 6B70 94B2 460F 2627 2624 211D"
	$"1419 160F 0E0C 1C15 010E 2A1F 2221 262E"
	$"352C 1A1E 1F19 2120 0E01 0304 0503 2921"
	$"0927 0C01 0E44 2921 5444 111F 325F ECFF"
	$"FBFE 08FF FEFF FFF4 A65C 453A 0835 2000"
	$"0301 0202 0000 FD01 FC00 0184 12A4 A39D"
	$"633E 4E52 4E4E 5153 5455 5759 595A 5552"
	$"FE51 6952 5151 5050 4F30 0724 6352 1E1C"
	$"2020 1D20 1E20 201B 589D 3D0E 3840 3623"
	$"2520 2731 1E22 1611 1F2B 221A 3F58 5758"
	$"5655 4738 4452 4F38 473D 1612 2422 1A17"
	$"2F2E 274D 341A 336D 4F59 AAA2 4E44 5584"
	$"99A2 8D8B 8B8C 9090 918E 97A2 6772 BEC2"
	$"B3A5 6C18 0001 060B 170E 0905 00FB 0013"
	$"BCC1 C581 3A44 413E 4043 4546 4749 4B4B"
	$"4D4E 4B4A FD4B 4C4C 4B4A 4C32 0A2D 7068"
	$"3833 3737 3233 3235 322B 66AD 420B 3138"
	$"3221 2220 2832 1F25 1710 1D29 1E19 3E54"
	$"5253 5151 4536 3842 4230 3D35 1210 1F1C"
	$"1916 2E2B 2145 2B18 2A56 3B44 807C 393A"
	$"4069 A9DD FED6 11D5 D6D5 D7D5 D3DF 844F"
	$"8B91 8079 530F 0000 0205 050E 0A05 0201"
	$"FB00 16E4 D9D5 8E39 3430 2926 2729 292A"
	$"2D31 3032 3431 3032 3334 FD33 4835 1B00"
	$"35A7 AD83 7F82 827B 7A79 7974 6CA4 DD6C"
	$"0B20 241D 0D11 101A 220D 0F05 0510 1407"
	$"052E 4440 3F3F 4234 221D 201E 111C 1903"
	$"020E 0502 0319 1309 2B12 0410 3518 214F"
	$"4011 1E26 42A3 FCFF FFFE 08FF FEFC FBE7"
	$"9456 453D 0836 1E01 0401 0102 0802 F800"
	$"018D 1756 4D4C 4B4E 5052 5050 5153 5456"
	$"5758 5959 5552 504F 5050 4EFE 4F64 4E33"
	$"0D10 2220 1F1E 1E22 2519 1E1F 1F1C 2C43"
	$"360B 2F3D 3220 2322 2F40 272C 2018 1D25"
	$"2520 364F 5C5D 5F4F 2C2B 5B50 4840 3E2C"
	$"0A1F 3E2C 1815 2823 2B49 2A1F 3449 3148"
	$"9E9E 5240 4B78 A2AF 7F79 7D81 8587 8987"
	$"98C9 7B75 C5C3 B2A7 6914 0004 111C 2824"
	$"1F20 1400 02FC 0113 524B 4746 4045 4341"
	$"4243 4547 494A 4B4B 4C4D 4B49 FE4A 0048"
	$"FE4B 5E4A 340E 1E3A 3738 383A 393B 3236"
	$"3634 2F3D 523D 0B29 3630 1F21 2230 4028"
	$"2C1F 151B 2422 1F37 4E5B 5D5F 4E2A 274D"
	$"4038 3534 2407 1E39 2518 1426 1F24 4021"
	$"1729 3B27 387B 7B3E 383B 5B88 C9C0 BDC2"
	$"C6C9 CDD2 D3D3 F68D 5390 9180 7951 0D00"
	$"0208 060E 1A1A 1418 0F01 FE00 FF01 1757"
	$"4540 332E 3331 2A28 2929 2A2C 2E30 3031"
	$"3331 3031 3232 30FE 324B 341D 0024 707D"
	$"7F84 8686 837A 7F80 7E78 8392 700F 1822"
	$"1A0B 1113 212E 1417 0903 090C 080A 2741"
	$"4B4A 4D3D 1714 311E 1919 110A 010F 230B"
	$"0003 1105 0A23 0905 0C17 091B 4E41 0F19"
	$"2537 5DD3 F5FD FBFF 06FD FFE4 8D57 4B3C"
	$"0339 1E00 03FE 0104 0A07 0508 07FB 0001"
	$"927F 4D4A 4A4B 4E50 5251 4F51 5252 5354"
	$"5556 5751 4E4E 4C4C 4E4D 4F4F 4E4E 3A0F"
	$"0F23 221F 2011 3BA3 791A 1A1C 1A1B 201E"
	$"062C 3A1F 1528 2C38 3B2F 2A24 211D 1C20"
	$"1B24 2D42 5A52 3417 123F 4E3D 3C39 210B"
	$"2D4E 3D24 1A26 2234 4B30 2A31 3328 427A"
	$"8A52 313D 579A AE73 6060 5D5F 6061 6268"
	$"8A7C 89CA C5B3 A966 1400 030D 1210 1212"
	$"2221 7F08 0101 0203 0241 3E3E 3D3F 4445"
	$"4341 4346 4748 494A 4A4C 4C48 4847 4849"
	$"494A 4A49 4839 111A 423B 393A 3050 B795"
	$"3635 3833 3232 2906 2535 2017 292B 3538"
	$"2C27 211D 1918 1D18 212A 4057 5133 1109"
	$"3242 312E 2E1A 082D 4636 2417 201D 2B3F"
	$"2620 272B 2234 616E 3E25 3342 708D 6A5F"
	$"6367 6D72 767B 7D95 7462 9191 817B 4E0D"
	$"0001 051B 0807 0808 1A18 0301 0000 0101"
	$"312C 2A2C 312F 2C29 2729 2B2B 2C2D 2E2F"
	$"FE30 2733 3030 3131 3333 3233 2301 2077"
	$"898A 9281 9DE0 C17E 8583 7E7B 7A65 1314"
	$"1E0B 091B 1B23 2519 150D 09FE 0835 040D"
	$"152B 443E 2205 011F 2716 140E 0600 1A30"
	$"1B0B 040A 0513 240E 0A0A 0808 1B39 3D15"
	$"081B 2B43 636A 7887 8A99 9CA0 B4B9 C4AF"
	$"7056 4B3B 043A 1D00 0001 FE00 0302 0308"
	$"08FB 0001 91FF 507D 4E5A 6351 5152 4F51"
	$"5152 5251 5253 524E 4C4D 4A4A 4B4C 4C4D"
	$"4B4B 3D14 0A1D 1F30 9856 265F 6629 181D"
	$"1B1B 1D1C 0C24 3822 0F26 2D2A 2628 271F"
	$"1915 1019 1F27 251D 2D2B 1A10 1014 292F"
	$"3942 191A 4257 3D23 1B25 2C2F 4149 383A"
	$"372A 4979 7B4D 2C2D 366E A9A0 A09D 9CA0"
	$"A2A2 A1A2 9D9F B4C9 C6B4 AB65 1701 070D"
	$"0F0E 0C0E 1C1C 1007 0101 0202 0342 4240"
	$"5361 4944 4341 4345 FE47 6B49 4A4A 4946"
	$"4644 4546 4746 4746 453D 1714 3F3C 49B4"
	$"7743 7683 4937 3D38 3739 2D0C 1C34 2211"
	$"282D 2723 2524 1D18 130C 1319 2323 1C2A"
	$"2715 0B0B 0D23 2A32 3B13 163C 4B35 2319"
	$"2026 2434 3E2E 302D 233B 5E5F 3C23 2425"
	$"547E 7075 7676 7577 7575 7676 7A83 9292"
	$"817D 4E0E 0003 05FF 0721 0406 1616 0301"
	$"0001 0102 3231 2E2E 2D25 2D2A 2729 2A2B"
	$"2B2C 2F2F 2E2D 2E30 2F31 3133 FE32 5833"
	$"2704 1171 9298 E0AC 92BA C596 898C 8784"
	$"836F 240D 1910 061A 1D16 1012 110A 0605"
	$"0006 080E 0903 1918 0700 0203 0E12 1820"
	$"0409 2837 1E0B 0508 1011 1C27 1516 1208"
	$"213C 3111 060A 1138 4531 3940 403F 4446"
	$"434A 4945 494F 4A38 0439 1C00 0002 FC01"
	$"FF06 FC00 0001 0193 FF52 7751 5863 5753"
	$"534F 5050 4F51 4F4F 504E 4D4B 4A49 4849"
	$"4A4A 4B49 4840 1709 2333 3890 8626 1217"
	$"1E1D 1C1B 1546 4808 1B35 2314 2326 271C"
	$"2222 1513 1111 1716 1817 1010 1C18 0D11"
	$"2129 2223 2A1C 374F 4E3D 1E19 2829 3143"
	$"4237 2B33 3546 707A 442B 2C2A 7EB2 94A0"
	$"A5A6 ABB0 B3B3 BCBE C0C2 C7C7 B6AB 661B"
	$"0A0B 0CFE 0B02 0C1C 1C00 06FE 017B 0203"
	$"4243 4152 6450 4545 4142 4445 4646 4848"
	$"4748 4544 4443 4445 4546 4442 3F1A 1348"
	$"5451 ABA7 4D3A 4143 4041 3E35 605B 0F17"
	$"3024 1725 2523 181F 1F13 1311 1018 1718"
	$"160D 0D16 100A 0F1C 231C 1E26 1731 4742"
	$"371D 1524 2429 3737 2D22 292D 3854 6036"
	$"2426 1E62 8A68 777E 7F81 8284 8586 8A8D"
	$"8F94 9283 7F4E 1207 0605 0607 0505 0719"
	$"1804 FE00 0301 0231 30FE 2D10 262D 2C27"
	$"2829 282A 2C2F 2F2D 2C2D 2E30 30FE 31FE"
	$"321C 2A07 0874 A9A2 DEDC 9E93 9A9D 9A98"
	$"9287 A59A 290C 190D 0717 1612 060C 0CFD"
	$"03FF 0629 0807 0103 0802 0004 0B0E 0908"
	$"1008 1D2A 281C 0503 0D0B 0F1A 1D14 0A12"
	$"131F 3634 0A06 0C04 4255 3342 494A FD47"
	$"064C 4949 4848 4939 0D39 1A01 0201 0102"
	$"0102 0106 0801 01FE 0000 0101 90FE 550A"
	$"5451 5756 524C 4D4E 4F4F 4DFE 4B6E 4A48"
	$"4647 4746 4547 4847 423F 1D09 94B8 7C16"
	$"1C1D 1919 1C19 1C1C 1837 5E1A 1027 251F"
	$"2C24 1F2B 2516 1023 2C2A 211E 1B15 140E"
	$"1112 1423 342D 231E 181B 4355 4C42 2418"
	$"2123 3A41 2F29 1E29 4A4F 6872 3F2C 2C36"
	$"94A1 959C A5A6 A8AC B0B4 B8BC C0C2 C8C8"
	$"BAAF 6B24 1911 0E0E 0C0C 0D23 1F05 0701"
	$"0001 0202 FE46 0745 4147 4746 4041 43FB"
	$"4468 4241 4142 4241 4142 4342 4140 1F0E"
	$"A8D7 9F43 4A4D 4A48 4740 3F3B 344D 6A1B"
	$"0E25 241E 2D24 1C2A 2415 0E1E 2627 2420"
	$"1D13 100A 0B0B 0E1E 2E27 1E1C 1314 3B49"
	$"403A 2316 1F21 3234 2422 1D25 3D3E 4E58"
	$"3023 2325 7175 6A71 7C7D 7E81 8386 878A"
	$"8C8F 9493 847D 4E17 1109 0623 0706 0508"
	$"1A15 0100 0001 0202 3332 2F2E 2C30 302F"
	$"2725 2628 2829 2B2A 2A2E 2E2D 2F2F 2E2D"
	$"FE2E 5830 2B0D 05B4 F4D2 96A6 AAA6 A3A0"
	$"968F 8173 8595 360B 1010 0F20 140B 1812"
	$"0400 0B14 1513 0F0B 0604 0002 0301 0A13"
	$"0F08 0504 061D 2725 2109 0209 0717 1808"
	$"0706 0D1F 2333 340C 070B 0F43 3F36 3C46"
	$"4647 4543 4548 4B4D 4C4B 473E 053C 1903"
	$"0100 02FE 0102 0208 05FE 02FE 0101 957F"
	$"504F 4E4D 4C4D 4D4C 4B4D 4D4B 4B49 4748"
	$"4745 4241 4040 4241 4041 4240 3E22 0C77"
	$"946E 2B14 181D 2122 1E1C 1B1E 181B 1910"
	$"1D26 2025 2B36 392E 1721 3239 3C2B 1F24"
	$"1C11 1014 1D24 3036 2720 1F1D 203A 574E"
	$"462F 181B 2D3E 4939 302C 4854 426B 7441"
	$"2724 50AF 9084 99A6 A9A9 AEB2 B0A9 ABAF"
	$"B6BE C6BF B163 2F28 140F 0F0D 0C12 281F"
	$"1F15 0E09 0503 0142 4241 403E 3E3F 4040"
	$"4141 3F3F 4040 4140 3E3D 3F3D 3D3F 3E3D"
	$"3EFE 3F5C 250E 7A9F 7F45 2B2C 2C2A 2623"
	$"221F 1F1C 1B15 0D1B 251F 262B 3338 2D16"
	$"1E2D 3438 2C20 2519 0D0D 1018 1F2C 3022"
	$"1E1E 181A 3249 423E 2B13 1629 333B 312A"
	$"253E 4733 525A 321D 1938 8968 5D6F 7A7D"
	$"7D7F 8282 7B7F 8184 8A90 8681 4B22 1E0A"
	$"0619 0806 050D 1D15 0F09 0502 0100 2F2D"
	$"2926 2526 2727 2627 2624 2325 FE26 002B"
	$"FD2A 332C 2B2B 2C2D 2C29 1105 80B5 9E6F"
	$"5854 4C44 392E 241C 180F 0E0B 030B 1312"
	$"181B 2226 1A06 0C18 2023 170E 130B 0302"
	$"0205 0912 150A 07FE 0626 142B 2724 1101"
	$"0112 1F25 1711 0D20 2617 3737 1004 031E"
	$"5632 2A3C 4143 4847 4542 3C42 4444 4748"
	$"3D11 3B17 0808 0103 0200 0104 0902 0200"
	$"0101 0000 0196 7F40 3E3D 4041 4243 4645"
	$"4647 4648 4A48 4640 3A36 3434 332F 2925"
	$"272D 2E2C 1E0C 141F 151B 191A 1C1C 1D1B"
	$"1A13 1113 1417 0F11 1B19 2030 3025 1E1B"
	$"3138 3F3C 2A24 2118 090F 242A 2F2F 2A2C"
	$"2622 2227 3149 5049 3A23 1D33 4247 292C"
	$"546B 503E 5E72 4522 2474 A38F 7A8A 8382"
	$"8791 9A9E 7C6A 707A 7E87 9EAA 5315 1A10"
	$"0B0E 0D0C 1426 1F2A 2425 211C 1712 3533"
	$"3435 3638 383B 393A 3B3A 3C40 423F 3A36"
	$"3435 3634 302B 2629 2E2D 2D22 0D0E 1915"
	$"1714 17FE 1551 171A 120E 0C0B 0E0A 1018"
	$"1722 2F2D 241D 1A2E 333A 3828 221E 1504"
	$"0A20 252A 2B26 2A28 221F 2228 3B44 4133"
	$"1C16 2A34 3B27 2944 5742 3248 5835 1818"
	$"567B 6A55 6262 6468 6F76 7759 4C52 585B"
	$"6172 823C 0A12 0B05 FF07 2D06 101D 161B"
	$"1D1B 1815 0F21 1F1B 1A19 1B1C 1E1F 2324"
	$"2223 2727 2520 221F 1F20 201B 150F 1016"
	$"1815 0C01 0513 0D08 06FE 0202 0102 04FE"
	$"0046 0104 0303 0A0D 141F 1C11 0C09 1A1C"
	$"231F 0F0E 0F06 0001 0C10 1515 0A10 100B"
	$"0708 0D20 2923 1A09 0212 1E22 0B14 2E34"
	$"1F16 2B37 1602 0232 4333 2230 3034 383B"
	$"3D41 271E 2428 272A 3911 4110 0105 0100"
	$"0101 0205 0600 0404 0504 0302 0196 7F2D"
	$"2F2F 3335 3739 3B3C 3E43 484E 5052 524D"
	$"4031 261C 1B1B 1C1D 1F21 2626 2415 1613"
	$"0F0F 1015 1816 1013 1611 0D0A 0A09 1015"
	$"1816 1F2A 1C16 1B1F 333D 392A 292A 1923"
	$"190F 2337 3E33 2228 2C29 2B32 3130 4147"
	$"3428 2228 4234 263C 748B 513A 4E4C 3D21"
	$"29A0 A589 8385 4C3D 423E 383C 362A 2E44"
	$"4F43 4C61 360C 0E0B 0B0F 0E0E 1724 1D01"
	$"2025 FE26 7A20 2528 292B 2B2D 302F 3032"
	$"353A 4145 4949 443C 2F26 1C1A 1A1B 1E20"
	$"2225 2825 120F 0A09 0A0E 1514 1210 1110"
	$"0C08 0606 050E 1517 171F 2819 1419 1D30"
	$"3936 2827 2917 2016 0E21 3239 2D1F 272B"
	$"2726 2B27 2437 3E2D 211C 1F36 2C23 365D"
	$"7343 2D3C 3B31 191B 7A78 635F 6234 2D30"
	$"2E29 2623 1A1E 313B 2F36 4926 060A 0806"
	$"0D07 0606 121D 1316 1D20 2324 1C0F 11FE"
	$"106E 1214 1316 1A1E 242A 2E30 2F29 2318"
	$"0F08 0604 0303 0507 0B0E 1003 0302 0102"
	$"0307 0302 0103 0402 0103 0201 0408 0908"
	$"1119 0703 070B 1A1E 1C0F 0F14 060C 0803"
	$"0E1D 261A 080F 1310 0E11 0E09 1A21 150B"
	$"0507 1B0F 0820 4149 1D13 1F16 1204 0950"
	$"3D2C 2F31 0A09 0E0E 0C10 0D06 0912 130A"
	$"1011 1D0B 0103 0001 0300 0105 0400 0406"
	$"0504 0706 0196 7927 2D32 373B 3F41 4547"
	$"4845 5055 5657 5B5D 5D5B 5335 2930 3235"
	$"3031 3535 2916 0E0C 0A05 0707 090B 0B0C"
	$"0E0E 0F0D 0C0B 1315 141A 181B 1C27 221F"
	$"333F 2D20 3737 1F2A 2614 1E3C 3E2E 1923"
	$"2D2E 3636 392F 2D33 3026 2735 5936 3356"
	$"8189 5F3C 4331 2920 2FA6 B68B 78A0 583F"
	$"3928 160E 1115 203C 572B 1916 0F0A 0E10"
	$"10FE 1202 1C21 2215 1F1A 181C 1917 2127"
	$"2D2F 3035 3739 3B3C 3841 4647 494E FE50"
	$"124A 2F23 2A2E 312D 2C2F 3425 100D 0907"
	$"0608 0709 FE0A FF0B 4E0C 0A09 0913 1615"
	$"1C1A 1C1A 231F 1C2E 3828 1C32 321A 2624"
	$"131B 383A 2A17 212B 292F 2D2F 2724 2B29"
	$"2122 2C4E 2F2C 4766 7051 2B35 2923 191F"
	$"7C87 6456 7E3F 302D 1F11 0809 0B11 2A45"
	$"2010 0B09 0508 0A08 3409 0A0B 151A 1814"
	$"1112 1710 1009 0F15 1718 1C1D 1F21 2220"
	$"2A2F 3131 3334 3335 2F19 0F12 1418 1413"
	$"161B 0E01 0102 0403 0201 0406 0605 FE06"
	$"0504 0200 070A 08FE 0A3E 0611 0C0A 171E"
	$"1106 1C1C 050B 0902 081F 2112 050C 1211"
	$"1716 1709 070F 1108 0A12 2F11 152E 4042"
	$"2B13 1504 0503 0B4F 462A 284F 150C 0B04"
	$"0000 0100 020C 1F03 0011 0001 0001 0201"
	$"0200 0004 0302 0301 0306 0403 0196 7F35"
	$"3334 3B3F 4145 4A4A 493F 434F 585C 5E5F"
	$"5D52 4944 3C3F 3F3C 3437 3835 2408 070A"
	$"0C0B 0D0D 0F11 1214 1614 151A 2022 1C11"
	$"0D1C 1A1A 2328 2A28 3033 2924 352E 1B20"
	$"221D 2234 3425 1924 2926 453C 3B37 2921"
	$"2623 2746 5D44 304D 6E66 4B4B 452A 1B20"
	$"449A AF8D 6C8A 6247 443F 3B39 475D 6A6B"
	$"632F 1510 1012 1218 1A1E 1D1F 2523 312C"
	$"403D 3230 1C1A 302E 2E33 3337 3B3E 3E3D"
	$"373A 4148 4B4E 4F4C 433B 3B35 3838 372F"
	$"3132 3626 0708 0B0D 0A0C 0C0D 0EFE 114F"
	$"1011 151A 1C1A 120E 1D1C 1A20 2627 262B"
	$"2D25 2130 2916 1D1E 181D 3030 2117 2227"
	$"213F 3331 3123 1B20 1D23 3C50 3A27 3E54"
	$"513E 3B35 2216 1932 7384 694B 6947 3534"
	$"2F2D 2C36 454F 514E 230C 0B0C 0A0A 0E12"
	$"FF16 1019 1C19 2533 3129 2611 1217 1516"
	$"1A1A 1E21 FE23 1F1D 202A 3032 3331 2E27"
	$"2221 1A1F 201E 1619 1F22 1500 0004 0806"
	$"0504 0506 0807 06FE 0546 0A08 0805 030E"
	$"0805 0B12 1413 1615 100C 1911 0305 0604"
	$"0716 1607 040D 0F09 271D 1916 0801 0705"
	$"0B22 2F1A 0C1E 302A 1D1E 1404 0000 1743"
	$"3F2C 1E3B 1A0F 130E 0C0E 1521 2422 2305"
	$"0111 0102 0101 0507 0703 0406 0307 0E0D"
	$"0C10 0606 0196 7F46 3F35 353A 3B42 4445"
	$"4746 4A48 515C 5C52 3726 1C2E 3E43 4647"
	$"494B 412F 2112 040A 1521 2224 2727 282A"
	$"2B26 2427 2A2E 1E0A 091E 2522 2A27 332C"
	$"2324 2031 3326 1516 2023 2625 2421 1820"
	$"2A1E 454A 3334 2822 2121 2A49 5A39 2B39"
	$"3E2F 3753 4536 1828 5B8D A683 648A 8A80"
	$"7F84 8982 98A7 9D86 6B4D 3624 1C16 1315"
	$"1A21 2325 272F 417F 3A30 2E32 2C1F 3E38"
	$"2F2E 3233 393A 3A3C 4145 3D43 4E4F 452F"
	$"2018 2735 3B3F 4040 413D 352F 1A03 0812"
	$"1A1B 1D1F 1E1F 2123 1E1B 1D21 271C 0A08"
	$"1E21 1C22 222F 2821 2522 332F 2311 131B"
	$"1B1F 201F 1C15 1D26 193E 412A 2F23 1D1D"
	$"1B23 3D4B 2C21 2F2E 222B 4437 2F14 1F44"
	$"677B 6048 6B6B 6563 6669 5E71 7B74 614F"
	$"3B28 1C13 0C0B 0E12 7F18 1B1E 1F22 322C"
	$"2222 2721 1527 2117 161A 1B21 2220 2227"
	$"2B26 2C34 3429 1608 020D 1A23 292B 2C2C"
	$"2926 2D1E 0203 060E 0D0D 0C0A 0C0C 0D07"
	$"0506 090D 0700 000F 100A 0E10 1C14 0B0D"
	$"0D1E 1B0F 0103 0908 0A0B 0B08 0408 0D05"
	$"2727 1116 0B05 0604 0B21 280B 070F 0D08"
	$"1125 1512 0107 233B 402B 1F41 413F 3F3D"
	$"3728 383E 3429 2113 0900 04FE 0001 0203"
	$"FE06 0805 0A0F 0905 060B 0802 0195 274F"
	$"423A 3435 393D 454E 5A5F 645E 4A4F 4D40"
	$"271C 2835 3F44 464F 5E6C 6B55 2E18 1204"
	$"1022 2121 2220 1FFD 1E53 2425 2724 1F19"
	$"1A20 2229 3B40 2E28 2627 3639 2715 171F"
	$"1E27 2622 1E1C 212E 203C 5731 2423 2523"
	$"233C 4E43 2F28 372A 1A38 4142 4823 3165"
	$"849C 7E5B 88A7 A8AD B6B7 BAB2 A58F 7A6D"
	$"6563 5B4B 3A2C 2620 2125 252C 4041 2C2D"
	$"211D 1F24 2645 3B36 3334 3537 4048 5254"
	$"5954 4047 473A 251A 2530 363D 464D 555D"
	$"5D50 3A2E 1C01 0D1C 1A1B 1B17 FE16 4F17"
	$"1518 1D23 221B 1618 1F1F 2435 3A29 2322"
	$"2332 3121 1014 1C19 2222 1D19 181B 2818"
	$"3550 2A20 1F21 201D 3040 3625 1E2C 2314"
	$"2B34 3741 1C21 475E 7260 456A 8182 8287"
	$"8685 8076 6657 4E49 4945 392B 1F1C 177F"
	$"191D 1E22 2F31 2116 1316 1D1D 3328 221E"
	$"1E21 242C 333B 3F3F 3B28 2C2E 2411 0611"
	$"1C25 2D36 4249 4941 3731 382C 0602 0A08"
	$"0706 0302 0304 0403 0406 0D10 0D07 0912"
	$"1312 2326 120D 0F10 1E1D 0E00 0509 050B"
	$"0D0A 0707 060E 041D 310F 0708 0D0C 0817"
	$"2212 0606 0E04 0013 1618 2408 0D23 313F"
	$"2F1C 425A 5F60 5C47 423D 3129 2622 2223"
	$"0620 180E 0804 0203 FE05 0212 0F06 FE01"
	$"0103 0501 967F 403A 3A43 4542 434B 5363"
	$"7476 7566 5356 4A40 3F3E 3E3B 3F45 4859"
	$"738A 8E6A 2727 1A11 171C 1F23 292C 3137"
	$"3C3E 403F 3128 2423 2223 2C33 392F 272B"
	$"2B2F 2B26 2016 181F 2322 2424 1920 2329"
	$"2233 452D 1E21 272B 2E3D 3E2B 3436 2F1C"
	$"2536 302C 413A 455C 7396 7A57 78C1 BDC1"
	$"AD9C A29A 9388 7D78 7576 7677 7B7A 7369"
	$"6262 6060 644B 7F29 1717 1421 2A3E 3738"
	$"4141 3B3A 434A 5864 6463 5647 4B42 3A39"
	$"3739 3337 484C 5060 7079 6132 361D 0C12"
	$"171B 1D22 2528 2C31 3338 3A31 2824 2322"
	$"2328 2E35 2B24 2624 2925 201B 1417 1C1E"
	$"1F23 2217 1D1F 221A 2C3E 271A 1C22 2627"
	$"3334 222A 2D29 171F 2C25 243A 3030 4356"
	$"735E 4058 968F 9380 7178 7068 615B 5854"
	$"5457 5A5A 5853 4FFF 4B79 4844 4A3B 1F0F"
	$"1411 1B23 2C25 2730 302B 2B32 3945 4941"
	$"4138 2A30 2826 2728 2B28 2E3E 4547 4A4B"
	$"5040 283B 1D04 060A 0A09 0D10 151A 1F21"
	$"2527 2018 1413 1316 1C1C 1F16 0F12 1113"
	$"0E0A 0803 060A 0908 0D0E 0609 0706 0111"
	$"200D 0105 0E10 101B 1806 1013 0B00 090F"
	$"0809 1F16 131C 283C 2816 2E67 646B 4C31"
	$"3933 2A27 FE29 002A 112B 2E2C 2B28 231F"
	$"2323 2025 1304 0004 0408 0B01 961F 403B"
	$"3D49 4D48 494D 5560 6D6D 6A68 635D 544A"
	$"4E4D 4646 4035 3B4C 5E77 7D68 4840 FE3F"
	$"2542 464A 4D4E 4F4F 5052 5342 2714 0E15"
	$"1D28 2E2C 221E 2229 3436 2B20 1C16 2124"
	$"241F 1A15 1C2D 27FE 2833 2625 2D2D 242C"
	$"383E 2B1A 3642 2B20 3234 312E 3147 5D57"
	$"578B 7D56 7DC7 CDC2 9682 8586 8987 8383"
	$"858B 8E90 8F8B 8689 8C8A 8B8C 8C83 7F76"
	$"6348 3730 323C 3635 4247 3F3E 4449 535C"
	$"5C59 5752 4E47 4245 4341 413D 383E 4751"
	$"6167 593F 3C3B 3635 383B 3D3F 4042 4243"
	$"4446 3A23 1310 171E 272C 2821 1D21 242C"
	$"2F24 1D1B 1721 211E 1C1B 161C 2B22 2221"
	$"221F 1E29 281E 232E 3626 142D 3929 1D2C"
	$"2C29 282A 3744 403F 6B63 3F5A 9799 916B"
	$"5C63 6262 605F 5E5F 6366 6867 6463 6554"
	$"6564 6665 6361 5847 342A 2427 2923 2330"
	$"342D 2B2D 313A 3D36 3435 3130 2A2E 373A"
	$"3432 312C 353E 4046 4236 262A 2C26 2627"
	$"292A 2C2D 3031 3233 3427 1104 0107 0E1A"
	$"1F15 0705 0C12 1815 0906 0604 100F 0A05"
	$"0502 0915 08FE 0427 0509 1011 0A0C 181F"
	$"0D02 1A1F 0F09 120D 0D10 121A 2016 183A"
	$"3016 2F5F 6158 2F27 2F2E 2F2D 2D2E 3033"
	$"1133 3131 302F 3334 3233 3031 2F2A 1F12"
	$"0C08 0A01 94FF 541C 5052 5557 585B 5755"
	$"5453 5252 514D 4746 4D4C 4948 463F 3D41"
	$"4551 5650 4CFE 4DFE 4F5A 5152 5253 5455"
	$"5554 3F21 1112 1925 1C17 161B 252A 3334"
	$"2C27 2325 1B28 2C25 1B21 1921 2927 3130"
	$"221D 282F 2B1F 3543 402E 1940 3D25 292F"
	$"2228 363D 4A61 4F45 7373 578C D3CE B19D"
	$"9292 9091 9094 9587 8792 9894 8D8B 898A"
	$"878B 95A0 A42B A6A5 9A8F 867E 4949 4548"
	$"4B4C 4A4A 4949 4745 4440 3F40 3E3D 4241"
	$"4242 403B 3C3D 3E44 4945 3E40 4241 4342"
	$"4343 FE44 4145 4647 4836 1C0F 111B 291F"
	$"1713 1923 272D 2E26 2222 251B 2526 1F1A"
	$"241B 2325 212A 2A1C 1722 2A26 1928 3839"
	$"2915 3A38 2125 2B20 242C 3139 4A3C 3455"
	$"593D 63A0 9B7F 70FD 6C0A 696C 6D60 6064"
	$"6762 5A56 4F2E 4E51 5964 7078 7977 6F67"
	$"625D 3F3B 3332 3332 3030 2D2D 2A27 2627"
	$"2928 262F 3737 3533 332D 2E31 3132 3430"
	$"2E34 3634 35FE 34FF 354B 3435 3433 3525"
	$"0C00 020A 1811 0904 080D 0F17 160C 070B"
	$"1004 0F13 0A06 120B 120D 080E 0A01 010A"
	$"110E 020F 1E1F 1003 261F 0C0D 0C03 0814"
	$"191B 2111 0E2F 2E19 365D 553F 3538 3C3B"
	$"3A36 3A3B 2F2F 0434 332E 2C28 FE22 0927"
	$"3038 3B3A 3934 302F 2B01 950C 504F 4F4E"
	$"4D49 494C 4A4A 4D4F 4FFE 536F 504A 4847"
	$"4A4C 4D4F 4F54 585F 615D 5451 5252 5656"
	$"5758 595B 5D5F 6063 5E3B 221B 1419 2717"
	$"0D09 1720 273B 311B 1A2B 281B 2A26 1E18"
	$"1C21 1F27 2432 3429 1F26 3333 252E 373E"
	$"341C 2D35 2A2D 251F 252F 3D55 5C43 3F57"
	$"514D 90B8 BAAC A6A6 A0A0 9CA3 BAC4 C0B6"
	$"BBC0 C298 8A8E 8D8B 8D8E 959C 05A3 ABAC"
	$"ADAD AEFE 451D 4443 4342 4140 4343 4445"
	$"4747 4B4B 4340 4041 4343 4849 4C4D 5253"
	$"4F47 4646 FE47 FF48 534A 4C4D 4C4F 5251"
	$"321F 1B14 1B29 190D 0815 1D22 362D 1615"
	$"2A28 1A26 2119 151D 221F 231E 2A2D 2318"
	$"212D 2D1E 242D 362E 1828 3125 2821 1E22"
	$"2830 4245 3333 4341 3768 8589 7C7A 7876"
	$"736F 7589 9590 848A 8B7F 401D 171D 1417"
	$"1C29 3D52 6370 7479 7B7A 3430 2C27 2628"
	$"2B30 2F31 3435 3639 383A 3A35 FE32 0933"
	$"3437 373A 3C3E 3F39 36FD 38FF 394E 3534"
	$"3638 3736 3738 1E0F 0B04 0B1A 0B01 000A"
	$"090B 2119 0506 1511 0713 0E07 030B 100D"
	$"0A04 0E10 0B02 0715 1606 0912 1A12 0214"
	$"190E 0D04 0104 0C15 221E 0A0C 1F1A 143A"
	$"4244 4044 4A47 4543 4757 564D 4311 4240"
	$"3711 0505 0305 090F 1924 2D37 3C3F 3D3A"
	$"018C 0243 4648 FE4A 084B 4D50 5255 5755"
	$"5756 FE57 6D56 575A 5D5F 5F5E 6064 6865"
	$"6664 6363 6668 6767 696B 6C70 7274 766B"
	$"3629 2D1D 1B20 130A 050C 2033 3F28 1109"
	$"2028 1528 281C 221F 1E1F 2821 2D3B 3328"
	$"2E43 452F 2627 433F 2115 2B35 2929 454B"
	$"3A3C 5B5D 3B46 483D 498B ADBC B2AC A09B"
	$"907B 95B7 CBD5 E5EE F7FB C291 9196 9593"
	$"9693 9212 979D A0A9 B2B7 3E40 4243 4344"
	$"4649 494A 4B4D 4BF9 4D01 4E4F FE51 0352"
	$"5654 55FE 53FF 56FF 5554 5759 5A5B 5B5F"
	$"615C 302A 3120 1A1E 120A 0609 1D2D 3A26"
	$"0F06 1F28 1322 2216 1E1D 1C1D 241C 2634"
	$"2D22 293D 3F29 211F 3738 1D10 252D 2222"
	$"3C41 312E 4648 2E38 3B32 3665 7B8B 847E"
	$"6355 473F 6586 97A0 BAC9 C4B0 540C 06FF"
	$"084D 0604 060C 1527 3E55 6B7A 3032 3438"
	$"3B3E 403E 3F41 4243 4240 3D3D 3E3D 3D3E"
	$"3B3B 3E3D 393A 3C3D 3A3C 3A3A 3B3D 3C3C"
	$"3B3A 3A3B 3D3C 3D3E 3B15 1720 100B 0F04"
	$"0101 030B 1926 1202 000A 0D08 1611 070D"
	$"FE09 2C0C 0309 1B1A 0C0D 2428 1103 0119"
	$"1804 0111 1409 0A1D 2011 0F26 2107 1519"
	$"1216 363B 4E55 5445 362D 2744 5658 545A"
	$"0358 5451 1BF9 0005 030B 1928 3036 0195"
	$"2858 5656 5452 5455 5255 5558 5958 5A5C"
	$"5B5D 5E5E 6061 6364 6667 696B 6D6F 6F72"
	$"7474 716E 6D6C 6C6F 6C6B FE6C 535E 372E"
	$"2518 1715 1009 0511 1F2E 301B 0E17 2D23"
	$"0B0B 1919 2228 2325 2520 263C 3A36 3A3F"
	$"4839 2B28 4141 1D16 212E 2F40 586F 6447"
	$"5367 4643 4C3F 5F7C A7BF BBAA 7B5E 5851"
	$"677B 8797 E7F7 E8D4 B9A1 A0A1 9F9F 9A9D"
	$"A106 A2A4 A4A3 A7AB 56FE 5403 524E 4C4C"
	$"FE4D FF4C FF4D 064C 4E4F 4F51 5152 FE54"
	$"0D56 5757 595A 5B5C 5C5A 5B59 5956 57FD"
	$"564E 574F 2E2B 271A 1613 0E0A 060D 1A29"
	$"2C19 0B15 2D23 0A07 1416 1E24 1F21 201A"
	$"1E32 322F 3337 4234 241F 353B 1C10 1A27"
	$"2634 4758 5034 3D51 3233 3F31 4656 7990"
	$"8C7C 4419 0D08 2E4A 5361 AEAF 8658 3012"
	$"0E7F 0D0A 0B0D 0A08 0706 0A15 2943 605C"
	$"5959 544D 4947 4542 3E3D 3C3D 3D3C 3E3D"
	$"3C3F 3B3A 3B3C 3A3B 3C3A 3B3D 3D3C 3C3A"
	$"3938 3837 3938 3634 3332 2A10 1714 0807"
	$"0502 0100 0209 1416 0700 0817 0C03 0309"
	$"070A 0D0A 0B06 0008 1F20 1B1C 2029 1906"
	$"041A 1E04 0208 0F0F 1A27 372C 1119 290C"
	$"0E1D 1526 2840 5E6F 6A37 0A02 0218 2324"
	$"2960 0C4C 2B19 0903 0201 0102 0303 0201"
	$"FE00 0104 0E01 9206 6C66 615D 5A5B 5AFD"
	$"580B 5958 5A5C 5A5D 5D5A 5B5B 5959 FE5A"
	$"6559 5856 5453 524C 4842 403D 3A38 3230"
	$"2C29 2722 201E 1914 1712 0C0C 1324 292A"
	$"190F 101F 311D 0C08 0E10 2536 291E 2124"
	$"2940 3E3A 3733 454A 3027 3B3F 1C18 1A1F"
	$"2F51 545D 6C79 785A 4B34 485A 7976 7AB7"
	$"C2BE AF91 795E 5762 6C7E B8D1 C8BE B6B2"
	$"B3B1 B0AD AEA9 A30F 9D9A C6DB DBDD 6863"
	$"5E5A 5551 4E4C 4D4E FC4C 054B 4E4E 4B4C"
	$"4EFE 4DFF 4C5F 4B4A 4846 4341 3B38 3633"
	$"312D 2B28 2724 201F 1C1B 1B17 1215 100D"
	$"0C13 2024 2615 0C0C 1D32 1E0A 060B 0F22"
	$"3124 1919 1D22 3533 3231 2E3C 3F29 1F33"
	$"3919 1518 1B26 4348 4853 5E5B 4337 2339"
	$"455D 5757 8E94 9085 6A4D 2C14 0E10 183C"
	$"4024 1614 120E 210D 0E0C 0B0D 0E10 1860"
	$"8E95 9A78 6F66 5E58 5049 413E 3938 3939"
	$"3838 3739 3533 3431 2EFE 2F5A 302E 2B29"
	$"2725 241D 1A19 1714 1413 0F0E 0C09 0805"
	$"0507 0401 0603 0101 080D 100D 0100 020D"
	$"1A0A 0201 0100 0D1A 0D04 0401 0A21 211F"
	$"1C15 2324 0A03 1821 0602 0405 1026 2728"
	$"2E32 2A13 1003 1C25 3528 2969 828D 7D5A"
	$"3B19 0200 0005 1708 1002 0000 0201 0002"
	$"01FD 0004 0531 4244 4701 920E 4A46 4543"
	$"4444 4343 4242 3F3E 3D3B 3AFE 3711 3433"
	$"302E 2C2A 2727 241C 1B1F 1818 1414 1718"
	$"FE16 5812 110F 0F0C 0E11 0F0F 1621 150E"
	$"101F 3234 2B13 0B12 1924 2016 1314 1320"
	$"2A27 1C27 2E33 423F 362C 293A 3D2B 2435"
	$"2D20 1E16 1923 404B 4854 82B0 6C3E 2733"
	$"6A85 6656 A7C9 C7C8 CAC8 BA9D 857A 7B8A"
	$"9EB4 BBBB B8B3 B0AC A69E 9994 0C7E 74C9"
	$"F9ED E545 4140 3D3B 3A38 FD36 FF35 0132"
	$"30FE 2D63 2B29 2928 2624 2322 2018 171B"
	$"1313 100F 1515 1415 1615 1310 110E 1012"
	$"100E 151F 1410 111F 2D2F 260F 070E 1622"
	$"1E13 1012 121D 2423 171F 272B 3835 2F28"
	$"2531 2F26 1F2F 2519 1C17 151A 3341 3D41"
	$"5F88 5233 1A24 546D 533D 829D 9899 9A99"
	$"8C72 502F 1A0A 0D0F FD11 1412 171A 2631"
	$"3A37 3A99 D5CF C03B 3634 2E29 2725 2320"
	$"FE1F 1B1E 1C1B 1818 1715 1410 0D0C 0908"
	$"0806 0604 0301 0201 0001 0201 0103 01FE"
	$"0248 0103 0501 0005 0D04 0202 101B 1A0E"
	$"0000 0406 0C08 0503 0203 0D13 0E03 0B0C"
	$"0F21 1F18 100C 1715 0904 1711 0807 0100"
	$"0517 241E 2133 4B18 0902 0C32 4025 1764"
	$"8E95 908B 836E 4B2B 1205 00FE 0000 01FE"
	$"00FF 0108 060B 110C 135C 7566 5B01 9106"
	$"1B19 1616 1516 16FE 1806 1617 1715 1613"
	$"11FD 16FF 1768 1613 1410 0C10 1510 0F0E"
	$"0C13 1414 1818 1614 1313 1215 110F 121F"
	$"2113 121A 2132 312F 1409 131D 2923 1916"
	$"161B 1C19 271F 3941 282B 2E2A 2023 3430"
	$"1B21 2A19 262A 231B 2034 414A 4873 B78C"
	$"3F25 1E42 7F57 47A1 CFCD CECF D1D3 D5D3"
	$"C9B5 947C 7C8B 9398 9BA1 A7AD BAC4 C716"
	$"9A62 7DBA D8DD 1411 0F0E 0D0F 1011 1212"
	$"1415 1615 1613 12FE 17FF 15FE 140A 1611"
	$"080C 120D 0D0B 0B14 16FE 1501 1714 FE13"
	$"3F19 120D 0F1E 2012 131B 222F 2D2A 1004"
	$"0E1A 241F 1413 151A 1914 221A 323A 2121"
	$"2423 191A 2D29 151C 2415 2526 1E16 1826"
	$"3442 3D55 8B69 3121 1831 6644 307C A49E"
	$"9EFE 9F0A 9E9A 9583 653E 2520 1F29 3910"
	$"495C 6F7F 8C94 7240 5388 A7AD 0805 0404"
	$"01FE 030D 0203 0201 0202 0504 0205 0605"
	$"0304 FE03 0804 0202 0302 0206 0402 FE03"
	$"0004 FB03 4708 0402 030E 0C00 030A 111C"
	$"1812 0302 0507 1007 0102 0408 0B07 0E03"
	$"171D 0C0E 0D0B 0303 120E 0309 1407 120F"
	$"0601 030A 1222 2333 512C 0402 0016 4121"
	$"0F5E 999C 958E 877E 7266 5944 2D11 1A0C"
	$"0604 0810 1A26 3239 444A 3116 2B47 5052"
	$"018D 0002 FE00 1F02 0407 0C0E 1011 1312"
	$"1516 1314 1718 1916 1617 1613 1511 0D12"
	$"1310 1311 1117 17FD 1840 1412 1015 1A11"
	$"1317 1E22 1719 1D25 312C 2B19 090F 1C21"
	$"1D17 100F 2F38 2625 2141 3D0E 0B1B 201D"
	$"3147 2C10 1E20 192B 292A 2520 3042 4348"
	$"80AE 9743 2823 263E 433A A2FE D213 D4D5"
	$"D5D7 D8DC DFDE D3C0 B8B8 BCCA D4D7 DADD"
	$"DFE1 06D8 C0B0 B3C6 CE01 FD00 0E03 0609"
	$"0B0D 1011 1114 1611 1217 1819 FC15 0A17"
	$"130E 1416 0F0E 0D0E 1616 FE17 FF16 4017"
	$"1418 1B11 0F13 1B1E 1517 1B22 2D29 2816"
	$"050C 1A1C 1811 0D0C 2A34 2321 1C3B 3A0E"
	$"0816 1A15 293F 250A 191B 1426 2424 1E1A"
	$"2635 3C3B 6281 7032 241C 1A2F 3727 7DA7"
	$"FCA4 FFA5 08A6 A9AD A593 8786 8B96 0B9F"
	$"A6AB ACAE AFA9 9182 8592 9CFC 000D 0102"
	$"0201 0201 0202 0405 0305 0403 FE05 FF06"
	$"0705 0604 0302 0201 04FD 024F 0403 0302"
	$"0306 0307 0E05 0303 090C 0203 0811 1C11"
	$"0F07 0104 0608 0502 0302 171D 0C09 051F"
	$"1C03 0305 0402 1228 0F01 0709 0717 0F0B"
	$"0502 0510 1E20 3F4C 3104 0300 0210 1809"
	$"659E A59F 978E 8577 6B65 5F5E 1157 4E45"
	$"4143 494E 5355 5657 5853 4740 3C40 4301"
	$"9216 0302 0101 0204 080D 0F10 1214 1415"
	$"1712 1318 1A1A 1818 16FE 1860 1415 1516"
	$"0F14 1112 1718 181A 1818 1515 1013 1A12"
	$"161B 1C1A 1A1D 141C 3431 271A 0710 2626"
	$"1913 0B10 3340 3B34 2943 4427 1217 141A"
	$"3A37 1B0B 1711 1931 2827 251B 3137 2F47"
	$"918F 8441 2D2A 281E 264E AFD8 D3D4 D8D8"
	$"D9D9 DCDD DEE0 E2E1 E0E0 DEE1 E2FD E000"
	$"E175 E3E7 E7E5 E6E7 0201 0000 0103 070A"
	$"0D0F 1012 1214 1610 1117 1919 1717 1517"
	$"1718 1415 1616 0C10 0D0E 1617 1719 1717"
	$"1619 1417 1B12 1318 1917 171B 1018 2D2B"
	$"2216 040D 2522 130C 080E 2E36 2F2E 253D"
	$"4024 0D11 0E13 3531 1507 140E 142C 2322"
	$"2017 282C 2837 746C 642F 2321 1D14 1D37"
	$"85AA A6A7 AAAB ACAC FEAD 06B2 B5B4 B2B2"
	$"B0B0 02B1 B2B3 FEB4 05B7 BCC0 BFC0 C1FB"
	$"0004 0104 0302 02FE 0311 0402 0403 0505"
	$"0404 0304 0505 0204 0103 0105 FE02 FF03"
	$"4E05 0303 0408 0306 0E04 0406 0504 0409"
	$"030E 1E14 0906 0105 0E09 0302 0001 191D"
	$"1613 0A23 2513 0301 0005 1F1E 0600 0905"
	$"0718 0E09 0500 080B 0F1D 4C37 320C 0302"
	$"0200 081C 669A A7A9 A297 8B7C 7169 6260"
	$"085C 5B5C 5B59 5B5C 5A58 FE5A 055B 5F61"
	$"5E5D 5F01 8E23 0403 0102 0306 090B 0E11"
	$"1115 1516 1712 1319 1B1A 1B1B 181B 1D1D"
	$"181B 1D1A 121A 1314 191A FE18 4D16 1414"
	$"1114 191A 2022 1C1A 1913 0A13 2D2D 2116"
	$"0612 2F33 2419 1217 2F37 3D4C 4640 4738"
	$"352F 1816 251A 101A 1208 232F 221D 1917"
	$"2527 194F 7763 593F 4035 2B1D 1754 C1D6"
	$"CECE D5D8 DADC DDDE E0E2 E2FC E105 E3E1"
	$"E0E1 E2E3 FDE5 25E6 E703 0200 0002 0507"
	$"080B 0F0F 1313 1416 1011 181A 191A 1A17"
	$"191B 1A15 191B 170E 1710 1218 19FE 1748"
	$"1514 1512 151B 191D 1F19 1716 0F06 0E24"
	$"261A 1104 102D 2E1F 130F 142B 2F31 403B"
	$"3A41 312E 2914 1322 150B 1910 0620 2A1E"
	$"1815 141E 1E13 3D5D 4841 2F32 2821 1810"
	$"3993 A9A3 A6AC AFB2 B2FE B306 B6B7 B6B5"
	$"B3B3 B402 B6B8 B9FE BA06 BCBE C0C2 C5C5"
	$"01FD 0000 01FC 02FF 05FF 0464 0104 0405"
	$"0506 0503 0507 0702 0303 0402 0601 0104"
	$"0504 0403 0203 0602 050B 080B 0B06 0405"
	$"0400 0815 0F03 0300 0818 190D 0302 0513"
	$"1213 231E 222A 1815 0F02 050E 0601 0907"
	$"020E 1107 0304 0405 0300 2537 201D 0C10"
	$"0804 0103 246A 889D A8A9 9F90 8075 6E66"
	$"62FE 5D0E 5E61 605D 5B5A 5C5D 5D61 5F60"
	$"6461 6201 946E 0605 0101 0205 0708 0A0E"
	$"0F13 1315 1410 151A 1D22 1F1D 1E22 2620"
	$"2124 241D 191F 1A1B 1C1C 1916 1513 1311"
	$"0F14 1D1D 292C 1D12 100A 0B10 1E21 1E16"
	$"0815 2F35 261A 141D 2E36 3A45 4B3E 3939"
	$"3739 2117 1211 1326 1811 2C2C 1F18 0F2D"
	$"2A1A 0F51 5A49 3F39 5D4C 271B 0B40 CCD7"
	$"CFCD D1D4 DCFE DF07 E0E3 E3E2 E3E2 E3E2"
	$"FEE1 02E2 E6EB 18E2 E8E6 E8EB E702 0201"
	$"0001 0406 070B 0F10 1213 1515 1116 1D1D"
	$"FE1E 631D 1F22 1D1E 2022 1C16 1B15 171B"
	$"1916 1514 1314 1210 1519 1924 291A 0F0C"
	$"0608 0C16 1A1B 1404 112C 3123 1711 1928"
	$"2E2F 393E 3532 3330 341B 110C 0C10 2516"
	$"0E2A 291D 160B 241F 1209 3E46 352C 2A49"
	$"3D20 170B 2CA0 AAA1 A2A6 ADB1 B3B6 B9B9"
	$"BBBB BABA B9BA BA0F BBBC BEBF C0C1 B8C1"
	$"C4C6 C4C7 0202 0000 FC01 FF02 FF04 FF06"
	$"1602 0505 0609 0908 0606 0903 0406 0807"
	$"0305 0101 0408 0403 FE04 4A03 0207 0C09"
	$"0F13 0701 0202 0303 0608 0604 000A 1A1E"
	$"1106 0307 0E11 121B 201A 1819 1214 0401"
	$"0002 0410 0707 170F 0402 0015 0C01 0126"
	$"1F11 0C05 241C 0300 001B 6D80 939E A4A1"
	$"9C8D 796D 6867 1163 6560 5D5F 5F61 605E"
	$"6162 6258 6264 6567 6801 916F 0806 0100"
	$"0204 080B 0B0E 1314 1518 1917 1D22 2427"
	$"2421 2629 2825 292B 271E 1F1F 1D1E 1D19"
	$"1716 1615 120F 0D14 1C24 291C 160F 0A09"
	$"090E 0F11 1E28 0D15 1F22 1D15 1420 303B"
	$"4440 4134 3C38 2C24 1A18 130D 1222 1920"
	$"2C1D 161F 1546 3E12 177B 684F 4F37 6B56"
	$"3120 0E2B D0C3 BAD1 D1D2 D6DC FEE1 00E3"
	$"FBE4 05E3 E5E9 ECE5 E437 CFE8 F0EA E9E4"
	$"0202 0100 0103 070B 0B0F 1313 1417 1816"
	$"1C22 2224 2321 2324 2320 2426 231C 1C1A"
	$"1819 1B16 1413 1211 100F 0E14 171F 2619"
	$"120C FE06 3C0B 070B 1D27 0911 1E20 1A12"
	$"101B 2A32 3835 362A 3533 271E 1411 0C08"
	$"1020 161D 2A1B 141D 123B 320E 0E5E 503B"
	$"3C27 5443 2417 0E1A AA99 8DA2 A2A7 AEB0"
	$"B6BB FEBE 04BD BEBD BDBE 0DBF C0C4 C0B7"
	$"B39B B8CC CAC9 C602 01FD 0000 03FE 02FF"
	$"0408 0508 0704 0709 0A0B 0CFE 090B 0805"
	$"0909 0805 0604 0203 0405 FE04 FE03 2202"
	$"070C 1112 0603 0000 0205 0400 010A 1200"
	$"0809 0B08 0303 0911 171E 1717 0A16 150A"
	$"0500 FE01 2304 0B05 0D16 0803 0901 2619"
	$"0007 3A22 141C 022E 230A 0100 0A72 5F71"
	$"9496 979B 9B8F 796C 6511 6467 6360 6062"
	$"625F 615E 595C 4758 666B 6864 0193 720B"
	$"0702 0101 0508 0E10 1319 1C1C 1F22 1F23"
	$"2B2D 2827 272D 2F29 2C2F 2F28 1F21 1E1A"
	$"1A18 150F 0B0D 0E0C 0A0E 1115 1413 0C0B"
	$"0E15 0F07 110F 0B16 200F 0F1F 191D 160F"
	$"1739 4748 4435 3037 2D1D 1817 1512 0C13"
	$"2C20 2926 0C0B 1D1F 4F51 1F43 AF89 5757"
	$"394C 4A37 3020 339A 8B56 93CB D7D4 D4DB"
	$"DEE1 FCE4 07E5 E4E6 EFD8 B6A2 9479 778E"
	$"C9E7 F7F0 0704 0100 0104 060B 0D10 1518"
	$"181B 1F1D 2025 2726 2524 2728 2124 2827"
	$"221B 1E19 1516 1513 0B06 0809 0A0A 0E11"
	$"1513 1209 070A 110D 040E 0C06 101C 0B0B"
	$"1D17 1A13 0B11 323E 3C39 2925 2F27 1611"
	$"100D 0A06 1029 1E27 2408 061A 1C45 4519"
	$"2F84 683D 4229 3938 2724 1A1E 786D 3C70"
	$"9CA6 A8AC B3B8 BDC0 FEC1 02C0 C1C1 0BC2"
	$"C7A8 8171 694A 5D97 B7D3 CFFE 001C 0100"
	$"0102 0102 0204 0606 090A 0607 0B0E 0B0C"
	$"0B0C 0C07 0A0D 0906 0205 04FD 0100 03FE"
	$"0106 0201 0307 0705 05FE 0141 0504 0209"
	$"0600 050B 0203 0902 0805 0106 1C24 211C"
	$"0909 130D 0201 0100 0202 0616 0A0F 0E01"
	$"020A 082D 2804 1A52 3213 1E05 1317 0E0B"
	$"0208 4536 1C5C 878F 8D91 978E 8070 1167"
	$"6564 6363 6461 6655 3D35 3420 253A 4D66"
	$"5E01 9518 100A 0403 0609 0C13 1618 1D20"
	$"2022 2722 272E 2F29 282D 2F2C 29FE 2B58"
	$"231D 1F1E 1F1E 1C1C 0E02 0308 0D0F 0F12"
	$"1715 0F0B 1016 1717 110D 130E 0D0D 080C"
	$"1515 1A17 0F10 3156 4837 2D28 221E 1A1D"
	$"2019 100F 101E 202C 1F07 0E1F 2747 4B3E"
	$"5E90 7A58 4239 443D 373D 3B4B 694D 182F"
	$"6EAD D2D7 D7DB DDE2 E5FD E606 E7E5 D98E"
	$"4134 4007 311A 4A88 D9F6 0A06 FE01 1306"
	$"090E 1113 181B 1C1D 221E 2327 2A25 2428"
	$"2925 21FE 235D 1C18 1917 1919 1A19 0A00"
	$"0206 0B0D 0E11 1615 0E07 0A13 1616 0F0B"
	$"1009 0407 0408 1313 1614 0C09 294B 3D2E"
	$"241D 1A17 1416 1913 0908 0B1A 1D29 1C03"
	$"0B1B 223D 4031 4569 5B41 302A 362F 2A31"
	$"2E34 4B3C 1021 5183 A1AB AEB3 B8BC C0C4"
	$"C4C3 C4C1 0BB8 AA62 2523 3328 0926 56A3"
	$"C7FE 0044 0100 0202 0304 0405 0707 080B"
	$"0508 0C0E 0809 0D0C 0908 0A0A 0503 0003"
	$"0302 0204 0403 0000 0104 0505 070A 0602"
	$"0101 0505 0706 0206 0202 0301 0304 0205"
	$"0501 0119 3320 1007 06FE 0428 0708 0202"
	$"0302 0A09 1108 0005 0B0F 2928 1625 3928"
	$"150C 0710 0E0D 1412 1920 1703 153F 6B81"
	$"848A 908D 8211 746A 6463 6666 5E58 290C"
	$"0A17 0C02 0C14 404F 0195 7F14 0E06 060B"
	$"0E12 1517 1B1E 2224 2225 2827 2D2D 2929"
	$"2D2A 2320 201F 1C17 1F21 201E 140F 0C05"
	$"0309 1012 110D 0A10 1E15 0E19 2422 150D"
	$"0D15 1709 0403 0711 1520 1A12 141A 4541"
	$"3127 2E25 1E1A 232A 271A 1218 1414 2318"
	$"131B 2635 4944 5045 606A 5133 2C4A 4341"
	$"424C 5E67 3E08 0414 3D80 C0DA DEDC E0E3"
	$"E5E7 E9E9 ECD9 8539 0B05 1A7F 5F4D 4578"
	$"AED0 0B08 0100 0207 0C10 1216 191D 201E"
	$"2124 2328 2823 2428 251D 1A1A 1916 1219"
	$"1916 180F 0D0B 0302 070C 0E0D 0905 0C1A"
	$"120D 1621 2415 0D0C 1314 0500 0004 0F12"
	$"1917 0F0C 103A 3528 2025 1D18 151E 2521"
	$"120C 140E 0E1D 1211 1B22 2D3F 3841 3144"
	$"4E3F 281F 3933 3535 3A45 4C2F 0400 0F2C"
	$"5E94 A9AF B3B7 BCC0 C4C6 C7C7 0DAE 5E21"
	$"0101 0E46 352A 4C6D 8C03 02FD 0010 0105"
	$"0406 0608 0705 090B 090B 0B06 070B 07FE"
	$"0359 0201 0105 0404 0501 0201 0001 0302"
	$"0203 0101 060B 0501 040C 1105 0103 0607"
	$"0201 0002 0506 0705 0203 0824 1B0E 070D"
	$"0704 020B 0F0A 0403 0702 010C 0406 0D0E"
	$"1A2A 2125 1122 2918 0605 1D16 1515 1E26"
	$"2410 0000 071A 4373 8585 8486 117E 766B"
	$"6867 6654 2006 0000 0523 150B 1B25 2801"
	$"957F 140E 0808 0B0E 1112 1518 1E23 2527"
	$"2125 2626 2425 2222 201E 1E20 201A 0E18"
	$"1913 120A 0503 070F 1011 0D08 0302 0310"
	$"1812 202F 2C21 1410 1521 1808 0412 212A"
	$"2515 1619 121B 302E 3133 2C21 1D27 2925"
	$"1D16 2025 1214 131C 1D23 3B37 3247 475F"
	$"644A 2A23 4841 4547 4C64 7247 0A00 0009"
	$"214E 91CC DFDE E0E4 E4E6 E9EC E9C8 977E"
	$"7289 57D5 E3D5 D3DF E80C 0803 0103 070C"
	$"1013 171A 1D21 231D 2122 201E 1F1C 1C1A"
	$"1818 1A1B 160A 1414 0D0F 0704 050B 0F0D"
	$"0C0A 0601 0001 0D13 101C 2526 1F11 0C15"
	$"2118 0600 0F1F 251D 0F0F 110A 1125 2327"
	$"2A25 1C18 2226 1F12 101F 1FFE 0C24 1B1E"
	$"1E32 2E27 3834 4849 3621 1B39 343B 3B3A"
	$"4C56 3606 0001 071A 3B6C 9EB1 B4B6 BBBF"
	$"C2C6 C90D C4A5 7B64 5565 A7B9 AEAB BABE"
	$"0201 FD00 1001 0202 0306 0807 0904 0909"
	$"0705 0503 0402 FE00 0D02 0500 0303 0105"
	$"0303 020C 100C 05FE 0048 0200 0809 0209"
	$"1113 0B04 0307 0F09 0000 0B11 1309 0003"
	$"0401 0513 0E0F 120E 0805 0D0C 0703 040F"
	$"0F01 0402 0A0B 0B1D 160D 1D17 2C2C 1707"
	$"081F 181E 1F20 2B2B 1301 0000 010E 244E"
	$"7982 7EFF 7B0F 766F 6A67 6551 342B 1F2B"
	$"5C5C 4F52 5755 0193 1117 100A 080B 1015"
	$"171A 1C1E 1F20 211E 1A1E 1EFD 1B08 1D20"
	$"2223 231D 0A08 07FE 0649 0410 1D16 1009"
	$"0302 0100 0001 2038 3D3E 3224 1610 1A1D"
	$"160E 1125 2F3C 3A16 1C29 170E 2339 3B37"
	$"2827 232B 2E22 1C17 1C24 130B 1220 1F1B"
	$"2E38 3C4E 504D 4F35 2426 4538 3C51 4D5E"
	$"714E 0C00 FE02 1009 2964 A0D4 E1E2 E2E3"
	$"E5E9 ECF0 F2EF EDEF 17ED EFF2 F2F1 F00F"
	$"0A06 0304 090F 1115 1719 1A1B 1D1A 161A"
	$"18FD 1514 171B 1D1D 1E1C 0805 0302 0707"
	$"0616 271C 1309 0302 01FE 003C 1729 2A2D"
	$"291F 100A 161A 130B 0F24 2E36 300F 1220"
	$"1108 182D 2E2D 2121 1F27 2A1E 1611 171E"
	$"0D04 0B1F 1F17 262E 2F3F 3E39 3C28 1B1A"
	$"372C 3445 3B46 553A 08FE 000B 0108 1D47"
	$"7AA6 B3B6 BABE C1C4 10C8 CFD1 CDC9 CCCF"
	$"D1D3 D2D1 D202 0100 0001 FE02 FF03 FF05"
	$"0504 0502 0003 02FD 0001 0102 FE01 0205"
	$"0100 FE02 5201 0012 3026 180A 0202 0100"
	$"0201 1119 1212 0E06 0103 0906 0300 0515"
	$"1820 1B03 080E 0401 0E1E 1915 0A0E 0A10"
	$"1004 0303 070D 0200 040C 0806 1014 1420"
	$"1D1B 1C06 0307 1D12 182A 2224 2614 0200"
	$"0100 0002 0E2D 5576 117B 7573 716E 6C6B"
	$"6F6C 6A6B 6968 6A6C 6C6B 6E01 900B 1614"
	$"110A 0A0F 1317 1B1D 1B16 FE15 FF19 6E1A"
	$"1B1C 1F20 2225 2728 2923 0600 0201 0410"
	$"0910 1E19 0C05 0603 0001 000B 3C57 5652"
	$"4F41 2C18 1A16 0A0E 2030 3138 4D2A 172E"
	$"1F0F 1433 423E 2F29 272E 352F 2213 1318"
	$"0C15 232B 2316 1930 4271 7038 3334 2820"
	$"403B 3859 595C 5F43 0E00 0201 0100 0416"
	$"3774 B4E0 E6E0 E0E5 E7E9 EBEF F1F0 18EE"
	$"ECED EFF0 EF0E 0B07 0305 0A0E 1317 1816"
	$"110F 1112 1312 1516 FE18 061B 1D1E 1E1F"
	$"1F07 FE00 4A06 110C 172C 2210 0503 0101"
	$"0000 0528 3736 3332 2A1D 1117 150A 0F21"
	$"2E2C 2F43 2612 291A 080C 2A39 3327 2322"
	$"2B32 2B1C 0E0E 1107 131D 241F 1212 272F"
	$"565A 2925 261F 1836 312F 4C46 4446 3108"
	$"FC00 0902 0F27 548A ADB4 B9BC C019 C4C7"
	$"CBCD CFCF CECD CCCF CFCE 0202 0100 0001"
	$"0201 0202 0100 0102 FE01 5902 0100 0102"
	$"0102 0303 0407 0201 0000 0104 0017 362F"
	$"1803 0001 0102 0103 1F29 1D14 140D 0605"
	$"0904 0005 0F1B 1717 2913 0710 0801 041D"
	$"241C 110E 0C13 1B11 0302 0507 0007 0D0E"
	$"0802 0416 1635 3108 0805 0304 1715 152E"
	$"2823 1D11 01FB 0002 0616 3605 6073 7371"
	$"6E6C FE6A 056C 6E6E 6C6B 6CFE 6D01 8929"
	$"1415 110F 0F14 171A 1A1C 1917 1718 191C"
	$"1F1E 1F20 2325 2527 2A2A 2C2C 0A00 0200"
	$"032A 350F 050A 0506 0803 FE00 3D1D 5059"
	$"5654 5048 3B2B 2116 0D18 2D35 3130 4935"
	$"191C 2118 0D1F 4B45 2D28 2939 3E39 250A"
	$"0715 253C 412E 1E19 1D19 4580 5B38 3239"
	$"291A 3541 3A58 504D 583F 0DFC 01FF 0005"
	$"091F 488A CAE4 FDE5 03E7 EAEE EF02 EFEE"
	$"EEFE EFFF 0C1A 0806 080D 1011 1213 1311"
	$"1113 1515 1718 1A1B 1C1D 1E20 2121 2326"
	$"0AFE 0008 0326 3211 0C0F 0606 05FD 003D"
	$"1738 3736 3532 302A 201C 140D 192A 3129"
	$"233B 2D14 181C 1205 1742 3925 2220 2F34"
	$"2F1C 080A 1320 3439 281A 1516 1031 6747"
	$"2B25 2B21 132F 382F 4A40 3740 2E06 FD00"
	$"0A01 0200 0517 3467 9AB3 B8BA 04BD C1C5"
	$"C8CC FDCD 0BCE CFCF 0103 0100 0001 0204"
	$"03FE 021A 0102 0302 0203 0201 0305 0203"
	$"0404 050B 0201 0100 0016 1804 0D13 06FD"
	$"013E 0200 142C 261E 1615 100C 0C09 0200"
	$"091A 1E15 091F 1703 0309 0800 0B28 2610"
	$"0A08 151A 1407 0003 0811 2021 0D00 0306"
	$"0016 4120 0806 0A03 0013 1B14 2C22 1616"
	$"0EF9 0001 040C 0A1A 3E67 756C 6769 6766"
	$"676B FD6C 026D 6C6C 0189 6A13 1511 1012"
	$"1517 1414 1517 1819 1C1E 2125 2223 2424"
	$"2628 292C 2D2E 310D 0002 0003 3151 3002"
	$"0001 0200 0629 3D10 2358 5A55 534E 453B"
	$"2F21 1211 1C29 2E29 2C34 241D 2226 261B"
	$"1637 4228 1819 1E22 1D15 131F 2E36 433F"
	$"281C 161C 2C5D 7043 243C 3E29 182B 3C45"
	$"523C 4360 4810 FD01 FF02 FF00 0C01 112E"
	$"5A9A D2E5 E4E3 E3E5 E8EB 22ED EEEE EFF0"
	$"EE0B 0C07 0709 0C0E 0C0D 0E11 1314 1616"
	$"181A 1A1B 1D1D 1F22 2223 2425 290B FD00"
	$"4926 462C 0200 0101 0001 1321 0513 3938"
	$"3634 312D 2820 1A0C 0D1A 2427 2221 271D"
	$"191D 2120 150E 2D37 1F12 0E12 1613 0E0C"
	$"1829 313C 3822 1813 1624 4A58 2F18 2F2F"
	$"2011 2634 3745 2D2F 4A36 0AF9 0006 030C"
	$"2041 73A1 B618 B9BB BFC3 C6C9 CCCD CDCE"
	$"D0CF 0002 0102 0201 0304 0301 0302 01FC"
	$"03FE 02FF 0406 0203 0403 0A02 01FE 0002"
	$"1827 14FE 0043 0100 000C 1402 1533 281E"
	$"1513 0C07 0507 0102 0A14 150E 0C11 0D04"
	$"080D 0E05 0116 1C0A 0100 0408 0503 0309"
	$"1018 2523 0A01 0103 102C 3614 0111 0E03"
	$"000D 171A 240F 0D1F 1703 FB00 FF01 0000"
	$"0C03 0E27 4B66 6C6A 6765 6265 686B FE6C"
	$"016D 6C01 8452 130F 0A0C 0C0E 0D0C 1012"
	$"1719 1B1D 2022 2522 2327 2627 2A2C 2E31"
	$"3539 1201 0000 0232 5753 3310 0100 0D33"
	$"5481 6542 5157 5751 4C45 3B2D 1D0E 1319"
	$"1D1C 1914 1D18 1F27 272B 2314 1022 2818"
	$"1B23 2F3C 4A59 675A 39FE 3615 2916 193E"
	$"4038 3B26 3C41 2A18 2039 4439 293E 646A"
	$"1C00 FE01 FF02 FD01 0A07 1837 66A8 D9E6"
	$"E2E2 E1E5 22E9 EAEC EDEF EE0D 0A06 0604"
	$"0607 060A 0C12 1416 1718 191C 1E1D 1F20"
	$"2224 2526 282A 2E0F FD00 1F22 4344 2C0C"
	$"0000 0A22 2438 3322 3737 3633 2F2B 261C"
	$"1305 0C16 1A18 1611 1812 19FE 2426 1C0C"
	$"071F 220E 0F14 1B23 2C36 403F 322F 2A2F"
	$"220F 1336 3529 2D1C 2E32 2111 1A31 372B"
	$"2130 4851 16F7 0004 030F 2548 7E08 A9B7"
	$"BABB C0C2 C5C9 CDFE CEFE 0100 03FE 0216"
	$"0002 0103 0403 0202 0102 0302 0301 0204"
	$"0506 0708 1003 02FE 0049 1928 2217 0400"
	$"0003 130F 180C 0C29 281F 1510 0C06 0405"
	$"0105 0A0D 0A07 0106 0506 0E0F 0D08 0301"
	$"070B 0103 0609 0C10 161D 1B10 1618 1A0E"
	$"0002 1D17 0D11 0213 1102 0007 141C 1002"
	$"1125 2B03 F800 1100 020A 1429 4C67 6B62"
	$"615E 6065 6869 6A6C 6B01 836B 120C 0404"
	$"0506 0A0E 1115 191C 1D20 2122 2425 2B31"
	$"3436 3B40 4449 504F 1B00 050D 1130 575B"
	$"5B50 3732 4B63 576B 8C77 5D55 524C 453C"
	$"3320 0809 141E 251E 1B1D 2323 2C28 1F1E"
	$"232E 303E 5055 5B63 6F75 7A7F 8687 7356"
	$"3935 2716 1C23 1C1E 3B35 3537 2922 1330"
	$"3221 283E 5187 2D01 FB00 0001 FE03 0906"
	$"0C23 487F BCDE E7E2 E370 E5E6 E7EA EDEE"
	$"0B07 0302 0002 0507 0A0F 1316 181A 1C1D"
	$"1F21 2529 2B2E 3236 383C 4143 1700 050F"
	$"0D23 4548 4B42 2E2B 3D4B 2E24 3A3E 3735"
	$"3431 2E28 2212 0305 1018 1C17 1415 1A16"
	$"2024 1A16 171E 1F27 3435 3A3E 4346 4A4B"
	$"4E53 4B3E 2D2E 2212 131B 1514 312A 2728"
	$"201A 0E2C 2C17 2030 3069 23F5 0002 0519"
	$"3276 5A8E AEB5 B9BB BCC1 C5CA CBCC 0100"
	$"0001 0000 0101 0301 0103 0202 0100 0105"
	$"080A 0A0C 1116 191B 1E23 0701 0209 0614"
	$"2925 2B25 1916 1E2B 0E01 0914 1F21 1C14"
	$"0F0B 0500 0002 0608 0D08 0606 0808 0507"
	$"0706 050A 0B0F 1716 1B1D 1C1C 2021 2325"
	$"241F 1112 0B01 0206 0202 140F 0F09 0308"
	$"0112 0E01 0814 163C 05F8 0011 0001 0001"
	$"0B19 3457 6768 6160 6262 6367 696A 017B"
	$"6B0E 0904 0102 0508 0D0E 1923 272A 2F33"
	$"3739 4046 4C51 5354 5558 5B5E 5D26 0519"
	$"2928 243C 4D55 5758 6064 6668 6E82 7D69"
	$"5F5C 5750 4E4A 4541 5062 6D6F 7072 7575"
	$"746E 5022 1850 7E84 8587 8A8A 8E94 9391"
	$"979C A0A4 966F 4927 1719 110D 1E3D 3229"
	$"302D 3915 1D23 1C32 4B54 AD47 02F8 00FF"
	$"01FF 0306 112D 528C C7E4 E543 E3E4 E6E6"
	$"E8EB 0704 0100 0004 0606 0714 1C20 2329"
	$"2D31 3438 3C3F 4245 4647 4949 4A4F 2101"
	$"1828 2320 3243 4345 4C51 4E4E 4534 373F"
	$"3F3A 3734 3131 2E29 272F 3B41 3F41 4345"
	$"FE46 2935 0E02 2C4A 4C4B 4E4F 4F52 5352"
	$"5556 5759 595B 4F36 1D12 140F 0E18 3227"
	$"2029 2534 151B 2015 273A 388B 34F4 0001"
	$"020E 0B21 3A64 98B3 B7B7 BABE C0C5 C7FD"
	$"00FC 01FF 0539 0708 0C10 1313 1A1D 1F21"
	$"2425 2629 2727 2A0B 000D 170E 091A 2626"
	$"272B 2F2B 2C25 130F 1015 1A19 1412 120C"
	$"0F12 191B 1A1A 1B1E 2021 201F 1401 0016"
	$"FE25 0523 2021 2423 21FE 2319 222A 2C21"
	$"1004 0204 0100 0717 0D07 0A08 1804 0907"
	$"0212 1D17 5710 F800 FF00 0F01 0000 0712"
	$"1C3D 5C66 5E5E 6061 6063 6601 7A38 0A06"
	$"0503 0203 0508 0C28 3B3D 4045 4A4A 4E4E"
	$"5054 5758 595A 5D5F 6061 2F07 1A2E 2B29"
	$"3336 393C 393E 4345 4F65 7880 7E7B 7E7C"
	$"7E82 807E 7882 8FFE 952F 9799 978E 7960"
	$"4A4E 7B9B 9E99 9898 9A9E 9F9F A0A5 ABAC"
	$"B0B6 B7A9 947B 675D 4D3E 483E 2922 344B"
	$"2B16 231F 2D4B 64C1 6704 F600 0803 0504"
	$"0A18 365D 9CD3 07E5 E6E4 E1E2 E505 02FE"
	$"011E 0203 0205 2232 3437 3A3C 3D40 4142"
	$"4546 4647 474A 4B4B 5128 0318 2A26 252C"
	$"32FE 3143 3234 3537 3B3C 4245 4344 4445"
	$"4A48 4645 474B 4E4F 5051 5355 524F 493E"
	$"3C51 5957 5555 5657 595B 5B5D 5D60 6165"
	$"6669 6658 4840 3D33 2836 2F1D 192C 4327"
	$"101A 1923 3847 9D4D F600 FD01 1507 1528"
	$"4373 9FB1 B4B7 B9BC BE02 0001 0201 0100"
	$"0002 10FE 1905 1D21 1F20 2323 FE24 3025"
	$"262A 2926 2B0E 000E 190F 111B 1D18 1D1B"
	$"1A1E 1F1F 2020 1B1F 1F20 2123 241E 1E1F"
	$"2527 2221 2223 2526 2424 2323 252C 2B29"
	$"FE23 0026 FE2A 1C29 2A2B 282A 2A2B 2B27"
	$"1D17 160D 0915 0E01 0214 230B 010A 040A"
	$"151F 6623 F800 FD00 FF01 0B02 0817 2846"
	$"5F62 5C5C 5B5C 5F01 7925 0204 0707 0607"
	$"0604 0929 4142 4649 4D4F 5453 5456 5A5D"
	$"5E60 6063 615B 330B 1B2C 2F30 3133 3538"
	$"FE37 423B 4042 4D62 6D77 8691 9696 928B"
	$"8287 97A1 A1A3 A4A5 9D87 7864 5A67 99A8"
	$"A49F 9E9F A2A6 A3A2 A7A9 AEB2 B6B8 BABE"
	$"C4C2 BDBB B1A3 8A6B 4D25 101F 2220 201C"
	$"253D 4C87 6107 F500 0702 0305 060F 1F3D"
	$"6B0A A5D7 E8E4 E3E3 0202 0302 02FD 031C"
	$"2136 363A 3C3D 3E41 4344 4647 484A 4C4B"
	$"5050 4E2C 0918 262A 2A29 2C2E 2FFE 2D22"
	$"2F31 3232 383C 3F46 4849 4B4C 4844 474A"
	$"5154 5556 5957 5056 5450 526E 645A 5858"
	$"595A 5DFE 5E1C 5F61 6466 6667 6B6E 6C6A"
	$"6E68 5D4D 3C29 1208 1619 1617 141A 2B33"
	$"6A4B 03F5 00FF 020C 0102 0817 2C48 77A1"
	$"B1B1 B4B6 01FD 0045 0201 0100 101E 1B1D"
	$"2022 2122 2425 2726 2527 2928 2B2A 2D13"
	$"000E 1314 1717 191B 1814 1415 1718 1816"
	$"1C1D 1D22 211E 1F20 1F1E 2325 2323 2425"
	$"2826 262E 3335 3649 3626 2525 2727 FE2A"
	$"FF2C 1B2B 2C2D 2B2B 2E2F 2D2F 312A 261C"
	$"0E05 0204 0A05 0606 0206 1014 4027 01F9"
	$"00FD 000D 0201 0000 040A 1626 435C 5F58"
	$"5558 0174 6B01 0407 0807 0908 0609 2741"
	$"4347 494E 5256 5658 5B5D 5F60 6163 5B46"
	$"2E1A 131C 282D 2D2E 3031 302E 3032 363D"
	$"3F39 3C3D 4C6A 8895 948F 877A 83A1 B1AD"
	$"AAAB AA9C 8176 584C 5082 ACA1 9F9F A2A1"
	$"A2A4 A3A4 A6A9 ACB0 B3B4 B5B8 B9BF C1C0"
	$"B399 7D5C 2704 0012 201F 110C 0C0F 181E"
	$"08F4 0006 0103 0608 0C11 260A 4776 B7DF"
	$"E4E1 0202 0303 04FE 0517 041F 3738 3C3E"
	$"4041 4445 4649 494B 4C4D 4F4B 3B28 1714"
	$"1B22 FE28 4829 2B29 2829 2A2D 3132 332F"
	$"2F33 3E49 4A49 4B49 4245 535D 5C59 5A5D"
	$"594F 5A50 4843 5F6E 5B57 585A 5A5C 5D5C"
	$"5E5E 5F60 6263 6566 6664 6565 645C 4F3F"
	$"3011 0000 0917 1807 0205 0910 1504 F400"
	$"0001 0C02 0304 0309 1B31 5486 A3AC AE01"
	$"FD00 FF01 FF00 0C11 1E1B 1D1E 2222 2324"
	$"2628 2728 FD29 4A1D 1005 060E 1012 1414"
	$"1518 110E 0F12 1416 1719 1614 161E 201D"
	$"1D20 201D 2029 2B28 2427 2C27 2333 3232"
	$"2F43 4123 2728 2A29 2A2B 2A2B 2929 2A2B"
	$"2A2B 2B29 272A 2822 201A 150A 0001 0002"
	$"0907 FE00 0302 0709 02F9 00F9 00FF 0107"
	$"060F 1B32 4D5D 5A53 016D 6603 050A 0B09"
	$"0A0A 080A 2342 4346 4B51 5456 5A59 5A5B"
	$"595A 584F 361C 1615 191E 282D 2D2B 2726"
	$"282C 3030 3238 3A3D 4040 4151 6A80 8B8E"
	$"9083 8097 B0B3 AFAC A799 7C74 5B53 4E71"
	$"9B9B 9695 9799 9DA2 A19E A1A5 A8AB AEB0"
	$"AFB2 B2B3 B0A9 9582 765D 3010 0D14 1510"
	$"0702 FD00 0002 F200 0402 080C 0303 3016"
	$"2A4B 83BE D903 0305 0706 0708 0804 1938"
	$"383C 4043 4544 4645 4647 4545 4643 2F1B"
	$"1616 1C1D 2128 2928 2423 2326 2A2A 2C2E"
	$"FE30 3734 363B 4148 4B4D 4D45 414E 5D5F"
	$"5A58 5958 4F5A 534E 4757 6259 5554 5656"
	$"5759 595A 5B5E 5E5F 6062 6162 6060 5D56"
	$"4C42 3B31 1A07 060E 1009 02ED 000F 0001"
	$"0405 0200 0E20 365C 8BA6 0201 0202 FD01"
	$"0C00 0F1E 191A 1E22 2221 2323 2424 FE22"
	$"5321 1609 0707 0E10 0F12 1514 0F0F 0B0C"
	$"1011 1212 1413 1519 1C20 2023 221F 1D1A"
	$"1925 2B27 2323 2925 2232 3336 303A 3827"
	$"2525 2826 272A 2A26 2527 2A29 292A 2827"
	$"2427 2520 1A14 1409 0002 0105 0503 0100"
	$"0303 0103 01F9 00FC 00FF 0101 0001 FE00"
	$"0508 1219 3351 5400 00FF"
};

resource 'PICT' (133) {
	6290,
	{0, 0, 201, 243},
	$"0011 02FF 0C00 FFFE 0000 0048 0042 0048"
	$"0042 0000 0000 00C9 00F3 0000 0000 00A1"
	$"01F2 0016 3842 494D 0000 0000 0000 00C9"
	$"00F3 4772 8970 68AF 626A 0001 000A 0000"
	$"0000 00C9 00F3 0098 80F4 0000 0000 00C9"
	$"00F3 0000 0000 0000 0000 0048 0042 0048"
	$"0042 0000 0008 0001 0008 0000 0000 0000"
	$"0000 0000 0000 0000 0028 0000 00FF 0000"
	$"FFFF FFFF FFFF 0001 FEFE FEFE FEFE 0002"
	$"FDFD FDFD FDFD 0003 FCFC FCFC FCFC 0004"
	$"FBFB FBFB FBFB 0005 FAFA FAFA FAFA 0006"
	$"F9F9 F9F9 F9F9 0007 F8F8 F8F8 F8F8 0008"
	$"F7F7 F7F7 F7F7 0009 F6F6 F6F6 F6F6 000A"
	$"F5F5 F5F5 F5F5 000B F4F4 F4F4 F4F4 000C"
	$"F3F3 F3F3 F3F3 000D F2F2 F2F2 F2F2 000E"
	$"F1F1 F1F1 F1F1 000F F0F0 F0F0 F0F0 0010"
	$"EFEF EFEF EFEF 0011 EEEE EEEE EEEE 0012"
	$"EDED EDED EDED 0013 ECEC ECEC ECEC 0014"
	$"EBEB EBEB EBEB 0015 EAEA EAEA EAEA 0016"
	$"E9E9 E9E9 E9E9 0017 E8E8 E8E8 E8E8 0018"
	$"E7E7 E7E7 E7E7 0019 E6E6 E6E6 E6E6 001A"
	$"E5E5 E5E5 E5E5 001B E4E4 E4E4 E4E4 001C"
	$"E3E3 E3E3 E3E3 001D E2E2 E2E2 E2E2 001E"
	$"E1E1 E1E1 E1E1 001F E0E0 E0E0 E0E0 0020"
	$"DFDF DFDF DFDF 0021 DEDE DEDE DEDE 0022"
	$"DDDD DDDD DDDD 0023 DCDC DCDC DCDC 0024"
	$"DBDB DBDB DBDB 0025 DADA DADA DADA 0026"
	$"D9D9 D9D9 D9D9 0027 D8D8 D8D8 D8D8 0028"
	$"D7D7 D7D7 D7D7 0029 D6D6 D6D6 D6D6 002A"
	$"D5D5 D5D5 D5D5 002B D4D4 D4D4 D4D4 002C"
	$"D3D3 D3D3 D3D3 002D D2D2 D2D2 D2D2 002E"
	$"D1D1 D1D1 D1D1 002F D0D0 D0D0 D0D0 0030"
	$"CFCF CFCF CFCF 0031 CECE CECE CECE 0032"
	$"CDCD CDCD CDCD 0033 CCCC CCCC CCCC 0034"
	$"CBCB CBCB CBCB 0035 CACA CACA CACA 0036"
	$"C9C9 C9C9 C9C9 0037 C8C8 C8C8 C8C8 0038"
	$"C7C7 C7C7 C7C7 0039 C6C6 C6C6 C6C6 003A"
	$"C5C5 C5C5 C5C5 003B C4C4 C4C4 C4C4 003C"
	$"C3C3 C3C3 C3C3 003D C2C2 C2C2 C2C2 003E"
	$"C1C1 C1C1 C1C1 003F C0C0 C0C0 C0C0 0040"
	$"BFBF BFBF BFBF 0041 BEBE BEBE BEBE 0042"
	$"BDBD BDBD BDBD 0043 BCBC BCBC BCBC 0044"
	$"BBBB BBBB BBBB 0045 BABA BABA BABA 0046"
	$"B9B9 B9B9 B9B9 0047 B8B8 B8B8 B8B8 0048"
	$"B7B7 B7B7 B7B7 0049 B6B6 B6B6 B6B6 004A"
	$"B5B5 B5B5 B5B5 004B B4B4 B4B4 B4B4 004C"
	$"B3B3 B3B3 B3B3 004D B2B2 B2B2 B2B2 004E"
	$"B1B1 B1B1 B1B1 004F B0B0 B0B0 B0B0 0050"
	$"AFAF AFAF AFAF 0051 AEAE AEAE AEAE 0052"
	$"ADAD ADAD ADAD 0053 ACAC ACAC ACAC 0054"
	$"ABAB ABAB ABAB 0055 AAAA AAAA AAAA 0056"
	$"A9A9 A9A9 A9A9 0057 A8A8 A8A8 A8A8 0058"
	$"A7A7 A7A7 A7A7 0059 A6A6 A6A6 A6A6 005A"
	$"A5A5 A5A5 A5A5 005B A4A4 A4A4 A4A4 005C"
	$"A3A3 A3A3 A3A3 005D A2A2 A2A2 A2A2 005E"
	$"A1A1 A1A1 A1A1 005F A0A0 A0A0 A0A0 0060"
	$"9F9F 9F9F 9F9F 0061 9E9E 9E9E 9E9E 0062"
	$"9D9D 9D9D 9D9D 0063 9C9C 9C9C 9C9C 0064"
	$"9B9B 9B9B 9B9B 0065 9A9A 9A9A 9A9A 0066"
	$"9999 9999 9999 0067 9898 9898 9898 0068"
	$"9797 9797 9797 0069 9696 9696 9696 006A"
	$"9595 9595 9595 006B 9494 9494 9494 006C"
	$"9393 9393 9393 006D 9292 9292 9292 006E"
	$"9191 9191 9191 006F 9090 9090 9090 0070"
	$"8F8F 8F8F 8F8F 0071 8E8E 8E8E 8E8E 0072"
	$"8D8D 8D8D 8D8D 0073 8C8C 8C8C 8C8C 0074"
	$"8B8B 8B8B 8B8B 0075 8A8A 8A8A 8A8A 0076"
	$"8989 8989 8989 0077 8888 8888 8888 0078"
	$"8787 8787 8787 0079 8686 8686 8686 007A"
	$"8585 8585 8585 007B 8484 8484 8484 007C"
	$"8383 8383 8383 007D 8282 8282 8282 007E"
	$"8181 8181 8181 007F 8080 8080 8080 0080"
	$"7F7F 7F7F 7F7F 0081 7E7E 7E7E 7E7E 0082"
	$"7D7D 7D7D 7D7D 0083 7C7C 7C7C 7C7C 0084"
	$"7B7B 7B7B 7B7B 0085 7A7A 7A7A 7A7A 0086"
	$"7979 7979 7979 0087 7878 7878 7878 0088"
	$"7777 7777 7777 0089 7676 7676 7676 008A"
	$"7575 7575 7575 008B 7474 7474 7474 008C"
	$"7373 7373 7373 008D 7272 7272 7272 008E"
	$"7171 7171 7171 008F 7070 7070 7070 0090"
	$"6F6F 6F6F 6F6F 0091 6E6E 6E6E 6E6E 0092"
	$"6D6D 6D6D 6D6D 0093 6C6C 6C6C 6C6C 0094"
	$"6B6B 6B6B 6B6B 0095 6A6A 6A6A 6A6A 0096"
	$"6969 6969 6969 0097 6868 6868 6868 0098"
	$"6767 6767 6767 0099 6666 6666 6666 009A"
	$"6565 6565 6565 009B 6464 6464 6464 009C"
	$"6363 6363 6363 009D 6262 6262 6262 009E"
	$"6161 6161 6161 009F 6060 6060 6060 00A0"
	$"5F5F 5F5F 5F5F 00A1 5E5E 5E5E 5E5E 00A2"
	$"5D5D 5D5D 5D5D 00A3 5C5C 5C5C 5C5C 00A4"
	$"5B5B 5B5B 5B5B 00A5 5A5A 5A5A 5A5A 00A6"
	$"5959 5959 5959 00A7 5858 5858 5858 00A8"
	$"5757 5757 5757 00A9 5656 5656 5656 00AA"
	$"5555 5555 5555 00AB 5454 5454 5454 00AC"
	$"5353 5353 5353 00AD 5252 5252 5252 00AE"
	$"5151 5151 5151 00AF 5050 5050 5050 00B0"
	$"4F4F 4F4F 4F4F 00B1 4E4E 4E4E 4E4E 00B2"
	$"4D4D 4D4D 4D4D 00B3 4C4C 4C4C 4C4C 00B4"
	$"4B4B 4B4B 4B4B 00B5 4A4A 4A4A 4A4A 00B6"
	$"4949 4949 4949 00B7 4848 4848 4848 00B8"
	$"4747 4747 4747 00B9 4646 4646 4646 00BA"
	$"4545 4545 4545 00BB 4444 4444 4444 00BC"
	$"4343 4343 4343 00BD 4242 4242 4242 00BE"
	$"4141 4141 4141 00BF 4040 4040 4040 00C0"
	$"3F3F 3F3F 3F3F 00C1 3E3E 3E3E 3E3E 00C2"
	$"3D3D 3D3D 3D3D 00C3 3C3C 3C3C 3C3C 00C4"
	$"3B3B 3B3B 3B3B 00C5 3A3A 3A3A 3A3A 00C6"
	$"3939 3939 3939 00C7 3838 3838 3838 00C8"
	$"3737 3737 3737 00C9 3636 3636 3636 00CA"
	$"3535 3535 3535 00CB 3434 3434 3434 00CC"
	$"3333 3333 3333 00CD 3232 3232 3232 00CE"
	$"3131 3131 3131 00CF 3030 3030 3030 00D0"
	$"2F2F 2F2F 2F2F 00D1 2E2E 2E2E 2E2E 00D2"
	$"2D2D 2D2D 2D2D 00D3 2C2C 2C2C 2C2C 00D4"
	$"2B2B 2B2B 2B2B 00D5 2A2A 2A2A 2A2A 00D6"
	$"2929 2929 2929 00D7 2828 2828 2828 00D8"
	$"2727 2727 2727 00D9 2626 2626 2626 00DA"
	$"2525 2525 2525 00DB 2424 2424 2424 00DC"
	$"2323 2323 2323 00DD 2222 2222 2222 00DE"
	$"2121 2121 2121 00DF 2020 2020 2020 00E0"
	$"1F1F 1F1F 1F1F 00E1 1E1E 1E1E 1E1E 00E2"
	$"1D1D 1D1D 1D1D 00E3 1C1C 1C1C 1C1C 00E4"
	$"1B1B 1B1B 1B1B 00E5 1A1A 1A1A 1A1A 00E6"
	$"1919 1919 1919 00E7 1818 1818 1818 00E8"
	$"1717 1717 1717 00E9 1616 1616 1616 00EA"
	$"1515 1515 1515 00EB 1414 1414 1414 00EC"
	$"1313 1313 1313 00ED 1212 1212 1212 00EE"
	$"1111 1111 1111 00EF 1010 1010 1010 00F0"
	$"0F0F 0F0F 0F0F 00F1 0E0E 0E0E 0E0E 00F2"
	$"0D0D 0D0D 0D0D 00F3 0C0C 0C0C 0C0C 00F4"
	$"0B0B 0B0B 0B0B 00F5 0A0A 0A0A 0A0A 00F6"
	$"0909 0909 0909 00F7 0808 0808 0808 00F8"
	$"0707 0707 0707 00F9 0606 0606 0606 00FA"
	$"0505 0505 0505 00FB 0404 0404 0404 00FC"
	$"0303 0303 0303 00FD 0202 0202 0202 00FE"
	$"0101 0101 0101 00FF 0000 0000 0000 0000"
	$"0000 00C9 00F3 0000 0000 00C9 00F3 0000"
	$"0481 008D 0004 8100 8D00 0481 008D 0004"
	$"8100 8D00 0481 008D 0004 8100 8D00 0481"
	$"008D 0004 8100 8D00 0481 008D 0004 8100"
	$"8D00 0481 008D 0004 8100 8D00 0481 008D"
	$"0004 8100 8D00 0481 008D 0004 8100 8D00"
	$"0481 008D 0004 8100 8D00 0481 008D 0004"
	$"8100 8D00 0481 008D 0004 8100 8D00 0481"
	$"008D 0004 8100 8D00 0481 008D 0004 8100"
	$"8D00 0481 008D 0004 8100 8D00 0481 008D"
	$"0004 8100 8D00 0481 008D 0006 81FF B5FF"
	$"D900 0681 FFB5 FFD9 0006 81FF B5FF D900"
	$"0681 FFB5 FFD9 000A 8100 BD00 FD33 FDFF"
	$"D900 0A81 00BD 00FD 33FD FFD9 000A 8100"
	$"BD00 FD33 FDFF D900 0A81 00BD 00FD 33FD"
	$"FFD9 000A 8133 BD33 FD66 F9FF DD00 0A81"
	$"33BD 33FD 66F9 FFDD 000A 8133 BD33 FD66"
	$"F9FF DD00 0A81 33BD 33FD 66F9 FFDD 000A"
	$"8133 BD33 FD66 F9FF DD00 0A81 33BD 33FD"
	$"66F9 FFDD 000A 8133 BD33 FD66 F9FF DD00"
	$"0A81 33BD 33FD 66F9 FFDD 0014 CD00 ED33"
	$"D177 F933 F933 D177 F533 FD66 F9FF DD00"
	$"14CD 00ED 33D1 77F9 33F9 33D1 77F5 33FD"
	$"66F9 FFDD 0014 CD00 ED33 D177 F933 F933"
	$"D177 F533 FD66 F9FF DD00 14CD 00ED 33D1"
	$"77F9 33F9 33D1 77F5 33FD 66F9 FFDD 001C"
	$"C988 F133 FD77 D5DD FD00 FD33 F933 FD77"
	$"D5DD FD00 F933 FD66 F9FF DD00 1CC9 88F1"
	$"33FD 77D5 DDFD 00FD 33F9 33FD 77D5 DDFD"
	$"00F9 33FD 66F9 FFDD 001C C988 F133 FD77"
	$"D5DD FD00 FD33 F933 FD77 D5DD FD00 F933"
	$"FD66 F9FF DD00 1CC9 88F1 33FD 77D5 DDFD"
	$"00FD 33F9 33FD 77D5 DDFD 00F9 33FD 66F9"
	$"FFDD 0028 CD00 ED33 FD77 FDDD FD00 E133"
	$"FDDD FD00 FD33 F933 FD77 FDDD FD00 E133"
	$"FDDD FD00 F933 FD66 F9FF DD00 28CD 00ED"
	$"33FD 77FD DDFD 00E1 33FD DDFD 00FD 33F9"
	$"33FD 77FD DDFD 00E1 33FD DDFD 00F9 33FD"
	$"66F9 FFDD 0028 CD00 ED33 FD77 FDDD FD00"
	$"E133 FDDD FD00 FD33 F933 FD77 FDDD FD00"
	$"E133 FDDD FD00 F933 FD66 F9FF DD00 28CD"
	$"00ED 33FD 77FD DDFD 00E1 33FD DDFD 00FD"
	$"33F9 33FD 77FD DDFD 00E1 33FD DDFD 00F9"
	$"33FD 66F9 FFDD 0038 C988 F133 FD77 FDDD"
	$"FD33 F966 F955 F944 FD33 FD77 FDDD FD00"
	$"FD33 F933 FD77 FDDD FD33 F966 F955 F944"
	$"FD33 FD77 FDDD FD00 F933 FD66 F9FF DD00"
	$"38C9 88F1 33FD 77FD DDFD 33F9 66F9 55F9"
	$"44FD 33FD 77FD DDFD 00FD 33F9 33FD 77FD"
	$"DDFD 33F9 66F9 55F9 44FD 33FD 77FD DDFD"
	$"00F9 33FD 66F9 FFDD 0038 C988 F133 FD77"
	$"FDDD FD33 F966 F955 F944 FD33 FD77 FDDD"
	$"FD00 FD33 F933 FD77 FDDD FD33 F966 F955"
	$"F944 FD33 FD77 FDDD FD00 F933 FD66 F9FF"
	$"DD00 38C9 88F1 33FD 77FD DDFD 33F9 66F9"
	$"55F9 44FD 33FD 77FD DDFD 00FD 33F9 33FD"
	$"77FD DDFD 33F9 66F9 55F9 44FD 33FD 77FD"
	$"DDFD 00F9 33FD 66F9 FFDD 0038 CD00 ED33"
	$"FD77 FDDD FD33 FD66 F955 F944 F933 FD77"
	$"FDDD FD00 FD33 F933 FD77 FDDD FD33 FD66"
	$"F955 F944 F933 FD77 FDDD FD00 F933 FD66"
	$"F9FF DD00 38CD 00ED 33FD 77FD DDFD 33FD"
	$"66F9 55F9 44F9 33FD 77FD DDFD 00FD 33F9"
	$"33FD 77FD DDFD 33FD 66F9 55F9 44F9 33FD"
	$"77FD DDFD 00F9 33FD 66F9 FFDD 0038 CD00"
	$"ED33 FD77 FDDD FD33 FD66 F955 F944 F933"
	$"FD77 FDDD FD00 FD33 F933 FD77 FDDD FD33"
	$"FD66 F955 F944 F933 FD77 FDDD FD00 F933"
	$"FD66 F9FF DD00 38CD 00ED 33FD 77FD DDFD"
	$"33FD 66F9 55F9 44F9 33FD 77FD DDFD 00FD"
	$"33F9 33FD 77FD DDFD 33FD 66F9 55F9 44F9"
	$"33FD 77FD DDFD 00F9 33FD 66F9 FFDD 001C"
	$"C988 F133 FD77 D5DD FD00 FD33 F933 FD77"
	$"D5DD FD00 F933 FD66 F9FF DD00 1CC9 88F1"
	$"33FD 77D5 DDFD 00FD 33F9 33FD 77D5 DDFD"
	$"00F9 33FD 66F9 FFDD 001C C988 F133 FD77"
	$"D5DD FD00 FD33 F933 FD77 D5DD FD00 F933"
	$"FD66 F9FF DD00 1CC9 88F1 33FD 77D5 DDFD"
	$"00FD 33F9 33FD 77D5 DDFD 00F9 33FD 66F9"
	$"FFDD 0038 CD00 ED33 FD77 FDDD FD33 FD55"
	$"F944 F933 F922 FD77 FDDD FD00 FD33 F933"
	$"FD77 FDDD FD33 FD55 F944 F933 F922 FD77"
	$"FDDD FD00 F933 FD66 F9FF DD00 38CD 00ED"
	$"33FD 77FD DDFD 33FD 55F9 44F9 33F9 22FD"
	$"77FD DDFD 00FD 33F9 33FD 77FD DDFD 33FD"
	$"55F9 44F9 33F9 22FD 77FD DDFD 00F9 33FD"
	$"66F9 FFDD 0038 CD00 ED33 FD77 FDDD FD33"
	$"FD55 F944 F933 F922 FD77 FDDD FD00 FD33"
	$"F933 FD77 FDDD FD33 FD55 F944 F933 F922"
	$"FD77 FDDD FD00 F933 FD66 F9FF DD00 38CD"
	$"00ED 33FD 77FD DDFD 33FD 55F9 44F9 33F9"
	$"22FD 77FD DDFD 00FD 33F9 33FD 77FD DDFD"
	$"33FD 55F9 44F9 33F9 22FD 77FD DDFD 00F9"
	$"33FD 66F9 FFDD 002A C988 F133 FD77 FDDD"
	$"FD33 F944 F933 F922 FD11 FD77 FDDD FD00"
	$"FD33 F933 FD77 D5DD FD00 F933 FD66 F9FF"
	$"DD00 2AC9 88F1 33FD 77FD DDFD 33F9 44F9"
	$"33F9 22FD 11FD 77FD DDFD 00FD 33F9 33FD"
	$"77D5 DDFD 00F9 33FD 66F9 FFDD 002A C988"
	$"F133 FD77 FDDD FD33 F944 F933 F922 FD11"
	$"FD77 FDDD FD00 FD33 F933 FD77 D5DD FD00"
	$"F933 FD66 F9FF DD00 2AC9 88F1 33FD 77FD"
	$"DDFD 33F9 44F9 33F9 22FD 11FD 77FD DDFD"
	$"00FD 33F9 33FD 77D5 DDFD 00F9 33FD 66F9"
	$"FFDD 0038 CD00 ED33 FD77 FDDD FD33 FD44"
	$"F933 F922 F911 FD77 FDDD FD00 FD33 F933"
	$"FD77 FDDD FD33 FD44 F933 F922 F911 FD77"
	$"FDDD FD00 F933 FD66 F9FF DD00 38CD 00ED"
	$"33FD 77FD DDFD 33FD 44F9 33F9 22F9 11FD"
	$"77FD DDFD 00FD 33F9 33FD 77FD DDFD 33FD"
	$"44F9 33F9 22F9 11FD 77FD DDFD 00F9 33FD"
	$"66F9 FFDD 0038 CD00 ED33 FD77 FDDD FD33"
	$"FD44 F933 F922 F911 FD77 FDDD FD00 FD33"
	$"F933 FD77 FDDD FD33 FD44 F933 F922 F911"
	$"FD77 FDDD FD00 F933 FD66 F9FF DD00 38CD"
	$"00ED 33FD 77FD DDFD 33FD 44F9 33F9 22F9"
	$"11FD 77FD DDFD 00FD 33F9 33FD 77FD DDFD"
	$"33FD 44F9 33F9 22F9 11FD 77FD DDFD 00F9"
	$"33FD 66F9 FFDD 0034 C988 F133 FD77 FDDD"
	$"F533 F922 F911 FD00 FD77 FDDD FD00 FD33"
	$"F933 FD77 FDDD F533 F922 F911 FD00 FD77"
	$"FDDD FD00 F933 FD66 F9FF DD00 34C9 88F1"
	$"33FD 77FD DDF5 33F9 22F9 11FD 00FD 77FD"
	$"DDFD 00FD 33F9 33FD 77FD DDF5 33F9 22F9"
	$"11FD 00FD 77FD DDFD 00F9 33FD 66F9 FFDD"
	$"0034 C988 F133 FD77 FDDD F533 F922 F911"
	$"FD00 FD77 FDDD FD00 FD33 F933 FD77 FDDD"
	$"F533 F922 F911 FD00 FD77 FDDD FD00 F933"
	$"FD66 F9FF DD00 34C9 88F1 33FD 77FD DDF5"
	$"33F9 22F9 11FD 00FD 77FD DDFD 00FD 33F9"
	$"33FD 77FD DDF5 33F9 22F9 11FD 00FD 77FD"
	$"DDFD 00F9 33FD 66F9 FFDD 0028 CD00 ED33"
	$"FD77 FDDD FD33 E177 FDDD FD00 FD33 F933"
	$"FD77 FDDD FD33 E177 FDDD FD00 F933 FD66"
	$"F9FF DD00 28CD 00ED 33FD 77FD DDFD 33E1"
	$"77FD DDFD 00FD 33F9 33FD 77FD DDFD 33E1"
	$"77FD DDFD 00F9 33FD 66F9 FFDD 0028 CD00"
	$"ED33 FD77 FDDD FD33 E177 FDDD FD00 FD33"
	$"F933 FD77 FDDD FD33 E177 FDDD FD00 F933"
	$"FD66 F9FF DD00 28CD 00ED 33FD 77FD DDFD"
	$"33E1 77FD DDFD 00FD 33F9 33FD 77FD DDFD"
	$"33E1 77FD DDFD 00F9 33FD 66F9 FFDD 001C"
	$"C988 F133 FD77 D5DD FD00 FD33 F933 FD77"
	$"D5DD FD00 F933 FD66 F9FF DD00 1CC9 88F1"
	$"33FD 77D5 DDFD 00FD 33F9 33FD 77D5 DDFD"
	$"00F9 33FD 66F9 FFDD 001C C988 F133 FD77"
	$"D5DD FD00 FD33 F933 FD77 D5DD FD00 F933"
	$"FD66 F9FF DD00 1CC9 88F1 33FD 77D5 DDFD"
	$"00FD 33F9 33FD 77D5 DDFD 00F9 33FD 66F9"
	$"FFDD 0012 B533 D100 FD33 F533 D100 F933"
	$"FD66 F9FF DD00 12B5 33D1 00FD 33F5 33D1"
	$"00F9 33FD 66F9 FFDD 0012 B533 D100 FD33"
	$"F533 D100 F933 FD66 F9FF DD00 12B5 33D1"
	$"00FD 33F5 33D1 00F9 33FD 66F9 FFDD 000A"
	$"8133 BD33 FD66 F9FF DD00 0A81 33BD 33FD"
	$"66F9 FFDD 000A 8133 BD33 FD66 F9FF DD00"
	$"0A81 33BD 33FD 66F9 FFDD 000A 8133 BD33"
	$"FD66 F9FF DD00 0A81 33BD 33FD 66F9 FFDD"
	$"000A 8133 BD33 FD66 F9FF DD00 0A81 33BD"
	$"33FD 66F9 FFDD 000A 8133 BD33 FD66 F9FF"
	$"DD00 0A81 33BD 33FD 66F9 FFDD 000A 8133"
	$"BD33 FD66 F9FF DD00 0A81 33BD 33FD 66F9"
	$"FFDD 000C 8166 C966 F533 FD66 F9FF DD00"
	$"0C81 66C9 66F5 33FD 66F9 FFDD 000C 8166"
	$"C966 F533 FD66 F9FF DD00 0C81 66C9 66F5"
	$"33FD 66F9 FFDD 000E 81FF C9FF FD00 F933"
	$"FD66 F9FF DD00 0E81 FFC9 FFFD 00F9 33FD"
	$"66F9 FFDD 000E 81FF C9FF FD00 F933 FD66"
	$"F9FF DD00 0E81 FFC9 FFFD 00F9 33FD 66F9"
	$"FFDD 0010 8100 CD00 FDFF FD00 F933 FD66"
	$"F9FF DD00 1081 00CD 00FD FFFD 00F9 33FD"
	$"66F9 FFDD 0010 8100 CD00 FDFF FD00 F933"
	$"FD66 F9FF DD00 1081 00CD 00FD FFFD 00F9"
	$"33FD 66F9 FFDD 0010 8100 CD00 FDFF FD00"
	$"F933 FD66 F9FF DD00 1081 00CD 00FD FFFD"
	$"00F9 33FD 66F9 FFDD 0010 8100 CD00 FDFF"
	$"FD00 F933 FD66 F9FF DD00 1081 00CD 00FD"
	$"FFFD 00F9 33FD 66F9 FFDD 0010 8100 CD00"
	$"FDFF FD00 F933 FD66 F9FF DD00 1081 00CD"
	$"00FD FFFD 00F9 33FD 66F9 FFDD 0010 8100"
	$"CD00 FDFF FD00 F933 FD66 F9FF DD00 1081"
	$"00CD 00FD FFFD 00F9 33FD 66F9 FFDD 0010"
	$"8100 CD00 FDFF FD00 F933 FD66 F9FF DD00"
	$"1081 00CD 00FD FFFD 00F9 33FD 66F9 FFDD"
	$"0010 8100 CD00 FDFF FD00 F933 FD66 F9FF"
	$"DD00 1081 00CD 00FD FFFD 00F9 33FD 66F9"
	$"FFDD 0010 8100 CD00 FDFF FD00 F933 FD66"
	$"F9FF DD00 1081 00CD 00FD FFFD 00F9 33FD"
	$"66F9 FFDD 0010 8100 CD00 FDFF FD00 F933"
	$"FD66 F9FF DD00 1081 00CD 00FD FFFD 00F9"
	$"33FD 66F9 FFDD 0010 8100 CD00 FDFF FD00"
	$"F933 FD66 F9FF DD00 1081 00CD 00FD FFFD"
	$"00F9 33FD 66F9 FFDD 0010 8100 CD00 FDFF"
	$"FD00 F933 FD66 F9FF DD00 1081 00CD 00FD"
	$"FFFD 00F9 33FD 66F9 FFDD 0010 8100 CD00"
	$"FDFF FD00 F933 FD66 F9FF DD00 1081 00CD"
	$"00FD FFFD 00F9 33FD 66F9 FFDD 0010 8100"
	$"CD00 FDFF FD00 F933 FD66 F9FF DD00 1081"
	$"00CD 00FD FFFD 00F9 33FD 66F9 FFDD 0010"
	$"8100 CD00 FDFF FD00 F933 FD66 F9FF DD00"
	$"1081 00CD 00FD FFFD 00F9 33FD 66F9 FFDD"
	$"0010 8100 CD00 FDFF FD00 F933 FD66 F9FF"
	$"DD00 1081 00CD 00FD FFFD 00F9 33FD 66F9"
	$"FFDD 0010 8100 CD00 FDFF FD00 F933 FD66"
	$"F9FF DD00 1081 00CD 00FD FFFD 00F9 33FD"
	$"66F9 FFDD 0010 8100 CD00 FDFF FD00 F933"
	$"FD66 F9FF DD00 1081 00CD 00FD FFFD 00F9"
	$"33FD 66F9 FFDD 0010 8100 CD00 FDFF FD00"
	$"F933 FD66 F9FF DD00 1081 00CD 00FD FFFD"
	$"00F9 33FD 66F9 FFDD 0010 8100 CD00 FDFF"
	$"FD00 F933 FD66 F9FF DD00 1081 00CD 00FD"
	$"FFFD 00F9 33FD 66F9 FFDD 0010 8100 CD00"
	$"FDFF FD00 F933 FD66 F9FF DD00 1081 00CD"
	$"00FD FFFD 00F9 33FD 66F9 FFDD 0010 8100"
	$"CD00 FDFF FD00 F933 FD66 F9FF DD00 1081"
	$"00CD 00FD FFFD 00F9 33FD 66F9 FFDD 0010"
	$"8100 CD00 FDFF FD00 F933 FD66 F9FF DD00"
	$"1081 00CD 00FD FFFD 00F9 33FD 66F9 FFDD"
	$"0010 8100 CD00 FDFF FD00 F933 FD66 F9FF"
	$"DD00 1081 00CD 00FD FFFD 00F9 33FD 66F9"
	$"FFDD 0010 8100 CD00 FDFF FD00 F933 FD66"
	$"F9FF DD00 1081 00CD 00FD FFFD 00F9 33FD"
	$"66F9 FFDD 0010 8100 CD00 FDFF FD00 F933"
	$"FD66 F9FF DD00 1081 00CD 00FD FFFD 00F9"
	$"33FD 66F9 FFDD 0010 8100 CD00 FDFF FD00"
	$"F933 FD66 F9FF DD00 1081 00CD 00FD FFFD"
	$"00F9 33FD 66F9 FFDD 0010 8100 CD00 FDFF"
	$"FD00 F933 FD66 F9FF DD00 1081 00CD 00FD"
	$"FFFD 00F9 33FD 66F9 FFDD 0010 8100 CD00"
	$"FDFF FD00 F933 FD66 F9FF DD00 1081 00CD"
	$"00FD FFFD 00F9 33FD 66F9 FFDD 0010 8100"
	$"CD00 FDFF FD00 F933 FD66 F9FF DD00 1081"
	$"00CD 00FD FFFD 00F9 33FD 66F9 FFDD 0010"
	$"8100 CD00 FDFF FD00 F933 FD66 F9FF DD00"
	$"1081 00CD 00FD FFFD 00F9 33FD 66F9 FFDD"
	$"0010 8100 CD00 FDFF FD00 F933 FD66 F9FF"
	$"DD00 1081 00CD 00FD FFFD 00F9 33FD 66F9"
	$"FFDD 0010 8100 CD00 FDFF FD00 F933 FD66"
	$"F9FF DD00 1081 00CD 00FD FFFD 00F9 33FD"
	$"66F9 FFDD 0010 8100 CD00 FDFF FD00 F933"
	$"FD66 F9FF DD00 1081 00CD 00FD FFFD 00F9"
	$"33FD 66F9 FFDD 0010 8100 CD00 FDFF FD00"
	$"F933 FD66 F9FF DD00 1081 00CD 00FD FFFD"
	$"00F9 33FD 66F9 FFDD 0010 8100 CD00 FDFF"
	$"FD00 F933 FD66 F9FF DD00 1081 00CD 00FD"
	$"FFFD 00F9 33FD 66F9 FFDD 0010 8100 CD00"
	$"FDFF FD00 F933 FD66 F9FF DD00 1081 00CD"
	$"00FD FFFD 00F9 33FD 66F9 FFDD 0010 8100"
	$"CD00 FDFF FD00 F933 FD66 F9FF DD00 1081"
	$"00CD 00FD FFFD 00F9 33FD 66F9 FFDD 0010"
	$"8100 CD00 FDFF FD00 F933 FD66 F9FF DD00"
	$"1081 00CD 00FD FFFD 00F9 33FD 66F9 FFDD"
	$"0010 8100 CD00 FDFF FD00 F933 FD66 F9FF"
	$"DD00 1081 00CD 00FD FFFD 00F9 33FD 66F9"
	$"FFDD 0010 8100 CD00 FDFF FD00 F933 FD66"
	$"F9FF DD00 1081 00CD 00FD FFFD 00F9 33FD"
	$"66F9 FFDD 0000 00FF"
};

resource 'PICT' (134) {
	4080,
	{0, 0, 201, 243},
	$"0011 02FF 0C00 FFFE 0000 0048 0042 0048"
	$"0042 0000 0000 00C9 00F3 0000 0000 00A1"
	$"01F2 0016 3842 494D 0000 0000 0000 00C9"
	$"00F3 4772 8970 68AF 626A 0001 000A 0000"
	$"0000 00C9 00F3 0098 807C 0000 0000 00C9"
	$"00F3 0000 0000 0000 0000 0048 0042 0048"
	$"0042 0000 0004 0001 0004 0000 0000 0000"
	$"0000 0000 0000 0046 D749 0000 000B 0000"
	$"FFFF FFFF FFFF 0001 EEEE EEEE EEEE 0002"
	$"DDDD DDDD DDDD 0003 CCCC CCCC CCCC 0004"
	$"BBBB BBBB BBBB 0005 AAAA AAAA AAAA 0006"
	$"9999 9999 9999 0007 8888 8888 8888 0008"
	$"7777 7777 7777 0009 5555 5555 5555 000A"
	$"2222 2222 2222 000B 0000 0000 0000 0000"
	$"0000 00C9 00F3 0000 0000 00C9 00F3 0000"
	$"0285 0002 8500 0285 0002 8500 0285 0002"
	$"8500 0285 0002 8500 0285 0002 8500 0285"
	$"0002 8500 0285 0002 8500 0285 0002 8500"
	$"0285 0002 8500 0285 0002 8500 0285 0002"
	$"8500 0285 0002 8500 0285 0002 8500 0285"
	$"0002 8500 0285 0002 8500 0285 0004 9BBB"
	$"EB00 049B BBEB 0004 9BBB EB00 049B BBEB"
	$"0008 9F00 FF33 FFBB EB00 089F 00FF 33FF"
	$"BBEB 0008 9F00 FF33 FFBB EB00 089F 00FF"
	$"33FF BBEB 0008 9F33 FF66 FDBB ED00 089F"
	$"33FF 66FD BBED 0008 9F33 FF66 FDBB ED00"
	$"089F 33FF 66FD BBED 0008 9F33 FF66 FDBB"
	$"ED00 089F 33FF 66FD BBED 0008 9F33 FF66"
	$"FDBB ED00 089F 33FF 66FD BBED 0012 E700"
	$"F733 E977 F933 E977 FB33 FF66 FDBB ED00"
	$"12E7 00F7 33E9 77F9 33E9 77FB 33FF 66FD"
	$"BBED 0012 E700 F733 E977 F933 E977 FB33"
	$"FF66 FDBB ED00 12E7 00F7 33E9 77F9 33E9"
	$"77FB 33FF 66FD BBED 001A E588 F933 FF77"
	$"EBAA FF00 FB33 FF77 EBAA FF00 FD33 FF66"
	$"FDBB ED00 1AE5 88F9 33FF 77EB AAFF 00FB"
	$"33FF 77EB AAFF 00FD 33FF 66FD BBED 001A"
	$"E588 F933 FF77 EBAA FF00 FB33 FF77 EBAA"
	$"FF00 FD33 FF66 FDBB ED00 1AE5 88F9 33FF"
	$"77EB AAFF 00FB 33FF 77EB AAFF 00FD 33FF"
	$"66FD BBED 002A E700 F733 FF77 FFAA FF00"
	$"FD33 FFAA F733 FFAA FF00 FB33 FF77 FFAA"
	$"FF00 F133 FFAA FF00 FD33 FF66 FDBB ED00"
	$"2AE7 00F7 33FF 77FF AAFF 00FD 33FF AAF7"
	$"33FF AAFF 00FB 33FF 77FF AAFF 00F1 33FF"
	$"AAFF 00FD 33FF 66FD BBED 002A E700 F733"
	$"FF77 FFAA FF00 FD33 FFAA F733 FFAA FF00"
	$"FB33 FF77 FFAA FF00 F133 FFAA FF00 FD33"
	$"FF66 FDBB ED00 2AE7 00F7 33FF 77FF AAFF"
	$"00FD 33FF AAF7 33FF AAFF 00FB 33FF 77FF"
	$"AAFF 00F1 33FF AAFF 00FD 33FF 66FD BBED"
	$"0038 E588 F933 FF77 FFAA FF33 FD66 FFAA"
	$"FF55 FD44 FF33 FF77 FFAA FF00 FB33 FF77"
	$"FFAA FF33 FD66 FD55 FD44 FF33 FF77 FFAA"
	$"FF00 FD33 FF66 FDBB ED00 38E5 88F9 33FF"
	$"77FF AAFF 33FD 66FF AAFF 55FD 44FF 33FF"
	$"77FF AAFF 00FB 33FF 77FF AAFF 33FD 66FD"
	$"55FD 44FF 33FF 77FF AAFF 00FD 33FF 66FD"
	$"BBED 0038 E588 F933 FF77 FFAA FF33 FD66"
	$"FFAA FF55 FD44 FF33 FF77 FFAA FF00 FB33"
	$"FF77 FFAA FF33 FD66 FD55 FD44 FF33 FF77"
	$"FFAA FF00 FD33 FF66 FDBB ED00 38E5 88F9"
	$"33FF 77FF AAFF 33FD 66FF AAFF 55FD 44FF"
	$"33FF 77FF AAFF 00FB 33FF 77FF AAFF 33FD"
	$"66FD 55FD 44FF 33FF 77FF AAFF 00FD 33FF"
	$"66FD BBED 0038 E700 F733 FF77 FFAA FF33"
	$"FF66 FF55 FFAA FD44 FD33 FF77 FFAA FF00"
	$"FB33 FF77 FFAA FF33 FF66 FD55 FD44 FD33"
	$"FF77 FFAA FF00 FD33 FF66 FDBB ED00 38E7"
	$"00F7 33FF 77FF AAFF 33FF 66FF 55FF AAFD"
	$"44FD 33FF 77FF AAFF 00FB 33FF 77FF AAFF"
	$"33FF 66FD 55FD 44FD 33FF 77FF AAFF 00FD"
	$"33FF 66FD BBED 0038 E700 F733 FF77 FFAA"
	$"FF33 FF66 FF55 FFAA FD44 FD33 FF77 FFAA"
	$"FF00 FB33 FF77 FFAA FF33 FF66 FD55 FD44"
	$"FD33 FF77 FFAA FF00 FD33 FF66 FDBB ED00"
	$"38E7 00F7 33FF 77FF AAFF 33FF 66FF 55FF"
	$"AAFD 44FD 33FF 77FF AAFF 00FB 33FF 77FF"
	$"AAFF 33FF 66FD 55FD 44FD 33FF 77FF AAFF"
	$"00FD 33FF 66FD BBED 002A E588 F933 FF77"
	$"FFAA FF33 FD55 FFAA FF44 FD33 FF22 FF77"
	$"FFAA FF00 FB33 FF77 EBAA FF00 FD33 FF66"
	$"FDBB ED00 2AE5 88F9 33FF 77FF AAFF 33FD"
	$"55FF AAFF 44FD 33FF 22FF 77FF AAFF 00FB"
	$"33FF 77EB AAFF 00FD 33FF 66FD BBED 002A"
	$"E588 F933 FF77 FFAA FF33 FD55 FFAA FF44"
	$"FD33 FF22 FF77 FFAA FF00 FB33 FF77 EBAA"
	$"FF00 FD33 FF66 FDBB ED00 2AE5 88F9 33FF"
	$"77FF AAFF 33FD 55FF AAFF 44FD 33FF 22FF"
	$"77FF AAFF 00FB 33FF 77EB AAFF 00FD 33FF"
	$"66FD BBED 0038 E700 F733 FF77 FFAA FF33"
	$"FF55 FF44 FFAA FD33 FD22 FF77 FFAA FF00"
	$"FB33 FF77 FFAA FF33 FF55 FD44 FD33 FD22"
	$"FF77 FFAA FF00 FD33 FF66 FDBB ED00 38E7"
	$"00F7 33FF 77FF AAFF 33FF 55FF 44FF AAFD"
	$"33FD 22FF 77FF AAFF 00FB 33FF 77FF AAFF"
	$"33FF 55FD 44FD 33FD 22FF 77FF AAFF 00FD"
	$"33FF 66FD BBED 0038 E700 F733 FF77 FFAA"
	$"FF33 FF55 FF44 FFAA FD33 FD22 FF77 FFAA"
	$"FF00 FB33 FF77 FFAA FF33 FF55 FD44 FD33"
	$"FD22 FF77 FFAA FF00 FD33 FF66 FDBB ED00"
	$"38E7 00F7 33FF 77FF AAFF 33FF 55FF 44FF"
	$"AAFD 33FD 22FF 77FF AAFF 00FB 33FF 77FF"
	$"AAFF 33FF 55FD 44FD 33FD 22FF 77FF AAFF"
	$"00FD 33FF 66FD BBED 002A E588 F933 FF77"
	$"FFAA FF33 FD44 FFAA FF33 FD22 FF11 FF77"
	$"FFAA FF00 FB33 FF77 EBAA FF00 FD33 FF66"
	$"FDBB ED00 2AE5 88F9 33FF 77FF AAFF 33FD"
	$"44FF AAFF 33FD 22FF 11FF 77FF AAFF 00FB"
	$"33FF 77EB AAFF 00FD 33FF 66FD BBED 002A"
	$"E588 F933 FF77 FFAA FF33 FD44 FFAA FF33"
	$"FD22 FF11 FF77 FFAA FF00 FB33 FF77 EBAA"
	$"FF00 FD33 FF66 FDBB ED00 2AE5 88F9 33FF"
	$"77FF AAFF 33FD 44FF AAFF 33FD 22FF 11FF"
	$"77FF AAFF 00FB 33FF 77EB AAFF 00FD 33FF"
	$"66FD BBED 0038 E700 F733 FF77 FFAA FF33"
	$"FF44 FF33 FFAA FD22 FD11 FF77 FFAA FF00"
	$"FB33 FF77 FFAA FF33 FF44 FD33 FD22 FD11"
	$"FF77 FFAA FF00 FD33 FF66 FDBB ED00 38E7"
	$"00F7 33FF 77FF AAFF 33FF 44FF 33FF AAFD"
	$"22FD 11FF 77FF AAFF 00FB 33FF 77FF AAFF"
	$"33FF 44FD 33FD 22FD 11FF 77FF AAFF 00FD"
	$"33FF 66FD BBED 0038 E700 F733 FF77 FFAA"
	$"FF33 FF44 FF33 FFAA FD22 FD11 FF77 FFAA"
	$"FF00 FB33 FF77 FFAA FF33 FF44 FD33 FD22"
	$"FD11 FF77 FFAA FF00 FD33 FF66 FDBB ED00"
	$"38E7 00F7 33FF 77FF AAFF 33FF 44FF 33FF"
	$"AAFD 22FD 11FF 77FF AAFF 00FB 33FF 77FF"
	$"AAFF 33FF 44FD 33FD 22FD 11FF 77FF AAFF"
	$"00FD 33FF 66FD BBED 0034 E588 F933 FF77"
	$"FFAA FB33 FFAA FF22 FD11 FF00 FF77 FFAA"
	$"FF00 FB33 FF77 FFAA FB33 FD22 FD11 FF00"
	$"FF77 FFAA FF00 FD33 FF66 FDBB ED00 34E5"
	$"88F9 33FF 77FF AAFB 33FF AAFF 22FD 11FF"
	$"00FF 77FF AAFF 00FB 33FF 77FF AAFB 33FD"
	$"22FD 11FF 00FF 77FF AAFF 00FD 33FF 66FD"
	$"BBED 0034 E588 F933 FF77 FFAA FB33 FFAA"
	$"FF22 FD11 FF00 FF77 FFAA FF00 FB33 FF77"
	$"FFAA FB33 FD22 FD11 FF00 FF77 FFAA FF00"
	$"FD33 FF66 FDBB ED00 34E5 88F9 33FF 77FF"
	$"AAFB 33FF AAFF 22FD 11FF 00FF 77FF AAFF"
	$"00FB 33FF 77FF AAFB 33FD 22FD 11FF 00FF"
	$"77FF AAFF 00FD 33FF 66FD BBED 002A E700"
	$"F733 FF77 FFAA FF33 FD77 FFAA F777 FFAA"
	$"FF00 FB33 FF77 FFAA FF33 F177 FFAA FF00"
	$"FD33 FF66 FDBB ED00 2AE7 00F7 33FF 77FF"
	$"AAFF 33FD 77FF AAF7 77FF AAFF 00FB 33FF"
	$"77FF AAFF 33F1 77FF AAFF 00FD 33FF 66FD"
	$"BBED 002A E700 F733 FF77 FFAA FF33 FD77"
	$"FFAA F777 FFAA FF00 FB33 FF77 FFAA FF33"
	$"F177 FFAA FF00 FD33 FF66 FDBB ED00 2AE7"
	$"00F7 33FF 77FF AAFF 33FD 77FF AAF7 77FF"
	$"AAFF 00FB 33FF 77FF AAFF 33F1 77FF AAFF"
	$"00FD 33FF 66FD BBED 001A E588 F933 FF77"
	$"EBAA FF00 FB33 FF77 EBAA FF00 FD33 FF66"
	$"FDBB ED00 1AE5 88F9 33FF 77EB AAFF 00FB"
	$"33FF 77EB AAFF 00FD 33FF 66FD BBED 001A"
	$"E588 F933 FF77 EBAA FF00 FB33 FF77 EBAA"
	$"FF00 FD33 FF66 FDBB ED00 1AE5 88F9 33FF"
	$"77EB AAFF 00FB 33FF 77EB AAFF 00FD 33FF"
	$"66FD BBED 0010 DB33 E900 F933 E900 FD33"
	$"FF66 FDBB ED00 10DB 33E9 00F9 33E9 00FD"
	$"33FF 66FD BBED 0010 DB33 E900 F933 E900"
	$"FD33 FF66 FDBB ED00 10DB 33E9 00F9 33E9"
	$"00FD 33FF 66FD BBED 0008 9F33 FF66 FDBB"
	$"ED00 089F 33FF 66FD BBED 0008 9F33 FF66"
	$"FDBB ED00 089F 33FF 66FD BBED 0008 9F33"
	$"FF66 FDBB ED00 089F 33FF 66FD BBED 0008"
	$"9F33 FF66 FDBB ED00 089F 33FF 66FD BBED"
	$"0008 9F33 FF66 FDBB ED00 089F 33FF 66FD"
	$"BBED 0008 9F33 FF66 FDBB ED00 089F 33FF"
	$"66FD BBED 000A A566 FB33 FF66 FDBB ED00"
	$"0AA5 66FB 33FF 66FD BBED 000A A566 FB33"
	$"FF66 FDBB ED00 0AA5 66FB 33FF 66FD BBED"
	$"000C A5BB FF00 FD33 FF66 FDBB ED00 0CA5"
	$"BBFF 00FD 33FF 66FD BBED 000C A5BB FF00"
	$"FD33 FF66 FDBB ED00 0CA5 BBFF 00FD 33FF"
	$"66FD BBED 000E A700 FFBB FF00 FD33 FF66"
	$"FDBB ED00 0EA7 00FF BBFF 00FD 33FF 66FD"
	$"BBED 000E A700 FFBB FF00 FD33 FF66 FDBB"
	$"ED00 0EA7 00FF BBFF 00FD 33FF 66FD BBED"
	$"000E A700 FFBB FF00 FD33 FF66 FDBB ED00"
	$"0EA7 00FF BBFF 00FD 33FF 66FD BBED 000E"
	$"A700 FFBB FF00 FD33 FF66 FDBB ED00 0EA7"
	$"00FF BBFF 00FD 33FF 66FD BBED 000E A700"
	$"FFBB FF00 FD33 FF66 FDBB ED00 0EA7 00FF"
	$"BBFF 00FD 33FF 66FD BBED 000E A700 FFBB"
	$"FF00 FD33 FF66 FDBB ED00 0EA7 00FF BBFF"
	$"00FD 33FF 66FD BBED 000E A700 FFBB FF00"
	$"FD33 FF66 FDBB ED00 0EA7 00FF BBFF 00FD"
	$"33FF 66FD BBED 000E A700 FFBB FF00 FD33"
	$"FF66 FDBB ED00 0EA7 00FF BBFF 00FD 33FF"
	$"66FD BBED 000E A700 FFBB FF00 FD33 FF66"
	$"FDBB ED00 0EA7 00FF BBFF 00FD 33FF 66FD"
	$"BBED 000E A700 FFBB FF00 FD33 FF66 FDBB"
	$"ED00 0EA7 00FF BBFF 00FD 33FF 66FD BBED"
	$"000E A700 FFBB FF00 FD33 FF66 FDBB ED00"
	$"0EA7 00FF BBFF 00FD 33FF 66FD BBED 000E"
	$"A700 FFBB FF00 FD33 FF66 FDBB ED00 0EA7"
	$"00FF BBFF 00FD 33FF 66FD BBED 000E A700"
	$"FFBB FF00 FD33 FF66 FDBB ED00 0EA7 00FF"
	$"BBFF 00FD 33FF 66FD BBED 000E A700 FFBB"
	$"FF00 FD33 FF66 FDBB ED00 0EA7 00FF BBFF"
	$"00FD 33FF 66FD BBED 000E A700 FFBB FF00"
	$"FD33 FF66 FDBB ED00 0EA7 00FF BBFF 00FD"
	$"33FF 66FD BBED 000E A700 FFBB FF00 FD33"
	$"FF66 FDBB ED00 0EA7 00FF BBFF 00FD 33FF"
	$"66FD BBED 000E A700 FFBB FF00 FD33 FF66"
	$"FDBB ED00 0EA7 00FF BBFF 00FD 33FF 66FD"
	$"BBED 000E A700 FFBB FF00 FD33 FF66 FDBB"
	$"ED00 0EA7 00FF BBFF 00FD 33FF 66FD BBED"
	$"000E A700 FFBB FF00 FD33 FF66 FDBB ED00"
	$"0EA7 00FF BBFF 00FD 33FF 66FD BBED 000E"
	$"A700 FFBB FF00 FD33 FF66 FDBB ED00 0EA7"
	$"00FF BBFF 00FD 33FF 66FD BBED 000E A700"
	$"FFBB FF00 FD33 FF66 FDBB ED00 0EA7 00FF"
	$"BBFF 00FD 33FF 66FD BBED 000E A700 FFBB"
	$"FF00 FD33 FF66 FDBB ED00 0EA7 00FF BBFF"
	$"00FD 33FF 66FD BBED 000E A700 FFBB FF00"
	$"FD33 FF66 FDBB ED00 0EA7 00FF BBFF 00FD"
	$"33FF 66FD BBED 000E A700 FFBB FF00 FD33"
	$"FF66 FDBB ED00 0EA7 00FF BBFF 00FD 33FF"
	$"66FD BBED 000E A700 FFBB FF00 FD33 FF66"
	$"FDBB ED00 0EA7 00FF BBFF 00FD 33FF 66FD"
	$"BBED 000E A700 FFBB FF00 FD33 FF66 FDBB"
	$"ED00 0EA7 00FF BBFF 00FD 33FF 66FD BBED"
	$"000E A700 FFBB FF00 FD33 FF66 FDBB ED00"
	$"0EA7 00FF BBFF 00FD 33FF 66FD BBED 000E"
	$"A700 FFBB FF00 FD33 FF66 FDBB ED00 0EA7"
	$"00FF BBFF 00FD 33FF 66FD BBED 000E A700"
	$"FFBB FF00 FD33 FF66 FDBB ED00 0EA7 00FF"
	$"BBFF 00FD 33FF 66FD BBED 000E A700 FFBB"
	$"FF00 FD33 FF66 FDBB ED00 0EA7 00FF BBFF"
	$"00FD 33FF 66FD BBED 000E A700 FFBB FF00"
	$"FD33 FF66 FDBB ED00 0EA7 00FF BBFF 00FD"
	$"33FF 66FD BBED 000E A700 FFBB FF00 FD33"
	$"FF66 FDBB ED00 0EA7 00FF BBFF 00FD 33FF"
	$"66FD BBED 000E A700 FFBB FF00 FD33 FF66"
	$"FDBB ED00 0EA7 00FF BBFF 00FD 33FF 66FD"
	$"BBED 000E A700 FFBB FF00 FD33 FF66 FDBB"
	$"ED00 0EA7 00FF BBFF 00FD 33FF 66FD BBED"
	$"000E A700 FFBB FF00 FD33 FF66 FDBB ED00"
	$"0EA7 00FF BBFF 00FD 33FF 66FD BBED 000E"
	$"A700 FFBB FF00 FD33 FF66 FDBB ED00 0EA7"
	$"00FF BBFF 00FD 33FF 66FD BBED 000E A700"
	$"FFBB FF00 FD33 FF66 FDBB ED00 0EA7 00FF"
	$"BBFF 00FD 33FF 66FD BBED 000E A700 FFBB"
	$"FF00 FD33 FF66 FDBB ED00 0EA7 00FF BBFF"
	$"00FD 33FF 66FD BBED 000E A700 FFBB FF00"
	$"FD33 FF66 FDBB ED00 0EA7 00FF BBFF 00FD"
	$"33FF 66FD BBED 000E A700 FFBB FF00 FD33"
	$"FF66 FDBB ED00 0EA7 00FF BBFF 00FD 33FF"
	$"66FD BBED 000E A700 FFBB FF00 FD33 FF66"
	$"FDBB ED00 0EA7 00FF BBFF 00FD 33FF 66FD"
	$"BBED 0000 00FF"
};

resource 'icl8' (128) {
	$"0000 FFFF FF00 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 FF2A 54FC FF00 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"FFFF FC54 542A 54FC FF00 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"FF00 54FC FC54 542A 54FC FF00 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"FF2A 2A00 54FC FC54 542A 54FC FF00 00FF"
	$"FFFF 0000 0000 0000 0000 0000 0000 0000"
	$"FF2A 2A2A 2A00 54FC FC54 542A 54FC FF54"
	$"2A54 FCFF 0000 0000 0000 0000 0000 0000"
	$"FF2A 2A2A 2A2A 2A00 54FC FC54 542A 5454"
	$"5454 2A54 FCFC 0000 0000 0000 0000 0000"
	$"FF2A 2A2A 2A2A 2A2A 2A00 54FC FC54 5454"
	$"5454 5454 2AFF 0000 0000 0000 0000 0000"
	$"FF2A 2A2A 2A2A 2A2A 2A2A 2A00 FC54 5454"
	$"5454 5454 5480 FC00 0000 0000 0000 0000"
	$"FF2A 2A2A 2A2A 2A2A 2A2A 2A2A FCFC 5454"
	$"5454 5454 5454 FF00 0000 0000 0000 0000"
	$"FF2A 2A2A 2A2A 2A2A 2A2A 2A2A 0054 FCFC"
	$"54FC FC54 5454 54FF 0000 0000 0000 0000"
	$"FF2A 2A2A 2A2A 2A2A 2A2A 2A2A 2A2A 0054"
	$"FCFC 54FC FC54 542A FF00 0000 0000 0000"
	$"FF2A 2A2A 2A2A 2A2A 2A2A 2A2A 2A2A 2A2A"
	$"2A2A 2A00 54FC 5454 FF00 0000 0000 0000"
	$"FF2A 2A2A 2A2A 2A2A 2A2A 2A2A 2A2A 2A2A"
	$"2A2A 2A2A 2A00 FF54 FF00 0000 0000 0000"
	$"FF2A 2A2A 2A2A 2A2A 2A2A 2A2A 2A2A 2A2A"
	$"2A2A 2A2A 2A7F FF7F FF00 0000 0000 0000"
	$"FF2A 2A2A 2A2A 2A2A 2A2A 2A2A 2A2A 2A2A"
	$"2A2A 2A2A 2A7F FF7F FF00 0000 0000 0000"
	$"FF2A 2A2A 2A2A 2A2A 2A2A 2A2A 2A2A 2A2A"
	$"2A2A 2A2A 2A7F FF7F FF00 0000 0000 0000"
	$"FF2A 2A2A 2A2A 2A2A 2A2A 2A2A 2A2A 2A2A"
	$"2A2A 2A2A 2A7F FF7F FF00 0000 0000 0000"
	$"FF2A 2A2A 2A2A 2A2A 2A2A 2A2A 2A2A 2A2A"
	$"2A2A 2A2A 2A7F FF7F FF00 0000 0000 0000"
	$"FF2A 2A2A 2A2A 2A2A 2A2A 2A2A 2A2A 2A2A"
	$"2A2A 2A2A 2A7F FF7F FF00 0000 0000 0000"
	$"FF7F 542A 2A2A 2A2A 2A2A 2A2A 2A2A 2A2A"
	$"2A2A 2A2A 2A7F FF7F FF00 0000 0000 0000"
	$"00FF FC7F 542A 2A2A 2A2A 2A2A 2A2A 2A2A"
	$"2A2A 2A2A 2A7F FF7F FF00 0000 0000 0000"
	$"0000 00FF FC7F 542A 2A2A 2A2A 2A2A 2A2A"
	$"2A2A 2A2A 2A7F FF7F FF00 0000 0000 0000"
	$"0000 0000 00FF FC7F 542A 2A2A 2A2A 2A2A"
	$"2A2A 2A2A 2A7F FF7F FF00 0000 0000 0000"
	$"0000 0000 0000 00FF FC7F 542A 2A2A 2A2A"
	$"2A2A 2A2A 2A7F FF7F FFFC 0000 0000 0000"
	$"0000 0000 0000 0000 00FF FC7F 542A 2A2A"
	$"2A2A 2A2A 2A7F FF7F FFFC FCFC 0000 0000"
	$"0000 0000 0000 0000 0000 00FF FC7F 542A"
	$"2A2A 2A2A 2A7F FF7F FFFC FCFC FCFC 0000"
	$"0000 0000 0000 0000 0000 0000 00FF FC7F"
	$"542A 2A2A 2A7F FF7F FFFC FCFC FCFC FC00"
	$"0000 0000 0000 0000 0000 0000 0000 00FF"
	$"FC7F 542A 2A7F FF7F FFFC FCFC FCFC FC00"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"00FF FC7F 7F7F FF7F FFFC FCFC FCFC 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 00FF FC7F FF7F FFFC FCFC 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 00FF FFFF FCFC"
};

resource 'icl4' (128) {
	$"00FF F000 0000 0000 0000 0000 0000 0000"
	$"00FC CEF0 0000 0000 0000 0000 0000 0000"
	$"FFEC CCCE F000 0000 0000 0000 0000 0000"
	$"F0CE ECCC CEF0 0000 0000 0000 0000 0000"
	$"FCC0 CEEC CCCE F00F FF00 0000 0000 0000"
	$"FCCC C0CE ECCC CEFC CCEF 0000 0000 0000"
	$"FCCC CCC0 CEEC CCCC CCCC EE00 0000 0000"
	$"FCCC CCCC C0CE ECCC CCCC CF00 0000 0000"
	$"FCCC CCCC CCC0 ECCC CCCC CDE0 0000 0000"
	$"FCCC CCCC CCCC EECC CCCC CCF0 0000 0000"
	$"FCCC CCCC CCCC 0CEE CEEC CCCF 0000 0000"
	$"FCCC CCCC CCCC CC0C EECE ECCC F000 0000"
	$"FCCC CCCC CCCC CCCC CCC0 CECC F000 0000"
	$"FCCC CCCC CCCC CCCC CCCC C0FC F000 0000"
	$"FCCC CCCC CCCC CCCC CCCC CDFD F000 0000"
	$"FCCC CCCC CCCC CCCC CCCC CDFD F000 0000"
	$"FCCC CCCC CCCC CCCC CCCC CDFD F000 0000"
	$"FCCC CCCC CCCC CCCC CCCC CDFD F000 0000"
	$"FCCC CCCC CCCC CCCC CCCC CDFD F000 0000"
	$"FCCC CCCC CCCC CCCC CCCC CDFD F000 0000"
	$"FDCC CCCC CCCC CCCC CCCC CDFD F000 0000"
	$"0FED CCCC CCCC CCCC CCCC CDFD F000 0000"
	$"000F EDCC CCCC CCCC CCCC CDFD F000 0000"
	$"0000 0FED CCCC CCCC CCCC CDFD F000 0000"
	$"0000 000F EDCC CCCC CCCC CDFD FE00 0000"
	$"0000 0000 0FED CCCC CCCC CDFD FEEE 0000"
	$"0000 0000 000F EDCC CCCC CDFD FEEE EE00"
	$"0000 0000 0000 0FED CCCC CDFD FEEE EEE0"
	$"0000 0000 0000 000F EDCC CDFD FEEE EEE0"
	$"0000 0000 0000 0000 0FED DDFD FEEE EE00"
	$"0000 0000 0000 0000 000F EDFD FEEE 0000"
	$"0000 0000 0000 0000 0000 0FFF EE"
};

resource 'ICN#' (128) {
	{	/* array: 2 elements */
		/* [1] */
		$"3800 0000 2600 0000 E180 0000 9860 0000"
		$"8619 C000 8186 3000 8060 0C00 8018 0400"
		$"8008 0600 800C 0200 8003 6100 8000 D880"
		$"8000 0480 8000 0280 8000 0780 8000 0780"
		$"8000 0780 8000 0780 8000 0780 8000 0780"
		$"C000 0780 7000 0780 1C00 0780 0700 0780"
		$"01C0 07C0 0070 07F0 001C 07FC 0007 07FE"
		$"0001 C7FE 0000 7FFC 0000 1FF0 0000 07C0",
		/* [2] */
		$"3800 0000 3E00 0000 FF80 0000 FFE0 0000"
		$"FFF9 C000 FFFF F000 FFFF FC00 FFFF FC00"
		$"FFFF FE00 FFFF FE00 FFFF FF00 FFFF FF80"
		$"FFFF FF80 FFFF FF80 FFFF FF80 FFFF FF80"
		$"FFFF FF80 FFFF FF80 FFFF FF80 FFFF FF80"
		$"FFFF FF80 7FFF FF80 1FFF FF80 07FF FF80"
		$"01FF FFC0 007F FFF0 001F FFFC 0007 FFFE"
		$"0001 FFFE 0000 7FFC 0000 1FF0 0000 07C0"
	}
};

resource 'ics4' (128) {
	$"0FFF 0000 0000 0000 FEEE FF00 0000 0000"
	$"FCEE EEFF FF00 0000 FCCC EEEC CCF0 0000"
	$"FCCC CCEC CCDF 0000 FCCC CCCE EEEF F000"
	$"FCCC CCCC CCEF F000 FCCC CCCC CCDF F000"
	$"FCCC CCCC CCDF F000 FCCC CCCC CCDF F000"
	$"FECC CCCC CCDF F000 0FFE CCCC CCDF F000"
	$"000F FECC CCDF FE00 0000 0FFE CCDF FEEE"
	$"0000 000F FEDF FEEE 0000 0000 0FFF FE"
};

resource 'ics4' (130) {
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 FFFF FF00"
	$"0000 0000 00FF 0000 0000 0000 0FF0 0000"
	$"0000 0000 FF00 0000 0000 000F F000 0000"
	$"0000 00FF 0000 0000 0000 0FF0 0000 0000"
	$"0000 FF00 0000 0000 00FF FFFF"
};

resource 'cicn' (128) {
	4,
	{0, 0, 12, 16},
	2,
	$"FFFC FFFC FFFC FFFF FFFF FFFF FFFF FFFF"
	$"1FFF 1FFF 1FFF 0000",
	$"FFFC FFFC FFFC FFFF F001 F001 F001 F001"
	$"1001 1001 1FFF 0000",
	{	/* array ColorSpec: 4 elements */
		/* [1] */
		65535, 65535, 65535,
		/* [2] */
		43690, 43690, 43690,
		/* [3] */
		21845, 21845, 21845,
		/* [4] */
		0, 0, 0
	},
	$"FFFF FFF0 EAAA AAB0 EAAA AAB0 EBFF FFFF"
	$"EB55 5557 EB55 5557 EB55 5557 FF55 5557"
	$"0355 5557 0355 5557 03FF FFFF 0000 0000"
};

data 'tab#' (128) {
	$"0003 0080 0554 6162 2031 0000 0000 0000"            /* ...ƒ.Tab 1...... */
	$"0000 0554 6162 2032 0000 0000 0000 0000"            /* ...Tab 2........ */
	$"0554 6162 2033 0000 0000 0000"                      /* .Tab 3...... */
};

resource 'tab#' (6000) {
	versionZero {
		{	/* array TabInfo: 6 elements */
			/* [1] */
			0,
			"Classic",
			/* [2] */
			0,
			"Sliders",
			/* [3] */
			0,
			"Text",
			/* [4] */
			0,
			"Progress",
			/* [5] */
			0,
			"Groups",
			/* [6] */
			0,
			"Grab Bag"
		}
	}
};

resource 'actb' (-1) {
	{	/* array ColorSpec: 5 elements */
		/* [1] */
		wContentColor, 56797, 56797, 56797,
		/* [2] */
		wFrameColor, 0, 0, 0,
		/* [3] */
		wTextColor, 0, 0, 0,
		/* [4] */
		wHiliteColor, 0, 0, 0,
		/* [5] */
		wTitleBarColor, 65535, 65535, 65535
	}
};

data 'ictb' (2000) {
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000"                                          /* .... */
};

data 'ictb' (1002) {
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
};

data 'ppat' (128) {
	$"0001 0000 001C 0000 004E 0000 0000 FFFF"            /* .........N....ùù */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"8001 0000 0000 0008 0008 0000 0000 0000"            /* ƒ............... */
	$"0000 0048 0000 0048 0000 0000 0001 0001"            /* ...H...H........ */
	$"0001 0000 0000 0000 0056 0000 0000 0000"            /* .........V...... */
	$"0000 0000 0000 0000 0000 0000 0000 0000"            /* ................ */
	$"0000 8888 0000"                                     /* ..‡‡.. */
};

resource 'DLOG' (1002) {
	{87, 57, 297, 393},
	documentProc,
	visible,
	goAway,
	0x0,
	1002,
	"",
	noAutoCenter
	/****** Extra bytes follow... ******/
	/* $"0001"                                               /* .. */
};

resource 'DLOG' (2001, "Visual Separator") {
	{40, 40, 130, 385},
	movableDBoxProc,
	visible,
	goAway,
	0x0,
	2001,
	"Visual Separator",
	alertPositionMainScreen
	/****** Extra bytes follow... ******/
	/* $"7FFA 0001"                                          /* .ô.. */
};

resource 'DLOG' (2002, "Disclosure Triangle") {
	{40, 40, 119, 358},
	movableDBoxProc,
	visible,
	goAway,
	0x0,
	2002,
	"Disclosure Triangle",
	alertPositionMainScreen
	/****** Extra bytes follow... ******/
	/* $"7FFA 0001"                                          /* .ô.. */
};

resource 'DLOG' (2003, "Finder Header") {
	{40, 40, 144, 381},
	movableDBoxProc,
	visible,
	goAway,
	0x0,
	2003,
	"Finder Header",
	alertPositionMainScreen
	/****** Extra bytes follow... ******/
	/* $"7FFA 0001"                                          /* .ô.. */
};

resource 'DLOG' (2004) {
	{43, 40, 130, 394},
	movableDBoxProc,
	visible,
	goAway,
	0x0,
	2004,
	"Set Value",
	centerParentWindow
	/****** Extra bytes follow... ******/
	/* $"7FFA 0001"                                          /* .ô.. */
};

resource 'DLOG' (2005, "Pict or Icon") {
	{52, 45, 181, 394},
	1043,
	invisible,
	goAway,
	0x0,
	2005,
	"",
	centerParentWindow
	/****** Extra bytes follow... ******/
	/* $"7FFA 0001"                                          /* .ô.. */
};

resource 'DLOG' (2006, "Progress Indicator") {
	{43, 40, 130, 394},
	movableDBoxProc,
	visible,
	goAway,
	0x0,
	2006,
	"Progress Indicator",
	alertPositionParentWindow
	/****** Extra bytes follow... ******/
	/* $"7FFA 0001"                                          /* .ô.. */
};

resource 'DLOG' (2007, "Group Box") {
	{40, 40, 192, 434},
	movableDBoxProc,
	visible,
	goAway,
	0x0,
	2007,
	"Group Box",
	alertPositionParentWindow
	/****** Extra bytes follow... ******/
	/* $"7FFA 0001"                                          /* .ô.. */
};

resource 'DLOG' (2008, "Placard") {
	{40, 40, 138, 381},
	movableDBoxProc,
	visible,
	goAway,
	0x0,
	2008,
	"Placard",
	alertPositionParentWindow
	/****** Extra bytes follow... ******/
	/* $"7FFA 0001"                                          /* .ô.. */
};

resource 'DLOG' (2009, "Popup Arrow") {
	{40, 40, 115, 387},
	movableDBoxProc,
	visible,
	goAway,
	0x0,
	2009,
	"Popup Arrow",
	alertPositionParentWindow
	/****** Extra bytes follow... ******/
	/* $"7FFA 0001"                                          /* .ô.. */
};

resource 'DLOG' (2010, "Scroll Bar") {
	{40, 40, 130, 385},
	movableDBoxProc,
	visible,
	goAway,
	0x0,
	2010,
	"Scroll Bar",
	alertPositionParentWindow
	/****** Extra bytes follow... ******/
	/* $"7FFA 0001"                                          /* .ô.. */
};

resource 'DLOG' (2011, "Image Well") {
	{73, 97, 192, 459},
	movableDBoxProc,
	visible,
	goAway,
	0x0,
	2011,
	"Image Well",
	alertPositionParentWindow
	/****** Extra bytes follow... ******/
	/* $"7FFA 0001"                                          /* .ô.. */
};

resource 'DLOG' (2000, "Bevel Button") {
	{175, 44, 523, 496},
	1043,
	invisible,
	noGoAway,
	0x0,
	2000,
	"Bevel Button",
	alertPositionMainScreen
	/****** Extra bytes follow... ******/
	/* $"7FFA 0001"                                          /* .ô.. */
};

resource 'DLOG' (1000) {
	{40, 40, 356, 414},
	dBoxProc,
	visible,
	goAway,
	0x0,
	1000,
	"Standard Alert",
	alertPositionParentWindowScreen
};

resource 'DLOG' (2012, "Push Button") {
	{53, 43, 158, 406},
	movableDBoxProc,
	visible,
	goAway,
	0x0,
	2012,
	"Push Button",
	alertPositionParentWindowScreen
};

resource 'DLOG' (5000, "About Box") {
	{50, 91, 174, 459},
	1042,
	visible,
	goAway,
	0x0,
	5000,
	"",
	alertPositionParentWindowScreen
};

data 'DLOG' (1004) {
	$"0028 0028 00C6 0175 0000 0100 0100 0000"            /* .(.(.ê.u........ */
	$"0000 03EC 00"                                       /* ...œ. */
};

data 'DLOG' (6000) {
	$"0042 0034 0131 01E9 0400 0100 0100 0000"            /* .B.4.1.»........ */
	$"0000 1770 0B4D 6567 6120 4469 616C 6F67"            /* ...p.Mega Dialog */
};

data 'DLOG' (4000, "AutoSize Tester") {
	$"0028 0028 0088 0198 0412 0100 0100 0000"            /* .(.(.‡.Ú........ */
	$"0000 0FA0 00"                                       /* ...›. */
};

data 'DLOG' (7000) {
	$"0028 0028 00F0 0118 0416 0100 0100 0000"            /* .(.(.ï.......... */
	$"0000 1B58 00"                                       /* ...X. */
};

resource 'DLOG' (2014, "Edit Text") {
	{43, 40, 130, 394},
	movableDBoxProc,
	visible,
	goAway,
	0x0,
	2014,
	"Edit Text",
	alertPositionMainScreen
};

resource 'DLOG' (2015, "Static Text") {
	{43, 40, 131, 361},
	movableDBoxProc,
	visible,
	noGoAway,
	0x0,
	2015,
	"Static Text",
	alertPositionMainScreen
};

resource 'DLOG' (2016, "Slider") {
	{70, 84, 212, 289},
	movableDBoxProc,
	invisible,
	noGoAway,
	0x0,
	2016,
	"Slider",
	alertPositionMainScreen
};

data 'DLOG' (2017, "Clock") {
	$"004C 0074 00E8 0133 0005 0000 0000 0000"            /* .L.t.À.3........ */
	$"0000 07E1 0543 6C6F 636B"                           /* ...∑.Clock */
};

resource 'DLOG' (2018, "Tab") {
	{43, 40, 190, 391},
	movableDBoxProc,
	visible,
	noGoAway,
	0x0,
	2018,
	"Tab",
	alertPositionParentWindow
};

resource 'DLOG' (2013, "Check or Radio") {
	{40, 40, 136, 358},
	movableDBoxProc,
	invisible,
	goAway,
	0x0,
	2013,
	"",
	alertPositionParentWindowScreen
};

data 'DLOG' (2019, "ProxyPath dialog") {
	$"0028 0028 00C5 0134 0000 0100 0100 0000"            /* .(.(.â.4........ */
	$"0000 07E3 0F50 726F 7879 5061 7468 2073"            /* ...ì.ProxyPath s */
	$"7475 6666"                                          /* tuff */
};

resource 'DLOG' (1001) {
	{69, 135, 401, 548},
	noGrowDocProc,
	invisible,
	goAway,
	0x0,
	1001,
	"",
	noAutoCenter
	/****** Extra bytes follow... ******/
	/* $"0001"                                               /* .. */
};

data 'DLOG' (2020, "ThemeColorDialog") {
	$"006A 00AB 0132 019B 0000 0100 0100 0000"            /* .j.¥.2.ı........ */
	$"0000 07E4 1054 6865 6D65 436F 6C6F 7244"            /* ...î.ThemeColorD */
	$"6961 6C6F 67"                                       /* ialog */
};

resource 'DLOG' (3000) {
	{107, 74, 224, 535},
	dBoxProc,
	visible,
	noGoAway,
	0x0,
	3000,
	"",
	alertPositionMainScreen
};

resource 'wctb' (130) {
	{	/* array ColorSpec: 5 elements */
		/* [1] */
		wContentColor, 56797, 56797, 56797,
		/* [2] */
		wFrameColor, 0, 0, 0,
		/* [3] */
		wTextColor, 0, 0, 0,
		/* [4] */
		wHiliteColor, 0, 0, 0,
		/* [5] */
		wTitleBarColor, 65535, 65535, 65535
	}
};

resource 'dlgx' (2014) {
	versionZero {
		15
	}
};

resource 'dlgx' (2002) {
	versionZero {
		15
	}
};

resource 'dlgx' (2006) {
	versionZero {
		15
	}
};

resource 'dlgx' (2008) {
	versionZero {
		15
	}
};

resource 'dlgx' (2009) {
	versionZero {
		15
	}
};

resource 'dlgx' (2011) {
	versionZero {
		15
	}
};

resource 'dlgx' (2012) {
	versionZero {
		15
	}
};

resource 'dlgx' (1002) {
	versionZero {
		11
	}
};

resource 'dlgx' (2003) {
	versionZero {
		15
	}
};

resource 'dlgx' (2004) {
	versionZero {
		15
	}
};

resource 'dlgx' (2005) {
	versionZero {
		15
	}
};

resource 'dlgx' (6000) {
	versionZero {
		11
	}
};

resource 'dlgx' (4000) {
	versionZero {
		11
	}
};

resource 'dlgx' (7000) {
	versionZero {
		11
	}
};

resource 'dlgx' (2000) {
	versionZero {
		15
	}
};

resource 'dlgx' (2001) {
	versionZero {
		15
	}
};

resource 'dlgx' (281) {
	versionZero {
		15
	}
};

resource 'dlgx' (2007) {
	versionZero {
		15
	}
};

resource 'dlgx' (282) {
	versionZero {
		15
	}
};

resource 'dlgx' (2010) {
	versionZero {
		15
	}
};

resource 'dlgx' (283) {
	versionZero {
		15
	}
};

resource 'dlgx' (2015) {
	versionZero {
		15
	}
};

resource 'dlgx' (2016) {
	versionZero {
		15
	}
};

resource 'dlgx' (2017) {
	versionZero {
		15
	}
};

resource 'dlgx' (2018) {
	versionZero {
		15
	}
};

resource 'dlgx' (2013) {
	versionZero {
		15
	}
};

resource 'dlgx' (128) {
	versionZero {
		0
	}
};

resource 'dlgx' (1000) {
	versionZero {
		11
	}
};

resource 'dlgx' (1001) {
	versionZero {
		11
	}
};

data 'TMPL' (128, "tab#") {
	$"0756 6572 7369 6F6E 4457 5244 0E4E 756D"            /* .VersionDWRD.Num */
	$"6265 7220 6F66 2074 6162 734F 434E 5405"            /* ber of tabsOCNT. */
	$"2A2A 2A2A 2A4C 5354 4307 4963 6F6E 2049"            /* *****LSTC.Icon I */
	$"4444 5752 4408 5461 6220 4E61 6D65 5053"            /* DDWRD.Tab NamePS */
	$"5452 0952 6573 6572 7665 6431 4657 5244"            /* TRêReserved1FWRD */
	$"0952 6573 6572 7665 6432 464C 4E47 042A"            /* êReserved2FLNG.* */
	$"2A2A 2A4C 5354 45"                                  /* ***LSTE */
};

data 'TMPL' (129, "ldes") {
	$"0756 6572 7369 6F6E 4457 5244 0452 6F77"            /* .VersionDWRD.Row */
	$"7344 5752 4407 436F 6C75 6D6E 7344 5752"            /* sDWRD.ColumnsDWR */
	$"440B 4365 6C6C 2048 6569 6768 7444 5752"            /* D.Cell HeightDWR */
	$"440A 4365 6C6C 2057 6964 7468 4457 5244"            /* D.Cell WidthDWRD */
	$"0B56 6572 7420 5363 726F 6C6C 424F 4F4C"            /* .Vert ScrollBOOL */
	$"0C48 6F72 697A 2053 6372 6F6C 6C42 4F4F"            /* .Horiz ScrollBOO */
	$"4C07 4C44 4546 2049 4444 5752 4408 4861"            /* L.LDEF IDDWRD.Ha */
	$"7320 4772 6F77 424F 4F4C"                           /* s GrowBOOL */
};

resource 'ldes' (6004, purgeable) {
	versionZero {
		0,
		1,
		0,
		0,
		hasVertScroll,
		noHorizScroll,
		0,
		noGrowSpace
	}
};



resource 'xmnu' (131, purgeable) {
	versionZero {
		{	/* array ItemExtensions: 10 elements */
			/* [1] */
			dataItem {
				0,
				0x0,
				0,
				0,
				0,
				noHierID,
				sysFont,
				naturalGlyph
			},
			/* [2] */
			dataItem {
				0,
				0x0,
				0,
				0,
				0,
				noHierID,
				sysFont,
				naturalGlyph
			},
			/* [3] */
			dataItem {
				0,
				0x0,
				0,
				0,
				0,
				noHierID,
				sysFont,
				naturalGlyph
			},
			/* [4] */
			dataItem {
				0,
				0x0,
				0,
				0,
				0,
				noHierID,
				sysFont,
				naturalGlyph
			},
			/* [5] */
			dataItem {
				0,
				0x0,
				0,
				0,
				0,
				noHierID,
				sysFont,
				naturalGlyph
			},
			/* [6] */
			dataItem {
				0,
				0x0,
				0,
				0,
				0,
				noHierID,
				sysFont,
				naturalGlyph
			},
			/* [7] */
			dataItem {
				0,
				0x0,
				0,
				0,
				0,
				noHierID,
				sysFont,
				naturalGlyph
			},
			/* [8] */
			dataItem {
				0,
				0x0,
				0,
				0,
				0,
				noHierID,
				sysFont,
				naturalGlyph
			},
			/* [9] */
			dataItem {
				0,
				0x0,
				0,
				0,
				0,
				noHierID,
				sysFont,
				naturalGlyph
			},
			/* [10] */
			dataItem {
				0,
				0x0,
				0,
				0,
				0,
				noHierID,
				sysFont,
				naturalGlyph
			}
		}
	}
};

data 'ckid' (128, "Projector") {
	$"CBE5 A1F3 3FE5 3230 0004 0000 0000 0000"            /* ¿¬∞€?¬20........ */
	$"0000 B1BE 808A B1BE 808A B03D 7745 0037"            /* ..±Êƒ‰±Êƒ‰É=wE.7 */
	$"3267 0001 0011 0019 2548 6172 6D6F 6E79"            /* 2g......%Harmony */
	$"5472 7574 6850 726F 6ABA 2853 616D 706C"            /* TruthProjÜ(Sampl */
	$"6543 6F64 6529 BA53 6F75 7263 65BA 0007"            /* eCode)ÜSourceÜ.. */
	$"4564 2056 6F61 7300 0232 3100 1541 7070"            /* Ed Voas..21..App */
	$"6561 7261 6E63 6553 616D 706C 652E 7273"            /* earanceSample.rs */
	$"7263 0000 0000 7B52 656D 6F76 6520 434E"            /* rc....{Remove CN */
	$"544C 2032 3437 2066 726F 6D20 7468 6520"            /* TL 247 from the  */
	$"2E72 7372 6320 6669 6C65 2C20 6173 2069"            /* .rsrc file, as i */
	$"7420 6861 7320 6265 656E 206D 6F76 6564"            /* t has been moved */
	$"2074 6F20 7468 6520 2E72 2066 696C 652C"            /*  to the .r file, */
	$"2074 6F20 6669 7820 7468 6520 7072 6F63"            /*  to fix the proc */
	$"4944 2074 6F20 6B43 6F6E 7472 6F6C 4564"            /* ID to kControlEd */
	$"6974 5465 7874 5061 7373 776F 7264 5072"            /* itTextPasswordPr */
	$"6F63 00"                                            /* oc. */
};
