package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		coerce
		index
	 * index is a u30 that must be an index into the multiname constant pool. 
	 * The multiname at index must not be a runtime multiname. 
	 * The type specified by the multiname is resolved, 
	 * and value is coerced to that type. 
	 * The resulting value is pushed onto the stack. 
	 * If any of value’s base classes, 
	 * or implemented Adobe ActionScript Virtual Machine 2 (AVM2) 
	 * Overview 47 interfaces matches the type specified by the multiname, 
	 * then the conversion succeeds and the result is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Coerce extends AbstractInstruction
	{
		private var index:uint;
		public function Coerce()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 128;
		}
		
		override public function getName():String
		{
			return "coerce";
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
//			return "[ coerce name:" + ABCFile.getInstance().getMultinameByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + ABCFile.getInstance().getMultinameByIndex(index);
		}
		
		
		
	}
}