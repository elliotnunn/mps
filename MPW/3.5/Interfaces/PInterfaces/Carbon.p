{
     File:       Carbon.p
 
     Contains:   Master include for all of Carbon
 
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
 UNIT Carbon;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CARBON__}
{$SETC __CARBON__ := 1}

{$I+}
{$SETC CarbonIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CORESERVICES__}
{$I CoreServices.p}
{$ENDC}
{$IFC UNDEFINED __APPLICATIONSERVICES__}
{$I ApplicationServices.p}
{$ENDC}

{$IFC UNDEFINED __APPLICATIONSERVICES__}
{$I ApplicationServices.p}
{$ENDC}
{$IFC UNDEFINED __BALLOONS__}
{$I Balloons.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __PROCESSES__}
{$I Processes.p}
{$ENDC}
{$IFC UNDEFINED __NOTIFICATION__}
{$I Notification.p}
{$ENDC}
{$IFC UNDEFINED __DRAG__}
{$I Drag.p}
{$ENDC}
{$IFC UNDEFINED __ICONS__}
{$I Icons.p}
{$ENDC}
{$IFC UNDEFINED __CONTROLS__}
{$I Controls.p}
{$ENDC}
{$IFC UNDEFINED __APPEARANCE__}
{$I Appearance.p}
{$ENDC}
{$IFC UNDEFINED __MACWINDOWS__}
{$I MacWindows.p}
{$ENDC}
{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __LISTS__}
{$I Lists.p}
{$ENDC}
{$IFC UNDEFINED __CARBONEVENTS__}
{$I CarbonEvents.p}
{$ENDC}
{$IFC UNDEFINED __TEXTSERVICES__}
{$I TextServices.p}
{$ENDC}
{$IFC UNDEFINED __SCRAP__}
{$I Scrap.p}
{$ENDC}
{$IFC UNDEFINED __MACTEXTEDITOR__}
{$I MacTextEditor.p}
{$ENDC}
{$IFC UNDEFINED __MACHELP__}
{$I MacHelp.p}
{$ENDC}
{$IFC UNDEFINED __CONTROLDEFINITIONS__}
{$I ControlDefinitions.p}
{$ENDC}
{$IFC UNDEFINED __TSMTE__}
{$I TSMTE.p}
{$ENDC}
{$IFC UNDEFINED __TRANSLATIONEXTENSIONS__}
{$I TranslationExtensions.p}
{$ENDC}
{$IFC UNDEFINED __TRANSLATION__}
{$I Translation.p}
{$ENDC}
{$IFC UNDEFINED __AEINTERACTION__}
{$I AEInteraction.p}
{$ENDC}
{$IFC UNDEFINED __TYPESELECT__}
{$I TypeSelect.p}
{$ENDC}
{$IFC UNDEFINED __INTERNETCONFIG__}
{$I InternetConfig.p}
{$ENDC}
{$IFC UNDEFINED __MACAPPLICATION__}
{$I MacApplication.p}
{$ENDC}
{$IFC UNDEFINED __KEYBOARDS__}
{$I Keyboards.p}
{$ENDC}
{$IFC UNDEFINED __SOUND__}
{$I Sound.p}
{$ENDC}
{$IFC UNDEFINED __OSA__}
{$I OSA.p}
{$ENDC}
{$IFC UNDEFINED __OSACOMP__}
{$I OSAComp.p}
{$ENDC}
{$IFC UNDEFINED __OSAGENERIC__}
{$I OSAGeneric.p}
{$ENDC}
{$IFC UNDEFINED __APPLESCRIPT__}
{$I AppleScript.p}
{$ENDC}
{$IFC UNDEFINED __ASDEBUGGING__}
{$I ASDebugging.p}
{$ENDC}
{$IFC UNDEFINED __ASREGISTRY__}
{$I ASRegistry.p}
{$ENDC}
{$IFC UNDEFINED __FINDERREGISTRY__}
{$I FinderRegistry.p}
{$ENDC}
{$IFC UNDEFINED __PMAPPLICATION__}
{$I PMApplication.p}
{$ENDC}
{$IFC UNDEFINED __NAVIGATION__}
{$I Navigation.p}
{$ENDC}
{$IFC UNDEFINED __URLACCESS__}
{$I URLAccess.p}
{$ENDC}
{$IFC UNDEFINED __COLORPICKER__}
{$I ColorPicker.p}
{$ENDC}
{$IFC UNDEFINED __CMCALIBRATOR__}
{$I CMCalibrator.p}
{$ENDC}
{$IFC UNDEFINED __HTMLRENDERING__}
{$I HTMLRendering.p}
{$ENDC}
{$IFC UNDEFINED __SPEECHRECOGNITION__}
{$I SpeechRecognition.p}
{$ENDC}
{$IFC UNDEFINED __NSL__}
{$I NSL.p}
{$ENDC}
{$IFC UNDEFINED __KEYCHAINHI__}
{$I KeychainHI.p}
{$ENDC}
{$IFC UNDEFINED __IBCARBONRUNTIME__}
{$I IBCarbonRuntime.p}
{$ENDC}
{$IFC UNDEFINED __APPLEHELP__}
{$I AppleHelp.p}
{$ENDC}
{$IFC UNDEFINED __ICAAPPLICATION__}
{$I ICAApplication.p}
{$ENDC}
{$IFC UNDEFINED __ICADEVICE__}
{$I ICADevice.p}
{$ENDC}
{$IFC UNDEFINED __ICACAMERA__}
{$I ICACamera.p}
{$ENDC}



{$SETC UsingIncludes := CarbonIncludes}

{$ENDC} {__CARBON__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
