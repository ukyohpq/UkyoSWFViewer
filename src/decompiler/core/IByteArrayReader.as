package decompiler.core
{
	import flash.utils.ByteArray;

	public interface IByteArrayReader
	{
		function decodeFromBytes(byte:ByteArray):void;
	}
}