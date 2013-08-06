package decompiler.tags.doabc.metadata
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.utils.SWFUtil;
	
	/**
	 * 	item_info
		{
			u30 key
			u30 value
		}
	 * @author ukyohpq
	 * 
	 */
	public class ABCMetadataItem implements ISWFElement, IByteArrayReader
	{
		private var _key:int;

		public function get key():int
		{
			return _key;
		}

		public function set key(value:int):void
		{
			_key = value;
		}

		private var _value:int;

		public function get value():int
		{
			return _value;
		}

		public function set value(value:int):void
		{
			_value = value;
		}

		public function ABCMetadataItem(key:int = 0, value:int = 0)
		{
			_key = key;
			_value = value;
		}
		
		public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _key);
			SWFUtil.writeU30(byte, _value);
			return byte;
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			_key = SWFUtil.readU30(byte);
			_value = SWFUtil.readU30(byte);
		}
	}
}