package decompiler.tags.doabc.classAndInstances
{
	import decompiler.tags.doabc.ABCFileElement;
	import decompiler.tags.doabc.trait.TraitsInfo;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * instance_info
		{
			u30 name
			u30 super_name
			u8 flags
			u30 protectedNs
			u30 intrf_count
			u30 interface[intrf_count]
			u30 iinit
			u30 trait_count
			traits_info trait[trait_count]
		}
	 * @author ukyohpq
	 * 
	 */
	public class InstanceInfo extends ABCFileElement
	{
		private var _name:int;

		/**
		 *The name field is an index into the multiname array of the constant pool; it provides a name for the
class. The entry specified must be a QName. 
		 * @return 
		 * 
		 */
		public function get name():int
		{
			return _name;
		}

		public function set name(value:int):void
		{
			modify();
			_name = value;
		}

		private var _superName:int;

		/**
		 *The super_name field is an index into the multiname array of the constant pool; it provides the name of
the base class of this class, if any. A value of zero indicates that this class has no base class. 
		 * @return 
		 * 
		 */
		public function get superName():int
		{
			return _superName;
		}

		public function set superName(value:int):void
		{
			modify();
			_superName = value;
		}

		
		/**
		 * flags structure
			Name 						Value 	Meaning
			CONSTANT_ClassSealed 		0x01 	The class is sealed: properties can not be dynamically added
												to instances of the class.
			CONSTANT_ClassFinal 		0x02 	The class is final: it cannot be a base class for any other
												class.
			CONSTANT_ClassInterface 	0x04 	The class is an interface.
			CONSTANT_ClassProtectedNs 	0x08 	The class uses its protected namespace and the
												protectedNs field is present in the interface_info
												structure.
		*/
		private var _isSealed:int;

		/**
		 * flag
		 * CONSTANT_ClassSealed
		 */
		public function get isSealed():int
		{
			return _isSealed;
		}

		/**
		 * @private
		 */
		public function set isSealed(value:int):void
		{
			modify();
			_isSealed = value;
		}

		private var _isFinal:int;

		/**
		 * flag
		 * CONSTANT_ClassFinal
		 */
		public function get isFinal():int
		{
			return _isFinal;
		}

		/**
		 * @private
		 */
		public function set isFinal(value:int):void
		{
			modify();
			_isFinal = value;
		}

		private var _isInterface:int;

		/**
		 * flag
		 * CONSTANT_ClassInterface
		 */
		public function get isInterface():int
		{
			return _isInterface;
		}

		/**
		 * @private
		 */
		public function set isInterface(value:int):void
		{
			modify();
			_isInterface = value;
		}

		private var _isProtectedNs:int;

		/**
		 * flag
		 * CONSTANT_ClassProtectedNs
		 */
		public function get isProtectedNs():int
		{
			return _isProtectedNs;
		}

		/**
		 * @private
		 */
		public function set isProtectedNs(value:int):void
		{
			modify();
			_isProtectedNs = value;
		}

		private var _protectedNs:uint;

		/**
		 * This field is present only if the CONSTANT_ProtectedNs bit of flags is set. It is an index into the
namespace array of the constant pool and identifies the namespace that serves as the protected namespace
for this class.
		 * @return 
		 * 
		 */
		public function get protectedNs():uint
		{
			return _protectedNs;
		}

		public function set protectedNs(value:uint):void
		{
			modify();
			_protectedNs = value;
		}

		/**
		 *The value of the intrf_count field is the number of entries in the interface array. The interface array
contains indices into the multiname array of the constant pool; the referenced names specify the interfaces
implemented by this class. None of the indices may be zero. 
		 */
		private var _interfaceVec:Vector.<int>;
		
		private var _iinit:uint;

		/**
		 * This is an index into the method array of the abcFile; it references the method that is invoked whenever
an object of this class is constructed. This method is sometimes referred to as an instance initializer.
		 * @return 
		 * 
		 */
		public function get iinit():uint
		{
			return _iinit;
		}

		public function set iinit(value:uint):void
		{
			modify();
			_iinit = value;
		}

		private var _traitsArray:Vector.<TraitsInfo>;

		public function get traitsArray():Vector.<TraitsInfo>
		{
			return _traitsArray;
		}
		
		public function InstanceInfo(name:int = 0, super_name:int = 0)
		{
			_name = name;
			_superName = super_name;
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			//name
			SWFUtil.writeU30(byte, _name);
			
			//super_name
			SWFUtil.writeU30(byte, _superName);
			
			//flag
			var flag:int = _isSealed | (_isFinal << 1) | (_isInterface << 2) | (_isProtectedNs << 3);
			byte.writeByte(flag);
			
			//protectedNs
			if(_isProtectedNs)
			{
				SWFUtil.writeU30(byte, _protectedNs);
			}
			
			//interface
			var iLength:int = _interfaceVec.length;
			SWFUtil.writeU30(byte, iLength);
			for (var i:int = 0; i < iLength; ++i) 
			{
				SWFUtil.writeU30(byte, _interfaceVec[i]);
			}
			
			//iinit
			SWFUtil.writeU30(byte, _iinit);
			
			//trait
			var tLength:int = _traitsArray.length;
			SWFUtil.writeU30(byte, tLength);
			for (i = 0; i < tLength; ++i) 
			{
				var tempByte:ByteArray = _traitsArray[i].encode();
				byte.writeBytes(tempByte);
				tempByte.clear();
			}
			
			return byte;
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_name = SWFUtil.readU30(byte);
//			trace("CInstance name:" + $abcFile.getMultinameByIndex(_name));
			_superName = SWFUtil.readU30(byte);
//			trace("CInstance superName:" + $abcFile.getMultinameByIndex(_superName));
			
			//flags结构见上面
			var flags:int = byte.readUnsignedByte();
			_isSealed = flags & 1;
			_isFinal = (flags >> 1) & 1;
			_isInterface = (flags >> 2) & 1;
			_isProtectedNs = (flags >> 3) & 1;
			
			if(_isProtectedNs)
			{
				_protectedNs = SWFUtil.readU30(byte);
			}
			
			var numInterface:int = SWFUtil.readU30(byte);
//			trace("CInstance numInterface:" + numInterface);
			_interfaceVec = new Vector.<int>(numInterface);
			for (var i:int = 0; i < numInterface; ++i) 
			{
				_interfaceVec[i] = SWFUtil.readU30(byte);
			}
			
			_iinit = SWFUtil.readU30(byte);
			
			var numTraitsInfo:int = SWFUtil.readU30(byte);
//			trace("CInstance numTraitsInfo:" + numTraitsInfo);
			_traitsArray = new Vector.<TraitsInfo>(numTraitsInfo);
			for (i = 0; i < numTraitsInfo; ++i) 
			{
				var traitsInfo:TraitsInfo = $abcFile.elementFactory(TraitsInfo) as TraitsInfo;
				traitsInfo.decodeFromBytes(byte);
				_traitsArray[i] = traitsInfo;
			}
		}
		
		override public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "InstanceInfo";
			var xml:SWFXML = new SWFXML("InstanceInfo");
			xml.setAttribute("name", "mn(" + _name + ")");
			xml.setAttribute("superName", "mn(" + _superName + ")");
			xml.setAttribute("isSealed", Boolean(_isSealed));
			xml.setAttribute("isFinal", Boolean(_isFinal));
			xml.setAttribute("isInterface", Boolean(_isInterface));
			xml.setAttribute("isProtectedNs", Boolean(_isProtectedNs));
			if(_isProtectedNs)
			{
				var pns:SWFXML = new SWFXML("protectedNs");
				pns.appendChild("ns(" + _protectedNs + ")");
				xml.appendChild(pns);
			}
			var interfaces:SWFXML = new SWFXML("interfaces");
			xml.appendChild(interfaces);
			var length:int = _interfaceVec.length;
			for (var i:int = 0; i < length; ++i) 
			{
				var ifc:SWFXML = new SWFXML("interface_" + i);
				ifc.setAttribute("index", "mn(" + _interfaceVec[i] + ")");
				interfaces.appendChild(ifc);
			}
			var iinit:SWFXML = new SWFXML("iinit");
			iinit.appendChild("md(" + _iinit + ")");
			xml.appendChild(iinit);
			
			var traits:SWFXML = new SWFXML("traits");
			xml.appendChild(traits);
			length = _traitsArray.length;
			for (i = 0; i < length; ++i) 
			{
				traits.appendChild(_traitsArray[i].toXML("traitInfo_" + i));
			}
			
			return xml;
		}
		
		
		public function toString():String
		{
			return "[ InstanceInfo name:" + $abcFile.getMultinameByIndex(_name) + " ]";
		}
	}
}