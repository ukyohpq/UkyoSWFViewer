package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		callstatic
		index
		arg_count
	 * index is a u30 that is the index of the method_info of the method to invoke. 
	 * arg_count is a u30 that is the number of arguments present on the stack. 
	 * receiver is the object to invoke the method on. 
	 * The method at position index is invoked with the arguments receiver, arg1, ..., argn. 
	 * The receiver will be used as the “this” value for the method. 
	 * The result of the method is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Callstatic extends AbstractInstruction
	{
		private var index:uint;
		private var arg_count:uint;
		public function Callstatic()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 68;
		}
		
		override public function getName():String
		{
			return "callstatic";
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			index = SWFUtil.readU30(byte);
			arg_count = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, index);
			SWFUtil.writeU30(byte, arg_count);
		}
		
//		override public function toString():String
//		{
//			return "[ callstatic name:" + ABCFile.getInstance().getMethodByIndex(index) + " arg_count:" + arg_count + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + ABCFile.getInstance().getMethodByIndex(index) + " arg_count:" + arg_count;
		}
		
		
	}
}