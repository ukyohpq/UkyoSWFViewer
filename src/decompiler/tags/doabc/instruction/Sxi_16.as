package decompiler.tags.doabc.instruction
{
	/**
	 * value popped off the stack and sign-extended by shifting 
	 * left 16 bits and arithmetically shifting right 16 bits.  
	 * The result is pushed onto the stack.
	 * 主要就是截取最后16bit，但是为什么不&65535(16个1)呢？
	 * @author ukyohpq
	 * 
	 */
	public class Sxi_16 extends AbstractInstruction
	{
		public function Sxi_16()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 82;
		}
		
		override public function getName():String
		{
			return "sxi_8";
		}
		
		
	}
}