package decompiler.core.instruction
{
	/**
	 * Format
		instanceof
	 * 	Pop value and type off of the stack. If value is null result is false. Walk up the prototype
		chain of value looking for type. If type is present anywhere on the prototype, result is true. If
		type is not found on the prototype chain, result is false. Push result onto the stack. See
		ECMA-262 section 11.8.6 for a further description.
	 * @author ukyohpq
	 * 
	 */
	public class Instanceof extends AbstractInstruction
	{
		public function Instanceof()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 177;
		}
		
		override public function getName():String
		{
			return "instanceof";
		}
		
		
	}
}