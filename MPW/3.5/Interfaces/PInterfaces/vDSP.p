{
     File:       vDSP.p
 
     Contains:   AltiVec DSP Interfaces
 
     Version:    Technology: 1.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT vDSP;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __VDSP__}
{$SETC __VDSP__ := 1}

{$I+}
{$SETC vDSPIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	DSPComplexPtr = ^DSPComplex;
	DSPComplex = RECORD
		real:					Single;
		imag:					Single;
	END;

	DSPSplitComplexPtr = ^DSPSplitComplex;
	DSPSplitComplex = RECORD
		realp:					^Single;
		imagp:					^Single;
	END;

	FFTSetup    = ^LONGINT; { an opaque 32-bit type }
	FFTSetupPtr = ^FFTSetup;  { when a VAR xx:FFTSetup parameter can be nil, it is changed to xx: FFTSetupPtr }
	FFTDirection 				= SInt32;
CONST
	kFFTDirection_Forward		= 1;
	kFFTDirection_Inverse		= -1;


TYPE
	FFTRadix 					= SInt32;
CONST
	kFFTRadix2					= 0;
	kFFTRadix3					= 1;
	kFFTRadix5					= 2;

	{	
	———————————————————————————————————————————————————————————————————————————————
	    The criteria to invoke the PowerPC vector implementation is subject to     
	    change and become less restrictive in the future.                          
	———————————————————————————————————————————————————————————————————————————————
		}
	{	
	———————————————————————————————————————————————————————————————————————————————
	    Functions create_fftsetup and destroy_fftsetup.
	
	    create_fftsetup will allocate memory and setup a weight array used by      
	    the FFT. The call destroy_fftsetup will free the array.                    
	———————————————————————————————————————————————————————————————————————————————
		}
	{
	 *  create_fftsetup()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in vecLib 1.0 and later
	 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION create_fftsetup(log2n: UInt32; radix: FFTRadix): FFTSetup; C;

{
 *  destroy_fftsetup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE destroy_fftsetup(setup: FFTSetup); C;



{
———————————————————————————————————————————————————————————————————————————————
    Functions ctoz and ztoc.
    
    ctoz converts a complex array to a complex-split array
    ztoc converts a complex-split array to a complex array
    
    Criteria to invoke PowerPC vector code:    
        1. size > 3
        2. strideC = 2
        3. strideZ = 1
        4. Z.realp and Z.imagp are relatively aligned.
        5. C is 8-byte aligned if Z.realp and Z.imagp are 4-byte- aligned
           or C is 16-byte aligned if Z.realp and Z.imagp are at least
           8-byte aligned.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  ctoz()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ctoz({CONST}VAR C: DSPComplex; strideC: SInt32; VAR Z: DSPSplitComplex; strideZ: SInt32; size: UInt32); C;

{
 *  ztoc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ztoc({CONST}VAR Z: DSPSplitComplex; strideZ: SInt32; VAR C: DSPComplex; strideC: SInt32; size: UInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Functions fft_zip and fft_zipt 
    
    In-place Split Complex Fourier Transform with or without temporary memory.
            
      Criteria to invoke PowerPC vector code:    
        
        1. ioData.realp and ioData.imagp must be 16-byte aligned.
        2. stride = 1
        3. 2 <= log2n <= 20
        4. bufferTemp.realp and bufferTemp.imagp must be 16-byte aligned.
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.  The size of temporary memory for each part
      is the lower value of 4*n and 16k.  Direction can be either
      kFFTDirection_Forward or kFFTDirection_Inverse.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  fft_zip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE fft_zip(setup: FFTSetup; VAR ioData: DSPSplitComplex; stride: SInt32; log2n: UInt32; direction: FFTDirection); C;

{
 *  fft_zipt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE fft_zipt(setup: FFTSetup; VAR ioData: DSPSplitComplex; stride: SInt32; VAR bufferTemp: DSPSplitComplex; log2n: UInt32; direction: FFTDirection); C;



{
———————————————————————————————————————————————————————————————————————————————
     Functions fft_zop and fft_zopt
     
     Out-of-place Split Complex Fourier Transform with or without temporary
     memory
            
      Criteria to invoke PowerPC vector code:  
        
        1. signal.realp and signal.imagp must be 16-byte aligned.
        2. signalStride = 1
        3. result.realp and result.imagp must be 16-byte aligned.
        4. strideResult = 1
        5. 2 <= log2n <= 20
        6. bufferTemp.realp and bufferTemp.imagp must be 16-byte aligned.
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.  The size of temporary memory for each part
      is the lower value of 4*n and 16k.  Direction can be either
      kFFTDirection_Forward or kFFTDirection_Inverse.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  fft_zop()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE fft_zop(setup: FFTSetup; VAR signal: DSPSplitComplex; signalStride: SInt32; VAR result: DSPSplitComplex; strideResult: SInt32; log2n: UInt32; direction: FFTDirection); C;

{
 *  fft_zopt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE fft_zopt(setup: FFTSetup; VAR signal: DSPSplitComplex; signalStride: SInt32; VAR result: DSPSplitComplex; strideResult: SInt32; VAR bufferTemp: DSPSplitComplex; log2n: UInt32; direction: FFTDirection); C;



{
———————————————————————————————————————————————————————————————————————————————
    Functions fft_zrip and fft_zript
    
    In-Place Real Fourier Transform with or without temporary memory,
    split Complex Format
            
      Criteria to invoke PowerPC vector code:    
        1. ioData.realp and ioData.imagp must be 16-byte aligned.
        2. stride = 1
        3. 3 <= log2n <= 13
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.  The size of temporary memory for each part
      is the lower value of 4*n and 16k.  Direction can be either
      kFFTDirection_Forward or kFFTDirection_Inverse.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  fft_zrip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE fft_zrip(setup: FFTSetup; VAR ioData: DSPSplitComplex; stride: SInt32; log2n: UInt32; direction: FFTDirection); C;

{
 *  fft_zript()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE fft_zript(setup: FFTSetup; VAR ioData: DSPSplitComplex; stride: SInt32; VAR bufferTemp: DSPSplitComplex; log2n: UInt32; direction: FFTDirection); C;



{
———————————————————————————————————————————————————————————————————————————————
    Functions fft_zrop and fft_zropt
    
    Out-of-Place Real Fourier Transform with or without temporary memory,
    split Complex Format
            
      Criteria to invoke PowerPC vector code:  
        1. signal.realp and signal.imagp must be 16-byte aligned.
        2. signalStride = 1
        3. result.realp and result.imagp must be be 16-byte aligned.
        4. strideResult = 1
        5. 3 <= log2n <= 13
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.  The size of temporary memory for each part
      is the lower value of 4*n and 16k.  Direction can be either
      kFFTDirection_Forward or kFFTDirection_Inverse.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  fft_zrop()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE fft_zrop(setup: FFTSetup; VAR signal: DSPSplitComplex; signalStride: SInt32; VAR result: DSPSplitComplex; strideResult: SInt32; log2n: UInt32; direction: FFTDirection); C;

{
 *  fft_zropt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE fft_zropt(setup: FFTSetup; VAR signal: DSPSplitComplex; signalStride: SInt32; VAR result: DSPSplitComplex; strideResult: SInt32; VAR bufferTemp: DSPSplitComplex; log2n: UInt32; direction: FFTDirection); C;



{
———————————————————————————————————————————————————————————————————————————————
    Functions fft2d_zip and fft2d_zipt
    
    In-place two dimensional Split Complex Fourier Transform with or without
    temporary memory
            
      Criteria to invoke PowerPC vector code:  
        1. ioData.realp and ioData.imagp must be 16-byte aligned.
        2. strideInRow = 1;
        3. strideInCol must be a multiple of 4
        4. 2 <= log2nInRow <= 12
        5. 2 <= log2nInCol <= 12
        6. bufferTemp.realp and bufferTemp.imagp must be 16-byte aligned.
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.  The size of temporary memory for each part
      is the lower value of 4*n and 16k.  ( log2n = log2nInRow + log2nInCol ) 
      Direction can be either kFFTDirection_Forward or kFFTDirection_Inverse.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  fft2d_zip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE fft2d_zip(setup: FFTSetup; VAR ioData: DSPSplitComplex; strideInRow: SInt32; strideInCol: SInt32; log2nInCol: UInt32; log2nInRow: UInt32; direction: FFTDirection); C;

{
 *  fft2d_zipt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE fft2d_zipt(setup: FFTSetup; VAR ioData: DSPSplitComplex; strideInRow: SInt32; strideInCol: SInt32; VAR bufferTemp: DSPSplitComplex; log2nInCol: UInt32; log2nInRow: UInt32; direction: FFTDirection); C;



{
———————————————————————————————————————————————————————————————————————————————
    Functions fft2d_zop and fft2d_zopt
    
    Out-of-Place two dimemsional Split Complex Fourier Transform with or
    without temporary memory
            
      Criteria to invoke PowerPC vector code:  
        
        1. signal.realp and signal.imagp must be 16-byte aligned.
        2. signalStrideInRow = 1;
        3. signalStrideInCol must be a multiple of 4
        4. result.realp and result.imagp must be 16-byte aligned.
        5. strideResultInRow = 1;
        6. strideResultInCol must be a multiple of 4
        7. 2 <= log2nInRow <= 12
        8. 2 <= log2nInCol <= 12
        9. bufferTemp.realp and bufferTemp.imagp must be 16-byte aligned.

      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.  The size of temporary memory for each part
      is the lower value of 4*n and 16k.  ( log2n = log2nInRow + log2nInCol ) 
      Direction can be either kFFTDirection_Forward or kFFTDirection_Inverse.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  fft2d_zop()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE fft2d_zop(setup: FFTSetup; VAR signal: DSPSplitComplex; signalStrideInRow: SInt32; signalStrideInCol: SInt32; VAR result: DSPSplitComplex; strideResultInRow: SInt32; strideResultInCol: SInt32; log2nInCol: UInt32; log2nInRow: UInt32; flag: SInt32); C;

{
 *  fft2d_zopt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE fft2d_zopt(setup: FFTSetup; VAR signal: DSPSplitComplex; signalStrideInRow: SInt32; signalStrideInCol: SInt32; VAR result: DSPSplitComplex; strideResultInRow: SInt32; strideResultInCol: SInt32; VAR bufferTemp: DSPSplitComplex; log2nInCol: UInt32; log2nInRow: UInt32; flag: SInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Functions fft2d_zrip and fft2d_zript
    
    In-place two dimensional Real Fourier Transform with or without temporary
    memory, Split Complex Format
            
      Criteria to invoke PowerPC vector code:  
        1. ioData.realp and ioData.imagp must be 16-byte aligned.
        2. strideInRow = 1;
        3. strideInCol must be a multiple of 4
        4. 3 <= log2nInRow <= 12
        5. 3 <= log2nInCol <= 13
        6. bufferTemp.realp and bufferTemp.imagp must be 16-byte aligned.

      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.  The size of temporary memory for each part
      is the lower value of 4*n and 16k.  ( log2n = log2nInRow + log2nInCol ) 
      Direction can be either kFFTDirection_Forward or kFFTDirection_Inverse.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  fft2d_zrip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE fft2d_zrip(setup: FFTSetup; VAR ioData: DSPSplitComplex; strideInRow: SInt32; strideInCol: SInt32; log2nInCol: UInt32; log2nInRow: UInt32; direction: FFTDirection); C;

{
 *  fft2d_zript()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE fft2d_zript(setup: FFTSetup; VAR ioData: DSPSplitComplex; strideInRow: SInt32; strideInCol: SInt32; VAR bufferTemp: DSPSplitComplex; log2nInCol: UInt32; log2nInRow: UInt32; direction: FFTDirection); C;



{
———————————————————————————————————————————————————————————————————————————————
    Functions fft2d_zrop and fft2d_zropt
    
    Out-of-Place Two-Dimemsional Real Fourier Transform with or without
    temporary memory, Split Complex Format
            
      Criteria to invoke PowerPC vector code:  
        1. signal.realp and signal.imagp must be 16-byte aligned.
        2. signalStrideInRow = 1;
        3. signalStrideInCol must be a multiple of 4
        4. result.realp and result.imagp must be 16-byte aligned.
        5. strideResultInRow = 1;
        6. strideResultInCol must be a multiple of 4
        7. 3 <= log2nInRow <= 12
        8. 3 <= log2nInCol <= 13
        9. bufferTemp.realp and bufferTemp.imagp must be 16-byte aligned.

      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.  The size of temporary memory for each part
      is the lower value of 4*n and 16k.  ( log2n = log2nInRow + log2nInCol ) 
      Direction can be either kFFTDirection_Forward or kFFTDirection_Inverse.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  fft2d_zrop()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE fft2d_zrop(setup: FFTSetup; VAR signal: DSPSplitComplex; signalStrideInRow: SInt32; signalStrideInCol: SInt32; VAR result: DSPSplitComplex; strideResultInRow: SInt32; strideResultInCol: SInt32; log2nInCol: UInt32; log2nInRow: UInt32; flag: SInt32); C;

{
 *  fft2d_zropt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE fft2d_zropt(setup: FFTSetup; VAR signal: DSPSplitComplex; signalStrideInRow: SInt32; signalStrideInCol: SInt32; VAR result: DSPSplitComplex; strideResultInRow: SInt32; strideResultInCol: SInt32; VAR bufferTemp: DSPSplitComplex; log2nInCol: UInt32; log2nInRow: UInt32; flag: SInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Function conv
    
    Floating Point Convolution and Correlation
      
      Criteria to invoke PowerPC vector code:  
        1. signal and result must have relative alignement.
        2. 4 <= lenFilter <= 256
        3. lenResult > 36
        4. signalStride = 1
        5. strideResult = 1
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.  strideFilter can be positive for
      correlation or negative for convolution.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  conv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE conv({CONST}VAR signal: Single; signalStride: SInt32; {CONST}VAR filter: Single; strideFilter: SInt32; VAR result: Single; strideResult: SInt32; lenResult: SInt32; lenFilter: SInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Function vadd
    
    Floating Point Add
    
      Criteria to invoke PowerPC vector code:  
        1. input1 and input2 and result are all relatively aligned.
        2. size >= 8
        3. stride1 = 1
        4. stride2 = 1
        5. strideResult = 1
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  vadd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE vadd({CONST}VAR input1: Single; stride1: SInt32; {CONST}VAR input2: Single; stride2: SInt32; VAR result: Single; strideResult: SInt32; size: UInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Function vsub
    
     Floating Point Substract
      
      Criteria to invoke PowerPC vector code:  
        1. input1 and input2 and result are all relatively aligned.
        2. size >= 8
        3. stride1 = 1
        4. stride2 = 1
        5. strideResult = 1
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  vsub()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE vsub({CONST}VAR input1: Single; stride1: SInt32; {CONST}VAR input2: Single; stride2: SInt32; VAR result: Single; strideResult: SInt32; size: UInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Function vmul
    
    Floating Point Multiply
    
      Criteria to invoke PowerPC vector code:  
        1. input1 and input2 and result must be all relatively aligned.
        2. size >= 8
        3. stride1 = 1
        4. stride2 = 1
        5. strideResult = 1
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  vmul()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE vmul({CONST}VAR input1: Single; stride1: SInt32; {CONST}VAR input2: Single; stride2: SInt32; VAR result: Single; strideResult: SInt32; size: UInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Function vsmul
    
    Floating Point - Scalar Multiply
    
      Criteria to invoke PowerPC vector code:  
        1. input1 and result are all relatively aligned.
        2. size >= 8
        3. stride1 = 1
        5. strideResult = 1
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  vsmul()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE vsmul({CONST}VAR input1: Single; stride1: SInt32; {CONST}VAR input2: Single; VAR result: Single; strideResult: SInt32; size: UInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Function vsq
    
    Floating Point Square
      
      Criteria to invoke PowerPC vector code:  
        1. input and result are relatively aligned.
        2. size >= 8
        3. strideInput = 1
        4. strideResult = 1
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  vsq()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE vsq({CONST}VAR input: Single; strideInput: SInt32; VAR result: Single; strideResult: SInt32; size: UInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Function vssq
    
    Floating Point Signed Square
      
      Criteria to invoke PowerPC vector code:  
        1. input and result must be all relatively aligned.
        2. size >= 8
        3. strideInput = 1
        4. strideResult = 1
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  vssq()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE vssq({CONST}VAR input: Single; strideInput: SInt32; VAR result: Single; strideResult: SInt32; size: UInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Function dotpr
    
    Floating Point Dot product
    
      Criteria to invoke PowerPC vector code:  
        1. input1 and input2 are relatively aligned.
        2. size >= 20
        3. stride1 = 1
        4. stride2 = 1
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  dotpr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE dotpr({CONST}VAR input1: Single; stride1: SInt32; {CONST}VAR input2: Single; stride2: SInt32; VAR result: Single; size: UInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Function vam
    
    Floating Point vadd and Multiply
    
      Criteria to invoke PowerPC vector code:  
        1. input1, input2, input_3 and result are all relatively aligned.
        2. size >= 8
        3. stride1 = 1
        4. stride2 = 1
        5. stride_3 = 1
        6. strideResult = 1
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  vam()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE vam({CONST}VAR input1: Single; stride1: SInt32; {CONST}VAR input2: Single; stride2: SInt32; {CONST}VAR input3: Single; stride3: SInt32; VAR result: Single; strideResult: SInt32; size: UInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Function zconv
    
    Split Complex Convolution and Correlation
      
      Criteria to invoke PowerPC vector code:  
        1. signal->realp, signal->imagp, result->realp, result->imagp
           must be relatively aligned.
        2. 4 <= lenFilter <= 128
        3. lenResult > 20
        4. signalStride = 1
        5. strideResult = 1
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.  strideFilter can be positive for correlation
      or negative for convolution
———————————————————————————————————————————————————————————————————————————————
}
{
 *  zconv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE zconv(VAR signal: DSPSplitComplex; signalStride: SInt32; VAR filter: DSPSplitComplex; strideFilter: SInt32; VAR result: DSPSplitComplex; strideResult: SInt32; lenResult: SInt32; lenFilter: SInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Function zvadd
    
    Split Complex vadd
      
      Criteria to invoke PowerPC vector code:  
        1. input1.realp, input1.imagp, input2.realp, input2.imagp,
           result.realp, result.imagp must be all relatively aligned.
        2. size >= 8
        3. stride1 = 1
        4. stride2 = 1
        5. strideResult = 1
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  zvadd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE zvadd(VAR input1: DSPSplitComplex; stride1: SInt32; VAR input2: DSPSplitComplex; stride2: SInt32; VAR result: DSPSplitComplex; strideResult: SInt32; size: UInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Function zvsub
    
    Split Complex Substract
      
      Criteria to invoke PowerPC vector code:  
        1. input1.realp, input1.imagp, input2.realp, input2.imagp,
           result.realp, result.imagp must be all relatively aligned.
        2. size >= 8
        3. stride1 = 1
        4. stride2 = 1
        5. strideResult = 1
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  zvsub()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE zvsub(VAR input1: DSPSplitComplex; stride1: SInt32; VAR input2: DSPSplitComplex; stride2: SInt32; VAR result: DSPSplitComplex; strideResult: SInt32; size: UInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Function zvmul
    
    Split Complex Multiply
      
      Criteria to invoke PowerPC vector code:  
        1. input1.realp, input1.imagp, input2.realp, input2.imagp,
           result.realp, result.imagp must be all relatively aligned.
        2. size >= 8
        3. stride1 = 1
        4. stride2 = 1
        5. strideResult = 1

      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.  The conjugate value can be 1 or -1.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  zvmul()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE zvmul(VAR input1: DSPSplitComplex; stride1: SInt32; VAR input2: DSPSplitComplex; stride2: SInt32; VAR result: DSPSplitComplex; strideResult: SInt32; size: UInt32; conjugate: SInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Function zdotpr
    
    Split Complex Dot product
    
      Criteria to invoke PowerPC vector code:  
        1. input1.realp, input1.imagp, input2.realp, input2.imagp are all
           relatively aligned.
        2. size >= 20
        3. stride1 = 1
        4. stride2 = 1
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  zdotpr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE zdotpr(VAR input1: DSPSplitComplex; stride1: SInt32; VAR input2: DSPSplitComplex; stride2: SInt32; VAR result: DSPSplitComplex; size: UInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Function zidotpr
    
    Split Complex Inner Dot product
    
      Criteria to invoke PowerPC vector code:  
        1. input1.realp, input1.imagp, input2.realp, input2.imagp must be
           all relatively aligned.
        2. size >= 20
        3. stride1 = 1
        4. stride2 = 1
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  zidotpr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE zidotpr(VAR input1: DSPSplitComplex; stride1: SInt32; VAR input2: DSPSplitComplex; stride2: SInt32; VAR result: DSPSplitComplex; size: UInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Function zrdotpr
    
    Split Complex - Real Dot product
      
      Criteria to invoke PowerPC vector code:  
        1. input1.realp, input1.imagp, input2 are must be relatively aligned.
        2. size >= 16
        3. stride1 = 1
        4. stride2 = 1
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  zrdotpr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE zrdotpr(VAR input1: DSPSplitComplex; stride1: SInt32; {CONST}VAR input2: Single; stride2: SInt32; VAR result: DSPSplitComplex; size: UInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Function zvcma
    
    Split Complex Conjugate Multiply And vadd
    
      Criteria to invoke PowerPC vector code:  
        1. input1.realp, input1.imagp, input2.realp, input2.imagp,
          input_3.realp, input_3.imagp, result.realp, result.imagp
          must be all relatively aligned.
        2. size >= 8
        3. stride1 = 1
        4. stride2 = 1
        5. stride_3 = 1
        6. strideResult = 1
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  zvcma()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE zvcma(VAR input1: DSPSplitComplex; stride1: SInt32; VAR input2: DSPSplitComplex; stride2: SInt32; VAR input3: DSPSplitComplex; stride3: SInt32; VAR result: DSPSplitComplex; strideResult: SInt32; size: UInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Function zrvadd
    
    Split Complex - Real Add
      
      Criteria to invoke PowerPC vector code:  
        1. input1.realp, input1.imagp, input2, result.realp, result.imagp
           are all relatively aligned.
        2. size >= 8
        3. stride1 = 1
        4. stride2 = 1
        5. strideResult = 1
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  zrvadd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE zrvadd(VAR input1: DSPSplitComplex; stride1: SInt32; {CONST}VAR input2: Single; stride2: SInt32; VAR result: DSPSplitComplex; strideResult: SInt32; size: UInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Function zrvsub
    
    Split Complex - Real Substract
    
      Criteria to invoke PowerPC vector code:  
        1. input1.realp, input1.imagp, input2, result.realp, result.imagp
           must be all relatively aligned.
        2. size >= 8
        3. stride1 = 1
        4. stride2 = 1
        5. strideResult = 1
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  zrvsub()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE zrvsub(VAR input1: DSPSplitComplex; stride1: SInt32; {CONST}VAR input2: Single; stride2: SInt32; VAR result: DSPSplitComplex; strideResult: SInt32; size: UInt32); C;



{
———————————————————————————————————————————————————————————————————————————————
    Function zrvmul
    
    Split Complex - Real Multiply
    
      Criteria to invoke PowerPC vector code:  
        1. input1.realp, input1.imagp, input2, result.realp, result.imagp
           must be all relatively aligned.
        2. size >= 8
        3. stride1 = 1
        4. stride2 = 1
        5. strideResult = 1
      
      If any of the above criteria are not satisfied, the PowerPC scalor code
      implementation will be used.
———————————————————————————————————————————————————————————————————————————————
}
{
 *  zrvmul()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in vecLib 1.0 and later
 *    CarbonLib:        not in Carbon, but vecLib is compatible with Carbon
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE zrvmul(VAR input1: DSPSplitComplex; stride1: SInt32; {CONST}VAR input2: Single; stride2: SInt32; VAR result: DSPSplitComplex; strideResult: SInt32; size: UInt32); C;




{$IFC UNDEFINED USE_NONE_APPLE_STANDARD_DATATYPES }
{$SETC USE_NONE_APPLE_STANDARD_DATATYPES := 1 }
{$ENDC}

{$IFC USE_NONE_APPLE_STANDARD_DATATYPES }

CONST
	FFT_FORWARD					= 1;
	FFT_INVERSE					= -1;

	FFT_RADIX2					= 0;
	FFT_RADIX3					= 1;
	FFT_RADIX5					= 2;


TYPE
	COMPLEX								= DSPComplex;
	COMPLEXPtr 							= ^COMPLEX;
	COMPLEX_SPLIT						= DSPSplitComplex;
	COMPLEX_SPLITPtr 					= ^COMPLEX_SPLIT;
{$ENDC}  {USE_NONE_APPLE_STANDARD_DATATYPES}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := vDSPIncludes}

{$ENDC} {__VDSP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
