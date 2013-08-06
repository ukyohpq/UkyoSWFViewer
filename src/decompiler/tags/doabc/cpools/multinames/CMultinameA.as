package decompiler.tags.doabc.cpools.multinames
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.cpools.Cpool_info;
	
	import decompiler.utils.SWFUtil;

	public class CMultinameA extends SWFMultiname
	{
		private var _name:int;

		public function get name():int
		{
			return _name;
		}

		public function set name(value:int):void
		{
			_name = value;
		}

		private var _ns_set:int;

		public function get ns_set():int
		{
			return _ns_set;
		}

		public function set ns_set(value:int):void
		{
			_ns_set = value;
		}

		public function CMultinameA(name:int = 0, ns_set:int = 0)
		{
			super(MultinameKind.CONSTANT_MultinameA);
			_name = name;
			_ns_set = ns_set;
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			/*multiname_kind_Multiname
			{
				u30 name
				u30 ns_set
			}*/
			_name = SWFUtil.readU30(byte);
			_ns_set = SWFUtil.readU30(byte);
		}
		
		override protected function encodeData():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _name);
			SWFUtil.writeU30(byte, _ns_set);
			return byte;
		}
		
		override public function toString():String
		{
			var abcFile:ABCFile = ABCFile.getInstance();
			return "[ CMultinameA name:" + abcFile.getStringStrFormByIndex(_name) + " ns_set:" + abcFile.getNsSetByIndex(_ns_set) + " ]";
		}
	}
}