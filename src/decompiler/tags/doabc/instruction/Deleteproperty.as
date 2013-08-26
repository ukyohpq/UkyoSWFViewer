package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		deleteproperty
		index
	 * index is a u30 that must be an index into the multiname constant pool. 
	 * If the multiname at that index is a runtime 
	 * multiname the name and/or namespace will also appear on the stack 
	 * so that the multiname can be constructed correctly at runtime. 
	 * This will invoke the [[Delete]] method on object with the name specified by the multiname. 
	 * If object is not dynamic or the property is a fixed property then nothing happens, 
	 * and false is pushed onto the stack. 
	 * If object is dynamic and the property is not a fixed property, 
	 * it is removed from object and true is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Deleteproperty extends AbstractInstruction
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

		public function Deleteproperty()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 106;
		}
		
		override public function getName():String
		{
			return "deleteproperty";
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_index = SWFUtil.readU30(byte);
			super.decodeFromBytes(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _index);
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getMultinameByIndex(_index).addReference(this, "index");
		}
		
//		override public function toString():String
//		{
//			return "[ deleteproperty name:" + $abcFile.getMultinameByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + $abcFile.getMultinameByIndex(_index);
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