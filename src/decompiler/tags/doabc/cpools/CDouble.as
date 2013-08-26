package decompiler.tags.doabc.cpools
{
	import decompiler.tags.doabc.ReferencedElement;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class CDouble extends ReferencedElement
	{
		private var _value:Number;

		public function get value():Number
		{
			return _value;
		}

		public function set value(value:Number):void
		{
			_value = value;
			modify();
		}

		public function CDouble(value:Number = NaN)
		{
			super();
			_value = value;
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_value = SWFUtil.readD64(byte);
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeD64(byte, _value);
			return byte;
		}
		
		override public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "double";
			var xml:SWFXML = new SWFXML(name);
			xml.appendChild(_value);
			return xml;
		}
	}
}