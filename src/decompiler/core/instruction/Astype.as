package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		astype
		index
	 * index is a u30 that must be an index into the multiname constant pool. 
	 * The multiname at index must not be a runtime multiname, and must be the name of a type.
	 * Pop value off of the stack. If value is of the type specified by the multiname, 
	 * push value back onto the stack. 
	 * If value is not of the type specified by the multiname, 
	 * then push null onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Astype extends AbstractInstruction
	{
		private var index:int;
		public function Astype()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 134;
		}
		
		override public function getName():String
		{
			return "astype";
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			index = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, index);
		}
		
//		override public function toString():String
//		{
//			return "[ astype index:" + ABCFile.getInstance().getMultinameByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "index:" + ABCFile.getInstance().getMultinameByIndex(index);
		}
		
		
	}
}