package decompiler.core.instruction
{
	/**
	 * Format
		esc_xattr
	 * value is popped off of the stack and converted to a string. 
	 * The result, stringvalue, is pushed onto the stack. 
	 * This uses the EscapeAttributeValue algorithm as 
	 * described in the E4X specification, 
	 * ECMA-357 section 10.2.1.2, to perform the conversion.
	 * @author ukyohpq
	 * 
	 */
	public class Esc_xattr extends AbstractInstruction
	{
		public function Esc_xattr()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 114;
		}
		
		override public function getName():String
		{
			return "esc_xattr";
		}
		
		
	}
}