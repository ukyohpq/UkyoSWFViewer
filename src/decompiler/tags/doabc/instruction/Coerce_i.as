package decompiler.tags.doabc.instruction
{
	/**
	 * Undocumented
	 * @author ukyohpq
	 * 
	 */
	public class Coerce_i extends AbstractInstruction
	{
		public function Coerce_i()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 131;
		}
		
		override public function getName():String
		{
			return "coerce_i";
		}
		
		
	}
}