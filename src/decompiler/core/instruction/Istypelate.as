package decompiler.core.instruction
{
	/**
	 * Format
		istypelate
	 * 	Compute the type of value, and let valueType refer to that type. If valueType is the same as
		type, result is true. If type is a base type of valueType, or an implemented interface of
		valueType, then result is true. Otherwise result is set to false. Push result onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Istypelate extends AbstractInstruction
	{
		public function Istypelate()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 179;
		}
		
		override public function getName():String
		{
			return "istypelate";
		}
		
		
	}
}