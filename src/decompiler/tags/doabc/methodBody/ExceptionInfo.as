package decompiler.tags.doabc.methodBody
{
	import decompiler.core.IByteArrayReader;
	import decompiler.core.ISWFElement;
	import decompiler.tags.doabc.ABCFileElement;
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
	public class ExceptionInfo extends ReferencedElement
	{
		/**
		 * The starting position in the code field from which the exception is enabled
		 */
		private var _from:uint;
		
		
		/**
		 * The ending position in the code field after which the exception is disabled
		 */
		private var _to:uint;
		/**
		 * The position in the code field to which control should jump 
		 * if an exception of type exc_type is encountered while executing 
		 * instructions that lie within the region [from, to] of the code field.
		 */
		private var _target:uint;
		/**
		 * An index into the muti array of the constant pool that 
		 * identifies the name of the type of exception that is 
		 * to be monitored during the reign of this handler. 
		 * A value of zero means the any type (“*”) and implies 
		 * that this exception handler will catch any type of exception thrown.
		 */
		private var _excType:uint;
		/**
		 * This index into the muti array of the constant pool defines 
		 * the name of the variable that is to receive the exception object
		 * when the exception is thrown and control is transferred to target location. 
		 * If the value is zero then there is no name associated with the exception object.
		 */
		private var _varName:uint;
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
	}
}