package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		pushuint
		index
	 * index is a u30 that must be an index into the unsigned integer constant pool. The value at
		index in the unsigned integer constant pool is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Pushuint extends AbstractInstruction
	{
		private var index:uint;
		public function Pushuint()
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
			return 46;
		}
		
		override public function getName():String
		{
			return "pushuint";
		}
		
//		override public function toString():String
//		{
//			return "[ pushuint uint:" + ABCFile.getInstance().getUintByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "uint:" + ABCFile.getInstance().getUintByIndex(index);
		}
		
		
	}
}