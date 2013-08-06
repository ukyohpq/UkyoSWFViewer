package decompiler.tags
{
	/**
	 * swftag类别。
	 * 其中部分tag类别不明，可能是历史原因，被取消了
	 * @author ukyohpq
	 * 
	 */
	public final class TagType
	{
		public static const End 								:int = 0;
		public static const SHOW_FRAME 							:int = 1;
		public static const DEFINE_SHAPE 						:int = 2;
		public static const FREE_CHARACTER 						:int = 3;
		public static const PLACE_OBJECT 						:int = 4;
		public static const REMOVE_OBJECT 						:int = 5;
		public static const DEFINE_BITS 						:int = 6;
		public static const DEFINE_BUTTON 						:int = 7;
		public static const JPEG_TABLES 						:int = 8;
		public static const SET_BACKGROUND_COLOR 				:int = 9;
		public static const DEFINE_FONT 						:int = 10;
		public static const DEFINE_TEXT 						:int = 11;
		public static const DO_ACTION 							:int = 12;
		public static const DEFINE_FONT_INFO 					:int = 13;
		public static const DEFINE_SOUND 						:int = 14;
		public static const START_SOUND 						:int = 15;
		public static const STOP_SOUND 							:int = 16;
		public static const DEFINE_BUTTON_SOUND 				:int = 17;
		public static const SOUND_STREAM_HEAD 					:int = 18;
		public static const SOUND_STREAM_BLOCK 					:int = 19;
		public static const DEFINE_BITS_LOSSLESS 				:int = 20;
		public static const DEFINE_BITS_JPEG_2 					:int = 21;
		public static const DEFINE_SHAPE_2 						:int = 22;
		public static const DEFINE_BUTTON_CXFORM 				:int = 23;
		public static const PROTECT 							:int = 24;
		public static const PATHS_ARE_POST_SCRIPT 				:int = 25;
		public static const PLACE_OBJECT_2 						:int = 26;
//		public static const RemoveObject_2 						:int = 27;
		public static const REMOVE_OBJECT_2 					:int = 28;
		public static const SYNC_FRAME 							:int = 29;
//		public static const REMOVE_OBJECT_2 					:int = 30;
		public static const FREE_ALL 							:int = 31;
		public static const DEFINE_SHAPE_3 						:int = 32;
		public static const DEFINE_TEXT_2 						:int = 33;
		public static const DEFINE_BUTTON_2 					:int = 34;
		public static const DEFINE_BITS_JPEG_3 					:int = 35;
		public static const DEFINE_BITS_LOSSLESS_2 				:int = 36;
		public static const DEFINE_EDIT_TEXT 					:int = 37;
		public static const DEFINE_VIDEO 						:int = 38;
		public static const DEFINE_SPRITE 						:int = 39;
		public static const NAME_CHARACTER 						:int = 40;
		public static const PRODUCT_INFO 						:int = 41;
		public static const NAME_OBJECT 						:int = 41;//已废弃
		public static const DEFINE_TEXT_FORMAT 					:int = 42;
		public static const FRAME_LABEL 						:int = 43;
		public static const DEFINE_BEHAVIOR 					:int = 44;
		public static const SOUND_STREAM_HEAD_2 				:int = 45;
		public static const DEFINE_MORPH_SHAPE 					:int = 46;
		public static const FRAME_TAG 							:int = 47;
		public static const DEFINE_FONT_2 						:int = 48;
		public static const GEN_COMMAND 						:int = 49;
		public static const DEFINE_COMMAND_OBJ 					:int = 50;
		public static const CHARACTER_SET 						:int = 51;
		public static const FONT_REF 							:int = 52;
		public static const DEFINE_FUNCTION 					:int = 53;
		public static const PLACE_FUNCTION 						:int = 54;
		public static const GEN_TAG_OBJECT 						:int = 55;
		public static const EXPORT_ASSETS 						:int = 56;
		public static const IMPORT_ASSETS 						:int = 57;
		public static const ENABLE_DEBUGGER 					:int = 58;
		public static const DO_INIT_ACTION 						:int = 59;
		public static const DEFINE_VIDEO_STREAM 				:int = 60;
		public static const VIDEO_FRAME 						:int = 61;
		public static const DEFINE_FONT_INFO_2 					:int = 62;
		public static const DEBUG_ID 							:int = 63;
		public static const ENABLE_DEBUGGER_2 					:int = 64;
		public static const SCRIPT_LIMITS 						:int = 65;
		public static const SET_TAB_INDEX 						:int = 66;
		public static const DEFINE_SHAPE_4_OBSOLETE 			:int = 67;
//		public static const SET_TAB_INDEX 						:int = 68;
		public static const FILE_ATTRIBUTES 					:int = 69;
		public static const PLACE_OBJECT_3 						:int = 70;
		public static const IMPORT_ASSETS_2 					:int = 71;
		public static const DO_ABC								:int = 72;
		public static const DEFINE_FONT_ALIGN_ZONES 			:int = 73;
		public static const CSMTEXT_SETTINGS 					:int = 74;
		public static const DEFINE_FONT_3 						:int = 75;
		public static const SYMBOL_CLASS 						:int = 76;
		public static const METADATA 							:int = 77;
		public static const DEFINE_SCALING_GRID 				:int = 78;
//		public static const DEFINE_SCALING_GRID 				:int = 79;
//		public static const DEFINE_SCALING_GRID 				:int = 80;
//		public static const DEFINE_SCALING_GRID 				:int = 81;
		public static const DO_ABC_2 							:int = 82;
		public static const DEFINE_SHAPE_4 						:int = 83;
		public static const DEFINE_MORPH_SHAPE_2 				:int = 84;
//		public static const DEFINE_MORPH_SHAPE_2 				:int = 85;
		public static const DEFINE_SCENE_AND_FRAME_LABEL_DATA 	:int = 86;
		public static const DEFINE_BINARY_DATA 					:int = 87;
		public static const DEFINE_FONT_NAME 					:int = 88;
		public static const START_SOUND_2 						:int = 89;
		public static const DEFINE_BITS_JPEG_4 					:int = 90;
		public static const DEFINE_FONT_4 						:int = 91;
//		public static const DEFINE_FONT_4 						:int = 92;
		public static const ENABLE_TELEMETRY 					:int = 93;
		public static const OBFUSCATION 						:int = 253;
		public static const DEFINE_BITS_PTR 					:int = 1023;//特殊的tag:1111111111
		
		public static function getNameByID(id:int):String
		{
			switch(id)
			{
				case 0:		return "End";
				case 1:		return "ShowFrame";
				case 2:		return "DefineShape";
				case 3:		return "FreeCharacter";//Undocumented
				case 4:		return "PlaceObject";
				case 5:		return "RemoveObject";
				case 6:		return "DefineBits";
				case 7:		return "DefineButton";
				case 8:		return "JPEGTables";
				case 9:		return "SetBackgroundColor";
				case 10:	return "DefineFont";
				case 11:	return "DefineText";
				case 12:	return "DoAction";
				case 13:	return "DefineFontInfo";
				case 14:	return "DefineSound";
				case 15:	return "StartSound";
				case 16:	return "StopSound";
				case 17:	return "DefineButtonSound";
				case 18:	return "SoundStreamHead";
				case 19:	return "SoundStreamBlock";
				case 20:	return "DefineBitsLossless";
				case 21:	return "DefineBitsJPEG2";
				case 22:	return "DefineShape2";
				case 23:	return "DefineButtonCxform";
				case 24:	return "Protect";
				case 25:	return "PathsArePostScript";//Undocumented
				case 26:	return "PlaceObject2";
				case 28:	return "RemoveObject2";
				case 29:	return "SyncFrame";//Undocumented
				case 31:	return "FreeAll";//Undocumented
				case 32:	return "DefineShape3";
				case 33:	return "DefineText2";
				case 34:	return "DefineButton2";
				case 35:	return "DefineBitsJPEG3";
				case 36:	return "DefineBitsLossless2";
				case 37:	return "DefineEditText";
				case 38:	return "DefineVideo";//Undocumented
				case 39:	return "DefineSprite";
				case 40:	return "NameCharacter";//Undocumented
				case 41:	return "ProductInfo";
//				case 41:	return "NameObject";//重复，已废弃
				case 42:	return "DefineTextFormat";//Undocumented
				case 43:	return "FrameLabel";
				case 44:	return "DefineBehavior";//Undocumented
				case 45:	return "SoundStreamHead2";
				case 46:	return "DefineMorphShape";
				case 47:	return "FrameTag";//Undocumented
				case 48:	return "DefineFont2";
				case 49:	return "GenCommand";//Undocumented
				case 50:	return "DefineCommandObj";//Undocumented
				case 51:	return "CharacterSet";//Undocumented
				case 52:	return "FontRef";//Undocumented
				case 53:	return "DefineFunction";//Undocumented
				case 54:	return "PlaceFunction";//Undocumented
				case 55:	return "GenTagObject";//Undocumented
				case 56:	return "ExportAssets";
				case 57:	return "ImportAssets";
				case 58:	return "EnableDebugger";
				case 59:	return "DoInitAction";
				case 60:	return "DefineVideoStream";
				case 61:	return "VideoFrame";
				case 62:	return "DefineFontInfo2";
				case 63:	return "DebugID";//Undocumented
				case 64:	return "EnableDebugger2";
				case 65:	return "ScriptLimits";
				case 66:	return "SetTabIndex";
				case 67:	return "DefineShape4Obsolete";//Undocumented
				case 69:	return "FileAttributes";
				case 70:	return "PlaceObject3";
				case 71:	return "ImportAssets2";
				case 72:	return "DoABC";
				case 73:	return "DefineFontAlignZones";
				case 74:	return "CsmtextSettings";
				case 75:	return "DefineFont3";
				case 76:	return "SymbolClass";
				case 77:	return "Metadata";
				case 78:	return "DefineScalingGrid";
				case 82:	return "DoABC2";
				case 83:	return "DefineShape4";
				case 84:	return "DefineMorphShape2";
				case 86:	return "DefineSceneAndFrameLabelData";
				case 87:	return "DefineBinaryData";
				case 88:	return "DefineFontName";
				case 89:	return "StartSound2";
				case 90:	return "DefineBitsJPEG4";
				case 91:	return "DefineFont4";
				case 93:	return "EnableTelemetry";//Undocumented
				case 253:	return "Obfuscation";//Undocumented
				case 1023:	return "DefineBitsPtr";//Undocumented
				default:
					return "unknownTag_" + id;
			}
		}
	}
}