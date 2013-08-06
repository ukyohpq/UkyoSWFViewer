package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * vm-use only, not allowed in ABC files.
	 * @author ukyohpq
	 * 
	 */
	public class Abs_jump extends AbstractInstruction
	{
		private var offset:uint;
		public function Abs_jump()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			offset = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, offset);
		}
		
		override public function getForms():int
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
			return "offset:" + offset;
		}
		
		
	}
}