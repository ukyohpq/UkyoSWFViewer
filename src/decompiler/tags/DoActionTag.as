package decompiler.tags
{
	import flash.utils.ByteArray;
	
	public class DoActionTag extends SWFTag implements ICanInDefineSpriteTag
	{
		public function DoActionTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}