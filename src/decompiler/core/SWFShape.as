package decompiler.core
{
	import decompiler.utils.BitArray;
	
	import flash.utils.ByteArray;
	
	public class SWFShape implements IByteArrayReader, ISWFElement
	{
		private var _numFillBits:int;
		private var _numLineBits:int;
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
	}
}