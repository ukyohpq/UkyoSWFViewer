
package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		declocal_i
		index
	 * index is a u30 that must be an index of a local register. 
	 * The value of the local register at index is converted 
	 * to an int using the ToInt32 algorithm (ECMA-262 section 9.5) 
	 * and then 1 is subtracted the int value. 
	 * The local register at index is then set to the result.
	 * @author ukyohpq
	 * 
	 */
	public class Declocal_i extends AbstractInstruction
	{
		private var index:uint;
		public function Declocal_i()
		{
			super();
		}
		
		override public function getForms():int
		{
			return 195;
		}
		
		override public function getName():String
		{
			return "declocal_i";
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			index = SWFUtil.readU30(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, index);
		}
		
//		override public function toString():String
//		{
//			return "[ declocal_i index:" + index + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "index:" + index;
		}
		
		
	}
}