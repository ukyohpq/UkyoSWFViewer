package decompiler.tags.doabc.cpools
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;
	
	/**
	 * ns_set_info
			{
				u30 count
				u30 ns[count]
			}
	 * @author ukyohpq
	 * 
	 */
	public class CNsSet implements IByteArrayReader, ISWFElement
	{
		private var _nsArr:Vector.<uint>;
		public function CNsSet()
		{
		}
		
		public function encode():ByteArray
		{
			return null;
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			var length:int = SWFUtil.readU30(byte);
			_nsArr = new Vector.<uint>(length);
			for (var i:int = 0; i < length; ++i) 
			{
				_nsArr[i] = SWFUtil.readU30(byte);
			}
		}
	}
}