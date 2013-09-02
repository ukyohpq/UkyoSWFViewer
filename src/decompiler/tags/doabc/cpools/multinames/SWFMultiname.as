package decompiler.tags.doabc.cpools.multinames
{
	import decompiler.tags.doabc.events.ABCFileEvent;
	import decompiler.tags.doabc.reference.IReferenceable;
	import decompiler.tags.doabc.reference.ReferencedElement;
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
		
		public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			include "../../reference/IReferenceable_Fragment_1.as";
		}
		
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			include "../../reference/IReferenced_Fragment_1.as";
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
		
		/**
		 * 运行时在pCode中确定一个mn所需要的栈的个数，主要用于确定callproperty时的可选参数的数量
		 * @return 
		 * 
		 */
		public function needNumParams():int
		{
			return 0;
		}
	}
}