package decompiler.tags.doabc.cpools
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	
	import flash.utils.ByteArray;
	
	import decompiler.tags.SWFTag;
	import decompiler.tags.doabc.cpools.multinames.SWFMultiname;
	import decompiler.tags.doabc.cpools.multinames.SWFMultinameFactory;
	
	import decompiler.utils.SWFUtil;

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
	public class Cpool_info implements ISWFElement, IByteArrayReader
	{
		/**
		 * The value of int_count is the number of entries in the integer array, plus one. 
		 * The integer array holds integer constants referenced by the bytecode. 
		 * The “0” entry of the integer array is not present in the abcFile; 
		 * it represents the zero value for the purposes of providing values for optional 
		 * parameters and field initialization.
		 */
		private var _integerArray:Vector.<int>;
		/**
		 * The value of uint_count is the number of entries in the uinteger array, plus one. 
		 * The uinteger array holds unsigned integer constants referenced by the bytecode. 
		 * The “0” entry of the uinteger array is not present in the abcFile; 
		 * it represents the zero value for the purposes of providing values for optional
		 * parameters and field initialization.
		 */
		private var _uintegerArray:Vector.<uint>;
		/**
		 * The value of double_count is the number of entries in the double array, plus one. 
		 * The double array holds IEEE double-precision floating point constants referenced by the bytecode. 
		 * The “0” entry of the double array is not present in the abcFile; 
		 * it represents the NaN (Not-a-Number) value for the purposes of providing values for optional 
		 * parameters and field initialization.
		 */
		private var _doubleArray:Vector.<Number>;
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
		
		public function Cpool_info()
		{
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			var i:int;
			var length:int;
			
			//The value of int_count is the number of entries in the integer array, plus one
			//length实际上是数组长度 + 1，所以长度要-1，但是长度为0是特殊，表示没有，不用减，所以length不可能是1
			length = SWFUtil.readU30(byte);
			if(length > 0) length--;
			trace("Cpool_info " + "integerLength " + length);
			_integerArray = new Vector.<int>(length);
			_integerArray[0] = 0;
			for (i = 0; i < length; ++i) 
			{
				_integerArray[i] = SWFUtil.readS32(byte);
				trace("Cpool_info " + "int" + (i + 1) + " " + _integerArray[i]);
			}
			
			//同上理-1
			length = SWFUtil.readU30(byte);
			if(length > 0) length--;
			trace("Cpool_info " + "uintegerLength " + length);
			_uintegerArray = new Vector.<uint>(length);
			for (i = 0; i < length; ++i) 
			{
				_uintegerArray[i] = SWFUtil.readU32(byte);
				trace("Cpool_info " + "uint" + (i + 1) + " " + _uintegerArray[i]);
			}
			
			//同上理-1
			length = SWFUtil.readU30(byte);
			if(length > 0) length--;
			trace("Cpool_info " + "doubleLength " + length);
			_doubleArray = new Vector.<Number>(length);
			for (i = 0; i < length; ++i) 
			{
				_doubleArray[i] = SWFUtil.readD64(byte);
				trace("Cpool_info " + "double index " + (i + 1) + " " + _doubleArray[i]);
			}
			
			//同上理-1
			length = SWFUtil.readU30(byte);
			if(length > 0) length--;
			trace("Cpool_info " + "stringLength " + length);
			_stringArr = new Vector.<CString>(length);
			for (i = 0; i < length; ++i) 
			{
				var si:CString = new CString;
				si.decodeFromBytes(byte);
				_stringArr[i] = si;
				trace("Cpool_info " + "string index " + (i + 1) + " " + si);
			}
			
			//同上理-1
			length = SWFUtil.readU30(byte);
			if(length > 0) length--;
			trace("Cpool_info " + "namespaceLength " + length);
			_namespaceArr = new Vector.<CNameSpace>(length);
			for (i = 0; i < length; ++i) 
			{
				var ns:CNameSpace = new CNameSpace;
				ns.decodeFromBytes(byte);
				_namespaceArr[i] = ns;
				trace("Cpool_info " + "namespace index " + (i + 1) + " " + getNamespaceByIndex(i + 1) + " " + getNameSpaceStringFormByIndex(i + 1));
			}
			
			//同上理-1
			length = SWFUtil.readU30(byte);
			if(length > 0) length--;
			trace("Cpool_info " + "nsSetLength " + length);
			_nsSetArr = new Vector.<CNsSet>(length);
			for (i = 0; i < length; ++i) 
			{
				var nsi:CNsSet = new CNsSet;
				nsi.decodeFromBytes(byte);
				_nsSetArr[i] = nsi;
				trace("Cpool_info " + "nsSet index " + (i + 1) + " " + nsi);
			}
			
			//同上理-1
			length = SWFUtil.readU30(byte);
			if(length > 0) length--;
			trace("Cpool_info " + "multinameLength " + length);
			_multinameArr = new Vector.<SWFMultiname>(length);
			for (i = 0; i < length; ++i) 
			{
				var mn:SWFMultiname = SWFMultinameFactory.factory(SWFUtil.readU30(byte));
				mn.decodeFromBytes(byte);
				_multinameArr[i] = mn;
				trace("Cpool_info " + "multiname index " + (i + 1) + " " + mn);
			}
		}
		
		public function encode():ByteArray
		{
			return null;
		}
		
		public function getIntLength():int
		{
			return _integerArray.length;
		}
		
		public function getIntByIndex(index:int):int
		{
			if(index == 0)
			{
				return 0;
			}else{
				return _integerArray[index - 1];
			}
		}
		
		public function getUintLength():int
		{
			return _uintegerArray.length; 
		}
		
		public function getUintByIndex(index:int):uint
		{
			if(index == 0)
			{
				return 0;
			}else{
				return _uintegerArray[index - 1];
			}
		}
		
		public function getDoubleLength():int
		{
			return _doubleArray.length;
		}
		
		public function getDoubleByIndex(index:int):Number
		{
			if(index == 0)
			{
				return NaN;
			}else{
				return _doubleArray[index - 1];
			}
		}
		
		public function getStringLength():int
		{
			return _stringArr.length;
		}
		
		public function getStringByIndex(index:int):CString
		{
			if(index == 0)
			{
				return new CString("*");
			}else{
				return _stringArr[index - 1];
			}
		}
		
		public function getStringStrFormByIndex(index:int):String
		{
			if(index == 0)
			{
				return "*";
			}else{
				return _stringArr[index - 1].str;
			}
		}
		
		public function getNamespaceLength():int
		{
			return _namespaceArr.length;
		}
		
		public function getNamespaceByIndex(index:int):CNameSpace
		{
			if(index == 0)
			{
				return new CNameSpace();
			}else{
				return _namespaceArr[index - 1];
			}
		}
		
		public function getNameSpaceStringFormByIndex(index:int):String
		{
			if(index == 0)
			{
				return "*";
			}else{
				return getStringStrFormByIndex(_namespaceArr[index - 1].name);
			}
		}
		
		public function getNsSetLength():int
		{
			return _nsSetArr.length;
		}
		
		public function getNsSetByIndex(index:int):CNsSet
		{
			if(index == 0)
			{
				return new CNsSet();
			}else{
				return _nsSetArr[index - 1];
			}
		}
		
		public function getMultinameLength():int
		{
			return _multinameArr.length;
		}
		
		public function getMultinameByIndex(index:int):SWFMultiname
		{
			if(index == 0)
			{
				return new SWFMultiname();
			}else{
				return _multinameArr[index - 1];
			}
		}
		
		public function getMultinameIndex(mn:SWFMultiname):int
		{
			return _multinameArr.indexOf(mn);
		}
	}
}