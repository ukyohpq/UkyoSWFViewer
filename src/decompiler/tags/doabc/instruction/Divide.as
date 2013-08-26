package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		divide
	 * Pop value1 and value2 off of the stack, 
	 * convert value1 and value2 to Number to create 
	 * value1_number and value2_number. 
	 * Divide value1_number by value2_number and push the result onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Divide extends AbstractInstruction
	{
		public function Divide()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 163;
		}
		
		override public function getName():String
		{
			return "divide";
		}
		
		
	}
}