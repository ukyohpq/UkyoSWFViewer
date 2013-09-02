package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		subtract_i
	 * Pop value1 and value2 off of the stack and convert value1 and value2 to int to create
		value1_int and value2_int. Subtract value2_int from value1_int. Push the result onto the
		stack.
	 * @author ukyohpq
	 * 
	 */
	public class Subtract_i extends AbstractInstruction
	{
		public function Subtract_i()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 198;
		}
		
		override public function getName():String
		{
			return "subtract_i";
		}
		
		override public function deltaNumStack():int
		{
			return -1;
		}
	}
}