package decompiler.tags.doabc.instruction.jump
{
	import decompiler.utils.SWFXML;

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
	public class Ifstrictne extends JumpSet
	{
		public function Ifstrictne()
		{
			super();
		}
		
		override public function getForm():int
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
		
		override public function deltaNumStack():int
		{
			return -2;
		}
	}
}