package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.reference.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		debug
		debug_type
		index
		reg
		extra
	 * 
	 * debug_type is an unsigned byte. 
	 * If the value of debug_type is DI_LOCAL (1), 
	 * then this is debugging information for a local register. 
	 * 
	 * index is a u30 that must be an index into the string constant pool. 
	 * The string at index is the name to use for this register. 
	 * 
	 * reg is an unsigned byte and is the index of the register 
	 * that this is debugging information for. 
	 * 
	 * extra is a u30 that is currently unused. 
	 * 
	 * Adobe ActionScript Virtual Machine 2 (AVM2) Overview 53 
	 * When debug_type has a value of 1, 
	 * this tells the debugger the name to display 
	 * for the register specified by reg. 
	 * If the debugger is not running, then this instruction does nothing.
	 * @author ukyohpq
	 * 
	 */
	public class Debug extends AbstractInstruction
	{
		private var _debug_type:uint;

		public function get debug_type():uint
		{
			return _debug_type;
		}

		public function set debug_type(value:uint):void
		{
			modify();
			_debug_type = value;
		}

		private var _index:uint;

		public function get index():uint
		{
			return _index;
		}

		public function set index(value:uint):void
		{
			modify();
			try{
				$abcFile.getStringByIndex(_index).removeReference(this, "index");
			}catch(err:Error)
			{
				trace(err);
			}
			_index = value;
			$abcFile.getStringByIndex(_index).addReference(this, "index");
		}

		private var _reg:uint;

		public function get reg():uint
		{
			return _reg;
		}

		public function set reg(value:uint):void
		{
			modify();
			_reg = value;
		}

		private var _extra:uint;

		public function get extra():uint
		{
			return _extra;
		}

		public function set extra(value:uint):void
		{
			modify();
			_extra = value;
		}

		public function Debug()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 239;
		}
		
		override public function getName():String
		{
			return "debug";
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_debug_type = byte.readUnsignedByte();
			_index = SWFUtil.readU30(byte);
			_reg = byte.readUnsignedByte();
			_extra = SWFUtil.readU30(byte);
			super.decodeFromBytes(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			byte.writeByte(_debug_type);
			SWFUtil.writeU30(byte, _index);
			byte.writeByte(_reg);
			SWFUtil.writeU30(byte, _extra);
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getStringByIndex(_index).addReference(this, "index");
		}
		
		
//		override public function toString():String
//		{
//			return "[ debug debug_type:" +
//				debug_type + 
//				" name:" + $abcFile.getStringByIndex(index) +
//				" reg:" + reg +
//				" extra:" + extra + 
//				" ]";
//		}
		
		override protected function stringBody():String
		{
			return "debug_type:" +
			_debug_type + 
			" name:" + $abcFile.getStringByIndex(_index) +
			" reg:" + _reg +
			" extra:" + _extra;
		}
		
		override public function getParams():Vector.<int>
		{
			return new <int>[_debug_type, _index, _reg, _extra];
		}
		
		override public function getParamNames():Vector.<String>
		{
			return new <String>["_debug_type, _index, _reg, _extra"];
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<debug_type>" + _debug_type + "</debug_type>");
			xml.appendChild("<index>" + _index + "</index>");
			xml.appendChild("<reg>" + _reg + "</reg>");
			xml.appendChild("<extra>" + _extra + "</extra>");
		}
		
		override public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			include "../reference/IReferenceable_Fragment_1.as";
		}
	}
}