package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		pushstring
		index
	 * index is a u30 that must be an index into the string constant pool. The string value at index
		in the string constant pool is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Pushstring extends AbstractInstruction
	{
		private var index:uint;
		public function Pushstring()
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
			return 44;
		}
		
		override public function getName():String
		{
			return "pushstring";
		}
		
//		override public function toString():String
//		{
//			return "[ pushstring string:" + ABCFile.getInstance().getStringByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "string:" + ABCFile.getInstance().getStringByIndex(index);
		}
		
		
	}
}