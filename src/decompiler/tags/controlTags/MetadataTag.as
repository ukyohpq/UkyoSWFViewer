package decompiler.tags.controlTags
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	
	public class MetadataTag extends AbstractControlTag
	{
		private var _metadata:String;

		public function get metadata():String
		{
			return _metadata;
		}

		public function set metadata(value:String):void
		{
			$isModified = true;
			_metadata = value;
		}

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
//			trace("metadata:\n" + XML(_metadata));
		}
		
		override protected function contentToXML(xml:SWFXML):void
		{
			xml.appendChild("<metadata><![CDATA[\n" + XML(_metadata).toXMLString() + "\n]]></metadata>");
		}
		
		
	}
}