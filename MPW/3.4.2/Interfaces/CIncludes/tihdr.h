/*
	File:		tihdr.h

	Copyright:	© 1992-1996 by Mentat Inc., all rights reserved.

*/

#ifndef __TIHDR__
#define __TIHDR__

#ifndef __OPENTRANSPORT__
#include <OpenTransport.h>
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

/* User generated requests */
#define T_BIND_REQ				101
#define T_CONN_REQ				102		/* connection request */
#define T_CONN_RES				103		/* respond to connection indication */
#define T_DATA_REQ				104
#define T_DISCON_REQ			105
#define T_EXDATA_REQ			106
#define T_INFO_REQ				107
#define T_OPTMGMT_REQ			108
#define T_ORDREL_REQ			109
#define T_UNBIND_REQ			110
#define T_UNITDATA_REQ			111
#define T_ADDR_REQ				112		/* Get address request				*/
#define T_UREQUEST_REQ			113		/* UnitRequest (transaction) req	*/
#define T_REQUEST_REQ			114		/* Request (CO transaction) req		*/
#define T_UREPLY_REQ			115		/* UnitRequest (transaction) req	*/
#define T_REPLY_REQ				116		/* REPLY (CO transaction) req		*/
#define T_CANCELREQUEST_REQ		117		/* Cancel outgoing request			*/
#define T_CANCELREPLY_REQ		118		/* Cancel incoming request			*/
#define T_REGNAME_REQ			119		/* Request name registration    	*/
#define T_DELNAME_REQ			120		/* Request delete name registration */
#define T_LKUPNAME_REQ			121		/* Request name lookup          	*/

/* Transport generated indications and acknowledgements */
#define T_BIND_ACK				122
#define T_CONN_CON				123		/* connection confirmation 			*/
#define T_CONN_IND				124		/* incoming connection indication 	*/
#define T_DATA_IND				125
#define T_DISCON_IND			126
#define T_ERROR_ACK 			127
#define T_EXDATA_IND			128
#define T_INFO_ACK				129
#define T_OK_ACK				130
#define T_OPTMGMT_ACK			131
#define T_ORDREL_IND			132
#define T_UNITDATA_IND			133
#define T_UDERROR_IND			134
#define T_ADDR_ACK				135		/* Get address ack					*/
#define T_UREQUEST_IND			136		/* UnitRequest (transaction) ind	*/
#define T_REQUEST_IND			137		/* Request (CO transaction) ind 	*/
#define T_UREPLY_IND			138		/* Incoming unit reply				*/
#define T_REPLY_IND				139		/* Incoming reply					*/
#define T_UREPLY_ACK			140		/* outgoing Unit Reply is complete	*/
#define T_REPLY_ACK				141		/* outgoing Reply is complete		*/
#define T_RESOLVEADDR_REQ		142
#define T_RESOLVEADDR_ACK		143

#define T_LKUPNAME_CON			146		/* Results of name lookup       	*/
#define T_LKUPNAME_RES			147		/* Partial results of name lookup	*/
#define T_REGNAME_ACK			148		/* Request name registration    	*/
#define T_SEQUENCED_ACK			149		/* Sequenced version of OK or ERROR ACK */

#define T_EVENT_IND				160		/* Miscellaneous event Indication		*/

/* State values */
#define TS_UNBND				1
#define TS_WACK_BREQ			2
#define TS_WACK_UREQ			3
#define TS_IDLE 				4
#define TS_WACK_OPTREQ			5
#define TS_WACK_CREQ			6
#define TS_WCON_CREQ			7
#define TS_WRES_CIND			8
#define TS_WACK_CRES			9
#define TS_DATA_XFER			10
#define TS_WIND_ORDREL			11
#define TS_WREQ_ORDREL			12
#define TS_WACK_DREQ6			13
#define TS_WACK_DREQ7			14
#define TS_WACK_DREQ9			15
#define TS_WACK_DREQ10			16
#define TS_WACK_DREQ11			17
#define TS_WACK_ORDREL			18
#define TS_NOSTATES 			19
#define TS_BAD_STATE			19

/* Transport events */
#define TE_OPENED				1
#define TE_BIND 				2
#define TE_OPTMGMT				3
#define TE_UNBIND				4
#define TE_CLOSED				5
#define TE_CONNECT1 			6
#define TE_CONNECT2 			7
#define TE_ACCEPT1				8
#define TE_ACCEPT2				9
#define TE_ACCEPT3				10
#define TE_SND					11
#define TE_SNDDIS1				12
#define TE_SNDDIS2				13
#define TE_SNDREL				14
#define TE_SNDUDATA 			15
#define TE_LISTEN				16
#define TE_RCVCONNECT			17
#define TE_RCV					18
#define TE_RCVDIS1				19
#define TE_RCVDIS2				20
#define TE_RCVDIS3				21
#define TE_RCVREL				22
#define TE_RCVUDATA 			23
#define TE_RCVUDERR 			24
#define TE_PASS_CONN			25
#define TE_BAD_EVENT			26

typedef struct T_addr_ack
{
	long	PRIM_type;		/* Always T_ADDR_ACK */
	long	LOCADDR_length;
	long	LOCADDR_offset;
	long	REMADDR_length;
	long	REMADDR_offset;
} T_addr_ack;

typedef struct T_addr_req
{
	long	PRIM_type;		/* Always T_ADDR_REQ */
} T_addr_req;

typedef struct T_bind_ack 
{
	long	PRIM_type;		/* always T_BIND_ACK */
	long	ADDR_length;
	long	ADDR_offset;
	unsigned long	CONIND_number;
} T_bind_ack;

typedef struct T_bind_req 
{
	long	PRIM_type;		/* always T_BIND_REQ */
	long	ADDR_length;
	long	ADDR_offset;
	unsigned long	CONIND_number;
} T_bind_req;

typedef struct T_conn_con 
{
	long	PRIM_type;		/* always T_CONN_CON */
	long	RES_length; 	/* responding address length */
	long	RES_offset;
	long	OPT_length;
	long	OPT_offset;
} T_conn_con;

typedef struct T_conn_ind 
{
	long	PRIM_type;		/* always T_CONN_IND */
	long	SRC_length;
	long	SRC_offset;
	long	OPT_length;
	long	OPT_offset;
	long	SEQ_number;
} T_conn_ind;

typedef struct T_conn_req 
{
	long	PRIM_type;		/* always T_CONN_REQ */
	long	DEST_length;
	long	DEST_offset;
	long	OPT_length;
	long	OPT_offset;
} T_conn_req;

typedef struct T_conn_res 
{
	long	PRIM_type;		/* always T_CONN_RES */
	struct queue* QUEUE_ptr;
	long	OPT_length;
	long	OPT_offset;
	long	SEQ_number;
} T_conn_res;

typedef struct T_data_ind 
{
	long	PRIM_type;		/* always T_DATA_IND */
	long	MORE_flag;
} T_data_ind;

typedef struct T_data_req 
{
	long	PRIM_type;		/* always T_DATA_REQ */
	long	MORE_flag;
} T_data_req;

typedef struct T_discon_ind 
{
	long	PRIM_type;		/* always T_DISCON_IND */
	long	DISCON_reason;
	long	SEQ_number;
} T_discon_ind;

typedef struct T_discon_req 
{
	long	PRIM_type;		/* always T_DISCON_REQ */
	long	SEQ_number;
} T_discon_req;

typedef struct T_exdata_ind 
{
	long	PRIM_type;		/* always T_EXDATA_IND */
	long	MORE_flag;
} T_exdata_ind;

typedef struct T_exdata_req 
{
	long	PRIM_type;		/* always T_EXDATA_REQ */
	long	MORE_flag;
} T_exdata_req;

typedef struct T_error_ack 
{
	long	PRIM_type;		/* always T_ERROR_ACK */
	long	ERROR_prim; 	/* primitive in error */
	long	TLI_error;
	long	UNIX_error;
} T_error_ack;

typedef struct T_info_ack 
{
	long	PRIM_type;		/* always T_INFO_ACK */
	long	TSDU_size;		/* max TSDU size */
	long	ETSDU_size; 	/* max ETSDU size */
	long	CDATA_size; 	/* connect data size */
	long	DDATA_size; 	/* disconnect data size */
	long	ADDR_size;		/* TSAP size */
	long	OPT_size;		/* options size */
	long	TIDU_size;		/* TIDU size */
	long	SERV_type;		/* service type */
	long	CURRENT_state;	/* current state */
	long	PROVIDER_flag;	/* provider flags (see xti.h for defines) */
} T_info_ack;

/* Provider flags */
#define SENDZERO        0x001   /* supports 0-length TSDU's */
#define XPG4_1          0x002   /* provider supports recent stuff */

typedef struct T_info_req 
{
	long	PRIM_type;		/* always T_INFO_REQ */
} T_info_req;

typedef struct T_ok_ack 
{
	long	PRIM_type;		/* always T_OK_ACK */
	long	CORRECT_prim;
} T_ok_ack;

typedef struct T_optmgmt_ack 
{
	long	PRIM_type;		/* always T_OPTMGMT_ACK */
	long	OPT_length;
	long	OPT_offset;
	long	MGMT_flags;
} T_optmgmt_ack;

typedef struct T_optmgmt_req 
{
	long	PRIM_type;		/* always T_OPTMGMT_REQ */
	long	OPT_length;
	long	OPT_offset;
	long	MGMT_flags;
} T_optmgmt_req;

typedef struct T_ordrel_ind 
{
	long	PRIM_type;		/* always T_ORDREL_IND */
} T_ordrel_ind;

typedef struct T_ordrel_req 
{
	long	PRIM_type;		/* always T_ORDREL_REQ */
} T_ordrel_req;

typedef struct T_unbind_req 
{
	long	PRIM_type;		/* always T_UNBIND_REQ */
} T_unbind_req;

typedef struct T_uderror_ind 
{
	long	PRIM_type;		/* always T_UDERROR_IND */
	long	DEST_length;
	long	DEST_offset;
	long	OPT_length;
	long	OPT_offset;
	long	ERROR_type;
} T_uderror_ind;

typedef struct T_unitdata_ind 
{
	long	PRIM_type;		/* always T_UNITDATA_IND */
	long	SRC_length;
	long	SRC_offset;
	long	OPT_length;
	long	OPT_offset;
} T_unitdata_ind;

typedef struct T_unitdata_req 
{
	long	PRIM_type;		/* always T_UNITDATA_REQ */
	long	DEST_length;
	long	DEST_offset;
	long	OPT_length;
	long	OPT_offset;
} T_unitdata_req;

typedef struct T_resolveaddr_ack 
{
	long	PRIM_type;		/* always T_RESOLVEADDR_ACK */
	long	SEQ_number;
	long	ADDR_length;
	long	ADDR_offset;
	long	ORIG_client;
	long	ORIG_data;
	long	TLI_error;
	long	UNIX_error;
} T_resolveaddr_ack;

typedef struct T_resolveaddr_req 
{
	long	PRIM_type;		/* always T_RESOLVEADDR_REQ */
	long	SEQ_number;
	long	ADDR_length;
	long	ADDR_offset;
	long	ORIG_client;
	long	ORIG_data;
	long	MAX_milliseconds;
} T_resolveaddr_req;

typedef struct T_unitreply_ind
{
	long	PRIM_type;		/* Always T_UREPLY_IND */
	long	SEQ_number;
	long	OPT_length;
	long	OPT_offset;
	long	REP_flags;
	long	TLI_error;
	long	UNIX_error;
} T_unitreply_ind;

typedef struct T_unitrequest_ind
{
	long	PRIM_type;		/* Always T_UREQUEST_IND */
	long	SEQ_number;
	long	SRC_length;
	long	SRC_offset;
	long	OPT_length;
	long	OPT_offset;
	long	REQ_flags;
} T_unitrequest_ind;

typedef struct T_unitrequest_req
{
	long	PRIM_type;		/* Always T_UREQUEST_REQ */
	long	SEQ_number;
	long	DEST_length;
	long	DEST_offset;
	long	OPT_length;
	long	OPT_offset;
	long	REQ_flags;
} T_unitrequest_req;

typedef struct T_unitreply_req
{
	long	PRIM_type;		/* Always T_UREPLY_REQ */
	long	SEQ_number;
	long	OPT_length;
	long	OPT_offset;
	long	REP_flags;
} T_unitreply_req;

typedef struct T_unitreply_ack
{
	long	PRIM_type;		/* Always T_UREPLY_ACK */
	long	SEQ_number;
	long	TLI_error;
	long	UNIX_error;
} T_unitreply_ack;

typedef struct T_cancelrequest_req
{
	long	PRIM_type;		/* Always T_CANCELREQUEST_REQ */
	long	SEQ_number;
} T_cancelrequest_req;

typedef struct T_cancelreply_req
{
	long	PRIM_type;		/* Always T_CANCELREPLY_REQ */
	long	SEQ_number;
} T_cancelreply_req;

typedef struct T_reply_ind
{
	long	PRIM_type;		/* Always T_REPLY_IND */
	long	SEQ_number;
	long	OPT_length;
	long	OPT_offset;
	long	REP_flags;
	long	TLI_error;
	long	UNIX_error;
} T_reply_ind;

typedef struct T_request_ind
{
	long	PRIM_type;		/* Always T_REQUEST_IND */
	long	SEQ_number;
	long	OPT_length;
	long	OPT_offset;
	long	REQ_flags;
} T_request_ind;

typedef struct T_request_req
{
	long	PRIM_type;		/* Always T_REQUEST_REQ */
	long	SEQ_number;
	long	OPT_length;
	long	OPT_offset;
	long	REQ_flags;
} T_request_req;

typedef struct T_reply_req
{
	long	PRIM_type;		/* Always T_REPLY_REQ */
	long	SEQ_number;
	long	OPT_length;
	long	OPT_offset;
	long	REP_flags;
} T_reply_req;

typedef struct T_reply_ack
{
	long	PRIM_type;		/* Always T_REPLY_ACK */
	long	SEQ_number;
	long	TLI_error;
	long	UNIX_error;
} T_reply_ack;

typedef struct T_regname_req
{
	long	PRIM_type;		/* Always T_REGNAME_REQ */
	long	SEQ_number;		/* Reply is sequence ack */
	long	NAME_length;
	long	NAME_offset;
	long	ADDR_length;
	long	ADDR_offset;
	long	REQ_flags;
} T_regname_req;

typedef struct T_regname_ack 
{
	long	PRIM_type;		/* always T_REGNAME_ACK		*/
	long	SEQ_number;
	long	REG_id;
	long	ADDR_length;
	long	ADDR_offset;
} T_regname_ack;

typedef struct T_delname_req
{
	long	PRIM_type;		/* Always T_DELNAME_REQ */
	long	SEQ_number;		/* Reply is sequence ack */
	long	NAME_length;
	long	NAME_offset;
} T_delname_req;

typedef struct T_lkupname_req
{
	long	PRIM_type;		/* Always T_LKUPNAME_REQ */
	long	SEQ_number;		/* Reply is sequence ack */
	long	NAME_length;	/* ... or T_LKUPNAME_CON */
	long	NAME_offset;
	long	ADDR_length;
	long	ADDR_offset;
	long	MAX_number;
	long	MAX_milliseconds;
	long	REQ_flags;
} T_lkupname_req;

typedef struct T_lkupname_con 
{
	long	PRIM_type;		/* Either T_LKUPNAME_CON */
	long	SEQ_number;		/* Or T_LKUPNAME_RES */
	long	NAME_length;
	long	NAME_offset;
	long	RSP_count;
	long	RSP_cumcount;
} T_lkupname_con;

typedef struct T_sequence_ack 
{
	long	PRIM_type;		/* always T_SEQUENCED_ACK		*/
	long	ORIG_prim; 		/* original primitive			*/
	long	SEQ_number;
	long	TLI_error;
	long	UNIX_error;
} T_sequence_ack;

typedef struct T_event_ind 
{
	long	PRIM_type;		/* always T_EVENT_IND			*/
	long	EVENT_code;
	long	EVENT_cookie;
} T_event_ind;

union T_primitives 
{
	long						type;
	struct T_addr_ack			taddrack;
	struct T_bind_ack			tbindack;
	struct T_bind_req			tbindreq;
	struct T_conn_con			tconncon;
	struct T_conn_ind			tconnind;
	struct T_conn_req			tconnreq;
	struct T_conn_res			tconnres;
	struct T_data_ind			tdataind;
	struct T_data_req			tdatareq;
	struct T_discon_ind 		tdisconind;
	struct T_discon_req 		tdisconreq;
	struct T_exdata_ind 		texdataind;
	struct T_exdata_req 		texdatareq;
	struct T_error_ack			terrorack;
	struct T_info_ack			tinfoack;
	struct T_info_req			tinforeq;
	struct T_ok_ack 			tokack;
	struct T_optmgmt_ack		toptmgmtack;
	struct T_optmgmt_req		toptmgmtreq;
	struct T_ordrel_ind 		tordrelind;
	struct T_ordrel_req 		tordrelreq;
	struct T_unbind_req 		tunbindreq;
	struct T_uderror_ind		tuderrorind;
	struct T_unitdata_ind		tunitdataind;
	struct T_unitdata_req		tunitdatareq;
	struct T_unitreply_ind		tunitreplyind;
	struct T_unitrequest_ind	tunitrequestind;
	struct T_unitrequest_req	tunitrequestreq;
	struct T_unitreply_req		tunitreplyreq;
	struct T_unitreply_ack		tunitreplyack;
	struct T_reply_ind			treplyind;
	struct T_request_ind		trequestind;
	struct T_request_req		trequestreq;
	struct T_reply_req			treplyreq;
	struct T_reply_ack			treplyack;
	struct T_cancelrequest_req	tcancelreqreq;
	struct T_resolveaddr_req	tresolvereq;
	struct T_resolveaddr_ack	tresolveack;
	struct T_regname_req		tregnamereq;
	struct T_regname_ack		tregnameack;
	struct T_delname_req		tdelnamereq;
	struct T_lkupname_req		tlkupnamereq;
	struct T_lkupname_con		tlkupnamecon;
	struct T_sequence_ack		tsequenceack;
	struct T_event_ind			teventind;
};

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#endif
