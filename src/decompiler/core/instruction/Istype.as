package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		istype
		index
	 * 	index is a u30 that must be an index into the multiname constant pool. The multiname at
		index must not be a runtime multiname.
		Resolve the type specified by the multiname. Let indexType refer to that type. Compute the
		type of value, and let valueType refer to that type. If valueType is the same as indexType, result
		is true. If indexType is a base type of valueType, or an implemented interface of valueType,
		then result is true. Otherwise result is set to false. Push result onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Istype extends AbstractInstruction
	{
		private var index:uint;
		public function Istype()
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
			return 178;
		}
		
		override public function getName():String
		{
			return "istype";
		}
		
//		override public function toString():String
//		{
//			return "[istype]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + ABCFile.getInstance().getMultinameByIndex(index);
		}
		
		
	}
}