package decompiler.core.shapeRecord
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	
	import flash.utils.ByteArray;
	
	public class EndShapeRecord implements IByteArrayReader, ISWFElement
	{
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
	}
}