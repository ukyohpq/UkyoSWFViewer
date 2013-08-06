package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		constructsuper
		arg_count
	 * arg_count is a u30 that is the number of arguments present on the stack. 
	 * This will invoke the constructor on the base class of object with the given arguments.
	 * @author ukyohpq
	 * 
	 */
	public class Constructsuper extends AbstractInstruction
	{
		private var arg_count:uint;
		public function Constructsuper()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 73;
		}
		
		override public function getName():String
		{
			return "constructsuper";
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			arg_count = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, arg_count);
		}
		
//		override public function toString():String
//		{
//			return "[ constructsuper arg_count:" + arg_count + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "arg_count:" + arg_count;
		}
		
		
	}
}