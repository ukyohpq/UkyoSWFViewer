package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		multiply_i
	 * 	Pop value1 and value2 off of the stack, convert value1 and value2 to int to create value1_int
		and value2_int. Multiply value1_int by value2_int and push the result onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Multiply_i extends AbstractInstruction
	{
		public function Multiply_i()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 199;
		}
		
		override public function getName():String
		{
			return "multiply_i";
		}
		
		override public function deltaNumStack():int
		{
			return -1;
		}
	}
}