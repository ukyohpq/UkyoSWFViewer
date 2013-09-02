package decompiler.tags.doabc.trait
{
	import decompiler.tags.doabc.ABCFileElement;
	import decompiler.tags.doabc.reference.IReferenceable;
	import decompiler.tags.doabc.trait.traitData.AbstractTraitData;
	import decompiler.tags.doabc.trait.traitData.TraitDataFactory;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 *	traits_info
		{
			u30 name
			u8 kind
			u8 data[]
			u30 metadata_count
			u30 metadata[metadata_count]
		} 
	 * @author ukyohpq
	 * 
	 */
	public class TraitsInfo extends ABCFileElement implements IReferenceable
	{
		private var _target:IHasTraits;

		/**
		 * 拥有这个trait的对象
		 * @return 
		 * 
		 */
		public function get target():IHasTraits
		{
			return _target;
		}
		
		public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			 include "../reference/IReferenceable_Fragment_1.as"
			
		}
		
		
		public function set target(value:IHasTraits):void
		{
			_target = value;
		}

		private var _name:uint;

		/**
		 * The name field is an index into the multiname array of the constant pool; 
		 * it provides a name for the trait. 
		 * The value can not be zero, and the multiname entry specified must be a QName.
		 */
		public function get name():uint
		{
			return _name;
		}

		/**
		 * @private
		 */
		public function set name(value:uint):void
		{
			modify();
			try{
				$abcFile.getMultinameByIndex(_name).removeReference(this, "name");
			}catch(err:Error)
			{
				trace(err);
			}
			_name = value;
			$abcFile.getMultinameByIndex(_name).addReference(this, "name");
		}

		private var _data:AbstractTraitData;

		public function set data(value:AbstractTraitData):void
		{
			_data = value;
		}

		/**
		 * The interpretation of the data field depends on the type of the trait, 
		 * which is provided by the low four bits of the kind field. 
		 * See below for a full description.
		 */
		public function get data():AbstractTraitData
		{
			return _data;
		}
		
		/**
		 * These fields are present only if ATTR_Metadata is present in the upper four bits of the kind field.
		 * The value of the metadata_count field is the number of entries in the metadata array. 
		 * That array contains indices into the metadata array of the abcFile.
		 */
		private var _metadataVec:Vector.<uint>;
		
		//traiAttributes
		private var _isMetadata:int;

		public function get isMetadata():int
		{
			return _isMetadata;
		}

		public function set isMetadata(value:int):void
		{
			modify();
			_isMetadata = value;
		}

		private var _isOverride:int;

		public function get isOverride():int
		{
			return _isOverride;
		}

		public function set isOverride(value:int):void
		{
			modify();
			_isOverride = value;
		}

		private var _isFinal:int;

		public function get isFinal():int
		{
			return _isFinal;
		}

		public function set isFinal(value:int):void
		{
			modify();
			_isFinal = value;
		}
		
		public function TraitsInfo()
		{
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_name = SWFUtil.readU30(byte);
//			trace("TraitsInfo name:" + $abcFile.getMultinameByIndex(_name));
//			parse kind
//			The kind field contains two four-bit fields. The lower four bits determine the kind of this trait. The
//			upper four bits comprise a bit vector providing attributes of the trait. See the following tables and
//			sections for full descriptions.
			var kind:int = byte.readUnsignedByte();
			var traitKind:int = kind & 15;
			var traiAttributes:int = (kind >> 4) & 15;
			_isFinal = traiAttributes & 1;
//			trace("TraitsInfo isFinal:" + _isFinal);
			_isOverride = (traiAttributes >> 1) & 1;
//			trace("TraitsInfo isOverride:" + _isOverride);
			_isMetadata = (traiAttributes >> 2) & 1;
//			trace("TraitsInfo isMetadata:" + _isMetadata);
			
			_data = TraitDataFactory.creatTrait(traitKind, $abcFile);
			_data.decodeFromBytes(byte);
			
			if(_isMetadata)
			{
				var length:int = SWFUtil.readU30(byte);
				_metadataVec = new Vector.<uint>(length);
				for (var i:int = 0; i < length; ++i) 
				{
					_metadataVec[i] = SWFUtil.readU30(byte);
				}
				
			}
			
			include "../reference/IReferenced_Fragment_1.as";
		}
		
		override public function encode():ByteArray
		{
			//name
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _name);
			
			//kind
			var traitKind:int = _data.getKind();
			var traiAttributes:int = _isFinal | (_isOverride << 1) | (_isMetadata << 2);
			var kind:int = (traiAttributes << 4) | traitKind;
			byte.writeByte(kind);
			
			//data
			var dataBytes:ByteArray = _data.encode();
			byte.writeBytes(dataBytes);
			dataBytes.clear();
			
			//metadata
			if(_isMetadata)
			{
				var mLength:int = _metadataVec.length;
				SWFUtil.writeU30(byte, mLength);
				for (var i:int = 0; i < mLength; ++i) 
				{
					SWFUtil.writeU30(byte, _metadataVec[i]);
				}
			}
			
			return byte;
		}
		
		override public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "TraitsInfo";
			var xml:SWFXML = new SWFXML(name);
			xml.setAttribute("name", "mn(" + _name + ")");
			xml.setAttribute("isFinal", _isFinal);
			xml.setAttribute("isOverride", _isOverride);
			xml.setAttribute("isMetadata", _isMetadata);
			if(_isMetadata)
			{
				var length:int = _metadataVec.length;
				for (var i:int = 0; i < length; ++i) 
				{
					xml.appendChild("<metadata>" + _metadataVec[i] + "</metadata>");
				}
			}
			xml.appendChild(_data.toXML());
			return xml;
		}
		
		public function creatRefrenceRelationship():void
		{
			$abcFile.getMultinameByIndex(_name).addReference(this, "name");
		}
		
		public function get kind():int
		{
			return _data.getKind();
		}
	}
}