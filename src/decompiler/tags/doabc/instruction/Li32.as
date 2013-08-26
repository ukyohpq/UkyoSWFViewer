package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		li32
	 * Pop offset off of the stack.  
	 * The offset's value must lie between 0 and 
	 * the size of the ByteArray which is the Domain's current domainMemory property.  
	 * Push the 32-bit integer value at that offset in the ByteArray onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Li32 extends AbstractInstruction
	{
		public function Li32()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 55;
		}
		
		override public function getName():String
		{
			return "li32";
		}
		
		
	}
}