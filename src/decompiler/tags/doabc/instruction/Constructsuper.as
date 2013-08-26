package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		constructsuper
		arg_count
	 * arg_count is a u30 that is the number of arguments present on the stack. 
	 * This will invoke the constructor on the base class of object with the given arguments.
	 * @author ukyohpq
	 * 
	 */
	public class Constructsuper extends AbstractInstruction
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

		public function Constructsuper()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 73;
		}
		
		override public function getName():String
		{
			return "constructsuper";
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_arg_count = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _arg_count);
		}
		
//		override public function toString():String
//		{
//			return "[ constructsuper arg_count:" + arg_count + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "arg_count:" + _arg_count;
		}
		
		override public function getParams():Vector.<uint>
		{
			return new <uint>[_arg_count];
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<arg_count>" + _arg_count + "</arg_count>");
		}
	}
}