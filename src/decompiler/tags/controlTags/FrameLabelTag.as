package decompiler.tags.controlTags
{
	import decompiler.tags.ICanInDefineSpriteTag;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	
	public class FrameLabelTag extends AbstractControlTag implements ICanInDefineSpriteTag
	{
		private var _name:String;

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			$isModified = true;
			_name = value;
		}

		public function FrameLabelTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
		
		override protected function realDecode():void
		{
			_name = SWFUtil.readString($data);
//			trace("name:" + _name);
		}
		
		override protected function contentToXML(xml:SWFXML):void
		{
			xml.appendChild("<name>" + _name + "</name>");
		}
		
		
	}
}