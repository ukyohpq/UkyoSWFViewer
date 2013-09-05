package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.reference.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		newfunction
		index
	 * 	index is a u30 that must be an index of a method_info. A new function object is created
		from that method_info and pushed onto the stack. For a description of creating a new
		function object, see ECMA-262 section 13.2.
		When creating the new function object the scope stack used is the current scope stack when
		this instruction is executed, and the body is the method_body entry that references the
		specified method_info entry.
	 * @author ukyohpq
	 * 
	 */
	public class Newfunction extends AbstractInstruction
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
				$abcFile.getMethodInfoByIndex(_index).removeReference(this, "index");
			}catch(err:Error)
			{
				trace(err);
			}
			_index = value;
			$abcFile.getMethodInfoByIndex(_index).addReference(this, "index");
		}

		public function Newfunction()
		{
			super();
		}
		
		override protected function pcodeDecodeFromBytes(byte:ByteArray):void
		{
			_index = SWFUtil.readU30(byte);
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getMethodInfoByIndex(_index).addReference(this, "index");
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _index);
		}
		
		override public function getForm():int
		{
			return 64;
		}
		
		override public function getName():String
		{
			return "newfunction";
		}
		
//		override public function toString():String
//		{
//			return "[ newfunction class:" + $abcFile.getMethodByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "methodBody:" + $abcFile.getMethodInfoByIndex(_index);
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
		
		override public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			include "../reference/IReferenceable_Fragment_1.as";
		}
		
		override public function deltaNumStack():int
		{
			return 1;
		}
	}
}