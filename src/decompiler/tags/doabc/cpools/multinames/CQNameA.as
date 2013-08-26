package decompiler.tags.doabc.cpools.multinames
{
	import decompiler.tags.doabc.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class CQNameA extends SWFMultiname
	{
		private var _ns:int;
		
		public function get ns():int
		{
			return _ns;
		}
		
		public function set ns(value:int):void
		{
			modify();
			$abcFile.getStringByIndex(_name).removeReference(this, "ns");
			_ns = value;
			$abcFile.getStringByIndex(_name).addReference(this, "ns");
		}
		
		private var _name:int;
		
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
			super.decodeFromBytes(byte);
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
			return "[ CQNameA ns:" + $abcFile.getNsSetByIndex(_ns) + ", name:" + $abcFile.getStringByIndex(_name) + " ]";
		}
		
		override protected function contentToXML(xml:SWFXML):void
		{
			xml.appendChild("<ns>" + $abcFile.getNamespaceByIndex(_ns).toXML() + " ns(" + _ns + ")" + "</ns>");
			xml.appendChild("<name>" + $abcFile.getStringByIndex(_name) + "(str_" + _name + ")" + "</name>");
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getNamespaceByIndex(_ns).addReference(this, "ns");
			$abcFile.getStringByIndex(_name).addReference(this, "name");
		}
	}
}