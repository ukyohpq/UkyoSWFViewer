package decompiler.core.instruction
{
	/**
	 * Undocumented
	 * @author ukyohpq
	 * 
	 */
	public class Concat extends AbstractInstruction
	{
		public function Concat()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 154;
		}
		
		override public function getName():String
		{
			return "concat";
		}
		
		
	}
}