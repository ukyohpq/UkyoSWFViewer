package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		istype
		index
	 * 	index is a u30 that must be an index into the multiname constant pool. The multiname at
		index must not be a runtime multiname.
		Resolve the type specified by the multiname. Let indexType refer to that type. Compute the
		type of value, and let valueType refer to that type. If valueType is the same as indexType, result
		is true. If indexType is a base type of valueType, or an implemented interface of valueType,
		then result is true. Otherwise result is set to false. Push result onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Istype extends AbstractInstruction
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

		public function Istype()
		{
			super();
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
		
		override public function getForm():int
		{
			return 178;
		}
		
		override public function getName():String
		{
			return "istype";
		}
		
//		override public function toString():String
//		{
//			return "[istype]";
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