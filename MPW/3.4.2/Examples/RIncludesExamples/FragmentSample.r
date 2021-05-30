
/*
  FragmentSample.r
  -- a sample 'cfrg' resource definition.
  
  
  For PowerPC native import libraries and applications, make a cfrg resource.
  For Applications be sure to use kIsApp and not kIsLib.
  For Import Libraries be sure to use kIsLib not kIsApp.
  
  For application plug ins, see the conventions established by the application vendor.
  
  Making an import library:
  Rez -i : Types.r CodeFragmentTypes.r {Active} -a -o myLib -t shlb -c cfrg
  SetFile myLib -a iB

  Making an application:
  Rez Types.r CodeFragmentTypes.r {Active} -a -o Application -t APPL

  This example is customized for building an application "MyApp"

  Change all occurences of  MyApp  to  YourApp   or YourLib
  NOTE: ID must be zero.  

*/

resource 'cfrg' (0) {
   {
      kPowerPC,
      kFullLib,
	  kNoVersionNum,kNoVersionNum,
	  kDefaultStackSize, kNoAppSubFolder,
	  kIsApp,kOnDiskFlat,kZeroOffset,kWholeFork,
	  "MyApp"
   }
};

