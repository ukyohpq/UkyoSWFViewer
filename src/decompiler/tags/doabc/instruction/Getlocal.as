package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		getlocal
		index
	 * 	index is a u30 that must be an index of a local register. The value of that register is pushed
		onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Getlocal extends AbstractInstruction
	{
		private var _index:uint;

		public function get index():uint
		{
			return _index;
		}

		public function set index(value:uint):void
		{
			modify();
			_index = value;
		}

		public function Getlocal()
		{
			super();
		}
		
		override protected function pcodeDecodeFromBytes(byte:ByteArray):void
		{
			_index = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _index);
		}
		
		override public function getForm():int
		{
			return 98;
		}
		
		override public function getName():String
		{
			return "getlocal";
		}
		
//		override public function toString():String
//		{
//			return "[ getlocal index:" + index + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "index:" + _index;
		}
		
		override public function getParams():Vector.<int>
		{
			return new <int>[_index];
		}
		
		override public function getParamNames():Vector.<String>
		{
			return new <String>["_index"];
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<index>" + _index + "</index>");
		}
		
		override public function deltaNumStack():int
		{
			return 1;
		}
	}
}