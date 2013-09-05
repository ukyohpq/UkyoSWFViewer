package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Undocumented
	 * VerifyError: Error #1011: 方法 global$init() 包含非法 opcode 77 (偏移量为 30)。
	 * 目前avm2不认识
	 * 发现已经被注释掉了
	 * @author ukyohpq
	 * 
	 */
	public class Callinterface extends UnrecognizedInstruction
	{
		private var _index:uint;

		public function get index():uint
		{
			return _index;
		}

		public function set index(value:uint):void
		{
			_index = value;
		}

		public function Callinterface()
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
			super.encodeBody(byte);
		}
		
		override public function getForm():int
		{
			return 77;
		}
		
		override public function getName():String
		{
			return "callinterface";
		}
		
//		override public function toString():String
//		{
//			return "[ callinterface name:" + $abcFile.getMultinameByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + $abcFile.getMultinameByIndex(_index);
		}
		
		override public function getParams():Vector.<int>
		{
			return new <int>[_index];
		}
		
		override public function getParamNames():Vector.<String>
		{
			return new <String>["index"];
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<name>" + _index + "</name>");
		}
		
		
	}
}