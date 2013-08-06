package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		pushbyte
		byte_value
	 * byte_value is an unsigned byte. The byte_value is promoted to an int, and the result is pushed
		onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Pushbyte extends AbstractInstruction
	{
		private var byte_value:uint;
		public function Pushbyte()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			byte_value = byte.readUnsignedByte();
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			byte.writeByte(byte_value);
		}
		
		override public function getForms():int
		{
			return 36;
		}
		
		override public function getName():String
		{
			return "pushbyte";
		}
		
//		override public function toString():String
//		{
//			return "[ pushbyte byte_value:" + byte_value + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "byte_value:" + byte_value;
		}
		
		
	}
}