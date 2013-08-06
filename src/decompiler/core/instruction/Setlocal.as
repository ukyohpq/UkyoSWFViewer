package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		setlocal
		index
	 * index is a u30 that must be an index of a local register. The register at index is set to value,
		and value is popped off the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Setlocal extends AbstractInstruction
	{
		private var index:uint;
		public function Setlocal()
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
			return 99;
		}
		
		override public function getName():String
		{
			return "setlocal";
		}
		
//		override public function toString():String
//		{
//			return "[ setlocal index:" + index + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "index:" + index;
		}
		
		
	}
}