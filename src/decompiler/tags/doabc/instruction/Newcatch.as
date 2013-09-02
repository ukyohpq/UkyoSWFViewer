package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.reference.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		newcatch
		index
	 * 	index is a u30 that must be an index of an exception_info structure for this method.
		This instruction creates a new object to serve as the scope object for the catch block for the
		exception referenced by index. This new scope is pushed onto the operand stack.
	 * @author ukyohpq
	 * 
	 */
	public class Newcatch extends AbstractInstruction
	{
		private var _index:uint;

		public function get index():uint
		{
			return _index;
		}

		public function set index(value:uint):void
		{
			modify();
			_index = value;
		}

		public function Newcatch()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_index = SWFUtil.readU30(byte);
			super.decodeFromBytes(byte);
		}
		
		override public function creatRefrenceRelationship():void
		{
			//必然会出现引用时还没创建好的情况，因为exception是在opcode之后的
//			methodBody.getExceptionInfoByIndex(_index).addRefrence(this, "index");
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _index);
		}
		
		override public function getForm():int
		{
			return 90;
		}
		
		override public function getName():String
		{
			return "newcatch";
		}
		
//		override public function toString():String
//		{
//			return "[ newcatch exception:" + methodBody.getExceptionInfoByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "exception:" + methodBody.getExceptionInfoByIndex(_index);
		}
		
		override public function getParams():Vector.<int>
		{
			return new <int>[_index];
		}
		
		override public function getParamNames():Vector.<String>
		{
			return new <String>["_index"];
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<index>" + _index + "</index>");
		}
		
		override public function deltaNumStack():int
		{
			return 1;
		}
	}
}