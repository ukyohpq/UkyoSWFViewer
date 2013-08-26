package decompiler.tags.doabc.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Undocumented
	 * @author ukyohpq
	 * 
	 */
	public class Pushdecimal extends AbstractInstruction
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
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			index = SWFUtil.readU30(byte);
			super.decodeFromBytes(byte);
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