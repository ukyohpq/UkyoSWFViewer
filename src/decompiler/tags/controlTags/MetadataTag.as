package decompiler.tags.controlTags
{
	import decompiler.utils.SWFUtil;
	
	import flash.utils.ByteArray;
	
	public class MetadataTag extends AbstractControlTag
	{
		private var _metadata:String;
		public function MetadataTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
		
		override protected function encodeData():void
		{
			super.encodeData();
			SWFUtil.writeString($data, _metadata);
		}
		
		override protected function realDecode():void
		{
			_metadata = SWFUtil.readString($data);
			trace(preFix + "metadata:\n" + XML(_metadata));
		}
		
	}
}