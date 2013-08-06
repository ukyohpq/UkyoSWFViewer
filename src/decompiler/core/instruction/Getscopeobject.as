package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		getscopeobject
		index
	 * 	index is an unsigned byte that specifies the index of the scope object to retrieve from the local
		scope stack. index must be less than the current depth of the scope stack. The scope at that
		index is retrieved and pushed onto the stack. The scope at the top of the stack is at index
		scope_depth-1, and the scope at the bottom of the stack is index 0.
	 * @author ukyohpq
	 * 
	 */
	public class Getscopeobject extends AbstractInstruction
	{
		private var index:uint;
		public function Getscopeobject()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			index = byte.readUnsignedByte();
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			byte.writeByte(index);
		}
		
		override public function getForms():int
		{
			return 101;
		}
		
		override public function getName():String
		{
			return "getscopeobject";
		}
		
//		override public function toString():String
//		{
//			return "[ getscopeobject index:" + index + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "index:" + index;
		}
		
		
	}
}