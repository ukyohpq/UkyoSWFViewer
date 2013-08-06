package decompiler.core.instruction
{
	/**
	 * Format
		convert_d
	 * value is popped off of the stack and converted to a double. 
	 * The result, doublevalue, is pushed onto the stack. 
	 * This uses the ToNumber algorithm, as described in ECMA-262 section 9.3, 
	 * to perform the conversion
	 * @author ukyohpq
	 * 
	 */
	public class Convert_d extends AbstractInstruction
	{
		public function Convert_d()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 117;
		}
		
		override public function getName():String
		{
			return "convert_d";
		}
		
		
	}
}