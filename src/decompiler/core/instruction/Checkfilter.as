package decompiler.core.instruction
{
	/**
	 * Format
		checkfilter
	 * This instruction checks that the top value of the 
	 * stack can have a filter operation performed on it. 
	 * If value is of type XML or XMLList then nothing happens. 
	 * If value is of any other type a TypeError is thrown.
	 * @author ukyohpq
	 * 
	 */
	public class Checkfilter extends AbstractInstruction
	{
		public function Checkfilter()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 120;
		}
		
		override public function getName():String
		{
			return "checkfilter";
		}
		
		
	}
}