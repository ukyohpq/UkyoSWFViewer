package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		lessthan
	 * 	Pop value1 and value2 off of the stack. Compute value1 < value2 using the Abstract
		Relational Comparison Algorithm as described in ECMA-262 section 11.8.5. If the result of
		the comparison is true, then push true onto the stack. Otherwise push false onto the
		stack.
	 * @author ukyohpq
	 * 
	 */
	public class Lessthan extends AbstractInstruction
	{
		public function Lessthan()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 173;
		}
		
		override public function getName():String
		{
			return "lessthan";
		}
		
		override public function deltaNumStack():int
		{
			return -1;
		}
	}
}