package decompiler.tags.doabc.instruction.jump
{

	/**
	 * Format
		ifstricteq
		offset
	 * 	offset is an s24 that is the number of bytes to jump if value1 is equal to value2.
		Compute value1 === value2 using the strict equality comparison algorithm in ECMA-262
		section 11.9.6. If the result of the comparison is true, jump the number of bytes indicated
		by offset. Otherwise continue executing code from this point.
	 * @author ukyohpq
	 * 
	 */
	public class Ifstricteq extends JumpSet
	{
		public function Ifstricteq()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 25;
		}
		
		override public function getName():String
		{
			return "ifstricteq";
		}
		
//		override public function toString():String
//		{
//			return "[ ifstricteq offset:" + offset + " ]";
//		}
		
		override public function deltaNumStack():int
		{
			return -2;
		}
	}
}