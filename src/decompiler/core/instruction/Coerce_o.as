package decompiler.core.instruction
{
	/**
	 * Undocumented
	 * @author ukyohpq
	 * 
	 */
	public class Coerce_o extends AbstractInstruction
	{
		public function Coerce_o()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 137;
		}
		
		override public function getName():String
		{
			return "coerce_o";
		}
		
		
	}
}