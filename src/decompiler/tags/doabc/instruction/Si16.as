package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		si16
	 * Pop value and offset off of the stack.  
	 * The offset's value must lie between 0 and the 
	 * size of the ByteArray which is the Domain's current domainMemory property.  
	 * Store value as a 16-bit quantity at that offset in the ByteArray.
	 * @author ukyohpq
	 * 
	 */
	public class Si16 extends AbstractInstruction
	{
		public function Si16()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 59 ;
		}
		
		override public function getName():String
		{
			return "si16";
		}
		
		
	}
}