package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		bitor
	 * Pop value1 and value2 off of the stack. 
	 * Convert value1 and value2 to integers, 
	 * as per ECMA- 262 section 11.10, 
	 * and perform a bitwise or (|) on the two resulting integer values. 
	 * Push the result onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Bitor extends AbstractInstruction
	{
		public function Bitor()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 169;
		}
		
		override public function getName():String
		{
			return "bitor";
		}
		
		override public function deltaNumStack():int
		{
			return -1;
		}
	}
}