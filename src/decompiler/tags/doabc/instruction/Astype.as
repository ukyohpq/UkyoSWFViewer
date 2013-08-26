package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		astype
		index
	 * index is a u30 that must be an index into the multiname constant pool. 
	 * The multiname at index must not be a runtime multiname, and must be the name of a type.
	 * Pop value off of the stack. If value is of the type specified by the multiname, 
	 * push value back onto the stack. 
	 * If value is not of the type specified by the multiname, 
	 * then push null onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Astype extends AbstractInstruction
	{
		private var _index:int;

		public function get index():int
		{
			return _index;
		}

		public function set index(value:int):void
		{
			modify();
			$abcFile.getMultinameByIndex(_index).removeReference(this, "index");
			_index = value;
			$abcFile.getMultinameByIndex(_index).addReference(this, "index");
		}

		public function Astype()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 134;
		}
		
		override public function getName():String
		{
			return "astype";
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			index = SWFUtil.readU30(byte);
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
//			return "[ astype index:" + $abcFile.getMultinameByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "index:" + $abcFile.getMultinameByIndex(index);
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<index>" + _index + "</index>");
			super.paramsToXML(xml);
		}
		
		override public function getParams():Vector.<uint>
		{
			return new <uint>[index];
		}
		
		
	}
}