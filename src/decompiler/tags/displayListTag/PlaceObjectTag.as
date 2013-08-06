package decompiler.tags.displayListTag
{
	import decompiler.tags.SWFTag;
	import decompiler.tags.ICanInDefineSpriteTag;
	
	import flash.utils.ByteArray;
	
	public class PlaceObjectTag extends SWFTag implements ICanInDefineSpriteTag
	{
		public function PlaceObjectTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}