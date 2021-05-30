{
 	File:		GXErrors.p
 
 	Contains:	QuickDraw GX error constants and debugging routines
 
 	Version:	Technology:	Quickdraw GX 1.1
 				Release:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT GXErrors;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __GXERRORS__}
{$SETC __GXERRORS__ := 1}

{$I+}
{$SETC GXErrorsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __GXTYPES__}
{$I GXTypes.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	gxFirstSystemError			= -27999;						{  0xffff92a1  }
	gxFirstFatalError			= -27999;
	gxLastFatalError			= -27951;
	gxFirstNonfatalError		= -27950;
	gxFirstFontScalerError		= -27900;
	gxLastFontScalerError		= -27851;
	gxFirstParameterError		= -27850;
	gxFirstImplementationLimitError = -27800;
	gxFirstSystemDebuggingError	= -27700;
	gxLastSystemError			= -27000;						{  0xffff9688  }
	gxFirstLibraryError			= 1048576;						{  0x00100000  }
	gxLastLibraryError			= 2097151;						{  0x001fffff  }
	gxFirstAppError				= 2097152;						{  0x00200000  }
	gxLastAppError				= 4194303;						{  0x003fffff  }
	gxFirstSystemWarning		= -26999;						{  0xffff9689  }
	gxFirstResultOutOfRangeWarning = -26950;
	gxFirstParameterOutOfRangeWarning = -26900;
	gxFirstFontScalerWarning	= -26850;
	gxFirstSystemDebuggingWarning = -26700;
	gxLastSystemWarning			= -26000;						{  0xffff9a70  }
	gxFirstLibraryWarning		= 4194304;						{  0x00400000  }
	gxLastLibraryWarning		= 5242879;						{  0x004fffff  }
	gxFirstAppWarning			= 5242880;						{  0x00500000  }
	gxLastAppWarning			= 7340031;						{  0x006fffff  }
	gxFirstSystemNotice			= -25999;						{  0xffff9a71  }
	gxLastSystemNotice			= -25500;						{  0xffff9c64  }
	gxFirstLibraryNotice		= 7340032;						{  0x00700000  }
	gxLastLibraryNotice			= 7602175;						{  0x0073ffff  }
	gxFirstAppNotice			= 7602176;						{  0x00740000  }
	gxLastAppNotice				= 8388607;						{  0x007fffff  }

																{  truly fatal errors  }
	out_of_memory				= -27999;
	internal_fatal_error		= -27998;
	no_outline_font_found		= -27997;
	not_enough_memory_for_graphics_client_heap = -27996;
	could_not_create_backing_store = -27995;					{  internal errors  }
	internal_error				= -27950;
	internal_font_error			= -27949;
	internal_layout_error		= -27948;						{  recoverable errors  }
	could_not_dispose_backing_store = -27946;
	unflattening_interrupted_by_client = -27945;				{  font manager errors  }
	font_cannot_be_changed		= -27944;
	illegal_font_parameter		= -27943;						{  gxFont scaler errors  }
	null_font_scaler_context	= -27900;
	null_font_scaler_input		= -27899;
	invalid_font_scaler_context	= -27898;
	invalid_font_scaler_input	= -27897;
	invalid_font_scaler_font_data = -27896;
	font_scaler_newblock_failed	= -27895;
	font_scaler_getfonttable_failed = -27894;
	font_scaler_bitmap_allocation_failed = -27893;
	font_scaler_outline_allocation_failed = -27892;
	required_font_scaler_table_missing = -27891;
	unsupported_font_scaler_outline_format = -27890;
	unsupported_font_scaler_stream_format = -27889;
	unsupported_font_scaler_font_format = -27888;
	font_scaler_hinting_error	= -27887;
	font_scaler_rasterizer_error = -27886;
	font_scaler_internal_error	= -27885;
	font_scaler_invalid_matrix	= -27884;
	font_scaler_fixed_overflow	= -27883;
	font_scaler_api_version_mismatch = -27882;
	font_scaler_streaming_aborted = -27881;
	unknown_font_scaler_error	= -27880;						{  bad parameters  }
	parameter_is_nil			= -27850;
	shape_is_nil				= -27849;
	style_is_nil				= -27848;
	transform_is_nil			= -27847;
	ink_is_nil					= -27846;
	transferMode_is_nil			= -27845;
	color_is_nil				= -27844;
	colorProfile_is_nil			= -27843;
	colorSet_is_nil				= -27842;
	spoolProcedure_is_nil		= -27841;
	tag_is_nil					= -27840;
	type_is_nil					= -27839;
	mapping_is_nil				= -27838;
	invalid_viewDevice_reference = -27837;
	invalid_viewGroup_reference	= -27836;
	invalid_viewPort_reference	= -27835;						{  implementation limits, these should be right before the debugging errors  }
	number_of_contours_exceeds_implementation_limit = -27800;
	number_of_points_exceeds_implementation_limit = -27799;
	size_of_polygon_exceeds_implementation_limit = -27798;
	size_of_path_exceeds_implementation_limit = -27797;
	size_of_text_exceeds_implementation_limit = -27796;
	size_of_bitmap_exceeds_implementation_limit = -27795;
	number_of_colors_exceeds_implementation_limit = -27794;
	procedure_not_reentrant		= -27793;

																{  internal debugging errors  }
	functionality_unimplemented	= -27700;
	clip_to_frame_shape_unimplemented = -27699;					{  font parameter debugging errors  }
	illegal_font_storage_type	= -27698;
	illegal_font_storage_reference = -27697;
	illegal_font_attributes		= -27696;						{  parameter debugging errors  }
	parameter_out_of_range		= -27695;
	inconsistent_parameters		= -27694;
	index_is_less_than_zero		= -27693;
	index_is_less_than_one		= -27692;
	count_is_less_than_zero		= -27691;
	count_is_less_than_one		= -27690;
	contour_is_less_than_zero	= -27689;
	length_is_less_than_zero	= -27688;
	invalid_client_reference	= -27687;
	invalid_graphics_heap_start_pointer = -27686;
	invalid_nongraphic_globals_pointer = -27685;
	colorSpace_out_of_range		= -27684;
	pattern_lattice_out_of_range = -27683;
	frequency_parameter_out_of_range = -27682;
	tinting_parameter_out_of_range = -27681;
	method_parameter_out_of_range = -27680;
	space_may_not_be_indexed	= -27679;
	glyph_index_too_small		= -27678;
	no_glyphs_added_to_font		= -27677;
	glyph_not_added_to_font		= -27676;
	point_does_not_intersect_bitmap = -27675;
	required_font_table_not_present = -27674;
	unknown_font_table_format	= -27673;						{  the styles encoding is not present in the font  }
	shapeFill_not_allowed		= -27672;
	inverseFill_face_must_set_clipLayer_flag = -27671;
	invalid_transferMode_colorSpace = -27670;
	colorProfile_must_be_nil	= -27669;
	bitmap_pixel_size_must_be_1	= -27668;
	empty_shape_not_allowed		= -27667;
	ignorePlatformShape_not_allowed = -27666;
	nil_style_in_glyph_not_allowed = -27665;
	complex_glyph_style_not_allowed = -27664;
	invalid_mapping				= -27663;
	cannot_set_item_shapes_to_nil = -27662;
	cannot_use_original_item_shapes_when_growing_picture = -27661;
	cannot_add_unspecified_new_glyphs = -27660;
	cannot_dispose_locked_tag	= -27659;
	cannot_dispose_locked_shape	= -27658;						{  restricted access  }
	shape_access_not_allowed	= -27657;
	colorSet_access_restricted	= -27656;
	colorProfile_access_restricted = -27655;
	tag_access_restricted		= -27654;
	viewDevice_access_restricted = -27653;
	graphic_type_does_not_have_a_structure = -27652;
	style_run_array_does_not_match_number_of_characters = -27651;
	rectangles_cannot_be_inserted_into = -27650;
	unknown_graphics_heap		= -27649;
	graphics_routine_selector_is_obsolete = -27648;
	cannot_set_graphics_client_memory_without_setting_size = -27647;
	graphics_client_memory_too_small = -27646;
	graphics_client_memory_is_already_allocated = -27645;
	viewPort_is_a_window		= -27644;						{  wrong type/bad reference  }
	illegal_type_for_shape		= -27643;
	shape_does_not_contain_a_bitmap = -27642;
	shape_does_not_contain_text	= -27641;
	picture_expected			= -27640;
	bitmap_is_not_resizable		= -27639;
	shape_may_not_be_a_bitmap	= -27638;
	shape_may_not_be_a_picture	= -27637;
	graphic_type_does_not_contain_points = -27636;
	graphic_type_does_not_have_multiple_contours = -27635;
	graphic_type_cannot_be_mapped = -27634;
	graphic_type_cannot_be_moved = -27633;
	graphic_type_cannot_be_scaled = -27632;
	graphic_type_cannot_be_rotated = -27631;
	graphic_type_cannot_be_skewed = -27630;
	graphic_type_cannot_be_reset = -27629;
	graphic_type_cannot_be_dashed = -27628;
	graphic_type_cannot_be_reduced = -27627;
	graphic_type_cannot_be_inset = -27626;
	shape_cannot_be_inverted	= -27625;
	shape_does_not_have_area	= -27624;
	shape_does_not_have_length	= -27623;
	first_glyph_advance_must_be_absolute = -27622;
	picture_cannot_contain_itself = -27621;
	viewPort_cannot_contain_itself = -27620;
	cannot_set_unique_items_attribute_when_picture_contains_items = -27619;
	layer_style_cannot_contain_a_face = -27618;
	layer_glyph_shape_cannot_contain_nil_styles = -27617;		{  validation errors  }
	object_wrong_type			= -27616;
	shape_wrong_type			= -27615;
	style_wrong_type			= -27614;
	ink_wrong_type				= -27613;
	transform_wrong_type		= -27612;
	device_wrong_type			= -27611;
	port_wrong_type				= -27610;						{  validation cache errors  }
	shape_cache_wrong_type		= -27609;
	style_cache_wrong_type		= -27608;
	ink_cache_wrong_type		= -27607;
	transform_cache_wrong_type	= -27606;
	port_cache_wrong_type		= -27605;
	shape_cache_parent_mismatch	= -27604;
	style_cache_parent_mismatch	= -27603;
	ink_cache_parent_mismatch	= -27602;
	transform_cache_parent_mismatch = -27601;
	port_cache_parent_mismatch	= -27600;
	invalid_shape_cache_port	= -27599;
	invalid_shape_cache_device	= -27598;
	invalid_ink_cache_port		= -27597;
	invalid_ink_cache_device	= -27596;
	invalid_style_cache_port	= -27595;
	invalid_style_cache_device	= -27594;
	invalid_transform_cache_port = -27593;
	invalid_transform_cache_device = -27592;
	recursive_caches			= -27591;						{  validation shape cache errors  }
	invalid_fillShape_ownerCount = -27590;
	recursive_fillShapes		= -27589;						{  validation memory block errors  }
	indirect_memory_block_too_small = -27588;
	indirect_memory_block_too_large = -27587;
	unexpected_nil_pointer		= -27586;
	bad_address					= -27585;						{  validation object errors  }
	no_owners					= -27584;
	invalid_pointer				= -27583;
	invalid_seed				= -27582;
	invalid_frame_seed			= -27581;
	invalid_text_seed			= -27580;
	invalid_draw_seed			= -27579;
	bad_private_flags			= -27578;						{  validation path and polygon errors  }
	invalid_vector_count		= -27577;
	invalid_contour_count		= -27576;						{  validation bitmap errors  }
	bitmap_ptr_too_small		= -27575;
	bitmap_ptr_not_aligned		= -27574;
	bitmap_rowBytes_negative	= -27573;
	bitmap_width_negative		= -27572;
	bitmap_height_negative		= -27571;
	invalid_pixelSize			= -27570;
	bitmap_rowBytes_too_small	= -27569;
	bitmap_rowBytes_not_aligned	= -27568;
	bitmap_rowBytes_must_be_specified_for_user_image_buffer = -27567; {  validation bitmap image errors  }
	invalid_bitImage_fileOffset	= -27566;
	invalid_bitImage_owners		= -27565;
	invalid_bitImage_rowBytes	= -27564;
	invalid_bitImage_internal_flag = -27563;					{  validation text errors  }
	text_bounds_cache_wrong_size = -27562;
	text_metrics_cache_wrong_size = -27561;
	text_index_cache_wrong_size	= -27560;						{  validation glyph errors  }
	glyph_run_count_negative	= -27559;
	glyph_run_count_zero		= -27558;
	glyph_run_counts_do_not_sum_to_character_count = -27557;
	glyph_first_advance_bit_set_not_allowed = -27556;
	glyph_tangent_vectors_both_zero = -27555;					{  validation layout errors  }
	layout_run_length_negative	= -27554;
	layout_run_length_zero		= -27553;
	layout_run_level_negative	= -27552;
	layout_run_lengths_do_not_sum_to_text_length = -27551;		{  validation picture errors  }
	bad_shape_in_picture		= -27550;
	bad_style_in_picture		= -27549;
	bad_ink_in_picture			= -27548;
	bad_transform_in_picture	= -27547;
	bad_shape_cache_in_picture	= -27546;
	bad_seed_in_picture			= -27545;
	invalid_picture_count		= -27544;						{  validation text face errors  }
	bad_textLayer_count			= -27543;
	bad_fillType_in_textFace	= -27542;
	bad_style_in_textFace		= -27541;
	bad_transform_in_textFace	= -27540;						{  validation transform errors  }
	invalid_matrix_flag			= -27539;
	transform_clip_missing		= -27538;						{  validation font cache errors  }
	metrics_wrong_type			= -27537;
	metrics_point_size_probably_bad = -27536;
	scalar_block_wrong_type		= -27535;
	scalar_block_parent_mismatch = -27534;
	scalar_block_too_small		= -27533;
	scalar_block_too_large		= -27532;
	invalid_metrics_range		= -27531;
	invalid_metrics_flags		= -27530;
	metrics_maxWidth_probably_bad = -27529;
	font_wrong_type				= -27528;
	font_wrong_size				= -27527;
	invalid_font_platform		= -27526;
	invalid_lookup_range		= -27525;
	invalid_lookup_platform		= -27524;
	font_not_in_font_list		= -27523;
	metrics_not_in_metrics_list	= -27522;						{  validation view device errors  }
	bad_device_private_flags	= -27521;
	bad_device_attributes		= -27520;
	invalid_device_number		= -27519;
	invalid_device_viewGroup	= -27518;
	invalid_device_bounds		= -27517;
	invalid_bitmap_in_device	= -27516;						{  validation color set errors  }
	colorSet_wrong_type			= -27515;
	invalid_colorSet_viewDevice_owners = -27514;
	invalid_colorSet_colorSpace	= -27513;
	invalid_colorSet_count		= -27512;						{  validation color profile errors  }
	colorProfile_wrong_type		= -27511;
	invalid_colorProfile_flags	= -27510;
	invalid_colorProfile_response_count = -27509;				{  validation internal backing store errors  }
	backing_free_parent_mismatch = -27508;
	backing_store_parent_mismatch = -27507;

																{  warnings about warnings  }
	warning_stack_underflow		= -26999;
	warning_stack_overflow		= -26998;
	notice_stack_underflow		= -26997;
	notice_stack_overflow		= -26996;
	about_to_grow_heap			= -26995;
	about_to_unload_objects		= -26994;						{  result went out of range  }
	map_shape_out_of_range		= -26950;
	move_shape_out_of_range		= -26949;
	scale_shape_out_of_range	= -26948;
	rotate_shape_out_of_range	= -26947;
	skew_shape_out_of_range		= -26946;
	map_transform_out_of_range	= -26945;
	move_transform_out_of_range	= -26944;
	scale_transform_out_of_range = -26943;
	rotate_transform_out_of_range = -26942;
	skew_transform_out_of_range	= -26941;
	map_points_out_of_range		= -26940;						{  gave a parameter out of range  }
	contour_out_of_range		= -26900;
	index_out_of_range_in_contour = -26899;
	picture_index_out_of_range	= -26898;
	color_index_requested_not_found = -26897;
	colorSet_index_out_of_range	= -26896;
	index_out_of_range			= -26895;
	count_out_of_range			= -26894;
	length_out_of_range			= -26893;
	font_table_index_out_of_range = -26892;
	font_glyph_index_out_of_range = -26891;
	point_out_of_range			= -26890;
	profile_response_out_of_range = -26889;						{  gxFont scaler warnings  }
	font_scaler_no_output		= -26850;
	font_scaler_fake_metrics	= -26849;
	font_scaler_fake_linespacing = -26848;
	font_scaler_glyph_substitution = -26847;
	font_scaler_no_kerning_applied = -26846;					{  might not be what you expected  }
	character_substitution_took_place = -26845;
	unable_to_get_bounds_on_multiple_devices = -26844;
	font_language_not_found		= -26843;
	font_not_found_during_unflattening = -26842;				{ storage  }
	unrecognized_stream_version	= -26841;
	bad_data_in_stream			= -26840;

																{  nonsense data  }
	new_shape_contains_invalid_data = -26700;
	new_tag_contains_invalid_data = -26699;
	extra_data_passed_was_ignored = -26698;
	font_table_not_found		= -26697;
	font_name_not_found			= -26696;						{  doesn't make sense to do  }
	unable_to_traverse_open_contour_that_starts_or_ends_off_the_curve = -26695;
	unable_to_draw_open_contour_that_starts_or_ends_off_the_curve = -26694;
	cannot_dispose_default_shape = -26693;
	cannot_dispose_default_style = -26692;
	cannot_dispose_default_ink	= -26691;
	cannot_dispose_default_transform = -26690;
	cannot_dispose_default_colorProfile = -26689;
	cannot_dispose_default_colorSet = -26688;
	shape_direct_attribute_not_set = -26687;					{  couldn't find what you were looking for  }
	point_does_not_intersect_port = -26686;
	cannot_dispose_non_font		= -26685;
	face_override_style_font_must_match_style = -26684;
	union_of_area_and_length_returns_area_only = -26683;
	insufficient_coordinate_space_for_new_device = -26682;		{  other  }
	shape_passed_has_no_bounds	= -26681;
	tags_of_type_flst_removed	= -26680;
	translator_not_installed_on_this_grafport = -26679;

	parameters_have_no_effect	= -25999;
	attributes_already_set		= -25998;
	caps_already_set			= -25997;
	clip_already_set			= -25996;
	color_already_set			= -25995;
	curve_error_already_set		= -25994;
	dash_already_set			= -25993;
	default_colorProfile_already_set = -25992;
	default_ink_already_set		= -25991;
	default_transform_already_set = -25990;
	default_shape_already_set	= -25989;
	default_style_already_set	= -25988;
	dither_already_set			= -25987;
	encoding_already_set		= -25986;
	face_already_set			= -25985;
	fill_already_set			= -25984;
	font_already_set			= -25983;
	font_variations_already_set	= -25982;
	glyph_positions_are_already_set = -25981;
	glyph_tangents_are_already_set = -25980;
	halftone_already_set		= -25979;
	hit_test_already_set		= -25978;
	ink_already_set				= -25977;
	join_already_set			= -25976;
	justification_already_set	= -25975;
	mapping_already_set			= -25974;
	pattern_already_set			= -25973;
	pen_already_set				= -25972;
	style_already_set			= -25971;
	tag_already_set				= -25970;
	text_attributes_already_set	= -25969;
	text_size_already_set		= -25968;
	transfer_already_set		= -25967;
	translator_already_installed_on_this_grafport = -25966;
	transform_already_set		= -25965;
	type_already_set			= -25964;
	validation_level_already_set = -25963;
	viewPorts_already_set		= -25962;
	viewPort_already_in_viewGroup = -25961;
	viewDevice_already_in_viewGroup = -25960;
	geometry_unaffected			= -25959;
	mapping_unaffected			= -25958;
	tags_in_shape_ignored		= -25957;
	shape_already_in_primitive_form = -25956;
	shape_already_in_simple_form = -25955;
	shape_already_broken		= -25954;
	shape_already_joined		= -25953;
	cache_already_cleared		= -25952;
	shape_not_disposed			= -25951;
	style_not_disposed			= -25950;
	ink_not_disposed			= -25949;
	transform_not_disposed		= -25948;
	colorSet_not_disposed		= -25947;
	colorProfile_not_disposed	= -25946;
	font_not_disposed			= -25945;
	glyph_tangents_have_no_effect = -25944;
	glyph_positions_determined_by_advance = -25943;
	transform_viewPorts_already_set = -25942;
	directShape_attribute_set_as_side_effect = -25941;
	lockShape_called_as_side_effect = -25940;
	lockTag_called_as_side_effect = -25939;
	shapes_unlocked_as_side_effect = -25938;
	shape_not_locked			= -25937;
	tag_not_locked				= -25936;
	profile_not_locked			= -25936;
	lockProfile_called_as_side_effect = -25939;
	disposed_dead_caches		= -25935;
	disposed_live_caches		= -25934;
	low_on_memory				= -25933;
	very_low_on_memory			= -25932;
	transform_references_disposed_viewPort = -25931;


TYPE
	gxGraphicsError						= LONGINT;
	gxGraphicsWarning					= LONGINT;
	gxGraphicsNotice					= LONGINT;
	gxUserErrorProcPtr = ProcPtr;  { PROCEDURE gxUserError(status: gxGraphicsError; refcon: LONGINT); C; }

	gxUserWarningProcPtr = ProcPtr;  { PROCEDURE gxUserWarning(status: gxGraphicsWarning; refcon: LONGINT); C; }

	gxUserNoticeProcPtr = ProcPtr;  { PROCEDURE gxUserNotice(status: gxGraphicsNotice; refcon: LONGINT); C; }

	gxUserErrorUPP = UniversalProcPtr;
	gxUserWarningUPP = UniversalProcPtr;
	gxUserNoticeUPP = UniversalProcPtr;

CONST
	uppgxUserErrorProcInfo = $000003C1;
	uppgxUserWarningProcInfo = $000003C1;
	uppgxUserNoticeProcInfo = $000003C1;

FUNCTION NewgxUserErrorProc(userRoutine: gxUserErrorProcPtr): gxUserErrorUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewgxUserWarningProc(userRoutine: gxUserWarningProcPtr): gxUserWarningUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewgxUserNoticeProc(userRoutine: gxUserNoticeProcPtr): gxUserNoticeUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallgxUserErrorProc(status: gxGraphicsError; refcon: LONGINT; userRoutine: gxUserErrorUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE CallgxUserWarningProc(status: gxGraphicsWarning; refcon: LONGINT; userRoutine: gxUserWarningUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE CallgxUserNoticeProc(status: gxGraphicsNotice; refcon: LONGINT; userRoutine: gxUserNoticeUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

TYPE
	gxUserErrorFunction					= gxUserErrorProcPtr;
	gxUserWarningFunction				= gxUserWarningProcPtr;
	gxUserNoticeFunction				= gxUserNoticeProcPtr;


CONST
	common_colors_not_initialized = 1048576;
	no_open_picture				= 1048577;
	picture_already_open		= 1048578;
	no_open_poly				= 1048579;
	poly_already_open			= 1048580;
	no_open_region				= 1048581;
	region_already_open			= 1048582;
	no_active_picture			= 1048583;

	no_picture_drawn			= 4194304;
	polygons_have_different_size_contours = 4194305;
	graphic_type_cannot_be_specifed_by_four_values = 4194306;
	graphic_type_cannot_be_specifed_by_six_values = 4194307;
	point_expected				= 4194308;
	line_or_rectangle_expected	= 4194309;
	curve_expected				= 4194310;
	graphic_type_does_not_contain_control_bits = 4194311;
	request_exceeds_available_data = 4194312;
	extra_data_unread			= 4194313;
	no_variable_length_user_data_saved = 4194314;

	zero_length_string_passed	= 7340032;

																{  These levels tell how to validate routines.  Choose one.  }
	gxNoValidation				= $00;							{  no validation  }
	gxPublicValidation			= $01;							{  check parameters to public routines  }
	gxInternalValidation		= $02;							{  check parameters to internal routines  }
																{  These levels tell how to validate types.  Choose one.  }
	gxTypeValidation			= $00;							{  check types of objects  }
	gxStructureValidation		= $10;							{  check fields of private structures  }
	gxAllObjectValidation		= $20;							{  check every object over every call  }
																{  These levels tell how to validate memory manager blocks.  Choose any combination.  }
	gxNoMemoryManagerValidation	= $0000;
	gxApBlockValidation			= $0100;						{  check the relevant block structures after each memory mgr. call  }
	gxFontBlockValidation		= $0200;						{  check the system gxHeap as well  }
	gxApHeapValidation			= $0400;						{  check the memory manager’s gxHeap after every mem. call  }
	gxFontHeapValidation		= $0800;						{  check the system gxHeap as well  }
	gxCheckApHeapValidation		= $1000;						{  check the memory manager’s gxHeap if checking routine parameters  }
	gxCheckFontHeapValidation	= $2000;						{  check the system gxHeap as well  }


TYPE
	gxValidationLevel					= LONGINT;

CONST
	no_draw_error				= 0;							{  gxShape type errors  }
	shape_emptyType				= 1;
	shape_inverse_fullType		= 2;
	rectangle_zero_width		= 3;
	rectangle_zero_height		= 4;
	polygon_empty				= 5;
	path_empty					= 6;
	bitmap_zero_width			= 7;
	bitmap_zero_height			= 8;
	text_empty					= 9;
	glyph_empty					= 10;
	layout_empty				= 11;
	picture_empty				= 12;							{  general gxShape errors  }
	shape_no_fill				= 13;
	shape_no_enclosed_area		= 14;
	shape_no_enclosed_pixels	= 15;
	shape_very_small			= 16;
	shape_very_large			= 17;
	shape_contours_cancel		= 18;							{  gxStyle errors  }
	pen_too_small				= 19;
	text_size_too_small			= 20;
	dash_empty					= 21;
	start_cap_empty				= 22;
	pattern_empty				= 23;
	textFace_empty				= 24;
	shape_primitive_empty		= 25;
	shape_primitive_very_small	= 26;							{  gxInk errors  }
	transfer_equals_noMode		= 27;
	transfer_matrix_ignores_source = 28;
	transfer_matrix_ignores_device = 29;
	transfer_source_reject		= 30;
	transfer_mode_ineffective	= 31;
	colorSet_no_entries			= 32;
	bitmap_colorSet_one_entry	= 33;							{  gxTransform errors  }
	transform_scale_too_small	= 34;
	transform_map_too_large		= 35;
	transform_move_too_large	= 36;
	transform_scale_too_large	= 37;
	transform_rotate_too_large	= 38;
	transform_perspective_too_large = 39;
	transform_skew_too_large	= 40;
	transform_clip_no_intersection = 41;
	transform_clip_empty		= 42;
	transform_no_viewPorts		= 43;							{  gxViewPort errors  }
	viewPort_disposed			= 44;
	viewPort_clip_empty			= 45;
	viewPort_clip_no_intersection = 46;
	viewPort_scale_too_small	= 47;
	viewPort_map_too_large		= 48;
	viewPort_move_too_large		= 49;
	viewPort_scale_too_large	= 50;
	viewPort_rotate_too_large	= 51;
	viewPort_perspective_too_large = 52;
	viewPort_skew_too_large		= 53;
	viewPort_viewGroup_offscreen = 54;							{  gxViewDevice errors  }
	viewDevice_clip_no_intersection = 55;
	viewDevice_scale_too_small	= 56;
	viewDevice_map_too_large	= 57;
	viewDevice_move_too_large	= 58;
	viewDevice_scale_too_large	= 59;
	viewDevice_rotate_too_large	= 60;
	viewDevice_perspective_too_large = 61;
	viewDevice_skew_too_large	= 62;


TYPE
	gxDrawError							= LONGINT;

FUNCTION GXGetShapeDrawError(source: gxShape): gxDrawError; C;
PROCEDURE GXValidateAll; C;
PROCEDURE GXValidateColorSet(target: gxColorSet); C;
PROCEDURE GXValidateColorProfile(target: gxColorProfile); C;
PROCEDURE GXValidateGraphicsClient(target: gxGraphicsClient); C;
PROCEDURE GXValidateInk(target: gxInk); C;
PROCEDURE GXValidateShape(target: gxShape); C;
PROCEDURE GXValidateStyle(target: gxStyle); C;
PROCEDURE GXValidateTag(target: gxTag); C;
PROCEDURE GXValidateTransform(target: gxTransform); C;
PROCEDURE GXValidateViewDevice(target: gxViewDevice); C;
PROCEDURE GXValidateViewPort(target: gxViewPort); C;
PROCEDURE GXValidateViewGroup(target: gxViewGroup); C;
FUNCTION GXGetValidation: gxValidationLevel; C;
PROCEDURE GXSetValidation(level: gxValidationLevel); C;
FUNCTION GXGetValidationError(procedureName: CStringPtr; VAR argument: UNIV Ptr; VAR argumentNumber: LONGINT): LONGINT; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GXErrorsIncludes}

{$ENDC} {__GXERRORS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}
