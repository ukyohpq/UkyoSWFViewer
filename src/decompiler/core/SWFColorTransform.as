package decompiler.core
{
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	
	final public class SWFColorTransform implements IByteArrayReader, ISWFElement
	{
		private var _isModified:Boolean;
		public function SWFColorTransform()
		{
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			//todo
		}
		
		public function encode():ByteArray
		{
			//todo
			return null;
		}
		
		public function toXML(name:String = null):SWFXML
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function get isModified():Boolean
		{
			return _isModified;
		}
		
	}
}