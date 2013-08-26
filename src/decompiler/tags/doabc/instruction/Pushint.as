package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		pushint
		index
	 * index is a u30 that must be an index into the integer constant pool. The int value at index in
		the integer constant pool is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Pushint extends AbstractInstruction
	{
		private var _index:uint;

		public function get index():uint
		{
			return _index;
		}

		public function set index(value:uint):void
		{
			modify();
			$abcFile.getIntByIndex(_index).removeReference(this, "index");
			_index = value;
			$abcFile.getIntByIndex(_index).addReference(this, "index");
		}

		public function Pushint()
		{
			super();
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getIntByIndex(_index).addReference(this, "index");
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
		
		override public function getForm():int
		{
			return 45;
		}
		
		override public function getName():String
		{
			return "pushint";
		}
		
//		override public function toString():String
//		{
//			return "[ pushint int:" + $abcFile.getIntByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "int:" + $abcFile.getIntByIndex(_index);
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