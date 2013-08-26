package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		lf64
	 * Pop offset off of the stack.  
	 * The offset's value must lie between 0 and 
	 * the size of the ByteArray which is the Domain's current domainMemory property.  
	 * Push the double value at that offset in the ByteArray onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Lf64 extends AbstractInstruction
	{
		public function Lf64()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 57;
		}
		
		override public function getName():String
		{
			return "lf64";
		}
		
		
	}
}