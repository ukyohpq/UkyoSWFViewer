package decompiler.core.instruction
{
	/**
	 * Undocumented
	 * @author ukyohpq
	 * 
	 */
	public class Verifypass extends AbstractInstruction
	{
		public function Verifypass()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 245;
		}
		
		override public function getName():String
		{
			return "verifypass";
		}
		
		
	}
}