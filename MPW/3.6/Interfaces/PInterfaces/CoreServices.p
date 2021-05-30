{
     File:       CoreServices.p
 
     Contains:   Master include for CoreServices (non-UI toolbox)
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CoreServices;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CORESERVICES__}
{$SETC __CORESERVICES__ := 1}

{$I+}
{$SETC CoreServicesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{
   By default using this header means you are building code for carbon.
   You can override this by setting TARGET_API_MAC_CARBON to zero before
   including this file
}
{$IFC UNDEFINED TARGET_API_MAC_CARBON }
{$SETC TARGET_API_MAC_CARBON := 1 }
{$ENDC}


{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FINDER__}
{$I Finder.p}
{$ENDC}
{$IFC UNDEFINED __FIXMATH__}
{$I FixMath.p}
{$ENDC}
{$IFC UNDEFINED __SCRIPT__}
{$I Script.p}
{$ENDC}
{$IFC UNDEFINED __UTCUTILS__}
{$I UTCUtils.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}
{$IFC UNDEFINED __COLLECTIONS__}
{$I Collections.p}
{$ENDC}
{$IFC UNDEFINED __ENDIAN__}
{$I Endian.p}
{$ENDC}
{$IFC UNDEFINED __PATCHES__}
{$I Patches.p}
{$ENDC}
{$IFC UNDEFINED __GESTALTEQU__}
{$I GestaltEqu.p}
{$ENDC}
{$IFC UNDEFINED __MACMEMORY__}
{$I MacMemory.p}
{$ENDC}
{$IFC UNDEFINED __MATH64__}
{$I Math64.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __RESOURCES__}
{$I Resources.p}
{$ENDC}
{$IFC UNDEFINED __CODEFRAGMENTS__}
{$I CodeFragments.p}
{$ENDC}
{$IFC UNDEFINED __ALIASES__}
{$I Aliases.p}
{$ENDC}
{$IFC UNDEFINED __MACLOCALES__}
{$I MacLocales.p}
{$ENDC}
{$IFC UNDEFINED __DEBUGGING__}
{$I Debugging.p}
{$ENDC}
{$IFC UNDEFINED __PLSTRINGFUNCS__}
{$I PLStringFuncs.p}
{$ENDC}
{$IFC UNDEFINED __DRIVERSYNCHRONIZATION__}
{$I DriverSynchronization.p}
{$ENDC}
{$IFC UNDEFINED __DEVICES__}
{$I Devices.p}
{$ENDC}
{$IFC UNDEFINED __DRIVERSERVICES__}
{$I DriverServices.p}
{$ENDC}
{$IFC UNDEFINED __INTLRESOURCES__}
{$I IntlResources.p}
{$ENDC}
{$IFC UNDEFINED __NUMBERFORMATTING__}
{$I NumberFormatting.p}
{$ENDC}
{$IFC UNDEFINED __DATETIMEUTILS__}
{$I DateTimeUtils.p}
{$ENDC}
{$IFC UNDEFINED __STRINGCOMPARE__}
{$I StringCompare.p}
{$ENDC}
{$IFC UNDEFINED __TEXTUTILS__}
{$I TextUtils.p}
{$ENDC}
{$IFC UNDEFINED __TOOLUTILS__}
{$I ToolUtils.p}
{$ENDC}
{$IFC UNDEFINED __NAMEREGISTRY__}
{$I NameRegistry.p}
{$ENDC}
{$IFC UNDEFINED __UNICODEUTILITIES__}
{$I UnicodeUtilities.p}
{$ENDC}
{$IFC UNDEFINED __FP__}
{$I fp.p}
{$ENDC}
{$IFC UNDEFINED __FENV__}
{$I fenv.p}
{$ENDC}
{$IFC UNDEFINED __TEXTENCODINGCONVERTER__}
{$I TextEncodingConverter.p}
{$ENDC}
{$IFC UNDEFINED __UNICODECONVERTER__}
{$I UnicodeConverter.p}
{$ENDC}
{$IFC UNDEFINED __THREADS__}
{$I Threads.p}
{$ENDC}
{$IFC UNDEFINED __FOLDERS__}
{$I Folders.p}
{$ENDC}
{$IFC UNDEFINED __TIMER__}
{$I Timer.p}
{$ENDC}
{$IFC UNDEFINED __MULTIPROCESSINGINFO__}
{$I MultiprocessingInfo.p}
{$ENDC}
{$IFC UNDEFINED __MULTIPROCESSING__}
{$I Multiprocessing.p}
{$ENDC}
{$IFC UNDEFINED __MACHINEEXCEPTIONS__}
{$I MachineExceptions.p}
{$ENDC}
{$IFC UNDEFINED __LOWMEM__}
{$I LowMem.p}
{$ENDC}
{$IFC UNDEFINED __AVLTREE__}
{$I AVLTree.p}
{$ENDC}
{$IFC UNDEFINED __PEFBINARYFORMAT__}
{$I PEFBinaryFormat.p}
{$ENDC}
{$IFC UNDEFINED __HFSVOLUMES__}
{$I HFSVolumes.p}
{$ENDC}
{$IFC UNDEFINED __AIFF__}
{$I AIFF.p}
{$ENDC}
{$IFC UNDEFINED __TEXTENCODINGPLUGIN__}
{$I TextEncodingPlugin.p}
{$ENDC}
{$IFC UNDEFINED __OPENTRANSPORT__}
{$I OpenTransport.p}
{$ENDC}
{$IFC UNDEFINED __OPENTRANSPORTPROVIDERS__}
{$I OpenTransportProviders.p}
{$ENDC}
{$IFC UNDEFINED __OPENTRANSPORTPROTOCOL__}
{$I OpenTransportProtocol.p}
{$ENDC}
{$IFC UNDEFINED __POWER__}
{$I Power.p}
{$ENDC}
{$IFC UNDEFINED __SCSI__}
{$I SCSI.p}
{$ENDC}
{$IFC UNDEFINED __APPLEDISKPARTITIONS__}
{$I AppleDiskPartitions.p}
{$ENDC}
{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}
{$IFC UNDEFINED __CFARRAY__}
{$I CFArray.p}
{$ENDC}
{$IFC UNDEFINED __CFBAG__}
{$I CFBag.p}
{$ENDC}
{$IFC UNDEFINED __CFBUNDLE__}
{$I CFBundle.p}
{$ENDC}
{$IFC UNDEFINED __CFCHARACTERSET__}
{$I CFCharacterSet.p}
{$ENDC}
{$IFC UNDEFINED __CFDATA__}
{$I CFData.p}
{$ENDC}
{$IFC UNDEFINED __CFDATE__}
{$I CFDate.p}
{$ENDC}
{$IFC UNDEFINED __CFDICTIONARY__}
{$I CFDictionary.p}
{$ENDC}
{$IFC UNDEFINED __CFNUMBER__}
{$I CFNumber.p}
{$ENDC}
{$IFC UNDEFINED __CFPLUGIN__}
{$I CFPlugIn.p}
{$ENDC}
{$IFC UNDEFINED __CFPREFERENCES__}
{$I CFPreferences.p}
{$ENDC}
{$IFC UNDEFINED __CFPROPERTYLIST__}
{$I CFPropertyList.p}
{$ENDC}
{$IFC UNDEFINED __CFSET__}
{$I CFSet.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRINGENCODINGEXT__}
{$I CFStringEncodingExt.p}
{$ENDC}
{$IFC UNDEFINED __CFTIMEZONE__}
{$I CFTimeZone.p}
{$ENDC}
{$IFC UNDEFINED __CFTREE__}
{$I CFTree.p}
{$ENDC}
{$IFC UNDEFINED __CFURL__}
{$I CFURL.p}
{$ENDC}
{$IFC UNDEFINED __CFURLACCESS__}
{$I CFURLAccess.p}
{$ENDC}
{$IFC UNDEFINED __CFUUID__}
{$I CFUUID.p}
{$ENDC}
{$IFC UNDEFINED __CFXMLNODE__}
{$I CFXMLNode.p}
{$ENDC}
{$IFC UNDEFINED __CFXMLPARSER__}
{$I CFXMLParser.p}
{$ENDC}
{$IFC UNDEFINED __NSLCORE__}
{$I NSLCore.p}
{$ENDC}
{$IFC UNDEFINED __KEYCHAINCORE__}
{$I KeychainCore.p}
{$ENDC}
{$SETC UsingIncludes := CoreServicesIncludes}

{$ENDC} {__CORESERVICES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
