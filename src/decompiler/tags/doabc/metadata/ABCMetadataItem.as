package decompiler.tags.doabc.metadata
{
	import decompiler.tags.doabc.ABCFileElement;
	import decompiler.tags.doabc.IReferenceable;
	import decompiler.tags.doabc.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * 	item_info
		{
			u30 key
			u30 value
		}
		 * The item_info entry consists of item_count elements that are interpreted as key/value pairs of indices into the
string table of the constant pool. If the value of key is zero, this is a keyless entry and only carries a value.
	 * @author ukyohpq
	 * 
	 */
	public class ABCMetadataItem extends ABCFileElement implements IReferenceable
	{
		private var _key:int;

		public function get key():int
		{
			return _key;
		}

		public function set key(value:int):void
		{
			modify();
			$abcFile.getStringByIndex(_key).removeReference(this, "key");
			_key = value;
			$abcFile.getStringByIndex(_key).addReference(this, "key");
		}

		private var _value:int;

		public function get value():int
		{
			return _value;
		}

		public function set value(value:int):void
		{
			modify();
			$abcFile.getStringByIndex(_value).removeReference(this, "value");
			_value = value;
			$abcFile.getStringByIndex(_value).addReference(this, "value");
		}

		public function ABCMetadataItem(key:int = 0, value:int = 0)
		{
			_key = key;
			_value = value;
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _key);
			SWFUtil.writeU30(byte, _value);
			return byte;
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_key = SWFUtil.readU30(byte);
			_value = SWFUtil.readU30(byte);
			
			include "../IReferenced_Fragment_1.as";
		}
		
		public function creatRefrenceRelationship():void
		{
			$abcFile.getStringByIndex(_key).addReference(this, "key");
			$abcFile.getStringByIndex(_value).addReference(this, "value");
		}
		
		override public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "item";
			var xml:SWFXML = new SWFXML(name);
			xml.setAttribute("key", _key);
			xml.setAttribute("value", _value);
			return xml;
		}
		
		
	}
}