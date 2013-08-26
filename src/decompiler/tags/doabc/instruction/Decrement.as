package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		decrement
	 * Pop value off of the stack. 
	 * Convert value to a Number using the ToNumber algorithm 
	 * (ECMA-262 section 9.3) and then subtract 1 from the Number value. 
	 * Push the result onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Decrement extends AbstractInstruction
	{
		public function Decrement()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 147;
		}
		
		override public function getName():String
		{
			return "decrement";
		}
		
		
	}
}