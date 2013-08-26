package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		convert_i
	 * value is popped off of the stack and converted to an integer. 
	 * The result, intvalue, is pushed onto the stack. 
	 * This uses the ToInt32 algorithm, as described in ECMA-262 section 9.5, 
	 * to perform the conversion.
	 * @author ukyohpq
	 * 
	 */
	public class Convert_i extends AbstractInstruction
	{
		public function Convert_i()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 115;
		}
		
		override public function getName():String
		{
			return "convert_i";
		}
		
		
	}
}