package decompiler.tags.doabc.instruction
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
		
		override public function getForm():int
		{
			return 39;
		}
		
		override public function getName():String
		{
			return "pushfalse";
		}
		
		override public function deltaNumStack():int
		{
			return 1;
		}
	}
}