package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		getglobalslot
		slotindex
	 * 	slotindex is a u30 that must be an index of a slot on the global scope. The slotindex must be
		greater than 0 and less than or equal to the total number of slots the global scope has.
		This will retrieve the value stored in the slot at slotindex of the global scope. This value is
		pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Getglobalslot extends AbstractInstruction
	{
		private var _slotindex:uint;

		public function get slotindex():uint
		{
			return _slotindex;
		}

		public function set slotindex(value:uint):void
		{
			modify();
			_slotindex = value;
		}

		public function Getglobalslot()
		{
			super();
		}
		
		override protected function pcodeDecodeFromBytes(byte:ByteArray):void
		{
			_slotindex = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _slotindex);
		}
		
		override public function getForm():int
		{
			return 110;
		}
		
		override public function getName():String
		{
			return "getglobalslot";
		}
		
//		override public function toString():String
//		{
//			return "[ getglobalslot slotindex:" + slotindex + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "slotindex:" + _slotindex;
		}
		
		override public function getParams():Vector.<int>
		{
			return new <int>[_slotindex];
		}
		
		override public function getParamNames():Vector.<String>
		{
			return new <String>["_slotindex"];
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<slotindex>" + _slotindex + "</slotindex>");
		}
		
		override public function deltaNumStack():int
		{
			return 1;
		}
	}
}