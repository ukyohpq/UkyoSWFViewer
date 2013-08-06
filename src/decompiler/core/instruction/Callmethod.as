package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		callmethod
		index
		arg_count
	 * index is a u30 that is the index of the method to invoke on receiver. 
	 * 这句话不能理解.这里的method数组究竟是什么？是methodInfo数组还是methodBodyInfo数组?这里暂且理解成methodBodyInfo数组
	 * arg_count is a u30 that is the number of arguments present on the stack. 
	 * receiver is the object to invoke the method on.
	 * The method at position index on the object receiver, 
	 * is invoked with the arguments receiver, arg1, ..., argn. 
	 * The result of the method call is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Callmethod extends AbstractInstruction
	{
		private var index:uint;
		private var arg_count:uint;
		public function Callmethod()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 67;
		}
		
		override public function getName():String
		{
			return "callmethod";
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			index = SWFUtil.readU32(byte);
			arg_count = SWFUtil.readU32(byte);
			super.decodeFromBytes(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, index);
			SWFUtil.writeU30(byte, arg_count);
		}
		
//		override public function toString():String
//		{
//			//这个可能存在问题
//			return "[ callmethod method:" + ABCFile.getInstance().getMethodBodyByIndex(index) + " arg_count:" + arg_count + " ]";
//		}
		
		//这个可能存在问题
		override protected function stringBody():String
		{
			return "method:" + ABCFile.getInstance().getMethodBodyByIndex(index) + " arg_count:" + arg_count;
		}
		
		
	}
}