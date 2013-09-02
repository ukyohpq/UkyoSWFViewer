package decompiler.tags.doabc.cpools.namespaces
{
	import decompiler.tags.doabc.events.ABCFileEvent;
	import decompiler.tags.doabc.reference.IReferenceable;
	import decompiler.tags.doabc.reference.Reference;
	import decompiler.tags.doabc.reference.ReferencedElement;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * namespace_info
			{
				u8 kind
				u30 name
			}
	 * 	Namespace 
	 * 	Kind 						Value
		CONSTANT_Namespace 			0x08
		CONSTANT_PackageNamespace 	0x16
		CONSTANT_PackageInternalNs 	0x17
		CONSTANT_ProtectedNamespace 0x18
		CONSTANT_ExplicitNamespace 	0x19
		CONSTANT_StaticProtectedNs 	0x1A
		CONSTANT_PrivateNs 			0x05
	 * @author ukyohpq
	 * 
	 */
	public class CNameSpace extends ReferencedElement implements IReferenceable
	{
		private var _kind:uint;

		public function get kind():uint
		{
			return _kind;
		}

		public function set kind(value:uint):void
		{
			modify();
			_kind = value;
		}
		
		public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			 include "../../reference/IReferenceable_Fragment_1.as"
			
		}
		
		
		private var _name:uint;

		/**
		 * namespace_info entry defines a namespace. 
		 * Namespaces have string names, represented by indices into the string array, and kinds.
		 * @return 
		 * 
		 */
		public function get name():uint
		{
			return _name;
		}

		public function set name(value:uint):void
		{
			if(_name == value)
				return;
			modify();
			try{
				$abcFile.getStringByIndex(_name).removeReference(this, "name");
			}catch(err:Error)
			{
				trace(err);
			}
			_name = value;
			$abcFile.getStringByIndex(_name).addReference(this, "name");
		}

		public function CNameSpace(kind:uint = 0, name:uint = 0)
		{
			//kind只有8bit，最大255，传入的参数如果大于8位，取低8位，忽略高位
			kind &= 255;
			_kind = kind;
			_name = name;
		}

		private function onParseComplete(event:ABCFileEvent):void
		{
			creatRefrenceRelationship();
		}
		
		public function creatRefrenceRelationship():void
		{
			$abcFile.getStringByIndex(_name).addReference(this, "name");
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_kind = byte.readUnsignedByte();
			_name = SWFUtil.readU30(byte);
			include "../../reference/IReferenced_Fragment_1.as";
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.writeByte(_kind);
			SWFUtil.writeU30(byte, _name);
			return byte;
		}
		
		public function toString():String
		{
			return "[ns (" + getKindString(_kind) + ") " + $abcFile.getStringByIndex(_name) + " str(" + _name + ")]";
		}
		
		public static function getKindString(kind:int):String
		{
			switch(kind)
			{
				case 0x08:	return "CONSTANT_Namespace";
				case 0x16:	return "CONSTANT_PackageNamespace";
				case 0x17:	return "CONSTANT_PackageInternalNs";
				case 0x18:	return "CONSTANT_ProtectedNamespace";
				case 0x19:	return "CONSTANT_ExplicitNamespace";
				case 0x1A:	return "CONSTANT_StaticProtectedNs";
				case 0x05:	return "CONSTANT_PrivateNs";
				default:	throw new Error("未识别的NameSpace kind.");
			}
		}
		
		override public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "namespace";
			var xml:SWFXML = new SWFXML(name);
			xml.setAttribute("kind", getKindString(_kind) + "(" + _kind + ")");
			xml.setAttribute("name", $abcFile.getStringByIndex(_name) + "(str_" + _name + ")");
			return xml;
		}
		
	}
}