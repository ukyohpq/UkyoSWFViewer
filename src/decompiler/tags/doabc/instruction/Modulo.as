package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		modulo
	 * 	Pop value1 and value2 off of the stack, convert value1 and value2 to Number to create
		value1_number and value2_number. Perform value1_number mod value2_number and push
		the result onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Modulo extends AbstractInstruction
	{
		public function Modulo()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 164;
		}
		
		override public function getName():String
		{
			return "modulo";
		}
		
		
	}
}