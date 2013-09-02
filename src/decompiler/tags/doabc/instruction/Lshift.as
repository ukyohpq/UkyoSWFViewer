package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		lshift
	 * 	Pop value1 and value2 off of the stack; convert value1 to an int to create value1_int ; and
		convert value2 to a uint to create value2_uint. Left shift value1_int by the result of
		value2_uint & 0x1F (leaving only the 5 least significant bits of value2_uint), and push the
		result onto the stack. See ECMA-262 section 11.7.1.
	 * @author ukyohpq
	 * 
	 */
	public class Lshift extends AbstractInstruction
	{
		public function Lshift()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 165;
		}
		
		override public function getName():String
		{
			return "lshift";
		}
		
		override public function deltaNumStack():int
		{
			return -1;
		}
	}
}