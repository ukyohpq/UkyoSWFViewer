package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

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
		private var _arg_count:uint;

		public function get arg_count():uint
		{
			return _arg_count;
		}

		public function set arg_count(value:uint):void
		{
			modify();
			_arg_count = value;
		}

		public function Newobject()
		{
			super();
		}
		
		override protected function pcodeDecodeFromBytes(byte:ByteArray):void
		{
			_arg_count = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _arg_count);
		}
		
		override public function getForm():int
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
			return -_arg_count + 1;
		}
	}
}