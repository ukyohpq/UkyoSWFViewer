package decompiler.core.instruction
{
	/**
	 * Format
		not
	 * 	Pop value off of the stack. Convert value to a Boolean using the ToBoolean algorithm
		(ECMA-262 section 9.2) and then negate the Boolean value. Push the result onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Not extends AbstractInstruction
	{
		public function Not()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 150;
		}
		
		override public function getName():String
		{
			return "not";
		}
		
		
	}
}