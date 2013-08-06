package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		setglobalslot
		slotindex
	 * slotindex is a u30 that must be an index of a slot on the global scope. The slotindex must be
		greater than zero and less than or equal to the total number of slots the global scope has.
		This instruction will set the value of the slot at slotindex of the global scope to value. value is
		first coerced to the type of the slot indicated by slotindex.
	 * @author ukyohpq
	 * 
	 */
	public class Setglobalslot extends AbstractInstruction
	{
		private var slotindex:uint;
		public function Setglobalslot()
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
			return 111;
		}
		
		override public function getName():String
		{
			return "setglobalslot";
		}
		
//		override public function toString():String
//		{
//			return "[ setglobalslot slotindex:" + slotindex + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "slotindex:" + slotindex;
		}
		
	}
}