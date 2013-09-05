package decompiler.tags.doabc.instruction.jump
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

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
	public class Ifeq extends JumpSet
	{
		public function Ifeq()
		{
			super();
		}
		
		override public function getForm():int
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
		
		override public function deltaNumStack():int
		{
			return -2;
		}
		
		
	}
}