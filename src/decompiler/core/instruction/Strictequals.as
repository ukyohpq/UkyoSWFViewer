package decompiler.core.instruction
{
	/**
	 * Format
		strictequals
	 * Pop value1 and value2 off of the stack. Compare the two values using the Strict Equality
		Comparison Algorithm as described in ECMA-262 section 11.9.6. Push the resulting
		Boolean value onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Strictequals extends AbstractInstruction
	{
		public function Strictequals()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 172;
		}
		
		override public function getName():String
		{
			return "strictequals";
		}
		
		
	}
}