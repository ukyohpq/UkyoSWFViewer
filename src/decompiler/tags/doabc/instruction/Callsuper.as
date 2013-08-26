package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		callsuper
		index
		arg_count
	 * arg_count is a u30 that is the number of arguments present on the stack. 
	 * The number of arguments specified by arg_count are popped off the stack and saved.
	 * index is a u30 that must be an index into the multiname constant pool. 
	 * If the multiname at that index is a runtime multiname 
	 * the name and/or namespace will also appear on the stack 
	 * so that the multiname can be constructed correctly at runtime. 
	 * receiver is the object to invoke the method on. 
	 * The base class of receiver is determined and 
	 * the method indicated by the multiname is 
	 * resolved in the declared traits of the base class. 
	 * The method is invoked with the arguments receiver, arg1, ..., argn. 
	 * The receiver will be used as the “this” value for the method. 
	 * The result of the method call is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Callsuper extends AbstractInstruction
	{
		private var _index:uint;

		public function get index():uint
		{
			return _index;
		}

		public function set index(value:uint):void
		{
			modify();
			$abcFile.getMultinameByIndex(_index).removeReference(this, "index");
			_index = value;
			$abcFile.getMultinameByIndex(_index).addReference(this, "index");
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

		public function Callsuper()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 69;
		}
		
		override public function getName():String
		{
			return "callsuper";
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_index = SWFUtil.readU30(byte);
			_arg_count = SWFUtil.readU30(byte);
			super.decodeFromBytes(byte);
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getMultinameByIndex(_index).addReference(this, "index");
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _index);
			SWFUtil.writeU30(byte, _arg_count);
		}
		
//		override public function toString():String
//		{
//			return "[ callsuper name:" + $abcFile.getMultinameByIndex(index) + " arg_count:" + arg_count + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + $abcFile.getMultinameByIndex(_index) + " arg_count:" + _arg_count;
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