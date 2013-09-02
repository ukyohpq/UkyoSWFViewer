package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * vm-use only, not allowed in ABC files.
	 * @author ukyohpq
	 * 
	 */
	public class Abs_jump extends AbstractInstruction
	{
		private var _offset:uint;

		public function get offset():uint
		{
			return _offset;
		}

		public function set offset(value:uint):void
		{
			modify();
			_offset = value;
		}

		public function Abs_jump()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			offset = SWFUtil.readU30(byte);
			super.decodeFromBytes(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _offset);
		}
		
		override public function getForm():int
		{
			return 238;
		}
		
		override public function getName():String
		{
			return "abs_jump";
		}
		
//		override public function toString():String
//		{
//			return "[ abs_jump offset:" + offset + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "offset:" + _offset;
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<offset>" + _offset + "</offset>");
		}
		
		override public function getParams():Vector.<int>
		{
			return new <int>[_offset];
		}
		
		override public function getParamNames():Vector.<String>
		{
			return new <String>["_offset"];
		}
		
		override public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			include "../reference/IReferenceable_Fragment_1.as";
		}
	}
}