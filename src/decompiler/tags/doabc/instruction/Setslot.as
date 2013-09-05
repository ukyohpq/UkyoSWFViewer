package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		setslot
		slotindex
	 * slotindex is a u30 that must be an index of a slot on obj. slotindex must be greater than 0 and
		less than or equal to the total number of slots obj has.
	 * @author ukyohpq
	 * 
	 */
	public class Setslot extends AbstractInstruction
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

		public function Setslot()
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
			return 109;
		}
		
		override public function getName():String
		{
			return "setslot";
		}
		
//		override public function toString():String
//		{
//			return "[ setslot slotindex:" + slotindex + " ]";
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
			return -2;
		}
	}
}