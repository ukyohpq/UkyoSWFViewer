package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		deleteproperty
		index
	 * index is a u30 that must be an index into the multiname constant pool. 
	 * If the multiname at that index is a runtime 
	 * multiname the name and/or namespace will also appear on the stack 
	 * so that the multiname can be constructed correctly at runtime. 
	 * This will invoke the [[Delete]] method on object with the name specified by the multiname. 
	 * If object is not dynamic or the property is a fixed property then nothing happens, 
	 * and false is pushed onto the stack. 
	 * If object is dynamic and the property is not a fixed property, 
	 * it is removed from object and true is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Deleteproperty extends AbstractInstruction
	{
		private var index:uint;
		public function Deleteproperty()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 106;
		}
		
		override public function getName():String
		{
			return "deleteproperty";
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
//			return "[ deleteproperty name:" + ABCFile.getInstance().getMultinameByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + ABCFile.getInstance().getMultinameByIndex(index);
		}
		
		
	}
}