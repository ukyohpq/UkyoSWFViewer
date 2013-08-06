package decompiler.tags.doabc.cpools.multinames
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	public class CMultinameLA extends SWFMultiname
	{
		private var _ns_set:int;
		
		public function get ns_set():int
		{
			return _ns_set;
		}
		
		public function set ns_set(value:int):void
		{
			_ns_set = value;
		}
		
		public function CMultinameLA(ns_set:int = 0)
		{
			super(MultinameKind.CONSTANT_MultinameLA);
			_ns_set = ns_set;
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			/*multiname_kind_MultinameL
			{
				u30 ns_set
			}*/
			_ns_set = SWFUtil.readU30(byte);
		}
		
		override protected function encodeData():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _ns_set);
			return byte;
		}
		
		override public function toString():String
		{
			return "[ CMultinameL ns_set:" + ABCFile.getInstance().getNsSetByIndex(_ns_set) + " ]";
		}
	}
}