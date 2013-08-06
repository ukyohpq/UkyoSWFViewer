package decompiler.core.instruction
{
	/**
	 * Undocumented
	 * @author ukyohpq
	 * 
	 */
	public class Timestamp extends AbstractInstruction
	{
		public function Timestamp()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 243;
		}
		
		override public function getName():String
		{
			return "timestamp";
		}
		
		
	}
}