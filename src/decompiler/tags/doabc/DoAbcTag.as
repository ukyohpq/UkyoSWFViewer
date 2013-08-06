package decompiler.tags.doabc
{
	import decompiler.tags.ICanInDefineSpriteTag;
	import decompiler.tags.SWFTag;
	
	import flash.utils.ByteArray;
	
	public class DoAbcTag extends SWFTag implements ICanInDefineSpriteTag
	{
		private var _abcData:ABCFile;
		public function DoAbcTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
		
		override protected function realDecode():void
		{
			_abcData = ABCFile.getInstance();
			_abcData.decodeFromBytes($data);
		}
	}
}