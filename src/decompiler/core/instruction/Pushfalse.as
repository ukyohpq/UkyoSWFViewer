package decompiler.core.instruction
{
	/**
	 * Format
		pushfalse	
	 * Push the false value onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Pushfalse extends AbstractInstruction
	{
		public function Pushfalse()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 39;
		}
		
		override public function getName():String
		{
			return "pushfalse";
		}
		
	}
}