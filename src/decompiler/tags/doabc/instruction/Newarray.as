package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

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

		public function Newarray()
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