package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		jump
		offset
	 * 	offset is an s24 that is the number of bytes to jump. Jump the number of bytes indicated by
		offset and resume execution there.
	 * @author ukyohpq
	 * 
	 */
	public class Jump extends AbstractInstruction
	{
		private var offset:int;
		public function Jump()
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
			return 16;
		}
		
		override public function getName():String
		{
			return "jump";
		}
		
//		override public function toString():String
//		{
//			// TODO Auto Generated method stub
//			return "[ jump offset:" + offset + " ]";
//		}
		
		override protected function stringBody():String
		{
			return " offset:" + offset
		}
		
		
	}
}