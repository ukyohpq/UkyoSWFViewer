package decompiler.tags.doabc.cpools.multinames
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * multiname_kind_RTQName
					{
						u30 name
					}
	 * The multiname_kind_RTQName format is used for kinds CONSTANT_RTQName and CONSTANT_RTQNameA
	 * @author ukyohpq
	 * 
	 */
	public class CRTQName extends SWFMultiname
	{
		private var _name:int;

		/**
		 * The single field, name, is an index into the string array of the constant pool. 
		 * A value of zero indicates the any (“*”) name.
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

		public function CRTQName(name:int = 0)
		{
			super(MultinameKind.CONSTANT_RTQName);
			_name = name;
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			// TODO Auto Generated method stub
			super.decodeFromBytes(byte);
		}
		
		override protected function encodeData():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _name);
			return byte;
		}
		
		override public function toString():String
		{
			return "[ CRTQName name:" + ABCFile.getInstance().getStringByIndex(_name) + " ]";
		}
	}
}