package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Format
		lookupswitch
		default_offset
		case_count
		case_offsets...
	 * 	default_offset is an s24 that is the offset to jump, in bytes, for the default case. case_offsets are
		each an s24 that is the offset to jump for a particular index. There are case_count+1 case
		offsets. case_count is a u30.
		index is popped off of the stack and must be of type int. If index is less than zero or greater
		than case_count, the target is calculated by adding default_offset to the base location.
		Otherwise the target is calculated by adding the case_offset at position index to the base
		location. Execution continues from the target location.
		The base location is the address of the lookupswitch instruction itself.
	 * @author ukyohpq
	 * 
	 */
	public class Lookupswitch extends AbstractInstruction
	{
		private var _default_offset:int;

		public function get default_offset():int
		{
			return _default_offset;
		}

		public function set default_offset(value:int):void
		{
			modify();
			_default_offset = value;
		}

		private var _case_offsets:Vector.<int>;

		public function get case_offsets():Vector.<int>
		{
			return _case_offsets.slice();
		}

		public function set case_offsets(value:Vector.<int>):void
		{
			modify();
			_case_offsets = value;
		}

		public function addCaseOffset(offset:int):void
		{
			_case_offsets.push(offset);
		}
		
		public function Lookupswitch()
		{
			super();
			_case_offsets = new <int>[];
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			_default_offset = SWFUtil.readS24(byte);
			var case_count:int = SWFUtil.readU30(byte);
			_case_offsets.length = case_count + 1;
			for (var i:int = 0; i <= case_count; ++i) 
			{
				_case_offsets[i] = SWFUtil.readS24(byte);
			}
			super.decodeFromBytes(byte);
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			//这里有问题啊。。。
			SWFUtil.writeS24(byte, _default_offset);
			SWFUtil.writeU30(byte, _case_offsets.length - 1);//这里可能会是-1，感觉这里是有问题的
			var length:int = _case_offsets.length;
			for (var i:int = 0; i < length; ++i) 
			{
				SWFUtil.writeS24(byte, _case_offsets[i]);
			}
		}
		
		override public function getForm():int
		{
			return 27;
		}
		
		override public function getName():String
		{
			return "lookupswitch";
		}
		
		override protected function stringBody():String
		{
			var str:String = "default_offset:" + _default_offset + "\ncase_offsets:";
			var length:int = _case_offsets.length;
			for (var i:int = 0; i < length; ++i) 
			{
				str += "\n\t" + _case_offsets[i];
			}
			
			return str;
		}
		
		
//		override public function toString():String
//		{
//			return "[lookupswitch]";
//		}
		
		override public function getParams():Vector.<int>
		{
			var vec:Vector.<int> = new <int>[_default_offset];
			return vec.concat(_case_offsets);
		}
		
		override public function getParamNames():Vector.<String>
		{
			return new <String>["default_offset", "case_offsets"];;
		}
		
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<default_offset>" + _default_offset + "</default_offset>");
			var caseOffsets:SWFXML = new SWFXML("case_offsets");
			xml.appendChild(caseOffsets);
			var length:int = _case_offsets.length;
			for (var i:int = 0; i < length; ++i) 
			{
				caseOffsets.appendChild("<case_offset_"+ i + ">" + _case_offsets[i] + "</case_offset_" + i + ">");
			}
		}
		
		override public function deltaNumStack():int
		{
			return -1;
		}
	}
}