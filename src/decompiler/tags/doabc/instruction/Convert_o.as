package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		convert_o
	 * If value is an Object then nothing happens. Otherwise an exception is thrown
	 * @author ukyohpq
	 * 
	 */
	public class Convert_o extends AbstractInstruction
	{
		public function Convert_o()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 119;
		}
		
		override public function getName():String
		{
			return "convert_o";
		}
		
		
	}
}