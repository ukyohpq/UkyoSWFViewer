package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * Format
		getlex
		index
	 * 	index is a u30 that must be an index into the multiname constant pool. The multiname at
		index must not be a runtime multiname, so there are never any optional namespace or name
		values on the stack.
		This is the equivalent of doing a findpropstict followed by a getproperty. It will find the
		object on the scope stack that contains the property, and then will get the value from that
		object. See “Resolving multinames” on page 10.
	 * @author ukyohpq
	 * 
	 */
	public class Getlex extends AbstractInstruction
	{
		private var index:uint;
		public function Getlex()
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
			return 96;
		}
		
		override public function getName():String
		{
			return "getlex";
		}
		
//		override public function toString():String
//		{
//			return "[ getlex name:" + ABCFile.getInstance().getMultinameByIndex(index) + " ]";
//		}
//		
		override protected function stringBody():String
		{
			return "name:" + ABCFile.getInstance().getMultinameByIndex(index);
		}
		
		
	}
}