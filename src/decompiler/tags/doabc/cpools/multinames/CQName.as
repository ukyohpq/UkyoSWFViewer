package decompiler.tags.doabc.cpools.multinames
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * multiname_kind_QName
					{
						u30 ns
						u30 name
					}
	 * The multiname_kind_QName format is used for kinds CONSTANT_QName and CONSTANT_QNameA
	 * @author ukyohpq
	 * 
	 */
	public class CQName extends SWFMultiname
	{
		private var _ns:int;

		/**
		 * The ns and name fields are indexes into the namespace and string arrays of the constant_pool entry, respectively.
		 * A value of zero for the ns field indicates the any (“*”) namespace 
		 * @return 
		 * 
		 */
		public function get ns():int
		{
			return _ns;
		}

		public function set ns(value:int):void
		{
			_ns = value;
		}

		private var _name:int;

		/**
		 * The ns and name fields are indexes into the namespace and string arrays of the constant_pool entry, respectively.
		 * A value of zero for the name field indicates the any (“*”) name
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

		public function CQName(ns:int = 0, name:int = 0)
		{
			super(MultinameKind.CONSTANT_QName);
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
			return byte;
		}
		
		override public function toString():String
		{
			var abcFile:ABCFile = ABCFile.getInstance();
			return "[ CQName ns:" + abcFile.getNamespaceByIndex(_ns) + " name:" + abcFile.getStringByIndex(_name) + " ]";
		}
	}
}