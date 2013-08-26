package decompiler.tags.doabc.cpools
{
	import decompiler.tags.doabc.ReferencedElement;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class Cuint extends ReferencedElement
	{
		private var _value:uint;

		public function get value():uint
		{
			return _value;
		}

		public function set value(value:uint):void
		{
			_value = value;
			modify();
		}

		public function Cuint(value:uint = 0)
		{
			super();
			_value = value;
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_value = SWFUtil.readU32(byte);
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU32(byte, _value);
			return byte;
		}
		
		override public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "uint";
			var xml:SWFXML = new SWFXML(name);
			xml.appendChild(_value);
			return xml;
		}
		
		
	}
}