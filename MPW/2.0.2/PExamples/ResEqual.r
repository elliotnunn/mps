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

resource 'cmdo' (355) {
	{
		240,
		"ResEqual compares the resources in two files and reports the differences.",
		{
			NotDependent {}, Files {
				InputFile,
				RequiredFile {
					{40, 40, 60, 190},
					"Resource File 1",
					"",
					"Select the first file to compare.",
				},
				Additional {
					"",
					FilterTypes,
					"Only applications, DA’s, and tools",
					"All files",
					{
						appl,
						tool,
						da
					}
				}
			},
			Or {{1}}, Files {
				InputFile,
				RequiredFile {
					{70, 40, 90, 190},
					"Resource File 2",
					"",
					"Select the second file to compare.",
				},
				Additional {
					"",
					FilterTypes,
					"Only applications, DA’s, and tools",
					"All files",
					{
						appl,
						tool,
						da
					}
				}
			},
			NotDependent {}, TextBox {
				gray,
				{30, 35, 95, 195},
				"Files to Compare"
			},
			NotDependent {}, CheckOption {
				NotSet,
				{105, 75, 121, 155},
				"Progress",
				"-p",
				"Write progress information to diagnostic output."
			},
			NotDependent {}, Redirection {
				StandardOutput,
				{40, 300}
			},
			NotDependent {}, Redirection {
				DiagnosticOutput,
				{80, 300}
			},
			NotDependent {}, TextBox {
				gray,
				{30, 295, 121, 420},
				"Redirection"
			},
			Or {{2}}, DoItButton {
			},
		}
	}
};

