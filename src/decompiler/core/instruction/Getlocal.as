package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		getlocal
		index
	 * 	index is a u30 that must be an index of a local register. The value of that register is pushed
		onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Getlocal extends AbstractInstruction
	{
		private var index:uint;
		public function Getlocal()
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
			return 98;
		}
		
		override public function getName():String
		{
			return "getlocal";
		}
		
//		override public function toString():String
//		{
//			return "[ getlocal index:" + index + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "index:" + index;
		}
		
		
	}
}