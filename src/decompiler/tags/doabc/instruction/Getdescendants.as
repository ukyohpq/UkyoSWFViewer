package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.reference.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		getdescendants
		index
	 * 	index is a u30 that must be an index into the multiname constant pool. If the multiname at
		that index is a runtime multiname the name and/or namespace will also appear on the stack
		so that the multiname can be constructed correctly at runtime.
		obj is the object to find the descendants in. This will invoke the [[Descendants]] property on
		obj with the multiname specified by index. For a description of the [[Descendants]] operator,
		see the E4X spec (ECMA-357) sections 9.1.1.8 (for the XML type) and 9.2.1.8 (for the
		XMLList type).
	 * @author ukyohpq
	 * 
	 */
	public class Getdescendants extends AbstractInstruction
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

		public function Getdescendants()
		{
			super();
		}
		
		override protected function pcodeDecodeFromBytes(byte:ByteArray):void
		{
			_index = SWFUtil.readU30(byte);
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getMultinameByIndex(_index).addReference(this, "index");
		}
		
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _index);
		}
		
		override public function getForm():int
		{
			return 89;
		}
		
		override public function getName():String
		{
			return "getdescendants";
		}
		
//		override public function toString():String
//		{
//			return "[ getdescendants name:" + $abcFile.getMultinameByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + $abcFile.getMultinameByIndex(_index);
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
			return -$abcFile.getMultinameByIndex(_index).needNumParams();
		}
	}
}