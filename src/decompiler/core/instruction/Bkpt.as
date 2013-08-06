package decompiler.core.instruction
{
	/**
	 * Undocumented   
	 * If in debug mode, enter the debugger. 
	 * @author ukyohpq
	 * 
	 */
	public class Bkpt extends AbstractInstruction
	{
		public function Bkpt()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 1;
		}
		
		override public function getName():String
		{
			return "bkpt";
		}
		
		
	}
}