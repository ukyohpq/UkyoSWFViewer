package decompiler.tags.doabc.cpools.multinames
{
	import decompiler.tags.doabc.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	/**
	 * multiname_kind_MultinameL
					{
						u30 ns_set
					}
	 * The multiname_kind_MultinameL format is used for kinds CONSTANT_MultinameL and CONSTANT_MultinameLA.
	 * @author ukyohpq
	 * 
	 */
	public class CMultinameL extends SWFMultiname
	{
		private var _ns_set:int;

		/**
		 * The ns_set field is an index into the ns_set array of the constant pool. 
		 * The value of ns_set cannot be zero
		 * @return 
		 * 
		 */
		public function get ns_set():int
		{
			return _ns_set;
		}

		public function set ns_set(value:int):void
		{
			$abcFile.getNsSetByIndex(_ns_set).removeReference(this, "ns_set");
			_ns_set = value;
			$abcFile.getNsSetByIndex(_ns_set).addReference(this, "ns_set");
			modify();
		}

		public function CMultinameL(ns_set:int = 0)
		{
			super(MultinameKind.CONSTANT_MultinameL);
			_ns_set = ns_set;
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			/*multiname_kind_MultinameL
			{
				u30 ns_set
			}*/
			_ns_set = SWFUtil.readU30(byte);
			super.decodeFromBytes(byte);
		}
		
		override protected function encodeData():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _ns_set);
			return byte;
		}
		
		override public function toString():String
		{
			return "[ CMultinameL ns_set:" + $abcFile.getNsSetByIndex(_ns_set) + " ]";
		}
		
		override protected function contentToXML(xml:SWFXML):void
		{
			xml.appendChild("<ns_set>" + "nss(" + _ns_set + ")" + "</ns_set>");
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getNsSetByIndex(_ns_set).addReference(this, "ns_set");
		}
	}
}