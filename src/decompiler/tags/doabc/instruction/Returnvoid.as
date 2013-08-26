package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		returnvoid
	 * Return from the currently executing method. This returns the value undefined. If the
		method has a return type, then undefined is coerced to that type and then returned.
	 * @author ukyohpq
	 * 
	 */
	public class Returnvoid extends AbstractInstruction
	{
		public function Returnvoid()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 71;
		}
		
		override public function getName():String
		{
			return "returnvoid";
		}
		
		
	}
}