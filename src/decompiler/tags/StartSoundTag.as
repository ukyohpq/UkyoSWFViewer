package decompiler.tags
{
	
	import flash.utils.ByteArray;
	
	public class StartSoundTag extends SWFTag implements ICanInDefineSpriteTag
	{
		public function StartSoundTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}