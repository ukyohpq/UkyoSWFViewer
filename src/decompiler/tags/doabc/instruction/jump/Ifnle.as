package decompiler.tags.doabc.instruction.jump
{

	/**
	 * Format
		ifnle
		offset
	 * offset is an s24 that is the number of bytes to jump if value1 is not less than or equal to
		value2.
		Compute value2 < value1 using the abstract relational comparison algorithm in ECMA-262
		section 11.8.5. If the result of the comparison is true, jump the number of bytes indicated
		by offset. Otherwise continue executing code from this point.
	 * @author ukyohpq
	 * 
	 */
	public class Ifnle extends JumpSet
	{
		public function Ifnle()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 13;
		}
		
		override public function getName():String
		{
			return "ifnle";
		}
		
//		override public function toString():String
//		{
//			return "[ ifnle offset:" + offset + " ]";
//		}
		
		override public function deltaNumStack():int
		{
			return -2;
		}
	}
}