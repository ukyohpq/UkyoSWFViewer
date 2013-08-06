package decompiler.tags
{
	import flash.utils.ByteArray;
	
	public class DebugIDTag extends SWFTag
	{
		public function DebugIDTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}