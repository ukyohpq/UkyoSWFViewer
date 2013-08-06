package decompiler.core.instruction
{
	/**
	 * Format
		negate_i
	 * 	Pop value off of the stack. Convert value to an int using the ToInt32 algorithm (ECMA-262
		section 9.5) and then negate the int value. Push the result onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Negate_i extends AbstractInstruction
	{
		public function Negate_i()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 196;
		}
		
		override public function getName():String
		{
			return "negate_i";
		}
		
		
	}
}