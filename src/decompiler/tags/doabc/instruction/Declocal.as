package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		declocal
		index
	 * index is a u30 that must be an index of a local register. 
	 * The value of the local register at index is converted 
	 * to a Number using the ToNumber algorithm (ECMA-262 section 9.3) and 
	 * then 1 is subtracted from the Number value. 
	 * The local register at index is then set to the result.
	 * @author ukyohpq
	 * 
	 */
	public class Declocal extends AbstractInstruction
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

		public function Declocal()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 148;
		}
		
		override public function getName():String
		{
			return "declocal";
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_index = SWFUtil.readU30(byte);
			super.decodeFromBytes(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _index);
		}
		
//		override public function toString():String
//		{
//			return "[ declocal index:" + index + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "index:" + _index;
		}
		
		override public function getParams():Vector.<uint>
		{
			return new <uint>[_index];
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<index>" + _index + "</index>");
		}
	}
}