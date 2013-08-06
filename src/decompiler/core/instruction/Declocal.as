package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		declocal
		index
	 * index is a u30 that must be an index of a local register. 
	 * The value of the local register at index is converted 
	 * to a Number using the ToNumber algorithm (ECMA-262 section 9.3) and 
	 * then 1 is subtracted from the Number value. 
	 * The local register at index is then set to the result.
	 * @author ukyohpq
	 * 
	 */
	public class Declocal extends AbstractInstruction
	{
		private var index:uint;
		public function Declocal()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 148;
		}
		
		override public function getName():String
		{
			return "declocal";
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			index = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, index);
		}
		
//		override public function toString():String
//		{
//			return "[ declocal index:" + index + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "index:" + index;
		}
		
		
	}
}