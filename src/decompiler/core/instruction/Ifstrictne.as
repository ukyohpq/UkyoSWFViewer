package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		ifstrictne
		offset
	 * 	offset is an s24 that is the number of bytes to jump if value1 is not equal to value2.
		Compute value1 === value2 using the strict equality comparison algorithm in ECMA-262
		section 11.9.6. If the result of the comparison is false, jump the number of bytes indicated
		by offset. Otherwise continue executing code from this point.
	 * @author ukyohpq
	 * 
	 */
	public class Ifstrictne extends AbstractInstruction
	{
		private var offset:int;
		public function Ifstrictne()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			offset = SWFUtil.readS24(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeS24(byte, offset);
		}
		
		override public function getForms():int
		{
			return 26;
		}
		
		override public function getName():String
		{
			return "ifstrictne";
		}
		
//		override public function toString():String
//		{
//			return "[ ifstrictne offset:" + offset + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "offset:" + offset;
		}
	}
}