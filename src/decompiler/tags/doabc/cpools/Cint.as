package decompiler.tags.doabc.cpools
{
	import decompiler.tags.doabc.reference.ReferencedElement;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class Cint extends ReferencedElement
	{
		private var _value:int;

		public function get value():int
		{
			return _value;
		}

		public function set value(value:int):void
		{
			_value = value;
			modify();
			modify();
		}

		public function Cint(value:int = 0)
		{
			super();
			_value = value;
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_value = SWFUtil.readS32(byte);
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeS32(byte, _value);
			return byte;
		}
		
		override public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "int";
			var xml:SWFXML = new SWFXML(name);
			xml.appendChild(_value);
			return xml;
		}
	}
}