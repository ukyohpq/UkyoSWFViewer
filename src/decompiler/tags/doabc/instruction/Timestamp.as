package decompiler.tags.doabc.instruction
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
		
		override public function getForm():int
		{
			return 243;
		}
		
		override public function getName():String
		{
			return "timestamp";
		}
		
		
	}
}