package decompiler.core.instruction
{
	/**
	 * Format
		pushnan
	 * Push the value NaN onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Pushnan extends AbstractInstruction
	{
		public function Pushnan()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 40;
		}
		
		override public function getName():String
		{
			return "pushnan";
		}
		
		
	}
}