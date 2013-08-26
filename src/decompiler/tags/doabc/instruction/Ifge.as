package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		ifge
		offset
	 * 	offset is an s24 that is the number of bytes to jump if value1 is greater than or equal to value2.
		Compute value1 < value2 using the abstract relational comparison algorithm in ECMA-262
		section 11.8.5. If the result of the comparison is false, jump the number of bytes indicated
		by offset. Otherwise continue executing code from this point.
	 * @author ukyohpq
	 * 
	 */
	public class Ifge extends AbstractInstruction
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

		public function Ifge()
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
			return 24;
		}
		
		override public function getName():String
		{
			return "ifge";
		}
		
//		override public function toString():String
//		{
//			return "[ ifge offset:" + offset + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "offset:" + _offset;
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