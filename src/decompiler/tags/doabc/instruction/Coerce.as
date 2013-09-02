package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.reference.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		coerce
		index
	 * index is a u30 that must be an index into the multiname constant pool. 
	 * The multiname at index must not be a runtime multiname. 
	 * The type specified by the multiname is resolved, 
	 * and value is coerced to that type. 
	 * The resulting value is pushed onto the stack. 
	 * If any of value’s base classes, 
	 * or implemented Adobe ActionScript Virtual Machine 2 (AVM2) 
	 * Overview 47 interfaces matches the type specified by the multiname, 
	 * then the conversion succeeds and the result is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Coerce extends AbstractInstruction
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

		public function Coerce()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 128;
		}
		
		override public function getName():String
		{
			return "coerce";
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_index = SWFUtil.readU30(byte);
			super.decodeFromBytes(byte);
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getMultinameByIndex(_index).addReference(this, "index");
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _index);
		}
		
//		override public function toString():String
//		{
//			return "[ coerce name:" + $abcFile.getMultinameByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:mn(" + _index + ")";
//			return "name:" + $abcFile.getMultinameByIndex(_index);
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
	}
}