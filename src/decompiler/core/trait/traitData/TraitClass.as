package decompiler.core.trait.traitData
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.utils.SWFUtil;

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
		/**
		 * The slot_id field is an integer from 0 to N and is used to identify 
		 * a position in which this trait resides. 
		 * A value of 0 requests the AVM2 to assign a position.
		 */
		private var _slotID:uint;
		/**
		 * The classi field is an index that points into the class array of the abcFile entry.
		 */
		private var _classi:uint;
		public function TraitClass()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_slotID = SWFUtil.readU30(byte);
			_classi = SWFUtil.readU30(byte);
			trace("TraitClass slot_id:" + _slotID);
			trace("TraitClass classi:" + _classi);
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
	}
}