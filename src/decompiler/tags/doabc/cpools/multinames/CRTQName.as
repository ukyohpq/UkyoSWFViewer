package decompiler.tags.doabc.cpools.multinames
{
	import decompiler.tags.doabc.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;

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
			modify();
			$abcFile.getStringByIndex(_name).removeReference(this, "name");
			_name = value;
			$abcFile.getStringByIndex(_name).addReference(this, "name");
		}

		public function CRTQName(name:int = 0)
		{
			super(MultinameKind.CONSTANT_RTQName);
			_name = name;
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_name = SWFUtil.readU30(byte);
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
			return "[ CRTQName name:" + $abcFile.getStringByIndex(_name) + " ]";
		}
		
		override protected function contentToXML(xml:SWFXML):void
		{
			xml.appendChild("<name>" + $abcFile.getStringByIndex(_name) + " str(" + _name + ")" + "</name>");
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getStringByIndex(_name).addReference(this, "name");
		}
	}
}