package decompiler.tags.doabc.trait.traitData
{
	import decompiler.tags.doabc.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;

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
		private var _slotID:int;

		/**
		 * The slot_id field is an integer from 0 to N and is used to identify a position in which this trait resides. 
		 * A value of 0 requests the AVM2 to assign a position
		 */
		public function get slotID():int
		{
			return _slotID;
		}

		/**
		 * @private
		 */
		public function set slotID(value:int):void
		{
			modify();
			_slotID = value;
		}

		private var _typeName:uint;

		/**
		 * This field is used to identify the type of the trait. 
		 * It is an index into the multiname array of the constant_pool. 
		 * A value of zero indicates that the type is the any type (*).
		 */
		public function get typeName():uint
		{
			return _typeName;
		}

		/**
		 * @private
		 */
		public function set typeName(value:uint):void
		{
			modify();
			$abcFile.getMultinameByIndex(_typeName).removeReference(this, "typeName");
			_typeName = value;
			$abcFile.getMultinameByIndex(_typeName).addReference(this, "typeName");
		}

		private var _vindex:uint;

		/**
		 * This field is an index that is used in conjunction 
		 * with the vkind field in order to define a value for the trait. 
		 * If it is 0, vkind is empty; 
		 * otherwise it references one of the tables in the constant pool, 
		 * depending on the value of vkind.
		 */
		public function get vindex():uint
		{
			return _vindex;
		}

		/**
		 * @private
		 */
		public function set vindex(value:uint):void
		{
			modify();
			_vindex = value;
		}

		private var _vkind:uint;

		/**
		 * This field exists only when vindex is non-zero. 
		 * It is used to determine how vindex will be interpreted.
		 * See the “Constant Kind” table above for details.
		 */
		public function get vkind():uint
		{
			return _vkind;
		}

		/**
		 * @private
		 */
		public function set vkind(value:uint):void
		{
			modify();
			_vkind = value;
		}

		public function TraitSlot()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_slotID = SWFUtil.readU30(byte);
			_typeName = SWFUtil.readU30(byte);
			_vindex = SWFUtil.readU30(byte);
//			trace("TraitSlot vindex:" + _vindex);
			if(_vindex != 0)
			{
				_vkind = byte.readUnsignedByte();
//				trace("TraitSlot vkind:" + _vkind);
//				trace("TraitSlot value:" + $abcFile.getValueByKindAndIndex(_vkind, _vindex));
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
		
		override protected function contentToXML(xml:SWFXML):void
		{
			if(_vindex)
			{
				xml.appendChild("<TraitSlot slot_id=\"" + _slotID + "\" type_name=\"" + _typeName + "\" vindex=\"" + _vindex + "\" vkind=\"" + _vkind + "\" />");
			}else{
				xml.appendChild("<TraitSlot slot_id=\"" + _slotID + "\" type_name=\"" + _typeName + "\" vindex=\"" + _vindex + "\" />");
			}
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getMultinameByIndex(_typeName).addReference(this, "typeName");
		}
		
		
	}
}