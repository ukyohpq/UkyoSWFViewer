package decompiler.tags.doabc.methodBody
{
	import decompiler.tags.doabc.IReferenceable;
	import decompiler.tags.doabc.Reference;
	import decompiler.tags.doabc.ReferencedElement;
	import decompiler.tags.doabc.trait.TraitsInfo;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;

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
	public class MethodBody extends ReferencedElement implements IReferenceable
	{
		private var _method:int;

		/**
		 * The method field is an index into the method array of the abcFile; 
		 * it identifies the method signature with which this body is to be associated.
		 */
		public function get method():int
		{
			return _method;
		}

		/**
		 * @private
		 */
		public function set method(value:int):void
		{
			modify();
			$abcFile.getMethodInfoByIndex(_method).removeReference(this, "method");
			_method = value;
			$abcFile.getMethodInfoByIndex(_method).addReference(this, "method");
		}

		private var _maxStack:uint;

		/**
		 * The max_stack field is maximum number of evaluation stack slots 
		 * used at any point during the execution of this body.
		 */
		public function get maxStack():uint
		{
			return _maxStack;
		}

		/**
		 * @private
		 */
		public function set maxStack(value:uint):void
		{
			modify();
			_maxStack = value;
		}

		private var _localCount:uint;

		/**
		 * The local_count field is the index of the highest-numbered local register this method will use, plus one.
		 */
		public function get localCount():uint
		{
			return _localCount;
		}

		/**
		 * @private
		 */
		public function set localCount(value:uint):void
		{
			modify();
			_localCount = value;
		}

		private var _initScopeDepth:uint;

		/**
		 * The init_scope_depth field defines the minimum scope depth, 
		 * relative to max_scope_depth, that may be accessed within the method.
		 */
		public function get initScopeDepth():uint
		{
			return _initScopeDepth;
		}

		/**
		 * @private
		 */
		public function set initScopeDepth(value:uint):void
		{
			modify();
			_initScopeDepth = value;
		}

		private var _maxScopeDepth:uint;

		/**
		 * The max_scope_depth field defines the maximum scope depth that may be accessed within the method.
		 * The difference between max_scope_depth and init_scope_depth determines the size of the local scope stack.
		 */
		public function get maxScopeDepth():uint
		{
			return _maxScopeDepth;
		}

		/**
		 * @private
		 */
		public function set maxScopeDepth(value:uint):void
		{
			modify();
			_maxScopeDepth = value;
		}

		private var _methodBodyPCode:MethodBodyPCode;

		/**
		 * The value of code_length is the number of bytes in the code array. 
		 * The code array holds AVM2 instructions for this method body. 
		 * The AVM2 instruction set is defined in Section 2.5.
		 */
		public function get methodBodyPCode():MethodBodyPCode
		{
			return _methodBodyPCode;
		}

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
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			//read method
			_method = SWFUtil.readU30(byte);
//			trace("MethodBody _method:" + $abcFile.getMethodByIndex(_method));
			//read max_stack
			_maxStack = SWFUtil.readU30(byte);
//			trace("MethodBody _maxStack:" + _maxStack);
			//read local_count
			_localCount = SWFUtil.readU30(byte);
//			trace("MethodBody _localCount:" + _localCount);
			//read init_scope_depth
			_initScopeDepth = SWFUtil.readU30(byte);
//			trace("MethodBody _initScopeDepth:" + _initScopeDepth);
			//read max_scope_depth
			_maxScopeDepth = SWFUtil.readU30(byte);
//			trace("MethodBody _maxScopeDepth:" + _maxScopeDepth);
			
			//read code_length
			var length:int = SWFUtil.readU30(byte);
			var methodBodyByte:ByteArray = new ByteArray;
			methodBodyByte.endian = Endian.LITTLE_ENDIAN;
			byte.readBytes(methodBodyByte, 0, length);
			methodBodyByte.position = 0;
			_methodBodyPCode = $abcFile.elementFactory(MethodBodyPCode) as MethodBodyPCode;
			_methodBodyPCode.methodBody = this;
			_methodBodyPCode.decodeFromBytes(methodBodyByte);
			methodBodyByte.clear();
//			trace("MethodBody code:" + _mbp);
			
			//read exception_count
			length = SWFUtil.readU30(byte);
			_exceptionArray = new Vector.<ExceptionInfo>(length);
			for (var i:int = 0; i < length; ++i) 
			{
				var ei:ExceptionInfo = $abcFile.elementFactory(ExceptionInfo) as ExceptionInfo;
				ei.decodeFromBytes(byte);
				_exceptionArray[i] = ei;
			}
			
			//read trait_count
			length = SWFUtil.readU30(byte);
			_traitArray = new Vector.<TraitsInfo>(length);
			for (i = 0; i < length; ++i) 
			{
				var trait:TraitsInfo = $abcFile.elementFactory(TraitsInfo) as TraitsInfo;
				trait.decodeFromBytes(byte);
				_traitArray[i] = trait;
			}
			
			include "../IReferenced_Fragment_1.as";
		}
		
		override public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "methodBody";
			var xml:SWFXML = new SWFXML(name);
			xml.setAttribute("method", _method);
			xml.setAttribute("max_stack", _maxStack);
			xml.setAttribute("local_count", _localCount);
			xml.setAttribute("init_scope_depth", _initScopeDepth);
			xml.setAttribute("max_scope_depth", _maxScopeDepth);
			
			xml.appendChild(_methodBodyPCode.toXML());
			
			var length:int = _exceptionArray.length;
			var exceptions:SWFXML = new SWFXML("exceptions");
			exceptions.setAttribute("length", length);
			xml.appendChild(exceptions);
			for (var i:int = 0; i < length; ++i) 
			{
				exceptions.appendChild(_exceptionArray[i].toXML("exception_" + i));
			}
			
			length = _traitArray.length;
			var traits:SWFXML = new SWFXML("traits");
			traits.setAttribute("length", length);
			xml.appendChild(traits);
			for (i = 0; i < length; ++i) 
			{
				traits.appendChild(_traitArray[i].toXML("trait_" + i));
			}
			return xml;
		}
		
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _method);
			SWFUtil.writeU30(byte, _maxStack);
			SWFUtil.writeU30(byte, _localCount);
			SWFUtil.writeU30(byte, _initScopeDepth);
			SWFUtil.writeU30(byte, _maxScopeDepth);
			
			var tempBytes:ByteArray = _methodBodyPCode.encode();
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
		
		public function creatRefrenceRelationship():void
		{
			$abcFile.getMethodInfoByIndex(_method).addReference(this, "method");
		}
		
	}
}