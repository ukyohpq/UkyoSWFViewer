package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		increment_i
	 * 	Pop value off of the stack. Convert value to an int using the ToInt32 algorithm (ECMA-262
		section 9.5) and then add 1 to the int value. Push the result onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Increment_i extends AbstractInstruction
	{
		public function Increment_i()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 192;
		}
		
		override public function getName():String
		{
			return "increment_i";
		}
	}
}