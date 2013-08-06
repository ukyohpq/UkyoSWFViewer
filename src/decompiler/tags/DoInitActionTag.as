package decompiler.tags
{
	import flash.utils.ByteArray;
	
	public class DoInitActionTag extends SWFTag implements ICanInDefineSpriteTag
	{
		public function DoInitActionTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
	}
}