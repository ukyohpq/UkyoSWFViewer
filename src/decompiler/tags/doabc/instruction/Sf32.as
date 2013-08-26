package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		sf32
	 * Pop value and offset off of the stack.  
	 * The offset's value must lie between 0 and the 
	 * size of the ByteArray which is the Domain's current domainMemory property.  
	 * Store value as a single-precision (32-bit) 
	 * floating point number at that offset in the ByteArray.
	 * @author ukyohpq
	 * 
	 */
	public class Sf32 extends AbstractInstruction
	{
		public function Sf32()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 61 ;
		}
		
		override public function getName():String
		{
			return "sf32";
		}
		
		
	}
}