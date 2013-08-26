package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.ABCFileElement;
	import decompiler.tags.doabc.IReferenceable;
	import decompiler.tags.doabc.methodBody.MethodBody;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class AbstractInstruction extends ABCFileElement implements IReferenceable
	{
		public var methodBody:MethodBody;
		public function AbstractInstruction()
		{
			super();
		}
		
		public function creatRefrenceRelationship():void
		{
			
		}
		
		
		public function getName():String
		{
			return "../";
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			include "../IReferenced_Fragment_1.as";
		}
		
		
		public function getForm():int
		{
			return -1;
		}
		
		override public final function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			byte.writeByte(getForm());
			encodeBody(byte);
			return byte;
		}
		
		protected function encodeBody(byte:ByteArray):void
		{
			
		}
		
		public final function toString():String
		{
			return "[ " + getName() + " " + stringBody() + "]";
		}
		
		protected function stringBody():String
		{
			return "";
		}
		
		override final public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "opcode";
			var xml:SWFXML = new SWFXML(name);
			xml.setAttribute("opcodeName", getName());
			xml.setAttribute("hex", toHex());
			paramsToXML(xml);
			return xml;
		}
		
		protected function paramsToXML(xml:SWFXML):void
		{
			//must be overrided
		}
		
		private function toHex():String
		{
			var str:String = getForm().toString(16);
			var vec:Vector.<uint> = getParams();
			if(!vec) return str;
			var length:int = vec.length;
			for (var i:int = 0; i < length; ++i) 
			{
				if(vec[i] < 16)
				{
					str += " 0" + vec[i].toString(16);
				}else{
					str += " " + vec[i].toString(16);
				}
				
			}
			
			return str;
		}
		
		public function getParams():Vector.<uint>
		{
			return null;
		}
		
		public function equal(pCode:AbstractInstruction):Boolean
		{
			if(getForm() != pCode.getForm()) return false;
			var params1:Vector.<uint> = getParams();
			var params2:Vector.<uint> = pCode.getParams();
			var length:int = getParams().length;
			for (var i:int = 0; i < length; ++i) 
			{
				if(params1[i] != params2[i])
					return false;
			}
			
			return true;
		}
	}
}