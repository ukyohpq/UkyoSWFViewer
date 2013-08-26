package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		bitand
	 * Pop value1 and value2 off of the stack. 
	 * Convert value1 and value2 to integers, 
	 * as per ECMA- 262 section 11.10, 
	 * and perform a bitwise and (&) on the two resulting integer values. 
	 * Push the result onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Bitand extends AbstractInstruction
	{
		public function Bitand()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 168;
		}
		
		override public function getName():String
		{
			return "bitand";
		}
	}
}