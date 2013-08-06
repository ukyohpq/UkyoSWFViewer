package decompiler.core.instruction
{
	/**
	 * Format
		equals
	 * Pop value1 and value2 off of the stack. 
	 * Compare the two values using the abstract equality comparison algorithm, 
	 * as described in ECMA-262 section 11.9.3 and extended in ECMA- 347 section 11.5.1. 
	 * Push the resulting Boolean value onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Equals extends AbstractInstruction
	{
		public function Equals()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 171;
		}
		
		override public function getName():String
		{
			return "equals";
		}
		
			
	}
}