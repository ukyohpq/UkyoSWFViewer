package decompiler.core.shapeRecord
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	
	public class ShapeRecords implements IByteArrayReader, ISWFElement
	{
		private var _isModified:Boolean;
		public function ShapeRecords()
		{
		}
		
		public function get isModified():Boolean
		{
			return _isModified;
		}
		
		
		public function decodeFromBytes(byte:ByteArray):void
		{
		}
		
		public function toXML(name:String = null):SWFXML
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		
		public function encode():ByteArray
		{
			return null;
		}
	}
}