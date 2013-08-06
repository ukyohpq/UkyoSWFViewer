package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

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
	public class Iffalse extends AbstractInstruction
	{
		private var offset:int;
		public function Iffalse()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			offset = SWFUtil.readS24(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeS24(byte, offset);
		}
		
		override public function getForms():int
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
		
		override protected function stringBody():String
		{
			return "offset:" + offset;
		}
	}
}