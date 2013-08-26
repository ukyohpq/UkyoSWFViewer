package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		sf64
	 * Pop value and offset off of the stack.  
	 * The offset's value must lie between 0 and the size 
	 * of the ByteArray which is the Domain's current domainMemory property.  
	 * Store value as a double-precision (64-bit) 
	 * floating point number at that offset in the ByteArray.
	 * @author ukyohpq
	 * 
	 */
	public class Sf64 extends AbstractInstruction
	{
		public function Sf64()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 62;
		}
		
		override public function getName():String
		{
			return "sf64";
		}
		
		
	}
}