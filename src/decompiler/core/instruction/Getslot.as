package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	public class Getslot extends AbstractInstruction
	{
		private var slotindex:uint;
		public function Getslot()
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
			return 108;
		}
		
		override public function getName():String
		{
			return "getslot";
		}
		
//		override public function toString():String
//		{
//			return "[ getslot slotindex:" + slotindex + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "slotindex:" + slotindex;
		}
	}
}