package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		coerce_s
	 * value is popped off of the stack and coerced to a String. 
	 * If value is null or undefined, 
	 * then stringvalue is set to null. 
	 * Otherwise stringvalue is set to the result of the ToString algorithm, 
	 * as specified in ECMA-262 section 9.8. stringvalue is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Coerce_s extends AbstractInstruction
	{
		public function Coerce_s()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 133;
		}
		
		override public function getName():String
		{
			return "coerce_s";
		}
		
		
	}
}