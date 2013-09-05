package decompiler.tags.doabc.instruction.jump
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		iftrue
		offset
	 * 	offset is an s24 that is the number of bytes to jump.
		Pop value off the stack and convert it to a Boolean. If the converted value is true, jump the
		number of bytes indicated by offset. Otherwise continue executing code from this point.
	 * @author ukyohpq
	 * 
	 */
	public class Iftrue extends JumpSet
	{
		public function Iftrue()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 17;
		}
		
		override public function getName():String
		{
			return "iftrue";
		}
		
//		override public function toString():String
//		{
//			return "[ iftrue offset:" + offset + " ]";
//		}
		
		override public function deltaNumStack():int
		{
			return -1;
		}
	}
}