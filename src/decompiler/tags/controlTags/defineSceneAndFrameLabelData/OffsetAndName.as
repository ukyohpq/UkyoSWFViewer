package decompiler.tags.controlTags.defineSceneAndFrameLabelData
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	import decompiler.utils.SWFUtil;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class OffsetAndName implements IByteArrayReader, ISWFElement
	{
		private var _offset:uint;
		private var _name:String;
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
	}
}