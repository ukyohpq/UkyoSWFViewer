package decompiler.tags.doabc.cpools.multinames
{
	import decompiler.tags.doabc.reference.IReferenceableArray;
	import decompiler.tags.doabc.reference.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	/**
	 * 	[TypeDefinition] is a U30 into the multiname table
	 * 经观察，这个TypeDefinition 一定是 QName:Vector, ns:__AS3__.vec
		[ParamCount] is a U8 (U30?) of how many parameters there are
		[ParamX] is a U30 into the multiname table.
	 * 这里有一个nb的处理方式，因为这个Multiname有一个别的Multiname不具备的特点，
	 * 这个ParamX是一个multiname的索引，于是出现一个技巧，它本身是一个Multiname，
	 * 而索引指向自己，导致死循环， 也可以循环索引，1指向2,2指向3,3指向1
		
		 
		[ParamCount]不知是U8还是U30，不过既然是参数长度，按照U30处理吧...反正如果小于127个参数，U8和U30都是一个byte,
					参数长度不会那么多吧。。。
	 * @author ukyohpq
	 * 
	 */
	public class CGenericName extends SWFMultiname implements IReferenceableArray
	{
		private var _typeDefinition:int;

		public function set typeDefinition(value:int):void
		{
			modify();
			try{
				$abcFile.getMultinameByIndex(_typeDefinition).removeReference(this, "typeDefinition");
			}catch(err:Error)
			{
				trace(err);
			}
			_typeDefinition = value;
			$abcFile.getMultinameByIndex(_typeDefinition).addReference(this, "typeDefinition");
		}


		public function get typeDefinition():int
		{
			return _typeDefinition;
		}

		private var _params:Vector.<uint>;

		public function get params():Vector.<uint>
		{
			return _params.slice();
		}

		public function setValueAt(value:uint, index:uint = -1, refreshReference:Boolean = true):void
		{
			if(index < 0 || index >= _params.length)
			{
				_params.push(value);
				$abcFile.getMultinameByIndex(value).addReference(this, "params", _params.length - 1);
			}else{
				if(refreshReference)
				{
					try{
						$abcFile.getMultinameByIndex(_params[index]).removeReference(this, "params", index);
					}catch(err:Error)
					{
						trace(err);
					}
					$abcFile.getMultinameByIndex(value).addReference(this, "params", index);
				}else{
					_params[index] = value;
				}
			}
			
			modify();
		}
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
			super.decodeFromBytes(byte);
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
			var str:String = "";
			var length:int = _params.length;
			for (var i:int = 0; i < length; ++i) 
			{
				if($abcFile.getMultinameIndex(this) == _params[i] - 1)
				{
					str += "this CGenericName's param index " + i + " is itself.";
				}else{
					str += $abcFile.getMultinameByIndex(_params[i]) + " ";
				}
				
			}
			
			return "[ CGenericName multinameCount:" + length + " multinames:" + str + " ]";
		}
		
		override protected function contentToXML(xml:SWFXML):void
		{
			xml.appendChild("<typeDefinition>mn(" + _typeDefinition + ")</typeDefinition>");
//			xml.appendChild(<typeDefinition>{"mn(" + _typeDefinition + ")"}</typeDefinition>);
			var params:SWFXML = new SWFXML("params");
			xml.appendChild(params);
			var length:int = _params.length;
			for (var i:int = 0; i < length; ++i) 
			{
				params.appendChild("<param_" + i + ">" + _params[i] + "</param_" + i + ">");
			}
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getMultinameByIndex(_typeDefinition).addReference(this, "typeDefinition");
			var length:int = _params.length;
			for (var i:int = 0; i < length; ++i) 
			{
				$abcFile.getMultinameByIndex(_params[i]).addReference(this, "params", i);
			}
			
		}
		
		override public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			include "../../reference/IReferenceable_Fragment_1.as";
		}
	}
}