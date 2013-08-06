package decompiler.tags.doabc.method
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.cpools.Cpool_info;
	
	import decompiler.utils.SWFUtil;
	
	/**
	 * The method_info entry defines the signature of a single method
	 * method_info
			{
				u30 param_count
				u30 return_type
				u30 param_type[param_count]
				u30 name
				u8 flags
				option_info options
				(
					option_info
					{
						u30 option_count
						option_detail option[option_count]
					}
				)
				param_info param_names
			}
			 
			flags:
			Name 				Value 		Meaning
	--------NEED_ARGUMENTS 		0x01 		Suggests to the run-time that an “arguments” object (as specified by the
	|										ActionScript 3.0 Language Reference) be created. Must not be used
互斥	|										together with NEED_REST. See Chapter 3.
	|		NEED_ACTIVATION 	0x02 		Must be set if this method uses the newactivation opcode.
	--------NEED_REST 			0x04 		This flag creates an ActionScript 3.0 rest arguments array. Must not be
											used with NEED_ARGUMENTS. See Chapter 3.
			HAS_OPTIONAL 		0x08 		Must be set if this method has optional parameters and the options
											field is present in this method_info structure.
			SET_DXNS 			0x40 		Must be set if this method uses the dxns or dxnslate opcodes.
			HAS_PARAM_NAMES 	0x80 		Must be set when the param_names field is present in this method_info structure.
			 
			option_info
			{
				u30 option_count
				option_detail option[option_count]
			}
	 * @author ukyohpq
	 * 
	 */
	public class MethodInfo implements IByteArrayReader, ISWFElement
	{
		/**
		 * The return_type field is an index into the multiname array of the constant pool; 
		 * the name at that entry provides the name of the return type of this method. 
		 * A zero value denotes the any (“*”) type
		 */
		private var _returnType:int;
		private var _paramTypesArr:Vector.<uint>;
		private var _needArguments:Boolean;
		private var _needActivation:Boolean;
		private var _needRest:Boolean;
		private var _hasOptional:Boolean;
		private var _setDXNS:Boolean;
		private var _hasParamNames:Boolean;
		/**
		 * The name field is an index into the string array of the constant pool; 
		 * the string at that entry provides the name of this method. 
		 * If the index is zero, this method has no name
		 */
		private var _name:uint;
		private var _optionArr:Vector.<MethodOptionDetail>;
		private var _paramNameArr:Vector.<uint>;
		public function MethodInfo(returnType:int = 0, 
								   name:int = 0,
								   needArguments:Boolean = false, 
								   needActivation:Boolean = false,
								   needRest:Boolean = false,
								   hasOptional:Boolean = false,
								   setDXNS:Boolean = false,
								   hasParamNames:Boolean = false)
		{
			_returnType = returnType;
			_name = name;
			_needArguments = needArguments;
			_needActivation = needActivation;
			_needRest = needRest;
			_hasOptional = hasOptional;
			_setDXNS = setDXNS;
			_hasParamNames = hasParamNames;
			
			_paramTypesArr = new <uint>[];
			_optionArr = new <MethodOptionDetail>[];
			_paramNameArr = new <uint>[];
		}
		
		public function decodeFromBytes(byte:ByteArray):void
		{
			/*The param_count field is the number of formal parameters that the method supports; 
			it also represents the length of the param_type array.*/
			var param_count:int = SWFUtil.readU30(byte);
			trace("MethodInfo param_count:" + param_count);
			_paramTypesArr.length = param_count;
			_paramNameArr.length = param_count;
			_returnType = SWFUtil.readU30(byte);
			trace("MethodInfo returnType:" + ABCFile.getInstance().getMultinameByIndex(_returnType));
			
			for (var i:int = 0; i < param_count; ++i) 
			{
				/*Each entry in the param_type array is an index into the multiname*/
				_paramTypesArr[i] = SWFUtil.readU30(byte);
				trace("MethodInfo paramTypeIndex:" + i + " paramType:" + ABCFile.getInstance().getMultinameByIndex(_paramTypesArr[i]));
			}
			_name = SWFUtil.readU30(byte);
			trace("MethodInfo name:" + ABCFile.getInstance().getStringByIndex(_name));
			
			var flag:int = byte.readUnsignedByte();
			trace("MethodInfo flag:" + flag);
			_needArguments = Boolean(flag & 1);
			trace("MethodInfo needArguments:" + _needArguments);
			_needActivation = Boolean((flag >> 1) & 1);
			trace("MethodInfo _needActivation:" + _needActivation);
			_needRest = Boolean((flag >> 2) & 1);
			trace("MethodInfo _needRest:" + _needRest);
			_hasOptional = Boolean((flag >> 3) & 1);
			trace("MethodInfo _hasOptional:" + _hasOptional);
			_setDXNS = Boolean((flag >> 6) & 1);
			trace("MethodInfo _setDXNS:" + _setDXNS);
			_hasParamNames = Boolean((flag >> 7) & 1);
			trace("MethodInfo _hasParamNames:" + _hasParamNames);
			
			//检测_needArguments 和  _needRest的互斥关系
			if(_needArguments && _needRest) throw new Error("NEED_ARGUMENTS 和 NEED_RESET 应该是互斥的");
			
			if(_hasOptional)
			{
				//option_count
				var option_count:int = SWFUtil.readU30(byte);
				_optionArr.length = option_count;
				for (i = 0; i < option_count; ++i) 
				{
					var optionDetail:MethodOptionDetail = new MethodOptionDetail;
					optionDetail.decodeFromBytes(byte);
					_optionArr[i] = optionDetail;
				}
			}
			
			if(_hasParamNames)
			{
				for (i = 0; i < param_count; ++i) 
				{
					_paramNameArr[i] = SWFUtil.readU30(byte);
				}
			}
		}
		
		public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			var paramLenght:int = _paramTypesArr.length;
			SWFUtil.writeU30(byte, paramLenght);//write param_count
			SWFUtil.writeU30(byte, _returnType);//write return_type
			//write param_type
			for (var i:int = 0; i < paramLenght; ++i) 
			{
				SWFUtil.writeU30(byte, _paramTypesArr[i]);
			}
			SWFUtil.writeU30(byte, _name);// write name
			var flag:int = 0;
			if(_needArguments) 				flag |= 0x01;
			if(_needActivation) 			flag |= 0x02;
			if(_needRest) 					flag |= 0x04;
			if(_optionArr.length)			flag |= 0x08;
			if(_setDXNS)					flag |= 0x40;
			if(_paramTypesArr.length)	flag |= 0x80;
			byte.writeByte(flag);
			
			//write option_info
			var length:int = _optionArr.length;
			SWFUtil.writeU30(byte, length);//write option_count
			//write option_detail
			for (i = 0; i < length; ++i) 
			{
				byte.writeBytes(_optionArr[i].encode());
			}
			
			//write paramName
			for (i = 0; i < length; ++i) 
			{
				SWFUtil.writeU30(byte, _paramNameArr[i]);
			}
			return byte;
		}
		
		public function toString():String
		{
			var abc:ABCFile = ABCFile.getInstance();
			var str:String = "[ MethodInfo name:" + ABCFile.getInstance().getStringByIndex(_name) + "parames:";
			var length:int = _paramTypesArr.length;
			for (var i:int = 0; i < length; ++i) 
			{
				str += abc.getMultinameByIndex(_paramTypesArr[i]) + " ";
			}
			str += "  returnType" + abc.getMultinameByIndex(_returnType) + "]";
			return str;
		}
	}
}