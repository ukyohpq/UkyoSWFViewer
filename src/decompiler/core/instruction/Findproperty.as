package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		findproperty
		index
	 * 	index is a u30 that must be an index into the multiname constant pool. If the multiname at
		that index is a runtime multiname the name and/or namespace will also appear on the stack
		so that the multiname can be constructed correctly at runtime.
		This searches the scope stack, and then the saved scope in the current method closure, for a
		property with the name specified by the multiname at index.
		If any of the objects searched is a with scope, its declared and dynamic properties will be
		searched for a match. Otherwise only the declared traits of a scope will be searched. The
		global object will have its declared traits, dynamic properties, and prototype chain searched.
		If the property is resolved then the object it was resolved in is pushed onto the stack. If the
		property is unresolved in all objects on the scope stack then the global object is pushed onto
		the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Findproperty extends AbstractInstruction
	{
		private var index:uint;
		public function Findproperty()
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
			return 94;
		}
		
		override public function getName():String
		{
			return "findproperty";
		}
		
//		override public function toString():String
//		{
//			return "[ findproperty name:" + ABCFile.getInstance().getMultinameByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + ABCFile.getInstance().getMultinameByIndex(index);
		}
		
		
	}
}