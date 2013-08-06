package decompiler.tags.controlTags
{
	import decompiler.utils.SWFUtil;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class SetBackgroundColorTag extends AbstractControlTag
	{
		private var rgb:int;
		public function SetBackgroundColorTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
		
		override protected function encodeData():void
		{
			super.encodeData();
			$data.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU24($data, rgb);
		}
		
		override protected function realDecode():void
		{
			rgb = SWFUtil.readU24($data);
			trace("rgb:" + rgb.toString(16));
		}
	}
}