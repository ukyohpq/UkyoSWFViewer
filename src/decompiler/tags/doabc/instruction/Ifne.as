package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		ifne
		offset
	 * 	offset is an s24 that is the number of bytes to jump if value1 is not equal to value2.
		Compute value1 == value2 using the abstract equality comparison algorithm in ECMA-262
		section 11.9.3 and ECMA-347 Section 11.5.1. If the result of the comparison is false,
		jump the number of bytes indicated by offset. Otherwise continue executing code from this
		point.
	 * @author ukyohpq
	 * 
	 */
	public class Ifne extends AbstractInstruction
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

		public function Ifne()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			offset = SWFUtil.readS24(byte);
			super.decodeFromBytes(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeS24(byte, offset);
		}
		
		override public function getForm():int
		{
			return 20;
		}
		
		override public function getName():String
		{
			return "ifne";
		}
		
//		override public function toString():String
//		{
//			return "[ ifne offset:" + offset + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "offset:" + offset;
		}
		
		override public function getParams():Vector.<uint>
		{
			return new <uint>[offset];
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<offset>" + _offset + "</offset>");
		}
	}
}