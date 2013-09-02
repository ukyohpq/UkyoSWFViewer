package decompiler.tags.doabc.metadata
{
	import decompiler.tags.doabc.ABCFileElement;
	import decompiler.tags.doabc.reference.IReferenceable;
	import decompiler.tags.doabc.reference.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * 	metadata_info
		{
			u30 name
			u30 item_count
			item_info items[item_count]
		}
		 * The name field is an index into the string array of the constant pool; it provides a name for the metadata
entry. The value of the name field must not be zero. Zero or more items may be associated with the entry;
item_count denotes the number of items that follow in the items array.
	 * @author ukyohpq
	 * 
	 */
	public final class ABCMetadata extends ABCFileElement implements IReferenceable
	{
		private var _name:uint;

		public function get name():uint
		{
			return _name;
		}

		public function set name(value:uint):void
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

		private var _itemArr:Vector.<ABCMetadataItem>;

		public function get itemArr():Vector.<ABCMetadataItem>
		{
			return _itemArr.slice();
		}

		public function set itemArr(value:Vector.<ABCMetadataItem>):void
		{
			modify();
			_itemArr = value;
		}
		
		override public function toXML(name:String = null):SWFXML
		{
			var xml:SWFXML = new SWFXML("metadata");
			xml.setAttribute("name", $abcFile.getStringByIndex(_name) + " str(" + _name + ")");
			var length:int = _itemArr.length;
			xml.setAttribute("length", length);
			for (var i:int = 0; i < length; ++i) 
			{
				xml.appendChild(_itemArr[i].toXML("item_" + i));
			}
			return xml;
		}
		
		
		public function ABCMetadata()
		{
			_itemArr = new <ABCMetadataItem>[];
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _name);
			
			var length:int = _itemArr.length;
			SWFUtil.writeU30(byte, length);
			for (var i:int = 0; i < length; ++i) 
			{
				byte.writeBytes(_itemArr[i].encode());
			}
			
			return byte;
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_name = SWFUtil.readU30(byte);
			var item_count:int = SWFUtil.readU30(byte);
			_itemArr.length = item_count;
			for (var i:int = 0; i < item_count; ++i) 
			{
				var mi:ABCMetadataItem = $abcFile.elementFactory(ABCMetadataItem) as ABCMetadataItem;
				mi.decodeFromBytes(byte);
				_itemArr[i] = mi;
			}
			
			include "../reference/IReferenced_Fragment_1.as";
		}
		
		public function toString():String
		{
			return "[ABCMetadata name:" + _name + "]";
		}
		
		public function creatRefrenceRelationship():void
		{
			$abcFile.getStringByIndex(_name).addReference(this, "name");
		}
		
		public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			 include "../reference/IReferenceable_Fragment_1.as"
			
		}
		
	}
}