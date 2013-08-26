package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		getlex
		index
	 * 	index is a u30 that must be an index into the multiname constant pool. The multiname at
		index must not be a runtime multiname, so there are never any optional namespace or name
		values on the stack.
		This is the equivalent of doing a findpropstict followed by a getproperty. It will find the
		object on the scope stack that contains the property, and then will get the value from that
		object. See “Resolving multinames” on page 10.
	 * @author ukyohpq
	 * 
	 */
	public class Getlex extends AbstractInstruction
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

		public function Getlex()
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
			return 96;
		}
		
		override public function getName():String
		{
			return "getlex";
		}
		
//		override public function toString():String
//		{
//			return "[ getlex name:" + $abcFile.getMultinameByIndex(index) + " ]";
//		}
//		
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