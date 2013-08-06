package decompiler.tags
{
	import flash.utils.ByteArray;
	
	public class SyncFrame extends SWFTag
	{
		public function SyncFrame(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}