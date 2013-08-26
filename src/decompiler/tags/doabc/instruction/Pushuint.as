package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		pushuint
		index
	 * index is a u30 that must be an index into the unsigned integer constant pool. The value at
		index in the unsigned integer constant pool is pushed onto the stack.
	 * @author ukyohpq
	 * 
	 */
	public class Pushuint extends AbstractInstruction
	{
		private var _index:uint;

		public function get index():uint
		{
			return _index;
		}

		public function set index(value:uint):void
		{
			modify();
			$abcFile.getUintByIndex(_index).removeReference(this, "index");
			_index = value;
			$abcFile.getUintByIndex(_index).addReference(this, "index");
		}

		public function Pushuint()
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
			$abcFile.getUintByIndex(_index).addReference(this, "index");
		}
		
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _index);
		}
		
		override public function getForm():int
		{
			return 46;
		}
		
		override public function getName():String
		{
			return "pushuint";
		}
		
//		override public function toString():String
//		{
//			return "[ pushuint uint:" + $abcFile.getUintByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "uint:" + $abcFile.getUintByIndex(_index);
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