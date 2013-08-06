package decompiler.core.instruction
{
	/**
	 * Undocumented
	 * @author ukyohpq
	 * 
	 */
	public class Coerce_d extends AbstractInstruction
	{
		public function Coerce_d()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 132;
		}
		
		override public function getName():String
		{
			return "coerce_d";
		}
		
		
	}
}