package decompiler.tags.doabc.instruction
{
	import decompiler.utils.SWFUtil;
	import decompiler.utils.SWFXML;
	
	import flash.utils.ByteArray;

	/**
	 * Undocumented
	 * 这个未文档，但是确实用到了，应该是在avm2overview成书后加的，和GenericName类似，是处理vector的东西。
	 * 查阅发现：
	 * 这里的代码非常有用
	 * http://hg.mozilla.org/tamarin-central/file/072e85a58498/core/Interpreter.cpp
	 * INSTR(applytype) {

  2491 				SAVE_EXPC;
  2492 				i1 = (intptr_t)U30ARG;  // argc
  2493 				// stack in: factory, arg1, ... argN
  2494 				// stack out: result
	 * @author ukyohpq
	 * 
	 */
	public class Applytype extends UndocumentedInstruction
	{
		private var _arg_counts:int;

		public function get arg_counts():int
		{
			return _arg_counts;
		}

		public function set arg_counts(value:int):void
		{
			if(_arg_counts != value)
			{
				_arg_counts = value;
				modify();
			}
		}

		public function Applytype()
		{
			super();
		}
		
		override public function getForm():int
		{
			return 83;
		}
		
		override public function getName():String
		{
			return "applytype";
		}
		
		override public function deltaNumStack():int
		{
			return -_arg_counts;
		}
		
		override protected function paramsToXML(xml:SWFXML):void
		{
			xml.appendChild("<arg_counts>" + _arg_counts + "</arg_counts>");
			super.paramsToXML(xml);
		}
		
		override protected function pcodeDecodeFromBytes(byte:ByteArray):void
		{
			_arg_counts = SWFUtil.readU30(byte);
			super.pcodeDecodeFromBytes(byte);
		}
		
		override protected function stringBody():String
		{
			return "arg_counts:" + _arg_counts;
		}
		
		override protected function encodeBody(byte:ByteArray):void
		{
			SWFUtil.writeU30(byte, _arg_counts);
		}
		
	}
}