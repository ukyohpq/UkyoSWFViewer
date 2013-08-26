package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		getscopeobject
		index
	 * 	index is an unsigned byte that specifies the index of the scope object to retrieve from the local
		scope stack. index must be less than the current depth of the scope stack. The scope at that
		index is retrieved and pushed onto the stack. The scope at the top of the stack is at index
		scope_depth-1, and the scope at the bottom of the stack is index 0.
	 * @author ukyohpq
	 * 
	 */
	public class Getscopeobject extends AbstractInstruction
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

		public function Getscopeobject()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_index = byte.readUnsignedByte();
			super.decodeFromBytes(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			byte.writeByte(_index);
		}
		
		override public function getForm():int
		{
			return 101;
		}
		
		override public function getName():String
		{
			return "getscopeobject";
		}
		
//		override public function toString():String
//		{
//			return "[ getscopeobject index:" + index + " ]";
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