package decompiler.tags.controlTags.symbolClass
{
	import decompiler.tags.controlTags.AbstractControlTag;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	
	public class SymbolClassTag extends AbstractControlTag
	{
		private var _symbols:Vector.<SymbolClassInternalTag>;
		public function SymbolClassTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
		
		override protected function realDecode():void
		{
			//Number of symbols that will be associated by this tag.
			var NumSymbols:int = $data.readShort();
			_symbols = new Vector.<SymbolClassInternalTag>([NumSymbols]);
//			trace("numSCITags:" + NumSymbols);
			for (var i:int = 0; i < NumSymbols; ++i) 
			{
				var sct:SymbolClassInternalTag = new SymbolClassInternalTag;
				sct.decodeFromBytes($data);
				_symbols[i] = sct;
//				trace("index:" + i + " " + sct);
			}
		}
		
		override protected function encodeData():void
		{
			var length:int = _symbols.length;
			$data.writeShort(length);
			for (var i:int = 0; i < length; ++i) 
			{
				$data.writeBytes(_symbols[i].encode());
			}
		}
		
		
		override protected function contentToXML(xml:SWFXML):void
		{
			var length:int = _symbols.length;
			for (var i:int = 0; i < length; ++i) 
			{
				xml.appendChild(_symbols[i].toXML());
			}
		}
		
	}
}