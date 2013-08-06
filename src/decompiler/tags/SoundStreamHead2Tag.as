package decompiler.tags
{
	
	import flash.utils.ByteArray;
	
	public class SoundStreamHead2Tag extends SWFTag implements ICanInDefineSpriteTag
	{
		public function SoundStreamHead2Tag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}