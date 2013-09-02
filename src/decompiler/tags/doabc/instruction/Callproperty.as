package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.cpools.multinames.MultinameKind;
	import decompiler.tags.doabc.cpools.multinames.SWFMultiname;
	import decompiler.tags.doabc.reference.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		callproperty
		index
		arg_count
	 * Stack
		…, obj, [ns], [name], arg1,...,argn => …, value
	 * 
	 * arg_count is a u30 that is the number of arguments present on the stack. 
	 * The number of arguments specified by arg_count are popped off the stack and saved. 
	 * 
	 * index is a u30 that must be an index into the multiname constant pool. 
	 * If the multiname at that index is a runtime multiname 
	 * the name and/or namespace will also appear on the stack 
	 * so that the multiname can be constructed correctly at runtime. 
	 * 
	 * obj is the object to resolve and call the property on. 
	 * The property specified by the multiname at index is resolved on the object obj. 
	 * The [[Call]] property is invoked on the value of the resolved property 
	 * with the arguments obj, arg1, ..., argn. 
	 * The result of the call is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Callproperty extends AbstractInstruction
	{
		private var _index:uint;

		public function get index():uint
		{
			return _index;
		}

		public function set index(value:uint):void
		{
			modify();
			try{
				$abcFile.getMultinameByIndex(_index).removeReference(this, "index");
			}catch(err:Error)
			{
				trace(err);
			}
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

		public function Callproperty()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 70;
		}
		
		override public function getName():String
		{
			return "callproperty";
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
//			return "[ callproperty name:" + $abcFile.getMultinameByIndex(index) + " arg_count:" + arg_count + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + $abcFile.getMultinameByIndex(_index) + " arg_count:" + _arg_count;
		}
		
		override public function getParams():Vector.<int>
		{
			return new <int>[_index, _arg_count];
		}
		
		override public function getParamNames():Vector.<String>
		{
			return new <String>["_index", "_arg_count"];
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<index>" + _index + "</index>");
			xml.appendChild("<arg_count>" + _arg_count + "</arg_count>");
		}
		
		override public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			include "../reference/IReferenceable_Fragment_1.as";
		}
		
		override public function deltaNumStack():int
		{
			return -(_arg_count + $abcFile.getMultinameByIndex(_index).needNumParams());
		}
	}
}