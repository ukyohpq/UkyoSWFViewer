package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		nop
	 * Do nothing.
	 * @author ukyohpq
	 * 
	 */
	public class Nop extends AbstractInstruction
	{
		public function Nop()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 2;
		}
		
		override public function getName():String
		{
			return "nop";
		}
		
		
	}
}