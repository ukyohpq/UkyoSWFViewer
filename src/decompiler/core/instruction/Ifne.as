package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		ifne
		offset
	 * 	offset is an s24 that is the number of bytes to jump if value1 is not equal to value2.
		Compute value1 == value2 using the abstract equality comparison algorithm in ECMA-262
		section 11.9.3 and ECMA-347 Section 11.5.1. If the result of the comparison is false,
		jump the number of bytes indicated by offset. Otherwise continue executing code from this
		point.
	 * @author ukyohpq
	 * 
	 */
	public class Ifne extends AbstractInstruction
	{
		private var offset:int;
		public function Ifne()
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
			return 20;
		}
		
		override public function getName():String
		{
			return "ifne";
		}
		
//		override public function toString():String
//		{
//			return "[ ifne offset:" + offset + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "offset:" + offset;
		}
	}
}