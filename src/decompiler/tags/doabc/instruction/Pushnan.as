package decompiler.tags.doabc.instruction
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
		
		override public function getForm():int
		{
			return 40;
		}
		
		override public function getName():String
		{
			return "pushnan";
		}
		
		override public function deltaNumStack():int
		{
			return 1;
		}
	}
}