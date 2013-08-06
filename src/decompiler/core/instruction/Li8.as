package decompiler.core.instruction
{
	/**
	 * Pop offset off of the stack. 
	 * The offset's value must lie between 0 and 
	 * the size of the ByteArray which is the Domain's current domainMemory property. 
	 * Push the byte at that offset in the ByteArray onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Li8 extends AbstractInstruction
	{
		public function Li8()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 53;
		}
		
		override public function getName():String
		{
			return "li8";
		}
		
		
	}
}