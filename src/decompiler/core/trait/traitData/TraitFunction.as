package decompiler.core.trait.traitData
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.utils.SWFUtil;

	/**
	 * trait_function
		{
			u30 slot_id
			u30 function
		}
	 * @author ukyohpq
	 * 
	 */
	public class TraitFunction extends AbstractTraitData
	{
		/**
		 * The slot_id field is an integer from 0 to N and is used 
		 * to identify a position in which this trait resides.
		 * A value of 0 requests the AVM2 to assign a position.
		 */
		private var _slotID:uint;
		/**
		 * The function field is an index that points into the method array of the abcFile entry
		 */
		private var _function:uint;
		public function TraitFunction()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_slotID = SWFUtil.readU30(byte);
			trace("TraitFunction slot_id:" + _slotID);
			_function = SWFUtil.readU30(byte);
			trace("TraitFunction function:" + _function);
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _slotID);
			SWFUtil.writeU30(byte, _function);
			return byte;
		}
		
		override public function getKind():int
		{
			return 5;
		}
		
		
	}
}