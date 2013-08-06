package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		newfunction
		index
	 * 	index is a u30 that must be an index of a method_info. A new function object is created
		from that method_info and pushed onto the stack. For a description of creating a new
		function object, see ECMA-262 section 13.2.
		When creating the new function object the scope stack used is the current scope stack when
		this instruction is executed, and the body is the method_body entry that references the
		specified method_info entry.
	 * @author ukyohpq
	 * 
	 */
	public class Newfunction extends AbstractInstruction
	{
		private var index:uint;
		public function Newfunction()
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
			return 64;
		}
		
		override public function getName():String
		{
			return "newfunction";
		}
		
//		override public function toString():String
//		{
//			return "[ newfunction class:" + ABCFile.getInstance().getMethodByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "class:" + ABCFile.getInstance().getMethodByIndex(index);
		}
		
		
	}
}