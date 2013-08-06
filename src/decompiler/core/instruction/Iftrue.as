package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

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
	public class Iftrue extends AbstractInstruction
	{
		private var offset:int;
		public function Iftrue()
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
		
		override protected function stringBody():String
		{
			return "offset:" + offset;
		}
	}
}