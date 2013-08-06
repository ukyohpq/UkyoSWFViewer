package decompiler.core.instruction
{
	/**
	 * Undocumented
	 * @author ukyohpq
	 * 
	 */
	public class Add_d extends AbstractInstruction
	{
		public function Add_d()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 155;
		}
		
		override public function getName():String
		{
			return "add_d";
		}
		
		
	}
}