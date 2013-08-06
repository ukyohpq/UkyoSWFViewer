package decompiler.core.trait
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.tags.doabc.ABCFile;
	import decompiler.core.trait.traitData.AbstractTraitData;
	import decompiler.core.trait.traitData.TraitDataFactory;
	
	import decompiler.utils.SWFUtil;
	
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
	public class TraitsInfo implements IByteArrayReader, ISWFElement
	{
		/**
		 * The name field is an index into the multiname array of the constant pool; 
		 * it provides a name for the trait. 
		 * The value can not be zero, and the multiname entry specified must be a QName.
		 */
		private var _name:uint;
		/**
		 * The interpretation of the data field depends on the type of the trait, 
		 * which is provided by the low four bits of the kind field. 
		 * See below for a full description.
		 */
		private var _data:AbstractTraitData;
		
		/**
		 * These fields are present only if ATTR_Metadata is present in the upper four bits of the kind field.
		 * The value of the metadata_count field is the number of entries in the metadata array. 
		 * That array contains indices into the metadata array of the abcFile.
		 */
		private var _metadataVec:Vector.<uint>;
		
		//traiAttributes
		private var _isMetadata:int;
		private var _isOverride:int;
		private var _isFinal:int;
		
		public function TraitsInfo()
		{
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			_name = SWFUtil.readU30(byte);
			trace("TraitsInfo name:" + ABCFile.getInstance().getMultinameByIndex(_name));
//			parse kind
//			The kind field contains two four-bit fields. The lower four bits determine the kind of this trait. The
//			upper four bits comprise a bit vector providing attributes of the trait. See the following tables and
//			sections for full descriptions.
			var kind:int = byte.readUnsignedByte();
			var traitKind:int = kind & 7;
			var traiAttributes:int = (kind >> 4) & 7;
			_isFinal = traiAttributes & 1;
			trace("TraitsInfo isFinal:" + _isFinal);
			_isOverride = (traiAttributes >> 1) & 1;
			trace("TraitsInfo isOverride:" + _isOverride);
			_isMetadata = (traiAttributes >> 2) & 1;
			trace("TraitsInfo isMetadata:" + _isMetadata);
			
			_data = TraitDataFactory.creatTrait(traitKind);
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
		}
		
		public function encode():ByteArray
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
	}
}