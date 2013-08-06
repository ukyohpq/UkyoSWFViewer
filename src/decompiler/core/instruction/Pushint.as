package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		pushint
		index
	 * index is a u30 that must be an index into the integer constant pool. The int value at index in
		the integer constant pool is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Pushint extends AbstractInstruction
	{
		private var index:uint;
		public function Pushint()
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
			return 45;
		}
		
		override public function getName():String
		{
			return "pushint";
		}
		
//		override public function toString():String
//		{
//			return "[ pushint int:" + ABCFile.getInstance().getIntByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "int:" + ABCFile.getInstance().getIntByIndex(index);
		}
		
		
	}
}