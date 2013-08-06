package decompiler.core.instruction
{
	/**
	 * Format
		lessequals
	 * 	Pop value1 and value2 off of the stack. Compute value2 < value1 using the Abstract
		Relational Comparison Algorithm as described in ECMA-262 section 11.8.5. If the result of
		the comparison is false, push true onto the stack. Otherwise push false onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Lessequals extends AbstractInstruction
	{
		public function Lessequals()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 174;
		}
		
		override public function getName():String
		{
			return "lessequals";
		}
		
		
	}
}