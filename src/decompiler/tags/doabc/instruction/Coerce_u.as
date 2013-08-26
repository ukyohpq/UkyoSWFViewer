package decompiler.tags.doabc.instruction
{
	/**
	 * Undocumented
	 * @author ukyohpq
	 * 
	 */
	public class Coerce_u extends AbstractInstruction
	{
		public function Coerce_u()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 136;
		}
		
		override public function getName():String
		{
			return "coerce_u";
		}
		
		
	}
}