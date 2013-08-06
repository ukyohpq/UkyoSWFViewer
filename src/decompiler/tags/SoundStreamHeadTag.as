package decompiler.tags
{
	
	import flash.utils.ByteArray;
	
	public class SoundStreamHeadTag extends SWFTag implements ICanInDefineSpriteTag
	{
		public function SoundStreamHeadTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}