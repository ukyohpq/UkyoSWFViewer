package decompiler.tags
{
	import flash.utils.ByteArray;
	
	public class ObfuscationTag extends SWFTag
	{
		public function ObfuscationTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}