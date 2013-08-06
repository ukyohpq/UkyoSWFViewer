package decompiler.tags
{
	import flash.utils.ByteArray;
	
	public class StopSoundTag extends SWFTag
	{
		public function StopSoundTag(id:int, data:ByteArray, preFix:String="")
		{
			super(id, data, preFix);
		}
	}
}