package decompiler.tags.doabc.instruction
{
	import decompiler.tags.doabc.ABCFile;
	import decompiler.tags.doabc.reference.Reference;
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		debugfile
		index
	 * index is a u30 that must be an index into the string constant pool 
	 * If the debugger is running, then this instruction sets 
	 * the current file name in the debugger to the string at 
	 * position index of the string constant pool. 
	 * This lets the debugger know which instructions are 
	 * associated with each source file. 
	 * The debugger will treat all instructions as 
	 * occurring in the same file until a new debugfile opcode is encountered. 
	 * This instruction must occur before any debugline opcodes.
	 * @author ukyohpq
	 * 
	 */
	public class Debugfile extends AbstractInstruction
	{
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

		public function Debugfile()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 241;
		}
		
		override public function getName():String
		{
			return "debugfile";
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_index = SWFUtil.readU30(byte);
			super.decodeFromBytes(byte);
		}
		
		override public function creatRefrenceRelationship():void
		{
			$abcFile.getStringByIndex(_index).addReference(this, "index");
		}
		
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _index);
		}
		
//		override public function toString():String
//		{
//			return "[ debugfile name:" + $abcFile.getStringByIndex(index) + " ]";
//		}
		
		override protected function stringBody():String
		{
			return "name:" + $abcFile.getStringByIndex(_index);
		}
		
		override public function getParams():Vector.<int>
		{
			return new <int>[_index];
		}
		
		override public function getParamNames():Vector.<String>
		{
			return new <String>["_index"];
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<index>" + _index + "</index>");
		}
		
		override public function setProperty(name:String, value:Object, refreshReference:Boolean=true):void
		{
			include "../reference/IReferenceable_Fragment_1.as";
		}
	}
}