package decompiler.tags.displayListTag
{
	import decompiler.tags.SWFTag;
	import decompiler.tags.ICanInDefineSpriteTag;
	
	import flash.utils.ByteArray;
	
	public class ShowFrameTag extends SWFTag implements ICanInDefineSpriteTag
	{
		public function ShowFrameTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}