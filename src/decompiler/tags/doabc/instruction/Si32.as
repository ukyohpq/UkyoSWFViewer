package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		si32
	 * Pop value and offset off of the stack.  
	 * The offset's value must lie between 0 and the 
	 * size of the ByteArray which is the Domain's current domainMemory property.  
	 * Store value as a 32-bit integer number at that offset in the ByteArray.
	 * @author ukyohpq
	 * 
	 */
	public class Si32 extends AbstractInstruction
	{
		public function Si32()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 60;
		}
		
		override public function getName():String
		{
			return "si32";
		}
		
		
	}
}