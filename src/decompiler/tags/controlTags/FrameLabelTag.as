package decompiler.tags.controlTags
{
	import decompiler.tags.ICanInDefineSpriteTag;
	import decompiler.utils.SWFUtil;
	
	import flash.utils.ByteArray;
	
	public class FrameLabelTag extends AbstractControlTag implements ICanInDefineSpriteTag
	{
		private var _name:String;
		public function FrameLabelTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
		
		override protected function realDecode():void
		{
			_name = SWFUtil.readString($data);
			trace(preFix + "name:" + _name);
		}
	}
}