package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		setslot
		slotindex
	 * slotindex is a u30 that must be an index of a slot on obj. slotindex must be greater than 0 and
		less than or equal to the total number of slots obj has.
	 * @author ukyohpq
	 * 
	 */
	public class Setslot extends AbstractInstruction
	{
		private var slotindex:uint;
		public function Setslot()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			slotindex = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, slotindex);
		}
		
		override public function getForms():int
		{
			return 109;
		}
		
		override public function getName():String
		{
			return "setslot";
		}
		
//		override public function toString():String
//		{
//			return "[ setslot slotindex:" + slotindex + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "slotindex:" + slotindex;
		}
	}
}