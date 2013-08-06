package decompiler.tags.displayListTag
{
	import decompiler.tags.SWFTag;
	import decompiler.tags.ICanInDefineSpriteTag;
	
	import flash.utils.ByteArray;
	
	public class RemoveObjectTag extends SWFTag implements ICanInDefineSpriteTag
	{
		public function RemoveObjectTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}