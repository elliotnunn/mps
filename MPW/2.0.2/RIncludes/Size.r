/*
	WARNING - This file is only a temporary file that won't be part
			  of any subsequent MPW release.  The SIZE resource
			  declaration below will be included in the next release
			  of the Types.r file.  If you use this new SIZE
			  declaration, it is recommended that you copy it
			  over the SIZE declaration in your Types.r file.
*/


/*----------------------------SIZE • MultiFinder Size Information-----------------------*/
type 'SIZE' {
		boolean					dontSaveScreen,					/* for SWITCHER 		*/
								saveScreen;						/*    compatibility		*/
		boolean 				ignoreSuspendResumeEvents,		/* suspend-resume		*/
								acceptSuspendResumeEvents;
		boolean					enableOptionSwitch,				/* for SWITCHER 		*/
								disableOptionSwitch;			/*    compatibility		*/
		boolean					cannotBackground,
								canBackground;					/* Can properly use back-
																   ground null events	*/
		boolean					notMultiFinderAware,			/* activate/deactivate	*/
								multiFinderAware;				/* on resume/suspend	*/
		unsigned bitstring[11] = 0; 							/* reserved 			*/
		
		/* Memory sizes are in bytes */
		unsigned longint;										/* preferred mem size	*/
		unsigned longint;										/* minimum mem size		*/
};
