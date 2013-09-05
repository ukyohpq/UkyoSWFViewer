package decompiler.tags.doabc.instruction.jump
{
	

	/**
	 * Format
		iflt
		offset
	 * offset is an s24 that is the number of bytes to jump if value1 is less than value2.
		Compute value1 < value2 using the abstract relational comparison algorithm in ECMA-262
		section 11.8.5. If the result of the comparison is true, jump the number of bytes indicated
		by offset. Otherwise continue executing code from this point.
	 * @author ukyohpq
	 * 
	 */
	public class Iflt extends JumpSet
	{
		public function Iflt()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 21;
		}
		
		override public function getName():String
		{
			return "iflt";
		}
		
//		override public function toString():String
//		{
//			return "[ iflt offset:" + offset + " ]";
//		}
		
		override public function deltaNumStack():int
		{
			return -2;
		}
	}
}