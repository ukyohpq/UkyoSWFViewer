package decompiler.tags.doabc.instruction
{
	/**
	 * Undocumented
	 * @author ukyohpq
	 * 
	 */
	public class Callsuperid extends AbstractInstruction
	{
		public function Callsuperid()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 75;
		}
		
		override public function getName():String
		{
			return "callsuperid";
		}
		
		
	}
}