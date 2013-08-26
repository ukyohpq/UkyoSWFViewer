package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		si8
	 * Pop value and offset off of the stack.  
	 * The offset's value must lie between 0 and the 
	 * size of the ByteArray which is the Domain's current domainMemory property.  
	 * Store value as an 8-bit quantity at that offset in the ByteArray.
	 * @author ukyohpq
	 * 
	 */
	public class Si8 extends AbstractInstruction
	{
		public function Si8()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 58;
		}
		
		override public function getName():String
		{
			return "si8";
		}
		
		
	}
}