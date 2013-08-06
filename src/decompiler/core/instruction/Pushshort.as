package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		pushshort
		value
	 * value is a u30. The value is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Pushshort extends AbstractInstruction
	{
		private var value:uint;
		public function Pushshort()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			value = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, value);
		}
		
		override public function getForms():int
		{
			return 37;
		}
		
		override public function getName():String
		{
			return "pushshort";
		}
		
//		override public function toString():String
//		{
//			return "[ pushshort value:" + value + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "value:" + value;
		}
		
		
	}
}