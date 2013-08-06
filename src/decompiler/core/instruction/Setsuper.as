package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		setsuper
		index
	 * value is the value that the property will be set to. value is popped off the stack and saved.
		index is a u30 that must be an index into the multiname constant pool. If the multiname at
		that index is a runtime multiname the name and/or namespace will also appear on the stack
		so that the multiname can be constructed correctly at runtime.
		Once the multiname is constructed the base class of obj is determined and the multiname is
		resolved in the declared traits of the base class. The property is then set to value. See
		“Resolving multinames” on page 10.
	 * @author ukyohpq
	 * 
	 */
	public class Setsuper extends AbstractInstruction
	{
		private var index:uint;
		public function Setsuper()
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
			return 5;
		}
		
		override public function getName():String
		{
			return "setsuper";
		}
		
//		override public function toString():String
//		{
//			return "[ setsuper name:" + ABCFile.getInstance().getMultinameByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + ABCFile.getInstance().getMultinameByIndex(index);
		}
	}
}