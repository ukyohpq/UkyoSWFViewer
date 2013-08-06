package decompiler.tags.doabc.cpools.multinames
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import decompiler.tags.doabc.ABCFile;
	
	import decompiler.utils.SWFUtil;

	/**
	 * 	[TypeDefinition] is a U30 into the multiname table
		[ParamCount] is a U8 (U30?) of how many parameters there are
		[ParamX] is a U30 into the multiname table.
	 * 这里有一个nb的处理方式，因为这个Multiname有一个别的Multiname不具备的特点，
	 * 这个ParamX是一个multiname的索引，于是出现一个技巧，它本身是一个Multiname，
	 * 而索引指向自己，导致死循环
		
		 
		[ParamCount]不知是U8还是U30，不过既然是参数长度，按照U30处理吧...反正如果小于127个参数，U8和U30都是一个byte,
					参数长度不会那么多吧。。。
	 * @author ukyohpq
	 * 
	 */
	public class CGenericName extends SWFMultiname
	{
		private var _typeDefinition:int;
		private var _params:Vector.<uint>;
		public function CGenericName(typeDefinition:int = 0, params:Vector.<uint> = null)
		{
			super(MultinameKind.CONSTANT_GenericName);
			_typeDefinition = typeDefinition;
			_params = params;
			if(!_params)
			{
				_params = new <uint>[];
			}
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_typeDefinition = SWFUtil.readU30(byte);
			var length:int = SWFUtil.readU30(byte);
			_params.length = length;
			for (var i:int = 0; i < length; ++i) 
			{
				_params[i] = SWFUtil.readU30(byte);
			}
		}
		
		override protected function encodeData():ByteArray
		{
			var length:int = _params.length;
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			SWFUtil.writeU30(byte, _typeDefinition);
			SWFUtil.writeU30(byte, length);
			for (var i:int = 0; i < length; ++i) 
			{
				SWFUtil.writeU30(byte, _params[i]);
			}
			
			return byte;
		}
		
		override public function toString():String
		{
			var abcFile:ABCFile = ABCFile.getInstance();
			var str:String = "";
			var length:int = _params.length;
			for (var i:int = 0; i < length; ++i) 
			{
				if(abcFile.getMultinameIndex(this) == _params[i] - 1)
				{
					str += "this CGenericName's param index " + i + " is itself.";
				}else{
					str += abcFile.getMultinameByIndex(_params[i]) + " ";
				}
				
			}
			
			return "[ CGenericName multinameCount:" + length + " multinames:" + str + " ]";
		}
	}
}