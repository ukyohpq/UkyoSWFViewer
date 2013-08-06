package decompiler.tags
{
	import flash.utils.ByteArray;
	
	public class SyncFrameTag extends SWFTag
	{
		public function SyncFrameTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}