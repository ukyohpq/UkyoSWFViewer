package decompiler.tags.controlTags.defineSceneAndFrameLabelData
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	final public class OffsetAndName implements IByteArrayReader, ISWFElement
	{
		private var _offset:uint;
		private var _name:String;
		private var _isModified:Boolean;
		public function OffsetAndName()
		{
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			_offset = SWFUtil.readU32(byte);
			_name = SWFUtil.readString(byte);
		}
		
		public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU32(byte, _offset);
			SWFUtil.writeString(byte, _name);
			return byte;
		}
		
		public function toString():String
		{
			return "[ offset:" + _offset + " name:" + _name + " ]";
		}
		
		public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "OffsetAndName";
			var xml:SWFXML = new SWFXML(name);
			xml.setAttribute("offset", _offset);
			xml.setAttribute("name", _name);
			return xml;
		}
		
		public function get isModified():Boolean
		{
			return _isModified;
		}
		
	}
}