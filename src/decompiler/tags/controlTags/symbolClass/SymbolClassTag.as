package decompiler.tags.controlTags.symbolClass
{
	import decompiler.tags.controlTags.AbstractControlTag;
	
	import flash.utils.ByteArray;
	
	public class SymbolClassTag extends AbstractControlTag
	{
		private var symbols:Vector.<SymbolClassInternalTag>;
		public function SymbolClassTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
		
		override protected function realDecode():void
		{
			//Number of symbols that will be associated by this tag.
			var NumSymbols:int = $data.readShort();
			symbols = new Vector.<SymbolClassInternalTag>([NumSymbols]);
			trace(preFix + "numSCITags:" + NumSymbols);
			for (var i:int = 0; i < NumSymbols; ++i) 
			{
				var sct:SymbolClassInternalTag = new SymbolClassInternalTag;
				sct.decodeFromBytes($data)
				symbols[i] = sct;
				trace(preFix + "index:" + i + " " + sct);
			}
		}
	}
}