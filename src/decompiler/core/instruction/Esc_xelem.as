package decompiler.core.instruction
{
	/**
	 * Format
		esc_xelem
	 * value is popped off of the stack and converted to a string. 
	 * The result, stringvalue, is pushed onto the stack. 
	 * This uses the ToXmlString algorithm as described in the E4X specification, 
	 * ECMA-357 section 10.2, to perform the conversion
	 * @author ukyohpq
	 * 
	 */
	public class Esc_xelem extends AbstractInstruction
	{
		public function Esc_xelem()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 113;
		}
		
		override public function getName():String
		{
			return "esc_xelem";
		}
		
	}
}