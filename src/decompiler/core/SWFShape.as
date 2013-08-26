package decompiler.core
{
	import decompiler.utils.BitArray;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	
	final public class SWFShape implements IByteArrayReader, ISWFElement
	{
		private var _numFillBits:int;
		private var _numLineBits:int;
		private var _isModified:Boolean;
		public function SWFShape()
		{
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			var bitArr:BitArray = new BitArray;
			bitArr.writeByte(byte.readUnsignedByte());
			_numFillBits = bitArr.readByte(4);
			_numLineBits = bitArr.readByte(4);
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
			return _isModified;
		}
		
	}
}