package decompiler.core.instruction
{
	/**
	 * Format
		convert_b
	 * value is popped off of the stack and converted to a Boolean. 
	 * The result, booleanvalue, is pushed onto the stack. 
	 * This uses the ToBoolean algorithm, 
	 * as described in ECMA-262 section 9.2, to perform the conversion.
	 * @author ukyohpq
	 * 
	 */
	public class Convert_b extends AbstractInstruction
	{
		public function Convert_b()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 118;
		}
		
		override public function getName():String
		{
			return "convert_b";
		}
		
		
	}
}