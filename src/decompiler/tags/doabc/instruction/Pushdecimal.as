package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	
	import flash.utils.ByteArray;

	/**
	 * Undocumented
	 * VerifyError: Error #1011: 方法 SDFASDFSDF() 包含非法 opcode 51 (偏移量为 6)。
	 * 没找到，avm2已经不认了
	 * @author ukyohpq
	 * 
	 */
	public class Pushdecimal extends UnrecognizedInstruction
	{
		private var _index:uint;

		public function get index():uint
		{
			return _index;
		}

		//不知这个index是啥用
		public function set index(value:uint):void
		{
			modify();
			_index = value;
		}

		public function Pushdecimal()
		{
			super();
		}
		
		override protected function pcodeDecodeFromBytes(byte:ByteArray):void
		{
			_index = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, index);
		}
		
		override public function getForm():int
		{
			return 51;
		}
		
		override public function getName():String
		{
			return "pushdecimal";
		}
		
//		override public function toString():String
//		{
//			return "[ pushdecimal index:" + index + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "index:" + index;
		}
	}
}