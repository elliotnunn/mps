Instructions.p	-  Instructions for Pascal Examples

Copyright Apple Computer, Inc. 1986
All rights reserved.



Instructions for Pascal Examples


   Note: For more information about building the sample programs, see
   Chapter 1 of the MPW Reference manual.

   The files used to create all of the following example programs are in
   the folder "PExamples".	Depending on the configuration of your machine,
   you must select and execute one of the following commands to change the
   directory to the correct folder.

	  Directory "{MPW}PExamples"	   # for HD-20 configurations
	  Directory "{Boot}"			   # for Macintosh XL
	  Directory "Pascal:PExamples"	   # for 800K disks

   (To execute the command select it and press Enter.)



Sample - The Inside Macintosh Sample Application


   The Sample application is discussed in Inside Macintosh, Volume I.
   The instructions below compile, create the resources, and link
   Sample.	Select and enter the commands to execute them.

	  Pascal Sample.p -o Sample.p.o
	  Rez Sample.r -o Sample
	  Link Sample.p.o ∂
		  "{Libraries}"Interface.o ∂
		  "{Libraries}"Runtime.o ∂
		  "{PLibraries}"Paslib.o ∂
		  -o Sample


   To execute Sample, simply select and enter its name.

	 Sample


   Make can be used to rebuild Sample after modifying Sample.p or Sample.r.
   The file MakeFile.p contains the commands for creating the Pascal
   version of Sample, as well as the other Pascal examples. Execute the 
   Make command below to see these commands, then execute the commands
   themselves.

	  Make -f MakeFile.p Sample


   Note that if Sample.p and Sample.r haven't been modified since Sample
   was built, Make won't generate any commands, since Sample is up-to-date.
		
	

ResEqual - A Sample MPW Tool

   ResEqual is a sample MPW tool that compares resource files.
   The file MakeFile.p contains the commands for compiling and linking
   ResEqual. Execute the following Make command to see these commands,
   then execute the commands themselves.

	  Make -f MakeFile.p ResEqual


   To execute ResEqual, enter its name, the name of two files to compare,
   and the -p option to display progress information.  Assuming you've 
   already built the Sample application, rebuild the non-CODE resources
   for Sample using Rez, then compare the two resource files, as follows:


	  Rez Sample.r -o Sample.rsrc
	  ResEqual -p Sample Sample.rsrc



Memory - A Sample Desk Accessory


   Memory is a sample desk accessory written in Pascal.  To build this desk
   accessory, execute the following Make command and then execute its output.

	  Make -f MakeFile.p Memory


   The build process puts the desk accessory into a Font/DA Mover file.
   To install the Memory desk accessory, use the Font/DA Mover to copy
   resource Memory from the file Memory into the System file.  If the
   Font/DA Mover is in your Applications folder, the following command
   will run it from MPW.

	 "Font/DA Mover" "{SystemFolder}"System Memory


   After quitting the Font/DA Mover and returning to the MPW Shell, select
   "Memory" from the Apple menu.  It displays the available memory in the
   application and system heaps, and on the boot disk.



ResXXXX - A Sample Resource Editor


   MakeFile.p also contains the commands for building "ResXXXX", a
   supplemental resource editor for ResEdit. Execute the following Make 
   command to see these commands, then execute the commands themselves.

	  Make -f MakeFile.p ResXXXX


   To use the ResXXXX editor, execute ResEdit by selecting its name
   and pressing Enter.	In ResEdit, open the files ResXXXX and ResEdit, 
   and copy the RSSC resource from ResXXXX and paste it into ResEdit.

	  ResEdit
