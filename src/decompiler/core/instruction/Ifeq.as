package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		ifeq
		offset
	 * 	offset is an s24 that is the number of bytes to jump if value1 is equal to value2.
		Compute value1 == value2 using the abstract equality comparison algorithm in ECMA-262
		section 11.9.3 and ECMA-347 section 11.5.1. If the result of the comparison is true, jump
		the number of bytes indicated by offset. Otherwise continue executing code from this point.
	 * @author ukyohpq
	 * 
	 */
	public class Ifeq extends AbstractInstruction
	{
		private var offset:uint;
		public function Ifeq()
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
			return 19;
		}
		
		override public function getName():String
		{
			return "ifeq";
		}
		
//		override public function toString():String
//		{
//			return "[ ifeq offset:" + offset + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "offset:" + offset;
		}
		
		
	}
}