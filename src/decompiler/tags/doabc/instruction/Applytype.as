package decompiler.tags.doabc.instruction
{
	/**
	 * Undocumented
	 * @author ukyohpq
	 * 
	 */
	public class Applytype extends AbstractInstruction
	{
		public function Applytype()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 83;
		}
		
		override public function getName():String
		{
			return "applytype";
		}
		
		
	}
}