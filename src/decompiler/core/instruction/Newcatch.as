package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		newcatch
		index
	 * 	index is a u30 that must be an index of an exception_info structure for this method.
		This instruction creates a new object to serve as the scope object for the catch block for the
		exception referenced by index. This new scope is pushed onto the operand stack.
	 * @author ukyohpq
	 * 
	 */
	public class Newcatch extends AbstractInstruction
	{
		private var index:uint;
		public function Newcatch()
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
			return 90;
		}
		
		override public function getName():String
		{
			return "newcatch";
		}
		
//		override public function toString():String
//		{
//			return "[ newcatch exception:" + methodBody.getExceptionInfoByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "exception:" + methodBody.getExceptionInfoByIndex(index);
		}
		
		
	}
}