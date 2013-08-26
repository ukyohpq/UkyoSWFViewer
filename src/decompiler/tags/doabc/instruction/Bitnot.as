package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		bitnot
	 * Pop value off of the stack. 
	 * Convert value to an integer, as per ECMA-262 section 11.4.8, 
	 * and then apply the bitwise complement operator (~) to the integer. 
	 * Push the result onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Bitnot extends AbstractInstruction
	{
		public function Bitnot()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 151;
		}
		
		override public function getName():String
		{
			return "bitnot";
		}
	}
}