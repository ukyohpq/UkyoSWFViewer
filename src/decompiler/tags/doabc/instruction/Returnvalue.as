package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		returnvalue
	 * Return from the currently executing method. This returns the top value on the stack.
		return_value is popped off of the stack, and coerced to the expected return type of the
		method. The coerced value is what is actually returned from the method.
	 * @author ukyohpq
	 * 
	 */
	public class Returnvalue extends AbstractInstruction
	{
		public function Returnvalue()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 72;
		}
		
		override public function getName():String
		{
			return "returnvalue";
		}
		
		
	}
}