package decompiler.tags.doabc.methodBody
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	import decompiler.core.trait.TraitsInfo;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;
	
	/**
	 * The method_body_info entry holds the AVM2 instructions 
	 * that are associated with a particular method or function body. 
	 * Some of the fields in this entry declare the maximum 
	 * amount of resources the body will consume during execution. 
	 * These declarations allow the AVM2 to anticipate the requirements 
	 * of the method without analyzing the method body prior to execution. 
	 * The declarations also serve as promises about the resource 
	 * boundary within which the method has agreed to remain.
	 * There can be fewer method bodies in the method_body table than 
	 * than there are method signatures in the method table—some methods have no bodies. 
	 * Therefore the method_body contains a reference to the method it belongs to, 
	 * and other parts of the abcFile always reference the method table, not the method_body table.
	 * Any code loaded from an untrusted source will be examined 
	 * in order to verify that the code stays within the declared limits.
	 * 
	 * method_body_info
		{
			u30 method
			u30 max_stack
			u30 local_count
			u30 init_scope_depth
			u30 max_scope_depth
			u30 code_length
			u8 code[code_length]
			u30 exception_count
			exception_info exception[exception_count]
			u30 trait_count
			traits_info trait[trait_count]
		}
	 * @author ukyohpq
	 * 
	 */
	public class MethodBody implements IByteArrayReader, ISWFElement
	{
		/**
		 * The method field is an index into the method array of the abcFile; 
		 * it identifies the method signature with which this body is to be associated.
		 */
		private var _method:int;
		/**
		 * The max_stack field is maximum number of evaluation stack slots 
		 * used at any point during the execution of this body.
		 */
		private var _maxStack:uint;
		/**
		 * The local_count field is the index of the highest-numbered local register this method will use, plus one.
		 */
		private var _localCount:uint;
		/**
		 * The init_scope_depth field defines the minimum scope depth, 
		 * relative to max_scope_depth, that may be accessed within the method.
		 */
		private var _initScopeDepth:uint;
		/**
		 * The max_scope_depth field defines the maximum scope depth that may be accessed within the method.
		 * The difference between max_scope_depth and init_scope_depth determines the size of the local scope stack.
		 */
		private var _maxScopeDepth:uint;
		/**
		 * The value of code_length is the number of bytes in the code array. 
		 * The code array holds AVM2 instructions for this method body. 
		 * The AVM2 instruction set is defined in Section 2.5.
		 */
		private var _mbp:MethodBodyPCode;
		/**
		 * The value of exception_count is the number of elements in the exception array. 
		 * The exception array associates exception handlers with ranges of instructions within the code array (see below).
		 */
		private var _exceptionArray:Vector.<ExceptionInfo>;
		/**
		 * The value of trait_count is the number of elements in the trait array. 
		 * The trait array contains all the traits for this method body (see above for more information on traits).
		 */
		private var _traitArray:Vector.<TraitsInfo>;
		public function MethodBody()
		{
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			//read method
			_method = SWFUtil.readU30(byte);
			trace("MethodBody _method:" + ABCFile.getInstance().getMethodByIndex(_method));
			//read max_stack
			_maxStack = SWFUtil.readU30(byte);
			trace("MethodBody _maxStack:" + _maxStack);
			//read local_count
			_localCount = SWFUtil.readU30(byte);
			trace("MethodBody _localCount:" + _localCount);
			//read init_scope_depth
			_initScopeDepth = SWFUtil.readU30(byte);
			trace("MethodBody _initScopeDepth:" + _initScopeDepth);
			//read max_scope_depth
			_maxScopeDepth = SWFUtil.readU30(byte);
			trace("MethodBody _maxScopeDepth:" + _maxScopeDepth);
			
			//read code_length
			var length:int = SWFUtil.readU30(byte);
			var methodBodyByte:ByteArray = new ByteArray;
			methodBodyByte.endian = Endian.LITTLE_ENDIAN;
			byte.readBytes(methodBodyByte, 0, length);
			methodBodyByte.position = 0;
			_mbp = new MethodBodyPCode(this);
			_mbp.decode(methodBodyByte);
			methodBodyByte.clear();
			trace("MethodBody code:" + _mbp);
			
			//read exception_count
			length = SWFUtil.readU30(byte);
			_exceptionArray = new Vector.<ExceptionInfo>(length);
			for (var i:int = 0; i < length; ++i) 
			{
				var ei:ExceptionInfo = new ExceptionInfo;
				ei.decodeFromBytes(byte);
				_exceptionArray[i] = ei;
			}
			
			//read trait_count
			length = SWFUtil.readU30(byte);
			_traitArray = new Vector.<TraitsInfo>(length);
			for (i = 0; i < length; ++i) 
			{
				var trait:TraitsInfo = new TraitsInfo;
				trait.decodeFromBytes(byte);
				_traitArray[i] = trait;
			}
		}
		
		public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _method);
			SWFUtil.writeU30(byte, _maxStack);
			SWFUtil.writeU30(byte, _localCount);
			SWFUtil.writeU30(byte, _initScopeDepth);
			SWFUtil.writeU30(byte, _maxScopeDepth);
			
			var tempBytes:ByteArray = _mbp.encode();
			byte.writeBytes(tempBytes);
			tempBytes.clear();
			
			var length:int = _exceptionArray.length;
			SWFUtil.writeU30(byte, length);
			for (var i:int = 0; i < length; ++i) 
			{
				var tempByte:ByteArray = _exceptionArray[i].encode();
				byte.writeBytes(tempByte);
				tempByte.clear();
			}
			
			length = _traitArray.length;
			SWFUtil.writeU30(byte, length);
			for (i = 0; i < length; ++i) 
			{
				tempByte = _traitArray[i].encode();
				byte.writeBytes(tempByte);
				tempByte.clear();
			}
			
			return byte;
		}
		
		public function getExceptionInfoByIndex(index:int):ExceptionInfo
		{
			if(_exceptionArray)
			{
				return _exceptionArray[index];
			}else{
				return null;
			}
		}
	}
}