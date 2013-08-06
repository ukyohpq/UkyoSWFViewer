package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		callproplex
		index
		arg_count
	 * 
	 * arg_count is a u30 that is the number of arguments present on the stack. 
	 * The number of arguments specified by arg_count are popped off the stack and saved. 
	 * 
	 * index is a u30 that must be an index into the multiname constant pool. 
	 * If the multiname at that index is a runtime multiname the name 
	 * and/or namespace will also appear on the stack so that 
	 * the multiname can be constructed correctly at runtime. 
	 * obj is the object to resolve and call the property on. 
	 * The property specified by the multiname at index is resolved on the object obj. 
	 * The [[Call]] property is invoked on the value of the 
	 * resolved property with the arguments null, arg1, ..., argn. 
	 * The result of the call is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Callproplex extends AbstractInstruction
	{
		private var index:uint;
		private var arg_count:uint;
		public function Callproplex()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 76;
		}
		
		override public function getName():String
		{
			return "callproplex";
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
//			return "[ callproplex name:" + ABCFile.getInstance().getMultinameByIndex(index) + " arg_count:" + arg_count + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + ABCFile.getInstance().getMultinameByIndex(index) + " arg_count:" + arg_count;
		}
		
		
	}
}