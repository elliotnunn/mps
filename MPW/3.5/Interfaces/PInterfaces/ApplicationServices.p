{
     File:       ApplicationServices.p
 
     Contains:   Master include for ApplicationServices public framework
 
     Version:    Technology: Mac OS X
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
 UNIT ApplicationServices;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __APPLICATIONSERVICES__}
{$SETC __APPLICATIONSERVICES__ := 1}

{$I+}
{$SETC ApplicationServicesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CORESERVICES__}
{$I CoreServices.p}
{$ENDC}


{$IFC UNDEFINED __ATSLAYOUTTYPES__}
{$I ATSLayoutTypes.p}
{$ENDC}
{$IFC UNDEFINED __ATSFONT__}
{$I ATSFont.p}
{$ENDC}
{$IFC UNDEFINED __ATSTYPES__}
{$I ATSTypes.p}
{$ENDC}
{$IFC UNDEFINED __SCALERSTREAMTYPES__}
{$I ScalerStreamTypes.p}
{$ENDC}
{$IFC UNDEFINED __SCALERTYPES__}
{$I ScalerTypes.p}
{$ENDC}
{$IFC UNDEFINED __SFNTLAYOUTTYPES__}
{$I SFNTLayoutTypes.p}
{$ENDC}
{$IFC UNDEFINED __SFNTTYPES__}
{$I SFNTTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __QDOFFSCREEN__}
{$I QDOffscreen.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAWTEXT__}
{$I QuickdrawText.p}
{$ENDC}
{$IFC UNDEFINED __FONTS__}
{$I Fonts.p}
{$ENDC}
{$IFC UNDEFINED __PALETTES__}
{$I Palettes.p}
{$ENDC}
{$IFC UNDEFINED __PICTUTILS__}
{$I PictUtils.p}
{$ENDC}
{$IFC UNDEFINED __ATSUNICODE__}
{$I ATSUnicode.p}
{$ENDC}
{$IFC UNDEFINED __VIDEO__}
{$I Video.p}
{$ENDC}
{$IFC UNDEFINED __DISPLAYS__}
{$I Displays.p}
{$ENDC}
{$IFC UNDEFINED __FONTSYNC__}
{$I FontSync.p}
{$ENDC}
{$IFC UNDEFINED __AEDATAMODEL__}
{$I AEDataModel.p}
{$ENDC}
{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED __AEPACKOBJECT__}
{$I AEPackObject.p}
{$ENDC}
{$IFC UNDEFINED __AEOBJECTS__}
{$I AEObjects.p}
{$ENDC}
{$IFC UNDEFINED __AEREGISTRY__}
{$I AERegistry.p}
{$ENDC}
{$IFC UNDEFINED __AEUSERTERMTYPES__}
{$I AEUserTermTypes.p}
{$ENDC}
{$IFC UNDEFINED __AEHELPERS__}
{$I AEHelpers.p}
{$ENDC}
{$IFC UNDEFINED __AEMACH__}
{$I AEMach.p}
{$ENDC}
{$IFC UNDEFINED __CGBASE__}
{$I CGBase.p}
{$ENDC}
{$IFC UNDEFINED __CGAFFINETRANSFORM__}
{$I CGAffineTransform.p}
{$ENDC}
{$IFC UNDEFINED __CGBITMAPCONTEXT__}
{$I CGBitmapContext.p}
{$ENDC}
{$IFC UNDEFINED __CGCOLORSPACE__}
{$I CGColorSpace.p}
{$ENDC}
{$IFC UNDEFINED __CGCONTEXT__}
{$I CGContext.p}
{$ENDC}
{$IFC UNDEFINED __CGDATACONSUMER__}
{$I CGDataConsumer.p}
{$ENDC}
{$IFC UNDEFINED __CGDATAPROVIDER__}
{$I CGDataProvider.p}
{$ENDC}
{$IFC UNDEFINED __CGERROR__}
{$I CGError.p}
{$ENDC}
{$IFC UNDEFINED __CGDIRECTDISPLAY__}
{$I CGDirectDisplay.p}
{$ENDC}
{$IFC UNDEFINED __CGDIRECTPALETTE__}
{$I CGDirectPalette.p}
{$ENDC}
{$IFC UNDEFINED __CGREMOTEOPERATION__}
{$I CGRemoteOperation.p}
{$ENDC}
{$IFC UNDEFINED __CGWINDOWLEVEL__}
{$I CGWindowLevel.p}
{$ENDC}
{$IFC UNDEFINED __CGGEOMETRY__}
{$I CGGeometry.p}
{$ENDC}
{$IFC UNDEFINED __CGIMAGE__}
{$I CGImage.p}
{$ENDC}
{$IFC UNDEFINED __CGPDFCONTEXT__}
{$I CGPDFContext.p}
{$ENDC}
{$IFC UNDEFINED __CGPDFDOCUMENT__}
{$I CGPDFDocument.p}
{$ENDC}
{$IFC UNDEFINED __CMTYPES__}
{$I CMTypes.p}
{$ENDC}
{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}
{$IFC UNDEFINED __CMICCPROFILE__}
{$I CMICCProfile.p}
{$ENDC}
{$IFC UNDEFINED __CMDEVICEINTEGRATION__}
{$I CMDeviceIntegration.p}
{$ENDC}
{$IFC UNDEFINED __CMMCOMPONENT__}
{$I CMMComponent.p}
{$ENDC}
{$IFC UNDEFINED __CMSCRIPTINGPLUGIN__}
{$I CMScriptingPlugin.p}
{$ENDC}
{$IFC UNDEFINED __FINDBYCONTENT__}
{$I FindByContent.p}
{$ENDC}
{$IFC UNDEFINED __PMCORE__}
{$I PMCore.p}
{$ENDC}
{$IFC UNDEFINED __PMDEFINITIONS__}
{$I PMDefinitions.p}
{$ENDC}
{$IFC UNDEFINED __LANGUAGEANALYSIS__}
{$I LanguageAnalysis.p}
{$ENDC}
{$IFC UNDEFINED __DICTIONARY__}
{$I Dictionary.p}
{$ENDC}
{$IFC UNDEFINED __SPEECHSYNTHESIS__}
{$I SpeechSynthesis.p}
{$ENDC}
{$IFC UNDEFINED __LAUNCHSERVICES__}
{$I LaunchServices.p}
{$ENDC}
{$SETC UsingIncludes := ApplicationServicesIncludes}

{$ENDC} {__APPLICATIONSERVICES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
