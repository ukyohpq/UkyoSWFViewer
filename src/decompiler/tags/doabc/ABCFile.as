package decompiler.tags.doabc
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	import decompiler.core.trait.TraitsInfo;
	import decompiler.tags.doabc.classAndInstances.CClass;
	import decompiler.tags.doabc.classAndInstances.CInstance;
	import decompiler.tags.doabc.cpools.CNameSpace;
	import decompiler.tags.doabc.cpools.CNsSet;
	import decompiler.tags.doabc.cpools.CString;
	import decompiler.tags.doabc.cpools.Cpool_info;
	import decompiler.tags.doabc.cpools.multinames.SWFMultiname;
	import decompiler.tags.doabc.metadata.ABCMetadata;
	import decompiler.tags.doabc.method.MethodInfo;
	import decompiler.tags.doabc.methodBody.ExceptionInfo;
	import decompiler.tags.doabc.methodBody.MethodBody;
	import decompiler.tags.doabc.script.ScriptInfo;
	import decompiler.utils.SWFUtil;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	/**
	 *abcFile
			{
				u16 minor_version
				u16 major_version
				cpool_info constant_pool
				u30 method_count
				method_info method[method_count]
				u30 metadata_count
				metadata_info metadata[metadata_count]
				u30 class_count
				instance_info instance[class_count]
				class_info class[class_count]
				u30 script_count
				script_info script[script_count]
				u30 method_body_count
				method_body_info method_body[method_body_count]
			} 
	 * @author ukyohpq
	 * 
	 */
	public final class ABCFile implements ISWFElement, IByteArrayReader
	{
		/**
		 * The values of major_version and minor_version are the major 
		 * and minor version numbers of the abcFile format. 
		 * A change in the minor version number signifies a change 
		 * in the file format that is backward compatible, 
		 * in the sense that an implementation of the AVM2 
		 * can still make use of a file of an older version. 
		 * A change in the major version number denotes an incompatible 
		 * adjustment to the file format. 
		 * As of the publication of this overview, 
		 * the major version is 46 and the minor version is 16.
		 */
		public var minor_version:uint;
		public var major_version:uint;
		
		/**
		 * The constant_pool is a variable length structure composed of 
		 * integers, doubles, strings, namespaces, namespace sets, and multinames. 
		 * These constants are referenced from other parts of the abcFile structure.
		 */
		private var _cpoolInfo:Cpool_info;
		/**
		 * The value of method_count is the number of entries in the method array. 
		 * Each entry in the method array is a variable length method_info structure. 
		 * The array holds information about every method defined in this abcFile. 
		 * The code for method bodies is held separately in the method_body array (see below). ]
		 * Some entries in method may have no body—this is the case for native methods, for example.
		 */
		private var _methodInfoArr:Vector.<MethodInfo>;
		/**
		 * The value of metadata_count is the number of entries in the metadata array. 
		 * Each metadata entry is a metadata_info structure that maps a name to a set of string values.
		 */
		private var _metadataArr:Vector.<ABCMetadata>;
		/**
		 * The value of class_count is the number of entries in the instance and class arrays. 
		 * Each instance entry is a variable length instance_info structure 
		 * which specifies the characteristics of object instances created by a particular class. 
		 * Each class entry defines the characteristics of a class. 
		 * It is used in conjunction with the instance field to derive a full description of an AS Class.
		 */
		private var _classInstanceArr:Vector.<CInstance>;
		private var _classArr:Vector.<CClass>
		
		/**
		 * The value of script_count is the number of entries in the script array. 
		 * Each script entry is a script_info structure that defines the characteristics of a single script in this file. 
		 * As explained in the previous chapter, 
		 * the last entry in this array is the entry point for execution in the abcFile.
		 */
		private var _scriptArr:Vector.<ScriptInfo>;
		/**
		 * The value of method_body_count is the number of entries in the method_body array. 
		 * Each method_body entry consists of a variable length method_body_info structure 
		 * which contains the instructions for an individual method or function.
		 */
		private var _methodBodyArr:Vector.<MethodBody>;
		
		private static var _instance:ABCFile;
		public static function getInstance():ABCFile
		{
			return _instance ||= new ABCFile;
		}
		
		public function ABCFile()
		{
		}
		
		public function encode():ByteArray
		{
			return null;
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			minor_version = byte.readUnsignedShort();
			major_version = byte.readUnsignedShort();
			_cpoolInfo = new Cpool_info;
			_cpoolInfo.decodeFromBytes(byte);
			var length:int;
			//method_count
			length = SWFUtil.readU30(byte);
			trace("ABCData " + "methodInfoLength " + length);
			_methodInfoArr = new Vector.<MethodInfo>(length);
			for (var i:int = 0; i < length; ++i) 
			{
				var mi:MethodInfo = new MethodInfo;
				mi.decodeFromBytes(byte);
				_methodInfoArr[i] = mi;
			}
			
			//metadata_count
			length = SWFUtil.readU30(byte);
			trace("ABCData " + "metadataLength " + length);
			_metadataArr = new Vector.<ABCMetadata>(length);
			for (i = 0; i < length; ++i) 
			{
				var metadata:ABCMetadata = new ABCMetadata;
				metadata.decodeFromBytes(byte);
				_metadataArr[i] = metadata;
			}
			
			//class_count
			length = SWFUtil.readU30(byte);
			trace("ABCData " + "classLength " + length);
			_classInstanceArr = new Vector.<CInstance>(length);
			for (i = 0; i < length; ++i) 
			{
				var instance:CInstance = new CInstance;
				instance.decodeFromBytes(byte);
				_classInstanceArr[i] = instance;
			}
			
			_classArr = new Vector.<CClass>(length);
			for (i = 0; i < length; ++i) 
			{
				var cClass:CClass = new CClass;
				cClass.decodeFromBytes(byte);
				_classArr[i] = cClass;
			}
			
			//script_count
			length = SWFUtil.readU30(byte);
			trace("ABCData " + "scriptLength " + length);
			_scriptArr = new Vector.<ScriptInfo>(length);
			for (i = 0; i < length; ++i) 
			{
				var script:ScriptInfo = new ScriptInfo;
				script.decodeFromBytes(byte);
				_scriptArr[i] = script;
			}
			//method_body_count
			length = SWFUtil.readU30(byte);
			trace("ABCData " + "methodBodyLength " + length);
			_methodBodyArr = new Vector.<MethodBody>(length);
			for (i = 0; i < length; ++i) 
			{
				var mb:MethodBody = new MethodBody;
				mb.decodeFromBytes(byte);
				_methodBodyArr[i] = mb;
			}
			//此时该tag应该解析完成了，不应该有剩余的字节
			if(byte.bytesAvailable > 0)
				throw new Error("tag尚有多余字节");
		}
		
		public function getIntLength():int
		{
			return _cpoolInfo.getIntLength();
		}
		
		public function getIntByIndex(index:int):int
		{
			return _cpoolInfo.getIntByIndex(index);
		}
		
		public function getUintLength():int
		{
			return _cpoolInfo.getUintLength(); 
		}
		
		public function getUintByIndex(index:int):uint
		{
			return _cpoolInfo.getUintByIndex(index);
		}
		
		public function getDoubleLength():int
		{
			return _cpoolInfo.getDoubleLength();
		}
		
		public function getDoubleByIndex(index:int):Number
		{
			return _cpoolInfo.getDoubleByIndex(index);
		}
		
		public function getStringLength():int
		{
			return _cpoolInfo.getStringLength();
		}
		
		public function getStringByIndex(index:int):CString
		{
			return _cpoolInfo.getStringByIndex(index);
		}
		
		public function getStringStrFormByIndex(index:int):String
		{
			return _cpoolInfo.getStringStrFormByIndex(index);
		}
		
		public function getNamespaceLength():int
		{
			return _cpoolInfo.getNamespaceLength();
		}
		
		public function getNamespaceByIndex(index:int):CNameSpace
		{
			return _cpoolInfo.getNamespaceByIndex(index);
		}
		
		public function getNameSpaceStringFormByIndex(index:int):String
		{
			return _cpoolInfo.getNameSpaceStringFormByIndex(index);
		}
		
		public function getNsSetLength():int
		{
			return _cpoolInfo.getNsSetLength();
		}
		
		public function getNsSetByIndex(index:int):CNsSet
		{
			return _cpoolInfo.getNsSetByIndex(index);
		}
		
		public function getMultinameLength():int
		{
			return _cpoolInfo.getMultinameLength();
		}
		
		public function getMultinameByIndex(index:int):SWFMultiname
		{
			return _cpoolInfo.getMultinameByIndex(index);
		}
		
		public function getMultinameIndex(mn:SWFMultiname):int
		{
			return _cpoolInfo.getMultinameIndex(mn);
		}
		
		/**
		 * Constant 
		 * 	Kind 						Value 	Entry
		 CONSTANT_Int 				0x03 	integer
		 CONSTANT_UInt 				0x04 	uinteger
		 CONSTANT_Double 			0x06 	double
		 CONSTANT_Utf8 				0x01 	string
		 CONSTANT_True 				0x0B 	-
		 CONSTANT_False 				0x0A 	-
		 CONSTANT_Null 				0x0C 	-
		 CONSTANT_Undefined 			0x00 	-
		 CONSTANT_Namespace 			0x08 	namespace
		 CONSTANT_PackageNamespace 	0x16 	namespace
		 CONSTANT_PackageInternalNs 	0x17 	Namespace
		 CONSTANT_ProtectedNamespace 0x18 	Namespace
		 CONSTANT_ExplicitNamespace 	0x19 	Namespace
		 CONSTANT_StaticProtectedNs 	0x1A 	Namespace
		 CONSTANT_PrivateNs 0x05 namespace
		 * 通过类别和索引从常量池中检索对象
		 * @param kind	要检索的常量池的类别
		 * @param index	该对象在常量池中的索引
		 * @return 
		 * 
		 */
		public function getValueByKindAndIndex(kind:int, index:int):Object
		{
			switch(kind)
			{
				case 0x03:	return getIntByIndex(index);
				case 0x04:	return getUintByIndex(index);
				case 0x06:	return getDoubleByIndex(index);
				case 0x01:	return getStringByIndex(index);
				case 0x0B:	return true;
				case 0x0A:	return false;
				case 0x0C:	return null;
				case 0x00:	return undefined;
				case 0x08:
				case 0x16:	return getNamespaceByIndex(index);
				case 0x17:	return "internal";
				case 0x18:	return "protected";
				case 0x19:	return "ExplicitNamespace";
				case 0x1A:	return "staticprotected";
				case 0x05:	return "private";
				default:	throw new Error("未识别的常量类别:" + kind);
			}
		}
		
		public function getMethodByIndex(index:int):MethodInfo
		{
			return _methodInfoArr[index];
		}
		
		public function getMethodBodyByIndex(index:int):MethodBody
		{
			return _methodBodyArr[index];
		}
		
		public function getClassInfoByIndex(index:int):CClass
		{
			return _classArr[index];
		}
		
		public function getInstanceInfoByIndex(index:int):CInstance
		{
			return _classInstanceArr[index];
		}
		
		
	}
}