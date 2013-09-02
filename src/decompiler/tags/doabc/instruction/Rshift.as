package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		rshift
	 * Pop value1 and value2 off of the stack, convert value1 to an int to create value1_int and
		convert value2 to a uint to create value2_uint. Right shift value1_int by the result of
		value2_uint & 0x1F (leaving only the 5 least significant bits of value2_uint), and push the
		result onto the stack. The right shift is sign extended, resulting in a signed 32-bit integer. See
		ECMA-262 section 11.7.2
	 * @author ukyohpq
	 * 
	 */
	public class Rshift extends AbstractInstruction
	{
		public function Rshift()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 166;
		}
		
		override public function getName():String
		{
			return "rshift";
		}
		
		override public function deltaNumStack():int
		{
			return -1;
		}
	}
}