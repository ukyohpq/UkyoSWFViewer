package decompiler.core.instruction
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
		
		override public function getForms():int
		{
			return 2;
		}
		
		override public function getName():String
		{
			return "nop";
		}
		
		
	}
}