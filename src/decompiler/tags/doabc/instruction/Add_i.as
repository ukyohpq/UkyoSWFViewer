package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		add_i
	 * Pop value1 and value2 off of the stack and convert them to int values 
	 * using the ToInt32 algorithm (ECMA-262 section 9.5). 
	 * Add the two int values and push the result onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Add_i extends AbstractInstruction
	{
		public function Add_i()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 197;
		}
		
		override public function getName():String
		{
			return "add_i";
		}
		
		override public function deltaNumStack():int
		{
			return -1;
		}
	}
}