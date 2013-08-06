package decompiler.core.instruction
{
	/**
	 * Undocumented
	 * @author ukyohpq
	 * 
	 */
	public class Deletepropertylate extends AbstractInstruction
	{
		public function Deletepropertylate()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 107;
		}
		
		override public function getName():String
		{
			return "deletepropertylate";
		}
		
		
	}
}