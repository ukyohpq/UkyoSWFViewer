package decompiler.tags.doabc.cpools
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	
	import flash.utils.ByteArray;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

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
	public class CNameSpace implements IByteArrayReader, ISWFElement
	{
		private var _kind:uint;

		public function get kind():uint
		{
			return _kind;
		}

		public function set kind(value:uint):void
		{
			_kind = value;
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
			_name = value;
		}

		public function CNameSpace(kind:uint = 0, name:uint = 0)
		{
			//kind只有8bit，最大255，传入的参数如果大于8位，取低8位，忽略高位
			kind &= 255;
			_kind = kind;
			_name = name;
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			_kind = byte.readUnsignedByte();
			_name = SWFUtil.readU30(byte);
		}
		
		public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.writeByte(_kind);
			SWFUtil.writeU30(byte, _name);
			return byte;
		}
		
		public function toString():String
		{
			return "[ NamespaceKind:" + getKindString(_kind) + " name:" + ABCFile.getInstance().getStringByIndex(_name) + " ]";
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
	}
}