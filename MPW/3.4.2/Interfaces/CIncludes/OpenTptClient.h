/*
	File:		OpenTptClient.h

	Contains:	headers for client development

	Copyright:	© 1993-1996 by Apple Computer, Inc. and Mentat Inc., all rights reserved.


*/

#ifndef __OPENTPTCLIENT__
#define __OPENTPTCLIENT__

#ifndef __OPENTPTCOMMON__
#include <OpenTptCommon.h>
#endif	
#ifndef __STROPTS__
#include <stropts.h>
#endif

#if defined(__MWERKS__) && GENERATING68K
#pragma pointers_in_D0
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif
#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

/*******************************************************************************
** Allocation functions
********************************************************************************/

#ifdef __cplusplus
extern "C" {
#endif

	extern void*	OTAllocSharedClientMem(size_t);
	extern void		OTFreeSharedClientMem(void*);

#ifdef __cplusplus
}
#endif

/*******************************************************************************
** STREAM APIs and Structures
********************************************************************************/

	typedef void*				StreamRef;

	#define kOTInvalidStreamRef		((StreamRef)0)
	
/*	-------------------------------------------------------------------------
	Autopush information
	
	The autopush functionality for Open Transport is based on the names of
	devices and modules, rather than on the major number information like 
	SVR4.  This is so that autopush information can be set up for modules
	that are not yet loaded.
	------------------------------------------------------------------------- */
	/*
	 * This is the name of the stream module you open and send the 
	 * IOCTL modules to.
	 */
	#define kSADModuleName	"sad"
	
	enum
	{
		kOTAutopushMax	= 8,
		
		I_SAD_SAP		= MIOC_CMD(MIOC_SAD, 1),	/* Set autopush information		*/
		I_SAD_GAP		= MIOC_CMD(MIOC_SAD, 2),	/* Get autopush information		*/
		I_SAD_VML		= MIOC_CMD(MIOC_SAD, 3)		/* Validate a list of modules 	*/
													/* (uses str_list structure		*/
													/*	in stropts.h)				*/
	};

	struct OTAutopushInfo			/* Ioctl structure used for SAD_SAP and SAD_GAP commands */
	{
		uint_t			sap_cmd;
		char			sap_device_name[kMaxModuleNameSize];
		long			sap_minor;
		long			sap_lastminor;
		long			sap_npush;
		char			sap_list[kOTAutopushMax][kMaxModuleNameSize];
	};
	
	typedef struct OTAutopushInfo	OTAutopushInfo;
	
	/*
	 * Command values for sap_cmd
	 */
	
	enum
	{
		kSAP_ONE			= 1,	/* Configure a single minor device			*/
		kSAP_RANGE			= 2,	/* Configure a range of minor devices		*/
		kSAP_ALL			= 3,	/* Configure all minor devices				*/
		kSAP_CLEAR			= 4		/* Clear autopush information				*/
	};
	
/*	-------------------------------------------------------------------------
	PollRef structure
	
	This is used with the OTStreamPoll function
	------------------------------------------------------------------------- */

	struct PollRef 
	{
		int_t	 	filler;
		short		events;
		short		revents;
		StreamRef 	ref;
	};
	
	typedef struct PollRef	PollRef;

/*	-------------------------------------------------------------------------
	OTReadInfo structure
	
	This is used with the various functions that read and peek at the 
	streamhead.
	------------------------------------------------------------------------- */

	struct OTReadInfo
	{
		UInt32		fType;
		OTCommand	fCommand;
		UInt32		fFiller;	/* For compatibility with OT 1.0 and 1.1 */
		size_t		fBytes;
		OSStatus	fError;
	};

	typedef struct OTReadInfo	OTReadInfo;
	
	/*	-------------------------------------------------------------------------
		Used in the fType field of OTReadInfo for functions
		------------------------------------------------------------------------- */

	enum
	{
		kOTNoMessagesAvailable	= 0xffffffffU,
			// Matches any message on requests, and indicates no
			// peeked message available on return.
		kOTAnyMsgType			= 0xfffffffeU,
			// Blows away any message not of type M_PROTO, M_PCPROTO or M_DATA
			// No match on OTCommand field
		kOTDataMsgTypes			= 0xfffffffcU,
			// Returns only M_PROTO or M_PCPROTO messages. 
			// Matches on OTCommand field, with special match for request = T_DATA_IND
			// and msg = T_EXDATA_IND.  Also, returns an M_DATA if T_DATA_IND or
			// T_UNITDATA_IND (or 0) is requested. Blows away all other message types.
			// If OTCommand is 0, matches any command.
		kOTMProtoMsgTypes		= 0xfffffffbU,
			// Exactly like kOTMProtoMsgTypes, except M_DATAs are also blown away
		kOTOnlyMProtoMsgTypes	= 0xfffffffaU
	};
	
	/*	-------------------------------------------------------------------------
		Use in PutCommand, PutData, and PutWriteData
		These equates must not conflict with any of the other putmsg flags
		MSG_ANY, MSG_BAND, MSG_HIPRI, or RS_HIPRI
		------------------------------------------------------------------------- */
	
	enum
	{
		RS_EXDATA		= 0x20,
		RS_ALLOWAGAIN	= 0x40,
		RS_DELIMITMSG	= 0x80
	};

/*	-------------------------------------------------------------------------
	The functions 
	------------------------------------------------------------------------- */

#ifdef __cplusplus
extern "C" {
#endif

	extern pascal StreamRef		OTStreamOpen(const char* name, OTOpenFlags, OSStatus*);
	extern pascal OSStatus		OTAsyncStreamOpen(const char* name, OTOpenFlags,
												  OTNotifyProcPtr, void* contextPtr);
	extern pascal StreamRef		OTCreateStream(OTConfiguration* cfig, OTOpenFlags, OSStatus*);
	extern pascal OSStatus		OTAsyncCreateStream(OTConfiguration* cfig, OTOpenFlags,
													OTNotifyProcPtr, void* contextPtr);
	extern pascal OTResult		OTStreamPoll(PollRef* fds, UInt32 nfds, OTTimeout timeout);
	extern pascal OTResult		OTAsyncStreamPoll(PollRef* fds, UInt32 nfds, OTTimeout timeout,
												  OTNotifyProcPtr, void* contextPtr);
	
	extern pascal OSStatus		OTStreamClose(StreamRef);
	extern pascal OTResult		OTStreamRead(StreamRef, void* buf, size_t len);
	extern pascal OTResult		OTStreamWrite(StreamRef, void* buf, size_t len);
	extern pascal OTResult		OTStreamIoctl(StreamRef, UInt32 type, void* data);
	extern pascal OTResult		OTStreamPipe(StreamRef*);
	extern pascal void			OTStreamSetBlocking(StreamRef);
	extern pascal void			OTStreamSetNonBlocking(StreamRef);
	extern pascal Boolean		OTStreamIsBlocking(StreamRef);
	extern pascal void			OTStreamSetSynchronous(StreamRef);
	extern pascal void			OTStreamSetAsynchronous(StreamRef);
	extern pascal Boolean		OTStreamIsSynchronous(StreamRef);
	extern pascal OTResult		OTStreamGetMessage(StreamRef, struct strbuf* ctlbuf,
												   struct strbuf* databuf, OTFlags*);
	extern pascal OTResult		OTStreamGetPriorityMessage(StreamRef, struct strbuf* ctlbuf,
														   struct strbuf* databuf, OTBand*, OTFlags*);
	extern pascal OSStatus		OTStreamPutMessage(StreamRef, const struct strbuf* ctlbuf,
									 const struct strbuf* databuf, OTFlags flags);
	extern pascal OSStatus		OTStreamPutPriorityMessage(StreamRef, const struct strbuf* ctlbuf,
														   const struct strbuf* databuf, OTBand, OTFlags);
	extern pascal OSStatus		OTStreamInstallNotifier(StreamRef, OTNotifyProcPtr, void* contextPtr);
	extern pascal void			OTStreamRemoveNotifier(StreamRef);
	extern pascal void			OTStreamSetControlMask(StreamRef ref, UInt32 mask, Boolean setClear);
	extern pascal OSStatus		OTStreamUseSyncIdleEvents(StreamRef, Boolean useEvents);
	/*
	 * Opening endpoints and mappers on a Stream - these calls are synchronous, and may
	 * only be used at System Task time. Once the stream has been installed into a provider
	 * or endpoint, you should not continue to use STREAMS APIs on it
	 */
	extern pascal ProviderRef	OTOpenProviderOnStream(StreamRef, OSStatus*);
	extern pascal EndpointRef	OTOpenEndpointOnStream(StreamRef, OSStatus*);
	/*
	 * Some functions that should only be used if you really know what you're doing.
	 */
	extern pascal StreamRef		OTRemoveStreamFromProvider(ProviderRef);
	extern pascal OSStatus		OTPeekMessage(StreamRef, OTReadInfo*);
	extern pascal OTBuffer*		OTReadMessage(StreamRef, OTReadInfo*);
	extern pascal void			OTPutBackBuffer(StreamRef, OTBuffer*);
	extern pascal void			OTPutBackPartialBuffer(StreamRef, OTBufferInfo*, OTBuffer*);

#ifdef __cplusplus
}
#endif

/*******************************************************************************
** Port functions
********************************************************************************/
		
#ifdef __cplusplus
extern "C" {
#endif
		//
		// Returns a buffer containing all of the clients that refused to yield the port.
		// "size" is the total number of bytes @ buffer, including the fNumClients field.
		//
	extern OSStatus	OTYieldPortRequest(ProviderRef, OTPortRef, OTClientList* buffer, size_t size);
		//
		// Send a notification to all Open Transport registered clients
		//
	extern void		OTNotifyAllClients(OTEventCode, OTResult, void* cookie);
		//
		// Determine if "child" is a child port of "parent"
		//
	extern Boolean	OTIsDependentPort(OTPortRef parent, OTPortRef child);

#ifdef __cplusplus
}
#endif

/*******************************************************************************
** Timer functions
********************************************************************************/

#ifdef __cplusplus
extern "C" {
#endif

	extern pascal long		OTCreateTimerTask(OTProcessProcPtr proc, void* arg);
	extern pascal Boolean	OTCancelTimerTask(long timerTask);
	extern pascal void		OTDestroyTimerTask(long timerTask);
	extern pascal Boolean	OTScheduleTimerTask(long timerTask, OTTimeout milliSeconds);

#ifdef __cplusplus
}
#endif

/*******************************************************************************
** Miscellaneous helpful functions
********************************************************************************/

#ifdef __cplusplus
extern "C" {
#endif

	extern Boolean			StoreIntoNetbuf(TNetbuf*, void*, long);
	extern Boolean			StoreMsgIntoNetbuf(TNetbuf*, OTBuffer* buf);
	extern void				OTReleaseBuffer(OTBuffer*);
	extern size_t			OTBufferDataSize(OTBuffer*);
	
	extern Boolean			OTReadBuffer(OTBufferInfo*, void*, size_t*);

#ifdef __cplusplus
}
#endif

/*******************************************************************************
** OTConfiguration
**
** This structure is used to describe a configuration.  
********************************************************************************/

	typedef struct OTConfiguration	OTConfiguration;
		
#ifdef __cplusplus
extern "C" {
#endif

	/*
	 * Manipulating a configuration
	 */
	extern OTConfiguration*	OTCfigNewConfiguration(const char* path);
	extern void				OTCfigDeleteConfiguration(OTConfiguration*);
	extern OTConfiguration*	OTCfigCloneConfiguration(OTConfiguration*);
	extern OTConfiguration*	OTCfigPushNewSingleChild(OTConfiguration*, const char* path, OSStatus*);
	extern OTConfiguration*	OTCfigPushParent(OTConfiguration*, const char* path, OSStatus*);
	extern OTConfiguration*	OTCfigPushChild(OTConfiguration*, size_t index, const char* path, OSStatus*);
	extern OSStatus			OTCfigPopChild(OTConfiguration*, size_t index);
	extern OTConfiguration*	OTCfigGetChild(OTConfiguration*, size_t index);
	extern OSStatus			OTCfigSetPath(OTConfiguration*, const char* path);
	extern OTConfiguration*	OTCfigNewChild(OTConfiguration*, const char* path, OSStatus*);
	extern OSStatus			OTCfigAddChild(OTConfiguration*, OTConfiguration* child);
	extern OTConfiguration*	OTCfigRemoveChild(OTConfiguration*, size_t index);
	extern void				OTCfigSetPortRef(OTConfiguration*, OTPortRef);
	extern void				OTCfigChangeProviderName(OTConfiguration*, const char* name);
	/*
	 * Query a configuration
	 */
	extern UInt16			OTCfigNumberOfChildren(OTConfiguration*);
	extern OTConfiguration*	OTCfigGetParent(OTConfiguration*);
	extern TNetbuf*			OTCfigGetOptionNetbuf(OTConfiguration*);
	extern OTPortRef		OTCfigGetPortRef(OTConfiguration*);
	extern UInt32			OTCfigGetInstallFlags(OTConfiguration*);
	extern const char*		OTCfigGetProviderName(OTConfiguration*);
	extern Boolean			OTCfigIsPort(OTConfiguration*);

#ifdef __cplusplus
}
#endif

/*******************************************************************************
** Configurator functions
********************************************************************************/

#ifdef __cplusplus
	class TOTConfigurator;
#else
	typedef struct TOTConfigurator	TOTConfigurator;
#endif

	//
	// Typedef for the OTCanConfigure function, and the enum for which pass we're doing.
	// The first (kOTSpecificConfigPass) is to give configurators a shot at the configuration
	// before we start allowing the generic configurators to get into the act.
	//
	enum
	{
		kOTSpecificConfigPass = 0, kOTGenericConfigPass = 1
	};
	
#ifdef __cplusplus
extern "C" {
#endif

	typedef Boolean			(*OTCanConfigureProcPtr)(OTConfiguration*, UInt32 pass);
	//
	// Typedef for the function to create and return a configurator object
	//
	typedef OSStatus		(*OTCreateConfiguratorProcPtr)(TOTConfigurator**);
	//
	// Typedef for the OTSetupConfigurator function that your configurator library must export.
	// The enum is for the type of configurator that it is.
	//
	enum
	{
		kOTDefaultConfigurator = 0, kOTProtocolFamilyConfigurator, kOTLinkDriverConfigurator
	};
	typedef OSStatus		(*OTSetupConfiguratorProcPtr)(OTCanConfigureProcPtr*,
														  OTCreateConfiguratorProcPtr*,
														  UInt8* type);
	
	typedef void (*OTCFHandleSystemEventProcPtr)(TOTConfigurator*, OTEventCode, OTResult, void*);
	typedef OSStatus (*OTCFConfigureProcPtr)(TOTConfigurator*, OTConfiguration*);
	typedef OSStatus (*OTCFCreateStreamProcPtr)(TOTConfigurator*, OTConfiguration*, OTOpenFlags,
												OTNotifyProcPtr, void*);
	
	//
	// Determine if this instance of your configurator is the "master"
	// (the one that can create and destroy control streams)
	//
	extern Boolean			OTIsMasterConfigurator(TOTConfigurator*);
	//
	// Get back the userData you passed in to OTNewConfigurator
	//
	extern void*			OTGetConfiguratorUserData(TOTConfigurator*);
	//
	// Create a configurator object for use by Open Transport
	//
	extern TOTConfigurator*	OTNewConfigurator(void* userData, OTCFConfigureProcPtr, OTCFCreateStreamProcPtr,
											  OTCFHandleSystemEventProcPtr);
	//
	// Delete a configurator object created by OTNewConfigurator
	//
	extern void				OTDeleteConfigurator(TOTConfigurator*);
	//
	// A utility function to send notifications to the user - it takes care of calls
	// from deferred tasks
	//
	typedef struct FSSpec	FSSpec;
	extern OSStatus			OTNotifyUser(FSSpec* theFile, SInt32 rsrcID, size_t index,
										 char* parm1, char* parm2);
	//
	// Call when the configurator unloads from memory
	//
	extern void				OTConfiguratorUnloaded(TOTConfigurator*);
	//
	// Call to create your control stream if you're not the master
	// configurator.  You can also use the state machine function
	// OTSMCreateControlStream(OTStateMachine*, OTConfiguration*, TOTConfigurator*).
	//
	extern OSStatus			OTCreateControlStream(OTConfiguration*,TOTConfigurator*,
												  OTNotifyProcPtr, void*);
	//
	// A helpful function for the configurators to
	// be able to recursively configure the children.
	//
	extern OSStatus			OTConfigureChildren(OTConfiguration*);

	extern UInt32			OTNewControlMask(void);
			//
			// %%% These 2 APIs is going away
			//
	extern void				OTCloseProvidersByUseCount(SInt32* useCount, OTResult reason, boolean_p doneDeal);
	extern void				OTCloseProvidersByPortRef(OTPortRef ref, OTResult reason, boolean_p doneDeal);
			//
			// These are the "real" APIs
			//
	extern void				OTCloseProviderByStream(StreamRef ref, OTResult reason, boolean_p doneDeal);
	extern void				OTCloseMatchingProviders(UInt32 mask, OTPortRef port, OTResult reason, boolean_p doneDeal);

#ifdef __cplusplus
}
#endif
	
/*	-------------------------------------------------------------------------
	The kOTConfiguratorInterfaceID define is what you need to add to your
	export file for the "interfaceID = " clause to export a configurator
	for ASLM
	------------------------------------------------------------------------- */
	#define kOTConfiguratorInterfaceID	kOTClientPrefix "cfigMkr"
	
/*******************************************************************************
** OTStateMachine
**
** This utility set allows you to write an asynchronous chain of code that looks 
** somewhat like it is synchronous.  This is primarily used for plumbing 
** streams asynchronously, especially in configurators
********************************************************************************/

	typedef struct OTStateMachine	OTStateMachine;

	typedef UInt32	UInt16_p;

	#define kOTSMBufferSize(callDepth)		(80 + (callDepth * 8))

#ifdef __cplusplus
extern "C" {
#endif

	typedef pascal void (*OTStateProcPtr)(OTStateMachine*);
	typedef void (*OTSMCompleteProcPtr)(void* contextPtr);

	/*
	 * For structSize, pass the size of your structure that you want associated with
	 * the state machine.  It can always be obtained by calling OTSMGetClientData().
	 * For bufSize, use the kOTSMBufferSize macro, plus the size of your structure
	 * to create a buffer on the stack. For synchronous calls, the stack buffer will
	 * be used (unless you pass in NULL).  The callDepth is the depth level of nested
	 * calls using OTSMCallStateProc.
	 */
	extern OTStateMachine*	OTCreateStateMachine(void*, size_t bufSize, size_t structSize,
												 OTNotifyProcPtr, void* contextPtr);
	extern void				OTDestroyStateMachine(OTStateMachine*);
	extern Boolean			OTSMCallStateProc(OTStateMachine*, OTStateProcPtr proc, UInt16_p state);
	extern UInt16			OTSMGetState(OTStateMachine*);
	extern void				OTSMSetState(OTStateMachine*, UInt16_p);
					// Fill out the fCookie, fCode, and fResult fields before calling!
	extern void				OTSMComplete(OTStateMachine*);
	extern void				OTSMPopCallback(OTStateMachine*);
	extern Boolean			OTSMWaitForComplete(OTStateMachine*);
	extern Boolean			OTSMCreateStream(OTStateMachine*, OTConfiguration*, OTOpenFlags);
	extern Boolean			OTSMOpenStream(OTStateMachine*, const char*, OTOpenFlags flags);
	extern Boolean			OTSMIoctl(OTStateMachine*, StreamRef, UInt32, long);
	extern Boolean			OTSMPutMessage(OTStateMachine*, StreamRef, struct strbuf*, struct strbuf*, OTFlags);
	extern Boolean			OTSMGetMessage(OTStateMachine*, StreamRef, struct strbuf*, struct strbuf*, OTFlags*);
	extern OSStatus			OTSMReturnToCaller(OTStateMachine*);
	extern void*			OTSMGetClientData(OTStateMachine*);
	extern void				OTSMInstallCompletionProc(OTStateMachine*, OTSMCompleteProcPtr, void* contextPtr);
	extern Boolean			OTSMCreateControlStream(OTStateMachine*, OTConfiguration*, TOTConfigurator*);

#ifdef __cplusplus
	}
#endif
	
	struct OTStateMachine
	{
	#if GENERATINGPOWERPC
				UInt8				fData[12];
	#else
				UInt8				fData[8];
	#endif
				void*				fCookie;
				OTEventCode			fCode;
				OTResult			fResult;
				
#ifdef __cplusplus
					void*		GetClientData()
								{ return OTSMGetClientData(this); }
			//
			// Call an OTStateProcPtr procedure.
			//
					Boolean		CallStateProc(OTStateProcPtr proc, UInt16_p state = 0)
								{ return OTSMCallStateProc(this, proc, state); }
			//
			// Get and Set the current state
			//
					UInt16		GetState()
								{ return OTSMGetState(this); }
					void		SetState(UInt16_p state)
								{ OTSMSetState(this, state); }
			//
			// These calls complete to the client without changing who to call back
			//
					void		Complete()
								{ OTSMComplete(this); }
					void		Complete(OTResult);
					void		Complete(OTResult, OTEventCode, void*);
			//
			// These calls complete to the client by popping the current callback
			//
					void		CompleteToClient();
					void		CompleteToClient(OTResult);
					void		CompleteToClient(OTResult, OTEventCode, void*);
			//
			// This call pops the current callback off the callback stack
			//
					void		PopCallback()
								{ OTSMPopCallback(this); }
								
					Boolean		CreateStream(OTConfiguration* cfig, OTOpenFlags flags)
								{ return OTSMCreateStream(this, cfig, flags); }
					Boolean		OpenStream(const char* name, OTOpenFlags flags)
								{ return OTSMOpenStream(this, name, flags); }
	
					Boolean		SendIoctl(StreamRef ref, UInt32 type, void* data)
								{ return OTSMIoctl(this, ref, type, (long)data); }
					Boolean		SendIoctl(StreamRef ref, UInt32 type, long data)
								{ return OTSMIoctl(this, ref, type, data); }
					Boolean		PutMessage(StreamRef ref, struct strbuf* ctl, struct strbuf* data, OTFlags flags)
								{ return OTSMPutMessage(this, ref, ctl, data, flags); }
					Boolean		GetMessage(StreamRef ref, struct strbuf* ctl, struct strbuf* data, OTFlags* flagPtr)
								{ return OTSMGetMessage(this, ref, ctl, data, flagPtr); }
	
					OSStatus	ReturnToCaller()
								{ return OTSMReturnToCaller(this); }
#endif
	};
	
#ifdef __cplusplus
		//
		// Other inline methods for OTStateMachine
		//
		inline void OTStateMachine::Complete(OTResult result, OTEventCode code,
								  		 	 void* cookie)
		{
			fCookie	= cookie;
			fCode	= code;
			fResult	= result;
			Complete();
		}
	
		inline void OTStateMachine::Complete(OTResult result)
		{
			fResult	= result;
			Complete();
		}
	
		inline void OTStateMachine::CompleteToClient()
		{
			PopCallback();
			Complete();
		}
		
		inline void OTStateMachine::CompleteToClient(OTResult result, OTEventCode code,
													 void* cookie)
		{
			fCookie	= cookie;
			fCode	= code;
			fResult	= result;
			CompleteToClient();
		}
	
		inline void OTStateMachine::CompleteToClient(OTResult result)
		{
			fResult	= result;
			CompleteToClient();
		}
		
#endif	/* __cplusplus	*/

/*******************************************************************************
** A few C++ objects for C++ fans
********************************************************************************/

#ifdef __cplusplus

	class OTConfiguration
	{
		public:
					OTConfiguration*	Clone()
										{ return OTCfigCloneConfiguration(this); }
				//
				// The Path for PushChild and PushParent must be a single module
				//
					OTConfiguration*	PushChild(const char* path, OSStatus* errPtr)
										{ return OTCfigPushNewSingleChild(this, path, errPtr); }
					OTConfiguration*	PushParent(const char* path, OSStatus* errPtr)
										{ return OTCfigPushParent(this, path, errPtr); }
					OTConfiguration*	PushNthChild(size_t index, const char* path,
													 OSStatus* errPtr)
										{ return OTCfigPushChild(this, index, path, errPtr); }
					OSStatus			PopChild(size_t index)
										{ return OTCfigPopChild(this, index); }

					OTConfiguration*	GetChild(size_t index = 0)
										{ return OTCfigGetChild(this, index); }
					OTConfiguration*	GetParent()
										{ return OTCfigGetParent(this); }
			
					OSStatus			AddChild(OTConfiguration* child)
										{ return OTCfigAddChild(this, child); }
					
					OTConfiguration*	NewChild(const char* path, OSStatus* errPtr)
										{ return OTCfigNewChild(this, path, errPtr); }
		
					OSStatus			SetPath(const char* path)
										{ return OTCfigSetPath(this, path); }
			
					Boolean				HasOptions()
										{ return OTCfigGetOptionNetbuf(this)->len != 0; }
	};

/*	-------------------------------------------------------------------------
	Class TOTConfigurator

	This class is subclassed to do configuration for a protocol or protocol stack.
	Of course, you can also use OTNewConfigurator to do it from "C".
	
	If you subclass it using C++, you MUST have a UInt32 field as the first
	field of your object that you do not touch or use.
	------------------------------------------------------------------------- */

	#if GENERATING68K && !defined(__SC__) && !defined(THINK_CPLUS)
	class TOTConfigurator : public SingleObject
#else
	class TOTConfigurator
#endif
	{
	#if defined(__SC__) || defined(THINK_CPLUS) || defined(__MRC__)
		private:
			virtual		void DummyVirtualFunction();
	#endif
				
		public:
				void*			operator new(size_t size)
								{ return OTAllocSharedClientMem(size); }
				void			operator delete(void* mem)
								{ OTFreeSharedClientMem(mem); };
								
								_MDECL TOTConfigurator();
			virtual				~ _MDECL TOTConfigurator();
	
			virtual void		_MDECL HandleSystemEvent(OTEventCode event, OTResult result,
														 void* cookie)						= 0;
			
			virtual OSStatus	_MDECL Configure(OTConfiguration*)							= 0;
			virtual OSStatus	_MDECL CreateStream(OTConfiguration*, OTOpenFlags,
													 OTNotifyProcPtr, void* contextPtr)		= 0;
	};

#endif __cplusplus

#if defined(__MWERKS__) && GENERATING68K
#pragma pointers_in_A0
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif
#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#endif	/* __OPENTPTCLIENT__ */
