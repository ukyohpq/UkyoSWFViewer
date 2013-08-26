package decompiler.tags.controlTags
{
	import decompiler.tags.ICanInDefineSpriteTag;
	
	import flash.utils.ByteArray;

	public class EndTag extends AbstractControlTag implements ICanInDefineSpriteTag
	{
		public function EndTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
		
		override public function get id():uint
		{
			return 0;
		}
		
		override public function get tagName():String
		{
			return "End";
		}
		
		override protected function encodeData():void
		{
			$data.writeByte(0);
		}
		
	}
}