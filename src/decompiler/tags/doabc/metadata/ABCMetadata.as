package decompiler.tags.doabc.metadata
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.utils.SWFUtil;
	
	/**
	 * 	metadata_info
		{
			u30 name
			u30 item_count
			item_info items[item_count]
		}
	 * @author ukyohpq
	 * 
	 */
	public class ABCMetadata implements ISWFElement, IByteArrayReader
	{
		private var _name:uint;
		private var _itemArr:Vector.<ABCMetadataItem>;
		public function ABCMetadata()
		{
		}
		
		public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _name);
			
			var length:int = _itemArr.length;
			SWFUtil.writeU30(byte, length);
			for (var i:int = 0; i < length; ++i) 
			{
				byte.writeBytes(_itemArr[i].encode());
			}
			
			return byte;
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			_name = SWFUtil.readU30(byte);
			var item_count:int = SWFUtil.readU30(byte);
			_itemArr = new Vector.<ABCMetadataItem>(item_count);
			for (var i:int = 0; i < item_count; ++i) 
			{
				var mi:ABCMetadataItem = new ABCMetadataItem;
				mi.decodeFromBytes(byte);
				_itemArr[i] = mi;
			}
		}
		
		public function toString():String
		{
			return "[ABCMetadata name:" + _name + "]";
		}
	}
}