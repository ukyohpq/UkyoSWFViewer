package decompiler.core.instruction
{
	/**
	 * Format
		popscope
	 * Pop the top scope off of the scope stack and discards it.
	 * @author ukyohpq
	 * 
	 */
	public class Popscope extends AbstractInstruction
	{
		public function Popscope()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 29;
		}
		
		override public function getName():String
		{
			return "popscope";
		}
		
		
	}
}