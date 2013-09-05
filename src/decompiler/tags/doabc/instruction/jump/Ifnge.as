package decompiler.tags.doabc.instruction.jump
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		ifnge
		offset
	 * 	offset is an s24 that is the number of bytes to jump if value1 is not greater than or equal to
		value2.
		Compute value1 < value2 using the abstract relational comparison algorithm in ECMA-262
		section 11.8.5. If the result of the comparison is not false, jump the number of bytes
		indicated by offset. Otherwise continue executing code from this point.
	 * @author ukyohpq
	 * 
	 */
	public class Ifnge extends JumpSet
	{
		public function Ifnge()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 15;
		}
		
		override public function getName():String
		{
			return "ifnge";
		}
		
//		override public function toString():String
//		{
//			return "[ ifnge offset:" + offset + " ]";
//		}
		
		override public function deltaNumStack():int
		{
			return -2;
		}
	}
}