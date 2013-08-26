package decompiler.tags.doabc.cpools.multinames
{
	import decompiler.tags.doabc.IReferenceable;
	import decompiler.tags.doabc.ReferencedElement;
	import decompiler.tags.doabc.events.ABCFileEvent;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * 各种Multiname的基类
	 * multiname_info
			{
				u8 kind
				u8 data[]
			}
	 * @author ukyohpq
	 * 
	 */
	public class SWFMultiname extends ReferencedElement implements IReferenceable
	{
		private var _kind:int;

		public function get kind():int
		{
			return _kind;
		}

		public function SWFMultiname(kind:int = 0)
		{
			_kind = kind;
		}

		private function onParseComplete(event:ABCFileEvent):void
		{
			creatRefrenceRelationship();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			include "../../IReferenced_Fragment_1.as";
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.writeByte(_kind);
			byte.writeBytes(encodeData());
			return byte;
		}
		
		final override public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "Multiname";
			var xml:SWFXML = new SWFXML(name);
			xml.setAttribute("kind", _kind);
			xml.setAttribute("kindName", MultinameKind.getNameByKind(_kind));
			contentToXML(xml);
			return xml;
		}
		
		protected function contentToXML(xml:SWFXML):void
		{
			//todo
		}
		
		protected function encodeData():ByteArray
		{
			return new ByteArray;
		}
		
		public function toString():String
		{
			return "[ SWFMultiname * ]";
		}
		
		public function creatRefrenceRelationship():void
		{
			//todo
		}
		
	}
}