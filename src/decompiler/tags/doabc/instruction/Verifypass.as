package decompiler.tags.doabc.instruction
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
		
		override public function getForm():int
		{
			return 245;
		}
		
		override public function getName():String
		{
			return "verifypass";
		}
		
		
	}
}