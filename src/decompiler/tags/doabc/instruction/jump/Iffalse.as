package decompiler.tags.doabc.instruction.jump
{
	import decompiler.utils.SWFXML;

	/**
	 * Format
		iffalse
		offset
	 * 	offset is an s24 that is the number of bytes to jump.
		Pop value off the stack and convert it to a Boolean. If the converted value is false, jump the
		number of bytes indicated by offset. Otherwise continue executing code from this point.
	 * @author ukyohpq
	 * 
	 */
	public class Iffalse extends JumpSet
	{
		public function Iffalse()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 18;
		}
		
		override public function getName():String
		{
			return "Iffalse";
		}
		
//		override public function toString():String
//		{
//			return "[ Iffalse offset:" + offset + " ]";
//		}
		
		override public function deltaNumStack():int
		{
			return -1;
		}
	}
}