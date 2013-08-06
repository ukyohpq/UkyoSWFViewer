package decompiler.core.instruction
{
	/**
	 * Format
		nextname
	 * 	index and obj are popped off of the stack. index must be a value of type int. Gets the name of
		the property that is at position index + 1 on the object obj, and pushes it onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Nextname extends AbstractInstruction
	{
		public function Nextname()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 30;
		}
		
		override public function getName():String
		{
			return "nextname";
		}
		
		
	}
}