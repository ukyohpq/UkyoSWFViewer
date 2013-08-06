package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		call
		arg_count
	 * arg_count is a u30 that is the number of arguments 
	 * present on the stack for the call. 
	 * function is the closure that is being called. 
	 * receiver is the object to use for the “this” value. 
	 * This will invoke the [[Call]] property on 
	 * function with the arguments receiver, arg1, ..., argn. 
	 * The result of invoking the [[Call]] property will be pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Call extends AbstractInstruction
	{
		private var arg_count:int;
		public function Call()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 65;
		}
		
		override public function getName():String
		{
			return "call";
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
//			return "[ call arg_count:" + arg_count + "]";
//		}
		
		override protected function stringBody():String
		{
			return "arg_count:" + arg_count;
		}
		
		
	}
}