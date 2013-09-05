package decompiler.tags.doabc.instruction.jump
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * vm-use only, not allowed in ABC files.
	 * @author ukyohpq
	 * 
	 */
	public class Abs_jump extends JumpSet
	{
		public function Abs_jump()
		{
			super();
		}
		
		//不知道为什么这个要用u30，一般的跳转的offset都是s24
		override protected function pcodeDecodeFromBytes(byte:ByteArray):void
		{
			_offset = SWFUtil.readU30(byte);
		}
		
		//不知道为什么这个要用u30，一般的跳转的offset都是s24
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
	}
}