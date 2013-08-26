package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		increment
	 * 	Pop value off of the stack. Convert value to a Number using the ToNumber algorithm
		(ECMA-262 section 9.3) and then add 1 to the Number value. Push the result onto the
		stack.
	 * @author ukyohpq
	 * 
	 */
	public class Increment extends AbstractInstruction
	{
		public function Increment()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 145;
		}
		
		override public function getName():String
		{
			return "increment";
		}
		
		
	}
}