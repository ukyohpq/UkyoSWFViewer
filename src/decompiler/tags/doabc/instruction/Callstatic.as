package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		callstatic
		index
		arg_count
	 * index is a u30 that is the index of the method_info of the method to invoke. 
	 * arg_count is a u30 that is the number of arguments present on the stack. 
	 * receiver is the object to invoke the method on. 
	 * The method at position index is invoked with the arguments receiver, arg1, ..., argn. 
	 * The receiver will be used as the “this” value for the method. 
	 * The result of the method is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Callstatic extends AbstractInstruction
	{
		private var _index:uint;

		public function get index():uint
		{
			return _index;
		}

		public function set index(value:uint):void
		{
			modify();
			$abcFile.getMethodInfoByIndex(_index).removeReference(this, "index");
			_index = value;
			$abcFile.getMethodInfoByIndex(_index).addReference(this, "index");
		}

		private var _arg_count:uint;

		public function get arg_count():uint
		{
			return _arg_count;
		}

		public function set arg_count(value:uint):void
		{
			modify();
			_arg_count = value;
		}

		public function Callstatic()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 68;
		}
		
		override public function getName():String
		{
			return "callstatic";
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_index = SWFUtil.readU30(byte);
			_arg_count = SWFUtil.readU30(byte);
			super.decodeFromBytes(byte);
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getMethodInfoByIndex(_index).addReference(this, "index");
		}
		
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _index);
			SWFUtil.writeU30(byte, _arg_count);
		}
		
//		override public function toString():String
//		{
//			return "[ callstatic name:" + $abcFile.getMethodByIndex(index) + " arg_count:" + arg_count + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + $abcFile.getMethodInfoByIndex(_index) + " arg_count:" + _arg_count;
		}
		
		override public function getParams():Vector.<uint>
		{
			return new <uint>[_index, _arg_count];
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<index>" + _index + "</index>");
			xml.appendChild("<arg_count>" + _arg_count + "</arg_count>");
		}
	}
}