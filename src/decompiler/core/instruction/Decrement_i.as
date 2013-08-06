package decompiler.core.instruction
{
	/**
	 * Format
		decrement_i
	 * Pop value off of the stack. 
	 * Convert value to an int using the ToInt32 algorithm 
	 * (ECMA-262 section 9.5) and then subtract 1 from the int value. 
	 * Push the result onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Decrement_i extends AbstractInstruction
	{
		public function Decrement_i()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 193;
		}
		
		override public function getName():String
		{
			return "decrement_i";
		}
		
	}
}