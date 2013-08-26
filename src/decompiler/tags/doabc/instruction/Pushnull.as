package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		pushnull
	 * Push the null value onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Pushnull extends AbstractInstruction
	{
		public function Pushnull()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 32;
		}
		
		override public function getName():String
		{
			return "pushnull";
		}
		
		
	}
}