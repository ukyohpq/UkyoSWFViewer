package decompiler.tags.doabc
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ICanModify;
	import decompiler.core.ISWFElement;
	import decompiler.tags.doabc.classAndInstances.ClassInfo;
	import decompiler.tags.doabc.classAndInstances.InstanceInfo;
	import decompiler.tags.doabc.cpools.CDouble;
	import decompiler.tags.doabc.cpools.CNsSet;
	import decompiler.tags.doabc.cpools.CString;
	import decompiler.tags.doabc.cpools.Cint;
	import decompiler.tags.doabc.cpools.Cpool_info;
	import decompiler.tags.doabc.cpools.Cuint;
	import decompiler.tags.doabc.cpools.multinames.CQName;
	import decompiler.tags.doabc.cpools.multinames.MultinameKind;
	import decompiler.tags.doabc.cpools.multinames.SWFMultiname;
	import decompiler.tags.doabc.cpools.namespaces.CNameSpace;
	import decompiler.tags.doabc.cpools.namespaces.NameSpaceKind;
	import decompiler.tags.doabc.events.ABCFileEvent;
	import decompiler.tags.doabc.metadata.ABCMetadata;
	import decompiler.tags.doabc.method.MethodInfo;
	import decompiler.tags.doabc.methodBody.MethodBody;
	import decompiler.tags.doabc.reference.IReferenceable;
	import decompiler.tags.doabc.reference.IReferenced;
	import decompiler.tags.doabc.reference.ReferencedElement;
	import decompiler.tags.doabc.script.ScriptInfo;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.getQualifiedClassName;

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
	[Event(name="parseComplete", type="decompiler.tags.doabc.events.ABCFileEvent")]
	public final class ABCFile extends EventDispatcher implements ISWFElement, IByteArrayReader, ICanModify
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
		private var minor_version:uint;
		private var major_version:uint;
		
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
		 * The code for method bodies is held separately in the method_body array (see below). 
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
		private var _instanceInfoArr:Vector.<InstanceInfo>;
		private var _classInfoArr:Vector.<ClassInfo>;
		
		/**
		 * The value of script_count is the number of entries in the script array. 
		 * Each script entry is a script_info structure that defines the characteristics of a single script in this file. 
		 * As explained in the previous chapter, 
		 * the last entry in this array is the entry point for execution in the abcFile.
		 */
		private var _scriptInfoArr:Vector.<ScriptInfo>;
		/**
		 * The value of method_body_count is the number of entries in the method_body array. 
		 * Each method_body entry consists of a variable length method_body_info structure 
		 * which contains the instructions for an individual method or function.
		 */
		private var _methodBodyArr:Vector.<MethodBody>;
		private var _isModified:Boolean;

		public function set isModified(value:Boolean):void
		{
			_isModified = value;
		}

		public function get isModified():Boolean
		{
			return _isModified;
		}
		
		public function ABCFile()
		{
		}
		
		public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			byte.writeShort(minor_version);
			byte.writeShort(major_version);
			byte.writeBytes(_cpoolInfo.encode());
			writeVec(byte, _methodInfoArr);
			writeVec(byte, _metadataArr);
			writeVec(byte, _instanceInfoArr);
//			u30 class_count
//			instance_info instance[class_count]
//			class_info class[class_count]
//			_classInfoArr和_instanceInfoArr长度一致，而只用写入一次长度
			writeVec(byte, _classInfoArr, false);
			writeVec(byte, _scriptInfoArr);
			writeVec(byte, _methodBodyArr);
			return byte;
		}
		
		/**
		 * 添加常量
		 * @param type
		 * @param params
		 * 
		 */
		public function addConstant(type:int, params:Array):void
		{
			_cpoolInfo.addConstant(type, params);
		}
		
		/**
		 * 
		 * 创建一个 Private命名空间，添加在ns数组末尾
		 */
		public function creatPrivateNS():void
		{
			_cpoolInfo.addConstant(Cpool_info.CPOOL_TYPE_NS, [NameSpaceKind.CONSTANT_PrivateNs, 0]);
		}
		
		/**
		 * 创建一个方法
		 * 自己创建方法，形式会比较简单，可选参数，参数name，rest, arguments,setDXNS什么的，统统不要
		 * @param returnType	方法的返回类型，如果是"xxx.xxx::xxxx"的形式，
		 * 						那么xxx.xxx将是包名,xxxx是类名，如果是"xxxx"的形式，那么就没有包，只有类名是xxxx
		 * @param params		参数类型，由和返回类型一致的字符串构成的数组
		 * @param needActivation
		 * 
		 */
		public function creatFunction(returnType:*, codeString:String, params:Array = null, needActivation:Boolean = false):int
		{
			var mi:MethodInfo = elementFactory(MethodInfo) as MethodInfo;
			if(returnType is Class)
			{
				mi.setProperty("returnType", getMNInstanceByString(getQualifiedClassName(returnType)));
			}else{
				mi.setProperty("returnType", getMNInstanceByString(returnType.toString()));
			}
			
			mi.setProperty("needActivation", needActivation);
			if(params)
			{
				var length:int = params.length;
				for (var i:int = 0; i < length; ++i) 
				{
					var param:Object = params[i];
					
					if(param is Class)
					{
						mi.setParamTypeAt(getMNInstanceByString(getQualifiedClassName(param)), i);
					}else{
						mi.setParamTypeAt(getMNInstanceByString(param.toString()), i);
					}
				}
			}
			var miIndex:int = _methodInfoArr.push(mi) - 1;
			
			var md:MethodBody = elementFactory(MethodBody) as MethodBody;
			md.method = miIndex;
			md.compile(codeString);
			_methodBodyArr.push(md);
			return miIndex;
		}
		
		/**
		 * 获取符合指定字符串(字符串的格式必须有"::")的类的mn index，如果没有，则创建
		 * @param typeString
		 * @return 
		 * 
		 */
		public function getMNInstanceByString(typeString:String, autoCreat:Boolean = true):int
		{
			var packageName:String;
			var name:String;
			if(typeString.indexOf("::") == -1)
			{
				packageName = "";
				name = typeString;
			}else{
				var arr:Array = typeString.split("::");
				packageName = arr[0];
				name = arr[1];
			}
			
			var packageIndex:int = get1stPackageIndex(packageName, false);
			var nameIndex:int = get1stStringIndex(name, false);
			//如果找不到这个包，或者找不到这个名，就需要创建新的mn
			if(packageIndex == -1 || nameIndex == -1)
			{
				if(!autoCreat)
					return -1;
				//如果找不到包，创建包
				if(packageIndex == -1)
				{
					//添加一个包
					//如果连包的字符串都找不到，那么新建一个字符串
					addConstant(Cpool_info.CPOOL_TYPE_NS, [NameSpaceKind.CONSTANT_PackageNamespace, get1stStringIndex(packageName)]);
					packageIndex = getNamespaceLength() - 1;
				}
				
				//如果找不到名，创建名
				if(nameIndex == -1){
					addConstant(Cpool_info.CPOOL_TYPE_STR, [name]);
					nameIndex = getStringLength() - 1;
				}
				
				addConstant(Cpool_info.CPOOL_TYPE_MN, [MultinameKind.CONSTANT_QName, packageIndex, nameIndex]);
				return getMultinameLength() - 1;
			}else{
				return get1stMultinameIndex(packageIndex, nameIndex);
			}
		}
		
		/**
		 * 找满足指定索引的第一个mn索引，如果没有mn的索引满足条件，则根据autoCreat的设置来选择是否创建新的mn
		 * @param packageIndex
		 * @param nameIndex
		 * @param autoCreat
		 * @return 
		 * 
		 */
		private function get1stMultinameIndex(packageIndex:int, nameIndex:int, autoCreat:Boolean = true):int
		{
			var arr:Vector.<SWFMultiname> = getMultinames();
			var length:int = arr.length;
			for (var i:int = 0; i < length; ++i) 
			{
				var mn:CQName = arr[i] as CQName;
				if(!mn)
					continue;
				if(mn.ns == packageIndex && mn.name == nameIndex)
					return i;
			}
			
			if(autoCreat)
			{
				addConstant(Cpool_info.CPOOL_TYPE_MN, [MultinameKind.CONSTANT_QName, getMultinames,  nameIndex]);
				return getMultinameLength() - 1;
			}else{
				return  -1;
			}
		}
		
		/**
		 * 找满足指定字符串的第一个包(包是mn的一种)索引，如果没有包的索引满足条件，则根据autoCreat的设置来选择是否创建新的包
		 * @param nsStr
		 * @param autoCreat
		 * @return 
		 * 
		 */
		public function get1stPackageIndex(nsStr:String, autoCreat:Boolean = true):int
		{
			var arr:Vector.<CNameSpace> = getNamespaces();
			var length:int = arr.length;
			for (var i:int = 0; i < length; ++i) 
			{
				var pk:CNameSpace = arr[i];
				if(pk.kind == NameSpaceKind.CONSTANT_PackageNamespace && getStringByIndex(pk.name).str == nsStr)
				{
					return i;
				}
			}
			
			if(autoCreat)
			{
				var strIndex:int = get1stStringIndex(nsStr);
				addConstant(Cpool_info.CPOOL_TYPE_NS, [NameSpaceKind.CONSTANT_PackageNamespace, strIndex]);
				return getNamespaceLength() - 1;
			}else{
				return -1;
			}
		}
		
		/**
		 * 获取第一个PrivateNS(ns的一种)的索引
		 * @param autoCreat	在没有的情况下，是否自动创建一个
		 * @return 如果没有，且不自动创建，返回-1
		 * 
		 */
		public function get1stPrivateNSIndex(autoCreat:Boolean = true):int
		{
			var namespaces:Vector.<CNameSpace> = getNamespaces();
			var length:int = namespaces.length;
			for (var i:int = 0; i < length; ++i) 
			{
				if(namespaces[i].kind == NameSpaceKind.CONSTANT_PrivateNs)
				{
					return i;
				}
			}
			if(autoCreat)
			{
				creatPrivateNS();
				return length;
			}else{
				return -1;
			}
		}
		
		/**
		 * 获取public命名空间，public和private不一样，private可能有0个或者多个，而public有且仅有一个.
		 * 一般情况是1，目前没发现特殊情况，但是搜索一下保险
		 * @return 
		 * 
		 */
		public function getPublicNSIndex():int
		{
			var namespaces:Vector.<CNameSpace> = getNamespaces();
			var length:int = namespaces.length;
			for (var i:int = 0; i < length; ++i) 
			{
				if(namespaces[i].kind == NameSpaceKind.CONSTANT_PackageNamespace && namespaces[i].name == get1stStringIndex(""))
				{
					return i;
				}
			}
			throw new Error("找不到public命名空间。");
		}
		
		/**
		 * 在字符串常量池中找到第一个指定名称的常量
		 * @param nameStr	要查找的字符串
		 * @param autoCreat	在没有找到的情况下，是否自动创建， 如果是，则会在没有找到时，自动创建一个，并返回创建的条目的索引
		 * 					如果否，在没有找到时，返回-1。默认是
		 * @return 
		 * 
		 */
		public function get1stStringIndex(nameStr:String, autoCreat:Boolean = true):int
		{
			var arr:Vector.<CString> = getStrings();
			var length:int = arr.length;
			for (var i:int = 0; i < length; ++i) 
			{
				if(arr[i].str == nameStr)
					return i;
			}
			if(autoCreat)
			{
				addConstant(Cpool_info.CPOOL_TYPE_STR, [nameStr]);
				return getStringLength() - 1;
			}else{
				return -1;
			}
		}
		
		public function removeConstanct(type:int, index:uint):ReferencedElement
		{
			return _cpoolInfo.removeConstance(type, index);
		}
		
		private function writeVec(byte:ByteArray, vec:*, needLength:Boolean = true):void
		{
			var length:int = vec.length;
			needLength && SWFUtil.writeU30(byte, length);
			for (var i:int = 0; i < length; ++i) 
			{
				byte.writeBytes(vec[i].encode());
			}
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			minor_version = byte.readUnsignedShort();
			major_version = byte.readUnsignedShort();
			_cpoolInfo = elementFactory(Cpool_info) as Cpool_info;
			_cpoolInfo.decodeFromBytes(byte);
			var length:int;
			//method_count
			length = SWFUtil.readU30(byte);
//			trace("ABCData " + "methodInfoLength " + length);
			_methodInfoArr = new Vector.<MethodInfo>(length);
			for (var i:int = 0; i < length; ++i) 
			{
				var mi:MethodInfo = elementFactory(MethodInfo) as MethodInfo;
				mi.decodeFromBytes(byte);
				_methodInfoArr[i] = mi;
			}
			
			//metadata_count
			length = SWFUtil.readU30(byte);
//			trace("ABCData " + "metadataLength " + length);
			_metadataArr = new Vector.<ABCMetadata>(length);
			for (i = 0; i < length; ++i) 
			{
				var metadata:ABCMetadata = elementFactory(ABCMetadata) as ABCMetadata;
				metadata.decodeFromBytes(byte);
				_metadataArr[i] = metadata;
			}
			
			//class_count
			length = SWFUtil.readU30(byte);
//			trace("ABCData " + "classLength " + length);
			_instanceInfoArr = new Vector.<InstanceInfo>(length);
			for (i = 0; i < length; ++i) 
			{
				var instance:InstanceInfo = elementFactory(InstanceInfo) as InstanceInfo;
				instance.decodeFromBytes(byte);
				_instanceInfoArr[i] = instance;
			}
			
			_classInfoArr = new Vector.<ClassInfo>(length);
			for (i = 0; i < length; ++i) 
			{
				var cClass:ClassInfo = elementFactory(ClassInfo) as ClassInfo;
				cClass.decodeFromBytes(byte);
				_classInfoArr[i] = cClass;
			}
			
			//script_count
			length = SWFUtil.readU30(byte);
//			trace("ABCData " + "scriptLength " + length);
			_scriptInfoArr = new Vector.<ScriptInfo>(length);
			for (i = 0; i < length; ++i) 
			{
				var script:ScriptInfo = elementFactory(ScriptInfo) as ScriptInfo;
				script.decodeFromBytes(byte);
				_scriptInfoArr[i] = script;
			}
			//method_body_count
			length = SWFUtil.readU30(byte);
//			trace("ABCData " + "methodBodyLength " + length);
			_methodBodyArr = new Vector.<MethodBody>(length);
			for (i = 0; i < length; ++i) 
			{
				var mb:MethodBody = elementFactory(MethodBody) as MethodBody;
				mb.decodeFromBytes(byte);
				_methodBodyArr[i] = mb;
			}
			//此时该tag应该解析完成了，不应该有剩余的字节
			if(byte.bytesAvailable > 0)
			{
				throw new Error("tag尚有多余字节");
			}else{
				dispatchEvent(new ABCFileEvent(ABCFileEvent.PARSE_COMPLETE));
			}
		}
		
		public function getIntLength():int
		{
			return _cpoolInfo.getIntLength();
		}
		
		public function getIntByIndex(index:int):Cint
		{
			return _cpoolInfo.getIntByIndex(index);
		}
		
		public function getUintLength():int
		{
			return _cpoolInfo.getUintLength(); 
		}
		
		public function getUintByIndex(index:int):Cuint
		{
			return _cpoolInfo.getUintByIndex(index);
		}
		
		public function getDoubleLength():int
		{
			return _cpoolInfo.getDoubleLength();
		}
		
		public function getDoubleByIndex(index:int):CDouble
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
		
		public function getStrings():Vector.<CString>
		{
			return _cpoolInfo.getStrings();
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
		
		public function getMultinames():Vector.<SWFMultiname>
		{
			return _cpoolInfo.getMultinames();
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
		
		public function addReferenceByKindAndIndex(kind:int, index:int, referencObject:IReferenceable):void
		{
			IReferenced(getValueByKindAndIndex(kind, index)).addReference(referencObject, "kind");
		}
		
		public function removeReferenceByKindAndIndex(kind:int, index:int, referencObject:IReferenceable):void
		{
			IReferenced(getValueByKindAndIndex(kind, index)).removeReference(referencObject, "kind");
		}
		
		public function getMethodInfoByIndex(index:int):MethodInfo
		{
			return _methodInfoArr[index];
		}
		
		public function getMethodInfos():Vector.<MethodInfo>
		{
			return _methodInfoArr.slice();
		}
		
		public function getMethodBodyByIndex(index:int):MethodBody
		{
			return _methodBodyArr[index];
		}
		
		public function getClassInfoByIndex(index:int):ClassInfo
		{
			return _classInfoArr[index];
		}
		
		public function getInstanceInfoByIndex(index:int):InstanceInfo
		{
			return _instanceInfoArr[index];
		}
		
		public function elementFactory(cls:Class):ABCFileElement
		{
			var element:ABCFileElement = new cls;
			element.setAbcFile(this);
			return element;
		}
		
		public function toXML(name:String = null):SWFXML
		{
			var xml:SWFXML = new SWFXML("abc");
			xml.setAttribute("minor_version", minor_version);
			xml.setAttribute("major_version", major_version);
			xml.appendChild(_cpoolInfo.toXML());
			var length:int = _methodInfoArr.length;
			var methodInfos:SWFXML = new SWFXML("methodInfos");
			methodInfos.setAttribute("length", length);
			xml.appendChild(methodInfos);
			for (var i:int = 0; i < length; ++i) 
			{
				methodInfos.appendChild(_methodInfoArr[i].toXML("methodInfo_" + i));
			}
			
			length = _metadataArr.length;
			var metadatas:SWFXML = new SWFXML("metadatas");
			metadatas.setAttribute("length", length);
			xml.appendChild(metadatas);
			for (i = 0; i < length; ++i) 
			{
				metadatas.appendChild(_metadataArr[i].toXML("metadata_" + i));
			}
			
			length = _classInfoArr.length;
			var instances:SWFXML = new SWFXML("instances");
			instances.setAttribute("length", length);
			xml.appendChild(instances);
			for (i = 0; i < length; ++i) 
			{
				instances.appendChild(_instanceInfoArr[i].toXML("InstanceInfo_" + i));
			}
			
			var classes:SWFXML = new SWFXML("classes");
			classes.setAttribute("length", length);
			xml.appendChild(classes);
			for (i = 0; i < length; ++i) 
			{
				classes.appendChild(_classInfoArr[i].toXML("classInfo_" + i));
			}
			
			length = _scriptInfoArr.length;
			var scripts:SWFXML = new SWFXML("scriptInfos");
			scripts.setAttribute("length", length);
			xml.appendChild(scripts);
			for (i = 0; i < length; ++i) 
			{
				scripts.appendChild(_scriptInfoArr[i].toXML("scriptInfo_" + i));
			}
			
			length = _methodBodyArr.length;
			var methodBodies:SWFXML = new SWFXML("methodBodies");
			methodBodies.setAttribute("length", length);
			xml.appendChild(methodBodies);
			for (i = 0; i < length; ++i) 
			{
				methodBodies.appendChild(_methodBodyArr[i].toXML("methodBody_" + i));
			}
			
			return xml;
		}
		
		public function getInstanceInfos():Vector.<InstanceInfo>
		{
			return _instanceInfoArr.slice();
		}
		
		public function getStringByValue(value:String):CString
		{
			return _cpoolInfo.getStringByValue(value);
		}
		
		public function getintByValue(value:int):Cint
		{
			return _cpoolInfo.getintByValue(value);
		}
		
		public function getuintByValue(value:uint):Cuint
		{
			return _cpoolInfo.getuintByValue(value);
		}
		
		public function getDoubleByValue(value:Number):CDouble
		{
			return _cpoolInfo.getDoubleByValue(value);;
		}
		
		public function getMethodBodies():Vector.<MethodBody>
		{
			return _methodBodyArr.slice();
		}
		
		public function getNamespaces():Vector.<CNameSpace>
		{
			return _cpoolInfo.getNamespaces();
		}
		
		public function getNamespcaseByValue(kind:int, name:int):CNameSpace
		{
			return getNamespcaseByValue(kind, name);
		}
		
		/**
		 * 检查指定multiname索引的instanceinfo是否存在
		 * @param MNIndex
		 * @return 
		 * 
		 */
		public function hasInstanceInABC(MNIndex:int):Boolean
		{
			var length:int = _instanceInfoArr.length;
			for (var i:int = 0; i < length; ++i) 
			{
				if(_instanceInfoArr[i].name == MNIndex)
					return true;
			}
			return false;
		}
		
		/**
		 * 获取指定multiname索引的instanceinfo
		 * @param MNIndex
		 * @return 
		 * 
		 */
		public function getInstanceInfoByMN(MNIndex:int):InstanceInfo
		{
			var length:int = _instanceInfoArr.length;
			for (var i:int = 0; i < length; ++i) 
			{
				if(_instanceInfoArr[i].name == MNIndex)
					return _instanceInfoArr[i];
			}
			return null;
		}
	}
}