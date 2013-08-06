package decompiler.core.instruction
{
	/**
	 * Format
		pushscope
	 * Pop value off of the stack. Push value onto the scope stack.
	 * @author ukyohpq
	 * 
	 */
	public class Pushscope extends AbstractInstruction
	{
		public function Pushscope()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 48;
		}
		
		override public function getName():String
		{
			return "pushscope";
		}
		
		
	}
}