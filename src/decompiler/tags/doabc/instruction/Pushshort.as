package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		pushshort
		value
	 * value is a u30. The value is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Pushshort extends AbstractInstruction
	{
		private var _value:uint;

		public function get value():uint
		{
			return _value;
		}

		public function set value(value:uint):void
		{
			modify();
			_value = value;
		}

		public function Pushshort()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_value = SWFUtil.readU30(byte);
			super.decodeFromBytes(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _value);
		}
		
		override public function getForm():int
		{
			return 37;
		}
		
		override public function getName():String
		{
			return "pushshort";
		}
		
//		override public function toString():String
//		{
//			return "[ pushshort value:" + value + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "value:" + _value;
		}
		
		override public function getParams():Vector.<int>
		{
			return new <int>[_value];
		}
		
		override public function getParamNames():Vector.<String>
		{
			return new <String>["_value"];
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<value>" + _value + "</value>");
		}
		
		override public function deltaNumStack():int
		{
			return 1;
		}
	}
}