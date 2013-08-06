package decompiler.tags.doabc.method
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;
	
	/**
	 * option_detail
		{
			u30 val
			u8 kind
		}
	 * @author ukyohpq
	 * 
	 */
	public class MethodOptionDetail implements IByteArrayReader, ISWFElement
	{
		private var _val:int;

		public function get val():int
		{
			return _val;
		}

		public function set val(value:int):void
		{
			_val = value;
		}

		private var _kind:int;

		public function get kind():int
		{
			return _kind;
		}

		public function set kind(value:int):void
		{
			_kind = value;
		}

		public function MethodOptionDetail(val:int = 0, kind:int = 0)
		{
			_val = val;
			_kind = kind;
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			_val = SWFUtil.readU30(byte);
			_kind = byte.readUnsignedByte();
			trace("MethodOptionDetail: " + ABCFile.getInstance().getValueByKindAndIndex(_kind, _val));
		}
		
		public function encode():ByteArray
		{
			var byte:ByteArray =  new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _val);
			byte.writeByte(_kind);
			return byte;
		}
	}
}