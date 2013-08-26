package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

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
		private var _byte_value:uint;

		public function get byte_value():uint
		{
			return _byte_value;
		}

		public function set byte_value(value:uint):void
		{
			modify();
			_byte_value = value;
		}

		public function Pushbyte()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_byte_value = byte.readUnsignedByte();
			super.decodeFromBytes(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			byte.writeByte(_byte_value);
		}
		
		override public function getForm():int
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
			return "byte_value:" + _byte_value;
		}
		
		override public function getParams():Vector.<uint>
		{
			return new <uint>[_byte_value];
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<byte_value>" + _byte_value + "</byte_value>");
		}
	}
}