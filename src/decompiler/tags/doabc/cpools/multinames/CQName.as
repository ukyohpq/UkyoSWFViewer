package decompiler.tags.doabc.cpools.multinames
{
	import decompiler.tags.doabc.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;

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
			if(_ns == value) return;
			modify();
			$abcFile.getNamespaceByIndex(_ns).removeReference(this, "ns");
			_ns = value;
			$abcFile.getNamespaceByIndex(_ns).addReference(this, "ns");
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
			if(_name == value) return;
			modify();
			$abcFile.getStringByIndex(_name).removeReference(this, "name");
			_name = value;
			$abcFile.getStringByIndex(_name).addReference(this, "name");
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
			super.decodeFromBytes(byte);
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
			return "[ CQName ns:" + $abcFile.getNamespaceByIndex(_ns) + ", name:" + $abcFile.getStringByIndex(_name) + " ]";
		}
		
		override protected function contentToXML(xml:SWFXML):void
		{
			xml.appendChild("<ns index=\"" + _ns + "\">" + $abcFile.getNamespaceByIndex(_ns).toXML() + "</ns>");
			xml.appendChild("<name>" + $abcFile.getStringByIndex(_name) + "(str_" + _name + ")" + "</name>");
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getNamespaceByIndex(_ns).addReference(this, "ns");
			$abcFile.getStringByIndex(_name).addReference(this, "name");
		}
	}
}