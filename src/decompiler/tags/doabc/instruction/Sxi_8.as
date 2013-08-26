package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		sxi_8
	 * value popped off the stack and sign-extended by shifting 
	 * left 24 bits and arithmetically shifting right 24 bits.  
	 * The result is pushed onto the stack.
	 * 主要就是保留最后8bit,但是为什么不&255(8个1)呢？
	 * @author ukyohpq
	 * 
	 */
	public class Sxi_8 extends AbstractInstruction
	{
		public function Sxi_8()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 81;
		}
		
		override public function getName():String
		{
			return "sxi_8";
		}
		
		
	}
}