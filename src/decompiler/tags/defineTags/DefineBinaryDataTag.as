package decompiler.tags.defineTags
{
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class DefineBinaryDataTag extends AbstractDefineTag
	{
		private var _binaData:ByteArray;
		public function DefineBinaryDataTag(id:int, data:ByteArray)
		{
			super(id, data);
		}
		
		override protected function encodeData():void
		{
			super.encodeData();
			$data.writeShort($charactorID);
			$data.writeInt(0);
			$data.writeBytes(_binaData);
		}
		
		override protected function realDecode():void
		{
			$charactorID = $data.readShort();
			$data.readInt();//Reserved, must be 0
			_binaData = new ByteArray;
			$data.readBytes(_binaData);
//			trace("[ DefineBinaryData characterID:" + $characterID + " ]");
		}
		
		override protected function contentToXML(xml:SWFXML):void
		{
			xml.appendChild("<characterID>" + $charactorID + "</characterID>");
			xml.appendChild("<length>" + _binaData.length + "</length>");
		}
		
		
//		override public function toString():String
//		{
//			return "[ DefineBinaryData characterID:" + $characterID + " ]";
//		}
	}
}