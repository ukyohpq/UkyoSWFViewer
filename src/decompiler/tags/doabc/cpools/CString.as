package decompiler.tags.doabc.cpools
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;
	
	/**
	 * string_info
			{
				u30 size
				u8 utf8[size]
			}
	 * @author ukyohpq
	 * 
	 */
	public class CString implements IByteArrayReader, ISWFElement
	{
		private var _str:String;

		public function get str():String
		{
			return _str;
		}

		public function set str(value:String):void
		{
			_str = value;
		}

		public function CString(str:String = "")
		{
			_str = str;
		}
		
		public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			var str:ByteArray = new ByteArray;
			str.writeUTFBytes(_str);
			SWFUtil.writeU30(byte, str.length);
			byte.writeBytes(str);
			byte.position = 0;
			return byte;
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			_str = byte.readUTFBytes(SWFUtil.readU30(byte));
		}
		
		public function toString():String
		{
			return _str;
		}
	}
}