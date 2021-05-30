Instructions.c	-  Instructions for C Examples

Copyright Apple Computer, Inc. 1986
All rights reserved.



Instructions for C Examples


   Note: For more information about building the sample programs, see
   Chapter 1 of the MPW Reference manual.

   The files used to create all of the following example programs are in
   the folder "CExamples".	Depending on the configuration of your machine,
   you must select and execute one of the following commands to change the
   directory to the correct folder.

	  Directory "{MPW}CExamples"	# for HD-20 configurations
	  Directory "{Boot}"			# for Macintosh XL
	  Directory "C:CExamples"		# for 800K disks

   (To execute the command select it and press Enter.)



Sample - The Inside Macintosh Sample Application


   The Sample application is discussed in Inside Macintosh, Volume I.
   The instructions below compile, create the resources, and link
   Sample.	Select and enter the commands to execute them.

	  C Sample.c
	  Rez Sample.r -o Sample
	  Link Sample.c.o  ∂
		 "{CLibraries}"CRuntime.o ∂
		 "{CLibraries}"CInterface.o ∂
		 -o Sample


   To execute Sample, simply select and enter its name.

	 Sample


   Make can be used to rebuild Sample after modifying Sample.c or Sample.r.
   The file MakeFile.c contains the commands for creating the C version 
   of Sample, as well as the other C examples. Execute the Make command 
   below to see these commands, then execute the commands themselves.

	  Make -f MakeFile.c Sample

	
   Note that if Sample.c and Sample.r haven't been modified since Sample
   was built, Make won't generate any commands, since Sample is up-to-date.



Count - A Sample MPW Tool


	Count is a tool that runs in the MPW environment.  A version of Count
	is included with MPW, and is documented in Chapter 9 of the MPW
	Reference manual. The file MakeFile.c contains the commands for creating
	the C version of Count. Execute the following Make command to see these 
	commands, then execute the commands themselves.

	  Make -f MakeFile.c Count


   To test Count, try counting the characters in file Count.c.

	  Count -c Count.c



Memory - A Sample Desk Accessory


   Memory is a sample desk accessory written in C.	To build this desk
   accessory, execute the following Make command and then execute its output.

	  Make -f MakeFile.c  Memory


   The build process puts the desk accessory into a Font/DA Mover file.
   To install the Memory desk accessory, use the Font/DA Mover to copy
   resource Memory from the file Memory into the System file.  If the
   Font/DA Mover is in your Applications folder, the following command
   will run it from MPW.

	 "Font/DA Mover" "{SystemFolder}"System Memory


   After quitting the Font/DA Mover and returning to the MPW Shell, select
   "Memory" from the Apple menu.  It displays the available memory in the
   application and system heaps, and on the boot disk.
