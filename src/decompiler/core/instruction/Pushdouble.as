package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		pushdouble
		index
	 * index is a u30 that must be an index into the double constant pool. The double value at
		index in the double constant pool is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Pushdouble extends AbstractInstruction
	{
		private var index:uint;
		public function Pushdouble()
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
			return 47;
		}
		
		override public function getName():String
		{
			return "pushdouble";
		}
		
//		override public function toString():String
//		{
//			return "[ pushdouble double:" + ABCFile.getInstance().getDoubleByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "double:" + ABCFile.getInstance().getDoubleByIndex(index);
		}
		
		
	}
}