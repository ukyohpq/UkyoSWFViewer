package decompiler.core.shapeRecord
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	
	import flash.utils.ByteArray;
	
	public class ShapeRecords implements IByteArrayReader, ISWFElement
	{
		public function ShapeRecords()
		{
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
		}
		
		public function encode():ByteArray
		{
			return null;
		}
	}
}