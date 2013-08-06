package decompiler.core.instruction
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
		private var index:uint;
		public function Pushdecimal()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			index = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, index);
		}
		
		override public function getForms():int
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