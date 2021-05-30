/****************************************************************************/
/*																			*/
/*                      ResEqual Commando Resources                         */
/*																			*/
/*																			*/
/*                   Copyright Apple Computer, Inc. 1987                    */
/*                           All rights reserved.                           */
/*																			*/
/****************************************************************************/

#include "cmdo.r"

resource 'cmdo' (355, "Resequal") {
	{	/* array dialogs: 1 elements */
		/* [1] */
		260,
		"Compare the resources in two files.",
		{	/* array itemArray: 5 elements */
			/* [1] */
			NotDependent {

			},
			Files {
				InputFile,
				{20, 105, 40, 145},
				{20, 145, 40, 360},
				"File1:",
				"",
				"",
				"",
				"Select the first file to be compared",
				dim,
				"Input file MUST be specified.",
				"",
				"",
				Additional {
					"",
					"",
					"",
					"",
					{	/* array TypesArray: 0 elements */
					}
				}
			},
			/* [2] */
			NotDependent {

			},
			Files {
				InputFile,
				{50, 105, 70, 145},
				{50, 145, 70, 360},
				"File2:",
				"",
				"",
				"",
				"Select the second file to be compared.",
				dim,
				"Input file MUST be specified.",
				"",
				"",
				Additional {
					"",
					"",
					"",
					"",
					{	/* array TypesArray: 0 elements */
					}
				}
			},
			/* [3] */
			NotDependent {

			},
			CheckOption {
				NotSet,
				{120, 200, 140, 280},
				"Progress",
				"-p",
				"Write progress information to Diagnostic"
				" Output."
			},
			/* [4] */
			NotDependent {

			},
			Redirection {
				StandardOutput,
				{80, 60}
			},
			/* [5] */
			NotDependent {

			},
			Redirection {
				DiagnosticOutput,
				{80, 300}
			}
		}
	}
};

