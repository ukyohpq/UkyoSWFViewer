package decompiler.tags
{
	import flash.utils.ByteArray;
	
	public class VideoFrameTag extends SWFTag
	{
		public function VideoFrameTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}