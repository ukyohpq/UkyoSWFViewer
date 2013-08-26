package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		findpropstrict
		index
	 * 	index is a u30 that must be an index into the multiname constant pool. If the multiname at
		that index is a runtime multiname the name and/or namespace will also appear on the stack
		so that the multiname can be constructed correctly at runtime.
		This searches the scope stack, and then the saved scope in the method closure, for a property
		with the name specified by the multiname at index.
		If any of the objects searched is a with scope, its declared and dynamic properties will be
		searched for a match. Otherwise only the declared traits of a scope will be searched. The
		global object will have its declared traits, dynamic properties, and prototype chain searched.
		If the property is resolved then the object it was resolved in is pushed onto the stack. If the
		property is unresolved in all objects on the scope stack then an exception is thrown.
	 * @author ukyohpq
	 * 
	 */
	public class Findpropstrict extends AbstractInstruction
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

		public function Findpropstrict()
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
			$abcFile.getMultinameByIndex(_index).addReference(this, "index");
		}
		
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _index);
		}
		
		override public function getForm():int
		{
			return 93;
		}
		
		override public function getName():String
		{
			return "findpropstrict";
		}
		
//		override public function toString():String
//		{
//			return "[ findpropstrict name:" + $abcFile.getMultinameByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:mn(" + _index + ")";
//			return "name:" + $abcFile.getMultinameByIndex(_index);
		}
		
		override public function getParams():Vector.<uint>
		{
			return new <uint>[_index];
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<index>" + _index + "</index>");
		}
	}
}