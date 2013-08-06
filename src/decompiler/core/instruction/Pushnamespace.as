package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		pushnamespace
		index
	 * index is a u30 that must be an index into the namespace constant pool. The namespace value
		at index in the namespace constant pool is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Pushnamespace extends AbstractInstruction
	{
		private var index:uint;
		public function Pushnamespace()
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
			return 49;
		}
		
		override public function getName():String
		{
			return "pushnamespace";
		}
		
//		override public function toString():String
//		{
//			return "[ pushnamespace namespace:" + ABCFile.getInstance().getNamespaceByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "namespace:" + ABCFile.getInstance().getNamespaceByIndex(index);
		}
		
		
	}
}