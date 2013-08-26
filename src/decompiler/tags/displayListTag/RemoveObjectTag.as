package decompiler.tags.displayListTag
{
	import decompiler.tags.ICanInDefineSpriteTag;
	import decompiler.tags.SWFTag;
	
	import flash.utils.ByteArray;
	
	public class RemoveObjectTag extends SWFTag implements ICanInDefineSpriteTag
	{
		public function RemoveObjectTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}