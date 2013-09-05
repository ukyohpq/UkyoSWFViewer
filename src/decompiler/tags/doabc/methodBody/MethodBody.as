package decompiler.tags.doabc.methodBody
{
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.instruction.AbstractInstruction;
	import decompiler.tags.doabc.instruction.Declocal;
	import decompiler.tags.doabc.instruction.Declocal_i;
	import decompiler.tags.doabc.instruction.Getlocal;
	import decompiler.tags.doabc.instruction.Getlocal_0;
	import decompiler.tags.doabc.instruction.Getlocal_1;
	import decompiler.tags.doabc.instruction.Getlocal_2;
	import decompiler.tags.doabc.instruction.Getlocal_3;
	import decompiler.tags.doabc.instruction.InstructionFactory;
	import decompiler.tags.doabc.instruction.Lookupswitch;
	import decompiler.tags.doabc.instruction.Setlocal;
	import decompiler.tags.doabc.instruction.Setlocal_0;
	import decompiler.tags.doabc.instruction.Setlocal_1;
	import decompiler.tags.doabc.instruction.Setlocal_2;
	import decompiler.tags.doabc.instruction.Setlocal_3;
	import decompiler.tags.doabc.method.MethodInfo;
	import decompiler.tags.doabc.reference.IReferenceable;
	import decompiler.tags.doabc.reference.ReferencedElement;
	import decompiler.tags.doabc.trait.IHasTraits;
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
	public final class MethodBody extends ReferencedElement implements IReferenceable, IHasTraits
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
		
		public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			 include "../reference/IReferenceable_Fragment_1.as"
			
		}
		
		/**
		 * @private
		 */
		public function set method(value:int):void
		{
			if(_method == value)
				return;
			modify();
			try{
				$abcFile.getMethodInfoByIndex(_method).removeReference(this, "method");
			}catch(err:Error)
			{
				trace(err);
			}
			_method = value;
			setLocalByMI();
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
			if(_maxStack == value)
				return;
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
			if(_localCount == value)
				return;
			modify();
			_localCount = value;
			if(method)
				setLocalByMI();
		}

		/**
		 * 设置方法签名的时候，要看看签名使用的参数长度，因为参数也会占用本地寄存器的.
		 * local_0固定是this,如果有参数，则local_1就是参数1，local_2就是参数2...以此类推
		 * 所以，local_count至少要为方法签名的参数长度+1
		 * 
		 */
		private function setLocalByMI():void
		{
			var mi:MethodInfo = $abcFile.getMethodInfoByIndex(_method)
			var minLocalCount:int = mi.paramTypesArr.length + 1 + mi.needArguments + mi.needRest;
			if(_localCount < minLocalCount)
				_localCount = minLocalCount;
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
			if(!_methodBodyPCode)
			{
				_methodBodyPCode = $abcFile.elementFactory(MethodBodyPCode) as MethodBodyPCode;
				_methodBodyPCode.methodBody = this;
			}
			return _methodBodyPCode;
		}

		public function getPCodeLength():int
		{
			return _methodBodyPCode.pcodes.length;
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
		private var _traitsArray:Vector.<TraitsInfo>;
		public function MethodBody(abc:ABCFile = null)
		{
			if(abc)
			{
				$abcFile = abc;
				_methodBodyPCode = $abcFile.elementFactory(MethodBodyPCode) as MethodBodyPCode;
				_methodBodyPCode.methodBody = this;
			}
			_exceptionArray = new Vector.<ExceptionInfo>([]);
			_traitsArray = new Vector.<TraitsInfo>([]);
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
			
			if(!_methodBodyPCode)
			{
				_methodBodyPCode = $abcFile.elementFactory(MethodBodyPCode) as MethodBodyPCode;
				_methodBodyPCode.methodBody = this;
			}
			_methodBodyPCode.decodeFromBytes(methodBodyByte);
			methodBodyByte.clear();
//			trace("MethodBody code:" + _mbp);
			
			//read exception_count
			length = SWFUtil.readU30(byte);
			_exceptionArray.length = length;
			for (var i:int = 0; i < length; ++i) 
			{
				var ei:ExceptionInfo = $abcFile.elementFactory(ExceptionInfo) as ExceptionInfo;
				ei.decodeFromBytes(byte);
				_exceptionArray[i] = ei;
			}
			
			//read trait_count
			length = SWFUtil.readU30(byte);
			_traitsArray.length = length;
			for (i = 0; i < length; ++i) 
			{
				var trait:TraitsInfo = $abcFile.elementFactory(TraitsInfo) as TraitsInfo;
				trait.target = this;
				trait.decodeFromBytes(byte);
				_traitsArray[i] = trait;
			}
			
			include "../reference/IReferenced_Fragment_1.as";
		}
		
		public function compile(codeStr:String):void
		{
			codeStr = "getlocal_0;pushscope;" + codeStr;
			insertPCodeStrAt(codeStr, 0);
		}
		
		/**
		 * 在指定位置加入pcode代码
		 * @param codeStr
		 * @param index
		 * 
		 */
		public function insertPCodeStrAt(codeStr:String, index:int):void
		{
			codeStr.replace(/\r\n/g, "");
			codeStr.replace(/ */g, " ");
			
			var localC:int = 0;
			var curNumStack:int = 0;
			var curNumScope:int = 0;
			var maxSt:int = 0;
			var maxSc:int = 0;
			var byteLength:int = 0;
			
			var codes:Array = codeStr.split(";");
			var length:int = codes.length;
			var opcodes:Array = [];
			for (var i:int = 0; i < length; ++i) 
			{
				var statement:String = codes[i];
				if(statement == "")
					continue;
				var arr:Array = statement.split(" ");
				var opcodeName:String = arr[0];
				var opcode:AbstractInstruction = InstructionFactory.creatInstruction(InstructionFactory.getPCodeFormByStr(opcodeName), $abcFile);
				switch(opcodeName)
				{
					//lookupswitch这个opcode很特殊，是唯一的参数不定长的opcode，编码需要特殊处理
					case "Lookupswitch":
						Lookupswitch(opcode).default_offset = arr[1];
						var len:int = arr.length;
						for (var j:int = 2; j < len; ++j) 
						{
							Lookupswitch(opcode).addCaseOffset(arr[j]);
						}
						break;
					case "declocal":
					case "declocal_i":
					case "getlocal":
					case "setlocal":
						if(localC < arr[1] + 1)
							localC = arr[1] + 1;
					case "getlocal_3":
					case "setlocal_3":
						if(localC < 4)
							localC = 4;
					case "getlocal_2":
					case "setlocal_2":
						if(localC < 3)
							localC = 3;
					case "getlocal_1":
					case "setlocal_1":
						if(localC < 2)
							localC = 2;
					case "getlocal_0":
					case "setlocal_0":
						if(localC < 1)
							localC = 1;
						break;
					default:
						var params:Vector.<String> = opcode.getParamNames();
						if(params)
						{
							len = params.length;
							for (var k:int = 0; k < len; ++k) 
							{
								opcode[params[k]] = arr[1 + k];
							}
						}
						break;
				}
				curNumStack += opcode.deltaNumStack();
				curNumScope += opcode.deltaNumScope();
				if(maxSt < curNumStack)
					maxSt = curNumStack;
				if(maxSc < curNumScope)
					maxSc = curNumScope;
				opcodes.push(opcode);
				byteLength += opcode.getBytesLength();
			}
			if(curNumStack != 0)
			{
				trace("这段代码导致栈改变量为:" + curNumStack + "， 可能引起栈不对称");
			}
			
			if(curNumScope != 0)
			{
				trace("这段代码导致作用域改变量为:" + curNumStack + "， 可能引起作用域不对称");
			}
			//由于有条件分支的情况存在，我这里做的线性检查会不准确，
			//简单处理，将这段代码计算出的峰值加到原始方法上，
			//这样虽然会有多，但不会少，不管这段代码放在什么条件分支上，
			//最终的堆栈总是够用的，并且避免了所有原始pcode也进行逐个检测堆栈改变量的过程
			_maxScopeDepth += maxSc - _initScopeDepth;
			_initScopeDepth = 0;
			_maxStack += maxSt;
			//寄存器比较特殊，完全由参数决定，不需要计算每个操作码改变堆栈和作用域的值
			//因此只需要将这段代码用的寄存器和原始方法体的寄存器相比取其较大值就可以了
			_localCount = (_localCount > localC)?_localCount:localC;
			
			var byteIndex:int = methodBodyPCode.getCodeByteLengthBefore(index);
			length = _exceptionArray.length;
			for (i = 0; i < length; i++) 
			{
				_exceptionArray[i].modifyByInsertPcodes(byteLength, byteIndex);
			}
			
			methodBodyPCode.insertPCode(index, opcodes, byteLength);
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
			
			length = _traitsArray.length;
			var traits:SWFXML = new SWFXML("traits");
			traits.setAttribute("length", length);
			xml.appendChild(traits);
			for (i = 0; i < length; ++i) 
			{
				traits.appendChild(_traitsArray[i].toXML("trait_" + i));
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
			
			var tempBytes:ByteArray = methodBodyPCode.encode();
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
			
			length = _traitsArray.length;
			SWFUtil.writeU30(byte, length);
			for (i = 0; i < length; ++i) 
			{
				tempByte = _traitsArray[i].encode();
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
		
		public function addTrait(trait:TraitsInfo):void
		{
			_traitsArray.push(trait);
			modify();
		}
		
		public function addTraitAt(trait:TraitsInfo, index:int):void
		{
			_traitsArray.splice(index, 0, trait);
			modify();
		}
		
		public function getTraits():Vector.<TraitsInfo>
		{
			return _traitsArray.slice();
		}
		
		public function removeTrait(trait:TraitsInfo):void
		{
			var index:int = _traitsArray.indexOf(trait);
			if(index == -1)
				throw new Error("并没有这个trait");
			removeTraitAt(index);
			modify();
		}
		
		public function removeTraitAt(index:int):void
		{
			_traitsArray.splice(index, 1);
			modify();
		}
		
	}
}