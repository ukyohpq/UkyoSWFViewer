package decompiler.tags.doabc.instruction
{
	/**
	 * Format
		sxi_1
	 * value popped off the stack and sign-extended by 
	 * shifting left 31 bits and arithmetically shifting right 31 bits.  
	 * The result is pushed onto the stack.
	 * 主要就是保留最后1bit.但是为什么不 & 1呢
	 * @author ukyohpq
	 * 
	 */
	public class Sxi1 extends AbstractInstruction
	{
		public function Sxi1()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 80;
		}
		
		override public function getName():String
		{
			return "sxi_1";
		}
		
		
	}
}