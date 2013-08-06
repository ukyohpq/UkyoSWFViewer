package decompiler.tags
{
	
	import flash.utils.ByteArray;
	
	public class SoundStreamBlockTag extends SWFTag implements ICanInDefineSpriteTag
	{
		public function SoundStreamBlockTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}