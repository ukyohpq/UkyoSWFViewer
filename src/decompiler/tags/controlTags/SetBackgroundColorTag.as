package decompiler.tags.controlTags
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class SetBackgroundColorTag extends AbstractControlTag
	{
		private var _rgb:int;

		public function get rgb():int
		{
			return _rgb;
		}

		public function set rgb(value:int):void
		{
			$isModified = true;
			_rgb = value;
		}

		public function SetBackgroundColorTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
		
		override protected function encodeData():void
		{
			SWFUtil.writeU24($data, _rgb);
		}
		
		override protected function contentToXML(xml:SWFXML):void
		{
			xml.appendChild("<rgb>" + _rgb.toString(16) + "</rgb>");
		}
		
		
		override protected function realDecode():void
		{
			_rgb = SWFUtil.readU24($data);
//			trace("rgb:" + rgb.toString(16));
		}
		
	}
}