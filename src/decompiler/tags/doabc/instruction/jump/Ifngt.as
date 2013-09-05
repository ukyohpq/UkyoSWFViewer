package decompiler.tags.doabc.instruction.jump
{

	/**
	 * Format
		ifngt
		offset
	 * 	offset is an s24 that is the number of bytes to jump if value1 is not greater than or value2.
		Compute value2 < value1 using the abstract relational comparison algorithm in ECMA-262
		section 11.8.5. If the result of the comparison is not true, jump the number of bytes
		indicated by offset. Otherwise continue executing code from this point.
	 * @author ukyohpq
	 * 
	 */
	public class Ifngt extends JumpSet
	{
		public function Ifngt()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 14;
		}
		
		override public function getName():String
		{
			return "ifngt";
		}
		
//		override public function toString():String
//		{
//			return "[ ifngt offset:" + offset + " ]";
//		}
		
		override public function deltaNumStack():int
		{
			return -2;
		}
	}
}