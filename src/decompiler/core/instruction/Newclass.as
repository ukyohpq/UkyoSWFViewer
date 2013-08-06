package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		newclass
		index
	 * 	index is a u30 that is an index of the ClassInfo that is to be created. basetype must be the
		base class of the class being created, or null if there is no base class.
		The class that is represented by the ClassInfo at position index of the ClassInfo entries is
		created with the given basetype as the base class. This will run the static initializer function
		for the class. The new class object, newclass, will be pushed onto the stack.
		When this instruction is executed, the scope stack must contain all the scopes of all base
		classes, as the scope stack is saved by the created ClassClosure.
	 * @author ukyohpq
	 * 
	 */
	public class Newclass extends AbstractInstruction
	{
		private var index:uint;
		public function Newclass()
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
			return 88;
		}
		
		override public function getName():String
		{
			return "newclass";
		}
		
//		override public function toString():String
//		{
//			return "[ newclass class:" + ABCFile.getInstance().getInstanceInfoByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "class:" + ABCFile.getInstance().getInstanceInfoByIndex(index);
		}
		
		
	}
}