package decompiler.tags.doabc.cpools.multinames
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	public class CQNameA extends SWFMultiname
	{
		private var _ns:int;
		
		public function get ns():int
		{
			return _ns;
		}
		
		public function set ns(value:int):void
		{
			_ns = value;
		}
		
		private var _name:int;
		
		public function get name():int
		{
			return _name;
		}
		
		public function set name(value:int):void
		{
			_name = value;
		}
		
		public function CQNameA(ns:int = 0, name:int = 0)
		{
			super(MultinameKind.CONSTANT_QNameA);
			_ns = ns;
			_name = name;
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			/*multiname_kind_QName
			{
			u30 ns
			u30 name
			}*/
			_ns = SWFUtil.readU30(byte);
			_name = SWFUtil.readU30(byte);
		}
		
		override protected function encodeData():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _ns);
			SWFUtil.writeU30(byte, _name);
			return super.encode();
		}
		
		override public function toString():String
		{
			var abcFile:ABCFile = ABCFile.getInstance();
			return "[ CQNameA ns:" + abcFile.getNsSetByIndex(_ns) + " name:" + abcFile.getStringByIndex(_name) + " ]";
		}
	}
}