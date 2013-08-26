package decompiler.core
{
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	
	public class SWFLanguageCode implements IByteArrayReader, ISWFElement
	{
		private var $isModified:Boolean;
		public function SWFLanguageCode()
		{
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
		}
		
		public function encode():ByteArray
		{
			return null;
		}
		
		public function toXML(name:String = null):SWFXML
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function get isModified():Boolean
		{
			return $isModified;
		}
		
	}
}