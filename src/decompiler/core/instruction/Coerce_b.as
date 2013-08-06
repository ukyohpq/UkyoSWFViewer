package decompiler.core.instruction
{
	/**
	 * Undocumented
	 * @author ukyohpq
	 * 
	 */
	public class Coerce_b extends AbstractInstruction
	{
		public function Coerce_b()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 129;
		}
		
		override public function getName():String
		{
			return "coerce_b";
		}
		
		
	}
}