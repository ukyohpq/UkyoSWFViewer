package decompiler.tags.doabc.cpools
{
	import decompiler.tags.doabc.ABCFileElement;
	import decompiler.tags.doabc.ReferencedElement;
	import decompiler.tags.doabc.cpools.multinames.CGenericName;
	import decompiler.tags.doabc.cpools.multinames.CMultiname;
	import decompiler.tags.doabc.cpools.multinames.CMultinameA;
	import decompiler.tags.doabc.cpools.multinames.CMultinameL;
	import decompiler.tags.doabc.cpools.multinames.CMultinameLA;
	import decompiler.tags.doabc.cpools.multinames.CQName;
	import decompiler.tags.doabc.cpools.multinames.CQNameA;
	import decompiler.tags.doabc.cpools.multinames.CRTQName;
	import decompiler.tags.doabc.cpools.multinames.CRTQNameA;
	import decompiler.tags.doabc.cpools.multinames.CRTQNameL;
	import decompiler.tags.doabc.cpools.multinames.CRTQNameLA;
	import decompiler.tags.doabc.cpools.multinames.MultinameKind;
	import decompiler.tags.doabc.cpools.multinames.SWFMultiname;
	import decompiler.tags.doabc.cpools.multinames.SWFMultinameFactory;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import decompiler.tags.doabc.cpools.namespaces.CNameSpace;
	import decompiler.tags.doabc.cpools.namespaces.CNameSpace_0;

	/**
	 * cpool_info
			{
				u30 int_count
				s32 integer[int_count]
				u30 uint_count
				u32 uinteger[uint_count]
				u30 double_count
				d64 double[double_count]
				u30 string_count
				string_info string[string_count]
				u30 namespace_count
				namespace_info namespace[namespace_count]
				u30 ns_set_count
				ns_set_info ns_set[ns_set_count]
				u30 multiname_count
				multiname_info multiname[multiname_count]
			}
	 * @author ukyohpq
	 * 
	 */
	public class Cpool_info extends ABCFileElement
	{
		/**
		 * The value of int_count is the number of entries in the integer array, plus one. 
		 * The integer array holds integer constants referenced by the bytecode. 
		 * The “0” entry of the integer array is not present in the abcFile; 
		 * it represents the zero value for the purposes of providing values for optional 
		 * parameters and field initialization.
		 */
		private var _integerArray:Vector.<Cint>;
		/**
		 * The value of uint_count is the number of entries in the uinteger array, plus one. 
		 * The uinteger array holds unsigned integer constants referenced by the bytecode. 
		 * The “0” entry of the uinteger array is not present in the abcFile; 
		 * it represents the zero value for the purposes of providing values for optional
		 * parameters and field initialization.
		 */
		private var _uintegerArray:Vector.<Cuint>;
		/**
		 * The value of double_count is the number of entries in the double array, plus one. 
		 * The double array holds IEEE double-precision floating point constants referenced by the bytecode. 
		 * The “0” entry of the double array is not present in the abcFile; 
		 * it represents the NaN (Not-a-Number) value for the purposes of providing values for optional 
		 * parameters and field initialization.
		 */
		private var _doubleArray:Vector.<CDouble>;
		/**
		 * The value of string_count is the number of entries in the string array, plus one. 
		 * The string array holds UTF-8 encoded strings referenced by the compiled code 
		 * and by many other parts of the abcFile.
		 * In addition to describing string constants in programs, 
		 * string data in the constant pool are used in the description of names of many kinds. 
		 * Entry “0” of the string array is not present in the abcFile; 
		 * it represents the empty string in most contexts but is also used to 
		 * represent the “any” name in others (known as “*” in ActionScript).
		 */
		private var _stringArr:Vector.<CString>;
		/**
		 * The value of namespace_count is the number of entries in the namespace array, plus one. 
		 * The namespace array describes the namespaces used by the bytecode and also for names of many kinds. 
		 * Entry “0” of the namespace array is not present in the abcFile; 
		 * it represents the “any” namespace (known as “*” in ActionScript).
		 */
		private var _namespaceArr:Vector.<CNameSpace>;
		/**
		 * The value of ns_set_count is the number of entries in the ns_set array, plus one. 
		 * The ns_set array describes namespace sets used in the descriptions of multinames. 
		 * The “0” entry of the ns_set array is not present in the abcFile.
		 */
		private var _nsSetArr:Vector.<CNsSet>;
		/**
		 * The value of multiname_count is the number of entries in the multiname array, plus one. 
		 * The multiname array describes names used by the bytecode. 
		 * The “0” entry of the multiname array is not present in the abcFile.
		 */
		private var _multinameArr:Vector.<SWFMultiname>;
		
		
		//常量池的常量类别
		public static const CPOOL_TYPE_INT:int = 0;//int
		public static const CPOOL_TYPE_UINT:int = 1;//uint
		public static const CPOOL_TYPE_DBL:int = 2;//double
		public static const CPOOL_TYPE_STR:int = 3;//string
		public static const CPOOL_TYPE_NS:int = 4;//namespace
		public static const CPOOL_TYPE_NSS:int = 5;//namespace set
		public static const CPOOL_TYPE_MN:int = 6;//multiname
		
		public function Cpool_info()
		{
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			var i:int;
			var length:int;
			
			//The value of int_count is the number of entries in the integer array, plus one
			//length实际上是数组长度 + 1，所以长度要-1，但是长度为0是特殊，表示没有，不用减，所以length不可能是1
			length = SWFUtil.readU30(byte);
//			trace("Cpool_info " + "integerLength " + length);
			_integerArray = new Vector.<Cint>(length);
			var int0:Cint = $abcFile.elementFactory(Cint) as Cint;
			_integerArray[0] = int0;
			for (i = 1; i < length; ++i) 
			{
				var cint:Cint = $abcFile.elementFactory(Cint) as Cint;
				cint.decodeFromBytes(byte);
				_integerArray[i] = cint;
//				trace("Cpool_info " + "int" + (i + 1) + " " + _integerArray[i]);
			}
			
			//同上理-1
			length = SWFUtil.readU30(byte);
//			trace("Cpool_info " + "uintegerLength " + length);
			_uintegerArray = new Vector.<Cuint>(length);
			var uint0:Cuint = $abcFile.elementFactory(Cuint) as Cuint;
			_uintegerArray[0] = uint0;
			for (i = 1; i < length; ++i) 
			{
				var cuint:Cuint = $abcFile.elementFactory(Cuint) as Cuint;
				cuint.decodeFromBytes(byte);
				_uintegerArray[i] = cuint;
//				trace("Cpool_info " + "uint" + (i + 1) + " " + _uintegerArray[i]);
			}
			
			//同上理-1
			length = SWFUtil.readU30(byte);
//			trace("Cpool_info " + "doubleLength " + length);
			_doubleArray = new Vector.<CDouble>(length);
			var double0:CDouble = $abcFile.elementFactory(CDouble) as CDouble;
			_doubleArray[0] = double0;
			for (i = 1; i < length; ++i) 
			{
				var cdouble:CDouble = $abcFile.elementFactory(CDouble) as CDouble;
				cdouble.decodeFromBytes(byte);
				_doubleArray[i] = cdouble;
//				trace("Cpool_info " + "double index " + (i + 1) + " " + _doubleArray[i]);
			}
			
			//同上理-1
			length = SWFUtil.readU30(byte);
//			trace("Cpool_info " + "stringLength " + length);
			_stringArr = new Vector.<CString>(length);
			var cString0:CString = $abcFile.elementFactory(CString_0) as CString;
			_stringArr[0] = cString0;
			for (i = 1; i < length; ++i) 
			{
				var si:CString = $abcFile.elementFactory(CString) as CString;
				si.decodeFromBytes(byte);
				_stringArr[i] = si;
//				trace("Cpool_info " + "string index " + (i + 1) + " " + si);
			}
			
			//同上理-1
			length = SWFUtil.readU30(byte);
//			trace("Cpool_info " + "namespaceLength " + length);
			_namespaceArr = new Vector.<CNameSpace>(length);
			var cNameSpace:CNameSpace = $abcFile.elementFactory(CNameSpace_0) as CNameSpace;
			_namespaceArr[0] = cNameSpace;
			for (i = 1; i < length; ++i) 
			{
				var ns:CNameSpace = $abcFile.elementFactory(CNameSpace) as CNameSpace;
				ns.decodeFromBytes(byte);
				_namespaceArr[i] = ns;
//				trace("Cpool_info " + "namespace index " + (i + 1) + " " + getNamespaceByIndex(i + 1) + " " + getNameSpaceStringFormByIndex(i + 1));
			}
			
			//同上理-1
			length = SWFUtil.readU30(byte);
//			trace("Cpool_info " + "nsSetLength " + length);
			_nsSetArr = new Vector.<CNsSet>(length);
			for (i = 1; i < length; ++i) 
			{
				var nsi:CNsSet = $abcFile.elementFactory(CNsSet) as CNsSet;
				nsi.decodeFromBytes(byte);
				_nsSetArr[i] = nsi;
//				trace("Cpool_info " + "nsSet index " + (i + 1) + " " + nsi);
			}
			
			//同上理-1
			length = SWFUtil.readU30(byte);
//			trace("Cpool_info " + "multinameLength " + length);
			_multinameArr = new Vector.<SWFMultiname>(length);
			var mu0:SWFMultiname = $abcFile.elementFactory(SWFMultiname) as SWFMultiname;
			_multinameArr[0] = mu0
			for (i = 1; i < length; ++i) 
			{
				var mn:SWFMultiname = SWFMultinameFactory.factory(SWFUtil.readU30(byte), $abcFile);
				mn.decodeFromBytes(byte);
				_multinameArr[i] = mn;
//				trace("Cpool_info " + "multiname index " + (i + 1) + " " + mn);
			}
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			var length:int = _integerArray.length;
//			如果长度为1，则是空数组，见上面注释:
//			length实际上是数组长度 + 1，所以长度要-1，但是长度为0是特殊，表示没有，不用减，所以length不可能是1
			
			writeVec(byte, _integerArray);
			writeVec(byte, _uintegerArray);
			writeVec(byte, _doubleArray);
			writeVec(byte, _stringArr);
			writeVec(byte, _namespaceArr);
			writeVec(byte, _nsSetArr);
			writeVec(byte, _multinameArr);
			
			return byte;
		}
		
		private function writeVec(byte:ByteArray,vec:*):void
		{
			var length:int = vec.length;
			if(length == 1) length = 0;
			SWFUtil.writeU30(byte, length);
			for (var i:int = 1; i < length; ++i) 
			{
				byte.writeBytes(vec[i].encode());
			}
		}
		
		public function getIntLength():int
		{
			return _integerArray.length;
		}
		
		public function getIntByIndex(index:int):Cint
		{
			return _integerArray[index];
		}
		
		public function getUintLength():int
		{
			return _uintegerArray.length; 
		}
		
		public function getUintByIndex(index:int):Cuint
		{
			return _uintegerArray[index];
		}
		
		public function getDoubleLength():int
		{
			return _doubleArray.length;
		}
		
		public function getDoubleByIndex(index:int):CDouble
		{
			return _doubleArray[index];
		}
		
		public function getStringLength():int
		{
			return _stringArr.length;
		}
		
		public function getStringByIndex(index:int):CString
		{
			return _stringArr[index];
		}
		
		public function getStringStrFormByIndex(index:int):String
		{
			return _stringArr[index].str;
		}
		
		public function getNamespaceLength():int
		{
			return _namespaceArr.length;
		}
		
		public function getNamespaceByIndex(index:int):CNameSpace
		{
			return _namespaceArr[index];
		}
		
		public function getNameSpaceStringFormByIndex(index:int):String
		{
			return getStringStrFormByIndex(_namespaceArr[index].name);
		}
		
		public function getNsSetLength():int
		{
			return _nsSetArr.length;
		}
		
		public function getNsSetByIndex(index:int):CNsSet
		{
			return _nsSetArr[index];
		}
		
		public function getMultinameLength():int
		{
			return _multinameArr.length;
		}
		
		public function getMultinameByIndex(index:int):SWFMultiname
		{
			return _multinameArr[index];
		}
		
		public function getMultinameIndex(mn:SWFMultiname):int
		{
			return _multinameArr.indexOf(mn);
		}
		
		override public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "CPool";
			var xml:SWFXML = new SWFXML(name);
			
			var length:int = _integerArray.length;
			var integers:SWFXML = new SWFXML("ints");
			integers.setAttribute("length", length);
			xml.appendChild(integers);
			var i:int;
			for(i = 0; i < length; ++i)
			{
				integers.appendChild(_integerArray[i].toXML("int_" + i));
			}
			
			length = _uintegerArray.length;
			var uintegers:SWFXML = new SWFXML("uint");
			uintegers.setAttribute("length", length);
			xml.appendChild(uintegers);
			for(i = 0; i < length; ++i)
			{
				uintegers.appendChild(_uintegerArray[i].toXML("uint_" + i));
			}
			
			length = _doubleArray.length;
			var doubles:SWFXML = new SWFXML("doubles");
			doubles.setAttribute("length", length);
			xml.appendChild(doubles);
			for(i = 0; i < length; ++i)
			{
				doubles.appendChild(_doubleArray[i].toXML("dbl_" + i));
			}
			
			length = _stringArr.length;
			var strings:SWFXML = new SWFXML("strings");
			strings.setAttribute("length", length);
			xml.appendChild(strings);
			for(i = 0; i < length; ++i)
			{
				strings.appendChild(_stringArr[i].toXML("str_" + i));
			}
			
			length = _namespaceArr.length;
			var namespaces:SWFXML = new SWFXML("namespaces");
			namespaces.setAttribute("length", length);
			xml.appendChild(namespaces);
			for(i = 0; i < length; ++i)
			{
				namespaces.appendChild(_namespaceArr[i].toXML("ns_" + i));
			}
			
			//The “0” entry of the ns_set array is not present in the abcFile.
			//条目0不存在，所以从1开始遍历,并且长度要减1
			length = _nsSetArr.length;
			var nsSets:SWFXML = new SWFXML("nsSets");
			nsSets.setAttribute("length", length);
			xml.appendChild(nsSets);
			for(i = 1; i < length; ++i)
			{
				nsSets.appendChild(_nsSetArr[i].toXML("nss_" + i));
			}
			
			//The “0” entry of the multiname array is not present in the abcFile.
			//条目0不存在，所以从1开始遍历,并且长度要减1
			length = _multinameArr.length;
			var multinames:SWFXML = new SWFXML("multinames");
			multinames.setAttribute("length", length);
			xml.appendChild(multinames);
			for(i = 1; i < length; ++i)
			{
				multinames.appendChild(_multinameArr[i].toXML("mn_" + i));
			}
			
			return xml;
		}
		
		public function addConstant(type:int, ...args):void
		{
			//先把传进来的数字进行整理，确定类别
			if(type == 0 || type == 1 || type == 2)
			{
				var num:Number = args[0];
				if(int(num) == num)//如果转型成int后，发现转和不转相等，那么它就是一个int
				{
					type = 0;
				}else if(uint(num) == num){//如果转成int后发现不相等了，但是转成uint后是相等的，那么它就是一个uint
					type = 1;
				}else{//连转成uint都不一致，那么就只能是Number了
					type = 2;
				}
			}
			//检测是否已经有此常量
			//后来想了下，其实没有必要检查是否有此常量了，重复常量无所谓，因为avm认的只是常量的index
//			if(hasConstant.apply([type].concat(args)))
//				return;
			switch(type)
			{
				case CPOOL_TYPE_INT:
					var cint:Cint = $abcFile.elementFactory(Cint) as Cint;
					cint.value = args[0];
					_integerArray.push(cint);
					break;
				case CPOOL_TYPE_UINT:
					var cuint:Cuint = $abcFile.elementFactory(Cuint) as Cuint;
					cuint.value = args[0];
					_uintegerArray.push(cuint);
					break;
				case CPOOL_TYPE_DBL:
					var cdouble:CDouble = $abcFile.elementFactory(CDouble) as CDouble;
					cdouble.value = args[0];
					_doubleArray.push(cdouble);
					break;
				case CPOOL_TYPE_STR:
					var cstr:CString = $abcFile.elementFactory(CString) as CString;
					cstr.str = args[0];
					_stringArr.push(cstr);
					break;
				case CPOOL_TYPE_NS:
					var ns:CNameSpace = $abcFile.elementFactory(CNameSpace) as CNameSpace;
					ns.kind = args[0];
					ns.name = args[1];
					_namespaceArr.push(ns);
					break;
				case CPOOL_TYPE_NSS:
					var nss:CNsSet = $abcFile.elementFactory(CNsSet) as CNsSet;
					var length:int = args.length - 2;
					for (var i:int = 0; i < length; ++i) 
					{
						nss.setValueAt(args[i + 2]);
					}
					_nsSetArr.push(nss);
				case CPOOL_TYPE_MN:
					var mn:SWFMultiname = SWFMultinameFactory.factory(args[0], $abcFile);
					switch(mn["constructor"])
					{
						case CQName:
						case CQNameA:
							mn["ns"] = args[1];
							mn["name"] = args[2];
							break;
						case CRTQName:
						case CRTQNameA:
							mn["name"] = args[1];
							break;
						case CRTQNameL:
						case CRTQNameLA:
							break;
						case CMultiname:
						case CMultinameA:
							mn["name"] = args[1];
							mn["ns_set"] = args[2];
							break;
						case CMultinameL:
						case CMultinameLA:
							mn["ns_set"] = args[1];
							break;
						case CGenericName:
							mn["typeDefinition"] = args[1];
							length = args.length - 2;
							for (var j:int = 0; j < length; ++j) 
							{
								mn["setValueAt"](args[j + 2]);
							}
							break;
					}
					_multinameArr.push(mn);
				default:
					throw new Error("错误的常量类别:" + type);
			}
			modify();
		}
		
		public function hasConstant(type:int, ...args):Boolean
		{
			switch(type)
			{
				case CPOOL_TYPE_INT:
					return _integerArray.indexOf(args[0]) != -1;
				case CPOOL_TYPE_UINT:
					return _uintegerArray.indexOf(args[0]) != -1;
				case CPOOL_TYPE_DBL:
					return _doubleArray.indexOf(args[0]) != -1;
				case CPOOL_TYPE_STR:
					return _stringArr.some(
						function(e:CString, i:int, v:*):Boolean
						{
							return e.str == args[0];
						});
				case CPOOL_TYPE_NS:
					return _namespaceArr.some(
						function(e:CNameSpace, i:int, v:*):Boolean
						{
							return e.kind == args[0] && e.name == args[1];
						});
				case CPOOL_TYPE_NSS:
					return _nsSetArr.some(
						function(e:CNsSet, i:int, v:*):Boolean
						{
							var arr:Vector.<uint> = e.nsArr;
							var length:int = arr.length;
							//nss里面是一个数组，也就是检测在所有的nss中，
							//有没有一个nss的数组和args这个数组元素一致，
							//先检测两个数组长度是否一致，不一致直接返回false
							//一致的话，再逐个元素对比，一有不一样就返回false
							//最后，没有不一样的情况下，返回true
							if(length != args.length) return false;
							for (var j:int = 0; j < length; ++j) 
							{
								if(arr[j] != args[j])
									return false;
							}
							return true;
						});
				case CPOOL_TYPE_MN:
					var mnKind:int = args[0];
					switch(mnKind)
					{
						case MultinameKind.CONSTANT_QName:
							return _multinameArr.some(
								function(e:SWFMultiname, i:int, v:*):Boolean
								{
									if(e is CQName)
									{
										return CQName(e).ns == args[1] && CQName(e).name == args[2];
									}else{
										return false;
									}
								}
							);
							break;
						case MultinameKind.CONSTANT_QNameA:
							return _multinameArr.some(
								function(e:CQNameA, i:int, v:*):Boolean
								{
									if(e is CQNameA)
									{
										return CQNameA(e).ns == args[1] && CQNameA(e).name == args[2];
									}else{
										return false;
									}
								}
							);
							break;
						case MultinameKind.CONSTANT_RTQName:
							return _multinameArr.some(
								function(e:CRTQName, i:int, v:*):Boolean
								{
									if(e is CRTQName)
									{
										return CRTQName(e).name == args[1];
									}else{
										return false;
									}
								}
							);
							break;
						case MultinameKind.CONSTANT_RTQNameA:
							return _multinameArr.some(
								function(e:CRTQNameA, i:int, v:*):Boolean
								{
									if(e is CRTQNameA)
									{
										return CRTQNameA(e).name == args[1];
									}else{
										return false;
									}
								}
							);
							break;
						case MultinameKind.CONSTANT_RTQNameL:
							return _multinameArr.some(
								function(e:CRTQNameL, i:int, v:*):Boolean
								{
									return e is CRTQNameL;
								}
							);
							break;
						case MultinameKind.CONSTANT_RTQNameLA:
							return _multinameArr.some(
								function(e:CRTQNameLA, i:int, v:*):Boolean
								{
									return e is CRTQNameLA;
								}
							);
							break;
						case MultinameKind.CONSTANT_Multiname:
							return _multinameArr.some(
								function(e:CMultiname, i:int, v:*):Boolean
								{
									if(e is CMultiname)
									{
										return CMultiname(e).ns_set == args[1] && CMultiname(e).name == args[2];
									}else{
										return false;
									}
								}
							);
							break;
						case MultinameKind.CONSTANT_MultinameA:
							return _multinameArr.some(
								function(e:CMultinameA, i:int, v:*):Boolean
								{
									if(e is CMultinameA)
									{
										return CMultinameA(e).ns_set == args[1] && CMultinameA(e).name == args[2];
									}else{
										return false;
									}
								}
							);
							break;
						case MultinameKind.CONSTANT_MultinameL:
							return _multinameArr.some(
								function(e:CMultinameL, i:int, v:*):Boolean
								{
									if(e is CMultinameL)
									{
										return CMultinameL(e).ns_set == args[1];
									}else{
										return false;
									}
								}
							);
							break;
						case MultinameKind.CONSTANT_MultinameLA:
							return _multinameArr.some(
								function(e:CMultinameLA, i:int, v:*):Boolean
								{
									if(e is CMultinameLA)
									{
										return CMultinameLA(e).ns_set == args[1];
									}else{
										return false;
									}
								}
							);
							break;
						case MultinameKind.CONSTANT_GenericName:
							return _multinameArr.some(
								function(e:CGenericName, i:int, v:*):Boolean
								{
									if(e is CGenericName)
									{
										var cg:CGenericName = e as CGenericName;
										if(cg.typeDefinition != args[1]) return false;
										var params:Vector.<uint> = cg.params;
										var length:int = params.length;
										if(length != args.length - 2) return false;
										for (var j:int = 0; j < length; ++j) 
										{
											if(params[j] != args[j + 2])
												return false;
										}
										return true;
									}else{
										return false;
									}
								}
							);
							break;
						default:
							throw new Error("错误的mn类别" + mnKind);
					}
				default:
					throw new Error("错误的常量类别:" + type);
			}
		}
		
		public function removeConstance(type:int, index:uint):ReferencedElement
		{
			if(index == 0) index = 1;
			var vec:*;
			switch(type)
			{
				case CPOOL_TYPE_INT:
					vec = _integerArray;
					break;
				case CPOOL_TYPE_UINT:
					vec = _uintegerArray;
					break;
				case CPOOL_TYPE_DBL:
					vec = _doubleArray;
					break;
				case CPOOL_TYPE_STR:
					vec = _stringArr;
					break;
				case CPOOL_TYPE_NS:
					vec = _namespaceArr;
					break;
				case CPOOL_TYPE_NSS:
					vec = _nsSetArr;
					break;
				case CPOOL_TYPE_MN:
					vec = _multinameArr;
					break;
				default:
					throw new Error("错误的常量类别:" + type);
					break;
			}
			if(index >= vec.length)
			{
				throw new Error("要删除的常量的索引越界，最大为:" + (vec.length - 1) + ", 实际为:" + index);
			}else{
				modify();
				return vec.splice(index, 1)[0];
			}
		}
		
		public function getStrings():Vector.<CString>
		{
			return _stringArr.slice();
		}
		
		public function getStringByValue(value:String):CString
		{
			var length:int = _stringArr.length;
			for (var i:int = 0; i < length; ++i) 
			{
				var cs:CString = _stringArr[i];
				if(cs.str == value)
					return cs;
			}
			
			return null;
		}
		
		public function getintByValue(value:int):Cint
		{
			var length:int = _integerArray.length;
			for (var i:int = 0; i < length; ++i) 
			{
				var ci:Cint = _integerArray[i];
				if(ci.value == value)
					return ci;
			}
			
			return null;
		}
		
		public function getuintByValue(value:uint):Cuint
		{
			var length:int = _uintegerArray.length;
			for (var i:int = 0; i < length; ++i) 
			{
				var cu:Cuint = _uintegerArray[i];
				if(cu.value == value)
					return cu;
			}
			
			return null;
		}
		
		public function getDoubleByValue(value:Number):CDouble
		{
			var length:int = _doubleArray.length;
			for (var i:int = 0; i < length; ++i) 
			{
				var cd:CDouble = _doubleArray[i];
				if(cd.value == value)
					return cd;
			}
			
			return null;
		}
		
		public function getNamespcaseByValue(kind:int, name:int):CNameSpace
		{
			var length:int = _namespaceArr.length;
			for (var i:int = 0; i < length; ++i) 
			{
				var ns:CNameSpace = _namespaceArr[i];
				if(ns.kind == kind && ns.name == name)
					return ns;
			}
			
			return null;
		}
		
		public function getNamespaces():Vector.<CNameSpace>
		{
			return _namespaceArr.slice();
		}
	}
}