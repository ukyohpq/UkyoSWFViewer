package decompiler.core.instruction
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.tags.doabc.methodBody.MethodBody;

	public class AbstractInstruction implements ISWFElement, IByteArrayReader
	{
		public var methodBody:MethodBody;
		public var position:uint;
		public var opcodeIndex:int;
		public function AbstractInstruction()
		{
		}
		
		public function getName():String
		{
			return "";
		}
		
		public function getForms():int
		{
			return -1;
		}
		
		public final function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			byte.writeByte(getForms());
			encodeBody(byte);
			return byte;
		}
		
		protected function encodeBody(byte:ByteArray):void
		{
			
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			
		}
		
		public final function toString():String
		{
			return "[ " + opcodeIndex + " " + position + " " + getName() + " " + stringBody() + " ]";
		}
		
		protected function stringBody():String
		{
			return "";
		}
	}
}