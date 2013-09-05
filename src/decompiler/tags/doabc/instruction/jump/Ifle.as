package decompiler.tags.doabc.instruction.jump
{
	

	/**
	 * Format
		ifle
		offset
	 * 	offset is an s24 that is the number of bytes to jump if value1 is less than or equal to value2.
		Compute value2 < value1 using the abstract relational comparison algorithm in ECMA-262
		section 11.8.5. If the result of the comparison is false, jump the number of bytes indicated
		by offset. Otherwise continue executing code from this point.
	 * @author ukyohpq
	 * 
	 */
	public class Ifle extends JumpSet
	{
		public function Ifle()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 22;
		}
		
		override public function getName():String
		{
			return "ifle";
		}
		
//		override public function toString():String
//		{
//			return "[ ifle offset:" + offset + " ]";
//		}
		
		override public function deltaNumStack():int
		{
			return -2;
		}
	}
}