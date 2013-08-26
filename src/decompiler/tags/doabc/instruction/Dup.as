package decompiler.tags.doabc.instruction
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
		
		override public function getForm():int
		{
			return 42;
		}
		
		override public function getName():String
		{
			return "dup";
		}
		
		
	}
}