package decompiler.tags.defineTags
{
	import decompiler.core.SWFLanguageCode;
	import decompiler.utils.BitArray;
	
	import flash.utils.ByteArray;
	
	public class DefineFont3Tag extends AbstractDefineTag
	{

		private var _lcd:SWFLanguageCode;
		private var _fontFlagsHasLayout:int;
		private var _fontFlagsShiftJIS:int;
		private var _fontFlagsSmallText:int;
		private var _fontFlagsANSI:int;
		private var _fontFlagsWideOffsets:int;
		private var _fontFlagsWideCodes:int;
		private var _fontFlagsItalic:int;
		private var _fontFlagsBold:int;
		private var _fontName:String;
		private var _offsetTable:Vector.<uint>;

		private var _codeTableOffset:int;
		/**
		 * 尚未解析完，shapeRecords的东西没看明白
		 * @param id
		 * @param data
		 * 
		 */
		public function DefineFont3Tag(id:int, data:ByteArray)
		{
			super(id, data);
		}
		
		/**
		 *	尚未解析完，shapeRecords的东西没看明白 
		 * 
		 */
		override protected function realDecode():void
		{
			return;
			$charactorID = $data.readUnsignedShort();
			var flag:BitArray = new BitArray;
			flag.writeByte($data.readUnsignedByte());
			flag.position = 0;
			_fontFlagsHasLayout = flag.readBit();
			_fontFlagsShiftJIS = flag.readBit();
			_fontFlagsSmallText = flag.readBit();
			_fontFlagsANSI = flag.readBit();
			_fontFlagsWideOffsets = flag.readBit();
			_fontFlagsWideCodes = flag.readBit();
			_fontFlagsItalic = flag.readBit();
			_fontFlagsBold = flag.readBit();
			_lcd = new SWFLanguageCode;
			_lcd.decodeFromBytes($data);
			var fontNameLen:int = $data.readUnsignedByte();
			_fontName = $data.readUTFBytes(fontNameLen);
			var numGlyphs:int = $data.readUnsignedShort();
			_offsetTable = new Vector.<uint>(numGlyphs);
			for (var i:int = 0; i < numGlyphs; ++i) 
			{
				_offsetTable[i] = _fontFlagsWideOffsets?$data.readUnsignedInt():$data.readUnsignedShort();
			}
			_codeTableOffset = _fontFlagsWideCodes?$data.readUnsignedInt():$data.readUnsignedShort();
//			_glyphShapeTable = new Vector.<>
		}
		
		
	}
}