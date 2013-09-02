package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		ifeq
		offset
	 * 	offset is an s24 that is the number of bytes to jump if value1 is equal to value2.
		Compute value1 == value2 using the abstract equality comparison algorithm in ECMA-262
		section 11.9.3 and ECMA-347 section 11.5.1. If the result of the comparison is true, jump
		the number of bytes indicated by offset. Otherwise continue executing code from this point.
	 * @author ukyohpq
	 * 
	 */
	public class Ifeq extends AbstractInstruction
	{
		private var _offset:uint;

		public function get offset():uint
		{
			return _offset;
		}

		public function set offset(value:uint):void
		{
			modify();
			_offset = value;
		}

		public function Ifeq()
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
			return 19;
		}
		
		override public function getName():String
		{
			return "ifeq";
		}
		
//		override public function toString():String
//		{
//			return "[ ifeq offset:" + offset + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "offset:" + _offset;
		}
		
		override public function getParams():Vector.<int>
		{
			return new <int>[_offset];
		}
		
		override public function getParamNames():Vector.<String>
		{
			return new <String>["_offset"];
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<offset>" + _offset + "</offset>");
		}
		
		override public function deltaNumStack():int
		{
			return -2;
		}
		
		
	}
}