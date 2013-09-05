package decompiler.tags.doabc.instruction.jump
{

	/**
	 * Format
		ifnlt
		offset
	 * 	offset is an s24 that is the number of bytes to jump if value1 is not less than value2.
		Adobe ActionScript Virtual Machine 2 (AVM2) Overview 74
		Compute value1 < value2 using the abstract relational comparison algorithm in ECMA-262
		section 11.8.5. If the result of the comparison is false, then jump the number of bytes
		indicated by offset. Otherwise continue executing code from this point.
	 * @author ukyohpq
	 * 
	 */
	public class Ifnlt extends JumpSet
	{
		public function Ifnlt()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 12;
		}
		
		override public function getName():String
		{
			return "ifnlt";
		}
		
//		override public function toString():String
//		{
//			return "[ ifnlt offset:" + offset + " ]";
//		}
		
		override public function deltaNumStack():int
		{
			return -2;
		}
	}
}