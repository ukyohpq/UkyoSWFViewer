package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

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
		private var _offset:int;

		public function get offset():int
		{
			return _offset;
		}

		public function set offset(value:int):void
		{
			modify();
			_offset = value;
		}

		public function Jump()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_offset = SWFUtil.readS24(byte);
			super.decodeFromBytes(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeS24(byte, _offset);
		}
		
		override public function getForm():int
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
			return " offset:" + _offset
		}
		
		override public function getParams():Vector.<uint>
		{
			return new <uint>[_offset];
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<offset>" + _offset + "</offset>");
		}
	}
}