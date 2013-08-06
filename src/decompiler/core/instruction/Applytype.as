package decompiler.core.instruction
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
		
		override public function getForms():int
		{
			return 83;
		}
		
		override public function getName():String
		{
			return "applytype";
		}
		
		
	}
}