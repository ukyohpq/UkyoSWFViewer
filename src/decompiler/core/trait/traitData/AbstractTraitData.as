package decompiler.core.trait.traitData
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	
	import flash.utils.ByteArray;
	
	public class AbstractTraitData implements IByteArrayReader, ISWFElement
	{
		public function AbstractTraitData()
		{
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			throw new Error("must be override");
		}
		
		public function encode():ByteArray
		{
			throw new Error("must be override");
		}
		
		public function getKind():int
		{
			throw new Error("must be override");
		}
	}
}