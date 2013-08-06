package decompiler.core.instruction
{
	/**
	 * Format
		dup
	 * Duplicates the top value of the stack, 
	 * and then pushes the duplicated value onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Dup extends AbstractInstruction
	{
		public function Dup()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 42;
		}
		
		override public function getName():String
		{
			return "dup";
		}
		
		
	}
}