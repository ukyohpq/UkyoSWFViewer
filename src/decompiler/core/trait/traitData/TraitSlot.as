package decompiler.core.trait.traitData
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.cpools.Cpool_info;
	
	import decompiler.utils.SWFUtil;

	/**
	 * trait_slot
		{
			u30 slot_id
			u30 type_name
			u30 vindex
			u8 vkind
		}
	 * @author ukyohpq
	 * 
	 */
	public class TraitSlot extends AbstractTraitData
	{
		/**
		 * The slot_id field is an integer from 0 to N and is used to identify a position in which this trait resides. 
		 * A value of 0 requests the AVM2 to assign a position
		 */
		private var _slotID:int;
		/**
		 * This field is used to identify the type of the trait. 
		 * It is an index into the multiname array of the constant_pool. 
		 * A value of zero indicates that the type is the any type (*).
		 */
		private var _typeName:uint;
		/**
		 * This field is an index that is used in conjunction 
		 * with the vkind field in order to define a value for the trait. 
		 * If it is 0, vkind is empty; 
		 * otherwise it references one of the tables in the constant pool, 
		 * depending on the value of vkind.
		 */
		private var _vindex:uint;
		/**
		 * This field exists only when vindex is non-zero. 
		 * It is used to determine how vindex will be interpreted.
		 * See the “Constant Kind” table above for details.
		 */
		private var _vkind:uint;
		public function TraitSlot()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_slotID = SWFUtil.readU30(byte);
			trace("TraitSlot slot_id:" + _slotID);
			_typeName = SWFUtil.readU30(byte);
			trace("TraitSlot type_name:" + ABCFile.getInstance().getMultinameByIndex(_typeName));
			_vindex = SWFUtil.readU30(byte);
			trace("TraitSlot vindex:" + _vindex);
			if(_vindex != 0)
			{
				_vkind = byte.readUnsignedByte();
				trace("TraitSlot vkind:" + _vkind);
				trace("TraitSlot value:" + ABCFile.getInstance().getValueByKindAndIndex(_vkind, _vindex));
			}
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _slotID);
			SWFUtil.writeU30(byte, _typeName);
			SWFUtil.writeU30(byte, _vindex);
			if(_vindex != 0)
			{
				SWFUtil.writeU30(byte, _vkind);
			}
			return byte; 
		}
		
		override public function getKind():int
		{
			return 0;
		}
		
	}
}