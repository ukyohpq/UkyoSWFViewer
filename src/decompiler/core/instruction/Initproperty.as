package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		initproperty
		index
	 * 	value is the value that the property will be set to. value is popped off the stack and saved.
		index is a u30 that must be an index into the multiname constant pool. If the multiname at
		that index is a runtime multiname the name and/or namespace will also appear on the stack
		so that the multiname can be constructed correctly at runtime.
		The property with the name specified by the multiname will be resolved in object, and will be
		set to value. This is used to initialize properties in the initializer method. When used in an
		initializer method it is able to set the value of const properties.
	 * @author ukyohpq
	 * 
	 */
	public class Initproperty extends AbstractInstruction
	{
		private var index:uint;
		public function Initproperty()
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
			return 104;
		}
		
		override public function getName():String
		{
			return "initproperty";
		}
		
//		override public function toString():String
//		{
//			return "[ initproperty Init_Property_Name:" + ABCFile.getInstance().getMultinameByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "Init_Property_Name:" + ABCFile.getInstance().getMultinameByIndex(index);
		}
		
		
	}
}