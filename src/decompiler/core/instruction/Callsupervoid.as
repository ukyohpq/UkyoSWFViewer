package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		callsupervoid
		index
		arg_count
	 * arg_count is a u30 that is the number of arguments present on the stack. 
	 * The number of arguments specified by arg_count are popped off the stack and saved. 
	 * index is a u30 that must be an index into the multiname constant pool. 
	 * If the multiname at that index is a runtime multiname the 
	 * name and/or namespace will also appear on the stack 
	 * so that the multiname can be constructed correctly at runtime. 
	 * receiver is the object to invoke the method on. 
	 * The base class of receiver is determined and the method indicated 
	 * by the multiname is resolved in the declared traits of the base class. 
	 * The method is invoked with the arguments receiver, arg1, ..., argn. 
	 * The first argument will be used as the “this” value for the method. 
	 * The result of the method is discarded.
	 * @author ukyohpq
	 * 
	 */
	public class Callsupervoid extends AbstractInstruction
	{
		private var index:uint;
		private var arg_count:uint;
		public function Callsupervoid()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 78;
		}
		
		override public function getName():String
		{
			return "callsupervoid";
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
//			return "[ callsupervoid name:" + ABCFile.getInstance().getMultinameByIndex(index) + " arg_count:" + arg_count + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + ABCFile.getInstance().getMultinameByIndex(index) + " arg_count:" + arg_count;
		}
		
		
	}
}