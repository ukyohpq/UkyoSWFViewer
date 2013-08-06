package decompiler.core.trait.traitData
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
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
	public class TraitGetter extends AbstractTraitData
	{
		private var _dispID:uint;
		private var _method:uint;
		public function TraitGetter()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_dispID = SWFUtil.readU30(byte);
			trace("TraitGetter disp_id:" + _dispID);
			_method = SWFUtil.readU30(byte);
			trace("TraitGetter method:" + _method);
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
			return 2;
		}
		
		
	}
}