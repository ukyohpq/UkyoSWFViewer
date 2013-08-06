package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		setproperty
		index
	 * value is the value that the property will be set to. value is popped off the stack and saved.
		index is a u30 that must be an index into the multiname constant pool. If the multiname at
		that index is a runtime multiname the name and/or namespace will also appear on the stack
		so that the multiname can be constructed correctly at runtime.
		The property with the name specified by the multiname will be resolved in obj, and will be
		set to value. If the property is not found in obj, and obj is dynamic then the property will be
		created and set to value. See “Resolving multinames” on page 10.
	 * @author ukyohpq
	 * 
	 */
	public class Setproperty extends AbstractInstruction
	{
		private var index:uint;
		public function Setproperty()
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
			return 97;
		}
		
		override public function getName():String
		{
			return "setproperty";
		}
		
//		override public function toString():String
//		{
//			return "[ setproperty name:" + ABCFile.getInstance().getMultinameByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + ABCFile.getInstance().getMultinameByIndex(index);
		}
	}
}