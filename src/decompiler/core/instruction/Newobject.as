package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		newobject
		arg_count
	 * 	arg_count is a u30 that is the number of properties that will be created in newobj. There will
		be a total of arg_count name values on the stack, which will be of type String (name1 to
		nameN). There will be an equal number of values on the stack, which can be of any type,
		and will be the initial values for the properties
		A new value of type Object is created and assigned to newobj. The properties specified on the
		stack will be dynamically added to newobj. The names of the properties will be name1,
		name2,..., nameN and these properties will be set to the corresponding values (value1,
		value2,..., valueN). newobj is then pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Newobject extends AbstractInstruction
	{
		private var arg_count:uint;
		public function Newobject()
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
			return 85;
		}
		
		override public function getName():String
		{
			return "newobject";
		}
		
//		override public function toString():String
//		{
//			return "[newobject]";
//		}
		
		override protected function stringBody():String
		{
			return "arg_count:" + arg_count;
		}
		
		
	}
}