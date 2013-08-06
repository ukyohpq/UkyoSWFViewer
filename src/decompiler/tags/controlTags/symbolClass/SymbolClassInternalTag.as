package decompiler.tags.controlTags.symbolClass
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	import decompiler.utils.SWFUtil;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class SymbolClassInternalTag implements ISWFElement, IByteArrayReader
	{
		private var characterID:int;
		private var name:String;
		public function SymbolClassInternalTag()
		{
		}
		
		public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			byte.writeShort(characterID);
			SWFUtil.writeString(byte, name);
			return byte;
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			characterID = byte.readShort();
			name = SWFUtil.readString(byte);
		}
		
		public function toString():String
		{
			return "[ SymbolClassInternalTag characterID:" + characterID + " name:" + name + " ]";
		}
	}
}