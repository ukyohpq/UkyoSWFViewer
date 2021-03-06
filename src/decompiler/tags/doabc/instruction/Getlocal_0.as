package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		getlocal_<n>
	 * 	<n> is the index of a local register. The value of that register is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Getlocal_0 extends AbstractInstruction
	{
		public function Getlocal_0()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 208;
		}
		
		override public function getName():String
		{
			return "getlocal_0";
		}
		
		override public function deltaNumStack():int
		{
			return 1;
		}
	}
}