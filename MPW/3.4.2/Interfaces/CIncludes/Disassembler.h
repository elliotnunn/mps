/*---------------------------------------------------------------------------*
 |                                                                           |
 |                          <<< Disassembler.h >>>                           |
 |                                                                           |
 |                     Power[PC] Disassembler Interfaces                     |
 |                                                                           |
 |                               Ira L. Ruben                                |
 |                                  5/9/93                                   |
 |                                                                           |
 |                  Copyright Apple Computer, Inc. 1993-1995                 |
 |                           All rights reserved.                            |
 |                                                                           |
 *---------------------------------------------------------------------------*/

#ifndef __DISASSEMBLER__
#define __DISASSEMBLER__

#if 0
#define DisHdrVersion "2.0"                /* Current version nbr.rev of this header		*/
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __TYPES__													/* private (normally predefined) types...			*/
typedef unsigned char Boolean;
enum {false, true};
#endif


/* All assembler options are of type DisassemblerOptions:																*/

typedef unsigned long DisassemblerOptions;

/* The following defines the "options" that can be passed to the disassembler.  All			*/
/* except ONE of the target architecture options have preset defaults.									*/

																						/* Target architecture (one must be set):		*/
#define Disassemble_Power			 0x00000001UL	/*    Power																	*/
#define Disassemble_PowerPC32	 0x00000002UL	/*       32-bitPowerPC											*/
#define Disassemble_PowerPC64  0x00000004UL	/*          64-bit PowerPC 									*/
#define Disassemble_PowerPC601 0x00000008UL	/*             PowerPC 601									*/
																						/* Error detection options:         				*/
#define Disassemble_RsvBitsErr 0x80000000UL	/*    invalid reserved bits is error				*/
#define Disassemble_FieldErr	 0x40000000UL	/*    invalid field (regs, BO, etc.) error	*/
																						/* Formatting options (reverses presets):		*/
#define Disassemble_Extended	 0x08000000UL	/*    extended mnemonics (ppc only)					*/
#define Disassemble_BasicComm	 0x04000000UL	/*    basic form in comment if extended			*/
#define Disassemble_DecSI			 0x02000000UL	/*    SI fields formatted as decimal				*/
#define Disassemble_DecUI			 0x01000000UL	/*    UI fields formatted as decimal				*/
#define Disassemble_DecField	 0x00800000UL	/* 		fields shown as decimal								*/
#define Disassemble_DecOffset	 0x00400000UL	/*    D of D(RA) shown in decimal						*/
#define Disassemble_DecPCRel	 0x00200000UL	/*    $+decimal offset instead of $+hex			*/
#define Disassemble_DollarHex	 0x00100000UL	/*    $XXX... instead of 0xXXX...						*/
#define Disassemble_Hex2sComp	 0x00080000UL	/* 		negative hex shown in 2s compliment		*/
#define Disassemble_MinHex		 0x00040000UL	/*		min nbr of hex digits for values >= 0	*/
#define Disassemble_CRBits		 0x00020000UL	/*    crN_LT, crN_GT, crN_EQ, crN_SO				*/
#define Disassemble_CRFltBits  0x00010000UL	/*		crN_FX, crN_FEX, crN_VX, crN_OX				*/
#define Disassemble_BranchBO	 0x00008000UL	/*		branch BO meaning if not extended			*/
#define Disassemble_TrapTO	 	 0x00004000UL	/*		trap TO meaning if not extended				*/
#define Disassemble_IBM				 0x00002000UL	/*    IBM assembler conventions							*/
																																												/*
Except for the target architecture options, ONE of which must be set, here's an explanation
of the other options and their preset default.
	 
Disassemble_RsvBitsErr - Reserved bits in PowerPC instructions are considered a "warning"
												 and causes the return status to be set to indicate whether
												 reserved bits were incorrectly coded (1's that should be 0's and
												 vice versa). The option indicates incorrectly coded reserved bits
												 cause the instruction to be treated as "invalid".

Disassemble_FieldErr	 - Attempted use of a field value not valid for a target is
												 considered a "warning" and causes the return status to be set to
												 indicate that fact.  The option indicates that use of a field
												 whose value is not valid for the target is "invalid".  An example
												 of an invalid field would be the use of a SPR not supported for
												 the target architecture like the "HIDx" SPRs which are only valid
												 for the 601.  Another example is non zero bits in the bc[l][a] BO
												 field that are supposed to be zero.  Note this is NOT the same as
												 Disassemble_RsvBitsErr.  But if a field has NO valid decoding
												 value for ANY target, that is always considered as an invalid
												 instruction.

Disassemble_Extended	 - Extended mnemonics are NOT generated.  The option allows the
												 extended mnemonic generation (recommended).  Only PowerPC32,
												 PowerPC64, and PowerPC32 and PowerPC64 instructions used on the
												 601 are supported.

Disassemble_BasicComm	 - The basic instruction form is NOT placed in the comment field.
												 The option causes the basic form of the instruction to be placed
												 in the comment if an extended mnemonic is generated for it.  This
												 option is not recommended since it is mainly for debugging and it
												 tends to "clutter" up the comment field making it harder to see
												 branch addresses.

Disassemble_DecSI			 - SIs (signed immediate integers) are formatted as hex.  The option
												 causes SI operands to be generated as decimal integers.

Disassemble_DecUI			 - UIs (unsigned immediate integers) are formatted as hex.  The
												 option causes UI operands to be generated as decimal integers.

Disassemble_DecField	 - All fields (e.g., shift/rotate constants) are shown as hex.  The
												 option causes the offsets to be generated as decimal integers.

Disassemble_DecOffset  - The "D" offsets in operands of the form D(RA) are shown in hex.
												 The option causes these to be generated as decimal.

Disassemble_DecPCRel	 - PC-relative branch addresses are formatted as "$+n" or "$-n", with
												 the offset ("n") generated in hex.  The option causes the offset
												 to be generated as decimal.

Disassemble_DollarHex	 - Hex values are prefixed with "0x".  The option causes hex values
												 to be formatted as "$XXX...".

Disassemble_Hex2sComp	 - Signed negative values that are shown in hex are negated and
												 prefixed with a "-" (e.g. "-0x0001").  The option causes these
												 values to be shown in their two's complement form (e.g.,
												 "0xFFFFFFFF").

Disassemble_MinHex		 - Positive hex values or negated negative values are always shown
												 with the number of digits attempting to indicate the size of the
												 instruction field which produced the value or the implied value
												 size.  Thus 32-bit target addresses are shown as 8 hex digits,
												 16-bit field values are shown with 4 hex digits, byte field values
												 as 2 hex digits.  5 or six-bit values are also shown as 2 hex
												 digits since the minimum is always at least 2. The option forces
												 the generation to always use 2 as the minimum even if the value
												 came from a bigger field (e.g., "0x1234" address, "0x01" or
												 "-0x01" from a 16-bit field).

Disassemble_CRBits 		 - Condition register field bits are referenced as bit numbers 0:31
												 in the basic instruction operand forms.  The option causes these
												 bits to be referenced using the format “crN_X”, where N is a 4-bit
												 CR field (0:7) and X is the bit “name” in the field (“LT”, “GT”,
												 “EQ”, “SO” for bits 0, 1, 2, and 3 respectively).  Note, this
												 notation is always used with extended mnemonics.

Disassemble_CRFltBits  - Condition register field bits are referenced as bit numbers 0:31
												 in the basic instruction operand forms.  The option is identical
												 to Disassemble_CRBits to generate the references as “crN_X”,
												 except that the bits (X) are referenced as “FX”, “FEX”, “VX” and
												 “OX” for the four bits 0,1, 2, and 3 respectively.  This option
												 can be used if the context of floating-point operations, but it's
												 up to the caller to determine that context.

Disassemble_BranchBO	 - Branch test BO encodings are referenced as values 0:31 in the 
												 basic instruction operand forms.  The option causes the BO value
												 to be referenced as more meaningful names (e.g., "dCTR_NZERO_NOT",
												 "ALWAYS", etc.).
												 
Disassemble_TrapTO		 - Trap TO operand encodings are referenced as values 0:31 in the 
											 	 basic instruction operand forms.  The option causes the TO value
												 to be an expression of the form "x|y|...", where the "x", "y",
												 and so are the meaning of each of the five TO bits; "LT", "GT",
												 "EQ", "LOW", "HI" for bits 0, 1, 2, 3, and 4 respectively.

Disassemble_IBM				 - Apple assembler conventions are used for comments and invalid
												 instructions.  The option causes IBM assembler conventions to be
												 used for these.  A “#” is used instead of a “;” as the comment
												 character, and “.long” is used instead of “dc.l” for the invalid
												 instruction directive mnemonic.

	                              [Are we having fun yet?]																*/

/* The following defines a set of the above options which seem to give "acceptable" 		*/
/* results:																																							*/

#define DisStdOptions (Disassemble_Extended  |			/* permit extended mnemonics				*/\
                       Disassemble_DecSI     |			/* decimal SIs but hex UIs					*/\
                       Disassemble_DecField  |			/* decimal field numbers						*/\
                       Disassemble_BranchBO  |			/* meaning of branch BO							*/\
											 Disassemble_TrapTO		 |			/* meaning of trap TO								*/\
											 Disassemble_CRBits)					/* CR bits references as crN_X			*/
											 

/* The optional lookup function (NULL could be passed) is used to allow the caller to		*/
/* substitute name strings for various objects that can occur in an operand.  It should	*/
/* return a pointer to a non-null string if substitution is desired.  If NULL or a null */
/* string is returned, the disassembler uses its own default names.  The following			*/
/* defines the possible substitable objects:																						*/

typedef enum {															/* Types of substitutable objects:					*/
	Disassembler_Lookup_GPRegister,						/*			general purpose register						*/
	Disassembler_Lookup_FPRegister,						/*			floating point register							*/
	Disassembler_Lookup_UImmediate,						/*			unsigned immediate value						*/
	Disassembler_Lookup_SImmediate,						/*			signed (32-bit) immediate value			*/
	Disassembler_Lookup_AbsAddress,						/*			absolute addresse										*/
	Disassembler_Lookup_RelAddress,						/*			relocatable addresse								*/
	Disassembler_Lookup_RegOffset,						/*			offset from a base register					*/
	Disassembler_Lookup_SPRegister						/*			special purpose register						*/
} DisassemblerLookupType;

/* Here's a definition of an object (value) which is a function of each 								*/
/* DisassemblerLookupType:																															*/

union DisLookupValue {											/* A "meaningful" name for each value type:	*/
	unsigned long gpr;												/*		Disassembler_Lookup_GPRegister				*/
	unsigned long fpr;												/*		Disassembler_Lookup_FPRegister				*/
	unsigned long ui;													/*		Disassembler_Lookup_UImmediate				*/
	long					si;													/*		Disassembler_Lookup_SImmediate				*/
	long					absAddress;									/*		Disassembler_Lookup_AbsAddress				*/
	long					relAddress;									/*		Disassembler_Lookup_RelAddress				*/
	unsigned long	spr;												/* 		Disassembler_Lookup_SPRegister				*/
	struct {																	/*		Disassembler_Lookup_RegOffset					*/
		short 				 offset;
		unsigned short baseReg;
	} regOffset;
};
typedef union DisLookupValue DisLookupValue, *DisLookupValuePtr;

/* The "lookup" substitution routine for the above objects is defined as below.					*/

/*                               WARNING and CAUTION																		*/

/* This routine MUST be defined as a C function, not a C++ member function.  The reason	*/
/* for this is that the disassembler is built using a C compiler.  Some compilers (for 	*/
/* example, SC and SCpp) have different calling conventions for C and C++. Further, for */
/* C++ member functions there is the additional "this" pointer which obviously is not 	*/
/* passed to the callback routine.																											*/

typedef char *(*DisassemblerLookups)(void 												*refCon,
																		 const unsigned long 			 		*cia, 
																		 const DisassemblerLookupType lookupType,
																		 const DisLookupValue 	 			thingToReplace);

/* where, refCon 				 = A "reference constant" that can be used as a communication link
													 between the lookup routine and the caller of the disassembler.
													 It is the same refCon passed to the disassembler.

					cia 	 				 = The instruction address passed to the disassembler.

					lookupType and
					thingToReplace = The kind of object and the associated value of that object to be
													 replaced.  As defined by DisLookupValue, the thingToReplace has
													 the following value for each lookupType.

													 lookupType												value			
													 ============================================= 
													 Disassembler_Lookup_GPRegister		0:31				
													 Disassembler_Lookup_FPRegister		0:31				
													 Disassembler_Lookup_UImmediate		integer	
													 Disassembler_Lookup_SImmediate		integer		
				                   Disassembler_Lookup_AbsAddress		address [1]
													 Disassembler_Lookup_RelAddress		address [2]
													 Disassembler_Lookup_RegOffset		D + Ra  [3]
													 Disassembler_Lookup_SPRegister		spr			[4]
													 =============================================

	 												 Notes: 
													 
													 [1] This is an absolute target branch address, i.e., the "a" bit
													 		 in the branch instruction IS set.  The passed absAddress
															 is the address contained in the instruction.
															 
													 [2] This is a relocatable target branch address, i.e., the "a"
													 		 bit in the branch instruction was NOT set.  The relAddress
															 is relative to the current instruction address adjusted
															 by the dstAdjust.  Thus,
															 
															 relAddress = destinationAddress + dstAdjust + cia
															 
															 where cia is the current instruction address, i.e, the value
															 of the instruction address passed to the disassembler.
																			
													 [3] Both the offset (D) and base register (Ra) are passed.  The
													 		 DisLookupValue.regOffset value defines how they are packed
															 in the thingToReplace.  The offset should be assigned to a
															 long to get its true 32-bit value.  It is valid to pass it
															 as a signed short since the instruction field from which it
															 came is never more than 16 bits wide.
													 
													 [4] The lookup for SPRs is slightly different in that it is only
													 		 done as an ESCAPE mechanism, i.e., only when the SPR number is
															 NOT one of the predefined Power, 601, PowerPC32, or
															 PowerPC64 SPR names.  This is done because a different
															 PowerPC architectures can have additional SPRs specific to
															 those architectures!  The lookup routine is called only if
															 the SPR is NOT one of the following predefined numbers:
																	
																0 MQ      272 SPRG0   528 IBAT0U   536 DBAT0U   1008 HID0
																1 XER     273 SPRG1   529 IBAT0L   537 DBAT0L   1009 HID1
																4 RTCU    274 SPRG2   530 IBAT1U   538 DBAT1U   1010 IABR
																5 RTCL    275 SPRG3   531 IBAT1L   539 DBAT1L   1013 DABR
																6 DEC     280 ASR     532 IBAT2U   540 DBAT2U   1023 PIR
																8 LR      282 EAR     533 IBAT2L   541 DBAT2L
																9 CTR     284 TB      534 IBAT3U   542 DBAT3U
															 18 DSIAR   285 TBU     535 IBAT3L   543 DBAT3L
															 19 DAR     287 PVR
															 22 DEC
															 25 SDR1
															 26 SRR0
															 27 SRR1
															
															 Not all of these SPRs are valid for all targets.  The
															 disassembler will check to see if these SPRs are valid for
															 the specified target architecture.  If they are not, the SPR
															 number is treated as an invalid field and processed
															 according to the Disassemble_FieldErr option, i.e., it’s
															 accepted but returns a status warning, or the instruction is
															 treated as invalid (“DC.L 0xXXXXXXXX”).

															 SPR numbers which are not on the list, and also do not have
															 a lookup substitution name, are always accepted.  But since
															 there is no way for the disassembler to validate these
															 against the target, the Disassembler_InvSprMaybe return
															 status flag will be set.																	*/
															 

/* Finally, at long last, here's the definition of the disassembler...									*/

typedef unsigned short DisassemblerStatus;		/* disassembler return status (see below)	*/

DisassemblerStatus ppcDisassembler(unsigned long  		 *instruction, 
																	 long 						   dstAdjust,
																	 DisassemblerOptions options,
																	 char								 *mnemonic,
																	 char								 *operand,
																	 char								 *comment,
																	 void								 *refCon,
																	 DisassemblerLookups lookupRoutine);
	/*
	Takes the four bytes pointed to by instruction and disassembles it, placing the mnemonic,
	operand, and comment in the strings provided.  The caller is then free to format or use
	the output strings any way appropriate to the application.  Any of these strings may be a
	null pointer, in which case that portion of the disassembled instruction is not returned.
	If they are not null, it is ASSUMED that the associated buffers are large enough to hold
	the disassembled output.
	
	Comments are formatted starting with a "; " (or "#" if the appropriate "IBM" option is
	set).  Invalid instructions generate a "dc.l" (".long" for IBM), an operand of the form
	0xXXXXXXXX showing the actual instruction, and a comment with a message indicating what
	is wrong with the instruction.
	
	For PC-relative branches, the comment generated is the destination address, the only
	address that the disassembler "knows" about is the address of the code pointed to by the
	instruction.  Generally, that may be a buffer that has no relation to "reality", i.e.,
	the actual code loaded into the buffer.  Therefore, to allow the address comment to be
	mapped back to some actual address, the caller may specify an adjustment factor,
	specified by dstAdjust that is ADDED to the value that normally would be placed in the
	comment.
 
	Many operands usually consist of registers, absolute and relocatable addresses, and
	signed and unsigned values.  In places where these occur, the disassembler can call a
	user specified routine to do the substitution using the lookupRoutine parameter if it
	is not NULL.  A "refcon" is passed to the disassembler that is, in turn, passed on to
	the lookup routine to allow a communication path between the disassembler caller and its
	lookup routine.  The refcon can be anything.  The disassembler does not look at it.
	
	The caller also can control some aspects of the formatting with the DisassemblerOptions
	as described above.  The options also specify the target architecture; Power, PowerPC32,
	PowerPC64, or PowerPC601.
	
	The disassembler returns as its function result the DisassemblerStatus.  This may be
	tested for 0 ("false" or DisInvalid defined below) to find out if an invalid instruction
	was detected.  For valid instructions, the DisassemblerStatus is non zero and indicates
	various attributes about the instruction as follows:																	*/
	
	/* Return status flags:																																*/
	
	#define Disassembler_OK 					0x0001U	/* instruction successfully decoded					*/
	#define Disassembler_InvRsvBits 	0x0002U	/* invalidly coded reserved bits						*/
	#define Disassembler_InvField 		0x0004U	/* invalidly coded field(s)									*/
	#define Disassembler_InvSprMaybe	0x0008U	/* possibly invalid SPR											*/
	#define Disassembler_601Power		  0x0010U	/* power instruction used with 601					*/
	#define Disassembler_Privileged   0x0020U	/* privileged instruction										*/
	#define Disassembler_Optional 		0x0040U	/* optional instruction											*/
	#define Disassembler_Branch				0x0080U	/* branch instruction												*/
	#define Disassembler_601SPR				0x0100U	/* SPR valid only for 601 has been used			*/
	#define Disassembler_HasExtended  0x4000U	/* possible extended mnemonic								*/
	#define Disassembler_ExtendedUsed 0x8000U	/* the extended mnemonic was generated			*/
 
	#define DisInvalid ((DisassemblerStatus)0x0000U)	/*       invalid instruction				*/

	/*
	Unless DisInvalid (0) is returned as the function result, Disassembler_OK will always be
	set.  The other flags have the following meaning:
	
	Disassembler_InvRsvBits		- The instruction had some or all of its reserved bits
															incorrectly coded, and the Disassemble_RsvBitsErr option was
															NOT set.  This is something like a "warning". With the option
															set, this condition is considered as an "error" and the
															"invalid instruction" is generated ("dc.l 0xXXXXXXXX").
	
	Disassembler_InvField			-	The instruction had fields incorrectly coded for the
															target, but is is still valid for some target (e.g., not
															valid for the 601 but valid for the PowerPC64), and the
															Disassemble_FieldErr option was NOT set.
	
	Disassembler_InvSprMaybe	- A mfspr or mtspr instruction references a POSSIBLY invalid
															SPR.  This occurs when an SPR value is not for one of the
															predefined SPR names (see list above) and there is no lookup
															routine, or it does not supply a substitution name.  In that
															case the SPR register number is generated.  Since there is
															no way of the disassembler knowing whether the register is
															valid for the architecture of interest, this flag is set 
															instead of Disassembler_InvField to indicate the possibility
															that the SPR may be invalid.
	
	Disassembler_601Power			- The options specified that the target architecture is the
															601 (Disassemble_PowerPC601), and a Power instruction was
															disassembled.  The 601 is basically an ORing of the Power
															and PowerPC32 architectures.  But this flag could be useful
															for "weeding" Power instructions out in preparation for use
															on a "pure" PowerPC32 or PowerPC64 architecture.
	
	Disassembler_601SPR				- The options specified that the target architecture is the
															601 (Disassemble_PowerPC601), and a mfspr or mtspr
															instruction references a SPR valid ONLY for the 601.
															
	Disassembler_Privileged		- The instruction is privileged.
															
	Disassembler_Optional			- The instruction is optional.
	
	Disassembler_Branch				-	Branch instruction; bc[l][a], b[l][a], bclr[l], bcctr[l] and
															Power bcr[l], bcc[l].  If any of these instructions are
															processed the flag is set.  Branches are signaled because
															the caller might want to do some additional processing on
															these.  For example, a debugger might want to dynamically
															show which way the branch is taken, or static analysis might
															want to know possible exit points from a function or show
															the branch in some graphical way.  Although the caller could
															determine if the instruction is a branch, the disassembler
															always has to classify the instructions passed to it, so
															there is no sense having both do it if the information is
															already available.  Note, the caller might still, however,
															need to extract the BO and BI fields to determine the
															condition of the branch, but at least it only needs to be
															done when the flag is set.
	
	Disassembler_HasExtended 	- The instruction POSSIBLY has an extended mnemonic, whether
															used or not used (as a function of the Disassemble_Extended
															option). Note, "possibly has an extended mnemonic"; the
															instruction could have extendeds, but not for all
															values of its operands.
															
	Disassembler_ExtendedUsed - The instruction has an extended mnemonic, and it was used
															because the option (Disassemble_Extended) permits it.  The
															operand is formatted appropriate to the extended mnemonic.
															Whether the original basic form is placed in the comment or
															not is controlled by the Disassemble_BasicComm option.
	*/
	
	
/* NOTES: 1. The disassembler library uses the convention that, with the exception of 	*/
/*					 the called routine name itself, i.e., "ppcDisassembler", all externally 		*/
/*					 visible names (linker symbols and macro names) begin with the letters "dis"*/
/* 					 (in any case).  The user should keep this in mind to avoid possible name 	*/
/* 					 conflicts.																																	*/

/*				2. Except for statically declared (read only) tables, the disassembler uses no*/
/*					 other global data.																													*/

/*				3. The disassembler is fully self contained in that it has no explicit 				*/
/*					 references to any runtime library routines (e.g., strcpy).  There may, 		*/
/*					 however, be implicit references generated by the (C) compiler.							*/

/*				4. The disassembler is written in standard ANSI C making it possible to easily*/
/*					 port to other platforms.																										*/


#ifdef __cplusplus
}
#endif

#endif
