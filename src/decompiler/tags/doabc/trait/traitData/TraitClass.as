package decompiler.tags.doabc.trait.traitData
{
	import decompiler.tags.doabc.reference.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	/**
	 * trait_class
		{
			u30 slot_id
			u30 classi
		}
	 * @author ukyohpq
	 * 
	 */
	public class TraitClass extends AbstractTraitData
	{
		private var _slotID:uint;

		/**
		 * The slot_id field is an integer from 0 to N and is used to identify 
		 * a position in which this trait resides. 
		 * A value of 0 requests the AVM2 to assign a position.
		 */
		public function get slotID():uint
		{
			return _slotID;
		}

		/**
		 * @private
		 */
		public function set slotID(value:uint):void
		{
			modify();
			try{
				$abcFile.getClassInfoByIndex(_classi).removeReference(this, "classi");
			}catch(err:Error)
			{
				trace(err);
			}
			_slotID = value;
			$abcFile.getClassInfoByIndex(_classi).addReference(this, "classi");
		}

		private var _classi:uint;

		/**
		 * The classi field is an index that points into the class array of the abcFile entry.
		 */
		public function get classi():uint
		{
			return _classi;
		}

		/**
		 * @private
		 */
		public function set classi(value:uint):void
		{
			modify();
			_classi = value;
		}

		public function TraitClass()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_slotID = SWFUtil.readU30(byte);
			_classi = SWFUtil.readU30(byte);
			super.decodeFromBytes(byte);
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _slotID);
			SWFUtil.writeU30(byte, _classi);
			return byte;
		}
		
		override public function getKind():int
		{
			return 4;
		}
		
		override protected function contentToXML(xml:SWFXML):void
		{
			xml.appendChild("<TraiClass slot_id=\"" + _slotID + "\" classi=\"" + _classi + "\"/>");
		}
		
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getClassInfoByIndex(_classi).addReference(this, "classi");
		}
		
		override public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			include "../../reference/IReferenceable_Fragment_1.as";
		}
	}
}