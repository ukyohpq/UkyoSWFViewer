package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		getdescendants
		index
	 * 	index is a u30 that must be an index into the multiname constant pool. If the multiname at
		that index is a runtime multiname the name and/or namespace will also appear on the stack
		so that the multiname can be constructed correctly at runtime.
		obj is the object to find the descendants in. This will invoke the [[Descendants]] property on
		obj with the multiname specified by index. For a description of the [[Descendants]] operator,
		see the E4X spec (ECMA-357) sections 9.1.1.8 (for the XML type) and 9.2.1.8 (for the
		XMLList type).
	 * @author ukyohpq
	 * 
	 */
	public class Getdescendants extends AbstractInstruction
	{
		private var index:uint;
		public function Getdescendants()
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
			return 89;
		}
		
		override public function getName():String
		{
			return "getdescendants";
		}
		
//		override public function toString():String
//		{
//			return "[ getdescendants name:" + ABCFile.getInstance().getMultinameByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + ABCFile.getInstance().getMultinameByIndex(index);
		}
	}
}