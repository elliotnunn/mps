/************************************************************

    XCOFF.h
    Definitions of constants and types used to read and
		write object files in the XCOFF format.

    Copyright Apple Computer,Inc.  1996
    All rights reserved

************************************************************

 This header defines the entire XCOFF file layout. It is based on the PowerOpen Application
 Binary Interface document and the IBM AIX headers. The field names are generally the same
 but others are introduced for PowerPC enhancements or where it makes sense to do so.  
 
 Many of the names are generally the same as those described in
 "Understanding and Usign COFF", A Nutshell Handbook, by O'Reilly & Associates.
 
 Here's a diagram of an XCOFF file described by this header:
 
																			XCOFF File Format

				 Composite Header     |-------------------------------|
														  |          File Header          |   20 bytes
														  |...............................|
														  |  Auxiliary Header (optional)  |
														  |_______________________________|
				.text, .data, .bss,   |        Section header 1       |   40 bytes/header
				.loader, .debug,      |...............................|
				.except, .typchk      |             _ _ _             |
				.info, .pad, .ovrflo  |...............................|
														  |        Section header N       |
														  |_______________________________|
				 "Raw data" is actual |       Raw data section 1      |
				 data corresponding   |...............................|
				 to section headers   |             _ _ _             |
				                      |...............................|
				                      |       Raw data section N      |
				                      |_______________________________|
				      							  |   Relocation data section 1   |   10 bytes/entry
				                      |...............................|
				 Linker (optional)	  |             _ _ _             |
														  |...............................|
														  |   Relocation data section N   |
														  |_______________________________|
				 Debugging (optional) |       Line number data 1      |   6 bytes/entry
														  |...............................|
														  |             _ _ _             |
														  |...............................|
														  |       Line number data N      |
														  |_______________________________|
														  |    Symbol Table (optional)    |   18 bytes/entry
				 (optional)           |_______________________________|
														  |  String Table (symbol spill)  |
														  |_______________________________|

 Notes: [1] Only the information to support XCOFF is defined.  XCOFF is derived from COFF,
 						but all (well, most) of the possible stuff defined for COFF that is not used
						in XCOFF has been omitted.
			 
			 	[2] In general, all field names are the same as defined in the sources mentioned 
			 			earlier for compatibility.  The main struct/union names, however, have been
						changed to something "more readable".  One naming convention used is that
						struct/union names of the form "...Entry" (i.e., names suffixed with "Entry")
						imply that the definition is for one entry of an array of such entries.
						Additional typedefs have also been added for the "old" names for compatibility
						with COFF, AIX, PowerOpen.  There is one caution, however.  The names of the
						various structs are defined as typedefs and NOT as "struct name".   Therefore
						definitions of the form like "struct AUXENT x;" must be changed to "AUXENT x",
						or even better, "AuxEntry x".
						
				[3] Macros are defined to allow "simpler" access to ALL fields that occur inside
				 		of unions or nested structs.  It is ASSUMED all fields are accessed by their
						simple field names, letting the macros do the extra qualifications.  If the
						fields are accessed any other way, then the pertinent macros MUST be #undef'ed.
						
				[4] All but two field names are unique and pose no compatibility problems using the
						macros to access them.  The two fields that do conflict are:
						
							(1). x_scnlen in the x_csect and x_scn layouts of an AuxEntry.
									 
									 These both have the SAME offset within their respective layouts. Thus
									 the macro defines the qualifiers for only one (x_scn) since accessing
									 the x_csect or the x_scn will yield the appropriate (correct) value.
									 
							(2). l_symndx in the LdrRelEntry layout of a .loader section and in the
									 line number LineNbrEntry layout.
									 
									 These have DIFFERENT offsets and one of them has to be renamed.  Since
									 the .loader section is for XCOFF and line numbers are in both XCOFF and
									 COFF, then, for maximum (oldest) compatibility, the LdrRelEntry field
									 has been renamed to l_symindx (with an inserted "i").
						
				[5] Bit numbering is left-to-right (i.e., the IBM way), with bit 0 being the high
					  order bit.  This is important only in the comments which reference bit ranges
						using the notation "x:y".
						
				[6] Some fields have been changed from signed to unsigned since that's the way they
						are used.  This was done to be more portable and also to say what we REALLY
						mean.  Related to this, corresponding constant definitions for unsigned fields
						have been explicity suffixed with the "U", e.g., "0x123U".
				
				[7] There is only ONE XCOFF header in this implementation, i.e., this file, XCOFF.h.
						Standard [X]COFF headers break the various sections up into separate headers.
						
				[8] If you are viewing this file from Mac MPW, the markers are set to conveniently
						allow moving to any part of the definitions.
						
				[9] For all other systems, the file is formatted with the assumed tab setting of
					  2.  View this file with that setting for best readability.
*/

#ifndef __XCOFF__
#define __XCOFF__

#include	<ConditionalMacros.h>

#if GENERATINGPOWERPC
#pragma options align=mac68k
#endif

/* There are macros defined here that use offsetof() and strlen(), therefore...					*/

#include <stddef.h>
#include <string.h>
 
/*             To view this file properly, tab stops should be set to 2.								*/

/*--------------------------------------------------------------------------------------*/

															/*-------------*
															 | File Header |
															 *-------------*/

struct FileHdr {													/* File header layout:												*/
	unsigned short	f_magic;								/* 		magic number ==> target machine					*/
	unsigned short	f_nscns;								/* 		number of sections (rel. 1)							*/
	long						f_timdat;								/* 		time and date of file creation					*/
	long						f_symptr;								/* 		file offset to start of symbol table		*/
	long						f_nsyms;								/* 		number of symbol table entries					*/
	unsigned short	f_opthdr;								/* 		sizeof(optional aux hdr, 0 if omitted)	*/
	unsigned short	f_flags;								/* 		flags																 		*/
};																				/*		          (20-byte header)							*/
typedef struct FileHdr FileHdr, *FileHdrPtr;

																					/* f_magic magic numbers:											*/
#define	U802TOCMAGIC 0x1DFU								/* 			PowerPC (readonly text segs and TOC)	*/
#define	U802WRMAGIC	 0x1D8U								/* 			IBM R2  (writeable text segments)			*/
#define	U802ROMAGIC	 0x1DDU								/* 			IBM R2  (readonly sharable text segs)	*/
#define	U800WRMAGIC	 0x198U								/* 			IBM RT	(writeable text segments)			*/
#define	U800ROMAGIC	 0x19DU								/* 			IBM RT	(readonly sharable text segs)	*/
#define	U800TOCMAGIC 0x19FU								/* 			IBM RT	(readonly text segs and TOC)	*/
#define	X386MAGIC		 0x14CU								/*			x86																		*/

																					/* f_flags file header flags:									*/
#define	F_RELFLG	0x0001U									/* 		relocation info removed from file				*/
#define	F_EXEC		0x0002U									/* 		executable file													*/
#define	F_LNNO		0x0004U									/* 		line numbers removed from file					*/
#define	F_LSYMS		0x0008U									/* 		local symbols removed from file					*/
#define F_MINIMAL	0x0010U									/*		<reserved>															*/
#define	F_UPDATE	0x0020U									/*		<reserved>															*/
#define F_SWABD		0x0040U									/*		<reserved>															*/
#define	F_AR16WR	0x0080U									/* 		<reserved>															*/
#define	F_AR32WR	0x0100U									/* 		32-bit word reversed byte ordering (x86)*/
#define	F_AR32W		0x0200U									/* 		32-bit word byte ordering (i.e.,PowerPC)*/
#define	F_PATCH		0x0400U									/*		<reserved>															*/
#define	F_DYNLOAD	0x1000U									/* 		file dynamically loadable and executable*/
#define	F_SHROBJ	0x2000U									/* 		file is shared object (shared library)	*/

typedef FileHdr filehdr; 									/* for compatibility only											*/
typedef FileHdr FILHDR;
#define FILHSZ sizeof(FileHdr)

struct OptAuxHdr {												/* Optional auxiliary header layout:					*/
	short					o_mflag;									/* 		flags - how to execute (always 0x010B)	*/
	short					o_vstamp;									/* 		format version (currently 0x0001)				*/
	long					o_tsize;									/* 		.text byte size (padded to mult. of 4)	*/
	long					o_dsize;									/* 		.data byte size (padded to mult. of 4)	*/
	long					o_bsize;									/* 		.bss  byte size (padded to mult. of 4)	*/
	long					o_entry;									/* 		virtual address of entry pt. funct desr */
	unsigned long	o_text_start;							/*		base address of .text section						*/
	unsigned long	o_data_start;							/* 		base address of .data section						*/
																					/*    ------ System Loader Extensions ------	*/
	unsigned long	o_toc;										/* 		virtual address of TOC anchor						*/
	short					o_snentry;								/* 		section number containing entry point		*/
	short					o_sntext;									/* 		section number containing the text			*/
	short					o_sndata;									/* 		section number containing the data			*/
	short					o_sntoc;									/* 		section number containing the toc				*/
	short					o_snloader;								/* 		section number containing loader info		*/
	short					o_snbss;									/* 		section number describing the bss				*/
	short					o_algntext;								/* 		log (base 2) max alignment for .text		*/
	short					o_algndata;								/* 		log (base 2) max alignment for .data		*/
	union {																	/*		module type field:											*/
		unsigned char	 o_modtype[2];					/* 				'1R', 'RE', 'RO'										*/
		unsigned short o_moduletype;					/*    		more usable way to use o_modtype		*/
	} _o_modtype;
	union {																	/* 		resultant executable CPU type ID:				*/
		unsigned char	 o_cputype[2];			 		/* 				cpu type info and ID								*/
		struct {															/*				two fields of the o_cputype:				*/
			unsigned char o_typeInfo;						/*						cpu type characteristic info		*/
			unsigned char o_cpuID;							/* 						cpu type ID											*/
		} _o;
	} _o_cputype;
	unsigned long	o_maxstack;								/* 		max stack size (bytes) allowed 					*/
	unsigned long	o_maxdata;								/* 		max data size (bytes) allowed 					*/
	unsigned long	o_resv2[3];								/* 		<reserved>															*/
};
typedef struct OptAuxHdr OptAuxHdr, *OptAuxHdrPtr;

#define o_modtype 	 _o_modtype.o_modtype
#define o_moduletype _o_modtype.o_moduletype
#define o_cputype		 _o_cputype.o_cputype
#define o_typeInfo	 _o_cputype._o.o_typeInfo
#define o_cpuID			 _o_cputype._o.o_cpuID

#define magic  		 o_mflag								/* for compatibility only											*/
#define	vstamp 		 o_vstamp
#define	tsize  		 o_tsize
#define	dsize  		 o_dsize
#define	bsize  		 o_bsize
#define	entry  		 o_entry
#define	text_start o_text_start
#define	data_start o_data_start
																					/* o_mflag magic numbers:											*/
#define MFLAG_PAGED		0x010B							/*		text & data aligned and may be paged		*/
#define MFLAG_RO			0x0108							/*		text is R/O, data in next section				*/
#define MFLAG_CONTIG	0x0107							/*		text & data contiguous, both writable		*/

#define VSTAMP_FMT_VER		 1							/* o_vstamp format version number							*/

#define ModTypeSingleUse (('1'<<8U)|'L')	/* o_modtype module types: single use ('1L') 	*/
#define ModTypeReusable  (('R'<<8U)|'E')	/*												 reusable		('RE') 	*/
#define ModTypeReadOnly  (('R'<<8U)|'O')	/*												 read only	('RO') 	*/

																					/* o_cputype's o_typeInfo cpu type info:			*/
#define OTYP_ONETYPE 	 0x80U							/* 		obj's are ALL of the same type (ID)			*/
#define OTYP_COMTYPE 	 0x40U							/*		obj's have common intersection of instr.*/
#define OTYP_EMUTYPE 	 0x20U							/*		some obj's require emulation						*/

																					/* o_cputype's o_cpuID cpu type ID:						*/
																					/* (also used by SymTblEntry's n_type n_cpuID)*/
#define CPU_ID_INV	 	 0U									/*		not used (invalid ID)										*/
#define CPU_ID_PPC32	 1U									/*		32-bit PowerPC													*/
#define CPU_ID_PPC64	 2U									/*		64-bit PowerPC													*/
#define CPU_ID_PWRPPC  3U									/*		common intersection of PowerPC and Power*/
#define CPU_ID_PWR		 4U									/*		Power																		*/
#define CPU_ID_ANY	 	 5U									/*		any																			*/
#define CPU_ID_PPC601  6U									/*		601																			*/
#define CPU_ID_PPC603  7U									/*		603																			*/
#define CPU_ID_PPC604  8U									/*		604																			*/
#define CPU_ID_PPC620  9U									/*		620																			*/

typedef OptAuxHdr aouthdr;								/* for compatibility only											*/
typedef OptAuxHdr AOUTHDR;								

#define AOUBASICSZ offsetof(OptAuxHdr, o_toc) /* size of basic (COFF) aux header				*/
#define AOUTHSZ	 	 sizeof(OptAuxHdr)

/* Note: all section numbers are relative to 1.																					*/

struct XCOFFHdr {													/* Full XCOFF header layout:									*/
	FileHdr		fileHdr;											/* 		file header															*/
	OptAuxHdr	aoutHdr;											/* 		optional auxiliary header								*/
};
typedef struct XCOFFHdr XCOFFHdr, *XCOFFHdrPtr;

typedef XCOFFHdr xcoffhdr;								/* for compatibility only											*/

/*--------------------------------------------------------------------------------------*/

																/*-----------------*
																 | Section Headers |
																 *-----------------*/

struct SectionHdrEntry {									/* Section header entry layout:								*/
	char					 s_name[8];								/* 		section name (8-char name has NO null!)	*/
	union {																	/* 		alt meaning if s_type = STYP_OVRFLO			*/
		unsigned long s_paddr;								/* 				physical address										*/
		unsigned long s_ovrflo_nreloc;				/*				nbr of reloc. entries (STYP_OVRFLO)	*/
	} _s_paddr;
	union {																	/*		alt meaning if s_type = STYP_OVRFLO			*/
		unsigned long	s_vaddr;								/* 				virtual addr (= s_paddr)						*/
		unsigned long s_ovrflo_nlnno;					/*				nbr of line nbr entries(STYP_OVRFLO)*/
	} _s_vaddr;
	unsigned long	 s_size;									/* 		raw data size (bytes)										*/
	long					 s_scnptr;								/* 		file offset to the raw data (or 0)			*/
	long					 s_relptr;								/* 		file offset to relocation entries (or 0)*/
	long					 s_lnnoptr;								/* 		file offset to line nbr entries (or 0)	*/
	union {																	/*		alt meaning if s_type = STYP_OVRFLO			*/
		unsigned short s_nreloc;							/* 				nbr of relocation entries 					*/
		unsigned short s_nreloc_primary;			/*				sctn nbr of primary overflowing sctn*/
	} _s_nreloc;														/*				(section numbers are relative to 1)	*/
	union {																	/*		alt meaning if s_type = STYP_OVRFLO			*/
		unsigned short s_nlnno;								/* 				nbr of line number entries 					*/
		unsigned short s_nlnno_primary;				/*				sctn nbr of primary overflowing sctn*/
	} _s_nlnno;
	union	{																	/*		only low-order 16-bits of flags used		*/
		unsigned long s_flags;								/* 				flags																*/
		struct {															/*				flags as two 16-bit values:					*/
			unsigned short s_unused;						/*						not used												*/
			unsigned short s_type;							/*						section type (see below)				*/
		} _s_s;
	} _s;
};
typedef struct SectionHdrEntry SectionHdrEntry, *SectionHdrEntryPtr;

#define s_paddr  					_s_paddr.s_paddr
#define s_ovrflo_nreloc		_s_paddr.s_ovrflo_nreloc
#define s_vaddr  					_s_vaddr.s_vaddr
#define s_ovrflo_nlnno		_s_vaddr.s_ovrflo_nlnno
#define s_nreloc 					_s_nreloc.s_nreloc
#define s_nreloc_primary 	_s_nreloc.s_nreloc_primary
#define s_nlnno_primary		_s_nlnno.s_nlnno_primary
#define s_nlnno	 					_s_nlnno.s_nlnno
#define s_flags  					_s.s_flags
#define s_unused 				 	_s._s_s.s_unused
#define s_type 				 		_s._s_s.s_type

#define _TEXT				".text"								/* names for special sections...							*/
#define _DATA				".data"
#define _BSS				".bss"
#define	_PAD				".pad"
#define _LOADER 		".loader"
#define _TYPCHK 		".typchk"
#define _DEBUG			".debug"
#define _EXCEPT			".except"
#define _OVRFLO			".ovrflo"
#define _EXPORT			".export"
#define _IMPORT  		".import"
#define _INTERN  		".intern"
#define _SEGMENT 		".segment"
																					/* s_flags/s_type section types:							*/
#define STYP_REG		0x0000U								/* 		<reserved>: allocated, relocated, loaded*/
#define STYP_DSECT	0x0001U								/* 		<reserved>:!allocated, relocated,!loaded*/
#define STYP_NOLOAD	0x0002U								/* 		<reserved>: allocated, relocated,!loaded*/
#define STYP_GROUP	0x0004U								/* 		<reserved>															*/
#define STYP_PAD		0x0008U								/* 		pad:   		 !allocated,!relocated, loaded*/
#define STYP_COPY		0x0010U								/*		<reserved>: allocated,!relocated, loaded*/
#define	STYP_TEXT		0x0020U								/* 		text only:  allocated, relocated, loaded*/
#define STYP_DATA		0x0040U								/* 		data only:  allocated, relocated, loaded*/
#define STYP_BSS		0x0080U								/* 		bss only:   allocated,!relocated,!loaded*/
#define STYP_EXCEPT	0x0100U								/* 		exception: !allocated,!relocated,!loaded*/
#define STYP_INFO		0x0200U								/*		comment:	 !allocated,!relocated,!loaded*/
#define STYP_OVER		0x0400U								/* 		<reserved>:!allocated, relocated,!loaded*/
#define STYP_LIB		0x0800U								/* 		<reserved>: = STYP_INFO									*/
#define STYP_LOADER	0x1000U								/* 		loader																	*/
#define STYP_DEBUG	0x2000U								/* 		debug																		*/
#define STYP_TYPCHK	0x4000U								/* 		type-check 															*/
#define STYP_OVRFLO	0x8000U								/* 		relocation and line nbr overflow 				*/

typedef SectionHdrEntry scnhdr;						/* for compatibility only											*/
typedef SectionHdrEntry SCNHDR;
#define	SCNHSZ sizeof(SectionHdrEntry)

/*--------------------------------------------------------------------------------------*/

														 /*-------------------*
															| Raw Data Sections |
															*-------------------*/
/*----------------*
 | Loader section |
 *----------------*
 
 The following is a diagram of the loader section.  The identifiers are the various fields
 defined in the loader header.
 
													          Loader Section Format
 												 
 s_scnptr ------------------> |-------------------------------|
		|        |        |       |     Loader Section Header     | 32 bytes
		|        |        |       |_______________________________|
		|        |        |       |   External symbol [1]         | 24 bytes/entry
		|        |        |       |...............................|
		|        |        |       |             _ _ _             |
		|        |        |       |...............................|
		|        |        |       |   External symbol [l_nsyms]   |
		|        |        |       |_______________________________|
		|        |        |       |  Relocation entry [1]         | 12 bytes/entry
		|        |        |       |...............................|
		|        |        |       |             _ _ _             |
		|        |        |       |...............................|
	s_size     |        |       |  Relocation entry [l_nreloc]  |
		|        |       ---      |_______________________________|    ---
		|        |    l_impoff    |   Import file ID [0]          |     |
		|        |	           	  |...............................|     |
		|        |                |             _ _ _             | l_istlen
		|        |                |...............................|     |
		|        |                |  Import file ID [l_nimpid-1]  |     |
		|       ---               |_______________________________|    ---
		|     l_stoff             |     String table entry 1      |     |
		|                         |...............................|     |
		|                         |             _ _ _             |  l_stlen
		|                         |...............................|     |
	  |                         |     String table entry n      |     |
	 ---                        |_______________________________|    ---
*/

struct LdrHdr {														/* Loader raw data section header layout:			*/
	long					l_version;								/* 		version number (currently 1)						*/
	long					l_nsyms;									/* 		nbr of external symbol tbl entries			*/
	long					l_nreloc;									/* 		nbr of relocation table entries 				*/
	unsigned long	l_istlen;									/* 		length of import file IDs							 	*/
	long					l_nimpid;									/* 		nbr of import file IDs									*/
	unsigned long	l_impoff;									/* 		offset to start of import file IDs			*/
	unsigned long	l_stlen;									/* 		length of the loader string table				*/
	unsigned long	l_stoff;									/* 		offset to start of loader string table 	*/
};																				/*		(offsets are from loader section start)	*/
typedef struct LdrHdr LdrHdr, *LdrHdrPtr;

#define LDRHDRVER 1L											/* Loader section version number							*/

typedef LdrHdr ldhdr;											/* for compatibility only											*/
typedef LdrHdr LDHDR;
#define	LDHDRSZ	sizeof(LdrHdr)

#define SYMNMLEN 8												/* number of characters in (small) symbol name*/

/*. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . */

struct LdrExtSymEntry {										/* Loader external symbol table entry layout:	*/
	union {																	/*    (note: these entries accessed by index)	*/
		char				_l_name[SYMNMLEN];				/* 		symbol name unless 1st 4 bytes are 0s		*/
		struct {															/* 		_l_name value if 1st 4 bytes are 0s:		*/
			long	_l_zeroes;										/* 				the 0s imply use the 2nd 4 bytes		*/
			long	_l_offset;										/* 				ldr strtbl offset to symbol(not len)*/
		} _l_l;																/*				(offset from start of ldr str tbl)	*/
		char		*_l_nptr[2];									/* 		yet another way to look at the symbol	 	*/
	} _l;
	unsigned long	l_value;									/* 		address value set by Linker							*/
	short					l_scnum;									/* 		1-rel sctn nbr where symbol is defined	*/
	unsigned char	l_smtype;									/* 		symbol type (see below)									*/
	unsigned char	l_smclas;									/* 		storage mapping class	(XMC_xx)					*/
	long					l_ifile;									/* 	 	import file ID (0-rel) index(0 not used)*/
	long					l_parm;										/* 		ldr sctn relative offset to type chk str*/
};
typedef struct LdrExtSymEntry LdrExtSymEntry, *LdrExtSymEntryPtr;

#define	l_name		_l._l_name
#define	l_zeroes	_l._l_l._l_zeroes
#define	l_offset	_l._l_l._l_offset
#define	l_nptr		_l._l_nptr[1]

#if 0																			/* l_scnum special section numbers:						*/
#define	N_UNDEF	 	  0											/*		undefined or uninited external symbol		*/
#define	N_ABS			 -1											/* 		absolute symbol value  									*/
#define	N_DEBUG		 -2											/* 		special debugging symbol (no value)			*/
#endif

/* l_smtype symbol type meaning: Bit  0  1  2  3   4  5  6  7 													*/
/*																		x  I  E  E   x  XTY_xx     x ==> reserved					*/
/*																		   m  n  x								 												*/
/*																	     p  t  p								 XTY_xx's defined with	*/
/*																		   o  r  o								 AuxEntry								*/
/*																			 r  y  r																				*/
/*																			 t     t																				*/

#define	L_IMPORT		0x40U												/* import										 (bit  1) 	*/
#define	L_ENTRY			0x20U												/* entry										 (bit  2) 	*/
#define	L_EXPORT		0x10U												/* export										 (bit  3) 	*/
#define	L_SMTYP(x)	((x).l_smtype & 0x07U)			/* XTY_xx is symbol type 		 (bits 5-7) */

#define	LDR_EXPORT(x)	(((x).l_smtype & L_EXPORT) != 0U)	/* l_smtype field operations...	*/
#define	LDR_ENTRY(x)	(((x).l_smtype & L_ENTRY ) != 0U)
#define	LDR_IMPORT(x)	(((x).l_smtype & L_IMPORT) != 0U)

typedef LdrExtSymEntry ldsym;							/* for compatibility only											*/
typedef LdrExtSymEntry LDSYM;
#define	LDSYMSZ	sizeof(LdrExtSymEntry)

/*. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . */

struct LdrRelEntry {											/* Loader relocation table entry layout:			*/
	unsigned long  l_vaddr;									/* 		virtual address of reference to fix up	*/
	long					 l_symindx;								/* 		external ldr symbol table INDEX (rel. 0)*/
	union {																	/* 		relocation type and fixup size:					*/
		struct {															/*				(see RelocEntry r_rtype for values)	*/
			unsigned char	_l_rsize;							/* 				sign and reloc bit len							*/
			unsigned char	_l_rtype;							/* 				toc relocation type									*/
		} _l_l;
		unsigned short _l_type;								/* 		relocation type(same meaning as r_rtype)*/
	} _l;
	short					 l_rsecnm;								/* 		section nbr being relocated (rel. 1)		*/
};
typedef struct LdrRelEntry LdrRelEntry, *LdrRelEntryPtr;

#define l_rsize	_l._l_l._l_rsize
#define l_rtype	_l._l_l._l_rtype
#define l_type	_l._l_type

/* Note: l_symindx, not spelling (with an "i"), not l_symndx, since this CONFLICTS with	*/
/*			 the same field name in the LineNbrEntry.  Also read what follows...						*/

#define L_SYMINDX_TEXT 0L									/* These values for l_symindx are implicit. 	*/
#define L_SYMINDX_DATA 1L									/* 		An index, i, for l_symindx, when i >= 3	*/
#define L_SYMINDX_BSS  2L									/*		refers to LdrExtSymEntry[i-3], where 		*/
																					/* 		LdrExtSymEntry[0] is the 1st symbol.		*/

#define LDRRELOC_RSIGN(x) (((x).l_rsize & R_SIGN)) /* same as the RELOC_xxx but operates*/
#define LDRRELOC_RLEN(x)	(((x).l_rsize & R_LEN))	 /* on LdrRelEntry. R_SIGN and  R_LEN	*/
#define LDRRELOC_RTYPE(x) ((x).l_rtype)						 /* are defined for the RelocEntry.		*/

typedef LdrRelEntry ldrel;								/* for compatibility only											*/
typedef LdrRelEntry LDREL;
#define	LDRELSZ	sizeof(LDREL)

/*. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . */

																					/* Import file ID entries (best I can do):		*/
#define l_impidpath(x) 										/* 		file ID pathname												*/\
	((char *)(x))
#define l_impidbase(x) 										/*		basename																*/\
	((char *)(l_impidpath(x) + strlen(l_impidpath(x)) + 1))
#define l_impidmem(x)	 										/*		archive file member name								*/\
	((char *)(l_impidbase(x) + strlen(l_impidbase(x)) + 1))

/*. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . */

struct LdrStrEntry {											/* String table entry layout:									*/
	unsigned short l_parmstlen;							/*		string length	(including null)					*/
	char					 l_parmst[1];							/*		START of the string of len l_parmstlen	*/
};
typedef struct LdrStrEntry LdrStrEntry, *LdrStrEntryPtr;

/*---------------*
 | Debug Section |
 *---------------*/

struct DbxStabEntry {											/* Debug dbx stab string entry layout:				*/
	unsigned short dbx_len;									/*		string length	(including null)					*/
	char					 dbx_stabst[1];						/*		START of the string of len dbx_len			*/
};																				/*		(strings are null terminated)						*/
typedef struct DbxStabEntry DbxStabEntry, *DbxStabEntryPtr;

/*--------------------*
 | Type Check Section |
 *--------------------*/

struct TypeChkEntry {											/* Type check entry layout:										*/
	unsigned short t_len;										/*		string length														*/
	char					 t_st[1];									/*		START of the string of len t_len				*/
};																				/*		(strings are NOT null terminated)				*/
typedef struct TypeChkEntry TypeChkEntry, *TypeChkEntryPtr;

struct AIXTypeChkEntry {									/* Type check entry layout used by AIX:				*/
	unsigned short t_len;										/*		string length (always 10)								*/
	unsigned short t_lang;									/*		compiler language ID (e_lang's LANG_xx)	*/
	unsigned long  t_genHash;								/*		most general hash form									*/
	unsigned long	 t_langHash;							/*		language-specific hash form							*/
};
typedef struct AIXTypeChkEntry AIXTypeChkEntry, *AIXTypeChkEntryPtr;

/*-------------------*
 | Exception Section |
 *-------------------*/

struct ExceptionEntry {										/* Exception entry layout:										*/
	union {																	/* 		use e_symndx if e_reason=0 else e_paddr	*/
		long e_symndx;												/* 				symbol tbl idx (0 rel) of funct name*/
		long e_paddr;													/* 				(physical) address of trap instr. 	*/
	} e_addr;
	unsigned char e_lang;										/*		compiler language ID code 							*/
	signed char	 	e_reason;									/* 		exception reason code 									*/
};
typedef struct ExceptionEntry ExceptionEntry, *ExceptionEntryPtr;

#define e_symndx e_addr.e_symndx
#define e_paddr	 e_addr.e_paddr
																					/* e_lang compiler language ID codes:					*/
																					/* (also used by SymTblEntry's n_type n_lang)	*/
#define LANG_C 			 0x00U								/* 		C																				*/
#define LANG_FORTRAN 0x01U								/* 		Fortran																	*/
#define LANG_PASCAL  0x02U								/* 		Pascal																	*/
#define LANG_ADA 		 0x03U								/* 		ADA																			*/
#define LANG_PL1 		 0x04U								/* 		PL/1																		*/
#define LANG_BASIC 	 0x05U								/* 		Basic																		*/
#define LANG_LISP 	 0x06U								/* 		Lisp																		*/
#define LANG_COBOL 	 0x07U								/* 		Cobol																		*/
#define LANG_MODULA2 0x08U								/* 		Modula2																	*/
#define LANG_CPP 		 0x09U								/* 		C++																			*/
#define LANG_RPG 		 0x0AU								/* 		RPG																			*/
#define LANG_PL8 		 0x0BU								/* 		PL8, PLIX																*/
#define LANG_ASM 		 0x0CU								/* 		Assembly																*/
#define LANG_MACOS	 0x2AU								/* 		MacOS language neutral Exceptions				*/

typedef ExceptionEntry exceptab;					/* for compatibility only											*/
typedef ExceptionEntry EXCEPTAB;
#define	EXCEPTSZ 6

/*-----------------*
 | Comment Section |
 *-----------------*/

struct CommentEntry {											/* Comment entry layout:											*/
	unsigned long c_len;										/*		comment length													*/
	char				  c_data[1];								/*		START of the comment of len c_len				*/
};																				/*		(strings are NOT null terminated)				*/
typedef struct CommentEntry CommentEntry, *CommentEntryPtr;

/*--------------------------------------------------------------------------------------*/

														/*-------------------------*
														 | Relocation data section |
														 *-------------------------*/

struct RelocEntry {												/* Relocation entry layout:										*/
	unsigned long	r_vaddr;									/* 		virtual address of reference to fix up	*/
	unsigned long	r_symndx;									/* 		symbol table index (rel 0) to get value	*/
	union {																	/*		relocation field type										*/
		struct {
			unsigned char	_r_rsize;							/* 				sign and reloc bit len (see below)	*/
			unsigned char	_r_rtype;							/* 				toc relocation type (see below)			*/
		} _r_r;
		unsigned short _r_type;								/* 				old style COFF relocation type 			*/
	} _r;
};
typedef struct RelocEntry RelocEntry, *RelocEntryPtr;

#define r_rsize	_r._r_r._r_rsize
#define r_rtype	_r._r_r._r_rtype
#define r_type	_r._r_type

#define R_SIGN	0x80U											/* extract sign of relocation								 	*/
#define R_LEN		0x1FU											/* extract bit length field (length - 1)			*/

#define RELOC_RSIGN(x) (((x).r_rsize & R_SIGN))
#define RELOC_RLEN(x)	 (((x).r_rsize & R_LEN))
#define RELOC_RTYPE(x) ((x).r_rtype)

																					/* r_type relocation types:										*/
#define	R_POS		0x00U											/*		A(sym) 			 positive relocation				*/
#define R_NEG		0x01U											/* 		-A(sym)			 negative relocation				*/
#define R_REL		0x02U											/* 		A(sym-$) 	 	 relative to self						*/
#define	R_TOC		0x03U											/* 		A(sym-TOC) 	 relative to TOC						*/
#define R_TRL		0x12U											/* 		A(sym-TOC) 	 TOC relative indirect load	*/
#define R_TRLA	0x13U											/* 		A(sym-TOC) 	 TOC relative load address	*/
#define R_GL		0x05U											/* 		A(ext TOC of sym) global linkage-ext TOC*/
#define R_TCL		0x06U											/* 		A(lcl TOC of sym) local TOC address 		*/
#define R_RL		0x0CU											/* 		A(sym) 			 pos indirect load (=R_POS)	*/
#define R_RLA		0x0DU											/* 		A(sym) 			 pos load address  (=R_POS)	*/
#define R_REF		0x0FU											/* 		AL0(sym) 		 nonrel ref-no garbge collct*/
#define R_BA		0x08U											/* 		A(sym) 			 br. absolute(nonmodifiable)*/
#define R_RBA		0x18U											/* 		A(sym) 			 br. absolute (modifiable)	*/
#define	R_RBAC	0x19U											/* 		A(sym) 			 br. absolute constant			*/
#define	R_BR		0x0AU											/* 		A(sym-$) 		 br. rel self(nonmodifiable)*/
#define R_RBR		0x1AU											/* 		A(sym-$) 		 br. rel self (modifiable)	*/
#define R_RBRC	0x1BU											/* 		A(sym-$) 		 br. absolute constant			*/
#define R_RTB		0x04U											/* 		A((sym-$)/2) not used										*/
#define R_RRTBI	0x14U											/* 		A((sym-$)/2) not used										*/
#define R_RRTBA	0x15U											/* 		A((sym-$)/2) not used										*/

typedef RelocEntry reloc;									/* for compatibility only											*/
typedef RelocEntry RELOC;
#define	RELSZ	10

/*--------------------------------------------------------------------------------------*/

															/*---------------------*
															 | Line Number Section |
															 *---------------------*/

struct LineNbrEntry {											/* Line number section entry layout:					*/
	union {																	/* 		use l_symndx if l_lnno=0 else l_paddr		*/
		long	l_symndx;												/* 		symbol table index (rel 0) of funct name*/
		long	l_paddr;												/* 		physical address of line number 				*/
	} l_addr;
	unsigned short l_lnno;									/* 		line number (0 indicates function start)*/
};
typedef struct LineNbrEntry LineNbrEntry, *LineNbrEntryPtr;

#define l_symndx l_addr.l_symndx
#define l_paddr	 l_addr.l_paddr

typedef LineNbrEntry lineno;							/* for compatibility only											*/
typedef LineNbrEntry LINENO;
#define	LINESZ 6

/*--------------------------------------------------------------------------------------*/

																	/*--------------*
																	 | Symbol Table |
																	 *--------------*/

struct SymTblEntry {											/* Symbol table entry layout:									*/
	union {
		struct {
			long _n_zeroes;											/* 		0 ==> string table offset else .debug 	*/
			long _n_offset;											/* 		string table or .debug section offset		*/
		} _n_n;																/*		(offset is to string, NOT its length)		*/
		char 	 *_n_nptr[2];										/* 		allows for overlaying 									*/
		char	 _n_name[SYMNMLEN];							/* 		old COFF version 												*/
	} _n;
	long					 n_value;									/* 		value (storage class dependent)					*/
	short					 n_scnum;									/* 		section number (some special-see below)	*/
	union {
		unsigned short n_type;								/* 		fundamental and derived type (see below)*/
		struct {															/*		when n_sclass is C_FILE n_type becomes:	*/ 
			unsigned char n_lang;								/*			source language ID (e_lang's LANG_xx)	*/
			unsigned char n_cpuID;							/*			cpu type ID (o_cputype's CPU_ID_xx)		*/
		} _n;
	} _n_type;
	unsigned char	 n_sclass;								/* 		storage class (see below)							  */
	signed char		 n_numaux;								/* 		number of auxiliary entries that follow	*/
};
typedef struct SymTblEntry SymTblEntry, *SymTblEntryPtr;

#define n_zeroes	_n._n_n._n_zeroes
#define n_offset	_n._n_n._n_offset
#define n_nptr		_n._n_nptr[1]
#define n_name		_n._n_name
#define n_type		_n_type.n_type
#define n_lang		_n_type._n.n_lang
#define n_cpuID		_n_type._n.n_cpuID
																					/* n_scnum special section numbers:						*/
#define	N_UNDEF	 	  0											/*		undefined or uninited external symbol		*/
#define	N_ABS			 -1											/* 		absolute symbol value  									*/
#define	N_DEBUG		 -2											/* 		special debugging symbol (no value)			*/
#define N_SCNUM			1											/*		any value > 0 (N_SCNUM IS NOT A VALUE)	*/

																					/* n_type:																		*/
																					/* 		fundamental types (bits 4:7):						*/
#define	T_NULL		 0U											/* 				no type															*/
#define	T_ARG			 1U											/* 				function argument										*/
#define	T_CHAR		 2U											/* 				char																*/
#define	T_SHORT		 3U											/* 				short integer 											*/
#define	T_INT			 4U											/* 				integer 														*/
#define	T_LONG		 5U											/* 				long integer												*/
#define	T_FLOAT		 6U											/* 				floating point											*/
#define	T_DOUBLE	 7U											/* 				double word													*/
#define	T_STRUCT	 8U											/* 				struct															*/
#define	T_UNION		 9U											/* 				union																*/
#define	T_ENUM		10U											/* 				enum																*/
#define	T_MOE			11U											/* 				member of enum											*/
#define	T_UCHAR		12U											/* 				unsigned character									*/
#define	T_USHORT	13U											/* 				unsigned short											*/
#define	T_UINT		14U											/* 				unsigned integer										*/
#define	T_ULONG		15U											/* 				unsigned long												*/

																					/* 		derived types (bits 2:3):								*/
#define DT_NON		 0U											/*		 		no derived type										 	*/
#define DT_PTR		 1U											/* 				pointer 														*/
#define DT_FCN		 2U											/* 				function 														*/
#define DT_ARY		 3U											/* 				array 															*/

																					/* 		n_type manipulation macros:							*/
#define N_BTMASK	0x0FU										/* 				extract fundamental type 						*/
#define N_TMASK		0x30U										/* 				extract derived type								*/
#define N_BTSHFT	4												/* 				shift to access derived type				*/
#define BTYPE(x)	((x) & N_BTMASK)													/* extract basic type				*/
#define DTYPE(x)	(((x) & N_TMASK) >> N_BTSHFT)							/* extract derived type			*/
#define ISPTR(x)	(((x) & N_TMASK) == (DT_PTR << N_BTSHFT)) /* is pointer ?							*/
#define ISFCN(x)	(((x) & N_TMASK) == (DT_FCN << N_BTSHFT))	/* is function ?						*/
#define ISARY(x)	(((x) & N_TMASK) == (DT_ARY << N_BTSHFT))	/* is array ?								*/

																					/* n_sclass storage classes:									*/
#define C_EFCN			0xFFU									/* 		physical end of function 		 <obsolete> */
#define C_NULL			0U										/*    														 						*/
#define C_AUTO			1U										/* 		automatic variable					 <obsolete> */
#define C_EXT				2U										/* 		external symbol													*/
#define C_STAT			3U										/* 		static symbol														*/
#define C_REG			 	4U										/* 		register variable						 <obsolete> */
#define C_EXTDEF	 	5U										/* 		external definition					 <obsolete> */
#define C_LABEL		 	6U										/* 		label																		*/
#define C_ULABEL	 	7U										/* 		undefined label							 <obsolete> */
#define C_MOS			 	8U										/* 		structure member						 <obsolete> */
#define C_ARG			 	9U										/* 		function argument						 <obsolete> */
#define C_STRTAG	 10U										/* 		structure tag								 <obsolete> */
#define C_MOU			 11U										/* 		union member								 <obsolete> */
#define C_UNTAG		 12U										/* 		union tag										 <obsolete> */
#define C_TPDEF		 13U										/* 		type definition							 <obsolete> */
#define C_USTATIC	 14U										/* 		uninitialized static				 <obsolete> */
#define C_ENTAG		 15U										/* 		enumeration tag							 <obsolete> */
#define C_MOE			 16U										/* 		enumeration member					 <obsolete> */
#define C_REGPARM	 17U										/* 		register argument						 <obsolete> */
#define C_FIELD		 18U										/* 		bit field										 <obsolete> */
#define C_BLOCK		100U										/* 		".bb" or ".eb"													*/
#define C_FCN			101U										/* 		".bf" or ".ef"													*/
#define C_EOS			102U										/* 		end of structure						 <obsolete> */
#define C_FILE		103U										/* 		file name																*/
#define C_LINE		104U										/*		utility program use (?)			 <obsolete> */
#define C_ALIAS		105U										/* 		duplicate tag								 <obsolete> */
#define C_HIDDEN	106U										/* 		unnamed static symbol				 <obsolete> */
#define	C_HIDEXT	107U										/* 		unnamed external symbol									*/
#define	C_BINCL		108U										/* 		beginning of include file								*/
#define	C_EINCL		109U										/* 		end of include file											*/
#define C_INFO		110U										/*		special information											*/

																					/* n_sclass dbx storage classes:							*/
#define C_GSYM		0x80U										/*		global variable													*/
#define C_LSYM		0x81U										/*		automatic variable allocated on stack		*/
#define C_PSYM		0x82U										/*		argument to subr. aloced on stack				*/
#define C_RSYM		0x83U										/*		register variable												*/
#define C_RPSYM		0x84U										/*		function argument in register						*/
#define C_STSYM		0x85U										/*		statically allocated symbol							*/
#define C_TCSYM		0x86U										/*		<reserved>															*/
#define C_BCOMM		0x87U										/*		beginning of common block								*/
#define C_ECOML		0x88U										/*		local member of common block						*/
#define C_ECOMM		0x89U										/*		end of common block											*/
#define C_DECL		0x8CU										/*		declaration of object										*/
#define C_ENTRY		0x8DU										/*		alternate entry													*/
#define C_FUN			0x8EU										/*		function or procedure										*/
#define C_BSTAT		0x8FU										/*		beginning of static block								*/
#define C_ESTAT		0x90U										/*		end of static block											*/

#define DBXMASK		0x80U										/*		all of these have the sign bit set			*/

#define ISSTAB(x) (((x) & DBXMASK) != 0)	/* n_sclass with high bit ==> n_name stab str	*/

/* Note: when the n_sclass is a C_FILE (103), the n_type represents a language ID and		*/
/*			 CPU ID, n_lang and n_cpuID respectively. The LANG_xx's define the n_lang values*/
/*			 and the CPU_ID_xx's define the CPU ID values.																	*/

/*------------------------------*
 | Auxiliary symbol table entry |
 *------------------------------*/

#define	FILNMLEN 14												/* nbr of characters in a file name 					*/
#define	DIMNUM		4												/* nbr of array dimensions in auxiliary entry */

union AuxEntry {													/* Auxiliary symbol table entry layout:				*/							
	struct {																/*		symbol																	*/
		long x_tagndx;												/* 				file offset to exception table			*/
																					/* 				or struct, union, enum tag index 		*/
		union {																
			struct {														/*				struct, union, array info:					*/
				unsigned short x_lnno;						/* 						declaration line number 				*/
				unsigned short x_size;						/* 						struct, union, or array size 		*/
			} x_lnsz;
			long x_fsize;												/* 				function size (bytes)								*/
		} x_misc;
		
		union {																/*				function,tag,.bb (additional fields)*/
			struct {														/*																						*/
				long	x_lnnoptr;									/* 						file offset to line number			*/
				long	x_endndx;										/* 						index to entry after function		*/
			} x_fcn;
			
			struct {														/* 				array (additional fields)						*/
				unsigned short x_dimen[DIMNUM];		/*						up to 4 dimensions							*/
			} x_ary;
		} x_fcnary;
		
		unsigned short x_tvndx;								/* 				<unused> (pads up to the 18 bytes)	*/
	} x_sym;
	
	union {																	/*		file name																*/
		char x_fname[FILNMLEN];								/*				source file name										*/
		struct {															/*			  or																	*/
			long					x_zeroes;							/*				0 ==> string is in the string table	*/
			long					x_offset;							/*				offset to file string in string tbl	*/
			char					x_pad[FILNMLEN-8];		
			unsigned char	x_ftype;							/*				file string type										*/
		} _x;
	} x_file;
																					/* 				x_ftype file string types:					*/
	#define	XFT_FN	 0U											/*						source file name 								*/
	#define	XFT_CT	 1U											/*						compile time stamp 							*/
	#define	XFT_CV	 2U											/*						compiler version number 				*/
	#define	XFT_CD 128U											/*						compiler defined information 		*/
	
	struct {																/* 		section																	*/
		long					 x_scnlen; 							/* 				section length											*/
		unsigned short x_nreloc; 							/* 				number of relocation entries 				*/
		unsigned short x_nlinno; 							/* 				number of line numbers 							*/
	} x_scn;

	struct {																/* 		csect																		*/
		long					 x_scnlen;							/* 				0, csect length, or symbol tbl index*/
		long					 x_parmhash;						/* 				.typchk sctn offset to type chk str	*/
		unsigned short x_snhash;							/* 				.typchk section number (rel. 1) 		*/
		unsigned char	 x_smtyp;								/* 				log 2 alignment (0:4) and type (5:7)*/
		unsigned char	 x_smclas;							/* 				storage mapping class (see below)		*/
		long					 x_stab;								/* 				dbx stab info index 			(reserved)*/
		unsigned short x_snstab;							/* 				section nbr with dbx stab (reserved)*/
	} x_csect;
																					/* 				x_smtyp manipulation macros:				*/
	#define X_ALSHIFT 3											/*						alignament = bits 0:4; type 5:7	*/
	#define X_SMTMASK 0x07U									/*						mask to extract type						*/
	#define X_ALIGNMENT(x) ((x)>>X_ALSHIFT)	/*						access alignent value						*/
	#define X_SMTYP(x)		 ((x)& X_SMTMASK)	/*						access csect type								*/
	
																					/* 				x_smtyp csect types (bits 5:7):			*/
	#define	XTY_ER	0U											/* 						external reference 							*/
	#define	XTY_SD	1U											/* 						csect definition 								*/
	#define XTY_LD	2U											/* 						entry point label definition 		*/
	#define XTY_CM	3U											/* 						common (BSS) 										*/
	#define XTY_HL	4U											/*						hidden label										*/
	#define XTY_EM	4U											/* 						error message - linker usage		*/
	#define XTY_US	5U											/* 						unset - linker usage						*/
	
																					/*				x_smclas storage mapping classes 		*/
																					/*						read only classes								*/
	#define	XMC_PR	 0U											/* 								program code 								*/
	#define	XMC_RO	 1U											/* 								read-only constants 				*/
	#define XMC_DB	 2U											/* 								debug dictionary table 			*/
	#define XMC_GL	 6U											/* 								global linkage							*/
	#define XMC_XO	 7U											/* 								extended operation					*/
	#define XMC_SV	 8U											/*							 	supervisor call descriptor	*/
	#define XMC_TI	12U											/* 								traceback index csect 			*/
	#define XMC_TB	13U											/* 								traceback table csect 			*/
																					/*						read/write classes							*/
	#define XMC_RW	 5U											/*								read/write data							*/
	#define XMC_TC0 15U											/* 								toc anchor for addressablty	*/
	#define XMC_TC	 3U											/* 								general toc entry 					*/
	#define XMC_DS	10U											/* 								function descriptor csect		*/
	#define XMC_UA	 4U											/* 								unclassified								*/
	#define XMC_BS	 9U											/* 								bss class										*/
	#define XMC_UC	11U											/*								un-named FORTRAN common 		*/
	#define XMC_TD	16U											/*								scalar data entry in the toc*/
};
typedef union AuxEntry AuxEntry, *AuxEntryPtr;

#define x_tagndx 	 x_sym.x_tagndx
#define x_lnno	 	 x_sym.x_misc.x_lnsz.x_lnno
#define x_size	 	 x_sym.x_misc.x_lnsz.x_size
#define x_fsize	 	 x_sym.x_misc.x_fsize
#define x_lnnoptr	 x_sym.x_fcnary.x_fcn.x_lnnoptr
#define x_endndx	 x_sym.x_fcnary.x_fcn.x_endndx
#define x_dimen		 x_sym.x_fcnary.x_ary.x_dimen
#define x_tvndx		 x_sym.x_tvndx
#define x_fname		 x_file.x_fname
#define x_zeroes	 x_file._x.x_zeroes
#define x_offset	 x_file._x.x_offset
#define x_ftype		 x_file._x.x_ftype
#define x_scnlen	 x_scn.x_scnlen					/* (this is also used for x_csect's x_scnlen)	*/
#define x_nreloc	 x_scn.x_nreloc
#define x_nlinno	 x_scn.x_nlinno
#define x_parmhash x_csect.x_parmhash
#define x_snhash	 x_csect.x_snhash
#define x_smtyp		 x_csect.x_smtyp
#define x_smclas	 x_csect.x_smclas
#define x_stab		 x_csect.x_stab
#define x_snstab	 x_csect.x_snstab

typedef SymTblEntry syment;								/* for compatibility only											*/
typedef SymTblEntry SYMENT;
#define	SYMESZ 18

typedef AuxEntry auxent;
typedef AuxEntry AUXENT;
#define	AUXESZ SYMESZ
#define x_exptr	x_tagndx

/*--------------------------------------------------------------------------------------*/

																/*--------------*
																 | String Table |
																 *--------------*/

struct StringTable {											/* String table layout:												*/
	long st_len;														/*		table length INCLUDING these 4 bytes		*/
	char st_table[1];												/*		list of C strings START here						*/
};																				/*		(strings are null terminated)						*/
typedef struct StringTable StringTable, *StringTablePtr;

/* Note: st_len can have a value 0 to mean NO strings follow!  4 means the same thing.	*/
/* 			 Offsets into this table are to the string itself, not to the length that				*/
/*			 precedes it.																																		*/

/*--------------------------------------------------------------------------------------*/

#if GENERATINGPOWERPC
#pragma options align=reset
#endif

#endif	/* __XCOFF__ */
