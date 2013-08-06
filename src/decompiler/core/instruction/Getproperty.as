package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		getproperty
		index
	 * 	index is a u30 that must be an index into the multiname constant pool. If the multiname at
		that index is a runtime multiname the name and/or namespace will also appear on the stack
		so that the multiname can be constructed correctly at runtime.
		The property with the name specified by the multiname will be resolved in object, and the
		value of that property will be pushed onto the stack. If the property is unresolved,
		undefined is pushed onto the stack. See “Resolving multinames” on page 10.
	 * @author ukyohpq
	 * 
	 */
	public class Getproperty extends AbstractInstruction
	{
		private var index:uint;
		public function Getproperty()
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
			return 102;
		}
		
		override public function getName():String
		{
			return "getproperty";
		}
		
//		override public function toString():String
//		{
//			return "[ getproperty name:" + ABCFile.getInstance().getMultinameByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + ABCFile.getInstance().getMultinameByIndex(index);
		}
	}
}