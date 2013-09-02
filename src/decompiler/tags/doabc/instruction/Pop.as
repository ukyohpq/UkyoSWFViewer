package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		pop
	 * Pops the top value from the stack and discards it.
	 * @author ukyohpq
	 * 
	 */
	public class Pop extends AbstractInstruction
	{
		public function Pop()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 41;
		}
		
		override public function getName():String
		{
			return "pop";
		}
		
		override public function deltaNumStack():int
		{
			return -1;
		}
	}
}