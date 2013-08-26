package decompiler.tags.controlTags.symbolClass
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	final public class SymbolClassInternalTag implements ISWFElement, IByteArrayReader
	{
		private var _charactorID:int;
		private var _name:String;
		private var _isModified:Boolean;
		public function SymbolClassInternalTag()
		{
		}
		
		public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			byte.writeShort(_charactorID);
			SWFUtil.writeString(byte, _name);
			return byte;
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			_charactorID = byte.readShort();
			_name = SWFUtil.readString(byte);
		}
		
		public function toString():String
		{
			return "[ SymbolClassInternalTag characterID:" + _charactorID + " name:" + _name + " ]";
		}
		
		public function toXML(name:String = null):SWFXML
		{
			var xml:SWFXML = new SWFXML("SymbolClassInternalTag");
			xml.setAttribute("charactorID", _charactorID);
			xml.setAttribute("name", _name);
			return xml;
		}
		
		public function get isModified():Boolean
		{
			return _isModified;
		}
		
	}
}