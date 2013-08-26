package decompiler.tags.doabc
{
	import decompiler.tags.ICanInDefineSpriteTag;
	import decompiler.tags.SWFTag;
	
	import flash.utils.ByteArray;
	
	public class DoAbcTag extends SWFTag implements ICanInDefineSpriteTag
	{
		private var _abcFile:ABCFile;

		public function get abcFile():ABCFile
		{
			return _abcFile;
		}

		public function DoAbcTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
		
		override protected function realDecode():void
		{
			_abcFile = new ABCFile;
			_abcFile.decodeFromBytes($data);
		}
		
		override protected function encodeData():void
		{
			$data.writeBytes(_abcFile.encode());
		}
		
		override public function get isModified():Boolean
		{
			return _abcFile.isModified;
		}
		
		
	}
}