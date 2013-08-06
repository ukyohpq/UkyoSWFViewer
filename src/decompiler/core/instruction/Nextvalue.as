package decompiler.core.instruction
{
	/**
	 * Format
		nextvalue
	 * 	index and obj are popped off of the stack. index must be of type int. Get the value of the
		property that is at position index + 1 on the object obj, and pushes it onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Nextvalue extends AbstractInstruction
	{
		public function Nextvalue()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 35;
		}
		
		override public function getName():String
		{
			return "nextvalue";
		}
		
		
	}
}