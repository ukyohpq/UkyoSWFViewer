package decompiler.core
{
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	
	public class SWFClipActions implements IByteArrayReader, ISWFElement
	{
		protected var $isModified:Boolean;
		public function SWFClipActions()
		{
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			//todo
		}
		
		public function get isModified():Boolean
		{
			// TODO Auto Generated method stub
			return $isModified;
		}
		
		
		public function encode():ByteArray
		{
			//todo
			return null;
		}
		
		public function toXML(name:String = null):SWFXML
		{
			return new SWFXML("ClipActions");
		}
	}
}