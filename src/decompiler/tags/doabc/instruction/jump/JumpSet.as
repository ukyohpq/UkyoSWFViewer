package decompiler.tags.doabc.instruction.jump
{
	import decompiler.tags.doabc.instruction.AbstractInstruction;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	public class JumpSet extends AbstractInstruction implements IJumpSet
	{
		protected var _offset:int;
		public function JumpSet()
		{
			super();
		}
		
		public function get offset():int
		{
			return _offset;
		}
		
		public function set offset(value:int):void
		{
			if(_offset != value)
			{
				_offset = value;
				modify();
			}
		}
		
		public function modifyOffset(deltaOffset:int, isAfter:Boolean, bytesLengthBetweenCurrentIndexAndInsertIndex:uint):void
		{
			//非lookupswith的跳转，是从下一个pcode数起的，所以，
			//前跳时，要跳过语句自身，和lookupswitch相反，
			//lookupswitch在后跳时需要跳过语句自身
			if(_offset < 0 && !isAfter && (bytesLengthBetweenCurrentIndexAndInsertIndex + getBytesLength() + _offset) < 0)
			{
				_offset -= deltaOffset;
			}else if(_offset > 0 && isAfter && bytesLengthBetweenCurrentIndexAndInsertIndex < _offset){
				_offset += deltaOffset;
			}
		}
		
		override protected function pcodeDecodeFromBytes(byte:ByteArray):void
		{
			_offset = SWFUtil.readS24(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeS24(byte, _offset);
		}
		
		override protected function stringBody():String
		{
			return "offset:" + _offset;
		}
		
		override public function getParams():Vector.<int>
		{
			return new <int>[_offset];
		}
		
		override public function getParamNames():Vector.<String>
		{
			return new <String>["_offset"];
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<offset>" + _offset + "</offset>");
		}
		
	}
}