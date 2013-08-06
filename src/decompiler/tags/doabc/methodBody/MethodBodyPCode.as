package decompiler.tags.doabc.methodBody
{
	import decompiler.core.ISWFElement;
	import decompiler.core.instruction.AbstractInstruction;
	import decompiler.core.instruction.InstructionFactory;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class MethodBodyPCode implements ISWFElement
	{
		private var _pcodes:Vector.<AbstractInstruction>;
		private var _methodBody:MethodBody;
		public function MethodBodyPCode(methodBody:MethodBody)
		{
			_methodBody = methodBody;
			_pcodes = new <AbstractInstruction>[];
		}
		
		public function decode(byte:ByteArray):void
		{
			var i:int = 0;
			while(byte.bytesAvailable)
			{
				var pCode:AbstractInstruction = InstructionFactory.creatInstruction(byte.readUnsignedByte());
				pCode.methodBody = _methodBody;
				pCode.position = byte.position - 1;
				pCode.decodeFromBytes(byte);
				pCode.opcodeIndex = i++;
				_pcodes.push(pCode);
			}
		}
		
		public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			var length:int = _pcodes.length;
			for (var i:int = 0; i < length; ++i) 
			{
				var tempBytes:ByteArray = _pcodes[i].encode();
				byte.writeBytes(tempBytes);
				tempBytes.clear();
			}
			
			return byte;
		}
		
		public function toString():String
		{
			var str:String = "";
			var length:int = _pcodes.length;
			for (var i:int = 0; i < length; ++i) 
			{
				str += "\n" + _pcodes[i].toString();
			}
			
			return "[ MethodBodyPCode" + str + " ]";
		}
	}
}