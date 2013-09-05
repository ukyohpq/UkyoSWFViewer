package decompiler.tags.doabc.methodBody
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	import decompiler.tags.doabc.ABCFileElement;
	import decompiler.tags.doabc.reference.IReferenceable;
	import decompiler.tags.doabc.reference.ReferencedElement;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * The exception_info entry is used to define the range of 
	 * ActionScript 3.0 instructions over which a particular exception handler is engaged.
	 * exception_info
		{
			u30 from
			u30 to
			u30 target
			u30 exc_type
			u30 var_name
		}
	 * @author ukyohpq
	 * 
	 */
	public class ExceptionInfo extends ReferencedElement implements IReferenceable
	{
		private var _from:uint;

		/**
		 * The starting position in the code field from which the exception is enabled
		 */
		public function get from():uint
		{
			return _from;
		}

		/**
		 * @private
		 */
		public function set from(value:uint):void
		{
			_from = value;
		}
		
		
		private var _to:uint;

		/**
		 * The ending position in the code field after which the exception is disabled
		 */
		public function get to():uint
		{
			return _to;
		}

		/**
		 * @private
		 */
		public function set to(value:uint):void
		{
			_to = value;
		}

		private var _target:uint;

		/**
		 * The position in the code field to which control should jump 
		 * if an exception of type exc_type is encountered while executing 
		 * instructions that lie within the region [from, to] of the code field.
		 */
		public function get target():uint
		{
			return _target;
		}

		/**
		 * @private
		 */
		public function set target(value:uint):void
		{
			_target = value;
		}

		private var _excType:uint;

		/**
		 * An index into the muti array of the constant pool that 
		 * identifies the name of the type of exception that is 
		 * to be monitored during the reign of this handler. 
		 * A value of zero means the any type (“*”) and implies 
		 * that this exception handler will catch any type of exception thrown.
		 */
		public function get excType():uint
		{
			return _excType;
		}

		/**
		 * @private
		 */
		public function set excType(value:uint):void
		{
			if(_excType != value)
			{
				try{
					$abcFile.getMultinameByIndex(_excType).removeReference(this, "excType");
				}catch(err:Error)
				{
					trace(err);
				}
				_excType = value;
				$abcFile.getMultinameByIndex(_excType).addReference(this, "excType");
			}
		}

		private var _varName:uint;
		
		/**
		 * This index into the muti array of the constant pool defines 
		 * the name of the variable that is to receive the exception object
		 * when the exception is thrown and control is transferred to target location. 
		 * If the value is zero then there is no name associated with the exception object.
		 */
		public function get varName():uint
		{
			return _varName;
		}

		/**
		 * @private
		 */
		public function set varName(value:uint):void
		{
			if(_varName != value)
			{
				try{
					$abcFile.getMultinameByIndex(_varName).removeReference(this, "varName");
				}catch(err:Error)
				{
					trace(err);
				}
				_varName = value;
				$abcFile.getMultinameByIndex(_varName).addReference(this, "varName");
			}
		}

		public function ExceptionInfo()
		{
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			//read from
			_from = SWFUtil.readU30(byte);
			//read to
			_to = SWFUtil.readU30(byte);
			//read target
			_target = SWFUtil.readU30(byte);
			//read excType
			_excType = SWFUtil.readU30(byte);
			//read varName
			_varName = SWFUtil.readU30(byte);
		}
		
		override public function encode():ByteArray
		{
			var byte:ByteArray = new ByteArray;
			byte.endian = Endian.LITTLE_ENDIAN;
			//write from
			SWFUtil.writeU30(byte, _from);
			//write to
			SWFUtil.writeU30(byte, _to);
			//write target
			SWFUtil.writeU30(byte, _target);
			//write excType
			SWFUtil.writeU30(byte, _excType);
			//write varName
			SWFUtil.writeU30(byte, _varName);
			return byte;
		}
		
		override public function toXML(name:String = null):SWFXML
		{
			if(!name) name = "exception";
			var xml:SWFXML = new SWFXML(name);
			xml.setAttribute("from", _from);
			xml.setAttribute("to", _to);
			xml.setAttribute("target", _target);
			xml.setAttribute("excType", "mn(" + _excType + ")");
			xml.setAttribute("varName", "mn(" + _varName + ")");
			return xml;
		}
		
		public function creatRefrenceRelationship():void
		{
			$abcFile.getMultinameByIndex(_excType).addReference(this, "excType");
			$abcFile.getMultinameByIndex(_varName).addReference(this, "varName");
		}
		
		public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			//empty
		}
		
		/**
		 * 根据插入的代码来调整from，to以及target的位置
		 * @param pcodesLength	pcode的字节长
		 * @param byteIndex		插入的pcode索引处的字节位置
		 * 
		 */
		public function modifyByInsertPcodes(pcodesLength:int, byteIndex:int):void
		{
			//如果插入在_from之前，那么_from和_to都需要调整
			if(byteIndex <= _from)
			{
				_from += pcodesLength;
				_to += pcodesLength;
			}
			
			//如果插入在_form和_to之间，就只需要调整_to
			if(_from < byteIndex && byteIndex <= _to)
			{
				_to += pcodesLength;
			}
			
			//如果插入在_target之前，则需要调整_target
			if(byteIndex <= _target)
			{
				_target += pcodesLength;
			}
		}
	}
}