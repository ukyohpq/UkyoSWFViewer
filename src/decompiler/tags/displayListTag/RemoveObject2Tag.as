package decompiler.tags.displayListTag
{
	import decompiler.tags.SWFTag;
	import decompiler.tags.ICanInDefineSpriteTag;
	
	import flash.utils.ByteArray;
	
	public class RemoveObject2Tag extends SWFTag implements ICanInDefineSpriteTag
	{
		public function RemoveObject2Tag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}