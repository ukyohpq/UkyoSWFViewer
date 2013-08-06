package decompiler.core.instruction
{
	/**
	 * Format
		swap
	 * Swap the top two values on the stack. Pop value2 and value1. Push value2, then push value1.
	 * @author ukyohpq
	 * 
	 */
	public class Swap extends AbstractInstruction
	{
		public function Swap()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 43;
		}
		
		override public function getName():String
		{
			return "swap";
		}
		
		
	}
}