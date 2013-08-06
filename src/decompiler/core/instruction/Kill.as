package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		kill
		index
	 * 	index is a u30 that must be an index of a local register. The local register at index is killed. It
		is killed by setting its value to undefined.
	 * @author ukyohpq
	 * 
	 */
	public class Kill extends AbstractInstruction
	{
		private var index:uint;
		public function Kill()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			index = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, index);
		}
		
		override public function getForms():int
		{
			return 8;
		}
		
		override public function getName():String
		{
			return "kill";
		}
		
//		override public function toString():String
//		{
//			return "[ kill index:" + index + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "index:" + index;
		}
		
		
	}
}