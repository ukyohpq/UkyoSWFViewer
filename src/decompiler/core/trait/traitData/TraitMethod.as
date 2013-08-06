package decompiler.core.trait.traitData
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * trait_method
		{
			u30 disp_id
			u30 method
		}
	 * @author ukyohpq
	 * 
	 */
	public class TraitMethod extends AbstractTraitData
	{
		/**
		 * The disp_id field is a compiler assigned integer that is 
		 * used by the AVM2 to optimize the resolution of virtual function calls.
		 * An overridden method must have the same disp_id as that of the method in the base class. 
		 * A value of zero disables this optimization.
		 */
		private var _dispID:uint;
		/**
		 * The method field is an index that points into the method array of the abcFile entry
		 */
		private var _method:uint;
		public function TraitMethod()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_dispID = SWFUtil.readU30(byte);
			trace("TraitMethod disp_id:" + _dispID);
			_method = SWFUtil.readU30(byte);
			trace("TraitMethod method:" + ABCFile.getInstance().getMethodByIndex(_method));
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _dispID);
			SWFUtil.writeU30(byte, _method);
			return byte;
		}
		
		override public function getKind():int
		{
			return 1;
		}
		
		
	}
}