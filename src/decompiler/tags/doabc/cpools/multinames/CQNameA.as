package decompiler.tags.doabc.cpools.multinames
{
	import decompiler.tags.doabc.reference.Reference;
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
			try{
				$abcFile.getStringByIndex(_name).removeReference(this, "ns");
			}catch(err:Error)
			{
				trace(err);
			}
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
			try{
				$abcFile.getStringByIndex(_name).removeReference(this, "name");
			}catch(err:Error)
			{
				trace(err);
			}
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
		
		override public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			include "../../reference/IReferenceable_Fragment_1.as";
		}
	}
}