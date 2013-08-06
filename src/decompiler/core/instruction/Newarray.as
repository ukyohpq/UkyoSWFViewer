package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		newarray
		arg_count
 	 * arg_count is a u30 that is the number of entries that will be created in the new array. 
	 * There will be a total of arg_count values on the stack.
	 * A new value of type Array is created and assigned to newarray. 
	 * The values on the stack will be assigned to the entries of the array, 
	 * so newarray[0] = value1, newarray[1] = value2, ...., newarray[N-1] = valueN. 
	 * newarray is then pushed onto the stack. 
	 * @author ukyohpq
	 * 
	 */
	public class Newarray extends AbstractInstruction
	{
		private var arg_count:uint;
		public function Newarray()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			arg_count = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, arg_count);
		}
		
		override public function getForms():int
		{
			return 86;
		}
		
		override public function getName():String
		{
			return "newarray";
		}
		
//		override public function toString():String
//		{
//			return "[ newarray arg_count:" + arg_count + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "arg_count:" + arg_count;
		}
		
		
	}
}