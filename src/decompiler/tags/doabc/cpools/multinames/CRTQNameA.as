package decompiler.tags.doabc.cpools.multinames
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.cpools.Cpool_info;
	
	import decompiler.utils.SWFUtil;

	public class CRTQNameA extends SWFMultiname
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
		
		public function CRTQNameA(name:int = 0)
		{
			super(MultinameKind.CONSTANT_RTQNameA);
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