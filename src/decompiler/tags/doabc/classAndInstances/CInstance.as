package decompiler.tags.doabc.classAndInstances
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.tags.doabc.ABCFile;
	import decompiler.core.trait.TraitsInfo;
	
	import decompiler.utils.SWFUtil;
	
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
	public class CInstance implements ISWFElement, IByteArrayReader
	{
		private var _name:int;
		private var _superName:int;
		
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
		/**
		 * flag
		 * CONSTANT_ClassSealed
		 */
		private var _isSealed:int;
		/**
		 * flag
		 * CONSTANT_ClassFinal
		 */
		private var _isFinal:int;
		/**
		 * flag
		 * CONSTANT_ClassInterface
		 */
		private var _isInterface:int;
		/**
		 * flag
		 * CONSTANT_ClassProtectedNs
		 */
		private var _isProtectedNs:int;
		private var _protectedNs:uint;
		private var _interfaceVec:Vector.<int>;
		private var _iinit:uint;
		private var _traitsArray:Vector.<TraitsInfo>;
		
		public function CInstance(name:int = 0, super_name:int = 0)
		{
			_name = name;
			_superName = super_name;
		}
		
		public function encode():ByteArray
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
			for (var j:int = 0; j < tLength; ++j) 
			{
				var tempByte:ByteArray = _traitsArray[i].encode();
				byte.writeBytes(tempByte);
				tempByte.clear();
			}
			
			return byte;
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			_name = SWFUtil.readU30(byte);
			trace("CInstance name:" + ABCFile.getInstance().getMultinameByIndex(_name));
			_superName = SWFUtil.readU30(byte);
			trace("CInstance name:" + ABCFile.getInstance().getMultinameByIndex(_superName));
			
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
			trace("CInstance numInterface:" + numInterface);
			_interfaceVec = new Vector.<int>(numInterface);
			for (var i:int = 0; i < numInterface; ++i) 
			{
				_interfaceVec[i] = SWFUtil.readU30(byte);
			}
			
			_iinit = SWFUtil.readU30(byte);
			
			var numTraitsInfo:int = SWFUtil.readU30(byte);
			trace("CInstance numTraitsInfo:" + numTraitsInfo);
			_traitsArray = new Vector.<TraitsInfo>(numTraitsInfo);
			for (i = 0; i < numTraitsInfo; ++i) 
			{
				var traitsInfo:TraitsInfo = new TraitsInfo;
				traitsInfo.decodeFromBytes(byte);
				_traitsArray[i] = traitsInfo;
			}
		}
		
		public function toString():String
		{
			return "[ CInstance name:" + ABCFile.getInstance().getMultinameByIndex(_name) + " ]";
		}
	}
}