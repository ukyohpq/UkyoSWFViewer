package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		astypelate
	 * Pop class and value off of the stack. 
	 * class should be an object of type Class. 
	 * If value is of the type specified by class, 
	 * push value back onto the stack. 
	 * If value is not of the type specified by class, 
	 * then push null onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Astypelate extends AbstractInstruction
	{
		public function Astypelate()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 135;
		}
		
		override public function getName():String
		{
			return "astypelate";
		}
		
		override public function deltaNumStack():int
		{
			return -1;
		}
	}
}