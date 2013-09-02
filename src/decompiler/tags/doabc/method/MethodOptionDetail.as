package decompiler.tags.doabc.method
{
	import decompiler.tags.doabc.ABCFileElement;
	import decompiler.tags.doabc.events.ABCFileEvent;
	import decompiler.tags.doabc.reference.IReferenceable;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * option_detail
		{
			u30 val
			u8 kind
		}
	 * @author ukyohpq
	 * 
	 */
	public final class MethodOptionDetail extends ABCFileElement implements IReferenceable
	{
		private var _val:int;
		
		public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			 include "../reference/IReferenceable_Fragment_1.as"
			
		}
		
		
		public function get val():int
		{
			return _val;
		}

		public function set val(value:int):void
		{
			modify();
			try{
				$abcFile.removeReferenceByKindAndIndex(_kind, _val, this);
			}catch(err:Error)
			{
				trace(err);
			}
			_val = value;
			$abcFile.addReferenceByKindAndIndex(_kind, _val, this);
		}

		private var _kind:int;

		public function get kind():int
		{
			return _kind;
		}

		public function set kind(value:int):void
		{
			modify();
			try{
				$abcFile.removeReferenceByKindAndIndex(_kind, _val, this);
			}catch(err:Error)
			{
				trace(err);
			}
			_kind = value;
			$abcFile.addReferenceByKindAndIndex(_kind, _val, this);
		}

		public function MethodOptionDetail(val:int = 0, kind:int = 0)
		{
			_val = val;
			_kind = kind;
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_val = SWFUtil.readU30(byte);
			_kind = byte.readUnsignedByte();
			
			include "../reference/IReferenced_Fragment_1.as";
		}

		private function onParseComplete(event:ABCFileEvent):void
		{
			$abcFile.addReferenceByKindAndIndex(_kind, _val, this);
		}
		
		override public function toXML(name:String = null):SWFXML
		{
			var xml:SWFXML = new SWFXML("MethodOptionDetail");
			xml.setAttribute("val", _val);
			xml.setAttribute("kind", _kind);
			return xml;
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray =  new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _val);
			byte.writeByte(_kind);
			return byte;
		}
		
		public function creatRefrenceRelationship():void
		{
			// TODO Auto Generated method stub
			
		}
		
	}
}