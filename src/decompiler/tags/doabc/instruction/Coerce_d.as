package decompiler.tags.doabc.instruction
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
		
		override public function getForm():int
		{
			return 132;
		}
		
		override public function getName():String
		{
			return "coerce_d";
		}
		
		
	}
}