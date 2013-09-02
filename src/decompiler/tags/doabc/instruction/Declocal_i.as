
package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		declocal_i
		index
	 * index is a u30 that must be an index of a local register. 
	 * The value of the local register at index is converted 
	 * to an int using the ToInt32 algorithm (ECMA-262 section 9.5) 
	 * and then 1 is subtracted the int value. 
	 * The local register at index is then set to the result.
	 * @author ukyohpq
	 * 
	 */
	public class Declocal_i extends AbstractInstruction
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

		public function Declocal_i()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 195;
		}
		
		override public function getName():String
		{
			return "declocal_i";
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
//			return "[ declocal_i index:" + index + " ]";
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
	}
}