package decompiler.tags.doabc.cpools
{
	import decompiler.tags.doabc.ReferencedElement;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	
	/**
	 * string_info
			{
				u30 size
				u8 utf8[size]
			}
	 * @author ukyohpq
	 * 
	 */
	public class CString extends ReferencedElement
	{
		private var _str:String;

		public function get str():String
		{
			return _str;
		}

		public function set str(value:String):void
		{
			modify();
			_str = value;
		}

		public function CString(str:String = "")
		{
			_str = str;
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			var str:ByteArray = new ByteArray;
			str.writeUTFBytes(_str);
			SWFUtil.writeU30(byte, str.length);
			byte.writeBytes(str);
			byte.position = 0;
			return byte;
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_str = byte.readUTFBytes(SWFUtil.readU30(byte));
		}
		
		public function toString():String
		{
			return _str;
		}
		
		override public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "str";
			var xml:SWFXML = new SWFXML(name);
			//检测_str是否具有xml干扰
			if(_str.indexOf("<") != -1 || _str.indexOf(">") != -1)
			{
				//检查_str是否具有<![CDATA[]]>干扰
				if(_str.indexOf("<![CDATA[") != -1 || _str.indexOf("]]>") != -1)
				{
					_str = encodeURIComponent(_str);
				}else{
					_str = "<![CDATA[" + _str + "]]>";
				}
				xml.setAttribute("illegal", true);
			}
			xml.appendChild(_str);
			
			return xml;
		}
		
	}
}