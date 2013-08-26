package decompiler.tags.doabc.instruction
{
	/**
	 * Undocumented
	 * @author ukyohpq
	 * 
	 */
	public class Bkptline extends AbstractInstruction
	{
		public function Bkptline()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 242;
		}
		
		override public function getName():String
		{
			return "bkptline";
		}
		
	}
}