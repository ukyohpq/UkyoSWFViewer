package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		dxns
	 * The top value on the stack is popped, converted to a string, 
	 * and that string is used as the uri for the default XML namespace for this method
	 * @author ukyohpq
	 * 
	 */
	public class Dxnslate extends AbstractInstruction
	{
		public function Dxnslate()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 7;
		}
		
		override public function getName():String
		{
			return "dxnslate";
		}
		
		override public function deltaNumStack():int
		{
			return -1;
		}
	}
}