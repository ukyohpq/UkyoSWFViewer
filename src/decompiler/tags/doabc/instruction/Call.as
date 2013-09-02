package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	/**
	 * Format
		call
		arg_count
	 * arg_count is a u30 that is the number of arguments 
	 * present on the stack for the call. 
	 * function is the closure that is being called. 
	 * receiver is the object to use for the “this” value. 
	 * This will invoke the [[Call]] property on 
	 * function with the arguments receiver, arg1, ..., argn. 
	 * The result of invoking the [[Call]] property will be pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Call extends AbstractInstruction
	{
		private var _arg_count:int;

		public function get arg_count():int
		{
			return _arg_count;
		}

		public function set arg_count(value:int):void
		{
			modify();
			_arg_count = value;
		}

		public function Call()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 65;
		}
		
		override public function getName():String
		{
			return "call";
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_arg_count = SWFUtil.readU30(byte);
			super.decodeFromBytes(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _arg_count);
		}
		
//		override public function toString():String
//		{
//			return "[ call arg_count:" + arg_count + "]";
//		}
		
		override protected function stringBody():String
		{
			return "arg_count:" + _arg_count;
		}
		
		override public function getParams():Vector.<int>
		{
			return new <int>[_arg_count];
		}
		
		override public function getParamNames():Vector.<String>
		{
			return new <String>["_arg_count"];
		}
		
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<arg_count>" + _arg_count + "</arg_count>");
		}
		
		override public function deltaNumStack():int
		{
			return -(_arg_count + 1);
		}
	}
}