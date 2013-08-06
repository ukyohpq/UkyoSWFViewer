package decompiler.tags.doabc.cpools.multinames
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.cpools.Cpool_info;
	
	import decompiler.utils.SWFUtil;

	/**
	 * multiname_kind_Multiname
					{
						u30 name
						u30 ns_set
					}
	 * The multiname_kind_Multiname format is used for kinds CONSTANT_Multiname and CONSTANT_MultinameA.
	 * @author ukyohpq
	 * 
	 */
	public class CMultiname extends SWFMultiname
	{
		private var _name:int;

		/**
		 * The name field is an index into the string array
		 * @return 
		 * 
		 */
		public function get name():int
		{
			return _name;
		}

		public function set name(value:int):void
		{
			_name = value;
		}

		private var _ns_set:int;

		/**
		 * the ns_set field is an index into the ns_set array
		 * @return 
		 * 
		 */
		public function get ns_set():int
		{
			return _ns_set;
		}

		public function set ns_set(value:int):void
		{
			_ns_set = value;
		}

		public function CMultiname(name:int = 0, ns_set:int = 0)
		{
			super(MultinameKind.CONSTANT_Multiname);
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
			return "[ CMultiname name:" + abcFile.getStringStrFormByIndex(_name) + " ns_set:" + abcFile.getNsSetByIndex(_ns_set) + " ]";
		}
	}
}