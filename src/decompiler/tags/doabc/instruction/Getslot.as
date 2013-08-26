package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		getslot
		slotindex
		Forms
		getslot = 108 (0x6c)
		Stack
		…, obj => …, value
		Description
		slotindex is a u30 that must be an index of a slot on obj. slotindex must be less than the total
		number of slots obj has.
		This will retrieve the value stored in the slot at slotindex on obj. This value is pushed onto the
		stack.
	 * @author ukyohpq
	 * 
	 */
	public class Getslot extends AbstractInstruction
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

		public function Getslot()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_slotindex = SWFUtil.readU30(byte);
			super.decodeFromBytes(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _slotindex);
		}
		
		override public function getForm():int
		{
			return 108;
		}
		
		override public function getName():String
		{
			return "getslot";
		}
		
//		override public function toString():String
//		{
//			return "[ getslot slotindex:" + slotindex + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "slotindex:" + _slotindex;
		}
		
		override public function getParams():Vector.<uint>
		{
			return new <uint>[_slotindex];
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<slotindex>" + _slotindex + "</slotindex>");
		}
	}
}