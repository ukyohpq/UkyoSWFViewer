package decompiler.core.instruction
{
	/**
	 * Format
		negate
	 * 	Pop value off of the stack. Convert value to a Number using the ToNumber algorithm
		(ECMA-262 section 9.3) and then negate the Number value. Push the result onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Negate extends AbstractInstruction
	{
		public function Negate()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 144;
		}
		
		override public function getName():String
		{
			return "negate";
		}
		
		
	}
}