package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		in
	 * 	name is converted to a String, and is looked up in obj. If no property is found, then the
		prototype chain is searched by calling [[HasProperty]] on the prototype of obj. If the
		property is found result is true. Otherwise result is false. Push result onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class In extends AbstractInstruction
	{
		public function In()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 180;
		}
		
		override public function getName():String
		{
			return "in";
		}
		
		override public function deltaNumStack():int
		{
			return -1;
		}
	}
}