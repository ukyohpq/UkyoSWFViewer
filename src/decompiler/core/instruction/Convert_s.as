package decompiler.core.instruction
{
	/**
	 * Format
		convert_s
	 * value is popped off of the stack and converted to a string. 
	 * The result, stringvalue, is pushed onto the stack. 
	 * This uses the ToString algorithm, as described in ECMA-262 section 9.8
	 * @author ukyohpq
	 * 
	 */
	public class Convert_s extends AbstractInstruction
	{
		public function Convert_s()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 112;
		}
		
		override public function getName():String
		{
			return "convert_s";
		}
		
		
	}
}