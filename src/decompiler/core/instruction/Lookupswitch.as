package decompiler.core.instruction
{
	import flash.utils.ByteArray;
	
	import decompiler.utils.SWFUtil;

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
		private var default_offset:int;
		private var case_offsets:Vector.<uint>;
		public function Lookupswitch()
		{
			super();
		}
		
		override public function decodeFromBytes(byte:ByteArray):void
		{
			default_offset = SWFUtil.readS24(byte);
			var case_count:int = SWFUtil.readU30(byte);
			case_offsets = new Vector.<uint>(case_offsets + 1);
			for (var i:int = 0; i < case_count + 1; ++i) 
			{
				case_offsets[i] = SWFUtil.readS24(byte);
			}
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			//这里有问题啊。。。
			SWFUtil.writeS24(byte, default_offset);
			SWFUtil.writeU30(byte, case_offsets.length - 1);//这里可能会是-1，感觉这里是有问题的
			var length:int = case_offsets.length;
			for (var i:int = 0; i < length; ++i) 
			{
				SWFUtil.writeS24(byte, case_offsets[i]);
			}
		}
		
		override public function getForms():int
		{
			return 27;
		}
		
		override public function getName():String
		{
			return "lookupswitch";
		}
		
		override protected function stringBody():String
		{
			var str:String = "default_offset:" + default_offset + "\ncase_offsets:";
			var length:int = case_offsets.length;
			for (var i:int = 0; i < length; ++i) 
			{
				str += "\n\t" + case_offsets[i];
			}
			
			return str;
		}
		
		
//		override public function toString():String
//		{
//			return "[lookupswitch]";
//		}
		
		
		
	}
}