package decompiler.tags.doabc.instruction
{
	/**
	 * Format
			coerce_a
	 * Indicates to the verifier that the value on the stack is of the any type (*). 
	 * Does nothing to value.
	 * @author ukyohpq
	 * 
	 */
	public class Coerce_a extends AbstractInstruction
	{
		public function Coerce_a()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 130;
		}
		
		override public function getName():String
		{
			return "coerce_a";
		}
		
		
	}
}