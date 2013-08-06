package decompiler.core.instruction
{
	/**
	 * Format
		pushundefined
	 * Push the undefined value onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Pushundefined extends AbstractInstruction
	{
		public function Pushundefined()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 33;
		}
		
		override public function getName():String
		{
			return "pushundefined";
		}
		
		
	}
}