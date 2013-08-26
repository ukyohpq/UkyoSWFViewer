package decompiler.core.shapeRecord
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	
	public class EndShapeRecord implements IByteArrayReader, ISWFElement
	{
		private var _isModified:Boolean;
		public function EndShapeRecord()
		{
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
		}
		
		public function encode():ByteArray
		{
			return null;
		}
		
		public function get isModified():Boolean
		{
			return _isModified;
		}
		
		
		public function toXML(name:String = null):SWFXML
		{
			return null;
		}
		
	}
}