package decompiler.core.instruction
{
	/**
	 * Format
		convert_u
	 * value is popped off of the stack and converted to an unsigned integer. 
	 * The result, uintvalue, is pushed onto the stack. This uses the ToUint32 algorithm, 
	 * as described in ECMA-262 section 9.6
	 * @author ukyohpq
	 * 
	 */
	public class Convert_u extends AbstractInstruction
	{
		public function Convert_u()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 116;
		}
		
		override public function getName():String
		{
			return "convert_u";
		}
		
		
	}
}