package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		inclocal
		index
	 * 	index is a u30 that must be an index of a local register. The value of the local register at index
		is converted to a Number using the ToNumber algorithm (ECMA-262 section 9.3) and
		then 1 is added to the Number value. The local register at index is then set to the result.
	 * @author ukyohpq
	 * 
	 */
	public class Inclocal extends AbstractInstruction
	{
		private var index:uint;
		public function Inclocal()
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
			return 146;
		}
		
		override public function getName():String
		{
			return "inclocal";
		}
		
//		override public function toString():String
//		{
//			return "[ inclocal index:" + index + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "index:" + index;
		}
	}
}