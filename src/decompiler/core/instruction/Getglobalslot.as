package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		getglobalslot
		slotindex
	 * 	slotindex is a u30 that must be an index of a slot on the global scope. The slotindex must be
		greater than 0 and less than or equal to the total number of slots the global scope has.
		This will retrieve the value stored in the slot at slotindex of the global scope. This value is
		pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Getglobalslot extends AbstractInstruction
	{
		private var slotindex:uint;
		public function Getglobalslot()
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
			return 110;
		}
		
		override public function getName():String
		{
			return "getglobalslot";
		}
		
//		override public function toString():String
//		{
//			return "[ getglobalslot slotindex:" + slotindex + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "slotindex:" + slotindex;
		}
	}
}