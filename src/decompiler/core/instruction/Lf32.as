package decompiler.core.instruction
{
	/**
	 * Format
		lf32
	 * Pop offset off of the stack.  
	 * The offset's value must lie between 0 and the 
	 * size of the ByteArray which is the Domain's current domainMemory property.  
	 * Push the 32-bit floating point number at that offset in the ByteArray onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Lf32 extends AbstractInstruction
	{
		public function Lf32()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 56;
		}
		
		override public function getName():String
		{
			return "lf32";
		}
	}
}