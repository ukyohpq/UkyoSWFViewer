package decompiler.tags.doabc.cpools.multinames
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	
	import flash.utils.ByteArray;
	
	/**
	 * 各种Multiname的基类
	 * multiname_info
			{
				u8 kind
				u8 data[]
			}
	 * @author ukyohpq
	 * 
	 */
	public class SWFMultiname implements IByteArrayReader, ISWFElement
	{
		private var _kind:int;
		public function SWFMultiname(kind:int = 0)
		{
			_kind = kind;
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
		}
		
		public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.writeByte(_kind);
			byte.writeBytes(encodeData());
			return byte;
		}
		
		protected function encodeData():ByteArray
		{
			return new ByteArray;
		}
		
		public function toString():String
		{
			return "[ SWFMultiname * ]";
		}
	}
}