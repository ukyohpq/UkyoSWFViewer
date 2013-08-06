package decompiler.tags
{
	import decompiler.tags.controlTags.DefineScalingGridTag;
	import decompiler.tags.controlTags.EnableDebugger2Tag;
	import decompiler.tags.controlTags.EnableDebuggerTag;
	import decompiler.tags.controlTags.EndTag;
	import decompiler.tags.controlTags.ExportAssetsTag;
	import decompiler.tags.controlTags.FileAttributesTag;
	import decompiler.tags.controlTags.FrameLabelTag;
	import decompiler.tags.controlTags.ImportAssets2Tag;
	import decompiler.tags.controlTags.ImportAssetsTag;
	import decompiler.tags.controlTags.MetadataTag;
	import decompiler.tags.controlTags.ProtectTag;
	import decompiler.tags.controlTags.ScriptLimitsTag;
	import decompiler.tags.controlTags.SetBackgroundColorTag;
	import decompiler.tags.controlTags.SetTabIndexTag;
	import decompiler.tags.controlTags.defineSceneAndFrameLabelData.DefineSceneAndFrameLabelDataTag;
	import decompiler.tags.controlTags.symbolClass.SymbolClassTag;
	import decompiler.tags.defineTags.DefineBehaviorTag;
	import decompiler.tags.defineTags.DefineBinaryDataTag;
	import decompiler.tags.defineTags.DefineBitsJpeg2Tag;
	import decompiler.tags.defineTags.DefineBitsJpeg3Tag;
	import decompiler.tags.defineTags.DefineBitsJpeg4Tag;
	import decompiler.tags.defineTags.DefineBitsLossless2Tag;
	import decompiler.tags.defineTags.DefineBitsLosslessTag;
	import decompiler.tags.defineTags.DefineBitsPtrTag;
	import decompiler.tags.defineTags.DefineBitsTag;
	import decompiler.tags.defineTags.DefineButton2Tag;
	import decompiler.tags.defineTags.DefineButtonCxformTag;
	import decompiler.tags.defineTags.DefineButtonSoundTag;
	import decompiler.tags.defineTags.DefineButtonTag;
	import decompiler.tags.defineTags.DefineCommandObjTag;
	import decompiler.tags.defineTags.DefineEditTextTag;
	import decompiler.tags.defineTags.DefineFont2Tag;
	import decompiler.tags.defineTags.DefineFont3Tag;
	import decompiler.tags.defineTags.DefineFont4Tag;
	import decompiler.tags.defineTags.DefineFontAlignZonesTag;
	import decompiler.tags.defineTags.DefineFontInfo2Tag;
	import decompiler.tags.defineTags.DefineFontInfoTag;
	import decompiler.tags.defineTags.DefineFontNameTag;
	import decompiler.tags.defineTags.DefineFontTag;
	import decompiler.tags.defineTags.DefineFunctionTag;
	import decompiler.tags.defineTags.DefineMorphShape2Tag;
	import decompiler.tags.defineTags.DefineMorphShapeTag;
	import decompiler.tags.defineTags.DefineShape2Tag;
	import decompiler.tags.defineTags.DefineShape3Tag;
	import decompiler.tags.defineTags.DefineShape4ObsoleteTag;
	import decompiler.tags.defineTags.DefineShape4Tag;
	import decompiler.tags.defineTags.DefineShapeTag;
	import decompiler.tags.defineTags.DefineSoundTag;
	import decompiler.tags.defineTags.DefineSpriteTag;
	import decompiler.tags.defineTags.DefineText2Tag;
	import decompiler.tags.defineTags.DefineTextFormatTag;
	import decompiler.tags.defineTags.DefineTextTag;
	import decompiler.tags.defineTags.DefineVideoStreamTag;
	import decompiler.tags.defineTags.DefineVideoTag;
	import decompiler.tags.displayListTag.PlaceObject2Tag;
	import decompiler.tags.displayListTag.PlaceObject3Tag;
	import decompiler.tags.displayListTag.PlaceObjectTag;
	import decompiler.tags.displayListTag.RemoveObject2Tag;
	import decompiler.tags.displayListTag.RemoveObjectTag;
	import decompiler.tags.displayListTag.ShowFrameTag;
	import decompiler.tags.doabc.DoAbc2Tag;
	import decompiler.tags.doabc.DoAbcTag;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public final class TagFactory
	{
		public static function creatTags(byteArray:ByteArray, parent:DefineSpriteTag = null):Vector.<SWFTag>
		{
			var vec:Vector.<SWFTag> = new <SWFTag>[];
			var swfTag:SWFTag;
			var tagHead:int;
			var tagID:int;
			var type:int;
			var isLong:Boolean;
			var length:int;
			var tagData:ByteArray;
			var short_tag_low_6:int = TagConfig.SHORT_TAG_LOW_PART;
			while(byteArray.bytesAvailable)
			{
//				var str:String = "";//\\\\\\\
				//16位无符号整数
				tagHead = byteArray.readUnsignedShort();
//				str += (tagHead & 255).toString(16) + " ";//\\\\\\\\\\\
//				str += (tagHead >> 8).toString(16) + " ";//\\\\\\\\\\\
				//高10位是tagID
				tagID = tagHead >> 6;//高10位低6位
				//低6位是长短tag标记，如果低6位是111111则是长tag，否则是短tag，且低6位是tag长
				type = tagHead & short_tag_low_6;
				isLong = type == short_tag_low_6;
				//如果是长tag，则后32位是tag长，否则tag长是tagHead的低6位
				length = isLong?byteArray.readUnsignedInt():type;
				tagData = new ByteArray;
				tagData.endian = Endian.LITTLE_ENDIAN;
				if(length)
				{
					if(byteArray.bytesAvailable < length)
					{
						trace("格式错误的tag，肯定是放在最末的");
						byteArray.readBytes(tagData, 0);
					}else{
						byteArray.readBytes(tagData, 0, length);
					}
				}
//				var length:int = tagData.length;//\\\\\\\\\\\
//				for (var i:int = 0; i < length; ++i) //\\\\\\\\\\\
//				{//\\\\\\\\\\\
//					str += tagData[i].toString(16) + " ";//\\\\\\\\\\\
//				}//\\\\\\\\\\\
//				trace("hex:" + str);//\\\\\\\\\\\
				
				swfTag = new (getTagClassByID(tagID) as Class)(tagID, tagData);
				if(parent)
				{
					swfTag.parentTag = parent;
					swfTag.preFix = parent.preFix + "\t";
				}
				vec.push(swfTag);
			}
			return vec;
		}
		
		internal static function getTagClassByID(tagID:int):Class
		{
			switch(tagID)
			{
				case TagType.CSMTEXT_SETTINGS: 						return CsmtextSettingsTag;
				case TagType.CHARACTER_SET: 						return CharacterSetTag;
				case TagType.DEBUG_ID: 								return DebugIDTag;
				case TagType.DEFINE_BEHAVIOR: 						return DefineBehaviorTag;
				case TagType.DEFINE_BINARY_DATA: 					return DefineBinaryDataTag;
				case TagType.DEFINE_BITS: 							return DefineBitsTag;
				case TagType.DEFINE_BITS_JPEG_2: 					return DefineBitsJpeg2Tag;
				case TagType.DEFINE_BITS_JPEG_3: 					return DefineBitsJpeg3Tag;
				case TagType.DEFINE_BITS_JPEG_4: 					return DefineBitsJpeg4Tag;
				case TagType.DEFINE_BITS_LOSSLESS: 					return DefineBitsLosslessTag;
				case TagType.DEFINE_BITS_LOSSLESS_2: 				return DefineBitsLossless2Tag;
				case TagType.DEFINE_BITS_PTR: 						return DefineBitsPtrTag;
				case TagType.DEFINE_BUTTON: 						return DefineButtonTag;
				case TagType.DEFINE_BUTTON_2: 						return DefineButton2Tag;
				case TagType.DEFINE_BUTTON_CXFORM: 					return DefineButtonCxformTag;
				case TagType.DEFINE_BUTTON_SOUND: 					return DefineButtonSoundTag;
				case TagType.DEFINE_COMMAND_OBJ: 					return DefineCommandObjTag;
				case TagType.DEFINE_EDIT_TEXT: 						return DefineEditTextTag;
				case TagType.DEFINE_FONT: 							return DefineFontTag;
				case TagType.DEFINE_FONT_2: 						return DefineFont2Tag;
				case TagType.DEFINE_FONT_3: 						return DefineFont3Tag;
				case TagType.DEFINE_FONT_4: 						return DefineFont4Tag;
				case TagType.DEFINE_FONT_ALIGN_ZONES: 				return DefineFontAlignZonesTag;
				case TagType.DEFINE_FONT_INFO: 						return DefineFontInfoTag;
				case TagType.DEFINE_FONT_INFO_2: 					return DefineFontInfo2Tag;
				case TagType.DEFINE_FONT_NAME: 						return DefineFontNameTag;
				case TagType.DEFINE_FUNCTION: 						return DefineFunctionTag;
				case TagType.DEFINE_MORPH_SHAPE: 					return DefineMorphShapeTag;
				case TagType.DEFINE_MORPH_SHAPE_2: 					return DefineMorphShape2Tag;
				case TagType.DEFINE_SCALING_GRID: 					return DefineScalingGridTag;
				case TagType.DEFINE_SCENE_AND_FRAME_LABEL_DATA: 	return DefineSceneAndFrameLabelDataTag;
				case TagType.DEFINE_SHAPE: 							return DefineShapeTag;
				case TagType.DEFINE_SHAPE_2: 						return DefineShape2Tag;
				case TagType.DEFINE_SHAPE_3: 						return DefineShape3Tag;
				case TagType.DEFINE_SHAPE_4: 						return DefineShape4Tag;
				case TagType.DEFINE_SHAPE_4_OBSOLETE: 				return DefineShape4ObsoleteTag;
				case TagType.DEFINE_SOUND: 							return DefineSoundTag;
				case TagType.DEFINE_SPRITE: 						return DefineSpriteTag;
				case TagType.DEFINE_TEXT: 							return DefineTextTag;
				case TagType.DEFINE_TEXT_2: 						return DefineText2Tag;
				case TagType.DEFINE_TEXT_FORMAT: 					return DefineTextFormatTag;
				case TagType.DEFINE_VIDEO: 							return DefineVideoTag;
				case TagType.DEFINE_VIDEO_STREAM: 					return DefineVideoStreamTag;
				case TagType.DO_ABC:								return DoAbcTag;
				case TagType.DO_ABC_2:								return DoAbc2Tag;
				case TagType.DO_ACTION: 							return DoActionTag;
				case TagType.DO_INIT_ACTION: 						return DoInitActionTag;
				case TagType.ENABLE_DEBUGGER: 						return EnableDebuggerTag;
				case TagType.ENABLE_DEBUGGER_2: 					return EnableDebugger2Tag;
				case TagType.ENABLE_TELEMETRY: 						return EnableTelemetryTag;
				case TagType.End: 									return EndTag;
				case TagType.EXPORT_ASSETS: 						return ExportAssetsTag;
				case TagType.FILE_ATTRIBUTES: 						return FileAttributesTag;
				case TagType.FONT_REF: 								return FontRefTag;
				case TagType.FRAME_LABEL: 							return FrameLabelTag;
				case TagType.FRAME_TAG: 							return FrameTagTag;
				case TagType.FREE_CHARACTER: 						return FreeCharacterTag;
				case TagType.FREE_ALL: 								return FreeAllTag;
				case TagType.GEN_COMMAND: 							return GenCommandTag;
				case TagType.GEN_TAG_OBJECT: 						return GenTagObjectTag;
				case TagType.IMPORT_ASSETS: 						return ImportAssetsTag;
				case TagType.IMPORT_ASSETS_2: 						return ImportAssets2Tag;
				case TagType.JPEG_TABLES: 							return JPEGTablesTag;
				case TagType.NAME_CHARACTER: 						return NameCharacterTag;
				case TagType.METADATA: 								return MetadataTag;
				case TagType.OBFUSCATION: 							return ObfuscationTag;
				case TagType.PATHS_ARE_POST_SCRIPT: 				return PathsArePostScriptTag;
				case TagType.PLACE_FUNCTION: 						return PlaceFunctionTag;
				case TagType.PLACE_OBJECT: 							return PlaceObjectTag;
				case TagType.PLACE_OBJECT_2: 						return PlaceObject2Tag;
				case TagType.PLACE_OBJECT_3: 						return PlaceObject3Tag;
				case TagType.PROTECT: 								return ProtectTag;
				case TagType.PRODUCT_INFO: 							return ProductInfoTag;
				case TagType.REMOVE_OBJECT: 						return RemoveObjectTag;
				case TagType.REMOVE_OBJECT_2: 						return RemoveObject2Tag;
				case TagType.SCRIPT_LIMITS: 						return ScriptLimitsTag;
				case TagType.SET_BACKGROUND_COLOR: 					return SetBackgroundColorTag;
				case TagType.SET_TAB_INDEX: 						return SetTabIndexTag;
				case TagType.STOP_SOUND: 							return StopSoundTag;
				case TagType.SHOW_FRAME: 							return ShowFrameTag;
				case TagType.SOUND_STREAM_BLOCK: 					return SoundStreamBlockTag;
				case TagType.SOUND_STREAM_HEAD: 					return SoundStreamHeadTag;
				case TagType.SOUND_STREAM_HEAD_2: 					return SoundStreamHead2Tag;
				case TagType.START_SOUND: 							return StartSoundTag;
				case TagType.START_SOUND_2: 						return StartSound2Tag;
				case TagType.SYNC_FRAME: 							return SyncFrameTag;
				case TagType.SYMBOL_CLASS: 							return SymbolClassTag;
				case TagType.VIDEO_FRAME: 							return VideoFrameTag;
				default:											return UnkownTag;
			}
		}
	}
}