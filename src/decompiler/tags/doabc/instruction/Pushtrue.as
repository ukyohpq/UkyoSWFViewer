package decompiler.tags.doabc.instruction
{
	/**
	 * Format
pushtrue
	 * Push the true value onto the stack
	 * @author ukyohpq
	 * 
	 */
	public class Pushtrue extends AbstractInstruction
	{
		public function Pushtrue()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 38;
		}
		
		override public function getName():String
		{
			return "pushtrue";
		}
		
		override public function deltaNumStack():int
		{
			return 1;
		}
	}
}