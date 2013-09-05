package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.ABCFileElement;
	import decompiler.tags.doabc.methodBody.MethodBody;
	import decompiler.tags.doabc.reference.IReferenceable;
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
		
		public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			 include "../reference/IReferenceable_Fragment_1.as"
			
		}
		
		
		public function creatRefrenceRelationship():void
		{
			//to be override 
		}
		
		
		public function getName():String
		{
			return "../";
		}
		
		/**
		 * 是否是经过解码过的pcode，用来区分是读一个swf中的pcode还是自己构造的一个pcode。
		 * 通过这个来决定该pcode使用的字节长度的计算方式。如果是解码得到的，就使用解码时的算法来决定，
		 * 如果是自己构造的，就进行一次encode，来得到字节长度
		 */
		private var _decoded:Boolean;
		override final public function decodeFromBytes(byte:ByteArray):void
		{
			var len:int = byte.bytesAvailable;
			pcodeDecodeFromBytes(byte);
			include "../reference/IReferenced_Fragment_1.as";
			//+1是因为form使用了1byte
			_bytesLength = len - byte.bytesAvailable + 1;
		}
		
		protected function pcodeDecodeFromBytes(byte:ByteArray):void
		{
			//must to be override 
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
			var vec:Vector.<int> = getParams();
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
		
		public function getParams():Vector.<int>
		{
			return null;
		}
		
		public function getParamNames():Vector.<String>
		{
			return null;
		}
		
		private var _bytesLength:int;
		/**
		 * 该pcode使用的字节长度
		 * @return 
		 * 
		 */
		public function getBytesLength():int
		{
			if(!_decoded)
			{
				_bytesLength = encode().length;
				_decoded = true;
			}
			return _bytesLength;
		}
		
		public function equal(pCode:AbstractInstruction):Boolean
		{
			if(getForm() != pCode.getForm()) return false;
			var params1:Vector.<int> = getParams();
			var params2:Vector.<int> = pCode.getParams();
			var length:int = getParams().length;
			for (var i:int = 0; i < length; ++i) 
			{
				if(params1[i] != params2[i])
					return false;
			}
			
			return true;
		}
		
		/**
		 * 该opcode造成的stack改变量
		 * @return 
		 * 
		 */
		public function deltaNumStack():int
		{
			return 0;
		}
		
		/**
		 * 该opcode造成的scope改变量
		 * @return 
		 * 
		 */
		public function deltaNumScope():int
		{
			return 0;
		}
	}
}